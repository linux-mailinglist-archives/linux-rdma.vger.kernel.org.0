Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7449ED86
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344443AbiA0ViQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344412AbiA0ViM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:12 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF3C061714
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:12 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id m9so8483689oia.12
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Qfvp20206DcmKvuNv+j3mvuVrDOObPq3yGtKsY16FI=;
        b=Y793FBN20EKl+qL3E8LCL49N/YLw2uFEY7d3pcW9yZqqtFaCGcffMdD2WH7iUG01yv
         shR008dH8j0144EanXXCTOG9uCOhA/ehmmAbiEASA4hGe4TChmFDkk+2iLk3HXAOypaP
         IB5Yb0upVFheyutKJo9C9Bcrs7/WTfFlVSHwsW0Yj35eiLS7IWwATSwabtIKpasBaHCD
         th5sYaSbyW9a1hp6h0W02MtPn5QTTvEreI6WEDdBScRt+bAj2hwT6jNzdqF7oJlnGs27
         KYa4U4No22vV603Is41XAlx7+VNXx/spglev8i7NnVS6fcsHFSaIL0F0sxJj+3P+aykf
         CM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Qfvp20206DcmKvuNv+j3mvuVrDOObPq3yGtKsY16FI=;
        b=3EdmfyqoNlC4Ml/IJT7dUaOgVrIJiGTwh+FCB1P4IWgphexQXmPTYXzzeoyZDf1DFY
         gv+LC5N9g+Zpw/pv9/q82EAo5HsHEv5a3eoyxDwWVQtKb5+BWGlxBH7guG83FzCo4m8H
         SO11vm4xSF9B33bF5cFPKF6Cl2vw7LIzoTB5RQGQw2gCXKTrmUjD7vXR94VcKXFg+Bmp
         bM/B8K48J471j91YpmLj4N/UB0RVNV5J2zBXIKqaZukKZMXuBp2sir65PqPaAcSDGXHz
         pQyWA2aeWB9IgPK9HwtSYji7xeGXfUb4tHMMwBzvq0cj37XtA5xrw3KIqcKuEva+gQAe
         onBw==
X-Gm-Message-State: AOAM533yF3q9mMjPxdd4r12LBrKqdOF2t/14p2SJc/+RoRYTeZLbWhR4
        enJfv0ipWTuFGAEJCk4jnP3z/zdncVI=
X-Google-Smtp-Source: ABdhPJxW0bs28lQHIt8gJEBg3sLVbbpYt+jXmcYhcQk+hi9sCaGQ9Wj0y5FLE/Igj2FaAoaQHHuG/Q==
X-Received: by 2002:a05:6808:14d0:: with SMTP id f16mr3537047oiw.32.1643319492114;
        Thu, 27 Jan 2022 13:38:12 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:11 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 09/26] RDMA/rxe: Introduce RXECB(skb)
Date:   Thu, 27 Jan 2022 15:37:38 -0600
Message-Id: <20220127213755.31697-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a #define RXECB(skb) to rxe_hdr.h as a short cut to
refer to single members of rxe_pkt_info which is stored in skb->cb
in the receive path. Use this to make some cleanups in rxe_recv.c

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_hdr.h  |  3 ++
 drivers/infiniband/sw/rxe/rxe_recv.c | 55 +++++++++++++---------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index e432f9e37795..2a85d1e40e6a 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -36,6 +36,9 @@ static inline struct sk_buff *PKT_TO_SKB(struct rxe_pkt_info *pkt)
 	return container_of((void *)pkt, struct sk_buff, cb);
 }
 
