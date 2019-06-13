Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA26343AC3
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfFMPXP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:23:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:54743 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731899AbfFMMar (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 08:30:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 05:30:46 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga005.jf.intel.com with ESMTP; 13 Jun 2019 05:30:46 -0700
Received: from awdrv-06.aw.intel.com (awdrv-06.aw.intel.com [10.228.212.220])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5DCUjA0009844;
        Thu, 13 Jun 2019 05:30:45 -0700
Received: from awdrv-06.aw.intel.com (localhost [127.0.0.1])
        by awdrv-06.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5DCUix1005349;
        Thu, 13 Jun 2019 08:30:44 -0400
Subject: [RESEND PATCH v2 1/2] IB/rdmavt: Add new completion inline
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 13 Jun 2019 08:30:44 -0400
Message-ID: <20190613123040.5297.83018.stgit@awdrv-06.aw.intel.com>
In-Reply-To: <20190613123013.5297.32797.stgit@awdrv-06.aw.intel.com>
References: <20190613123013.5297.32797.stgit@awdrv-06.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is opencoded send completion logic all over all
the drivers.

We need to convert to this routine to enforce ordering
issues for completions.  This routine fixes an ordering
issue where the read of the SWQE fields necessary for creating
the completion can race with a post send if the post send catches
a send queue at the edge of being full.  Is is possible in that situation
to read SWQE fields that are being written.

This new routine insures that SWQE fields are read prior to advancing
the index that post send uses to determine queue fullness.

Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
v2 - use smp_store_release on write of s_last
---
 include/rdma/rdmavt_qp.h |   72 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index 68e38c2..6014f17 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -737,6 +737,78 @@ static inline void rvt_put_qp_swqe(struct rvt_qp *qp, struct rvt_swqe *wqe)
 		atomic_dec(&ibah_to_rvtah(wqe->ud_wr.ah)->refcount);
 }
 
+/**
+ * rvt_qp_sqwe_incr - increment ring index
+ * @qp: the qp
+ * @val: the starting value
+ *
+ * Return: the new value wrapping as appropriate
+ */
+static inline u32
+rvt_qp_swqe_incr(struct rvt_qp *qp, u32 val)
+{
+	if (++val >= qp->s_size)
+		val = 0;
+	return val;
+}
+
+/**
+ * rvt_qp_complete_swqe - insert send completion
+ * @qp - the qp
+ * @wqe - the send wqe
+ * @opcode - wc operation (driver dependent)
+ * @status - completion status
+ *
+ * Update the s_last information, and then insert a send
+ * completion into the completion
+ * queue if the qp indicates it should be done.
+ *
+ * See IBTA 10.7.3.1 for info on completion
+ * control.
+ *
+ * Return: new last
+ */
+static inline u32
+rvt_qp_complete_swqe(struct rvt_qp *qp,
+		     struct rvt_swqe *wqe,
+		     enum ib_wc_opcode opcode,
+		     enum ib_wc_status status)
+{
+	bool need_completion;
+	u64 wr_id;
+	u32 byte_len, last;
+	int flags = wqe->wr.send_flags;
+
+	rvt_put_qp_swqe(qp, wqe);
+
+	need_completion =
+		!(flags & RVT_SEND_RESERVE_USED) &&
+		(!(qp->s_flags & RVT_S_SIGNAL_REQ_WR) ||
+		(flags & IB_SEND_SIGNALED) ||
+		status != IB_WC_SUCCESS);
+	if (need_completion) {
+		wr_id = wqe->wr.wr_id;
+		byte_len = wqe->length;
+		/* above fields required before writing s_last */
+	}
+	last = rvt_qp_swqe_incr(qp, qp->s_last);
+	/* see rvt_qp_is_avail() */
+	smp_store_release(&qp->s_last, last);
+	if (need_completion) {
+		struct ib_wc w = {
+			.wr_id = wr_id,
+			.status = status,
+			.opcode = opcode,
+			.qp = &qp->ibqp,
+			.byte_len = byte_len,
+		};
+
+		rvt_cq_enter(ibcq_to_rvtcq(qp->ibqp.send_cq), &w,
+			     status != IB_WC_SUCCESS);
+	}
+	return last;
+}
+
 extern const int  ib_rvt_state_ops[];
 
 struct rvt_dev_info;

