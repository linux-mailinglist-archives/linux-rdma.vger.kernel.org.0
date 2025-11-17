Return-Path: <linux-rdma+bounces-14569-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 418E8C66501
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id ED2B628FFC
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC8326D67;
	Mon, 17 Nov 2025 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nIysa2DA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012018.outbound.protection.outlook.com [40.93.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07919325717;
	Mon, 17 Nov 2025 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415789; cv=fail; b=KttenMSt6sICyfp3dfOCSf+qALfmoIwjzOPjDI4nLrMjFLxJNpUEYPl18Ctf+PSs197kMfvTD7NYqzIQXFP4NvHXTn+NpLKSdS6Ffb9tU7T1SCemeloEuskdMPDbvB9zPmaAYBTPTLUZB+IoL7+ksJCeC+gYTuSFLpmvmxZLZhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415789; c=relaxed/simple;
	bh=mOqHjlwl7XO7g5OXvr6Vs1Q8nqDlt5tP8TI5NG0KZcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfw+xakHVEGE9l3CN4KDQD24dP4jZceOxW/O+Kd2vBDEf7EWa+hGqUGaCqZwY6eGuGlE1nJrR/qFY7NvoMRZk/kVVtIbEPLdH6S/xSKF3dmIkbCC3o8A1f0WtS7EP/enAzWFSUGCqOQkTSSXXSDjDxAyU6MHxDEXNfNJRGhwUwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nIysa2DA; arc=fail smtp.client-ip=40.93.195.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcCMVCxXUrk+u7rwyrJcAqaD7MTOWrCeWqUCh4jokuqra0RlGPKV/sUK5pRajl1Yz+s6x5rnrBsFVqOR17iCvvTiFJT0mHWqLO2uF0suNaAZKeM2v84SvEBwzfLci5/8Q5ZML8Lw8XtPB2JbO+NidaEH93gJkYFKbx/bAdy01h4U9PWmG43OvMa17IjHiTmtGd0f/9riBlAF4I0REZV52PpH/+5zGKq3GNOGvhZ8lTLmJ6hmY9BWQS1AvLHX6icg+501V4DeYfdlwhvRfLKdXJLAvXNv0U19s/ap38Bh5r6uF5U4yLOGalauXe4vs0A+mmnr1S+9plTlPFPfGA9SIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtxXQLkTB0Rf0inSpjertTEfhB8JvQ+yLRMQ+XCD5Ek=;
 b=hjDevVU+hRyqarYF2cKh/W4jbskXMoGA0b9DCtsuNGsXAwtYsdYecP2UbBdojYsLGlGtQn+Y0Ntqtlt4pyt48vv8nZdtylrL6EEFhm+O/enldxqdmFdyb0NrdJaIJOXpoCQ5JKXZfdiMIsiq3x/5GXFeMUAHv6cC+llmqIO6/l4yiRWRXErs4Qd0F6kupFHmqI7R4TwLghUp880ORPmvenazvG8zd8oomReNKj1ruczYSvGfp3uCaUq8AMlj3Yy04qj42VUzmgJCyAHFHGE/EW3Kg8yXErJpK8C+I6x4WDO6Rqq8LURBG+6TMRVfJor8Di6n08lZNVM0bj0wE7/zvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtxXQLkTB0Rf0inSpjertTEfhB8JvQ+yLRMQ+XCD5Ek=;
 b=nIysa2DA8DjV40985mjp4lspK79RNT+UG5BaWJAhdek4mC3jp2vpPruyHWMbG0X3KlPvZk39kp88pOfP9VYBS66qsiP/JTfsbUqNzJzGMATlPO0N6SbYk9Utq3R9r/VVePYTNC0GEOG3yU6W7oQi9c3S0SHiIPA5pq8k+OKjKzm0xxocWjnfPD2eb+/JuJb/3Dl9ldX1Ln5DSy7Ab2rDLkh93GaAAAIl/R/zKU4ce05R8X9LZ8cf8ExOHTPJB4KI83jWk/rDwHl/Mki8vSXDxlgnuDzTCr/i6Ej7OOrjDI1R5R0zdwOLHmoP+8TxvN/m9kL68PY37bskfda/9ZKzXg==
Received: from SJ0PR05CA0143.namprd05.prod.outlook.com (2603:10b6:a03:33d::28)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 21:43:00 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::fb) by SJ0PR05CA0143.outlook.office365.com
 (2603:10b6:a03:33d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Mon,
 17 Nov 2025 21:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 21:42:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:42:36 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:42:35 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 17
 Nov 2025 13:42:31 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Matthew W Carlis <mattc@purestorage.com>
Subject: [PATCH net-next 1/5] net/mlx5: Refactor EEPROM query error handling to return status separately
Date: Mon, 17 Nov 2025 23:42:05 +0200
Message-ID: <1763415729-1238421-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763415729-1238421-1-git-send-email-tariqt@nvidia.com>
References: <1763415729-1238421-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0d805b-673a-4ccf-dcd6-08de26224684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r4iarcYX575NbToy3qX5GkgnVs4smoCZgJ9P7kcV0I0FGfEvcQZVH0JsYDSE?=
 =?us-ascii?Q?0m8zqoBIvuY537CUTG9HaaOlf2dSx9f+z9XYZ2w2ygEme5wrvWeYdcASayiK?=
 =?us-ascii?Q?VUJeY7lS07AnZdzoXjoQas46ALXoxjnj3390Xjgg3r0zafIDTD7eC/tg7BC/?=
 =?us-ascii?Q?3VWX4IWoMuq38DUTWh7DnCLVlny+yS6A/MchJi0Bx04K0zYOZKfI1W3pFE3H?=
 =?us-ascii?Q?eDHAGewqsYCNuTR/Uen6vInnqtlC4lzKjsDPx0ch8N8316rl+rkYiGQ4eOtX?=
 =?us-ascii?Q?kRzo3hVGvPvZBbgMGBnGtEBTroCS5W0VkGR00ZgEnrvldZQCRQkXBmF7AMlf?=
 =?us-ascii?Q?ricLT97FAqP25xc6FmJJ1WsjUQjV0xHw+KfgJp5rzEUR5isPfjAMSl1af8Aw?=
 =?us-ascii?Q?fkT6onwzXCmA/jh6azLRU2YrXr0R36K/9x/u0/c/6+LBHZ6hmeIAflpsqWH9?=
 =?us-ascii?Q?6uyICgnYSDUFP6Gx6UbrkFL3hlR2c6ru0i9L/fi6OmRhjOprC0T3T2e+3aM/?=
 =?us-ascii?Q?XqkKaEcwzxauAMlxSEthjktNIkgvWIkLX3e1vEeQ2WBtD+SuyAgQDEUjDwLa?=
 =?us-ascii?Q?IUILfik4t8i2xm0K9RGZ1V3mK4GNzXdpxWBJAUZoJeoxJzTzWlBkDrEbQhg/?=
 =?us-ascii?Q?55h5GwEqr+IMuvmoYYqnKOxCnfXDMMhzf2UhW9XlthWBBEgt1e8OGwtxhfrh?=
 =?us-ascii?Q?AZnYuG1ogNcR2AgV9FWZBmA1vkriDPyGgMzjiE18AmNEWAOQQBCZaG9gceXS?=
 =?us-ascii?Q?12duf7i3eH6HFo5MCwrx+vip+HZCm5WU1Zlp3jITSQ0vhKCg1skRFbux6O1Q?=
 =?us-ascii?Q?oNg72P0Ydzknpj7y1sQuJoTaeAvN8wSigHPBo0VfW+SuZgHGfa2Cd2cQcyRf?=
 =?us-ascii?Q?4dtFzqaW7grxywNfS6pmCrRVcU7X1DlqmQlrn5IcoAtFRx9LiAYQfxSVhRLZ?=
 =?us-ascii?Q?6tG8aiDKtRVucEXwwZ4BSuzuEkUsloPH4s9zc+k1niG83di6/KMsNM/8dG4r?=
 =?us-ascii?Q?mEfl3cR/Ui0ySGYHHPRnsFTplw4S/T/7SqZttIGaezkhsuHWt7oNG0xLXDbt?=
 =?us-ascii?Q?WPyLmEr5IvpTxx11DqdJHQ7K85YG5l7Kh54aJtvdnk+4CeX26zzonyLVlsFn?=
 =?us-ascii?Q?wDEsEwG1h/ipaKdCXJgaP+Xxs2IqsXkR9v4LZ3LMvSMUQ1yPet8f2777IzpC?=
 =?us-ascii?Q?hZzXhfdXLLXZnbu2qP0DhAAqj6/Gw7scESJv3B1QhUxE8qzrm0f3gx27aqyn?=
 =?us-ascii?Q?CF0tPxRaTHmOcbmSKlVCKq9/pE1TxjNsWTSjDGNUavh/RVpZ2ex9XydcCm1u?=
 =?us-ascii?Q?6PNf5ivQH3Sx7RyHj7GpIJ1Wzp+s5LbHT9OqJ8Hx2h7dABF+XSf8E/Rh7GEM?=
 =?us-ascii?Q?h0Wlm09iHUjNY+37TAqJT6i7CKIWyJ7q8u6Vl6vsGwbiwl/Bxuhm64fPUNuD?=
 =?us-ascii?Q?yhjIIuu7/IwigxAaW1qZeuUFj9AgEw5m1JnHWIdOqMagzMES9e6RUnPOFLac?=
 =?us-ascii?Q?gGt+32B9/sDkjFA807ZLWiZEqBB77hw/RPqPM0N9u4rvPGaPg27uIsmQgNei?=
 =?us-ascii?Q?vrSnnbTc/AMXjZltDLI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:42:58.6771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0d805b-673a-4ccf-dcd6-08de26224684
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144

From: Gal Pressman <gal@nvidia.com>

Matthew and Jakub reported [1] issues where inventory automation tools
are calling EEPROM query repeatedly on a port that doesn't have an SFP
connected, resulting in millions of error prints.

Move MCIA register status extraction from the query functions to the
callers, allowing use of extack reporting instead of a dmesg print when
using the netlink API.

[1] https://lore.kernel.org/netdev/20251028194011.39877-1-mattc@purestorage.com/

Cc: Matthew W Carlis <mattc@purestorage.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 19 +++++-----
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  4 +--
 .../net/ethernet/mellanox/mlx5/core/port.c    | 35 +++++++++----------
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 01b8f05a23db..7cf2ec8543f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2027,7 +2027,7 @@ static int mlx5e_get_module_info(struct net_device *netdev,
 	int size_read = 0;
 	u8 data[4] = {0};
 
-	size_read = mlx5_query_module_eeprom(dev, 0, 2, data);
+	size_read = mlx5_query_module_eeprom(dev, 0, 2, data, NULL);
 	if (size_read < 2)
 		return -EIO;
 
@@ -2069,6 +2069,7 @@ static int mlx5e_get_module_eeprom(struct net_device *netdev,
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int offset = ee->offset;
 	int size_read;
+	u8 status = 0;
 	int i = 0;
 
 	if (!ee->len)
@@ -2078,15 +2079,15 @@ static int mlx5e_get_module_eeprom(struct net_device *netdev,
 
 	while (i < ee->len) {
 		size_read = mlx5_query_module_eeprom(mdev, offset, ee->len - i,
-						     data + i);
-
+						     data + i, &status);
 		if (!size_read)
 			/* Done reading */
 			return 0;
 
 		if (size_read < 0) {
-			netdev_err(priv->netdev, "%s: mlx5_query_eeprom failed:0x%x\n",
-				   __func__, size_read);
+			netdev_err(netdev,
+				   "%s: mlx5_query_eeprom failed:0x%x, status %u\n",
+				   __func__, size_read, status);
 			return size_read;
 		}
 
@@ -2106,6 +2107,7 @@ static int mlx5e_get_module_eeprom_by_page(struct net_device *netdev,
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u8 *data = page_data->data;
 	int size_read;
+	u8 status = 0;
 	int i = 0;
 
 	if (!page_data->length)
@@ -2119,7 +2121,8 @@ static int mlx5e_get_module_eeprom_by_page(struct net_device *netdev,
 	query.page = page_data->page;
 	while (i < page_data->length) {
 		query.size = page_data->length - i;
-		size_read = mlx5_query_module_eeprom_by_page(mdev, &query, data + i);
+		size_read = mlx5_query_module_eeprom_by_page(mdev, &query,
+							     data + i, &status);
 
 		/* Done reading, return how many bytes was read */
 		if (!size_read)
@@ -2128,8 +2131,8 @@ static int mlx5e_get_module_eeprom_by_page(struct net_device *netdev,
 		if (size_read < 0) {
 			NL_SET_ERR_MSG_FMT_MOD(
 				extack,
-				"Query module eeprom by page failed, read %u bytes, err %d",
-				i, size_read);
+				"Query module eeprom by page failed, read %u bytes, err %d, status %u",
+				i, size_read, status);
 			return size_read;
 		}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index acef7d0ffa09..cfebc110c02f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -357,11 +357,11 @@ int mlx5_set_port_fcs(struct mlx5_core_dev *mdev, u8 enable);
 void mlx5_query_port_fcs(struct mlx5_core_dev *mdev, bool *supported,
 			 bool *enabled);
 int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
-			     u16 offset, u16 size, u8 *data);
+			     u16 offset, u16 size, u8 *data, u8 *status);
 int
 mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
 				 struct mlx5_module_eeprom_query_params *params,
-				 u8 *data);
+				 u8 *data, u8 *status);
 
 int mlx5_query_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *out);
 int mlx5_set_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *in);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index aa9f2b0a77d3..e4b1dfafb41f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -289,11 +289,11 @@ int mlx5_query_module_num(struct mlx5_core_dev *dev, int *module_num)
 }
 
 static int mlx5_query_module_id(struct mlx5_core_dev *dev, int module_num,
-				u8 *module_id)
+				u8 *module_id, u8 *status)
 {
 	u32 in[MLX5_ST_SZ_DW(mcia_reg)] = {};
 	u32 out[MLX5_ST_SZ_DW(mcia_reg)];
-	int err, status;
+	int err;
 	u8 *ptr;
 
 	MLX5_SET(mcia_reg, in, i2c_device_address, MLX5_I2C_ADDR_LOW);
@@ -308,12 +308,12 @@ static int mlx5_query_module_id(struct mlx5_core_dev *dev, int module_num,
 	if (err)
 		return err;
 
-	status = MLX5_GET(mcia_reg, out, status);
-	if (status) {
-		mlx5_core_err(dev, "query_mcia_reg failed: status: 0x%x\n",
-			      status);
+	if (MLX5_GET(mcia_reg, out, status)) {
+		if (status)
+			*status = MLX5_GET(mcia_reg, out, status);
 		return -EIO;
 	}
+
 	ptr = MLX5_ADDR_OF(mcia_reg, out, dword_0);
 
 	*module_id = ptr[0];
@@ -370,13 +370,14 @@ static int mlx5_mcia_max_bytes(struct mlx5_core_dev *dev)
 }
 
 static int mlx5_query_mcia(struct mlx5_core_dev *dev,
-			   struct mlx5_module_eeprom_query_params *params, u8 *data)
+			   struct mlx5_module_eeprom_query_params *params,
+			   u8 *data, u8 *status)
 {
 	u32 in[MLX5_ST_SZ_DW(mcia_reg)] = {};
 	u32 out[MLX5_ST_SZ_DW(mcia_reg)];
-	int status, err;
 	void *ptr;
 	u16 size;
+	int err;
 
 	size = min_t(int, params->size, mlx5_mcia_max_bytes(dev));
 
@@ -392,12 +393,9 @@ static int mlx5_query_mcia(struct mlx5_core_dev *dev,
 	if (err)
 		return err;
 
-	status = MLX5_GET(mcia_reg, out, status);
-	if (status) {
-		mlx5_core_err(dev, "query_mcia_reg failed: status: 0x%x\n",
-			      status);
+	*status = MLX5_GET(mcia_reg, out, status);
+	if (*status)
 		return -EIO;
-	}
 
 	ptr = MLX5_ADDR_OF(mcia_reg, out, dword_0);
 	memcpy(data, ptr, size);
@@ -406,7 +404,7 @@ static int mlx5_query_mcia(struct mlx5_core_dev *dev,
 }
 
 int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
-			     u16 offset, u16 size, u8 *data)
+			     u16 offset, u16 size, u8 *data, u8 *status)
 {
 	struct mlx5_module_eeprom_query_params query = {0};
 	u8 module_id;
@@ -416,7 +414,8 @@ int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
 	if (err)
 		return err;
 
-	err = mlx5_query_module_id(dev, query.module_number, &module_id);
+	err = mlx5_query_module_id(dev, query.module_number, &module_id,
+				   status);
 	if (err)
 		return err;
 
@@ -441,12 +440,12 @@ int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
 	query.size = size;
 	query.offset = offset;
 
-	return mlx5_query_mcia(dev, &query, data);
+	return mlx5_query_mcia(dev, &query, data, status);
 }
 
 int mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
 				     struct mlx5_module_eeprom_query_params *params,
-				     u8 *data)
+				     u8 *data, u8 *status)
 {
 	int err;
 
@@ -460,7 +459,7 @@ int mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
 		return -EINVAL;
 	}
 
-	return mlx5_query_mcia(dev, params, data);
+	return mlx5_query_mcia(dev, params, data, status);
 }
 
 static int mlx5_query_port_pvlc(struct mlx5_core_dev *dev, u32 *pvlc,
-- 
2.31.1


