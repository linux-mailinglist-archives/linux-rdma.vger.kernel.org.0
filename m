Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0AAA1239E
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 22:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfEBUus (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 16:50:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfEBUus (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 16:50:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29082C057F2C;
        Thu,  2 May 2019 20:50:48 +0000 (UTC)
Received: from jtoppins.rdu.csb (ovpn-125-122.rdu2.redhat.com [10.10.125.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA0D41001E85;
        Thu,  2 May 2019 20:50:47 +0000 (UTC)
Reply-To: jtoppins@redhat.com
Subject: Re: Is this a known build issue on s390x for v5.1-rc7?
From:   Jonathan Toppins <jtoppins@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <9dd7f774-2b14-d4a7-3a85-edff758e36d0@redhat.com>
Organization: Red Hat
Message-ID: <be19dd92-2025-bc03-605f-db3e0e6c2a74@redhat.com>
Date:   Thu, 2 May 2019 16:50:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9dd7f774-2b14-d4a7-3a85-edff758e36d0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 02 May 2019 20:50:48 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/02/2019 04:48 PM, Jonathan Toppins wrote:
> $ git log --oneline -1
> 37624b58542f (HEAD, tag: v5.1-rc7, stable/master, rdma/master,
> acpi/master) Linux 5.1-rc7
> 
> $ make ARCH=s390 CROSS_COMPILE=s390x-linux-gnu-
> KCONFIG_CONFIG=../kernel-4.18.0-s390x.config all
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   CHK     include/generated/compile.h
>   LD [M]  drivers/infiniband/core/ib_core.o
>   LD [M]  drivers/infiniband/core/ib_cm.o
>   LD [M]  drivers/infiniband/core/iw_cm.o
>   LD [M]  drivers/infiniband/core/rdma_cm.o
>   CC [M]  drivers/infiniband/core/uverbs_main.o
> In file included from ./arch/s390/include/asm/page.h:180:0,
>                  from ./arch/s390/include/asm/thread_info.h:26,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/s390/include/asm/preempt.h:6,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/seqlock.h:36,
>                  from ./include/linux/time.h:6,
>                  from ./include/linux/stat.h:19,
>                  from ./include/linux/module.h:10,
>                  from drivers/infiniband/core/uverbs_main.c:37:
> drivers/infiniband/core/uverbs_main.c: In function ‘rdma_umap_fault’:
> drivers/infiniband/core/uverbs_main.c:898:28: error: ‘struct vm_fault’
> has no member named ‘vm_start’
>    vmf->page = ZERO_PAGE(vmf->vm_start);
>                             ^
> ./include/asm-generic/memory_model.h:54:40: note: in definition of macro
> ‘__pfn_to_page’
>  #define __pfn_to_page(pfn) (vmemmap + (pfn))
>                                         ^
> ./arch/s390/include/asm/page.h:162:29: note: in expansion of macro ‘__pa’
>  #define virt_to_pfn(kaddr) (__pa(kaddr) >> PAGE_SHIFT)
>                              ^
> ./arch/s390/include/asm/page.h:166:41: note: in expansion of macro
> ‘virt_to_pfn’
>  #define virt_to_page(kaddr) pfn_to_page(virt_to_pfn(kaddr))
>                                          ^
> ./arch/s390/include/asm/pgtable.h:60:3: note: in expansion of macro
> ‘virt_to_page’
>   (virt_to_page((void *)(empty_zero_page + \
>    ^
> drivers/infiniband/core/uverbs_main.c:898:15: note: in expansion of
> macro ‘ZERO_PAGE’
>    vmf->page = ZERO_PAGE(vmf->vm_start);
>                ^
> make[4]: *** [drivers/infiniband/core/uverbs_main.o] Error 1
> make[3]: *** [drivers/infiniband/core] Error 2
> make[2]: *** [drivers/infiniband] Error 2
> make[1]: *** [drivers] Error 2
> make: *** [sub-make] Error 2
> 

Nevermind, found the thread involving this.
