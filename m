Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44266613F01
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJaU2t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiJaU2r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:47 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC313EB5
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:44 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13c569e5ff5so14331759fac.6
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9aWvP5E+EuHgWPrBiedIOT+sa781DTiq4CA4EkIugM=;
        b=k3EYxISd6drpmcOhGYsKRCvPZKLoS7RXq/4JM5irmJXLxNgqfgnmRAIK717IrWXxCB
         +9eZriH27rBJVbdW2Pr7AGP8ro8HJBxq7ZEuxRDKmQwVcLqbGKy9uOcBMZRQLCVBB3I/
         PLWiK1Q32Fc3LEef1EgptsxinX90YF2wnoOHBk/A4kY4RUyw0JJedp9LIiT455AUDEG/
         dJpHG6Lriox7xqRO0FjqBxkPSuJA1r84dViLVULjmR97Xv8POx4NQRrALFvbktfv5fkb
         7+mEZkIwnn2vVAKFeZAQzMlhWCiWyDzgPKAGQDVZ7cjYQnbWttdwTETSaaBflS/pDubM
         8LHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9aWvP5E+EuHgWPrBiedIOT+sa781DTiq4CA4EkIugM=;
        b=m+1LZdTYtI6SLvWYSBS89ULHmjMHEVFr/dEVV2H8n3Z/uyugRKIWSxMJrz27GeaXB8
         JUl/GJSnqLSC2HyFmnv+RtZvN7Rlssu201B3E4JS7OU5S0Gsx4eFQS559NtbWtiDMIq8
         jdRAfDt4JJkM1TgsA4HLqou7AxuBI6pBA9toKabSU02KtB8BANZ0lX/iX7kCDx2NCReW
         WWIk0928lZGNRVpavWWlo4kZI9rpDmi31RuMkPmd5GYnObhG+F8vHLU3dY7oLdtLjb+h
         W/FwC6i/NZ1zPj+WNSmBJe2zUOM+ab2W/RW3kHGFYcyGf0WCrkS4LzqccvzPqxhDaeAC
         jIxA==
X-Gm-Message-State: ACrzQf14L0Wu9dcVJvLMX+j4obttclhvCGwaBoG+cM/YhLWhPr6KAQO6
        yozijwi/2TJLlK83sFZRtkU=
X-Google-Smtp-Source: AMsMyM4dA5s3MAqDAgl+T9rUSn1YgAPVFi2O16aanX1umDzHOVBLNGpiukw7d8r2SeCYacwGUSsAIw==
X-Received: by 2002:a05:6870:428d:b0:133:24a1:c245 with SMTP id y13-20020a056870428d00b0013324a1c245mr8648886oah.153.1667248124001;
        Mon, 31 Oct 2022 13:28:44 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:43 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 12/18] RDMA/rxe: Extend rxe_init_packet() to support frags
Date:   Mon, 31 Oct 2022 15:28:01 -0500
Message-Id: <20221031202805.19138-12-rpearsonhpe@gmail.com>
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

Add a subroutine rxe_can_use_sg() to determine if a packet is
a candidate for a fragmented skb. Add a global variable rxe_use_sg
to control whether to support nonlinear skbs. Modify rxe_init_packet()
to test if the packet should use a fragmented skb. Fixup calls to
rxe_init_packet() to use the new API but disable creating nonlinear
skbs for now.

This is in preparation for using fragmented skbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  3 ++
 drivers/infiniband/sw/rxe/rxe.h      |  3 ++
 drivers/infiniband/sw/rxe/rxe_loc.h  |  2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c   | 12 +++--
 drivers/infiniband/sw/rxe/rxe_net.c  | 79 +++++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_req.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c |  7 ++-
 7 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 51daac5c4feb..388d8103ec20 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -13,6 +13,9 @@ MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
 MODULE_DESCRIPTION("Soft RDMA transport");
 MODULE_LICENSE("Dual BSD/GPL");
 
