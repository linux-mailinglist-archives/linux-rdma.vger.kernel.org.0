Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFCD7E6356
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Nov 2023 06:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjKIFpm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Nov 2023 00:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjKIFpl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Nov 2023 00:45:41 -0500
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF5926B2;
        Wed,  8 Nov 2023 21:45:38 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="127393828"
X-IronPort-AV: E=Sophos;i="6.03,288,1694703600"; 
   d="scan'208";a="127393828"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:45:35 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 96445D6189;
        Thu,  9 Nov 2023 14:45:33 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id DC626CFAB3;
        Thu,  9 Nov 2023 14:45:32 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id A958F2005323;
        Thu,  9 Nov 2023 14:45:32 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v7 1/7] RDMA/rxe: Always defer tasks on responder and completer to workqueue
Date:   Thu,  9 Nov 2023 14:44:46 +0900
Message-Id: <cd40681b996af4e1c065820aee28ffce5f814bcf.1699503619.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
References: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Both responder and completer need to sleep to execute page-fault when used
with ODP. It can happen when they are going to access user MRs, so tasks
must be executed in process context for such cases.

Additionally, current implementation seldom defers tasks to workqueue, but
instead defers to a softirq context running do_task(). It is called from
rxe_resp_queue_pkt() and rxe_comp_queue_pkt() in SOFTIRQ_NET_RX context and
can last until maximum RXE_MAX_ITERATIONS (=1024) loops are executed. The
problem is the that task execuion appears to be anonymous loads in the
system and that the loop can throttle other softirqs on the same CPU.

This patch makes responder and completer codes run in process context for
ODP and the problem described above.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c        | 12 +-----------
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |  1 -
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |  1 -
 drivers/infiniband/sw/rxe/rxe_resp.c        | 13 +------------
 4 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index d0bdc2d8adc8..bb016a43330d 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -129,18 +129,8 @@ void retransmit_timer(struct timer_list *t)
 
 void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 {
-	int must_sched;
-
 	skb_queue_tail(&qp->resp_pkts, skb);
-
-	must_sched = skb_queue_len(&qp->resp_pkts) > 1;
-	if (must_sched != 0)
-		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
-
-	if (must_sched)
-		rxe_sched_task(&qp->comp.task);
-	else
-		rxe_run_task(&qp->comp.task);
+	rxe_sched_task(&qp->comp.task);
 }
 
 static inline enum comp_state get_wqe(struct rxe_qp *qp,
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
index a012522b577a..dc23cf3a6967 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
@@ -14,7 +14,6 @@ static const struct rdma_stat_desc rxe_counter_descs[] = {
 	[RXE_CNT_RCV_RNR].name             =  "rcvd_rnr_err",
 	[RXE_CNT_SND_RNR].name             =  "send_rnr_err",
 	[RXE_CNT_RCV_SEQ_ERR].name         =  "rcvd_seq_err",
-	[RXE_CNT_COMPLETER_SCHED].name     =  "ack_deferred",
 	[RXE_CNT_RETRY_EXCEEDED].name      =  "retry_exceeded_err",
 	[RXE_CNT_RNR_RETRY_EXCEEDED].name  =  "retry_rnr_exceeded_err",
 	[RXE_CNT_COMP_RETRY].name          =  "completer_retry_err",
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.h b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
index 71f4d4fa9dc8..303da0e3134a 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.h
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
@@ -18,7 +18,6 @@ enum rxe_counters {
 	RXE_CNT_RCV_RNR,
 	RXE_CNT_SND_RNR,
 	RXE_CNT_RCV_SEQ_ERR,
-	RXE_CNT_COMPLETER_SCHED,
 	RXE_CNT_RETRY_EXCEEDED,
 	RXE_CNT_RNR_RETRY_EXCEEDED,
 	RXE_CNT_COMP_RETRY,
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index da470a925efc..969e057bbfd1 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -46,21 +46,10 @@ static char *resp_state_name[] = {
 	[RESPST_EXIT]				= "EXIT",
 };
 
-/* rxe_recv calls here to add a request packet to the input queue */
 void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 {
-	int must_sched;
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
-
 	skb_queue_tail(&qp->req_pkts, skb);
-
-	must_sched = (pkt->opcode == IB_OPCODE_RC_RDMA_READ_REQUEST) ||
-			(skb_queue_len(&qp->req_pkts) > 1);
-
-	if (must_sched)
-		rxe_sched_task(&qp->resp.task);
-	else
-		rxe_run_task(&qp->resp.task);
+	rxe_sched_task(&qp->resp.task);
 }
 
 static inline enum resp_states get_req(struct rxe_qp *qp,
-- 
2.39.1

