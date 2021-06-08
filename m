Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EF039EDB4
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 06:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFHE3X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 00:29:23 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40762 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhFHE3X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 00:29:23 -0400
Received: by mail-ot1-f54.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso19062450otu.7
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 21:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x79LBNecSFH6i9+OWuHb1JpoGoEyheMjS2mhGoy755Q=;
        b=dvGbHASdc/w0rFdbQluQVyr69SSMwdpI9u7RZmNQV6pCxLgPq7vd04nLuva0+ifaDS
         x2UXHiEGp6JL7hCOvVBdRttsjjKWtoJaPBk0Ry9OVlglTT2NJJ52zixmypSh/GIFBYnA
         phvB6UgVPaTvMXhyr91yPOBYmtqntFolARqYbed3Fd/cb7O615ntoMRwtFvkLBsZmwWG
         YE1uPK3GW6WTR7AZJut1pBIGGVZWfZRbp9n9r1Hfh1RDg3jExVPYgYO9SeSS4nl40w+P
         I6mdL7zOysgI2gUaToUaadIb7u8eX3DGNvWzFmgcI3vxKyLtYYT9oqF3g9E4y4Vo46Sy
         eZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x79LBNecSFH6i9+OWuHb1JpoGoEyheMjS2mhGoy755Q=;
        b=K2lLTS86/jy9hKwoGju1XaZVRnkM04M7QhA+v5hhhY8Nq2XYxhw6MhCPcQ+5RJ+00/
         U60WKMYEuMEnbw0A27efd3TBF6jqo6Er14T7upVVcT0hZ/4AVRphWATyz7c6ahK374vo
         HiXPMFL8hv0G9TzJ80fFjgA4tSXrqr/lMH/USDRxqlTa4R58C+VCdSUACt5fUmzGLnya
         uM8qIj8QRIm6JQGiTGynOfPtX5um71uKROpFwN9MxpERkNSCo8ztCx778X6X0xdKbbex
         wcEWkiKUqOySp3SCwRi0TBELcBYb3AnC/a6Yz9G0e8gRBtAYbqEPIs3vMGkZvBJs/2dp
         2U7w==
X-Gm-Message-State: AOAM53316LS1qEwkBKBxrjDaI9MesRvY6+UXqx7cp8CkAuKrvLYjPEuM
        jVftS7c3Rc6Gp4FCPMc56ZplAvPZIt0=
X-Google-Smtp-Source: ABdhPJwErxBDNMM8ztbIQZmoiX1U+EjYCjg7l31WNuV4pP9PTmEBwSUZsN6kHTZRntxgC0hdL1cDUg==
X-Received: by 2002:a9d:475:: with SMTP id 108mr15513366otc.69.1623126377277;
        Mon, 07 Jun 2021 21:26:17 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-cb25-4f27-0965-41cc.res6.spectrum.com. [2603:8081:140c:1a00:cb25:4f27:965:41cc])
        by smtp.gmail.com with ESMTPSA id v14sm561428ote.15.2021.06.07.21.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 21:26:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, monis@mellanox.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v9 07/10] RDMA/rxe: Add support for bind MW work requests
Date:   Mon,  7 Jun 2021 23:25:50 -0500
Message-Id: <20210608042552.33275-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608042552.33275-1-rpearsonhpe@gmail.com>
References: <20210608042552.33275-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support for bind MW work requests from user space.  Since rdma/core
does not support bind mw in ib_send_wr there is no way to support bind
mw in kernel space.

Added bind_mw local operation in rxe_req.c. Added bind_mw WR operation
in rxe_opcode.c. Added bind_mw WC in rxe_comp.c.  Added additional
fields to rxe_mw in rxe_verbs.h. Added rxe_do_dealloc_mw() subroutine
to cleanup an mw when rxe_dealloc_mw is called.  Added code to implement
bind_mw operation in rxe_mw.c

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
 drivers/infiniband/sw/rxe/rxe_loc.h    |   1 +
 drivers/infiniband/sw/rxe/rxe_mw.c     | 202 ++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.c |   7 +
 drivers/infiniband/sw/rxe/rxe_req.c    |   8 +
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  15 +-
 6 files changed, 229 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 32e587c47637..02bc93e186cc 100644
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
index 422b9481d5f6..e97048e77451 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -110,6 +110,7 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 /* rxe_mw.c */
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
+int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 69128e298d44..65215dde9974 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -29,6 +29,29 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	return 0;
 }
 
