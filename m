Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD47B613EFA
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJaU2g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJaU2f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:35 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF3A13CC8
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:34 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y67so13986516oiy.1
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKMD9CSVYsJ0M/9k6DWFpfS0Q7slCSuxZ6idqjgC6HQ=;
        b=lJjc5NUsXJTuq+BEd9CREoohkGMiZXB0ng8f9660nLqT7jDtI5HhZseDT57sWm0GiL
         KAVrGIWRU6ioJQa4vf3IGX3sQvCJtog3eNrGFdLiMKAl//kU+8LEfDKuQtZkUekdm/gu
         WlrQvsZ/p8GAcM60CtkbzYq2y7KTEc7PGUSguJkIJOVRU3zdV6OI4M9m6PPoFOfPXsFH
         sYezqqXb2xgUGnVg86P8UB9y16v5Q7O33n8oiiees9Xh2mvnONOwS6JyS7YrzNG/Uz3b
         6vDXu/3ZYTON0VbeUg0g1yNeZvm15ICBiGl92OQBWzdVY20DBfsgrDMSfMtTDf+RbXMR
         i73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKMD9CSVYsJ0M/9k6DWFpfS0Q7slCSuxZ6idqjgC6HQ=;
        b=7zzNht7qFArYlUL+cW9hAwiu3XXplI++MujLcXmjPfHLPNlJAKLcjHOIcTRIrF6B6d
         PXZpimdDP9AdgLgrknDYXX6Tfo9rvTg96kYBj2J3WNtqxrNJEW+uQKTbTxMb9CfJiTGo
         Hs/TJ7yb5wbfnUrrjxirvhZUdFBmpv2A62bf6Xt7JiGn/Ol38QotZYr/9HKVqkhD5JIT
         OAiv5V8Wd58N4P4VuD6/oZnqiauUJsqigVGySTq2A3WW/fSXNkrij1/JEHQ7QJwU49u7
         ABWSn21obgkIah1a1t+NzMT2VycXYBYkzzYOY+rT65AooSrbLYesKn+lmGol6W7vnM7q
         6qLQ==
X-Gm-Message-State: ACrzQf1YEw/plekUXfx4o1bno/8NKoMcDJ0INHCMESlFNy46CnmZz2xB
        JcGYsxpb7SVX5o0GIsmQqRE=
X-Google-Smtp-Source: AMsMyM6bAoYALcy2smKZXoHgd+Mrnd5c8CqNGwbDmEb5lQ51HUGojwXeKhpeFNLeFZOQ6TFn5DpP2A==
X-Received: by 2002:a05:6808:16a3:b0:351:5153:a6e1 with SMTP id bb35-20020a05680816a300b003515153a6e1mr15501036oib.56.1667248113724;
        Mon, 31 Oct 2022 13:28:33 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:33 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 05/18] RDMA/rxe: Add sg fragment ops
Date:   Mon, 31 Oct 2022 15:27:54 -0500
Message-Id: <20221031202805.19138-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031202805.19138-1-rpearsonhpe@gmail.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
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

Rename rxe_mr_copy_dir to rxe_mr_copy_op and add new operations for
copying between an skb fragment list and an mr.

This is in preparation for supporting fragmented skbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  4 ++--
 drivers/infiniband/sw/rxe/rxe_loc.h   |  4 ++--
 drivers/infiniband/sw/rxe/rxe_mr.c    | 14 +++++++-------
 drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  9 +++++----
 drivers/infiniband/sw/rxe/rxe_verbs.h | 15 ++++++++++++---
 6 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index c9170dd99f3a..77640e35ae88 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -356,7 +356,7 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, payload_addr(pkt),
