Return-Path: <linux-rdma+bounces-13369-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44FEB57B0E
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 14:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBF21886144
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 12:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8826F315D28;
	Mon, 15 Sep 2025 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R20O1dqr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9C31354F;
	Mon, 15 Sep 2025 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939147; cv=fail; b=ekBk8HBV7kNruIVPXAx6ZVVgwbk95i6t3d/vNBqwhNJ4VMbQHI5Rijd6Qqp10sH+2c6ehRC6K7x9qojrqWUXg/hPhVUPIjzrO9aS/NvZAjGbC+rrGdvrhC4A73o5OlNccAVNylQh6f7mkkMU6UWxjSOsckSp1rJTUojr3ZfOi2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939147; c=relaxed/simple;
	bh=qGtTZXjx9LO7sfpjNXuxyM+ZkHawms9x7LrmgGDL1og=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0R9kN9So8X33NqT5bY9QdIRx9aNmdxXHchjJKpXdi5o0uAenAcn1ogPayTStRCznfoOHpvNnaTNQ3MAOHA8hoy5r/9+aTvQw9YVux4z7hd7zcT1JQcKOlylr+CpZqU8lVcCxCAeQtBSnYr61oVg2nX+qf5l9dkTHjysegafU7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R20O1dqr; arc=fail smtp.client-ip=40.93.194.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxHKLmm7hOQrYN7A64f0I4AP6Ij097nGpDLu2LXcxkdHGhNK2G35n4OWNp1bvJ8fmZci+4t0RT6sn46uJXIploIyHAf199Oyibq+bAW9KtX1XHGDk9puPo+xujIIHHoqFGJVSrJD/uEkk/yuBgrRoARWHIU2oge8qW6JfGYJNdv7LRnwYXclHBDXlBQnZm/P9nWM7WKZnosJ4upVeNJ//MoCCMynDN+GQ+Lt4Tqv0dJcsxT+UkJuTDBuaSkPk20YGzbRqGgI6gXJ9VDgUnofEptMh2YgYUbNFLZfr1E6BeYRbX054Z51tvxFIrHmfp8CT6f7Kal04Oz7xMwtv9wVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUTw+1UaZJYi8H50lTGZKOKj4xotFmwMRsW5+NAIThc=;
 b=xJKmIC10c32K2+WdV29DGv85tSsDth3cSLRxqj5DJdPG5GXT+EHKaS/xR5rqUJNCwXug30r1ku67jcg9KOokxF4Ud6KhdX4kXa1upX7H3Ve23WYSW0bTsc8ECry3M3iJBtfwDYVk+ufhiSKJs6rWR9IG4/ZYqDhAwtsBpu2yqw/eTRjs6LZGUJM8n+UrpJz5bqS+vzv6RDv860FKXlaQuHFrrcinJxTjhok3d3f4RBQotoT8OA/FC22xTfVu02ZunzivHHgLd3pldE3Kh4qSV7BuEjCOL2A8olEK8NZAikJaAhmLyb0ma+KGijapYaF2EJ4zHDtKmROVX4VuY1ggjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUTw+1UaZJYi8H50lTGZKOKj4xotFmwMRsW5+NAIThc=;
 b=R20O1dqrT3vEbS6uYpZUiPU+dUxvOoHdPfeUPOaPZ28R2g4cHgQsdzDileaYZxwen+BRqs3+YfqTA3E/eAMg1a5US0V5Z4+YPxVNmoNUfXloBE6Ogd1ldScNyV583K9vWUVk2DHYOCE8WsB5wyTsGm9vxWZPc1GAKqYSTd6ed06i5iIiwdyGpdfCtSQttUZIiiXLa8ID+vG+ihFHdhve8cp9+a6flrDFTRDjQJB3edb2JxwH91mJzMdFZfb1A7yddmoK+yfqIIUWI4rFpXIkp3ohhtAB1NcGm/YgaLyP419WmNE81kYKwm+xqqHZ8Ts9A3RlKqjJxVeKF5tCScbSsw==
Received: from PH7PR17CA0023.namprd17.prod.outlook.com (2603:10b6:510:324::24)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 12:25:42 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::24) by PH7PR17CA0023.outlook.office365.com
 (2603:10b6:510:324::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Mon,
 15 Sep 2025 12:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 12:25:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 05:25:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 05:25:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 15
 Sep 2025 05:25:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH net V2 1/3] net/mlx5e: Harden uplink netdev access against device unbind
