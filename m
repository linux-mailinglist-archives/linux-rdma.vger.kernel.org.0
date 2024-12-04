Return-Path: <linux-rdma+bounces-6248-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3734A9E479F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 23:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F6218814E4
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671301A3034;
	Wed,  4 Dec 2024 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T9luIHPq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E714F9F7;
	Wed,  4 Dec 2024 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350319; cv=fail; b=SrtuipNhLqIkQux3o3Rr/auEtp5nJ4j+h4T2BJ6uzj0Fh14WpiDt5IsaxofVdPw0eS84arBi99mGkAJ5SIcuFOXVxC6AtsVU1uQhI88ognQAT0BzokkQlJ7wrVPjK6HzNZcjKwrzUdBTdkdmatLMPELLXBPWbz5Zkc7ftpX6DbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350319; c=relaxed/simple;
	bh=p+f0Rc2cXt21kTHLqooaSn39K7o1wGJSQMQlC7VmNFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOm6SedTJ4iK606a3ywrTEZ+Q3bUZMctXX87cg0NTteBPd8sI+4BQ+GYKKrf8sN/3hN1/jWXt0cCKKRKlaGXxV8W9n3XNzzuRm+hiqnXBcz5mRVWULn45d9HnsdOCO0dzKYhsfu9kehnmZe/qJHNVn5x0sx0C4AQVw7LF9bqvYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T9luIHPq; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=je1GBzbdmCllUaYxGqc3PKiDK0KWetGly0hPzNL57xUki18FZXLpyzIQRMpAhSrSBMZMSY+2TtRG6EmzGWKEN46NTUbdq0SOe79vKEVQfTHF0+2m8fYd9ZCCaBWWk7s07Ci7YdqtZvq4lGhVEpx4qmElOA5DeiinOfDYAdLWghklIilYQ6IGlVrbbgLNRkCWztcahpFHPzKCcSZRvBRRolD4HXjRWTBW3aDRuyEBDPNGVNmeMaEPDa36wWSuqYuRYkCaywmFn9JpcSO695Ade1rR5WCVnlvBabfYqfR/Ty2s0eZwR9sbN8z/QfMLzD1kTS3wtnu6+/GKXs7qyRD4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7HaYmOaPnhb5t6S6+OAIrA4j5fQBco6gkGceNj+Ws4=;
 b=UQNr6ZgeWH+o4g3njikTWSiOWwRznvUbwQWRdfnnOe9asnGBErHAwwrJgR6f6vI1vwAn6pwhvN9l5u5U8CU8bL0BhDw4Wl77biu06SQFH7IFsTm3x3YFeAQFsxh3X0MI5ITNyu3BqNaPtSeTNms8lXyhqvX42lkamuuMWZ9X9aSHAXkGNlDl3UWD0+FtmmsnZY8AR6dNcMJCksW/G3c6kYUZTVnh5AyEYLVfn7mRR9QZm0qFNEQ3Fzi1i/7+VB00285Em1kj1C0PF/ommiqBZEB6R5V+/c7eEU+U/VbwU8KvaUXJo9oJEimHRynghZVRP1nUacuCfLf30kxYTUDnTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7HaYmOaPnhb5t6S6+OAIrA4j5fQBco6gkGceNj+Ws4=;
 b=T9luIHPqQfoVwnGz4CV4GEohfVxLJ7Ta7wpeZuiJs8FghBaGKos26r/9yVgpKYMNeob8msUBtSRckChwSf2rB9o2a1c5DqA7FoIMahcj2MoW+uCzz1jIG6IA5wgafTXzzTuveLnRBhPOmIk/h2gN7RTGHTQDv4AR89n8xpCTJlx2EM6b2hW6f8CrsBmgQ2qpgJ0ZB6g9ERd5AUDtZWJY7JS0FZ6eVN7L8dNjHAaGNfaLgCiskfvH4P08g4XK78XDDX8e+lWAXU1YI36nXpkgcID5hyUdQnglKcyGd4XwMCwvxKcuBaG0trpVrGRl2wvuBxBPcUUBg01vfxrcoJZ0Bw==
Received: from BN8PR15CA0029.namprd15.prod.outlook.com (2603:10b6:408:c0::42)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 22:11:53 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::bf) by BN8PR15CA0029.outlook.office365.com
 (2603:10b6:408:c0::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Wed,
 4 Dec 2024 22:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 22:11:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:36 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:35 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 4 Dec
 2024 14:11:32 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V5 08/11] net/mlx5: Add no-op implementation for setting tc-bw on rate objects
