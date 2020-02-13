Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CEA15CB79
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 20:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgBMT4h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 14:56:37 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45739 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgBMT4g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Feb 2020 14:56:36 -0500
Received: by mail-qv1-f68.google.com with SMTP id l14so3185187qvu.12
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xlI28pKmm+gLzClYLhGnIbPO0ZtCd5sgmz9ja5H5BEM=;
        b=lqal4ujcIEKXnjhF5kjWcI7snifjyOGDVmirVJpMDf76dHKQfZeAitR6uP3EEKStV2
         H47w+vJRqDR2AFe9CaUEMo88J3u0eNU2mhKkXprYA8EK8iLp5dfVNmxMujT1HMEElF+q
         tKatDAK4EF8+brrEj/T9u1CZUF1apdWTt816qdQ0rLpQFSi9/1CB4aHBFIE8ai64WVLb
         GtKxq9FQtFrYgRHYc+yyfu8SAXTFQUK7qdRM3OCkbAAwljfrUTHVeFbJc6ckWXqUFNRM
         K/W0hHvA2tSLdpRGUcQzhxlSTkQ5JVDjEzRe6KlDbL6TfriU9m8qSoAmE6U1giIOSNUS
         q52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xlI28pKmm+gLzClYLhGnIbPO0ZtCd5sgmz9ja5H5BEM=;
        b=h6DmAwi6aAbeYADOyjdEGVggmw3D5NAGOMDQURkpoANhhJ1ziQeq3N+iekBt3Qm+sT
         w1IVRhsNGZE/ZnxvgtqAaAGskCSBykebPPbBJHeL+9nnJhUSY5+L5Wbn9cBAhVhR8hri
         L5z+k65EY7qrRQLs0GbIHFm0hbT+qYZKWhySD2iN9Ufn34/dJ7wXqFJnwJyw9NnPmhvZ
         dNiC4Hz2JBfBv610sB6vvFC9P4RRKgkG95RZH2S8vJGIxs3uBmqbTCM/1uEEl8s/EvLM
         wN+BYy8B3VVEtaWcUar0exfES8mc9jojGs4SIJSSdPROKO1u4iF6H4TfrPf3IKe1ohtE
         esFw==
X-Gm-Message-State: APjAAAX3O6p9qeGvmrJYHl3XC3MSfYSwWFryWCaf/KeWwlrMqeNgI5mK
        eEJOH6xiqYyKQXMMEEd7ZeXvOg==
X-Google-Smtp-Source: APXvYqwVJqpu3BhkMK2xyuRS/wllT6TEOA1KeTtt/Ss1X2n3hkQBkJ77qirxSv2vVs4UUAPG7G/Y1g==
X-Received: by 2002:a0c:e34e:: with SMTP id a14mr25229138qvm.73.1581623794337;
        Thu, 13 Feb 2020 11:56:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n189sm1900036qke.9.2020.02.13.11.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 11:56:33 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2KbB-0005ik-Dx; Thu, 13 Feb 2020 15:56:33 -0400
Date:   Thu, 13 Feb 2020 15:56:33 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/core: Fix protection fault in
 ib_mr_pool_destroy
