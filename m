Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FD36002B
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Apr 2021 04:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhDOCzg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Apr 2021 22:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhDOCzg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Apr 2021 22:55:36 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA35C061756
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:12 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id o13-20020a9d404d0000b029028e0a0ae6b4so2261468oti.10
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nDzocN5htwCRKz4LpPkUQhPP0guWctQm3P0t0sULE58=;
        b=W1YbpDM9vnhEVW4CbcXX723zgS0K87s6ELQ2WlH+BZslBssgzaT/CumMaKFW5DOQfG
         trfnsuVg5jeHune4/42ZFChY77+/jptmSsk3yq66CYQM6/0QnrqF7I44pYMkB4t4I79o
         1DCS3Pthl4T6MGGrNWE+56IOU+M9qs4UorWiIwT8bO/gZOmLimL7M0YiWZ7Ecrm3YCHB
         Zox1E7uNZr2oyHvr+3EivlsVKpOp4vuYPywZk7kNTKDmxmAicttVB1dg11WypqaIt7+P
         1gF6XD3n0bYl7Gu2u+iMT80oThEJgOxiQFRdPlLxEH1SWk75nyNPPXmSV0kl5Mjz+y8k
         +PDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nDzocN5htwCRKz4LpPkUQhPP0guWctQm3P0t0sULE58=;
        b=HUV4tXcusHAJP/0q+GOIf3jFWbJoJCWXP1hqMQLE5wRLWQIdKRiskMrghqjtkowPet
         AB+q25ikHzLXaLU37NvDZAZGQISOW8zw4mI/Gzq8Zq2fM58oIqBQyjJNCO7dyUxm8dMC
         vHk4zqeAHDP2dQZ+WGaVAW5mP5pu2p0cZshggYiC/V8SQUWF4d97XCgfSMRETE7HuJir
         MhDclVbi+6ZKB+KpH1Qmt7h+mCvGInvjhPisr+otwqrfJ+lmtGv06fA/5TCqTh+4dolN
         kVW+Zy5VhNrfxkPi5u+aBDXeLuzElnKznJnRAK/KxBGqKpceh5oRFBpUSZAkRDIRB8db
         Rrpw==
X-Gm-Message-State: AOAM531RpFHUkWIuxSlKYKXjefKkF/XNRQaDjWOXmTcKylPKUudlfgvq
        5ka1gQ9BAWmYeRfkUjTIvBrX0Kxrhbk=
X-Google-Smtp-Source: ABdhPJyMWM/A2ONo2y/a0q7JY8xf11BwoM697OWQ3zeNbbxt4a+9R7fLyGHB6e9FySR87bkJeL03Pw==
X-Received: by 2002:a9d:1e83:: with SMTP id n3mr916119otn.233.1618455312372;
        Wed, 14 Apr 2021 19:55:12 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9ee3-9764-577f-477e.res6.spectrum.com. [2603:8081:140c:1a00:9ee3:9764:577f:477e])
        by smtp.gmail.com with ESMTPSA id a7sm328448ooo.30.2021.04.14.19.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 19:55:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2 8/9] RDMA/rxe: Implement invalidate MW operations
Date:   Wed, 14 Apr 2021 21:54:29 -0500
Message-Id: <20210415025429.11053-9-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210415025429.11053-1-rpearson@hpe.com>
References: <20210415025429.11053-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement invalidate MW and cleaned up invalidate MR operations.

Added code to perform remote invalidate for send with invalidate.
Added code to perform local invalidation.
Deleted some blank lines in rxe_loc.h.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   | 23 ++++-----
 drivers/infiniband/sw/rxe/rxe_mr.c    | 59 +++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_mw.c    | 67 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_req.c   | 22 +++++----
 drivers/infiniband/sw/rxe/rxe_resp.c  | 52 +++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 23 +++++----
 6 files changed, 178 insertions(+), 68 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index e6f574973298..7f1117c51e30 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -76,41 +76,34 @@ enum copy_direction {
 	from_mr_obj,
 };
 
+enum lookup_type {
+	lookup_local,
+	lookup_remote,
+};
+
 u8 rxe_get_next_key(u32 last_key);
 void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr);
-
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		     int access, struct ib_udata *udata, struct rxe_mr *mr);
-
 int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr);
-
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum copy_direction dir, u32 *crcp);
-
 int copy_data(struct rxe_pd *pd, int access,
 	      struct rxe_dma_info *dma, void *addr, int length,
 	      enum copy_direction dir, u32 *crcp);
-
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
-
-enum lookup_type {
-	lookup_local,
-	lookup_remote,
-};
-
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum lookup_type type);
-
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
-
-void rxe_mr_cleanup(struct rxe_pool_entry *arg);
-
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
+int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
+void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_mw.c */
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
+int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 7f2cfc1ce659..0f1791ed0350 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -55,21 +55,6 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->map_shift = ilog2(RXE_BUF_PER_MAP);
 }
 
