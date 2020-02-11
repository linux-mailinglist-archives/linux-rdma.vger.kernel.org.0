Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0946158A41
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 08:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgBKHRy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 02:17:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43177 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbgBKHRy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 02:17:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so10298554ljm.10
        for <linux-rdma@vger.kernel.org>; Mon, 10 Feb 2020 23:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=u5W6LT0SIlofUaog6dAvPn4FyJafg8FTNV4xBZSKseM=;
        b=aRMopRvKClDHEcEUhV/E9jZRgJ0HlOsCFP8Q72HddJzKp3meXbtfXAU8XtVe1sHDRH
         2Z1kqyVR2rvV06viLYEFcoXwC0ivkDv1GJVlNMZ1d2UoTZ7jnRSIt40uDJfXDJoulyh9
         Tqq6WmP7QTVLW0H17EKj+wnmE/oVb+zDOCFh12Y1OWoeE+1rwZuDZUBwNJ4yeafU3Y3s
         oBwoE6ae+8EBowGXAB4CPB5gcjee5z4aMVaStlCIK9rbWMdJ7m1J042VPZxmutfk8uec
         E/hbhTFd3jbjAvohzbtqk8+3dn+3gvR7Wqdo7Gd9PSEXxu5SqHpjDlAc5xq3Om4yt+vl
         VdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=u5W6LT0SIlofUaog6dAvPn4FyJafg8FTNV4xBZSKseM=;
        b=XIG/Ag9zutZ1XDWR11QYXpgWfyU9EFyCB0fRxNoUtCOYD5vYfc63sgPfEOHi62VhU2
         8X7DRaQIJQ2MkQu3ib1LZBKDKqkuGGUADymrVXGdxyjVxYBM/6KxN0TYopPRHOcjIaj/
         d2xtj0YqWG7GlgcCfM/C5ECEycLQ3mRjnL31wLLVVjvYmx/0lpeNUuZX0P9dcoL3+qlO
         rEUG5ah4ZNMfW1tM2H++MAKfkfeT7SAfpvwOw2+Tc0IOW4m5pB+wDveV8uarnfQtAKfo
         TdFnVxS6VY4WPxv6wmGRpPYHJDl6kxFftjTPjkxvs3+Uu76s2oGqajYf5W8LoGT+/0v4
         2CmA==
X-Gm-Message-State: APjAAAXRs8TS0J9eHy1ezKuRnCwaa2p2eWafy1mWuRWNucVa1A66YJXX
        oUINqYzu4AF5djd4o0WHtazC9/4ksS14gP+qLd+6so6WwFI=
X-Google-Smtp-Source: APXvYqx3W2jUwovgd3JzD+f7Fzaa11XVkU2TH5UVnQSa/p0UWTcBDITp846Ap6XT0RoC4BjZf9dPIIWq4AYWsV+vc2E=
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr3366752ljk.201.1581405469759;
 Mon, 10 Feb 2020 23:17:49 -0800 (PST)
MIME-Version: 1.0
References: <CAKC_zStdDH4my0gzfGhFc3zuWwGG1bW93Q+Bc-UF4csFacT5Hw@mail.gmail.com>
In-Reply-To: <CAKC_zStdDH4my0gzfGhFc3zuWwGG1bW93Q+Bc-UF4csFacT5Hw@mail.gmail.com>
From:   Frank Huang <tigerinxm@gmail.com>
Date:   Tue, 11 Feb 2020 15:17:38 +0800
Message-ID: <CAKC_zSvKE+tOYiODVmW=0=qd+HGGTEhREi3e4SOmK_Et_iVn8A@mail.gmail.com>
Subject: Re: slab leak on rxe
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Re-post the log , sorry for the format.

