Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E87158B44
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 09:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgBKIdT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 03:33:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46729 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgBKIdT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 03:33:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id z26so6316267lfg.13
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2020 00:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZoY3Hsdgrv3CmxwLhGMdakKrkjLfqAG6LQwKXCGH2As=;
        b=m9JU4UkFkuD4pnHDaauVmJ9fI6OT40DrNwfgzJCZ4d+eg+JmvW/G4qTlNJ417JVgga
         GWPTJc+cIsZ4QFF4ITl8k77VII5E6LBD6n9Qc158yU6vILonNeQUrlIUHsW/4x2ovp3U
         0HEUH4QnhT0qlm4XM+LHzoFBMIGJxYmKjPx5e+31eWzxhSipORcOjPkl4d/H4Il7jZCS
         /2yErFu9kyNHoh3KOrZVQwnzVNr1lual5/79axw+yErENGlEOJfVQb+9qeA0lNv6eP0S
         7Cts2CH3FrPvVj5dwybdlvJ/EgufSRntTL9w1rH34Gkz10mhFKRf9XOk3hLmJm0OwG4w
         D2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZoY3Hsdgrv3CmxwLhGMdakKrkjLfqAG6LQwKXCGH2As=;
        b=EBJjoPD25OZxgxzt5mr+3+qgRQBfcRAV+Tk9IwROcGySOkDHHZg64vI5Yno7ge5ZFV
         xajKnzwkkTKUqRCp/wDc2+VuJ2JFlEIn4y2gWjJvMpoajURcLhYzXmMqP8xsG3u7VMex
         Bt+6cBquxseUYIwJ8Y9hAVSrdvvBY3mMiUriksdd5VnhLU5dZbGzvmUlUqMFUamEImZF
         bYpzpVc16eG9/XM5eTYBFrSPAkSU23/fiR+rOOkG5VKFew2BIHby0OryN7X2CYZBGbzq
         u0HlCr13GRaNGWiABmJQnBxb5nq/haUlue/IX5IFsHxhc2Okl7EwL6h6shwwawM+RtTD
         XA3g==
X-Gm-Message-State: APjAAAUzfmW4nykZIwem7ZQl1CdsSi7twvc7FN1Bi7pL2+9iC+VpWmYn
        g7q0PAtAM/SyRvbUhLipGxwapOEalOdmnMENgoahDw9OOeo=
X-Google-Smtp-Source: APXvYqxZMTUzPj/Lfmtl+NcwpocRECuPIxguwQA6UeO2abJJ5359qgfKt8RSdQAremoJOPOi4Mip8qm8xl0U7biOPEc=
X-Received: by 2002:a19:7515:: with SMTP id y21mr2971523lfe.45.1581409994744;
 Tue, 11 Feb 2020 00:33:14 -0800 (PST)
MIME-Version: 1.0
References: <CAKC_zStdDH4my0gzfGhFc3zuWwGG1bW93Q+Bc-UF4csFacT5Hw@mail.gmail.com>
 <CAKC_zSvKE+tOYiODVmW=0=qd+HGGTEhREi3e4SOmK_Et_iVn8A@mail.gmail.com> <CAD=hENf3RaNDaxi3qRCH499Q9WK6ZDoPBSCrh0ffES6f5UU=5Q@mail.gmail.com>
In-Reply-To: <CAD=hENf3RaNDaxi3qRCH499Q9WK6ZDoPBSCrh0ffES6f5UU=5Q@mail.gmail.com>
From:   Frank Huang <tigerinxm@gmail.com>
Date:   Tue, 11 Feb 2020 16:33:03 +0800
Message-ID: <CAKC_zSuwGKEc1za4gvUze41nyKzemwHSV-m_um3MkxwKQw=w1g@mail.gmail.com>
Subject: Re: slab leak on rxe
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the first time I meet this bug, haven't found the bug trigger yet.

We will kill the process in some situation using kill -9. Would it cause that?

Before this happens, there are some error report:

Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5
Feb 11 04:24:55  kernel: rdma_rxe: no qp matches qpn 0x31f5