Date: Mon, 15 Sep 2025 15:24:32 +0300
Message-ID: <1757939074-617281-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757939074-617281-1-git-send-email-tariqt@nvidia.com>
References: <1757939074-617281-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 71bda616-7180-4575-b4f9-08ddf452fcd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OkQysaOORFp1aHQaft51usDqLcMpLmrYIUCoIFuI8GPVCKo7UzSuS5un2UsE?=
 =?us-ascii?Q?6mgmqzCPnbjCGueNh63vLl13WI4gCCTgk4P57sFWobiA7V6EMpVOGCBF+QGZ?=
 =?us-ascii?Q?iNItfFQAKAiLUHvegWUybx8irW8TWwBArW/BDNFtxmYOo5INKVgaj72ruG8S?=
 =?us-ascii?Q?pTvb758VljJoGJGEtwTdsM2J3ffQXcHqBqwCl5IP0HkDAjo/RNhbE8IW7XN1?=
 =?us-ascii?Q?Lo3fPlgrlnI8LwHiK/37RJ5yrF8SHgLAf4vfUptga0pzBJRQgq3Jfx4Arjla?=
 =?us-ascii?Q?//m+xQ7oh5aZMCw9udKCR5TbqrkNsb7igoC3F1b6lB1jWSdGHqTVPJhLj53q?=
 =?us-ascii?Q?KL4HeJYTQ/d9EJm8N2r9LctW6WzT9mDg693k2bCHIix2vvVfSpA6eWbH7Q8V?=
 =?us-ascii?Q?5yyNgL0xFgiGfO3NJSVRiwKOxKw2v83qQ4nrCZ+BD6EUbBmhD7n/j3HS2Vw6?=
 =?us-ascii?Q?23xMnKK/haZ9aYiOze9PwmZ8Ik+mEnunA1UOD5hOu9GmV3WNed0IAE5ptFjJ?=
 =?us-ascii?Q?xsU7WSm2Snjz51+fSWBFkwayo5dw7LGmE9eIoNCpO+1J3CUyKKVFRQw5xG8C?=
 =?us-ascii?Q?rg0kaHNfJvnueeAj8N2nbUDO/yTZHlHZFcfz/U6aEZiZWu9HBhjS6cIabI9o?=
 =?us-ascii?Q?sseQ4eierXHPjkoCrvxC5XPywJudCejEYYJknnZlf86oA7N6EWvcGcTGLP7q?=
 =?us-ascii?Q?j0NFOmm4yudT+/N4DbwbgwAQ5Ulv9NcD1CnC7ij0qVobUhAyUmmaxrcREp+U?=
 =?us-ascii?Q?gHgiOB3FpWeUaEruJ/a4STj/91TjuOrK+Gcsbbd1bbUloyf+SDC/U+6kiqe7?=
 =?us-ascii?Q?/1x27XSkGPrNB4LTzoUzLSlxkwb6e9SN6ORgIZCWpWttkQP/Yb+T8kVOiitP?=
 =?us-ascii?Q?/1eyR4u80lBw0Q3bLTguWb9ef7b7DjL0Cou4vgyB5Y0OLpFHFtUJ/Msat/Xj?=
 =?us-ascii?Q?8P3/glFQN2QbIccvUi85T4sVKNaLjvfPGSMLAVrl80vsB20ulKPWkojK/eyU?=
 =?us-ascii?Q?iu3Bf3ePDm81htNAVdJax2Hz/pSVGZdEEKAumF3XHjDjQwGF48Bs5sMn1yhR?=
 =?us-ascii?Q?9TKG43BiJIjGBxmDmnyslb5ilvRkJPzZ7yn4+OhVnoBEg+d5dDYpt7ZCgoxN?=
 =?us-ascii?Q?k2a1c2YL/PA8H1SO3ZQcVneL2foSp4bqxxub9j3SfXUrO8oynrpk6UYB4Bvh?=
 =?us-ascii?Q?6u6Pt36cO7bTLL6CK5k+F0W8l5k1SXrZZ/kXXT0UlzkS2iM+b+DbpsXBXAXv?=
 =?us-ascii?Q?VjJvr3RZdBGeMPNCr+iT6wfShH9etDONc47FHUM2t3OFt+kqr7gCw+ykCS8P?=
 =?us-ascii?Q?a01YI459DvJ2ZnX1+b9EusmbPhjnIwhQSlZ4ydzoAJdHczcuQ7CRLeL0e00C?=
 =?us-ascii?Q?pcymR1hPbJU6yr0+cc8X5Y0XGt+C5WMdmP/AFcyT/dkNfwMA/2sCtaDl/O3A?=
 =?us-ascii?Q?Vgw81yXvD0rh1P7wra2+FnTB/DPpfQ78VJ4xj62UMvt9ijCIw8hZuBozXAz/?=
 =?us-ascii?Q?W39iQl8IT4DOWE3nMRK6Rg+5nzW7vQzvRqDF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:25:42.1635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bda616-7180-4575-b4f9-08ddf452fcd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222

From: Jianbo Liu <jianbol@nvidia.com>

