Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14030765CC6
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 22:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjG0UCT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 16:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjG0UCR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 16:02:17 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8D230D4
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:14 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9f46dc2e3so994740a34.0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488134; x=1691092934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0gaMN61MfF1nKHyiXLH9h75hP0spU3KUHPxxTMSBFE=;
        b=VS0uPQzm0FF43tCrAi14fyDrUfUhYfZ/9bF5VJVIqTgTeRiaHzSXhxbHCKEDVzlww5
         VLTEsFK20pJmVd3SdHLVLznxcPayKbXF+9K8Jqao6EGnM5OC/b23nWUs3Peb35yX07Bc
         Gay+FTaTQZ4LRrUonVEgAXR55Ly6fVseo00GVaHtH/TLFrkBJtCzLap8zly5DVG1SMS8
         5B4NCNiPZcI9/wiDfLDsuq8aPbOp+eQLOyJdkBUxKmewlRgx5j6eoFMk3+9PRhq9PuTM
         Vuref6YXWUkGmG+gwknQ1UgP6gKpeE++5j4xKsAxVlIdD0lDh3P36aBYTc35eqpG8Z9O
         I9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488134; x=1691092934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0gaMN61MfF1nKHyiXLH9h75hP0spU3KUHPxxTMSBFE=;
        b=RAPTlEbsa4WjMrGMG/cTeXc4m+GZRt3ZNqgekqsZ/VfpID1K/DdDoMCaGLU07uR8aT
         eBQ+Syt6fSN10k6zCqWnBluDO2wTGA9nVqS8VZzhwP+gRpSYPPyifeu2ovdaGhJunVk0
         f2iAOmfN+FnU43KN46HPh7iI+ISz3bGGFl5/TT2sfhJ40JNg5rMA0Lo2Ba41RuxY83SR
         GqpRvVAaGESnASKftwCaAmCyB5e9T/i9krbMnwmW/YuaVtcQhOd8vhSh14F4dY1iTgzq
         OTjCd+JpefPmFkfdU7uwL9k1RcI1PDVZzkK+HviCWuo/p76dA9J5tJKtj0GEsdlUeoD8
         tV2Q==
X-Gm-Message-State: ABy/qLbq8Un0yh6TXJ5pd2tzDnYS5X6zut/5KiCbA+iq4gYdI1wfXTps
        IhyaRp9OO3JE5S41LKH1qEQ=
X-Google-Smtp-Source: APBJJlGX1l4bCpt5mW5DCdhMNHN2O5i4kxC3/P3DZJyLjSdtF3kqkBwfg+6S7xpmu3/T7fMt95Z2Zg==
X-Received: by 2002:a9d:7ac1:0:b0:6b9:c7de:68e0 with SMTP id m1-20020a9d7ac1000000b006b9c7de68e0mr168444otn.29.1690488133863;
        Thu, 27 Jul 2023 13:02:13 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id m3-20020a9d73c3000000b006b9acf5ebc0sm938142otk.76.2023.07.27.13.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:02:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 03/10] RDMA/rxe: Extend copy_data to support skb frags
Date:   Thu, 27 Jul 2023 15:01:22 -0500
Message-Id: <20230727200128.65947-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727200128.65947-1-rpearsonhpe@gmail.com>
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

copy_data() currently supports copying between an mr and
the scatter-gather list of a wqe.

Rename copy_data() to rxe_copy_dma_data().
Extend the operations to support copying between a sg list and an skb
fragment list. Fixup calls to copy_data() to support the new API.
Add a routine to count the number of skbs required for
rxe_copy_dma_data().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c |  17 ++-
 drivers/infiniband/sw/rxe/rxe_loc.h  |  10 +-
 drivers/infiniband/sw/rxe/rxe_mr.c   | 175 +++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_req.c  |  11 +-
 drivers/infiniband/sw/rxe/rxe_resp.c |   7 +-
 5 files changed, 139 insertions(+), 81 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index e3f8dfc9b8bf..670ee08f6f5a 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -364,11 +364,14 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 				      struct rxe_pkt_info *pkt,
 				      struct rxe_send_wqe *wqe)
 {
+	struct sk_buff *skb = PKT_TO_SKB(pkt);
+	int skb_offset = 0;
 	int ret;
 
-	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
-			&wqe->dma, payload_addr(pkt),
-			payload_size(pkt), RXE_COPY_TO_MR);
+	ret = rxe_copy_dma_data(skb, qp->pd, IB_ACCESS_LOCAL_WRITE,
+				&wqe->dma, payload_addr(pkt),
+				skb_offset, payload_size(pkt),
+				RXE_COPY_TO_MR);
 	if (ret) {
 		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
@@ -384,13 +387,15 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 					struct rxe_pkt_info *pkt,
 					struct rxe_send_wqe *wqe)
 {
+	struct sk_buff *skb = NULL;
+	int skb_offset = 0;
 	int ret;
 
 	u64 atomic_orig = atmack_orig(pkt);
 
-	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
-			&wqe->dma, &atomic_orig,
-			sizeof(u64), RXE_COPY_TO_MR);
+	ret = rxe_copy_dma_data(skb, qp->pd, IB_ACCESS_LOCAL_WRITE,
+				&wqe->dma, &atomic_orig,
+				skb_offset, sizeof(u64), RXE_COPY_TO_MR);
 	if (ret) {
 		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 77661e0ccab7..fad853199b4d 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -68,15 +68,19 @@ int rxe_num_mr_frags(struct rxe_mr *mr, u64 iova, unsigned int length);
 int rxe_copy_mr_data(struct sk_buff *skb, struct rxe_mr *mr, u64 iova,
 		     void *addr, unsigned int skb_offset,
 		     unsigned int length, enum rxe_mr_copy_op op);
-int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
-	      void *addr, int length, enum rxe_mr_copy_op op);
+int rxe_num_dma_frags(const struct rxe_pd *pd, const struct rxe_dma_info *dma,
+		      unsigned int length);
+int rxe_copy_dma_data(struct sk_buff *skb, struct rxe_pd *pd, int access,
+		      struct rxe_dma_info *dma, void *addr,
+		      unsigned int skb_offset, unsigned int length,
+		      enum rxe_mr_copy_op op);
 int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length);
 int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset);
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val);
 int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
