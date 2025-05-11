Return-Path: <linux-rdma+bounces-10280-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05676AB2AA1
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 21:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DF91892280
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 19:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A3525F97A;
	Sun, 11 May 2025 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YN5kRbGE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF7266B47;
	Sun, 11 May 2025 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746992394; cv=fail; b=utujqx1y82CI2RK6ZbST88jxgSlBgUP16PHVjCUq/fmICOr+tvcEqHEOW/0BrOhrXrKDfQGry+ZFi22tv0D8m7xqpylZtU2lequPLC8UxoLTxzDf9QmRRj24TYat3x69KvmunvrcSS/l4cfovOs26Som7eitMPFawVcKMtJ63OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746992394; c=relaxed/simple;
	bh=ngyZyJkriuWBgH6ehVGyW0iTw1fC1IVVmB73MDvjszs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2OuJJAIU3NQuvcT9uwTa1V1Tgc2W2EPqnPLnnt+EJCHG6dGsvJlk+i8JRPZpSHFazFVM0x+ZEZ8xbuKm3TD5trK0Of9fNAOpEL/Tsy6EwdPu/v/99YKamGuc5B5Lk23RkTfYdQrS65MetAOKuW4Vw9n3o1MtWPrHsn9VnXMAkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YN5kRbGE; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHQO491tGeFyez64CIlyOzZoq4H9wR7SN5evCFmjU0I7YJGVmv6mXc0wUjs5PUkhZ57mfT22tTiU/GoS4kd/rXh07tbNzzKxQ7pzFbxu2DIHdS5m17m+MkGzJnIxYborCsegwMv64pdO7Qy0Pr3OmVqTtr1xVqm1CKMqLv++ZgAIwdsGyAsCerkFexWV+qr00hwmiARbZY3ADNaE2JOd3BNEGyl3Kq1Qg8QvGk34mN8xkA8GzJ8BIY+dU0qw7BBGN4Ik6F4G1+hHGEmluVsRondPYa11oMbalnL1GWwL4wGwBCKsuB0iA8BXN16UgmdqJQqH0xQyHNIJW413ebpArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLkCFHrHKYXFEqM6MvND1QK36DFVD5kectElTp20Zy0=;
 b=fZI1z/zqOvLul1+LI2K27N5mnfW5WMcbLD1U96hj+DyUlvgXTcT+Qz1UFn4uh+XXnwetR8RXR04T5zrJ7vVHDLGohJhkoNjcZL00ODZXlMD1hs+XAcfev/w8XUxXuReupWC0HoS5Lhm5EGiibaVesyotaAvRe3H47gF6/OimXIoHVbXuBRIczZnWVzg6mgzjioNA2iueLoCo0UBA2TGNjKQt3plYzfHsTc4LM7uov/hMLoscZfzFXyqOuf98Atmsmcj5SVjcWXT/duPixQRZx8JH2yfbWli1mAsc5ILYwd7pE7wIQ1ShMX4O1XuKrF5LVXwQcpI/JHp7PT2nq/HmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLkCFHrHKYXFEqM6MvND1QK36DFVD5kectElTp20Zy0=;
 b=YN5kRbGEitJcgMf0dXgLIxXblXRrd+e7lL/7Tg3xBqe4mabcVzsAaY594JbvZTm5WkDq50jaJ7ZuKJzXowDYj1ZsFyJEiolRyiCg8FqELiZxFqlImlfx/uLUcxtmHx08yfXWx2ulfQP3gk4GY/FQ2cJ4ejZH0N/ko9s62AY4B8Stzp2eJ+7+J8Aj1hIHEN14pVi43bPBmxrtA6CAOx2IAmrWCHkw2RdSw0DCy3C/FOcCU9h1tSI3pF3PsG2izJZMrDexEuXH81KCidQEKmz+OwsbUbhR8cQog8/9GZpcBptZO2JGdHlERXrFrXyjH134dMn6vgh+NraRoHzQKZoA8w==
