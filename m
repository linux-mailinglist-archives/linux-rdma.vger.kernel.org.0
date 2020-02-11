Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE3F158A8C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 08:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBKHmJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 02:42:09 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33276 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgBKHmJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 02:42:09 -0500
Received: by mail-ua1-f65.google.com with SMTP id w15so3607613uap.0
        for <linux-rdma@vger.kernel.org>; Mon, 10 Feb 2020 23:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWQuKsWAUtYuWB0dDKIZbLAdnTYLI+LaA6HOcJp5sFQ=;
        b=eqGZ3VzqYBSYMngagncil2kEYS8cNHDB6RFSEJs+qIMFbQ8MuXZR2n0mCkx4jiszXj
         8Sjei+F3jpbk9jyUe/cW2O23hIlDN3OD+GqvI240SDDyLdAcOzxrqG2PmRGCgE2Tkz7M
         mV5LbfYbiccwgLIpiloiaUNLvKnOGUXaEYxR5RJGSwrNiQngPsIyXR8YL2BbKl1oWyBr
         voOHS8uMc01ThHHaUeE5R7VgYzdDXDEr/8htJpdeQCSLNMgZ5qO9Zjpe/gesXbFItZm6
         ivZo3Qf0kTMI1eoH4hU8EhAy3u1kBYvkMzSnFV6BloqaPlxM6kqmXSYL2jGlE3zvUh2Q
         0ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWQuKsWAUtYuWB0dDKIZbLAdnTYLI+LaA6HOcJp5sFQ=;
        b=Va3DMasfPJZLjFSqDPwBwWZCpgvr4RbX+5xCqbXs9115stU5fIQBldgq4jA7oDLt64
         uTCRBppScS1BtR4L7dGg7vP5gfqVPbYiE+5XL+JjHgq0q3XFaaJIrpX99Sr27SRRuQGh
         1uvpt6h2vw1vw8C8l/3mUoWzPi/WIvQ1vmC6k9VwpAEv+Cx1cT/LSDNg/XdntzE9IPsW
         ODhINRKNCCdVNKSI+lh9A2+RgYEG18SpsrF0xh6IzuerwZTsW7Y3WrV2MqaZ5XR4x0oW
         Q8KbeRjHWjkQ9Gu05hSgBeklEkEvM8+/hWN8tqInTdiMWN/Z75C+WdIB/RYSxSQL1fRK
         AnbQ==
X-Gm-Message-State: APjAAAX1Zu3uCNyt8f+YvFbRNNKmXqEWjYxSzFut+pXiujanAUM5jMdE
        p/vuv7VEp2KyJci9NFdxtTBU7hu8z2PWzu8eNpbqZA==
X-Google-Smtp-Source: APXvYqztXHLNOwPRoQng9CJgTS5BquoxTTgWeSQklhFvNytMH5iWnLHbATolFQB7CMFizvj/IyeBavs6GmD3bhcml4s=
X-Received: by 2002:ab0:3350:: with SMTP id h16mr940885uap.142.1581406926308;
 Mon, 10 Feb 2020 23:42:06 -0800 (PST)
MIME-Version: 1.0
References: <CAKC_zStdDH4my0gzfGhFc3zuWwGG1bW93Q+Bc-UF4csFacT5Hw@mail.gmail.com>
 <CAKC_zSvKE+tOYiODVmW=0=qd+HGGTEhREi3e4SOmK_Et_iVn8A@mail.gmail.com>
In-Reply-To: <CAKC_zSvKE+tOYiODVmW=0=qd+HGGTEhREi3e4SOmK_Et_iVn8A@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 11 Feb 2020 15:41:55 +0800
Message-ID: <CAD=hENf3RaNDaxi3qRCH499Q9WK6ZDoPBSCrh0ffES6f5UU=5Q@mail.gmail.com>
Subject: Re: slab leak on rxe
To:     Frank Huang <tigerinxm@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Can this bug be reproduced?

Zhu Yanjun

