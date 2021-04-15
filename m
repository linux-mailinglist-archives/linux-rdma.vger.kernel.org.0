Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D7F360029
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Apr 2021 04:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhDOCzf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Apr 2021 22:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhDOCze (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Apr 2021 22:55:34 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2D8C06175F
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:12 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so21304792otb.7
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iD3kxQsG5kpTTm+zV72cXqp7FGJ7/xY4xIhZEPX8orw=;
        b=Y7OeJZGzaSv1x8yTlI9ZCCwejw/XK0SfSpY8IhpwbeXFaWs3wWIqoveNNGQvIQJvWQ
         RY92wAMOYCgC2Cp3Hsj2huWJf+pEKjPopl4jc9VSQ7MX8/lehYBYNDyHgj6JkSeQhv4P
         dnQswP+jlbJlEfFQWTOuN4L9xY1e+qPABpMBrHHeOoerFa3Oo6LLVi7CdApsKHPwGqyj
         Hbb81Ery5j5cF3dkNU2zfVuOn7zP8d0ZItqYLT3V5HNGw/wypQwuwZaEJIlapCRI0Jsp
         9jrqxadOEff5mH+MA44e64e3SDWM0U0o7uU1l7qadF2SDGxBIRLY4Ut1/vpLaZjYhMSX
         eEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iD3kxQsG5kpTTm+zV72cXqp7FGJ7/xY4xIhZEPX8orw=;
        b=ZDLbycqqPw3RWoSTCyOh9rO5STACnZYLKAb7YrMvCJFTO7sTq3lnlQuRRQSFe473Sd
         yp9XdVQTZZ905Ngfow/LL/DH484bA2MiYLua+HMa5aEAmIvodY2E9+KSBReIo5JmkeoC
         SnSiuO+CYeTfhUwCrwyhLN0CE6PCdE7NQep4lKGvC6cXSd8swUXwpxNiobiZVYBEf0RL
         PGrPdOMp0UnlLKwVPD8iyTrq3GgFik96V3hE2yb1HxsCDTTpYFqU5RS79M0DAND2SZih
         S6qshK7ft6TRZyLXHSCtZ8NG+B6DsPcss4bLV57HnX0alrJRXblzlkeKmBF5wONkPAwF
         A58w==
X-Gm-Message-State: AOAM532TuJjwYJ0c44k+WciwTrS6GGxkqmryZ/ldln31fcerooPn+aZu
        HDoGf7aoXT+aXepQMoutC/JitZ04Dm8=
X-Google-Smtp-Source: ABdhPJx0BKWtkKAnu2l00mnzcfFgSGJJB+uzCuHJgR4oOOx5Oz7zutGXneSj4exO5lXanolQs1iuBA==
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr894657otp.169.1618455311577;
        Wed, 14 Apr 2021 19:55:11 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9ee3-9764-577f-477e.res6.spectrum.com. [2603:8081:140c:1a00:9ee3:9764:577f:477e])
        by smtp.gmail.com with ESMTPSA id y67sm364456otb.1.2021.04.14.19.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 19:55:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2 7/9] RDMA/rxe: Add support for bind MW work requests
Date:   Wed, 14 Apr 2021 21:54:28 -0500
Message-Id: <20210415025429.11053-8-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210415025429.11053-1-rpearson@hpe.com>
References: <20210415025429.11053-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support for bind MW work requests from user space.
Since rdma/core does not support bind mw in ib_send_wr
there is no way to support bind mw in kernel space.

Added bind_mw local operation in rxe_req.c
Added bind_mw WR operation in rxe_opcode.c
Added bind_mw WC in rxe_comp.c
Added additional fields to rxe_mw in rxe_verbs.h
Added do_dealloc_mw() subroutine to cleanup an mw
when rxe_dealloc_mw is called.
Added code to implement bind_mw operation in rxe_mw.c

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
v2:
  Dropped kernel support for bind_mw in rxe_mw.c
  Replaced umw with mw in rxe_send_wr.

 drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
 drivers/infiniband/sw/rxe/rxe_loc.h    |   1 +
 drivers/infiniband/sw/rxe/rxe_mw.c     | 204 ++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.c |   7 +
 drivers/infiniband/sw/rxe/rxe_req.c    |   9 ++
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  15 +-
 6 files changed, 232 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 2af26737d32d..bc5488af5f55 100644
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
index edf575930a98..e6f574973298 100644
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
index 69128e298d44..6ced54126b72 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -29,6 +29,29 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	return 0;
 }
 
+static void do_dealloc_mw(struct rxe_mw *mw)
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
+	do_dealloc_mw(mw);
 	spin_unlock_irqrestore(&mw->lock, flags);
 
 	rxe_drop_ref(mw);
@@ -45,6 +68,185 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	return 0;
 }
 
+static int check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
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
+static int do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
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
+	ret = check_bind_mw(qp, wqe, mw, mr);
+	if (ret)
+		goto err_unlock;
+
+	ret = do_bind_mw(qp, wqe, mw, mr);
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
index 0cf97e3db29f..243602584a28 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -561,6 +561,7 @@ static int do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	struct rxe_dev *rxe;
 	struct rxe_mr *mr;
 	u32 rkey;
+	int ret;
 
 	switch (opcode) {
 	case IB_WR_LOCAL_INV:
@@ -587,6 +588,14 @@ static int do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		mr->iova = wqe->wr.wr.reg.mr->iova;
 		rxe_drop_ref(mr);
 		break;
+	case IB_WR_BIND_MW:
+		ret = rxe_bind_mw(qp, wqe);
+		if (ret) {
+			wqe->state = wqe_state_error;
+			wqe->status = IB_WC_MW_BIND_ERR;
+			return -EINVAL;
+		}
+		break;
 	default:
 		pr_err("Unexpected send wqe opcode %d\n", opcode);
 		wqe->state = wqe_state_error;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index c8597ae8c833..7da47b8c707b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -312,6 +312,8 @@ struct rxe_mr {
 	u32			num_map;
 
 	struct rxe_map		**map;
+
+	atomic_t		num_mw;
 };
 
 enum rxe_mw_state {
@@ -321,10 +323,15 @@ enum rxe_mw_state {
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
2.27.0

