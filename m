Return-Path: <linux-rdma+bounces-11884-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B62EAF80F6
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 21:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3262188DE9B
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF5E2FE37E;
	Thu,  3 Jul 2025 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oM3Oouin"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF3298990;
	Thu,  3 Jul 2025 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569001; cv=fail; b=JRMul8KBYi2fXUC00fKwSmfaOKt62bztS7yqxtG0fbeiCF0W8ul3kCZh2US6wZCrP3OLe1JcA45b/Nzc0i1j+oYq10NwWdiKN4xJur7EqQn5lcCZKWfnhUXBznfNXaegGKGN/cUOPNw/vLAf0p3a6hkTREutujCDwicK+aD5Xyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569001; c=relaxed/simple;
	bh=964UyC549PnWiz4jeY9q3eKtgnZLPbBIzGGbOrSZXgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4B6g6UpWR3xbxHavatmY33k/oB9MwwlZEFw3aJVrTEmYHAEa7PiJpOLQ0XoxYxAmBmEyTl0AzHaBtRd25zoSeMc/13qA9u6DVZOwvP3fAFdJR8mjS6UyWEMwH1xpKPp+n9b+DefIaiy9tVwvLhq7k6de5XKueA2cWkMnYZWEG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oM3Oouin; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAEIrDt/Mwu4ZoDiaJkO9NyotGw0gOyfA/ueZzneJlj7k4G5xXE1+zvzK59vUtFWlV5hcuUFKEBB1qBVZtmiwSUJ0RDqn4cBkMMVQMqmwj6xjDkMQKdMCKXIti89s6DSg6UIT/C4K03fPstYZzEXZWqmQ8Gbbuohgz019LY4+Nm3sM6Sg+a3vndaUeqDo/LuTENgxYYwVYYFjISxddHpazhgoFfBEIfCRrB+rZfVaxYQabX9nBucgDdHdxN/Mq3BzuCo0Svhb+MiP+9Q7nkGzrVJoRyIFBG6RZi2WYF4ip/by2hQeiuGgoG0/Itr063rGOJRyJ7HqgvLkKCEU/722A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dArjK9/F1SDkjODhcyZRnZHpcAWwDSur7M/knRq4SnM=;
 b=J8dWgeDYcm8bMRKBtzT4zUsgDv3N7m9mnu3zhA+qsHscLanDd6V7mYmZHYfg7QPx3Vobk387SrLw3BrMO9jgPOqWaqiNZXhgPSeLstTFvdGYMhNWwi/aymMiGkXgkTGB897bS6OfCg+5SqQROZeyZvFoXikhFqgDvxCsbiEES9WgnI2noGKNbomAnixNDHK1mV/v7fmrLpwdHJGjpH5UgS/IC0hl71qG/mUyVx6FaCJMPVH+xTfohMGnCD5KUqJlVtLCO6ozWED4x7Qd5YKVTlzyfCGSWclSR38SjC3GZJsuqEiCsQRfyHhYqHBmViZYTnylgGhjMrxJ0ZNvJg4IFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dArjK9/F1SDkjODhcyZRnZHpcAWwDSur7M/knRq4SnM=;
 b=oM3OouinNHDbjHb6jgK6+VeCbAdRvimbHSziRWpVAzH+O6GKbzg+VTwn6fihUgmxh4s9JB1Ba7mInUJTCCs5wm/iP2rbd+m21aCarz5yv+RLSFBV1+r0FYq800acrb9EiaqAZHT9OVL1ZmsO2V2ZMqGxb/DbTg1VRLKqjZ8tah3x8uv55wUrOTJOFJBbrg7DMXSdjYG29Yl83x+Lra5dIHeomxXVFSXo7uEIjAOAhhKc84bIvNO8Lv6UNQwTC1hRC7Icwg6PHAcjj88/4Tvo6jDNQlSe8AGPkFs2ZdTlAUNLu8LlBQxWlc0FUQExgLYEckZLQo8R3p4vTjRiUGEFGg==
Received: from BN7PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:20::38)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 18:56:36 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:20:cafe::79) by BN7PR02CA0025.outlook.office365.com
 (2603:10b6:408:20::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Thu,
 3 Jul 2025 18:56:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 18:56:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Jul 2025
 11:56:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 11:56:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 3 Jul
 2025 11:56:14 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vlad Dogaru <vdogaru@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 04/10] net/mlx5: HWS, Refactor rule skip logic
