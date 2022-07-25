Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903745804F1
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jul 2022 22:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiGYUCP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jul 2022 16:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGYUCO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jul 2022 16:02:14 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD4113CC6
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jul 2022 13:02:13 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id by10-20020a056830608a00b0061c1ac80e1dso9446804otb.13
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jul 2022 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hjpjc9sFKmRyzglvAtNCt6IoEVAqaBLcTmmQa3+eCA=;
        b=Xd06mhpYTxKIxqWmWd+ujjBkd/0KXoDchEu7cw8v+Zhf8OGd66Ol6W76qyD3uaKo+2
         ItmlVvTsm2aQGdD9qyVA7FrJMnESUcLjnShsTwjC9mEEtlfgOJA3+5MgCZz7ZWiPQtYa
         ty63QQaT21/JLiA+arZcGpBDKZJ+SovRMNlouOspfTXnRrC7Y209U5pfTEUBZ783xJXY
         Y8IHptIy1oV8PGBlflOabZ8DeQdLMel4fF4WU7y6NnwAnQhzc48wvJfSb0jchkM92hHa
         D5Y3tZSCs0QbBMy0KmpfmfMwO1UI8JUNWQeWIF+uFiDhX0f9NsH49PQOIujePZ9jIcNw
         eW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hjpjc9sFKmRyzglvAtNCt6IoEVAqaBLcTmmQa3+eCA=;
        b=KH7ZZfV440rTxTcLtOM/u0D62BMq4MHGQnnXmvx7QwywWu0VDEDQsaBK6csKjmUCjd
         1/wyBNICpIiM1vGbjWhOSyF96NPx9nVMR8nQmcxH1B5u3XFesyGaSMTcA7qkyZdGsGt5
         VqlCvbFH7wYAFXt+w/orJ5ouyyHOym+cGuoOAQTYrR3LU+KsWlfLSwsNyb1Uk+LdfGpe
         usv6Rq6wxM+BC86MHaOzSzhFXcaVCi8C9vNAeuuIyaMYeh9svxrWY2XUcGSY+vgHIkyO
         /AnteeAHF8IhtA54qY09ALYhlsJDMrN0pqoYeqvi9qMldHv/NeT9Q5n98b/nJPNsuH2+
         e9VQ==
X-Gm-Message-State: AJIora+Jsmtd8LqucQyv3qId/MkZBhNAfjyAeqGsD+xSigRF2h5gT2Dw
        DA1ETMtquaeFliq9WmTqomyASv6aZsE=
X-Google-Smtp-Source: AGRyM1sAFW+Fgh9D6U/X+AJrc2/E9WcG5y3GiR2fe7MWqRhJQKN7A/R1ovIrwvH81h9zhOHF8T5KGw==
X-Received: by 2002:a05:6830:1c3:b0:61c:aca3:c57f with SMTP id r3-20020a05683001c300b0061caca3c57fmr4912591ota.269.1658779333061;
        Mon, 25 Jul 2022 13:02:13 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id t26-20020a056870601a00b0010490c6b552sm6553011oaa.35.2022.07.25.13.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:02:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     lizhijian@fujitsu.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Guard mr state with spin lock
Date:   Mon, 25 Jul 2022 15:01:15 -0500
Message-Id: <20220725200114.2666-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe driver does not guard changes to the mr state
against race conditions which can arise from races between
local operations and remote invalidate operations. This patch
adds a spinlock to the mr object and makes the state changes
atomic.

Applies to current for-next after adding the patch
Revert "RDMA/rxe: Create duplicate mapping tables for FMRs"

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 62 +++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 24 +++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  3 ++
 3 files changed, 67 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 850b80f5ad8b..1dd849eb14dd 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -61,7 +61,8 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->lkey = mr->ibmr.lkey = lkey;
 	mr->rkey = mr->ibmr.rkey = rkey;
 
