Return-Path: <linux-rdma+bounces-18203-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JQMoJ2JQuGmKcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18203-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:48:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 582B629F3CC
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B963D30985B8
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 18:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8C23E51D4;
	Mon, 16 Mar 2026 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njUxTBSh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C63E3C69
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686476; cv=none; b=SAhPD4G3yy1lsFAbKHMWnMeP6D0jU9SYggZVvgFh+JoV9nm3SADpAp4JLpFwhXCdGjHDF32yuz0tx566thJmppgWjiA+rf0oExlS1mmOTp+A0t2wHjdhqt5remi/oE5uku0kPKNFSfvyqjY1K91Q3TR+QQ3LyCm9gu3GxMwq84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686476; c=relaxed/simple;
	bh=s08eL5feQ2NvPP2nQC5ed1yakzxGJebiSd+GxC7Y/CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uS/ZZzekAIKZ8wOevg0OOu0UTOh/aai+9Feg8X4EB4pLTNa/Og1i3zBWLSfMybnqKVIFEthZiGISSrTDByg6/FsUa6W5pvPoNNMzXW+jPZ4Ppn5aaKQrUuzAXR/rcQLjX84ZuNNxbgKL0sbnRd1BIKKpzs+CeMoX6fhN5eVMFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njUxTBSh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773686470; x=1805222470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s08eL5feQ2NvPP2nQC5ed1yakzxGJebiSd+GxC7Y/CM=;
  b=njUxTBShS1avYM1O1obi5ZC2mZE/6l34F7KVIi8MIPWUg4uncx+UHuqW
   MUIkBeKE6djSMRFZpZ0uGLU6S8W6v9iAQL6wxFNhXjLcU0ByIZXd9R3kW
   OVnDDq4AaZ+InfQbR+nbbEI3BjMGXUWjJ36SxjV/dkXc/TtL3nM5ZRECO
   HhST4Cd52kNNNarKJkPMKA+jgpayOzIkaNJbW5Z8DjSkoszvNMGEuXH/m
   bXkvxyzBJorXcE45qeUYSomX3oh2oqpxRNGYZ/HqpSGTs/8rJ+0SbSnCf
   K2xMK4IfgJIRfVOStuVFs5UyxW6JHmOZEbrkfhgSrgorjGHdLLWvGWjBN
   w==;
