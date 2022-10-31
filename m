Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE08E613F00
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJaU2s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJaU2p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:45 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12038DEA4
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:42 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id k59-20020a9d19c1000000b0066c45cdfca5so2972799otk.10
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHxFM1J0AbwRN3LfhUbzpJKABUqkA+7pjVZ0MMGxkN4=;
        b=JRg10oc9ZjTFdY9yYZSmNXtWhoWXRwZY7ZZLibyFCo0MBJTqpeZ2AlZfm7qxkreXLR
         9jy27uwDAzFpAIsgncr0Smp47MiVdOUzWqb5lvcic7AF9z/sCOBHAYLs1X2xketrdN9C
         bL2uAhV1kOl4HfBf1fifrsBVn4pgLPs72626WZhD/Yezyqj+fxN1q7t+1lmnEFs3dZOp
         bWaz0O4/T2IQ2Q/hxzdGZlqOgHQ7EKGt0njHNQqTKx/J1rxVbqlCJ+0C/xgv8T9UEWMN
         paRia3EX64nr0wVzjtMvI6/HHjpEBUIh8DYifjZX/qirX/3nunDwdoA+vj4Vwqhh3ebs
         Xxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHxFM1J0AbwRN3LfhUbzpJKABUqkA+7pjVZ0MMGxkN4=;
        b=HDVlc7LRcQUL8dONdf7+pbN5mrfvmxxtYCS81vAC0/OgUgoKzlfQEbc7tybvqJra3t
         Ce0cSJlolTRRvGSzxIsxPARke0ez2bX7Bv7ueGdl2E/3RkEhdEh3Bz9W3Cq7a5se8IfE
         Miw0hPg2kbZLxIr4bPx9LKaTbG3dAHCuAiajFE8LQjdl06Nw7kQYe3khcrziQWLJCz7B
         ln4HhKBQ/LPqfUXAHH+zAQePeE2pnft3seJNr5Qb0Dc402Gijn3jJkeLhkmlBDq3Vmzu
         NM8w5OcomssiW3ImEvJX4TtWvTK8cHdpAqk6kfaLH+PFnG5NWq43THTAVMohW5znMp61
         JfWg==
X-Gm-Message-State: ACrzQf0i5dillu3Lh+0PEd1NlMxgBziAwRG0/s1UoOw3SCucVXUyn6kd
        fN9j37fbL40tc+5Fnfv56e4=
X-Google-Smtp-Source: AMsMyM7PiM7bFuIN5XWteW9OUM51U2iLZFT5sdnljjQpkCmCcbPccpSEVfZuj3QnFlcGNn4IBiaQYQ==
X-Received: by 2002:a9d:2625:0:b0:66c:5694:f4ce with SMTP id a34-20020a9d2625000000b0066c5694f4cemr2596298otb.145.1667248121300;
        Mon, 31 Oct 2022 13:28:41 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:40 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 10/18] RDMA/rxe: Extend copy_data to support skb frags
Date:   Mon, 31 Oct 2022 15:27:59 -0500
Message-Id: <20221031202805.19138-10-rpearsonhpe@gmail.com>
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

copy_data() currently supports copying between an mr and
the scatter-gather list of a wqe.

Rename copy_data() to rxe_copy_dma_data().
Extend the operations to support copying between a sg list and an skb
fragment list. Fixup calls to copy_data() to support the new API.

This is in preparation for supporting fragmented skbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c |  17 ++--
 drivers/infiniband/sw/rxe/rxe_loc.h  |   5 +-
 drivers/infiniband/sw/rxe/rxe_mr.c   | 122 ++++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_req.c  |  11 ++-
 drivers/infiniband/sw/rxe/rxe_resp.c |   7 +-
 5 files changed, 79 insertions(+), 83 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 77640e35ae88..3c1ecc88446d 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -352,11 +352,14 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
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
@@ -372,13 +375,15 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
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
index 4c30ffaccc92..dbead759123d 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -78,8 +78,9 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_op op);
 int rxe_num_dma_frags(const struct rxe_pd *pd, const struct rxe_dma_info *dma,
 		      int length);
