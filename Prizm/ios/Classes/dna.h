#ifndef _dna_h__
#define _dna_h__

#include "util.h"
#include "table.h"
#include "fft.h"
#include "mel.h"

typedef struct AudioDNA {
    typedef struct __f128 {
		__int64 f[2];
	} __f128;

    __int64* F;
	__f128* E;
	int N;

	AudioDNA() { memset(this, 0, sizeof(AudioDNA)); }

	void free() {
		_Delete(E);
        _Delete(F);
	}
	int write(char* buf) {
		char* p=buf;
		*p=fpVer; p++;
		memcpy(p, &N, 4); p+=4;
        memcpy(p, F, N*8); p+=N*8;
        memcpy(p, E, N*8*2); p+=N*8*2;
		return (int)(p-buf);
	}
	int extract(short* wav, int len) {
		static MEL<fftN/2, srate/2, fDim> mel;
        static MEL<fftN, srate, fDim*2> mel2;

        N= (len-fftN)/fftHop;
        F= new __int64[N];
        E= new __f128[N];

        for (int i=0, p=0; i<N; i++, p+=fftHop) {
            float f0[fftN];
            for (int y=0; y<fftN; y++)
                f0[y]= wav[p+y];
            FFT<fftN>::hanning(f0);
            FFT<fftN> fft;
            double f1[fftN];
            fft.transform(f0, f1);

            double f2[fDim*2];
            mel.conv(f1, f2);
            float f3[fDim*2];
            for (int y=0; y<fDim; y++)
                f3[y] = (float)(10.f*log10(f2[y]+1));
            to_f(f3, F[i]);

            mel2.conv(f1, f2);
            for (int y=0; y<fDim*2; y++)
                f3[y] = (float)(10.f*log10(f2[y]+1));
            to_e(f3, E[i]);
        }
        return 1+4+ N*8+ N*8*2;
	}
private:
    static void to_f(float f[fDim], __int64& w) {
        w=0;
        for (int y=0; y<fDim-1; y++) {
            w <<= 1;
            float d= f[y] - f[y+1];
            w |= d>0 ? 1 : 0;
        }
    }
    static void to_e(float f[fDim*2], __f128& w) {
        __int64 w0=0, w1=0, w2=0, w3=0;
        int y=0;
        for (; y<fDim; y++) {
            w0 <<= 1;
            float d= f[y] - f[y+1];
            w0 |= d>0 ? 1 : 0;
        }
        for (; y<fDim*2-1; y++) {
            w1 <<= 1;
            float d= f[y] - f[y+1];
            w1 |= d>0 ? 1 : 0;
        }
        w.f[0]= w0, w.f[1]=w1;
    }
} AudioDNA;

#endif // _dna_h__
