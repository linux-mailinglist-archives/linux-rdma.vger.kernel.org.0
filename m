Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2515A9B5
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 14:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBLNHy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 08:07:54 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40488 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgBLNHx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Feb 2020 08:07:53 -0500
Received: by mail-vs1-f68.google.com with SMTP id c18so1069389vsq.7
        for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2020 05:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3x9UhB/yOAUz4xbOX8GmEmjh4gJ17LLK385BHmrhXgo=;
        b=VbBHpS9Cun+lC6YvGEOoqqEhfylhEzx0aTWyejA6SjKz85bbtvax/jeRKGnh/fONZN
         VxHtv8Im0ofDWlKpLKptB3mDfawExj+5pQLtEoY8TVVrAJTtz0Kbz5n6hXQnjVJX8AMG
         0HfdecT5w/5u7Z9fBvEH/nVPnwb6PQeoO6CpIe4IQZ9O6B8dx1uZWJJ79mnXJCol56bA
         1kEPRbNasg7enVa/jK51AGhNrw1zuaTI46wQo2xncg+T7/OAIigYlNDBFmn0amp2+1f3
         Iyd630SZuIvl9obbypJy7qPAFuuTCfbivzXimKVybclArKEhsiezlvRXwiTvWBXYfLdR
         Kxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3x9UhB/yOAUz4xbOX8GmEmjh4gJ17LLK385BHmrhXgo=;
        b=AwHUSBu6y3Fm0xod7rM8mEbKkWcQ0ehy03Xm004mbUUbAYavfgfkRvjgoLHqyR2OBn
         rzlLnl2H/fYqgEZhYpkF6kMXQtCGgLmYiqRO/0O6xhQqXTXq6HW12AtAGKxONV7jRiNd
         6oI/x7EiwJCBQ0b7K0FZbh+lEugJQYAbCDq0k3hvUvx9s4Zldzb1kiRuJJoKwkFDvojH
         cD3joyN3RVl6Cjk8REz+kiEx9f3J79+jo78aP/uExruzgCJ3IifMnvzrVaNnClunu/Px
         aLg5KiLjIf/84ELk2XNVeuxR0HryjTr9XyYq5ewa2yQSE7gmP+UZLskbHc1vhixlgytQ
         ueEw==
X-Gm-Message-State: APjAAAXUdqcYfBanlwtSY7fBC2uJpBy6UzljbTpcFEdIMog/ds03kzUe
        zjiqN1gKlAmIHzF8UbMuOIrjzbTUAiVe4YZMzQM=
X-Google-Smtp-Source: APXvYqx6HUwrSuY9Vr28YE5aupI8ZVRY8jHI2XdUvawuoS3eqtzvfVB6MGNSqgacY3MrKvR13vCw0DqDiZDvRIQ0ZCE=
X-Received: by 2002:a67:f6c8:: with SMTP id v8mr12501713vso.147.1581512872187;
 Wed, 12 Feb 2020 05:07:52 -0800 (PST)
MIME-Version: 1.0
References: <CAKC_zStdDH4my0gzfGhFc3zuWwGG1bW93Q+Bc-UF4csFacT5Hw@mail.gmail.com>
 <CAKC_zSvKE+tOYiODVmW=0=qd+HGGTEhREi3e4SOmK_Et_iVn8A@mail.gmail.com>
 <CAD=hENf3RaNDaxi3qRCH499Q9WK6ZDoPBSCrh0ffES6f5UU=5Q@mail.gmail.com> <CAKC_zSuwGKEc1za4gvUze41nyKzemwHSV-m_um3MkxwKQw=w1g@mail.gmail.com>
In-Reply-To: <CAKC_zSuwGKEc1za4gvUze41nyKzemwHSV-m_um3MkxwKQw=w1g@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 12 Feb 2020 21:07:40 +0800
Message-ID: <CAD=hENep4EFeE+C6g=aPJ7-OGJb0VbMyrrCZvC5jJJ4G5VUH1w@mail.gmail.com>
Subject: Re: slab leak on rxe
To:     Frank Huang <tigerinxm@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From kernel 4.14.97, the function rxe_cache_clean does not exist.
This function is introduced in the following commit.
"
commit 6db21d8986e14e2e86573a3b055b05296188bd2c
Author: Yuval Shaia <yuval.shaia@oracle.com>
Date:   Sun Dec 9 15:53:49 2018 +0200
    IB/rxe: Fix incorrect cache cleanup in error flow
    Array iterator stays at the same slot, fix it.
    Fixes: 8700e3e7c485 ("Soft RoCE driver")
    Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
    Reviewed-by: Bart Van Assche <bvanassche@acm.org>
    Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
    Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
"

