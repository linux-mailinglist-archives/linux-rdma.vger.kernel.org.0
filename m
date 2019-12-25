Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F9A12A686
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2019 08:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfLYHKd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Dec 2019 02:10:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35550 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfLYHKd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Dec 2019 02:10:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id 15so16423625lfr.2
        for <linux-rdma@vger.kernel.org>; Tue, 24 Dec 2019 23:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=syXD6M8Pz8sKK0bAZ5+qkJ0i7M9M3D0tf2srDloJ1Ts=;
        b=gnGk2+u9PsHRjGmJpnyhkCVrRN4090tKqS8h5aDoB0VtxLuuCPtmehoyhJfkJ8/B5V
         N1xRUnr+kIL34LJylDp+VOgTF6XbiiUql3KwGzA782DdBlIVOGcuPv0CKgX9MAw43FvZ
         NlmaBTg9puEjsSwoqqNZ6z69alzMbNasslgEmT7asYDTGbEgBO3sUlTSdN14O+vND8uh
         E76DRRol0J6hmj7C//x7XWxJsKJ9QI5DkqAg2VYLH9VCC2oMdjxJ3KflTN0bJsoiyR4H
         7+7IuNi3OLRdHRFUWoqv5m+fdz0QZQyw8eOrp07X/4xtOfM15WuWmCw++PwzsCuYUFFP
         J6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=syXD6M8Pz8sKK0bAZ5+qkJ0i7M9M3D0tf2srDloJ1Ts=;
        b=a8sYQvE2BufgywR+hq8xreBzKcFsC0s/eltpNzmai1vOKf06tG0QuuKBIKrqEUhWO9
         RhtvAlUCm/A/KQoLl2lGYF4YSsVaDRtZl8NW0xxX2T+yadR5D1su/JFXbdzpaNAEWm8d
         n+xd7Am0vBhxA0t0GjzB3m3uPTccXxUyNreeYpeZDYL4nVkHLbMkfAUkdRmDOeR1bOhE
         B/4G4QhAVU6qD+MH1lcB165Vv8n5RwRIQT9mqfEZdGBWGrD9lRbrKGIocxcv96HfwZsR
         GOjPGi8blG7UzaBuFn8y7PbzlB949ec7gADAmbFe+RQOk7VCtikbkgv3/pxOV1BIVfFW
         Jijg==
X-Gm-Message-State: APjAAAWEvfcDz62A+r7tnq1J//SCNyEeBA9hlMofSNOptseUBUqhN4OQ
        lJsBUrrIkRoaLCn0ETNEPBwCEd1Uo2uKbsuKi4I=
X-Google-Smtp-Source: APXvYqy0omQzN+QDbu2n9F8eb+H8icjQt8M+wueR3bMvNrdGqPKF5rgviWBBApinQ/tS6Ccp5C0CSNG5sjKZ1q7Vumo=
X-Received: by 2002:a19:c3cc:: with SMTP id t195mr22839937lff.144.1577257830738;
 Tue, 24 Dec 2019 23:10:30 -0800 (PST)
MIME-Version: 1.0
References: <CAKC_zSs=m_qPs06ZqxB-UJ_nHqhb+V2CBNKj3HsdJX+6eevqCA@mail.gmail.com>
 <CAD=hENfnjGXk7HuaihdxQ-uuYSdox6B_2BHaAMnYKWzMQHx5=Q@mail.gmail.com>
 <CAKC_zStGqt_BO=sos+jtfEvxO3ZEgv4Sf-YytNPowhnBtGdDog@mail.gmail.com> <CAD=hENfVz9OuOg0vQyi4jR1G+_cHj3_BZhVyRG+FGgOaAz-KZQ@mail.gmail.com>
In-Reply-To: <CAD=hENfVz9OuOg0vQyi4jR1G+_cHj3_BZhVyRG+FGgOaAz-KZQ@mail.gmail.com>
From:   Frank Huang <tigerinxm@gmail.com>
Date:   Wed, 25 Dec 2019 15:10:16 +0800
Message-ID: <CAKC_zSvHg0vB=f85ESej+yN9zNg5WXRYTynp+E53+evJvcuPiQ@mail.gmail.com>
Subject: Re: rxe panic
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

hi, zhu

Here is the detail.  Wish it is what your wanted.


[root@test 127.0.0.1-2019-11-11-18:59:57]# crash
/usr/lib/debug/lib/modules/$(uname -r)/vmlinux vmcore

crash 7.2.3-10.el7
Copyright (C) 2002-2017  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005, 2011  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.

GNU gdb (GDB) 7.6
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-unknown-linux-gnu"...

WARNING: kernel relocated [224MB]: patching 92417 gdb minimal_symbol values

      KERNEL: /usr/lib/debug/lib/modules/4.14.97-.el7.centos.x86_64/vmlinux
    DUMPFILE: vmcore  [PARTIAL DUMP]
        CPUS: 48
        DATE: Mon Nov 11 18:59:49 2019
      UPTIME: 11 days, 04:57:53
