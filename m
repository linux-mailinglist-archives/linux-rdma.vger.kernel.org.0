Return-Path: <linux-rdma+bounces-14157-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D2CC22F7E
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 03:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02B014EE9AB
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 02:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192CE274FFE;
	Fri, 31 Oct 2025 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpmQ9m1Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85F1ADFFB
	for <linux-rdma@vger.kernel.org>; Fri, 31 Oct 2025 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877090; cv=none; b=JPof3AY7f33Jv2HF8xfNNt9VoI4Zw/cikIev1YidHHei+X//Bh5dvoOAA4l1iXvlcYqD62VYNNCyfjAeofTrXWVOwPKwq/LoVQdAZ2GXDsx+nQvXOLU71uIZtNNcoYzamZO0p6vJ9stE+y2Vy4zkc5kRSFUEJC2wU1dpLfMcVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877090; c=relaxed/simple;
	bh=HZPkAUhlqWcFtQnMLOt17NXBUkKLngMSVEMI7ZIq08g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZ4MCqJV7KrXy3wO7o+B3+XH+Oz60auyTB0pLjoDEQKfwASnmiBkrpcyCO/LSw2KhpQHOLmSNcFf6il3rSnF0ylWMLXOtkm4EOyJ1TIQIGSgXcev9DtpUydS65T91tHVPLtnaNepXE4sUFxP2k+nvGolj6PKe4GTkPYf4YV8J8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpmQ9m1Y; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761877089; x=1793413089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZPkAUhlqWcFtQnMLOt17NXBUkKLngMSVEMI7ZIq08g=;
  b=GpmQ9m1YSNFXns5PLTd4r6c8+tiX9mOrxnZXSAIlcBAH0zBdM9DS4W/d
   mahr/2N8nCk0LEYuCQLl37f0Gx5OSJxnQ34GRBZWfQdJX5823CzkF3KZD
   grZ5bNbFo7mSYor6X9m9wLqg1lNLxWLnGTY5onkb3AbDwYHXs0HhRgXAL
   E68WqLbgS2dF3agnBYbLM4iutPMpDrK0d8FcSzfjNKGm3QR6yhf0MshiW
   GEJg6imEvlZF/f2M1h9HG3ZUXg85PryxgY9SXwi3LdNTkTJqMqcp8i08I
   m4NNIFi514zRvqSWrCr8UlWqzFRaf2fwdlzd8VAbRidbeDablikMLM7Xs
   A==;
X-CSE-ConnectionGUID: clquHU5qSqWWVJLm1p1PEg==
X-CSE-MsgGUID: 3hVmmh/5RhOkld6Pc5BkjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64182216"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64182216"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:06 -0700
X-CSE-ConnectionGUID: r4FJ6h3eRneMeS2YlmL8Uw==
X-CSE-MsgGUID: oDNCs/gvRRm6qDWnhJXMow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="216950179"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:05 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	krzysztof.czurylo@intel.com,
	Jay Bhat <jay.bhat@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH] RDMA/irdma: CQ size and shadow update changes for GEN3
Date: Thu, 30 Oct 2025 21:17:23 -0500
Message-ID: <20251031021726.1003-4-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251031021726.1003-1-tatyana.e.nikolova@intel.com>
References: <20251031021726.1003-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jay Bhat <jay.bhat@intel.com>

CQ shadow area should not be updated at the end of a page (once every
64th CQ entry), except when CQ has no more CQEs. SW must also increase
the requested CQ size by 1 and make sure the CQ is not exactly one page
in size. This is to address a quirk in the hardware.

Signed-off-by: Jay Bhat <jay.bhat@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/main.h  |  1 -
 drivers/infiniband/hw/irdma/uk.c    | 26 +++++++++++++--
 drivers/infiniband/hw/irdma/user.h  |  1 +
 drivers/infiniband/hw/irdma/utils.c | 52 ++++++++++-------------------
 drivers/infiniband/hw/irdma/verbs.c | 16 +++++++--
 5 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 886b30d..f22b1ee 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -564,7 +564,6 @@ int irdma_ah_cqp_op(struct irdma_pci_f *rf, struct irdma_sc_ah *sc_ah, u8 cmd,
 		    void (*callback_fcn)(struct irdma_cqp_request *cqp_request),
 		    void *cb_param);
 void irdma_gsi_ud_qp_ah_cb(struct irdma_cqp_request *cqp_request);