Feb 11 14:17:31  kernel:
=============================================================================
Feb 11 14:17:31  kernel: BUG rxe-qp (Tainted: G           OE  ):
Objects remaining in rxe-qp on __kmem_cache_shutdown()
Feb 11 14:17:31  kernel:
-----------------------------------------------------------------------------
Feb 11 14:17:31  kernel: Disabling lock debugging due to kernel taint
Feb 11 14:17:31  kernel: INFO: Slab 0xfffff4c4b027a000 objects=16
used=1 fp=0xffff96f3c9e83f00 flags=0x17ffffc0008100
Feb 11 14:17:31  kernel: CPU: 27 PID: 25588 Comm: rmmod Tainted: G
B      OE   4.14.97-.el7.centos.x86_64 #1
Feb 11 14:17:31  kernel: Hardware name: /80010056, BIOS 4.1.15 03/28/2017
Feb 11 14:17:31  kernel: Call Trace:
Feb 11 14:17:31  kernel:  dump_stack+0x5a/0x7b
Feb 11 14:17:31  kernel:  slab_err+0xb4/0xe0
Feb 11 14:17:31  kernel:  ? calibrate_delay+0x138/0x5f0
Feb 11 14:17:31  kernel:  ? on_each_cpu_mask+0x27/0x60
Feb 11 14:17:31  kernel:  ? on_each_cpu_cond+0xaf/0x140
Feb 11 14:17:31  kernel:  ? __kmalloc+0x179/0x200
Feb 11 14:17:31  kernel:  ? __kmem_cache_shutdown+0x194/0x3d0
Feb 11 14:17:31  kernel:  __kmem_cache_shutdown+0x1b4/0x3d0
Feb 11 14:17:31  kernel:  shutdown_cache+0x13/0x1b0
Feb 11 14:17:31  kernel:  kmem_cache_destroy+0x1e4/0x220
Feb 11 14:17:31  kernel:  rxe_cache_clean+0x41/0x60 [rdma_rxe]
Feb 11 14:17:31  kernel:  rxe_module_exit+0xf/0x68 [rdma_rxe]
Feb 11 14:17:31  kernel:  SyS_delete_module+0x175/0x270
Feb 11 14:17:31  kernel:  do_syscall_64+0x74/0x190
Feb 11 14:17:31  kernel:  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
Feb 11 14:17:31  kernel: RIP: 0033:0x7ff146d3f517
Feb 11 14:17:31  kernel: RSP: 002b:00007ffd4b5c1598 EFLAGS: 00000202
ORIG_RAX: 00000000000000b0
Feb 11 14:17:31  kernel: RAX: ffffffffffffffda RBX: 0000000000d78280
RCX: 00007ff146d3f517
Feb 11 14:17:31  kernel: RDX: 00007ff146db3ca0 RSI: 0000000000000800
RDI: 0000000000d782e8
Feb 11 14:17:31  kernel: RBP: 0000000000000000 R08: 00007ff147008060
R09: 00007ff146db3ca0
Feb 11 14:17:31  kernel: R10: 00007ffd4b5c1020 R11: 0000000000000202
R12: 00007ffd4b5c36ca
Feb 11 14:17:31  kernel: R13: 0000000000000000 R14: 0000000000d78280
R15: 0000000000d78010
Feb 11 14:17:31  kernel: INFO: Object 0xffff96f3c9e84ec0 @offset=20160
Feb 11 14:17:31  kernel: kmem_cache_destroy rxe-qp: Slab cache still has objects
Feb 11 14:17:31  kernel: CPU: 27 PID: 25588 Comm: rmmod Tainted: G
B      OE   4.14.97-.el7.centos.x86_64 #1
Feb 11 14:17:31  kernel: Hardware name: /80010056, BIOS 4.1.15 03/28/2017
Feb 11 14:17:31  kernel: Call Trace:
Feb 11 14:17:31  kernel:  dump_stack+0x5a/0x7b
Feb 11 14:17:31  kernel:  kmem_cache_destroy+0x203/0x220
Feb 11 14:17:31  kernel:  rxe_cache_clean+0x41/0x60 [rdma_rxe]
Feb 11 14:17:31  kernel:  rxe_module_exit+0xf/0x68 [rdma_rxe]
Feb 11 14:17:31  kernel:  SyS_delete_module+0x175/0x270
Feb 11 14:17:31  kernel:  do_syscall_64+0x74/0x190
Feb 11 14:17:31  kernel:  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
Feb 11 14:17:31  kernel: RIP: 0033:0x7ff146d3f517
Feb 11 14:17:31  kernel: RSP: 002b:00007ffd4b5c1598 EFLAGS: 00000202
ORIG_RAX: 00000000000000b0
Feb 11 14:17:31  kernel: RAX: ffffffffffffffda RBX: 0000000000d78280
RCX: 00007ff146d3f517
Feb 11 14:17:31  kernel: RDX: 00007ff146db3ca0 RSI: 0000000000000800
RDI: 0000000000d782e8

