Return-Path: <linux-rdma+bounces-14746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2623C83253
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 03:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBD63AE26A
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 02:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8B41EB5FD;
	Tue, 25 Nov 2025 02:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kifYy7LZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9DB1E231E
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039302; cv=none; b=XfpY3CbqcK2GisJRTfu6PIEVHYPA4YN8ky7U8xgOnRJduxoYjzDXG6/4rXpSAlwRvaBecQ5xIN8mxJqo0OlocvRLOmBg1nOAoata9q85AL0hxlz4OoWJPxAwQLgGsGGIWxPVm9JB+P0V7lpEGzemVt10spW63v16m1+lvwRhHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039302; c=relaxed/simple;
	bh=d19eVDGjElZo0He0ayC8gKg4beAUYSYqWYPOYTEfFbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvYzIfC83S2RTD3Cr9rCpEWgZvPhO+tzKdBVD8x765FnwkKcgjv8ejTvIF6ibG2ON78PU0hiIl3as2X33Yjwfa5KOuLDyjceJ8PKwJjb7YLaCQhn2jPZLQaAx8hCgKOCpUTtwHDQW9ov3JinMyGZbp2NdkW8TdoOmGEgwjhPWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kifYy7LZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764039300; x=1795575300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d19eVDGjElZo0He0ayC8gKg4beAUYSYqWYPOYTEfFbg=;
  b=kifYy7LZNbDk9VHNs3Hr+q1ut60IN06hEPCymihCphdq0S2V5hDtZPJO
   1hdLga5ZpF9Zflgx3O4FWiiS+x+RNnPqyz2v7b3LRiLCcK9zu6lggFeZ/
   4y7Zhm2/LRWysUk166eZSchYq075P0E4zl6a0rSXL+W/gm0JEGdvCJtIm
   5qUiER2kfOxj1+aVD4RTwmQ8VEsooZ0Pyo6oK5GIYFQQ8p10mOavpgv3M
   y1GFe+8jAFAAo2JXJIvqyuBTLM9vJ5fZ5MWOhviKkmlLXmtRvBNjwY1k3
   KNITwJNDKmO0QhQy2Dt4lFtXwtMs+c4rLbYzd0D20u/Q2+J2h2voPmaDF
   A==;
X-CSE-ConnectionGUID: tSo0EObxScmAoetqmUXd2A==
X-CSE-MsgGUID: F+6aWovGQ1u25mnLZsHoQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65942215"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="65942215"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:59 -0800
X-CSE-ConnectionGUID: fG3uNuyMSu28i+ApSHyvvg==
X-CSE-MsgGUID: Zko0j/XGSaGlevBDpgM+qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="196800306"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:59 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	jmoroni@google.com
Subject: [PATCH 6/9] RDMA/irdma: Do not directly rely on IB_PD_UNSAFE_GLOBAL_RKEY
Date: Mon, 24 Nov 2025 20:53:47 -0600
Message-ID: <20251125025350.180-7-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251125025350.180-1-tatyana.e.nikolova@intel.com>
References: <20251125025350.180-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Moroni <jmoroni@google.com>

The HW disables bounds checking for MRs with a length of zero, so
the driver will only allow a zero length MR if the "all_memory"
flag is set, and this flag is only set if IB_PD_UNSAFE_GLOBAL_RKEY
is set for the PD.

This means that the "get_dma_mr" method will currently fail unless
the IB_PD_UNSAFE_GLOBAL_RKEY flag is set. This has not been an issue
because the "get_dma_mr" method is only ever invoked if the device
does not support the local DMA key or if IB_PD_UNSAFE_GLOBAL_RKEY
is set, and so far, all IRDMA HW supports the local DMA lkey.

However, some new HW does not support the local DMA lkey, so the
"get_dma_mr" method needs to work without IB_PD_UNSAFE_GLOBAL_RKEY
being set.

To support HW that does not allow the local DMA lkey, the logic has
been changed to pass an explicit flag to indicate when a dma_mr is
being created so that the zero length will be allowed.

Also, the "all_memory" flag has been forced to false for normal MR
allocation since these MRs are never supposed to provide global
unsafe rkey semantics anyway; only the MR created with "get_dma_mr"
should support this.

