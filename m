Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CDB2805D4
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbgJARtC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732965AbgJARtB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:49:01 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDAEC0613E5
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:49:01 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u126so6461893oif.13
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIIxjMiijQKzXq2Kbweyj7CBlorEnAYCrsUgCTrnYFA=;
        b=PvVVPgfQzxaqxbq4Tn6gIcrarPobO4PzzTziDPqFS31Q2o+EH0ay+pHdNL8Mnra0QR
         Y1SanmQoGRpG+IzZzpUxDAi/zQCz/8DN+e61LrSnAxRPcuzdjC7BxTmqwR09cExcSrfM
         vUa4hubbz4ob+2EZCpuZtd9qpLADR/0mvcAjO6H+u7U8dQtNAsbUU5nTw2+hPkNK+xv7
         EBSiikF1hD2qlpRxg3s0okL0DLMimzVLMDmlu83MNvHlL7sZavkFsMud4Uth9qh3op+c
         lu8lJwNREtUCQCp2Exbcb9bVmdbXdAjhQXmgi+8C/Vkp7gR8eTxhVadLmsxSfyOOw1Wg
         ne2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIIxjMiijQKzXq2Kbweyj7CBlorEnAYCrsUgCTrnYFA=;
        b=ElDlOHBDKIOgApKHYHc9qCFJBISx6z4eOrdsTeYFcEfd4lY0EafWBs/GNOJ9p5g+uy
         TBE0/cZE8LRw992foRlgn54yp0xsa2TAOokfs/QqTxA01dpfBguqqxHnvJ9a4N369zt7
         2exxFMlDKpTHrBvQPlQXF/goHjG68yO6NL05q/Mfcs48bgIlG2yD1zy6GCkq9dYW8ThB
         aVGYr+N1TwD1524f/WVSpQe0ljMO/C1A8HRddI8vwU5vEsVSLI9ila82VpIMVGKXDCjy
         1XN431dqhTP4HzZptT6PMaJmB1GsYAxhiYbWwfO6b6JZmlYidKoqAZiYPf1MEJGJ79Ra
         fgIA==
X-Gm-Message-State: AOAM530K+raG3jlTl9cVZsVJvye0mgZQShADz1tu5WPvlWnzxVD8LyYF
        D1sCCfocClMkQo7aq3YlUno=
X-Google-Smtp-Source: ABdhPJzj7sNRHHc/NK8Jc7PL+Vr2Go+gGRc0hmQtfGmazEtv9PkH0+Q2yD2KHTKh7uB4YRLuC+aV9Q==
X-Received: by 2002:aca:aa84:: with SMTP id t126mr723402oie.5.1601574540374;
        Thu, 01 Oct 2020 10:49:00 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id 91sm1361258ott.55.2020.10.01.10.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:49:00 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 07/19] rdma_rxe: Add bind_mw and invalidate_mw verbs
Date:   Thu,  1 Oct 2020 12:48:35 -0500
Message-Id: <20201001174847.4268-8-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

v7:
 - adjust for new pool api changes
v6:
 - Add code to implement ibv_bind_mw (for type 1 MWs) and
   post send queue bind_mw (for type 2 MWs).
 - Add code to implement local (post send) and remote
   (send with invalidate) invalidate operations.
 - Add rules checking for MW operations from IBA.
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
 drivers/infiniband/sw/rxe/rxe_loc.h    |   6 +
 drivers/infiniband/sw/rxe/rxe_mr.c     |  13 +-
 drivers/infiniband/sw/rxe/rxe_mw.c     | 289 ++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h |   1 -
 drivers/infiniband/sw/rxe/rxe_req.c    | 134 +++++++++---
 drivers/infiniband/sw/rxe/rxe_resp.c   |  81 +++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c  |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h  |   7 +
 include/uapi/rdma/rdma_user_rxe.h      |  34 ++-
 11 files changed, 512 insertions(+), 67 deletions(-)

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
index 1502aa557621..0916fc8c541e 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -109,6 +109,8 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 
+int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr);
+
 /* rxe_mw.c */
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 
@@ -116,6 +118,10 @@ int rxe_dealloc_mw(struct ib_mw *ibmw);
 
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
+int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
+
+int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw);
+
 /* rxe_net.c */
 void rxe_loopback(struct sk_buff *skb);
 int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index af2d0d8877fe..a1aa5e2267d6 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -532,12 +532,23 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 	return mr;
 }
 
