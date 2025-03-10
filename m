Return-Path: <linux-rdma+bounces-8553-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF87EA5A6B4
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 23:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D941735AD
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 22:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E322C1E8350;
	Mon, 10 Mar 2025 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VxIHvyR4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195051F874E;
	Mon, 10 Mar 2025 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644204; cv=fail; b=qvYF2t46awNIn6C0qK/kpgoTz1IgvUxZUKqnwfCuhj5niW61AZuIxtbJv5AdEyIp7vLOIaJxSAIgDDRJc/KGHt/o2Umb7oQunMNoGXsj77LqAWadts69OB/u3R/3zQq+igQqh1mpv9b/K/SCZbrDI1eUNMXt7+g1aPiPY0Zyu5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644204; c=relaxed/simple;
	bh=ntXEEPieNkn9nt0rkJNtI2Ido/KPswTzXd14etU9I4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxkxVURKgxyM+S+31q9RXPp5tQg/CTw1mYK7wppIh4IeQbCexdbgOFDMctvOSsrViJAkp2ssDS04gnhfRVy7dFTTZMn2f66VDU9+ir7yjk3/U7JerjhZEfkiRO7GnO935csVkjDIYLBq67VcrRQWuU7Y3xYyOIM0w3yRhdoQOcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VxIHvyR4; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpVb801S6r+X6C8bJMzCQZSVVn0puR+BkzysT3+VWN2nM8XmcTe/56DkvsTaEpVw+ISzxuhvQYW36Lsmc7ii7FctUBC9p9zQvnjmEY4T/lPNZIoPSpWJrIBWJ4KpHYVpORlQgJ7St6GL7qlQB/PRtDoYFRe5aG6EOyT2jJW62Wq0vhWB31BHjg/3+v9YtaD4ylC5gd77wUygSyaYREaNr5OWxt49WbreumNtlc3I2xyzpU2Oj3GNiAIP2/Vq/RBn8ueuligztCis0DRJKcqXV1kcmquGEL8ql3aND6n9bbHMuqJ6TVyuq3DgmsKdAP4f7cL1GcEWMybZ5lFr4EvXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VrVXyny0I9yZeHk2axmchY7t7XUAsBWVKtxxGgFksY=;
 b=np7l8DCMmn3xivrQEmH1d38Vc4B54uA3N2fpfZl52I0EwRdWPWg3mMPoqdg03IX1PTORNXVrDoM24LM9EU8LrNJjntmqrzd4CUVJbtVREEHJyQO462r/ydEQ1B7YYXQGI5Fcr6Z2tTxt5xU9/PHPmFSurxiC3Y5z5696iKCpwiB6CzeTKohTL5YdQFNg9pj2G3MUCWY7afK8XwxxtOwMf5ZyPRe27bysdK3eAFA/n9heVbsQnsP8WgzD3nKAWxJhmFwQZvPbVOYH45TzVenxrgr9Do15AILrvq9xAxCB9ivx8odHQwlEZb1NjueUkgteNUlseMQzyYmcfPnt1r0hIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VrVXyny0I9yZeHk2axmchY7t7XUAsBWVKtxxGgFksY=;
 b=VxIHvyR46DvOeznHKe4ub6CusM2GWPCoWg/O+dWFJhHMtjo7Nkl4CTHBIVWEeSAP4UqhDrTdq1Q8X+b4I1tmUTpeCfhjKM0u/owN58Du2iDJ+FNhzGEto7WnaXdBB/sBOwJiczycK4wiOPEeMKbt6ppGaCJNop0RydlK8N1B+hsLCg32EDVJvtci6bU4dnxVrV+6211qblBmpYcMDkQOgvps2IGF3c9uJH6nfyvjganI6cNflfic+gtjWFC+BXISq6jL7Z7X1sdg79wEbBa5IzKS2owbjQsvDCbLvv2tetherW8dN8WQryrnDlxNgaEmPkUoi6W06VH8Ke4Z4VHyXw==
Received: from SN6PR01CA0003.prod.exchangelabs.com (2603:10b6:805:b6::16) by
 CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Mon, 10 Mar 2025 22:03:13 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::14) by SN6PR01CA0003.outlook.office365.com
 (2603:10b6:805:b6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 22:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 22:03:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 15:03:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 15:03:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Mar 2025 15:03:00 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net 6/6] net/mlx5e: Prevent bridge link show failure for non-eswitch-allowed devices