Fixes: bb6d73d9add6 ("RDMA/irdma: Prevent zero-length STAG registration")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/cm.c    |  2 +-
 drivers/infiniband/hw/irdma/main.h  |  2 +-
 drivers/infiniband/hw/irdma/verbs.c | 15 ++++++++-------
 drivers/infiniband/hw/irdma/verbs.h |  3 ++-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index c6a0a661d6e7..f4f4f92ba63a 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3710,7 +3710,7 @@ int irdma_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 	iwpd = iwqp->iwpd;
 	tagged_offset = (uintptr_t)iwqp->ietf_mem.va;
 	ibmr = irdma_reg_phys_mr(&iwpd->ibpd, iwqp->ietf_mem.pa, buf_len,
-				 IB_ACCESS_LOCAL_WRITE, &tagged_offset);
+				 IB_ACCESS_LOCAL_WRITE, &tagged_offset, false);
 	if (IS_ERR(ibmr)) {
 		ret = -ENOMEM;
 		goto error;
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index f22b1ee20fcc..baab61e424a2 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -556,7 +556,7 @@ void irdma_copy_ip_htonl(__be32 *dst, u32 *src);
 u16 irdma_get_vlan_ipv4(u32 *addr);
 void irdma_get_vlan_mac_ipv6(u32 *addr, u16 *vlan_id, u8 *mac);
 struct ib_mr *irdma_reg_phys_mr(struct ib_pd *ib_pd, u64 addr, u64 size,
-				int acc, u64 *iova_start);
+				int acc, u64 *iova_start, bool dma_mr);
 int irdma_upload_qp_context(struct irdma_qp *iwqp, bool freeze, bool raw);
 void irdma_cqp_ce_handler(struct irdma_pci_f *rf, struct irdma_sc_cq *cq);
 int irdma_ah_cqp_op(struct irdma_pci_f *rf, struct irdma_sc_ah *sc_ah, u8 cmd,
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index e35c8e87a756..695ff459e7ab 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3116,7 +3116,6 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 	info->stag_idx = iwmr->stag >> IRDMA_CQPSQ_STAG_IDX_S;
 	info->pd_id = iwpd->sc_pd.pd_id;
 	info->total_len = iwmr->len;
-	info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	info->remote_access = true;
 	cqp_info->cqp_cmd = IRDMA_OP_ALLOC_STAG;
 	cqp_info->post_sq = 1;
@@ -3127,7 +3126,7 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 	if (status)
 		return status;
 
-	iwmr->is_hwreg = 1;
+	iwmr->is_hwreg = true;
 	return 0;
 }
 
@@ -3270,7 +3269,7 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_ATOMIC_OPS)
 		stag_info->remote_atomics_en = (access & IB_ACCESS_REMOTE_ATOMIC) ? 1 : 0;
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
-	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
+	stag_info->all_memory = iwmr->dma_mr;
 	if (stag_info->access_rights & IRDMA_ACCESS_FLAGS_ZERO_BASED)
 		stag_info->addr_type = IRDMA_ADDR_TYPE_ZERO_BASED;
 	else
@@ -3297,7 +3296,7 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	irdma_put_cqp_request(&iwdev->rf->cqp, cqp_request);
 
 	if (!ret)
-		iwmr->is_hwreg = 1;
+		iwmr->is_hwreg = true;
 
 	return ret;
 }
@@ -3669,7 +3668,7 @@ static int irdma_hwdereg_mr(struct ib_mr *ib_mr)
 	if (status)
 		return status;
 
-	iwmr->is_hwreg = 0;
+	iwmr->is_hwreg = false;
 	return 0;
 }
 
@@ -3792,9 +3791,10 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
  * @size: size of memory to register
  * @access: Access rights
  * @iova_start: start of virtual address for physical buffers
+ * @dma_mr: Flag indicating whether this region is a PD DMA MR
  */
 struct ib_mr *irdma_reg_phys_mr(struct ib_pd *pd, u64 addr, u64 size, int access,
-				u64 *iova_start)
+				u64 *iova_start, bool dma_mr)
 {
 	struct irdma_device *iwdev = to_iwdev(pd->device);
 	struct irdma_pbl *iwpbl;
@@ -3811,6 +3811,7 @@ struct ib_mr *irdma_reg_phys_mr(struct ib_pd *pd, u64 addr, u64 size, int access
 	iwpbl = &iwmr->iwpbl;
 	iwpbl->iwmr = iwmr;
 	iwmr->type = IRDMA_MEMREG_TYPE_MEM;
+	iwmr->dma_mr = dma_mr;
 	iwpbl->user_base = *iova_start;
 	stag = irdma_create_stag(iwdev);
 	if (!stag) {
@@ -3849,7 +3850,7 @@ static struct ib_mr *irdma_get_dma_mr(struct ib_pd *pd, int acc)
 {
 	u64 kva = 0;
 
-	return irdma_reg_phys_mr(pd, 0, 0, acc, &kva);
+	return irdma_reg_phys_mr(pd, 0, 0, acc, &kva, true);
 }
 
 /**
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index ed21c1b56e8e..6c05179d4a31 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -111,7 +111,8 @@ struct irdma_mr {
 	};
 	struct ib_umem *region;
 	int access;
-	u8 is_hwreg;
+	bool is_hwreg:1;
+	bool dma_mr:1;
 	u16 type;
 	u32 page_cnt;
 	u64 page_size;
-- 
2.31.1