+int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
+{
+	/* TODO there are API rules being ignored here
+	 * cleanup later. Current project is not trying
+	 * to fix MR
+	 */
+	mr->state = RXE_MEM_STATE_FREE;
+	return 0;
+}
+
 void rxe_mr_cleanup(struct rxe_pool_entry *elem)
 {
 	struct rxe_mr *mr = container_of(elem, typeof(*mr), pelem);
 	int i;
 
-	ib_umem_release(mr->umem);
+	if (mr->umem)
+		ib_umem_release(mr->umem);
 
 	if (mr->map) {
 		for (i = 0; i < mr->num_map; i++)
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index c10e8762243f..b09a880df35a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -30,7 +30,7 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	int ret;
 
 	if (udata) {
-		if (udata->outlen < sizeof(*uresp))
+		if (unlikely(udata->outlen < sizeof(*uresp)))
 			return -EINVAL;
 		uresp = udata->outbuf;
 	}
@@ -49,10 +49,9 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 					RXE_MEM_STATE_VALID;
 
 	if (uresp) {
-		if (copy_to_user(&uresp->index, &mw->pelem.index,
-				 sizeof(uresp->index))) {
+		if (unlikely(copy_to_user(&uresp->index, &mw->pelem.index,
+				 sizeof(uresp->index)))) {
 			rxe_drop_ref(mw);
-			rxe_drop_ref(pd);
 			return -EFAULT;
 		}
 	}
@@ -60,22 +59,298 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	return 0;
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
 	spin_unlock_irqrestore(&mw->lock, flags);
 
 	rxe_drop_ref(mw);
-	rxe_drop_ref(pd);
 
 	return 0;
 }
 
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
+	duplicate_mw = rxe_get_key(&rxe->mw_pool, &new_rkey);
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
+		mw = rxe_get_index(&rxe->mw_pool,
+				   wqe->wr.wr.umw.mw_index);
+		if (!mw) {
+			pr_err_once("mw with index = %d not found\n",
+			wqe->wr.wr.umw.mw_index);
+			ret = -EINVAL;
+			goto err1;
+		}
+		mr = rxe_get_index(&rxe->mr_pool,
+				   wqe->wr.wr.umw.mr_index);
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
+	spin_unlock_irqrestore(&mw->lock, flags);
+
+	if (mr)
+		rxe_drop_ref(mr);
+err2:
+	rxe_drop_ref(mw);
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
+
+	return 0;
+}
+
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
 void rxe_mw_cleanup(struct rxe_pool_entry *elem)
 {
 	struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
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
index fe3fcc70411d..7efafb3e21eb 100644
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
 
@@ -556,9 +556,38 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			  jiffies + qp->qp_timeout_jiffies);
 }
 