-bool irdma_cq_empty(struct irdma_cq *iwcq);
 int irdma_inetaddr_event(struct notifier_block *notifier, unsigned long event,
 			 void *ptr);
 int irdma_inet6addr_event(struct notifier_block *notifier, unsigned long event,
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index ce1ae10..54011bf 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1136,6 +1136,27 @@ void irdma_uk_cq_request_notification(struct irdma_cq_uk *cq,
 	writel(cq->cq_id, cq->cqe_alloc_db);
 }
 
+/**
+ * irdma_uk_cq_empty - Check if CQ is empty
+ * @cq: hw cq
+ */
+bool irdma_uk_cq_empty(struct irdma_cq_uk *cq)
+{
+	__le64 *cqe;
+	u8 polarity;
+	u64 qword3;
+
+	if (cq->avoid_mem_cflct)
+		cqe = IRDMA_GET_CURRENT_EXTENDED_CQ_ELEM(cq);
+	else
+		cqe = IRDMA_GET_CURRENT_CQ_ELEM(cq);
+
+	get_64bit_val(cqe, 24, &qword3);
+	polarity = (u8)FIELD_GET(IRDMA_CQ_VALID, qword3);
+
+	return polarity != cq->polarity;
+}
+
 /**
  * irdma_uk_cq_poll_cmpl - get cq completion info
  * @cq: hw cq
@@ -1420,8 +1441,9 @@ exit:
 		IRDMA_RING_MOVE_TAIL(cq->cq_ring);
 		if (!cq->avoid_mem_cflct && ext_valid)
 			IRDMA_RING_MOVE_TAIL(cq->cq_ring);
-		set_64bit_val(cq->shadow_area, 0,
-			      IRDMA_RING_CURRENT_HEAD(cq->cq_ring));
+		if (IRDMA_RING_CURRENT_HEAD(cq->cq_ring) & 0x3F || irdma_uk_cq_empty(cq))
+			set_64bit_val(cq->shadow_area, 0,
+				      IRDMA_RING_CURRENT_HEAD(cq->cq_ring));
 	} else {
 		qword3 &= ~IRDMA_CQ_WQEIDX;
 		qword3 |= FIELD_PREP(IRDMA_CQ_WQEIDX, pring->tail);
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index ab57f68..81ae738 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -429,6 +429,7 @@ struct irdma_wqe_uk_ops {
 				   struct irdma_bind_window *op_info);
 };
 
+bool irdma_uk_cq_empty(struct irdma_cq_uk *cq);
 int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 			  struct irdma_cq_poll_info *info);
 void irdma_uk_cq_request_notification(struct irdma_cq_uk *cq,
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 8b94d87..ed3186f 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2357,24 +2357,6 @@ void irdma_ib_qp_event(struct irdma_qp *iwqp, enum irdma_qp_event_type event)
 	iwqp->ibqp.event_handler(&ibevent, iwqp->ibqp.qp_context);
 }
 
-bool irdma_cq_empty(struct irdma_cq *iwcq)
-{
-	struct irdma_cq_uk *ukcq;
-	u64 qword3;
-	__le64 *cqe;
-	u8 polarity;
-
-	ukcq  = &iwcq->sc_cq.cq_uk;
-	if (ukcq->avoid_mem_cflct)
-		cqe = IRDMA_GET_CURRENT_EXTENDED_CQ_ELEM(ukcq);
-	else
-		cqe = IRDMA_GET_CURRENT_CQ_ELEM(ukcq);
-	get_64bit_val(cqe, 24, &qword3);
-	polarity = (u8)FIELD_GET(IRDMA_CQ_VALID, qword3);
-
-	return polarity != ukcq->polarity;
-}
-
 void irdma_remove_cmpls_list(struct irdma_cq *iwcq)
 {
 	struct irdma_cmpl_gen *cmpl_node;
@@ -2436,6 +2418,8 @@ void irdma_generate_flush_completions(struct irdma_qp *iwqp)
 	struct irdma_qp_uk *qp = &iwqp->sc_qp.qp_uk;
 	struct irdma_ring *sq_ring = &qp->sq_ring;
 	struct irdma_ring *rq_ring = &qp->rq_ring;
+	struct irdma_cq *iwscq = iwqp->iwscq;
+	struct irdma_cq *iwrcq = iwqp->iwrcq;
 	struct irdma_cmpl_gen *cmpl;
 	__le64 *sw_wqe;
 	u64 wqe_qword;
@@ -2443,8 +2427,8 @@ void irdma_generate_flush_completions(struct irdma_qp *iwqp)
 	bool compl_generated = false;
 	unsigned long flags1;
 
-	spin_lock_irqsave(&iwqp->iwscq->lock, flags1);
-	if (irdma_cq_empty(iwqp->iwscq)) {
+	spin_lock_irqsave(&iwscq->lock, flags1);
+	if (irdma_uk_cq_empty(&iwscq->sc_cq.cq_uk)) {
 		unsigned long flags2;
 
 		spin_lock_irqsave(&iwqp->lock, flags2);
@@ -2452,7 +2436,7 @@ void irdma_generate_flush_completions(struct irdma_qp *iwqp)
 			cmpl = kzalloc(sizeof(*cmpl), GFP_ATOMIC);
 			if (!cmpl) {
 				spin_unlock_irqrestore(&iwqp->lock, flags2);
-				spin_unlock_irqrestore(&iwqp->iwscq->lock, flags1);
+				spin_unlock_irqrestore(&iwscq->lock, flags1);
 				return;
 			}
 
@@ -2471,24 +2455,24 @@ void irdma_generate_flush_completions(struct irdma_qp *iwqp)
 				kfree(cmpl);
 				continue;
 			}
-			ibdev_dbg(iwqp->iwscq->ibcq.device,
+			ibdev_dbg(iwscq->ibcq.device,
 				  "DEV: %s: adding wr_id = 0x%llx SQ Completion to list qp_id=%d\n",
 				  __func__, cmpl->cpi.wr_id, qp->qp_id);
-			list_add_tail(&cmpl->list, &iwqp->iwscq->cmpl_generated);
+			list_add_tail(&cmpl->list, &iwscq->cmpl_generated);
 			compl_generated = true;
 		}
 		spin_unlock_irqrestore(&iwqp->lock, flags2);
-		spin_unlock_irqrestore(&iwqp->iwscq->lock, flags1);
+		spin_unlock_irqrestore(&iwscq->lock, flags1);
 		if (compl_generated)
-			irdma_comp_handler(iwqp->iwscq);
+			irdma_comp_handler(iwscq);
 	} else {
-		spin_unlock_irqrestore(&iwqp->iwscq->lock, flags1);
+		spin_unlock_irqrestore(&iwscq->lock, flags1);
 		mod_delayed_work(iwqp->iwdev->cleanup_wq, &iwqp->dwork_flush,
 				 msecs_to_jiffies(IRDMA_FLUSH_DELAY_MS));
 	}
 
-	spin_lock_irqsave(&iwqp->iwrcq->lock, flags1);
-	if (irdma_cq_empty(iwqp->iwrcq)) {
+	spin_lock_irqsave(&iwrcq->lock, flags1);
+	if (irdma_uk_cq_empty(&iwrcq->sc_cq.cq_uk)) {
 		unsigned long flags2;
 
 		spin_lock_irqsave(&iwqp->lock, flags2);
@@ -2496,7 +2480,7 @@ void irdma_generate_flush_completions(struct irdma_qp *iwqp)
 			cmpl = kzalloc(sizeof(*cmpl), GFP_ATOMIC);
 			if (!cmpl) {
 				spin_unlock_irqrestore(&iwqp->lock, flags2);
-				spin_unlock_irqrestore(&iwqp->iwrcq->lock, flags1);
+				spin_unlock_irqrestore(&iwrcq->lock, flags1);
 				return;
 			}
 
@@ -2508,20 +2492,20 @@ void irdma_generate_flush_completions(struct irdma_qp *iwqp)
 			cmpl->cpi.q_type = IRDMA_CQE_QTYPE_RQ;
 			/* remove the RQ WR by moving RQ tail */
 			IRDMA_RING_SET_TAIL(*rq_ring, rq_ring->tail + 1);
-			ibdev_dbg(iwqp->iwrcq->ibcq.device,
+			ibdev_dbg(iwrcq->ibcq.device,
 				  "DEV: %s: adding wr_id = 0x%llx RQ Completion to list qp_id=%d, wqe_idx=%d\n",
 				  __func__, cmpl->cpi.wr_id, qp->qp_id,
 				  wqe_idx);
-			list_add_tail(&cmpl->list, &iwqp->iwrcq->cmpl_generated);
+			list_add_tail(&cmpl->list, &iwrcq->cmpl_generated);
 
 			compl_generated = true;
 		}
 		spin_unlock_irqrestore(&iwqp->lock, flags2);
-		spin_unlock_irqrestore(&iwqp->iwrcq->lock, flags1);
+		spin_unlock_irqrestore(&iwrcq->lock, flags1);
 		if (compl_generated)
-			irdma_comp_handler(iwqp->iwrcq);
+			irdma_comp_handler(iwrcq);
 	} else {
-		spin_unlock_irqrestore(&iwqp->iwrcq->lock, flags1);
+		spin_unlock_irqrestore(&iwrcq->lock, flags1);
 		mod_delayed_work(iwqp->iwdev->cleanup_wq, &iwqp->dwork_flush,
 				 msecs_to_jiffies(IRDMA_FLUSH_DELAY_MS));
 	}
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 76ce613..c0a1fca 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2029,6 +2029,7 @@ static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
 	struct irdma_pci_f *rf;
 	struct irdma_cq_buf *cq_buf = NULL;
 	unsigned long flags;