-	mr->state = RXE_MR_STATE_INVALID;
+	spin_lock_init(&mr->lock);
+
 	mr->map_shift = ilog2(RXE_BUF_PER_MAP);
 }
 
@@ -109,7 +110,7 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
 
 	mr->ibmr.pd = &pd->ibpd;
 	mr->access = access;
-	mr->state = RXE_MR_STATE_VALID;
+	smp_store_release(&mr->state, RXE_MR_STATE_VALID);
 	mr->type = IB_MR_TYPE_DMA;
 }
 
@@ -182,7 +183,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	mr->iova = iova;
 	mr->va = start;
 	mr->offset = ib_umem_offset(umem);
-	mr->state = RXE_MR_STATE_VALID;
+	smp_store_release(&mr->state, RXE_MR_STATE_VALID);
 	mr->type = IB_MR_TYPE_USER;
 
 	return 0;
@@ -210,7 +211,7 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 
 	mr->ibmr.pd = &pd->ibpd;
 	mr->max_buf = max_pages;
-	mr->state = RXE_MR_STATE_FREE;
+	smp_store_release(&mr->state, RXE_MR_STATE_FREE);
 	mr->type = IB_MR_TYPE_MEM_REG;
 
 	return 0;
@@ -260,8 +261,11 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 	size_t offset;
 	int m, n;
 	void *addr;
+	enum rxe_mr_state state;
+
+	state = smp_load_acquire(&mr->state);
 
-	if (mr->state != RXE_MR_STATE_VALID) {
+	if (state != RXE_MR_STATE_VALID) {
 		pr_warn("mr not in valid state\n");
 		addr = NULL;
 		goto out;
@@ -510,15 +514,18 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 	struct rxe_mr *mr;
 	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
 	int index = key >> 8;
+	enum rxe_mr_state state;
 
 	mr = rxe_pool_get_index(&rxe->mr_pool, index);
 	if (!mr)
 		return NULL;
 
+	state = smp_load_acquire(&mr->state);
+
 	if (unlikely((type == RXE_LOOKUP_LOCAL && mr->lkey != key) ||
 		     (type == RXE_LOOKUP_REMOTE && mr->rkey != key) ||
 		     mr_pd(mr) != pd || (access && !(access & mr->access)) ||
-		     mr->state != RXE_MR_STATE_VALID)) {
+		     state != RXE_MR_STATE_VALID)) {
 		rxe_put(mr);
 		mr = NULL;
 	}
@@ -559,7 +566,18 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
 		goto err_drop_ref;
 	}
 
-	mr->state = RXE_MR_STATE_FREE;
+	spin_lock_bh(&mr->lock);
+	if (mr->state == RXE_MR_STATE_INVALID) {
+		spin_unlock_bh(&mr->lock);
+		pr_debug("%s: Attempt to invalidate mr#%d in INVALID state\n",
+			__func__, mr->elem.index);
+		ret = -EINVAL;
+		goto err_drop_ref;
+	} else {
+		mr->state = RXE_MR_STATE_FREE;
+	}
+	spin_unlock_bh(&mr->lock);
+
 	ret = 0;
 
 err_drop_ref:
@@ -581,13 +599,6 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	u32 key = wqe->wr.wr.reg.key;
 	u32 access = wqe->wr.wr.reg.access;
 