+static int invalidate_key(struct rxe_qp *qp, u32 key)
+{
+	int ret;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mw *mw;
+	struct rxe_mr *mr;
+
+	if (key & IS_MW) {
+		mw = rxe_get_key(&rxe->mw_pool, &key);
+		if (!mw) {
+			pr_err("No mw for key %#x\n", key);
+			return -EINVAL;
+		}
+		ret = rxe_invalidate_mw(qp, mw);
+		rxe_drop_ref(mw);
+	} else {
+		mr = rxe_get_key(&rxe->mr_pool, &key);
+		if (!mr) {
+			pr_err("No mr for key %#x\n", key);
+			return -EINVAL;
+		}
+		ret = rxe_invalidate_mr(qp, mr);
+		rxe_drop_ref(mr);
+	}
+
+	return ret;
+}
+
 int rxe_requester(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
+	struct rxe_mr *mr;
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
 	struct rxe_send_wqe *wqe;
@@ -569,6 +598,7 @@ int rxe_requester(void *arg)
 	int ret;
 	struct rxe_send_wqe rollback_wqe;
 	u32 rollback_psn;
+	u32 key;
 
 	rxe_add_ref(qp);
 
@@ -594,42 +624,47 @@ int rxe_requester(void *arg)
 	if (unlikely(!wqe))
 		goto exit;
 
-	if (wqe->mask & WR_REG_MASK) {
-		if (wqe->wr.opcode == IB_WR_LOCAL_INV) {
-			struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-			struct rxe_mr *rmr;
-
-			rmr = rxe_get_key(&rxe->mr_pool,
-					    &wqe->wr.ex.invalidate_rkey);
-			if (!rmr) {
-				pr_err("No mr for key %#x\n",
-				       wqe->wr.ex.invalidate_rkey);
-				wqe->state = wqe_state_error;
+	if (wqe->mask & WR_LOCAL_MASK) {
+		switch (wqe->wr.opcode) {
+		case IB_WR_LOCAL_INV:
+			key = wqe->wr.ex.invalidate_rkey;
+			ret = invalidate_key(qp, key);
+			if (ret) {
+				wqe->status = IB_WC_LOC_QP_OP_ERR;
+				goto err;
+			}
+			break;
+		case IB_WR_REG_MR:
+			mr = to_rmr(wqe->wr.wr.reg.mr);
+			mr->state = RXE_MEM_STATE_VALID;
+			mr->access = wqe->wr.wr.reg.access;
+			mr->lkey = wqe->wr.wr.reg.key;
+			mr->rkey = wqe->wr.wr.reg.key;
+			mr->iova = wqe->wr.wr.reg.mr->iova;
+			break;
+		case IB_WR_BIND_MW:
+			ret = rxe_bind_mw(qp, wqe);
+			if (ret) {
+				wqe->state = wqe_state_done;
 				wqe->status = IB_WC_MW_BIND_ERR;
-				goto exit;
+				goto err;
 			}
-			rmr->state = RXE_MEM_STATE_FREE;
-			rxe_drop_ref(rmr);
-			wqe->state = wqe_state_done;
-			wqe->status = IB_WC_SUCCESS;
-		} else if (wqe->wr.opcode == IB_WR_REG_MR) {
-			struct rxe_mr *rmr = to_rmr(wqe->wr.wr.reg.mr);
-
-			rmr->state = RXE_MEM_STATE_VALID;
-			rmr->access = wqe->wr.wr.reg.access;
-			rmr->lkey = wqe->wr.wr.reg.key;
-			rmr->rkey = wqe->wr.wr.reg.key;
-			rmr->iova = wqe->wr.wr.reg.mr->iova;
-			wqe->state = wqe_state_done;
-			wqe->status = IB_WC_SUCCESS;
-		} else {
-			goto exit;
+			break;
+		default:
+			pr_err_once("unexpected LOCAL WR opcode = %d\n",
+					wqe->wr.opcode);
+			goto err;
 		}
+
+		wqe->state = wqe_state_done;
+		wqe->status = IB_WC_SUCCESS;
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
 
@@ -649,6 +684,7 @@ int rxe_requester(void *arg)
 	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
 	if (unlikely(opcode < 0)) {
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
+		/* TODO this should be goto err */
 		goto exit;
 	}
 
@@ -678,8 +714,7 @@ int rxe_requester(void *arg)
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 			__rxe_do_task(&qp->comp.task);
-			rxe_drop_ref(qp);
-			return 0;
+			goto again;
 		}
 		payload = mtu;
 	}
@@ -687,12 +722,14 @@ int rxe_requester(void *arg)
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
 
@@ -716,6 +753,7 @@ int rxe_requester(void *arg)
 			goto exit;
 		}
 
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		goto err;
 	}
 
@@ -724,11 +762,35 @@ int rxe_requester(void *arg)
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
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index cc8a0bb7530b..351faa867181 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -35,6 +35,7 @@ enum resp_states {
 	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
 	RESPST_ERR_RNR,
 	RESPST_ERR_RKEY_VIOLATION,
+	RESPST_ERR_INVALIDATE_RKEY,
 	RESPST_ERR_LENGTH,
 	RESPST_ERR_CQ_OVERFLOW,
 	RESPST_ERROR,
@@ -68,6 +69,7 @@ static char *resp_state_name[] = {
 	[RESPST_ERR_TOO_MANY_RDMA_ATM_REQ]	= "ERR_TOO_MANY_RDMA_ATM_REQ",
 	[RESPST_ERR_RNR]			= "ERR_RNR",
 	[RESPST_ERR_RKEY_VIOLATION]		= "ERR_RKEY_VIOLATION",
+	[RESPST_ERR_INVALIDATE_RKEY]		= "ERR_INVALIDATE_RKEY_VIOLATION",
 	[RESPST_ERR_LENGTH]			= "ERR_LENGTH",
 	[RESPST_ERR_CQ_OVERFLOW]		= "ERR_CQ_OVERFLOW",
 	[RESPST_ERROR]				= "ERROR",
@@ -751,6 +753,39 @@ static void build_rdma_network_hdr(union rdma_network_hdr *hdr,
 		memcpy(&hdr->ibgrh, ipv6_hdr(skb), sizeof(hdr->ibgrh));
 }
 
+static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
+{
+	int ret;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mw *mw;
+	struct rxe_mr *mr;
+
+	if (rkey & IS_MW) {
+		mw = rxe_get_key(&rxe->mw_pool, &rkey);
+		if (!mw) {
+			pr_err("No mw for rkey %#x\n", rkey);
+			goto err;
+		}
+		ret = rxe_invalidate_mw(qp, mw);
+		rxe_drop_ref(mw);
+	} else {
+		mr = rxe_get_key(&rxe->mr_pool, &rkey);
+		if (!mr || mr->ibmr.rkey != rkey) {
+			pr_err("No mr for rkey %#x\n", rkey);
+			goto err;
+		}
+		ret = rxe_invalidate_mr(qp, mr);
+		rxe_drop_ref(mr);
+	}
+
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	return RESPST_ERR_INVALIDATE_RKEY;
+}
+
 /* Executes a new request. A retried request never reach that function (send
  * and writes are discarded, and reads and atomics are retried elsewhere.
  */
@@ -790,6 +825,14 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		WARN_ON_ONCE(1);
 	}
 
+	if (pkt->mask & RXE_IETH_MASK) {
+		u32 rkey = ieth_rkey(pkt);
+
+		err = invalidate_rkey(qp, rkey);
+		if (err)
+			return err;
+	}
+
 	/* next expected psn, read handles this separately */
 	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
 	qp->resp.ack_psn = qp->resp.psn;
@@ -822,15 +865,20 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	memset(&cqe, 0, sizeof(cqe));
 
 	if (qp->rcq->is_user) {
-		uwc->status             = qp->resp.status;
-		uwc->qp_num             = qp->ibqp.qp_num;
-		uwc->wr_id              = wqe->wr_id;
+		uwc->status		= qp->resp.status;
+		uwc->qp_num		= qp->ibqp.qp_num;
+		uwc->wr_id		= wqe->wr_id;
 	} else {
-		wc->status              = qp->resp.status;
-		wc->qp                  = &qp->ibqp;
-		wc->wr_id               = wqe->wr_id;
+		wc->status		= qp->resp.status;
+		wc->qp			= &qp->ibqp;
+		wc->wr_id		= wqe->wr_id;
 	}
 
+	/* TODO nothing is returned for error WQEs but
+	 * at least some of these have important things
+	 * to report (for example send with invalidate but
+	 * rkey fails) Fix this when I clean up MR logic
+	 */
 	if (wc->status == IB_WC_SUCCESS) {
 		rxe_counter_inc(rxe, RXE_CNT_RDMA_RECV);
 		wc->opcode = (pkt->mask & RXE_IMMDT_MASK &&
@@ -883,20 +931,8 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 			}
 
 			if (pkt->mask & RXE_IETH_MASK) {
-				struct rxe_mr *rmr;
-
 				wc->wc_flags |= IB_WC_WITH_INVALIDATE;
 				wc->ex.invalidate_rkey = ieth_rkey(pkt);
-
-				rmr = rxe_get_key(&rxe->mr_pool,
-						  &wc->ex.invalidate_rkey);
-				if (unlikely(!rmr)) {
-					pr_err("Bad rkey %#x invalidation\n",
-					       wc->ex.invalidate_rkey);
-					return RESPST_ERROR;
-				}
-				rmr->state = RXE_MEM_STATE_FREE;
-				rxe_drop_ref(rmr);
 			}
 
 			wc->qp			= &qp->ibqp;
@@ -1314,6 +1350,15 @@ int rxe_responder(void *arg)
 			}
 			break;
 
+		case RESPST_ERR_INVALIDATE_RKEY:
+			/* RC Only - Class C. */
+			/* Class J */
+			qp->resp.goto_error = 1;
+			/* is there a better choice */
+			qp->resp.status = IB_WC_REM_INV_REQ_ERR;
+			state = RESPST_COMPLETE;
+			break;
+
 		case RESPST_ERR_LENGTH:
 			if (qp_type(qp) == IB_QPT_RC) {
 				/* Class C */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f9425daad924..807c9a3b22ea 100644
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
index 3253508a3b74..57849df8ccec 100644
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