+struct rxe_mr *lookup_mr(const struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 2667e8129a1d..0ac71238599a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -313,6 +313,63 @@ int rxe_num_mr_frags(struct rxe_mr *mr, u64 iova, unsigned int length)
 	return num_frags;
 }
 
+/**
+ * rxe_num_dma_frags() - Count the number of skb frags needed to copy
+ *			 length bytes from a dma info struct to an skb
+ * @pd: protection domain used by dma entries
+ * @dma: dma info
+ * @length: number of bytes to copy
+ *
+ * Returns: number of frags needed
+ */
+int rxe_num_dma_frags(const struct rxe_pd *pd, const struct rxe_dma_info *dma,
+		      unsigned int length)
+{
+	unsigned int cur_sge = dma->cur_sge;
+	const struct rxe_sge *sge = &dma->sge[cur_sge];
+	unsigned int offset = dma->sge_offset;
+	struct rxe_mr *mr = NULL;
+	unsigned int bytes;
+	u64 iova;
+	int num_frags = 0;
+
+	if (WARN_ON(length > dma->resid))
+		return 0;
+
+	while (length) {
+		if (offset >= sge->length) {
+			if (mr)
+				rxe_put(mr);
+			sge++;
+			cur_sge++;
+			offset = 0;
+
+			if (WARN_ON(cur_sge >= dma->num_sge))
+				return 0;
+			if (!sge->length)
+				continue;
+		}
+
+		mr = lookup_mr(pd, 0, sge->lkey, RXE_LOOKUP_LOCAL);
+		if (WARN_ON(!mr))
+			return 0;
+
+		bytes = min_t(unsigned int, length,
+				sge->length - offset);
+		if (bytes) {
+			iova = sge->addr + offset;
+			num_frags += rxe_num_mr_frags(mr, iova, length);
+			offset += bytes;
+			length -= bytes;
+		}
+	}
+
+	if (mr)
+		rxe_put(mr);
+
+	return num_frags;
+}
+
 static int rxe_mr_copy_xarray(struct sk_buff *skb, struct rxe_mr *mr,
 			      u64 iova, void *addr, unsigned int skb_offset,
 			      unsigned int length, enum rxe_mr_copy_op op)
@@ -465,99 +522,85 @@ int rxe_copy_mr_data(struct sk_buff *skb, struct rxe_mr *mr, u64 iova,
 				  length, op);
 }
 
-/* copy data in or out of a wqe, i.e. sg list
- * under the control of a dma descriptor
+/**
+ * rxe_copy_dma_data() - transfer data between a packet and a wqe
+ * @skb: packet buffer (FRAG MR only)
+ * @pd: PD which MRs must match
+ * @access: access permission for MRs in sge (TO MR only)
+ * @dma: dma info from a wqe
+ * @addr: payload address in packet (TO/FROM MR only)
+ * @skb_offset: offset of data in skb (RXE_FRAG_TO_MR only)
+ * @length: payload length
+ * @op: copy operation (RXE_COPY_TO/FROM_MR or RXE_FRAG_TO/FROM_MR)
+ *
+ * Iterate over scatter/gather list in dma info starting from the
+ * current location until the payload length is used up and for each
+ * entry copy or build a frag list referencing the MR obtained from
+ * the lkey in the sge. This routine is called once for each packet
+ * sent or received to/from the wqe.
+ *
+ * Returns: 0 on success or an error
  */
