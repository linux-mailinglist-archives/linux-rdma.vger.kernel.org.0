Return-Path: <linux-rdma+bounces-7549-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4DEA2CD33
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 20:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA291164C99
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 19:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28F01D63E5;
	Fri,  7 Feb 2025 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1/D7gXO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2561C32FF;
	Fri,  7 Feb 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957840; cv=none; b=j6PVwrRXtNq/fK0tHcm258lOAFd51pjcWSwq1zOZIC8SiGw5zxGioOEZ/9WQU3OQzLrOGjZUD+I3MRN1KccJ4GrVWAGwL1j2qZJsBn0hzbX8YeNdg1hheg0q/1jvP+tX1M1OoeX6A7cuRcydnaE40gjL+Qjb8VamuoZqhoRUv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957840; c=relaxed/simple;
	bh=HK4xdxQlDPR2lgYlMQU0vczuFT9fwLQwjb/aR5EAQKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hF6krmUEJ/JvNhIWO3cmGhFkhihv5v8wshOo1kBCMdH35Uoy769JhsRo2p3JBUw8H0UqGPBgFHeJlDVkSIs00+51n2GhnzN1+973mbBzNBiX+/IEGAue9tEX7OgTtyPhNA6vvBbWVZtiDwPZtz2ifNBwqOOBpFN9QeOCCeog5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1/D7gXO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738957839; x=1770493839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HK4xdxQlDPR2lgYlMQU0vczuFT9fwLQwjb/aR5EAQKM=;
  b=W1/D7gXOD2zDLm83hRF2exzW3raqTxz1ylyhA0doEzNj8pRqw5yMAlC6
   P0dDYiAjVbyYInUYjLE7bWWhm6g1dk3VGySU6cOfExKyc+L8O99GTNRWz
   FdKIyMqfN2cG83vhPblkeyasbly5r9r3d5YAf8qbjVmhpQRcmB+v5E3mD
   vki0VDWmsrlVZbqu0LY7xVu2UgGgFmofcDsLqQb8JeTyy6Z1jWJuFWz/H
   TfjR0HyobUNfi6X4q8/mKOqR+pk48dxztgGqPub965D8Wtlcu12WTZ0sV
   eVNBb67kZzD0UUqgFWAVtM4vj9EqWu4Z/F0iprr5lWECKkW6x5z8Pw3xl
   g==;
X-CSE-ConnectionGUID: 2xapFXXWTY6FjW/rjLPKRw==
X-CSE-MsgGUID: JWr7TJuzRPCwq2sAtOfDhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42451849"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42451849"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:34 -0800
X-CSE-ConnectionGUID: xrhlp6kiS02m/MqkhHAFKA==
X-CSE-MsgGUID: FtPfCKE9QzGslN5sDo7IdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112238274"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.81.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:33 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [rdma v3 20/24] RDMA/irdma: Restrict Memory Window and CQE Timestamping to GEN3
Date: Fri,  7 Feb 2025 13:49:27 -0600
Message-Id: <20250207194931.1569-21-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
References: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiraz Saleem <shiraz.saleem@intel.com>

With the deprecation of Memory Window and Timestamping support in GEN2,
move these features to be exclusive to GEN3. This iteration supports
only Type2 Memory Windows. Additionally, it includes the reporting of
the timestamp mask and Host Channel Adapter (HCA) core clock frequency
via the query device verb.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 42 ++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 4ab81bf60543..fc5b9b629a51 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -41,7 +41,8 @@ static int irdma_query_device(struct ib_device *ibdev,
 	props->max_cq = rf->max_cq - rf->used_cqs;
 	props->max_cqe = rf->max_cqe - 1;
 	props->max_mr = rf->max_mr - rf->used_mrs;
-	props->max_mw = props->max_mr;
+	if (hw_attrs->uk_attrs.hw_rev >= IRDMA_GEN_3)
+		props->max_mw = props->max_mr;
 	props->max_pd = rf->max_pd - rf->used_pds;
 	props->max_sge_rd = hw_attrs->uk_attrs.max_hw_read_sges;
 	props->max_qp_rd_atom = hw_attrs->max_hw_ird;
@@ -56,12 +57,16 @@ static int irdma_query_device(struct ib_device *ibdev,
 	props->max_mcast_qp_attach = IRDMA_MAX_MGS_PER_CTX;
 	props->max_total_mcast_qp_attach = rf->max_qp * IRDMA_MAX_MGS_PER_CTX;
 	props->max_fast_reg_page_list_len = IRDMA_MAX_PAGES_PER_FMR;
-#define HCA_CLOCK_TIMESTAMP_MASK 0x1ffff
-	if (hw_attrs->uk_attrs.hw_rev >= IRDMA_GEN_2)
-		props->timestamp_mask = HCA_CLOCK_TIMESTAMP_MASK;
 	props->max_srq = rf->max_srq - rf->used_srqs;
 	props->max_srq_wr = IRDMA_MAX_SRQ_WRS;
 	props->max_srq_sge = hw_attrs->uk_attrs.max_hw_wq_frags;
+	if (hw_attrs->uk_attrs.hw_rev >= IRDMA_GEN_3) {
+#define HCA_CORE_CLOCK_KHZ 1000000UL
+		props->timestamp_mask = GENMASK(31, 0);
+		props->hca_core_clock = HCA_CORE_CLOCK_KHZ;
+	}
+	if (hw_attrs->uk_attrs.hw_rev >= IRDMA_GEN_3)
+		props->device_cap_flags |= IB_DEVICE_MEM_WINDOW_TYPE_2B;
 
 	return 0;
 }
@@ -798,7 +803,8 @@ static void irdma_roce_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
 		roce_info->is_qp1 = true;
 	roce_info->rd_en = true;
 	roce_info->wr_rdresp_en = true;
-	roce_info->bind_en = true;
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3)
+		roce_info->bind_en = true;
 	roce_info->dcqcn_en = false;
 	roce_info->rtomin = 5;
 