LOAD AVERAGE: 3.14, 3.11, 3.09
       TASKS: 1103
    NODENAME: test
     RELEASE: 4.14.97-.el7.centos.x86_64
     VERSION: #1 SMP Mon Apr 29 14:32:59 CST 2019
     MACHINE: x86_64  (2494 Mhz)
      MEMORY: 159.9 GB
       PANIC: "general protection fault: 0000 [#1] SMP PTI"
         PID: 108
     COMMAND: "ksoftirqd/16"
        TASK: ffff978e28548000  [THREAD_INFO: ffff978e28548000]
         CPU: 16
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 108    TASK: ffff978e28548000  CPU: 16  COMMAND: "ksoftirqd/16"
 #0 [ffffa2f14c9a7b18] machine_kexec at ffffffff8f059992
 #1 [ffffa2f14c9a7b70] __crash_kexec at ffffffff8f13cf7d
 #2 [ffffa2f14c9a7c38] crash_kexec at ffffffff8f13e089
 #3 [ffffa2f14c9a7c50] oops_end at ffffffff8f027a77
 #4 [ffffa2f14c9a7c70] general_protection at ffffffff8fa01635
    [exception RIP: rxe_elem_release+15]
    RIP: ffffffffc08da38f  RSP: ffffa2f14c9a7d28  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: 860e42124013b0aa  RCX: 0000000000000000
    RDX: ffff978e03ba8900  RSI: 0000000000000281  RDI: ffff978e02e746e8
    RBP: ffff978e02e746e0   R8: 0000000000000201   R9: ffffa2f14dcb9000
    R10: 0000000000000000  R11: 0000000000000001  R12: 0000000000000000
    R13: 000000000000001d  R14: 0000000000000006  R15: ffff978e02e746e0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #5 [ffffa2f14c9a7d38] rxe_responder at ffffffffc08d7d10 [rdma_rxe]
 #6 [ffffa2f14c9a7e48] rxe_do_task at ffffffffc08e060b [rdma_rxe]
 #7 [ffffa2f14c9a7e70] tasklet_action at ffffffff8f0afa1e
 #8 [ffffa2f14c9a7e88] __softirqentry_text_start at ffffffff8fc000d9
 #9 [ffffa2f14c9a7ee0] run_ksoftirqd at ffffffff8f0afa4e
#10 [ffffa2f14c9a7ee8] smpboot_thread_fn at ffffffff8f0cca5e
#11 [ffffa2f14c9a7f10] kthread at ffffffff8f0c8c9f
#12 [ffffa2f14c9a7f50] ret_from_fork at ffffffff8fa00205
crash> mod -s rdma_rxe
     MODULE       NAME                    SIZE  OBJECT FILE
ffffffffc08ef240  rdma_rxe              126976
/usr/lib/debug/usr/lib/modules/4.14.97-.el7.centos.x86_64/kernel/drivers/infiniband/sw/rxe/rdma_rxe.ko.debug
crash> dis -lr rxe_elem_release+15
/usr/src/debug/kernel--4.14.97-1.el7/linux-4.14.97-.el7.centos.x86_64/drivers/infiniband/sw/rxe/rxe_pool.c:
452
0xffffffffc08da380 <rxe_elem_release>:  nopl   0x0(%rax,%rax,1) [FTRACE NOP]
0xffffffffc08da385 <rxe_elem_release+5>:        push   %rbp
/usr/src/debug/kernel--4.14.97-1.el7/linux-4.14.97-.el7.centos.x86_64/drivers/infiniband/sw/rxe/rxe_pool.c:
447
0xffffffffc08da386 <rxe_elem_release+6>:        lea    -0x8(%rdi),%rbp
/usr/src/debug/kernel--4.14.97-1.el7/linux-4.14.97-.el7.centos.x86_64/arch/x86/include/asm/refcount.h:
52
0xffffffffc08da38a <rxe_elem_release+10>:       push   %rbx
0xffffffffc08da38b <rxe_elem_release+11>:       mov    -0x8(%rdi),%rbx
0xffffffffc08da38f <rxe_elem_release+15>:       mov    0x20(%rbx),%rax

crash> quit
[root@test 127.0.0.1-2019-11-11-18:59:57]#
   433 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
   434 {
   435 struct rb_node *node = NULL;
   436 struct rxe_pool_entry *elem = NULL;
   437 unsigned long flags;
   438
   439 spin_lock_irqsave(&pool->pool_lock, flags);
   440
   441 if (pool->state != rxe_pool_valid)
   442 goto out;
   443
   444 node = pool->tree.rb_node;
   445
   446 while (node) {
   447 elem = rb_entry(node, struct rxe_pool_entry, node);
   448
   449 if (elem->index > index)
   450 node = node->rb_left;
   451 else if (elem->index < index)
   452 node = node->rb_right;
   453 else
   454 break;
   455 }
   456
   457 if (node)
   458 kref_get(&elem->ref_cnt);
   459
   460 out:
   461 spin_unlock_irqrestore(&pool->pool_lock, flags);
   462 return node ? elem : NULL;
   463 }
