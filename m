Return-Path: <linux-rdma+bounces-3961-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C28A93B987
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 01:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396661C218E7
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E65143888;
	Wed, 24 Jul 2024 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nkf5gHR3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AA1448D8
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864446; cv=none; b=rKRfNic0g5znxXiOwq23YlJutccI3ZdeKddBZhjYkzEIqDHNVQ9VKBr2IMNYfi6UGeWQeS9BQo9WjF/G2ZNfKkIXYvnm0CzmZDkCpTErQY/goKkRyrbIN2OeYaNPDdxQbibxjDekL+4WB3nR/0WKF7EELXxRge+3G6vkXJEf8QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864446; c=relaxed/simple;
	bh=q00fszpD2Qyk3oAdePGLjSF2xntq88+vGVo40ifKgi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPjhztp2saDnZdVLFl6NZUYIKD2f7JuBgzvl6vqT+0rmnLAgLF1ewd8r1w/QgZNztWNox3+OxH96KG4HUuHM3T+k30VbvuHmCwmjIC1FvwxYuztMYbU1r8TSKj+TPvRGMzxSG6thoDj8YYf6rxdO9mwwtL1FKQLW+zQqw1vYWjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nkf5gHR3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864443; x=1753400443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q00fszpD2Qyk3oAdePGLjSF2xntq88+vGVo40ifKgi4=;
  b=Nkf5gHR3vk9d7MNPbY1zMzrEYZ9bpeTG7ZcZ47Q2I17h9FlkcPZ3qbdb
   jqkClXb2fUQti94ZdiqUBpIJ50z9ytASVgYKpsLPgwNEQsxXPlr8PbM6R
   8os7rhEVMJDU5BMQ+GMTFuVwvOqS/uK3kjh8h6688oRq6xUEIKVqiC6wf
   DX6QvtuSYCNLz/CXhqLf4GCIb1GLMumiXgOZjCvpmS0U8RN5h9cD2GWJ6
   OZTxNectUcLtOC/jDZA+rajCYDhbwiPaRY4esPJBwVp7e7wVVzoC2JS5n
   rYYTHlniqWBu6UacdYscGG6wKVJlhhhrA3RXxrW+9rYIcrer28M6rrq3p
   A==;
X-CSE-ConnectionGUID: OjNA+TZST5Gv6bs5SgHQjw==
X-CSE-MsgGUID: WKLrwsFSRueC5W8AlDKDOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44999766"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="44999766"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:41 -0700
X-CSE-ConnectionGUID: 9KnClcBSRkK2iDwTy+ocFQ==
X-CSE-MsgGUID: tylJq2wQQBuASyk93AY5cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52426043"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.96.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:40 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	mustafa.ismail@intel.com,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC PATCH 11/25] RDMA/irdma: Add GEN3 core driver support
Date: Wed, 24 Jul 2024 18:39:03 -0500
Message-Id: <20240724233917.704-12-tatyana.e.nikolova@intel.com>
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

From: Mustafa Ismail <mustafa.ismail@intel.com>

Introduce support for the GEN3 auxiliary core driver, which is responsible
for initializing PCI-level RDMA resources.

Facilitate host-driver communication with the device's Control Plane (CP)
to discover capabilities and perform privileged operations through an RDMA-
specific messaging interface built atop the IDPF mailbox and virtchannel
protocol.

Establish the RDMA virtual channel message interface and incorporate
operations to retrieve the hardware version and discover capabilities from
the CP.

Additionally, set up the RDMA MMIO regions and initialize the RF structure.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/Makefile     |   2 +
 drivers/infiniband/hw/irdma/ctrl.c       | 438 +++++++++++++++++++++++++++----
 drivers/infiniband/hw/irdma/defs.h       |  30 ++-
 drivers/infiniband/hw/irdma/hmc.c        |  18 +-
 drivers/infiniband/hw/irdma/hmc.h        |  19 +-
 drivers/infiniband/hw/irdma/hw.c         |   4 +
 drivers/infiniband/hw/irdma/i40iw_if.c   |   1 +
 drivers/infiniband/hw/irdma/icrdma_if.c  |   2 +
 drivers/infiniband/hw/irdma/ig3rdma_hw.h |  11 +
 drivers/infiniband/hw/irdma/ig3rdma_if.c | 171 ++++++++++++
 drivers/infiniband/hw/irdma/irdma.h      |   3 +
 drivers/infiniband/hw/irdma/main.c       |  55 ++++
 drivers/infiniband/hw/irdma/main.h       |   4 +
 drivers/infiniband/hw/irdma/pble.c       |  20 +-
 drivers/infiniband/hw/irdma/type.h       |  63 ++++-
 drivers/infiniband/hw/irdma/user.h       |   4 +-
 drivers/infiniband/hw/irdma/virtchnl.c   | 300 +++++++++++++++++++++
 drivers/infiniband/hw/irdma/virtchnl.h   |  96 +++++++
 18 files changed, 1166 insertions(+), 75 deletions(-)
 create mode 100644 drivers/infiniband/hw/irdma/ig3rdma_hw.h
 create mode 100644 drivers/infiniband/hw/irdma/ig3rdma_if.c
 create mode 100644 drivers/infiniband/hw/irdma/virtchnl.c
 create mode 100644 drivers/infiniband/hw/irdma/virtchnl.h

diff --git a/drivers/infiniband/hw/irdma/Makefile b/drivers/infiniband/hw/irdma/Makefile
index 2522e4c..3aa63b9 100644
--- a/drivers/infiniband/hw/irdma/Makefile
+++ b/drivers/infiniband/hw/irdma/Makefile
@@ -13,6 +13,7 @@ irdma-objs := cm.o        \
               hw.o        \
               i40iw_hw.o  \
               i40iw_if.o  \
+	      ig3rdma_if.o\
 	      icrdma_if.o \
               icrdma_hw.o \
               main.o      \
@@ -23,6 +24,7 @@ irdma-objs := cm.o        \
               uk.o        \
               utils.o     \
               verbs.o     \
+	      virtchnl.o  \
               ws.o        \
 
 CFLAGS_trace.o = -I$(src)
diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 6aed616..9d7b151 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -2794,7 +2794,10 @@ static u64 irdma_sc_decode_fpm_commit(struct irdma_sc_dev *dev, __le64 *buf,
 		obj_info[rsrc_idx].cnt = (u32)FLD_RS_64(dev, temp, IRDMA_COMMIT_FPM_CQCNT);
 		break;
 	case IRDMA_HMC_IW_APBVT_ENTRY:
-		obj_info[rsrc_idx].cnt = 1;
+		if (dev->hw_attrs.uk_attrs.hw_rev <= IRDMA_GEN_2)
+			obj_info[rsrc_idx].cnt = 1;
+		else
+			obj_info[rsrc_idx].cnt = 0;
 		break;
 	default:
 		obj_info[rsrc_idx].cnt = (u32)temp;
@@ -2829,7 +2832,8 @@ static u64 irdma_sc_decode_fpm_commit(struct irdma_sc_dev *dev, __le64 *buf,
 				   IRDMA_HMC_IW_QP);
 	irdma_sc_decode_fpm_commit(dev, buf, 8, info,
 				   IRDMA_HMC_IW_CQ);
-	/* skiping RSRVD */
+	irdma_sc_decode_fpm_commit(dev, buf, 16, info,
+				   IRDMA_HMC_IW_SRQ);
 	irdma_sc_decode_fpm_commit(dev, buf, 24, info,
 				   IRDMA_HMC_IW_HTE);
 	irdma_sc_decode_fpm_commit(dev, buf, 32, info,
@@ -2864,15 +2868,17 @@ static u64 irdma_sc_decode_fpm_commit(struct irdma_sc_dev *dev, __le64 *buf,
 					   IRDMA_HMC_IW_HDR);
 		irdma_sc_decode_fpm_commit(dev, buf, 152, info,
 					   IRDMA_HMC_IW_MD);
-		irdma_sc_decode_fpm_commit(dev, buf, 160, info,
-					   IRDMA_HMC_IW_OOISC);
-		irdma_sc_decode_fpm_commit(dev, buf, 168, info,
-					   IRDMA_HMC_IW_OOISCFFL);
+		if (dev->cqp->protocol_used == IRDMA_IWARP_PROTOCOL_ONLY) {
+			irdma_sc_decode_fpm_commit(dev, buf, 160, info,
+						   IRDMA_HMC_IW_OOISC);
+			irdma_sc_decode_fpm_commit(dev, buf, 168, info,
+						   IRDMA_HMC_IW_OOISCFFL);
+		}
 	}
 
 	/* searching for the last object in HMC to find the size of the HMC area. */
 	for (i = IRDMA_HMC_IW_QP; i < IRDMA_HMC_IW_MAX; i++) {
-		if (info[i].base > max_base) {
+		if (info[i].base > max_base && info[i].cnt) {
 			max_base = info[i].base;
 			last_hmc_obj = i;
 		}
@@ -2937,6 +2943,14 @@ static int irdma_sc_parse_fpm_query_buf(struct irdma_sc_dev *dev, __le64 *buf,
 	hmc_info->first_sd_index = (u16)FIELD_GET(IRDMA_QUERY_FPM_FIRST_PE_SD_INDEX, temp);
 	max_pe_sds = (u16)FIELD_GET(IRDMA_QUERY_FPM_MAX_PE_SDS, temp);
 
+	/* Reduce SD count for unprivleged functions by 1 to account for PBLE
+	 * backing page rounding
+	 */
+	if (dev->hw_attrs.uk_attrs.hw_rev <= IRDMA_GEN_2 &&
+	    (hmc_info->hmc_fn_id >= dev->hw_attrs.first_hw_vf_fpm_id ||
+	    !dev->privileged))
+		max_pe_sds--;
+
 	hmc_fpm_misc->max_sds = max_pe_sds;
 	hmc_info->sd_table.sd_cnt = max_pe_sds + hmc_info->first_sd_index;
 	get_64bit_val(buf, 8, &temp);
@@ -2949,11 +2963,17 @@ static int irdma_sc_parse_fpm_query_buf(struct irdma_sc_dev *dev, __le64 *buf,
 	size = (u32)(temp >> 32);
 	obj_info[IRDMA_HMC_IW_CQ].size = BIT_ULL(size);
 
+	irdma_sc_decode_fpm_query(buf, 24, obj_info, IRDMA_HMC_IW_SRQ);
 	irdma_sc_decode_fpm_query(buf, 32, obj_info, IRDMA_HMC_IW_HTE);
 	irdma_sc_decode_fpm_query(buf, 40, obj_info, IRDMA_HMC_IW_ARP);
 
-	obj_info[IRDMA_HMC_IW_APBVT_ENTRY].size = 8192;
-	obj_info[IRDMA_HMC_IW_APBVT_ENTRY].max_cnt = 1;
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3) {
+		obj_info[IRDMA_HMC_IW_APBVT_ENTRY].size = 0;
+		obj_info[IRDMA_HMC_IW_APBVT_ENTRY].max_cnt = 0;
+	} else {
+		obj_info[IRDMA_HMC_IW_APBVT_ENTRY].size = 8192;
+		obj_info[IRDMA_HMC_IW_APBVT_ENTRY].max_cnt = 1;
+	}
 
 	irdma_sc_decode_fpm_query(buf, 48, obj_info, IRDMA_HMC_IW_MR);
 	irdma_sc_decode_fpm_query(buf, 56, obj_info, IRDMA_HMC_IW_XF);
@@ -2962,7 +2982,7 @@ static int irdma_sc_parse_fpm_query_buf(struct irdma_sc_dev *dev, __le64 *buf,
 	obj_info[IRDMA_HMC_IW_XFFL].max_cnt = (u32)temp;
 	obj_info[IRDMA_HMC_IW_XFFL].size = 4;
 	hmc_fpm_misc->xf_block_size = FIELD_GET(IRDMA_QUERY_FPM_XFBLOCKSIZE, temp);
-	if (!hmc_fpm_misc->xf_block_size)
+	if (obj_info[IRDMA_HMC_IW_XF].max_cnt && !hmc_fpm_misc->xf_block_size)
 		return -EINVAL;
 
 	irdma_sc_decode_fpm_query(buf, 72, obj_info, IRDMA_HMC_IW_Q1);
@@ -2998,17 +3018,30 @@ static int irdma_sc_parse_fpm_query_buf(struct irdma_sc_dev *dev, __le64 *buf,
 	    obj_info[IRDMA_HMC_IW_RRFFL].max_cnt)
 		return -EINVAL;
 
+	if (!obj_info[IRDMA_HMC_IW_XF].max_cnt)
+		obj_info[IRDMA_HMC_IW_RRF].max_cnt = IRDMA_HMC_MIN_RRF;
+
 	irdma_sc_decode_fpm_query(buf, 144, obj_info, IRDMA_HMC_IW_HDR);
 	irdma_sc_decode_fpm_query(buf, 152, obj_info, IRDMA_HMC_IW_MD);
-	irdma_sc_decode_fpm_query(buf, 160, obj_info, IRDMA_HMC_IW_OOISC);
-
-	get_64bit_val(buf, 168, &temp);
-	obj_info[IRDMA_HMC_IW_OOISCFFL].max_cnt = (u32)temp;
-	obj_info[IRDMA_HMC_IW_OOISCFFL].size = 4;
-	hmc_fpm_misc->ooiscf_block_size = FIELD_GET(IRDMA_QUERY_FPM_OOISCFBLOCKSIZE, temp);
-	if (!hmc_fpm_misc->ooiscf_block_size &&
-	    obj_info[IRDMA_HMC_IW_OOISCFFL].max_cnt)
-		return -EINVAL;
+
+	if (dev->cqp->protocol_used == IRDMA_IWARP_PROTOCOL_ONLY) {
+		irdma_sc_decode_fpm_query(buf, 160, obj_info, IRDMA_HMC_IW_OOISC);
+
+		get_64bit_val(buf, 168, &temp);
+		obj_info[IRDMA_HMC_IW_OOISCFFL].max_cnt = (u32)temp;
+		obj_info[IRDMA_HMC_IW_OOISCFFL].size = 4;
+		hmc_fpm_misc->ooiscf_block_size = FIELD_GET(IRDMA_QUERY_FPM_OOISCFBLOCKSIZE, temp);
+		if (!hmc_fpm_misc->ooiscf_block_size &&
+		    obj_info[IRDMA_HMC_IW_OOISCFFL].max_cnt)
+			return -EINVAL;
+	}
+
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3) {
+		get_64bit_val(buf, 176, &temp);
+		hmc_fpm_misc->loc_mem_pages = (u32)FIELD_GET(IRDMA_QUERY_FPM_LOC_MEM_PAGES, temp);
+		if (!hmc_fpm_misc->loc_mem_pages)
+			return -EINVAL;
+	}
 
 	return 0;
 }
@@ -4336,6 +4369,26 @@ int irdma_sc_init_iw_hmc(struct irdma_sc_dev *dev, u8 hmc_fn_id)
 }
 
 /**
+ * irdma_set_loc_mem() - set a local memory bit field
+ * @buf: ptr to a buffer where local memory gets enabled
+ */
+static void irdma_set_loc_mem(__le64 *buf)
+{
+	u64 loc_mem_en = BIT_ULL(ENABLE_LOC_MEM);
+	u32 offset;
+	u64 temp;
+
+	for (offset = 0; offset < IRDMA_COMMIT_FPM_BUF_SIZE;
+	     offset += sizeof(__le64)) {
+		if (offset == IRDMA_PBLE_COMMIT_OFFSET)
+			continue;
+		get_64bit_val(buf, offset, &temp);
+		if (temp)
+			set_64bit_val(buf, offset, temp | loc_mem_en);
+	}
+}
+
+/**
  * irdma_sc_cfg_iw_fpm() - commits hmc obj cnt values using cqp
  * command and populates fpm base address in hmc_info
  * @dev : ptr to irdma_dev struct
@@ -4356,7 +4409,7 @@ static int irdma_sc_cfg_iw_fpm(struct irdma_sc_dev *dev, u8 hmc_fn_id)
 
 	set_64bit_val(buf, 0, (u64)obj_info[IRDMA_HMC_IW_QP].cnt);
 	set_64bit_val(buf, 8, (u64)obj_info[IRDMA_HMC_IW_CQ].cnt);
-	set_64bit_val(buf, 16, (u64)0); /* RSRVD */
+	set_64bit_val(buf, 16, (u64)obj_info[IRDMA_HMC_IW_SRQ].cnt);
 	set_64bit_val(buf, 24, (u64)obj_info[IRDMA_HMC_IW_HTE].cnt);
 	set_64bit_val(buf, 32, (u64)obj_info[IRDMA_HMC_IW_ARP].cnt);
 	set_64bit_val(buf, 40, (u64)0); /* RSVD */
@@ -4383,7 +4436,9 @@ static int irdma_sc_cfg_iw_fpm(struct irdma_sc_dev *dev, u8 hmc_fn_id)
 		      (u64)obj_info[IRDMA_HMC_IW_OOISC].cnt);
 	set_64bit_val(buf, 168,
 		      (u64)obj_info[IRDMA_HMC_IW_OOISCFFL].cnt);
-
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3 &&
+	    dev->hmc_fpm_misc.loc_mem_pages)
+		irdma_set_loc_mem(buf);
 	commit_fpm_mem.pa = dev->fpm_commit_buf_pa;
 	commit_fpm_mem.va = dev->fpm_commit_buf;
 
