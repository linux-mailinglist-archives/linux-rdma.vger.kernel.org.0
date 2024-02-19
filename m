Return-Path: <linux-rdma+bounces-1044-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7772A85A07C
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Feb 2024 11:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045841F2483E
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Feb 2024 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E705F2556D;
	Mon, 19 Feb 2024 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8nSM8rP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969E210FA;
	Mon, 19 Feb 2024 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337115; cv=none; b=RVJyAr7PoeFxzZ5h06Xn9moA7nEbHL12HDwdJS3ddLnKqmoRPQDwlN7A+G4NcxCRubKOkGjrRZlg+8Mhr1KF0CrmXvpHSAqEI8Q+XsLR4zWUrqNrMna0UWSl5livgz9KmzCP/Ke2fN8zJd66LSCjAIwRxiWeYPEWuFPM5zqH/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337115; c=relaxed/simple;
	bh=+vaXQiOlwrlEfVMuL5MnJ8PuL8Zf1ywZS/hJQleg+yk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LzosekUzcDtm2p3pvf4BGPbkqFRTrkS45iwIix+Oh+yyTAX3Ec/6e1PaaIYVD4QkP51DCP8ZDi3e5wKJ8ACDbcRvL8IrkTU4ZQv++cSYEzwWeaz2acOUSOk4BEMbBUvFrF4/diWJGG9UVV/EP6phmEvETI9jCtP9nZQZqgQ0SAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8nSM8rP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054DFC433F1;
	Mon, 19 Feb 2024 10:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708337115;
	bh=+vaXQiOlwrlEfVMuL5MnJ8PuL8Zf1ywZS/hJQleg+yk=;
	h=From:To:Cc:Subject:Date:From;
	b=K8nSM8rPqaSWjvA9wfBx7VyhGhrgsJjmtKGMBn6eaw3b3gNOhSlXfQ75f73PRfsnH
	 TYr47cZWoNghx0ytHhkuok08LOnJuFqfzsvCs95XwMlBTdEiB2aYPRHv/p+tuV0HpI
	 vKLMp6DwsmMyNDGNb99mzutP+Yiu0XdcJLwwWuCaybGvqOD3a6nPjSlbFcaI6FekuU
	 qhv9VEcezYlFyAT39n7yl4ti9THSaJRdqUpMSkyontHdzmz7T3Jg5EPKAaWy2QnM9V
	 3CUj9l5NS1XKeIAVbVSeaSu/xBi22luQY0OLnaZj/JTkiw9a44D3ZqK+2IiXOxWaUd
	 FNtoJIN+lgFVA==
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
	Erez Shitrit <erezsh@nvidia.com>,
	Hamdan Igbaria <hamdani@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net/mlx5: pre-initialize sprintf buffers
Date: Mon, 19 Feb 2024 11:04:55 +0100
Message-Id: <20240219100506.648089-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The debugfs files always in this driver all use an extra round-trip
through an snprintf() before getting put into a mlx5dr_dbg_dump_buff()
rather than the normal seq_printf().

Zhu Yanjun noticed that the buffers are not initialized before being
filled or reused and requested them to always be zeroed as a
preparation for having more reused between the buffers.

