Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1468137A156
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 10:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhEKIGA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhEKIGA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 May 2021 04:06:00 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B1EC061574;
        Tue, 11 May 2021 01:04:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id v22so13404458oic.2;
        Tue, 11 May 2021 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+s7Q6HeMDVe3VxU+zVpnFtWeMKWBHbhimZCBxLkHHCc=;
        b=Dm6J034CLl7HowSsz0ys2fkOcajezjyRzkK9Ni67jTW5QWQogGeXE3szI3djZBxBKF
         mgVOBKw4OhkNeLyEGoLw2FqEbpW42uhSVHpOGzGzvwjC2rgJrJF5hZRkg1uLnzR2AksN
         kXHErr9P8Nr027H0b7ckqQLTx0cf85uVH+AAQVcHJQotoKDxpx3B4PGKQGhEF6Aftqfg
         WzGl5NIqLeib7iwRt7Jw6IOIK8gKLKk4kVFYAGKNiU37X7AYnWhTIzjUBWXNFBKxjsPF
         I+/+MOPJSKoy6hgRRIMEHSJYm79r2xwCI7B6gOU7jrVHKKP44VPhEvD3OZS5LOpdxxFM
         Fd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+s7Q6HeMDVe3VxU+zVpnFtWeMKWBHbhimZCBxLkHHCc=;
        b=VWKXNzZry891GHGXVmThtdqrTYyuBqShpHtXRwhYxRHunefLM4DDo6Q7FCVBEBl6EN
         PxjWe/4POlb3675DiJdojuc+8Y2FOjN9uknJeluuScWJ6/3akvj22Zeyuv0wbJR0NLnF
         zVuojFYxDOgsM5TgP3E5erMYW4dHz80d8r0xn+6fS6IKwsLxPu7uTWzNJwumQMIztnlw
         89ydNCcks3BPqzwBSub3E+QliXoouCsqO1YBU1kMDJRZDqxI6Jeu18pmOLHnaZTXViiB
         LKjedwAhdb/7IoWnFCR1aHW86qpotb2Z/1ca2Y3pkGv1Y3oJ2Cmv1+h1N8FgiU8RIX1K
         LrKQ==
X-Gm-Message-State: AOAM532tx7oM9o5sZKaBYz9adSQfjzvmEh7qbALdJU25kH9B2rkjO4Qi
        PSpzKaO4RZJNVJMuJ2zca0Ivo6pm4mw4D4cPZdg=
X-Google-Smtp-Source: ABdhPJyIsoHE2BnePrMyCHgxu9DgM6EVMCRPHXKBqQXRcLfhhUcWYPfM19EM+N+5v4gJKvqHE0nYasn7A1o0Zuhv8eI=
X-Received: by 2002:aca:c685:: with SMTP id w127mr2550780oif.89.1620720293876;
 Tue, 11 May 2021 01:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <7bf8d548764d406dbbbaf4b574960ebfd5af8387.1620717918.git.leonro@nvidia.com>
