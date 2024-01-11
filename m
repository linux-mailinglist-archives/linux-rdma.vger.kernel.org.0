Return-Path: <linux-rdma+bounces-598-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96A782A6F3
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jan 2024 05:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239B71F23DD1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jan 2024 04:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C186815CF;
	Thu, 11 Jan 2024 04:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MuJ6FgTv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9341110;
	Thu, 11 Jan 2024 04:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qpEyBF6X8nl3c3+dQHZ2gTaNSIrp5TqJJ+YBonBOJ68=; b=MuJ6FgTviPtPEEj0OmR1VMmw9v
	I5NBf4N0UevX/l4yh0uM+2Rlt1IXSUuAnV1YlI+uiX7joDKmN5KKp9vq3eSmzsB5V7XoOSiUAEozA
	+lLuCBtFtwWddJdz7f5Mr6Z5ayAxOX30XsEQqTfMgJ6GbTOaOdVJ2pu7KYBTc8VapG9XjOlrqT01Q
	w58yY6XV+Dr5peQkM/XmxRXnqP1Qje4EqgITSjO8yh5OTrIea68C+jW7h3z5R+U4SXl74ElGbP44n
	8UcVuLkocdvVQd/x0uYK8WnOyDbunRPIwU7vtC/sAAjptTmzPTc7C+DlKLSWOkkvhxFLp7PHN1x0z
	3/IzEbzg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNmfb-00FnPb-0q;
	Thu, 11 Jan 2024 04:27:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] IB/hfi1: fix spellos and kernel-doc
Date: Wed, 10 Jan 2024 20:27:54 -0800
Message-ID: <20240111042754.17530-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistakes as reported by codespell.
Fix kernel-doc warnings.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/hw/hfi1/tid_rdma.c |   25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff -- a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -315,7 +315,7 @@ int hfi1_kern_exp_rcv_init(struct hfi1_c
  * This routine returns the receive context associated
  * with a a qp's qpn.
  *
- * Returns the context.
+ * Return: the context.
  */
 static struct hfi1_ctxtdata *qp_to_rcd(struct rvt_dev_info *rdi,
 				       struct rvt_qp *qp)
@@ -710,7 +710,7 @@ void hfi1_tid_rdma_flush_wait(struct rvt
  * The exp_lock must be held.
  *
  * Return:
- * On success: a value postive value between 0 and RXE_NUM_TID_FLOWS - 1
+ * On success: a value positive value between 0 and RXE_NUM_TID_FLOWS - 1
  * On failure: -EAGAIN
  */
 static int kern_reserve_flow(struct hfi1_ctxtdata *rcd, int last)
@@ -1007,7 +1007,7 @@ static u32 tid_flush_pages(struct tid_rd
  * pages are tested two at a time, i, i + 1 for contiguous
  * pages and i - 1 and i contiguous pages.
  *
- * If any condition is false, any accumlated pages are flushed and
+ * If any condition is false, any accumulated pages are flushed and
  * v0,v1 are emitted as separate PAGE_SIZE pagesets
  *
  * Otherwise, the current 8k is totaled for a future flush.
@@ -1434,7 +1434,7 @@ static void kern_program_rcvarray(struct
  * (5) computes a tidarray with formatted TID entries which can be sent
  *     to the sender
  * (6) Reserves and programs HW flows.
- * (7) It also manages queing the QP when TID/flow resources are not
+ * (7) It also manages queueing the QP when TID/flow resources are not
  *     available.
  *
  * @req points to struct tid_rdma_request of which the segments are a part. The
@@ -1604,7 +1604,7 @@ void hfi1_kern_exp_rcv_clear_all(struct
 }
 
 /**
- * hfi1_kern_exp_rcv_free_flows - free priviously allocated flow information
+ * hfi1_kern_exp_rcv_free_flows - free previously allocated flow information
  * @req: the tid rdma request to be cleaned
  */
 static void hfi1_kern_exp_rcv_free_flows(struct tid_rdma_request *req)
@@ -2055,7 +2055,7 @@ static int tid_rdma_rcv_error(struct hfi
 		 * req->clear_tail is advanced). However, when an earlier
 		 * request is received, this request will not be complete any
 		 * more (qp->s_tail_ack_queue is moved back, see below).
-		 * Consequently, we need to update the TID flow info everytime
+		 * Consequently, we need to update the TID flow info every time
 		 * a duplicate request is received.
 		 */
 		bth0 = be32_to_cpu(ohdr->bth[0]);
@@ -2219,7 +2219,7 @@ void hfi1_rc_rcv_tid_rdma_read_req(struc
 	/*
 	 * 1. Verify TID RDMA READ REQ as per IB_OPCODE_RC_RDMA_READ
 	 *    (see hfi1_rc_rcv())
-	 * 2. Put TID RDMA READ REQ into the response queueu (s_ack_queue)
+	 * 2. Put TID RDMA READ REQ into the response queue (s_ack_queue)
 	 *     - Setup struct tid_rdma_req with request info
 	 *     - Initialize struct tid_rdma_flow info;
 	 *     - Copy TID entries;
@@ -2439,7 +2439,7 @@ find_tid_request(struct rvt_qp *qp, u32
 
 void hfi1_rc_rcv_tid_rdma_read_resp(struct hfi1_packet *packet)
 {
-	/* HANDLER FOR TID RDMA READ RESPONSE packet (Requestor side */
+	/* HANDLER FOR TID RDMA READ RESPONSE packet (Requester side) */
 
 	/*
 	 * 1. Find matching SWQE
@@ -3649,7 +3649,7 @@ void hfi1_rc_rcv_tid_rdma_write_req(stru
 	 * 1. Verify TID RDMA WRITE REQ as per IB_OPCODE_RC_RDMA_WRITE_FIRST
 	 *    (see hfi1_rc_rcv())
 	 *     - Don't allow 0-length requests.
-	 * 2. Put TID RDMA WRITE REQ into the response queueu (s_ack_queue)
+	 * 2. Put TID RDMA WRITE REQ into the response queue (s_ack_queue)
 	 *     - Setup struct tid_rdma_req with request info
 	 *     - Prepare struct tid_rdma_flow array?
 	 * 3. Set the qp->s_ack_state as state diagram in design doc.
@@ -4026,7 +4026,7 @@ unlock_r_lock:
 
 void hfi1_rc_rcv_tid_rdma_write_resp(struct hfi1_packet *packet)
 {
-	/* HANDLER FOR TID RDMA WRITE RESPONSE packet (Requestor side */
+	/* HANDLER FOR TID RDMA WRITE RESPONSE packet (Requester side) */
 
 	/*
 	 * 1. Find matching SWQE
@@ -5440,8 +5440,9 @@ static bool _hfi1_schedule_tid_send(stru
  * the two state machines can step on each other with respect to the
  * RVT_S_BUSY flag.
  * Therefore, a modified test is used.
- * @return true if the second leg is scheduled;
- *  false if the second leg is not scheduled.
+ *
+ * Return: %true if the second leg is scheduled;
+ *  %false if the second leg is not scheduled.
  */
 bool hfi1_schedule_tid_send(struct rvt_qp *qp)
 {

