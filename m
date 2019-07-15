Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C866994F
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 18:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbfGOQpb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jul 2019 12:45:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:41371 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729941AbfGOQpb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jul 2019 12:45:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 09:45:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="194571978"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jul 2019 09:45:30 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x6FGjTEe033146;
        Mon, 15 Jul 2019 09:45:30 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x6FGjStG074266;
        Mon, 15 Jul 2019 12:45:28 -0400
Subject: [PATCH 2/6] IB/hfi1: Unreserve a flushed OPFN request
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 15 Jul 2019 12:45:28 -0400
Message-ID: <20190715164528.74174.31364.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
References: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

When an OPFN request is flushed, the request is completed without
unreserving itself from the send queue. Subsequently, when a new
request is post sent, the following warning will be triggered:

WARNING: CPU: 4 PID: 8130 at rdmavt/qp.c:1761 rvt_post_send+0x72a/0x880 [rdmavt]
Call Trace:
[<ffffffffbbb61e41>] dump_stack+0x19/0x1b
[<ffffffffbb497688>] __warn+0xd8/0x100
[<ffffffffbb4977cd>] warn_slowpath_null+0x1d/0x20
[<ffffffffc01c941a>] rvt_post_send+0x72a/0x880 [rdmavt]
[<ffffffffbb4dcabe>] ? account_entity_dequeue+0xae/0xd0
[<ffffffffbb61d645>] ? __kmalloc+0x55/0x230
[<ffffffffc04e1a4c>] ib_uverbs_post_send+0x37c/0x5d0 [ib_uverbs]
[<ffffffffc04e5e36>] ? rdma_lookup_put_uobject+0x26/0x60 [ib_uverbs]
[<ffffffffc04dbce6>] ib_uverbs_write+0x286/0x460 [ib_uverbs]
[<ffffffffbb6f9457>] ? security_file_permission+0x27/0xa0
[<ffffffffbb641650>] vfs_write+0xc0/0x1f0
[<ffffffffbb64246f>] SyS_write+0x7f/0xf0
[<ffffffffbbb74ddb>] system_call_fastpath+0x22/0x27

This patch fixes the problem by moving rvt_qp_wqe_unreserve() into
rvt_qp_complete_swqe() to simplify the code and make it less
error-prone.

Fixes: ca95f802ef51 ("IB/hfi1: Unreserve a reserved request when it is completed")
Cc: <stable@vger.kernel.org>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
---
 drivers/infiniband/hw/hfi1/rc.c |    2 --
 include/rdma/rdmavt_qp.h        |    9 ++++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index 0477c14..024a7c2 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -1835,7 +1835,6 @@ void hfi1_rc_send_complete(struct rvt_qp *qp, struct hfi1_opa_header *opah)
 		    cmp_psn(qp->s_sending_psn, qp->s_sending_hpsn) <= 0)
 			break;
 		trdma_clean_swqe(qp, wqe);
-		rvt_qp_wqe_unreserve(qp, wqe);
 		trace_hfi1_qp_send_completion(qp, wqe, qp->s_last);
 		rvt_qp_complete_swqe(qp,
 				     wqe,
@@ -1882,7 +1881,6 @@ struct rvt_swqe *do_rc_completion(struct rvt_qp *qp,
 	if (cmp_psn(wqe->lpsn, qp->s_sending_psn) < 0 ||
 	    cmp_psn(qp->s_sending_psn, qp->s_sending_hpsn) > 0) {
 		trdma_clean_swqe(qp, wqe);
-		rvt_qp_wqe_unreserve(qp, wqe);
 		trace_hfi1_qp_send_completion(qp, wqe, qp->s_last);
 		rvt_qp_complete_swqe(qp,
 				     wqe,
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index 0eeea52..e06c77d 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -608,7 +608,7 @@ static inline void rvt_qp_wqe_reserve(
 /**
  * rvt_qp_wqe_unreserve - clean reserved operation
  * @qp - the rvt qp
- * @wqe - the send wqe
+ * @flags - send wqe flags
  *
  * This decrements the reserve use count.
  *
@@ -620,11 +620,9 @@ static inline void rvt_qp_wqe_reserve(
  * the compiler does not juggle the order of the s_last
  * ring index and the decrementing of s_reserved_used.
  */
-static inline void rvt_qp_wqe_unreserve(
-	struct rvt_qp *qp,
-	struct rvt_swqe *wqe)
+static inline void rvt_qp_wqe_unreserve(struct rvt_qp *qp, int flags)
 {
-	if (unlikely(wqe->wr.send_flags & RVT_SEND_RESERVE_USED)) {
+	if (unlikely(flags & RVT_SEND_RESERVE_USED)) {
 		atomic_dec(&qp->s_reserved_used);
 		/* insure no compiler re-order up to s_last change */
 		smp_mb__after_atomic();
@@ -853,6 +851,7 @@ static inline void rvt_send_cq(struct rvt_qp *qp, struct ib_wc *wc,
 	u32 byte_len, last;
 	int flags = wqe->wr.send_flags;
 
+	rvt_qp_wqe_unreserve(qp, flags);
 	rvt_put_qp_swqe(qp, wqe);
 
 	need_completion =

