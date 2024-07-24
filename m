Return-Path: <linux-rdma+bounces-3974-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 725C993B994
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 01:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945571C22FC0
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788D4149C77;
	Wed, 24 Jul 2024 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ib7GLiKv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563451494DB
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864456; cv=none; b=SeB4DKfLJpmlo4f9dyHRc+FK5G3zKzu1+0DbU21oxYOubIy1qpoYP/c/Z6LG+CC6v2pTloc7I5Ra0QxBKndH59LeXVRQak0KfCX6QHDybfkHXRnx1eUYNDL65ONsKlNObCgfiO8NxdQwFcu0dX3IKQ1PApSejZXUIuAank+6RHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864456; c=relaxed/simple;
	bh=ntSPNb3Np3EhlZxXdIigFHoJJEXjXhptSNhjvH1HcSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7cZByJgtgX3sI+HGhoUQl5P4TSIbbxj8f5UFDC0h4eQUzY3TUcKB5ENJDyYEsDCUUC4bLikWOz3ROby6bRUTPHGMApDVDhFCqpJm5d+N4qt8vT8tOj0/S0RRwEXJ+F5aEx+DW5qmwZfaCuHmlrAFoBkqmTyONfsGGz8lnIDwN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ib7GLiKv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864454; x=1753400454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ntSPNb3Np3EhlZxXdIigFHoJJEXjXhptSNhjvH1HcSs=;
  b=ib7GLiKvpacwAfTjaxFKi7tK2GFClIBO0It7To82PaPQM+12fwzSpTL4
   M8go90MIZywysJSezYYzqSlYMwr7MowRl9USSohNZytDj74uADVWhUbLi
   Q+VTX9BDGFLKtJWaojWo43vUC9O2kLelilq4740n/k50As7HuER8Hb84K
   GruykHfrex8cCkMqtfSXrIWxw0LcOGnzg523foQebNGoc3RtGFpYDKEq/
   3iv4w183Zw4SPgypcPM6J0jX2A3bk7YUjA7F93eu8yiYDNwpMl3BS7OzK
   ZULRNxB9v2mhQTyBz9OLdvzRy7mBXvi8PYbeqghstZC03LnTrwMEUx2aj
   A==;
X-CSE-ConnectionGUID: xYzJuxFZQ4+efaMqyLcYYw==
X-CSE-MsgGUID: 3G7IemNMQOeLbXciJzv1eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44999807"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="44999807"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:48 -0700
X-CSE-ConnectionGUID: s1+26j9PQTOuVhKrCvXP9w==
X-CSE-MsgGUID: OXZ/3SIdQ7CIdCKaqOBmqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52426122"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.96.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:47 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	mustafa.ismail@intel.com,
	Jay Bhat <jay.bhat@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC PATCH 24/25] RDMA/irdma: Add Push Page Support for GEN3
Date: Wed, 24 Jul 2024 18:39:16 -0500
Message-Id: <20240724233917.704-25-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
References: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jay Bhat <jay.bhat@intel.com>

Implement the necessary support for enabling push on GEN3 devices.

Key Changes:
- Introduce a RDMA virtual channel operation with the Control Plane (CP)
to manage the doorbell/push page which is a privileged operation.
- Implement the MMIO mapping of push pages which adheres to the updated
  BAR layout and page indexing specific to GEN3 devices.
- Support up to 16 QPs on a single push page, given that they are tied
to the same Queue Set.
- Impose limits on the size of WQEs pushed based on the message length
constraints provided by the CP.