-int copy_data(
-	struct rxe_pd		*pd,
-	int			access,
-	struct rxe_dma_info	*dma,
-	void			*addr,
-	int			length,
-	enum rxe_mr_copy_op	op)
+int rxe_copy_dma_data(struct sk_buff *skb, struct rxe_pd *pd, int access,
+		      struct rxe_dma_info *dma, void *addr,
+		      unsigned int skb_offset, unsigned int length,
+		      enum rxe_mr_copy_op op)
 {
-	int			bytes;
-	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
-	int			offset	= dma->sge_offset;
-	int			resid	= dma->resid;
-	struct rxe_mr		*mr	= NULL;
-	u64			iova;
-	int			err;
+	struct rxe_sge *sge = &dma->sge[dma->cur_sge];
+	unsigned int offset = dma->sge_offset;
+	unsigned int resid = dma->resid;
+	struct rxe_mr *mr = NULL;
+	unsigned int bytes;
+	u64 iova;
+	int err = 0;
 
 	if (length == 0)
 		return 0;
 
-	if (length > resid) {
-		err = -EINVAL;
-		goto err2;
-	}
-
-	if (sge->length && (offset < sge->length)) {
-		mr = lookup_mr(pd, access, sge->lkey, RXE_LOOKUP_LOCAL);
-		if (!mr) {
-			err = -EINVAL;
-			goto err1;
-		}
-	}
-
-	while (length > 0) {
-		bytes = length;
+	if (length > resid)
+		return -EINVAL;
 
+	while (length) {
 		if (offset >= sge->length) {
-			if (mr) {
+			if (mr)
 				rxe_put(mr);
-				mr = NULL;
-			}
+
 			sge++;
 			dma->cur_sge++;
 			offset = 0;
 
-			if (dma->cur_sge >= dma->num_sge) {
-				err = -ENOSPC;
-				goto err2;
-			}
-
-			if (sge->length) {
-				mr = lookup_mr(pd, access, sge->lkey,
-					       RXE_LOOKUP_LOCAL);
-				if (!mr) {
-					err = -EINVAL;
-					goto err1;
-				}
-			} else {
+			if (dma->cur_sge >= dma->num_sge)
+				return -EINVAL;
+			if (!sge->length)
 				continue;
-			}
 		}
 
-		if (bytes > sge->length - offset)
-			bytes = sge->length - offset;
+		mr = lookup_mr(pd, access, sge->lkey, RXE_LOOKUP_LOCAL);
+		if (!mr)
+			return -EINVAL;
 
+		bytes = min_t(int, length, sge->length - offset);
 		if (bytes > 0) {
 			iova = sge->addr + offset;
-			err = rxe_copy_mr_data(NULL, mr, iova, addr,
-					       0, bytes, op);
+			err = rxe_copy_mr_data(skb, mr, iova, addr,
+					       skb_offset, bytes, op);
 			if (err)
-				goto err2;
+				goto err_put;
 
-			offset	+= bytes;
-			resid	-= bytes;
-			length	-= bytes;
-			addr	+= bytes;
+			addr += bytes;
+			offset += bytes;
+			skb_offset += bytes;
+			resid -= bytes;
+			length -= bytes;
 		}
 	}
 
 	dma->sge_offset = offset;
-	dma->resid	= resid;
-
-	if (mr)
-		rxe_put(mr);
-
-	return 0;
+	dma->resid = resid;
 
-err2:
+err_put:
 	if (mr)
 		rxe_put(mr);
-err1:
 	return err;
 }
 
@@ -753,7 +796,7 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 	return 0;
 }
 
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
+struct rxe_mr *lookup_mr(const struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type)
 {
 	struct rxe_mr *mr;
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index f3653234cf32..525e704c12c2 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -315,8 +315,10 @@ static void rxe_init_roce_hdrs(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 }
 
 static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-			    struct rxe_pkt_info *pkt, u32 payload)
+			    struct rxe_pkt_info *pkt, u32 payload,
+			    struct sk_buff *skb)
 {
+	int skb_offset = 0;
 	void *data;
 	int err = 0;
 
@@ -326,8 +328,9 @@ static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		wqe->dma.resid -= payload;
 		wqe->dma.sge_offset += payload;
 	} else {
-		err = copy_data(qp->pd, 0, &wqe->dma, payload_addr(pkt),
-				payload, RXE_COPY_FROM_MR);
+		err = rxe_copy_dma_data(skb, qp->pd, 0, &wqe->dma,
+					payload_addr(pkt), skb_offset,
+					payload, RXE_COPY_FROM_MR);
 	}
 
 	return err;
@@ -379,7 +382,7 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 
 	/* init payload if any */
 	if (pkt->mask & RXE_WRITE_OR_SEND_MASK) {
-		err = rxe_init_payload(qp, wqe, pkt, payload);
+		err = rxe_init_payload(qp, wqe, pkt, payload, skb);
 		if (unlikely(err))
 			goto err_out;
 	} else if (pkt->mask & RXE_FLUSH_MASK) {
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 87d61a462ff5..a6c1d67ad943 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -562,10 +562,13 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
 				     int data_len)
 {
+	struct sk_buff *skb = NULL;
+	int skb_offset = 0;
 	int err;
 
-	err = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
-			data_addr, data_len, RXE_COPY_TO_MR);
+	err = rxe_copy_dma_data(skb, qp->pd, IB_ACCESS_LOCAL_WRITE,
+				&qp->resp.wqe->dma, data_addr,
+				skb_offset, data_len, RXE_COPY_TO_MR);
 	if (unlikely(err))
 		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
 					: RESPST_ERR_MALFORMED_WQE;
-- 
2.39.2