In-Reply-To: <7bf8d548764d406dbbbaf4b574960ebfd5af8387.1620717918.git.leonro@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 11 May 2021 16:04:42 +0800
Message-ID: <CAD=hENfsutV7Pig=64e52OADieLTxeQ=aCjNQ06xvUm_PM5JOQ@mail.gmail.com>
Subject: Re: [PATCH rdma-rc] RDMA/rxe: Clear all QP fields if creation failed
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        syzbot+36a7f280de4e11c6f04e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 11, 2021 at 3:26 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> rxe_qp_do_cleanup() relies on valid pointer values in QP for the
> properly created ones, but in case rxe_qp_from_init() failed it was
> filled with garbage and caused tot the following error.
>
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 1 PID: 12560 at lib/refcount.c:28 refcount_warn_saturate+0x1d1/0x1e0 lib/refcount.c:28
> Modules linked in:
> CPU: 1 PID: 12560 Comm: syz-executor.4 Not tainted 5.12.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:refcount_warn_saturate+0x1d1/0x1e0 lib/refcount.c:28
> Code: e9 db fe ff ff 48 89 df e8 2c c2 ea fd e9 8a fe ff ff e8 72 6a a7 fd 48 c7 c7 e0 b2 c1 89 c6 05 dc 3a e6 09 01 e8 ee 74 fb 04 <0f> 0b e9 af fe ff ff 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 55
> RSP: 0018:ffffc900097ceba8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000040000 RSI: ffffffff815bb075 RDI: fffff520012f9d67
> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff815b4eae R11: 0000000000000000 R12: ffff8880322a4800
> R13: ffff8880322a4940 R14: ffff888033044e00 R15: 0000000000000000
> FS:  00007f6eb2be3700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdbe5d41000 CR3: 000000001d181000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __refcount_sub_and_test include/linux/refcount.h:283 [inline]
>  __refcount_dec_and_test include/linux/refcount.h:315 [inline]
>  refcount_dec_and_test include/linux/refcount.h:333 [inline]
>  kref_put include/linux/kref.h:64 [inline]
>  rxe_qp_do_cleanup+0x96f/0xaf0 drivers/infiniband/sw/rxe/rxe_qp.c:805
>  execute_in_process_context+0x37/0x150 kernel/workqueue.c:3327
>  rxe_elem_release+0x9f/0x180 drivers/infiniband/sw/rxe/rxe_pool.c:391
>  kref_put include/linux/kref.h:65 [inline]
>  rxe_create_qp+0x2cd/0x310 drivers/infiniband/sw/rxe/rxe_verbs.c:425
>  _ib_create_qp drivers/infiniband/core/core_priv.h:331 [inline]
>  ib_create_named_qp+0x2ad/0x1370 drivers/infiniband/core/verbs.c:1231
>  ib_create_qp include/rdma/ib_verbs.h:3644 [inline]
>  create_mad_qp+0x177/0x2d0 drivers/infiniband/core/mad.c:2920
>  ib_mad_port_open drivers/infiniband/core/mad.c:3001 [inline]
>  ib_mad_init_device+0xd6f/0x1400 drivers/infiniband/core/mad.c:3092
>  add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:717
>  enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1331
>  ib_register_device drivers/infiniband/core/device.c:1413 [inline]
>  ib_register_device+0x7c7/0xa50 drivers/infiniband/core/device.c:1365
>  rxe_register_device+0x3d5/0x4a0 drivers/infiniband/sw/rxe/rxe_verbs.c:1147
>  rxe_add+0x12fe/0x16d0 drivers/infiniband/sw/rxe/rxe.c:247
>  rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:503
>  rxe_newlink drivers/infiniband/sw/rxe/rxe.c:269 [inline]
>  rxe_newlink+0xb7/0xe0 drivers/infiniband/sw/rxe/rxe.c:250
>  nldev_newlink+0x30e/0x550 drivers/infiniband/core/nldev.c:1555
>  rdma_nl_rcv_msg+0x36d/0x690 drivers/infiniband/core/netlink.c:195
>  rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>  rdma_nl_rcv+0x2ee/0x430 drivers/infiniband/core/netlink.c:259
>  netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
>  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1338
>  netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1927
>  sock_sendmsg_nosec net/socket.c:654 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:674
>  ____sys_sendmsg+0x6e8/0x810 net/socket.c:2350
>  ___sys_sendmsg+0xf3/0x170 net/socket.c:2404
>  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2433
>  do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665f9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f6eb2be3188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 00000000004665f9
> RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000003
> RBP: 00000000004bfce1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
> R13: 00007ffc54e34f4f R14: 00007f6eb2be3300 R15: 0000000000022000
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Reported-by: syzbot+36a7f280de4e11c6f04e@syzkaller.appspotmail.com
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Thanks.
Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 34ae957a315c..b0f350d674fd 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -242,6 +242,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>         if (err) {
>                 vfree(qp->sq.queue->buf);
>                 kfree(qp->sq.queue);
> +               qp->sq.queue = NULL;
>                 return err;
>         }
>
> @@ -295,6 +296,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
>                 if (err) {
>                         vfree(qp->rq.queue->buf);
>                         kfree(qp->rq.queue);
> +                       qp->rq.queue = NULL;
>                         return err;
>                 }
>         }
> @@ -355,6 +357,11 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
>  err2:
>         rxe_queue_cleanup(qp->sq.queue);
>  err1:
> +       qp->pd = NULL;
> +       qp->rcq = NULL;
> +       qp->scq = NULL;
> +       qp->srq = NULL;
> +
>         if (srq)
>                 rxe_drop_ref(srq);
>         rxe_drop_ref(scq);
> --
> 2.31.1
>
