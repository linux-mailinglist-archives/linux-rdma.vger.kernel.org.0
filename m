Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211AC6BB6BF
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 15:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjCOO5L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 10:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjCOO4u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 10:56:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1026624BDD
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678892176; x=1710428176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KCmkP9idVe4VufdazH6NwfH791LNMWW1w2uFfa+t/eo=;
  b=igyR31WiTSf7ayxEPntwABLfLjAdlhgvEbSHgJKIFQcBpWXzasWzCm60
   yQKTCmPGbmPypNiWKw3xhCVhglsgyiy+IAvgg2ZsvE3cgsRCwGeIW4pau
   wYc8PbaXUomJYgKTrozAawIqz7+b8KBk53x9Q50pWvgohlzKDDUKVApUQ
   N8UYoXYstbww+FI8oAeqzcEC8OsPs0WrWcRAaxdXftpp5CkDSkvd1OMAK
   CpfX8xTzoS65Lg4ZpGHY73MpxlS2rUwY7SXc47AgpjPM0OnLdlBlPSB8d
   +Cm7na5OAtGGcipn3o59wtE+4l9rqvoJb5D3i1OApsfo0/AeyjZsuRZSk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321561719"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321561719"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="743714343"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="743714343"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.35.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:53:30 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 1/4] RDMA/irdma: Refactor HW statistics
Date:   Wed, 15 Mar 2023 09:53:02 -0500
Message-Id: <20230315145305.955-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230315145305.955-1-shiraz.saleem@intel.com>
References: <20230315145305.955-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>

Refactor HW statistics which,

- Unifies HW statistics support for all HW generations.

- Unifies support of 32- and 64-bit counters.

- Removes duplicated code and simplifies implementation.

- Fixes roll-over handling.

- Removes unneeded last_hw_stats.

With new implementation, there is no separate handling and no separate
arrays for 32- and 64-bit counters (offsets, regs, values). Instead,
there is a HW stats map array for each HW revision, which defines
HW-specific width and location of each counter in the statistics buffer.

Once the statistics are gathered (either via CQP op, or by reading HW
registers), counter values are extracted from the statistics buffer using
the stats map and the delta between the last and new values is computed.
Finally, the counter values in rdma_hw_stats are incremented by those
deltas.