Date: Thu, 3 Jul 2025 21:54:25 +0300
Message-ID: <20250703185431.445571-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703185431.445571-1-mbloch@nvidia.com>
References: <20250703185431.445571-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 52287daa-3e52-45a4-99c0-08ddba635586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0j95zKozmm4x9ND7/lfbuugIsAV9Gh+Yv04v2rdrWRYw0YbEGFJfM2mmvrrf?=
 =?us-ascii?Q?S+QlPH69Pc2ZpdOc8WGW88UmK4iD0iy8nsFFRciq/Mu1m1KkX+pE5YmtY0KL?=
 =?us-ascii?Q?DuasAghfm6Y/ktX+QLuaCAA5RNtAHY8/3Tfr7mFLH4OgB9UZlyiholq/d8wS?=
 =?us-ascii?Q?m5fNnANDNfz1xDWdT7Q/BWlx5nEfujGcVy/54bc6mDUkON+fZDrTq/bgFcW+?=
 =?us-ascii?Q?F1atX/IzdBBN7zD1ddFxjFnpFQ+Ckj5Imt8ygVaikhq306u9NftmsA2SVLBh?=
 =?us-ascii?Q?GHT6RFhKbxEJ76HwcQkn/aI+20xNfh6FuiNVmPChfkLaiKmptMoZ+IMK5mZV?=
 =?us-ascii?Q?UsB2iX6Fbf/UJ+Is+mmqOZLLPRfWABGK1zqDF4e1zwJsLMKMOIDrcB1FZviG?=
 =?us-ascii?Q?RgHT9gP8/SU8hHA2j7qCborbzkK9wmKtx8lkABzrB6EXSh9WMZVKg1swa/Yn?=
 =?us-ascii?Q?sFYSq71B5nENOWtkyWxPFyZt1AQFzkUApQL0b00dBgsiBxL1vk3b9YrwzQpV?=
 =?us-ascii?Q?IvsQEYK+t9+t9+TRMizUe9xZb4UtiCcRN3ynQdH6ve/ZofeD0QDkhM710ku5?=
 =?us-ascii?Q?8+GmLkAHrqFmymaIL9aMO8QjccRC3Pb/9mdV9njjskW8qs4Q6wytKNMtX/TE?=
 =?us-ascii?Q?hnZ3j1oFRyAVtFsp05YR0biVmM50Oa0lNdxaN8qH7F1tGu9jKBC0+28ommjO?=
 =?us-ascii?Q?56wIt2bUkIHTfX4SWDlvRFLu1s8tJA2LMFYzxaoEhyf+i1Gds98GZhSyt5Tx?=
 =?us-ascii?Q?uyma5+g905bLD+Rs9UVGt4eBI5MCkEbNg0Xxi/A7Ef6qjMLqDixBcNmTgkZO?=
 =?us-ascii?Q?A3M+DhSeUo6soxjz9SQFxRur3XEf12zqD2vT6dXiB0bxwnzisz0BDzyjL5zM?=
 =?us-ascii?Q?vRA0I074EYMglGVJn7HMMww4YAtvc+yWLJjZptTDYzpn55A1mnv6mBq/OVEE?=
 =?us-ascii?Q?9UeKwbQInjT0tfw0XOn1QzcUWH6s+RlZ+gEfKNV/jAX1kN0riULo+NUHMPRV?=
 =?us-ascii?Q?ly/xwuRpj5fwYLaoR9PO6yjYcXTk8ptxKqyk9B7lqxsKfpclmxcAuBKU/kcK?=
 =?us-ascii?Q?BALKlui8BaNhi/H/Yk1NpiLAoZHJnRAnBmAnL3Y0Um7ZmHSer4uyv8BDv2H5?=
 =?us-ascii?Q?V1aXxa59LMToCCHy2M/7UHTk41OvzLb4wF55pWlIoRyOmUJFRQ8t1+X9trEG?=
 =?us-ascii?Q?4EuACgVZbQ4ip71gLLxAOWyXc8ny4u2rPBKJ9oL75qfxOz4YMOz68sFmnkad?=
 =?us-ascii?Q?pnRfXRJGR0wE57M0gn7KDqNH8yY/TVKw5q4isqEvf91b4nT+R2wW8oscMtGR?=
 =?us-ascii?Q?rtlA7UsAJcPEor2xsT6Y+OQpJL6EzAXnZjnwQcuAtD2sPrdafEiOWr6YsgVE?=
 =?us-ascii?Q?SUHXo+mlkismS+ODZzVKhcyGiU+O1/leivFEHytX1IZnckyhSw3SCmvZoM0m?=
 =?us-ascii?Q?3dEOjnIavg87v7CGUjtAFXP5Arfre7JMW3ttlRbrZd0Bf3kahfoIWruAqfGS?=
 =?us-ascii?Q?3Xd+JPyPlhDqnie2AiGyOgCCCH7lDPmBXwU3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 18:56:35.4076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52287daa-3e52-45a4-99c0-08ddba635586
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

From: Vlad Dogaru <vdogaru@nvidia.com>

Reduce nesting by adding a couple of early return statements.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/rule.c    | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
index 4883e4e1d251..a94f094e72ba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
@@ -12,20 +12,21 @@ void mlx5hws_rule_skip(struct mlx5hws_matcher *matcher, u32 flow_source,
 
 	if (flow_source == MLX5_FLOW_CONTEXT_FLOW_SOURCE_LOCAL_VPORT) {
 		*skip_rx = true;
-	} else if (flow_source == MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK) {
+		return;
+	}
+
+	if (flow_source == MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK) {
 		*skip_tx = true;
-	} else {
-		/* If no flow source was set for current rule,
-		 * check for flow source in matcher attributes.
-		 */
-		if (matcher->attr.optimize_flow_src) {
-			*skip_tx =
-				matcher->attr.optimize_flow_src == MLX5HWS_MATCHER_FLOW_SRC_WIRE;
-			*skip_rx =
-				matcher->attr.optimize_flow_src == MLX5HWS_MATCHER_FLOW_SRC_VPORT;
-			return;
-		}
+		return;
 	}
+
+	/* If no flow source was set for current rule,
+	 * check for flow source in matcher attributes.
+	 */
+	*skip_tx = matcher->attr.optimize_flow_src ==
+			MLX5HWS_MATCHER_FLOW_SRC_WIRE;
+	*skip_rx = matcher->attr.optimize_flow_src ==
+			MLX5HWS_MATCHER_FLOW_SRC_VPORT;
 }
 
 static void
-- 
2.34.1


