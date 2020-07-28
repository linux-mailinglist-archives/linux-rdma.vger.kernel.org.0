Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1D12311D5
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgG1Six (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 14:38:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:45709 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729475AbgG1Six (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Jul 2020 14:38:53 -0400
IronPort-SDR: vyArQlnq1NjPO4zrviu5okL/jF/fZq2AXMnEST38eZ9L5aes9Xwd/jmQ86Fv3KD5X3CKuORJ7b
 3u7pPx7/iXNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="139312238"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="139312238"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 11:38:52 -0700
IronPort-SDR: 7E07RAPnS8/p/M3fSlMbRvdBVhxYYMcCcyMKd5B1m1oN/hR8x3fqY91GZHj5BDm7J1a6uvk8SS
 Y+3WEZCsyb4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="489997141"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jul 2020 11:38:51 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 06SIcobE005788;
        Tue, 28 Jul 2020 11:38:50 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 06SIcmJM022248;
        Tue, 28 Jul 2020 14:38:48 -0400
Subject: [PATCH for-rc] IB/rdmavt: Fix RQ counting issues causing use of an
 invalid RWQE
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 28 Jul 2020 14:38:48 -0400
Message-ID: <20200728183848.22226.29132.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The lookaside count is improperly initialized to the size of the
Receive Queue with the additional +1.  In the traces below, the
RQ size is 384, so the count was set to 385.

The lookaside count is then rarely refreshed.  Note the high and
incorrect count in the trace below:

rvt_get_rwqe: [hfi1_0] wqe ffffc900078e9008 wr_id 55c7206d75a0 qpn c
	qpt 2 pid 3018 num_sge 1 head 1 tail 0, count 385
rvt_get_rwqe: (hfi1_rc_rcv+0x4eb/0x1480 [hfi1] <- rvt_get_rwqe) ret=0x1

The head,tail indicate there is only one RWQE posted although the count
says 385 and we correctly return the element 0.

The next call to rvt_get_rwqe with the decremented count:

rvt_get_rwqe: [hfi1_0] wqe ffffc900078e9058 wr_id 0 qpn c
	qpt 2 pid 3018 num_sge 0 head 1 tail 1, count 384
rvt_get_rwqe: (hfi1_rc_rcv+0x4eb/0x1480 [hfi1] <- rvt_get_rwqe) ret=0x1

Note that the RQ is empty (head == tail) yet we return the RWQE at tail 1,
which is not valid because of the bogus high count.

Best case, the RWQE has never been posted and the rc logic sees an RWQE
that is too small (all zeros) and puts the QP into an error state.

In the worst case, a server slow at posting receive buffers might fool
rvt_get_rwqe() into fetching an old RWQE and corrupt memory.

Fix by deleting the faulty initialization code and creating an
inline to fetch the posted count and convert all callers to use
new inline.

Fixes: f592ae3c999f ("IB/rdmavt: Fracture single lock used for posting and processing RWQEs")
Reported-by: Zhaojuan Guo <zguo@redhat.com>
Cc: <stable@vger.kernel.org> # 5.4.x
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
---
 drivers/infiniband/sw/rdmavt/qp.c |   33 ++++-----------------------------
 drivers/infiniband/sw/rdmavt/rc.c |    4 +---
 include/rdma/rdmavt_qp.h          |   19 +++++++++++++++++++
 3 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 7db35dd..332a8ba 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -901,8 +901,6 @@ static void rvt_init_qp(struct rvt_dev_info *rdi, struct rvt_qp *qp,
 	qp->s_tail_ack_queue = 0;
 	qp->s_acked_ack_queue = 0;
 	qp->s_num_rd_atomic = 0;
-	if (qp->r_rq.kwq)
-		qp->r_rq.kwq->count = qp->r_rq.size;
 	qp->r_sge.num_sge = 0;
 	atomic_set(&qp->s_reserved_used, 0);
 }
@@ -2367,31 +2365,6 @@ static int init_sge(struct rvt_qp *qp, struct rvt_rwqe *wqe)
 }
 
 /**
- * get_count - count numbers of request work queue entries
- * in circular buffer
- * @rq: data structure for request queue entry
- * @tail: tail indices of the circular buffer
- * @head: head indices of the circular buffer
- *
- * Return - total number of entries in the circular buffer
- */
-static u32 get_count(struct rvt_rq *rq, u32 tail, u32 head)
-{
-	u32 count;
-
-	count = head;
-
-	if (count >= rq->size)
-		count = 0;
-	if (count < tail)
-		count += rq->size - tail;
-	else
-		count -= tail;
-
-	return count;
-}
-
-/**
  * get_rvt_head - get head indices of the circular buffer
  * @rq: data structure for request queue entry
  * @ip: the QP
@@ -2465,7 +2438,7 @@ int rvt_get_rwqe(struct rvt_qp *qp, bool wr_id_only)
 
 	if (kwq->count < RVT_RWQ_COUNT_THRESHOLD) {
 		head = get_rvt_head(rq, ip);
-		kwq->count = get_count(rq, tail, head);
+		kwq->count = rvt_get_rq_count(rq, head, tail);
 	}
 	if (unlikely(kwq->count == 0)) {
 		ret = 0;
@@ -2500,7 +2473,9 @@ int rvt_get_rwqe(struct rvt_qp *qp, bool wr_id_only)
 		 * the number of remaining WQEs.
 		 */
 		if (kwq->count < srq->limit) {
-			kwq->count = get_count(rq, tail, get_rvt_head(rq, ip));
+			kwq->count =
+				rvt_get_rq_count(rq,
+						 get_rvt_head(rq, ip), tail);
 			if (kwq->count < srq->limit) {
 				struct ib_event ev;
 
diff --git a/drivers/infiniband/sw/rdmavt/rc.c b/drivers/infiniband/sw/rdmavt/rc.c
index 977906c..c58735f 100644
--- a/drivers/infiniband/sw/rdmavt/rc.c
+++ b/drivers/infiniband/sw/rdmavt/rc.c
@@ -127,9 +127,7 @@ __be32 rvt_compute_aeth(struct rvt_qp *qp)
 			 * not atomic, which is OK, since the fuzziness is
 			 * resolved as further ACKs go out.
 			 */
-			credits = head - tail;
-			if ((int)credits < 0)
-				credits += qp->r_rq.size;
+			credits = rvt_get_rq_count(&qp->r_rq, head, tail);
 		}
 		/*
 		 * Binary search the credit table to find the code to
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index c4369a6..2f1fc23 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -305,6 +305,25 @@ struct rvt_rq {
 	spinlock_t lock ____cacheline_aligned_in_smp;
 };
 
+/**
+ * rvt_get_rq_count - count numbers of request work queue entries
+ * in circular buffer
+ * @rq: data structure for request queue entry
+ * @head: head indices of the circular buffer
+ * @tail: tail indices of the circular buffer
+ *
+ * Return - total number of entries in the Receive Queue
+ */
+
+static inline u32 rvt_get_rq_count(struct rvt_rq *rq, u32 head, u32 tail)
+{
+	u32 count = head - tail;
+
+	if ((s32)count < 0)
+		count += rq->size;
+	return count;
+}
+
 /*
  * This structure holds the information that the send tasklet needs
  * to send a RDMA read response or atomic operation.

