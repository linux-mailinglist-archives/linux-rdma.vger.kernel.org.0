Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA36540EF15
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Sep 2021 04:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhIQCFC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 22:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhIQCFB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 22:05:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92458C061574;
        Thu, 16 Sep 2021 19:03:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d18so5109587pll.11;
        Thu, 16 Sep 2021 19:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZW+88bHVtNLTHD1JZeZR9DkyRHIpMDlYnlNEb4JXekw=;
        b=dOri+gaYNV6Aw3eCSY6triyQuFNTZSFqk0LxOxgYZsIgrtLSSuokjQhUf3xOiijpMx
         syqefNpfyYpAN9KGJJO0Q95jUyWqF9XhQkmoIaAf6m3XkGcPG2MKXvfT8eWZTGOPw3w/
         zQ6oftxvsc0JQ8Nij74oEPCaTbYSBUBrGEN6ZQHJyvfxNWoqja17AbOWTUjmFILcElQT
         j+56mDPXYFEMKeW3u9RljnBHnPCIqKvIdK6nIklwSklZdWTm1MW7fMvNA6owCMZfv5Bb
         zBrWPT2MLP5wMcM5Kuhhop6nyOZf66FhE4JCou+kglERiOLfGYVYvkSM4sEPMp28dDOi
         KdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZW+88bHVtNLTHD1JZeZR9DkyRHIpMDlYnlNEb4JXekw=;
        b=VR6RxjLXd0DgsjC/2yUCBTWQelKrtRjwClVQ/EQpBIkqfRMlCeUsBNlnvRf4brxRuT
         MzPuw4e2owuLF288Q/fT4lmFtSlMou1CJwF+7GqTEoILEDjNL2hTcqy8O+TToP/t2K54
         gMlLz3SY5i6pxrNnHgqKC3E7yFA/QZN6+kogHVXq11fEjVkP6eGWrLZwN+C8e7cltbqx
         dTPQm7t22HzZEFgI4bvZcPsqMuc4JrIJhASSDgEzCANsiGmhk7bERWsCXGbI+CoedSbq
         Mq20YdVqwE5DCVy5plI0kgD3wWOakOOAEVBVCYDvXRUBwkeSsvUk9A4ulD+OMLfLfgKG
         xMbQ==
X-Gm-Message-State: AOAM531ho2f8L07AIkX4cuE2TynAdefEEbkcmZPwUcJ3u5ZrEtcNTDps
        kC5fNDB+JW4rxTkDCmmadUbOSJw+OhiL0yA/Bg==
X-Google-Smtp-Source: ABdhPJxxZa/epP8XAvSZn6oHhTWniLLRq7ikOqNmiLXqfkTytZzUuSyGnETUL3zUUCK8eVDs98365MmlGZmQy0HRfFs=
X-Received: by 2002:a17:902:f08c:b0:13d:8e59:caf5 with SMTP id
 p12-20020a170902f08c00b0013d8e59caf5mr964492pla.38.1631844219917; Thu, 16 Sep
 2021 19:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsY5-rKKzh-9GedNs53Luk6m_m3F67HguysW-=H1pdnH5Q@mail.gmail.com>
 <20210413133359.GG227011@ziepe.ca> <CACkBjsb2QU3+J3mhOT2nb0YRB0XodzKoNTwF3RCufFbSoXNm6A@mail.gmail.com>
 <20210413134458.GI227011@ziepe.ca> <CACkBjsY-CNzO74XGo0uJrcaZTubC+Yw9Sg1bNNi+evUOGaZTCg@mail.gmail.com>
 <20210916183518.GR3544071@ziepe.ca> <CACkBjsa3Fqkp-OkHFQ0LCL+VbP2H3xvpaArFkTPsdw8Cka27sw@mail.gmail.com>
