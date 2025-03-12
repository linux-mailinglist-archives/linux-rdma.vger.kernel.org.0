Return-Path: <linux-rdma+bounces-8605-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584DEA5DBFC
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 12:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E2A1887A06
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E21F23F384;
	Wed, 12 Mar 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UTvtTtls"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF523A9BA;
	Wed, 12 Mar 2025 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780240; cv=fail; b=qu2wDOG+zoKF5awIF18TDG9DHTtI9lVYeOEZTKerhHBeRuZXIyGpG9IC4vqPQJmPocEYjtFZIl/QsisiS3FqoaMTgiDjWNa06hNidv7zeSSobdaw4WZXWlNI+4b5O6G/YSXMhAW2F6a3M51k9AZo/eMJmNGbJbtBTlM4/c5mX3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780240; c=relaxed/simple;
	bh=E+vCGtAgxG//KW4YmPTPsTtl5pe2tCmAppTiQ+Ogvrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRQkxhs9znLEchmGJrw+vFlyd2PyNlWHCtnLJvxV0SripxZCnzKUgUsMBw4gBjEbATSUvRvzmFAwyRUCv95r9dv+x2Bg/kYCdiFkKthJBYnWbSsWWvVfWy6UEZehEKq/sbJDogSnzt8nN5gwPc62LLIzNzqkUVEniKL11rZwpzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UTvtTtls; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aC7Jw8Sr/OFBumc4Qv7iJTSVsWVbTH/dIXR126He42WJMD1vygaKp+afwSWQXKpaAge+j7n0fj6d+pMIzPqboG1dvHlSMfqJ1zpRRmmzjSPQoE+nGoR8cY6RPcjY4Aeonkcw7OkwXCCysv/sHnaiyNGZIVmeKi5G2jB2oQoSM1AsdR/OzzysNK9h1TH5vUJBdP1h9KtJDzZL7qfjrtqit/4bA8J7fd3lO76bOzh3kk+2yEBE8ckGtSLjo/+EB/NOUN06QwcMPwiNNn11gpVIZK9cuGBT/GrwY5BzBVoQ3o366WqfM7C8gbgvv/NFNjUy1/M0MMlmCcAYhHPhKiRNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB6xCIR8EI2qJcdNRanKSb1dlteyno4Yu08+AF5rXtw=;
 b=FMnHDfwV9X47Wry1KZU3/pO+r2WaEe/cOXwfTryV7ASj1OX4oHMG9M+j1DhOFeZ3mkGWyNGuzjFq7ql65OHCJbD5TG5VbqcVwYNsIjDNXffklhFKhETEG27/eLO5FVdUUbBWa5YAt7XfHEsOMmavHZjJkA6A/SMeEWEa/niwGF/zRxFMDJ9HPCokx1tLER+jModfaaZGajrwMaNTjEujzwkZZoRr6pqWKTzS7d7tyKzG4aLTkBEIqiCZ3hX2Z+M8brWiH/uobn9DD55Mt5wG+eTlMVUs7EBxEqJBOfBd5gEj2PErBvciUMWp3aUBnWt0Jq6q9hmpi97m4bLjmqPfJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB6xCIR8EI2qJcdNRanKSb1dlteyno4Yu08+AF5rXtw=;
 b=UTvtTtlsEK0/rhxBDxKEbUIoM+M/M5nXYfVWRb1G4RjCVKGv0LyzYYBZKpORSEncNFM+9hF2YmLsjtw49H+G5n7zQ40rDGTUqXzoHkoS15TEnBldtNnCskD9gvH6Tqr7vHjOAOw42JNilvBA6U2+coKVfgf4+FeJ2CbMZMoj48HT3oCHorBnOtLiUThxLHvMN2M7l6YHHTDUI1anyNtP5vzSI2bqIpjOslizV7qTAWj8ExPMe2M1ISixv6l4kP3HRIdn2hQhMNff4u1M4IQGTLKAaPyS35PrOFUTNPC8g8/FcD2hOaEyiK0kHLlp0Oo2cRRZrE0DcIlbSnMdQMMJkw==
