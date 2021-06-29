Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB47B3B792B
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhF2UQy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 16:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhF2UQx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 16:16:53 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44FAC061766
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:14:24 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s17so271888oij.0
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ZP8OQV1IW6mwxiCTa9PrhgGhzRq3ovPPPsyQVW7nmQ=;
        b=idZdwXldCOhfip19zWTPoqKVlD6MJ5ckeeOjhrwPiWFRjEu3rL4h3F8tT8TXocPHZk
         VdR9a6HNUROr1xpua9HfZOcwdSIRwyyf7Q500haxyeP8ZxuxvJZkkWJ3+kmQ2CRrEBTz
         MhlL5Ej9yACkAvwAqvrkYlWYz03wOIU2t+s976BN+8xTpKwZBooGvzwnZMzCPqx3T2Rj
         gLFOWiBjtv7kEvaHT7IJjwZUrSpXptVY5XZZD3sKbQU6BnHCYrn8V14/AyLzt6NsLCUz
         ZI9rubIN5d+ciTm9qFtn8sitExIz/0tAsVlnUI76/U7TECtTv4wM79YcOYeXRzxu5aGM
         NznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ZP8OQV1IW6mwxiCTa9PrhgGhzRq3ovPPPsyQVW7nmQ=;
        b=aP/pXh44djjXdKZDQMtGKlphczXweXlKJME7uNJbSTPhrynbfGCjb2JwyfMKgLULWu
         LbBh2qJNJ0G0Ff9dvo8Y4wWJE+SA5xd1FMlCHZNtpCoYLrgjvlutZalcxHh/FJwtHpQ4
         fn7G+aCtA54AOMQJSNnmfzoP452OIDj63of8zTHt/JAOZfmuhd9MVnyU8yLhLZWgnnek
         WVEoF4sD94/ue+Ii0DIeW5nDdgCqCBGOyAVreOWp0HpH7chIDbK5Z/hJ1dr/kA77gNXp
         aBZXZnKi/vV8862DZwKhbLGJ7JRD0ac3MwXSTaQR/bO+W4y+3ayDYSk5yq1G92sRDzB5
         1Bbg==
X-Gm-Message-State: AOAM531Dj3AzabblCx10i3Ggk12rdlb7qi0sc6HdrUlIBiBoaGEgIC8Y
        DPdYyQdUp7tdcH+Vc0DZYTE=
X-Google-Smtp-Source: ABdhPJxYdl8c9L4sBGLngrsdoqGszJiOywtuinDBj8iGLvL2bxYe6rkTzgL+p/lv08yO1hGnIbzv5A==
X-Received: by 2002:a54:4514:: with SMTP id l20mr23183619oil.1.1624997664206;
        Tue, 29 Jun 2021 13:14:24 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id k14sm2547284oon.5.2021.06.29.13.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 13:14:23 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 3/5] RDMA/rxe: Move ICRC generation to a subroutine
Date:   Tue, 29 Jun 2021 15:14:08 -0500
Message-Id: <20210629201412.28306-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210629201412.28306-1-rpearsonhpe@gmail.com>
References: <20210629201412.28306-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Isolate ICRC generation into a single subroutine named rxe_generate_icrc()
in rxe_icrc.c. Remove scattered crc generation code from elsewhere.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c |  4 +--
 drivers/infiniband/sw/rxe/rxe_icrc.c | 13 ++++++++
 drivers/infiniband/sw/rxe/rxe_loc.h  | 10 +++---
 drivers/infiniband/sw/rxe/rxe_mr.c   | 47 ++++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_net.c  |  8 ++---
 drivers/infiniband/sw/rxe/rxe_req.c  | 13 ++------
 drivers/infiniband/sw/rxe/rxe_resp.c | 33 +++++--------------
 7 files changed, 54 insertions(+), 74 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 58ad9c2644f3..d2d802c776fd 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -349,7 +349,7 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, payload_addr(pkt),
-			payload_size(pkt), RXE_TO_MR_OBJ, NULL);
+			payload_size(pkt), RXE_TO_MR_OBJ);
 	if (ret) {
 		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
@@ -371,7 +371,7 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, &atomic_orig,
-			sizeof(u64), RXE_TO_MR_OBJ, NULL);
+			sizeof(u64), RXE_TO_MR_OBJ);
 	if (ret) {
 		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 5193dfa94a75..5424b8bea908 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -105,3 +105,16 @@ int rxe_icrc_check(struct sk_buff *skb)
 
 	return 0;
 }
+
+/* rxe_icrc_generate- compute ICRC for a packet. */
+void rxe_icrc_generate(struct rxe_pkt_info *pkt, struct sk_buff *skb)
+{
+	__be32 *icrcp;
+	u32 icrc;
+
+	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
+	icrc = rxe_icrc_hdr(pkt, skb);
+	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
+				payload_size(pkt) + bth_pad(pkt));
+	*icrcp = ~icrc;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 3468a61efe4e..2c724b9970d6 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -77,10 +77,9 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
-		enum rxe_mr_copy_dir dir, u32 *crcp);
-int copy_data(struct rxe_pd *pd, int access,
-	      struct rxe_dma_info *dma, void *addr, int length,
-	      enum rxe_mr_copy_dir dir, u32 *crcp);
+		enum rxe_mr_copy_dir dir);
+int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
+	      void *addr, int length, enum rxe_mr_copy_dir dir);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
@@ -101,7 +100,7 @@ void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 /* rxe_net.c */
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt);
-int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
+int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		    struct sk_buff *skb);
 const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