On Tue, Feb 11, 2020 at 3:32 PM Frank Huang <tigerinxm@gmail.com> wrote:
>
> Re-post the log , sorry for the format.
>
> Feb 11 14:17:31  kernel:
> =============================================================================
> Feb 11 14:17:31  kernel: BUG rxe-qp (Tainted: G           OE  ):
> Objects remaining in rxe-qp on __kmem_cache_shutdown()
> Feb 11 14:17:31  kernel:
> -----------------------------------------------------------------------------
> Feb 11 14:17:31  kernel: Disabling lock debugging due to kernel taint
> Feb 11 14:17:31  kernel: INFO: Slab 0xfffff4c4b027a000 objects=16
> used=1 fp=0xffff96f3c9e83f00 flags=0x17ffffc0008100
> Feb 11 14:17:31  kernel: CPU: 27 PID: 25588 Comm: rmmod Tainted: G
> B      OE   4.14.97-.el7.centos.x86_64 #1
> Feb 11 14:17:31  kernel: Hardware name: /80010056, BIOS 4.1.15 03/28/2017
> Feb 11 14:17:31  kernel: Call Trace:
> Feb 11 14:17:31  kernel:  dump_stack+0x5a/0x7b
> Feb 11 14:17:31  kernel:  slab_err+0xb4/0xe0
> Feb 11 14:17:31  kernel:  ? calibrate_delay+0x138/0x5f0
> Feb 11 14:17:31  kernel:  ? on_each_cpu_mask+0x27/0x60
> Feb 11 14:17:31  kernel:  ? on_each_cpu_cond+0xaf/0x140
> Feb 11 14:17:31  kernel:  ? __kmalloc+0x179/0x200
> Feb 11 14:17:31  kernel:  ? __kmem_cache_shutdown+0x194/0x3d0
> Feb 11 14:17:31  kernel:  __kmem_cache_shutdown+0x1b4/0x3d0
> Feb 11 14:17:31  kernel:  shutdown_cache+0x13/0x1b0
> Feb 11 14:17:31  kernel:  kmem_cache_destroy+0x1e4/0x220
> Feb 11 14:17:31  kernel:  rxe_cache_clean+0x41/0x60 [rdma_rxe]
> Feb 11 14:17:31  kernel:  rxe_module_exit+0xf/0x68 [rdma_rxe]
> Feb 11 14:17:31  kernel:  SyS_delete_module+0x175/0x270
> Feb 11 14:17:31  kernel:  do_syscall_64+0x74/0x190
> Feb 11 14:17:31  kernel:  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> Feb 11 14:17:31  kernel: RIP: 0033:0x7ff146d3f517
> Feb 11 14:17:31  kernel: RSP: 002b:00007ffd4b5c1598 EFLAGS: 00000202
> ORIG_RAX: 00000000000000b0
> Feb 11 14:17:31  kernel: RAX: ffffffffffffffda RBX: 0000000000d78280
> RCX: 00007ff146d3f517
> Feb 11 14:17:31  kernel: RDX: 00007ff146db3ca0 RSI: 0000000000000800
> RDI: 0000000000d782e8
> Feb 11 14:17:31  kernel: RBP: 0000000000000000 R08: 00007ff147008060
> R09: 00007ff146db3ca0
> Feb 11 14:17:31  kernel: R10: 00007ffd4b5c1020 R11: 0000000000000202
> R12: 00007ffd4b5c36ca
> Feb 11 14:17:31  kernel: R13: 0000000000000000 R14: 0000000000d78280
> R15: 0000000000d78010
> Feb 11 14:17:31  kernel: INFO: Object 0xffff96f3c9e84ec0 @offset=20160
> Feb 11 14:17:31  kernel: kmem_cache_destroy rxe-qp: Slab cache still has objects
> Feb 11 14:17:31  kernel: CPU: 27 PID: 25588 Comm: rmmod Tainted: G
> B      OE   4.14.97-.el7.centos.x86_64 #1
> Feb 11 14:17:31  kernel: Hardware name: /80010056, BIOS 4.1.15 03/28/2017
> Feb 11 14:17:31  kernel: Call Trace:
> Feb 11 14:17:31  kernel:  dump_stack+0x5a/0x7b
> Feb 11 14:17:31  kernel:  kmem_cache_destroy+0x203/0x220
> Feb 11 14:17:31  kernel:  rxe_cache_clean+0x41/0x60 [rdma_rxe]
> Feb 11 14:17:31  kernel:  rxe_module_exit+0xf/0x68 [rdma_rxe]
> Feb 11 14:17:31  kernel:  SyS_delete_module+0x175/0x270
> Feb 11 14:17:31  kernel:  do_syscall_64+0x74/0x190
> Feb 11 14:17:31  kernel:  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> Feb 11 14:17:31  kernel: RIP: 0033:0x7ff146d3f517
> Feb 11 14:17:31  kernel: RSP: 002b:00007ffd4b5c1598 EFLAGS: 00000202
> ORIG_RAX: 00000000000000b0
> Feb 11 14:17:31  kernel: RAX: ffffffffffffffda RBX: 0000000000d78280
> RCX: 00007ff146d3f517
> Feb 11 14:17:31  kernel: RDX: 00007ff146db3ca0 RSI: 0000000000000800
> RDI: 0000000000d782e8
>
> On Tue, Feb 11, 2020 at 3:09 PM Frank Huang <tigerinxm@gmail.com> wrote:
> >
> > Hi, All
> >
> > When I use the old version of rdma_rxe (kernel 4.14.97), There is a
> > slab leak of qp, is it fixed in newest version? I found the commit
> > history on kernel.org, have not found same issue with it?
> >
> >
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > =============================================================================
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: BUG
> > rxe-qp (Tainted: G           OE  ): Objects remaining in rxe-qp on
> > __kmem_cache_shutdown()
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > -----------------------------------------------------------------------------
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Disabling
> > lock debugging due to kernel taint
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: INFO:
> > Slab 0xfffff4c4b027a000 objects=16 used=1 fp=0xffff96f3c9e83f00
> > flags=0x17ffffc0008100
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: CPU: 27
> > PID: 25588 Comm: rmmod Tainted: G    B      OE
> > 4.14.97-.el7.centos.x86_64 #1
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Hardware
> > name: 80010056, BIOS 4.1.15 03/28/2017
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Call Trace:
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > dump_stack+0x5a/0x7b
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  slab_err+0xb4/0xe0
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > calibrate_delay+0x138/0x5f0
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > on_each_cpu_mask+0x27/0x60
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > on_each_cpu_cond+0xaf/0x140
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > __kmalloc+0x179/0x200
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
> > __kmem_cache_shutdown+0x194/0x3d0
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > __kmem_cache_shutdown+0x1b4/0x3d0
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > shutdown_cache+0x13/0x1b0
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > kmem_cache_destroy+0x1e4/0x220
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > rxe_cache_clean+0x41/0x60 [rdma_rxe]
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > rxe_module_exit+0xf/0x68 [rdma_rxe]
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > SyS_delete_module+0x175/0x270
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > do_syscall_64+0x74/0x190
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RIP:
> > 0033:0x7ff146d3f517
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RSP:
> > 002b:00007ffd4b5c1598 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RAX:
> > ffffffffffffffda RBX: 0000000000d78280 RCX: 00007ff146d3f517
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RDX:
> > 00007ff146db3ca0 RSI: 0000000000000800 RDI: 0000000000d782e8
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RBP:
> > 0000000000000000 R08: 00007ff147008060 R09: 00007ff146db3ca0
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R10:
> > 00007ffd4b5c1020 R11: 0000000000000202 R12: 00007ffd4b5c36ca
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R13:
> > 0000000000000000 R14: 0000000000d78280 R15: 0000000000d78010
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: INFO:
> > Object 0xffff96f3c9e84ec0 @offset=20160
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > kmem_cache_destroy rxe-qp: Slab cache still has objects
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: CPU: 27
> > PID: 25588 Comm: rmmod Tainted: G    B      OE
> > 4.14.97-.el7.centos.x86_64 #1
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Hardware
> > name: 80010056, BIOS 4.1.15 03/28/2017
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Call Trace:
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > dump_stack+0x5a/0x7b
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > kmem_cache_destroy+0x203/0x220
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > rxe_cache_clean+0x41/0x60 [rdma_rxe]
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > rxe_module_exit+0xf/0x68 [rdma_rxe]
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > SyS_delete_module+0x175/0x270
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > do_syscall_64+0x74/0x190
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
> > entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RIP:
> > 0033:0x7ff146d3f517
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RSP:
> > 002b:00007ffd4b5c1598 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RAX:
> > ffffffffffffffda RBX: 0000000000d78280 RCX: 00007ff146d3f517
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RDX:
> > 00007ff146db3ca0 RSI: 0000000000000800 RDI: 0000000000d782e8
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RBP:
> > 0000000000000000 R08: 00007ff147008060 R09: 00007ff146db3ca0
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R10:
> > 00007ffd4b5c1020 R11: 0000000000000202 R12: 00007ffd4b5c36ca
> > Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R13:
> > 0000000000000000 R14: 0000000000d78280 R15: 0000000000d78010
