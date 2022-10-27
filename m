Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB796100D4
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiJ0S4Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiJ0S4X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:23 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69D51D33C
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:21 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s125so2901731oib.6
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MChkxtjkhxIWWxt3gK9PetgTDkpZGN347IVsIZZOBg=;
        b=GXKnBUY6xk9NAnNPlsvhrigLwsJTCvbclz9/fgNzubVWetU5pzs6TfgWyLdjd3lDXs
         i6MosDCRzekY1aYhr5WaQI6VeqVNAUYBm+U5Jza1SUyCWwagLGCxJogjSi7piyt5LWgp
         FcJ0gIdfF5bKvJ27O5WSxdToNss5QetWvuqEpk/y/VcWfeuczVb00h350RAExRiuOsob
         GO31Z/ahlW8ZIsWN5rybaJjAEaoItImy6LdA2Evn4hY4rKuFXiVom0BKEVm2CNt7YXE7
         RQIXkEmvQYdUlJsLLuTqNjPLvIMQ1oUbQaIqvJAQ6j/UG+NtHF25Y9RGdpj/O/FmN0Zg
         Mi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MChkxtjkhxIWWxt3gK9PetgTDkpZGN347IVsIZZOBg=;
        b=zyNMfjWiAZSgZZNQWlBJTxZp6MfvKUimL7Ugn4yaWEsg9ozY3cBLyDMki1103o0kRc
         2bxPDkaML5c0/la/oNyfg6XaYdIClOytByRcVAgFe9a0tJhm23E1VI6MhDEKgCegHKF4
         LTVCRPcKhOpFX2BLP/lHaiomIPt16hSeqE3QqVDzcMFRy+WESSayF03c3S0zWiHa6atZ
         bqC82BqoN96vVNeCgvyc0DfARlb9kqYXs+vWe2+A5mrqF09BFMY1RSnYWpVbIXUtr6L+
         8sL9VFH7prjDNjWf9BQ7B9S/E13QqidzeJRpG3sPbKBwYr1oizYD+YZlI3VloLrP5BNT
         u8gw==
X-Gm-Message-State: ACrzQf0K0FGYeCiyfGCKqlSOfhPaxXTxymZltICvCQMj0NvPJcaeDGhM
        c8+se9chBZxXYrfPTXyZE4A=
X-Google-Smtp-Source: AMsMyM7jfzflMCuwiF+kScImJ9hlViLTjJkNEeJ6sFkttPTpR/+ntPxmgI05pnwa95Ae9cXIHcQ1Vw==
X-Received: by 2002:a05:6808:f0e:b0:359:b055:32ea with SMTP id m14-20020a0568080f0e00b00359b05532eamr4909842oiw.112.1666896980976;
        Thu, 27 Oct 2022 11:56:20 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:20 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 09/17] RDMA/rxe: Extend copy_data to support skb frags
Date:   Thu, 27 Oct 2022 13:55:03 -0500
Message-Id: <20221027185510.33808-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027185510.33808-1-rpearsonhpe@gmail.com>
References: <20221027185510.33808-1-rpearsonhpe@gmail.com>
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
index 77437a0dd7ec..85d46ea24166 100644
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
index 9d92acfb2fcf..c4ab1a152491 100644
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
index ba359242118a..7afff56aa398 100644
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

