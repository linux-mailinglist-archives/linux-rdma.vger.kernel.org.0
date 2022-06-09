Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E146544B33
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jun 2022 14:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbiFIMDc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jun 2022 08:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiFIMDc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jun 2022 08:03:32 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B7568FAD
        for <linux-rdma@vger.kernel.org>; Thu,  9 Jun 2022 05:03:30 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o68so17524897qkf.13
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jun 2022 05:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DinoQkxtsFggwn03fieMs2CFMhruMMTyGaVrm/GIj4w=;
        b=FYEeSP2Oip9CqenHNojqET9XDZ6TmhP2qgiA6dJFRhe/2RtQLilTtyH4vQVX1JkDFv
         qQ4tNW4j7GxxybHiBxvoCR9j/eJ+Na0KjLx+lb6CM58jv/11exIm5SliIXmeuj13qotU
         LrxJIUwTSjeuZRCK5y95FDKSzBWnd1GEArSr3c6V67RNe2kwry47/jNMAHNCGz7KyOpI
         asvG20VZ8uxSh/4JeMj15eHuMzme+ZbJCc02HnChbDAM0z087u68Fj79AYJxyAGW+01P
         DafQiL13Kfofsv0CoYhHvN1IDPrgvsQuzruK97WEy8VurN/aYHQymwLLNNFhVOc/xuTu
         zAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DinoQkxtsFggwn03fieMs2CFMhruMMTyGaVrm/GIj4w=;
        b=5JVBWu+6E5akJq/pdRqP1fbjYMcbxMAnuvDE3wnKeMnJhJKaQ8+gwaQgaIIOAZQd12
         BchY35Oh1pUl+7y6tGkY5sY22OxK+P2xRQGVAXGwn8snnZIKUye6zzArM3j3Zlw2V5u/
         6HxRnDm972zUjLlEsiNoSae5uMn7Q12j8+BbbzreEruD8Ozl4/Lz/dfQFJoLEmrRQ6q9
         wN22qkP0IUQsbPKPLigzvL3Zx4rmKZigNw8r4dBVUVLCi/Sx2Wyyc/Ey9fw2jd+xo3oV
         k0XzZmR7c4gka/6msJDYQcRulOyKy9ulJUJkdVKBjrdeiSaOz3WthZqegL0/Z6e8k5aZ
         oE1g==
X-Gm-Message-State: AOAM5326ao8FiK+7sS61r3PqyOCDTy3TKR9qFKRsjcTAXKvWxR3woDJv
        tU+9qPUsQLFo4KfSb+CxuieA/zyCIh32xF63
X-Google-Smtp-Source: ABdhPJx6hlEwY0OhVPEf7qgX8VTNzpMGAf+mnvnt2yJRb2AHUIG/MN7JRQGghbHWuQMYWEz+oB4R6A==
X-Received: by 2002:a05:620a:28d6:b0:6a6:6c9c:ca9e with SMTP id l22-20020a05620a28d600b006a66c9cca9emr25103391qkp.518.1654776208738;
        Thu, 09 Jun 2022 05:03:28 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id v186-20020a3793c3000000b0069fc13ce1f3sm18252222qkd.36.2022.06.09.05.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 05:03:27 -0700 (PDT)
From:   Md Haris Iqbal <haris.phnx@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        aleksei.marov@ionos.com, Md Haris Iqbal <haris.phnx@gmail.com>,
        rpearsonhpe@gmail.com
Subject: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote versions
Date:   Thu,  9 Jun 2022 14:03:22 +0200
Message-Id: <20220609120322.144315-1-haris.phnx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently rxe_invalidate_mr does invalidate for both local ops, and remote
ones. This means that MR being invalidated is compared with rkey for both,
which is incorrect. For local invalidate, comparison should happen with
lkey, and for the remote one, it should happen with rkey.

This commit splits the rxe_invalidate_mr into local and remote versions.
Each of them does comparison the right way as described above (with lkey
for local, and rkey for remote).

Fixes: 3902b429ca14 ("RDMA/rxe: Implement invalidate MW operations")
Cc: rpearsonhpe@gmail.com
Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  |  3 +-
 drivers/infiniband/sw/rxe/rxe_mr.c   | 59 +++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_req.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c |  2 +-
 4 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 0e022ae1b8a5..4da57abbbc8c 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -77,7 +77,8 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
-int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
+int rxe_invalidate_mr_local(struct rxe_qp *qp, u32 lkey);
+int rxe_invalidate_mr_remote(struct rxe_qp *qp, u32 rkey);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
 int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index fc3942e04a1f..1c7179dd92eb 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -576,41 +576,72 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 	return mr;
 }
 
-int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
+static int rxe_invalidate_mr(struct rxe_mr *mr)
+{
+	if (atomic_read(&mr->num_mw) > 0) {
+		pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
+		pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
+		return -EINVAL;
+	}
+
+	mr->state = RXE_MR_STATE_FREE;
+	return 0;
+}
+
+int rxe_invalidate_mr_local(struct rxe_qp *qp, u32 lkey)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_mr *mr;
 	int ret;
 
-	mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
+	mr = rxe_pool_get_index(&rxe->mr_pool, lkey >> 8);
 	if (!mr) {
-		pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
+		pr_err("%s: No MR for lkey %#x\n", __func__, lkey);
 		ret = -EINVAL;
 		goto err;
 	}
 
-	if (rkey != mr->rkey) {
-		pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
-			__func__, rkey, mr->rkey);
+	if (lkey != mr->lkey) {
+		pr_err("%s: lkey (%#x) doesn't match mr->lkey (%#x)\n",
+			__func__, lkey, mr->lkey);
 		ret = -EINVAL;
 		goto err_drop_ref;
 	}
 
-	if (atomic_read(&mr->num_mw) > 0) {
-		pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
-			__func__);
+	ret = rxe_invalidate_mr(mr);
+
+err_drop_ref:
+	rxe_put(mr);
+err:
+	return ret;
+}
+
+int rxe_invalidate_mr_remote(struct rxe_qp *qp, u32 rkey)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mr *mr;
+	int ret;
+
+	mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
+	if (!mr) {
+		pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
 		ret = -EINVAL;
-		goto err_drop_ref;
+		goto err;
 	}
 
-	if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
-		pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
+	if (rkey != mr->rkey) {
+		pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
+			__func__, rkey, mr->rkey);
 		ret = -EINVAL;
 		goto err_drop_ref;
 	}
 
-	mr->state = RXE_MR_STATE_FREE;
-	ret = 0;
+	ret = rxe_invalidate_mr(mr);
 
 err_drop_ref:
 	rxe_put(mr);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 9d98237389cf..e7dd9738a255 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -550,7 +550,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		if (rkey_is_mw(rkey))
 			ret = rxe_invalidate_mw(qp, rkey);
 		else
-			ret = rxe_invalidate_mr(qp, rkey);
+			ret = rxe_invalidate_mr_local(qp, rkey);
 
 		if (unlikely(ret)) {
 			wqe->status = IB_WC_LOC_QP_OP_ERR;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index f4f6ee5d81fe..01411280cd73 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -818,7 +818,7 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
 	if (rkey_is_mw(rkey))
 		return rxe_invalidate_mw(qp, rkey);
 	else
-		return rxe_invalidate_mr(qp, rkey);
+		return rxe_invalidate_mr_remote(qp, rkey);
 }
 
 /* Executes a new request. A retried request never reach that function (send
-- 
2.25.1