-	/* user can only register MR in free state */
-	if (unlikely(mr->state != RXE_MR_STATE_FREE)) {
-		pr_warn("%s: mr->lkey = 0x%x not free\n",
-			__func__, mr->lkey);
-		return -EINVAL;
-	}
-
 	/* user can only register mr with qp in same protection domain */
 	if (unlikely(qp->ibqp.pd != mr->ibmr.pd)) {
 		pr_warn("%s: qp->pd and mr->pd don't match\n",
@@ -602,11 +613,20 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		return -EINVAL;
 	}
 
-	mr->access = access;
-	mr->lkey = key;
-	mr->rkey = (access & IB_ACCESS_REMOTE) ? key : 0;
-	mr->iova = wqe->wr.wr.reg.mr->iova;
-	mr->state = RXE_MR_STATE_VALID;
+	spin_lock_bh(&mr->lock);
+	if (mr->state == RXE_MR_STATE_FREE) {
+		mr->access = access;
+		mr->lkey = key;
+		mr->rkey = (access & IB_ACCESS_REMOTE) ? key : 0;
+		mr->iova = wqe->wr.wr.reg.mr->iova;
+		mr->state = RXE_MR_STATE_VALID;
+	} else {
+		spin_unlock_bh(&mr->lock);
+		pr_debug("%s: mr#%d not in FREE state\n",
+			__func__, mr->elem.index);
+		return -EINVAL;
+	}
+	spin_unlock_bh(&mr->lock);
 
 	return 0;
 }
@@ -619,6 +639,10 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	if (atomic_read(&mr->num_mw) > 0)
 		return -EINVAL;
 
+	spin_lock_bh(&mr->lock);
+	mr->state = RXE_MR_STATE_INVALID;
+	spin_unlock_bh(&mr->lock);
+
 	rxe_cleanup(mr);
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index b36ec5c4d5e0..5ff0cdce24d2 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -602,15 +602,20 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 	enum resp_states ret;
 	struct rxe_mr *mr = qp->resp.mr;
 	struct resp_res *res = qp->resp.res;
+	enum rxe_mr_state state;
 	u64 value;
 
+	spin_lock_bh(&mr->lock);
+	state = mr->state;
+	spin_unlock_bh(&mr->lock);
+
 	if (!res) {
 		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_MASK);
 		qp->resp.res = res;
 	}
 
 	if (!res->replay) {
-		if (mr->state != RXE_MR_STATE_VALID) {
+		if (state != RXE_MR_STATE_VALID) {
 			ret = RESPST_ERR_RKEY_VIOLATION;
 			goto out;
 		}
@@ -723,6 +728,7 @@ static struct rxe_mr *rxe_recheck_mr(struct rxe_qp *qp, u32 rkey)
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_mr *mr;
 	struct rxe_mw *mw;
+	enum rxe_mr_state state;
 
 	if (rkey_is_mw(rkey)) {
 		mw = rxe_pool_get_index(&rxe->mw_pool, rkey >> 8);
@@ -730,8 +736,16 @@ static struct rxe_mr *rxe_recheck_mr(struct rxe_qp *qp, u32 rkey)
 			return NULL;
 
 		mr = mw->mr;
+		if (mr) {
+			spin_lock_bh(&mr->lock);
+			state = mr->state;
+			spin_unlock_bh(&mr->lock);
+		} else {
+			state = RXE_MR_STATE_INVALID;
+		}
+
 		if (mw->rkey != rkey || mw->state != RXE_MW_STATE_VALID ||
-		    !mr || mr->state != RXE_MR_STATE_VALID) {
+		    !mr || state != RXE_MR_STATE_VALID) {
 			rxe_put(mw);
 			return NULL;
 		}
@@ -746,7 +760,11 @@ static struct rxe_mr *rxe_recheck_mr(struct rxe_qp *qp, u32 rkey)
 	if (!mr)
 		return NULL;
 
-	if (mr->rkey != rkey || mr->state != RXE_MR_STATE_VALID) {
+	spin_lock_bh(&mr->lock);
+	state = mr->state;
+	spin_unlock_bh(&mr->lock);
+
+	if (mr->rkey != rkey || state != RXE_MR_STATE_VALID) {
 		rxe_put(mr);
 		return NULL;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index a24fbe984066..2dbc754c3faf 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -302,7 +302,10 @@ struct rxe_mr {
 
 	u32			lkey;
 	u32			rkey;
+
 	enum rxe_mr_state	state;
+	spinlock_t		lock;	/* guard state */
+
 	enum ib_mr_type		type;
 	u64			va;
 	u64			iova;
-- 
2.34.1