+/* alternative to access a single element of rxe_pkt_info from skb */
+#define RXECB(skb) ((struct rxe_pkt_info *)((skb)->cb))
+
 /*
  * IBA header types and methods
  *
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 814a002b8911..10020103ea4a 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -107,17 +107,15 @@ static int check_keys(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	return -EINVAL;
 }
 
-static int check_addr(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
+static int check_addr(struct rxe_dev *rxe, struct sk_buff *skb,
 		      struct rxe_qp *qp)
 {
-	struct sk_buff *skb = PKT_TO_SKB(pkt);
-
 	if (qp_type(qp) != IB_QPT_RC && qp_type(qp) != IB_QPT_UC)
 		goto done;
 
-	if (unlikely(pkt->port_num != qp->attr.port_num)) {
+	if (unlikely(RXECB(skb)->port_num != qp->attr.port_num)) {
 		pr_warn_ratelimited("port %d != qp port %d\n",
-				    pkt->port_num, qp->attr.port_num);
+				    RXECB(skb)->port_num, qp->attr.port_num);
 		goto err1;
 	}
 
@@ -167,8 +165,9 @@ static int check_addr(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	return -EINVAL;
 }
 
-static int hdr_check(struct rxe_pkt_info *pkt)
+static int hdr_check(struct sk_buff *skb)
 {
+	struct rxe_pkt_info *pkt = RXECB(skb);
 	struct rxe_dev *rxe = pkt->rxe;
 	struct rxe_port *port = &rxe->port;
 	struct rxe_qp *qp = NULL;
@@ -199,7 +198,7 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 		if (unlikely(err))
 			goto err2;
 
-		err = check_addr(rxe, pkt, qp);
+		err = check_addr(rxe, skb, qp);
 		if (unlikely(err))
 			goto err2;
 
@@ -222,17 +221,19 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 	return -EINVAL;
 }
 
-static inline void rxe_rcv_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb)
+static inline void rxe_rcv_pkt(struct sk_buff *skb)
 {
-	if (pkt->mask & RXE_REQ_MASK)
-		rxe_resp_queue_pkt(pkt->qp, skb);
+	if (RXECB(skb)->mask & RXE_REQ_MASK)
+		rxe_resp_queue_pkt(RXECB(skb)->qp, skb);
 	else
-		rxe_comp_queue_pkt(pkt->qp, skb);
+		rxe_comp_queue_pkt(RXECB(skb)->qp, skb);
 }
 
-static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
+static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 {
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	struct sk_buff *s;
+	struct rxe_pkt_info *pkt = RXECB(skb);
+	struct rxe_dev *rxe = pkt->rxe;
 	struct rxe_mcg *mcg;
 	struct rxe_mca *mca;
 	struct rxe_qp *qp;
@@ -274,26 +275,22 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		 * the last QP in the list.
 		 */
 		if (mca->qp_list.next != &mcg->qp_list) {
-			struct sk_buff *cskb;
-			struct rxe_pkt_info *cpkt;
-
-			cskb = skb_clone(skb, GFP_ATOMIC);
-			if (unlikely(!cskb))
+			s = skb_clone(skb, GFP_ATOMIC);
+			if (unlikely(!s))
 				continue;
 
 			if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
-				kfree_skb(cskb);
+				kfree_skb(s);
 				break;
 			}
 
-			cpkt = SKB_TO_PKT(cskb);
-			cpkt->qp = qp;
+			RXECB(s)->qp = qp;
 			rxe_add_ref(qp);
-			rxe_rcv_pkt(cpkt, cskb);
+			rxe_rcv_pkt(s);
 		} else {
-			pkt->qp = qp;
+			RXECB(skb)->qp = qp;
 			rxe_add_ref(qp);
-			rxe_rcv_pkt(pkt, skb);
+			rxe_rcv_pkt(skb);
 			skb = NULL;	/* mark consumed */
 		}
 	}
@@ -326,7 +323,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
  */
 static int rxe_chk_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
 {
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	struct rxe_pkt_info *pkt = RXECB(skb);
 	const struct ib_gid_attr *gid_attr;
 	union ib_gid dgid;
 	union ib_gid *pdgid;
@@ -359,7 +356,7 @@ static int rxe_chk_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
 void rxe_rcv(struct sk_buff *skb)
 {
 	int err;
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	struct rxe_pkt_info *pkt = RXECB(skb);
 	struct rxe_dev *rxe = pkt->rxe;
 
 	if (unlikely(skb->len < RXE_BTH_BYTES))
@@ -378,7 +375,7 @@ void rxe_rcv(struct sk_buff *skb)
 	if (unlikely(skb->len < header_size(pkt)))
 		goto drop;
 
-	err = hdr_check(pkt);
+	err = hdr_check(skb);
 	if (unlikely(err))
 		goto drop;
 
@@ -389,9 +386,9 @@ void rxe_rcv(struct sk_buff *skb)
 	rxe_counter_inc(rxe, RXE_CNT_RCVD_PKTS);
 
 	if (unlikely(bth_qpn(pkt) == IB_MULTICAST_QPN))
-		rxe_rcv_mcast_pkt(rxe, skb);
+		rxe_rcv_mcast_pkt(skb);
 	else
-		rxe_rcv_pkt(pkt, skb);
+		rxe_rcv_pkt(skb);
 
 	return;
 
-- 
2.32.0

