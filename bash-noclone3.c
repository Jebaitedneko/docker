#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

char *envp[] = {"HOME=/",
                "PATH=/usr/gcc64/bin:/usr/gcc32/bin:/usr/clang/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "TZ=UTC0",
                "USER=root",
                "LOGNAME=log",
                0};

static int execprog(char **argv) {
  pid_t my_pid;
  int status, timeout;

  if (0 == (my_pid = fork()))
    if (-1 == execve(argv[0], (char **)argv, envp)) {
      perror("child process execve failed");
      return -1;
    }

  timeout = 1000;
  while (0 == waitpid(my_pid, &status, WNOHANG)) {
    if (--timeout < 0) {
      perror("timeout");
      return -1;
    }
    sleep(1);
  }
  /*
    printf("%s WEXITSTATUS %d WIFEXITED %d [status %d]\n", argv[0],
           WEXITSTATUS(status), WIFEXITED(status), status);
  */
  if (1 != WIFEXITED(status) || 0 != WEXITSTATUS(status)) {
    perror("process failed, halt system");
    return -1;
  }

  return 0;
}

int main(int argc, char *argv[]) {
  char *arg[512 * 1024] = {""};
  arg[0] = "/noclone3";
  arg[1] = "/bin/bash";
  for(int i=2; i<argc+2; i++)
    arg[i] = argv[i-1];
  return execprog(arg);
}