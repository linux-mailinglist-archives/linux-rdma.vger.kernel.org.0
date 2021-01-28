Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE1E3081FD
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jan 2021 00:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhA1XgG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 18:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhA1Xfj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 18:35:39 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89B7C061574
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 15:34:47 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id e70so6940039ote.11
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 15:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SNPHPdWJPZ2f+qmznYRJ8qHYUYRVQ+yuc9DRf8WEokY=;
        b=uZlFw77cJyPdUISx4ETJxGKPUiCFeb9q5YPgR5gcH3GxvfGMPlTQYLxQvyMNHpuuG/
         MOG649VZniDVN6s43SqRgeeCFKq/x1YnN3wHzfMfdNlZW0Oq5D7EASCFYsbAlH1PAvhd
         Em9H/J5ThfY+JHIOPF0lXSp72dqRA67Qg6v4vFMowslvWz/5DbS+U1CbfOr4Dk9xaOMq
         //GQvdH8Qxvf5WTXf683jppZOa8f0e2Y7JRa46LviCTxRMPr4ATbnbAcwtMXmyumXdw7
         6f9JMfOETLO/L48AQmHBwClyvkXYQgZRWx67vnUCAcbHgdX3TWfkwFZfsMn5B4vl/RIw
         49Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SNPHPdWJPZ2f+qmznYRJ8qHYUYRVQ+yuc9DRf8WEokY=;
        b=E4l2SD/YkCPRhfQxwN6iW4kP8TJbfQNCaL7wtjhVKEki9pPIgjLhshuUIO/6fXvimm
         qwwiMjCnk0RyAy1tg1dRUKdT8j2yjtvkhP76OspLe3mspY7q5ZlwT1taSLiB7PsJX9I0
         1odp26aRHVgx/8chqs+8BsydDNuYFxsrGbAsEmrkYO3UwBB8ZcMVFtlrKiKROxLSs4Je
         vONFDfp8Y8EDlPkfej7h/n8gcP8tEKkQxHDM1zbVRd2U194watbEbIV9y/ooo9OJCLgx
         bCsR7x0vFnUFIjX1e+lC92KpONy0MK6OKxmmbeQpqgzoqvu+r6QTVB8X1PeKNsuNWO4d
         yD7w==
X-Gm-Message-State: AOAM530nH9xEsa/DwNV28z+HY6SOHr58Y+DQBJRtYOOsuCAX0EzZgPgS
        I0ZGxAbFN5+iXy9bTV7Ukzs=
X-Google-Smtp-Source: ABdhPJypVCsMsk/PQHbJEIPIBxxFvUQ3pdubFZhoZLId1DV2dn+O0V5aJDKwEz9hS5NpOeSyPX/4cA==
X-Received: by 2002:a9d:1c9a:: with SMTP id l26mr1255798ota.316.1611876887328;
        Thu, 28 Jan 2021 15:34:47 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-0a17-c366-3c70-b476.res6.spectrum.com. [2603:8081:140c:1a00:a17:c366:3c70:b476])
        by smtp.gmail.com with ESMTPSA id q127sm1617379oia.18.2021.01.28.15.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 15:34:46 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()
Date:   Thu, 28 Jan 2021 17:33:19 -0600
Message-Id: <20210128233318.2591-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_udp_encap_recv() drops the reference to rxe->ib_dev taken by
rxe_get_dev_from_net() which should be held until each received
skb is freed. This patch moves the calls to ib_device_put() to
each place a received skb is freed. It also takes references to
the ib_device for each cloned skb created to process received
multicast packets.

Fixes: 4c173f596b3ff ("RDMA/rxe: Use ib_device_get_by_netdev()
                instead of open coding")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 49 ++++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_net.c  | 12 +++----
 drivers/infiniband/sw/rxe/rxe_recv.c | 15 +++++++--
 drivers/infiniband/sw/rxe/rxe_resp.c |  3 ++
 4 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 0a1e6393250b..96d32903a3b5 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -515,6 +515,7 @@ static void rxe_drain_resp_pkts(struct rxe_qp *qp, bool notify)
 	while ((skb = skb_dequeue(&qp->resp_pkts))) {
 		rxe_drop_ref(qp);
 		kfree_skb(skb);
+		ib_device_put(qp->ibqp.device);
 	}
 
 	while ((wqe = queue_head(qp->sq.queue))) {
@@ -527,6 +528,17 @@ static void rxe_drain_resp_pkts(struct rxe_qp *qp, bool notify)
 	}
 }
 
