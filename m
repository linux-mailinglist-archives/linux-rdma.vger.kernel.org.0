Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA7A70352
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfGVPOg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:14:36 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:58236 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfGVPOg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:14:36 -0400
Received: from [195.176.96.199] (helo=jupiter)
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
        id 1hpa1K-00089V-PC; Mon, 22 Jul 2019 17:14:34 +0200
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [PATCH 02/10] Remove counter that does not have a meaning anymore
Date:   Mon, 22 Jul 2019 17:14:18 +0200
Message-Id: <20190722151426.5266-3-mplaneta@os.inf.tu-dresden.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After putting all tasks to schedule, this counter does not have a
meaning anymore.

Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
---
 drivers/infiniband/sw/rxe/rxe_comp.c        | 6 ------
 drivers/infiniband/sw/rxe/rxe_hw_counters.c | 1 -
 drivers/infiniband/sw/rxe/rxe_hw_counters.h | 1 -
 3 files changed, 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index ad09bd9d0a82..5f3a43cfeb63 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -148,14 +148,8 @@ void retransmit_timer(struct timer_list *t)
 
 void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 {
-	int must_sched;
-
 	skb_queue_tail(&qp->resp_pkts, skb);
 
-	must_sched = skb_queue_len(&qp->resp_pkts) > 1;
-	if (must_sched != 0)
-		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
-
 	rxe_run_task(&qp->comp.task);
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
index 636edb5f4cf4..9bc762b0e66a 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
@@ -41,7 +41,6 @@ static const char * const rxe_counter_name[] = {
 	[RXE_CNT_RCV_RNR]             =  "rcvd_rnr_err",
 	[RXE_CNT_SND_RNR]             =  "send_rnr_err",
 	[RXE_CNT_RCV_SEQ_ERR]         =  "rcvd_seq_err",
-	[RXE_CNT_COMPLETER_SCHED]     =  "ack_deferred",
 	[RXE_CNT_RETRY_EXCEEDED]      =  "retry_exceeded_err",
 	[RXE_CNT_RNR_RETRY_EXCEEDED]  =  "retry_rnr_exceeded_err",
 	[RXE_CNT_COMP_RETRY]          =  "completer_retry_err",
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.h b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
index 72c0d63c79e0..cfe19159a77f 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.h
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
@@ -45,7 +45,6 @@ enum rxe_counters {
 	RXE_CNT_RCV_RNR,
 	RXE_CNT_SND_RNR,
 	RXE_CNT_RCV_SEQ_ERR,
-	RXE_CNT_COMPLETER_SCHED,
 	RXE_CNT_RETRY_EXCEEDED,
 	RXE_CNT_RNR_RETRY_EXCEEDED,
 	RXE_CNT_COMP_RETRY,
-- 
2.20.1