@@ -829,7 +835,6 @@ static void irdma_iw_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
 	ether_addr_copy(iwarp_info->mac_addr, iwdev->netdev->dev_addr);
 	iwarp_info->rd_en = true;
 	iwarp_info->wr_rdresp_en = true;
-	iwarp_info->bind_en = true;
 	iwarp_info->ecn_en = true;
 	iwarp_info->rtomin = 5;
 
@@ -1147,8 +1152,6 @@ static int irdma_get_ib_acc_flags(struct irdma_qp *iwqp)
 		}
 		if (iwqp->iwarp_info.rd_en)
 			acc_flags |= IB_ACCESS_REMOTE_READ;
-		if (iwqp->iwarp_info.bind_en)
-			acc_flags |= IB_ACCESS_MW_BIND;
 	}
 	return acc_flags;
 }
@@ -2433,8 +2436,8 @@ static int irdma_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 
 static inline int cq_validate_flags(u32 flags, u8 hw_rev)
 {
-	/* GEN1 does not support CQ create flags */
-	if (hw_rev == IRDMA_GEN_1)
+	/* GEN1/2 does not support CQ create flags */
+	if (hw_rev <= IRDMA_GEN_2)
 		return flags ? -EOPNOTSUPP : 0;
 
 	return flags & ~IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION ? -EOPNOTSUPP : 0;
@@ -2660,8 +2663,9 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 /**
  * irdma_get_mr_access - get hw MR access permissions from IB access flags
  * @access: IB access flags
+ * @hw_rev: Hardware version
  */
-static inline u16 irdma_get_mr_access(int access)
+static inline u16 irdma_get_mr_access(int access, u8 hw_rev)
 {
 	u16 hw_access = 0;
 
@@ -2671,8 +2675,10 @@ static inline u16 irdma_get_mr_access(int access)
 		     IRDMA_ACCESS_FLAGS_REMOTEWRITE : 0;
 	hw_access |= (access & IB_ACCESS_REMOTE_READ) ?
 		     IRDMA_ACCESS_FLAGS_REMOTEREAD : 0;
-	hw_access |= (access & IB_ACCESS_MW_BIND) ?
-		     IRDMA_ACCESS_FLAGS_BIND_WINDOW : 0;
+	if (hw_rev >= IRDMA_GEN_3) {
+		hw_access |= (access & IB_ACCESS_MW_BIND) ?
+			     IRDMA_ACCESS_FLAGS_BIND_WINDOW : 0;
+	}
 	hw_access |= (access & IB_ZERO_BASED) ?
 		     IRDMA_ACCESS_FLAGS_ZERO_BASED : 0;
 	hw_access |= IRDMA_ACCESS_FLAGS_LOCALREAD;
@@ -3242,7 +3248,8 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	stag_info->stag_idx = iwmr->stag >> IRDMA_CQPSQ_STAG_IDX_S;
 	stag_info->stag_key = (u8)iwmr->stag;
 	stag_info->total_len = iwmr->len;
-	stag_info->access_rights = irdma_get_mr_access(access);
+	stag_info->access_rights = irdma_get_mr_access(access,
+						       iwdev->rf->sc_dev.hw_attrs.uk_attrs.hw_rev);
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
 	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	if (stag_info->access_rights & IRDMA_ACCESS_FLAGS_ZERO_BASED)
@@ -4027,7 +4034,9 @@ static int irdma_post_send(struct ib_qp *ibqp,
 
 			stag_info.signaled = info.signaled;
 			stag_info.read_fence = info.read_fence;
-			stag_info.access_rights = irdma_get_mr_access(reg_wr(ib_wr)->access);
+			stag_info.access_rights =
+				irdma_get_mr_access(reg_wr(ib_wr)->access,
+						    dev->hw_attrs.uk_attrs.hw_rev);
 			stag_info.stag_key = reg_wr(ib_wr)->key & 0xff;
 			stag_info.stag_idx = reg_wr(ib_wr)->key >> 8;
 			stag_info.page_size = reg_wr(ib_wr)->mr->page_size;
@@ -5230,7 +5239,9 @@ static const struct ib_device_ops irdma_gen1_dev_ops = {
 };
 
 static const struct ib_device_ops irdma_gen3_dev_ops = {
+	.alloc_mw = irdma_alloc_mw,
 	.create_srq = irdma_create_srq,
+	.dealloc_mw = irdma_dealloc_mw,
 	.destroy_srq = irdma_destroy_srq,
 	.modify_srq = irdma_modify_srq,
 	.post_srq_recv = irdma_post_srq_recv,
@@ -5271,7 +5282,6 @@ static const struct ib_device_ops irdma_dev_ops = {
 
 	.alloc_hw_port_stats = irdma_alloc_hw_port_stats,
 	.alloc_mr = irdma_alloc_mr,
-	.alloc_mw = irdma_alloc_mw,
 	.alloc_pd = irdma_alloc_pd,
 	.alloc_ucontext = irdma_alloc_ucontext,
 	.create_cq = irdma_create_cq,
-- 
2.37.3