Received: from SA1PR02CA0013.namprd02.prod.outlook.com (2603:10b6:806:2cf::11)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:50:33 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::d3) by SA1PR02CA0013.outlook.office365.com
 (2603:10b6:806:2cf::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Wed,
 12 Mar 2025 11:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 11:50:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Mar
 2025 04:50:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 04:50:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 12
 Mar 2025 04:50:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5: HWS, use list_move() instead of del/add
Date: Wed, 12 Mar 2025 13:49:53 +0200
Message-ID: <1741780194-137519-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741780194-137519-1-git-send-email-tariqt@nvidia.com>
References: <1741780194-137519-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb06670-067d-4a4f-19ee-08dd615c1859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wEX4mzhQwwiLIYu2eoudbZu4PZiv02UYWbR7wLpouRR8ZxAYzJiHfWvI3twc?=
 =?us-ascii?Q?wuKgs+JRfNHqB7un8gR3cdIzsiklY0r3j/+FP04S2F4EduPj0IQTd6EHro+V?=
 =?us-ascii?Q?Ve7NvagVsZPRwBb+QWy5hZ+rFMZq+mcYbaw+xFBr3y1616zVlzoQ1d6g/Yrb?=
 =?us-ascii?Q?y8RRdVzjrFpcPKF3HUFWmrLLMxfEEmp7miJXTMS4bx7vSJuwG5odkeZ1TUUT?=
 =?us-ascii?Q?rPmfVNot/vVzcHHrseZRgwNhkOszTy8Y6oH1lTvdXHKGoVZcR8QO5TozJ8OX?=
 =?us-ascii?Q?LcSdbNS9DMcGV8N6+YKom41VAktkFyakl+HGeTuMkbEsn0mwKZeP6+hcTM+l?=
 =?us-ascii?Q?maSfKJ6ZIr9cPE13cKHRJOSd+zSUs0MjB+w2r9HLRErP0a9zl2TtmR/TNTAg?=
 =?us-ascii?Q?Dp4s0B0phWi9J15mDdUkxOhvZcNvlfK9uUrHX9LDls3+75pR241T/gucVSlT?=
 =?us-ascii?Q?Edlr7QkHczbp6erhFyJAR+VFRW1eBxE7mckQE2uRLuHiiHF6RslqBZTBk/oH?=
 =?us-ascii?Q?Okn4zqL8qtFEI1oD3NMT4Mr2JXl1zBsRJ53fBNEkstM6nQEemTyLcKhEszLR?=
 =?us-ascii?Q?5QSi1u2OjQIc8jszXXU+0IT4JvoKxm+yHMaH/oKI6aPfwDY7Gwjyi9KeURGT?=
 =?us-ascii?Q?hbUhEbLQendp89XVS+z8xhCV1KamxUwhbvuUertkxqhdQc0VH+uLoyL+26SY?=
 =?us-ascii?Q?lyDVKVR01SHyiX54QZGLKBNO7mGAHoVGCRAesgpQG63LhargY64PGdGkE63c?=
 =?us-ascii?Q?Pyyh/MRVYj9QUcXUj0bbYo+3iax/cdXFU4NhxAdcSqtRdlnbJOQYMAV21GkU?=
 =?us-ascii?Q?w1LvHIFpPJHQ06yxRXAsz5Y2aoR/loViTlpvXOoW/kEVyHxhEpeyAZw0NSuV?=
 =?us-ascii?Q?mMDRb+Y4ulH9Vs/xa520eShWgo7qO4ZwI2dQXKKLWibEGoYBYA0NfWVtK1rE?=
 =?us-ascii?Q?vubxExpXXjhts9aJEeKbuvXhPm4BakJ9rnyBUxSJvwBozkUXg1KBa4pXNuh2?=
 =?us-ascii?Q?G1wBg8rt6Mmoi5Rso2IKBSG6GTXkIgUs8iSeGd+sL7pOlSkxm0lIXz7W6+QE?=
 =?us-ascii?Q?qn0BFXjdrmAB1Gn2Za14u1EmbZk9KlbDT+n2PHcd14nig/jwkboq7Qmuem6C?=
 =?us-ascii?Q?OEqxwKueA1ql4kx/caygnB6YTHyOquE2zSMFcWwhD2nsq/FwjRdiCZUKag1e?=
 =?us-ascii?Q?QeY/DQgwK/9DQnfS0BSt7yQ+hnejQ/obTYWvFTh3rGQ7g7IM+U9EBLE8N+7G?=
 =?us-ascii?Q?KhRJIEDPzjlxLiwwCPUJ72u4In6l5fzEYbCk77SQxQlBJuzAZ44tP40k8oir?=
 =?us-ascii?Q?ajQpP4s0jrX3FFefZ2TE0H1BVZm13qFu3+qpAQ6i6aVCcyi7mbfdTGLSNaJC?=
 =?us-ascii?Q?hRdO6b42hbjm2nJ7LatcNHOYmrElTMsas7D9SlfWSZPBSH+Ask7bqCt59hqM?=
 =?us-ascii?Q?bG65/eXPOYbcii4wZi71IBeQpEDZdT5gNIcz+DJ9OV/58zyXR01HGPymSWMu?=
 =?us-ascii?Q?yDG7jeD2qI9p+jU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:50:32.8450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb06670-067d-4a4f-19ee-08dd615c1859
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Wherever applicable, use list_move function instead of list_del + list_add.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
index 10ece7df1cfa..c4851d5584b7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
@@ -1985,8 +1985,7 @@ int mlx5hws_definer_get_obj(struct mlx5hws_context *ctx,
 			continue;
 
 		/* Reuse definer and set LRU (move to be first in the list) */
-		list_del_init(&cached_definer->list_node);
-		list_add(&cached_definer->list_node, &cache->list_head);
+		list_move(&cached_definer->list_node, &cache->list_head);
 		cached_definer->refcount++;
 		return cached_definer->definer.obj_id;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
index d9dc4f2d0dc6..f51ed24526b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
@@ -153,8 +153,7 @@ mlx5hws_pat_get_existing_cached_pattern(struct mlx5hws_pattern_cache *cache,
 	cached_pattern = mlx5hws_pat_find_cached_pattern(cache, num_of_actions, actions);
 	if (cached_pattern) {
 		/* LRU: move it to be first in the list */
-		list_del_init(&cached_pattern->ptrn_list_node);
-		list_add(&cached_pattern->ptrn_list_node, &cache->ptrn_list);
+		list_move(&cached_pattern->ptrn_list_node, &cache->ptrn_list);
 		cached_pattern->refcount++;
 	}
 
-- 
2.31.1


