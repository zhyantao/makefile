#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#define MAX_BUFFER_SIZE 1024

void handle_error(const char* msg) {
    perror(msg);
    exit(EXIT_FAILURE);
}

int main(int argc, char* argv[]) {
    int serverfd, clientfd, portno, n;
    socklen_t clilen;
    char buffer[MAX_BUFFER_SIZE];
    struct sockaddr_in serveraddr, clientaddr;
    fd_set readfds;

    if (argc < 2) {
        fprintf(stderr, "ERROR, no port provided\n");
        exit(1);
    }

    serverfd = socket(AF_INET, SOCK_STREAM, 0);
    if (serverfd < 0)
        handle_error("ERROR opening socket");

    bzero((char*)&serveraddr, sizeof(serveraddr));
    portno = atoi(argv[1]);
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_addr.s_addr = INADDR_ANY;
    serveraddr.sin_port = htons(portno);

    if (bind(serverfd, (struct sockaddr*)&serveraddr, sizeof(serveraddr)) < 0)
        handle_error("ERROR on binding");

    listen(serverfd, 5);
    clilen = sizeof(clientaddr);

    FD_ZERO(&readfds);
    FD_SET(serverfd, &readfds);

    while (1) {
        fd_set tempfds = readfds;
        int retval = pselect(FD_SETSIZE, &tempfds, NULL, NULL, NULL, NULL);
        if (retval < 0)
            handle_error("ERROR in pselect");

        for (int i = 0; i < FD_SETSIZE; i++) {
            if (FD_ISSET(i, &tempfds)) {
                if (i == serverfd) {
                    clientfd = accept(serverfd, (struct sockaddr*)&clientaddr, &clilen);
                    if (clientfd < 0)
                        handle_error("ERROR on accept");
                    FD_SET(clientfd, &readfds);
                } else {
                    bzero(buffer, MAX_BUFFER_SIZE);
                    n = read(i, buffer, MAX_BUFFER_SIZE - 1);
                    if (n < 0)
                        handle_error("ERROR reading from socket");
                    else if (n == 0) {
                        close(i);
                        FD_CLR(i, &readfds);
                    } else {
                        printf("Received message from client: %s", buffer);
                        n = write(i, "Got response from server", 25);
                        if (n < 0)
                            handle_error("ERROR writing to socket");
                    }
                }
            }
        }
    }

    return 0;
}
