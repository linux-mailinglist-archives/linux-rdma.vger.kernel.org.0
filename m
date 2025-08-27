Return-Path: <linux-rdma+bounces-12954-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 912F5B38695
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 17:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218BA1BA5BC5
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D5128488D;
	Wed, 27 Aug 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpmSvjoO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5F7212B0A
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308415; cv=none; b=G5eWj5Mg0W8rnyFhflYv2qlUHgTKRuHQ1/4kOb8aFQQrEno5zeKUujpK8XkzCr0p71j9lYYXTBYKPrdBeQG4MaDAdtiRq/EDblKs9deZIvMGZDTv6l9JmplRJTABw3jHmVeC8hum6sFiRq0nUJ0LLukCaW3nijtbSl1gNtAwtso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308415; c=relaxed/simple;
	bh=Y7/hmIR3AdBnPzzID5zjUDgREMv/H0v1GzIKBoCEaH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipJcfevU8KDewqfnJYtDLxoEz1hG6o6naUacnFvUvNiT4AaqwOjC1F7ZaYWBYXZbUkDVQraLox9lgbEcflVWpuoMcF/UMOtHl29QBSCg59u0rra3aQ8dqgHe0QW7YnK/3XM8F4Z26+VFVvtbRpZIj45AsVweavVR74GMbHRBzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpmSvjoO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756308413; x=1787844413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y7/hmIR3AdBnPzzID5zjUDgREMv/H0v1GzIKBoCEaH0=;
  b=fpmSvjoO5k5vPGCqGvgYeoUmnthb/mAJqWOquLblUCWURXT+xCc0jHxg
   ckp10wsfuZ2lQkz61WFzn1cdCOuIzbUcsoH6JmNHKJ9IYsYRozg7hh//g
   Jb+WTs1Sm4luq5AZN/54gt1GGhUHDc8RVrSZYpGzceoIfFyK1QDUymMem
   I3Cimu2DEH3xlvzijvuJ/2WIuAhfehyMFAkLTJ735tH+t4qZBj8MhBeiJ
   5bifdMX5QgDmyEFSO6m1Y/K1MxceW+mUMrZ/vnfwIv5g2Your6VS3FFx3
   m3+gJeSuRzl85uLCo+BdY0sYEJsG3TmiPbyDnxadqDIeaNPXhPbY56pXO
   w==;
X-CSE-ConnectionGUID: 7RfUytFqRkOCfR30X4YQBA==
X-CSE-MsgGUID: DulUYb2OR7iwJr16InFXdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76162764"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76162764"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:41 -0700
X-CSE-ConnectionGUID: 1OQHk3NXQgqAZzV4Aj5snA==
X-CSE-MsgGUID: eTYqSGJkTmmb2r6Be2OSkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174206783"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:35 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 03/16] RDMA/irdma: Discover and set up GEN3 hardware register layout
Date: Wed, 27 Aug 2025 10:25:32 -0500
Message-ID: <20250827152545.2056-4-tatyana.e.nikolova@intel.com>
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

From: Christopher Bednarz <christopher.n.bednarz@intel.com>

Discover the hardware register layout for GEN3 devices through an RDMA
virtual channel operation with the Control Plane (CP). Set up the
corresponding hardware attributes specific to GEN3 devices.

Signed-off-by: Christopher Bednarz <christopher.n.bednarz@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---

At [4]:
* Decrease IG3RDMA_MAX_IRD/ORD_SIZE to 64 for smaller memory
requirements

 drivers/infiniband/hw/irdma/Makefile     |   1 +
 drivers/infiniband/hw/irdma/ctrl.c       |  31 ++--
 drivers/infiniband/hw/irdma/defs.h       |  12 +-
 drivers/infiniband/hw/irdma/i40iw_hw.c   |   2 +
 drivers/infiniband/hw/irdma/i40iw_hw.h   |   2 +
 drivers/infiniband/hw/irdma/icrdma_hw.c  |   3 +
 drivers/infiniband/hw/irdma/icrdma_hw.h  |   5 +-
 drivers/infiniband/hw/irdma/ig3rdma_hw.c |  65 +++++++++
 drivers/infiniband/hw/irdma/ig3rdma_hw.h |  18 +++
 drivers/infiniband/hw/irdma/irdma.h      |   5 +
 drivers/infiniband/hw/irdma/virtchnl.c   | 178 +++++++++++++++++++++++
 drivers/infiniband/hw/irdma/virtchnl.h   |  44 ++++++
 12 files changed, 351 insertions(+), 15 deletions(-)
 create mode 100644 drivers/infiniband/hw/irdma/ig3rdma_hw.c

diff --git a/drivers/infiniband/hw/irdma/Makefile b/drivers/infiniband/hw/irdma/Makefile
index 3aa63b913377..03ceb9e5475f 100644
--- a/drivers/infiniband/hw/irdma/Makefile
+++ b/drivers/infiniband/hw/irdma/Makefile
@@ -16,6 +16,7 @@ irdma-objs := cm.o        \
 	      ig3rdma_if.o\
 	      icrdma_if.o \
               icrdma_hw.o \