On Tue, Feb 11, 2020 at 3:42 PM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> Can this bug be reproduced?
>
> Zhu Yanjun
>
> On Tue, Feb 11, 2020 at 3:32 PM Frank Huang <tigerinxm@gmail.com> wrote:
> >
> > Re-post the log , sorry for the format.
> >
> > Feb 11 14:17:31  kernel:
> > =============================================================================
> > Feb 11 14:17:31  kernel: BUG rxe-qp (Tainted: G           OE  ):
> > Objects remaining in rxe-qp on __kmem_cache_shutdown()
> > Feb 11 14:17:31  kernel:
> > -----------------------------------------------------------------------------
> > Feb 11 14:17:31  kernel: Disabling lock debugging due to kernel taint
> > Feb 11 14:17:31  kernel: INFO: Slab 0xfffff4c4b027a000 objects=16
> > used=1 fp=0xffff96f3c9e83f00 flags=0x17ffffc0008100
> > Feb 11 14:17:31  kernel: CPU: 27 PID: 25588 Comm: rmmod Tainted: G
> > B      OE   4.14.97-.el7.centos.x86_64 #1
> > Feb 11 14:17:31  kernel: Hardware name: /80010056, BIOS 4.1.15 03/28/2017
> > Feb 11 14:17:31  kernel: Call Trace:
> > Feb 11 14:17:31  kernel:  dump_stack+0x5a/0x7b
> > Feb 11 14:17:31  kernel:  slab_err+0xb4/0xe0
> > Feb 11 14:17:31  kernel:  ? calibrate_delay+0x138/0x5f0
> > Feb 11 14:17:31  kernel:  ? on_each_cpu_mask+0x27/0x60
> > Feb 11 14:17:31  kernel:  ? on_each_cpu_cond+0xaf/0x140
> > Feb 11 14:17:31  kernel:  ? __kmalloc+0x179/0x200
> > Feb 11 14:17:31  kernel:  ? __kmem_cache_shutdown+0x194/0x3d0
> > Feb 11 14:17:31  kernel:  __kmem_cache_shutdown+0x1b4/0x3d0
> > Feb 11 14:17:31  kernel:  shutdown_cache+0x13/0x1b0
> > Feb 11 14:17:31  kernel:  kmem_cache_destroy+0x1e4/0x220
> > Feb 11 14:17:31  kernel:  rxe_cache_clean+0x41/0x60 [rdma_rxe]
> > Feb 11 14:17:31  kernel:  rxe_module_exit+0xf/0x68 [rdma_rxe]
> > Feb 11 14:17:31  kernel:  SyS_delete_module+0x175/0x270
> > Feb 11 14:17:31  kernel:  do_syscall_64+0x74/0x190
> > Feb 11 14:17:31  kernel:  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> > Feb 11 14:17:31  kernel: RIP: 0033:0x7ff146d3f517
> > Feb 11 14:17:31  kernel: RSP: 002b:00007ffd4b5c1598 EFLAGS: 00000202
> > ORIG_RAX: 00000000000000b0
> > Feb 11 14:17:31  kernel: RAX: ffffffffffffffda RBX: 0000000000d78280
> > RCX: 00007ff146d3f517
> > Feb 11 14:17:31  kernel: RDX: 00007ff146db3ca0 RSI: 0000000000000800
> > RDI: 0000000000d782e8
> > Feb 11 14:17:31  kernel: RBP: 0000000000000000 R08: 00007ff147008060
> > R09: 00007ff146db3ca0
> > Feb 11 14:17:31  kernel: R10: 00007ffd4b5c1020 R11: 0000000000000202
> > R12: 00007ffd4b5c36ca
> > Feb 11 14:17:31  kernel: R13: 0000000000000000 R14: 0000000000d78280
> > R15: 0000000000d78010
> > Feb 11 14:17:31  kernel: INFO: Object 0xffff96f3c9e84ec0 @offset=20160
> > Feb 11 14:17:31  kernel: kmem_cache_destroy rxe-qp: Slab cache still has objects
> > Feb 11 14:17:31  kernel: CPU: 27 PID: 25588 Comm: rmmod Tainted: G
> > B      OE   4.14.97-.el7.centos.x86_64 #1
> > Feb 11 14:17:31  kernel: Hardware name: /80010056, BIOS 4.1.15 03/28/2017
> > Feb 11 14:17:31  kernel: Call Trace:
> > Feb 11 14:17:31  kernel:  dump_stack+0x5a/0x7b
> > Feb 11 14:17:31  kernel:  kmem_cache_destroy+0x203/0x220
> > Feb 11 14:17:31  kernel:  rxe_cache_clean+0x41/0x60 [rdma_rxe]
> > Feb 11 14:17:31  kernel:  rxe_module_exit+0xf/0x68 [rdma_rxe]
> > Feb 11 14:17:31  kernel:  SyS_delete_module+0x175/0x270
> > Feb 11 14:17:31  kernel:  do_syscall_64+0x74/0x190
> > Feb 11 14:17:31  kernel:  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> > Feb 11 14:17:31  kernel: RIP: 0033:0x7ff146d3f517
> > Feb 11 14:17:31  kernel: RSP: 002b:00007ffd4b5c1598 EFLAGS: 00000202
> > ORIG_RAX: 00000000000000b0
> > Feb 11 14:17:31  kernel: RAX: ffffffffffffffda RBX: 0000000000d78280
> > RCX: 00007ff146d3f517
> > Feb 11 14:17:31  kernel: RDX: 00007ff146db3ca0 RSI: 0000000000000800
> > RDI: 0000000000d782e8
> >
> > On Tue, Feb 11, 2020 at 3:09 PM Frank Huang <tigerinxm@gmail.com> wrote:
> > >
> > > Hi, All
> > >
> > > When I use the old version of rdma_rxe (kernel 4.14.97), There is a
> > > slab leak of qp, is it fixed in newest version? I found the commit
> > > history on kernel.org, have not found same issue with it?
> > >
> > >
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > =============================================================================
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: BUG
> > > rxe-qp (Tainted: G           OE  ): Objects remaining in rxe-qp on
> > > __kmem_cache_shutdown()
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > -----------------------------------------------------------------------------
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Disabling
> > > lock debugging due to kernel taint
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: INFO:
> > > Slab 0xfffff4c4b027a000 objects=16 used=1 fp=0xffff96f3c9e83f00
> > > flags=0x17ffffc0008100
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: CPU: 27
> > > PID: 25588 Comm: rmmod Tainted: G    B      OE
> > > 4.14.97-.el7.centos.x86_64 #1
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Hardware
> > > name: 80010056, BIOS 4.1.15 03/28/2017
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Call Trace:
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > dump_stack+0x5a/0x7b
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  slab_err+0xb4/0xe0
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > > calibrate_delay+0x138/0x5f0
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > > on_each_cpu_mask+0x27/0x60
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > > on_each_cpu_cond+0xaf/0x140
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > > __kmalloc+0x179/0x200
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > > __kmem_cache_shutdown+0x194/0x3d0
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > __kmem_cache_shutdown+0x1b4/0x3d0
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > shutdown_cache+0x13/0x1b0
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > kmem_cache_destroy+0x1e4/0x220
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > rxe_cache_clean+0x41/0x60 [rdma_rxe]
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > rxe_module_exit+0xf/0x68 [rdma_rxe]
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > SyS_delete_module+0x175/0x270
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > do_syscall_64+0x74/0x190
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RIP:
> > > 0033:0x7ff146d3f517
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RSP:
> > > 002b:00007ffd4b5c1598 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RAX:
> > > ffffffffffffffda RBX: 0000000000d78280 RCX: 00007ff146d3f517
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RDX:
> > > 00007ff146db3ca0 RSI: 0000000000000800 RDI: 0000000000d782e8
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RBP:
> > > 0000000000000000 R08: 00007ff147008060 R09: 00007ff146db3ca0
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R10:
> > > 00007ffd4b5c1020 R11: 0000000000000202 R12: 00007ffd4b5c36ca
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R13:
> > > 0000000000000000 R14: 0000000000d78280 R15: 0000000000d78010
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: INFO:
> > > Object 0xffff96f3c9e84ec0 @offset=20160
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > kmem_cache_destroy rxe-qp: Slab cache still has objects
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: CPU: 27
> > > PID: 25588 Comm: rmmod Tainted: G    B      OE
> > > 4.14.97-.el7.centos.x86_64 #1
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Hardware
> > > name: 80010056, BIOS 4.1.15 03/28/2017
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Call Trace:
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > dump_stack+0x5a/0x7b
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > kmem_cache_destroy+0x203/0x220
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > rxe_cache_clean+0x41/0x60 [rdma_rxe]
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > rxe_module_exit+0xf/0x68 [rdma_rxe]
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > SyS_delete_module+0x175/0x270
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > do_syscall_64+0x74/0x190
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > > entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RIP:
> > > 0033:0x7ff146d3f517
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RSP:
> > > 002b:00007ffd4b5c1598 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RAX:
> > > ffffffffffffffda RBX: 0000000000d78280 RCX: 00007ff146d3f517
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RDX:
> > > 00007ff146db3ca0 RSI: 0000000000000800 RDI: 0000000000d782e8
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RBP:
> > > 0000000000000000 R08: 00007ff147008060 R09: 00007ff146db3ca0
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R10:
> > > 00007ffd4b5c1020 R11: 0000000000000202 R12: 00007ffd4b5c36ca
> > > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R13:
> > > 0000000000000000 R14: 0000000000d78280 R15: 0000000000d78010
