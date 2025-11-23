Return-Path: <linux-rdma+bounces-14698-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED5FC7DD62
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBAEC350E61
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FD82D8363;
	Sun, 23 Nov 2025 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HOtFb6/m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B02C0273;
	Sun, 23 Nov 2025 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882692; cv=fail; b=JS5HSwA1t4/98LDFX1FG/DcQ6WBupnQEkUcPGpqH8DcJbwBK30+d5TX07SlCJFE8wYE/QjSzO8COH+sFuUvvLZcq/Evsa54J3b4J7SzNwHQP+AMx/qFNY6EFTQvA7LTTTZnxoVeeyN+/xhqWFfSIhF4aRvr04n9w8p5rUPgyCx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882692; c=relaxed/simple;
	bh=eCQG3S/yOds8JQUOHWixmpPqBLMdmU/S/TtH7v9dU+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpYHTeNqngGQdywRQ69spxmYg7H6STjNVVuA/lWHCmD2dPjLB9JpOEoRQX2bOry3CYj9sZRNGo731sPljehxWzMoXJskrdCdIACOB6zZdDHm+IR2925e56/V2LRi0MxLzL/1oDNvEeFuSVAq+7hHbccqI+B23ah7GN3tWjYQWm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HOtFb6/m; arc=fail smtp.client-ip=52.101.43.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJE9RrlZPVLnLxHi0alk4tVLwAczBXfxMha6gOngayXURP4jZlURTXoRuM1KN4++zntVXc+emZE3C7F8mANbPOcrD9LeGKZXsuBN5p1lCKyY6M0fcKWWdxtVbC2KYLBgTF1c5Lq9e1QwYK8XS4nGRsywFmUHpTp/FMSMMsAzcivw2r/x42Owu65Hp4abHpKzUOD1BS7nNvbXxwp6HTkgXk95qd86qClvmS4xHvOjPAlXofV/+27UDYgs4OJFjpof8i1VmK0H63/mdqFN+a5Yt+/73Xh9sVgYK8+3to5UwplNEHFprCjwW3UxIbr7zm1/xfcj1m9/kZixqz9/SQ1UAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pAm2wQVgo0BwkiOeplsjOGdgWjn/yXUgEfaNOjFTP0=;
 b=g0H0yltoBc35ke2Q1zAadmtzqzp/Q0gP/+2tpz0dmnifJobjdO15vUc3PM90CXY6DpppfOACMQqht5UtEnkl173iGrUbNV6TRSzSjPZBZ9Lk5m14ld7OCTyGAYr3u0jShoJ+9oJfVvYciIu25HcTP09BIIHrFRrchgR5WFA7ojGcvUb1sJdBMRga1B11BPWJPUub580x6z0HGx99bPa+HXLDc7PxERYdGi2AsUCQxQ3gZSoEY2ir6gd2FEBzmLRrTpOCziI6YcAenINuyyGkh6b8w+rZnUFI+ir34f0KFpfcKjaRh36mtjn9dTC8+K5gWPgCgSLK5Ybrsn9rLNN4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pAm2wQVgo0BwkiOeplsjOGdgWjn/yXUgEfaNOjFTP0=;
 b=HOtFb6/mWe/SZz81xG4nRF+VGSmw4JaaMtpHyjuzuEa82zKLKUctV63ClMvqyxHOo4r/mz3a78GzlyI5VmyB1xrWevLwH+EyC5KCQSL6EGsaGU8uftCeTBpop0O7MDG/OM4iFiqTZqwb8jKXTCZJMRxjauI3hLxFWn/l3Z0G2n37h3n0i+PJPEpOnIuun5mFybJVRWj1H3hNDGPBLZM3CuXkDJQJrqOPULlpAgRbL5UksatVg6j4WISiEM9+bCdLKfLTqnRld+gu9veI4m9idsqafuaCyFSCNeurNfwNb9Pr9ZgWnbdniv9ki34s2BTTwSplIuvdfJ6aNw1UGs+g1A==
Received: from SN6PR08CA0034.namprd08.prod.outlook.com (2603:10b6:805:66::47)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Sun, 23 Nov
 2025 07:24:41 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:805:66:cafe::69) by SN6PR08CA0034.outlook.office365.com
 (2603:10b6:805:66::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.14 via Frontend Transport; Sun,
 23 Nov 2025 07:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:24:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:32 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:24:26 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V2 13/14] net/mlx5: qos: Enable cross-device scheduling
