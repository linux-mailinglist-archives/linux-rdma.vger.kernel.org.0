Return-Path: <linux-rdma+bounces-9356-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF35A84CE4
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36878A69D2
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECA5298CDB;
	Thu, 10 Apr 2025 19:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rJxivHph"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F685298CCE;
	Thu, 10 Apr 2025 19:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312776; cv=fail; b=FYb9CH5jkBLU9lQ2yh9ziQUUNzQ0nyhKW0Jo2/HCf4LAci0jnRYsq/JL/QZtP4AMjDUgbBJC+Au86024lADywywGQYZu/zE8hHtcj1oe7OCCSiU6m4XY2PqepWTQp8UtDJcksG7ddnkD5Ptjz6zWymaMBgZIVBdcicf7cZhXU+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312776; c=relaxed/simple;
	bh=ozq5nNyPqvgamiid3fvBHYxvTtDVhGdhl6MXIBYKUoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlVsfdFW/Yo8Qxt9JXgZiePF4+UyJd4YqPHhlNle2xxd/+0ldtGqwsS/LnlrUOrryvWeMT+nV2b4IPEnWhL7xl+J2gYMhkTzqlgPJxbtHVm4O24MOb3Xcz8TzHVJAIv4w2ghOjEb50igKyKxSSVjC1DaUazDcQUwiaYcT2PCl1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rJxivHph; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNncUoPQfnqTecelq1kt75F7BMXgpB8koysXYAVT5986o6qEPm0LGNOqrgTVZLM6NOZg6ytjXAiMyE5BaaYrSwduCC0U/jjxBIohtsJoz9L/p4shYhotga26w3TDE/4df4tCTJYy6Xvofx14RqZJG9QzPYEeBQUu/FN4kaAgG7Xr3gSpIpao61MiGnW0WMhzFF3KU7daSX6pXPJ4pMWVdcwbb8vZtntlO5QU2VIJXHuCGkHaqhdBGkzQl4xmPIb8itjCiRUAIuiLCCPjTyTJXSh8t8zfGBe/SWOOTJnZf5uCNWBUAMkHaWP2tSaiKgrARABA/DZzScm1PXCSKTvNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmmQVbtw2fwBKhzRMLIGxh2ndX4g+qAr8KVVKPmrmkQ=;
 b=f8C+L5ENVNrs+6wr/ZyNN5NTcLFeHqplRWUjatGAVywzCcJIhhCiL5d9Zcw93f8TIgU6bXcs5ETt1uYxCzvYbx9RYeJ+ZWZ1kMi40xUeJiLAo5dkarsyg6HyJozmrPq329yBRmk/skSflzqqEonJNdohtJ/la3FXqvmdBRR/RiOefcQzIFVH7zZoQUHzllxNi+J0W1KGbqCCja0LbHWuicAT5LypD11U95g0GxvJCk3Bz6XSJJ+28OPGPhaq6CX+Zi0wQErHqPmSNBCpaYcOJNjs2BFOAj3BpUACydlWGuOzjrqpyk3HB9sgvKL6/UD9v/Le/flRLqQcwpYzZbYzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmmQVbtw2fwBKhzRMLIGxh2ndX4g+qAr8KVVKPmrmkQ=;
 b=rJxivHph6xtJ7s8Y1YV+w76x2UW+4MyR9yQ9Nm5qXyJe5vPV5pe6Im88KkBrx9lr+kxD1bQxpqjro3Zmcei1cbDCXtEZ/fYWNwLYl4G+FrusKdY/xC0OE3HDb/k07l9mEFeko+4kRO6JxnAiSHHW2Cf5xu1Ph5PpalnZXSABp5hoWL9e5nH7LeovC2iX+K7N5dwt0jayGYavYsSEo6JyfRI8T6Jo29tLU9JCXVkYU6U2ZNvgbEHh0P5CrVu9sS/62SnGCzlOyGtQfji9lzZOMLXREz9jpuMz2uxO+5sSVC908e83RNQVlgigVDSAVSUkucebu8rJwJc8bhCxTLqKrw==