In-Reply-To: <CACkBjsa3Fqkp-OkHFQ0LCL+VbP2H3xvpaArFkTPsdw8Cka27sw@mail.gmail.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 17 Sep 2021 10:03:28 +0800
Message-ID: <CACkBjsZVPNPeDSJsHDDfygrAR6fgYZuOGgNs-78ME44-7SxHrw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in cma_cancel_operation, rdma_listen
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hao Sun <sunhao.th@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=889:01=E5=86=99=E9=81=93=EF=BC=9A
>
> Jason Gunthorpe <jgg@ziepe.ca> =E4=BA=8E2021=E5=B9=B49=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=882:35=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Apr 13, 2021 at 10:19:25PM +0800, Hao Sun wrote:
> > > Jason Gunthorpe <jgg@ziepe.ca> =E4=BA=8E2021=E5=B9=B44=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:45=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Tue, Apr 13, 2021 at 09:42:43PM +0800, Hao Sun wrote:
> > > > > Jason Gunthorpe <jgg@ziepe.ca> =E4=BA=8E2021=E5=B9=B44=E6=9C=8813=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:34=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > > >
> > > > > > On Tue, Apr 13, 2021 at 11:36:41AM +0800, Hao Sun wrote:
> > > > > > > Hi
> > > > > > >
> > > > > > > When using Healer(https://github.com/SunHao-0/healer/tree/dev=
) to fuzz
> > > > > > > the Linux kernel, I found two use-after-free bugs which have =
been
> > > > > > > reported a long time ago by Syzbot.
> > > > > > > Although the corresponding patches have been merged into upst=
ream,
> > > > > > > these two bugs can still be triggered easily.
> > > > > > > The original information about Syzbot report can be found her=
e:
> > > > > > > https://syzkaller.appspot.com/bug?id=3D8dc0bcd9dd6ec915ba10b3=
354740eb420884acaa
> > > > > > > https://syzkaller.appspot.com/bug?id=3D95f89b8fb9fdc42e28ad58=
6e657fea074e4e719b
> > > > > >
> > > > > > Then why hasn't syzbot seen this in a year's time? Seems strang=
e
> > > > > >
> > > > >
> > > > > Seems strange to me too, but the fact is that the reproduction pr=
ogram
> > > > > in attachment can trigger these two bugs quickly.
> > > >
> > > > Do you have this in the C format?
> > > >
> > >
> > > Just tried to use syz-prog2c to convert the repro-prog to C format.
> > > The repro program of  rdma_listen was successfully reproduced
> > > (uploaded in attachment), the other one failed. it looks like
> > > syz-prog2c may not be able to do the equivalent conversion.
> > > You can use syz-execprog to execute the reprogram directly, this
> > > method can reproduce both crashes, I have tried it.
> >
> > Can you check this patch that should solve it?
> >
> > https://patchwork.kernel.org/project/linux-rdma/patch/0-v1-9fbb33f5e201=
+2a-cma_listen_jgg@nvidia.com/
> >
>
> Just executed the original Syz prog on the latest Linux kernel
> (ff1ffd71d5f0 Merge tag 'hyperv-fixes-signed-20210915'), it did not
> crash the kernel. I've checked that the above patch has not been
> merged into the latest commit. Therefore, there might be some other
> commits that fixed that issue.
>

Sorry, I made a mistake. The C reproducer can still crash the latest
version of the Linux kernel **without** patching the code from here
(https://patchwork.kernel.org/project/linux-rdma/patch/0-v1-9fbb33f5e201+2a=
-cma_listen_jgg@nvidia.com/).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: use-after-free in __list_add_valid+0x93/0xa0 lib/list_debug.c:2=
6
Read of size 8 at addr ffff8880189211e0 by task a.out/6637

