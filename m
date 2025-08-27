Return-Path: <linux-rdma+bounces-12961-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FF7B386A2
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 17:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC0A367911
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 15:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178EE2874F6;
	Wed, 27 Aug 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnibO0ai"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6AE284882
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308422; cv=none; b=cLFVDTahufEnvmPcADiB9WvwzCjdMkg7C2hYvCZvWL7Gr0XHdgxxRIZ/9nUVCxv8KTnBoc1h4C/oZlozM//CYnniEaff8qiFT+x2D7baYePNdWf7kgnuZDvCfmbTd8q0VohC23RYFcqpzq5BsBO/pHXX2MWdDAz+9pHYJggudhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308422; c=relaxed/simple;
	bh=c93QHWvBoIbHmS1P9eTSaqNE4z65RFvxTaZThuyN4Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBtng5CnCteQcPc9LOHRUGSGKSDRj5+taUuDYpCOxdCehhoqxLJjIW3v9sZ5uJyq1QMQk9QMgM41RD4+iK2DnhbP4+tx+BakQO0z/ekA5GLTRu0dt0t6KQQm+AoqQiX5UimNEd49jGmBkQ4RTyl2KZ+aGrYHs3+MacjjKseVpT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GnibO0ai; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756308419; x=1787844419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c93QHWvBoIbHmS1P9eTSaqNE4z65RFvxTaZThuyN4Bk=;
  b=GnibO0ai4oT/2DCKyg+piAzpLfGYRNhrBTGfBYy/CwUBoM57lwde7XgR
   a/rXagXCtpQ+iibTQ7lrhsazvuTY12i+Eich2cpGmKwayAfOyYSGYp5D2
   dXQDrcOh4zyeXlNXonsTVZ0IduYCDKqsHJInsmBKOm2hvIGQCl91oKtex
   zTRkpyHkL9NYd7EB6DPH1JBrVDY5fCEKRvlxdyJJiz17dNHGjE4nnMiah
   LLnlXhw4tSCwgjiyjjaf7bMibqMEcDChXkPUJ0022nmqb2UTM2z7dQ54B
   dBFPgwG1iYqw7bJj/5m4AgNlDujfR3ufji/vOyLIM9jRAQKdyMpJAqpwe
   Q==;
X-CSE-ConnectionGUID: TaHX6gDpTcyFHJZuebi2BA==
X-CSE-MsgGUID: Tiwn+kpDTSOrlKFHA7M5Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76162780"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76162780"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:42 -0700
X-CSE-ConnectionGUID: kU6rQnv/QmejTlYOni9E3w==
X-CSE-MsgGUID: IQuwuMo+Rs+V/n2cV1clxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174206834"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:37 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 06/16] RDMA/irdma: Add GEN3 HW statistics support
Date: Wed, 27 Aug 2025 10:25:35 -0500
Message-ID: <20250827152545.2056-7-tatyana.e.nikolova@intel.com>
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

From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>

