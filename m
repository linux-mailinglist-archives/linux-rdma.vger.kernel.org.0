Return-Path: <linux-rdma+bounces-13561-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB40CB8FB12
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 11:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFCB2A189B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894DD2FF66B;
	Mon, 22 Sep 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LQJGa6I/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260427B34A;
	Mon, 22 Sep 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531752; cv=fail; b=Y03zCVwRILntryLxYyTD+IzUl6Q0YWfsn9gjoRB0SRoZS0kY8FsfxQDzHeMKM7qOZtJBZN77rLtGwtClqSBSvzpPD/onDjXELhR0fbOKpulKUW3WwHaqNfEx5XqfT9BTXS5ATiSvCjlEf3tlySQ2siq3PU/SgYlOqoI6ksj9QRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531752; c=relaxed/simple;
	bh=eyNOEWOYNaZruvf9oTqBbiwKqujNRhemsNG6iueXap8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OV6XGaC0uPEdHnd4NtCeo5SXaDmgVqU//F/cfQXy3EvD886WGgO1WWtJ1a9OsFzAt+MKV8sY96q/aINccRi0OtwwB5+xiB4ikN3744Cw6t3pDzqA6ie5P3mFPCK5/fQeXiC8yYu1OvPFqY9m1VDjTDIvpurJi0WPK31QGhRAQ6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LQJGa6I/; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuANq9hFoBq+2AhtSy+Ju3h3PuO485PJ5ytx83qH3VD8UIEQ7jVTq0wypQ8IaHyaG4HSZqnEXYRfDmO3owrggOgsbVr9eed2AbEZ7Lv5Aop+dcF6AwKcY5Zg3tTAhZWT9FpFvidmLP4GIbMu+HeUER70ZmwI6Jnbu5rcNPDpZEmCPujTt5QiAPIevzpC99y+K4ZhZE8CzspczGKyprr8i0sOQ1c6sJmfr3nmkqibbN7D7hu5MUDmJS+gp6rIUtUuMlR9H5Q6vs+J7P2BV7x9SH9xP+6HmTdaRJW0hUj/ecXOPOpQUxI90eIOv9Dq8zPEnjMGuoHwKOWvCOm8Yby0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiiLITT7pnqFYHkvtAW0hcETkAYivUpZyQmuCKGdCgQ=;
 b=kENWAounzGKBpJ5xLLaIwizEtRsz492l2xafHBTJ8ODw1VJjV/YZfvVxExKPNIBZaKAJgEuTMRrtV36neYhWiiQv2NACBAlfb/6ITfocgvKkE6+AiWaPkmd8HArob9xSSDT8RMbDeoy/kJa9kFrA7fnNdtz+vedUIFoEKDNf6xazWH+sj2b6NV2hclsuOM3U1vY3sv6WVVHcGIaEFvpbBeL+USLtFpV55t0tCevBCW6GxdJjGfB1LWmiUZaSwKAUbI5FIOHPznNMdjYhZrrljjsD5Qf5sKdKLFXhgzFOmdt9aWKOpyPy+FynqY56C8ZQx/Mn6mqml8yM1gjB3JWN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiiLITT7pnqFYHkvtAW0hcETkAYivUpZyQmuCKGdCgQ=;
 b=LQJGa6I/7usFI5tPEP9lLeddwRqL6m2zwil83ulHM1VRE+h7ByIsDZDOVm1GXHAkUvPMSsJs4r8LOS6DFmMfiBTWgjy3aWIvrOFnUL/S9+jX3kkf2X/Rk3ydMi3eC72IJhggFTGuiM0XQVL10AFJAdS5CmWnCvlf0ZmRL7Y5bdeSXZewTG3uszGGR7GyPareEy3mcLcjzdtO+EovqfYT1RVuoF8vQddjqT41aJtSYeAhoDedcMXSsXeJZDBSxQPyD+Jo1BwJYKqUjhN2+zWwNjz3VZY/sYMN/U5+WJ8IQ+1rtoUStd/h9z+ivTTeQEfhq5bfzBqjU6n3hH1J3I9bAQ==