CPU: 0 PID: 6637 Comm: a.out Not tainted 5.15.0-rc1+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x93/0x334 mm/kasan/report.c:25=
6
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 __list_add_valid+0x93/0xa0 lib/list_debug.c:26
 __list_add include/linux/list.h:67 [inline]
 list_add_tail include/linux/list.h:100 [inline]
 cma_listen_on_all drivers/infiniband/core/cma.c:2563 [inline]
 rdma_listen+0x7d2/0xeb0 drivers/infiniband/core/cma.c:3813
 ucma_listen+0x16a/0x210 drivers/infiniband/core/ucma.c:1102
 ucma_write+0x25c/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x22a/0xae0 fs/read_write.c:592
 ksys_write+0x1ee/0x250 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3352746469
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc7cfa3f68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000200003a8 RCX: 00007f3352746469
RDX: 0000000000000010 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007ffc7cfa4070 R08: 4e22224e4e24244e R09: 4e22224e4e24244e
R10: 0000000000000000 R11: 0000000000000246 R12: 0000561d50400fb0
R13: 00007ffc7cfa41b0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6636:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa4/0xd0 mm/kasan/common.c:522
 kasan_kmalloc include/linux/kasan.h:264 [inline]
 kmem_cache_alloc_trace+0x186/0x340 mm/slub.c:3233
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 __rdma_create_id+0x5b/0x550 drivers/infiniband/core/cma.c:839
 rdma_create_user_id+0x79/0xd0 drivers/infiniband/core/cma.c:893
 ucma_create_id+0x162/0x360 drivers/infiniband/core/ucma.c:461
 ucma_write+0x25c/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x22a/0xae0 fs/read_write.c:592
 ksys_write+0x1ee/0x250 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 6636:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0x100/0x140 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1700 [inline]
 slab_free_freelist_hook mm/slub.c:1725 [inline]
 slab_free mm/slub.c:3483 [inline]
 kfree+0xfc/0x700 mm/slub.c:4543
 ucma_close_id+0x4c/0x90 drivers/infiniband/core/ucma.c:185
 ucma_destroy_private_ctx+0x887/0xb00 drivers/infiniband/core/ucma.c:576
 ucma_close+0x10a/0x180 drivers/infiniband/core/ucma.c:1797
 __fput+0x288/0x9f0 fs/file_table.c:280
 task_work_run+0xe0/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xbbe/0x2dd0 kernel/exit.c:825
 do_group_exit+0x125/0x340 kernel/exit.c:922
 __do_sys_exit_group kernel/exit.c:933 [inline]
 __se_sys_exit_group kernel/exit.c:931 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888018921000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 480 bytes inside of
 2048-byte region [ffff888018921000, ffff888018921800)
The buggy address belongs to the page:
page:ffffea0000624800 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x18920
head:ffffea0000624800 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
raw: 00fff00000010200 0000000000000000 0000000300000001 ffff888010c42000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEM=
ALLOC),
pid 1, ts 12722123527, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook mm/page_alloc.c:2418 [inline]
 prep_new_page+0x1a5/0x240 mm/page_alloc.c:2424
 get_page_from_freelist+0x1f10/0x3b70 mm/page_alloc.c:4153
 __alloc_pages+0x306/0x6e0 mm/page_alloc.c:5375
 alloc_page_interleave+0x1e/0x1f0 mm/mempolicy.c:2042
 alloc_pages+0x1e4/0x240 mm/mempolicy.c:2192
 alloc_slab_page mm/slub.c:1763 [inline]
 allocate_slab mm/slub.c:1900 [inline]
 new_slab+0x34a/0x480 mm/slub.c:1963
 ___slab_alloc+0xa9f/0x10d0 mm/slub.c:2994
 __slab_alloc.isra.0+0x4d/0xa0 mm/slub.c:3081
 slab_alloc_node mm/slub.c:3172 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 __kmalloc+0x32e/0x390 mm/slub.c:4387
 kmalloc include/linux/slab.h:596 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 __register_sysctl_table+0xc3/0x1000 fs/proc/proc_sysctl.c:1318
 __devinet_sysctl_register+0x156/0x280 net/ipv4/devinet.c:2577
 devinet_sysctl_register net/ipv4/devinet.c:2617 [inline]
 devinet_sysctl_register+0x160/0x230 net/ipv4/devinet.c:2607
 inetdev_init+0x269/0x570 net/ipv4/devinet.c:276
 inetdev_event+0xdde/0x12f0 net/ipv4/devinet.c:1530
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info net/core/dev.c:1996 [inline]
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1981
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888018921080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888018921100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888018921180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888018921200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888018921280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


However, after patching the code, the crash can not be reproduced.
Therefore, that patch did fix the problem.

Regards
Hao