+/* if true allow using fragmented skbs */
+bool rxe_use_sg;
+
 /* free resources for a rxe device all objects created for this device must
  * have been destroyed
  */
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 30fbdf3bc76a..c78fb497d9c3 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -30,6 +30,9 @@
 #include "rxe_verbs.h"
 #include "rxe_loc.h"
 
+/* if true allow using fragmented skbs */
+extern bool rxe_use_sg;
+
 /*
  * Version 1 and Version 2 are identical on 64 bit machines, but on 32 bit
  * machines Version 2 has a different struct layout.
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 4e5fbc33277d..12fd5811cd79 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -101,7 +101,7 @@ void rxe_mw_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_net.c */
 struct sk_buff *rxe_init_packet(struct rxe_qp *qp, struct rxe_av *av,
-				struct rxe_pkt_info *pkt);
+				struct rxe_pkt_info *pkt, bool *is_frag);
 int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 		struct sk_buff *skb);
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 6fe5bbe43a60..cf538d97c7a5 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -541,7 +541,7 @@ int rxe_num_dma_frags(const struct rxe_pd *pd, const struct rxe_dma_info *dma,
 	struct rxe_mr *mr = NULL;
 	int bytes;
 	u64 iova;
-	int ret;
+	int nf;
 	int num_frags = 0;
 
 	if (length == 0)
@@ -572,18 +572,22 @@ int rxe_num_dma_frags(const struct rxe_pd *pd, const struct rxe_dma_info *dma,
 		bytes = min_t(int, length, sge->length - buf_offset);
 		if (bytes > 0) {
 			iova = sge->addr + buf_offset;
-			ret = rxe_num_mr_frags(mr, iova, length);
-			if (ret < 0) {
+			nf = rxe_num_mr_frags(mr, iova, length);
+			if (nf < 0) {
 				rxe_put(mr);
-				return ret;
+				return nf;
 			}
 
+			num_frags += nf;
 			buf_offset += bytes;
 			resid -= bytes;
 			length -= bytes;
 		}
 	}
 
+	if (mr)
+		rxe_put(mr);
+
 	return num_frags;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index faabc444d546..c6d8f5c80562 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -442,8 +442,60 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	return err;
 }
 
+/**
+ * rxe_can_use_sg() - determine if packet is a candidate for fragmenting
+ * @rxe: the rxe device
+ * @pkt: packet info
+ *
+ * Limit to packets with:
+ *	rxe_use_sg set
+ *	qp is RC
+ *	ndev supports SG
+ *	#sges less than #frags for sends
+ *
+ * Returns: true if conditions are met else 0
+ */
+static bool rxe_can_use_sg(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	int length = pkt->paylen - rxe_opcode[pkt->opcode].length
+				 - RXE_ICRC_SIZE;
+	int nf;
+
+	if (!rxe_use_sg)
+		return false;
+	if (qp_type(pkt->qp) != IB_QPT_RC)
+		return false;
+	if (!(rxe->ndev->features & NETIF_F_SG))
+		return false;
+
+	/* check we don't have a pathological sge list with lots of
+	 * short segments. Recall we need one extra frag for icrc.
+	 */
+	if (pkt->mask & RXE_SEND_MASK) {
+		nf = rxe_num_dma_frags(qp->pd, &pkt->wqe->dma, length);
+		return (nf >= 0 && nf <= MAX_SKB_FRAGS - 1) ? true : false;
+	}
+
+	return true;
+}
+
+#define RXE_MIN_SKB_SIZE (256)
+
+/**
+ * rxe_init_packet - allocate and initialize a new skb
+ * @qp: the queue pair
+ * @av: remote address vector
+ * @pkt: packet info
+ * @frag: optional return value for fragmented skb
+ *	  on call if frag == NULL do not use fragmented skb
+ *	  on return if not NULL set *frag to 1
+ *	  if packet will be fragmented else 0
+ *
+ * Returns: an skb on success else NULL
+ */
 struct sk_buff *rxe_init_packet(struct rxe_qp *qp, struct rxe_av *av,
-				struct rxe_pkt_info *pkt)
+				struct rxe_pkt_info *pkt, bool *frag)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	unsigned int hdr_len;
@@ -451,6 +503,7 @@ struct sk_buff *rxe_init_packet(struct rxe_qp *qp, struct rxe_av *av,
 	struct net_device *ndev;
 	const struct ib_gid_attr *attr;
 	const int port_num = 1;
+	int skb_size;
 
 	attr = rdma_get_gid_attr(&rxe->ib_dev, port_num, av->grh.sgid_index);
 	if (IS_ERR(attr))
@@ -469,9 +522,19 @@ struct sk_buff *rxe_init_packet(struct rxe_qp *qp, struct rxe_av *av,
 		rcu_read_unlock();
 		goto out;
 	}
-	skb = alloc_skb(pkt->paylen + hdr_len + LL_RESERVED_SPACE(ndev),
-			GFP_ATOMIC);
 
+	skb_size = LL_RESERVED_SPACE(ndev) + hdr_len + pkt->paylen;
+	if (frag) {
+		if (rxe_use_sg && (skb_size > RXE_MIN_SKB_SIZE) &&
+		    rxe_can_use_sg(qp, pkt)) {
+			skb_size = RXE_MIN_SKB_SIZE;
+			*frag = true;
+		} else {
+			*frag = false;
+		}
+	}
+
+	skb = alloc_skb(skb_size, GFP_ATOMIC);
 	if (unlikely(!skb)) {
 		rcu_read_unlock();
 		goto out;
@@ -480,7 +543,7 @@ struct sk_buff *rxe_init_packet(struct rxe_qp *qp, struct rxe_av *av,
 	skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
 
 	/* FIXME: hold reference to this netdev until life of this skb. */
-	skb->dev	= ndev;
+	skb->dev = ndev;
 	rcu_read_unlock();
 
 	if (av->network_type == RXE_NETWORK_TYPE_IPV4)
@@ -488,10 +551,10 @@ struct sk_buff *rxe_init_packet(struct rxe_qp *qp, struct rxe_av *av,
 	else
 		skb->protocol = htons(ETH_P_IPV6);
 
-	pkt->rxe	= rxe;
-	pkt->port_num	= port_num;
-	pkt->hdr	= skb_put(skb, pkt->paylen);
-	pkt->mask	|= RXE_GRH_MASK;
+	if (frag && *frag)
+		pkt->hdr = skb_put(skb, rxe_opcode[pkt->opcode].length);
+	else
+		pkt->hdr = skb_put(skb, pkt->paylen);
 
 out:
 	rdma_put_gid_attr(attr);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 0a4b8825bd55..71a65f2a5d6d 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -491,7 +491,7 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 						pad + RXE_ICRC_SIZE;
 
 	/* init skb */
-	skb = rxe_init_packet(qp, av, pkt);
+	skb = rxe_init_packet(qp, av, pkt, NULL);
 	if (unlikely(!skb))
 		goto err_out;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 8503d22f9114..8868415b71b6 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -665,6 +665,7 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 					  u32 psn,
 					  u8 syndrome)
 {
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct sk_buff *skb;
 	int paylen;
 	int pad;
@@ -672,14 +673,16 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 
 	pad = (-payload) & 0x3;
 	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
-	ack->paylen = paylen;
 
+	ack->rxe = rxe;
 	ack->qp = qp;
 	ack->opcode = opcode;
 	ack->mask = rxe_opcode[opcode].mask;
+	ack->paylen = paylen;
 	ack->psn = psn;
+	ack->port_num = 1;
 
-	skb = rxe_init_packet(qp, &qp->pri_av, ack);
+	skb = rxe_init_packet(qp, &qp->pri_av, ack, NULL);
 	if (!skb)
 		return NULL;
 
-- 
2.34.1

