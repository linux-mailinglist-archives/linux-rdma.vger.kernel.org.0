Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B99F14588A
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2020 16:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgAVPXI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jan 2020 10:23:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53721 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgAVPXI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Jan 2020 10:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579706586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sZ4zsbmWkdK6dd5A3RLmubQmcTn2MHf1I/StnPqdzIw=;
        b=BCr6UZNGdW72RmUbXpBAwvTPibqiXRUaYlBD953MsHFu6THOSvraaW1zikQYhM+VAWjsCz
        odeblDPS1qZNy5uZY2YwNuROVhzcCSyxFz7xzOofVFOLEMryzsp8rZJ9K1dlSbvt9hwqqe
        1NLJF/j8FQVqOPasWRXxjCeUe9yxW3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-GNtEcAXWMI6h8TZThKpAgQ-1; Wed, 22 Jan 2020 10:23:03 -0500
X-MC-Unique: GNtEcAXWMI6h8TZThKpAgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B0B18017CC;
        Wed, 22 Jan 2020 15:23:02 +0000 (UTC)
Received: from localhost (unknown [10.66.128.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B9528CCCB;
        Wed, 22 Jan 2020 15:23:01 +0000 (UTC)
Date:   Wed, 22 Jan 2020 23:22:58 +0800
From:   Honggang LI <honli@redhat.com>
To:     "Hefty, Sean" <sean.hefty@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: resource leak in librdmacm
Message-ID: <20200122152258.GA142196@dhcp-128-72.nay.redhat.com>
References: <20200121122133.GA105701@dhcp-128-72.nay.redhat.com>
 <BYAPR11MB3272F4913688AE9B3BFF815C9E0D0@BYAPR11MB3272.namprd11.prod.outlook.com>
 <20200122085655.GA126224@dhcp-128-72.nay.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20200122085655.GA126224@dhcp-128-72.nay.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 22, 2020 at 04:56:59PM +0800, Honggang LI wrote:
> > > 
> > > 	rdma_destroy_event_channel(ch);
> > 
> > This call should fail, since there's still a valid id open on it.
> 
> Yes, you are right. After switch rdma_destroy_event_channel and
> rdma_destroy_id, the memory leak issue is gone.
> 
> But we still observe file descriptor leak.

I managed to reproduce the file descriptor leak without dapl. That means
it is a librdmacm issue.

Please see attachment 'rdmacm-fd-leak.txt' for details.

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rdmacm-fd-leak.txt"

I managed to reproduce this without dapl. That means the resource leak is a librdamcm issue.


[root@rdma-dev-00 cm2]$ sh build.sh 
+ rm -f libofa.so libofa.o
+ gcc -fPIC -g -c -o libofa.o libofa.c
+ gcc -shared -fPIC -g -Wl,-init,test_init -Wl,-fini,test_fini -lrdmacm -o libofa.so libofa.o
+ gcc -ldl -g -o test.exe test.c
+ ip addr show mlx4_ib0
+ grep -w inet
    inet 172.31.0.230/24 brd 172.31.0.255 scope global dynamic noprefixroute mlx4_ib0
+ ./test.exe 172.31.0.230
dlopen librdamcm.so done
dlopen librdamcm.so done
dlopen librdamcm.so done
dlopen librdamcm.so done
=== ls -l /proc/20221/fd
total 0
lrwx------. 1 root root 64 Jan 22 10:10 0 -> /dev/pts/1
lrwx------. 1 root root 64 Jan 22 10:10 1 -> /dev/pts/1
lrwx------. 1 root root 64 Jan 22 10:10 10 -> /dev/infiniband/uverbs0      <--- leak
lr-x------. 1 root root 64 Jan 22 10:10 11 -> 'anon_inode:[infinibandevent]'
lrwx------. 1 root root 64 Jan 22 10:10 2 -> /dev/pts/1
lrwx------. 1 root root 64 Jan 22 10:10 4 -> /dev/infiniband/uverbs0       <--  leak
lr-x------. 1 root root 64 Jan 22 10:10 5 -> 'anon_inode:[infinibandevent]'
lrwx------. 1 root root 64 Jan 22 10:10 6 -> /dev/infiniband/uverbs0       <-- leak
lr-x------. 1 root root 64 Jan 22 10:10 7 -> 'anon_inode:[infinibandevent]'
lrwx------. 1 root root 64 Jan 22 10:10 8 -> /dev/infiniband/uverbs0       <-- leak
lr-x------. 1 root root 64 Jan 22 10:10 9 -> 'anon_inode:[infinibandevent]'
[root@rdma-dev-00 cm2]$ 


[root@rdma-dev-00 cm2]$ cat build.sh 
#/bin/bash
set -x

rm -f libofa.so libofa.o
gcc -fPIC -g -c -o libofa.o libofa.c
gcc -shared -fPIC -g -Wl,-init,test_init -Wl,-fini,test_fini -lrdmacm -o libofa.so libofa.o

gcc -ldl -g -o test.exe test.c

ip addr show mlx4_ib0 | grep -w inet

#LD_DEBUG=libs ./test.exe 172.31.0.230
./test.exe 172.31.0.230


[root@rdma-dev-00 cm2]$ cat libofa.c
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <arpa/inet.h>
#include <rdma/rdma_cma.h>
#include <limits.h>

#include <sys/types.h>
#include <unistd.h>

static void *handle;
void test_init(void)
{

	handle = dlopen("/usr/lib64/librdmacm.so", RTLD_NOW | RTLD_GLOBAL);
	if (!handle)
		printf("dlopen /usr/lib64/librdmacm.so failed\n");
	else
		printf("dlopen librdamcm.so done\n");
}

void test_fini(void)
{
	if (handle)
		dlclose(handle);
	handle = NULL;
}

void test(char *ipoib_ip)
{
#if 1
	int ret;
	struct rdma_cm_id *id;
	struct sockaddr_in ipoib_addr;
	struct rdma_event_channel *ch;
	void *handle;

	memset(&ipoib_addr, 0, sizeof(ipoib_addr));

	ipoib_addr.sin_family = AF_INET;
	ipoib_addr.sin_port = 5555;

#if 1
	ret = inet_pton(AF_INET, ipoib_ip, (void *)&(ipoib_addr.sin_addr));

	if (ret != 1)
		printf("inet_pton failed\n");
#else	
	ipoib_addr.sin_addr.s_addr=htonl(INADDR_ANY);
#endif	

	ch = rdma_create_event_channel();
	if (ch == NULL)
		printf("rdma_create_event_channel failed\n");

	ret = rdma_create_id(ch, &id, NULL, RDMA_PS_TCP);
	if (ret != 0)
		printf("rdma_create_id failed\n");

	ret = rdma_bind_addr(id, (struct sockaddr *) &ipoib_addr);

	if (ret != 0)
		printf("rdma_bind_addr failed\n");

#if DEBUG
	printf("befora call rdma_destroy_id\n");
	getchar();
#endif

	ret = rdma_destroy_id(id);
	if (ret != 0)
		printf("rdma_destroy_id failed\n");

#if DEBUG
	printf("before call rdma_destroy_event_channel\n");
	getchar();
#endif

	rdma_destroy_event_channel(ch);
#if DEBUG
	printf("after call rdma_destroy_event_channle\n");
	getchar();
#endif

#else
	printf("xxx %s:%s\n", __FILE__, __func__);
#endif	
}


[root@rdma-dev-00 cm2]$ cat test.c
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>

typedef void (* DUMMY_TEST_FUNC) (char *);

int main(int argc, char **argv)
{
	DUMMY_TEST_FUNC sym;
	void *handle;
	int i;
	pid_t cpid, ppid;
	int wstatus;
	char path[128];

	if (argc != 2) {
		printf("usage: %s IPoIB_IP_ADDR\n", argv[0]);
		return 1;
	}
	
	for (i = 0; i < 4; i++) {
		handle = dlopen("./libofa.so", RTLD_NOW | RTLD_GLOBAL);
		sym = dlsym(handle, "test");
		sym(argv[1]);
		dlclose(handle);
	}

	cpid = fork();

	if (cpid == 0) { /* child */
		ppid = getppid();
		memset(path, 0, 128);
		sprintf(path, "/proc/%d/fd", ppid);
		printf("=== ls -l %s\n", path);
		execl("/usr/bin/ls", "/usr/bin/ls", "-l", path, (char *)NULL);
	} else {
		waitpid(cpid, &wstatus, 0);
	}
	return 0;
}

--envbJBWh7q8WU6mo--