Date: Tue, 11 Mar 2025 00:01:44 +0200
Message-ID: <1741644104-97767-7-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
References: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4413c0-3f40-495e-d76e-08dd601f5a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HtnrNqUEYuivalbcmUakCz6KxYFa49ES6SKfE1xxXQVjQwPVPvbg/s5UkZQi?=
 =?us-ascii?Q?w6IcHj0LNnmnWgnwvt+MsxNwBrqLWRFztysNgEH3Hs/0ImkRHA2BEdhK0VP+?=
 =?us-ascii?Q?aD3IanAoG2Cpi/oFEUM6T50wTMRkCeWWQYevLDKrQaOjsIRLwbIMr8UKa82y?=
 =?us-ascii?Q?1lQgIywqmWyjawoiNrq/bYfKPak+S15UVE3ZMrlyeNn48H4O0Ff6ZEbuDWSB?=
 =?us-ascii?Q?hMFhmtwcRRe8KliJKYb6AYZuZovLcjx69ckay378vxEZ/6+cmFiGTjfSFWww?=
 =?us-ascii?Q?IkJwU+muzN7nEUm+tm1GN0WToGMIkHlyjkszPWxO0cXu9X81tdMw9TfeCDBN?=
 =?us-ascii?Q?oWMmZZ8SRowbPfJJwCoEhs2krfVhnE374Jq4u0ig82i8mAU+m5jRPjkzAJi5?=
 =?us-ascii?Q?23/U69lbC9rLVgLb52wydybtIXFDrXfaVx+1QHPwiD1byNSW07B3pkAFHQJZ?=
 =?us-ascii?Q?1/JTd0Qk2H8fTdYAn9EkzDD6ImlaD0+5crpgdryoZH4s06CpdRPMJ7TgVTny?=
 =?us-ascii?Q?Y5HnMhhbliinEE5iBAwD8ST4XMNzjHBXiNJrVqAOKCBLemIlS+Nu2uNFGPfZ?=
 =?us-ascii?Q?INV5t49UDSb44oHKBJUjsbwHXK2m0VwLX3JyDbdu9P2SXBH5LQLFMKes6jbH?=
 =?us-ascii?Q?EPttVE8CqXmCyAj/qRhNEeXX1Z+wRDbvJiRKCh6RjeRpNjM8VA2fgciv83eo?=
 =?us-ascii?Q?HkVguEe/kaVFHy/g0ON18qFDaZFSieUL78eTJv2AWvlAhwUnKxhHSn9yLCWw?=
 =?us-ascii?Q?X7JdrCyRqBBW0RMUWcvntxRpjDEp92QbCllUYMa1J3fue46DKK5f3dRSmbG+?=
 =?us-ascii?Q?RwKaxc5l90n0OdKsPE1EpQUDm/G4mi3R5U08pv4r18SjRln2eHnR2n2APX98?=
 =?us-ascii?Q?yGWAXUm/4mq8U7UPwCMPDOv/01poIgooEALeUcP9ZOg2oAtiZIR3lXhLu/b0?=
 =?us-ascii?Q?3Fi4mGRVtiqW3oIdjR0vKVQNLXlIfHC4QPBv96RRx5FCLb9Ew6ie4PyXbwue?=
 =?us-ascii?Q?A4XFS03ealItSPlqjZRKnrNZGFxsn3NORK3OOE+qEWJXEnC6Ccc2USVngKqP?=
 =?us-ascii?Q?cgina7Z7bFaL3WD7CX2giG/KXqZFme8EP0Ca++gRmR7cpIeiI0fdG6Wtm9MI?=
 =?us-ascii?Q?NwMMrfLSq7+bE6uif7Up2Z3slzgEy8FSaEmP5cm0IJTIyJDAC7LGvGv6lFwa?=
 =?us-ascii?Q?jq/s5TBIeCFwKn2gKCmKZLjQUUqvvIczlwkDCoYScmMwFKgE6+ne+20mxlgj?=
 =?us-ascii?Q?KZFkw1X8SOTIdrOpyi/xsMqC9FUnhTpT9MSixm8iii9ZtA4WjetUGIHOuIXX?=
 =?us-ascii?Q?c0Hq4QCG+TgGSTNUJBZ1BDQpQdya6mRgqtyESkiYqM2uhuWiusMByx5ff4Jk?=
 =?us-ascii?Q?cdnx+ShTZIYcKO7OP3XDxdcX32TZHrL6ijWQfo8MZYSPCoXrVP33DzhT3gJU?=
 =?us-ascii?Q?UBifOdKdhP0Kxl97RbNioVgZ2OxceZtjs69FV3izd95EliHPw3pzdu5LdMgH?=
 =?us-ascii?Q?4N17JzJSZSY7AxU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 22:03:13.0622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4413c0-3f40-495e-d76e-08dd601f5a4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279

From: Carolina Jubran <cjubran@nvidia.com>

mlx5_eswitch_get_vepa returns -EPERM if the device lacks
eswitch_manager capability, blocking mlx5e_bridge_getlink from
retrieving VEPA mode. Since mlx5e_bridge_getlink implements
ndo_bridge_getlink, returning -EPERM causes bridge link show to fail
instead of skipping devices without this capability.

To avoid this, return -EOPNOTSUPP from mlx5e_bridge_getlink when
mlx5_eswitch_get_vepa fails, ensuring the command continues processing
other devices while ignoring those without the necessary capability.

Fixes: 4b89251de024 ("net/mlx5: Support ndo bridge_setlink and getlink")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a814b63ed97e..8fcaee381b0e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5132,11 +5132,9 @@ static int mlx5e_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u8 mode, setting;
-	int err;
 
-	err = mlx5_eswitch_get_vepa(mdev->priv.eswitch, &setting);
-	if (err)
-		return err;
+	if (mlx5_eswitch_get_vepa(mdev->priv.eswitch, &setting))
+		return -EOPNOTSUPP;
 	mode = setting ? BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB;
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
 				       mode,
-- 
2.31.1