Received: from BY3PR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:39b::15)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Sun, 11 May 2025 19:39:49 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::d1) by BY3PR05CA0040.outlook.office365.com
 (2603:10b6:a03:39b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Sun,
 11 May 2025 19:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Sun, 11 May 2025 19:39:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 12:39:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 11 May
 2025 12:39:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 11
 May 2025 12:39:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 09/10] net/mlx5: HWS, rework rehash loop
Date: Sun, 11 May 2025 22:38:09 +0300
Message-ID: <1746992290-568936-10-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
References: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d4994a-9ac8-4e1e-f7c3-08dd90c39710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1RBxBSY8WCoMRGIBoCy5vXByiqKCIBz/BEPaRSM+hNSe4ISmyh0+PnVzGJjM?=
 =?us-ascii?Q?NrKYtPD4YURCwZhpAjpjx7Lq34qQvEl6Pvy1QvL5NdnwZciswtoIfGUurdbR?=
 =?us-ascii?Q?0xUP5LW4HZqrY14UfNmAD9PS4fjnkcKAXglZ+76MlfBLhyM9peLg+h4kTzxS?=
 =?us-ascii?Q?O8+JfPTcC1uZQhpxMRRPx3O7lXUtKX5j5ddjQMn77mBZqVPFLpq4Tv6EYqDm?=
 =?us-ascii?Q?tQOPdTzoGXvTSPX1usG4vZdArDxVhJEfV4jjmJA64fwyTSmtV361y6DBRtZ1?=
 =?us-ascii?Q?zN3XhPU8n9BJ3YvcUKeTKoJ5le1PPV0EB70ia3CRjTzN2Zgffknd5kwWFnTH?=
 =?us-ascii?Q?iS7bKGZi6EV3Qfod45rLTfckBH2BTeS0jbMiSA0zBK0kb9Mq+jQn+32witUI?=
 =?us-ascii?Q?F3arfpxvr2z6sBhunOlHQwg5Sx/UXQF/jmze+ikWgnQhaZD/6WZaJ5rO9aiT?=
 =?us-ascii?Q?6JPgS8FRuOHqSTf+XzuWenogFVGYqsZT5fQPWzQ85fdOkXs1UCAjiPKbBTDR?=
 =?us-ascii?Q?Y+ZVnHlsuoV5iIgJ0SIvC2vpEUepb6nRaHiaURGEA0nblYbUu4hJ3XHNkmFf?=
 =?us-ascii?Q?HKIZrSUXoIUAjMU+XtSqPSaLIhcliUaeeEfdFBOQhGuTiXzDi50MRdIgqfqr?=
 =?us-ascii?Q?E5EMq5en+T+vX3N8znP8alV4XiL2qpMMKdOTu2AbDksaiaojq7EMA3bjIF+9?=
 =?us-ascii?Q?+z88tN62abcLq7SMB2uN4WudjnA7wL7830npsahSB7+DagMLM8A1/AB3HETx?=
 =?us-ascii?Q?xUc3O9NCrlJs+I095hKLCgl5fysotUehgzBxtSOif1VuHkHF29WJcniC9toZ?=
 =?us-ascii?Q?t6otzIHUPx9PcY7QX9/XI0e5GM/A6LrIIMPkcXbEA/3BuZRfnAUYEMWNBdBa?=
 =?us-ascii?Q?lx3FzOLsOFIuZNHfMWUFpE1b28YO9ZZgix5zMGXMmI0zG43jwVKOrWsC1GBQ?=
 =?us-ascii?Q?8Hh0rEtxUBKo9oeeKvG8DAfSPjbrMkjzVWy7SkpRi7MlHyIERJl8KtnDZb7p?=
 =?us-ascii?Q?2dokFdUcLGt3l++1MS3VbjTTs9qC64Cz/sQeU/4cEO/nlEa3c15Q2Cf03Wuf?=
 =?us-ascii?Q?htII8njWoVbl43jOEW3RWUJBNKk5xsnMy9HnuLUqxR9ShNfwPmtcMmS756Kn?=
 =?us-ascii?Q?kin7v3pDNQJbfJzPnCR7qxoW9Z9VrMAQn+4JvDArlcy71oQ2FgiAf8v6zQkW?=
 =?us-ascii?Q?Lj1M3QcUItFc0N5jagIXqocW299gm+RnnRbL9Bq6J7li3BZrvMnXL5cKPxb5?=
 =?us-ascii?Q?pcCTWlvz+npZ67Gw+E3aqp0hiTD6ajS07K7WmUCm8DjWzs0ziBW51cCPWTNR?=
 =?us-ascii?Q?F4PhJQjjfJRFkzOU/LDryAbu48n4m2ol4XvLsUbXUeLQrXktnRj5bvK2sOLE?=
 =?us-ascii?Q?BoqSP9sIBKI6xUfFHda+qBZPcunnbW6tWyTqUmHML/k06MKWOtT0zOcoa8g7?=
 =?us-ascii?Q?LeEUv5/M50WznE0ftZlwvvwfQ1jLsgGQ7ZJm3gjXcV1YB1hyUJW45ALDoiV7?=
 =?us-ascii?Q?dT6Feqw13drBmYLHj0E86V5lesvo51ZQy0Lz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 19:39:48.2728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d4994a-9ac8-4e1e-f7c3-08dd90c39710
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Reworking the rehash loop - simplifying the code and making it less
error prone:
 - Instead of doing round-robin on all the queues with batch of rules in
   each cycle, just go over all the queues and move all the rules that
   belong to this queue.
 - If at some stage of moving the rule we get a failure (which should
   not happen), this can't be rolled back. So instead of aborting
   rehash and leaving the matcher in a broken state, allow the loop
   to continue: attempt to move the rest of the rules and delete the
   old matcher. A rule that failed to move to a new matcher will loose
   its match STE once the rehash is completed and the old matcher is
   deleted, so the rule won't match any traffic any more. This rule's
   packets will fall back to the steering pipeline w/o HW offload.
   Rehash procedure will return an error, which will cause the rule
   insertion to fail for the rule that started this whole rehash.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 127 +++++++-----------
 1 file changed, 52 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 456fac895f5e..9e057f808ea5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -610,95 +610,69 @@ hws_bwc_matcher_find_at(struct mlx5hws_bwc_matcher *bwc_matcher,
 
 static int hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
+	bool move_error = false, poll_error = false, drain_error = false;
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	struct mlx5hws_matcher *matcher = bwc_matcher->matcher;
 	u16 bwc_queues = mlx5hws_bwc_queues(ctx);
-	struct mlx5hws_bwc_rule **bwc_rules;
 	struct mlx5hws_rule_attr rule_attr;
-	u32 *pending_rules;
-	int i, j, ret = 0;
-	bool all_done;
-	u16 burst_th;
+	struct mlx5hws_bwc_rule *bwc_rule;
+	struct mlx5hws_send_engine *queue;
+	struct list_head *rules_list;
+	u32 pending_rules;
+	int i, ret = 0;
 
 	mlx5hws_bwc_rule_fill_attr(bwc_matcher, 0, 0, &rule_attr);
 
-	pending_rules = kcalloc(bwc_queues, sizeof(*pending_rules), GFP_KERNEL);
-	if (!pending_rules)
-		return -ENOMEM;
-
-	bwc_rules = kcalloc(bwc_queues, sizeof(*bwc_rules), GFP_KERNEL);
-	if (!bwc_rules) {
-		ret = -ENOMEM;
-		goto free_pending_rules;
-	}
-
 	for (i = 0; i < bwc_queues; i++) {
 		if (list_empty(&bwc_matcher->rules[i]))
-			bwc_rules[i] = NULL;
-		else
-			bwc_rules[i] = list_first_entry(&bwc_matcher->rules[i],
-							struct mlx5hws_bwc_rule,
-							list_node);
-	}
+			continue;
 
-	do {
-		all_done = true;
+		pending_rules = 0;
+		rule_attr.queue_id = mlx5hws_bwc_get_queue_id(ctx, i);
+		rules_list = &bwc_matcher->rules[i];
 
-		for (i = 0; i < bwc_queues; i++) {
-			rule_attr.queue_id = mlx5hws_bwc_get_queue_id(ctx, i);
-			burst_th = hws_bwc_get_burst_th(ctx, rule_attr.queue_id);
-
-			for (j = 0; j < burst_th && bwc_rules[i]; j++) {
-				rule_attr.burst = !!((j + 1) % burst_th);
-				ret = mlx5hws_matcher_resize_rule_move(bwc_matcher->matcher,
-								       bwc_rules[i]->rule,
-								       &rule_attr);
-				if (unlikely(ret)) {
-					mlx5hws_err(ctx,
-						    "Moving BWC rule failed during rehash (%d)\n",
-						    ret);
-					goto free_bwc_rules;
-				}
+		list_for_each_entry(bwc_rule, rules_list, list_node) {
+			ret = mlx5hws_matcher_resize_rule_move(matcher,
+							       bwc_rule->rule,
+							       &rule_attr);
+			if (unlikely(ret && !move_error)) {
+				mlx5hws_err(ctx,
+					    "Moving BWC rule: move failed (%d), attempting to move rest of the rules\n",
+					    ret);
+				move_error = true;
+			}
 
-				all_done = false;
-				pending_rules[i]++;
-				bwc_rules[i] = list_is_last(&bwc_rules[i]->list_node,
-							    &bwc_matcher->rules[i]) ?
-					       NULL : list_next_entry(bwc_rules[i], list_node);
-
-				ret = mlx5hws_bwc_queue_poll(ctx,
-							     rule_attr.queue_id,
-							     &pending_rules[i],
-							     false);
-				if (unlikely(ret)) {
-					mlx5hws_err(ctx,
-						    "Moving BWC rule failed during rehash (%d)\n",
-						    ret);
-					goto free_bwc_rules;
-				}
+			pending_rules++;
+			ret = mlx5hws_bwc_queue_poll(ctx,
+						     rule_attr.queue_id,
+						     &pending_rules,
+						     false);
+			if (unlikely(ret && !poll_error)) {
+				mlx5hws_err(ctx,
+					    "Moving BWC rule: poll failed (%d), attempting to move rest of the rules\n",
+					    ret);
+				poll_error = true;
 			}
 		}
-	} while (!all_done);
-
-	/* drain all the bwc queues */
-	for (i = 0; i < bwc_queues; i++) {
-		if (pending_rules[i]) {
-			u16 queue_id = mlx5hws_bwc_get_queue_id(ctx, i);
 
-			mlx5hws_send_engine_flush_queue(&ctx->send_queue[queue_id]);
-			ret = mlx5hws_bwc_queue_poll(ctx, queue_id,
-						     &pending_rules[i], true);
-			if (unlikely(ret)) {
+		if (pending_rules) {
+			queue = &ctx->send_queue[rule_attr.queue_id];
+			mlx5hws_send_engine_flush_queue(queue);
+			ret = mlx5hws_bwc_queue_poll(ctx,
+						     rule_attr.queue_id,
+						     &pending_rules,
+						     true);
+			if (unlikely(ret && !drain_error)) {
 				mlx5hws_err(ctx,
-					    "Moving BWC rule failed during rehash (%d)\n", ret);
-				goto free_bwc_rules;
+					    "Moving BWC rule: drain failed (%d), attempting to move rest of the rules\n",
+					    ret);
+				drain_error = true;
 			}
 		}
 	}
 
-free_bwc_rules:
-	kfree(bwc_rules);
-free_pending_rules:
-	kfree(pending_rules);
+	if (move_error || poll_error || drain_error)
+		ret = -EINVAL;
 
 	return ret;
 }
@@ -742,15 +716,18 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
 	}
 
 	ret = hws_bwc_matcher_move_all(bwc_matcher);
-	if (ret) {
-		mlx5hws_err(ctx, "Rehash error: moving rules failed\n");
-		return -ENOMEM;
-	}
+	if (ret)
+		mlx5hws_err(ctx, "Rehash error: moving rules failed, attempting to remove the old matcher\n");
+
+	/* Error during rehash can't be rolled back.
+	 * The best option here is to allow the rehash to complete and remove
+	 * the old matcher - can't leave the matcher in the 'in_resize' state.
+	 */
 
 	bwc_matcher->matcher = new_matcher;
 	mlx5hws_matcher_destroy(old_matcher);
 
-	return 0;
+	return ret;
 }
 
 static int
-- 
2.31.1