Received: from BN9PR03CA0133.namprd03.prod.outlook.com (2603:10b6:408:fe::18)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 09:02:25 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::59) by BN9PR03CA0133.outlook.office365.com
 (2603:10b6:408:fe::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 09:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 09:02:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 02:02:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 22 Sep 2025 02:02:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:02:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net-next 7/7] net/mlx5e: Use extack in set rxfh callback
Date: Mon, 22 Sep 2025 12:01:11 +0300
Message-ID: <1758531671-819655-8-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
References: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 0792bd8b-7a54-40df-d598-08ddf9b6bf5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RMZVpRAsQg/7r3X9KH7citZNlJ3sa+ZH9uFStp0GbZYeBhf8Kz1/OxjNVxe/?=
 =?us-ascii?Q?EiJMvkSv6CWKrBi65eJaPsMJo+84n7npkWof0Wt5ffNdk6b6Ha2fvHNfsmbz?=
 =?us-ascii?Q?n1DroU286NbbKzkym5ykgSlK0HErIgY+lTiPQaLcclHw0kIrcEF2hO4RkATx?=
 =?us-ascii?Q?avSVr6UgQhlE9slSVrf3w+mgciQw4SoVmDn1cngWGIkFbrMQMbVea+3+5WPp?=
 =?us-ascii?Q?IFyTgPEmHr92fX1yFEDhzny3pB73n0BTWPMf7GeS16J/p5kdpam+JF8d0yUu?=
 =?us-ascii?Q?ywioqi4Mk8/Pdbg++DoITeOUwHhNffYiYhkuqhuKnJIvgQWkWPwrYFvs2GjE?=
 =?us-ascii?Q?PaF56ZzYoOGmSUCS8t3fI0wtW8JALJfu8atsFneV+F05bDErgCULADgNdMaO?=
 =?us-ascii?Q?fiiPTND+x5iTXxby4Tm6oR4Sw7YdRRXXEPkddhnPTQAbUc/SjTJsLqa/Sn1E?=
 =?us-ascii?Q?LFv1ixK44n/uIzwkIyjhirF1nW8o0jzHQXTcb78hbhtiKAoRAbZnZP3U/G3k?=
 =?us-ascii?Q?fg466Z9tUVyt4ms0ZS+UsNDna0RAbYm2Xo0czTH1TnSzu0OYKKh1kblt0+S1?=
 =?us-ascii?Q?+B7lKMYyEM3T7YJMpNz2UyS+t8839MAKtVLukWHwqW67ybYgOeAcjkazPV6P?=
 =?us-ascii?Q?1CaRPsYaOuG1xovGx5CQsXOP4seOf7zawmYlya1FZcYVY9z37KJENlLF375O?=
 =?us-ascii?Q?ekPr3ncgug9dxB9tYqBNp5W0caxkkPgYqZelHn64mQdDt3L4UXmth8ZVb7DY?=
 =?us-ascii?Q?zPm96UEKaX/n8bbg7ideYh/eJj/zNhnxpnHL0QEq8MlDkZpGlHsXE8YrR8fG?=
 =?us-ascii?Q?LB+xPYD+PjgjbMNkC6R9CGGEoKkb1RszuljXW1WctSEDZUCenP5Sv1tDEhfb?=
 =?us-ascii?Q?TeeWJE5Gqy4R17frlFlIN1/XYl7SeP4dfeYjHT+oq05ihjmV7OC1qxv4Hz7u?=
 =?us-ascii?Q?GznrjTz8Rb+lLjmRjj+epmBT2uUeUns3f2TnLIVj2Y6hVvcC1J/tLV14FdtV?=
 =?us-ascii?Q?Uy3t+2xKHMvEnJ2Sd8NCx8W4CDlArFzIeHCD+WLIkXi5ElGD7f+LsegoBUjy?=
 =?us-ascii?Q?3TO2VYdCUn5oqDr8kcJV2bVGAURBkkL3i9c7rzbus6H5J1z3X+bF2hXgoyRZ?=
 =?us-ascii?Q?JIPlH2/NORV19fY6NPnGXqpZEvq7tB7DLkMGHpGoeLfkoQT1dSt5xFHPqK8K?=
 =?us-ascii?Q?8tLJokUnoL5X+5vg+HFJ1iOc45iY/CPUnZIjz0WRTf6YCXobj6zFFTX2YxKM?=
 =?us-ascii?Q?T41uWaiBiQ51v/mzcDpztVOnt2pcJW6KE4BXqz1C66GAHDukjaJvtEwJagEf?=
 =?us-ascii?Q?WneDWHkhoBRSHzglXqFr45zrQgCwqKNLXYz87X1mO2siHJpt7nl5N+N5XWbv?=
 =?us-ascii?Q?ELHpb3xree5H3ibtBP8wET5V8Pr1JPBXdUzSVwcC0J4LxiXTLgcbh0KEBFi7?=
 =?us-ascii?Q?mB7V4OqocbcJTSv4WEvVQiKacUS+brbxbjxNnEMYmz381c/DnwUWiJ2LVJLY?=
 =?us-ascii?Q?EHHq2XPPbsXrjG0g1Cp6L/5cj5L5XmjDuYe9?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:02:24.4746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0792bd8b-7a54-40df-d598-08ddf9b6bf5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

