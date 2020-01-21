Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497B6143CAB
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2020 13:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAUMVm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jan 2020 07:21:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52620 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728794AbgAUMVm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Jan 2020 07:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579609301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xeUUVc/gbRpn1e/cwEf6TDgPQSYoqeMmL2GV3MfPBCo=;
        b=HdPqCD4ngI9EVlZGbeZBPLrPS4SjUGpVHr4xlXBdh8FT3sycvDssUJAMyP45BHqWGe5UcH
        8kvSXhRkjvkKS6NNacFZ5bt2vtNsRFj2QXRoligDw4qMTHedPIQh5PPRH355iLSONqFSXE
        cZIEr+tcmQoCgGb99pFU64GN1AVDMlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-kpwjti72PYq5hhWCR6MM9g-1; Tue, 21 Jan 2020 07:21:37 -0500
X-MC-Unique: kpwjti72PYq5hhWCR6MM9g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06FA88017CC;
        Tue, 21 Jan 2020 12:21:37 +0000 (UTC)
Received: from localhost (unknown [10.66.128.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 789FB28982;
        Tue, 21 Jan 2020 12:21:36 +0000 (UTC)
Date:   Tue, 21 Jan 2020 20:21:33 +0800
From:   Honggang LI <honli@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     sean.hefty@intel.com
Subject: resource leak in librdmacm
Message-ID: <20200121122133.GA105701@dhcp-128-72.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

 We are observing resource leak issues with librdmacm. This memory leak
 issue is one of those issues.

 You need a working IPoIB interface to run this reproducer. This reproducer will
be killed as out of memory.

It had been compiled with "gcc -ldl -lrdmacm -g -o fd-leak.exe fd-leak.c"

Thanks

~]$ cat fd-leak.c 
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

#if 0
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

	rdma_destroy_event_channel(ch);

	rdma_destroy_id(id);
}

int main(int argc, char** argv)
{
	int i;
	void *handle;
	pid_t pid;
	char path[128];
	int ret;

#if 0
	if (argc != 2) {
		printf("usage: %s IPoIB_IP_ADDR\n", argv[0]);
		exit(-1);
	}
#endif

#define MAX INT_MAX
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

#if 0
	pid = getpid();
	printf("pid = %d\n", pid);

//	for(;;);
#endif
	return 0;
}
 