On Tue, Feb 11, 2020 at 3:09 PM Frank Huang <tigerinxm@gmail.com> wrote:
>
> Hi, All
>
> When I use the old version of rdma_rxe (kernel 4.14.97), There is a
> slab leak of qp, is it fixed in newest version? I found the commit
> history on kernel.org, have not found same issue with it?
>
>
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> =============================================================================
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: BUG
> rxe-qp (Tainted: G           OE  ): Objects remaining in rxe-qp on
> __kmem_cache_shutdown()
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> -----------------------------------------------------------------------------
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Disabling
> lock debugging due to kernel taint
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: INFO:
> Slab 0xfffff4c4b027a000 objects=16 used=1 fp=0xffff96f3c9e83f00
> flags=0x17ffffc0008100
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: CPU: 27
> PID: 25588 Comm: rmmod Tainted: G    B      OE
> 4.14.97-.el7.centos.x86_64 #1
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Hardware
> name: 80010056, BIOS 4.1.15 03/28/2017
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Call Trace:
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> dump_stack+0x5a/0x7b
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  slab_err+0xb4/0xe0
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> calibrate_delay+0x138/0x5f0
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> on_each_cpu_mask+0x27/0x60
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> on_each_cpu_cond+0xaf/0x140
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> __kmalloc+0x179/0x200
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> __kmem_cache_shutdown+0x194/0x3d0
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> __kmem_cache_shutdown+0x1b4/0x3d0
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> shutdown_cache+0x13/0x1b0
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> kmem_cache_destroy+0x1e4/0x220
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> rxe_cache_clean+0x41/0x60 [rdma_rxe]
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> rxe_module_exit+0xf/0x68 [rdma_rxe]
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> SyS_delete_module+0x175/0x270
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> do_syscall_64+0x74/0x190
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RIP:
> 0033:0x7ff146d3f517
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RSP:
> 002b:00007ffd4b5c1598 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RAX:
> ffffffffffffffda RBX: 0000000000d78280 RCX: 00007ff146d3f517
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RDX:
> 00007ff146db3ca0 RSI: 0000000000000800 RDI: 0000000000d782e8
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RBP:
> 0000000000000000 R08: 00007ff147008060 R09: 00007ff146db3ca0
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R10:
> 00007ffd4b5c1020 R11: 0000000000000202 R12: 00007ffd4b5c36ca
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R13:
> 0000000000000000 R14: 0000000000d78280 R15: 0000000000d78010
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: INFO:
> Object 0xffff96f3c9e84ec0 @offset=20160
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> kmem_cache_destroy rxe-qp: Slab cache still has objects
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: CPU: 27
> PID: 25588 Comm: rmmod Tainted: G    B      OE
> 4.14.97-.el7.centos.x86_64 #1
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Hardware
> name: 80010056, BIOS 4.1.15 03/28/2017
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Call Trace:
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> dump_stack+0x5a/0x7b
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> kmem_cache_destroy+0x203/0x220
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> rxe_cache_clean+0x41/0x60 [rdma_rxe]
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> rxe_module_exit+0xf/0x68 [rdma_rxe]
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> SyS_delete_module+0x175/0x270
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> do_syscall_64+0x74/0x190
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RIP:
> 0033:0x7ff146d3f517
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RSP:
> 002b:00007ffd4b5c1598 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RAX:
> ffffffffffffffda RBX: 0000000000d78280 RCX: 00007ff146d3f517
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RDX:
> 00007ff146db3ca0 RSI: 0000000000000800 RDI: 0000000000d782e8
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RBP:
> 0000000000000000 R08: 00007ff147008060 R09: 00007ff146db3ca0
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R10:
> 00007ffd4b5c1020 R11: 0000000000000202 R12: 00007ffd4b5c36ca
> Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R13:
> 0000000000000000 R14: 0000000000d78280 R15: 0000000000d78010
