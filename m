Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE9B144E12
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2020 09:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgAVI5V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jan 2020 03:57:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23070 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725862AbgAVI5V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jan 2020 03:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579683437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a88lXB35Ugo6pnVzka6JxYCK5Epvy9YsmzfDog3f5Pg=;
        b=FR86dfsdcFn8KW50ulwRKYosPzIBQ5Vl8id3weMvoCZAWh8ZlpUVQgb4eE6amDjXAVPG+b
        Vqm0JW3FrmI9osjj6DQLjGfqQCmltzwprNmbq8QyiEsi1coFGoIZAcK9KgRQ+nbCikJHb5
        rsFR0CG98vPUwmU4EElHVKjU+zwYnjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-QGKOQ0kkOJiSawIH9f7Nhw-1; Wed, 22 Jan 2020 03:57:00 -0500
X-MC-Unique: QGKOQ0kkOJiSawIH9f7Nhw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D3C8107ACC4;
        Wed, 22 Jan 2020 08:56:59 +0000 (UTC)
Received: from localhost (unknown [10.66.128.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E3BB5C1BB;
        Wed, 22 Jan 2020 08:56:57 +0000 (UTC)
Date:   Wed, 22 Jan 2020 16:56:55 +0800
From:   Honggang LI <honli@redhat.com>
To:     "Hefty, Sean" <sean.hefty@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: resource leak in librdmacm
Message-ID: <20200122085655.GA126224@dhcp-128-72.nay.redhat.com>
References: <20200121122133.GA105701@dhcp-128-72.nay.redhat.com>
 <BYAPR11MB3272F4913688AE9B3BFF815C9E0D0@BYAPR11MB3272.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3272F4913688AE9B3BFF815C9E0D0@BYAPR11MB3272.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2020 at 03:57:53PM +0000, Hefty, Sean wrote:
> > 	ch = rdma_create_event_channel();
> > 	if (ch == NULL)
> > 		printf("rdma_create_event_channel failed\n");
> > 
> > 	ret = rdma_create_id(ch, &id, NULL, RDMA_PS_TCP);
> > 	if (ret != 0)
> > 		printf("rdma_create_id failed\n");
> > 
> > 	ret = rdma_bind_addr(id, (struct sockaddr *) &ipoib_addr);
> > 
> > 	if (ret != 0)
> > 		printf("rdma_bind_addr failed\n");
> > 
> > 	rdma_destroy_event_channel(ch);
> 
> This call should fail, since there's still a valid id open on it.

Yes, you are right. After switch rdma_destroy_event_channel and
rdma_destroy_id, the memory leak issue is gone.

But we still observe file descriptor leak.

 cm]$ ip addr show | grep -w inet  | grep mlx4_ib0$
    inet 172.31.0.230/24 brd 172.31.0.255 scope global dynamic noprefixroute mlx4_ib0

 cm]$ ./fd.exe 172.31.0.230
pid = 30530
dlopen/dlclose test: round 0    

cm]$ valgrind -v --trace-children=yes --track-fds=yes --log-fd=2 --error-limit=no --leak-check=full --show-possibly-lost=yes --track-origins=yes --show-reachable=yes --keep-debuginfo=yes ./fd.exe 172.31.0.230 2>&1 | tee trace.log
<== ignore many lines, please see attachment trace.log for details ==>
==30545== FILE DESCRIPTORS: 4 open at exit.
==30545== Open file descriptor 4: /dev/infiniband/uverbs0
==30545==    at 0x53487D2: open (in /usr/lib64/libc-2.28.so)
==30545==    by 0x5632EF8: UnknownInlinedFun (fcntl2.h:53)
==30545==    by 0x5632EF8: open_cdev_internal (open_cdev.c:52)
==30545==    by 0x56331C3: open_cdev (open_cdev.c:141)
==30545==    by 0x562C7F3: verbs_open_device (device.c:345)
==30545==    by 0x50482D1: ucma_open_device (cma.c:325)
==30545==    by 0x50482D1: ucma_init_device.part.2 (cma.c:343)
==30545==    by 0x504855F: ucma_init_device (cma.c:474)
==30545==    by 0x504855F: ucma_get_device (cma.c:469)
==30545==    by 0x50487A9: ucma_query_addr (cma.c:714)
==30545==    by 0x5048883: rdma_bind_addr2 (cma.c:884)
==30545==    by 0x5048F34: rdma_bind_addr (cma.c:901)
==30545==    by 0x400A59: test (fd.c:40)
==30545==    by 0x400B7D: main (fd.c:94)


In this simple program, only one file descriptor leaked. We can trigger
a lot of instance file descriptordescriptor leak with dapl. Please see attachment dapl-librdmacm-leak.txt for details.

Thanks


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dapl-librdmacm-leak.txt"

[root@rdma-dev-19 test]$ ibstat
CA 'mlx5_2'
	CA type: MT4115
	Number of ports: 1
	Firmware version: 12.23.1020
	Hardware version: 0
	Node GUID: 0x248a07030049d338
	System image GUID: 0x248a07030049d338
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 100
		Base lid: 13
		LMC: 0
		SM lid: 1
		Capability mask: 0x2659e848
		Port GUID: 0x248a07030049d338
		Link layer: InfiniBand
CA 'mlx5_3'
	CA type: MT4115
	Number of ports: 1
	Firmware version: 12.23.1020
	Hardware version: 0
	Node GUID: 0x248a07030049d339
	System image GUID: 0x248a07030049d338
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 40
		Base lid: 38
		LMC: 1
		SM lid: 36
		Capability mask: 0x2659e848
		Port GUID: 0x248a07030049d339
		Link layer: InfiniBand
