Return-Path: <linux-rdma+bounces-12960-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5640B386A1
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 17:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF936366487
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 15:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1630B286D69;
	Wed, 27 Aug 2025 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCq2XAhw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54EF27E7F9
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308421; cv=none; b=hH5AmpccMGcw5b+hPLiIOwceKHhYuMsKx/Yg7Icnvmbh90+yi2QRazx/5kefKiNXUmDsDXOukiYnVTQeOGBMg90Vhzs6qZWzsyJUz29GQ8gbCJFwUuHEDeZIUOUqYK7FYF3RhcfBwslweaUf9RjAD4qLOyTu5o0a+VdU49gdJaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308421; c=relaxed/simple;
	bh=gsIag/0tdqogTYbGe8fRxtCSOeKDluIEDx2TOaHp/6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0/wORXY+tzy/eIcFkliGJQBO6m2snrLQHsCnyRnR9nYtKjYtAZHPcENYBkxQpzN2ntVbgA4NBFcd5Jd2UR1xgy8jBohGjlk6g+6CDDZx20+htPW9joVRgH9b+VxsSGwKmZrXGbueo+ZT7qom1KtxMxxFS8H+7u0+WKSEVB5bsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCq2XAhw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756308419; x=1787844419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gsIag/0tdqogTYbGe8fRxtCSOeKDluIEDx2TOaHp/6c=;
  b=FCq2XAhwU1mtUz8nMV7r0gv5NlJOh9Vcahi9/Gs1oFqiNl0wuxD0gid0
   IxZOj0rMlvjIRTlepaHU9qenw8JOQkMj5E8XNpf0Xlx8NmdCZg0WLPTu2
   3hLg2JHmS0SDJSjrnVLVxPCljDV0ZW/kwNboQHiDzcLUI6nkSq8xPKeTc
   ofNXk9aOsYVE+4GFJB16UHJfGtRs/sXzQOpgxdDwKNlCrxFSmNQEZetHX
   zpCBdXDhjN4HHLOzgjVr5hEdqnJxg40C9Emrps/0nDNkUeMY7ur+CeRi5
   +cIQRiz3vKWXagfnmpn5s1wvX7kl0N5C199cBbxvqgVioe8QDRxWNQmKZ
   g==;
X-CSE-ConnectionGUID: JO8aN8QeRNaKZyYWM8y6Hg==
X-CSE-MsgGUID: IIutfU5OS0KyqiqVvwyWrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76162786"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76162786"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:42 -0700
X-CSE-ConnectionGUID: 1VAFvoV0ROibuBwn9LStoQ==
X-CSE-MsgGUID: PcrevDHkRNyvaiTdra+Lew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174206855"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:40 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 11/16] RDMA/irdma: Support 64-byte CQEs and GEN3 CQE opcode decoding
Date: Wed, 27 Aug 2025 10:25:40 -0500
Message-ID: <20250827152545.2056-12-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
References: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiraz Saleem <shiraz.saleem@intel.com>

Introduce support for 64-byte CQEs in GEN3 devices. Additionally,
implement GEN3-specific CQE opcode decoding.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---

Changes since split:
* Size CQP CCQ correctly for GEN3 to accommodate pending completions.
  Each CQP posting could result in one pending and one real completion.

At [4]:
* Fix detection of CQ empty when avoid_mem_cflct is on.
* In resize CQ, do not double the CQ size if avoid_mem_cflct is on.
* Make CQ size an even number, which is a GEN3 HW requirement.

 drivers/infiniband/hw/irdma/hw.c    |  6 ++++--
 drivers/infiniband/hw/irdma/main.h  |  3 ++-
 drivers/infiniband/hw/irdma/utils.c |  5 ++++-
 drivers/infiniband/hw/irdma/verbs.c | 30 ++++++++++++++++++++++++-----
 drivers/infiniband/hw/irdma/verbs.h | 13 +++++++++++++
 5 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 459343ef72b9..2931d1a879e9 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1117,13 +1117,15 @@ static int irdma_create_ccq(struct irdma_pci_f *rf)
 	struct irdma_sc_dev *dev = &rf->sc_dev;
 	struct irdma_ccq_init_info info = {};
 	struct irdma_ccq *ccq = &rf->ccq;
+	int ccq_size;
 	int status;
 
 	dev->ccq = &ccq->sc_cq;
 	dev->ccq->dev = dev;
 	info.dev = dev;
+	ccq_size = (rf->rdma_ver >= IRDMA_GEN_3) ? IW_GEN_3_CCQ_SIZE : IW_CCQ_SIZE;
 	ccq->shadow_area.size = sizeof(struct irdma_cq_shadow_area);