Requested-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../mellanox/mlx5/core/steering/dr_dbg.c      | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
index 64f4cc284aea..be7a8481d7d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
@@ -217,6 +217,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 
 	switch (action->action_type) {
 	case DR_ACTION_TYP_DROP:
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx\n",
 			       DR_DUMP_REC_TYPE_ACTION_DROP, action_id,
@@ -229,6 +230,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 			return ret;
 		break;
 	case DR_ACTION_TYP_FT:
+		memset(buff, 0, sizeof(buff));
 		if (action->dest_tbl->is_fw_tbl)
 			ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 				       "%d,0x%llx,0x%llx,0x%x,0x%x\n",
@@ -250,6 +252,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 			return ret;
 		break;
 	case DR_ACTION_TYP_CTR:
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx,0x%x\n",
 			       DR_DUMP_REC_TYPE_ACTION_CTR, action_id, rule_id,
@@ -262,6 +265,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 			return ret;
 		break;
 	case DR_ACTION_TYP_TAG:
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx,0x%x\n",
 			       DR_DUMP_REC_TYPE_ACTION_TAG, action_id, rule_id,
@@ -283,6 +287,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 
 		ptrn_arg = !action->rewrite->single_action_opt && ptrn && arg;
 
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx,0x%x,%d,0x%x,0x%x,0x%x",
 			       DR_DUMP_REC_TYPE_ACTION_MODIFY_HDR, action_id,
@@ -300,6 +305,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 
 		if (ptrn_arg) {
 			for (i = 0; i < action->rewrite->num_of_actions; i++) {
+				memset(buff, 0, sizeof(buff));
 				ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 					       ",0x%016llx",
 					       be64_to_cpu(((__be64 *)rewrite_data)[i]));
@@ -321,6 +327,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 		break;
 	}
 	case DR_ACTION_TYP_VPORT:
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx,0x%x\n",
 			       DR_DUMP_REC_TYPE_ACTION_VPORT, action_id, rule_id,
@@ -333,6 +340,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 			return ret;
 		break;
 	case DR_ACTION_TYP_TNL_L2_TO_L2:
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx\n",
 			       DR_DUMP_REC_TYPE_ACTION_DECAP_L2, action_id,
@@ -345,6 +353,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 			return ret;
 		break;
 	case DR_ACTION_TYP_TNL_L3_TO_L2:
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx,0x%x\n",
 			       DR_DUMP_REC_TYPE_ACTION_DECAP_L3, action_id,
@@ -360,6 +369,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 			return ret;
 		break;
 	case DR_ACTION_TYP_L2_TO_TNL_L2:
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx,0x%x\n",
 			       DR_DUMP_REC_TYPE_ACTION_ENCAP_L2, action_id,
@@ -372,6 +382,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 			return ret;
 		break;
 	case DR_ACTION_TYP_L2_TO_TNL_L3:
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx,0x%x\n",
 			       DR_DUMP_REC_TYPE_ACTION_ENCAP_L3, action_id,
@@ -384,6 +395,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 			return ret;
 		break;
 	case DR_ACTION_TYP_POP_VLAN:
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx\n",
 			       DR_DUMP_REC_TYPE_ACTION_POP_VLAN, action_id,
@@ -396,6 +408,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 			return ret;
 		break;
 	case DR_ACTION_TYP_PUSH_VLAN:
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx,0x%x\n",
 			       DR_DUMP_REC_TYPE_ACTION_PUSH_VLAN, action_id,
@@ -408,6 +421,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 			return ret;
 		break;
 	case DR_ACTION_TYP_INSERT_HDR:
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx,0x%x,0x%x,0x%x\n",
 			       DR_DUMP_REC_TYPE_ACTION_INSERT_HDR, action_id,
@@ -422,6 +436,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 			return ret;
 		break;
 	case DR_ACTION_TYP_REMOVE_HDR:
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx,0x%x,0x%x,0x%x\n",
 			       DR_DUMP_REC_TYPE_ACTION_REMOVE_HDR, action_id,
@@ -436,6 +451,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 			return ret;
 		break;
 	case DR_ACTION_TYP_SAMPLER:
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx,0x%x,0x%x,0x%x,0x%llx,0x%llx\n",
 			       DR_DUMP_REC_TYPE_ACTION_SAMPLER, action_id,
@@ -468,6 +484,7 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 				DR_DBG_PTR_TO_ID(action->range->miss_tbl_action->dest_tbl->tbl);
 		}
 
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,0x%llx,0x%x,0x%llx,0x%x,0x%llx,0x%x\n",
 			       DR_DUMP_REC_TYPE_ACTION_MATCH_RANGE, action_id,