CA 'mlx5_bond_0'
	CA type: MT4117
	Number of ports: 1
	Firmware version: 14.23.1020
	Hardware version: 0
	Node GUID: 0x7cfe900300cb743a
	System image GUID: 0x7cfe900300cb743a
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 10
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x00010000
		Port GUID: 0x7efe90fffecb743a
		Link layer: Ethernet


[root@rdma-dev-19 test]$ cat test.sh
#!/bin/bash
set -x

export DAT_OVERRIDE=/root/test/dat.conf

cat > ${DAT_OVERRIDE} << 'EOF'
OpenIB-cma u2.0 nonthreadsafe default libdaplcma.so.1 dapl.2.0 "mlx5_bond_roce 0" ""
ofa-v2-cma-roe-mlx5_bond_roce u2.0 nonthreadsafe default libdaplofa.so.2 dapl.2.0 "mlx5_bond_roce 0" ""
ofa-v2-cma-roe-mlx5_ib0 u2.0 nonthreadsafe default libdaplofa.so.2 dapl.2.0 "mlx5_ib0 0" ""
EOF

cat ${DAT_OVERRIDE}

cat test.c

rm -f test.exe

if [ ! -e test.exe ]; then
	gcc -ldat2 -Wall -Werror -g -o test.exe test.c
fi

if [ "x$2" = "xdebug" ]; then
	export DAPL_DBG_DEST=0x0001
	export DAPL_DBG_TYPE=0xffffffff
	export DAPL_DBG_LEVEL=0xffff

	export DAT_DBG_TYPE_ENV=0xffff
	export DAT_DBG_TYPE=0xff
	export DAT_DBG_DEST=0x1
fi

ulimit -n 50
./test.exe ofa-v2-cma-roe-mlx5_bond_roce 8
./test.exe ofa-v2-cma-roe-mlx5_ib0 8

[root@rdma-dev-19 test]$ 


[root@rdma-dev-19 test]$ sh test.sh 
+ export DAT_OVERRIDE=/root/test/dat.conf
+ DAT_OVERRIDE=/root/test/dat.conf
+ cat
+ cat /root/test/dat.conf
OpenIB-cma u2.0 nonthreadsafe default libdaplcma.so.1 dapl.2.0 "mlx5_bond_roce 0" ""
ofa-v2-cma-roe-mlx5_bond_roce u2.0 nonthreadsafe default libdaplofa.so.2 dapl.2.0 "mlx5_bond_roce 0" ""
ofa-v2-cma-roe-mlx5_ib0 u2.0 nonthreadsafe default libdaplofa.so.2 dapl.2.0 "mlx5_ib0 0" ""
+ cat test.c
#include <stdio.h>
#include <stdlib.h>
#include <dat2/udat.h>

int main(int argc, char **argv)
{
	DAT_IA_HANDLE  iaHandle;
	DAT_EVD_HANDLE evdHandle;
	DAT_RETURN status;
	DAT_NAME_PTR gDevName;
	DAT_COUNT SVR_EVD_QLEN;

	int i;

	if (argc != 3)
		return -1;

	gDevName = argv[1];
	SVR_EVD_QLEN = atoi(argv[2]);

	for(i = 0 ; i < 400 ; i++ ) {
		iaHandle = DAT_HANDLE_NULL;
		evdHandle   = DAT_HANDLE_NULL;
		printf("open number %d\n", i);
		status = dat_ia_open(gDevName, SVR_EVD_QLEN, &evdHandle, &iaHandle);
		if (DAT_SUCCESS != status) {
			printf("dat_ia_open status = %u\n", status);
			return 1;
		}
		if (DAT_SUCCESS != (status = dat_ia_close(iaHandle, DAT_CLOSE_GRACEFUL_FLAG) )) {
			printf("dat_ia_close status = %u\n", status);
			return 1;
		}
	}

	//for(;;);
	
	return 0;
}
+ rm -f test.exe
+ '[' '!' -e test.exe ']'
+ gcc -ldat2 -Wall -Werror -g -o test.exe test.c
+ '[' x = xdebug ']'
+ ulimit -n 50
+ ./test.exe ofa-v2-cma-roe-mlx5_bond_roce 8
open number 0
open number 1
open number 2
open number 3
open number 4
open number 5
open number 6
open number 7
open number 8
open number 9
open number 10
open number 11
open number 12
open number 13
open number 14
open number 15
open number 16
open number 17
open number 18
open number 19
open number 20
open number 21
rdma-dev-19.lab.bos.redhat.com:CMA:2112e:24ea4640: 1735 us(1735 us):  open_hca: ibv_create_comp_channel ERR Too many open files
dat_ia_open status = 262144
+ ./test.exe ofa-v2-cma-roe-mlx5_ib0 8
open number 0
open number 1
open number 2
open number 3
open number 4
open number 5
open number 6
open number 7
open number 8
open number 9
open number 10
open number 11
open number 12
open number 13
open number 14
open number 15
open number 16
open number 17
open number 18
open number 19
open number 20
open number 21
rdma-dev-19.lab.bos.redhat.com:CMA:21170:6c834640: 2294 us(2294 us):  open_hca: ibv_create_comp_channel ERR Too many open files
dat_ia_open status = 262144


[root@rdma-dev-19 test]$  ps -ef | grep test.exe
root     135815 135807 90 08:35 pts/1    00:00:24 ./test.exe ofa-v2-cma-roe-mlx5_ib0 8