On Tue, Feb 11, 2020 at 4:33 PM Frank Huang <tigerinxm@gmail.com> wrote:
>
> This is the first time I meet this bug, haven't found the bug trigger yet.
>
> We will kill the process in some situation using kill -9. Would it cause that?
>
> Before this happens, there are some error report:
>
> Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
> Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
> Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
> Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
> Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
> Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
> Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
> Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
> Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
> Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
>
> On Tue, Feb 11, 2020 at 3:42 PM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> >
> > Can this bug be reproduced?
> >
> > Zhu Yanjun
> >
> > On Tue, Feb 11, 2020 at 3:32 PM Frank Huang <tigerinxm@gmail.com> wrote:
> > >
> > > Re-post the log , sorry for the format.
> > >
> > > Feb 11 14:17:31  kernel:
> > > =============================================================================
> > > Feb 11 14:17:31  kernel: BUG rxe-qp (Tainted: G           OE  ):
> > > Objects remaining in rxe-qp on __kmem_cache_shutdown()
> > > Feb 11 14:17:31  kernel:
> > > -----------------------------------------------------------------------------
> > > Feb 11 14:17:31  kernel: Disabling lock debugging due to kernel taint
> > > Feb 11 14:17:31  kernel: INFO: Slab 0xfffff4c4b027a000 objects=16
> > > used=1 fp=0xffff96f3c9e83f00 flags=0x17ffffc0008100
> > > Feb 11 14:17:31  kernel: CPU: 27 PID: 25588 Comm: rmmod Tainted: G
> > > B      OE   4.14.97-.el7.centos.x86_64 #1
> > > Feb 11 14:17:31  kernel: Hardware name: /80010056, BIOS 4.1.15 03/28/2017
> > > Feb 11 14:17:31  kernel: Call Trace:
> > > Feb 11 14:17:31  kernel:  dump_stack+0x5a/0x7b
> > > Feb 11 14:17:31  kernel:  slab_err+0xb4/0xe0
> > > Feb 11 14:17:31  kernel:  ? calibrate_delay+0x138/0x5f0
> > > Feb 11 14:17:31  kernel:  ? on_each_cpu_mask+0x27/0x60
> > > Feb 11 14:17:31  kernel:  ? on_each_cpu_cond+0xaf/0x140
> > > Feb 11 14:17:31  kernel:  ? __kmalloc+0x179/0x200
> > > Feb 11 14:17:31  kernel:  ? __kmem_cache_shutdown+0x194/0x3d0
> > > Feb 11 14:17:31  kernel:  __kmem_cache_shutdown+0x1b4/0x3d0
> > > Feb 11 14:17:31  kernel:  shutdown_cache+0x13/0x1b0
> > > Feb 11 14:17:31  kernel:  kmem_cache_destroy+0x1e4/0x220
> > > Feb 11 14:17:31  kernel:  rxe_cache_clean+0x41/0x60 [rdma_rxe]
> > > Feb 11 14:17:31  kernel:  rxe_module_exit+0xf/0x68 [rdma_rxe]
> > > Feb 11 14:17:31  kernel:  SyS_delete_module+0x175/0x270
> > > Feb 11 14:17:31  kernel:  do_syscall_64+0x74/0x190
> > > Feb 11 14:17:31  kernel:  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> > > Feb 11 14:17:31  kernel: RIP: 0033:0x7ff146d3f517
> > > Feb 11 14:17:31  kernel: RSP: 002b:00007ffd4b5c1598 EFLAGS: 00000202
> > > ORIG_RAX: 00000000000000b0
> > > Feb 11 14:17:31  kernel: RAX: ffffffffffffffda RBX: 0000000000d78280
> > > RCX: 00007ff146d3f517
> > > Feb 11 14:17:31  kernel: RDX: 00007ff146db3ca0 RSI: 0000000000000800
> > > RDI: 0000000000d782e8
> > > Feb 11 14:17:31  kernel: RBP: 0000000000000000 R08: 00007ff147008060
> > > R09: 00007ff146db3ca0
> > > Feb 11 14:17:31  kernel: R10: 00007ffd4b5c1020 R11: 0000000000000202
> > > R12: 00007ffd4b5c36ca
> > > Feb 11 14:17:31  kernel: R13: 0000000000000000 R14: 0000000000d78280
> > > R15: 0000000000d78010
> > > Feb 11 14:17:31  kernel: INFO: Object 0xffff96f3c9e84ec0 @offset=20160
> > > Feb 11 14:17:31  kernel: kmem_cache_destroy rxe-qp: Slab cache still has objects
> > > Feb 11 14:17:31  kernel: CPU: 27 PID: 25588 Comm: rmmod Tainted: G
> > > B      OE   4.14.97-.el7.centos.x86_64 #1
> > > Feb 11 14:17:31  kernel: Hardware name: /80010056, BIOS 4.1.15 03/28/2017
> > > Feb 11 14:17:31  kernel: Call Trace:
> > > Feb 11 14:17:31  kernel:  dump_stack+0x5a/0x7b
> > > Feb 11 14:17:31  kernel:  kmem_cache_destroy+0x203/0x220
> > > Feb 11 14:17:31  kernel:  rxe_cache_clean+0x41/0x60 [rdma_rxe]
> > > Feb 11 14:17:31  kernel:  rxe_module_exit+0xf/0x68 [rdma_rxe]
> > > Feb 11 14:17:31  kernel:  SyS_delete_module+0x175/0x270
> > > Feb 11 14:17:31  kernel:  do_syscall_64+0x74/0x190
> > > Feb 11 14:17:31  kernel:  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> > > Feb 11 14:17:31  kernel: RIP: 0033:0x7ff146d3f517
> > > Feb 11 14:17:31  kernel: RSP: 002b:00007ffd4b5c1598 EFLAGS: 00000202
> > > ORIG_RAX: 00000000000000b0
> > > Feb 11 14:17:31  kernel: RAX: ffffffffffffffda RBX: 0000000000d78280
> > > RCX: 00007ff146d3f517
> > > Feb 11 14:17:31  kernel: RDX: 00007ff146db3ca0 RSI: 0000000000000800
> > > RDI: 0000000000d782e8
> > >
> > > On Tue, Feb 11, 2020 at 3:09 PM Frank Huang <tigerinxm@gmail.com> wrote:
> > > >
> > > > Hi, All
> > > >
> > > > When I use the old version of rdma_rxe (kernel 4.14.97), There is a
> > > > slab leak of qp, is it fixed in newest version? I found the commit
> > > > history on kernel.org, have not found same issue with it?
> > > >
> > > >
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > =============================================================================
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: BUG
> > > > rxe-qp (Tainted: G           OE  ): Objects remaining in rxe-qp on
> > > > __kmem_cache_shutdown()
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > -----------------------------------------------------------------------------
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Disabling
> > > > lock debugging due to kernel taint
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: INFO:
> > > > Slab 0xfffff4c4b027a000 objects=16 used=1 fp=0xffff96f3c9e83f00
> > > > flags=0x17ffffc0008100
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: CPU: 27
> > > > PID: 25588 Comm: rmmod Tainted: G    B      OE
> > > > 4.14.97-.el7.centos.x86_64 #1
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Hardware
> > > > name: 80010056, BIOS 4.1.15 03/28/2017
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Call Trace:
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > dump_stack+0x5a/0x7b
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  slab_err+0xb4/0xe0
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > > > calibrate_delay+0x138/0x5f0
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > > > on_each_cpu_mask+0x27/0x60
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > > > on_each_cpu_cond+0xaf/0x140
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > > > __kmalloc+0x179/0x200
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > > > __kmem_cache_shutdown+0x194/0x3d0
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > __kmem_cache_shutdown+0x1b4/0x3d0
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > shutdown_cache+0x13/0x1b0
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > kmem_cache_destroy+0x1e4/0x220
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > rxe_cache_clean+0x41/0x60 [rdma_rxe]
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > rxe_module_exit+0xf/0x68 [rdma_rxe]
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > SyS_delete_module+0x175/0x270
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > do_syscall_64+0x74/0x190
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RIP:
> > > > 0033:0x7ff146d3f517
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RSP:
> > > > 002b:00007ffd4b5c1598 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RAX:
> > > > ffffffffffffffda RBX: 0000000000d78280 RCX: 00007ff146d3f517
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RDX:
> > > > 00007ff146db3ca0 RSI: 0000000000000800 RDI: 0000000000d782e8
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RBP:
> > > > 0000000000000000 R08: 00007ff147008060 R09: 00007ff146db3ca0
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R10:
> > > > 00007ffd4b5c1020 R11: 0000000000000202 R12: 00007ffd4b5c36ca
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R13:
> > > > 0000000000000000 R14: 0000000000d78280 R15: 0000000000d78010
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: INFO:
> > > > Object 0xffff96f3c9e84ec0 @offset=20160
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > kmem_cache_destroy rxe-qp: Slab cache still has objects
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: CPU: 27
> > > > PID: 25588 Comm: rmmod Tainted: G    B      OE
> > > > 4.14.97-.el7.centos.x86_64 #1
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Hardware
> > > > name: 80010056, BIOS 4.1.15 03/28/2017
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Call Trace:
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > dump_stack+0x5a/0x7b
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > kmem_cache_destroy+0x203/0x220
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > rxe_cache_clean+0x41/0x60 [rdma_rxe]
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > rxe_module_exit+0xf/0x68 [rdma_rxe]
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > SyS_delete_module+0x175/0x270
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > do_syscall_64+0x74/0x190
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > > entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RIP:
> > > > 0033:0x7ff146d3f517
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RSP:
> > > > 002b:00007ffd4b5c1598 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RAX:
> > > > ffffffffffffffda RBX: 0000000000d78280 RCX: 00007ff146d3f517
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RDX:
> > > > 00007ff146db3ca0 RSI: 0000000000000800 RDI: 0000000000d782e8
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RBP:
> > > > 0000000000000000 R08: 00007ff147008060 R09: 00007ff146db3ca0
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R10:
> > > > 00007ffd4b5c1020 R11: 0000000000000202 R12: 00007ffd4b5c36ca
> > > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R13:
> > > > 0000000000000000 R14: 0000000000d78280 R15: 0000000000d78010
