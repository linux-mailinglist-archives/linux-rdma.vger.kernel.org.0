Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82D2707F7
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 23:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIRVP4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 17:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRVP4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 17:15:56 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631EBC0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:15:56 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 26so313885ois.5
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ysPdlCeRkun4Q9i3M/sfU46TifNlwFA7gqnECwTQHjo=;
        b=u+qeSDAEC/PxcNHlQcJLTJCWpvCwPq+Tu9yLwhPNW6/7Mp3nn2rtVaJXeYgo3+AYNV
         N3eyinI0SC8CLcSirUfgfLqEHu3XBb7Y84Rm2a5ztWM0PyYnXXfH/lTA/ntkvqvFiHRz
         AcOxLmFJIpH6EfXggSoyeFXVO7NzXTt2WfEUGMNmeTC4Ri3jedtSpiU4yzZAQoxKAwuS
         j3mc85sj7FROwIDMwaiQ8XTzgsXcHVJ+UuPQFIufS1U9FDVqFb08cE3/ZTjVOnH4VYZB
         SXKLxV+iXET6+TB8CxLJFZQV8kQuUlfhucC1/I5MiDx8pKnipBGRtph2+JxW8MVPY+Tu
         ha3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ysPdlCeRkun4Q9i3M/sfU46TifNlwFA7gqnECwTQHjo=;
        b=rW351kJZj9+HtWJCFjGsb597guFIUgHMY2rz0E8F/R0pP3Sk3huwFC1qU6fw8kZpye
         DNoes26bzYmbKqEY3hBDdGskweYCxDNfLOHIJd1NPHHrbyldzIcQsjO0XQPz+YuXiexZ
         +YYSX5+5CnSqdSw8oqUV5RRxgbmGG9JQQMS3BJ/kn76tlWgAepBF2ukol7y2OKk4ahEM
         07lsdcBOWToflPOLwhULfhBnu1L9Ynp5ZXvVcwrvw2/IFsOVkR4BK3e3aTdKfx+EM7Xj
         rhFopeYGsfH9zf2vB7TMUtrSZvgnbOQkDu6WRiVMW6Y+NhtnNaD3T8/Bo1X13fLZbnnR
         maww==
X-Gm-Message-State: AOAM530k35lnwcxFmrKzbpACZKBrDoNKrX4PWjMorqQ3Yo3N3cwgqMan
        EuJm8pvJLGoOND9+oAlcIBw=
X-Google-Smtp-Source: ABdhPJzPDSUL3Qb+1OQdqVOaJPHOVicshB/RUR+2E5QK7xKCblSrHgbUE01piYr59DUPElgP6JbJsQ==
X-Received: by 2002:aca:52d6:: with SMTP id g205mr10702654oib.54.1600463755717;
        Fri, 18 Sep 2020 14:15:55 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:4725:6035:508:6d87])
        by smtp.gmail.com with ESMTPSA id e30sm3348178otf.49.2020.09.18.14.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:15:55 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 05/12] rdma_rxe: Add bind_mw and invalidate_mw verbs
Date:   Fri, 18 Sep 2020 16:15:10 -0500
Message-Id: <20200918211517.5295-6-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918211517.5295-1-rpearson@hpe.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 - Add code to implement ibv_bind_mw (for type 1 MWs) and
   post send queue bind_mw (for type 2 MWs).
 - Add code to implement local (post send) and remote
   (send with invalidate) invalidate operations.
 - Add rules checking for MW operations from IBA.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
 drivers/infiniband/sw/rxe/rxe_loc.h    |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c     |   3 +-
 drivers/infiniband/sw/rxe/rxe_mw.c     | 289 ++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h |   1 -
 drivers/infiniband/sw/rxe/rxe_req.c    |  81 +++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c  |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h  |   7 +
 include/uapi/rdma/rdma_user_rxe.h      |  34 ++-
 10 files changed, 399 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 5dc86c9e74c2..8b81d3b24a8a 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -103,6 +103,7 @@ static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
 	case IB_WR_RDMA_READ_WITH_INV:		return IB_WC_RDMA_READ;
 	case IB_WR_LOCAL_INV:			return IB_WC_LOCAL_INV;
 	case IB_WR_REG_MR:			return IB_WC_REG_MR;