[root@rdma-dev-19 fd]$ ls -l | head
total 0
lrwx------. 1 root root 64 Dec 26 08:36 0 -> /dev/pts/1
lrwx------. 1 root root 64 Dec 26 08:36 1 -> /dev/pts/1
lrwx------. 1 root root 64 Dec 26 08:36 10 -> /dev/infiniband/uverbs2
lrwx------. 1 root root 64 Dec 26 08:36 100 -> /dev/infiniband/uverbs2
lr-x------. 1 root root 64 Dec 26 08:36 101 -> anon_inode:[infinibandevent]
lrwx------. 1 root root 64 Dec 26 08:36 102 -> /dev/infiniband/uverbs2
lr-x------. 1 root root 64 Dec 26 08:36 103 -> anon_inode:[infinibandevent]
lrwx------. 1 root root 64 Dec 26 08:36 104 -> /dev/infiniband/uverbs2
lr-x------. 1 root root 64 Dec 26 08:36 105 -> anon_inode:[infinibandevent]

The 'dev/infiniband/uverbs2' and 'anon_inode:[infinibandevent]' file handlers are leaked.

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fd.c"

#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <arpa/inet.h>
#include <rdma/rdma_cma.h>
#include <limits.h>

#include <sys/types.h>
#include <unistd.h>

void test(char *ipoib_ip)
{
	int ret;
	struct rdma_cm_id *id;
	struct sockaddr_in ipoib_addr;
	struct rdma_event_channel *ch;

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
}

int main(int argc, char** argv)
{
	int i;
	void *handle;
	pid_t pid;
	char path[128];
	int ret;

#if 1
	if (argc != 2) {
		printf("usage: %s IPoIB_IP_ADDR\n", argv[0]);
		exit(-1);
	}
#endif

	pid = getpid();
	printf("pid = %d\n", pid);

//#define MAX INT_MAX
#define MAX 1
	for (i = 0; i < MAX; i++) {
		if (i % 1000 == 0)
			printf("dlopen/dlclose test: round %d\n", i);
		handle = dlopen("/usr/lib64/librdmacm.so", RTLD_NOW);
		if (!handle) {
			printf("dlopen failed\n");
		}

		test(argv[1]);
#if 1
		ret = dlclose(handle);
		if (ret != 0)
			printf("dlclose failed\n");
#endif		
	}

	return 0;
}
 


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trace.log"