X-CSE-ConnectionGUID: FrzyjpuWSEy2uFJI5Hn/2g==
X-CSE-MsgGUID: GbNHlhUKTZCcFOM6A8DqFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86067633"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86067633"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:54 -0700
X-CSE-ConnectionGUID: QoOSz2TvQCyT4E56EPFWeQ==
X-CSE-MsgGUID: GSGeV1tFR+WWmUjsdF63+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="252520447"
Received: from soc-pf51ragt.clients.intel.com ([10.122.184.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:52 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	Jay Bhat <jay.bhat@intel.com>
Subject: [for-next 11/12] RDMA/irdma: Provide scratch buffers to firmware for internal use
Date: Mon, 16 Mar 2026 13:39:48 -0500
Message-ID: <20260316183949.261-12-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
References: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18203-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[tatyana.e.nikolova@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 582B629F3CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jay Bhat <jay.bhat@intel.com>

For GEN3 and higher, FW requires scratch buffers for bookkeeping
during cleanup, specifically during QP and MR destroy ops.

Signed-off-by: Jay Bhat <jay.bhat@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c | 43 +++++++++++++++++++++++++++++-
 drivers/infiniband/hw/irdma/defs.h |  4 +++
 drivers/infiniband/hw/irdma/hw.c   | 11 ++++++++
 drivers/infiniband/hw/irdma/type.h |  2 ++
 drivers/infiniband/hw/irdma/user.h |  4 +--
 5 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 45c7433c96f3..13820f1a48a4 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -3570,6 +3570,41 @@ static int irdma_sc_parse_fpm_query_buf(struct irdma_sc_dev *dev, __le64 *buf,
 		hmc_fpm_misc->loc_mem_pages = (u32)FIELD_GET(IRDMA_QUERY_FPM_LOC_MEM_PAGES, temp);
 		if (!hmc_fpm_misc->loc_mem_pages)
 			return -EINVAL;
+
+		get_64bit_val(buf, 184, &temp);
+		if (temp) {
+			hmc_fpm_misc->fw_scratch_buf0.size = temp;
+			hmc_fpm_misc->fw_scratch_buf0.va =
+				dma_alloc_coherent(dev->hw->device,
+						   hmc_fpm_misc->fw_scratch_buf0.size,
+						   &hmc_fpm_misc->fw_scratch_buf0.pa,
+						   GFP_KERNEL);
+
+			if (!hmc_fpm_misc->fw_scratch_buf0.va) {
+				hmc_fpm_misc->fw_scratch_buf0.size = 0;
+				return -ENOMEM;
+			}
+		}
+		get_64bit_val(buf, 192, &temp);
+		if (temp) {
+			hmc_fpm_misc->fw_scratch_buf1.size = temp;
+			hmc_fpm_misc->fw_scratch_buf1.va =
+				dma_alloc_coherent(dev->hw->device,
+						   hmc_fpm_misc->fw_scratch_buf1.size,
+						   &hmc_fpm_misc->fw_scratch_buf1.pa,
+						   GFP_KERNEL);
+
+			if (!hmc_fpm_misc->fw_scratch_buf1.va) {
+				hmc_fpm_misc->fw_scratch_buf1.size = 0;
+				dma_free_coherent(dev->hw->device,
+						  hmc_fpm_misc->fw_scratch_buf0.size,
+						  hmc_fpm_misc->fw_scratch_buf0.va,
+						  hmc_fpm_misc->fw_scratch_buf0.pa);
+				hmc_fpm_misc->fw_scratch_buf0.va = NULL;
+				hmc_fpm_misc->fw_scratch_buf0.size = 0;
+				return -ENOMEM;
+			}
+		}
 	}
 
 	return 0;
@@ -4187,6 +4222,8 @@ static int irdma_sc_commit_fpm_val(struct irdma_sc_cqp *cqp, u64 scratch,
 
 	hdr = FIELD_PREP(IRDMA_CQPSQ_BUFSIZE, IRDMA_COMMIT_FPM_BUF_SIZE) |
 	      FIELD_PREP(IRDMA_CQPSQ_OPCODE, IRDMA_CQP_OP_COMMIT_FPM_VAL) |
+	      FIELD_PREP(IRDMA_CQPSQ_CFPM_FW_SCRATCH_BUF_PRESENT,
+			 cqp->dev->hmc_fpm_misc.fw_scratch_buf0.va != NULL) |
 	      FIELD_PREP(IRDMA_CQPSQ_WQEVALID, cqp->polarity);
 
 	dma_wmb(); /* make sure WQE is written before valid bit is set */
@@ -5034,7 +5071,9 @@ static void irdma_set_loc_mem(__le64 *buf)
 
 	for (offset = 0; offset < IRDMA_COMMIT_FPM_BUF_SIZE;
 	     offset += sizeof(__le64)) {
-		if (offset == IRDMA_PBLE_COMMIT_OFFSET)
+		if (offset == IRDMA_PBLE_COMMIT_OFFSET ||
+		    offset == IRDMA_SCRATCH_BUF0_COMMIT_OFFSET ||
+		    offset == IRDMA_SCRATCH_BUF1_COMMIT_OFFSET)
 			continue;
 		get_64bit_val(buf, offset, &temp);
 		if (temp)
@@ -5090,6 +5129,8 @@ static int irdma_sc_cfg_iw_fpm(struct irdma_sc_dev *dev, u8 hmc_fn_id)
 		      (u64)obj_info[IRDMA_HMC_IW_OOISC].cnt);
 	set_64bit_val(buf, 168,
 		      (u64)obj_info[IRDMA_HMC_IW_OOISCFFL].cnt);
+	set_64bit_val(buf, 192, dev->hmc_fpm_misc.fw_scratch_buf0.pa);
+	set_64bit_val(buf, 200, dev->hmc_fpm_misc.fw_scratch_buf1.pa);
 	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3 &&
 	    dev->hmc_fpm_misc.loc_mem_pages)
 		irdma_set_loc_mem(buf);
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index 983b22d7ae23..d6a3152959dd 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -133,6 +133,8 @@ enum irdma_protocol_used {
 #define MAX_MR_PER_SD			0x8000
 #define MAX_MR_SD_PER_FCN		0x80
 #define IRDMA_PBLE_COMMIT_OFFSET	112
+#define IRDMA_SCRATCH_BUF0_COMMIT_OFFSET 192
+#define IRDMA_SCRATCH_BUF1_COMMIT_OFFSET 200
 #define IRDMA_MAX_QUANTA_PER_WR	8
 
 #define IRDMA_QP_SW_MAX_WQ_QUANTA	32768
@@ -658,6 +660,8 @@ enum irdma_cqp_op_type {
 #define IRDMA_COMMIT_FPM_QPCNT GENMASK_ULL(20, 0)
 #define IRDMA_COMMIT_FPM_BASE_S 32
 #define IRDMA_CQPSQ_CFPM_HMCFNID GENMASK_ULL(15, 0)
+#define IRDMA_CQPSQ_CFPM_FW_SCRATCH_BUF_PRESENT_S 38
+#define IRDMA_CQPSQ_CFPM_FW_SCRATCH_BUF_PRESENT BIT_ULL(38)
 
 #define IRDMA_CQPSQ_FWQE_AECODE GENMASK_ULL(15, 0)
 #define IRDMA_CQPSQ_FWQE_AESOURCE GENMASK_ULL(19, 16)
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 3ba4809bc1ef..10eb21213cf9 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1693,6 +1693,8 @@ static int irdma_hmc_setup(struct irdma_pci_f *rf)
 static void irdma_del_init_mem(struct irdma_pci_f *rf)
 {
 	struct irdma_sc_dev *dev = &rf->sc_dev;
+	struct irdma_dma_mem *fw_scratch_buf0;
+	struct irdma_dma_mem *fw_scratch_buf1;
 
 	if (!rf->sc_dev.privileged)
 		irdma_vchnl_req_put_hmc_fcn(&rf->sc_dev);
@@ -1713,6 +1715,15 @@ static void irdma_del_init_mem(struct irdma_pci_f *rf)
 	rf->iw_msixtbl = NULL;
 	kfree(rf->hmc_info_mem);
 	rf->hmc_info_mem = NULL;
+
+	fw_scratch_buf0 = &dev->hmc_fpm_misc.fw_scratch_buf0;
+	fw_scratch_buf1 = &dev->hmc_fpm_misc.fw_scratch_buf1;
+	if (fw_scratch_buf0->va)
+		dma_free_coherent(dev->hw->device, fw_scratch_buf0->size,
+				  fw_scratch_buf0->va, fw_scratch_buf0->pa);
+	if (fw_scratch_buf1->va)
+		dma_free_coherent(dev->hw->device, fw_scratch_buf1->size,
+				  fw_scratch_buf1->va, fw_scratch_buf1->pa);
 }
 
 /**
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index da8c54d1f035..5557d9338796 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -622,6 +622,8 @@ struct irdma_hmc_fpm_misc {
 	u32 timer_bucket;
 	u32 rrf_block_size;
 	u32 ooiscf_block_size;
+	struct irdma_dma_mem fw_scratch_buf0;
+	struct irdma_dma_mem fw_scratch_buf1;
 };
 
 #define IRDMA_VCHNL_MAX_MSG_SIZE 512
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 9eb7fd0b1cbf..008af1acc928 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -159,8 +159,8 @@ enum irdma_device_caps_const {
 	IRDMA_CEQE_SIZE =			1,
 	IRDMA_CQP_CTX_SIZE =			8,
 	IRDMA_SHADOW_AREA_SIZE =		8,
-	IRDMA_QUERY_FPM_BUF_SIZE =		192,
-	IRDMA_COMMIT_FPM_BUF_SIZE =		192,
+	IRDMA_QUERY_FPM_BUF_SIZE =		200,
+	IRDMA_COMMIT_FPM_BUF_SIZE =		208,
 	IRDMA_GATHER_STATS_BUF_SIZE =		1024,
 	IRDMA_MIN_IW_QP_ID =			0,
 	IRDMA_MAX_IW_QP_ID =			262143,
-- 
2.31.1


