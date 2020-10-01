Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E102805E3
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbgJARtM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733009AbgJARtK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:49:10 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA10C0613D0
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:49:10 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o8so6326575otl.4
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C62gDt66uknWUy7fAfUfQKtDdScjtj2a0ful2t+NuZ8=;
        b=p/WwbWFSbKfVA5zQIGnBDdu7C1cUUF+bAUcJZYflfWTJs3LVrHryvzKUK2rksl30KA
         qZfgBjqo/V5LELncDH8kc3szisi0inrz5o/t+xYXH9sqFDJhaOZqpV+qppC6Nw0BMyll
         Z7b3iIjBjcZQvz8Ot+FEQUagYVczl2F56FTTMBfq7qXTwC9UA8FSrCs6QhIoMW4M+jc7
         GUJI+ziyObjoLA7Sp8+Yt+pOE60VGBzzDNcbL+pZumBC98aDvO38hBVAupQ/0qzcUBgR
         PfUNj7boVyx4w2anF5CRrI3YwCJQvFJiSx8wzooos2DQHtsD42GoKak50GesIpoojMIY
         8Acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C62gDt66uknWUy7fAfUfQKtDdScjtj2a0ful2t+NuZ8=;
        b=ED2GsFnM/vMKfXGlRYigExt+IIFJP4dEn2cUAk+FBk4Xnjbfw4ktISIFqOBosFInLk
         zqEm47RcGf79zUAS/bpuyuarCIpVHmkVijYqTxwLm4d3VM8Ezxrh0tOgLuSRBTyKD/BW
         D9HhYYcIJr5OwnbLOaPvCrTFKW+CKPwkMy6q0WMeoRzpijD8mH3r8fxc0dm9pFN5VLuH
         r0tVdEerIqJjqMY2iFKn82/fsOceDBYpZPQSVislb7ivrNpEVhObxkhp00vHf6f9Sxzo
         5vEIDgyPbk3gFl3Loho1l+8a/X/G5kswKhq6CBvIvFZw/x3LEkfmk6yZkmN9pMI+lkLM
         DRKA==
X-Gm-Message-State: AOAM533oUaHrV/mHcjR4yUvNE2/yx11+6Zv2fjrjp5j1wXNfdUtd0bPd
        vjvvF4jXtRZXkjx//wxP1mU=
X-Google-Smtp-Source: ABdhPJxbJWXNNmYtxzdG5TYfonOGDINFPj/BOkxwNxNOzMAKMF/OLIgY8AaqxtZFU0JFw5OUGxUeeg==
X-Received: by 2002:a05:6830:1e89:: with SMTP id n9mr5592654otr.274.1601574550171;
        Thu, 01 Oct 2020 10:49:10 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id s13sm1374025otq.5.2020.10.01.10.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:49:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 19/19] rdma_rxe: moved rxe_xmit_packet to rxe_net.c
Date:   Thu,  1 Oct 2020 12:48:47 -0500
Message-Id: <20201001174847.4268-20-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No good reason to stick such a large subroutine in a
header file as an inline function.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h | 47 ++---------------------------
 drivers/infiniband/sw/rxe/rxe_net.c | 47 +++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index fcffd5075b18..9d3c59694e7b 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -124,8 +124,6 @@ int rxe_mw_check_access(struct rxe_qp *qp, struct rxe_mw *mw,
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
-void rxe_loopback(struct sk_buff *skb);
-int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
@@ -133,6 +131,8 @@ const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
 struct device *rxe_dma_device(struct rxe_dev *rxe);
 int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid);
+int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
+		    struct sk_buff *skb);
 
 /* rxe_qp.c */
 int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init);
@@ -230,47 +230,4 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 	return rxe_wr_opcode_info[opcode].mask[qp->ibqp.qp_type];
 }
 
-static inline int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
-				  struct sk_buff *skb)
-{
-	int err;
-	int is_request = pkt->mask & RXE_REQ_MASK;
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-
-	if ((is_request && (qp->req.state != QP_STATE_READY)) ||
-	    (!is_request && (qp->resp.state != QP_STATE_READY))) {
-		pr_info("Packet dropped. QP is not in ready state\n");
-		goto drop;
-	}
-
-	if (pkt->mask & RXE_LOOPBACK_MASK) {
-		memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
-		rxe_loopback(skb);
-		err = 0;
-	} else {
-		err = rxe_send(pkt, skb);
-	}
-
-	if (err) {
-		rxe->xmit_errors++;
-		rxe_counter_inc(rxe, RXE_CNT_SEND_ERR);
-		return err;
-	}
-
-	if ((qp_type(qp) != IB_QPT_RC) &&
-	    (pkt->mask & RXE_END_MASK)) {
-		pkt->wqe->state = wqe_state_done;
-		rxe_run_task(&qp->comp.task, 1);
-	}
-
-	rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
-	goto done;
-
-drop:
-	kfree_skb(skb);
-	err = 0;
-done:
-	return err;
-}
-
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 31b93e7e1e2f..759d2c751e5d 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -394,7 +394,7 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
 	rxe_drop_ref(qp);
 }
 
-int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
+static int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
 	int err;
 
@@ -424,11 +424,54 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 	return 0;
 }
 
-void rxe_loopback(struct sk_buff *skb)
+static void rxe_loopback(struct sk_buff *skb)
 {
 	rxe_rcv(skb);
 }
 
+int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
+		    struct sk_buff *skb)
+{
+	int err;
+	int is_request = pkt->mask & RXE_REQ_MASK;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+
+	if ((is_request && (qp->req.state != QP_STATE_READY)) ||
+	    (!is_request && (qp->resp.state != QP_STATE_READY))) {
+		pr_info("Packet dropped. QP is not in ready state\n");
+		goto drop;
+	}
+
+	if (pkt->mask & RXE_LOOPBACK_MASK) {
+		memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
+		rxe_loopback(skb);
+		err = 0;
+	} else {
+		err = rxe_send(pkt, skb);
+	}
+
+	if (err) {
+		rxe->xmit_errors++;
+		rxe_counter_inc(rxe, RXE_CNT_SEND_ERR);
+		return err;
+	}
+
+	if ((qp_type(qp) != IB_QPT_RC) &&
+	    (pkt->mask & RXE_END_MASK)) {
+		pkt->wqe->state = wqe_state_done;
+		rxe_run_task(&qp->comp.task, 1);
+	}
+
+	rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
+	goto done;
+
+drop:
+	kfree_skb(skb);
+	err = 0;
+done:
+	return err;
+}
+
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt)
 {
-- 
2.25.1

