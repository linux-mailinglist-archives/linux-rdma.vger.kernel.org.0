Return-Path: <linux-rdma+bounces-4550-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8AE95DAFA
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 05:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86846281CA1
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 03:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3257DA74;
	Sat, 24 Aug 2024 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4mFt03e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEAC7DA8F;
	Sat, 24 Aug 2024 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469656; cv=none; b=nEE/Q1LepfF2S44rVjrFyOv1HTiFpZW2TeOyNQ6K6b58twX0B/zANjx0Ynd2orBVZq+tS7rQypFa9P8adxR9SPTj+XgAYLk7Ql9R2xoAsDZ1Rp+Icerx9TO2sasMCua3d8/Kve0Wy7je9/6HfOwU+zxI2Z3Xh46SzWxLykvnDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469656; c=relaxed/simple;
	bh=F1j/SJFc7xTc36c5OvZ6+87X2uuK24+pWbCVV6hccWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RdCfARqoh9bvNEPRXluo7Lpjb/0P9vTOV08C6pE11YZkY96nDxXMjgxpvnTIozokMR0D/Z2pipFRSPy7M0f1jkFkSW8U433q9ifzsRXNFwr2zPsimO6ky3fG/E0oXqKRW2RmsCl2qClgw6BKT48TFYL26lJkpqx6L8R7mBhlXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4mFt03e; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724469655; x=1756005655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F1j/SJFc7xTc36c5OvZ6+87X2uuK24+pWbCVV6hccWw=;
  b=c4mFt03eqV3nuuV/nERmxEE/jK7tHLV8vrv+6oq21b/TxV5M9+n5JoYs
   lsDgxAgk9zof/LXawJGB2R1mFJ+OJNfjn1DDBwBXD6Z0JTspBcGlulM1H
   EP4eQ8sKoX8dfUrAzrfsCkiKlDElxAd3hFP7FyCRJ0/AOeqGQk1Ikjz90
   W44UtkeohRx87WJOsnkFFYvL1bfi0B0LcpXJSJ1BPg0XHX3rsfcvh+t86
   HwTtHHXVanbfhhtEjaI4BmZEANCV7X13eFErHS4qgR1xpA4KI/YBIxoqq
   q/PY1LTxmkO2X8IjWELrM2IrEsibpc+z4H0R1mVV5kvxi+eJ+16E545gu
   Q==;
X-CSE-ConnectionGUID: rNLyG6+uRx2CrNeix6R8EQ==
X-CSE-MsgGUID: Xv/+zskfQwOcRODwTROn/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="13187828"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="13187828"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:50 -0700
X-CSE-ConnectionGUID: DVSdMZJiQiyN8hGP5fRLAA==
X-CSE-MsgGUID: dz1+YSGiQbqfSPEawcpexA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="99492139"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.36.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:50 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC v2 21/25] RDMA/irdma: Restrict Memory Window and CQE Timestamping to GEN3
Date: Fri, 23 Aug 2024 22:19:20 -0500
Message-Id: <20240824031924.421-22-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
References: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
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
 drivers/infiniband/hw/irdma/verbs.c | 39 +++++++++++++++++++----------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 9d08937848bc..66e67be2e67b 100644
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
@@ -59,6 +60,13 @@ static int irdma_query_device(struct ib_device *ibdev,
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
@@ -795,7 +803,8 @@ static void irdma_roce_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
 		roce_info->is_qp1 = true;
 	roce_info->rd_en = true;
 	roce_info->wr_rdresp_en = true;
-	roce_info->bind_en = true;
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3)
+		roce_info->bind_en = true;
 	roce_info->dcqcn_en = false;
 	roce_info->rtomin = 5;
 
@@ -826,7 +835,6 @@ static void irdma_iw_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
 	ether_addr_copy(iwarp_info->mac_addr, iwdev->netdev->dev_addr);
 	iwarp_info->rd_en = true;
 	iwarp_info->wr_rdresp_en = true;