From: Gal Pressman <gal@nvidia.com>

The ->set_rxfh() callback now passes a valid extack instead of NULL
through netlink [1]. In case of an error, reflect it through extack instead
of a dmesg print.

[1]
commit c0ae03588bbb ("ethtool: rss: initial RSS_SET (indirection table handling)")

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c  | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index d507366d773e..eb25b19b4a4a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1494,7 +1494,8 @@ static int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *
 }
 
 static int mlx5e_rxfh_hfunc_check(struct mlx5e_priv *priv,
-				  const struct ethtool_rxfh_param *rxfh)
+				  const struct ethtool_rxfh_param *rxfh,
+				  struct netlink_ext_ack *extack)
 {
 	unsigned int count;
 
@@ -1504,8 +1505,10 @@ static int mlx5e_rxfh_hfunc_check(struct mlx5e_priv *priv,
 		unsigned int xor8_max_channels = mlx5e_rqt_max_num_channels_allowed_for_xor8();
 
 		if (count > xor8_max_channels) {
-			netdev_err(priv->netdev, "%s: Cannot set RSS hash function to XOR, current number of channels (%d) exceeds the maximum allowed for XOR8 RSS hfunc (%d)\n",
-				   __func__, count, xor8_max_channels);
+			NL_SET_ERR_MSG_FMT_MOD(
+				extack,
+				"Cannot set RSS hash function to XOR, current number of channels (%d) exceeds the maximum allowed for XOR8 RSS hfunc (%d)\n",
+				count, xor8_max_channels);
 			return -EINVAL;
 		}
 	}
@@ -1524,7 +1527,7 @@ static int mlx5e_set_rxfh(struct net_device *dev,
 
 	mutex_lock(&priv->state_lock);
 
-	err = mlx5e_rxfh_hfunc_check(priv, rxfh);
+	err = mlx5e_rxfh_hfunc_check(priv, rxfh, extack);
 	if (err)
 		goto unlock;
 
@@ -1550,7 +1553,7 @@ static int mlx5e_create_rxfh_context(struct net_device *dev,
 
 	mutex_lock(&priv->state_lock);
 
-	err = mlx5e_rxfh_hfunc_check(priv, rxfh);
+	err = mlx5e_rxfh_hfunc_check(priv, rxfh, extack);
 	if (err)
 		goto unlock;
 
@@ -1590,7 +1593,7 @@ static int mlx5e_modify_rxfh_context(struct net_device *dev,
 
 	mutex_lock(&priv->state_lock);
 
-	err = mlx5e_rxfh_hfunc_check(priv, rxfh);
+	err = mlx5e_rxfh_hfunc_check(priv, rxfh, extack);
 	if (err)
 		goto unlock;
 
-- 
2.31.1