Date: Thu, 5 Dec 2024 00:09:28 +0200
Message-ID: <20241204220931.254964-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241204220931.254964-1-tariqt@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b49ecc-6f5d-4943-72df-08dd14b0a8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w/VGc/QJIhTe91N/RzgEc0f6YcdSComDXhyXx5qBp6x0vsGg+3G+KhrRDIg/?=
 =?us-ascii?Q?xit+Alri5MZOAoiPcZ2Y8NGFsT8aPHRofEJ3ZBybSudbbXh8p9Ocsb4CKQOJ?=
 =?us-ascii?Q?bNqgjSzIck/F8Wq7CihKSjTtBBbJJnVRW1ViHNZSsrapIqhNC9gKDq4UF9jv?=
 =?us-ascii?Q?GKYVqD9ui3sezZnIKXagYfNJj5812s4jkFMT0WKDQ3HOqGgl18Ra72nyNaM9?=
 =?us-ascii?Q?Q5jeBsptYzrrR0m8ezQisCoBOkMTWVePu6IFwbmQxSi4rdAzfjQpGUh3jNoX?=
 =?us-ascii?Q?bgQrlcJ8rGOye4t4RWUUPY4wJEUaPuTUbq8CsZ2iEB0mkPTxI1V+bSyRIW5z?=
 =?us-ascii?Q?eMx5PtUm28QSIgcuAzz/WJJlanD/QW/NS17vq33Hque9jG7PPeOCyAOxWADL?=
 =?us-ascii?Q?jQmSX26F/8O6d5ee7wwcU3/GAI6IdNnRYkHoapkGBFY+A+kbTJIa7VGme84P?=
 =?us-ascii?Q?JnWP30RT5ZEigpSoG/J7CCT+bBkNSl67UYL7uq1N0Ss2CaLTlh5DL2FJ6Qle?=
 =?us-ascii?Q?4kn3U7DqKZXQ+dPyWCqxIP3yCMJhoU3wwE4S06t3NqcdBtkSpf9QZpyDPnWT?=
 =?us-ascii?Q?NJWgN4jU9xs660AL4MQop5NuFej07DV4WLz5VRuMJLyUeq5i+pf71SxOVFMy?=
 =?us-ascii?Q?qAuv6+7al57oVHLehDWxM2JSQxfed/tfNt2oF/CuN3IRByGENT3oBWnFlDsg?=
 =?us-ascii?Q?wp4yOjTh0ziWLTj6FeYaoXf3AQJULiSxKc8ShtjPvuq8fGYqxHLzXq2pJA8g?=
 =?us-ascii?Q?Mfq35X5/+oJZgjT18SIdxdG/kxJDWWFk6/EhZCHyw8s17snr8h4TRq9ME83R?=
 =?us-ascii?Q?7b3NKfiCObiz01tbNEJSTgX4N1fqY6YDrRkA8SnltCgCncq1UjLIg/JT+ct7?=
 =?us-ascii?Q?ND5bo9kyo5699zuhmVg79K2sAbBZ7p7CrGaCsG351UbvyXADWLK+MLDWt32W?=
 =?us-ascii?Q?50EHFDpvilkToRwYSTh5u5myCVKCYZbeOe6qkEaUAcL26NLNlqDclaqrX+IF?=
 =?us-ascii?Q?bWWuicG+rd0uKCDb7oSEq8CCkRlTtlnq2XVn+0IM+KVgLyUfejS1XKYvBxAo?=
 =?us-ascii?Q?6Kk+tfCmohgOqc+li+TB/TWpd1fB6Y7VsTes9dM2N07t3WtZaXEcuOraTV2I?=
 =?us-ascii?Q?GputGurCjdX69LHIRaINRb5Bc0oPkWqPRFg1MH72F8Kjjs+FgzSX5wdIs3RN?=
 =?us-ascii?Q?JoPgWn5zb5icR1ytWpxWrfdzOYLS9qnZ3uUhVPMTjsTb0feIqUyamHFyEe/M?=
 =?us-ascii?Q?L/sgjiOvDdpu5jOnZ+pq83y+DfaP3BjfXB+ZlL/uMj8Nf6bNj9fURSt9velA?=
 =?us-ascii?Q?VAeynsOxA8dG9rEs5RiQ/H6r6SDrj3AWA/aXMCiBiixSfKYSZqjNc1mR0kgT?=
 =?us-ascii?Q?B4OhFsLmt1qDMUMgppppEbQ1LZ1csC6Dj/m/rqGu3elrkVMdECNEveiLXZ1D?=
 =?us-ascii?Q?eS5wwVQKCJw9RBxDBZnW5tAunhtiqP0Q?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 22:11:53.1513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b49ecc-6f5d-4943-72df-08dd14b0a8b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485

From: Carolina Jubran <cjubran@nvidia.com>

Introduce `mlx5_esw_devlink_rate_node_tc_bw_set()` and
`mlx5_esw_devlink_rate_leaf_tc_bw_set()` with no-op logic.

Future patches will add support for setting traffic class bandwidth
on rate objects.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 98d4306929f3..728d5c06d612 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -320,6 +320,8 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.eswitch_encap_mode_get = mlx5_devlink_eswitch_encap_mode_get,
 	.rate_leaf_tx_share_set = mlx5_esw_devlink_rate_leaf_tx_share_set,
 	.rate_leaf_tx_max_set = mlx5_esw_devlink_rate_leaf_tx_max_set,
+	.rate_leaf_tc_bw_set = mlx5_esw_devlink_rate_leaf_tc_bw_set,
+	.rate_node_tc_bw_set = mlx5_esw_devlink_rate_node_tc_bw_set,
 	.rate_node_tx_share_set = mlx5_esw_devlink_rate_node_tx_share_set,
 	.rate_node_tx_max_set = mlx5_esw_devlink_rate_node_tx_max_set,
 	.rate_node_new = mlx5_esw_devlink_rate_node_new,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8b7c843446e1..db112a87b7ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -882,6 +882,20 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 	return err;
 }
 
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on leafs");
+	return -EOPNOTSUPP;
+}
+
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on nodes");
+	return -EOPNOTSUPP;
+}
+
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 6eb8f6a648c8..0239f10f95e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -21,6 +21,10 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *priv,
 					  u64 tx_max, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
-- 
2.44.0


