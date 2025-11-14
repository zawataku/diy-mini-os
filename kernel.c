// C言語の標準ライブラリ <stdint.h> や <stddef.h> がない環境（ベアメタル）のため、必要な型を自分で定義

typedef unsigned char uint8_t; // 8ビット(1バイト)の符号なし整数
typedef unsigned int uint32_t; // 32ビットの符号なし整数 (RISC-V 32bit環境を想定)
typedef uint32_t size_t;       // メモリのサイズや配列の要素数を表す型 (ここでは32ビット)

extern char __bss[], __bss_end[], __stack_top[]; // リンカスクリプトによって定義される「シンボル」をC言語側で参照するための宣言

/**
 * @brief メモリの指定領域を特定の値で埋める
 * @param buf 書き込み先のメモリアドレス
 * @param c 書き込む値
 * @param n 書き込むバイト数
 * @note 標準Cライブラリの memset と同じ機能
 * OS起動直後は標準ライブラリを使えないため、自作する必要がある
 */
void *memset(void *buf, char c, size_t n)
{
    uint8_t *p = (uint8_t *)buf; // void* 型は直接操作できないため、1バイト単位で操作できる uint8_t* (char*) にキャスト
    while (n--)                  // n バイト分ループ
        *p++ = c;                // 1バイト書き込み、ポインタを次のメモリアドレスに進める
    return buf;                  // 標準のmemsetの仕様にならい、書き込み先の先頭アドレスを返す
}

/**
 * @brief C言語で記述されたカーネル本体のメイン関数
 */
void kernel_main(void)
{
    memset(__bss, 0, (size_t)__bss_end - (size_t)__bss);
    for (;;)
        ;
}

__attribute__((section(".text.boot")))
__attribute__((naked))

void
boot(void)
{
    __asm__ __volatile__(
        "mv sp, %[stack_top]\n"
        "j kernel_main\n"
        :
        : [stack_top] "r"(__stack_top));
}