-int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
-	      void *addr, int length, enum rxe_mr_copy_op op);
+int rxe_copy_dma_data(struct sk_buff *skb, struct rxe_pd *pd, int access,
+		      struct rxe_dma_info *dma, void *addr,
+		      int skb_offset, int length, enum rxe_mr_copy_op op);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 struct rxe_mr *lookup_mr(const struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 99d0b5afefc3..6fe5bbe43a60 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -587,100 +587,84 @@ int rxe_num_dma_frags(const struct rxe_pd *pd, const struct rxe_dma_info *dma,
 	return num_frags;
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
+		      int skb_offset, int length, enum rxe_mr_copy_op op)
 {
-	int			bytes;
-	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
-	int			offset	= dma->sge_offset;
-	int			resid	= dma->resid;
-	struct rxe_mr		*mr	= NULL;
-	u64			iova;
-	int			err;
+	struct rxe_sge *sge = &dma->sge[dma->cur_sge];
+	int buf_offset = dma->sge_offset;
+	int resid = dma->resid;
+	struct rxe_mr *mr = NULL;
+	int bytes;
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
+	if (length > resid)
+		return -EINVAL;
 
 	while (length > 0) {
-		bytes = length;
-
-		if (offset >= sge->length) {
-			if (mr) {
+		if (buf_offset >= sge->length) {
+			if (mr)
 				rxe_put(mr);
-				mr = NULL;
-			}
+
 			sge++;
 			dma->cur_sge++;
-			offset = 0;
-
-			if (dma->cur_sge >= dma->num_sge) {
-				err = -ENOSPC;
-				goto err2;
-			}
+			buf_offset = 0;
 
-			if (sge->length) {
-				mr = lookup_mr(pd, access, sge->lkey,
-					       RXE_LOOKUP_LOCAL);
-				if (!mr) {
-					err = -EINVAL;
-					goto err1;
-				}
-			} else {
+			if (dma->cur_sge >= dma->num_sge)
+				return -ENOSPC;
+			if (!sge->length)
 				continue;
-			}
 		}
 
-		if (bytes > sge->length - offset)
-			bytes = sge->length - offset;
+		mr = lookup_mr(pd, access, sge->lkey, RXE_LOOKUP_LOCAL);
+		if (!mr)
+			return -EINVAL;
 
+		bytes = min_t(int, length, sge->length - buf_offset);
 		if (bytes > 0) {
-			iova = sge->addr + offset;
-
-			err = rxe_copy_mr_data(NULL, mr, iova, addr,
-					       0, bytes, op);
+			iova = sge->addr + buf_offset;
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
+			buf_offset += bytes;
+			skb_offset += bytes;
+			resid -= bytes;
+			length -= bytes;
 		}
 	}
 
-	dma->sge_offset = offset;
-	dma->resid	= resid;
+	dma->sge_offset = buf_offset;
+	dma->resid = resid;
 
+err_put:
 	if (mr)
 		rxe_put(mr);
-
-	return 0;
-
-err2:
-	if (mr)
-		rxe_put(mr);
-err1:
 	return err;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index b111a6ddf66c..ea0132797613 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -438,8 +438,10 @@ static void rxe_init_roce_hdrs(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 }
 
 static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-			    struct rxe_pkt_info *pkt, u32 payload)
+			    struct rxe_pkt_info *pkt, u32 payload,
+			    struct sk_buff *skb)
 {
+	int skb_offset = 0;
 	void *data;
 	int err = 0;
 
@@ -449,8 +451,9 @@ static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
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
@@ -495,7 +498,7 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 	rxe_init_roce_hdrs(qp, wqe, pkt, pad);
 
 	if (pkt->mask & RXE_WRITE_OR_SEND_MASK) {
-		err = rxe_init_payload(qp, wqe, pkt, payload);
+		err = rxe_init_payload(qp, wqe, pkt, payload, skb);
 		if (err)
 			goto err_out;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 5f00477544fa..589306de7647 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -521,10 +521,13 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
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
2.34.1