@@ -507,6 +524,7 @@ dr_dump_rule_mem(struct seq_file *file, struct mlx5dr_ste *ste,
 	dr_dump_hex_print(hw_ste_dump, (char *)mlx5dr_ste_get_hw_ste(ste),
 			  DR_STE_SIZE_REDUCED);
 
+	memset(buff, 0, sizeof(buff));
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 		       "%d,0x%llx,0x%llx,%s\n", mem_rec_type,
 		       dr_dump_icm_to_idx(mlx5dr_ste_get_icm_addr(ste)),
@@ -554,6 +572,7 @@ static int dr_dump_rule(struct seq_file *file, struct mlx5dr_rule *rule)
 
 	format_ver = rule->matcher->tbl->dmn->info.caps.sw_format_ver;
 
+	memset(buff, 0, sizeof(buff));
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 		       "%d,0x%llx,0x%llx\n", DR_DUMP_REC_TYPE_RULE,
 		       rule_id, DR_DBG_PTR_TO_ID(rule->matcher));
@@ -593,6 +612,7 @@ dr_dump_matcher_mask(struct seq_file *file, struct mlx5dr_match_param *mask,
 	char dump[DR_HEX_SIZE];
 	int ret;
 
+	memset(buff, 0, sizeof(buff));
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH, "%d,0x%llx,",
 		       DR_DUMP_REC_TYPE_MATCHER_MASK, matcher_id);
 	if (ret < 0)
