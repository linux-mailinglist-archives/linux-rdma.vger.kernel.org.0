Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D66B9158A37
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 08:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBKHJt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 02:09:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42390 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbgBKHJt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 02:09:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id d10so10290519ljl.9
        for <linux-rdma@vger.kernel.org>; Mon, 10 Feb 2020 23:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aDl2jIZrlfmIMc8ELHUrWCpUIzvcBaftWl90I6Vd5uA=;
        b=NdM2kdJ9siQ+wmZAzHWDjihLX3uQPzdwfH8op7arPAggzc2CO0Jd8n9ddzqsAjgvhV
         bS5Wmd68vX6p4ybLdvW72WuKX4gKAketG0sqednAuPDK0w+wEjwXN2oMozR6hXrjnGuQ
         ztp92xbMDLsUQZF6QGqCvnbnkQ0j2TVhCeRVwDYzloqlGhpT+mNg3yf+XF4egTieVjRQ
         CrN8DgUruSmM7yy178dE8iqJWzfj6J5dOH8sOVe6i9wNdfuYDtNr7goLHI5pOvPLG64Y
         Rb2x9DEVLLb61B6M3dCDOPNTX6RyNtdSqLQx42pG+eQeI4Se5NXAlKtIa78d1a1yH8RC
         MUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aDl2jIZrlfmIMc8ELHUrWCpUIzvcBaftWl90I6Vd5uA=;
        b=W3qvyS65d3HCJmqH/MA8FgLcbrRzOvY88FHePYII3FIAfkEl3YK6N0MW8WniXRa9Tl
         29cwH4zlWiSkpHoEk8kKC6gTmBWbqmIXeHN51in3TwB6EGgOZW3vA1tqJQLe23BMYIut
         6Bu/QOyM87cK/wVlHntSY3xH96HS9YPwfe+CP4ydRql7GzxWcsTJdUTBxebBUsvbt9VN
         YPlG76BLPZQwdiAuBGqBltZzTu57p9WqufKNMAraqnndFEDvaZmlhoDBMQahbBsL32xK
         1KTXuAjed0HcoDS9Yo4NxwfoazFXRlTRdQY6avg5xd1URfMChjEOS1X57Jtjj61+FJu4
         iKRA==
X-Gm-Message-State: APjAAAVvgltGZd0PIwOAF2qepiN+5v7Lk1jK1oegWIdOSQ6FruvcaHhj
        zxaA8sCJfrl3Qu/USf7zo7nsabaCEmE7+4XbL54nrkKvsXY=
X-Google-Smtp-Source: APXvYqylDoqKllg6VVB9rVGn7aEwb2Rr+tqwEUY4LfvoWNapt7XPbCm0C+myfthi9cOCKAmErMw3G3xeTQ3bp3h342M=
X-Received: by 2002:a2e:b536:: with SMTP id z22mr3214387ljm.259.1581404986182;
 Mon, 10 Feb 2020 23:09:46 -0800 (PST)
MIME-Version: 1.0
From:   Frank Huang <tigerinxm@gmail.com>
Date:   Tue, 11 Feb 2020 15:09:34 +0800
Message-ID: <CAKC_zStdDH4my0gzfGhFc3zuWwGG1bW93Q+Bc-UF4csFacT5Hw@mail.gmail.com>
Subject: slab leak on rxe
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, All

When I use the old version of rdma_rxe (kernel 4.14.97), There is a
slab leak of qp, is it fixed in newest version? I found the commit
history on kernel.org, have not found same issue with it?


Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
=============================================================================
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: BUG
rxe-qp (Tainted: G           OE  ): Objects remaining in rxe-qp on
__kmem_cache_shutdown()
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
-----------------------------------------------------------------------------
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Disabling
lock debugging due to kernel taint
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: INFO:
Slab 0xfffff4c4b027a000 objects=16 used=1 fp=0xffff96f3c9e83f00
flags=0x17ffffc0008100
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: CPU: 27
PID: 25588 Comm: rmmod Tainted: G    B      OE
4.14.97-.el7.centos.x86_64 #1
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Hardware
name: 80010056, BIOS 4.1.15 03/28/2017
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Call Trace:
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
dump_stack+0x5a/0x7b
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  slab_err+0xb4/0xe0
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
calibrate_delay+0x138/0x5f0
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
on_each_cpu_mask+0x27/0x60
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
on_each_cpu_cond+0xaf/0x140
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
__kmalloc+0x179/0x200
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:  ?
__kmem_cache_shutdown+0x194/0x3d0
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
__kmem_cache_shutdown+0x1b4/0x3d0
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
shutdown_cache+0x13/0x1b0
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
kmem_cache_destroy+0x1e4/0x220
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
rxe_cache_clean+0x41/0x60 [rdma_rxe]
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
rxe_module_exit+0xf/0x68 [rdma_rxe]
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
SyS_delete_module+0x175/0x270
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
do_syscall_64+0x74/0x190
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
entry_SYSCALL_64_after_hwframe+0x3d/0xa2
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RIP:
0033:0x7ff146d3f517
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RSP:
002b:00007ffd4b5c1598 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RAX:
ffffffffffffffda RBX: 0000000000d78280 RCX: 00007ff146d3f517
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RDX:
00007ff146db3ca0 RSI: 0000000000000800 RDI: 0000000000d782e8
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RBP:
0000000000000000 R08: 00007ff147008060 R09: 00007ff146db3ca0
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R10:
00007ffd4b5c1020 R11: 0000000000000202 R12: 00007ffd4b5c36ca
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R13:
0000000000000000 R14: 0000000000d78280 R15: 0000000000d78010
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: INFO:
Object 0xffff96f3c9e84ec0 @offset=20160
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
kmem_cache_destroy rxe-qp: Slab cache still has objects
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: CPU: 27
PID: 25588 Comm: rmmod Tainted: G    B      OE
4.14.97-.el7.centos.x86_64 #1
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Hardware
name: 80010056, BIOS 4.1.15 03/28/2017
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: Call Trace:
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
dump_stack+0x5a/0x7b
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
kmem_cache_destroy+0x203/0x220
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
rxe_cache_clean+0x41/0x60 [rdma_rxe]
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
rxe_module_exit+0xf/0x68 [rdma_rxe]
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
SyS_delete_module+0x175/0x270
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
do_syscall_64+0x74/0x190
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel:
entry_SYSCALL_64_after_hwframe+0x3d/0xa2
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RIP:
0033:0x7ff146d3f517
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RSP:
002b:00007ffd4b5c1598 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RAX:
ffffffffffffffda RBX: 0000000000d78280 RCX: 00007ff146d3f517
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RDX:
00007ff146db3ca0 RSI: 0000000000000800 RDI: 0000000000d782e8
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: RBP:
0000000000000000 R08: 00007ff147008060 R09: 00007ff146db3ca0
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R10:
00007ffd4b5c1020 R11: 0000000000000202 R12: 00007ffd4b5c36ca
Feb 11 14:17:31 57c4c63f-e817-4e22-aec9-72bc376b757c kernel: R13:
0000000000000000 R14: 0000000000d78280 R15: 0000000000d78010