From the OS perspective, all the counters are 64-bit and their order in
rdma_hw_stats->value[] array, as well as in irdma_hw_stat_names[], is the
same for all HW gens.  New statistics should always be added at the end.

Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Youvaraj Sagar <youvaraj.sagar@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c      | 324 +++++++++++---------------------
 drivers/infiniband/hw/irdma/defs.h      |   9 +-
 drivers/infiniband/hw/irdma/i40iw_hw.c  |  60 +++++-
 drivers/infiniband/hw/irdma/icrdma_hw.c |  51 +++++
 drivers/infiniband/hw/irdma/irdma.h     |   1 +
 drivers/infiniband/hw/irdma/protos.h    |   8 +-
 drivers/infiniband/hw/irdma/type.h      | 166 ++++++----------
 drivers/infiniband/hw/irdma/utils.c     | 172 ++---------------
 drivers/infiniband/hw/irdma/verbs.c     | 151 ++++++---------
 9 files changed, 362 insertions(+), 580 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index a41e0d2..d88c918 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -1867,8 +1867,6 @@ void irdma_sc_vsi_init(struct irdma_sc_vsi  *vsi,
 	vsi->mtu = info->params->mtu;
 	vsi->exception_lan_q = info->exception_lan_q;
 	vsi->vsi_idx = info->pf_data_vsi_num;
-	if (vsi->dev->hw_attrs.uk_attrs.hw_rev == IRDMA_GEN_1)
-		vsi->fcn_id = info->dev->hmc_fn_id;
 
 	irdma_set_qos_info(vsi, info->params);
 	for (i = 0; i < IRDMA_MAX_USER_PRIORITY; i++) {
@@ -1887,32 +1885,56 @@ void irdma_sc_vsi_init(struct irdma_sc_vsi  *vsi,
 }
 
 /**
- * irdma_get_fcn_id - Return the function id
+ * irdma_get_stats_idx - Return stats index
  * @vsi: pointer to the vsi
  */
-static u8 irdma_get_fcn_id(struct irdma_sc_vsi *vsi)
+static u8 irdma_get_stats_idx(struct irdma_sc_vsi *vsi)
 {
 	struct irdma_stats_inst_info stats_info = {};
 	struct irdma_sc_dev *dev = vsi->dev;
-	u8 fcn_id = IRDMA_INVALID_FCN_ID;
-	u8 start_idx, max_stats, i;
+	u8 i;
 
-	if (dev->hw_attrs.uk_attrs.hw_rev != IRDMA_GEN_1) {
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2) {
 		if (!irdma_cqp_stats_inst_cmd(vsi, IRDMA_OP_STATS_ALLOCATE,
 					      &stats_info))
 			return stats_info.stats_idx;
 	}
 
-	start_idx = 1;
-	max_stats = 16;
-	for (i = start_idx; i < max_stats; i++)
-		if (!dev->fcn_id_array[i]) {
-			fcn_id = i;
-			dev->fcn_id_array[i] = true;
-			break;
+	for (i = 0; i < IRDMA_MAX_STATS_COUNT_GEN_1; i++) {
+		if (!dev->stats_idx_array[i]) {
+			dev->stats_idx_array[i] = true;
+			return i;
 		}
+	}
 
-	return fcn_id;
+	return IRDMA_INVALID_STATS_IDX;
+}
+
+/**
+ * irdma_hw_stats_init_gen1 - Initialize stat reg table used for gen1
+ * @vsi: vsi structure where hw_regs are set
+ *
+ * Populate the HW stats table
+ */
+static void irdma_hw_stats_init_gen1(struct irdma_sc_vsi *vsi)
+{
+	struct irdma_sc_dev *dev = vsi->dev;
+	const struct irdma_hw_stat_map *map;
+	u64 *stat_reg = vsi->hw_stats_regs;
+	u64 *regs = dev->hw_stats_regs;
+	u16 i, stats_reg_set = vsi->stats_idx;
+
+	map = dev->hw_stats_map;
+
+	/* First 4 stat instances are reserved for port level statistics. */
+	stats_reg_set += vsi->stats_inst_alloc ? IRDMA_FIRST_NON_PF_STAT : 0;
+
+	for (i = 0; i < dev->hw_attrs.max_stat_idx; i++) {
+		if (map[i].bitmask <= IRDMA_MAX_STATS_32)
+			stat_reg[i] = regs[i] + stats_reg_set * sizeof(u32);
+		else
+			stat_reg[i] = regs[i] + stats_reg_set * sizeof(u64);
+	}
 }
 
 /**
@@ -1923,7 +1945,6 @@ static u8 irdma_get_fcn_id(struct irdma_sc_vsi *vsi)
 int irdma_vsi_stats_init(struct irdma_sc_vsi *vsi,
 			 struct irdma_vsi_stats_info *info)
 {
-	u8 fcn_id = info->fcn_id;
 	struct irdma_dma_mem *stats_buff_mem;
 
 	vsi->pestat = info->pestat;
@@ -1944,26 +1965,24 @@ int irdma_vsi_stats_init(struct irdma_sc_vsi *vsi,
 			 IRDMA_GATHER_STATS_BUF_SIZE);
 
 	irdma_hw_stats_start_timer(vsi);
-	if (info->alloc_fcn_id)
-		fcn_id = irdma_get_fcn_id(vsi);
-	if (fcn_id == IRDMA_INVALID_FCN_ID)
-		goto stats_error;
-
-	vsi->stats_fcn_id_alloc = info->alloc_fcn_id;
-	vsi->fcn_id = fcn_id;
-	if (info->alloc_fcn_id) {
-		vsi->pestat->gather_info.use_stats_inst = true;
-		vsi->pestat->gather_info.stats_inst_index = fcn_id;
-	}
 
-	return 0;
+	/* when stat allocation is not required default to fcn_id. */
+	vsi->stats_idx = info->fcn_id;
+	if (info->alloc_stats_inst) {
+		u8 stats_idx = irdma_get_stats_idx(vsi);
 
-stats_error:
-	dma_free_coherent(vsi->pestat->hw->device, stats_buff_mem->size,
-			  stats_buff_mem->va, stats_buff_mem->pa);
-	stats_buff_mem->va = NULL;
+		if (stats_idx != IRDMA_INVALID_STATS_IDX) {
+			vsi->stats_inst_alloc = true;
+			vsi->stats_idx = stats_idx;
+			vsi->pestat->gather_info.use_stats_inst = true;
+			vsi->pestat->gather_info.stats_inst_index = stats_idx;
+		}
+	}
+
+	if (vsi->dev->hw_attrs.uk_attrs.hw_rev == IRDMA_GEN_1)
+		irdma_hw_stats_init_gen1(vsi);
 
-	return -EIO;
+	return 0;
 }
 
 /**
@@ -1973,19 +1992,19 @@ int irdma_vsi_stats_init(struct irdma_sc_vsi *vsi,
 void irdma_vsi_stats_free(struct irdma_sc_vsi *vsi)
 {
 	struct irdma_stats_inst_info stats_info = {};
-	u8 fcn_id = vsi->fcn_id;
 	struct irdma_sc_dev *dev = vsi->dev;
+	u8 stats_idx = vsi->stats_idx;
 
-	if (dev->hw_attrs.uk_attrs.hw_rev != IRDMA_GEN_1) {
-		if (vsi->stats_fcn_id_alloc) {
-			stats_info.stats_idx = vsi->fcn_id;
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2) {
+		if (vsi->stats_inst_alloc) {
+			stats_info.stats_idx = vsi->stats_idx;
 			irdma_cqp_stats_inst_cmd(vsi, IRDMA_OP_STATS_FREE,
 						 &stats_info);
 		}
 	} else {
-		if (vsi->stats_fcn_id_alloc &&
-		    fcn_id < vsi->dev->hw_attrs.max_stat_inst)
-			vsi->dev->fcn_id_array[fcn_id] = false;
+		if (vsi->stats_inst_alloc &&
+		    stats_idx < vsi->dev->hw_attrs.max_stat_inst)
+			vsi->dev->stats_idx_array[stats_idx] = false;
 	}
 
 	if (!vsi->pestat)
@@ -5297,7 +5316,8 @@ void sc_vsi_update_stats(struct irdma_sc_vsi *vsi)
 	gather_stats = vsi->pestat->gather_info.gather_stats_va;
 	last_gather_stats = vsi->pestat->gather_info.last_gather_stats_va;
 	irdma_update_stats(&vsi->pestat->hw_stats, gather_stats,
-			   last_gather_stats);
+			   last_gather_stats, vsi->dev->hw_stats_map,
+			   vsi->dev->hw_attrs.max_stat_idx);
 }
 
 /**
@@ -5405,185 +5425,61 @@ int irdma_sc_dev_init(enum irdma_vers ver, struct irdma_sc_dev *dev,
 }
 
 /**
+ * irdma_stat_val - Extract HW counter value from statistics buffer
+ * @stats_val: pointer to statistics buffer
+ * @byteoff: byte offset of counter value in the buffer (8B-aligned)
+ * @bitoff: bit offset of counter value within 8B entry
+ * @bitmask: maximum counter value (e.g. 0xffffff for 24-bit counter)
+ */
+static inline u64 irdma_stat_val(const u64 *stats_val, u16 byteoff, u8 bitoff,
+				 u64 bitmask)
+{
+	u16 idx = byteoff / sizeof(*stats_val);
+
+	return (stats_val[idx] >> bitoff) & bitmask;
+}
+
+/**
+ * irdma_stat_delta - Calculate counter delta
+ * @new_val: updated counter value
+ * @old_val: last counter value
+ * @max_val: maximum counter value (e.g. 0xffffff for 24-bit counter)
+ */
+static inline u64 irdma_stat_delta(u64 new_val, u64 old_val, u64 max_val)
+{
+	if (new_val >= old_val)
+		return new_val - old_val;
+
+	/* roll-over case */
+	return max_val - old_val + new_val + 1;
+}
+
+/**
  * irdma_update_stats - Update statistics
  * @hw_stats: hw_stats instance to update
  * @gather_stats: updated stat counters
  * @last_gather_stats: last stat counters
+ * @map: HW stat map (hw_stats => gather_stats)
+ * @max_stat_idx: number of HW stats
  */
 void irdma_update_stats(struct irdma_dev_hw_stats *hw_stats,
 			struct irdma_gather_stats *gather_stats,
-			struct irdma_gather_stats *last_gather_stats)
-{
-	u64 *stats_val = hw_stats->stats_val_32;
-
-	stats_val[IRDMA_HW_STAT_INDEX_RXVLANERR] +=
-		IRDMA_STATS_DELTA(gather_stats->rxvlanerr,
-				  last_gather_stats->rxvlanerr,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4RXDISCARD] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4rxdiscard,
-				  last_gather_stats->ip4rxdiscard,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4RXTRUNC] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4rxtrunc,
-				  last_gather_stats->ip4rxtrunc,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4TXNOROUTE] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4txnoroute,
-				  last_gather_stats->ip4txnoroute,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6RXDISCARD] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6rxdiscard,
-				  last_gather_stats->ip6rxdiscard,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6RXTRUNC] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6rxtrunc,
-				  last_gather_stats->ip6rxtrunc,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6TXNOROUTE] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6txnoroute,
-				  last_gather_stats->ip6txnoroute,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_TCPRTXSEG] +=
-		IRDMA_STATS_DELTA(gather_stats->tcprtxseg,
-				  last_gather_stats->tcprtxseg,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_TCPRXOPTERR] +=
-		IRDMA_STATS_DELTA(gather_stats->tcprxopterr,
-				  last_gather_stats->tcprxopterr,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_TCPRXPROTOERR] +=
-		IRDMA_STATS_DELTA(gather_stats->tcprxprotoerr,
-				  last_gather_stats->tcprxprotoerr,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_RXRPCNPHANDLED] +=
-		IRDMA_STATS_DELTA(gather_stats->rxrpcnphandled,
-				  last_gather_stats->rxrpcnphandled,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_RXRPCNPIGNORED] +=
-		IRDMA_STATS_DELTA(gather_stats->rxrpcnpignored,
-				  last_gather_stats->rxrpcnpignored,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_TXNPCNPSENT] +=
-		IRDMA_STATS_DELTA(gather_stats->txnpcnpsent,
-				  last_gather_stats->txnpcnpsent,
-				  IRDMA_MAX_STATS_32);
-	stats_val = hw_stats->stats_val_64;
-	stats_val[IRDMA_HW_STAT_INDEX_IP4RXOCTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4rxocts,
-				  last_gather_stats->ip4rxocts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4RXPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4rxpkts,
-				  last_gather_stats->ip4rxpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4RXFRAGS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4txfrag,
-				  last_gather_stats->ip4txfrag,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4RXMCPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4rxmcpkts,
-				  last_gather_stats->ip4rxmcpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4TXOCTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4txocts,
-				  last_gather_stats->ip4txocts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4TXPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4txpkts,
-				  last_gather_stats->ip4txpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4TXFRAGS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4txfrag,
-				  last_gather_stats->ip4txfrag,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4TXMCPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4txmcpkts,
-				  last_gather_stats->ip4txmcpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6RXOCTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6rxocts,
-				  last_gather_stats->ip6rxocts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6RXPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6rxpkts,
-				  last_gather_stats->ip6rxpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6RXFRAGS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6txfrags,
-				  last_gather_stats->ip6txfrags,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6RXMCPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6rxmcpkts,
-				  last_gather_stats->ip6rxmcpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6TXOCTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6txocts,
-				  last_gather_stats->ip6txocts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6TXPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6txpkts,
-				  last_gather_stats->ip6txpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6TXFRAGS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6txfrags,
-				  last_gather_stats->ip6txfrags,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6TXMCPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6txmcpkts,
-				  last_gather_stats->ip6txmcpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_TCPRXSEGS] +=
-		IRDMA_STATS_DELTA(gather_stats->tcprxsegs,
-				  last_gather_stats->tcprxsegs,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_TCPTXSEG] +=
-		IRDMA_STATS_DELTA(gather_stats->tcptxsegs,
-				  last_gather_stats->tcptxsegs,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMARXRDS] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmarxrds,
-				  last_gather_stats->rdmarxrds,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMARXSNDS] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmarxsnds,
-				  last_gather_stats->rdmarxsnds,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMARXWRS] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmarxwrs,
-				  last_gather_stats->rdmarxwrs,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMATXRDS] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmatxrds,
-				  last_gather_stats->rdmatxrds,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMATXSNDS] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmatxsnds,
-				  last_gather_stats->rdmatxsnds,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMATXWRS] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmatxwrs,
-				  last_gather_stats->rdmatxwrs,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMAVBND] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmavbn,
-				  last_gather_stats->rdmavbn,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMAVINV] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmavinv,
-				  last_gather_stats->rdmavinv,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_UDPRXPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->udprxpkts,
-				  last_gather_stats->udprxpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_UDPTXPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->udptxpkts,
-				  last_gather_stats->udptxpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RXNPECNMARKEDPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->rxnpecnmrkpkts,
-				  last_gather_stats->rxnpecnmrkpkts,
-				  IRDMA_MAX_STATS_48);
+			struct irdma_gather_stats *last_gather_stats,
+			const struct irdma_hw_stat_map *map, u16 max_stat_idx)
+{
+	u64 *stats_val = hw_stats->stats_val;
+	u16 i;
+
+	for (i = 0; i < max_stat_idx; i++) {
+		u64 new_val = irdma_stat_val(gather_stats->val, map[i].byteoff,
+					     map[i].bitoff, map[i].bitmask);
+		u64 last_val = irdma_stat_val(last_gather_stats->val,
+					      map[i].byteoff, map[i].bitoff,
+					      map[i].bitmask);
+
+		stats_val[i] +=
+			irdma_stat_delta(new_val, last_val, map[i].bitmask);
+	}
+
 	memcpy(last_gather_stats, gather_stats, sizeof(*last_gather_stats));
 }
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index c1906ca..6014b9d 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -36,6 +36,7 @@ enum irdma_protocol_used {
 #define IRDMA_QP_STATE_ERROR		6
 
 #define IRDMA_MAX_TRAFFIC_CLASS		8
+#define	IRDMA_MAX_STATS_COUNT_GEN_1	12
 #define IRDMA_MAX_USER_PRIORITY		8
 #define IRDMA_MAX_APPS			8
 #define IRDMA_MAX_STATS_COUNT		128
@@ -365,9 +366,11 @@ enum irdma_cqp_op_type {
 #define FLD_RS_32(dev, val, field)	\
 	((u64)((val) & (dev)->hw_masks[field ## _M]) >> (dev)->hw_shifts[field ## _S])
 
-#define IRDMA_STATS_DELTA(a, b, c) ((a) >= (b) ? (a) - (b) : (a) + (c) - (b))
-#define IRDMA_MAX_STATS_32	0xFFFFFFFFULL
-#define IRDMA_MAX_STATS_48	0xFFFFFFFFFFFFULL
+#define IRDMA_MAX_STATS_24	0xffffffULL
+#define IRDMA_MAX_STATS_32	0xffffffffULL
+#define IRDMA_MAX_STATS_48	0xffffffffffffULL
+#define IRDMA_MAX_STATS_56	0xffffffffffffffULL
+#define IRDMA_MAX_STATS_64	0xffffffffffffffffULL
 
 #define IRDMA_MAX_CQ_READ_THRESH 0x3FFFF
 #define IRDMA_CQPSQ_QHASH_VLANID GENMASK_ULL(43, 32)
diff --git a/drivers/infiniband/hw/irdma/i40iw_hw.c b/drivers/infiniband/hw/irdma/i40iw_hw.c
index 50299f5..37a40fb4 100644
--- a/drivers/infiniband/hw/irdma/i40iw_hw.c
+++ b/drivers/infiniband/hw/irdma/i40iw_hw.c
@@ -32,7 +32,7 @@
 	0xffffffff      /* PFINT_RATEN not used in FPK */
 };
 
-static u32 i40iw_stat_offsets_32[IRDMA_HW_STAT_INDEX_MAX_32] = {
+static u32 i40iw_stat_offsets[] = {
 	I40E_GLPES_PFIP4RXDISCARD(0),
 	I40E_GLPES_PFIP4RXTRUNC(0),
 	I40E_GLPES_PFIP4TXNOROUTE(0),
@@ -42,10 +42,8 @@
 	I40E_GLPES_PFTCPRTXSEG(0),
 	I40E_GLPES_PFTCPRXOPTERR(0),
 	I40E_GLPES_PFTCPRXPROTOERR(0),
-	I40E_GLPES_PFRXVLANERR(0)
-};
+	I40E_GLPES_PFRXVLANERR(0),
 
-static u32 i40iw_stat_offsets_64[IRDMA_HW_STAT_INDEX_MAX_64] = {
 	I40E_GLPES_PFIP4RXOCTSLO(0),
 	I40E_GLPES_PFIP4RXPKTSLO(0),
 	I40E_GLPES_PFIP4RXFRAGSLO(0),
@@ -158,6 +156,51 @@ static void i40iw_disable_irq(struct irdma_sc_dev *dev, u32 idx)
 	.irdma_en_irq = i40iw_ena_irq,
 };
 
+static const struct irdma_hw_stat_map i40iw_hw_stat_map[] = {
+	[IRDMA_HW_STAT_INDEX_RXVLANERR]	=	{   0,  0, IRDMA_MAX_STATS_24 },
+	[IRDMA_HW_STAT_INDEX_IP4RXOCTS] =	{   8,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4RXPKTS] =	{  16,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4RXDISCARD] =	{  24,  0, IRDMA_MAX_STATS_32 },
+	[IRDMA_HW_STAT_INDEX_IP4RXTRUNC] =	{  32,  0, IRDMA_MAX_STATS_32 },
+	[IRDMA_HW_STAT_INDEX_IP4RXFRAGS] =      {  40,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4RXMCPKTS] =     {  48,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6RXOCTS] =       {  56,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6RXPKTS] =       {  64,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6RXDISCARD] =    {  72,  0, IRDMA_MAX_STATS_32 },
+	[IRDMA_HW_STAT_INDEX_IP6RXTRUNC] =      {  80,  0, IRDMA_MAX_STATS_32 },
+	[IRDMA_HW_STAT_INDEX_IP6RXFRAGS] =      {  88,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6RXMCPKTS] =     {  96,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4TXOCTS] =       { 104,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4TXPKTS] =       { 112,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4TXFRAGS] =      { 120,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4TXMCPKTS] =     { 128,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6TXOCTS] =       { 136,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6TXPKTS] =       { 144,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6TXFRAGS] =      { 152,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6TXMCPKTS] =     { 160,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4TXNOROUTE] =    { 168,  0, IRDMA_MAX_STATS_24 },
+	[IRDMA_HW_STAT_INDEX_IP6TXNOROUTE] =    { 176,  0, IRDMA_MAX_STATS_24 },
+	[IRDMA_HW_STAT_INDEX_TCPRXSEGS] =       { 184,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_TCPRXOPTERR] =     { 192,  0, IRDMA_MAX_STATS_24 },
+	[IRDMA_HW_STAT_INDEX_TCPRXPROTOERR] =   { 200,  0, IRDMA_MAX_STATS_24 },
+	[IRDMA_HW_STAT_INDEX_TCPTXSEG] =        { 208,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_TCPRTXSEG] =       { 216,  0, IRDMA_MAX_STATS_32 },
+	[IRDMA_HW_STAT_INDEX_RDMARXWRS] =       { 224,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMARXRDS] =       { 232,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMARXSNDS] =      { 240,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMATXWRS] =       { 248,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMATXRDS] =       { 256,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMATXSNDS] =      { 264,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMAVBND] =        { 272,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMAVINV] =        { 280,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4RXMCOCTS] =     { 288,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4TXMCOCTS] =     { 296,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6RXMCOCTS] =     { 304,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6TXMCOCTS] =     { 312,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_UDPRXPKTS] =       { 320,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_UDPTXPKTS] =       { 328,  0, IRDMA_MAX_STATS_48 },
+};
+
 void i40iw_init_hw(struct irdma_sc_dev *dev)
 {
 	int i;
@@ -172,11 +215,8 @@ void i40iw_init_hw(struct irdma_sc_dev *dev)
 		dev->hw_regs[i] = (u32 __iomem *)(i40iw_regs[i] + hw_addr);
 	}
 
-	for (i = 0; i < IRDMA_HW_STAT_INDEX_MAX_32; ++i)
-		dev->hw_stats_regs_32[i] = i40iw_stat_offsets_32[i];
-
-	for (i = 0; i < IRDMA_HW_STAT_INDEX_MAX_64; ++i)
-		dev->hw_stats_regs_64[i] = i40iw_stat_offsets_64[i];
+	for (i = 0; i < IRDMA_HW_STAT_INDEX_MAX_GEN_1; ++i)
+		dev->hw_stats_regs[i] = i40iw_stat_offsets[i];
 
 	dev->hw_attrs.first_hw_vf_fpm_id = I40IW_FIRST_VF_FPM_ID;
 	dev->hw_attrs.max_hw_vf_fpm_id = IRDMA_MAX_VF_FPM_ID;
@@ -195,6 +235,7 @@ void i40iw_init_hw(struct irdma_sc_dev *dev)
 	dev->ceq_itr_mask_db = NULL;
 	dev->aeq_itr_mask_db = NULL;
 	dev->irq_ops = &i40iw_irq_ops;
+	dev->hw_stats_map = i40iw_hw_stat_map;
 
 	/* Setup the hardware limits, hmc may limit further */
 	dev->hw_attrs.uk_attrs.max_hw_wq_frags = I40IW_MAX_WQ_FRAGMENT_COUNT;
@@ -210,6 +251,7 @@ void i40iw_init_hw(struct irdma_sc_dev *dev)
 	dev->hw_attrs.uk_attrs.max_hw_sq_chunk = I40IW_MAX_QUANTA_PER_WR;
 	dev->hw_attrs.max_hw_pds = I40IW_MAX_PDS;
 	dev->hw_attrs.max_stat_inst = I40IW_MAX_STATS_COUNT;
+	dev->hw_attrs.max_stat_idx = IRDMA_HW_STAT_INDEX_MAX_GEN_1;
 	dev->hw_attrs.max_hw_outbound_msg_size = I40IW_MAX_OUTBOUND_MSG_SIZE;
 	dev->hw_attrs.max_hw_inbound_msg_size = I40IW_MAX_INBOUND_MSG_SIZE;
 	dev->hw_attrs.max_qp_wr = I40IW_MAX_QP_WRS;
diff --git a/drivers/infiniband/hw/irdma/icrdma_hw.c b/drivers/infiniband/hw/irdma/icrdma_hw.c
index 5986fd9..298d149 100644
--- a/drivers/infiniband/hw/irdma/icrdma_hw.c
+++ b/drivers/infiniband/hw/irdma/icrdma_hw.c
@@ -111,6 +111,55 @@ static void icrdma_cfg_ceq(struct irdma_sc_dev *dev, u32 ceq_id, u32 idx,
 	.irdma_en_irq = icrdma_ena_irq,
 };
 
+static const struct irdma_hw_stat_map icrdma_hw_stat_map[] = {
+	[IRDMA_HW_STAT_INDEX_RXVLANERR]	=	{   0, 32, IRDMA_MAX_STATS_24 },
+	[IRDMA_HW_STAT_INDEX_IP4RXOCTS] =	{   8,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4RXPKTS] =	{  16,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4RXDISCARD] =	{  24, 32, IRDMA_MAX_STATS_32 },
+	[IRDMA_HW_STAT_INDEX_IP4RXTRUNC] =	{  24,  0, IRDMA_MAX_STATS_32 },
+	[IRDMA_HW_STAT_INDEX_IP4RXFRAGS] =	{  32,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4RXMCOCTS] =	{  40,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4RXMCPKTS] =	{  48,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6RXOCTS] =	{  56,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6RXPKTS] =	{  64,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6RXDISCARD] =	{  72, 32, IRDMA_MAX_STATS_32 },
+	[IRDMA_HW_STAT_INDEX_IP6RXTRUNC] =	{  72,  0, IRDMA_MAX_STATS_32 },
+	[IRDMA_HW_STAT_INDEX_IP6RXFRAGS] =	{  80,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6RXMCOCTS] =	{  88,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6RXMCPKTS] =	{  96,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4TXOCTS] =	{ 104,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4TXPKTS] =	{ 112,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4TXFRAGS] =	{ 120,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4TXMCOCTS] =	{ 128,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4TXMCPKTS] =	{ 136,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6TXOCTS] =	{ 144,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6TXPKTS] =	{ 152,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6TXFRAGS] =	{ 160,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6TXMCOCTS] =	{ 168,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP6TXMCPKTS] =	{ 176,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_IP4TXNOROUTE] =	{ 184, 32, IRDMA_MAX_STATS_24 },
+	[IRDMA_HW_STAT_INDEX_IP6TXNOROUTE] =	{ 184,  0, IRDMA_MAX_STATS_24 },
+	[IRDMA_HW_STAT_INDEX_TCPRXSEGS] =	{ 192, 32, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_TCPRXOPTERR] =	{ 200, 32, IRDMA_MAX_STATS_24 },
+	[IRDMA_HW_STAT_INDEX_TCPRXPROTOERR] =	{ 200,  0, IRDMA_MAX_STATS_24 },
+	[IRDMA_HW_STAT_INDEX_TCPTXSEG] =	{ 208,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_TCPRTXSEG] =	{ 216, 32, IRDMA_MAX_STATS_32 },
+	[IRDMA_HW_STAT_INDEX_UDPRXPKTS] =	{ 224,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_UDPTXPKTS] =	{ 232,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMARXWRS] =	{ 240,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMARXRDS] =	{ 248,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMARXSNDS] =	{ 256,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMATXWRS] =	{ 264,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMATXRDS] =	{ 272,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMATXSNDS] =	{ 280,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMAVBND] =	{ 288,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RDMAVINV] =	{ 296,  0, IRDMA_MAX_STATS_48 },
+	[IRDMA_HW_STAT_INDEX_RXNPECNMARKEDPKTS] = { 304,  0, IRDMA_MAX_STATS_56 },
+	[IRDMA_HW_STAT_INDEX_RXRPCNPIGNORED] =	{ 312, 32, IRDMA_MAX_STATS_24 },
+	[IRDMA_HW_STAT_INDEX_RXRPCNPHANDLED] =	{ 312,  0, IRDMA_MAX_STATS_32 },
+	[IRDMA_HW_STAT_INDEX_TXNPCNPSENT] =	{ 320,  0, IRDMA_MAX_STATS_32 },
+};
+
 void icrdma_init_hw(struct irdma_sc_dev *dev)
 {
 	int i;
@@ -140,9 +189,11 @@ void icrdma_init_hw(struct irdma_sc_dev *dev)
 	dev->cq_ack_db = dev->hw_regs[IRDMA_CQACK];
 	dev->irq_ops = &icrdma_irq_ops;
 	dev->hw_attrs.page_size_cap = SZ_4K | SZ_2M | SZ_1G;
+	dev->hw_stats_map = icrdma_hw_stat_map;
 	dev->hw_attrs.max_hw_ird = ICRDMA_MAX_IRD_SIZE;
 	dev->hw_attrs.max_hw_ord = ICRDMA_MAX_ORD_SIZE;
 	dev->hw_attrs.max_stat_inst = ICRDMA_MAX_STATS_COUNT;
+	dev->hw_attrs.max_stat_idx = IRDMA_HW_STAT_INDEX_MAX_GEN_2;
 
 	dev->hw_attrs.uk_attrs.max_hw_sq_chunk = IRDMA_MAX_QUANTA_PER_WR;
 	dev->hw_attrs.uk_attrs.feature_flags |= IRDMA_FEATURE_RTS_AE |
diff --git a/drivers/infiniband/hw/irdma/irdma.h b/drivers/infiniband/hw/irdma/irdma.h
index 4789e85..173e2dc 100644
--- a/drivers/infiniband/hw/irdma/irdma.h
+++ b/drivers/infiniband/hw/irdma/irdma.h
@@ -147,6 +147,7 @@ struct irdma_hw_attrs {
 	u32 max_sleep_count;
 	u32 max_cqp_compl_wait_time_ms;
 	u16 max_stat_inst;
+	u16 max_stat_idx;
 };
 
 void i40iw_init_hw(struct irdma_sc_dev *dev);
diff --git a/drivers/infiniband/hw/irdma/protos.h b/drivers/infiniband/hw/irdma/protos.h
index 9b6e919..113096b 100644
--- a/drivers/infiniband/hw/irdma/protos.h
+++ b/drivers/infiniband/hw/irdma/protos.h
@@ -28,9 +28,7 @@ int irdma_cqp_gather_stats_cmd(struct irdma_sc_dev *dev,
 void irdma_cqp_gather_stats_gen1(struct irdma_sc_dev *dev,
 				 struct irdma_vsi_pestat *pestat);
 void irdma_hw_stats_read_all(struct irdma_vsi_pestat *stats,
-			     struct irdma_dev_hw_stats *stats_values,
-			     u64 *hw_stats_regs_32, u64 *hw_stats_regs_64,
-			     u8 hw_rev);
+			     const u64 *hw_stats_regs);
 int irdma_cqp_ws_node_cmd(struct irdma_sc_dev *dev, u8 cmd,
 			  struct irdma_ws_node_info *node_info);
 int irdma_cqp_ceq_cmd(struct irdma_sc_dev *dev, struct irdma_sc_ceq *sc_ceq,
@@ -43,7 +41,9 @@ int irdma_cqp_stats_inst_cmd(struct irdma_sc_vsi *vsi, u8 cmd,
 void irdma_free_ws_node_id(struct irdma_sc_dev *dev, u16 node_id);
 void irdma_update_stats(struct irdma_dev_hw_stats *hw_stats,
 			struct irdma_gather_stats *gather_stats,
-			struct irdma_gather_stats *last_gather_stats);
+			struct irdma_gather_stats *last_gather_stats,
+			const struct irdma_hw_stat_map *map, u16 max_stat_idx);
+
 /* vsi functions */
 int irdma_vsi_stats_init(struct irdma_sc_vsi *vsi,
 			 struct irdma_vsi_stats_info *info);
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 517d41a..5ee6860 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -101,7 +101,8 @@ enum irdma_qp_event_type {
 	IRDMA_QP_EVENT_REQ_ERR,
 };
 
-enum irdma_hw_stats_index_32b {
+enum irdma_hw_stats_index {
+	/* gen1 - 32-bit */
 	IRDMA_HW_STAT_INDEX_IP4RXDISCARD	= 0,
 	IRDMA_HW_STAT_INDEX_IP4RXTRUNC		= 1,
 	IRDMA_HW_STAT_INDEX_IP4TXNOROUTE	= 2,
@@ -111,50 +112,48 @@ enum irdma_hw_stats_index_32b {
 	IRDMA_HW_STAT_INDEX_TCPRTXSEG		= 6,
 	IRDMA_HW_STAT_INDEX_TCPRXOPTERR		= 7,
 	IRDMA_HW_STAT_INDEX_TCPRXPROTOERR	= 8,
-	IRDMA_HW_STAT_INDEX_MAX_32_GEN_1	= 9, /* Must be same value as next entry */
 	IRDMA_HW_STAT_INDEX_RXVLANERR		= 9,
-	IRDMA_HW_STAT_INDEX_RXRPCNPHANDLED	= 10,
-	IRDMA_HW_STAT_INDEX_RXRPCNPIGNORED	= 11,
-	IRDMA_HW_STAT_INDEX_TXNPCNPSENT		= 12,
-	IRDMA_HW_STAT_INDEX_MAX_32, /* Must be last entry */
-};
-
-enum irdma_hw_stats_index_64b {
-	IRDMA_HW_STAT_INDEX_IP4RXOCTS	= 0,
-	IRDMA_HW_STAT_INDEX_IP4RXPKTS	= 1,
-	IRDMA_HW_STAT_INDEX_IP4RXFRAGS	= 2,
-	IRDMA_HW_STAT_INDEX_IP4RXMCPKTS	= 3,
-	IRDMA_HW_STAT_INDEX_IP4TXOCTS	= 4,
-	IRDMA_HW_STAT_INDEX_IP4TXPKTS	= 5,
-	IRDMA_HW_STAT_INDEX_IP4TXFRAGS	= 6,
-	IRDMA_HW_STAT_INDEX_IP4TXMCPKTS	= 7,
-	IRDMA_HW_STAT_INDEX_IP6RXOCTS	= 8,
-	IRDMA_HW_STAT_INDEX_IP6RXPKTS	= 9,
-	IRDMA_HW_STAT_INDEX_IP6RXFRAGS	= 10,
-	IRDMA_HW_STAT_INDEX_IP6RXMCPKTS	= 11,
-	IRDMA_HW_STAT_INDEX_IP6TXOCTS	= 12,
-	IRDMA_HW_STAT_INDEX_IP6TXPKTS	= 13,
-	IRDMA_HW_STAT_INDEX_IP6TXFRAGS	= 14,
-	IRDMA_HW_STAT_INDEX_IP6TXMCPKTS	= 15,
-	IRDMA_HW_STAT_INDEX_TCPRXSEGS	= 16,
-	IRDMA_HW_STAT_INDEX_TCPTXSEG	= 17,
-	IRDMA_HW_STAT_INDEX_RDMARXRDS	= 18,
-	IRDMA_HW_STAT_INDEX_RDMARXSNDS	= 19,
-	IRDMA_HW_STAT_INDEX_RDMARXWRS	= 20,
-	IRDMA_HW_STAT_INDEX_RDMATXRDS	= 21,
-	IRDMA_HW_STAT_INDEX_RDMATXSNDS	= 22,
-	IRDMA_HW_STAT_INDEX_RDMATXWRS	= 23,
-	IRDMA_HW_STAT_INDEX_RDMAVBND	= 24,
-	IRDMA_HW_STAT_INDEX_RDMAVINV	= 25,
-	IRDMA_HW_STAT_INDEX_MAX_64_GEN_1 = 26, /* Must be same value as next entry */
-	IRDMA_HW_STAT_INDEX_IP4RXMCOCTS	= 26,
-	IRDMA_HW_STAT_INDEX_IP4TXMCOCTS	= 27,
-	IRDMA_HW_STAT_INDEX_IP6RXMCOCTS	= 28,
-	IRDMA_HW_STAT_INDEX_IP6TXMCOCTS	= 29,
-	IRDMA_HW_STAT_INDEX_UDPRXPKTS	= 30,
-	IRDMA_HW_STAT_INDEX_UDPTXPKTS	= 31,
-	IRDMA_HW_STAT_INDEX_RXNPECNMARKEDPKTS = 32,
-	IRDMA_HW_STAT_INDEX_MAX_64, /* Must be last entry */
+		/* gen1 - 64-bit */
+	IRDMA_HW_STAT_INDEX_IP4RXOCTS		= 10,
+	IRDMA_HW_STAT_INDEX_IP4RXPKTS		= 11,
+	IRDMA_HW_STAT_INDEX_IP4RXFRAGS		= 12,
+	IRDMA_HW_STAT_INDEX_IP4RXMCPKTS		= 13,
+	IRDMA_HW_STAT_INDEX_IP4TXOCTS		= 14,
+	IRDMA_HW_STAT_INDEX_IP4TXPKTS		= 15,
+	IRDMA_HW_STAT_INDEX_IP4TXFRAGS		= 16,
+	IRDMA_HW_STAT_INDEX_IP4TXMCPKTS		= 17,
+	IRDMA_HW_STAT_INDEX_IP6RXOCTS		= 18,
+	IRDMA_HW_STAT_INDEX_IP6RXPKTS		= 19,
+	IRDMA_HW_STAT_INDEX_IP6RXFRAGS		= 20,
+	IRDMA_HW_STAT_INDEX_IP6RXMCPKTS		= 21,
+	IRDMA_HW_STAT_INDEX_IP6TXOCTS		= 22,
+	IRDMA_HW_STAT_INDEX_IP6TXPKTS		= 23,
+	IRDMA_HW_STAT_INDEX_IP6TXFRAGS		= 24,
+	IRDMA_HW_STAT_INDEX_IP6TXMCPKTS		= 25,
+	IRDMA_HW_STAT_INDEX_TCPRXSEGS		= 26,
+	IRDMA_HW_STAT_INDEX_TCPTXSEG		= 27,
+	IRDMA_HW_STAT_INDEX_RDMARXRDS		= 28,
+	IRDMA_HW_STAT_INDEX_RDMARXSNDS		= 29,
+	IRDMA_HW_STAT_INDEX_RDMARXWRS		= 30,
+	IRDMA_HW_STAT_INDEX_RDMATXRDS		= 31,
+	IRDMA_HW_STAT_INDEX_RDMATXSNDS		= 32,
+	IRDMA_HW_STAT_INDEX_RDMATXWRS		= 33,
+	IRDMA_HW_STAT_INDEX_RDMAVBND		= 34,
+	IRDMA_HW_STAT_INDEX_RDMAVINV		= 35,
+	IRDMA_HW_STAT_INDEX_IP4RXMCOCTS         = 36,
+	IRDMA_HW_STAT_INDEX_IP4TXMCOCTS         = 37,
+	IRDMA_HW_STAT_INDEX_IP6RXMCOCTS         = 38,
+	IRDMA_HW_STAT_INDEX_IP6TXMCOCTS         = 39,
+	IRDMA_HW_STAT_INDEX_UDPRXPKTS           = 40,
+	IRDMA_HW_STAT_INDEX_UDPTXPKTS           = 41,
+	IRDMA_HW_STAT_INDEX_MAX_GEN_1           = 42, /* Must be same value as next entry */
+	/* gen2 - 64-bit */
+	IRDMA_HW_STAT_INDEX_RXNPECNMARKEDPKTS   = 42,
+	/* gen2 - 32-bit */
+	IRDMA_HW_STAT_INDEX_RXRPCNPHANDLED      = 43,
+	IRDMA_HW_STAT_INDEX_RXRPCNPIGNORED      = 44,
+	IRDMA_HW_STAT_INDEX_TXNPCNPSENT         = 45,
+	IRDMA_HW_STAT_INDEX_MAX_GEN_2		= 46,
 };
 
 enum irdma_feature_type {
@@ -274,65 +273,21 @@ struct irdma_cq_shadow_area {
 };
 
 struct irdma_dev_hw_stats_offsets {
-	u32 stats_offset_32[IRDMA_HW_STAT_INDEX_MAX_32];
-	u32 stats_offset_64[IRDMA_HW_STAT_INDEX_MAX_64];
+	u32 stats_offset[IRDMA_HW_STAT_INDEX_MAX_GEN_1];
 };
 
 struct irdma_dev_hw_stats {
-	u64 stats_val_32[IRDMA_HW_STAT_INDEX_MAX_32];
-	u64 stats_val_64[IRDMA_HW_STAT_INDEX_MAX_64];
+	u64 stats_val[IRDMA_GATHER_STATS_BUF_SIZE / sizeof(u64)];
 };
 
 struct irdma_gather_stats {
-	u32 rsvd1;
-	u32 rxvlanerr;
-	u64 ip4rxocts;
-	u64 ip4rxpkts;
-	u32 ip4rxtrunc;
-	u32 ip4rxdiscard;
-	u64 ip4rxfrags;
-	u64 ip4rxmcocts;
-	u64 ip4rxmcpkts;
-	u64 ip6rxocts;
-	u64 ip6rxpkts;
-	u32 ip6rxtrunc;
-	u32 ip6rxdiscard;
-	u64 ip6rxfrags;
-	u64 ip6rxmcocts;
-	u64 ip6rxmcpkts;
-	u64 ip4txocts;
-	u64 ip4txpkts;
-	u64 ip4txfrag;
-	u64 ip4txmcocts;
-	u64 ip4txmcpkts;
-	u64 ip6txocts;
-	u64 ip6txpkts;
-	u64 ip6txfrags;
-	u64 ip6txmcocts;
-	u64 ip6txmcpkts;
-	u32 ip6txnoroute;
-	u32 ip4txnoroute;
-	u64 tcprxsegs;
-	u32 tcprxprotoerr;
-	u32 tcprxopterr;
-	u64 tcptxsegs;
-	u32 rsvd2;
-	u32 tcprtxseg;
-	u64 udprxpkts;
-	u64 udptxpkts;
-	u64 rdmarxwrs;
-	u64 rdmarxrds;
-	u64 rdmarxsnds;
-	u64 rdmatxwrs;
-	u64 rdmatxrds;
-	u64 rdmatxsnds;
-	u64 rdmavbn;
-	u64 rdmavinv;
-	u64 rxnpecnmrkpkts;
-	u32 rxrpcnphandled;
-	u32 rxrpcnpignored;
-	u32 txnpcnpsent;
-	u32 rsvd3[88];
+	u64 val[IRDMA_GATHER_STATS_BUF_SIZE / sizeof(u64)];
+};
+
+struct irdma_hw_stat_map {
+	u16 byteoff;
+	u8 bitoff;
+	u64 bitmask;
 };
 
 struct irdma_stats_gather_info {
@@ -584,7 +539,7 @@ struct irdma_qos {
 	bool valid;
 };
 
-#define IRDMA_INVALID_FCN_ID 0xff
+#define IRDMA_INVALID_STATS_IDX 0xff
 struct irdma_sc_vsi {
 	u16 vsi_idx;
 	struct irdma_sc_dev *dev;
@@ -598,11 +553,9 @@ struct irdma_sc_vsi {
 	u32 exception_lan_q;
 	u16 mtu;
 	u16 vm_id;
-	u8 fcn_id;
 	enum irdma_vm_vf_type vm_vf_type;
-	bool stats_fcn_id_alloc:1;
+	bool stats_inst_alloc:1;
 	bool tc_change_pending:1;
-	struct irdma_qos qos[IRDMA_MAX_USER_PRIORITY];
 	struct irdma_vsi_pestat *pestat;
 	atomic_t qp_suspend_reqs;
 	int (*register_qset)(struct irdma_sc_vsi *vsi,
@@ -611,14 +564,17 @@ struct irdma_sc_vsi {
 				struct irdma_ws_node *tc_node);
 	u8 qos_rel_bw;
 	u8 qos_prio_type;
+	u8 stats_idx;
 	u8 dscp_map[IIDC_MAX_DSCP_MAPPING];
+	struct irdma_qos qos[IRDMA_MAX_USER_PRIORITY];
+	u64 hw_stats_regs[IRDMA_HW_STAT_INDEX_MAX_GEN_1];
 	bool dscp_mode:1;
 };
 
 struct irdma_sc_dev {
 	struct list_head cqp_cmd_head; /* head of the CQP command list */
 	spinlock_t cqp_lock; /* protect CQP list access */
-	bool fcn_id_array[IRDMA_MAX_STATS_COUNT];
+	bool stats_idx_array[IRDMA_MAX_STATS_COUNT_GEN_1];
 	struct irdma_dma_mem vf_fpm_query_buf[IRDMA_MAX_PE_ENA_VF_COUNT];
 	u64 fpm_query_buf_pa;
 	u64 fpm_commit_buf_pa;
@@ -637,8 +593,8 @@ struct irdma_sc_dev {
 	u32 ceq_itr;   /* Interrupt throttle, usecs between interrupts: 0 disabled. 2 - 8160 */
 	u64 hw_masks[IRDMA_MAX_MASKS];
 	u64 hw_shifts[IRDMA_MAX_SHIFTS];
-	u64 hw_stats_regs_32[IRDMA_HW_STAT_INDEX_MAX_32];
-	u64 hw_stats_regs_64[IRDMA_HW_STAT_INDEX_MAX_64];
+	const struct irdma_hw_stat_map *hw_stats_map;
+	u64 hw_stats_regs[IRDMA_HW_STAT_INDEX_MAX_GEN_1];
 	u64 feature_info[IRDMA_MAX_FEATURES];
 	u64 cqp_cmd_stats[IRDMA_MAX_CQP_OPS];
 	struct irdma_hw_attrs hw_attrs;
@@ -763,7 +719,7 @@ struct irdma_vsi_init_info {
 struct irdma_vsi_stats_info {
 	struct irdma_vsi_pestat *pestat;
 	u8 fcn_id;
-	bool alloc_fcn_id;
+	bool alloc_stats_inst;
 };
 
 struct irdma_device_init_info {
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 445e69e8..0604d5e 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -1634,10 +1634,10 @@ static void irdma_hw_stats_timeout(struct timer_list *t)
 		from_timer(pf_devstat, t, stats_timer);
 	struct irdma_sc_vsi *sc_vsi = pf_devstat->vsi;
 
-	if (sc_vsi->dev->hw_attrs.uk_attrs.hw_rev == IRDMA_GEN_1)
-		irdma_cqp_gather_stats_gen1(sc_vsi->dev, sc_vsi->pestat);
-	else
+	if (sc_vsi->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
 		irdma_cqp_gather_stats_cmd(sc_vsi->dev, sc_vsi->pestat, false);
+	else
+		irdma_cqp_gather_stats_gen1(sc_vsi->dev, sc_vsi->pestat);
 
 	mod_timer(&pf_devstat->stats_timer,
 		  jiffies + msecs_to_jiffies(STATS_TIMER_DELAY));
@@ -1686,164 +1686,28 @@ void irdma_cqp_gather_stats_gen1(struct irdma_sc_dev *dev,
 {
 	struct irdma_gather_stats *gather_stats =
 		pestat->gather_info.gather_stats_va;
+	const struct irdma_hw_stat_map *map = dev->hw_stats_map;
+	u16 max_stats_idx = dev->hw_attrs.max_stat_idx;
 	u32 stats_inst_offset_32;
 	u32 stats_inst_offset_64;
+	u64 new_val;
+	u16 i;
 
 	stats_inst_offset_32 = (pestat->gather_info.use_stats_inst) ?
-				       pestat->gather_info.stats_inst_index :
-				       pestat->hw->hmc.hmc_fn_id;
+				pestat->gather_info.stats_inst_index :
+				pestat->hw->hmc.hmc_fn_id;
 	stats_inst_offset_32 *= 4;
 	stats_inst_offset_64 = stats_inst_offset_32 * 2;
 
-	gather_stats->rxvlanerr =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_RXVLANERR]
-		     + stats_inst_offset_32);
-	gather_stats->ip4rxdiscard =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_IP4RXDISCARD]
-		     + stats_inst_offset_32);
-	gather_stats->ip4rxtrunc =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_IP4RXTRUNC]
-		     + stats_inst_offset_32);
-	gather_stats->ip4txnoroute =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_IP4TXNOROUTE]
-		     + stats_inst_offset_32);
-	gather_stats->ip6rxdiscard =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_IP6RXDISCARD]
-		     + stats_inst_offset_32);
-	gather_stats->ip6rxtrunc =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_IP6RXTRUNC]
-		     + stats_inst_offset_32);
-	gather_stats->ip6txnoroute =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_IP6TXNOROUTE]
-		     + stats_inst_offset_32);
-	gather_stats->tcprtxseg =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_TCPRTXSEG]
-		     + stats_inst_offset_32);
-	gather_stats->tcprxopterr =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_TCPRXOPTERR]
-		     + stats_inst_offset_32);
-
-	gather_stats->ip4rxocts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4RXOCTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4rxpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4RXPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4txfrag =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4RXFRAGS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4rxmcpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4RXMCPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4txocts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4TXOCTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4txpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4TXPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4txfrag =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4TXFRAGS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4txmcpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4TXMCPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6rxocts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6RXOCTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6rxpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6RXPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6txfrags =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6RXFRAGS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6rxmcpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6RXMCPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6txocts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6TXOCTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6txpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6TXPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6txfrags =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6TXFRAGS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6txmcpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6TXMCPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->tcprxsegs =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_TCPRXSEGS]
-		     + stats_inst_offset_64);
-	gather_stats->tcptxsegs =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_TCPTXSEG]
-		     + stats_inst_offset_64);
-	gather_stats->rdmarxrds =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMARXRDS]
-		     + stats_inst_offset_64);
-	gather_stats->rdmarxsnds =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMARXSNDS]
-		     + stats_inst_offset_64);
-	gather_stats->rdmarxwrs =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMARXWRS]
-		     + stats_inst_offset_64);
-	gather_stats->rdmatxrds =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMATXRDS]
-		     + stats_inst_offset_64);
-	gather_stats->rdmatxsnds =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMATXSNDS]
-		     + stats_inst_offset_64);
-	gather_stats->rdmatxwrs =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMATXWRS]
-		     + stats_inst_offset_64);
-	gather_stats->rdmavbn =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMAVBND]
-		     + stats_inst_offset_64);
-	gather_stats->rdmavinv =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMAVINV]
-		     + stats_inst_offset_64);
-	gather_stats->udprxpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_UDPRXPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->udptxpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_UDPTXPKTS]
-		     + stats_inst_offset_64);
+	for (i = 0; i < max_stats_idx; i++) {
+		if (map[i].bitmask <= IRDMA_MAX_STATS_32)
+			new_val = rd32(dev->hw,
+				       dev->hw_stats_regs[i] + stats_inst_offset_32);
+		else
+			new_val = rd64(dev->hw,
+				       dev->hw_stats_regs[i] + stats_inst_offset_64);
+		gather_stats->val[map[i].byteoff / sizeof(u64)] = new_val;
+	}
 
 	irdma_process_stats(pestat);
 }
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 1b2e3e8..ec9f4df 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3708,89 +3708,59 @@ static int irdma_iw_port_immutable(struct ib_device *ibdev, u32 port_num,
 	return 0;
 }
 