@@ -602,6 +622,7 @@ dr_dump_matcher_mask(struct seq_file *file, struct mlx5dr_match_param *mask,
 	if (ret)
 		return ret;
 
+	memset(buff, 0, sizeof(buff));
 	if (criteria & DR_MATCHER_CRITERIA_OUTER) {
 		dr_dump_hex_print(dump, (char *)&mask->outer, sizeof(mask->outer));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
@@ -617,6 +638,7 @@ dr_dump_matcher_mask(struct seq_file *file, struct mlx5dr_match_param *mask,
 	if (ret)
 		return ret;
 
+	memset(buff, 0, sizeof(buff));
 	if (criteria & DR_MATCHER_CRITERIA_INNER) {
 		dr_dump_hex_print(dump, (char *)&mask->inner, sizeof(mask->inner));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
@@ -632,6 +654,7 @@ dr_dump_matcher_mask(struct seq_file *file, struct mlx5dr_match_param *mask,
 	if (ret)
 		return ret;
 
+	memset(buff, 0, sizeof(buff));
 	if (criteria & DR_MATCHER_CRITERIA_MISC) {
 		dr_dump_hex_print(dump, (char *)&mask->misc, sizeof(mask->misc));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
@@ -647,6 +670,7 @@ dr_dump_matcher_mask(struct seq_file *file, struct mlx5dr_match_param *mask,
 	if (ret)
 		return ret;
 
+	memset(buff, 0, sizeof(buff));
 	if (criteria & DR_MATCHER_CRITERIA_MISC2) {
 		dr_dump_hex_print(dump, (char *)&mask->misc2, sizeof(mask->misc2));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
@@ -662,6 +686,7 @@ dr_dump_matcher_mask(struct seq_file *file, struct mlx5dr_match_param *mask,
 	if (ret)
 		return ret;
 
+	memset(buff, 0, sizeof(buff));
 	if (criteria & DR_MATCHER_CRITERIA_MISC3) {
 		dr_dump_hex_print(dump, (char *)&mask->misc3, sizeof(mask->misc3));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
@@ -687,6 +712,7 @@ dr_dump_matcher_builder(struct seq_file *file, struct mlx5dr_ste_build *builder,
 	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	int ret;
 
+	memset(buff, 0, sizeof(buff));
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 		       "%d,0x%llx,%d,%d,0x%x\n",
 		       DR_DUMP_REC_TYPE_MATCHER_BUILDER, matcher_id, index,
@@ -716,6 +742,7 @@ dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
 
 	s_icm_addr = mlx5dr_icm_pool_get_chunk_icm_addr(matcher_rx_tx->s_htbl->chunk);
 	e_icm_addr = mlx5dr_icm_pool_get_chunk_icm_addr(matcher_rx_tx->e_anchor->chunk);
+	memset(buff, 0, sizeof(buff));
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 		       "%d,0x%llx,0x%llx,%d,0x%llx,0x%llx\n",
 		       rec_type, DR_DBG_PTR_TO_ID(matcher_rx_tx),
@@ -752,6 +779,7 @@ dr_dump_matcher(struct seq_file *file, struct mlx5dr_matcher *matcher)
 
 	matcher_id = DR_DBG_PTR_TO_ID(matcher);
 
+	memset(buff, 0, sizeof(buff));
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 		       "%d,0x%llx,0x%llx,%d\n", DR_DUMP_REC_TYPE_MATCHER,
 		       matcher_id, DR_DBG_PTR_TO_ID(matcher->tbl),
@@ -816,6 +844,7 @@ dr_dump_table_rx_tx(struct seq_file *file, bool is_rx,
 			   DR_DUMP_REC_TYPE_TABLE_TX;
 
 	s_icm_addr = mlx5dr_icm_pool_get_chunk_icm_addr(table_rx_tx->s_anchor->chunk);
+	memset(buff, 0, sizeof(buff));
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 		       "%d,0x%llx,0x%llx\n", rec_type, table_id,
 		       dr_dump_icm_to_idx(s_icm_addr));
@@ -836,6 +865,7 @@ static int dr_dump_table(struct seq_file *file, struct mlx5dr_table *table)
 	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	int ret;
 
+	memset(buff, 0, sizeof(buff));
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 		       "%d,0x%llx,0x%llx,%d,%d\n", DR_DUMP_REC_TYPE_TABLE,
 		       DR_DBG_PTR_TO_ID(table), DR_DBG_PTR_TO_ID(table->dmn),
@@ -887,6 +917,7 @@ dr_dump_send_ring(struct seq_file *file, struct mlx5dr_send_ring *ring,
 	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	int ret;
 
+	memset(buff, 0, sizeof(buff));
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 		       "%d,0x%llx,0x%llx,0x%x,0x%x\n",
 		       DR_DUMP_REC_TYPE_DOMAIN_SEND_RING,
@@ -911,6 +942,7 @@ dr_dump_domain_info_flex_parser(struct seq_file *file,
 	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	int ret;
 
+	memset(buff, 0, sizeof(buff));
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 		       "%d,0x%llx,%s,0x%x\n",
 		       DR_DUMP_REC_TYPE_DOMAIN_INFO_FLEX_PARSER, domain_id,
@@ -937,6 +969,7 @@ dr_dump_domain_info_caps(struct seq_file *file, struct mlx5dr_cmd_caps *caps,
 	xa_for_each(&caps->vports.vports_caps_xa, vports_num, vport_caps)
 		; /* count the number of vports in xarray */
 
+	memset(buff, 0, sizeof(buff));
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 		       "%d,0x%llx,0x%x,0x%llx,0x%llx,0x%x,%lu,%d\n",
 		       DR_DUMP_REC_TYPE_DOMAIN_INFO_CAPS, domain_id, caps->gvmi,
@@ -952,6 +985,7 @@ dr_dump_domain_info_caps(struct seq_file *file, struct mlx5dr_cmd_caps *caps,
 	xa_for_each(&caps->vports.vports_caps_xa, i, vport_caps) {
 		vport_caps = xa_load(&caps->vports.vports_caps_xa, i);
 
+		memset(buff, 0, sizeof(buff));
 		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 			       "%d,0x%llx,%lu,0x%x,0x%llx,0x%llx\n",
 			       DR_DUMP_REC_TYPE_DOMAIN_INFO_VPORT,
@@ -1012,6 +1046,7 @@ dr_dump_domain(struct seq_file *file, struct mlx5dr_domain *dmn)
 	u64 domain_id = DR_DBG_PTR_TO_ID(dmn);
 	int ret;
 
+	memset(buff, 0, sizeof(buff));
 	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
 		       "%d,0x%llx,%d,0%x,%d,%u.%u.%u,%s,%d,%u,%u,%u\n",
 		       DR_DUMP_REC_TYPE_DOMAIN,
-- 
2.39.2