Plug into the unified HW statistics framework by adding a hardware
statistics map array for GEN3, defining the HW-specific width and
location for each counter in the statistics buffer.

Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c       |  33 +++++--
 drivers/infiniband/hw/irdma/defs.h       |   2 +-
 drivers/infiniband/hw/irdma/ig3rdma_hw.c |  63 +++++++++++++
 drivers/infiniband/hw/irdma/type.h       |  19 +++-
 drivers/infiniband/hw/irdma/verbs.c      | 110 +++++++++++++----------
 5 files changed, 166 insertions(+), 61 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 3f83ffaf448d..26b8905dbc03 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -1968,7 +1968,8 @@ int irdma_vsi_stats_init(struct irdma_sc_vsi *vsi,
 		(void *)((uintptr_t)stats_buff_mem->va +
 			 IRDMA_GATHER_STATS_BUF_SIZE);
 
-	irdma_hw_stats_start_timer(vsi);
+	if (vsi->dev->hw_attrs.uk_attrs.hw_rev < IRDMA_GEN_3)
+		irdma_hw_stats_start_timer(vsi);
 
 	/* when stat allocation is not required default to fcn_id. */
 	vsi->stats_idx = info->fcn_id;
@@ -2013,7 +2014,9 @@ void irdma_vsi_stats_free(struct irdma_sc_vsi *vsi)
 
 	if (!vsi->pestat)
 		return;
-	irdma_hw_stats_stop_timer(vsi);
+
+	if (dev->hw_attrs.uk_attrs.hw_rev < IRDMA_GEN_3)
+		irdma_hw_stats_stop_timer(vsi);
 	dma_free_coherent(vsi->pestat->hw->device,
 			  vsi->pestat->gather_info.stats_buff_mem.size,
 			  vsi->pestat->gather_info.stats_buff_mem.va,
@@ -5929,14 +5932,26 @@ void irdma_cfg_aeq(struct irdma_sc_dev *dev, u32 idx, bool enable)
  */
 void sc_vsi_update_stats(struct irdma_sc_vsi *vsi)
 {
-	struct irdma_gather_stats *gather_stats;
-	struct irdma_gather_stats *last_gather_stats;
+	struct irdma_dev_hw_stats *hw_stats = &vsi->pestat->hw_stats;
+	struct irdma_gather_stats *gather_stats =
+		vsi->pestat->gather_info.gather_stats_va;
+	struct irdma_gather_stats *last_gather_stats =
+		vsi->pestat->gather_info.last_gather_stats_va;
+	const struct irdma_hw_stat_map *map = vsi->dev->hw_stats_map;
+	u16 max_stat_idx = vsi->dev->hw_attrs.max_stat_idx;
+	u16 i;
+
+	if (vsi->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3) {
+		for (i = 0; i < max_stat_idx; i++) {
+			u16 idx = map[i].byteoff / sizeof(u64);
+
+			hw_stats->stats_val[i] = gather_stats->val[idx];
+		}
+		return;
+	}
 
-	gather_stats = vsi->pestat->gather_info.gather_stats_va;
-	last_gather_stats = vsi->pestat->gather_info.last_gather_stats_va;
-	irdma_update_stats(&vsi->pestat->hw_stats, gather_stats,
-			   last_gather_stats, vsi->dev->hw_stats_map,
-			   vsi->dev->hw_attrs.max_stat_idx);
+	irdma_update_stats(hw_stats, gather_stats, last_gather_stats,
+			   map, max_stat_idx);
 }
 
 /**
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index 52ace06912eb..2fc8e3cf4395 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -415,7 +415,7 @@ enum irdma_cqp_op_type {
 #define IRDMA_CQPSQ_STATS_USE_INST BIT_ULL(61)
 #define IRDMA_CQPSQ_STATS_OP GENMASK_ULL(37, 32)
 #define IRDMA_CQPSQ_STATS_INST_INDEX GENMASK_ULL(6, 0)
-#define IRDMA_CQPSQ_STATS_HMC_FCN_INDEX GENMASK_ULL(5, 0)
+#define IRDMA_CQPSQ_STATS_HMC_FCN_INDEX GENMASK_ULL(15, 0)
 #define IRDMA_CQPSQ_WS_WQEVALID BIT_ULL(63)
 #define IRDMA_CQPSQ_WS_NODEOP GENMASK_ULL(55, 52)
 #define IRDMA_SD_MAX GENMASK_ULL(15, 0)
diff --git a/drivers/infiniband/hw/irdma/ig3rdma_hw.c b/drivers/infiniband/hw/irdma/ig3rdma_hw.c
index 1d582c50e4d2..2a3d7144c771 100644
--- a/drivers/infiniband/hw/irdma/ig3rdma_hw.c
+++ b/drivers/infiniband/hw/irdma/ig3rdma_hw.c
@@ -48,9 +48,70 @@ static const struct irdma_irq_ops ig3rdma_irq_ops = {
 	.irdma_en_irq = ig3rdma_ena_irq,
 };
 
+static const struct irdma_hw_stat_map ig3rdma_hw_stat_map[] = {
+	[IRDMA_HW_STAT_INDEX_RXVLANERR] =	{   0, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP4RXOCTS] =	{   8, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP4RXPKTS] =	{  16, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP4RXDISCARD] =	{  24, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP4RXTRUNC] =	{  32, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP4RXFRAGS] =	{  40, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP4RXMCOCTS] =	{  48, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP4RXMCPKTS] =	{  56, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP6RXOCTS] =	{  64, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP6RXPKTS] =	{  72, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP6RXDISCARD] =	{  80, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP6RXTRUNC] =	{  88, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP6RXFRAGS] =	{  96, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP6RXMCOCTS] =	{ 104, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP6RXMCPKTS] =	{ 112, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP4TXOCTS] =	{ 120, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP4TXPKTS] =	{ 128, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP4TXFRAGS] =	{ 136, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP4TXMCOCTS] =	{ 144, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP4TXMCPKTS] =	{ 152, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP6TXOCTS] =	{ 160, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP6TXPKTS] =	{ 168, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP6TXFRAGS] =	{ 176, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP6TXMCOCTS] =	{ 184, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP6TXMCPKTS] =	{ 192, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP4TXNOROUTE] =	{ 200, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_IP6TXNOROUTE] =	{ 208, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_TCPRTXSEG] =	{ 216, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_TCPRXOPTERR] =	{ 224, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_TCPRXPROTOERR] =	{ 232, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_TCPTXSEG] =	{ 240, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_TCPRXSEGS] =	{ 248, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_UDPRXPKTS] =	{ 256, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_UDPTXPKTS] =	{ 264, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RDMARXWRS] =	{ 272, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RDMARXRDS] =	{ 280, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RDMARXSNDS] =	{ 288, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RDMATXWRS] =	{ 296, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RDMATXRDS] =	{ 304, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RDMATXSNDS] =	{ 312, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RDMAVBND] =	{ 320, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RDMAVINV] =	{ 328, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RXNPECNMARKEDPKTS] = { 336, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RXRPCNPHANDLED] =	{ 344, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RXRPCNPIGNORED] =	{ 352, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_TXNPCNPSENT] =	{ 360, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RNR_SENT] =	{ 368, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RNR_RCVD] =	{ 376, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RDMAORDLMTCNT] =	{ 384, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RDMAIRDLMTCNT] =	{ 392, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RDMARXATS] =	{ 408, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RDMATXATS] =	{ 416, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_NAKSEQERR] =	{ 424, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_NAKSEQERR_IMPLIED] = { 432, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RTO] =		{ 440, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_RXOOOPKTS] =	{ 448, 0, 0 },
+	[IRDMA_HW_STAT_INDEX_ICRCERR] =		{ 456, 0, 0 },
+};
+
 void ig3rdma_init_hw(struct irdma_sc_dev *dev)
 {
 	dev->irq_ops = &ig3rdma_irq_ops;
+	dev->hw_stats_map = ig3rdma_hw_stat_map;
 
 	dev->hw_attrs.uk_attrs.hw_rev = IRDMA_GEN_3;
 	dev->hw_attrs.uk_attrs.max_hw_wq_frags = IG3RDMA_MAX_WQ_FRAGMENT_COUNT;
@@ -70,6 +131,8 @@ void ig3rdma_init_hw(struct irdma_sc_dev *dev)
 	dev->hw_attrs.page_size_cap = SZ_4K | SZ_2M | SZ_1G;
 	dev->hw_attrs.max_hw_ird = IG3RDMA_MAX_IRD_SIZE;
 	dev->hw_attrs.max_hw_ord = IG3RDMA_MAX_ORD_SIZE;
+	dev->hw_attrs.max_stat_inst = IG3RDMA_MAX_STATS_COUNT;
+	dev->hw_attrs.max_stat_idx = IRDMA_HW_STAT_INDEX_MAX_GEN_3;
 	dev->hw_attrs.uk_attrs.min_hw_wq_size = IG3RDMA_MIN_WQ_SIZE;
 	dev->hw_attrs.uk_attrs.max_hw_srq_quanta = IRDMA_SRQ_MAX_QUANTA;
 	dev->hw_attrs.uk_attrs.max_hw_inline = IG3RDMA_MAX_INLINE_DATA_SIZE;
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 875e3756aa20..5eeb50f5defc 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -156,6 +156,21 @@ enum irdma_hw_stats_index {
 	IRDMA_HW_STAT_INDEX_RXRPCNPIGNORED      = 44,
 	IRDMA_HW_STAT_INDEX_TXNPCNPSENT         = 45,
 	IRDMA_HW_STAT_INDEX_MAX_GEN_2		= 46,
+
+	/* gen3 */
+	IRDMA_HW_STAT_INDEX_RNR_SENT		= 46,
+	IRDMA_HW_STAT_INDEX_RNR_RCVD		= 47,
+	IRDMA_HW_STAT_INDEX_RDMAORDLMTCNT	= 48,
+	IRDMA_HW_STAT_INDEX_RDMAIRDLMTCNT	= 49,
+	IRDMA_HW_STAT_INDEX_RDMARXATS		= 50,
+	IRDMA_HW_STAT_INDEX_RDMATXATS		= 51,
+	IRDMA_HW_STAT_INDEX_NAKSEQERR		= 52,
+	IRDMA_HW_STAT_INDEX_NAKSEQERR_IMPLIED	= 53,
+	IRDMA_HW_STAT_INDEX_RTO			= 54,
+	IRDMA_HW_STAT_INDEX_RXOOOPKTS		= 55,
+	IRDMA_HW_STAT_INDEX_ICRCERR		= 56,
+
+	IRDMA_HW_STAT_INDEX_MAX_GEN_3		= 57,
 };
 
 enum irdma_feature_type {
@@ -569,7 +584,7 @@ struct irdma_sc_qp {
 struct irdma_stats_inst_info {
 	bool use_hmc_fcn_index;
 	u8 hmc_fn_id;
-	u8 stats_idx;
+	u16 stats_idx;
 };
 
 struct irdma_up_info {
@@ -1027,7 +1042,7 @@ struct irdma_qp_host_ctx_info {
 	u32 send_cq_num;
 	u32 rcv_cq_num;
 	u32 rem_endpoint_idx;
-	u8 stats_idx;
+	u16 stats_idx;
 	bool srq_valid:1;
 	bool tcp_info_valid:1;
 	bool iwarp_info_valid:1;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 1bee1cbf7a4d..894c1f7bcb43 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3923,40 +3923,7 @@ static int irdma_req_notify_cq(struct ib_cq *ibcq,
 	return ret;
 }
 
-static int irdma_roce_port_immutable(struct ib_device *ibdev, u32 port_num,
-				     struct ib_port_immutable *immutable)
-{
-	struct ib_port_attr attr;
-	int err;
-
-	immutable->core_cap_flags = RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
-	err = ib_query_port(ibdev, port_num, &attr);
-	if (err)
-		return err;
-
-	immutable->max_mad_size = IB_MGMT_MAD_SIZE;
-	immutable->pkey_tbl_len = attr.pkey_tbl_len;
-	immutable->gid_tbl_len = attr.gid_tbl_len;
-
-	return 0;
-}
-
-static int irdma_iw_port_immutable(struct ib_device *ibdev, u32 port_num,
-				   struct ib_port_immutable *immutable)
-{
-	struct ib_port_attr attr;
-	int err;
-
-	immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
-	err = ib_query_port(ibdev, port_num, &attr);
-	if (err)
-		return err;
-	immutable->gid_tbl_len = attr.gid_tbl_len;
-
-	return 0;
-}
-
-static const struct rdma_stat_desc irdma_hw_stat_names[] = {
+static const struct rdma_stat_desc irdma_hw_stat_descs[] = {
 	/* gen1 - 32-bit */
 	[IRDMA_HW_STAT_INDEX_IP4RXDISCARD].name		= "ip4InDiscards",
 	[IRDMA_HW_STAT_INDEX_IP4RXTRUNC].name		= "ip4InTruncatedPkts",
@@ -3964,9 +3931,6 @@ static const struct rdma_stat_desc irdma_hw_stat_names[] = {
 	[IRDMA_HW_STAT_INDEX_IP6RXDISCARD].name		= "ip6InDiscards",
 	[IRDMA_HW_STAT_INDEX_IP6RXTRUNC].name		= "ip6InTruncatedPkts",
 	[IRDMA_HW_STAT_INDEX_IP6TXNOROUTE].name		= "ip6OutNoRoutes",
-	[IRDMA_HW_STAT_INDEX_TCPRTXSEG].name		= "tcpRetransSegs",
-	[IRDMA_HW_STAT_INDEX_TCPRXOPTERR].name		= "tcpInOptErrors",
-	[IRDMA_HW_STAT_INDEX_TCPRXPROTOERR].name	= "tcpInProtoErrors",
 	[IRDMA_HW_STAT_INDEX_RXVLANERR].name		= "rxVlanErrors",
 	/* gen1 - 64-bit */
 	[IRDMA_HW_STAT_INDEX_IP4RXOCTS].name		= "ip4InOctets",
@@ -3985,16 +3949,14 @@ static const struct rdma_stat_desc irdma_hw_stat_names[] = {
 	[IRDMA_HW_STAT_INDEX_IP6TXPKTS].name		= "ip6OutPkts",
 	[IRDMA_HW_STAT_INDEX_IP6TXFRAGS].name		= "ip6OutSegRqd",
 	[IRDMA_HW_STAT_INDEX_IP6TXMCPKTS].name		= "ip6OutMcastPkts",
-	[IRDMA_HW_STAT_INDEX_TCPRXSEGS].name		= "tcpInSegs",
-	[IRDMA_HW_STAT_INDEX_TCPTXSEG].name		= "tcpOutSegs",
-	[IRDMA_HW_STAT_INDEX_RDMARXRDS].name		= "iwInRdmaReads",
-	[IRDMA_HW_STAT_INDEX_RDMARXSNDS].name		= "iwInRdmaSends",
-	[IRDMA_HW_STAT_INDEX_RDMARXWRS].name		= "iwInRdmaWrites",
-	[IRDMA_HW_STAT_INDEX_RDMATXRDS].name		= "iwOutRdmaReads",
-	[IRDMA_HW_STAT_INDEX_RDMATXSNDS].name		= "iwOutRdmaSends",
-	[IRDMA_HW_STAT_INDEX_RDMATXWRS].name		= "iwOutRdmaWrites",
-	[IRDMA_HW_STAT_INDEX_RDMAVBND].name		= "iwRdmaBnd",
-	[IRDMA_HW_STAT_INDEX_RDMAVINV].name		= "iwRdmaInv",
+	[IRDMA_HW_STAT_INDEX_RDMARXRDS].name		= "InRdmaReads",
+	[IRDMA_HW_STAT_INDEX_RDMARXSNDS].name		= "InRdmaSends",
+	[IRDMA_HW_STAT_INDEX_RDMARXWRS].name		= "InRdmaWrites",
+	[IRDMA_HW_STAT_INDEX_RDMATXRDS].name		= "OutRdmaReads",
+	[IRDMA_HW_STAT_INDEX_RDMATXSNDS].name		= "OutRdmaSends",
+	[IRDMA_HW_STAT_INDEX_RDMATXWRS].name		= "OutRdmaWrites",
+	[IRDMA_HW_STAT_INDEX_RDMAVBND].name		= "RdmaBnd",
+	[IRDMA_HW_STAT_INDEX_RDMAVINV].name		= "RdmaInv",
 
 	/* gen2 - 32-bit */
 	[IRDMA_HW_STAT_INDEX_RXRPCNPHANDLED].name	= "cnpHandled",
@@ -4008,9 +3970,59 @@ static const struct rdma_stat_desc irdma_hw_stat_names[] = {
 	[IRDMA_HW_STAT_INDEX_UDPRXPKTS].name		= "RxUDP",
 	[IRDMA_HW_STAT_INDEX_UDPTXPKTS].name		= "TxUDP",
 	[IRDMA_HW_STAT_INDEX_RXNPECNMARKEDPKTS].name	= "RxECNMrkd",
-
+	[IRDMA_HW_STAT_INDEX_TCPRTXSEG].name		= "RetransSegs",
+	[IRDMA_HW_STAT_INDEX_TCPRXOPTERR].name		= "InOptErrors",
+	[IRDMA_HW_STAT_INDEX_TCPRXPROTOERR].name	= "InProtoErrors",
+	[IRDMA_HW_STAT_INDEX_TCPRXSEGS].name		= "InSegs",
+	[IRDMA_HW_STAT_INDEX_TCPTXSEG].name		= "OutSegs",
+
+	/* gen3 */
+	[IRDMA_HW_STAT_INDEX_RNR_SENT].name		= "RNR sent",
+	[IRDMA_HW_STAT_INDEX_RNR_RCVD].name		= "RNR received",
+	[IRDMA_HW_STAT_INDEX_RDMAORDLMTCNT].name	= "ord limit count",
+	[IRDMA_HW_STAT_INDEX_RDMAIRDLMTCNT].name	= "ird limit count",
+	[IRDMA_HW_STAT_INDEX_RDMARXATS].name		= "Rx atomics",
+	[IRDMA_HW_STAT_INDEX_RDMATXATS].name		= "Tx atomics",
+	[IRDMA_HW_STAT_INDEX_NAKSEQERR].name		= "Nak Sequence Error",
+	[IRDMA_HW_STAT_INDEX_NAKSEQERR_IMPLIED].name	= "Nak Sequence Error Implied",
+	[IRDMA_HW_STAT_INDEX_RTO].name			= "RTO",
+	[IRDMA_HW_STAT_INDEX_RXOOOPKTS].name		= "Rcvd Out of order packets",
+	[IRDMA_HW_STAT_INDEX_ICRCERR].name		= "CRC errors",
 };
 
+static int irdma_roce_port_immutable(struct ib_device *ibdev, u32 port_num,
+				     struct ib_port_immutable *immutable)
+{
+	struct ib_port_attr attr;
+	int err;
+
+	immutable->core_cap_flags = RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
+	err = ib_query_port(ibdev, port_num, &attr);
+	if (err)
+		return err;
+
+	immutable->max_mad_size = IB_MGMT_MAD_SIZE;
+	immutable->pkey_tbl_len = attr.pkey_tbl_len;
+	immutable->gid_tbl_len = attr.gid_tbl_len;
+
+	return 0;
+}
+
+static int irdma_iw_port_immutable(struct ib_device *ibdev, u32 port_num,
+				   struct ib_port_immutable *immutable)
+{
+	struct ib_port_attr attr;
+	int err;
+
+	immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
+	err = ib_query_port(ibdev, port_num, &attr);
+	if (err)
+		return err;
+	immutable->gid_tbl_len = attr.gid_tbl_len;
+
+	return 0;
+}
+
 static void irdma_get_dev_fw_str(struct ib_device *dev, char *str)
 {
 	struct irdma_device *iwdev = to_iwdev(dev);
@@ -4034,7 +4046,7 @@ static struct rdma_hw_stats *irdma_alloc_hw_port_stats(struct ib_device *ibdev,
 	int num_counters = dev->hw_attrs.max_stat_idx;
 	unsigned long lifespan = RDMA_HW_STATS_DEFAULT_LIFESPAN;
 
-	return rdma_alloc_hw_stats_struct(irdma_hw_stat_names, num_counters,
+	return rdma_alloc_hw_stats_struct(irdma_hw_stat_descs, num_counters,
 					  lifespan);
 }
 
-- 
2.42.0