==30362== Memcheck, a memory error detector
==30362== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==30362== Using Valgrind-3.15.0-608cb11914-20190413 and LibVEX; rerun with -h for copyright info
==30362== Command: ./fd.exe 172.31.0.230
==30362== 
--30362-- Valgrind options:
--30362--    -v
--30362--    --trace-children=yes
--30362--    --track-fds=yes
--30362--    --log-fd=2
--30362--    --error-limit=no
--30362--    --leak-check=full
--30362--    --show-possibly-lost=yes
--30362--    --track-origins=yes
--30362--    --show-reachable=yes
--30362--    --keep-debuginfo=yes
--30362-- Contents of /proc/version:
--30362--   Linux version 4.18.0-171.el8.x86_64 (mockbuild@x86-vm-08.build.eng.bos.redhat.com) (gcc version 8.3.1 20191121 (Red Hat 8.3.1-5) (GCC)) #1 SMP Fri Jan 17 15:12:49 UTC 2020
--30362-- 
--30362-- Arch and hwcaps: AMD64, LittleEndian, amd64-cx16-rdtscp-sse3-ssse3-avx-f16c-rdrand
--30362-- Page sizes: currently 4096, max supported 4096
--30362-- Valgrind library directory: /usr/libexec/valgrind
--30362-- Reading syms from /root/cm/fd.exe
--30362-- Reading syms from /usr/lib64/ld-2.28.so
--30362-- Reading syms from /usr/libexec/valgrind/memcheck-amd64-linux
--30362--    object doesn't have a symbol table
--30362--    object doesn't have a dynamic symbol table
--30362-- Scheduler: using generic scheduler lock implementation.
--30362-- Reading suppressions file: /usr/libexec/valgrind/default.supp
==30362== embedded gdbserver: reading from /tmp/vgdb-pipe-from-vgdb-to-30362-by-root-on-rdma-dev-00.lab.bos.redhat.com
==30362== embedded gdbserver: writing to   /tmp/vgdb-pipe-to-vgdb-from-30362-by-root-on-rdma-dev-00.lab.bos.redhat.com
==30362== embedded gdbserver: shared mem   /tmp/vgdb-pipe-shared-mem-vgdb-30362-by-root-on-rdma-dev-00.lab.bos.redhat.com
==30362== 
==30362== TO CONTROL THIS PROCESS USING vgdb (which you probably
==30362== don't want to do, unless you know exactly what you're doing,
==30362== or are doing some strange experiment):
==30362==   /usr/libexec/valgrind/../../bin/vgdb --pid=30362 ...command...
==30362== 
==30362== TO DEBUG THIS PROCESS USING GDB: start GDB like this
==30362==   /path/to/gdb ./fd.exe
==30362== and then give GDB the following command
==30362==   target remote | /usr/libexec/valgrind/../../bin/vgdb --pid=30362
==30362== --pid is optional if only one valgrind process is running
==30362== 
--30362-- REDIR: 0x401fff0 (ld-linux-x86-64.so.2:strlen) redirected to 0x580cb2d2 (???)
--30362-- REDIR: 0x401fdc0 (ld-linux-x86-64.so.2:index) redirected to 0x580cb2ec (???)
--30362-- Reading syms from /usr/libexec/valgrind/vgpreload_core-amd64-linux.so
--30362-- Reading syms from /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so
==30362== WARNING: new redirection conflicts with existing -- ignoring it
--30362--     old: 0x0401fff0 (strlen              ) R-> (0000.0) 0x580cb2d2 ???
--30362--     new: 0x0401fff0 (strlen              ) R-> (2007.0) 0x04c34410 strlen
--30362-- REDIR: 0x401c7d0 (ld-linux-x86-64.so.2:strcmp) redirected to 0x4c354f0 (strcmp)
--30362-- REDIR: 0x4020550 (ld-linux-x86-64.so.2:mempcpy) redirected to 0x4c39040 (mempcpy)
--30362-- Reading syms from /usr/lib64/libdl-2.28.so
--30362-- Reading syms from /usr/lib64/librdmacm.so.1.2.26.0
--30362--   Considering /usr/lib/debug/.build-id/6b/3625f352f0ac61b7bce3802c2cf2b4377a30db.debug ..
--30362--   .. build-id is valid
--30362--   Considering /usr/lib/debug/.build-id/6b/../../../../../usr/lib/debug/usr/lib64/../../.dwz/rdma-core-26.0-7.el8.x86_64 ..
--30362--   .. build-id is valid
--30362-- Warning: cross-CU LIMITATION: some inlined fn names
--30362-- might be shown as UnknownInlinedFun
--30362-- Reading syms from /usr/lib64/libc-2.28.so
--30362-- Reading syms from /usr/lib64/libibverbs.so.1.7.26.0
--30362--   Considering /usr/lib/debug/.build-id/35/47f9d7d41fccb557351e3ef30df4c76e40da37.debug ..
--30362--   .. build-id is valid
--30362--   Considering /usr/lib/debug/.build-id/35/../../../../../usr/lib/debug/usr/lib64/../../.dwz/rdma-core-26.0-7.el8.x86_64 ..
--30362--   .. build-id is valid
--30362-- Reading syms from /usr/lib64/libnl-3.so.200.26.0
--30362--    object doesn't have a symbol table
--30362-- Reading syms from /usr/lib64/libpthread-2.28.so
--30362-- Reading syms from /usr/lib64/libnl-route-3.so.200.26.0
--30362--    object doesn't have a symbol table
--30362-- REDIR: 0x52e63d0 (libc.so.6:memmove) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e5550 (libc.so.6:strncpy) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e66e0 (libc.so.6:strcasecmp) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e4f10 (libc.so.6:strcat) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e5590 (libc.so.6:rindex) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e7d40 (libc.so.6:rawmemchr) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x5300990 (libc.so.6:wmemchr) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x53003f0 (libc.so.6:wcscmp) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e6540 (libc.so.6:mempcpy) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e6360 (libc.so.6:bcmp) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e54f0 (libc.so.6:strncmp) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e4f90 (libc.so.6:strcmp) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e64a0 (libc.so.6:memset) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x53003c0 (libc.so.6:wcschr) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e5480 (libc.so.6:strnlen) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e5040 (libc.so.6:strcspn) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e6730 (libc.so.6:strncasecmp) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e5000 (libc.so.6:strcpy) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e6880 (libc.so.6:memcpy@@GLIBC_2.14) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x5301c80 (libc.so.6:wcsnlen) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e55c0 (libc.so.6:strpbrk) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e4f50 (libc.so.6:index) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e5450 (libc.so.6:strlen) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52ec800 (libc.so.6:memrchr) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e6780 (libc.so.6:strcasecmp_l) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e6330 (libc.so.6:memchr) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x53004f0 (libc.so.6:wcslen) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e5880 (libc.so.6:strspn) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e66a0 (libc.so.6:stpncpy) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e6660 (libc.so.6:stpcpy) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e7d70 (libc.so.6:strchrnul) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e67d0 (libc.so.6:strncasecmp_l) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e54b0 (libc.so.6:strncat) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x53668c0 (libc.so.6:__memcpy_chk) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52e6250 (libc.so.6:strstr) redirected to 0x4a2b721 (_vgnU_ifunc_wrapper)
--30362-- REDIR: 0x52f5500 (libc.so.6:__strrchr_sse2) redirected to 0x4c33e00 (__strrchr_sse2)
--30362-- REDIR: 0x52f5800 (libc.so.6:__strlen_sse2) redirected to 0x4c34350 (__strlen_sse2)
--30362-- REDIR: 0x52edff0 (libc.so.6:__strcmp_sse2_unaligned) redirected to 0x4c353b0 (strcmp)
--30362-- REDIR: 0x52e1480 (libc.so.6:malloc) redirected to 0x4c30e69 (malloc)
--30362-- REDIR: 0x52f52f0 (libc.so.6:__strchrnul_sse2) redirected to 0x4c38b70 (strchrnul)
--30362-- REDIR: 0x52ff710 (libc.so.6:memcpy@GLIBC_2.2.5) redirected to 0x4c35650 (memcpy@GLIBC_2.2.5)
--30362-- REDIR: 0x52e1ad0 (libc.so.6:free) redirected to 0x4c3206a (free)
--30362-- REDIR: 0x52e5db0 (libc.so.6:__GI_strstr) redirected to 0x4c392a0 (__strstr_sse2)
--30362-- REDIR: 0x52efb00 (libc.so.6:__memchr_sse2) redirected to 0x4c35590 (memchr)
--30362-- REDIR: 0x53c1390 (libc.so.6:__strspn_sse42) redirected to 0x4c394b0 (strspn)
--30362-- REDIR: 0x53c10d0 (libc.so.6:__strcspn_sse42) redirected to 0x4c393f0 (strcspn)
--30362-- REDIR: 0x53b6010 (libc.so.6:__strcasecmp_avx) redirected to 0x4c34c60 (strcasecmp)
--30362-- REDIR: 0x52e2240 (libc.so.6:calloc) redirected to 0x4c33160 (calloc)
--30362-- REDIR: 0x52ff6f0 (libc.so.6:__mempcpy_sse2_unaligned) redirected to 0x4c38c80 (mempcpy)
--30362-- REDIR: 0x52ffb40 (libc.so.6:__memset_sse2_unaligned) redirected to 0x4c37f70 (memset)
--30362-- REDIR: 0x53affe0 (libc.so.6:__strncmp_sse42) redirected to 0x4c34bf0 (__strncmp_sse42)
--30362-- Reading syms from /usr/lib64/libibverbs/libvmw_pvrdma-rdmav25.so
--30362--   Considering /usr/lib/debug/.build-id/ee/9c6a6ad45b7f8fa93b96a32c95fa1bb4cad9df.debug ..
--30362--   .. build-id is valid
--30362--   Considering /usr/lib/debug/.build-id/ee/../../../../../usr/lib/debug/usr/lib64/libibverbs/../../../.dwz/rdma-core-26.0-7.el8.x86_64 ..
--30362--   .. build-id is valid
--30362-- Reading syms from /usr/lib64/libibverbs/libsiw-rdmav25.so
--30362--   Considering /usr/lib/debug/.build-id/e4/e49ea20292cc905ed7c123f6610223c0e33769.debug ..
--30362--   .. build-id is valid
--30362--   Considering /usr/lib/debug/.build-id/e4/../../../../../usr/lib/debug/usr/lib64/libibverbs/../../../.dwz/rdma-core-26.0-7.el8.x86_64 ..
--30362--   .. build-id is valid
--30362-- Reading syms from /usr/lib64/libibverbs/librxe-rdmav25.so
--30362--   Considering /usr/lib/debug/.build-id/d6/78251328d22875747387de14f79dc01358bd1e.debug ..
--30362--   .. build-id is valid
--30362--   Considering /usr/lib/debug/.build-id/d6/../../../../../usr/lib/debug/usr/lib64/libibverbs/../../../.dwz/rdma-core-26.0-7.el8.x86_64 ..
--30362--   .. build-id is valid
--30362-- Reading syms from /usr/lib64/libibverbs/libqedr-rdmav25.so
--30362--   Considering /usr/lib/debug/.build-id/4d/996e3a3885a7a0d5c32eabb991d21eb267e4f0.debug ..
--30362--   .. build-id is valid
--30362--   Considering /usr/lib/debug/.build-id/4d/../../../../../usr/lib/debug/usr/lib64/libibverbs/../../../.dwz/rdma-core-26.0-7.el8.x86_64 ..
--30362--   .. build-id is valid
--30362-- Reading syms from /usr/lib64/libmlx5.so.1.11.26.0
--30362--   Considering /usr/lib/debug/.build-id/fa/e6256e06a2090493d1f8beacf938270803982e.debug ..
--30362--   .. build-id is valid
--30362--   Considering /usr/lib/debug/.build-id/fa/../../../../../usr/lib/debug/usr/lib64/../../.dwz/rdma-core-26.0-7.el8.x86_64 ..
--30362--   .. build-id is valid
--30362-- Reading syms from /usr/lib64/libmlx4.so.1.0.26.0
--30362--   Considering /usr/lib/debug/.build-id/5d/66e90560dec9ebfe2d0478535745b2edff8dd8.debug ..
--30362--   .. build-id is valid
--30362--   Considering /usr/lib/debug/.build-id/5d/../../../../../usr/lib/debug/usr/lib64/../../.dwz/rdma-core-26.0-7.el8.x86_64 ..
--30362--   .. build-id is valid
--30362-- Reading syms from /usr/lib64/libibverbs/libi40iw-rdmav25.so
--30362--   Considering /usr/lib/debug/.build-id/03/7b1c0f89ec6d9b49b74f47236eedd754e25f0b.debug ..
--30362--   .. build-id is valid
--30362--   Considering /usr/lib/debug/.build-id/03/../../../../../usr/lib/debug/usr/lib64/libibverbs/../../../.dwz/rdma-core-26.0-7.el8.x86_64 ..
--30362--   .. build-id is valid
--30362-- Reading syms from /usr/lib64/libibverbs/libhns-rdmav25.so
--30362--   Considering /usr/lib/debug/.build-id/8c/e0e44b7a48fbea7433316c84e2063defa37bda.debug ..
--30362--   .. build-id is valid
--30362--   Considering /usr/lib/debug/.build-id/8c/../../../../../usr/lib/debug/usr/lib64/libibverbs/../../../.dwz/rdma-core-26.0-7.el8.x86_64 ..
--30362--   .. build-id is valid
--30362-- Reading syms from /usr/lib64/libibverbs/libhfi1verbs-rdmav25.so
--30362--   Considering /usr/lib/debug/.build-id/81/94080102321370b46b787389ed641fe39a96e4.debug ..
--30362--   .. build-id is valid
--30362--   Considering /usr/lib/debug/.build-id/81/../../../../../usr/lib/debug/usr/lib64/libibverbs/../../../.dwz/rdma-core-26.0-7.el8.x86_64 ..
--30362--   .. build-id is valid
--30362-- Reading syms from /usr/lib64/libibverbs/libcxgb4-rdmav25.so
--30362--   Considering /usr/lib/debug/.build-id/b3/ad6186ade5b49a67445c72f5836b092f0738d0.debug ..
--30362--   .. build-id is valid
--30362--   Considering /usr/lib/debug/.build-id/b3/../../../../../usr/lib/debug/usr/lib64/libibverbs/../../../.dwz/rdma-core-26.0-7.el8.x86_64 ..
--30362--   .. build-id is valid
--30362-- Reading syms from /usr/lib64/libibverbs/libbnxt_re-rdmav25.so
--30362--   Considering /usr/lib/debug/.build-id/2d/40d6f3b9c9200d4a649861edaf790c6e47f2c4.debug ..
--30362--   .. build-id is valid
--30362--   Considering /usr/lib/debug/.build-id/2d/../../../../../usr/lib/debug/usr/lib64/libibverbs/../../../.dwz/rdma-core-26.0-7.el8.x86_64 ..
--30362--   .. build-id is valid
--30362-- REDIR: 0x5366ca0 (libc.so.6:__strcpy_chk) redirected to 0x4c38be0 (__strcpy_chk)
--30362-- REDIR: 0x52fa740 (libc.so.6:__strcpy_sse2_unaligned) redirected to 0x4c34440 (strcpy)
--30362-- REDIR: 0x52ff700 (libc.so.6:__memcpy_chk_sse2_unaligned) redirected to 0x4c39130 (__memcpy_chk)
pid = 30362
dlopen/dlclose test: round 0
==30362== 
==30362== FILE DESCRIPTORS: 4 open at exit.
==30362== Open file descriptor 4: /dev/infiniband/uverbs0
==30362==    at 0x53487D2: open (in /usr/lib64/libc-2.28.so)
==30362==    by 0x5632EF8: UnknownInlinedFun (fcntl2.h:53)
==30362==    by 0x5632EF8: open_cdev_internal (open_cdev.c:52)
==30362==    by 0x56331C3: open_cdev (open_cdev.c:141)
==30362==    by 0x562C7F3: verbs_open_device (device.c:345)
==30362==    by 0x50482D1: ucma_open_device (cma.c:325)
==30362==    by 0x50482D1: ucma_init_device.part.2 (cma.c:343)
==30362==    by 0x504855F: ucma_init_device (cma.c:474)
==30362==    by 0x504855F: ucma_get_device (cma.c:469)
==30362==    by 0x50487A9: ucma_query_addr (cma.c:714)
==30362==    by 0x5048883: rdma_bind_addr2 (cma.c:884)
==30362==    by 0x5048F34: rdma_bind_addr (cma.c:901)
==30362==    by 0x400A59: test (fd.c:40)
==30362==    by 0x400B7D: main (fd.c:94)
==30362== 
==30362== Open file descriptor 2:
==30362==    <inherited from parent>
==30362== 
==30362== Open file descriptor 1:
==30362==    <inherited from parent>
==30362== 
==30362== Open file descriptor 0: /dev/pts/0
==30362==    <inherited from parent>
==30362== 
==30362== 
==30362== HEAP SUMMARY:
==30362==     in use at exit: 36,922 bytes in 62 blocks
==30362==   total heap usage: 266 allocs, 204 frees, 276,155 bytes allocated
==30362== 
==30362== Searching for pointers to 62 not-freed blocks
==30362== Checked 240,400 bytes
==30362== 
==30362== 2 bytes in 1 blocks are still reachable in loss record 1 of 12
==30362==    at 0x4C30EDB: malloc (vg_replace_malloc.c:309)
==30362==    by 0x5048311: ucma_init_device.part.2 (cma.c:353)
==30362==    by 0x504855F: ucma_init_device (cma.c:474)
==30362==    by 0x504855F: ucma_get_device (cma.c:469)
==30362==    by 0x50487A9: ucma_query_addr (cma.c:714)
==30362==    by 0x5048883: rdma_bind_addr2 (cma.c:884)
==30362==    by 0x5048F34: rdma_bind_addr (cma.c:901)
==30362==    by 0x400A59: test (fd.c:40)
==30362==    by 0x400B7D: main (fd.c:94)
==30362== 
==30362== 56 bytes in 1 blocks are still reachable in loss record 2 of 12
==30362==    at 0x4C331EA: calloc (vg_replace_malloc.c:762)
==30362==    by 0x504A3E8: ucma_init (cma.c:289)
==30362==    by 0x504A3E8: ucma_init (cma.c:256)
==30362==    by 0x504A789: rdma_create_event_channel (cma.c:432)
==30362==    by 0x400A04: test (fd.c:32)
==30362==    by 0x400B7D: main (fd.c:94)
==30362== 
==30362== 264 bytes in 11 blocks are still reachable in loss record 3 of 12
==30362==    at 0x4C30EDB: malloc (vg_replace_malloc.c:309)
==30362==    by 0x562EE71: verbs_register_driver_25 (init.c:224)
==30362==    by 0x400FEC9: call_init.part.0 (in /usr/lib64/ld-2.28.so)
==30362==    by 0x400FFC9: _dl_init (in /usr/lib64/ld-2.28.so)
==30362==    by 0x539446B: _dl_catch_exception (in /usr/lib64/libc-2.28.so)
==30362==    by 0x4014107: dl_open_worker (in /usr/lib64/ld-2.28.so)
==30362==    by 0x5394413: _dl_catch_exception (in /usr/lib64/libc-2.28.so)
==30362==    by 0x40138FD: _dl_open (in /usr/lib64/ld-2.28.so)
==30362==    by 0x4E3F1B9: dlopen_doit (in /usr/lib64/libdl-2.28.so)
==30362==    by 0x5394413: _dl_catch_exception (in /usr/lib64/libc-2.28.so)
==30362==    by 0x53944D2: _dl_catch_error (in /usr/lib64/libc-2.28.so)
==30362==    by 0x4E3F938: _dlerror_run (in /usr/lib64/libdl-2.28.so)
==30362== 
==30362== 464 bytes in 11 blocks are still reachable in loss record 4 of 12
==30362==    at 0x4C30EDB: malloc (vg_replace_malloc.c:309)
==30362==    by 0x401C79D: strdup (in /usr/lib64/ld-2.28.so)
==30362==    by 0x40092C5: _dl_map_object (in /usr/lib64/ld-2.28.so)
==30362==    by 0x4013D64: dl_open_worker (in /usr/lib64/ld-2.28.so)
==30362==    by 0x5394413: _dl_catch_exception (in /usr/lib64/libc-2.28.so)
==30362==    by 0x40138FD: _dl_open (in /usr/lib64/ld-2.28.so)
==30362==    by 0x4E3F1B9: dlopen_doit (in /usr/lib64/libdl-2.28.so)
==30362==    by 0x5394413: _dl_catch_exception (in /usr/lib64/libc-2.28.so)
==30362==    by 0x53944D2: _dl_catch_error (in /usr/lib64/libc-2.28.so)
==30362==    by 0x4E3F938: _dlerror_run (in /usr/lib64/libdl-2.28.so)
==30362==    by 0x4E3F259: dlopen@@GLIBC_2.2.5 (in /usr/lib64/libdl-2.28.so)
==30362==    by 0x562D7ED: load_driver (dynamic_driver.c:186)
==30362== 
==30362== 464 bytes in 11 blocks are still reachable in loss record 5 of 12
==30362==    at 0x4C30EDB: malloc (vg_replace_malloc.c:309)
==30362==    by 0x400BEDF: _dl_new_object (in /usr/lib64/ld-2.28.so)
==30362==    by 0x40064BF: _dl_map_object_from_fd (in /usr/lib64/ld-2.28.so)
==30362==    by 0x4009349: _dl_map_object (in /usr/lib64/ld-2.28.so)
==30362==    by 0x4013D64: dl_open_worker (in /usr/lib64/ld-2.28.so)
==30362==    by 0x5394413: _dl_catch_exception (in /usr/lib64/libc-2.28.so)
==30362==    by 0x40138FD: _dl_open (in /usr/lib64/ld-2.28.so)
==30362==    by 0x4E3F1B9: dlopen_doit (in /usr/lib64/libdl-2.28.so)
==30362==    by 0x5394413: _dl_catch_exception (in /usr/lib64/libc-2.28.so)
==30362==    by 0x53944D2: _dl_catch_error (in /usr/lib64/libc-2.28.so)
==30362==    by 0x4E3F938: _dlerror_run (in /usr/lib64/libdl-2.28.so)
==30362==    by 0x4E3F259: dlopen@@GLIBC_2.2.5 (in /usr/lib64/libdl-2.28.so)
==30362== 
==30362== 552 bytes in 1 blocks are possibly lost in loss record 6 of 12
==30362==    at 0x4C331EA: calloc (vg_replace_malloc.c:762)
==30362==    by 0x562C618: verbs_init_context (device.c:276)
==30362==    by 0x562C78E: _verbs_init_and_alloc_context (device.c:312)
==30362==    by 0x6D6348C: mlx4_alloc_context (mlx4.c:172)
==30362==    by 0x562C809: verbs_open_device (device.c:354)
==30362==    by 0x50482D1: ucma_open_device (cma.c:325)
==30362==    by 0x50482D1: ucma_init_device.part.2 (cma.c:343)
==30362==    by 0x504855F: ucma_init_device (cma.c:474)
==30362==    by 0x504855F: ucma_get_device (cma.c:469)
==30362==    by 0x50487A9: ucma_query_addr (cma.c:714)
==30362==    by 0x5048883: rdma_bind_addr2 (cma.c:884)
==30362==    by 0x5048F34: rdma_bind_addr (cma.c:901)
==30362==    by 0x400A59: test (fd.c:40)
==30362==    by 0x400B7D: main (fd.c:94)
==30362== 
==30362== 712 bytes in 1 blocks are possibly lost in loss record 7 of 12
==30362==    at 0x4C331EA: calloc (vg_replace_malloc.c:762)
==30362==    by 0x6D6339B: mlx4_device_alloc (mlx4.c:287)
==30362==    by 0x562E639: try_driver (init.c:365)
==30362==    by 0x562E940: try_drivers (init.c:431)
==30362==    by 0x562E940: try_all_drivers (init.c:521)
==30362==    by 0x562F34C: ibverbs_get_device_list (init.c:585)
==30362==    by 0x562C1C4: ibv_get_device_list@@IBVERBS_1.1 (device.c:74)
==30362==    by 0x504A3C5: ucma_init (cma.c:278)
==30362==    by 0x504A3C5: ucma_init (cma.c:256)
==30362==    by 0x504A789: rdma_create_event_channel (cma.c:432)
==30362==    by 0x400A04: test (fd.c:32)
==30362==    by 0x400B7D: main (fd.c:94)
==30362== 
==30362== 1,048 bytes in 1 blocks are possibly lost in loss record 8 of 12
==30362==    at 0x4C331EA: calloc (vg_replace_malloc.c:762)
==30362==    by 0x562E0EB: find_sysfs_devs_nl_cb (ibdev_nl.c:156)
==30362==    by 0x584DECB: nl_recvmsgs_report (in /usr/lib64/libnl-3.so.200.26.0)
==30362==    by 0x584E38C: nl_recvmsgs (in /usr/lib64/libnl-3.so.200.26.0)
==30362==    by 0x5633307: rdmanl_get_devices (rdma_nl.c:96)
==30362==    by 0x562E29D: find_sysfs_devs_nl (ibdev_nl.c:205)
==30362==    by 0x562F105: ibverbs_get_device_list (init.c:540)
==30362==    by 0x562C1C4: ibv_get_device_list@@IBVERBS_1.1 (device.c:74)
==30362==    by 0x504A3C5: ucma_init (cma.c:278)
==30362==    by 0x504A3C5: ucma_init (cma.c:256)
==30362==    by 0x504A789: rdma_create_event_channel (cma.c:432)
==30362==    by 0x400A04: test (fd.c:32)
==30362==    by 0x400B7D: main (fd.c:94)
==30362== 
==30362== 2,544 bytes in 11 blocks are still reachable in loss record 9 of 12
==30362==    at 0x4C331EA: calloc (vg_replace_malloc.c:762)
==30362==    by 0x401160F: _dl_check_map_versions (in /usr/lib64/ld-2.28.so)
==30362==    by 0x4013E15: dl_open_worker (in /usr/lib64/ld-2.28.so)
==30362==    by 0x5394413: _dl_catch_exception (in /usr/lib64/libc-2.28.so)
==30362==    by 0x40138FD: _dl_open (in /usr/lib64/ld-2.28.so)
==30362==    by 0x4E3F1B9: dlopen_doit (in /usr/lib64/libdl-2.28.so)
==30362==    by 0x5394413: _dl_catch_exception (in /usr/lib64/libc-2.28.so)
==30362==    by 0x53944D2: _dl_catch_error (in /usr/lib64/libc-2.28.so)
==30362==    by 0x4E3F938: _dlerror_run (in /usr/lib64/libdl-2.28.so)
==30362==    by 0x4E3F259: dlopen@@GLIBC_2.2.5 (in /usr/lib64/libdl-2.28.so)
==30362==    by 0x562D7ED: load_driver (dynamic_driver.c:186)
==30362==    by 0x562DC1B: load_drivers (dynamic_driver.c:236)
==30362== 
==30362== 8,192 bytes in 1 blocks are still reachable in loss record 10 of 12
==30362==    at 0x4C331EA: calloc (vg_replace_malloc.c:762)
==30362==    by 0x504C933: idm_grow (indexer.c:125)
==30362==    by 0x504C933: idm_set (indexer.c:146)
==30362==    by 0x5048C95: ucma_insert_id (cma.c:518)
==30362==    by 0x504A984: rdma_create_id2.part.12 (cma.c:616)
==30362==    by 0x504A451: ucma_set_af_ib_support (cma.c:241)
==30362==    by 0x504A451: ucma_init (cma.c:299)
==30362==    by 0x504A451: ucma_init (cma.c:256)
==30362==    by 0x504A789: rdma_create_event_channel (cma.c:432)
==30362==    by 0x400A04: test (fd.c:32)
==30362==    by 0x400B7D: main (fd.c:94)
==30362== 
==30362== 9,136 bytes in 1 blocks are possibly lost in loss record 11 of 12
==30362==    at 0x4C331EA: calloc (vg_replace_malloc.c:762)
==30362==    by 0x562C774: _verbs_init_and_alloc_context (device.c:303)
==30362==    by 0x6D6348C: mlx4_alloc_context (mlx4.c:172)
==30362==    by 0x562C809: verbs_open_device (device.c:354)
==30362==    by 0x50482D1: ucma_open_device (cma.c:325)
==30362==    by 0x50482D1: ucma_init_device.part.2 (cma.c:343)
==30362==    by 0x504855F: ucma_init_device (cma.c:474)
==30362==    by 0x504855F: ucma_get_device (cma.c:469)
==30362==    by 0x50487A9: ucma_query_addr (cma.c:714)
==30362==    by 0x5048883: rdma_bind_addr2 (cma.c:884)
==30362==    by 0x5048F34: rdma_bind_addr (cma.c:901)
==30362==    by 0x400A59: test (fd.c:40)
==30362==    by 0x400B7D: main (fd.c:94)
==30362== 
==30362== 13,488 bytes in 11 blocks are still reachable in loss record 12 of 12
==30362==    at 0x4C331EA: calloc (vg_replace_malloc.c:762)
==30362==    by 0x400BC01: _dl_new_object (in /usr/lib64/ld-2.28.so)
==30362==    by 0x40064BF: _dl_map_object_from_fd (in /usr/lib64/ld-2.28.so)
==30362==    by 0x4009349: _dl_map_object (in /usr/lib64/ld-2.28.so)
==30362==    by 0x4013D64: dl_open_worker (in /usr/lib64/ld-2.28.so)
==30362==    by 0x5394413: _dl_catch_exception (in /usr/lib64/libc-2.28.so)
==30362==    by 0x40138FD: _dl_open (in /usr/lib64/ld-2.28.so)
==30362==    by 0x4E3F1B9: dlopen_doit (in /usr/lib64/libdl-2.28.so)
==30362==    by 0x5394413: _dl_catch_exception (in /usr/lib64/libc-2.28.so)
==30362==    by 0x53944D2: _dl_catch_error (in /usr/lib64/libc-2.28.so)
==30362==    by 0x4E3F938: _dlerror_run (in /usr/lib64/libdl-2.28.so)
==30362==    by 0x4E3F259: dlopen@@GLIBC_2.2.5 (in /usr/lib64/libdl-2.28.so)
==30362== 
==30362== LEAK SUMMARY:
==30362==    definitely lost: 0 bytes in 0 blocks
==30362==    indirectly lost: 0 bytes in 0 blocks
==30362==      possibly lost: 11,448 bytes in 4 blocks
==30362==    still reachable: 25,474 bytes in 58 blocks
==30362==         suppressed: 0 bytes in 0 blocks
==30362== 
==30362== ERROR SUMMARY: 4 errors from 4 contexts (suppressed: 0 from 0)

--/9DWx/yDrRhgMJTb--