-	iwarp_info->bind_en = true;
 	iwarp_info->ecn_en = true;
 	iwarp_info->rtomin = 5;
 
@@ -1144,8 +1152,6 @@ static int irdma_get_ib_acc_flags(struct irdma_qp *iwqp)
 		}
 		if (iwqp->iwarp_info.rd_en)
 			acc_flags |= IB_ACCESS_REMOTE_READ;
-		if (iwqp->iwarp_info.bind_en)
-			acc_flags |= IB_ACCESS_MW_BIND;
 	}
 	return acc_flags;
 }
@@ -2425,8 +2431,8 @@ static int irdma_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 
 static inline int cq_validate_flags(u32 flags, u8 hw_rev)
 {
-	/* GEN1 does not support CQ create flags */
-	if (hw_rev == IRDMA_GEN_1)
+	/* GEN1/2 does not support CQ create flags */
+	if (hw_rev <= IRDMA_GEN_2)
 		return flags ? -EOPNOTSUPP : 0;
 
 	return flags & ~IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION ? -EOPNOTSUPP : 0;
@@ -2648,8 +2654,9 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 /**
  * irdma_get_mr_access - get hw MR access permissions from IB access flags
  * @access: IB access flags
+ * @hw_rev: Hardware version
  */
-static inline u16 irdma_get_mr_access(int access)
+static inline u16 irdma_get_mr_access(int access, u8 hw_rev)
 {
 	u16 hw_access = 0;
 
@@ -2659,8 +2666,10 @@ static inline u16 irdma_get_mr_access(int access)
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
@@ -3230,7 +3239,8 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	stag_info->stag_idx = iwmr->stag >> IRDMA_CQPSQ_STAG_IDX_S;
 	stag_info->stag_key = (u8)iwmr->stag;
 	stag_info->total_len = iwmr->len;
-	stag_info->access_rights = irdma_get_mr_access(access);
+	stag_info->access_rights = irdma_get_mr_access(access,
+						       iwdev->rf->sc_dev.hw_attrs.uk_attrs.hw_rev);
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
 	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	if (stag_info->access_rights & IRDMA_ACCESS_FLAGS_ZERO_BASED)
@@ -4015,7 +4025,9 @@ static int irdma_post_send(struct ib_qp *ibqp,
 
 			stag_info.signaled = info.signaled;
 			stag_info.read_fence = info.read_fence;
-			stag_info.access_rights = irdma_get_mr_access(reg_wr(ib_wr)->access);
+			stag_info.access_rights =
+				irdma_get_mr_access(reg_wr(ib_wr)->access,
+						    dev->hw_attrs.uk_attrs.hw_rev);
 			stag_info.stag_key = reg_wr(ib_wr)->key & 0xff;
 			stag_info.stag_idx = reg_wr(ib_wr)->key >> 8;
 			stag_info.page_size = reg_wr(ib_wr)->mr->page_size;
@@ -5218,7 +5230,9 @@ static const struct ib_device_ops irdma_gen1_dev_ops = {
 };
 
 static const struct ib_device_ops irdma_gen3_dev_ops = {
+	.alloc_mw = irdma_alloc_mw,
 	.create_srq = irdma_create_srq,
+	.dealloc_mw = irdma_dealloc_mw,
 	.destroy_srq = irdma_destroy_srq,
 	.modify_srq = irdma_modify_srq,
 	.post_srq_recv = irdma_post_srq_recv,
@@ -5259,7 +5273,6 @@ static const struct ib_device_ops irdma_dev_ops = {
 
 	.alloc_hw_port_stats = irdma_alloc_hw_port_stats,
 	.alloc_mr = irdma_alloc_mr,
-	.alloc_mw = irdma_alloc_mw,
 	.alloc_pd = irdma_alloc_pd,
 	.alloc_ucontext = irdma_alloc_ucontext,
 	.create_cq = irdma_create_cq,
-- 
2.42.0