+	u8 cqe_size;
 	int ret;
 
 	iwdev = to_iwdev(ibcq->device);
@@ -2045,7 +2046,7 @@ static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
 		return -EINVAL;
 
 	if (!iwcq->user_mode) {
-		entries++;
+		entries += 2;
 
 		if (!iwcq->sc_cq.cq_uk.avoid_mem_cflct &&
 		    dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
@@ -2053,6 +2054,10 @@ static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
 
 		if (entries & 1)
 			entries += 1; /* cq size must be an even number */
+
+		cqe_size = iwcq->sc_cq.cq_uk.avoid_mem_cflct ? 64 : 32;
+		if (entries * cqe_size == IRDMA_HW_PAGE_SIZE)
+			entries += 2;
 	}
 
 	info.cq_size = max(entries, 4);
@@ -2483,6 +2488,7 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	int err_code;
 	int entries = attr->cqe;
 	bool cqe_64byte_ena;
+	u8 cqe_size;
 
 	err_code = cq_validate_flags(attr->flags, dev->hw_attrs.uk_attrs.hw_rev);
 	if (err_code)
@@ -2508,6 +2514,7 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	ukinfo->cq_id = cq_num;
 	cqe_64byte_ena = dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_64_BYTE_CQE ?
 			 true : false;
+	cqe_size = cqe_64byte_ena ? 64 : 32;
 	ukinfo->avoid_mem_cflct = cqe_64byte_ena;
 	iwcq->ibcq.cqe = info.cq_uk_init_info.cq_size;
 	if (attr->comp_vector < rf->ceqs_count)
@@ -2580,13 +2587,16 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 			goto cq_free_rsrc;
 		}
 
-		entries++;
+		entries += 2;
 		if (!cqe_64byte_ena && dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
 			entries *= 2;
 
 		if (entries & 1)
 			entries += 1; /* cq size must be an even number */
 
+		if (entries * cqe_size == IRDMA_HW_PAGE_SIZE)
+			entries += 2;
+
 		ukinfo->cq_size = entries;
 
 		if (cqe_64byte_ena)
@@ -4504,7 +4514,7 @@ static int irdma_req_notify_cq(struct ib_cq *ibcq,
 	}
 
 	if ((notify_flags & IB_CQ_REPORT_MISSED_EVENTS) &&
-	    (!irdma_cq_empty(iwcq) || !list_empty(&iwcq->cmpl_generated)))
+	    (!irdma_uk_cq_empty(ukcq) || !list_empty(&iwcq->cmpl_generated)))
 		ret = 1;
 	spin_unlock_irqrestore(&iwcq->lock, flags);
 
-- 
2.37.3


