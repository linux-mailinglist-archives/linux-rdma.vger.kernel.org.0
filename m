Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092A554E30B
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jun 2022 16:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377101AbiFPOJQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jun 2022 10:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377538AbiFPOJP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jun 2022 10:09:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7AB39813
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jun 2022 07:09:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o10so2387634edi.1
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jun 2022 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=18ESss5nCqQf0bVU1+jYRmGavTy5/k339W9NkrlMjPM=;
        b=cHfdxSXMwa2MOVfYEwNsvBWCwvEse8MFKskt03yAhLU7zH66TX+FsM+AYJ+DvlQ538
         CDkEAdcIXQsnzb7Q/19ffgXEE25VFbosOiyC0D1eJK6+eKIF3ugcaPutWZfH2JBBJi0G
         fsgeZYrXYX/g8SrEiwDYu64ZKzCY7Vab2m6Wtxg9FAaq289+NHaCbIBqnDE3C44gMWgH
         7x8BAAWKv3B0nT0we5nGbgov3AZiUq6S1gKA45b+s/dQ2zKSOcd/mbV8XItBxYlOX3J5
         uraxnRTy0gTCsmcWE6Uu0vRjQeIRqBJzUdz9nZ3Alz+/rmGPldJlrTw/ojPHv1vTEEmm
         z4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=18ESss5nCqQf0bVU1+jYRmGavTy5/k339W9NkrlMjPM=;
        b=TX9iHcBNyzE/DFhKXTPuIPFZj02iOHyuYtPeU/0KmAVVG4W1zjY6//BkKwY+nLH/7U
         G4aVkbkB6+NQFgIJrl0YyFjnDbKjuDuSRT3nM3BIg1w9e6nyxapG5K8lgV74bnTePk6A
         AX509ox9ua4NSU8NHv0RpZ3PjyjRseYZ89NmV8M/Wa5fkCtNsuRq9JloPPZNQBRAJWWS
         v38sWnk8U8OtcmE1lnBabv64yubN2cD1x7wRzaBkwJ2MFzVo0xIRsCTDau+7qoXkh8wh
         A08s7hUuPdmmavfzI3N4rzGX+wfk/oPbTdyIp+nbAIUNbCyAIaFWOKV9deKjyKx+QfwA
         JeyQ==
X-Gm-Message-State: AJIora+ufYt15MuXm5qgLKI4jIsyCc0BGY1Qd+N8nTITJY0svAZrPKQY
        TEOCLX4xSmOnPtBeOEfvIojAeuiLbHzbDO1J
X-Google-Smtp-Source: AGRyM1tvUyymQ9XvaVX/N+ED6aUQ7sBOwP2xm6oBxRkWTC1pwke7bxQBQAwat4RpWXtnbe9CBXt15Q==
X-Received: by 2002:a05:6402:2682:b0:42e:1c85:7ddc with SMTP id w2-20020a056402268200b0042e1c857ddcmr6649368edd.143.1655388551720;
        Thu, 16 Jun 2022 07:09:11 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id s2-20020a1709060d6200b006f3ef214e2csm859297ejh.146.2022.06.16.07.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 07:09:11 -0700 (PDT)
From:   Md Haris Iqbal <haris.phnx@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        aleksei.marov@ionos.com, Md Haris Iqbal <haris.phnx@gmail.com>,
        rpearsonhpe@gmail.com
Subject: [PATCH v2] RDMA/rxe: Split rxe_invalidate_mr into local and remote versions
Date:   Thu, 16 Jun 2022 16:09:08 +0200
Message-Id: <20220616140908.666092-1-haris.phnx@gmail.com>
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
v1 -> v2
give a better name to key variable in function rxe_do_local_ops

 drivers/infiniband/sw/rxe/rxe_loc.h  |  3 +-
 drivers/infiniband/sw/rxe/rxe_mr.c   | 59 +++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_req.c  | 10 ++---
 drivers/infiniband/sw/rxe/rxe_resp.c |  2 +-
 4 files changed, 53 insertions(+), 21 deletions(-)

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
index 9d98237389cf..ef193a8a7158 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -541,16 +541,16 @@ static void update_state(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 {
 	u8 opcode = wqe->wr.opcode;
-	u32 rkey;
+	u32 key;
 	int ret;
 
 	switch (opcode) {
 	case IB_WR_LOCAL_INV:
-		rkey = wqe->wr.ex.invalidate_rkey;
-		if (rkey_is_mw(rkey))
-			ret = rxe_invalidate_mw(qp, rkey);
+		key = wqe->wr.ex.invalidate_rkey;
+		if (rkey_is_mw(key))
+			ret = rxe_invalidate_mw(qp, key);
 		else
-			ret = rxe_invalidate_mr(qp, rkey);
+			ret = rxe_invalidate_mr_local(qp, key);
 
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

