#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#define BMP_HEADER_SIZE 54

typedef unsigned char byte;

FILE *fp_in;
FILE *fp_out;
byte *image=NULL;
unsigned int rgb_raw_data_offset; // RGB raw data offset
unsigned int width;
unsigned int height;
unsigned int R,G,B;

int sobel(int y,int x,int off)
{
    int mask[9]= {-1,0,1,-2,0,2,-1,0,1};
    int points[9]=
    {
        (unsigned int) *(image+3*(width*(y-1)+(x-1))+off),
        (unsigned int) *(image+3*(width*(y-1)+(x))+off),
        (unsigned int) *(image+3*(width*(y-1)+(x+1))+off),
        (unsigned int) *(image+3*(width*(y)+(x-1))+off),
        (unsigned int) *(image+3*(width*(y)+(x))+off),
        (unsigned int) *(image+3*(width*(y)+(x+1))+off),
        (unsigned int) *(image+3*(width*(y+1)+(x-1))+off),
        (unsigned int) *(image+3*(width*(y+1)+(x))+off),
        (unsigned int) *(image+3*(width*(y+1)+(x+1))+off)
    };
    int result = 0;
    for(int i=0; i<9; i++)
    {
        result+=(mask[i]*points[i]);
    }
    return abs(result);
}

void read_header(const char *file_in,const char *file_out)
{
    fp_in = fopen(file_in,"rb");
    if(fp_in == NULL)
    {
        printf("open bmp failed\n");
        exit(EXIT_FAILURE);
    }
    fseek(fp_in,10,SEEK_SET);
    fread(&rgb_raw_data_offset,sizeof(unsigned int),1,fp_in);
    //printf("rgb_raw_data_offset:%x\n",rgb_raw_data_offset);
    fseek(fp_in,18,SEEK_SET);
    fread(&width,sizeof(unsigned int),1,fp_in);
    fread(&height,sizeof(unsigned int),1,fp_in);
    //printf("W:%d\nH:%d",width,height);

    fclose(fp_in);
}

void copy_header(const char *file_in,const char *file_out)
{
    fp_in = fopen(file_in,"rb");
    if(fp_in == NULL)
    {
        printf("open bmp failed\n");
        exit(EXIT_FAILURE);
    }
    fp_out = fopen(file_out,"wb");
    if(fp_out == NULL)
    {
        printf("create bmp file failed\n");
        exit(EXIT_FAILURE);
    }
    byte header[BMP_HEADER_SIZE];

    fread(header,sizeof(byte),BMP_HEADER_SIZE,fp_in);
    fwrite(header,sizeof(byte),BMP_HEADER_SIZE,fp_out);

    fclose(fp_in);
    fclose(fp_out);
}

void read_raw(const char *file_in,const char *file_out)
{
    fp_in = fopen(file_in,"rb");
    if(fp_in == NULL)
    {
        printf("open bmp failed\n");
        exit(EXIT_FAILURE);
    }
    fp_out = fopen(file_out,"ab");
    if(fp_out == NULL)
    {
        printf("open bmp file failed\n");
        exit(EXIT_FAILURE);
    }
    fseek(fp_in,BMP_HEADER_SIZE,SEEK_SET);
    fseek(fp_out,BMP_HEADER_SIZE,SEEK_SET);
    image = (byte*)malloc((size_t)width*height*3);
    fread(image,sizeof(byte),(size_t)width*height*3,fp_in);

    for(int y=0; y != height; y++)
    {
        for(int x=0; x != width; x++)
        {
            B = (int) *(image+3*(width*y+x)+0);
            G = (int) *(image+3*(width*y+x)+1);
            R = (int) *(image+3*(width*y+x)+2);
            if ( ( x >= 1 && x <= width - 1 ) && ( y >= 1 && y <= height - 1 ) )
            {
                //printf("B:%d\n",sobel(y,x,0));
                //printf("G:%d\n",sobel(y,x,1));
                //printf("R:%d\n",sobel(y,x,2));
                fprintf( fp_out, "%c%c%c",
                        (unsigned char)((sobel(y,x,0)>64)?255:0),
                        (unsigned char)((sobel(y,x,1)>64)?255:0),
                        (unsigned char)((sobel(y,x,2)>64)?255:0)
                        );
            }
            else
            {
                fprintf( fp_out, "%c%c%c", ( unsigned char )B, ( unsigned char )G, ( unsigned char )R );
            }
        }
    }

    free(image);
    fclose(fp_in);
    fclose(fp_out);
}

int main( int argc, char *argv[] )
{
    if(argc<3)
    {
        printf("Usage [exe] [input] [output]");
        exit(EXIT_FAILURE);
    }
    read_header(argv[1],argv[2]);
    copy_header(argv[1],argv[2]);
    read_raw(argv[1],argv[2]);
}