-	ccq->mem_cq.size = ALIGN(sizeof(struct irdma_cqe) * IW_CCQ_SIZE,
+	ccq->mem_cq.size = ALIGN(sizeof(struct irdma_cqe) * ccq_size,
 				 IRDMA_CQ0_ALIGNMENT);
 	ccq->mem_cq.va = dma_alloc_coherent(dev->hw->device, ccq->mem_cq.size,
 					    &ccq->mem_cq.pa, GFP_KERNEL);
@@ -1140,7 +1142,7 @@ static int irdma_create_ccq(struct irdma_pci_f *rf)
 	/* populate the ccq init info */
 	info.cq_base = ccq->mem_cq.va;
 	info.cq_pa = ccq->mem_cq.pa;
-	info.num_elem = IW_CCQ_SIZE;
+	info.num_elem = ccq_size;
 	info.shadow_area = ccq->shadow_area.va;
 	info.shadow_area_pa = ccq->shadow_area.pa;
 	info.ceqe_mask = false;
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 3d37cd12e9f6..6922cfaac6d0 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -66,7 +66,8 @@ extern struct iidc_rdma_core_auxiliary_drv ig3rdma_core_auxiliary_drv;
 #define IRDMA_MACIP_ADD		1
 #define IRDMA_MACIP_DELETE	2
 
-#define IW_CCQ_SIZE	(IRDMA_CQP_SW_SQSIZE_2048 + 1)
+#define IW_GEN_3_CCQ_SIZE  (2 * IRDMA_CQP_SW_SQSIZE_2048 + 2)
+#define IW_CCQ_SIZE	(IRDMA_CQP_SW_SQSIZE_2048 + 2)
 #define IW_CEQ_SIZE	2048
 #define IW_AEQ_SIZE	2048
 
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 1fd09e287e6f..0b12a875dbe9 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2338,7 +2338,10 @@ bool irdma_cq_empty(struct irdma_cq *iwcq)
 	u8 polarity;
 
 	ukcq  = &iwcq->sc_cq.cq_uk;
-	cqe = IRDMA_GET_CURRENT_CQ_ELEM(ukcq);
+	if (ukcq->avoid_mem_cflct)
+		cqe = IRDMA_GET_CURRENT_EXTENDED_CQ_ELEM(ukcq);
+	else
+		cqe = IRDMA_GET_CURRENT_CQ_ELEM(ukcq);
 	get_64bit_val(cqe, 24, &qword3);
 	polarity = (u8)FIELD_GET(IRDMA_CQ_VALID, qword3);
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 2857631543b7..da0f56e0c897 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1971,8 +1971,13 @@ static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
 
 	if (!iwcq->user_mode) {
 		entries++;
-		if (rf->sc_dev.hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
+
+		if (!iwcq->sc_cq.cq_uk.avoid_mem_cflct &&
+		    dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
 			entries *= 2;
+
+		if (entries & 1)
+			entries += 1; /* cq size must be an even number */
 	}
 
 	info.cq_size = max(entries, 4);
@@ -2115,6 +2120,7 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	unsigned long flags;
 	int err_code;
 	int entries = attr->cqe;
+	bool cqe_64byte_ena;
 
 	err_code = cq_validate_flags(attr->flags, dev->hw_attrs.uk_attrs.hw_rev);
 	if (err_code)
@@ -2138,6 +2144,9 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	info.dev = dev;
 	ukinfo->cq_size = max(entries, 4);
 	ukinfo->cq_id = cq_num;
+	cqe_64byte_ena = dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_64_BYTE_CQE ?
+			 true : false;
+	ukinfo->avoid_mem_cflct = cqe_64byte_ena;
 	iwcq->ibcq.cqe = info.cq_uk_init_info.cq_size;
 	if (attr->comp_vector < rf->ceqs_count)
 		info.ceq_id = attr->comp_vector;
@@ -2213,11 +2222,18 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 		}
 
 		entries++;
-		if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
+		if (!cqe_64byte_ena && dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
 			entries *= 2;
+
+		if (entries & 1)
+			entries += 1; /* cq size must be an even number */
+
 		ukinfo->cq_size = entries;
 
-		rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_cqe);
+		if (cqe_64byte_ena)
+			rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_extended_cqe);
+		else
+			rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_cqe);
 		iwcq->kmem.size = ALIGN(round_up(rsize, 256), 256);
 		iwcq->kmem.va = dma_alloc_coherent(dev->hw->device,
 						   iwcq->kmem.size,
@@ -3784,8 +3800,12 @@ static void irdma_process_cqe(struct ib_wc *entry,
 	if (cq_poll_info->q_type == IRDMA_CQE_QTYPE_SQ) {
 		set_ib_wc_op_sq(cq_poll_info, entry);
 	} else {
-		set_ib_wc_op_rq(cq_poll_info, entry,
-				qp->qp_uk.qp_caps & IRDMA_SEND_WITH_IMM);
+		if (qp->dev->hw_attrs.uk_attrs.hw_rev <= IRDMA_GEN_2)
+			set_ib_wc_op_rq(cq_poll_info, entry,
+					qp->qp_uk.qp_caps & IRDMA_SEND_WITH_IMM ?
+					true : false);
+		else
+			set_ib_wc_op_rq_gen_3(cq_poll_info, entry);
 		if (qp->qp_uk.qp_type != IRDMA_QP_TYPE_ROCE_UD &&
 		    cq_poll_info->stag_invalid_set) {
 			entry->ex.invalidate_rkey = cq_poll_info->inv_stag;
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index cfa140b36395..fcb163c45252 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -267,6 +267,19 @@ static inline void set_ib_wc_op_sq(struct irdma_cq_poll_info *cq_poll_info,
 	}
 }
 
+static inline void set_ib_wc_op_rq_gen_3(struct irdma_cq_poll_info *info,
+					 struct ib_wc *entry)
+{
+	switch (info->op_type) {
+	case IRDMA_OP_TYPE_RDMA_WRITE:
+	case IRDMA_OP_TYPE_RDMA_WRITE_SOL:
+		entry->opcode = IB_WC_RECV_RDMA_WITH_IMM;
+		break;
+	default:
+		entry->opcode = IB_WC_RECV;
+	}
+}
+
 static inline void set_ib_wc_op_rq(struct irdma_cq_poll_info *cq_poll_info,
 				   struct ib_wc *entry, bool send_imm_support)
 {
-- 
2.42.0