+	      ig3rdma_hw.o\
               main.o      \
               pble.o      \
               puda.o      \
diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 7b3afb9577f9..dd174e771786 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -5672,6 +5672,9 @@ static inline void irdma_sc_init_hw(struct irdma_sc_dev *dev)
 	case IRDMA_GEN_2:
 		icrdma_init_hw(dev);
 		break;
+	case IRDMA_GEN_3:
+		ig3rdma_init_hw(dev);
+		break;
 	}
 }
 
@@ -5742,18 +5745,26 @@ int irdma_sc_dev_init(enum irdma_vers ver, struct irdma_sc_dev *dev,
 
 	irdma_sc_init_hw(dev);
 
-	if (irdma_wait_pe_ready(dev))
-		return -ETIMEDOUT;
+	if (dev->privileged) {
+		if (irdma_wait_pe_ready(dev))
+			return -ETIMEDOUT;
 
-	val = readl(dev->hw_regs[IRDMA_GLPCI_LBARCTRL]);
-	db_size = (u8)FIELD_GET(IRDMA_GLPCI_LBARCTRL_PE_DB_SIZE, val);
-	if (db_size != IRDMA_PE_DB_SIZE_4M && db_size != IRDMA_PE_DB_SIZE_8M) {
-		ibdev_dbg(to_ibdev(dev),
-			  "DEV: RDMA PE doorbell is not enabled in CSR val 0x%x db_size=%d\n",
-			  val, db_size);
-		return -ENODEV;
+		val = readl(dev->hw_regs[IRDMA_GLPCI_LBARCTRL]);
+		db_size = (u8)FIELD_GET(IRDMA_GLPCI_LBARCTRL_PE_DB_SIZE, val);
+		if (db_size != IRDMA_PE_DB_SIZE_4M &&
+		    db_size != IRDMA_PE_DB_SIZE_8M) {
+			ibdev_dbg(to_ibdev(dev),
+				  "DEV: RDMA PE doorbell is not enabled in CSR val 0x%x db_size=%d\n",
+				  val, db_size);
+			return -ENODEV;
+			}
+	} else {
+		ret_code = irdma_vchnl_req_get_reg_layout(dev);
+		if (ret_code)
+			ibdev_dbg(to_ibdev(dev),
+				  "DEV: Get Register layout failed ret = %d\n",
+				  ret_code);
 	}
-	dev->db_addr = dev->hw->hw_addr + (uintptr_t)dev->hw_regs[IRDMA_DB_ADDR_OFFSET];
 
 	return ret_code;
 }
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index 7d363088b5c3..425bcd17abe9 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -115,6 +115,7 @@ enum irdma_protocol_used {
 #define IRDMA_FEATURE_BUF_SIZE		(8 * IRDMA_MAX_FEATURES)
 
 #define ENABLE_LOC_MEM			63
+#define IRDMA_ATOMICS_ALLOWED_BIT	1
 #define MAX_PBLE_PER_SD			0x40000
 #define MAX_PBLE_SD_PER_FCN		0x400
 #define MAX_MR_PER_SD			0x8000
@@ -127,7 +128,7 @@ enum irdma_protocol_used {
 #define IRDMA_QP_SW_MAX_RQ_QUANTA	32768
 #define IRDMA_MAX_QP_WRS(max_quanta_per_wr) \
 	((IRDMA_QP_SW_MAX_WQ_QUANTA - IRDMA_SQ_RSVD) / (max_quanta_per_wr))
-
+#define IRDMA_SRQ_MAX_QUANTA 262144
 #define IRDMAQP_TERM_SEND_TERM_AND_FIN		0
 #define IRDMAQP_TERM_SEND_TERM_ONLY		1
 #define IRDMAQP_TERM_SEND_FIN_ONLY		2
@@ -153,8 +154,13 @@ enum irdma_protocol_used {
 #define IRDMA_SQ_RSVD	258
 #define IRDMA_RQ_RSVD	1
 
-#define IRDMA_FEATURE_RTS_AE			1ULL
-#define IRDMA_FEATURE_CQ_RESIZE			2ULL
+#define IRDMA_FEATURE_RTS_AE			BIT_ULL(0)
+#define IRDMA_FEATURE_CQ_RESIZE			BIT_ULL(1)
+#define IRDMA_FEATURE_64_BYTE_CQE		BIT_ULL(5)
+#define IRDMA_FEATURE_ATOMIC_OPS		BIT_ULL(6)
+#define IRDMA_FEATURE_SRQ			BIT_ULL(7)
+#define IRDMA_FEATURE_CQE_TIMESTAMPING		BIT_ULL(8)
+
 #define IRDMAQP_OP_RDMA_WRITE			0x00
 #define IRDMAQP_OP_RDMA_READ			0x01
 #define IRDMAQP_OP_RDMA_SEND			0x03
diff --git a/drivers/infiniband/hw/irdma/i40iw_hw.c b/drivers/infiniband/hw/irdma/i40iw_hw.c
index ce61a27cb1f6..60c1f2b1811d 100644
--- a/drivers/infiniband/hw/irdma/i40iw_hw.c
+++ b/drivers/infiniband/hw/irdma/i40iw_hw.c
@@ -85,6 +85,7 @@ static u64 i40iw_masks[IRDMA_MAX_MASKS] = {
 	I40E_CQPSQ_CQ_CEQID,
 	I40E_CQPSQ_CQ_CQID,
 	I40E_COMMIT_FPM_CQCNT,
+	I40E_CQPSQ_UPESD_HMCFNID,
 };
 
 static u64 i40iw_shifts[IRDMA_MAX_SHIFTS] = {
@@ -94,6 +95,7 @@ static u64 i40iw_shifts[IRDMA_MAX_SHIFTS] = {
 	I40E_CQPSQ_CQ_CEQID_S,
 	I40E_CQPSQ_CQ_CQID_S,
 	I40E_COMMIT_FPM_CQCNT_S,
+	I40E_CQPSQ_UPESD_HMCFNID_S,
 };
 
 /**
diff --git a/drivers/infiniband/hw/irdma/i40iw_hw.h b/drivers/infiniband/hw/irdma/i40iw_hw.h
index e1db84d8a62c..0095b327afcc 100644
--- a/drivers/infiniband/hw/irdma/i40iw_hw.h
+++ b/drivers/infiniband/hw/irdma/i40iw_hw.h
@@ -123,6 +123,8 @@
 #define I40E_CQPSQ_CQ_CQID GENMASK_ULL(15, 0)
 #define I40E_COMMIT_FPM_CQCNT_S 0
 #define I40E_COMMIT_FPM_CQCNT GENMASK_ULL(17, 0)
+#define I40E_CQPSQ_UPESD_HMCFNID_S 0
+#define I40E_CQPSQ_UPESD_HMCFNID GENMASK_ULL(5, 0)
 
 #define I40E_VSIQF_CTL(_VSI)             (0x0020D800 + ((_VSI) * 4))
 
diff --git a/drivers/infiniband/hw/irdma/icrdma_hw.c b/drivers/infiniband/hw/irdma/icrdma_hw.c
index 941d3edffadb..32f26284a788 100644
--- a/drivers/infiniband/hw/irdma/icrdma_hw.c
+++ b/drivers/infiniband/hw/irdma/icrdma_hw.c
@@ -38,6 +38,7 @@ static u64 icrdma_masks[IRDMA_MAX_MASKS] = {
 	ICRDMA_CQPSQ_CQ_CEQID,
 	ICRDMA_CQPSQ_CQ_CQID,
 	ICRDMA_COMMIT_FPM_CQCNT,
+	ICRDMA_CQPSQ_UPESD_HMCFNID,
 };
 
 static u64 icrdma_shifts[IRDMA_MAX_SHIFTS] = {
@@ -47,6 +48,7 @@ static u64 icrdma_shifts[IRDMA_MAX_SHIFTS] = {
 	ICRDMA_CQPSQ_CQ_CEQID_S,
 	ICRDMA_CQPSQ_CQ_CQID_S,
 	ICRDMA_COMMIT_FPM_CQCNT_S,
+	ICRDMA_CQPSQ_UPESD_HMCFNID_S,
 };
 
 /**
@@ -194,6 +196,7 @@ void icrdma_init_hw(struct irdma_sc_dev *dev)
 	dev->hw_attrs.max_hw_ord = ICRDMA_MAX_ORD_SIZE;
 	dev->hw_attrs.max_stat_inst = ICRDMA_MAX_STATS_COUNT;
 	dev->hw_attrs.max_stat_idx = IRDMA_HW_STAT_INDEX_MAX_GEN_2;
+	dev->hw_attrs.max_hw_device_pages = ICRDMA_MAX_PUSH_PAGE_COUNT;
 
 	dev->hw_attrs.uk_attrs.min_hw_wq_size = ICRDMA_MIN_WQ_SIZE;
 	dev->hw_attrs.uk_attrs.max_hw_sq_chunk = IRDMA_MAX_QUANTA_PER_WR;
diff --git a/drivers/infiniband/hw/irdma/icrdma_hw.h b/drivers/infiniband/hw/irdma/icrdma_hw.h
index 697b9572b5c6..d97944ab45da 100644
--- a/drivers/infiniband/hw/irdma/icrdma_hw.h
+++ b/drivers/infiniband/hw/irdma/icrdma_hw.h
@@ -58,14 +58,15 @@
 #define ICRDMA_CQPSQ_CQ_CQID GENMASK_ULL(18, 0)
 #define ICRDMA_COMMIT_FPM_CQCNT_S 0
 #define ICRDMA_COMMIT_FPM_CQCNT GENMASK_ULL(19, 0)
-
+#define ICRDMA_CQPSQ_UPESD_HMCFNID_S 0
+#define ICRDMA_CQPSQ_UPESD_HMCFNID GENMASK_ULL(5, 0)
 enum icrdma_device_caps_const {
 	ICRDMA_MAX_STATS_COUNT = 128,
 
 	ICRDMA_MAX_IRD_SIZE			= 127,
 	ICRDMA_MAX_ORD_SIZE			= 255,
 	ICRDMA_MIN_WQ_SIZE                      = 8 /* WQEs */,
-
+	ICRDMA_MAX_PUSH_PAGE_COUNT		= 256,
 };
 
 void icrdma_init_hw(struct irdma_sc_dev *dev);
diff --git a/drivers/infiniband/hw/irdma/ig3rdma_hw.c b/drivers/infiniband/hw/irdma/ig3rdma_hw.c
new file mode 100644
index 000000000000..83ef6af82a8f
--- /dev/null
+++ b/drivers/infiniband/hw/irdma/ig3rdma_hw.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+/* Copyright (c) 2018 - 2024 Intel Corporation */
+#include "osdep.h"
+#include "type.h"
+#include "protos.h"
+#include "ig3rdma_hw.h"
+
+void ig3rdma_init_hw(struct irdma_sc_dev *dev)
+{
+	dev->hw_attrs.uk_attrs.hw_rev = IRDMA_GEN_3;
+	dev->hw_attrs.uk_attrs.max_hw_wq_frags = IG3RDMA_MAX_WQ_FRAGMENT_COUNT;
+	dev->hw_attrs.uk_attrs.max_hw_read_sges = IG3RDMA_MAX_SGE_RD;
+	dev->hw_attrs.uk_attrs.max_hw_sq_chunk = IRDMA_MAX_QUANTA_PER_WR;
+	dev->hw_attrs.first_hw_vf_fpm_id = 0;
+	dev->hw_attrs.max_hw_vf_fpm_id = IG3_MAX_APFS + IG3_MAX_AVFS;
+	dev->hw_attrs.uk_attrs.feature_flags |= IRDMA_FEATURE_64_BYTE_CQE;
+	if (dev->feature_info[IRDMA_FTN_FLAGS] & IRDMA_ATOMICS_ALLOWED_BIT)
+		dev->hw_attrs.uk_attrs.feature_flags |=
+			IRDMA_FEATURE_ATOMIC_OPS;
+	dev->hw_attrs.uk_attrs.feature_flags |= IRDMA_FEATURE_CQE_TIMESTAMPING;
+
+	dev->hw_attrs.uk_attrs.feature_flags |= IRDMA_FEATURE_SRQ;
+	dev->hw_attrs.uk_attrs.feature_flags |= IRDMA_FEATURE_RTS_AE |
+						IRDMA_FEATURE_CQ_RESIZE;
+	dev->hw_attrs.page_size_cap = SZ_4K | SZ_2M | SZ_1G;
+	dev->hw_attrs.max_hw_ird = IG3RDMA_MAX_IRD_SIZE;
+	dev->hw_attrs.max_hw_ord = IG3RDMA_MAX_ORD_SIZE;
+	dev->hw_attrs.uk_attrs.min_hw_wq_size = IG3RDMA_MIN_WQ_SIZE;
+	dev->hw_attrs.uk_attrs.max_hw_srq_quanta = IRDMA_SRQ_MAX_QUANTA;
+	dev->hw_attrs.uk_attrs.max_hw_inline = IG3RDMA_MAX_INLINE_DATA_SIZE;
+	dev->hw_attrs.max_hw_device_pages =
+		dev->is_pf ? IG3RDMA_MAX_PF_PUSH_PAGE_COUNT : IG3RDMA_MAX_VF_PUSH_PAGE_COUNT;
+}
+
+static void __iomem *__ig3rdma_get_reg_addr(struct irdma_mmio_region *region, u64 reg_offset)
+{
+	if (reg_offset >= region->offset &&
+	    reg_offset < (region->offset + region->len)) {
+		reg_offset -= region->offset;
+
+		return region->addr + reg_offset;
+	}
+
+	return NULL;
+}
+
+void __iomem *ig3rdma_get_reg_addr(struct irdma_hw *hw, u64 reg_offset)
+{
+	u8 __iomem *reg_addr;
+	int i;
+
+	reg_addr = __ig3rdma_get_reg_addr(&hw->rdma_reg, reg_offset);
+	if (reg_addr)
+		return reg_addr;
+
+	for (i = 0; i < hw->num_io_regions; i++) {
+		reg_addr = __ig3rdma_get_reg_addr(&hw->io_regs[i], reg_offset);
+		if (reg_addr)
+			return reg_addr;
+	}
+
+	WARN_ON_ONCE(1);
+
+	return NULL;
+}
diff --git a/drivers/infiniband/hw/irdma/ig3rdma_hw.h b/drivers/infiniband/hw/irdma/ig3rdma_hw.h
index c0997c54e5e3..03d5f1188789 100644
--- a/drivers/infiniband/hw/irdma/ig3rdma_hw.h
+++ b/drivers/infiniband/hw/irdma/ig3rdma_hw.h
@@ -3,11 +3,29 @@
 #ifndef IG3RDMA_HW_H
 #define IG3RDMA_HW_H
 
+#define IG3_MAX_APFS 1
+#define IG3_MAX_AVFS 0
+
 #define IG3_PF_RDMA_REGION_OFFSET 0xBC00000
 #define IG3_PF_RDMA_REGION_LEN 0x401000
 #define IG3_VF_RDMA_REGION_OFFSET 0x8C00
 #define IG3_VF_RDMA_REGION_LEN 0x8400
 
+enum ig3rdma_device_caps_const {
+	IG3RDMA_MAX_WQ_FRAGMENT_COUNT		= 14,
+	IG3RDMA_MAX_SGE_RD			= 14,
+
+	IG3RDMA_MAX_STATS_COUNT			= 128,
+
+	IG3RDMA_MAX_IRD_SIZE			= 64,
+	IG3RDMA_MAX_ORD_SIZE			= 64,
+	IG3RDMA_MIN_WQ_SIZE			= 16 /* WQEs */,
+	IG3RDMA_MAX_INLINE_DATA_SIZE		= 216,
+	IG3RDMA_MAX_PF_PUSH_PAGE_COUNT		= 8192,
+	IG3RDMA_MAX_VF_PUSH_PAGE_COUNT		= 16,
+};
+
+void __iomem *ig3rdma_get_reg_addr(struct irdma_hw *hw, u64 reg_offset);
 int ig3rdma_vchnl_send_sync(struct irdma_sc_dev *dev, u8 *msg, u16 len,
 			    u8 *recv_msg, u16 *recv_len);
 
diff --git a/drivers/infiniband/hw/irdma/irdma.h b/drivers/infiniband/hw/irdma/irdma.h
index df7f6124570c..7e3214904488 100644
--- a/drivers/infiniband/hw/irdma/irdma.h
+++ b/drivers/infiniband/hw/irdma/irdma.h
@@ -67,6 +67,7 @@ enum irdma_shifts {
 	IRDMA_CQPSQ_CQ_CEQID_S,
 	IRDMA_CQPSQ_CQ_CQID_S,
 	IRDMA_COMMIT_FPM_CQCNT_S,
+	IRDMA_CQPSQ_UPESD_HMCFNID_S,
 	IRDMA_MAX_SHIFTS,
 };
 
@@ -77,6 +78,7 @@ enum irdma_masks {
 	IRDMA_CQPSQ_CQ_CEQID_M,
 	IRDMA_CQPSQ_CQ_CQID_M,
 	IRDMA_COMMIT_FPM_CQCNT_M,
+	IRDMA_CQPSQ_UPESD_HMCFNID_M,
 	IRDMA_MAX_MASKS, /* Must be last entry */
 };
 
@@ -121,6 +123,7 @@ struct irdma_uk_attrs {
 	u32 max_hw_wq_quanta;
 	u32 min_hw_cq_size;
 	u32 max_hw_cq_size;
+	u32 max_hw_srq_quanta;
 	u16 max_hw_sq_chunk;
 	u16 min_hw_wq_size;
 	u8 hw_rev;
@@ -156,4 +159,6 @@ struct irdma_hw_attrs {
 
 void i40iw_init_hw(struct irdma_sc_dev *dev);
 void icrdma_init_hw(struct irdma_sc_dev *dev);
+void ig3rdma_init_hw(struct irdma_sc_dev *dev);
+void __iomem *ig3rdma_get_reg_addr(struct irdma_hw *hw, u64 reg_offset);
 #endif /* IRDMA_H*/
diff --git a/drivers/infiniband/hw/irdma/virtchnl.c b/drivers/infiniband/hw/irdma/virtchnl.c
index 5beaecd7dbb5..ea071ffc0204 100644
--- a/drivers/infiniband/hw/irdma/virtchnl.c
+++ b/drivers/infiniband/hw/irdma/virtchnl.c
@@ -11,6 +11,51 @@
 #include "i40iw_hw.h"
 #include "ig3rdma_hw.h"
 
+struct vchnl_reg_map_elem {
+	u16 reg_id;
+	u16 reg_idx;
+	bool pg_rel;
+};
+
+struct vchnl_regfld_map_elem {
+	u16 regfld_id;
+	u16 regfld_idx;
+};
+
+static struct vchnl_reg_map_elem vchnl_reg_map[] = {
+	{IRDMA_VCHNL_REG_ID_CQPTAIL, IRDMA_CQPTAIL, false},
+	{IRDMA_VCHNL_REG_ID_CQPDB, IRDMA_CQPDB, false},
+	{IRDMA_VCHNL_REG_ID_CCQPSTATUS, IRDMA_CCQPSTATUS, false},
+	{IRDMA_VCHNL_REG_ID_CCQPHIGH, IRDMA_CCQPHIGH, false},
+	{IRDMA_VCHNL_REG_ID_CCQPLOW, IRDMA_CCQPLOW, false},
+	{IRDMA_VCHNL_REG_ID_CQARM, IRDMA_CQARM, false},
+	{IRDMA_VCHNL_REG_ID_CQACK, IRDMA_CQACK, false},
+	{IRDMA_VCHNL_REG_ID_AEQALLOC, IRDMA_AEQALLOC, false},
+	{IRDMA_VCHNL_REG_ID_CQPERRCODES, IRDMA_CQPERRCODES, false},
+	{IRDMA_VCHNL_REG_ID_WQEALLOC, IRDMA_WQEALLOC, false},
+	{IRDMA_VCHNL_REG_ID_DB_ADDR_OFFSET, IRDMA_DB_ADDR_OFFSET, false },
+	{IRDMA_VCHNL_REG_ID_DYN_CTL, IRDMA_GLINT_DYN_CTL, false },
+	{IRDMA_VCHNL_REG_INV_ID, IRDMA_VCHNL_REG_INV_ID, false }
+};
+
+static struct vchnl_regfld_map_elem vchnl_regfld_map[] = {
+	{IRDMA_VCHNL_REGFLD_ID_CCQPSTATUS_CQP_OP_ERR, IRDMA_CCQPSTATUS_CCQP_ERR_M},
+	{IRDMA_VCHNL_REGFLD_ID_CCQPSTATUS_CCQP_DONE, IRDMA_CCQPSTATUS_CCQP_DONE_M},
+	{IRDMA_VCHNL_REGFLD_ID_CQPSQ_STAG_PDID, IRDMA_CQPSQ_STAG_PDID_M},
+	{IRDMA_VCHNL_REGFLD_ID_CQPSQ_CQ_CEQID, IRDMA_CQPSQ_CQ_CEQID_M},
+	{IRDMA_VCHNL_REGFLD_ID_CQPSQ_CQ_CQID, IRDMA_CQPSQ_CQ_CQID_M},
+	{IRDMA_VCHNL_REGFLD_ID_COMMIT_FPM_CQCNT, IRDMA_COMMIT_FPM_CQCNT_M},
+	{IRDMA_VCHNL_REGFLD_ID_UPESD_HMCN_ID, IRDMA_CQPSQ_UPESD_HMCFNID_M},
+	{IRDMA_VCHNL_REGFLD_INV_ID, IRDMA_VCHNL_REGFLD_INV_ID}
+};
+
+#define IRDMA_VCHNL_REG_COUNT ARRAY_SIZE(vchnl_reg_map)
+#define IRDMA_VCHNL_REGFLD_COUNT ARRAY_SIZE(vchnl_regfld_map)
+#define IRDMA_VCHNL_REGFLD_BUF_SIZE \
+	(IRDMA_VCHNL_REG_COUNT * sizeof(struct irdma_vchnl_reg_info) + \
+	 IRDMA_VCHNL_REGFLD_COUNT * sizeof(struct irdma_vchnl_reg_field_info))
+#define IRDMA_REGMAP_RESP_BUF_SIZE (IRDMA_VCHNL_RESP_MIN_SIZE + IRDMA_VCHNL_REGFLD_BUF_SIZE)
+
 /**
  * irdma_sc_vchnl_init - Initialize dev virtchannel and get hw_rev
  * @dev: dev structure to update
@@ -64,6 +109,8 @@ static int irdma_vchnl_req_verify_resp(struct irdma_vchnl_req *vchnl_req,
 		if (resp_len < IRDMA_VCHNL_OP_GET_RDMA_CAPS_MIN_SIZE)
 			return -EBADMSG;
 		break;
+	case IRDMA_VCHNL_OP_GET_REG_LAYOUT:
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -137,6 +184,137 @@ static int irdma_vchnl_req_send_sync(struct irdma_sc_dev *dev,
 	return ret;
 }
 
+/**
+ * irdma_vchnl_req_get_reg_layout - Get Register Layout
+ * @dev: RDMA device pointer
+ */
+int irdma_vchnl_req_get_reg_layout(struct irdma_sc_dev *dev)
+{
+	u16 reg_idx, reg_id, tmp_reg_id, regfld_idx, regfld_id, tmp_regfld_id;
+	struct irdma_vchnl_reg_field_info *regfld_array = NULL;
+	u8 resp_buffer[IRDMA_REGMAP_RESP_BUF_SIZE] = {};
+	struct vchnl_regfld_map_elem *regfld_map_array;
+	struct irdma_vchnl_req_init_info info = {};
+	struct vchnl_reg_map_elem *reg_map_array;
+	struct irdma_vchnl_reg_info *reg_array;
+	u8 num_bits, shift_cnt;
+	u16 buf_len = 0;
+	u64 bitmask;
+	u32 rindex;
+	int ret;
+
+	if (!dev->vchnl_up)
+		return -EBUSY;
+
+	info.op_code = IRDMA_VCHNL_OP_GET_REG_LAYOUT;
+	info.op_ver = IRDMA_VCHNL_OP_GET_REG_LAYOUT_V0;
+	info.resp_parm = resp_buffer;
+	info.resp_parm_len = sizeof(resp_buffer);
+
+	ret = irdma_vchnl_req_send_sync(dev, &info);
+
+	if (ret)
+		return ret;
+
+	/* parse the response buffer and update reg info*/
+	/* Parse registers till invalid */
+	/* Parse register fields till invalid */
+	reg_array = (struct irdma_vchnl_reg_info *)resp_buffer;
+	for (rindex = 0; rindex < IRDMA_VCHNL_REG_COUNT; rindex++) {
+		buf_len += sizeof(struct irdma_vchnl_reg_info);
+		if (buf_len >= sizeof(resp_buffer))
+			return -ENOMEM;
+
+		regfld_array =
+			(struct irdma_vchnl_reg_field_info *)&reg_array[rindex + 1];
+		reg_id = reg_array[rindex].reg_id;
+		if (reg_id == IRDMA_VCHNL_REG_INV_ID)
+			break;
+
+		reg_id &= ~IRDMA_VCHNL_REG_PAGE_REL;
+		if (reg_id >= IRDMA_VCHNL_REG_COUNT)
+			return -EINVAL;
+
+		/* search regmap for register index in hw_regs.*/
+		reg_map_array = vchnl_reg_map;
+		do {
+			tmp_reg_id = reg_map_array->reg_id;
+			if (tmp_reg_id == reg_id)
+				break;
+
+			reg_map_array++;
+		} while (tmp_reg_id != IRDMA_VCHNL_REG_INV_ID);
+		if (tmp_reg_id != reg_id)
+			continue;
+
+		reg_idx = reg_map_array->reg_idx;
+
+		/* Page relative, DB Offset do not need bar offset */
+		if (reg_idx == IRDMA_DB_ADDR_OFFSET ||
+		    (reg_array[rindex].reg_id & IRDMA_VCHNL_REG_PAGE_REL)) {
+			dev->hw_regs[reg_idx] =
+				(u32 __iomem *)(uintptr_t)reg_array[rindex].reg_offset;
+			continue;
+		}
+
+		/* Update the local HW struct */
+		dev->hw_regs[reg_idx] = ig3rdma_get_reg_addr(dev->hw,
+						reg_array[rindex].reg_offset);
+		if (!dev->hw_regs[reg_idx])
+			return -EINVAL;
+	}
+
+	if (!regfld_array)
+		return -ENOMEM;
+
+	/* set up doorbell variables using mapped DB page */
+	dev->wqe_alloc_db = dev->hw_regs[IRDMA_WQEALLOC];
+	dev->cq_arm_db = dev->hw_regs[IRDMA_CQARM];
+	dev->aeq_alloc_db = dev->hw_regs[IRDMA_AEQALLOC];
+	dev->cqp_db = dev->hw_regs[IRDMA_CQPDB];
+	dev->cq_ack_db = dev->hw_regs[IRDMA_CQACK];
+
+	for (rindex = 0; rindex < IRDMA_VCHNL_REGFLD_COUNT; rindex++) {
+		buf_len += sizeof(struct irdma_vchnl_reg_field_info);
+		if ((buf_len - 1) > sizeof(resp_buffer))
+			break;
+
+		if (regfld_array[rindex].fld_id == IRDMA_VCHNL_REGFLD_INV_ID)
+			break;
+
+		regfld_id = regfld_array[rindex].fld_id;
+		regfld_map_array = vchnl_regfld_map;
+		do {
+			tmp_regfld_id = regfld_map_array->regfld_id;
+			if (tmp_regfld_id == regfld_id)
+				break;
+
+			regfld_map_array++;
+		} while (tmp_regfld_id != IRDMA_VCHNL_REGFLD_INV_ID);
+
+		if (tmp_regfld_id != regfld_id)
+			continue;
+
+		regfld_idx = regfld_map_array->regfld_idx;
+
+		num_bits = regfld_array[rindex].fld_bits;
+		shift_cnt = regfld_array[rindex].fld_shift;
+		if ((num_bits + shift_cnt > 64) || !num_bits) {
+			ibdev_dbg(to_ibdev(dev),
+				  "ERR: Invalid field mask id %d bits %d shift %d",
+				  regfld_id, num_bits, shift_cnt);
+
+			continue;
+		}
+
+		bitmask = (1ULL << num_bits) - 1;
+		dev->hw_masks[regfld_idx] = bitmask << shift_cnt;
+		dev->hw_shifts[regfld_idx] = shift_cnt;
+	}
+
+	return 0;
+}
+
 /**
  * irdma_vchnl_req_get_ver - Request Channel version
  * @dev: RDMA device pointer
diff --git a/drivers/infiniband/hw/irdma/virtchnl.h b/drivers/infiniband/hw/irdma/virtchnl.h
index d1e64666208d..ba551dc70d19 100644
--- a/drivers/infiniband/hw/irdma/virtchnl.h
+++ b/drivers/infiniband/hw/irdma/virtchnl.h
@@ -14,13 +14,44 @@
 #define IRDMA_VCHNL_OP_GET_HMC_FCN_V1 1
 #define IRDMA_VCHNL_OP_GET_HMC_FCN_V2 2
 #define IRDMA_VCHNL_OP_PUT_HMC_FCN_V0 0
+#define IRDMA_VCHNL_OP_GET_REG_LAYOUT_V0 0
 #define IRDMA_VCHNL_OP_GET_RDMA_CAPS_V0 0
 #define IRDMA_VCHNL_OP_GET_RDMA_CAPS_MIN_SIZE 1
 
+#define IRDMA_VCHNL_REG_ID_CQPTAIL 0
+#define IRDMA_VCHNL_REG_ID_CQPDB 1
+#define IRDMA_VCHNL_REG_ID_CCQPSTATUS 2
+#define IRDMA_VCHNL_REG_ID_CCQPHIGH 3
+#define IRDMA_VCHNL_REG_ID_CCQPLOW 4
+#define IRDMA_VCHNL_REG_ID_CQARM 5
+#define IRDMA_VCHNL_REG_ID_CQACK 6
+#define IRDMA_VCHNL_REG_ID_AEQALLOC 7
+#define IRDMA_VCHNL_REG_ID_CQPERRCODES 8
+#define IRDMA_VCHNL_REG_ID_WQEALLOC 9
+#define IRDMA_VCHNL_REG_ID_IPCONFIG0 10
+#define IRDMA_VCHNL_REG_ID_DB_ADDR_OFFSET 11
+#define IRDMA_VCHNL_REG_ID_DYN_CTL 12
+#define IRDMA_VCHNL_REG_ID_AEQITRMASK 13
+#define IRDMA_VCHNL_REG_ID_CEQITRMASK 14
+#define IRDMA_VCHNL_REG_INV_ID 0xFFFF
+#define IRDMA_VCHNL_REG_PAGE_REL 0x8000
+
+#define IRDMA_VCHNL_REGFLD_ID_CCQPSTATUS_CQP_OP_ERR 2
+#define IRDMA_VCHNL_REGFLD_ID_CCQPSTATUS_CCQP_DONE 5
+#define IRDMA_VCHNL_REGFLD_ID_CQPSQ_STAG_PDID 6
+#define IRDMA_VCHNL_REGFLD_ID_CQPSQ_CQ_CEQID 7
+#define IRDMA_VCHNL_REGFLD_ID_CQPSQ_CQ_CQID 8
+#define IRDMA_VCHNL_REGFLD_ID_COMMIT_FPM_CQCNT 9
+#define IRDMA_VCHNL_REGFLD_ID_UPESD_HMCN_ID 10
+#define IRDMA_VCHNL_REGFLD_INV_ID 0xFFFF
+
+#define IRDMA_VCHNL_RESP_MIN_SIZE (sizeof(struct irdma_vchnl_resp_buf))
+
 enum irdma_vchnl_ops {
 	IRDMA_VCHNL_OP_GET_VER = 0,
 	IRDMA_VCHNL_OP_GET_HMC_FCN = 1,
 	IRDMA_VCHNL_OP_PUT_HMC_FCN = 2,
+	IRDMA_VCHNL_OP_GET_REG_LAYOUT = 11,
 	IRDMA_VCHNL_OP_GET_RDMA_CAPS = 13,
 };
 
@@ -65,6 +96,18 @@ struct irdma_vchnl_init_info {
 	bool is_pf;
 };
 
+struct irdma_vchnl_reg_info {
+	u32 reg_offset;
+	u16 field_cnt;
+	u16 reg_id; /* High bit of reg_id: bar or page relative */
+};
+
+struct irdma_vchnl_reg_field_info {
+	u8 fld_shift;
+	u8 fld_bits;
+	u16 fld_id;
+};
+
 struct irdma_vchnl_req {
 	struct irdma_vchnl_op_buf *vchnl_msg;
 	void *parm;
@@ -91,4 +134,5 @@ int irdma_vchnl_req_put_hmc_fcn(struct irdma_sc_dev *dev);
 int irdma_vchnl_req_get_caps(struct irdma_sc_dev *dev);
 int irdma_vchnl_req_get_resp(struct irdma_sc_dev *dev,
 			     struct irdma_vchnl_req *vc_req);
+int irdma_vchnl_req_get_reg_layout(struct irdma_sc_dev *dev);
 #endif /* IRDMA_VIRTCHNL_H */
-- 
2.42.0


