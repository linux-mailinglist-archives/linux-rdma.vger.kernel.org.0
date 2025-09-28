Return-Path: <linux-rdma+bounces-13718-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29C2BA78A3
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 23:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBDA17910D
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 21:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E245B2C2369;
	Sun, 28 Sep 2025 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UGz0E/c8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CB2C11E3;
	Sun, 28 Sep 2025 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759094780; cv=fail; b=WcAk9OVjjbCmBREz1F62NXd7SoIJGe8LLM2VjF5u2uY4jk1tWMSG03aKj1GkNTH9UKQ9SgHZG9npsBh/Vn8sZvfCvdYtMNUpCA+VLsVjYqU/4TStN0npEmHOBo/ddyhHLu7dNm6UfIPfAHdAC0jMJ9wThBv/tVwzHM2i9cFZowA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759094780; c=relaxed/simple;
	bh=lyzSE+5ShTnvx9eFRVjHX6V9YTGzKs2hNVmq/IPPKok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTIHou39P8e7nf3Vg36nSBeRjqPJZw7NnL8jZL7lTEnA+AQqt3NLSiAEfCmqGAaY4AcH8gKcoEW8uM976Tc4Byr1Af1eiw8y64EdFoOiuraN56SBR2TCfba4YnxXZ0T9v3cjvEEUND++Xa+/C5qm9TQ/0PVgbSp6wUMTtt95Ifg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UGz0E/c8; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ox13dh9baKVrGAqoTLHmt0P6FlAj+pWKkx4Ak3kuGX2WavLIpfuGZphMmC4Gdb4yzfsyl40cYTERYAXrpg+khcHd/KzEeB/VwWI22Zd4bBtM84pyCHx58xnGRnIVo2QH36/So5z0v+GvC3WRZcnubEFUH6NK6PXSuZO40LLlSdrYi4SimEskXuccFLH1IMaNbdKrpt7x9nrqT5Uq3ezdkmZ49s4DX0KcAyq5P5/tcuannDddyVfp0AwXKCLu/RgTB2Mo6EFxKB7YmweOUftYqmWlAOUBXFnDZiUxXolUFaXOZ2KJayqp3sAkdVcYy3/uBB73vd4lSJGmjVdiEKg2Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yEN6FYnKxNwuXK0X2JrMpR9gU+HMN+/NLGgffbcBBc=;
 b=m76v1FpH06vRRWpgURqyUs78m4TBXll7uEestPBmcQxsGOZIfQMNcN7S9cStRZyG+Jv+2y77Mj4vmGwaoYrWJqdTeOzN9fLm4bd/JzggVt8pgeLxWLfAmj2zLQYcH6sh/vsaoUtmR/zCv8BQ+QR58hmRtEZ5KVhh/QhrXfQe9pA0y+wfLDyz1wr13qnTyAsJvwIox1KY3N7cdYaqykXCIGFkvBuOQREbhLxAcMqPUSg+DgJh9KoR1dTg4S2xtDgR2e0FcAxu1i9sCZljAFtlTsZ6w89sytlkpKRN6Kj1sHyXUNCTou7tmOyqM1jh9/yat+TzePO9rOTPxX5iGbDYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yEN6FYnKxNwuXK0X2JrMpR9gU+HMN+/NLGgffbcBBc=;
 b=UGz0E/c8sfkKQzfByCa/u/j+w22wvZDyoJHUZidYozM30De6xKqR7rh1lTdeUrmbwDzXWmb31EOK6v33neNourWbk2Rr+gX9GwyN2R5+rSakJTTlh1/w+iXJrZPvumW86VTqu0FMi30c82LeGFsJzTJglmDk1h+kOFS6GVG14WPJEajE4hDqMymPWBBl8QUlkrGm4kmP3uzOD0NRTGt3ZhHZ620GD0/fWW3jpoogdLi1QxciZ5AcYVdPWdPB3tdOW5UVy3mPF72AZopmBGvuiEAsiOJM5UUy7i4zIzv9WYmLM8WLWpt1SBy6Anu2IX3RfyKyle7cdnizjYt8/+bqxQ==
Received: from PH5P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::7)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.15; Sun, 28 Sep 2025 21:26:14 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::de) by PH5P222CA0004.outlook.office365.com
 (2603:10b6:510:34b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Sun,
 28 Sep 2025 21:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 21:26:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 14:26:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 14:26:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 14:26:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net-next V2 7/7] net/mlx5e: Use extack in set rxfh callback
