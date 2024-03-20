Return-Path: <linux-rdma+bounces-1494-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A542088172F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Mar 2024 19:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A1BB2103F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Mar 2024 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C179D6AF88;
	Wed, 20 Mar 2024 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4glrX9D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760FF6A33E;
	Wed, 20 Mar 2024 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710958118; cv=none; b=R2QlYkDTWcnqj9xgZcGVWe+51hGE7ArEdwMYxUEBJ8I1zBHxzyiz7LUyFm2a6D812QpJDg/wEUMRo7yTMbjw0R6z8Av1jxxHko1KWDUUrfExbj/Iz9yUBot/OLBhYK3KD37cKuZ6gi5GesNSHomaEjYWxzmvtlrMZtWNbARa2yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710958118; c=relaxed/simple;
	bh=s8hh5ibfmoqAlMKecBCXc82EDZUFeDU9i99TMxqttOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WMtdvDg3tn6qrufwrejszD6oqZMb9KUiw2+iYFxUeyvsxmdvxRniJZ1jREqxOH/m84QP9ZyiMqN2W1iEEHVFvsnzgC69kVqY7/6HmnxrvUvj6J3VPRbawi3U4t48Q5bboxocPQJJIgJt1nrKOzaGlLFcH1e6FUwiwcwL5MOQflQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4glrX9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD5FC433B1;
	Wed, 20 Mar 2024 18:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710958118;
	bh=s8hh5ibfmoqAlMKecBCXc82EDZUFeDU9i99TMxqttOw=;
	h=From:To:Cc:Subject:Date:From;
	b=Q4glrX9DQ+6EEuXw8ushrXysECS5j5nMhmSfRKrXH3wx/ne+0beyx7JFv5DgWPao6
	 GQ+Vr223mLFVwqzUXq+mbI3eMCkkNuW52/+xBFh7L8LEHtdF+sEb12UXkjUayvHVKx
	 WdYDxHvmgh/AWDVAxEPmxLfL4xdixjtI1afcmy76zIxm+5LNism5FHdvsaC/deCfcG
	 vi+jdr1Iz0ygXbfX4MiRxlI5CwcktEYOpWmBHO2CQ9rbaJOPlQIOnnr8TvFUCMKoya
	 8ir+LDcBs8QfVS9kKeWYZ04hvPQaraSVob2DGjZatjOJM3JjOFqxjvD9lE1ivGD0vr
	 lhcRvHGSIPuCg==
From: Arnd Bergmann <arnd@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Alex Vesker <valex@nvidia.com>,
	Erez Shitrit <erezsh@nvidia.com>,
	Hamdan Igbaria <hamdani@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] net/mlx5: fix possible stack overflows
Date: Wed, 20 Mar 2024 19:08:09 +0100
Message-Id: <20240320180831.185128-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A couple of debug functions use a 512 byte temporary buffer and call another
function that has another buffer of the same size, which in turn exceeds the
usual warning limit for excessive stack usage:

drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1073:1: error: stack frame size (1448) exceeds limit (1024) in 'dr_dump_start' [-Werror,-Wframe-larger-than]
dr_dump_start(struct seq_file *file, loff_t *pos)
drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1009:1: error: stack frame size (1120) exceeds limit (1024) in 'dr_dump_domain' [-Werror,-Wframe-larger-than]
dr_dump_domain(struct seq_file *file, struct mlx5dr_domain *dmn)
drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:705:1: error: stack frame size (1104) exceeds limit (1024) in 'dr_dump_matcher_rx_tx' [-Werror,-Wframe-larger-than]
dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,

Rework these so that each of the various code paths only ever has one of
these buffers in it, and exactly the functions that declare one have
the 'noinline_for_stack' annotation that prevents them from all being
inlined into the same caller.

Fixes: 917d1e799ddf ("net/mlx5: DR, Change SWS usage to debug fs seq_file interface")
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/all/20240219100506.648089-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
[v3] no changes, sending again without a second patch
[v2] no changes, just based on patch 1/2 but can still be applied independently
---
 .../mellanox/mlx5/core/steering/dr_dbg.c      | 82 +++++++++----------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
index 64f4cc284aea..030a5776c937 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
@@ -205,12 +205,11 @@ dr_dump_hex_print(char hex[DR_HEX_SIZE], char *src, u32 size)
 }
 
 static int
-dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
+dr_dump_rule_action_mem(struct seq_file *file, char *buff, const u64 rule_id,
 			struct mlx5dr_rule_action_member *action_mem)
 {
 	struct mlx5dr_action *action = action_mem->action;
 	const u64 action_id = DR_DBG_PTR_TO_ID(action);
-	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	u64 hit_tbl_ptr, miss_tbl_ptr;
 	u32 hit_tbl_id, miss_tbl_id;
 	int ret;
@@ -488,10 +487,9 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 }
 
 static int
-dr_dump_rule_mem(struct seq_file *file, struct mlx5dr_ste *ste,
+dr_dump_rule_mem(struct seq_file *file, char *buff, struct mlx5dr_ste *ste,
 		 bool is_rx, const u64 rule_id, u8 format_ver)
 {
-	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	char hw_ste_dump[DR_HEX_SIZE];
 	u32 mem_rec_type;
 	int ret;
@@ -522,7 +520,8 @@ dr_dump_rule_mem(struct seq_file *file, struct mlx5dr_ste *ste,
 }
 
 static int
-dr_dump_rule_rx_tx(struct seq_file *file, struct mlx5dr_rule_rx_tx *rule_rx_tx,
+dr_dump_rule_rx_tx(struct seq_file *file, char *buff,
+		   struct mlx5dr_rule_rx_tx *rule_rx_tx,
 		   bool is_rx, const u64 rule_id, u8 format_ver)
 {
 	struct mlx5dr_ste *ste_arr[DR_RULE_MAX_STES + DR_ACTION_MAX_STES];
@@ -533,7 +532,7 @@ dr_dump_rule_rx_tx(struct seq_file *file, struct mlx5dr_rule_rx_tx *rule_rx_tx,
 		return 0;
 
 	while (i--) {
-		ret = dr_dump_rule_mem(file, ste_arr[i], is_rx, rule_id,
+		ret = dr_dump_rule_mem(file, buff, ste_arr[i], is_rx, rule_id,
 				       format_ver);
 		if (ret < 0)
 			return ret;
@@ -542,7 +541,8 @@ dr_dump_rule_rx_tx(struct seq_file *file, struct mlx5dr_rule_rx_tx *rule_rx_tx,
 	return 0;
 }
 
-static int dr_dump_rule(struct seq_file *file, struct mlx5dr_rule *rule)
+static noinline_for_stack int
+dr_dump_rule(struct seq_file *file, struct mlx5dr_rule *rule)
 {
 	struct mlx5dr_rule_action_member *action_mem;
 	const u64 rule_id = DR_DBG_PTR_TO_ID(rule);
@@ -565,19 +565,19 @@ static int dr_dump_rule(struct seq_file *file, struct mlx5dr_rule *rule)
 		return ret;
 
 	if (rx->nic_matcher) {
-		ret = dr_dump_rule_rx_tx(file, rx, true, rule_id, format_ver);
+		ret = dr_dump_rule_rx_tx(file, buff, rx, true, rule_id, format_ver);
 		if (ret < 0)
 			return ret;
 	}
 
 	if (tx->nic_matcher) {
-		ret = dr_dump_rule_rx_tx(file, tx, false, rule_id, format_ver);
+		ret = dr_dump_rule_rx_tx(file, buff, tx, false, rule_id, format_ver);
 		if (ret < 0)
 			return ret;
 	}
 
 	list_for_each_entry(action_mem, &rule->rule_actions_list, list) {
-		ret = dr_dump_rule_action_mem(file, rule_id, action_mem);
+		ret = dr_dump_rule_action_mem(file, buff, rule_id, action_mem);
 		if (ret < 0)
 			return ret;
 	}
@@ -586,10 +586,10 @@ static int dr_dump_rule(struct seq_file *file, struct mlx5dr_rule *rule)
 }
 
 static int
-dr_dump_matcher_mask(struct seq_file *file, struct mlx5dr_match_param *mask,
+dr_dump_matcher_mask(struct seq_file *file, char *buff,
+		     struct mlx5dr_match_param *mask,
 		     u8 criteria, const u64 matcher_id)
 {
-	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	char dump[DR_HEX_SIZE];
 	int ret;
 
@@ -681,10 +681,10 @@ dr_dump_matcher_mask(struct seq_file *file, struct mlx5dr_match_param *mask,
 }
 
 static int
-dr_dump_matcher_builder(struct seq_file *file, struct mlx5dr_ste_build *builder,
+dr_dump_matcher_builder(struct seq_file *file, char *buff,
+			struct mlx5dr_ste_build *builder,
 			u32 index, bool is_rx, const u64 matcher_id)
 {
-	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	int ret;
 
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
@@ -702,11 +702,10 @@ dr_dump_matcher_builder(struct seq_file *file, struct mlx5dr_ste_build *builder,
 }
 
 static int
-dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
+dr_dump_matcher_rx_tx(struct seq_file *file, char *buff, bool is_rx,
 		      struct mlx5dr_matcher_rx_tx *matcher_rx_tx,
 		      const u64 matcher_id)
 {
-	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	enum dr_dump_rec_type rec_type;
 	u64 s_icm_addr, e_icm_addr;
 	int i, ret;
@@ -731,7 +730,7 @@ dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
 		return ret;
 
 	for (i = 0; i < matcher_rx_tx->num_of_builders; i++) {
-		ret = dr_dump_matcher_builder(file,
+		ret = dr_dump_matcher_builder(file, buff,
 					      &matcher_rx_tx->ste_builder[i],
 					      i, is_rx, matcher_id);
 		if (ret < 0)
@@ -741,7 +740,7 @@ dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
 	return 0;
 }
 
-static int
+static noinline_for_stack int
 dr_dump_matcher(struct seq_file *file, struct mlx5dr_matcher *matcher)
 {
 	struct mlx5dr_matcher_rx_tx *rx = &matcher->rx;
@@ -763,19 +762,19 @@ dr_dump_matcher(struct seq_file *file, struct mlx5dr_matcher *matcher)
 	if (ret)
 		return ret;
 
-	ret = dr_dump_matcher_mask(file, &matcher->mask,
+	ret = dr_dump_matcher_mask(file, buff, &matcher->mask,
 				   matcher->match_criteria, matcher_id);
 	if (ret < 0)
 		return ret;
 
 	if (rx->nic_tbl) {
-		ret = dr_dump_matcher_rx_tx(file, true, rx, matcher_id);
+		ret = dr_dump_matcher_rx_tx(file, buff, true, rx, matcher_id);
 		if (ret < 0)
 			return ret;
 	}
 
 	if (tx->nic_tbl) {
-		ret = dr_dump_matcher_rx_tx(file, false, tx, matcher_id);
+		ret = dr_dump_matcher_rx_tx(file, buff, false, tx, matcher_id);
 		if (ret < 0)
 			return ret;
 	}
@@ -803,11 +802,10 @@ dr_dump_matcher_all(struct seq_file *file, struct mlx5dr_matcher *matcher)
 }
 
 static int
-dr_dump_table_rx_tx(struct seq_file *file, bool is_rx,
+dr_dump_table_rx_tx(struct seq_file *file, char *buff, bool is_rx,
 		    struct mlx5dr_table_rx_tx *table_rx_tx,
 		    const u64 table_id)
 {
-	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	enum dr_dump_rec_type rec_type;
 	u64 s_icm_addr;
 	int ret;
@@ -829,7 +827,8 @@ dr_dump_table_rx_tx(struct seq_file *file, bool is_rx,
 	return 0;
 }
 
-static int dr_dump_table(struct seq_file *file, struct mlx5dr_table *table)
+static noinline_for_stack int
+dr_dump_table(struct seq_file *file, struct mlx5dr_table *table)
 {
 	struct mlx5dr_table_rx_tx *rx = &table->rx;
 	struct mlx5dr_table_rx_tx *tx = &table->tx;
@@ -848,14 +847,14 @@ static int dr_dump_table(struct seq_file *file, struct mlx5dr_table *table)
 		return ret;
 
 	if (rx->nic_dmn) {
-		ret = dr_dump_table_rx_tx(file, true, rx,
+		ret = dr_dump_table_rx_tx(file, buff, true, rx,
 					  DR_DBG_PTR_TO_ID(table));
 		if (ret < 0)
 			return ret;
 	}
 
 	if (tx->nic_dmn) {
-		ret = dr_dump_table_rx_tx(file, false, tx,
+		ret = dr_dump_table_rx_tx(file, buff, false, tx,
 					  DR_DBG_PTR_TO_ID(table));
 		if (ret < 0)
 			return ret;
@@ -881,10 +880,10 @@ static int dr_dump_table_all(struct seq_file *file, struct mlx5dr_table *tbl)
 }
 
 static int
-dr_dump_send_ring(struct seq_file *file, struct mlx5dr_send_ring *ring,
+dr_dump_send_ring(struct seq_file *file, char *buff,
+		  struct mlx5dr_send_ring *ring,
 		  const u64 domain_id)
 {
-	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	int ret;
 
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
@@ -902,13 +901,13 @@ dr_dump_send_ring(struct seq_file *file, struct mlx5dr_send_ring *ring,
 	return 0;
 }
 
-static noinline_for_stack int
+static int
 dr_dump_domain_info_flex_parser(struct seq_file *file,
+				char *buff,
 				const char *flex_parser_name,
 				const u8 flex_parser_value,
 				const u64 domain_id)
 {
-	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	int ret;
 
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
@@ -925,11 +924,11 @@ dr_dump_domain_info_flex_parser(struct seq_file *file,
 	return 0;
 }
 
-static noinline_for_stack int
-dr_dump_domain_info_caps(struct seq_file *file, struct mlx5dr_cmd_caps *caps,
+static int
+dr_dump_domain_info_caps(struct seq_file *file, char *buff,
+			 struct mlx5dr_cmd_caps *caps,
 			 const u64 domain_id)
 {
-	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	struct mlx5dr_cmd_vport_cap *vport_caps;
 	unsigned long i, vports_num;
 	int ret;
@@ -969,34 +968,35 @@ dr_dump_domain_info_caps(struct seq_file *file, struct mlx5dr_cmd_caps *caps,
 }
 
 static int
-dr_dump_domain_info(struct seq_file *file, struct mlx5dr_domain_info *info,
+dr_dump_domain_info(struct seq_file *file, char *buff,
+		    struct mlx5dr_domain_info *info,
 		    const u64 domain_id)
 {
 	int ret;
 
-	ret = dr_dump_domain_info_caps(file, &info->caps, domain_id);
+	ret = dr_dump_domain_info_caps(file, buff, &info->caps, domain_id);
 	if (ret < 0)
 		return ret;
 
-	ret = dr_dump_domain_info_flex_parser(file, "icmp_dw0",
+	ret = dr_dump_domain_info_flex_parser(file, buff, "icmp_dw0",
 					      info->caps.flex_parser_id_icmp_dw0,
 					      domain_id);
 	if (ret < 0)
 		return ret;
 
-	ret = dr_dump_domain_info_flex_parser(file, "icmp_dw1",
+	ret = dr_dump_domain_info_flex_parser(file, buff, "icmp_dw1",
 					      info->caps.flex_parser_id_icmp_dw1,
 					      domain_id);
 	if (ret < 0)
 		return ret;
 
-	ret = dr_dump_domain_info_flex_parser(file, "icmpv6_dw0",
+	ret = dr_dump_domain_info_flex_parser(file, buff, "icmpv6_dw0",
 					      info->caps.flex_parser_id_icmpv6_dw0,
 					      domain_id);
 	if (ret < 0)
 		return ret;
 
-	ret = dr_dump_domain_info_flex_parser(file, "icmpv6_dw1",
+	ret = dr_dump_domain_info_flex_parser(file, buff, "icmpv6_dw1",
 					      info->caps.flex_parser_id_icmpv6_dw1,
 					      domain_id);
 	if (ret < 0)
@@ -1032,12 +1032,12 @@ dr_dump_domain(struct seq_file *file, struct mlx5dr_domain *dmn)
 	if (ret)
 		return ret;
 
-	ret = dr_dump_domain_info(file, &dmn->info, domain_id);
+	ret = dr_dump_domain_info(file, buff, &dmn->info, domain_id);
 	if (ret < 0)
 		return ret;
 
 	if (dmn->info.supp_sw_steering) {
-		ret = dr_dump_send_ring(file, dmn->send_ring, domain_id);
+		ret = dr_dump_send_ring(file, buff, dmn->send_ring, domain_id);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.39.2