-			payload_size(pkt), RXE_TO_MR_OBJ);
+			payload_size(pkt), RXE_COPY_TO_MR);
 	if (ret) {
 		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
@@ -378,7 +378,7 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, &atomic_orig,
-			sizeof(u64), RXE_TO_MR_OBJ);
+			sizeof(u64), RXE_COPY_TO_MR);
 	if (ret) {
 		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 574a6afc1199..ff803a957ac1 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -69,9 +69,9 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
-		enum rxe_mr_copy_dir dir);
+		enum rxe_mr_copy_op op);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
-	      void *addr, int length, enum rxe_mr_copy_dir dir);
+	      void *addr, int length, enum rxe_mr_copy_op op);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index d4f10c2d1aa7..60a8034f1416 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -290,7 +290,7 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
  * a mr object starting at iova.
  */
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
-		enum rxe_mr_copy_dir dir)
+		enum rxe_mr_copy_op op)
 {
 	int			err;
 	int			bytes;
@@ -307,9 +307,9 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
 		u8 *src, *dest;
 
-		src = (dir == RXE_TO_MR_OBJ) ? addr : ((void *)(uintptr_t)iova);
+		src = (op == RXE_COPY_TO_MR) ? addr : ((void *)(uintptr_t)iova);
 
-		dest = (dir == RXE_TO_MR_OBJ) ? ((void *)(uintptr_t)iova) : addr;
+		dest = (op == RXE_COPY_TO_MR) ? ((void *)(uintptr_t)iova) : addr;
 
 		memcpy(dest, src, length);
 
@@ -333,8 +333,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		u8 *src, *dest;
 
 		va	= (u8 *)(uintptr_t)buf->addr + offset;
-		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
-		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
+		src = (op == RXE_COPY_TO_MR) ? addr : va;
+		dest = (op == RXE_COPY_TO_MR) ? va : addr;
 
 		bytes	= buf->size - offset;
 
@@ -372,7 +372,7 @@ int copy_data(
 	struct rxe_dma_info	*dma,
 	void			*addr,
 	int			length,
-	enum rxe_mr_copy_dir	dir)
+	enum rxe_mr_copy_op	op)
 {
 	int			bytes;
 	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
@@ -433,7 +433,7 @@ int copy_data(
 		if (bytes > 0) {
 			iova = sge->addr + offset;
 
-			err = rxe_mr_copy(mr, iova, addr, bytes, dir);
+			err = rxe_mr_copy(mr, iova, addr, bytes, op);
 			if (err)
 				goto err2;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 6177c513e5b5..b111a6ddf66c 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -450,7 +450,7 @@ static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		wqe->dma.sge_offset += payload;
 	} else {
 		err = copy_data(qp->pd, 0, &wqe->dma, payload_addr(pkt),
-				payload, RXE_FROM_MR_OBJ);
+				payload, RXE_COPY_FROM_MR);
 	}
 
 	return err;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 44b5c159cef9..023df0562258 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -524,7 +524,7 @@ static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
 	int err;
 
 	err = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
-			data_addr, data_len, RXE_TO_MR_OBJ);
+			data_addr, data_len, RXE_COPY_TO_MR);
 	if (unlikely(err))
 		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
 					: RESPST_ERR_MALFORMED_WQE;
@@ -540,7 +540,7 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int data_len = payload_size(pkt);
 
 	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
-			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
+			  payload_addr(pkt), data_len, RXE_COPY_TO_MR);
 	if (err) {
 		rc = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
@@ -807,8 +807,9 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		return RESPST_ERR_RNR;
 
 	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
-			  payload, RXE_FROM_MR_OBJ);
-	rxe_put(mr);
+			  payload, RXE_COPY_FROM_MR);
+	if (mr)
+		rxe_put(mr);
 	if (err) {
 		kfree_skb(skb);
 		return RESPST_ERR_RKEY_VIOLATION;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 22a299b0a9f0..08275b0c7a6e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -267,9 +267,18 @@ enum rxe_mr_state {
 	RXE_MR_STATE_VALID,
 };
 
-enum rxe_mr_copy_dir {
-	RXE_TO_MR_OBJ,
-	RXE_FROM_MR_OBJ,
+/**
+ * enum rxe_mr_copy_op - Operations peformed by rxe_copy_mr/dma_data()
+ * @RXE_COPY_TO_MR:	Copy data from packet to MR(s)
+ * @RXE_COPY_FROM_MR:	Copy data from MR(s) to packet
+ * @RXE_FRAG_TO_MR:	Copy data from frag list to MR(s)
+ * @RXE_FRAG_FROM_MR:	Copy data from MR(s) to frag list
+ */
+enum rxe_mr_copy_op {
+	RXE_COPY_TO_MR,
+	RXE_COPY_FROM_MR,
+	RXE_FRAG_TO_MR,
+	RXE_FRAG_FROM_MR,
 };
 
 enum rxe_mr_lookup_type {
-- 
2.34.1

