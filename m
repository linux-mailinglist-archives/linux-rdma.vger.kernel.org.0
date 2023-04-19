Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12CA6E72B5
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Apr 2023 07:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjDSFxE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Apr 2023 01:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSFxC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Apr 2023 01:53:02 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7DE524E;
        Tue, 18 Apr 2023 22:52:59 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="102053460"
X-IronPort-AV: E=Sophos;i="5.99,208,1677510000"; 
   d="scan'208";a="102053460"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 14:52:56 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 22A1AC68B3;
        Wed, 19 Apr 2023 14:52:53 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5F128D67A5;
        Wed, 19 Apr 2023 14:52:52 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.106])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 3039B2005334;
        Wed, 19 Apr 2023 14:52:52 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v4 2/8] RDMA/rxe: Always schedule works before accessing user MRs
Date:   Wed, 19 Apr 2023 14:51:54 +0900
Message-Id: <7441c59fcea601c03c70ec03b5d17a69032e51f8.1681882651.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1681882651.git.matsuda-daisuke@fujitsu.com>
References: <cover.1681882651.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Both responder and completer can sleep to execute page-fault when used
with ODP. It happens when they are going to access user MRs, so works must
be scheduled in such cases.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 12 ++++++++++--
 drivers/infiniband/sw/rxe/rxe_loc.h  |  4 ++--
 drivers/infiniband/sw/rxe/rxe_recv.c |  4 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c | 14 +++++++++-----
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index db18ace74d2b..b71bd9cc00d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -126,13 +126,21 @@ void retransmit_timer(struct timer_list *t)
 	spin_unlock_bh(&qp->state_lock);
 }
 
-void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
+void rxe_comp_queue_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
+	struct rxe_qp *qp = pkt->qp;
 	int must_sched;
 
 	skb_queue_tail(&qp->resp_pkts, skb);
 
-	must_sched = skb_queue_len(&qp->resp_pkts) > 1;
+	/* Schedule the task if processing Read responses or Atomic acks.
+	 * In these cases, completer may sleep to access ODP-enabled MRs.
+	 */
+	if (pkt->mask | (RXE_PAYLOAD_MASK || RXE_ATMACK_MASK))
+		must_sched = 1;
+	else
+		must_sched = skb_queue_len(&qp->resp_pkts) > 1;
+
 	if (must_sched != 0)
 		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 804b15e929dd..bf28ac13c3f5 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -179,9 +179,9 @@ int rxe_icrc_init(struct rxe_dev *rxe);
 int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt);
 void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt);
 
-void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb);
+void rxe_resp_queue_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 
-void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb);
+void rxe_comp_queue_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 
 static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 2f953cc74256..0d869615508a 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -181,9 +181,9 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 static inline void rxe_rcv_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
 	if (pkt->mask & RXE_REQ_MASK)
-		rxe_resp_queue_pkt(pkt->qp, skb);
+		rxe_resp_queue_pkt(pkt, skb);
 	else
-		rxe_comp_queue_pkt(pkt->qp, skb);
+		rxe_comp_queue_pkt(pkt, skb);
 }
 
 static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 68f6cd188d8e..f915128ed32a 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -47,15 +47,19 @@ static char *resp_state_name[] = {
 };
 
 /* rxe_recv calls here to add a request packet to the input queue */
-void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
+void rxe_resp_queue_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
-	int must_sched;
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	int must_sched = 1;
+	struct rxe_qp *qp = pkt->qp;
 
 	skb_queue_tail(&qp->req_pkts, skb);
 
-	must_sched = (pkt->opcode == IB_OPCODE_RC_RDMA_READ_REQUEST) ||
-			(skb_queue_len(&qp->req_pkts) > 1);
+	/* responder can sleep to access an ODP-enabled MR. Always schedule
+	 * tasks for non-zero-byte operations, RDMA Read, and Atomic.
+	 */
+	if ((skb_queue_len(&qp->req_pkts) == 1) && (payload_size(pkt) == 0)
+	    && !(pkt->mask & RXE_READ_OR_ATOMIC_MASK))
+		must_sched = 0;
 
 	if (must_sched)
 		rxe_sched_task(&qp->resp.task);
-- 
2.39.1