+void free_pkt(struct rxe_pkt_info *pkt)
+{
+	struct sk_buff *skb = PKT_TO_SKB(pkt);
+	struct rxe_qp *qp = pkt->qp;
+	struct ib_device *dev = qp->ibqp.device;
+
+	kfree_skb(skb);
+	rxe_drop_ref(qp);
+	ib_device_put(dev);
+}
+
 int rxe_completer(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
@@ -624,11 +636,8 @@ int rxe_completer(void *arg)
 			break;
 
 		case COMPST_DONE:
-			if (pkt) {
-				rxe_drop_ref(pkt->qp);
-				kfree_skb(skb);
-				skb = NULL;
-			}
+			if (pkt)
+				free_pkt(pkt);
 			goto done;
 
 		case COMPST_EXIT:
@@ -671,12 +680,8 @@ int rxe_completer(void *arg)
 			 */
 			if (qp->comp.started_retry &&
 			    !qp->comp.timeout_retry) {
-				if (pkt) {
-					rxe_drop_ref(pkt->qp);
-					kfree_skb(skb);
-					skb = NULL;
-				}
-
+				if (pkt)
+					free_pkt(pkt);
 				goto done;
 			}
 
@@ -699,13 +704,8 @@ int rxe_completer(void *arg)
 					qp->comp.started_retry = 1;
 					rxe_run_task(&qp->req.task, 0);
 				}
-
-				if (pkt) {
-					rxe_drop_ref(pkt->qp);
-					kfree_skb(skb);
-					skb = NULL;
-				}
-
+				if (pkt)
+					free_pkt(pkt);
 				goto done;
 
 			} else {
@@ -726,9 +726,7 @@ int rxe_completer(void *arg)
 				mod_timer(&qp->rnr_nak_timer,
 					  jiffies + rnrnak_jiffies(aeth_syn(pkt)
 						& ~AETH_TYPE_MASK));
-				rxe_drop_ref(pkt->qp);
-				kfree_skb(skb);
-				skb = NULL;
+				free_pkt(pkt);
 				goto exit;
 			} else {
 				rxe_counter_inc(rxe,
@@ -742,13 +740,8 @@ int rxe_completer(void *arg)
 			WARN_ON_ONCE(wqe->status == IB_WC_SUCCESS);
 			do_complete(qp, wqe);
 			rxe_qp_error(qp);
-
-			if (pkt) {
-				rxe_drop_ref(pkt->qp);
-				kfree_skb(skb);
-				skb = NULL;
-			}
-
+			if (pkt)
+				free_pkt(pkt);
 			goto exit;
 		}
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index c4b06ced30a7..1dba23e57d92 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -152,10 +152,14 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
 	struct udphdr *udph;
+	struct rxe_dev *rxe;
 	struct net_device *ndev = skb->dev;
-	struct rxe_dev *rxe = rxe_get_dev_from_net(ndev);
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 
+	/* takes a reference on rxe->ib_dev
+	 * drop when skb is freed
+	 */
+	rxe = rxe_get_dev_from_net(ndev);
 	if (!rxe)
 		goto drop;
 
@@ -174,12 +178,6 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	rxe_rcv(skb);
 
-	/*
-	 * FIXME: this is in the wrong place, it needs to be done when pkt is
-	 * destroyed
-	 */
-	ib_device_put(&rxe->ib_dev);
-
 	return 0;
 drop:
 	kfree_skb(skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index c9984a28eecc..8e60d9eaf79a 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -266,10 +266,19 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		/* for all but the last qp create a new clone of the
 		 * skb and pass to the qp.
 		 */
-		if (mce->qp_list.next != &mcg->qp_list)
+		if (mce->qp_list.next != &mcg->qp_list) {
 			per_qp_skb = skb_clone(skb, GFP_ATOMIC);
-		else
+			if (!ib_device_try_get(&rxe->ib_dev)) {
+				/* shouldn't happen we already have
+				 * one ref for skb.
+				 */
+				pr_warn("ib_device_try_get failed\n");
+				kfree_skb(per_qp_skb);
+				continue;
+			}
+		} else {
 			per_qp_skb = skb;
+		}
 
 		if (unlikely(!per_qp_skb))
 			continue;
@@ -288,6 +297,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 err1:
 	kfree_skb(skb);
+	ib_device_put(&rxe->ib_dev);
 }
 
 /**
@@ -397,4 +407,5 @@ void rxe_rcv(struct sk_buff *skb)
 		rxe_drop_ref(pkt->qp);
 
 	kfree_skb(skb);
+	ib_device_put(&rxe->ib_dev);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 5a098083a9d2..5fd26786d79b 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -99,6 +99,7 @@ static inline enum resp_states get_req(struct rxe_qp *qp,
 		while ((skb = skb_dequeue(&qp->req_pkts))) {
 			rxe_drop_ref(qp);
 			kfree_skb(skb);
+			ib_device_put(qp->ibqp.device);
 		}
 
 		/* go drain recv wr queue */
@@ -1012,6 +1013,7 @@ static enum resp_states cleanup(struct rxe_qp *qp,
 		skb = skb_dequeue(&qp->req_pkts);
 		rxe_drop_ref(qp);
 		kfree_skb(skb);
+		ib_device_put(qp->ibqp.device);
 	}
 
 	if (qp->resp.mr) {
@@ -1176,6 +1178,7 @@ static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
 	while ((skb = skb_dequeue(&qp->req_pkts))) {
 		rxe_drop_ref(qp);
 		kfree_skb(skb);
+		ib_device_put(qp->ibqp.device);
 	}
 
 	if (notify)
-- 
2.27.0