@@ -4592,6 +4647,7 @@ static bool irdma_cqp_ring_full(struct irdma_sc_cqp *cqp)
 static u32 irdma_est_sd(struct irdma_sc_dev *dev,
 			struct irdma_hmc_info *hmc_info)
 {
+	struct irdma_hmc_obj_info *pble_info;
 	int i;
 	u64 size = 0;
 	u64 sd;
@@ -4600,12 +4656,22 @@ static u32 irdma_est_sd(struct irdma_sc_dev *dev,
 		if (i != IRDMA_HMC_IW_PBLE)
 			size += round_up(hmc_info->hmc_obj[i].cnt *
 					 hmc_info->hmc_obj[i].size, 512);
-	size += round_up(hmc_info->hmc_obj[IRDMA_HMC_IW_PBLE].cnt *
-			 hmc_info->hmc_obj[IRDMA_HMC_IW_PBLE].size, 512);
+
+	pble_info = &hmc_info->hmc_obj[IRDMA_HMC_IW_PBLE];
+	if (dev->privileged)
+		size += round_up(pble_info->cnt * pble_info->size, 512);
 	if (size & 0x1FFFFF)
 		sd = (size >> 21) + 1; /* add 1 for remainder */
 	else
 		sd = size >> 21;
+	if (!dev->privileged && !dev->hmc_fpm_misc.loc_mem_pages) {
+		/* 2MB alignment for VF PBLE HMC */
+		size = pble_info->cnt * pble_info->size;
+		if (size & 0x1FFFFF)
+			sd += (size >> 21) + 1; /* add 1 for remainder */
+		else
+			sd += size >> 21;
+	}
 	if (sd > 0xFFFFFFFF) {
 		ibdev_dbg(to_ibdev(dev), "HMC: sd overflow[%lld]\n", sd);
 		sd = 0xFFFFFFFF - 1;
@@ -4786,22 +4852,287 @@ static void cfg_fpm_value_gen_2(struct irdma_sc_dev *dev,
 }
 
 /**
+ * irdma_get_rsrc_mem_config - configure resources if local memory or host
+ * @dev: sc device struct
+ * @is_mrte_loc_mem: if true, MR's to be in local memory because sd=loc pages
+ *
+ * Only mr can be configured host or local memory if qp's are in local memory.
+ * If qp is in local memory, then all resource object will be in local memory
+ * except mr which can be either host or local memory.  The only exception
+ * is pble's which are always in host memory.
+ */
+static void irdma_get_rsrc_mem_config(struct irdma_sc_dev *dev, bool is_mrte_loc_mem)
+{
+	struct irdma_hmc_info *hmc_info = dev->hmc_info;
+	int i;
+
+	for (i = IRDMA_HMC_IW_QP; i < IRDMA_HMC_IW_MAX; i++)
+		hmc_info->hmc_obj[i].mem_loc = IRDMA_LOC_MEM;
+
+	if (dev->feature_info[IRDMA_OBJ_1] && !is_mrte_loc_mem) {
+		u8 mem_type;
+
+		mem_type = (u8)FIELD_GET(IRDMA_MR_MEM_LOC, dev->feature_info[IRDMA_OBJ_1]);
+
+		hmc_info->hmc_obj[IRDMA_HMC_IW_MR].mem_loc =
+			(mem_type & IRDMA_OBJ_LOC_MEM_BIT) ?
+			IRDMA_LOC_MEM : IRDMA_HOST_MEM;
+	} else {
+		hmc_info->hmc_obj[IRDMA_HMC_IW_MR].mem_loc = IRDMA_LOC_MEM;
+	}
+
+	hmc_info->hmc_obj[IRDMA_HMC_IW_PBLE].mem_loc = IRDMA_HOST_MEM;
+
+	ibdev_dbg(to_ibdev(dev), "HMC: INFO: mrte_mem_loc = %d pble = %d\n",
+		  hmc_info->hmc_obj[IRDMA_HMC_IW_MR].mem_loc,
+		  hmc_info->hmc_obj[IRDMA_HMC_IW_PBLE].mem_loc);
+}
+
+/**
+ * irdma_cfg_sd_mem - allocate sd memory
+ * @dev: sc device struct
+ * @hmc_info: ptr to irdma_hmc_obj_info struct
+ */
+static int irdma_cfg_sd_mem(struct irdma_sc_dev *dev,
+			    struct irdma_hmc_info *hmc_info)
+{
+	struct irdma_virt_mem virt_mem;
+	u32 mem_size;
+
+	mem_size = sizeof(struct irdma_hmc_sd_entry) * hmc_info->sd_table.sd_cnt;
+	virt_mem.size = mem_size;
+	virt_mem.va = kzalloc(virt_mem.size, GFP_KERNEL);
+	if (!virt_mem.va)
+		return -ENOMEM;
+	hmc_info->sd_table.sd_entry = virt_mem.va;
+
+	return 0;
+}
+
+/**
+ * irdma_get_objs_pages - get number of 2M pages needed
+ * @dev: sc device struct
+ * @hmc_info: pointer to the HMC configuration information struct
+ * @mem_loc: pages for local or host memory
+ */
+static u32 irdma_get_objs_pages(struct irdma_sc_dev *dev,
+				struct irdma_hmc_info *hmc_info,
+				enum irdma_hmc_obj_mem mem_loc)
+{
+	u64 size = 0;
+	int i;
+
+	for (i = IRDMA_HMC_IW_QP; i < IRDMA_HMC_IW_MAX; i++) {
+		if (hmc_info->hmc_obj[i].mem_loc == mem_loc) {
+			size += round_up(hmc_info->hmc_obj[i].cnt *
+					 hmc_info->hmc_obj[i].size, 512);
+		}
+	}
+
+	return DIV_ROUND_UP(size, IRDMA_HMC_PAGE_SIZE);
+}
+
+/**
+ * irdma_set_host_hmc_rsrc_gen_3 - calculate host hmc resources for gen 3
+ * @dev: sc device struct
+ */
+static void irdma_set_host_hmc_rsrc_gen_3(struct irdma_sc_dev *dev)
+{
+	struct irdma_hmc_fpm_misc *hmc_fpm_misc;
+	struct irdma_hmc_info *hmc_info;
+	enum irdma_hmc_obj_mem mrte_loc;
+	u32 mrwanted, pblewanted;
+	u32  avail_sds, mr_sds;
+
+	hmc_info = dev->hmc_info;
+	hmc_fpm_misc = &dev->hmc_fpm_misc;
+	avail_sds = hmc_fpm_misc->max_sds;
+	mrte_loc = hmc_info->hmc_obj[IRDMA_HMC_IW_MR].mem_loc;
+	mrwanted = hmc_info->hmc_obj[IRDMA_HMC_IW_MR].cnt;
+	pblewanted = hmc_info->hmc_obj[IRDMA_HMC_IW_PBLE].max_cnt;
+
+	if (mrte_loc == IRDMA_HOST_MEM && avail_sds > IRDMA_MIN_PBLE_PAGES) {
+		mr_sds = avail_sds - IRDMA_MIN_PBLE_PAGES;
+		mrwanted = min(mrwanted, mr_sds * MAX_MR_PER_SD);
+		hmc_info->hmc_obj[IRDMA_HMC_IW_MR].cnt = mrwanted;
+		avail_sds -= DIV_ROUND_UP(mrwanted, MAX_MR_PER_SD);
+	}
+
+	pblewanted = min(pblewanted, avail_sds * MAX_PBLE_PER_SD);
+	hmc_info->hmc_obj[IRDMA_HMC_IW_PBLE].cnt = pblewanted;
+}
+
+/**
+ * irdma_set_loc_hmc_rsrc_gen_3 - calculate hmc resources for gen 3
+ * @dev: sc device struct
+ * @max_pages: max local memory available
+ * @qpwanted: number of qp's wanted
+ */
+static int irdma_set_loc_hmc_rsrc_gen_3(struct irdma_sc_dev *dev,
+					u32 max_pages,
+					u32 qpwanted)
+{
+	struct irdma_hmc_fpm_misc *hmc_fpm_misc;
+	u32 xf_cnt, timer_cnt, pages_needed;
+	struct irdma_hmc_info *hmc_info;
+	u32 ird, ord, min_ird;
+
+	hmc_info = dev->hmc_info;
+	hmc_fpm_misc = &dev->hmc_fpm_misc;
+	ird = dev->hw_attrs.max_hw_ird;
+	ord = dev->hw_attrs.max_hw_ord;
+	min_ird = IRDMA_MIN_IRD;
+
+	hmc_info->hmc_obj[IRDMA_HMC_IW_HDR].cnt = qpwanted;
+	hmc_info->hmc_obj[IRDMA_HMC_IW_QP].cnt = qpwanted;
+
+	hmc_info->hmc_obj[IRDMA_HMC_IW_CQ].cnt =
+		min(hmc_info->hmc_obj[IRDMA_HMC_IW_CQ].cnt, qpwanted * 2);
+
+	hmc_info->hmc_obj[IRDMA_HMC_IW_FSIAV].cnt =
+		min(qpwanted * 8, hmc_info->hmc_obj[IRDMA_HMC_IW_FSIAV].max_cnt);
+
+	hmc_info->hmc_obj[IRDMA_HMC_IW_RRF].cnt =
+		min(hmc_info->hmc_obj[IRDMA_HMC_IW_RRF].max_cnt,
+		    IRDMA_RRF_MULTIPLIER * qpwanted);
+
+	if (hmc_info->hmc_obj[IRDMA_HMC_IW_RRFFL].max_cnt)
+		hmc_info->hmc_obj[IRDMA_HMC_IW_RRFFL].cnt =
+			hmc_info->hmc_obj[IRDMA_HMC_IW_RRF].cnt /
+			hmc_fpm_misc->rrf_block_size;
+
+	xf_cnt = IRDMA_XF_MULTIPLIER * qpwanted;
+	xf_cnt = min(hmc_info->hmc_obj[IRDMA_HMC_IW_XF].max_cnt, xf_cnt);
+	hmc_info->hmc_obj[IRDMA_HMC_IW_XF].cnt = xf_cnt;
+
+	if (xf_cnt)
+		hmc_info->hmc_obj[IRDMA_HMC_IW_XFFL].cnt =
+			xf_cnt / hmc_fpm_misc->xf_block_size;
+
+	timer_cnt = (round_up(qpwanted, 512) / 512 + 1) *
+		hmc_fpm_misc->timer_bucket;
+	hmc_info->hmc_obj[IRDMA_HMC_IW_TIMER].cnt =
+		min(timer_cnt, hmc_info->hmc_obj[IRDMA_HMC_IW_TIMER].cnt);
+
+	do {
+		hmc_info->hmc_obj[IRDMA_HMC_IW_Q1].cnt = ird * 2 * qpwanted;
+		hmc_info->hmc_obj[IRDMA_HMC_IW_Q1FL].cnt =
+			hmc_info->hmc_obj[IRDMA_HMC_IW_Q1].cnt / hmc_fpm_misc->q1_block_size;
+
+		pages_needed = irdma_get_objs_pages(dev, hmc_info, IRDMA_LOC_MEM);
+		if (pages_needed <= max_pages)
+			break;
+
+		ird /= 2;
+		ord /= 2;
+	} while (ird >= IRDMA_MIN_IRD);
+
+	if (ird < IRDMA_MIN_IRD) {
+		ibdev_dbg(to_ibdev(dev), "HMC: FAIL: IRD=%u Q1 CNT = %u\n",
+			  ird, hmc_info->hmc_obj[IRDMA_HMC_IW_Q1].cnt);
+		return -EINVAL;
+	}
+
+	dev->hw_attrs.max_hw_ird = ird;
+	dev->hw_attrs.max_hw_ord = ord;
+	hmc_fpm_misc->max_sds -= pages_needed;
+
+	return 0;
+}
+
+/**
+ * cfg_fpm_value_gen_3 - configure fpm for gen 3
+ * @dev: sc device struct
+ * @hmc_info: ptr to irdma_hmc_obj_info struct
+ * @hmc_fpm_misc: ptr to fpm data
+ */
+static int cfg_fpm_value_gen_3(struct irdma_sc_dev *dev,
+			       struct irdma_hmc_info *hmc_info,
+			       struct irdma_hmc_fpm_misc *hmc_fpm_misc)
+{
+	enum irdma_hmc_obj_mem mrte_loc;
+	u32 mrwanted,  qpwanted;
+	int i, ret_code = 0;
+	u32 loc_mem_pages;
+	bool is_mrte_loc_mem;
+
+	loc_mem_pages = hmc_fpm_misc->loc_mem_pages;
+	is_mrte_loc_mem = hmc_fpm_misc->loc_mem_pages == hmc_fpm_misc->max_sds ?
+			true : false;
+
+	irdma_get_rsrc_mem_config(dev, is_mrte_loc_mem);
+	mrte_loc = hmc_info->hmc_obj[IRDMA_HMC_IW_MR].mem_loc;
+
+	if (is_mrte_loc_mem)
+		loc_mem_pages -= IRDMA_MIN_PBLE_PAGES;
+
+	ibdev_dbg(to_ibdev(dev),
+		  "HMC: mrte_loc %d loc_mem %u fpm max sds %u host_obj %d\n",
+		  hmc_info->hmc_obj[IRDMA_HMC_IW_MR].mem_loc,
+		  hmc_fpm_misc->loc_mem_pages, hmc_fpm_misc->max_sds,
+		  is_mrte_loc_mem);
+
+	mrwanted = hmc_info->hmc_obj[IRDMA_HMC_IW_MR].max_cnt;
+	qpwanted = hmc_info->hmc_obj[IRDMA_HMC_IW_QP].max_cnt;
+	hmc_info->hmc_obj[IRDMA_HMC_IW_HDR].cnt = qpwanted;
+
+	hmc_info->hmc_obj[IRDMA_HMC_IW_OOISC].max_cnt = 0;
+	hmc_info->hmc_obj[IRDMA_HMC_IW_OOISCFFL].max_cnt = 0;
+	hmc_info->hmc_obj[IRDMA_HMC_IW_HTE].max_cnt = 0;
+	hmc_info->hmc_obj[IRDMA_HMC_IW_FSIMC].max_cnt = 0;
+	hmc_info->hmc_obj[IRDMA_HMC_IW_FSIAV].max_cnt =
+		min(hmc_info->hmc_obj[IRDMA_HMC_IW_FSIAV].max_cnt,
+		    (u32)IRDMA_FSIAV_CNT_MAX);
+	for (i = IRDMA_HMC_IW_QP; i < IRDMA_HMC_IW_MAX; i++)
+		hmc_info->hmc_obj[i].cnt = hmc_info->hmc_obj[i].max_cnt;
+
+	while (qpwanted >= IRDMA_MIN_QP_CNT) {
+		if (!irdma_set_loc_hmc_rsrc_gen_3(dev, loc_mem_pages, qpwanted))
+			break;
+
+		qpwanted /= 2;
+		if (mrte_loc == IRDMA_LOC_MEM) {
+			mrwanted = qpwanted * IRDMA_MIN_MR_PER_QP;
+			hmc_info->hmc_obj[IRDMA_HMC_IW_MR].cnt =
+				min(hmc_info->hmc_obj[IRDMA_HMC_IW_MR].max_cnt, mrwanted);
+		}
+	}
+
+	if (qpwanted < IRDMA_MIN_QP_CNT) {
+		ibdev_dbg(to_ibdev(dev),
+			  "HMC: ERROR: could not allocate fpm resources\n");
+		return -EINVAL;
+	}
+
+	irdma_set_host_hmc_rsrc_gen_3(dev);
+	ret_code = irdma_sc_cfg_iw_fpm(dev, dev->hmc_fn_id);
+	if (ret_code) {
+		ibdev_dbg(to_ibdev(dev),
+			  "HMC: cfg_iw_fpm returned error_code[x%08X]\n",
+			  readl(dev->hw_regs[IRDMA_CQPERRCODES]));
+
+		return ret_code;
+	}
+
+	return irdma_cfg_sd_mem(dev, hmc_info);
+}
+
+/**
  * irdma_cfg_fpm_val - configure HMC objects
  * @dev: sc device struct
  * @qp_count: desired qp count
  */
 int irdma_cfg_fpm_val(struct irdma_sc_dev *dev, u32 qp_count)
 {
-	struct irdma_virt_mem virt_mem;
-	u32 i, mem_size;
 	u32 qpwanted, mrwanted, pblewanted;
-	u32 powerof2, hte;
+	u32 powerof2, hte, i;
 	u32 sd_needed;
 	u32 sd_diff;
 	u32 loop_count = 0;
 	struct irdma_hmc_info *hmc_info;
 	struct irdma_hmc_fpm_misc *hmc_fpm_misc;
 	int ret_code = 0;
+	u32 max_sds;
 
 	hmc_info = dev->hmc_info;
 	hmc_fpm_misc = &dev->hmc_fpm_misc;
@@ -4814,14 +5145,16 @@ int irdma_cfg_fpm_val(struct irdma_sc_dev *dev, u32 qp_count)
 		return ret_code;
 	}
 
+	max_sds = hmc_fpm_misc->max_sds;
+
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3)
+		return cfg_fpm_value_gen_3(dev, hmc_info, hmc_fpm_misc);
+
 	for (i = IRDMA_HMC_IW_QP; i < IRDMA_HMC_IW_MAX; i++)
 		hmc_info->hmc_obj[i].cnt = hmc_info->hmc_obj[i].max_cnt;
 	sd_needed = irdma_est_sd(dev, hmc_info);
-	ibdev_dbg(to_ibdev(dev),
-		  "HMC: FW max resources sd_needed[%08d] first_sd_index[%04d]\n",
-		  sd_needed, hmc_info->first_sd_index);
-	ibdev_dbg(to_ibdev(dev), "HMC: sd count %d where max sd is %d\n",
-		  hmc_info->sd_table.sd_cnt, hmc_fpm_misc->max_sds);
+	ibdev_dbg(to_ibdev(dev), "HMC: sd count %u where max sd is %u\n",
+		  hmc_info->sd_table.sd_cnt, max_sds);
 
 	qpwanted = min(qp_count, hmc_info->hmc_obj[IRDMA_HMC_IW_QP].max_cnt);
 
@@ -4835,8 +5168,8 @@ int irdma_cfg_fpm_val(struct irdma_sc_dev *dev, u32 qp_count)
 	pblewanted = hmc_info->hmc_obj[IRDMA_HMC_IW_PBLE].max_cnt;
 
 	ibdev_dbg(to_ibdev(dev),
-		  "HMC: req_qp=%d max_sd=%d, max_qp = %d, max_cq=%d, max_mr=%d, max_pble=%d, mc=%d, av=%d\n",
-		  qp_count, hmc_fpm_misc->max_sds,
+		  "HMC: req_qp=%d max_sd=%u, max_qp = %u, max_cq=%u, max_mr=%u, max_pble=%u, mc=%d, av=%u\n",
+		  qp_count, max_sds,
 		  hmc_info->hmc_obj[IRDMA_HMC_IW_QP].max_cnt,
 		  hmc_info->hmc_obj[IRDMA_HMC_IW_CQ].max_cnt,
 		  hmc_info->hmc_obj[IRDMA_HMC_IW_MR].max_cnt,
@@ -4849,7 +5182,6 @@ int irdma_cfg_fpm_val(struct irdma_sc_dev *dev, u32 qp_count)
 		hmc_info->hmc_obj[IRDMA_HMC_IW_FSIAV].max_cnt;
 	hmc_info->hmc_obj[IRDMA_HMC_IW_ARP].cnt =
 		hmc_info->hmc_obj[IRDMA_HMC_IW_ARP].max_cnt;
-
 	hmc_info->hmc_obj[IRDMA_HMC_IW_APBVT_ENTRY].cnt = 1;
 
 	while (irdma_q1_cnt(dev, hmc_info, qpwanted) > hmc_info->hmc_obj[IRDMA_HMC_IW_Q1].max_cnt)
@@ -4860,7 +5192,7 @@ int irdma_cfg_fpm_val(struct irdma_sc_dev *dev, u32 qp_count)
 		hmc_info->hmc_obj[IRDMA_HMC_IW_QP].cnt = qpwanted;
 		hmc_info->hmc_obj[IRDMA_HMC_IW_CQ].cnt =
 			min(2 * qpwanted, hmc_info->hmc_obj[IRDMA_HMC_IW_CQ].cnt);
-		hmc_info->hmc_obj[IRDMA_HMC_IW_RESERVED].cnt = 0; /* Reserved */
+		hmc_info->hmc_obj[IRDMA_HMC_IW_SRQ].cnt = 0; /* Reserved */
 		hmc_info->hmc_obj[IRDMA_HMC_IW_MR].cnt = mrwanted;
 
 		hte = round_up(qpwanted + hmc_info->hmc_obj[IRDMA_HMC_IW_FSIMC].cnt, 512);
@@ -4898,11 +5230,12 @@ int irdma_cfg_fpm_val(struct irdma_sc_dev *dev, u32 qp_count)
 			if (!(loop_count % 2) && qpwanted > 128) {
 				qpwanted /= 2;
 			} else {
-				mrwanted /= 2;
 				pblewanted /= 2;
+				mrwanted /= 2;
 			}
 			continue;
 		}
+
 		if (dev->cqp->hmc_profile != IRDMA_HMC_PROFILE_FAVOR_VF &&
 		    pblewanted > (512 * FPM_MULTIPLIER * sd_diff)) {
 			pblewanted -= 256 * FPM_MULTIPLIER * sd_diff;
@@ -4928,14 +5261,13 @@ int irdma_cfg_fpm_val(struct irdma_sc_dev *dev, u32 qp_count)
 
 	if (sd_needed > hmc_fpm_misc->max_sds) {
 		ibdev_dbg(to_ibdev(dev),
-			  "HMC: cfg_fpm failed loop_cnt=%d, sd_needed=%d, max sd count %d\n",
+			  "HMC: cfg_fpm failed loop_cnt=%u, sd_needed=%u, max sd count %u\n",
 			  loop_count, sd_needed, hmc_info->sd_table.sd_cnt);
 		return -EINVAL;
 	}
 
-	if (loop_count > 1 && sd_needed < hmc_fpm_misc->max_sds) {
-		pblewanted += (hmc_fpm_misc->max_sds - sd_needed) * 256 *
-			      FPM_MULTIPLIER;
+	if (loop_count > 1 && sd_needed < max_sds) {
+		pblewanted += (max_sds - sd_needed) * 256 * FPM_MULTIPLIER;
 		hmc_info->hmc_obj[IRDMA_HMC_IW_PBLE].cnt = pblewanted;
 		sd_needed = irdma_est_sd(dev, hmc_info);
 	}
@@ -4959,18 +5291,7 @@ int irdma_cfg_fpm_val(struct irdma_sc_dev *dev, u32 qp_count)
 		return ret_code;
 	}
 
-	mem_size = sizeof(struct irdma_hmc_sd_entry) *
-		   (hmc_info->sd_table.sd_cnt + hmc_info->first_sd_index + 1);
-	virt_mem.size = mem_size;
-	virt_mem.va = kzalloc(virt_mem.size, GFP_KERNEL);
-	if (!virt_mem.va) {
-		ibdev_dbg(to_ibdev(dev),
-			  "HMC: failed to allocate memory for sd_entry buffer\n");
-		return -ENOMEM;
-	}
-	hmc_info->sd_table.sd_entry = virt_mem.va;
-
-	return ret_code;
+	return irdma_cfg_sd_mem(dev, hmc_info);
 }
 
 /**
@@ -5381,6 +5702,7 @@ int irdma_sc_dev_init(enum irdma_vers ver, struct irdma_sc_dev *dev,
 	dev->fpm_commit_buf = info->fpm_commit_buf;
 	dev->hw = info->hw;
 	dev->hw->hw_addr = info->bar0;
+	dev->protocol_used = info->protocol_used;
 	/* Setup the hardware limits, hmc may limit further */
 	dev->hw_attrs.min_hw_qp_id = IRDMA_MIN_IW_QP_ID;
 	dev->hw_attrs.min_hw_aeq_size = IRDMA_MIN_AEQ_ENTRIES;
@@ -5409,7 +5731,17 @@ int irdma_sc_dev_init(enum irdma_vers ver, struct irdma_sc_dev *dev,
 	dev->hw_attrs.max_sleep_count = IRDMA_SLEEP_COUNT;
 	dev->hw_attrs.max_cqp_compl_wait_time_ms = CQP_COMPL_WAIT_TIME_MS;
 
-	dev->hw_attrs.uk_attrs.hw_rev = ver;
+	if (!dev->privileged) {
+		ret_code = irdma_vchnl_req_get_hmc_fcn(dev);
+		if (ret_code) {
+			ibdev_dbg(to_ibdev(dev),
+				  "DEV: Get HMC function ret = %d\n",
+				  ret_code);
+
+			return ret_code;
+		}
+	}
+
 	irdma_sc_init_hw(dev);
 
 	if (irdma_wait_pe_ready(dev))
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index 2cb4b96..7825896 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -114,6 +114,12 @@ enum irdma_protocol_used {
 #define IRDMA_UPDATE_SD_BUFF_SIZE	128
 #define IRDMA_FEATURE_BUF_SIZE		(8 * IRDMA_MAX_FEATURES)
 
+#define ENABLE_LOC_MEM			63
+#define MAX_PBLE_PER_SD			0x40000
+#define MAX_PBLE_SD_PER_FCN		0x400
+#define MAX_MR_PER_SD			0x8000
+#define MAX_MR_SD_PER_FCN		0x80
+#define IRDMA_PBLE_COMMIT_OFFSET	112
 #define IRDMA_MAX_QUANTA_PER_WR	8
 
 #define IRDMA_QP_SW_MAX_WQ_QUANTA	32768
@@ -396,6 +402,11 @@ enum irdma_cqp_op_type {
 #define IRDMA_CQPSQ_STATS_HMC_FCN_INDEX GENMASK_ULL(5, 0)
 #define IRDMA_CQPSQ_WS_WQEVALID BIT_ULL(63)
 #define IRDMA_CQPSQ_WS_NODEOP GENMASK_ULL(53, 52)
+#define IRDMA_SD_MAX GENMASK_ULL(15, 0)
+#define IRDMA_MEM_MAX GENMASK_ULL(15, 0)
+#define IRDMA_QP_MEM_LOC GENMASK_ULL(47, 44)
+#define IRDMA_MR_MEM_LOC_S 24
+#define IRDMA_MR_MEM_LOC GENMASK_ULL(27, 24)
 
 #define IRDMA_CQPSQ_WS_ENABLENODE BIT_ULL(62)
 #define IRDMA_CQPSQ_WS_NODETYPE BIT_ULL(61)
@@ -660,10 +671,12 @@ enum irdma_cqp_op_type {
 #define IRDMA_CQPSQ_AEQ_VMAP BIT_ULL(47)
 #define IRDMA_CQPSQ_AEQ_FIRSTPMPBLIDX GENMASK_ULL(27, 0)
 
-#define IRDMA_COMMIT_FPM_QPCNT GENMASK_ULL(18, 0)
+#define IRDMA_COMMIT_FPM_QPCNT_S 0
+#define IRDMA_COMMIT_FPM_QPCNT GENMASK_ULL(20, 0)
 
 #define IRDMA_COMMIT_FPM_BASE_S 32
-#define IRDMA_CQPSQ_CFPM_HMCFNID GENMASK_ULL(5, 0)
+#define IRDMA_CQPSQ_CFPM_HMCFNID GENMASK_ULL(15, 0)
+
 #define IRDMA_CQPSQ_FWQE_AECODE GENMASK_ULL(15, 0)
 #define IRDMA_CQPSQ_FWQE_AESOURCE GENMASK_ULL(19, 16)
 #define IRDMA_CQPSQ_FWQE_RQMNERR GENMASK_ULL(15, 0)
@@ -903,10 +916,17 @@ enum irdma_cqp_op_type {
 #define IRDMAPFINT_OICR_PE_PUSH_M BIT(27)
 #define IRDMAPFINT_OICR_PE_CRITERR_M BIT(28)
 
-#define IRDMA_QUERY_FPM_MAX_QPS GENMASK_ULL(18, 0)
-#define IRDMA_QUERY_FPM_MAX_CQS GENMASK_ULL(19, 0)
+#define IRDMA_QUERY_FPM_LOC_MEM_PAGES_S 32
+#define IRDMA_QUERY_FPM_LOC_MEM_PAGES GENMASK_ULL(63, 32)
+#define IRDMA_QUERY_FPM_MAX_QPS_S 0
+#define IRDMA_QUERY_FPM_MAX_QPS GENMASK_ULL(31, 0)
+#define IRDMA_QUERY_FPM_MAX_CQS_S 0
+#define IRDMA_QUERY_FPM_MAX_CQS GENMASK_ULL(31, 0)
+#define IRDMA_QUERY_FPM_FIRST_PE_SD_INDEX_S 0
 #define IRDMA_QUERY_FPM_FIRST_PE_SD_INDEX GENMASK_ULL(13, 0)
-#define IRDMA_QUERY_FPM_MAX_PE_SDS GENMASK_ULL(45, 32)
+#define IRDMA_QUERY_FPM_MAX_PE_SDS_S 32
+#define IRDMA_QUERY_FPM_MAX_PE_SDS GENMASK_ULL(44, 32)
+
 #define IRDMA_QUERY_FPM_MAX_CEQS GENMASK_ULL(9, 0)
 #define IRDMA_QUERY_FPM_XFBLOCKSIZE GENMASK_ULL(63, 32)
 #define IRDMA_QUERY_FPM_Q1BLOCKSIZE GENMASK_ULL(63, 32)
diff --git a/drivers/infiniband/hw/irdma/hmc.c b/drivers/infiniband/hw/irdma/hmc.c
index ac58088..da18add1 100644
--- a/drivers/infiniband/hw/irdma/hmc.c
+++ b/drivers/infiniband/hw/irdma/hmc.c
@@ -5,6 +5,7 @@
 #include "defs.h"
 #include "type.h"
 #include "protos.h"
+#include "virtchnl.h"
 
 /**
  * irdma_find_sd_index_limit - finds segment descriptor index limit
@@ -228,6 +229,10 @@ int irdma_sc_create_hmc_obj(struct irdma_sc_dev *dev,
 	bool pd_error = false;
 	int ret_code = 0;
 
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3 &&
+	    dev->hmc_info->hmc_obj[info->rsrc_type].mem_loc == IRDMA_LOC_MEM)
+		return 0;
+
 	if (info->start_idx >= info->hmc_info->hmc_obj[info->rsrc_type].cnt)
 		return -EINVAL;
 
@@ -330,7 +335,7 @@ static int irdma_finish_del_sd_reg(struct irdma_sc_dev *dev,
 	u32 i, sd_idx;
 	struct irdma_dma_mem *mem;
 
-	if (!reset)
+	if (dev->privileged && !reset)
 		ret_code = irdma_hmc_sd_grp(dev, info->hmc_info,
 					    info->hmc_info->sd_indexes[0],
 					    info->del_sd_cnt, false);
@@ -376,6 +381,9 @@ int irdma_sc_del_hmc_obj(struct irdma_sc_dev *dev,
 	u32 i, j;
 	int ret_code = 0;
 
+	if (dev->hmc_info->hmc_obj[info->rsrc_type].mem_loc == IRDMA_LOC_MEM)
+		return 0;
+
 	if (info->start_idx >= info->hmc_info->hmc_obj[info->rsrc_type].cnt) {
 		ibdev_dbg(to_ibdev(dev),
 			  "HMC: error start_idx[%04d]  >= [type %04d].cnt[%04d]\n",
@@ -589,7 +597,10 @@ int irdma_add_pd_table_entry(struct irdma_sc_dev *dev,
 		pd_entry->sd_index = sd_idx;
 		pd_entry->valid = true;
 		pd_table->use_cnt++;
-		irdma_invalidate_pf_hmc_pd(dev, sd_idx, rel_pd_idx);
+
+		if (hmc_info->hmc_fn_id < dev->hw_attrs.first_hw_vf_fpm_id &&
+		    dev->privileged)
+			irdma_invalidate_pf_hmc_pd(dev, sd_idx, rel_pd_idx);
 	}
 	pd_entry->bp.use_cnt++;
 
@@ -640,7 +651,8 @@ int irdma_remove_pd_bp(struct irdma_sc_dev *dev,
 	pd_addr = pd_table->pd_page_addr.va;
 	pd_addr += rel_pd_idx;
 	memset(pd_addr, 0, sizeof(u64));
-	irdma_invalidate_pf_hmc_pd(dev, sd_idx, idx);
+	if (dev->privileged && dev->hmc_fn_id == hmc_info->hmc_fn_id)
+		irdma_invalidate_pf_hmc_pd(dev, sd_idx, idx);
 
 	if (!pd_entry->rsrc_pg) {
 		mem = &pd_entry->bp.addr;
diff --git a/drivers/infiniband/hw/irdma/hmc.h b/drivers/infiniband/hw/irdma/hmc.h
index 415f9e2..257a5d2 100644
--- a/drivers/infiniband/hw/irdma/hmc.h
+++ b/drivers/infiniband/hw/irdma/hmc.h
@@ -16,11 +16,21 @@
 #define IRDMA_HMC_PD_BP_BUF_ALIGNMENT		4096
 #define IRDMA_FIRST_VF_FPM_ID			8
 #define FPM_MULTIPLIER				1024
+#define IRDMA_OBJ_LOC_MEM_BIT			0x4
+#define IRDMA_XF_MULTIPLIER			16
+#define IRDMA_RRF_MULTIPLIER			8
+#define IRDMA_MIN_PBLE_PAGES			3
+#define IRDMA_HMC_PAGE_SIZE			2097152
+#define IRDMA_MIN_MR_PER_QP			4
+#define IRDMA_MIN_QP_CNT			64
+#define IRDMA_FSIAV_CNT_MAX			1048576
+#define IRDMA_MIN_IRD				8
+#define IRDMA_HMC_MIN_RRF			16
 
 enum irdma_hmc_rsrc_type {
 	IRDMA_HMC_IW_QP		 = 0,
 	IRDMA_HMC_IW_CQ		 = 1,
-	IRDMA_HMC_IW_RESERVED	 = 2,
+	IRDMA_HMC_IW_SRQ	 = 2,
 	IRDMA_HMC_IW_HTE	 = 3,
 	IRDMA_HMC_IW_ARP	 = 4,
 	IRDMA_HMC_IW_APBVT_ENTRY = 5,
@@ -48,11 +58,17 @@ enum irdma_sd_entry_type {
 	IRDMA_SD_TYPE_DIRECT  = 2,
 };
 
+enum irdma_hmc_obj_mem {
+	IRDMA_HOST_MEM = 0,
+	IRDMA_LOC_MEM  = 1,
+};
+
 struct irdma_hmc_obj_info {
 	u64 base;
 	u32 max_cnt;
 	u32 cnt;
 	u64 size;
+	enum irdma_hmc_obj_mem mem_loc;
 };
 
 struct irdma_hmc_bp {
@@ -117,6 +133,7 @@ struct irdma_update_sds_info {
 struct irdma_ccq_cqe_info;
 struct irdma_hmc_fcn_info {
 	u32 vf_id;
+	u8 protocol_used;
 	u8 free_fcn;
 };
 
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index ad50b77..2881314 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -33,6 +33,7 @@
 static enum irdma_hmc_rsrc_type iw_hmc_obj_types[] = {
 	IRDMA_HMC_IW_QP,
 	IRDMA_HMC_IW_CQ,
+	IRDMA_HMC_IW_SRQ,
 	IRDMA_HMC_IW_HTE,
 	IRDMA_HMC_IW_ARP,
 	IRDMA_HMC_IW_APBVT_ENTRY,
@@ -1571,6 +1572,8 @@ static void irdma_del_init_mem(struct irdma_pci_f *rf)
 {
 	struct irdma_sc_dev *dev = &rf->sc_dev;
 
+	if (!rf->sc_dev.privileged)
+		irdma_vchnl_req_put_hmc_fcn(&rf->sc_dev);
 	kfree(dev->hmc_info->sd_table.sd_entry);
 	dev->hmc_info->sd_table.sd_entry = NULL;
 	vfree(rf->mem_rsrc);
@@ -1637,6 +1640,7 @@ static int irdma_initialize_dev(struct irdma_pci_f *rf)
 
 	info.bar0 = rf->hw.hw_addr;
 	info.hmc_fn_id = rf->pf_id;
+	info.protocol_used = rf->protocol_used;
 	info.hw = &rf->hw;
 	status = irdma_sc_dev_init(rf->rdma_ver, &rf->sc_dev, &info);
 	if (status)
diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
index 6fa807e..15e036d 100644
--- a/drivers/infiniband/hw/irdma/i40iw_if.c
+++ b/drivers/infiniband/hw/irdma/i40iw_if.c
@@ -77,6 +77,7 @@ static void i40iw_fill_device_info(struct irdma_device *iwdev, struct i40e_info
 	rf->rdma_ver = IRDMA_GEN_1;
 	rf->sc_dev.hw = &rf->hw;
 	rf->sc_dev.hw_attrs.uk_attrs.hw_rev = IRDMA_GEN_1;
+	rf->sc_dev.privileged = true;
 	rf->gen_ops.request_reset = i40iw_request_reset;
 	rf->pcidev = cdev_info->pcidev;
 	rf->pf_id = cdev_info->fid;
diff --git a/drivers/infiniband/hw/irdma/icrdma_if.c b/drivers/infiniband/hw/irdma/icrdma_if.c
index 5fcbf69..0ddccf1 100644
--- a/drivers/infiniband/hw/irdma/icrdma_if.c
+++ b/drivers/infiniband/hw/irdma/icrdma_if.c
@@ -144,6 +144,8 @@ static void icrdma_fill_device_info(struct irdma_device *iwdev,
 	rf->msix_entries = cdev_info->msix_entries;
 	rf->rdma_ver = IRDMA_GEN_2;
 	rf->sc_dev.hw_attrs.uk_attrs.hw_rev = IRDMA_GEN_2;
+	rf->sc_dev.is_pf = true;
+	rf->sc_dev.privileged = true;
 
 	rf->gen_ops.register_qset = icrdma_lan_register_qset;
 	rf->gen_ops.unregister_qset = icrdma_lan_unregister_qset;
diff --git a/drivers/infiniband/hw/irdma/ig3rdma_hw.h b/drivers/infiniband/hw/irdma/ig3rdma_hw.h
new file mode 100644
index 0000000..4c3d186
--- /dev/null
+++ b/drivers/infiniband/hw/irdma/ig3rdma_hw.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* Copyright (c) 2021 - 2024 Intel Corporation */
+#ifndef IG3RDMA_HW_H
+#define IG3RDMA_HW_H
+
+#define IG3_PF_RDMA_REGION_OFFSET 0xBC00000
+#define IG3_PF_RDMA_REGION_LEN 0x401000
+#define IG3_VF_RDMA_REGION_OFFSET 0x8C00
+#define IG3_VF_RDMA_REGION_LEN 0x8400
+
+#endif /* IG3RDMA_HW_H*/
diff --git a/drivers/infiniband/hw/irdma/ig3rdma_if.c b/drivers/infiniband/hw/irdma/ig3rdma_if.c
new file mode 100644
index 0000000..70b1ed3
--- /dev/null
+++ b/drivers/infiniband/hw/irdma/ig3rdma_if.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+/* Copyright (c) 2023 - 2024 Intel Corporation */
+#include "main.h"
+#include "ig3rdma_hw.h"
+
+static void ig3rdma_idc_core_event_handler(struct idc_rdma_core_dev_info *cdev_info,
+					   struct idc_rdma_event *event)
+{
+	struct irdma_pci_f *rf = auxiliary_get_drvdata(cdev_info->adev);
+
+	if (*event->type & BIT(IDC_RDMA_EVENT_WARN_RESET)) {
+		rf->reset = true;
+		rf->sc_dev.vchnl_up = false;
+	}
+}
+
+static int ig3rdma_cfg_regions(struct irdma_hw *hw,
+			       struct idc_rdma_core_dev_info *cdev_info)
+{
+	struct pci_dev *pdev = cdev_info->pdev;
+	int i;
+
+	switch (cdev_info->ftype) {
+	case IDC_FUNCTION_TYPE_PF:
+		hw->rdma_reg.len = IG3_PF_RDMA_REGION_LEN;
+		hw->rdma_reg.offset = IG3_PF_RDMA_REGION_OFFSET;
+		break;
+	case IDC_FUNCTION_TYPE_VF:
+		hw->rdma_reg.len = IG3_VF_RDMA_REGION_LEN;
+		hw->rdma_reg.offset = IG3_VF_RDMA_REGION_OFFSET;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	hw->rdma_reg.addr = ioremap(pci_resource_start(pdev, 0) + hw->rdma_reg.offset,
+				    hw->rdma_reg.len);
+
+	if (!hw->rdma_reg.addr)
+		return -ENOMEM;
+
+	hw->io_regs = kcalloc(cdev_info->num_memory_regions,
+			      sizeof(struct irdma_mmio_region), GFP_KERNEL);
+
+	if (!hw->io_regs) {
+		iounmap(hw->rdma_reg.addr);
+		return -ENOMEM;
+	}
+
+	hw->num_io_regions = le16_to_cpu(cdev_info->num_memory_regions);
+	for (i = 0; i < cdev_info->num_memory_regions; i++) {
+		hw->io_regs[i].addr =
+			cdev_info->mapped_mem_regions[i].region_addr;
+		hw->io_regs[i].len =
+			cdev_info->mapped_mem_regions[i].size;
+		hw->io_regs[i].offset =
+			cdev_info->mapped_mem_regions[i].start_offset;
+	}
+
+	return 0;
+}
+
+static void ig3rdma_decfg_rf(struct irdma_pci_f *rf)
+{
+	struct irdma_hw *hw = &rf->hw;
+
+	destroy_workqueue(rf->vchnl_wq);
+	kfree(hw->io_regs);
+	iounmap(hw->rdma_reg.addr);
+}
+
+static int ig3rdma_cfg_rf(struct irdma_pci_f *rf,
+			  struct idc_rdma_core_dev_info *cdev_info)
+{
+	int err;
+
+	rf->sc_dev.hw = &rf->hw;
+	rf->cdev = cdev_info;
+	rf->pcidev = cdev_info->pdev;
+	rf->hw.device = &rf->pcidev->dev;
+	rf->msix_count = cdev_info->msix_count;
+	rf->msix_entries = cdev_info->msix_entries;
+
+	err = irdma_vchnl_init(rf, cdev_info, &rf->rdma_ver);
+	if (err)
+		return err;
+
+	err = ig3rdma_cfg_regions(&rf->hw, cdev_info);
+	if (err) {
+		destroy_workqueue(rf->vchnl_wq);
+		return err;
+	}
+
+	rf->protocol_used = IRDMA_ROCE_PROTOCOL_ONLY;
+	rf->rsrc_profile = IRDMA_HMC_PROFILE_DEFAULT;
+	rf->rst_to = IRDMA_RST_TIMEOUT_HZ;
+	rf->gen_ops.request_reset = irdma_request_reset;
+	rf->limits_sel = 7;
+	mutex_init(&rf->ah_tbl_lock);
+
+	return 0;
+}
+
+static int ig3rdma_core_probe(struct auxiliary_device *aux_dev,
+			      const struct auxiliary_device_id *id)
+{
+	struct idc_rdma_core_auxiliary_dev *idc_adev =
+		container_of(aux_dev, struct idc_rdma_core_auxiliary_dev, adev);
+	struct idc_rdma_core_dev_info *cdev_info = idc_adev->cdev_info;
+	struct irdma_pci_f *rf;
+	int err;
+
+	rf = kzalloc(sizeof(*rf), GFP_KERNEL);
+	if (!rf)
+		return -ENOMEM;
+
+	err = ig3rdma_cfg_rf(rf, cdev_info);
+	if (err)
+		goto err_cfg_rf;
+
+	err = irdma_ctrl_init_hw(rf);
+	if (err)
+		goto err_ctrl_init;
+
+	auxiliary_set_drvdata(aux_dev, rf);
+
+	err = cdev_info->ops->vport_dev_ctrl(cdev_info, true);
+	if (err)
+		goto err_vport_ctrl;
+
+	return 0;
+
+err_vport_ctrl:
+	irdma_ctrl_deinit_hw(rf);
+err_ctrl_init:
+	ig3rdma_decfg_rf(rf);
+err_cfg_rf:
+	kfree(rf);
+
+	return err;
+}
+
+static void ig3rdma_core_remove(struct auxiliary_device *aux_dev)
+{
+	struct idc_rdma_core_auxiliary_dev *idc_adev =
+		container_of(aux_dev, struct idc_rdma_core_auxiliary_dev, adev);
+	struct idc_rdma_core_dev_info *cdev_info = idc_adev->cdev_info;
+	struct irdma_pci_f *rf = auxiliary_get_drvdata(aux_dev);
+
+	cdev_info->ops->vport_dev_ctrl(cdev_info, false);
+	irdma_ctrl_deinit_hw(rf);
+	ig3rdma_decfg_rf(rf);
+	kfree(rf);
+}
+
+static const struct auxiliary_device_id ig3rdma_core_auxiliary_id_table[] = {
+	{.name = "idpf.8086.rdma.core", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, ig3rdma_core_auxiliary_id_table);
+
+struct idc_rdma_core_auxiliary_drv ig3rdma_core_auxiliary_drv = {
+	.adrv = {
+		.name = "core",
+		.id_table = ig3rdma_core_auxiliary_id_table,
+		.probe = ig3rdma_core_probe,
+		.remove = ig3rdma_core_remove,
+	},
+	.event_handler = ig3rdma_idc_core_event_handler,
+};
\ No newline at end of file
diff --git a/drivers/infiniband/hw/irdma/irdma.h b/drivers/infiniband/hw/irdma/irdma.h
index 20d2e739..7691704 100644
--- a/drivers/infiniband/hw/irdma/irdma.h
+++ b/drivers/infiniband/hw/irdma/irdma.h
@@ -107,6 +107,9 @@ enum irdma_vers {
 	IRDMA_GEN_RSVD,
 	IRDMA_GEN_1,
 	IRDMA_GEN_2,
+	IRDMA_GEN_3,
+	IRDMA_GEN_NEXT,
+	IRDMA_GEN_MAX = IRDMA_GEN_NEXT-1
 };
 
 struct irdma_uk_attrs {
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index ee59ca1..e9524de 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -7,6 +7,23 @@
 MODULE_DESCRIPTION("Intel(R) Ethernet Protocol Driver for RDMA");
 MODULE_LICENSE("Dual BSD/GPL");
 
+int irdma_vchnl_send_sync(struct irdma_sc_dev *dev, u8 *msg, u16 len,
+			  u8 *recv_msg, u16 *recv_len)
+{
+	struct idc_rdma_core_dev_info *cdev_info = dev_to_rf(dev)->cdev;
+	int ret;
+
+	ret = cdev_info->ops->vc_send_sync(cdev_info, msg, len, recv_msg,
+					   recv_len);
+	if (ret == -ETIMEDOUT) {
+		ibdev_err(&(dev_to_rf(dev)->iwdev->ibdev),
+			  "Virtual channel Req <-> Resp completion timeout\n");
+		dev->vchnl_up = false;
+	}
+
+	return ret;
+}
+
 static struct notifier_block irdma_inetaddr_notifier = {
 	.notifier_call = irdma_inetaddr_event
 };
@@ -103,16 +120,54 @@ static int __init irdma_init_module(void)
 		return ret;
 	}
 
+	ret = auxiliary_driver_register(&ig3rdma_core_auxiliary_drv.adrv);
+	if (ret) {
+		auxiliary_driver_unregister(&icrdma_core_auxiliary_drv.adrv);
+		auxiliary_driver_unregister(&i40iw_auxiliary_drv);
+		pr_err("Failed ig3rdma(gen_3) core auxiliary_driver_register() ret=%d\n",
+		       ret);
+
+		return ret;
+	}
 	irdma_register_notifiers();
 
 	return 0;
 }
 
+int irdma_vchnl_init(struct irdma_pci_f *rf,
+		     struct idc_rdma_core_dev_info *cdev_info, u8 *rdma_ver)
+{
+	struct irdma_vchnl_init_info virt_info;
+	u8 gen = rf->rdma_ver;
+	int ret;
+
+	rf->vchnl_wq = alloc_ordered_workqueue("irdma-virtchnl-wq", 0);
+	if (!rf->vchnl_wq)
+		return -ENOMEM;
+
+	mutex_init(&rf->sc_dev.vchnl_mutex);
+
+	virt_info.is_pf = !cdev_info->ftype;
+	virt_info.hw_rev = gen;
+	virt_info.privileged = gen == IRDMA_GEN_2;
+	virt_info.vchnl_wq = rf->vchnl_wq;
+	ret = irdma_sc_vchnl_init(&rf->sc_dev, &virt_info);
+	if (ret) {
+		destroy_workqueue(rf->vchnl_wq);
+		return ret;
+	}
+
+	*rdma_ver = rf->sc_dev.hw_attrs.uk_attrs.hw_rev;
+
+	return 0;
+}
+
 static void __exit irdma_exit_module(void)
 {
 	irdma_unregister_notifiers();
 	auxiliary_driver_unregister(&icrdma_core_auxiliary_drv.adrv);
 	auxiliary_driver_unregister(&i40iw_auxiliary_drv);
+	auxiliary_driver_unregister(&ig3rdma_core_auxiliary_drv.adrv);
 }
 
 module_init(irdma_init_module);
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 7360e17..a7f3d19 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -55,6 +55,7 @@
 #include "puda.h"
 
 extern struct auxiliary_driver i40iw_auxiliary_drv;
+extern struct idc_rdma_core_auxiliary_drv ig3rdma_core_auxiliary_drv;
 extern struct idc_rdma_core_auxiliary_drv icrdma_core_auxiliary_drv;
 
 #define IRDMA_FW_VER_DEFAULT	2
@@ -326,6 +327,7 @@ struct irdma_pci_f {
 	wait_queue_head_t vchnl_waitq;
 	struct workqueue_struct *cqp_cmpl_wq;
 	struct work_struct cqp_cmpl_work;
+	struct workqueue_struct *vchnl_wq;
 	struct irdma_sc_vsi default_vsi;
 	void *back_fcn;
 	struct irdma_gen_ops gen_ops;
@@ -556,6 +558,8 @@ int irdma_netdevice_event(struct notifier_block *notifier, unsigned long event,
 			  void *ptr);
 void irdma_add_ip(struct irdma_device *iwdev);
 void cqp_compl_worker(struct work_struct *work);
+int irdma_vchnl_init(struct irdma_pci_f *rf,
+		     struct idc_rdma_core_dev_info *cdev_info, u8 *rdma_ver);
 void irdma_fill_qos_info(struct irdma_l2params *l2params,
 			 struct iidc_rdma_qos_params *qos_info);
 void irdma_request_reset(struct irdma_pci_f *rf);
diff --git a/drivers/infiniband/hw/irdma/pble.c b/drivers/infiniband/hw/irdma/pble.c
index e7ce684..2ef60e6 100644
--- a/drivers/infiniband/hw/irdma/pble.c
+++ b/drivers/infiniband/hw/irdma/pble.c
@@ -193,8 +193,15 @@ static enum irdma_sd_entry_type irdma_get_type(struct irdma_sc_dev *dev,
 {
 	enum irdma_sd_entry_type sd_entry_type;
 
-	sd_entry_type = !idx->rel_pd_idx && pages == IRDMA_HMC_PD_CNT_IN_SD ?
-			IRDMA_SD_TYPE_DIRECT : IRDMA_SD_TYPE_PAGED;
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3)
+		sd_entry_type = (!idx->rel_pd_idx &&
+				 pages == IRDMA_HMC_PD_CNT_IN_SD) ?
+				 IRDMA_SD_TYPE_DIRECT : IRDMA_SD_TYPE_PAGED;
+	else
+		sd_entry_type = (!idx->rel_pd_idx &&
+				 pages == IRDMA_HMC_PD_CNT_IN_SD &&
+				 dev->privileged) ?
+				 IRDMA_SD_TYPE_DIRECT : IRDMA_SD_TYPE_PAGED;
 	return sd_entry_type;
 }
 
@@ -279,10 +286,11 @@ static int add_pble_prm(struct irdma_hmc_pble_rsrc *pble_rsrc)
 	sd_reg_val = (sd_entry_type == IRDMA_SD_TYPE_PAGED) ?
 			     sd_entry->u.pd_table.pd_page_addr.pa :
 			     sd_entry->u.bp.addr.pa;
-
-	if (!sd_entry->valid) {
-		ret_code = irdma_hmc_sd_one(dev, hmc_info->hmc_fn_id, sd_reg_val,
-					    idx->sd_idx, sd_entry->entry_type, true);
+	if ((dev->privileged && !sd_entry->valid) ||
+	    dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3) {
+		ret_code = irdma_hmc_sd_one(dev, hmc_info->hmc_fn_id,
+					    sd_reg_val, idx->sd_idx,
+					    sd_entry->entry_type, true);
 		if (ret_code)
 			goto error;
 	}
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 59b34af..cfcb5d9 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -8,6 +8,8 @@
 #include "hmc.h"
 #include "uda.h"
 #include "ws.h"
+#include "virtchnl.h"
+
 #define IRDMA_DEBUG_ERR		"ERR"
 #define IRDMA_DEBUG_INIT	"INIT"
 #define IRDMA_DEBUG_DEV		"DEV"
@@ -159,7 +161,34 @@ enum irdma_hw_stats_index {
 enum irdma_feature_type {
 	IRDMA_FEATURE_FW_INFO = 0,
 	IRDMA_HW_VERSION_INFO = 1,
+	IRDMA_QP_MAX_INCR     = 2,
+	IRDMA_CQ_MAX_INCR     = 3,
+	IRDMA_CEQ_MAX_INCR    = 4,
+	IRDMA_SD_MAX_INCR     = 5,
+	IRDMA_QP_SMALL        = 6,
+	IRDMA_QP_MEDIUM       = 7,
+	IRDMA_QP_LARGE        = 8,
+	IRDMA_QP_XLARGE       = 9,
+	IRDMA_CQ_SMALL        = 10,
+	IRDMA_CQ_MEDIUM       = 11,
+	IRDMA_CQ_LARGE        = 12,
+	IRDMA_CQ_XLARGE       = 13,
+	IRDMA_CEQ_SMALL       = 14,
+	IRDMA_CEQ_MEDIUM      = 15,
+	IRDMA_CEQ_LARGE       = 16,
+	IRDMA_CEQ_XLARGE      = 17,
+	IRDMA_SD_SMALL        = 18,
+	IRDMA_SD_MEDIUM       = 19,
+	IRDMA_SD_LARGE        = 20,
+	IRDMA_SD_XLARGE       = 21,
+	IRDMA_OBJ_1           = 22,
+	IRDMA_OBJ_2           = 23,
+	IRDMA_ENDPT_TRK       = 24,
+	IRDMA_FTN_INLINE_MAX  = 25,
 	IRDMA_QSETS_MAX       = 26,
+	IRDMA_ASO	      = 27,
+	IRDMA_FTN_FLAGS	      = 32,
+	IRDMA_FTN_NOP         = 33,
 	IRDMA_MAX_FEATURES, /* Must be last entry */
 };
 
@@ -310,9 +339,21 @@ struct irdma_vsi_pestat {
 	spinlock_t lock; /* rdma stats lock */
 };
 
+struct irdma_mmio_region {
+	u8 __iomem *addr;
+	resource_size_t len;
+	resource_size_t offset;
+};
+
 struct irdma_hw {
-	u8 __iomem *hw_addr;
-	u8 __iomem *priv_hw_addr;
+	union {
+		u8 __iomem *hw_addr;
+		struct {
+			struct irdma_mmio_region rdma_reg; /* RDMA region */
+			struct irdma_mmio_region *io_regs; /* Non-RDMA MMIO regions */
+			u16 num_io_regions; /* Number of Non-RDMA MMIO regions */
+		};
+	};
 	struct device *device;
 	struct irdma_hmc_info hmc;
 };
@@ -518,6 +559,7 @@ struct irdma_ws_node_info {
 struct irdma_hmc_fpm_misc {
 	u32 max_ceqs;
 	u32 max_sds;
+	u32 loc_mem_pages;
 	u32 xf_block_size;
 	u32 q1_block_size;
 	u32 ht_multiplier;
@@ -526,6 +568,7 @@ struct irdma_hmc_fpm_misc {
 	u32 ooiscf_block_size;
 };
 
+#define IRDMA_VCHNL_MAX_MSG_SIZE 512
 #define IRDMA_LEAF_DEFAULT_REL_BW		64
 #define IRDMA_PARENT_DEFAULT_REL_BW		1
 
@@ -601,19 +644,28 @@ struct irdma_sc_dev {
 	u64 cqp_cmd_stats[IRDMA_MAX_CQP_OPS];
 	struct irdma_hw_attrs hw_attrs;
 	struct irdma_hmc_info *hmc_info;
+	struct irdma_vchnl_rdma_caps vc_caps;
+	u8 vc_recv_buf[IRDMA_VCHNL_MAX_MSG_SIZE];
+	u16 vc_recv_len;
 	struct irdma_sc_cqp *cqp;
 	struct irdma_sc_aeq *aeq;
 	struct irdma_sc_ceq *ceq[IRDMA_CEQ_MAX_COUNT];
 	struct irdma_sc_cq *ccq;
 	const struct irdma_irq_ops *irq_ops;
+	struct irdma_qos qos[IRDMA_MAX_USER_PRIORITY];
 	struct irdma_hmc_fpm_misc hmc_fpm_misc;
 	struct irdma_ws_node *ws_tree_root;
 	struct mutex ws_mutex; /* ws tree mutex */
+	u32 vchnl_ver;
 	u16 num_vfs;
-	u8 hmc_fn_id;
+	u16 hmc_fn_id;
 	u8 vf_id;
+	bool privileged:1;
 	bool vchnl_up:1;
 	bool ceq_valid:1;
+	bool is_pf:1;
+	u8 protocol_used;
+	struct mutex vchnl_mutex; /* mutex to synchronize RDMA virtual channel messages */
 	u8 pci_rev;
 	int (*ws_add)(struct irdma_sc_vsi *vsi, u8 user_pri);
 	void (*ws_remove)(struct irdma_sc_vsi *vsi, u8 user_pri);
@@ -731,7 +783,8 @@ struct irdma_device_init_info {
 	__le64 *fpm_commit_buf;
 	struct irdma_hw *hw;
 	void __iomem *bar0;
-	u8 hmc_fn_id;
+	enum irdma_protocol_used protocol_used;
+	u16 hmc_fn_id;
 };
 
 struct irdma_ceq_init_info {
@@ -972,7 +1025,7 @@ struct irdma_allocate_stag_info {
 	bool use_hmc_fcn_index:1;
 	bool use_pf_rid:1;
 	bool all_memory:1;
-	u8 hmc_fcn_index;
+	u16 hmc_fcn_index;
 };
 
 struct irdma_mw_alloc_info {
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 380e4a4..8fd7eeb 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -55,8 +55,8 @@ enum irdma_device_caps_const {
 	IRDMA_CEQE_SIZE =			1,
 	IRDMA_CQP_CTX_SIZE =			8,
 	IRDMA_SHADOW_AREA_SIZE =		8,
-	IRDMA_QUERY_FPM_BUF_SIZE =		176,
-	IRDMA_COMMIT_FPM_BUF_SIZE =		176,
+	IRDMA_QUERY_FPM_BUF_SIZE =		192,
+	IRDMA_COMMIT_FPM_BUF_SIZE =		192,
 	IRDMA_GATHER_STATS_BUF_SIZE =		1024,
 	IRDMA_MIN_IW_QP_ID =			0,
 	IRDMA_MAX_IW_QP_ID =			262143,
diff --git a/drivers/infiniband/hw/irdma/virtchnl.c b/drivers/infiniband/hw/irdma/virtchnl.c
new file mode 100644
index 0000000..2abfc39
--- /dev/null
+++ b/drivers/infiniband/hw/irdma/virtchnl.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+/* Copyright (c) 2015 - 2024 Intel Corporation */
+#include "osdep.h"
+#include "hmc.h"
+#include "defs.h"
+#include "type.h"
+#include "protos.h"
+#include "virtchnl.h"
+#include "ws.h"
+#include "i40iw_hw.h"
+
+/**
+ * irdma_sc_vchnl_init - Initialize dev virtchannel and get hw_rev
+ * @dev: dev structure to update
+ * @info: virtchannel info parameters to fill into the dev structure
+ */
+int irdma_sc_vchnl_init(struct irdma_sc_dev *dev,
+			struct irdma_vchnl_init_info *info)
+{
+	dev->vchnl_up = true;
+	dev->privileged = info->privileged;
+	dev->is_pf = info->is_pf;
+	dev->hw_attrs.uk_attrs.hw_rev = info->hw_rev;
+
+	if (!dev->privileged) {
+		int ret = irdma_vchnl_req_get_ver(dev, IRDMA_VCHNL_CHNL_VER_MAX,
+						  &dev->vchnl_ver);
+
+		ibdev_dbg(to_ibdev(dev),
+			  "DEV: Get Channel version ret = %d, version is %u\n",
+			  ret, dev->vchnl_ver);
+
+		if (ret)
+			return ret;
+
+		ret = irdma_vchnl_req_get_caps(dev);
+		if (ret)
+			return ret;
+
+		dev->hw_attrs.uk_attrs.hw_rev = dev->vc_caps.hw_rev;
+	}
+
+	return 0;
+}
+
+/**
+ * irdma_vchnl_req_verify_resp - Verify requested response size
+ * @vchnl_req: vchnl message requested
+ * @resp_len: response length sent from vchnl peer
+ */
+static int irdma_vchnl_req_verify_resp(struct irdma_vchnl_req *vchnl_req,
+				       u16 resp_len)
+{
+	switch (vchnl_req->vchnl_msg->op_code) {
+	case IRDMA_VCHNL_OP_GET_VER:
+	case IRDMA_VCHNL_OP_GET_HMC_FCN:
+	case IRDMA_VCHNL_OP_PUT_HMC_FCN:
+		if (resp_len != vchnl_req->parm_len)
+			return -EBADMSG;
+		break;
+	case IRDMA_VCHNL_OP_GET_RDMA_CAPS:
+		if (resp_len < IRDMA_VCHNL_OP_GET_RDMA_CAPS_MIN_SIZE)
+			return -EBADMSG;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static void irdma_free_vchnl_req_msg(struct irdma_vchnl_req *vchnl_req)
+{
+	kfree(vchnl_req->vchnl_msg);
+}
+
+static int irdma_alloc_vchnl_req_msg(struct irdma_vchnl_req *vchnl_req,
+				     struct irdma_vchnl_req_init_info *info)
+{
+	struct irdma_vchnl_op_buf *vchnl_msg;
+
+	vchnl_msg = kzalloc(IRDMA_VCHNL_MAX_MSG_SIZE, GFP_KERNEL);
+
+	if (!vchnl_msg)
+		return -ENOMEM;
+
+	vchnl_msg->op_ctx = (uintptr_t)vchnl_req;
+	vchnl_msg->buf_len = sizeof(*vchnl_msg) + info->req_parm_len;
+	if (info->req_parm_len)
+		memcpy(vchnl_msg->buf, info->req_parm, info->req_parm_len);
+	vchnl_msg->op_code = info->op_code;
+	vchnl_msg->op_ver = info->op_ver;
+
+	vchnl_req->vchnl_msg = vchnl_msg;
+	vchnl_req->parm = info->resp_parm;
+	vchnl_req->parm_len = info->resp_parm_len;
+
+	return 0;
+}
+
+static int irdma_vchnl_req_send_sync(struct irdma_sc_dev *dev,
+				     struct irdma_vchnl_req_init_info *info)
+{
+	u16 resp_len = sizeof(dev->vc_recv_buf);
+	struct irdma_vchnl_req vchnl_req = {};
+	u16 msg_len;
+	u8 *msg;
+	int ret;
+
+	ret = irdma_alloc_vchnl_req_msg(&vchnl_req, info);
+	if (ret)
+		return ret;
+
+	msg_len = vchnl_req.vchnl_msg->buf_len;
+	msg = (u8 *)vchnl_req.vchnl_msg;
+
+	mutex_lock(&dev->vchnl_mutex);
+	ret = irdma_vchnl_send_sync(dev, msg, msg_len, dev->vc_recv_buf,
+				    &resp_len);
+	dev->vc_recv_len = resp_len;
+	if (ret)
+		goto exit;
+
+	ret = irdma_vchnl_req_get_resp(dev, &vchnl_req);
+exit:
+	mutex_unlock(&dev->vchnl_mutex);
+	ibdev_dbg(to_ibdev(dev),
+		  "VIRT: virtual channel send %s caller: %pS ret=%d op=%u op_ver=%u req_len=%u parm_len=%u resp_len=%u\n",
+		  !ret ? "SUCCEEDS" : "FAILS", __builtin_return_address(0),
+		  ret, vchnl_req.vchnl_msg->op_code,
+		  vchnl_req.vchnl_msg->op_ver, vchnl_req.vchnl_msg->buf_len,
+		  vchnl_req.parm_len, vchnl_req.resp_len);
+	irdma_free_vchnl_req_msg(&vchnl_req);
+
+	return ret;
+}
+
+/**
+ * irdma_vchnl_req_get_ver - Request Channel version
+ * @dev: RDMA device pointer
+ * @ver_req: Virtual channel version requested
+ * @ver_res: Virtual channel version response
+ */
+int irdma_vchnl_req_get_ver(struct irdma_sc_dev *dev, u16 ver_req, u32 *ver_res)
+{
+	struct irdma_vchnl_req_init_info info = {};
+	int ret;
+
+	if (!dev->vchnl_up)
+		return -EBUSY;
+
+	info.op_code = IRDMA_VCHNL_OP_GET_VER;
+	info.op_ver = ver_req;
+	info.resp_parm = ver_res;
+	info.resp_parm_len = sizeof(*ver_res);
+
+	ret = irdma_vchnl_req_send_sync(dev, &info);
+	if (ret)
+		return ret;
+
+	if (*ver_res < IRDMA_VCHNL_CHNL_VER_MIN) {
+		ibdev_dbg(to_ibdev(dev),
+			  "VIRT: %s unsupported vchnl version 0x%0x\n",
+			  __func__, *ver_res);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/**
+ * irdma_vchnl_req_get_hmc_fcn - Request VF HMC Function
+ * @dev: RDMA device pointer
+ */
+int irdma_vchnl_req_get_hmc_fcn(struct irdma_sc_dev *dev)
+{
+	struct irdma_vchnl_req_hmc_info req_hmc = {};
+	struct irdma_vchnl_resp_hmc_info resp_hmc = {};
+	struct irdma_vchnl_req_init_info info = {};
+	int ret;
+
+	if (!dev->vchnl_up)
+		return -EBUSY;
+
+	info.op_code = IRDMA_VCHNL_OP_GET_HMC_FCN;
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3) {
+		info.op_ver = IRDMA_VCHNL_OP_GET_HMC_FCN_V2;
+		req_hmc.protocol_used = dev->protocol_used;
+		info.req_parm_len = sizeof(req_hmc);
+		info.req_parm = &req_hmc;
+		info.resp_parm = &resp_hmc;
+		info.resp_parm_len = sizeof(resp_hmc);
+	}
+
+	ret = irdma_vchnl_req_send_sync(dev, &info);
+
+	if (ret)
+		return ret;
+
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3) {
+		int i;
+
+		for (i = 0;  i < IRDMA_MAX_USER_PRIORITY; i++) {
+			dev->qos[i].qs_handle = resp_hmc.qs_handle[i];
+			dev->qos[i].valid = true;
+		}
+	}
+	return 0;
+}
+
+/**
+ * irdma_vchnl_req_put_hmc_fcn - Free VF HMC Function
+ * @dev: RDMA device pointer
+ */
+int irdma_vchnl_req_put_hmc_fcn(struct irdma_sc_dev *dev)
+{
+	struct irdma_vchnl_req_init_info info = {};
+
+	if (!dev->vchnl_up)
+		return -EBUSY;
+
+	info.op_code = IRDMA_VCHNL_OP_PUT_HMC_FCN;
+	info.op_ver = IRDMA_VCHNL_OP_PUT_HMC_FCN_V0;
+
+	return irdma_vchnl_req_send_sync(dev, &info);
+}
+
+/**
+ * irdma_vchnl_req_get_caps - Request RDMA capabilities
+ * @dev: RDMA device pointer
+ */
+int irdma_vchnl_req_get_caps(struct irdma_sc_dev *dev)
+{
+	struct irdma_vchnl_req_init_info info = {};
+	int ret;
+
+	if (!dev->vchnl_up)
+		return -EBUSY;
+
+	info.op_code = IRDMA_VCHNL_OP_GET_RDMA_CAPS;
+	info.op_ver = IRDMA_VCHNL_OP_GET_RDMA_CAPS_V0;
+	info.resp_parm = &dev->vc_caps;
+	info.resp_parm_len = sizeof(dev->vc_caps);
+
+	ret = irdma_vchnl_req_send_sync(dev, &info);
+
+	if (ret)
+		return ret;
+
+	if (dev->vc_caps.hw_rev > IRDMA_GEN_MAX ||
+	    dev->vc_caps.hw_rev < IRDMA_GEN_2) {
+		ibdev_dbg(to_ibdev(dev),
+			  "ERR: %s unsupported hw_rev version 0x%0x\n",
+			  __func__, dev->vc_caps.hw_rev);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/**
+ * irdma_vchnl_req_get_resp - Receive the inbound vchnl response.
+ * @dev: Dev pointer
+ * @vchnl_req: Vchannel request
+ */
+int irdma_vchnl_req_get_resp(struct irdma_sc_dev *dev,
+			     struct irdma_vchnl_req *vchnl_req)
+{
+	struct irdma_vchnl_resp_buf *vchnl_msg_resp =
+		(struct irdma_vchnl_resp_buf *)dev->vc_recv_buf;
+	u16 resp_len;
+	int ret;
+
+	if ((uintptr_t)vchnl_req != (uintptr_t)vchnl_msg_resp->op_ctx) {
+		ibdev_dbg(to_ibdev(dev),
+			  "VIRT: error vchnl context value does not match\n");
+		return -EBADMSG;
+	}
+
+	resp_len = dev->vc_recv_len - sizeof(*vchnl_msg_resp);
+	resp_len = min(resp_len, vchnl_req->parm_len);
+
+	ret = irdma_vchnl_req_verify_resp(vchnl_req, resp_len);
+	if (ret)
+		return ret;
+
+	ret = (int)vchnl_msg_resp->op_ret;
+	if (ret)
+		return ret;
+
+	vchnl_req->resp_len = 0;
+	if (vchnl_req->parm_len && vchnl_req->parm && resp_len) {
+		memcpy(vchnl_req->parm, vchnl_msg_resp->buf, resp_len);
+		vchnl_req->resp_len = resp_len;
+		ibdev_dbg(to_ibdev(dev), "VIRT: Got response, data size %u\n",
+			  resp_len);
+	}
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/irdma/virtchnl.h b/drivers/infiniband/hw/irdma/virtchnl.h
new file mode 100644
index 0000000..fb28fa0
--- /dev/null
+++ b/drivers/infiniband/hw/irdma/virtchnl.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* Copyright (c) 2015 - 2024 Intel Corporation */
+#ifndef IRDMA_VIRTCHNL_H
+#define IRDMA_VIRTCHNL_H
+
+#include "hmc.h"
+#include "irdma.h"
+
+/* IRDMA_VCHNL_CHNL_VER_V0 is for legacy hw, no longer supported. */
+#define IRDMA_VCHNL_CHNL_VER_V2 2
+#define IRDMA_VCHNL_CHNL_VER_MIN IRDMA_VCHNL_CHNL_VER_V2
+#define IRDMA_VCHNL_CHNL_VER_MAX IRDMA_VCHNL_CHNL_VER_V2
+#define IRDMA_VCHNL_OP_GET_HMC_FCN_V0 0
+#define IRDMA_VCHNL_OP_GET_HMC_FCN_V1 1
+#define IRDMA_VCHNL_OP_GET_HMC_FCN_V2 2
+#define IRDMA_VCHNL_OP_PUT_HMC_FCN_V0 0
+#define IRDMA_VCHNL_OP_GET_RDMA_CAPS_V0 0
+#define IRDMA_VCHNL_OP_GET_RDMA_CAPS_MIN_SIZE 1
+
+enum irdma_vchnl_ops {
+	IRDMA_VCHNL_OP_GET_VER = 0,
+	IRDMA_VCHNL_OP_GET_HMC_FCN = 1,
+	IRDMA_VCHNL_OP_PUT_HMC_FCN = 2,
+	IRDMA_VCHNL_OP_GET_RDMA_CAPS = 13,
+};
+
+struct irdma_vchnl_req_hmc_info {
+	u8 protocol_used;
+	u8 disable_qos;
+} __packed;
+
+struct irdma_vchnl_resp_hmc_info {
+	u16 hmc_func;
+	u16 qs_handle[IRDMA_MAX_USER_PRIORITY];
+} __packed;
+
+struct irdma_vchnl_op_buf {
+	u16 op_code;
+	u16 op_ver;
+	u16 buf_len;
+	u16 rsvd;
+	u64 op_ctx;
+	u8 buf[];
+} __packed;
+
+struct irdma_vchnl_resp_buf {
+	u64 op_ctx;
+	u16 buf_len;
+	s16 op_ret;
+	u16 rsvd[2];
+	u8 buf[];
+} __packed;
+
+struct irdma_vchnl_rdma_caps {
+	u8 hw_rev;
+	u16 cqp_timeout_s;
+	u16 cqp_def_timeout_s;
+	u16 max_hw_push_len;
+} __packed;
+
+struct irdma_vchnl_init_info {
+	struct workqueue_struct *vchnl_wq;
+	enum irdma_vers hw_rev;
+	bool privileged;
+	bool is_pf;
+};
+
+struct irdma_vchnl_req {
+	struct irdma_vchnl_op_buf *vchnl_msg;
+	void *parm;
+	u32 vf_id;
+	u16 parm_len;
+	u16 resp_len;
+};
+
+struct irdma_vchnl_req_init_info {
+	void *req_parm;
+	void *resp_parm;
+	u16 req_parm_len;
+	u16 resp_parm_len;
+	u16 op_code;
+	u16 op_ver;
+} __packed;
+
+int irdma_sc_vchnl_init(struct irdma_sc_dev *dev,
+			struct irdma_vchnl_init_info *info);
+int irdma_vchnl_send_sync(struct irdma_sc_dev *dev, u8 *msg, u16 len,
+			  u8 *recv_msg, u16 *recv_len);
+int irdma_vchnl_req_get_ver(struct irdma_sc_dev *dev, u16 ver_req,
+			    u32 *ver_res);
+int irdma_vchnl_req_get_hmc_fcn(struct irdma_sc_dev *dev);
+int irdma_vchnl_req_put_hmc_fcn(struct irdma_sc_dev *dev);
+int irdma_vchnl_req_get_caps(struct irdma_sc_dev *dev);
+int irdma_vchnl_req_get_resp(struct irdma_sc_dev *dev,
+			     struct irdma_vchnl_req *vc_req);
+#endif /* IRDMA_VIRTCHNL_H */
-- 
1.8.3.1