Date: Sun, 23 Nov 2025 09:22:59 +0200
Message-ID: <1763882580-1295213-14-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
References: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8a2432-fd67-422b-950a-08de2a615dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4d+aZZeb1DAyK7GeIbXxrmt0cR12662kDMEcQOwcF+c1DjYhPPaOwTtSe0f4?=
 =?us-ascii?Q?JKgb1/HJGmVikyRNr3Z2WlcG4umiLid/L0Hs7bLm4RUA2OqqEvLSP8TNe8T1?=
 =?us-ascii?Q?GX4mrZ8WNNBmGO25/w75LmlVHcT8E5TViWL95VUA3nGi1BpxYN7kp5R5uOem?=
 =?us-ascii?Q?7OGeq9ss80XlN5tvMVmN5wjEPYd3rQxfKHVQjEUxDB2BsTF5HBQGni9qSsKS?=
 =?us-ascii?Q?sjN637uXUNt6fthUUmh5PdPKP3fwZuZiQjJbQnBd0cxDEfW/xOYCSXEthZdZ?=
 =?us-ascii?Q?DZhtuFvOUw2xbXDzBH2Ye04GFdCMJbb6g6RyjDabiI2+lcj0eYCdlkhqb4Qk?=
 =?us-ascii?Q?2feIasYkZKe49V16VOdtvy6Ygue386p4qeXGwvF8XpC0x8N0zw8dC8Rvwidw?=
 =?us-ascii?Q?/l98mSzmQZdRnshHErGPcvKR/hTJcGUnYgxgCJahkLMTe6BYbmtgPpCPiyW1?=
 =?us-ascii?Q?ijSaHZSPEMaSkUVeGlYPlCfMCh+u6Trav0UirRTf6nl7Xe2LNWmc09zfbEwl?=
 =?us-ascii?Q?zdnNommyBPwL372nhPDS8vPZjyUjcxG4r+y43n+rnIFKN9OSlgJd2US6AaE4?=
 =?us-ascii?Q?wF3NGbaDNeNA9ClwhoZLSvlmKYShORBCbsB7/l+EeCqVhQ3b+IoOBWCz4G1k?=
 =?us-ascii?Q?YbSxCceXMsP3KkRHHVtJc2H7Cs2PVe/uaDN6Vo58zlXk43VFmRTW4Ht4bmLL?=
 =?us-ascii?Q?VzYPW6qxFHfOq4RoyNRvxREMswqBUz+WeePrgK64zzmTz86UuN51iNRF9Wyo?=
 =?us-ascii?Q?pZyaUncwfyquSVvZ/RCSStMWywAKke2lwJT1Wt8PI0DAVCQAYFHxWTlPqKCz?=
 =?us-ascii?Q?WnnutG11npCtvGdL56LZGc3zibAl+u+w2T2vwl1/nm8gwwEIWF/edBE0FxKR?=
 =?us-ascii?Q?bWK/H+jsmQ6wsYb9d8DSoZCu7EshT5+L26QM7SwQ5Sd5rdWm21QY4wXepaBr?=
 =?us-ascii?Q?DrHY1M35KVFQ3ssWZMW+fDPLZRwbEzwB9eVlj66yMDu4a//tn181FlCE4xdT?=
 =?us-ascii?Q?+4d6jLyRer7cE07eUleBO5wmSg7azpO0Q55zUHj70I8dvFfC+K07/ih5JmuU?=
 =?us-ascii?Q?Hs1cRcLOrrnrDYmnxdNFIFnethQf8kq63l/JIBWga1K+63KIHoeaOzpT7b7o?=
 =?us-ascii?Q?8NAWfk0mBgXi9HnQvRdg0StsOKvrUC7U2wZ/6/ujOPNA9bBdQBwlF3NM69iQ?=
 =?us-ascii?Q?x8gx5W5f/cEG6gx4ysySd+4I1FcqRHtpVFRPRn3JC5Y8SSr5srIPL/xPiEN8?=
 =?us-ascii?Q?IOTVtV5RWTTbEbTDzk7UN8QgTIn9WaN3+L5p2Vi338DWBu6ekS4fcsCObTOW?=
 =?us-ascii?Q?vTlm6Q35rH6f8EMGMSDuJ5G0ycAZTy0gjxUstic9E0mIaQceCjkRVBuniGVE?=
 =?us-ascii?Q?7ZERq0G1Yv5yy/g/zEamjRl5UqX50aRX1CUIHTTdJ6jGKga4yUDxtN/PXv7Q?=
 =?us-ascii?Q?X6TP4SGG6tNSWuA8n9fkN0XwowaeDeJ4aIjqPQXoIagEO2LnyUdZZ5oYFWKa?=
 =?us-ascii?Q?lFRLazQq4sBgotJsuzCMJB6M5Vz9gaW281C4vLA3MajtlPnalv5p+jHkM46A?=
 =?us-ascii?Q?uNFimKewg1N1mdEI174=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:24:40.8470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8a2432-fd67-422b-950a-08de2a615dfe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109

From: Cosmin Ratiu <cratiu@nvidia.com>

Enable the new devlink feature.
All rate nodes will be stored in the shared device, when available.
The shared instance lock will additionally be acquired by all rate
manipulation code to protect against concurrent execution across
different functions of the same physical device.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 887adf4807d1..343fb3c52fce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -380,6 +380,7 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.rate_node_del = mlx5_esw_devlink_rate_node_del,
 	.rate_leaf_parent_set = mlx5_esw_devlink_rate_leaf_parent_set,
 	.rate_node_parent_set = mlx5_esw_devlink_rate_node_parent_set,
+	.supported_cross_device_rate_nodes = true,
 #endif
 #ifdef CONFIG_MLX5_SF_MANAGER
 	.port_new = mlx5_devlink_sf_port_new,
-- 
2.31.1


