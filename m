Return-Path: <linux-rdma+bounces-11984-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B5DAFD987
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 23:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4314A870A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 21:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E4F24DCE9;
	Tue,  8 Jul 2025 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qSVOOS/Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227E24A049;
	Tue,  8 Jul 2025 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009428; cv=fail; b=G775pF0oj1ou/1K0vLVJdu+hW2A7X4OVF0Q487sse000EJM4z2JkSufhk8eR6rN25p8nC5FLK9oBSIdqJeqaGsm9k0ULj+0Asy0tLwurxewul1TZbXFkfDO7pRhO9XR7Ox7kGM+tDni4MYoxE8OgCXJ9+T8M6T2TlJUMNfS8JeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009428; c=relaxed/simple;
	bh=tO67gcMgBlgm3G0CkGSTNSQxv3hTAkuj+qwjgGZ9yig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfLQITA/WQ5gH8rAvk+kt1fB8ILzU1GpwopRs6wCdtppx953PpE6hs2EGYW/TyLBjNu8yABjMor7uucF12qz1hH8SnMcGsacw7J9cqX/skYNYUwyoLSV4Bv6aFh2wa9dU9nv0gFaqstzFW23C3D2y5reiz/mf88RwEvPpp349IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qSVOOS/Y; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJiyIeSTE/Z6jEEXwdhzvocfwfbFC2d3cmhGPNNMx/Im/cg35kkitpiAnjzFjhULf5EX8iwPN0NaphLZXPwdIWGaQQytjkH/LQKGoWRReAYVsPgBKuZ4Vix/+Pf3Q2LP8jNMULmkpFfhVam89DBV7UKEqYqElyPkqwSbh+jNwUNJ0IdQxDYIT2DZ4uDXyxwnVKBRStODJcYBC+R7pfMgJmBQVLXOil7mp6YS7fhVRHznRyHD3PNHU8cbel/VdBY0ZaVHozaInLWhAQ8hO+K8z1/bEf5VGXSRQTkmw6x+Aam3BeByskaTdqaoRUsotccdguuZo7ufwfh8XN4sZtJ4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW2IuU/a7LM1HdZXHZo2LwtR0skoM+7tsOL3JyPCpJM=;
 b=eikJONnwSglmJtlQvf36DjDjeRAMeKvULYkaNS5Okm4TGvY3LaaU7o+ead33aa+RFf25L/LpZB9DZ2HbrS1/K+ir8nJdLw+ZhLrHRh5X1P6Zo6HGFDvdwlBbTtdp0Ul+pky/uYEmaIsO1HRt87xQGQfuN5rNuk5yu2jLyKKOwZ15/fnedNFCRLAIZKHaiDqafuhiTfag3Yu2vzMrQRYzk+Zmisj1WXTb/GM/jqzl/L6Vnf/SPwTDj1euP/tn0Jmv5Pxa2F9ExZ8bIoN0g4ZUjGXhJrGQvxzXmxIpANNbAMvI0InUAaqv+M4WciL5nWjldzeMKw2cWsbR3PURB267Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW2IuU/a7LM1HdZXHZo2LwtR0skoM+7tsOL3JyPCpJM=;
 b=qSVOOS/YVrBN0mokRwN1kl8SjoaiFjLb8tbIw1chhsYr6jXIbGSS7uGQgqX8nliRyGPQTuGZkDTkJ/qR52qn5xd/y/fdRdqVA7QXnvn3aSV1AV9ZyHlVSYZF9HadZEZvzySZ0G8CSACeRxMQe5xUBqzqUpnZWA3iGE4rqCy5BFLcKjpfmi5Q6JIlFa92P7FyIEJoeeinRrtpQokFh2UNXwihFTL35hPxxP1lwedDJ1pF/05Hz59mxAfPvcmiJqw1fEnxsN65A76O8rDVeCkrNewWPhO2myuUYhO1sQa+J4nnUxuW7CxtGiNrz6fM4cgX4aubdao76yAPcVQlsyUSag==
Received: from SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) by MW4PR12MB7333.namprd12.prod.outlook.com
 (2603:10b6:303:21b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Tue, 8 Jul
 2025 21:17:04 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::a2) by SN6PR2101CA0001.outlook.office365.com
 (2603:10b6:805:106::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.5 via Frontend Transport; Tue, 8
 Jul 2025 21:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 21:17:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 14:16:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 14:16:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 14:16:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 2/5] net/mlx5e: CT: extract a memcmp from a spinlock section