The function mlx5_uplink_netdev_get() gets the uplink netdevice
pointer from mdev->mlx5e_res.uplink_netdev. However, the netdevice can
be removed and its pointer cleared when unbound from the mlx5_core.eth
driver. This results in a NULL pointer, causing a kernel panic.

 BUG: unable to handle page fault for address: 0000000000001300
 at RIP: 0010:mlx5e_vport_rep_load+0x22a/0x270 [mlx5_core]
 Call Trace:
  <TASK>
  mlx5_esw_offloads_rep_load+0x68/0xe0 [mlx5_core]
  esw_offloads_enable+0x593/0x910 [mlx5_core]
  mlx5_eswitch_enable_locked+0x341/0x420 [mlx5_core]
  mlx5_devlink_eswitch_mode_set+0x17e/0x3a0 [mlx5_core]
  devlink_nl_eswitch_set_doit+0x60/0xd0
  genl_family_rcv_msg_doit+0xe0/0x130
  genl_rcv_msg+0x183/0x290
  netlink_rcv_skb+0x4b/0xf0
  genl_rcv+0x24/0x40
  netlink_unicast+0x255/0x380
  netlink_sendmsg+0x1f3/0x420
  __sock_sendmsg+0x38/0x60
  __sys_sendto+0x119/0x180
  do_syscall_64+0x53/0x1d0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Ensure the pointer is valid before use by checking it for NULL. If it
is valid, immediately call netdev_hold() to take a reference, and
preventing the netdevice from being freed while it is in use.

Fixes: 7a9fb35e8c3a ("net/mlx5e: Do not reload ethernet ports when changing eswitch mode")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 27 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |  1 +
 .../ethernet/mellanox/mlx5/core/lib/mlx5.h    | 15 ++++++++++-
 include/linux/mlx5/driver.h                   |  1 +
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 63a7a788fb0d..cd0242eb008c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1506,12 +1506,21 @@ static const struct mlx5e_profile mlx5e_uplink_rep_profile = {
 static int
 mlx5e_vport_uplink_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 {
-	struct mlx5e_priv *priv = netdev_priv(mlx5_uplink_netdev_get(dev));
 	struct mlx5e_rep_priv *rpriv = mlx5e_rep_to_rep_priv(rep);
+	struct net_device *netdev;
+	struct mlx5e_priv *priv;
+	int err;
+
+	netdev = mlx5_uplink_netdev_get(dev);
+	if (!netdev)
+		return 0;
 
+	priv = netdev_priv(netdev);
 	rpriv->netdev = priv->netdev;
-	return mlx5e_netdev_change_profile(priv, &mlx5e_uplink_rep_profile,
-					   rpriv);
+	err = mlx5e_netdev_change_profile(priv, &mlx5e_uplink_rep_profile,
+					  rpriv);
+	mlx5_uplink_netdev_put(dev, netdev);
+	return err;
 }
 
 static void
@@ -1638,8 +1647,16 @@ mlx5e_vport_rep_unload(struct mlx5_eswitch_rep *rep)
 {
 	struct mlx5e_rep_priv *rpriv = mlx5e_rep_to_rep_priv(rep);
 	struct net_device *netdev = rpriv->netdev;
-	struct mlx5e_priv *priv = netdev_priv(netdev);
-	void *ppriv = priv->ppriv;
+	struct mlx5e_priv *priv;
+	void *ppriv;
+
+	if (!netdev) {
+		ppriv = rpriv;
+		goto free_ppriv;
+	}
+
+	priv = netdev_priv(netdev);
+	ppriv = priv->ppriv;
 
 	if (rep->vport == MLX5_VPORT_UPLINK) {
 		mlx5e_vport_uplink_rep_unload(rpriv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8b4977650183..5f2d6c35f1ad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1515,6 +1515,7 @@ static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
 		speed = lksettings.base.speed;
 
 out:
+	mlx5_uplink_netdev_put(mdev, slave);
 	return speed;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
index b111ccd03b02..74ea5da58b7e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
@@ -47,7 +47,20 @@ int mlx5_crdump_collect(struct mlx5_core_dev *dev, u32 *cr_data);
 
 static inline struct net_device *mlx5_uplink_netdev_get(struct mlx5_core_dev *mdev)
 {
-	return mdev->mlx5e_res.uplink_netdev;
+	struct mlx5e_resources *mlx5e_res = &mdev->mlx5e_res;
+	struct net_device *netdev;
+
+	mutex_lock(&mlx5e_res->uplink_netdev_lock);
+	netdev = mlx5e_res->uplink_netdev;
+	netdev_hold(netdev, &mlx5e_res->tracker, GFP_KERNEL);
+	mutex_unlock(&mlx5e_res->uplink_netdev_lock);
+	return netdev;
+}
+
+static inline void mlx5_uplink_netdev_put(struct mlx5_core_dev *mdev,
+					  struct net_device *netdev)
+{
+	netdev_put(netdev, &mdev->mlx5e_res.tracker);
 }
 
 struct mlx5_sd;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 8c5fbfb85749..10fe492e1fed 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -663,6 +663,7 @@ struct mlx5e_resources {
 		bool			   tisn_valid;
 	} hw_objs;
 	struct net_device *uplink_netdev;
+	netdevice_tracker tracker;
 	struct mutex uplink_netdev_lock;
 	struct mlx5_crypto_dek_priv *dek_priv;
 };
-- 
2.31.1