-static const struct rdma_stat_desc irdma_hw_stat_descs[] = {
-	/* 32bit names */
-	[IRDMA_HW_STAT_INDEX_RXVLANERR].name = "rxVlanErrors",
-	[IRDMA_HW_STAT_INDEX_IP4RXDISCARD].name = "ip4InDiscards",
-	[IRDMA_HW_STAT_INDEX_IP4RXTRUNC].name = "ip4InTruncatedPkts",
-	[IRDMA_HW_STAT_INDEX_IP4TXNOROUTE].name = "ip4OutNoRoutes",
-	[IRDMA_HW_STAT_INDEX_IP6RXDISCARD].name = "ip6InDiscards",
-	[IRDMA_HW_STAT_INDEX_IP6RXTRUNC].name = "ip6InTruncatedPkts",
-	[IRDMA_HW_STAT_INDEX_IP6TXNOROUTE].name = "ip6OutNoRoutes",
-	[IRDMA_HW_STAT_INDEX_TCPRTXSEG].name = "tcpRetransSegs",
-	[IRDMA_HW_STAT_INDEX_TCPRXOPTERR].name = "tcpInOptErrors",
-	[IRDMA_HW_STAT_INDEX_TCPRXPROTOERR].name = "tcpInProtoErrors",
-	[IRDMA_HW_STAT_INDEX_RXRPCNPHANDLED].name = "cnpHandled",
-	[IRDMA_HW_STAT_INDEX_RXRPCNPIGNORED].name = "cnpIgnored",
-	[IRDMA_HW_STAT_INDEX_TXNPCNPSENT].name = "cnpSent",
-
-	/* 64bit names */
-	[IRDMA_HW_STAT_INDEX_IP4RXOCTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip4InOctets",
-	[IRDMA_HW_STAT_INDEX_IP4RXPKTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip4InPkts",
-	[IRDMA_HW_STAT_INDEX_IP4RXFRAGS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip4InReasmRqd",
-	[IRDMA_HW_STAT_INDEX_IP4RXMCOCTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip4InMcastOctets",
-	[IRDMA_HW_STAT_INDEX_IP4RXMCPKTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip4InMcastPkts",
-	[IRDMA_HW_STAT_INDEX_IP4TXOCTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip4OutOctets",
-	[IRDMA_HW_STAT_INDEX_IP4TXPKTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip4OutPkts",
-	[IRDMA_HW_STAT_INDEX_IP4TXFRAGS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip4OutSegRqd",
-	[IRDMA_HW_STAT_INDEX_IP4TXMCOCTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip4OutMcastOctets",
-	[IRDMA_HW_STAT_INDEX_IP4TXMCPKTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip4OutMcastPkts",
-	[IRDMA_HW_STAT_INDEX_IP6RXOCTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip6InOctets",
-	[IRDMA_HW_STAT_INDEX_IP6RXPKTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip6InPkts",
-	[IRDMA_HW_STAT_INDEX_IP6RXFRAGS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip6InReasmRqd",
-	[IRDMA_HW_STAT_INDEX_IP6RXMCOCTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip6InMcastOctets",
-	[IRDMA_HW_STAT_INDEX_IP6RXMCPKTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip6InMcastPkts",
-	[IRDMA_HW_STAT_INDEX_IP6TXOCTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip6OutOctets",
-	[IRDMA_HW_STAT_INDEX_IP6TXPKTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip6OutPkts",
-	[IRDMA_HW_STAT_INDEX_IP6TXFRAGS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip6OutSegRqd",
-	[IRDMA_HW_STAT_INDEX_IP6TXMCOCTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip6OutMcastOctets",
-	[IRDMA_HW_STAT_INDEX_IP6TXMCPKTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"ip6OutMcastPkts",
-	[IRDMA_HW_STAT_INDEX_TCPRXSEGS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"tcpInSegs",
-	[IRDMA_HW_STAT_INDEX_TCPTXSEG + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"tcpOutSegs",
-	[IRDMA_HW_STAT_INDEX_RDMARXRDS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"iwInRdmaReads",
-	[IRDMA_HW_STAT_INDEX_RDMARXSNDS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"iwInRdmaSends",
-	[IRDMA_HW_STAT_INDEX_RDMARXWRS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"iwInRdmaWrites",
-	[IRDMA_HW_STAT_INDEX_RDMATXRDS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"iwOutRdmaReads",
-	[IRDMA_HW_STAT_INDEX_RDMATXSNDS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"iwOutRdmaSends",
-	[IRDMA_HW_STAT_INDEX_RDMATXWRS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"iwOutRdmaWrites",
-	[IRDMA_HW_STAT_INDEX_RDMAVBND + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"iwRdmaBnd",
-	[IRDMA_HW_STAT_INDEX_RDMAVINV + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"iwRdmaInv",
-	[IRDMA_HW_STAT_INDEX_UDPRXPKTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"RxUDP",
-	[IRDMA_HW_STAT_INDEX_UDPTXPKTS + IRDMA_HW_STAT_INDEX_MAX_32].name =
-		"TxUDP",
-	[IRDMA_HW_STAT_INDEX_RXNPECNMARKEDPKTS + IRDMA_HW_STAT_INDEX_MAX_32]
-		.name = "RxECNMrkd",
+static const struct rdma_stat_desc irdma_hw_stat_names[] = {
+	/* gen1 - 32-bit */
+	[IRDMA_HW_STAT_INDEX_IP4RXDISCARD].name		= "ip4InDiscards",
+	[IRDMA_HW_STAT_INDEX_IP4RXTRUNC].name		= "ip4InTruncatedPkts",
+	[IRDMA_HW_STAT_INDEX_IP4TXNOROUTE].name		= "ip4OutNoRoutes",
+	[IRDMA_HW_STAT_INDEX_IP6RXDISCARD].name		= "ip6InDiscards",
+	[IRDMA_HW_STAT_INDEX_IP6RXTRUNC].name		= "ip6InTruncatedPkts",
+	[IRDMA_HW_STAT_INDEX_IP6TXNOROUTE].name		= "ip6OutNoRoutes",
+	[IRDMA_HW_STAT_INDEX_TCPRTXSEG].name		= "tcpRetransSegs",
+	[IRDMA_HW_STAT_INDEX_TCPRXOPTERR].name		= "tcpInOptErrors",
+	[IRDMA_HW_STAT_INDEX_TCPRXPROTOERR].name	= "tcpInProtoErrors",
+	[IRDMA_HW_STAT_INDEX_RXVLANERR].name		= "rxVlanErrors",
+	/* gen1 - 64-bit */
+	[IRDMA_HW_STAT_INDEX_IP4RXOCTS].name		= "ip4InOctets",
+	[IRDMA_HW_STAT_INDEX_IP4RXPKTS].name		= "ip4InPkts",
+	[IRDMA_HW_STAT_INDEX_IP4RXFRAGS].name		= "ip4InReasmRqd",
+	[IRDMA_HW_STAT_INDEX_IP4RXMCPKTS].name		= "ip4InMcastPkts",
+	[IRDMA_HW_STAT_INDEX_IP4TXOCTS].name		= "ip4OutOctets",
+	[IRDMA_HW_STAT_INDEX_IP4TXPKTS].name		= "ip4OutPkts",
+	[IRDMA_HW_STAT_INDEX_IP4TXFRAGS].name		= "ip4OutSegRqd",
+	[IRDMA_HW_STAT_INDEX_IP4TXMCPKTS].name		= "ip4OutMcastPkts",
+	[IRDMA_HW_STAT_INDEX_IP6RXOCTS].name		= "ip6InOctets",
+	[IRDMA_HW_STAT_INDEX_IP6RXPKTS].name		= "ip6InPkts",
+	[IRDMA_HW_STAT_INDEX_IP6RXFRAGS].name		= "ip6InReasmRqd",
+	[IRDMA_HW_STAT_INDEX_IP6RXMCPKTS].name		= "ip6InMcastPkts",
+	[IRDMA_HW_STAT_INDEX_IP6TXOCTS].name		= "ip6OutOctets",
+	[IRDMA_HW_STAT_INDEX_IP6TXPKTS].name		= "ip6OutPkts",
+	[IRDMA_HW_STAT_INDEX_IP6TXFRAGS].name		= "ip6OutSegRqd",
+	[IRDMA_HW_STAT_INDEX_IP6TXMCPKTS].name		= "ip6OutMcastPkts",
+	[IRDMA_HW_STAT_INDEX_TCPRXSEGS].name		= "tcpInSegs",
+	[IRDMA_HW_STAT_INDEX_TCPTXSEG].name		= "tcpOutSegs",
+	[IRDMA_HW_STAT_INDEX_RDMARXRDS].name		= "iwInRdmaReads",
+	[IRDMA_HW_STAT_INDEX_RDMARXSNDS].name		= "iwInRdmaSends",
+	[IRDMA_HW_STAT_INDEX_RDMARXWRS].name		= "iwInRdmaWrites",
+	[IRDMA_HW_STAT_INDEX_RDMATXRDS].name		= "iwOutRdmaReads",
+	[IRDMA_HW_STAT_INDEX_RDMATXSNDS].name		= "iwOutRdmaSends",
+	[IRDMA_HW_STAT_INDEX_RDMATXWRS].name		= "iwOutRdmaWrites",
+	[IRDMA_HW_STAT_INDEX_RDMAVBND].name		= "iwRdmaBnd",
+	[IRDMA_HW_STAT_INDEX_RDMAVINV].name		= "iwRdmaInv",
+
+	/* gen2 - 32-bit */
+	[IRDMA_HW_STAT_INDEX_RXRPCNPHANDLED].name	= "cnpHandled",
+	[IRDMA_HW_STAT_INDEX_RXRPCNPIGNORED].name	= "cnpIgnored",
+	[IRDMA_HW_STAT_INDEX_TXNPCNPSENT].name		= "cnpSent",
+	/* gen2 - 64-bit */
+	[IRDMA_HW_STAT_INDEX_IP4RXMCOCTS].name		= "ip4InMcastOctets",
+	[IRDMA_HW_STAT_INDEX_IP4TXMCOCTS].name		= "ip4OutMcastOctets",
+	[IRDMA_HW_STAT_INDEX_IP6RXMCOCTS].name		= "ip6InMcastOctets",
+	[IRDMA_HW_STAT_INDEX_IP6TXMCOCTS].name		= "ip6OutMcastOctets",
+	[IRDMA_HW_STAT_INDEX_UDPRXPKTS].name		= "RxUDP",
+	[IRDMA_HW_STAT_INDEX_UDPTXPKTS].name		= "TxUDP",
+	[IRDMA_HW_STAT_INDEX_RXNPECNMARKEDPKTS].name	= "RxECNMrkd",
+
 };
 
 static void irdma_get_dev_fw_str(struct ib_device *dev, char *str)
@@ -3810,14 +3780,13 @@ static void irdma_get_dev_fw_str(struct ib_device *dev, char *str)
 static struct rdma_hw_stats *irdma_alloc_hw_port_stats(struct ib_device *ibdev,
 						       u32 port_num)
 {
-	int num_counters = IRDMA_HW_STAT_INDEX_MAX_32 +
-			   IRDMA_HW_STAT_INDEX_MAX_64;
-	unsigned long lifespan = RDMA_HW_STATS_DEFAULT_LIFESPAN;
+	struct irdma_device *iwdev = to_iwdev(ibdev);
+	struct irdma_sc_dev *dev = &iwdev->rf->sc_dev;
 
-	BUILD_BUG_ON(ARRAY_SIZE(irdma_hw_stat_descs) !=
-		     (IRDMA_HW_STAT_INDEX_MAX_32 + IRDMA_HW_STAT_INDEX_MAX_64));
+	int num_counters = dev->hw_attrs.max_stat_idx;
+	unsigned long lifespan = RDMA_HW_STATS_DEFAULT_LIFESPAN;
 
-	return rdma_alloc_hw_stats_struct(irdma_hw_stat_descs, num_counters,
+	return rdma_alloc_hw_stats_struct(irdma_hw_stat_names, num_counters,
 					  lifespan);
 }
 
@@ -3840,7 +3809,7 @@ static int irdma_get_hw_stats(struct ib_device *ibdev,
 	else
 		irdma_cqp_gather_stats_gen1(&iwdev->rf->sc_dev, iwdev->vsi.pestat);
 
-	memcpy(&stats->value[0], hw_stats, sizeof(*hw_stats));
+	memcpy(&stats->value[0], hw_stats, sizeof(u64) * stats->num_counters);
 
 	return stats->num_counters;
 }
@@ -4054,7 +4023,7 @@ static int irdma_attach_mcast(struct ib_qp *ibqp, union ib_gid *ibgid, u16 lid)
 		mc_qht_elem->mc_grp_ctx.vlan_id = vlan_id;
 		if (vlan_id < VLAN_N_VID)
 			mc_qht_elem->mc_grp_ctx.vlan_valid = true;
-		mc_qht_elem->mc_grp_ctx.hmc_fcn_id = iwdev->vsi.fcn_id;
+		mc_qht_elem->mc_grp_ctx.hmc_fcn_id = iwdev->rf->sc_dev.hmc_fn_id;
 		mc_qht_elem->mc_grp_ctx.qs_handle =
 			iwqp->sc_qp.vsi->qos[iwqp->sc_qp.user_pri].qs_handle;
 		ether_addr_copy(mc_qht_elem->mc_grp_ctx.dest_mac_addr, dmac);
-- 
1.8.3.1