@@ -196,6 +195,7 @@ int rxe_responder(void *arg);
 /* rxe_icrc.c */
 u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 int rxe_icrc_check(struct sk_buff *skb);
+void rxe_icrc_generate(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 
 void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 6aabcb4de235..f94fd143e27b 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -279,11 +279,10 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 }
 
 /* copy data from a range (vaddr, vaddr+length-1) to or from
- * a mr object starting at iova. Compute incremental value of
- * crc32 if crcp is not zero. caller must hold a reference to mr
+ * a mr object starting at iova.
  */
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
-		enum rxe_mr_copy_dir dir, u32 *crcp)
+		enum rxe_mr_copy_dir dir)
 {
 	int			err;
 	int			bytes;
@@ -293,24 +292,23 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	int			m;
 	int			i;
 	size_t			offset;
-	u32			crc = crcp ? (*crcp) : 0;
+	u8			*src;
+	u8			*dest;
 
 	if (length == 0)
 		return 0;
 
 	if (mr->type == RXE_MR_TYPE_DMA) {
-		u8 *src, *dest;
-
-		src = (dir == RXE_TO_MR_OBJ) ? addr : ((void *)(uintptr_t)iova);
-
-		dest = (dir == RXE_TO_MR_OBJ) ? ((void *)(uintptr_t)iova) : addr;
+		if (dir == RXE_TO_MR_OBJ) {
+			src = addr;
+			dest = ((void *)(uintptr_t)iova);
+		} else {
+			src = ((void *)(uintptr_t)iova);
+			dest = addr;
+		}
 
 		memcpy(dest, src, length);
 
-		if (crcp)
-			*crcp = rxe_crc32(to_rdev(mr->ibmr.device), *crcp, dest,
-					  length);
-
 		return 0;
 	}
 
@@ -328,11 +326,14 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	buf	= map[0]->buf + i;
 
 	while (length > 0) {
-		u8 *src, *dest;
-
 		va	= (u8 *)(uintptr_t)buf->addr + offset;
-		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
-		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
+		if (dir == RXE_TO_MR_OBJ) {
+			src = addr;
+			dest = va;
+		} else {
+			src = va;
+			dest = addr;
+		}
 
 		bytes	= buf->size - offset;
 
@@ -341,10 +342,6 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 
 		memcpy(dest, src, bytes);
 
-		if (crcp)
-			crc = rxe_crc32(to_rdev(mr->ibmr.device), crc, dest,
-					bytes);
-
 		length	-= bytes;
 		addr	+= bytes;
 
@@ -359,9 +356,6 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		}
 	}
 
-	if (crcp)
-		*crcp = crc;
-
 	return 0;
 
 err1:
@@ -377,8 +371,7 @@ int copy_data(
 	struct rxe_dma_info	*dma,
 	void			*addr,
 	int			length,
-	enum rxe_mr_copy_dir	dir,
-	u32			*crcp)
+	enum rxe_mr_copy_dir	dir)
 {
 	int			bytes;
 	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
@@ -439,7 +432,7 @@ int copy_data(
 		if (bytes > 0) {
 			iova = sge->addr + offset;
 
-			err = rxe_mr_copy(mr, iova, addr, bytes, dir, crcp);
+			err = rxe_mr_copy(mr, iova, addr, bytes, dir);
 			if (err)
 				goto err2;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 6968c247bcf7..ffbe8f95405e 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -343,7 +343,7 @@ static int prepare6(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 	return 0;
 }
 
-int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc)
+int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
 	int err = 0;
 
@@ -352,8 +352,6 @@ int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc)
 	else if (skb->protocol == htons(ETH_P_IPV6))
 		err = prepare6(pkt, skb);
 
-	*crc = rxe_icrc_hdr(pkt, skb);
-
 	if (ether_addr_equal(skb->dev->dev_addr, rxe_get_av(pkt)->dmac))
 		pkt->mask |= RXE_LOOPBACK_MASK;
 
@@ -396,7 +394,7 @@ static int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 	}
 
 	if (unlikely(net_xmit_eval(err))) {
-		pr_debug("error sending packet: %d\n", err);
+		pr_info("error sending packet: %d\n", err);
 		return -EAGAIN;
 	}
 
@@ -438,6 +436,8 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		goto drop;
 	}
 
