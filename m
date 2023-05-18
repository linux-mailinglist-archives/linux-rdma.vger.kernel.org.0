Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B81E707BE3
	for <lists+linux-rdma@lfdr.de>; Thu, 18 May 2023 10:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjERIWu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 04:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjERIWq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 04:22:46 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABC1E49;
        Thu, 18 May 2023 01:22:37 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="117097140"
X-IronPort-AV: E=Sophos;i="5.99,284,1677510000"; 
   d="scan'208";a="117097140"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:22:24 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2A81EC3F94;
        Thu, 18 May 2023 17:22:22 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 665D0C4A14;
        Thu, 18 May 2023 17:22:21 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.106])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 338E4200B2AE;
        Thu, 18 May 2023 17:22:21 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v5 1/7] RDMA/rxe: Always defer tasks on responder and completer to workqueue
Date:   Thu, 18 May 2023 17:21:46 +0900
Message-Id: <3edbcfacf7ff4fbe8b527a372ef73d1a6db17144.1684397037.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
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
index db18ace74d2b..671fdb645030 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -128,18 +128,8 @@ void retransmit_timer(struct timer_list *t)
 
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
index 68f6cd188d8e..ba0222bfce9e 100644
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

