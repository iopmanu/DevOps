#include <stdlib.h>
#include "fcgi_stdio.h"

int main() {
    int count = 0;
    while (FCGI_Accept() >= 0)
        printf("Content-type: text/html\r\n"
               "\r\n"
               "<title>FastCGI Hello World!</title>"
               "<h1>FastCGI Hello World!</h1>"
               "Request number %d running on host <i>%s</i>\n",
                ++count, "nginx");
    return 0;
}