+	rxe_icrc_generate(pkt, skb);
+
 	if (pkt->mask & RXE_LOOPBACK_MASK)
 		err = rxe_loopback(pkt, skb);
 	else
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index c57699cc6578..3894197a82f6 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -466,12 +466,9 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		       struct rxe_pkt_info *pkt, struct sk_buff *skb,
 		       int paylen)
 {
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-	u32 crc = 0;
-	u32 *p;
 	int err;
 
-	err = rxe_prepare(pkt, skb, &crc);
+	err = rxe_prepare(pkt, skb);
 	if (err)
 		return err;
 
@@ -479,7 +476,6 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		if (wqe->wr.send_flags & IB_SEND_INLINE) {
 			u8 *tmp = &wqe->dma.inline_data[wqe->dma.sge_offset];
 
-			crc = rxe_crc32(rxe, crc, tmp, paylen);
 			memcpy(payload_addr(pkt), tmp, paylen);
 
 			wqe->dma.resid -= paylen;
@@ -487,8 +483,7 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		} else {
 			err = copy_data(qp->pd, 0, &wqe->dma,
 					payload_addr(pkt), paylen,
-					RXE_FROM_MR_OBJ,
-					&crc);
+					RXE_FROM_MR_OBJ);
 			if (err)
 				return err;
 		}
@@ -496,12 +491,8 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			u8 *pad = payload_addr(pkt) + paylen;
 
 			memset(pad, 0, bth_pad(pkt));
-			crc = rxe_crc32(rxe, crc, pad, bth_pad(pkt));
 		}
 	}
-	p = payload_addr(pkt) + paylen + bth_pad(pkt);
-
-	*p = ~crc;
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 3743dc39b60c..685b8aebd627 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -536,7 +536,7 @@ static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
 	int err;
 
 	err = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
-			data_addr, data_len, RXE_TO_MR_OBJ, NULL);
+			data_addr, data_len, RXE_TO_MR_OBJ);
 	if (unlikely(err))
 		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
 					: RESPST_ERR_MALFORMED_WQE;
@@ -552,7 +552,7 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int data_len = payload_size(pkt);
 
 	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
-			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ, NULL);
+			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
 	if (err) {
 		rc = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
@@ -613,13 +613,10 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 					  int opcode,
 					  int payload,
 					  u32 psn,
-					  u8 syndrome,
-					  u32 *crcp)
+					  u8 syndrome)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct sk_buff *skb;
-	u32 crc = 0;
-	u32 *p;
 	int paylen;
 	int pad;
 	int err;
@@ -651,20 +648,12 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	if (ack->mask & RXE_ATMACK_MASK)
 		atmack_set_orig(ack, qp->resp.atomic_orig);
 
-	err = rxe_prepare(ack, skb, &crc);
+	err = rxe_prepare(ack, skb);
 	if (err) {
 		kfree_skb(skb);
 		return NULL;
 	}
 
-	if (crcp) {
-		/* CRC computation will be continued by the caller */
-		*crcp = crc;
-	} else {
-		p = payload_addr(ack) + payload + bth_pad(ack);
-		*p = ~crc;
-	}
-
 	return skb;
 }
 
@@ -682,8 +671,6 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	int opcode;
 	int err;
 	struct resp_res *res = qp->resp.res;
-	u32 icrc;
-	u32 *p;
 
 	if (!res) {
 		/* This is the first time we process that request. Get a
@@ -742,24 +729,20 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	payload = min_t(int, res->read.resid, mtu);
 
 	skb = prepare_ack_packet(qp, req_pkt, &ack_pkt, opcode, payload,
-				 res->cur_psn, AETH_ACK_UNLIMITED, &icrc);
+				 res->cur_psn, AETH_ACK_UNLIMITED);
 	if (!skb)
 		return RESPST_ERR_RNR;
 
 	err = rxe_mr_copy(res->read.mr, res->read.va, payload_addr(&ack_pkt),
-			  payload, RXE_FROM_MR_OBJ, &icrc);
+			  payload, RXE_FROM_MR_OBJ);
 	if (err)
 		pr_err("Failed copying memory\n");
 
 	if (bth_pad(&ack_pkt)) {
-		struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 		u8 *pad = payload_addr(&ack_pkt) + payload;
 
 		memset(pad, 0, bth_pad(&ack_pkt));
-		icrc = rxe_crc32(rxe, icrc, pad, bth_pad(&ack_pkt));
 	}
-	p = payload_addr(&ack_pkt) + payload + bth_pad(&ack_pkt);
-	*p = ~icrc;
 
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (err) {
@@ -984,7 +967,7 @@ static int send_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	struct sk_buff *skb;
 
 	skb = prepare_ack_packet(qp, pkt, &ack_pkt, IB_OPCODE_RC_ACKNOWLEDGE,
-				 0, psn, syndrome, NULL);
+				 0, psn, syndrome);
 	if (!skb) {
 		err = -ENOMEM;
 		goto err1;
@@ -1008,7 +991,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	skb = prepare_ack_packet(qp, pkt, &ack_pkt,
 				 IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE, 0, pkt->psn,
-				 syndrome, NULL);
+				 syndrome);
 	if (!skb) {
 		rc = -ENOMEM;
 		goto out;
-- 
2.30.2