Received: from SJ0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:a03:39e::28)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 19:19:30 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::56) by SJ0PR03CA0293.outlook.office365.com
 (2603:10b6:a03:39e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Thu,
 10 Apr 2025 19:18:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:18:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:18:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:18:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 12:18:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Michal Kubiak
	<michal.kubiak@intel.com>
Subject: [PATCH net-next V2 01/12] net/mlx5: HWS, Fix matcher action template attach
Date: Thu, 10 Apr 2025 22:17:31 +0300
Message-ID: <1744312662-356571-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
References: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 68dda70c-ce96-4a51-0912-08dd78647a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L/0G1tDSt8lZJjtqkIV2Le3R29D7ow3h2qzd+1j3stPzppXjNC/eyojp6tQG?=
 =?us-ascii?Q?JWZFzfhu8jiS7EYpLEzg7jeeMhlMhPhd2bVNTq6b6EqnHfbgE9FBhzQOqC/G?=
 =?us-ascii?Q?aq2USDCwm8YF9NqsimbBHGhFCjHqJd4JCtW2xIzqGnEQWUx07maPV+ImqJ2b?=
 =?us-ascii?Q?M1cDWtL+NQoXP54tebGflsT0TgDPms/d+z0fwFvtPZXKX5Cy8L1u5OmOBMCk?=
 =?us-ascii?Q?CWXa/hpkzGsKYHtGV6eK5e1/aQ14J/6Lpvb+QzvkNS97VTxdzntmiQczCT6J?=
 =?us-ascii?Q?gh3RwqexgUYMOsbGnJWzw/3h0miLWqvqtD+jHzQfZ9puuWYFL3S+OFqv49HA?=
 =?us-ascii?Q?nXRIBlfI0+uoI/IL1E+YU/IUQj8IC6EpTM7Vv3jJQbYrbsnycX1OmG0XasHT?=
 =?us-ascii?Q?43LvPCiS+60gIfuU2ZKsrODKgzws2reygab0McoiPmw+Xh7/BjsqTYcYyfIS?=
 =?us-ascii?Q?3UJM0f8kV1SVTyF/uSQnCzeTCdHTDDbC1QhA3pTe8lWDNsD5xQmXVpMLg2ru?=
 =?us-ascii?Q?ajXqXHqZMhmISUppmScPvDTJImFc1M7p7tT904HhtnZRPpRP3ymnExGaNANk?=
 =?us-ascii?Q?pLnVTYCrFTFk5KUZZgqVFM6yXcJpRl0RbAdI7rkuqtBjPcJuHGl5qCeE3KBP?=
 =?us-ascii?Q?BUE606xnOrdns4gLIVnMbc1YY7gfyUD9cjLjrWjO7VPsQvQoi/rO1nnwiiKk?=
 =?us-ascii?Q?sfJ1nM06SmOQhYlOP7jpmFd/y/wniX6A8w5T5PnfE+UE8hbj43jjaTAPurTm?=
 =?us-ascii?Q?tfkCPzB26KH7yPNyQFVAuv2bETwWxgwUEdO+TNWnOWItDGnF8WFvSyMhbMMu?=
 =?us-ascii?Q?XIbdLqql0AaSH5z5RJmyOxCLkbcHprln0adFoILZqTru6yjoUIgoOsmmhUg1?=
 =?us-ascii?Q?niHiXixOoSt1z4+gAAniquVFcJElpCR5JJypTFa7YrZVl0scPM3Z41vj7VAC?=
 =?us-ascii?Q?oxvkHkFiPLcLPkdlCTCnWQ8E20O+KX5L/0L++DhR5Sl1PQcRxbch8QgFTDjQ?=
 =?us-ascii?Q?GY6BJxuJFvB06Z86M5h+6MvY1VXlR5+sfCOJrqQdMawlqqSVm2F9c+K0onM9?=
 =?us-ascii?Q?B+iZgJ6dHfSZr+Ny2TtmMP+C6lz3NnnL3Lv8VaG2a8GAgrPOyhavs/x0H25K?=
 =?us-ascii?Q?lcMb7IMDwRinFqNzbGZaefueOYva4w87k6+wyJZT/s3kZXE1/mQnflUQ8pNR?=
 =?us-ascii?Q?VbNw917OEGwPUeJd09WXe/5Kzt/7T8n0x7ALrHzx/gh4AqhXYUIDLiArZEm+?=
 =?us-ascii?Q?in/NRSdbMh8GxNdZRmVcdVfn7omslsOGWFsYKi+QAml/uvq83FDL+lS059Yk?=
 =?us-ascii?Q?xwnCg6Jkeo4YK6OftN9pmRIEk9D8U82+A6g8ISsFzDhQKPLw2MqPxZNBKwcJ?=
 =?us-ascii?Q?QDGIdqQ8ELW9MjRhaeoSQXgDWOj/ew5QXHmn02DY8Sk8XALu81nw0He/OzMM?=
 =?us-ascii?Q?aM77kWEbClkLGJSvU3Bm7PQ3Gfq2bmeTXEPLqTVJwW5nFNCKlhccB6fMObIL?=
 =?us-ascii?Q?WgV15Fh9BBQoMQPuZ1QG06uX9DHeIZBLOQUU?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:18:29.8020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dda70c-ce96-4a51-0912-08dd78647a3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376

From: Vlad Dogaru <vdogaru@nvidia.com>

The procedure of attaching an action template to an existing matcher had
a few issues:

1. Attaching accidentally overran the `at` array in bwc_matcher, which
   would result in memory corruption. This bug wasn't triggered, but it
   is possible to trigger it by attaching action templates beyond the
   initial buffer size of 8. Fix this by converting to a dynamically
   sized buffer and reallocating if needed.

2. Similarly, the `at` array inside the native matcher was never
   reallocated. Fix this the same as above.

3. The bwc layer treated any error in action template attach as a signal
   that the matcher should be rehashed to account for a larger number of
   action STEs. In reality, there are other unrelated errors that can
   arise and they should be propagated upstack. Fix this by adding a
   `need_rehash` output parameter that's orthogonal to error codes.

Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 55 ++++++++++++++++---
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  9 ++-
 .../mellanox/mlx5/core/steering/hws/matcher.c | 48 +++++++++++++---
 .../mellanox/mlx5/core/steering/hws/matcher.h |  4 ++
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  5 +-
 5 files changed, 97 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 19dce1ba512d..32de8bfc7644 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -90,13 +90,19 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 	bwc_matcher->priority = priority;
 	bwc_matcher->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
 
+	bwc_matcher->size_of_at_array = MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM;
+	bwc_matcher->at = kcalloc(bwc_matcher->size_of_at_array,
+				  sizeof(*bwc_matcher->at), GFP_KERNEL);
+	if (!bwc_matcher->at)
+		goto free_bwc_matcher_rules;
+
 	/* create dummy action template */
 	bwc_matcher->at[0] =
 		mlx5hws_action_template_create(action_types ?
 					       action_types : init_action_types);
 	if (!bwc_matcher->at[0]) {
 		mlx5hws_err(table->ctx, "BWC matcher: failed creating action template\n");
-		goto free_bwc_matcher_rules;
+		goto free_bwc_matcher_at_array;
 	}
 
 	bwc_matcher->num_of_at = 1;
@@ -126,6 +132,8 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 	mlx5hws_match_template_destroy(bwc_matcher->mt);
 free_at:
 	mlx5hws_action_template_destroy(bwc_matcher->at[0]);
+free_bwc_matcher_at_array:
+	kfree(bwc_matcher->at);
 free_bwc_matcher_rules:
 	kfree(bwc_matcher->rules);
 err:
@@ -192,6 +200,7 @@ int mlx5hws_bwc_matcher_destroy_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 	for (i = 0; i < bwc_matcher->num_of_at; i++)
 		mlx5hws_action_template_destroy(bwc_matcher->at[i]);
+	kfree(bwc_matcher->at);
 
 	mlx5hws_match_template_destroy(bwc_matcher->mt);
 	kfree(bwc_matcher->rules);
@@ -520,6 +529,23 @@ hws_bwc_matcher_extend_at(struct mlx5hws_bwc_matcher *bwc_matcher,
 			  struct mlx5hws_rule_action rule_actions[])
 {
 	enum mlx5hws_action_type action_types[MLX5HWS_BWC_MAX_ACTS];
+	void *p;
+
+	if (unlikely(bwc_matcher->num_of_at >= bwc_matcher->size_of_at_array)) {
+		if (bwc_matcher->size_of_at_array >= MLX5HWS_MATCHER_MAX_AT)
+			return -ENOMEM;
+		bwc_matcher->size_of_at_array *= 2;
+		p = krealloc(bwc_matcher->at,
+			     bwc_matcher->size_of_at_array *
+				     sizeof(*bwc_matcher->at),
+			     __GFP_ZERO | GFP_KERNEL);
+		if (!p) {
+			bwc_matcher->size_of_at_array /= 2;
+			return -ENOMEM;
+		}
+
+		bwc_matcher->at = p;
+	}
 
 	hws_bwc_rule_actions_to_action_types(rule_actions, action_types);
 
@@ -777,6 +803,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	struct mlx5hws_rule_attr rule_attr;
 	struct mutex *queue_lock; /* Protect the queue */
 	u32 num_of_rules;
+	bool need_rehash;
 	int ret = 0;
 	int at_idx;
 
@@ -803,10 +830,14 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 		at_idx = bwc_matcher->num_of_at - 1;
 
 		ret = mlx5hws_matcher_attach_at(bwc_matcher->matcher,
-						bwc_matcher->at[at_idx]);
+						bwc_matcher->at[at_idx],
+						&need_rehash);
 		if (unlikely(ret)) {
-			/* Action template attach failed, possibly due to
-			 * requiring more action STEs.
+			hws_bwc_unlock_all_queues(ctx);
+			return ret;
+		}
+		if (unlikely(need_rehash)) {
+			/* The new action template requires more action STEs.
 			 * Need to attempt creating new matcher with all
 			 * the action templates, including the new one.
 			 */
@@ -942,6 +973,7 @@ hws_bwc_rule_action_update(struct mlx5hws_bwc_rule *bwc_rule,
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
 	struct mlx5hws_rule_attr rule_attr;
 	struct mutex *queue_lock; /* Protect the queue */
+	bool need_rehash;
 	int at_idx, ret;
 	u16 idx;
 
@@ -973,12 +1005,17 @@ hws_bwc_rule_action_update(struct mlx5hws_bwc_rule *bwc_rule,
 			at_idx = bwc_matcher->num_of_at - 1;
 
 			ret = mlx5hws_matcher_attach_at(bwc_matcher->matcher,
-							bwc_matcher->at[at_idx]);
+							bwc_matcher->at[at_idx],
+							&need_rehash);
 			if (unlikely(ret)) {
-				/* Action template attach failed, possibly due to
-				 * requiring more action STEs.
-				 * Need to attempt creating new matcher with all
-				 * the action templates, including the new one.
+				hws_bwc_unlock_all_queues(ctx);
+				return ret;
+			}
+			if (unlikely(need_rehash)) {
+				/* The new action template requires more action
+				 * STEs. Need to attempt creating new matcher
+				 * with all the action templates, including the
+				 * new one.
 				 */
 				ret = hws_bwc_matcher_rehash_at(bwc_matcher);
 				if (unlikely(ret)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index 47f7ed141553..bb0cf4b922ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -10,9 +10,7 @@
 #define MLX5HWS_BWC_MATCHER_REHASH_BURST_TH 32
 
 /* Max number of AT attach operations for the same matcher.
- * When the limit is reached, next attempt to attach new AT
- * will result in creation of a new matcher and moving all
- * the rules to this matcher.
+ * When the limit is reached, a larger buffer is allocated for the ATs.
  */
 #define MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM 8
 
@@ -23,10 +21,11 @@
 struct mlx5hws_bwc_matcher {
 	struct mlx5hws_matcher *matcher;
 	struct mlx5hws_match_template *mt;
-	struct mlx5hws_action_template *at[MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM];
-	u32 priority;
+	struct mlx5hws_action_template **at;
 	u8 num_of_at;
+	u8 size_of_at_array;
 	u8 size_log;
+	u32 priority;
 	atomic_t num_of_rules;
 	struct list_head *rules;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index b61864b32053..37a4497048a6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -905,18 +905,48 @@ static int hws_matcher_uninit(struct mlx5hws_matcher *matcher)
 	return 0;
 }
 
+static int hws_matcher_grow_at_array(struct mlx5hws_matcher *matcher)
+{
+	void *p;
+
+	if (matcher->size_of_at_array >= MLX5HWS_MATCHER_MAX_AT)
+		return -ENOMEM;
+
+	matcher->size_of_at_array *= 2;
+	p = krealloc(matcher->at,
+		     matcher->size_of_at_array * sizeof(*matcher->at),
+		     __GFP_ZERO | GFP_KERNEL);
+	if (!p) {
+		matcher->size_of_at_array /= 2;
+		return -ENOMEM;
+	}
+
+	matcher->at = p;
+
+	return 0;
+}
+
 int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
-			      struct mlx5hws_action_template *at)
+			      struct mlx5hws_action_template *at,
+			      bool *need_rehash)
 {
 	bool is_jumbo = mlx5hws_matcher_mt_is_jumbo(matcher->mt);
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
 	u32 required_stes;
 	int ret;
 
-	if (!matcher->attr.max_num_of_at_attach) {
-		mlx5hws_dbg(ctx, "Num of current at (%d) exceed allowed value\n",
-			    matcher->num_of_at);
-		return -EOPNOTSUPP;
+	*need_rehash = false;
+
+	if (unlikely(matcher->num_of_at >= matcher->size_of_at_array)) {
+		ret = hws_matcher_grow_at_array(matcher);
+		if (ret)
+			return ret;
+
+		if (matcher->col_matcher) {
+			ret = hws_matcher_grow_at_array(matcher->col_matcher);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = hws_matcher_check_and_process_at(matcher, at);
@@ -927,12 +957,11 @@ int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
 	if (matcher->action_ste.max_stes < required_stes) {
 		mlx5hws_dbg(ctx, "Required STEs [%d] exceeds initial action template STE [%d]\n",
 			    required_stes, matcher->action_ste.max_stes);
-		return -ENOMEM;
+		*need_rehash = true;
 	}
 
 	matcher->at[matcher->num_of_at] = *at;
 	matcher->num_of_at += 1;
-	matcher->attr.max_num_of_at_attach -= 1;
 
 	if (matcher->col_matcher)
 		matcher->col_matcher->num_of_at = matcher->num_of_at;
@@ -960,8 +989,9 @@ hws_matcher_set_templates(struct mlx5hws_matcher *matcher,
 	if (!matcher->mt)
 		return -ENOMEM;
 
-	matcher->at = kvcalloc(num_of_at + matcher->attr.max_num_of_at_attach,
-			       sizeof(*matcher->at),
+	matcher->size_of_at_array =
+		num_of_at + matcher->attr.max_num_of_at_attach;
+	matcher->at = kvcalloc(matcher->size_of_at_array, sizeof(*matcher->at),
 			       GFP_KERNEL);
 	if (!matcher->at) {
 		mlx5hws_err(ctx, "Failed to allocate action template array\n");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
index 020de70270c5..20b32012c418 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
@@ -23,6 +23,9 @@
  */
 #define MLX5HWS_MATCHER_ACTION_RTC_UPDATE_MULT 1
 
+/* Maximum number of action templates that can be attached to a matcher. */
+#define MLX5HWS_MATCHER_MAX_AT 128
+
 enum mlx5hws_matcher_offset {
 	MLX5HWS_MATCHER_OFFSET_TAG_DW1 = 12,
 	MLX5HWS_MATCHER_OFFSET_TAG_DW0 = 13,
@@ -72,6 +75,7 @@ struct mlx5hws_matcher {
 	struct mlx5hws_match_template *mt;
 	struct mlx5hws_action_template *at;
 	u8 num_of_at;
+	u8 size_of_at_array;
 	u8 num_of_mt;
 	/* enum mlx5hws_matcher_flags */
 	u8 flags;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index 5121951f2778..8ed8a715a2eb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -399,11 +399,14 @@ int mlx5hws_matcher_destroy(struct mlx5hws_matcher *matcher);
  *
  * @matcher: Matcher to attach the action template to.
  * @at: Action template to be attached to the matcher.
+ * @need_rehash: Output parameter that tells callers if the matcher needs to be
+ * rehashed.
  *
  * Return: Zero on success, non-zero otherwise.
  */
 int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
-			      struct mlx5hws_action_template *at);
+			      struct mlx5hws_action_template *at,
+			      bool *need_rehash);
 
 /**
  * mlx5hws_matcher_resize_set_target - Link two matchers and enable moving rules.
-- 
2.31.1