+static void rxe_do_dealloc_mw(struct rxe_mw *mw)
+{
+	if (mw->mr) {
+		struct rxe_mr *mr = mw->mr;
+
+		mw->mr = NULL;
+		atomic_dec(&mr->num_mw);
+		rxe_drop_ref(mr);
+	}
+
+	if (mw->qp) {
+		struct rxe_qp *qp = mw->qp;
+
+		mw->qp = NULL;
+		rxe_drop_ref(qp);
+	}
+
+	mw->access = 0;
+	mw->addr = 0;
+	mw->length = 0;
+	mw->state = RXE_MW_STATE_INVALID;
+}
+
 int rxe_dealloc_mw(struct ib_mw *ibmw)
 {
 	struct rxe_mw *mw = to_rmw(ibmw);
@@ -36,7 +59,7 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	unsigned long flags;
 
 	spin_lock_irqsave(&mw->lock, flags);
-	mw->state = RXE_MW_STATE_INVALID;
+	rxe_do_dealloc_mw(mw);
 	spin_unlock_irqrestore(&mw->lock, flags);
 
 	rxe_drop_ref(mw);
@@ -45,6 +68,183 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	return 0;
 }
 
+static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+			 struct rxe_mw *mw, struct rxe_mr *mr)
+{
+	if (mw->ibmw.type == IB_MW_TYPE_1) {
+		if (unlikely(mw->state != RXE_MW_STATE_VALID)) {
+			pr_err_once(
+				"attempt to bind a type 1 MW not in the valid state\n");
+			return -EINVAL;
+		}
+
+		/* o10-36.2.2 */
+		if (unlikely((mw->access & IB_ZERO_BASED))) {
+			pr_err_once("attempt to bind a zero based type 1 MW\n");
+			return -EINVAL;
+		}
+	}
+
+	if (mw->ibmw.type == IB_MW_TYPE_2) {
+		/* o10-37.2.30 */
+		if (unlikely(mw->state != RXE_MW_STATE_FREE)) {
+			pr_err_once(
+				"attempt to bind a type 2 MW not in the free state\n");
+			return -EINVAL;
+		}
+
+		/* C10-72 */
+		if (unlikely(qp->pd != to_rpd(mw->ibmw.pd))) {
+			pr_err_once(
+				"attempt to bind type 2 MW with qp with different PD\n");
+			return -EINVAL;
+		}
+
+		/* o10-37.2.40 */
+		if (unlikely(!mr || wqe->wr.wr.mw.length == 0)) {
+			pr_err_once(
+				"attempt to invalidate type 2 MW by binding with NULL or zero length MR\n");
+			return -EINVAL;
+		}
+	}
+
+	if (unlikely((wqe->wr.wr.mw.rkey & 0xff) == (mw->ibmw.rkey & 0xff))) {
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
+	/* C10-73 */
+	if (unlikely(!(mr->access & IB_ACCESS_MW_BIND))) {
+		pr_err_once(
+			"attempt to bind an MW to an MR without bind access\n");
+		return -EINVAL;
+	}
+
+	/* C10-74 */
+	if (unlikely((mw->access &
+		      (IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_ATOMIC)) &&
+		     !(mr->access & IB_ACCESS_LOCAL_WRITE))) {
+		pr_err_once(
+			"attempt to bind an writeable MW to an MR without local write access\n");
+		return -EINVAL;
+	}
+
+	/* C10-75 */
+	if (mw->access & IB_ZERO_BASED) {
+		if (unlikely(wqe->wr.wr.mw.length > mr->length)) {
+			pr_err_once(
+				"attempt to bind a ZB MW outside of the MR\n");
+			return -EINVAL;
+		}
+	} else {
+		if (unlikely((wqe->wr.wr.mw.addr < mr->iova) ||
+			     ((wqe->wr.wr.mw.addr + wqe->wr.wr.mw.length) >
+			      (mr->iova + mr->length)))) {
+			pr_err_once(
+				"attempt to bind a VA MW outside of the MR\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static void rxe_do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+		      struct rxe_mw *mw, struct rxe_mr *mr)
+{
+	u32 rkey;
+	u32 new_rkey;
+
+	rkey = mw->ibmw.rkey;
+	new_rkey = (rkey & 0xffffff00) | (wqe->wr.wr.mw.rkey & 0x000000ff);
+
+	mw->ibmw.rkey = new_rkey;
+	mw->access = wqe->wr.wr.mw.access;
+	mw->state = RXE_MW_STATE_VALID;
+	mw->addr = wqe->wr.wr.mw.addr;
+	mw->length = wqe->wr.wr.mw.length;
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
+	if (mw->ibmw.type == IB_MW_TYPE_2) {
+		rxe_add_ref(qp);
+		mw->qp = qp;
+	}
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
+	mw = rxe_pool_get_index(&rxe->mw_pool,
+				wqe->wr.wr.mw.mw_rkey >> 8);
+	if (unlikely(!mw)) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (unlikely(mw->ibmw.rkey != wqe->wr.wr.mw.mw_rkey)) {
+		ret = -EINVAL;
+		goto err_drop_mw;
+	}
+
+	if (likely(wqe->wr.wr.mw.length)) {
+		mr = rxe_pool_get_index(&rxe->mr_pool,
+					wqe->wr.wr.mw.mr_lkey >> 8);
+		if (unlikely(!mr)) {
+			ret = -EINVAL;
+			goto err_drop_mw;
+		}
+
+		if (unlikely(mr->ibmr.lkey != wqe->wr.wr.mw.mr_lkey)) {
+			ret = -EINVAL;
+			goto err_drop_mr;
+		}
+	} else {
+		mr = NULL;
+	}
+
+	spin_lock_irqsave(&mw->lock, flags);
+
+	ret = rxe_check_bind_mw(qp, wqe, mw, mr);
+	if (ret)
+		goto err_unlock;
+
+	rxe_do_bind_mw(qp, wqe, mw, mr);
+err_unlock:
+	spin_unlock_irqrestore(&mw->lock, flags);
+err_drop_mr:
+	if (mr)
+		rxe_drop_ref(mr);
+err_drop_mw:
+	rxe_drop_ref(mw);
+err:
+	return ret;
+}
+
 void rxe_mw_cleanup(struct rxe_pool_entry *elem)
 {
 	struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 1e4b67b048f3..3ef5a10a6efd 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -96,6 +96,13 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 			[IB_QPT_RC]	= WR_LOCAL_OP_MASK,
 		},
 	},
+	[IB_WR_BIND_MW]					= {
+		.name	= "IB_WR_BIND_MW",
+		.mask	= {
+			[IB_QPT_RC]	= WR_LOCAL_OP_MASK,
+			[IB_QPT_UC]	= WR_LOCAL_OP_MASK,
+		},
+	},
 };
 
 struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 80872ec54219..6583f8ca95dc 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -584,6 +584,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	struct rxe_dev *rxe;
 	struct rxe_mr *mr;
 	u32 rkey;
+	int ret;
 
 	switch (opcode) {
 	case IB_WR_LOCAL_INV:
@@ -609,6 +610,13 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		mr->iova = wqe->wr.wr.reg.mr->iova;
 		rxe_drop_ref(mr);
 		break;
+	case IB_WR_BIND_MW:
+		ret = rxe_bind_mw(qp, wqe);
+		if (unlikely(ret)) {
+			wqe->status = IB_WC_MW_BIND_ERR;
+			return ret;
+		}
+		break;
 	default:
 		pr_err("Unexpected send wqe opcode %d\n", opcode);
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 5effb12d22cc..3d0ab8b7804f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -315,6 +315,8 @@ struct rxe_mr {
 	u32			num_map;
 
 	struct rxe_map		**map;
+
+	atomic_t		num_mw;
 };
 
 enum rxe_mw_state {
@@ -324,10 +326,15 @@ enum rxe_mw_state {
 };
 
 struct rxe_mw {
-	struct ib_mw ibmw;
-	struct rxe_pool_entry pelem;
-	spinlock_t lock;
-	enum rxe_mw_state state;
+	struct			ib_mw ibmw;
+	struct			rxe_pool_entry pelem;
+	spinlock_t		lock;
+	enum rxe_mw_state	state;
+	struct rxe_qp		*qp;	/* Type 2 only */
+	struct rxe_mr		*mr;
+	int			access;
+	u64			addr;
+	u64			length;
 };
 
 struct rxe_mc_grp {
-- 
2.30.2