Signed-off-by: Jay Bhat <jay.bhat@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c     |  1 -
 drivers/infiniband/hw/irdma/defs.h     |  2 +
 drivers/infiniband/hw/irdma/irdma.h    |  1 +
 drivers/infiniband/hw/irdma/type.h     |  3 ++
 drivers/infiniband/hw/irdma/user.h     |  1 -
 drivers/infiniband/hw/irdma/utils.c    | 48 ++++++++++++++++++---
 drivers/infiniband/hw/irdma/verbs.c    | 79 ++++++++++++++++++++++++++++++----
 drivers/infiniband/hw/irdma/verbs.h    |  7 +++
 drivers/infiniband/hw/irdma/virtchnl.c | 40 +++++++++++++++++
 drivers/infiniband/hw/irdma/virtchnl.h | 11 +++++
 include/uapi/rdma/irdma-abi.h          |  3 +-
 11 files changed, 178 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 73cab77..0c13b0b 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -6467,7 +6467,6 @@ int irdma_sc_dev_init(enum irdma_vers ver, struct irdma_sc_dev *dev,
 	dev->hw_attrs.max_hw_outbound_msg_size = IRDMA_MAX_OUTBOUND_MSG_SIZE;
 	dev->hw_attrs.max_mr_size = IRDMA_MAX_MR_SIZE;
 	dev->hw_attrs.max_hw_inbound_msg_size = IRDMA_MAX_INBOUND_MSG_SIZE;
-	dev->hw_attrs.max_hw_device_pages = IRDMA_MAX_PUSH_PAGE_COUNT;
 	dev->hw_attrs.uk_attrs.max_hw_inline = IRDMA_MAX_INLINE_DATA_SIZE;
 	dev->hw_attrs.max_hw_wqes = IRDMA_MAX_WQ_ENTRIES;
 	dev->hw_attrs.max_qp_wr = IRDMA_MAX_QP_WRS(IRDMA_MAX_QUANTA_PER_WR);
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index e75dd8b..53d9588 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -167,6 +167,8 @@ enum irdma_protocol_used {
 #define IRDMA_MAX_RQ_WQE_SHIFT_GEN1 2
 #define IRDMA_MAX_RQ_WQE_SHIFT_GEN2 3
 
+#define IRDMA_DEFAULT_MAX_PUSH_LEN 8192
+
 #define IRDMA_SQ_RSVD	258
 #define IRDMA_RQ_RSVD	1
 
diff --git a/drivers/infiniband/hw/irdma/irdma.h b/drivers/infiniband/hw/irdma/irdma.h
index 6af79bb..955ab98 100644
--- a/drivers/infiniband/hw/irdma/irdma.h
+++ b/drivers/infiniband/hw/irdma/irdma.h
@@ -133,6 +133,7 @@ struct irdma_uk_attrs {
 	u32 min_hw_cq_size;
 	u32 max_hw_cq_size;
 	u32 max_hw_srq_quanta;
+	u16 max_hw_push_len;
 	u16 max_hw_sq_chunk;
 	u16 min_hw_wq_size;
 	u8 hw_rev;
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 9916091..0bfaf8b 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -1289,8 +1289,11 @@ struct irdma_qhash_table_info {
 struct irdma_cqp_manage_push_page_info {
 	u32 push_idx;
 	u16 qs_handle;
+	u16 hmc_fn_id;
 	u8 free_page;
 	u8 push_page_type;
+	u8 page_type;
+	u8 use_hmc_fn_id;
 };
 
 struct irdma_qp_flush_info {
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index a2029f5..d04175d 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -180,7 +180,6 @@ enum irdma_device_caps_const {
 	IRDMA_MAX_SGE_RD =			13,
 	IRDMA_MAX_OUTBOUND_MSG_SIZE =		2147483647,
 	IRDMA_MAX_INBOUND_MSG_SIZE =		2147483647,
-	IRDMA_MAX_PUSH_PAGE_COUNT =		1024,
 	IRDMA_MAX_PE_ENA_VF_COUNT =		32,
 	IRDMA_MAX_VF_FPM_ID =			47,
 	IRDMA_MAX_SQ_PAYLOAD_SIZE =		2145386496,
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 2fdcb88..2e210be 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -1156,21 +1156,51 @@ int irdma_cqp_qp_create_cmd(struct irdma_sc_dev *dev, struct irdma_sc_qp *qp)
 /**
  * irdma_dealloc_push_page - free a push page for qp
  * @rf: RDMA PCI function
- * @qp: hardware control qp
+ * @iwqp: QP pointer
  */
 static void irdma_dealloc_push_page(struct irdma_pci_f *rf,
-				    struct irdma_sc_qp *qp)
+				    struct irdma_qp *iwqp)
 {
 	struct irdma_cqp_request *cqp_request;
 	struct cqp_cmds_info *cqp_info;
 	int status;
+	struct irdma_sc_qp *qp = &iwqp->sc_qp;
+	struct irdma_pd *pd = iwqp->iwpd;
+	u32 push_pos;
+	bool is_empty;
 
 	if (qp->push_idx == IRDMA_INVALID_PUSH_PAGE_INDEX)
 		return;
 
+	mutex_lock(&pd->push_alloc_mutex);
+
+	push_pos = qp->push_offset / IRDMA_PUSH_WIN_SIZE;
+	__clear_bit(push_pos, pd->push_offset_bmap);
+	is_empty = bitmap_empty(pd->push_offset_bmap, IRDMA_QPS_PER_PUSH_PAGE);
+	if (!is_empty) {
+		qp->push_idx = IRDMA_INVALID_PUSH_PAGE_INDEX;
+		goto exit;
+	}
+
+	if (!rf->sc_dev.privileged) {
+		u32 pg_idx = qp->push_idx;
+
+		status = irdma_vchnl_req_manage_push_pg(&rf->sc_dev, false,
+							qp->qs_handle, &pg_idx);
+		if (!status) {
+			qp->push_idx = IRDMA_INVALID_PUSH_PAGE_INDEX;
+			pd->push_idx = IRDMA_INVALID_PUSH_PAGE_INDEX;
+		} else {
+			__set_bit(push_pos, pd->push_offset_bmap);
+		}
+		goto exit;
+	}
+
 	cqp_request = irdma_alloc_and_get_cqp_request(&rf->cqp, false);
-	if (!cqp_request)
-		return;
+	if (!cqp_request) {
+		__set_bit(push_pos, pd->push_offset_bmap);
+		goto exit;
+	}
 
 	cqp_info = &cqp_request->info;
 	cqp_info->cqp_cmd = IRDMA_OP_MANAGE_PUSH_PAGE;
@@ -1182,9 +1212,15 @@ static void irdma_dealloc_push_page(struct irdma_pci_f *rf,
 	cqp_info->in.u.manage_push_page.cqp = &rf->cqp.sc_cqp;
 	cqp_info->in.u.manage_push_page.scratch = (uintptr_t)cqp_request;
 	status = irdma_handle_cqp_op(rf, cqp_request);
-	if (!status)
+	if (!status) {
 		qp->push_idx = IRDMA_INVALID_PUSH_PAGE_INDEX;
+		pd->push_idx = IRDMA_INVALID_PUSH_PAGE_INDEX;
+	} else {
+		__set_bit(push_pos, pd->push_offset_bmap);
+	}
 	irdma_put_cqp_request(&rf->cqp, cqp_request);
+exit:
+	mutex_unlock(&pd->push_alloc_mutex);
 }
 
 static void irdma_free_gsi_qp_rsrc(struct irdma_qp *iwqp, u32 qp_num)
@@ -1218,7 +1254,7 @@ void irdma_free_qp_rsrc(struct irdma_qp *iwqp)
 	u32 qp_num = iwqp->sc_qp.qp_uk.qp_id;
 
 	irdma_ieq_cleanup_qp(iwdev->vsi.ieq, &iwqp->sc_qp);
-	irdma_dealloc_push_page(rf, &iwqp->sc_qp);
+	irdma_dealloc_push_page(rf, iwqp);
 	if (iwqp->sc_qp.vsi) {
 		irdma_qp_rem_qos(&iwqp->sc_qp);
 		iwqp->sc_qp.dev->ws_remove(iwqp->sc_qp.vsi,
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 8765a2a..edcd720 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -245,11 +245,46 @@ static void irdma_alloc_push_page(struct irdma_qp *iwqp)
 	struct cqp_cmds_info *cqp_info;
 	struct irdma_device *iwdev = iwqp->iwdev;
 	struct irdma_sc_qp *qp = &iwqp->sc_qp;
+	struct irdma_pd *pd = iwqp->iwpd;
+	u32 push_pos = 0;
 	int status;
 
+	mutex_lock(&pd->push_alloc_mutex);
+	if (pd->push_idx == IRDMA_INVALID_PUSH_PAGE_INDEX) {
+		bitmap_zero(pd->push_offset_bmap, IRDMA_QPS_PER_PUSH_PAGE);
+	} else {
+		if (pd->qs_handle == qp->qs_handle) {
+			push_pos = find_first_zero_bit(pd->push_offset_bmap,
+						       IRDMA_QPS_PER_PUSH_PAGE);
+			if (push_pos < IRDMA_QPS_PER_PUSH_PAGE) {
+				qp->push_idx = pd->push_idx;
+				qp->push_offset =
+					push_pos * IRDMA_PUSH_WIN_SIZE;
+				__set_bit(push_pos, pd->push_offset_bmap);
+			}
+		}
+		goto exit;
+	}
+
+	if (!iwdev->rf->sc_dev.privileged) {
+		u32 pg_idx;
+
+		status = irdma_vchnl_req_manage_push_pg(&iwdev->rf->sc_dev,
+							true, qp->qs_handle,
+							&pg_idx);
+		if (!status && pg_idx != IRDMA_INVALID_PUSH_PAGE_INDEX) {
+			qp->push_idx = pg_idx;
+			qp->push_offset = push_pos * IRDMA_PUSH_WIN_SIZE;
+			__set_bit(push_pos, pd->push_offset_bmap);
+			pd->push_idx = pg_idx;
+			pd->qs_handle = qp->qs_handle;
+		}
+		goto exit;
+	}
+
 	cqp_request = irdma_alloc_and_get_cqp_request(&iwdev->rf->cqp, true);
 	if (!cqp_request)
-		return;
+		goto exit;
 
 	cqp_info = &cqp_request->info;
 	cqp_info->cqp_cmd = IRDMA_OP_MANAGE_PUSH_PAGE;
@@ -266,10 +301,15 @@ static void irdma_alloc_push_page(struct irdma_qp *iwqp)
 	if (!status && cqp_request->compl_info.op_ret_val <
 	    iwdev->rf->sc_dev.hw_attrs.max_hw_device_pages) {
 		qp->push_idx = cqp_request->compl_info.op_ret_val;
-		qp->push_offset = 0;
+		qp->push_offset = push_pos * IRDMA_PUSH_WIN_SIZE;
+		__set_bit(push_pos, pd->push_offset_bmap);
+		pd->push_idx = cqp_request->compl_info.op_ret_val;
+		pd->qs_handle = qp->qs_handle;
 	}
 
 	irdma_put_cqp_request(&iwdev->rf->cqp, cqp_request);
+exit:
+	mutex_unlock(&pd->push_alloc_mutex);
 }
 
 /**
@@ -351,6 +391,9 @@ static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 		uresp.comp_mask |= IRDMA_ALLOC_UCTX_MIN_HW_WQ_SIZE;
 		uresp.max_hw_srq_quanta = uk_attrs->max_hw_srq_quanta;
 		uresp.comp_mask |= IRDMA_ALLOC_UCTX_MAX_HW_SRQ_QUANTA;
+		uresp.max_hw_push_len = uk_attrs->max_hw_push_len;
+		uresp.comp_mask |= IRDMA_SUPPORT_MAX_HW_PUSH_LEN;
+
 		if (ib_copy_to_udata(udata, &uresp,
 				     min(sizeof(uresp), udata->outlen))) {
 			rdma_user_mmap_entry_remove(ucontext->db_mmap_entry);
@@ -410,6 +453,9 @@ static int irdma_alloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 	if (err)
 		return err;
 
+	iwpd->push_idx = IRDMA_INVALID_PUSH_PAGE_INDEX;
+	mutex_init(&iwpd->push_alloc_mutex);
+
 	sc_pd = &iwpd->sc_pd;
 	if (udata) {
 		struct irdma_ucontext *ucontext =
@@ -485,6 +531,23 @@ static void irdma_clean_cqes(struct irdma_qp *iwqp, struct irdma_cq *iwcq)
 	spin_unlock_irqrestore(&iwcq->lock, flags);
 }
 
+static u64 irdma_compute_push_wqe_offset(struct irdma_device *iwdev, u32 page_idx)
+{
+	u64 bar_off = (uintptr_t)iwdev->rf->sc_dev.hw_regs[IRDMA_DB_ADDR_OFFSET];
+
+	if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.hw_rev == IRDMA_GEN_2) {
+		/* skip over db page */
+		bar_off += IRDMA_HW_PAGE_SIZE;
+		/* skip over reserved space */
+		bar_off += IRDMA_PF_BAR_RSVD;
+	}
+
+	/* push wqe page */
+	bar_off += (u64)page_idx * IRDMA_HW_PAGE_SIZE;
+
+	return bar_off;
+}
+
 static void irdma_remove_push_mmap_entries(struct irdma_qp *iwqp)
 {
 	if (iwqp->push_db_mmap_entry) {
@@ -503,14 +566,12 @@ static int irdma_setup_push_mmap_entries(struct irdma_ucontext *ucontext,
 					 u64 *push_db_mmap_key)
 {
 	struct irdma_device *iwdev = ucontext->iwdev;
-	u64 rsvd, bar_off;
+	u64 bar_off;
+
+	WARN_ON_ONCE(iwdev->rf->sc_dev.hw_attrs.uk_attrs.hw_rev < IRDMA_GEN_2);
+
+	bar_off = irdma_compute_push_wqe_offset(iwdev, iwqp->sc_qp.push_idx);
 
-	rsvd = IRDMA_PF_BAR_RSVD;
-	bar_off = (uintptr_t)iwdev->rf->sc_dev.hw_regs[IRDMA_DB_ADDR_OFFSET];
-	/* skip over db page */
-	bar_off += IRDMA_HW_PAGE_SIZE;
-	/* push wqe page */
-	bar_off += rsvd + iwqp->sc_qp.push_idx * IRDMA_HW_PAGE_SIZE;
 	iwqp->push_wqe_mmap_entry = irdma_user_mmap_entry_insert(ucontext,
 					bar_off, IRDMA_MMAP_IO_WC,
 					push_wqe_mmap_key);
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index 0922a22..71b627d 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -8,6 +8,9 @@
 
 #define IRDMA_PKEY_TBL_SZ		1
 #define IRDMA_DEFAULT_PKEY		0xFFFF
+
+#define IRDMA_QPS_PER_PUSH_PAGE		16
+#define IRDMA_PUSH_WIN_SIZE		256
 #define IRDMA_SHADOW_PGCNT		1
 
 struct irdma_ucontext {
@@ -28,6 +31,10 @@ struct irdma_ucontext {
 struct irdma_pd {
 	struct ib_pd ibpd;
 	struct irdma_sc_pd sc_pd;
+	struct mutex push_alloc_mutex; /* protect push page alloc within a PD*/
+	DECLARE_BITMAP(push_offset_bmap, IRDMA_QPS_PER_PUSH_PAGE);
+	u32 push_idx;
+	u16 qs_handle;
 };
 
 union irdma_sockaddr {
diff --git a/drivers/infiniband/hw/irdma/virtchnl.c b/drivers/infiniband/hw/irdma/virtchnl.c
index 9f39cd6..667ec0e 100644
--- a/drivers/infiniband/hw/irdma/virtchnl.c
+++ b/drivers/infiniband/hw/irdma/virtchnl.c
@@ -66,6 +66,7 @@ int irdma_sc_vchnl_init(struct irdma_sc_dev *dev,
 	dev->privileged = info->privileged;
 	dev->is_pf = info->is_pf;
 	dev->hw_attrs.uk_attrs.hw_rev = info->hw_rev;
+	dev->hw_attrs.uk_attrs.max_hw_push_len = IRDMA_DEFAULT_MAX_PUSH_LEN;
 
 	if (!dev->privileged) {
 		int ret = irdma_vchnl_req_get_ver(dev, IRDMA_VCHNL_CHNL_VER_MAX,
@@ -83,6 +84,7 @@ int irdma_sc_vchnl_init(struct irdma_sc_dev *dev,
 			return ret;
 
 		dev->hw_attrs.uk_attrs.hw_rev = dev->vc_caps.hw_rev;
+		dev->hw_attrs.uk_attrs.max_hw_push_len = dev->vc_caps.max_hw_push_len;
 	}
 
 	return 0;
@@ -107,6 +109,7 @@ static int irdma_vchnl_req_verify_resp(struct irdma_vchnl_req *vchnl_req,
 		if (resp_len < IRDMA_VCHNL_OP_GET_RDMA_CAPS_MIN_SIZE)
 			return -EBADMSG;
 		break;
+	case IRDMA_VCHNL_OP_MANAGE_PUSH_PAGE:
 	case IRDMA_VCHNL_OP_GET_REG_LAYOUT:
 	case IRDMA_VCHNL_OP_QUEUE_VECTOR_MAP:
 	case IRDMA_VCHNL_OP_QUEUE_VECTOR_UNMAP:
@@ -187,6 +190,40 @@ static int irdma_vchnl_req_send_sync(struct irdma_sc_dev *dev,
 }
 
 /**
+ * irdma_vchnl_req_manage_push_pg - manage push page
+ * @dev: rdma device pointer
+ * @add: Add or remove push page
+ * @qs_handle: qs_handle of push page for add
+ * @pg_idx: index of push page that is added or removed
+ */
+int irdma_vchnl_req_manage_push_pg(struct irdma_sc_dev *dev, bool add,
+				   u32 qs_handle, u32 *pg_idx)
+{
+	struct irdma_vchnl_manage_push_page add_push_pg = {};
+	struct irdma_vchnl_req_init_info info = {};
+
+	if (!dev->vchnl_up)
+		return -EBUSY;
+
+	add_push_pg.add = add;
+	add_push_pg.pg_idx = add ? 0 : *pg_idx;
+	add_push_pg.qs_handle = qs_handle;
+
+	info.op_code = IRDMA_VCHNL_OP_MANAGE_PUSH_PAGE;
+	info.op_ver = IRDMA_VCHNL_OP_MANAGE_PUSH_PAGE_V0;
+	info.req_parm = &add_push_pg;
+	info.req_parm_len = sizeof(add_push_pg);
+	info.resp_parm = pg_idx;
+	info.resp_parm_len = sizeof(*pg_idx);
+
+	ibdev_dbg(to_ibdev(dev),
+		  "VIRT: Sending msg: manage_push_pg add = %d, idx %u, qsh %u\n",
+		  add_push_pg.add, add_push_pg.pg_idx, add_push_pg.qs_handle);
+
+	return irdma_vchnl_req_send_sync(dev, &info);
+}
+
+/**
  * irdma_vchnl_req_get_reg_layout - Get Register Layout
  * @dev: RDMA device pointer
  */
@@ -561,6 +598,9 @@ int irdma_vchnl_req_get_caps(struct irdma_sc_dev *dev)
 	if (ret)
 		return ret;
 
+	if (!dev->vc_caps.max_hw_push_len)
+		dev->vc_caps.max_hw_push_len = IRDMA_DEFAULT_MAX_PUSH_LEN;
+
 	if (dev->vc_caps.hw_rev > IRDMA_GEN_MAX ||
 	    dev->vc_caps.hw_rev < IRDMA_GEN_2) {
 		ibdev_dbg(to_ibdev(dev),
diff --git a/drivers/infiniband/hw/irdma/virtchnl.h b/drivers/infiniband/hw/irdma/virtchnl.h
index 23e66bc..0c88f64 100644
--- a/drivers/infiniband/hw/irdma/virtchnl.h
+++ b/drivers/infiniband/hw/irdma/virtchnl.h
@@ -14,6 +14,7 @@
 #define IRDMA_VCHNL_OP_GET_HMC_FCN_V1 1
 #define IRDMA_VCHNL_OP_GET_HMC_FCN_V2 2
 #define IRDMA_VCHNL_OP_PUT_HMC_FCN_V0 0
+#define IRDMA_VCHNL_OP_MANAGE_PUSH_PAGE_V0 0
 #define IRDMA_VCHNL_OP_GET_REG_LAYOUT_V0 0
 #define IRDMA_VCHNL_OP_QUEUE_VECTOR_MAP_V0 0
 #define IRDMA_VCHNL_OP_QUEUE_VECTOR_UNMAP_V0 0
@@ -55,6 +56,7 @@ enum irdma_vchnl_ops {
 	IRDMA_VCHNL_OP_GET_VER = 0,
 	IRDMA_VCHNL_OP_GET_HMC_FCN = 1,
 	IRDMA_VCHNL_OP_PUT_HMC_FCN = 2,
+	IRDMA_VCHNL_OP_MANAGE_PUSH_PAGE = 10,
 	IRDMA_VCHNL_OP_GET_REG_LAYOUT = 11,
 	IRDMA_VCHNL_OP_GET_RDMA_CAPS = 13,
 	IRDMA_VCHNL_OP_QUEUE_VECTOR_MAP = 14,
@@ -125,6 +127,13 @@ struct irdma_vchnl_init_info {
 	bool is_pf;
 };
 
+struct irdma_vchnl_manage_push_page {
+	u8 page_type;
+	u8 add;
+	u32 pg_idx;
+	u32 qs_handle;
+};
+
 struct irdma_vchnl_reg_info {
 	u32 reg_offset;
 	u16 field_cnt;
@@ -167,6 +176,8 @@ int irdma_vchnl_req_get_ver(struct irdma_sc_dev *dev, u16 ver_req,
 int irdma_vchnl_req_get_caps(struct irdma_sc_dev *dev);
 int irdma_vchnl_req_get_resp(struct irdma_sc_dev *dev,
 			     struct irdma_vchnl_req *vc_req);
+int irdma_vchnl_req_manage_push_pg(struct irdma_sc_dev *dev, bool add,
+				   u32 qs_handle, u32 *pg_idx);
 int irdma_vchnl_req_get_reg_layout(struct irdma_sc_dev *dev);
 int irdma_vchnl_req_aeq_vec_map(struct irdma_sc_dev *dev, u32 v_idx);
 int irdma_vchnl_req_ceq_vec_map(struct irdma_sc_dev *dev, u16 ceq_id,
diff --git a/include/uapi/rdma/irdma-abi.h b/include/uapi/rdma/irdma-abi.h
index f7788d3..9c8cee0 100644
--- a/include/uapi/rdma/irdma-abi.h
+++ b/include/uapi/rdma/irdma-abi.h
@@ -28,6 +28,7 @@ enum {
 	IRDMA_ALLOC_UCTX_MIN_HW_WQ_SIZE = 1 << 1,
 	IRDMA_ALLOC_UCTX_MAX_HW_SRQ_QUANTA = 1 << 2,
 	IRDMA_SUPPORT_WQE_FORMAT_V2 = 1 << 3,
+	IRDMA_SUPPORT_MAX_HW_PUSH_LEN = 1 << 4,
 };
 
 struct irdma_alloc_ucontext_req {
@@ -58,7 +59,7 @@ struct irdma_alloc_ucontext_resp {
 	__aligned_u64 comp_mask;
 	__u16 min_hw_wq_size;
 	__u32 max_hw_srq_quanta;
-	__u8 rsvd3[2];
+	__u16 max_hw_push_len;
 };
 
 struct irdma_alloc_pd_resp {
-- 
1.8.3.1


