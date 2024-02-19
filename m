Return-Path: <linux-rdma+bounces-1045-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0CB85A07F
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Feb 2024 11:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21C41C211F2
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Feb 2024 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC0425574;
	Mon, 19 Feb 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIqlK0/x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3C22F13;
	Mon, 19 Feb 2024 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337130; cv=none; b=VoEE4enWR486j1JxDr5+t7vfDjkOqx9V5qm5tjiXgvunFWWNI8AFJwNNie4mYag3Pgp1xeRMCmRB1Tu3kAkKN00HZv2FwOq9pQdH0QHlDGhq6dIks1nKy3qn+cTKqiJGjfEc7Ah5Dl6da8DqmXBezEeucWj2YL8tkQSBSfZeavA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337130; c=relaxed/simple;
	bh=Wp1z8DD4y2npUVyApGi7Hca+cEHUY33+maH5kr1tQf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M5J0459LtIsBn5CrllFaKzjzjOuEYRcrwl4pxU+OeD3NcskIjR1gnmPYn/dObHNKJ0fajcAXs59iufV31XoXCWOiGluTIV51rX6BHlQMdrX6E8lPR8Ww6t8dVh3vWHq9KZU3wFB0exiaiM7fjiqFJ/dPkm0goPL7+QJPJKkB5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIqlK0/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83B9C433F1;
	Mon, 19 Feb 2024 10:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708337129;
	bh=Wp1z8DD4y2npUVyApGi7Hca+cEHUY33+maH5kr1tQf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIqlK0/xwDm4hFEwUq+KvV91ubPAyFk5GkmJHR1wz7FaM7mmXgiGrgVUDFpwWgO+U
	 /TyKtGUmQTVguqYNLMBBLlNCE2AhS7bpIDZlo2XgreH1+ZTaPl8AIfh3oyzKAw7nSz
	 YJRiTIQN6azbWHt79KcQ5I02nL5llWFEUfPl6b4I0hSByeeBZYUAUKLSsWhChQ5D+e
	 CFyGm0EOJY2bglrWukdKWfjQe85i958MchkOqaI0O6hM8EX/USA7WSLbVjrcsQWnRO
	 rDYbZFIsQjY5JsTAwLjHjxKa8wiyZG6g03OSL2TEVe72D6jwAhUKeW/pYQcAe5F4Ak
	 Twubf9Tg6Azlw==
From: Arnd Bergmann <arnd@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Alex Vesker <valex@nvidia.com>,
	Hamdan Igbaria <hamdani@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [v2] net/mlx5: fix possible stack overflows
Date: Mon, 19 Feb 2024 11:04:56 +0100
Message-Id: <20240219100506.648089-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219100506.648089-1-arnd@kernel.org>
References: <20240219100506.648089-1-arnd@kernel.org>
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
[v2] no changes, just based on patch 1/2 but can still be applied independently
---
 .../mellanox/mlx5/core/steering/dr_dbg.c      | 82 +++++++++----------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
index be7a8481d7d2..eae04f66b8f4 100644
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
@@ -505,10 +504,9 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
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
@@ -540,7 +538,8 @@ dr_dump_rule_mem(struct seq_file *file, struct mlx5dr_ste *ste,
 }
 
 static int
