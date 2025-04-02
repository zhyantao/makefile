#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#define MAX_BUFFER_SIZE 1024

void handle_error(const char* msg) {
    perror(msg);
    exit(EXIT_FAILURE);
}

int main(int argc, char* argv[]) {
    int sockfd, portno, n;
    struct sockaddr_in serv_addr;
    char buffer[MAX_BUFFER_SIZE];

    if (argc < 3) {
        fprintf(stderr, "usage %s hostname port\n", argv[0]);
        exit(0);
    }

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0)
        handle_error("ERROR opening socket");

    bzero((char*)&serv_addr, sizeof(serv_addr));
    portno = atoi(argv[2]);
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = inet_addr(argv[1]);
    serv_addr.sin_port = htons(portno);

    if (connect(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0)
        handle_error("ERROR connecting");

    while (1) {
        printf("Please enter the message: ");
        bzero(buffer, MAX_BUFFER_SIZE);
        fgets(buffer, MAX_BUFFER_SIZE - 1, stdin);
        n = write(sockfd, buffer, strlen(buffer));
        if (n < 0)
            handle_error("ERROR writing to socket");

        bzero(buffer, MAX_BUFFER_SIZE);
        n = read(sockfd, buffer, MAX_BUFFER_SIZE - 1);
        if (n < 0)
            handle_error("ERROR reading from socket");
        printf("%s\n", buffer);
    }

    close(sockfd);
    return 0;
}