Message-ID: <20200213195633.GA12180@ziepe.ca>
References: <20200212080744.686787-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212080744.686787-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 10:07:44AM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> Fix NULL pointer dereference in the error flow of ib_create_qp_user
> when accessing to uninitialized list pointers - rdma_mrs and sig_mrs.
> The following crash from syzkaller revealed it.
> 
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN PTI
> CPU: 1 PID: 23167 Comm: syz-executor.1 Not tainted 5.5.0-rc5 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> RIP: 0010:ib_mr_pool_destroy+0x81/0x1f0
> Code: 00 00 fc ff df 49 c1 ec 03 4d 01 fc e8 a8 ea 72 fe 41 80 3c 24 00
> 0f 85 62 01 00 00 48 8b 13 48 89 d6 4c 8d 6a c8 48 c1 ee 03 <42> 80 3c
> 3e 00 0f 85 34 01 00 00 48 8d 7a 08 4c 8b 02 48 89 fe 48
> RSP: 0018:ffffc9000951f8b0 EFLAGS: 00010046
> RAX: 0000000000040000 RBX: ffff88810f268038 RCX: ffffffff82c41628
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9000951f850
> RBP: ffff88810f268020 R08: 0000000000000004 R09: fffff520012a3f0a
> R10: 0000000000000001 R11: fffff520012a3f0a R12: ffffed1021e4d007
> R13: ffffffffffffffc8 R14: 0000000000000246 R15: dffffc0000000000
> FS:  00007f54bc788700(0000) GS:ffff88811b100000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000116920002 CR4: 0000000000360ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  rdma_rw_cleanup_mrs+0x15/0x30
>  ib_destroy_qp_user+0x674/0x7d0
>  ib_create_qp_user+0xb01/0x11c0
>  create_qp+0x1517/0x2130
>  ib_uverbs_create_qp+0x13e/0x190
>  ib_uverbs_write+0xaa5/0xdf0
>  __vfs_write+0x7c/0x100
>  vfs_write+0x168/0x4a0
>  ksys_write+0xc8/0x200
>  do_syscall_64+0x9c/0x390
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x465b49
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f54bc787c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000465b49
> RDX: 0000000000000040 RSI: 0000000020000540 RDI: 0000000000000003
> RBP: 00007f54bc787c70 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f54bc7886bc
> R13: 00000000004ca2ec R14: 000000000070ded0 R15: 0000000000000005
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> 
> Fixes: a060b5629ab06 ("IB/core: generic RDMA READ/WRITE API")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/verbs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 3ebae3b65c28..90c72f0e7388 100644
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1181,10 +1181,6 @@ struct ib_qp *ib_create_qp_user(struct ib_pd *pd,
>  	if (IS_ERR(qp))
>  		return qp;
> 
> -	ret = ib_create_qp_security(qp, device);
> -	if (ret)
> -		goto err;
> -
>  	qp->qp_type    = qp_init_attr->qp_type;
>  	qp->rwq_ind_tbl = qp_init_attr->rwq_ind_tbl;

I don't think that the init that follows this line should be open
coded in ib_create_qp_user, it belongs in _ib_create_qp() so that it
can be paied with ib_destroy_qp, can you move it and respin it?

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index b1457b3464d34f..d701956e435758 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -338,6 +338,20 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 	qp->pd = pd;
 	qp->uobject = uobj;
 	qp->real_qp = qp;
+	qp->qp_type = attr->qp_type;
+	qp->rwq_ind_tbl = attr->rwq_ind_tbl;
+	qp->send_cq = attr->send_cq;
+	qp->recv_cq = attr->recv_cq;
+	qp->srq = attr->srq;
+	qp->event_handler = attr->event_handler;
+
+	atomic_set(&qp->usecnt, 0);
+	qp->mrs_used = 0;
+	spin_lock_init(&qp->mr_lock);
+	INIT_LIST_HEAD(&qp->rdma_mrs);
+	INIT_LIST_HEAD(&qp->sig_mrs);
+	qp->port = 0;
+
 	/*
 	 * We don't track XRC QPs for now, because they don't have PD
 	 * and more importantly they are created internaly by driver,
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index c8693f5231dd7d..2d24552e24c740 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1445,16 +1445,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		if (ret)
 			goto err_cb;
 
-		qp->pd		  = pd;
-		qp->send_cq	  = attr.send_cq;
-		qp->recv_cq	  = attr.recv_cq;
-		qp->srq		  = attr.srq;
-		qp->rwq_ind_tbl	  = ind_tbl;
-		qp->event_handler = attr.event_handler;
-		qp->qp_type	  = attr.qp_type;
-		atomic_set(&qp->usecnt, 0);
 		atomic_inc(&pd->usecnt);
-		qp->port = 0;
 		if (attr.send_cq)
 			atomic_inc(&attr.send_cq->usecnt);
 		if (attr.recv_cq)
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 3ebae3b65c2821..e62c9dfc7837a8 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1185,16 +1185,6 @@ struct ib_qp *ib_create_qp_user(struct ib_pd *pd,
 	if (ret)
 		goto err;
 
-	qp->qp_type    = qp_init_attr->qp_type;
-	qp->rwq_ind_tbl = qp_init_attr->rwq_ind_tbl;
-
-	atomic_set(&qp->usecnt, 0);
-	qp->mrs_used = 0;
-	spin_lock_init(&qp->mr_lock);
-	INIT_LIST_HEAD(&qp->rdma_mrs);
-	INIT_LIST_HEAD(&qp->sig_mrs);
-	qp->port = 0;
-
 	if (qp_init_attr->qp_type == IB_QPT_XRC_TGT) {
 		struct ib_qp *xrc_qp =
 			create_xrc_qp_user(qp, qp_init_attr, udata);