Date: Wed, 9 Jul 2025 00:16:24 +0300
Message-ID: <1752009387-13300-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
References: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 5501dc16-aff8-4c23-5676-08ddbe64c91b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wYVBS2CmkObccRyhdGF4RF2qBGH8B2zI9nOGWKfW0XQD3E0h80c1tD9nUNK+?=
 =?us-ascii?Q?8GIeoHItoZUJXHeiEyK9K4GXvc5XME1wg4eal1ZtiHtHru5Tp4EBFr6wfKtC?=
 =?us-ascii?Q?TtguK20Rk58xodXR4JeDCeH7liQyMiypSroEI0j4mT41G7wewYBM/51+BupB?=
 =?us-ascii?Q?l9/1egkXMkQ2ZbqATMq9Q3QRmLvr9kz+Dkrt7+pD3ib33a7p6T+wicwyoaeF?=
 =?us-ascii?Q?gCmjnw7WzOMqo3kG9hT3XpD83OY3cf9ywsLGjPhoiQbiXtp2EXnwvJ71NH55?=
 =?us-ascii?Q?gNWS2gcEMH0mMowW6y7W950RdsgWGTQMWVAsOcvzTBA6WHkZl9+piP+M0z54?=
 =?us-ascii?Q?u+tB6o0EUerXWC8jPopmyHsuSrfrBfeu2Wqk/yBlyC7HLCV/KYdwz5i3OCKT?=
 =?us-ascii?Q?QsFXQGt6K4FqdouqEh2ODhaLMPVwjG6myNMtc7I3QB8yQ8qOdnXkikLDiegY?=
 =?us-ascii?Q?v+8/ljz1Oxfai8JHb+yimJLqsHSeP0o5PmtSQhqtJh0TrBtbRD3gwm3+8ggh?=
 =?us-ascii?Q?6S5NGu1hAJC34QCRZ2bTvHXx3gZwxe+ocpS6tzfFI+GR++dVbJU3exSt+oxj?=
 =?us-ascii?Q?JLJTGvDqA+9Bk9vrDvwIZOx7r2fq7l0Udz0MZ5fdSgenf8/dwEsdoBYgKkJz?=
 =?us-ascii?Q?L7MNbnv4Gq2fSriT50pdE3Cj2hPHdOIyHh85kYlDU0qJtFlhB0P6RXhNuesI?=
 =?us-ascii?Q?TF5hnOPPTqjZ5n/ln0GG/jruusWodxw7YEhdHUsi4LPvf8McMOrvRBwW31BZ?=
 =?us-ascii?Q?LYzzBW35w+GzSentGE1Kply1UFbajLzEY+Ge5zMZc99Rjxni/cp5H6DuTE9g?=
 =?us-ascii?Q?UYVLweeYs29O0CQSipWFUZCPc0eNHExxWHs38SPce/vK4eRA6VXTLPLBu42P?=
 =?us-ascii?Q?EqpUlLGxC7ISdPM71mUTyPWSd3CAxkQDS0Vgb7zlJwAqZB2l6hfqxAX5YKdn?=
 =?us-ascii?Q?BB7qnvgzZLIFv/nWVoVbO0igvEGwFamWqMkChFH/zg+TziQ4Vy2soMxGloXp?=
 =?us-ascii?Q?eEgQNgvnQyvZmSxVB83MLzYcNqEiwlANg3Wi0F4oLHkxgrrJGlEfb/Q+RZPx?=
 =?us-ascii?Q?UTAT8EM5DwdF5h9yZKJuvbb8yKUlsegJ07LuFNmNJ3L64P0pqUFCdmF9rXRM?=
 =?us-ascii?Q?+8xkdDxTFQw3VkpIivfBpz3IkQyUmUFRJVtMKPNXhUQJ9huBdFksYX+aatk1?=
 =?us-ascii?Q?eJscxFU3vWI6B/PF60YNCwZDjFpgcVrwNwMopW7yt9OFKCHNCbGQyio5XhxR?=
 =?us-ascii?Q?oU8P4PGXBUFvHGNOXa1JELiiwOHqxaiUWUC8Y4qsoYGfDaRODucSDKEzK4cs?=
 =?us-ascii?Q?LsC9ytJTgFEJ/eaCOIO9zOGKaBFQ4KCfVe1YG9xb7ctKucy6oPZTKnrAHDf+?=
 =?us-ascii?Q?RpR08u7gU9gmyC28Ov3pbR2rtvTAqU+5eTRgot/jJUxUDcPtEROWoo3rQeg/?=
 =?us-ascii?Q?jZvPkevvPNLtzjYshXlXgR6ZCmuxFh5CRNRPW4aKdYcBY0tBzmAnQBfoBjyl?=
 =?us-ascii?Q?7EoDCaYqVJM+HZVd6gUTZB1hzlGIH9NAA8Sy?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 21:17:03.5149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5501dc16-aff8-4c23-5676-08ddbe64c91b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333

From: Cosmin Ratiu <cratiu@nvidia.com>

This reduces the time the lock is held and reduces contention.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 81332cd4a582..870d12364f99 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -1195,6 +1195,7 @@ mlx5_tc_ct_block_flow_offload_add(struct mlx5_ct_ft *ft,
 	struct flow_action_entry *meta_action;
 	unsigned long cookie = flow->cookie;
 	struct mlx5_ct_entry *entry;
+	bool has_nat;
 	int err;
 
 	meta_action = mlx5_tc_ct_get_ct_metadata_action(flow_rule);
@@ -1236,6 +1237,8 @@ mlx5_tc_ct_block_flow_offload_add(struct mlx5_ct_ft *ft,
 	err = mlx5_tc_ct_rule_to_tuple_nat(&entry->tuple_nat, flow_rule);
 	if (err)
 		goto err_set;
+	has_nat = memcmp(&entry->tuple, &entry->tuple_nat,
+			 sizeof(entry->tuple));
 
 	spin_lock_bh(&ct_priv->ht_lock);
 
@@ -1244,7 +1247,7 @@ mlx5_tc_ct_block_flow_offload_add(struct mlx5_ct_ft *ft,
 	if (err)
 		goto err_entries;
 
-	if (memcmp(&entry->tuple, &entry->tuple_nat, sizeof(entry->tuple))) {
+	if (has_nat) {
 		err = rhashtable_lookup_insert_fast(&ct_priv->ct_tuples_nat_ht,
 						    &entry->tuple_nat_node,
 						    tuples_nat_ht_params);
-- 
2.31.1