-dr_dump_rule_rx_tx(struct seq_file *file, struct mlx5dr_rule_rx_tx *rule_rx_tx,
+dr_dump_rule_rx_tx(struct seq_file *file, char *buff,
+		   struct mlx5dr_rule_rx_tx *rule_rx_tx,
 		   bool is_rx, const u64 rule_id, u8 format_ver)
 {
 	struct mlx5dr_ste *ste_arr[DR_RULE_MAX_STES + DR_ACTION_MAX_STES];
@@ -551,7 +550,7 @@ dr_dump_rule_rx_tx(struct seq_file *file, struct mlx5dr_rule_rx_tx *rule_rx_tx,
 		return 0;
 
 	while (i--) {
-		ret = dr_dump_rule_mem(file, ste_arr[i], is_rx, rule_id,
+		ret = dr_dump_rule_mem(file, buff, ste_arr[i], is_rx, rule_id,
 				       format_ver);
 		if (ret < 0)
 			return ret;
@@ -560,7 +559,8 @@ dr_dump_rule_rx_tx(struct seq_file *file, struct mlx5dr_rule_rx_tx *rule_rx_tx,
 	return 0;
 }
 
-static int dr_dump_rule(struct seq_file *file, struct mlx5dr_rule *rule)
+static noinline_for_stack int
+dr_dump_rule(struct seq_file *file, struct mlx5dr_rule *rule)
 {
 	struct mlx5dr_rule_action_member *action_mem;
 	const u64 rule_id = DR_DBG_PTR_TO_ID(rule);
@@ -584,19 +584,19 @@ static int dr_dump_rule(struct seq_file *file, struct mlx5dr_rule *rule)
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
@@ -605,10 +605,10 @@ static int dr_dump_rule(struct seq_file *file, struct mlx5dr_rule *rule)
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
 
@@ -706,10 +706,10 @@ dr_dump_matcher_mask(struct seq_file *file, struct mlx5dr_match_param *mask,
 }
 
 static int
-dr_dump_matcher_builder(struct seq_file *file, struct mlx5dr_ste_build *builder,
+dr_dump_matcher_builder(struct seq_file *file, char *buff,
+			struct mlx5dr_ste_build *builder,
 			u32 index, bool is_rx, const u64 matcher_id)
 {
-	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	int ret;
 
 	memset(buff, 0, sizeof(buff));
@@ -728,11 +728,10 @@ dr_dump_matcher_builder(struct seq_file *file, struct mlx5dr_ste_build *builder,
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
@@ -758,7 +757,7 @@ dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
 		return ret;
 
 	for (i = 0; i < matcher_rx_tx->num_of_builders; i++) {
-		ret = dr_dump_matcher_builder(file,
+		ret = dr_dump_matcher_builder(file, buff,
 					      &matcher_rx_tx->ste_builder[i],
 					      i, is_rx, matcher_id);
 		if (ret < 0)
@@ -768,7 +767,7 @@ dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
 	return 0;
 }
 
-static int
+static noinline_for_stack int
 dr_dump_matcher(struct seq_file *file, struct mlx5dr_matcher *matcher)
 {
 	struct mlx5dr_matcher_rx_tx *rx = &matcher->rx;
@@ -791,19 +790,19 @@ dr_dump_matcher(struct seq_file *file, struct mlx5dr_matcher *matcher)
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
@@ -831,11 +830,10 @@ dr_dump_matcher_all(struct seq_file *file, struct mlx5dr_matcher *matcher)
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
@@ -858,7 +856,8 @@ dr_dump_table_rx_tx(struct seq_file *file, bool is_rx,
 	return 0;
 }
 
-static int dr_dump_table(struct seq_file *file, struct mlx5dr_table *table)
+static noinline_for_stack int
+dr_dump_table(struct seq_file *file, struct mlx5dr_table *table)
 {
 	struct mlx5dr_table_rx_tx *rx = &table->rx;
 	struct mlx5dr_table_rx_tx *tx = &table->tx;
@@ -878,14 +877,14 @@ static int dr_dump_table(struct seq_file *file, struct mlx5dr_table *table)
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
@@ -911,10 +910,10 @@ static int dr_dump_table_all(struct seq_file *file, struct mlx5dr_table *tbl)
 }
 
 static int
-dr_dump_send_ring(struct seq_file *file, struct mlx5dr_send_ring *ring,
+dr_dump_send_ring(struct seq_file *file, char *buff,
+		  struct mlx5dr_send_ring *ring,
 		  const u64 domain_id)
 {
-	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	int ret;
 
 	memset(buff, 0, sizeof(buff));
@@ -933,13 +932,13 @@ dr_dump_send_ring(struct seq_file *file, struct mlx5dr_send_ring *ring,
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
 
 	memset(buff, 0, sizeof(buff));
@@ -957,11 +956,11 @@ dr_dump_domain_info_flex_parser(struct seq_file *file,
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
@@ -1003,34 +1002,35 @@ dr_dump_domain_info_caps(struct seq_file *file, struct mlx5dr_cmd_caps *caps,
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
@@ -1067,12 +1067,12 @@ dr_dump_domain(struct seq_file *file, struct mlx5dr_domain *dmn)
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