-void rxe_mr_cleanup(struct rxe_pool_entry *arg)
-{
-	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
-	int i;
-
-	ib_umem_release(mr->umem);
-
-	if (mr->map) {
-		for (i = 0; i < mr->num_map; i++)
-			kfree(mr->map[i]);
-
-		kfree(mr->map);
-	}
-}
-
 static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
 {
 	int i;
@@ -540,3 +525,47 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 
 	return mr;
 }
+
+int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mr *mr;
+	int ret;
+
+	mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
+	if (!mr) {
+		pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (rkey != mr->ibmr.rkey) {
+		pr_err("%s: rkey (%#x) doesn't match mr->ibmr.rkey (%#x)\n",
+			__func__, rkey, mr->ibmr.rkey);
+		ret = -EINVAL;
+		goto err_drop_ref;
+	}
+
+	mr->state = RXE_MR_STATE_FREE;
+	ret = 0;
+
+err_drop_ref:
+	rxe_drop_ref(mr);
+err:
+	return ret;
+}
+
+void rxe_mr_cleanup(struct rxe_pool_entry *arg)
+{
+	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
+	int i;
+
+	ib_umem_release(mr->umem);
+
+	if (mr->map) {
+		for (i = 0; i < mr->num_map; i++)
+			kfree(mr->map[i]);
+
+		kfree(mr->map);
+	}
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 6ced54126b72..4c1830b4a8bf 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -247,6 +247,73 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	return ret;
 }
 