Date: Mon, 29 Sep 2025 00:25:23 +0300
Message-ID: <1759094723-843774-8-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1759094723-843774-1-git-send-email-tariqt@nvidia.com>
References: <1759094723-843774-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: e6568e8d-4a11-4b91-cfa4-08ddfed5a73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SJFRs+v6dEMuyMgeez54OyYFjjM/1mp3iaVqFYbsP0/pMtzcTc1oKBwVEs2z?=
 =?us-ascii?Q?BR+BqvTD5WsQdRUqTHvDALvgMt+ckIB4u8BE+mtK2yk3bY0SJbu6HFwB6z1D?=
 =?us-ascii?Q?DFLN7jh/YAf+1OKRMy2k6kni6FYcGtZrKasL0X6Zn8uYYav8evMww1OJR7zv?=
 =?us-ascii?Q?InmOfovpPOUz3SHc19Av+RL4ho7toq11h+QF1jn6arwgUB7ZppidSMP5bAeF?=
 =?us-ascii?Q?586LGuJI/ydsUKql/OVOotT+ze5wv++yovvg4z2GMp+b/cqv/+UfW7oZHO93?=
 =?us-ascii?Q?262Jb96ff2vNV2EV0QUaJCHicIa5U+23o1n/Lx3toaQIk88dJ5N/dS4yO6S9?=
 =?us-ascii?Q?KRDrBCI+mr2rrWLUQSnNkX8ySzC12a5jhtysx0NBUjOmvfr07t+hIiV+UQqK?=
 =?us-ascii?Q?l1GS6ckPBbt2gKdjM313tc2q/NoGvnNyD+nOt8RD8/7eNLm+ZShArlrH+Fxn?=
 =?us-ascii?Q?EAEWvs7NDO0nXChCToCqEoebU4WM12hrTZzHWnMM0XJMg0RF0vZ74fhkrKPf?=
 =?us-ascii?Q?7zSE20dHoXtA2OxGSbVV/L7hjLdQxbbvRaYScLolIGfjSTkgpm1GVSLUesnl?=
 =?us-ascii?Q?nuQADPSx/Hi3TyetUrQmmDmjQXz1xL/dPNRbXbyX2kN3ujsb9wxCTNQIyRO/?=
 =?us-ascii?Q?tjS90nn7MA/0I3dGSJDgKrX4IAv0TJmh+41xHfxPuekXSBz/rZXCvU4zib5g?=
 =?us-ascii?Q?fw03RzDopqKx2hq80i8uMm+4XJ+dJogd71sdSfd3S0SrHAWdMZPbOp1xNKvc?=
 =?us-ascii?Q?s9iew9GNvU3TDnJ9ls6/S2TXuhNWNBMdAY1gwjEDOd9A9iUWB9kjW25xFiUn?=
 =?us-ascii?Q?RQ+cX3ag+GGpILRrqFc7NT9Da7jHKzSAuhHjtAsUDDZ1UFYZXwZ53KuPXZme?=
 =?us-ascii?Q?JeeknHB/IW0UAT2zZTz/+WhqqG3jNbXf9EAHf28w2bcZGYC6GEtZtVq98MD1?=
 =?us-ascii?Q?O1dFEaviWSjJoQTK6XBBd14K+J+Cy9YFX/syB8kEb6aVdXtyoGpx3TIbdJ8O?=
 =?us-ascii?Q?JtmXqOCnuzIxos0ViQL1V1ykXYiRB//tJtDP082g5UhpuSFWsWJq93PtXqgd?=
 =?us-ascii?Q?I2SMT6sUMeEcC0ttlWUNPJV2ylHtKMVZnxG4KFJOvwSAg6VfvbSeeP+e4SbF?=
 =?us-ascii?Q?P5BDmBHFRhW14fj9s7LF20d6Be8GH6jZc8tZ24n3rLOQdI42DfEtd51Nt4aV?=
 =?us-ascii?Q?v7x+L23BaMVbAEFWcHAJR6B/k8ZXDtGhbjmbNOVXtM/wvYv2VRNv6TBu/7BS?=
 =?us-ascii?Q?qot5B+Suo1ek1Wh8zNLJgxOmcNWrqMs4HTsjC2EFy0owQ8OL5DOgahAS6p7s?=
 =?us-ascii?Q?ZiZsEWLBzRmljy4A0mtnYtC4kHkdd1mw+HzRerc/gjrd5eAeNlgjKv8clqn4?=
 =?us-ascii?Q?7m6qmjJUSwSnj6qKyiIOoImmJRMJZJFwi4N+h0GiDcJO2sYimuOw7IYRdJaT?=
 =?us-ascii?Q?eucUAo1Kxg2sIOOJessQnCSaZqXiw6ROWR/TxlfZU2g9y0EYxnb6mmWZqgze?=
 =?us-ascii?Q?nA3WI2X4VchnGSKGdilwrFw1JSpsRm5Y8XcEmixq8qi8AXLVhs0Jncg9wlHM?=
 =?us-ascii?Q?uyAO0qtad5M7A5tWgTk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 21:26:14.2742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6568e8d-4a11-4b91-cfa4-08ddfed5a73d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021

From: Gal Pressman <gal@nvidia.com>

The ->set/create/modify_rxfh() callbacks now pass a valid extack instead
of NULL through netlink [1]. In case of an error, reflect it through
extack instead of a dmesg print.

[1]
commit c0ae03588bbb ("ethtool: rss: initial RSS_SET (indirection table handling)")

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c  | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index fd45384a855b..53e5ae252eac 100644
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
+				"Number of channels (%u) exceeds the max for XOR8 RSS (%u)",
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


