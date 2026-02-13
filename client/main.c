#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/types.h>
#include <unistd.h>
#include <jni.h>
#include <string.h>

#ifndef _WIN32
#include <sys/time.h>
#else
#include "mywin32.h"
#endif

#include "client.h"
#include "options.h"
#include "socket.h"
#include "auth.h"
#include "myerror.h"
#include "dns.h"

int debug = 0;

// تغيير اسم main الأصلية إلى dns_main
int dns_main(int argc, char **argv)
{
  t_conf conf;
  
  if ((get_option(argc, argv, &conf)) ||  
      ((conf.sd_udp = create_socket(&conf)) == -1))
    return (-1);

  srand(getpid() ^ (unsigned int) time(0));

  if (!conf.resource)
    return (list_resources(&conf));
    
  if ((!conf.local_port) || (!bind_socket(&conf)))
    do_client(&conf);
    
  return (0);
}

// دالة main الأصلية للـ Binary المستقل
#ifndef JNI_BUILD
int main(int argc, char **argv) {
    return dns_main(argc, argv);
}
#endif

// واجهة JNI لاستدعاء المكتبة من Android (AIDE)
JNIEXPORT jint JNICALL
Java_com_slowdns_testing_ui_activity_Dns2TcpController_runDns2Tcp(JNIEnv *env, jobject thiz, jobjectArray args) {
    
    int argc = (*env)->GetArrayLength(env, args);
    char **argv = (char **)malloc(argc * sizeof(char *));
    int i;

    for (i = 0; i < argc; i++) {
        jstring str = (jstring)(*env)->GetObjectArrayElement(env, args, i);
        const char *nativeString = (*env)->GetStringUTFChars(env, str, 0);
        if (nativeString) {
            argv[i] = strdup(nativeString);
            (*env)->ReleaseStringUTFChars(env, str, nativeString);
        } else {
            argv[i] = NULL;
        }
    }

    int result = dns_main(argc, argv);

    for (i = 0; i < argc; i++) {
        if (argv[i]) free(argv[i]);
    }
    free(argv);

    return (jint)result;
}