+static int check_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
+{
+	if (unlikely(mw->state == RXE_MW_STATE_INVALID))
+		return -EINVAL;
+
+	/* o10-37.2.26 */
+	if (unlikely(mw->ibmw.type == IB_MW_TYPE_1))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void do_invalidate_mw(struct rxe_mw *mw)
+{
+	struct rxe_qp *qp;
+	struct rxe_mr *mr;
+
+	/* valid type 2 MW will always have a QP pointer */
+	qp = mw->qp;
+	mw->qp = NULL;
+	rxe_drop_ref(qp);
+
+	/* valid type 2 MW will always have an MR pointer */
+	mr = mw->mr;
+	mw->mr = NULL;
+	atomic_dec(&mr->num_mw);
+	rxe_drop_ref(mr);
+
+	mw->access = 0;
+	mw->addr = 0;
+	mw->length = 0;
+	mw->state = RXE_MW_STATE_FREE;
+}
+
+int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	unsigned long flags;
+	struct rxe_mw *mw;
+	int ret;
+
+	mw = rxe_pool_get_index(&rxe->mw_pool, rkey >> 8);
+	if (!mw) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (rkey != mw->ibmw.rkey) {
+		ret = -EINVAL;
+		goto err_drop_ref;
+	}
+
+	spin_lock_irqsave(&mw->lock, flags);
+
+	ret = check_invalidate_mw(qp, mw);
+	if (ret)
+		goto err_unlock;
+
+	do_invalidate_mw(mw);
+err_unlock:
+	spin_unlock_irqrestore(&mw->lock, flags);
+err_drop_ref:
+	rxe_drop_ref(mw);
+err:
+	return ret;
+}
+
 void rxe_mw_cleanup(struct rxe_pool_entry *elem)
 {
 	struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 243602584a28..66fc208d0ec1 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -558,25 +558,25 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 static int do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 {
 	u8 opcode = wqe->wr.opcode;
-	struct rxe_dev *rxe;
 	struct rxe_mr *mr;
-	u32 rkey;
 	int ret;
+	u32 rkey;
 
 	switch (opcode) {
 	case IB_WR_LOCAL_INV:
-		rxe = to_rdev(qp->ibqp.device);
 		rkey = wqe->wr.ex.invalidate_rkey;
-		mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
-		if (!mr) {
-			pr_err("No MR for rkey %#x\n", rkey);
+		if (rkey_is_mw(rkey))
+			ret = rxe_invalidate_mw(qp, rkey);
+		else
+			ret = rxe_invalidate_mr(qp, rkey);
+
+		if (ret) {
 			wqe->state = wqe_state_error;
 			wqe->status = IB_WC_LOC_QP_OP_ERR;
-			return -EINVAL;
+			return ret;
 		}
-		mr->state = RXE_MR_STATE_FREE;
-		rxe_drop_ref(mr);
 		break;
+
 	case IB_WR_REG_MR:
 		mr = to_rmr(wqe->wr.wr.reg.mr);
 
@@ -588,14 +588,16 @@ static int do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		mr->iova = wqe->wr.wr.reg.mr->iova;
 		rxe_drop_ref(mr);
 		break;
+
 	case IB_WR_BIND_MW:
 		ret = rxe_bind_mw(qp, wqe);
 		if (ret) {
 			wqe->state = wqe_state_error;
 			wqe->status = IB_WC_MW_BIND_ERR;
-			return -EINVAL;
+			return ret;
 		}
 		break;
+
 	default:
 		pr_err("Unexpected send wqe opcode %d\n", opcode);
 		wqe->state = wqe_state_error;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 2b220659bddb..21adc9209107 100644
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
@@ -751,6 +753,14 @@ static void build_rdma_network_hdr(union rdma_network_hdr *hdr,
 		memcpy(&hdr->ibgrh, ipv6_hdr(skb), sizeof(hdr->ibgrh));
 }
 
+static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
+{
+	if (rkey_is_mw(rkey))
+		return rxe_invalidate_mw(qp, rkey);
+	else
+		return rxe_invalidate_mr(qp, rkey);
+}
+
 /* Executes a new request. A retried request never reach that function (send
  * and writes are discarded, and reads and atomics are retried elsewhere.
  */
@@ -790,6 +800,14 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		WARN_ON_ONCE(1);
 	}
 
+	if (pkt->mask & RXE_IETH_MASK) {
+		u32 rkey = ieth_rkey(pkt);
+
+		err = invalidate_rkey(qp, rkey);
+		if (err)
+			return RESPST_ERR_INVALIDATE_RKEY;
+	}
+
 	/* next expected psn, read handles this separately */
 	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
 	qp->resp.ack_psn = qp->resp.psn;
@@ -822,13 +840,13 @@ static enum resp_states do_complete(struct rxe_qp *qp,
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
 
 	if (wc->status == IB_WC_SUCCESS) {
@@ -883,27 +901,14 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 			}
 
 			if (pkt->mask & RXE_IETH_MASK) {
-				struct rxe_mr *rmr;
-
 				wc->wc_flags |= IB_WC_WITH_INVALIDATE;
 				wc->ex.invalidate_rkey = ieth_rkey(pkt);
-
-				rmr = rxe_pool_get_index(&rxe->mr_pool,
-							 wc->ex.invalidate_rkey >> 8);
-				if (unlikely(!rmr)) {
-					pr_err("Bad rkey %#x invalidation\n",
-					       wc->ex.invalidate_rkey);
-					return RESPST_ERROR;
-				}
-				rmr->state = RXE_MR_STATE_FREE;
-				rxe_drop_ref(rmr);
 			}
 
-			wc->qp			= &qp->ibqp;
-
 			if (pkt->mask & RXE_DETH_MASK)
 				wc->src_qp = deth_sqp(pkt);
 
+			wc->qp			= &qp->ibqp;
 			wc->port_num		= qp->attr.port_num;
 		}
 	}
@@ -1314,6 +1319,13 @@ int rxe_responder(void *arg)
 			}
 			break;
 
+		case RESPST_ERR_INVALIDATE_RKEY:
+			/* RC - Class J. */
+			qp->resp.goto_error = 1;
+			qp->resp.status = IB_WC_REM_INV_REQ_ERR;
+			state = RESPST_COMPLETE;
+			break;
+
 		case RESPST_ERR_LENGTH:
 			if (qp_type(qp) == IB_QPT_RC) {
 				/* Class C */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 7da47b8c707b..b286a14ec282 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -286,6 +286,13 @@ struct rxe_map {
 	struct rxe_phys_buf	buf[RXE_BUF_PER_MAP];
 };
 
+static inline int rkey_is_mw(u32 rkey)
+{
+	u32 index = rkey >> 8;
+
+	return (index >= RXE_MIN_MW_INDEX) && (index <= RXE_MAX_MW_INDEX);
+}
+
 struct rxe_mr {
 	struct rxe_pool_entry	pelem;
 	struct ib_mr		ibmr;
@@ -311,23 +318,23 @@ struct rxe_mr {
 	u32			max_buf;
 	u32			num_map;
 
-	struct rxe_map		**map;
-
 	atomic_t		num_mw;
+
+	struct rxe_map		**map;
 };
 
 enum rxe_mw_state {
-	RXE_MW_STATE_INVALID = RXE_MR_STATE_INVALID,
-	RXE_MW_STATE_FREE = RXE_MR_STATE_FREE,
-	RXE_MW_STATE_VALID = RXE_MR_STATE_VALID,
+	RXE_MW_STATE_INVALID	= RXE_MR_STATE_INVALID,
+	RXE_MW_STATE_FREE	= RXE_MR_STATE_FREE,
+	RXE_MW_STATE_VALID	= RXE_MR_STATE_VALID,
 };
 
 struct rxe_mw {
-	struct			ib_mw ibmw;
-	struct			rxe_pool_entry pelem;
+	struct ib_mw		ibmw;
+	struct rxe_pool_entry	pelem;
 	spinlock_t		lock;
 	enum rxe_mw_state	state;
-	struct rxe_qp		*qp;	/* Type 2 only */
+	struct rxe_qp		*qp; /* Type 2 only */
 	struct rxe_mr		*mr;
 	int			access;
 	u64			addr;
-- 
2.27.0