+	case IB_WR_BIND_MW:			return IB_WC_BIND_MW;
 
 	default:
 		return 0xff;
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 65f2e4a94956..d9a4004fddaa 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -117,6 +117,8 @@ int rxe_dealloc_mw(struct ib_mw *ibmw);
 
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
+int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
+
 /* rxe_net.c */
 void rxe_loopback(struct sk_buff *skb);
 int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 4c53badfa4e9..f506dff25fdf 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -543,7 +543,8 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
 	int i;
 
-	ib_umem_release(mr->umem);
+	if (mr->umem)
+		ib_umem_release(mr->umem);
 
 	if (mr->map) {
 		for (i = 0; i < mr->num_map; i++)
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index b818f1e869da..51bc71c98654 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -30,7 +30,7 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 	struct rxe_alloc_mw_resp __user *uresp = NULL;
 
 	if (udata) {
-		if (udata->outlen < sizeof(*uresp))
+		if (unlikely(udata->outlen < sizeof(*uresp)))
 			return ERR_PTR(-EINVAL);
 		uresp = udata->outbuf;
 	}
@@ -62,10 +62,9 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 					RXE_MEM_STATE_VALID;
 
 	if (uresp) {
-		if (copy_to_user(&uresp->index, &mw->pelem.index,
-				 sizeof(uresp->index))) {
+		if (unlikely(copy_to_user(&uresp->index, &mw->pelem.index,
+				 sizeof(uresp->index)))) {
 			rxe_drop_ref(mw);
-			rxe_drop_ref(pd);
 			return ERR_PTR(-EFAULT);
 		}
 	}
@@ -73,22 +72,298 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 	return &mw->ibmw;
 }
 
+/* cleanup mw in case someone is still holding a ref */
+static void do_dealloc_mw(struct rxe_mw *mw)
+{
+	if (mw->mr) {
+		rxe_drop_ref(mw->mr);
+		atomic_dec(&mw->mr->num_mw);
+		mw->mr = NULL;
+	}
+
+	mw->qp = NULL;
+	mw->access = 0;
+	mw->addr = 0;
+	mw->length = 0;
+	mw->state = RXE_MEM_STATE_INVALID;
+}
+
 int rxe_dealloc_mw(struct ib_mw *ibmw)
 {
 	struct rxe_mw *mw = to_rmw(ibmw);
-	struct rxe_pd *pd = to_rpd(ibmw->pd);
 	unsigned long flags;
 
 	spin_lock_irqsave(&mw->lock, flags);
-	mw->state = RXE_MEM_STATE_INVALID;
+
+	do_dealloc_mw(mw);
+
+	spin_unlock_irqrestore(&mw->lock, flags);
+
+	rxe_drop_ref(mw);
+
+	return 0;
+}
+
+/* Check the rules for bind MW oepration. */
+static int check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+			 struct rxe_mw *mw, struct rxe_mr *mr)
+{
+	/* check to see if bind operation came through
+	 * ibv_bind_mw verbs API.
+	 */
+	switch (mw->ibmw.type) {
+	case IB_MW_TYPE_1:
+		/* o10-37.2.34 */
+		if (unlikely(!(wqe->wr.wr.umw.flags & RXE_BIND_MW))) {
+			pr_err_once("attempt to bind type 1 MW with send WR\n");
+			return -EINVAL;
+		}
+		break;
+	case IB_MW_TYPE_2:
+		/* o10-37.2.35 */
+		if (unlikely(wqe->wr.wr.umw.flags & RXE_BIND_MW)) {
+			pr_err_once("attempt to bind type 2 MW with verbs API\n");
+			return -EINVAL;
+		}
+
+		/* C10-72 */
+		if (unlikely(qp->pd != to_rpd(mw->ibmw.pd))) {
+			pr_err_once("attempt to bind type 2 MW with qp with different PD\n");
+			return -EINVAL;
+		}
+
+		/* o10-37.2.40 */
+		if (unlikely(wqe->wr.wr.umw.length == 0)) {
+			pr_err_once("attempt to invalidate type 2 MW by binding with zero length\n");
+			return -EINVAL;
+		}
+
+		if (unlikely(!mr)) {
+			pr_err_once("attempt to bind MW to a NULL mr\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (unlikely((mw->ibmw.type == IB_MW_TYPE_1) &&
+		     (mw->state != RXE_MEM_STATE_VALID))) {
+		pr_err_once("attempt to bind a type 1 MW not in the valid state\n");
+		return -EINVAL;
+	}
+
+	/* o10-36.2.2 */
+	if (unlikely((mw->access & IB_ZERO_BASED) &&
+		     (mw->ibmw.type == IB_MW_TYPE_1))) {
+		pr_err_once("attempt to bind a zero based type 1 MW\n");
+		return -EINVAL;
+	}
+
+	if (unlikely((wqe->wr.wr.umw.rkey & 0xff) == (mw->ibmw.rkey & 0xff))) {
+		pr_err_once("attempt to bind MW with same key\n");
+		return -EINVAL;
+	}
+
+	/* remaining checks only apply to a nonzero MR */
+	if (!mr)
+		return 0;
+
+	if (unlikely(mr->access & IB_ZERO_BASED)) {
+		pr_err_once("attempt to bind MW to zero based MR\n");
+		return -EINVAL;
+	}
+
+	/* o10-37.2.30 */
+	if (unlikely((mw->ibmw.type == IB_MW_TYPE_2) &&
+		     (mw->state != RXE_MEM_STATE_FREE))) {
+		pr_err_once("attempt to bind a type 2 MW not in the free state\n");
+		return -EINVAL;
+	}
+
+	/* C10-73 */
+	if (unlikely(!(mr->access & IB_ACCESS_MW_BIND))) {
+		pr_err_once("attempt to bind an MW to an MR without bind access\n");
+		return -EINVAL;
+	}
+
+	/* C10-74 */
+	if (unlikely((mw->access & (IB_ACCESS_REMOTE_WRITE |
+				    IB_ACCESS_REMOTE_ATOMIC)) &&
+		     !(mr->access & IB_ACCESS_LOCAL_WRITE))) {
+		pr_err_once("attempt to bind an writeable MW to an MR without local write access\n");
+		return -EINVAL;
+	}
+
+	/* C10-75 */
+	if (mw->access & IB_ZERO_BASED) {
+		if (unlikely(wqe->wr.wr.umw.length > mr->length)) {
+			pr_err_once("attempt to bind a ZB MW outside of the MR\n");
+			return -EINVAL;
+		}
+	} else {
+		if (unlikely((wqe->wr.wr.umw.addr < mr->iova) ||
+			     ((wqe->wr.wr.umw.addr + wqe->wr.wr.umw.length) >
+			     (mr->iova + mr->length)))) {
+			pr_err_once("attempt to bind a VA MW outside of the MR\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+		      struct rxe_mw *mw, struct rxe_mr *mr)
+{
+	u32 rkey;
+	u32 new_rkey;
+	struct rxe_mw *duplicate_mw;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+
+	/* key part of new rkey is provided by user for type 2
+	 * and ibv_bind_mw() for type 1 MWs
+	 * there is a very rare chance that the new rkey will
+	 * collide with an existing MW. Return an error if this
+	 * occurs
+	 */
+	rkey = mw->ibmw.rkey;
+	new_rkey = (rkey & 0xffffff00) | (wqe->wr.wr.umw.rkey & 0x000000ff);
+	duplicate_mw = rxe_pool_get_key(&rxe->mw_pool, &new_rkey);
+	if (duplicate_mw) {
+		pr_err_once("new MW key is a duplicate, try another\n");
+		rxe_drop_ref(duplicate_mw);
+		return -EINVAL;
+	}
+
+	rxe_drop_key(mw);
+	rxe_add_key(mw, &new_rkey);
+
+	mw->access = wqe->wr.wr.umw.access;
+	mw->state = RXE_MEM_STATE_VALID;
+	mw->addr = wqe->wr.wr.umw.addr;
+	mw->length = wqe->wr.wr.umw.length;
+
+	if (mw->mr) {
+		rxe_drop_ref(mw->mr);
+		atomic_dec(&mw->mr->num_mw);
+		mw->mr = NULL;
+	}
+
+	if (mw->length) {
+		mw->mr = mr;
+		atomic_inc(&mr->num_mw);
+		rxe_add_ref(mr);
+	}
+
+	if (mw->ibmw.type == IB_MW_TYPE_2)
+		mw->qp = qp;
+
+	return 0;
+}
+
+int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
+{
+	int ret;
+	struct rxe_mw *mw;
+	struct rxe_mr *mr;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	unsigned long flags;
+
+	if (qp->is_user) {
+		mw = rxe_pool_get_index(&rxe->mw_pool,
+					wqe->wr.wr.umw.mw_index);
+		if (!mw) {
+			pr_err_once("mw with index = %d not found\n",
+			wqe->wr.wr.umw.mw_index);
+			ret = -EINVAL;
+			goto err1;
+		}
+		mr = rxe_pool_get_index(&rxe->mr_pool,
+		wqe->wr.wr.umw.mr_index);
+		if (!mr && wqe->wr.wr.umw.length) {
+			pr_err_once("mr with index = %d not found\n",
+			wqe->wr.wr.umw.mr_index);
+			ret = -EINVAL;
+			goto err2;
+		}
+	} else {
+		mw = to_rmw(wqe->wr.wr.kmw.mw);
+		rxe_add_ref(mw);
+		if (wqe->wr.wr.kmw.mr) {
+			mr = to_rmr(wqe->wr.wr.kmw.mr);
+			rxe_add_ref(mr);
+		} else {
+			mr = NULL;
+		}
+	}
+
+	spin_lock_irqsave(&mw->lock, flags);
+
+	ret = check_bind_mw(qp, wqe, mw, mr);
+	if (ret)
+		goto err3;
+
+	ret = do_bind_mw(qp, wqe, mw, mr);
+err3:
 	spin_unlock_irqrestore(&mw->lock, flags);
 
-	rxe_drop_ref(pd);
+	if (mr)
+		rxe_drop_ref(mr);
+err2:
 	rxe_drop_ref(mw);
+err1:
+	return ret;
+}
+
+static int check_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
+{
+	if (unlikely(mw->state != RXE_MEM_STATE_VALID)) {
+		pr_err_once("attempt to invalidate a MW that is not valid\n");
+		return -EINVAL;
+	}
+
+	/* o10-37.2.26 */
+	if (unlikely(mw->ibmw.type == IB_MW_TYPE_1)) {
+		pr_err_once("attempt to invalidate a type 1 MW\n");
+		return -EINVAL;
+	}
 
 	return 0;
 }
 
+static void do_invalidate_mw(struct rxe_mw *mw)
+{
+	mw->qp = NULL;
+
+	rxe_drop_ref(mw->mr);
+	atomic_dec(&mw->mr->num_mw);
+	mw->mr = NULL;
+
+	mw->access = 0;
+	mw->addr = 0;
+	mw->length = 0;
+	mw->state = RXE_MEM_STATE_FREE;
+}
+
+int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mw->lock, flags);
+
+	ret = check_invalidate_mw(qp, mw);
+	if (ret)
+		goto err;
+
+	do_invalidate_mw(mw);
+err:
+	spin_unlock_irqrestore(&mw->lock, flags);
+
+	return ret;
+}
+
 void rxe_mw_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_mw *mw = container_of(arg, typeof(*mw), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 0cb4b01fd910..5532f01ae5a3 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -87,13 +87,20 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 	[IB_WR_LOCAL_INV]				= {
 		.name	= "IB_WR_LOCAL_INV",
 		.mask	= {
-			[IB_QPT_RC]	= WR_REG_MASK,
+			[IB_QPT_RC]	= WR_LOCAL_MASK,
 		},
 	},
 	[IB_WR_REG_MR]					= {
 		.name	= "IB_WR_REG_MR",
 		.mask	= {
-			[IB_QPT_RC]	= WR_REG_MASK,
+			[IB_QPT_RC]	= WR_LOCAL_MASK,
+		},
+	},
+	[IB_WR_BIND_MW]					= {
+		.name	= "IB_WR_BIND_MW",
+		.mask	= {
+			[IB_QPT_RC]	= WR_LOCAL_MASK,
+			[IB_QPT_UC]	= WR_LOCAL_MASK,
 		},
 	},
 };
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 1041ac9a9233..440e34f446bd 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -20,7 +20,6 @@ enum rxe_wr_mask {
 	WR_READ_MASK			= BIT(3),
 	WR_WRITE_MASK			= BIT(4),
 	WR_LOCAL_MASK			= BIT(5),
-	WR_REG_MASK			= BIT(6),
 
 	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
 	WR_READ_WRITE_OR_SEND_MASK	= WR_READ_OR_WRITE_MASK | WR_SEND_MASK,
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 682f30bb3495..39ca88030d3a 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -524,9 +524,9 @@ static void save_state(struct rxe_send_wqe *wqe,
 		       struct rxe_send_wqe *rollback_wqe,
 		       u32 *rollback_psn)
 {
-	rollback_wqe->state     = wqe->state;
+	rollback_wqe->state	= wqe->state;
 	rollback_wqe->first_psn = wqe->first_psn;
-	rollback_wqe->last_psn  = wqe->last_psn;
+	rollback_wqe->last_psn	= wqe->last_psn;
 	*rollback_psn		= qp->req.psn;
 }
 
@@ -559,6 +559,8 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 int rxe_requester(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mr *mr;
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
 	struct rxe_send_wqe *wqe;
@@ -594,11 +596,9 @@ int rxe_requester(void *arg)
 	if (unlikely(!wqe))
 		goto exit;
 
-	if (wqe->mask & WR_REG_MASK) {
-		if (wqe->wr.opcode == IB_WR_LOCAL_INV) {
-			struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-			struct rxe_mr *mr;
-
+	if (wqe->mask & WR_LOCAL_MASK) {
+		switch (wqe->wr.opcode) {
+		case IB_WR_LOCAL_INV:
 			mr = rxe_pool_get_key(&rxe->mr_pool,
 					      &wqe->wr.ex.invalidate_rkey);
 			if (!mr) {
@@ -606,15 +606,15 @@ int rxe_requester(void *arg)
 				       wqe->wr.ex.invalidate_rkey);
 				wqe->state = wqe_state_error;
 				wqe->status = IB_WC_MW_BIND_ERR;
-				goto exit;
+				goto err;
 			}
 			mr->state = RXE_MEM_STATE_FREE;
 			rxe_drop_ref(mr);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-		} else if (wqe->wr.opcode == IB_WR_REG_MR) {
-			struct rxe_mr *mr = to_rmr(wqe->wr.wr.reg.mr);
-
+			break;
+		case IB_WR_REG_MR:
+			mr = to_rmr(wqe->wr.wr.reg.mr);
 			mr->state = RXE_MEM_STATE_VALID;
 			mr->access = wqe->wr.wr.reg.access;
 			mr->lkey = wqe->wr.wr.reg.key;
@@ -622,14 +622,30 @@ int rxe_requester(void *arg)
 			mr->iova = wqe->wr.wr.reg.mr->iova;
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-		} else {
-			goto exit;
+			break;
+		case IB_WR_BIND_MW:
+			ret = rxe_bind_mw(qp, wqe);
+			if (ret) {
+				wqe->state = wqe_state_done;
+				wqe->status = IB_WC_MW_BIND_ERR;
+				goto err;
+			}
+			wqe->state = wqe_state_done;
+			wqe->status = IB_WC_SUCCESS;
+			break;
+		default:
+			pr_err_once("unexpected LOCAL WR opcode = %d\n",
+					wqe->wr.opcode);
+			goto err;
 		}
+
+		qp->req.wqe_index = next_index(qp->sq.queue,
+					       qp->req.wqe_index);
+
 		if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
 		    qp->sq_sig_type == IB_SIGNAL_ALL_WR)
 			rxe_run_task(&qp->comp.task, 1);
-		qp->req.wqe_index = next_index(qp->sq.queue,
-						qp->req.wqe_index);
+
 		goto next_wqe;
 	}
 
@@ -649,6 +665,7 @@ int rxe_requester(void *arg)
 	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
 	if (unlikely(opcode < 0)) {
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
+		/* TODO this should be goto err */
 		goto exit;
 	}
 
@@ -678,8 +695,7 @@ int rxe_requester(void *arg)
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 			__rxe_do_task(&qp->comp.task);
-			rxe_drop_ref(qp);
-			return 0;
+			goto again;
 		}
 		payload = mtu;
 	}
@@ -687,12 +703,14 @@ int rxe_requester(void *arg)
 	skb = init_req_packet(qp, wqe, opcode, payload, &pkt);
 	if (unlikely(!skb)) {
 		pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		goto err;
 	}
 
 	if (fill_packet(qp, wqe, &pkt, skb, payload)) {
 		pr_debug("qp#%d Error during fill packet\n", qp_num(qp));
 		kfree_skb(skb);
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		goto err;
 	}
 
@@ -716,6 +734,7 @@ int rxe_requester(void *arg)
 			goto exit;
 		}
 
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		goto err;
 	}
 
@@ -724,11 +743,35 @@ int rxe_requester(void *arg)
 	goto next_wqe;
 
 err:
-	wqe->status = IB_WC_LOC_PROT_ERR;
+	/* we come here if an error occurred while processing
+	 * a send wqe. The completer will put the qp in error
+	 * state and no more wqes will be processed unless
+	 * the qp is cleaned up and restarted. We do not want
+	 * to be called again
+	 */
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);
+	ret = -EAGAIN;
+	goto done;
 
 exit:
+	/* we come here if either there are no more wqes in the send
+	 * queue or we are blocked waiting for some resource or event.
+	 * The current wqe will be restarted or new wqe started when
+	 * there is work to do or we can complete the current wqe.
+	 */
+	ret = -EAGAIN;
+	goto done;
+
+again:
+	/* we come here if we are done with the current wqe but want to
+	 * get called again. Mostly we loop back to next wqe so should
+	 * be all one way or the other
+	 */
+	ret = 0;
+	goto done;
+
+done:
 	rxe_drop_ref(qp);
-	return -EAGAIN;
+	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 96fea64ba02d..21582507ed32 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -577,7 +577,7 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
 			p += sge->length;
 		}
-	} else if (mask & WR_REG_MASK) {
+	} else if (mask & WR_LOCAL_MASK) {
 		wqe->mask = mask;
 		wqe->state = wqe_state_posted;
 		return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 2233630fea7f..2fb5581edd8a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -316,9 +316,16 @@ struct rxe_mr {
 	u32			max_buf;
 	u32			num_map;
 
+	atomic_t		num_mw;
+
 	struct rxe_map		**map;
 };
 
+enum rxe_send_flags {
+	/* flag indicaes bind call came through verbs API */
+	RXE_BIND_MW		= (1 << 0),
+};
+
 /* use high order bit to separate MW and MR rkeys */
 #define IS_MW  (1 << 31)
 
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index 4ad0fa0b2ab9..d49125682359 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -93,7 +93,39 @@ struct rxe_send_wr {
 			__u32	remote_qkey;
 			__u16	pkey_index;
 		} ud;
-		/* reg is only used by the kernel and is not part of the uapi */
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			union {
+				__u32		mr_index;
+				__aligned_u64	reserved1;
+			};
+			union {
+				__u32		mw_index;
+				__aligned_u64	reserved2;
+			};
+			__u32	rkey;
+			__u32	access;
+			__u32	flags;
+		} umw;
+		/* The following are only used by the kernel
+		 * and are not part of the uapi
+		 */
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			union {
+				struct ib_mr	*mr;
+				__aligned_u64	reserved1;
+			};
+			union {
+				struct ib_mw	*mw;
+				__aligned_u64	reserved2;
+			};
+			__u32	rkey;
+			__u32	access;
+			__u32	flags;
+		} kmw;
 		struct {
 			union {
 				struct ib_mr *mr;
-- 
2.25.1

