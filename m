Return-Path: <linux-rdma+bounces-12716-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695AFB24C11
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 16:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E942886EE3
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4FF1E3762;
	Wed, 13 Aug 2025 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IRo8Lc2J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15601DE8A0;
	Wed, 13 Aug 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095543; cv=fail; b=qbykkgUueDzbSwlP1MKhmQ8un0laP2byf/yq3+pumLyvo8gugAApQZ8LnhPdKnG/hrMnRTkBzVtZg3IPbSWFfTaalYiz4ibH3AtfbaTQ9z/ThyIXbd5IiEuIXsCs7CnUEMOZ9HkTIb4hiP+b7zR6FxoekdXVI4NrwX4yo5cT7ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095543; c=relaxed/simple;
	bh=gp4c3S0bTdcxKqu7KTD6jyvd8wXpoxfhLd6iegnPJSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQ3wOnY09rw2RGu0Si3myGB8gLAi/RAvJa1XPyWxnhcdABS727agxlolKv9ZupgP7fH3C4wxhoOqoKSK62ljxZDkVgaJRIk/Sd5E99rE2usyzxZkKdVmckCAuss9O2qHFXXRBQ0nB0hIo60gl/LBY0iaIF53x60kSJDwdo4s+E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IRo8Lc2J; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5z/KlPRG6Ff6tv4Wso3JwrmHrH5PdC8UDiVGHsKRk9Dxa1iOkcJEfUChR9TZe5QdEwAjjWHdxnMyc0ENVYxrJFrTkAgKweezazWy12ijX40eDaUFS0QMrYKUJEy3/43Zuy+QOdAKIRWKDKL8Da3vz4gt58nzAnuy7UCLQSnk0UMkM/1pXNr3P8QHFbXbWLAKWEvIj6Cp6z1oV9jOe/mHuimAWXBPSEzl/GrVcsZ0yE50HmlWCoZKXyLx1R+jO0PXier+R3mS0q1dLeEUCnpFKOGepNsxRBpgVlNSJEstcp+AduiQ1yqVjmawevmWS1IAWJPUBpHd0jeLevzRQd8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhrVlwoAs7f+gkborNatB6dus2rwANbyKHcyC/ECOnY=;
 b=JKU8nVzxeaELhB0jfJNg2Gqq9WvzvE7A6pmdgj3dWvIc4zXoE+VZz2rJA8ToR/rRgwf1DgnqdGE4dAPUexvQoWfm1kvehdSZyu9kSsF1oOUG0lMAxGmc0pQ2S9BLugFcr+LSW5rlsb4485+fJOP8biR3+jb71ZK+lZBW/0e6DUANgjO2q1CUZFUzAhe3/3E7g01X2ti5bIjOF8gIaZcCHyvIhYENT4raQprvL6eTVV4AQ355VGEUlsjHlyPnr31k95KhXls1PafMBerR8AqfY200ojGo19ioem6OGWTsjcfczAq1hb5Dk6Fxzs6TiiEDNVraPil+Pr80bUb/ltZreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhrVlwoAs7f+gkborNatB6dus2rwANbyKHcyC/ECOnY=;
 b=IRo8Lc2Jse7iyO0hamgK0XTcQ9Z7qmQtirGNj/vlBy/4Kqr74x/tHtYq0P7wQWnZE+TY1CnxnaqtFtM3U8pUbvnMjg9vV2WvtE5xSeH8GIvDng4VuWPtIZ2hWOyQBHMO7r7Hqk/ej5yvA95ouvSbxk3Bxhc9+T2mHuv7bLIqoJQ5+L88hVi2BwqdD5moLkt0syjFeKfV4535vMBDMXJuUxlAu80//CfAnOvHVc4IbJVnSit0XNa/Sp1BEP0dqu72TKIuflFtmAp49W5/cjPCe//iTuSrySfQo0HtPOq2RgcuZRBtQXF9KeX66Fj+y5wdjUyG4uqUJ2kGwghnsm4pcg==
Received: from CH0PR03CA0266.namprd03.prod.outlook.com (2603:10b6:610:e5::31)
 by DS5PPF1ADAD2878.namprd12.prod.outlook.com (2603:10b6:f:fc00::646) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Wed, 13 Aug
 2025 14:32:18 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::2) by CH0PR03CA0266.outlook.office365.com
 (2603:10b6:610:e5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 14:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 14:32:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 07:32:04 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 13 Aug 2025 07:32:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 13 Aug 2025 07:32:00 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH net 6/6] net/mlx5e: Query FW for buffer ownership
Date: Wed, 13 Aug 2025 17:31:16 +0300
Message-ID: <1755095476-414026-7-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
References: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DS5PPF1ADAD2878:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5f2ed6-365b-4f2d-7964-08ddda763513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zDZd70FXsBFbgNoPTpVGA7LzjsOdPOrMzHGM8sEMXNp2QGOb4xzzBhOkk2UZ?=
 =?us-ascii?Q?oC3WIwPYO/+wniogfL+hLKO94ntz53RV06raBwJkWPUR5IcHMJYQn9BNYzIA?=
 =?us-ascii?Q?l4+49jdybO/dMLGa205ycGgHm7j63WKqEtMr/qpfmo/I6L+tcI12J21XBTow?=
 =?us-ascii?Q?cpYZRBlvoGCn7SJTxWR9QkzC/aeKAOQRvE2ZzQnlyJHhW4MnVlD92wnaVSBZ?=
 =?us-ascii?Q?9/MHl45FuGTQcVbQoBf5xVdiMiG23JS8XIHIaiwXX4m7R0UuwXsxmkdVfyvI?=
 =?us-ascii?Q?/Fx+a3g96EYV4N3vAf0qqe6asZz53h4ZalMArCWk30WJUfUYd6hYvIWCSya9?=
 =?us-ascii?Q?RadTMxxXJNTOK3qColGNPyfxyp8IfAAhf12AN9ZhOxikHR6aR17Agh+LAjcK?=
 =?us-ascii?Q?V17aqkZoSjG5ctvt/ZjHYGpTRIaJXq8fnXw3cRBFdrJPJEi2DX4iACWycS0p?=
 =?us-ascii?Q?z9bOif2XrsVIoO/rriAu1Re6m3sWgO+sKMk5j73u/nZ7rKXM2Mu9LS9pc4hK?=
 =?us-ascii?Q?7euHe0eNF6wBQungxAwswWXkZEF3XnzUzut/ktZX6d/M9Hw6PawbXDLE40OZ?=
 =?us-ascii?Q?UbokMbsA6PKzpSAVGdNoSLMLwYNUnl155K3dQ584yetGlPKzn0WVXvTmMRV4?=
 =?us-ascii?Q?Nr1095NiaTpw4Qioj57q22ek04XMxAdcJTIcjo+Z/Km9CK3ex4CRyIEVOFQm?=
 =?us-ascii?Q?XvSdBzbjQykIiJ22sUNVHqG29xVkBE4wKraH3H8149NROsMbB5+1AVVGN/LZ?=
 =?us-ascii?Q?GD/lBL8SJi1+XRjvvxVV32VXgWZUr6Ntf+YjuwEo7NFx6ayi9kBOc6V3BCyG?=
 =?us-ascii?Q?2eqrdkNQx8O7vnQUEX9TRuzmcxueTSuBIz7seVPDtA4kCj2vDRruns1efJmd?=
 =?us-ascii?Q?CvWiNMcxvmYIT39QLY/AC8tQkIq3MnI7SZdhqP+d9ElqZXTo5rTkpdczqLMP?=
 =?us-ascii?Q?GC5ZceUfxKZ6b4Ec3gaod5PgAkNbLXEgGziH2OZgcvplC0A0q01WsPRgXIbf?=
 =?us-ascii?Q?YOPUtfWbX7FdlpCpzazejAnBCmHBAsCuPS1H9TLnc9tssgP9QL7hthcc8eRw?=
 =?us-ascii?Q?mCPVr7aFf3GhgNKmUqZSZrUyKdg7wGAbY27yVofzt3ofgW60unCneSpkZeLJ?=
 =?us-ascii?Q?//a/ANZpxhx/HNyIJRM16hi5170DtAs1ywAlytbRGlYT73GqUZFQfZ6zbG0j?=
 =?us-ascii?Q?aTGkm6wIjwPPyjLqyJ1rlJ1M25+BQzfDAbzOXC8LkNXdmcBZW5mqSbEqs1Zc?=
 =?us-ascii?Q?XoLOQyaJMbGGMX4WF4JXG9A8Ib9/rYCc7vgcjyz716lRd6pAonsREihd6MbZ?=
 =?us-ascii?Q?MAZORrDUFTcpxQuIFnzzxNH6ysZPKa5YHnumZPbL9MQWW6g7r3+TDIdWYytO?=
 =?us-ascii?Q?bZt9fjX9/9so8iMx/ZaBFWNK1GwOGcUG13QlItu2pyCPBQuidG/yYYHAcqr/?=
 =?us-ascii?Q?2Y0B6PUUAKADLTc9eHkXs+I9gkd7WISKdD0sCM0zdM2S+18P05S2zxYHAn0x?=
 =?us-ascii?Q?2rM46O9hUjbBgb1lDZXS/bwN/ZH9oy16injJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:32:18.6477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5f2ed6-365b-4f2d-7964-08ddda763513
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF1ADAD2878

From: Alexei Lazar <alazar@nvidia.com>

The SW currently saves local buffer ownership when setting
the buffer.
This means that the SW assumes it has ownership of the buffer
after the command is set.

If setting the buffer fails and we remain in FW ownership,
the local buffer ownership state incorrectly remains as SW-owned.
This leads to incorrect behavior in subsequent PFC commands,
causing failures.

Instead of saving local buffer ownership in SW,
query the FW for buffer ownership when setting the buffer.
This ensures that the buffer ownership state is accurately
reflected, avoiding the issues caused by incorrect ownership
states.

Fixes: ecdf2dadee8e ("net/mlx5e: Receive buffer support for DCBX")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/dcbnl.h    |  1 -
 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    | 12 ++++++++---
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  2 ++
 .../net/ethernet/mellanox/mlx5/core/port.c    | 20 +++++++++++++++++++
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h b/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
index b59aee75de94..2c98a5299df3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
@@ -26,7 +26,6 @@ struct mlx5e_dcbx {
 	u8                         cap;
 
 	/* Buffer configuration */
-	bool                       manual_buffer;
 	u32                        cable_len;
 	u32                        xoff;
 	u16                        port_buff_cell_sz;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 5fe016e477b3..d166c0d5189e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -362,6 +362,7 @@ static int mlx5e_dcbnl_ieee_getpfc(struct net_device *dev,
 static int mlx5e_dcbnl_ieee_setpfc(struct net_device *dev,
 				   struct ieee_pfc *pfc)
 {
+	u8 buffer_ownership = MLX5_BUF_OWNERSHIP_UNKNOWN;
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u32 old_cable_len = priv->dcbx.cable_len;
@@ -389,7 +390,14 @@ static int mlx5e_dcbnl_ieee_setpfc(struct net_device *dev,
 
 	if (MLX5_BUFFER_SUPPORTED(mdev)) {
 		pfc_new.pfc_en = (changed & MLX5E_PORT_BUFFER_PFC) ? pfc->pfc_en : curr_pfc_en;
-		if (priv->dcbx.manual_buffer)
+		ret = mlx5_query_port_buffer_ownership(mdev,
+						       &buffer_ownership);
+		if (ret)
+			netdev_err(dev,
+				   "%s, Failed to get buffer ownership: %d\n",
+				   __func__, ret);
+
+		if (buffer_ownership == MLX5_BUF_OWNERSHIP_SW_OWNED)
 			ret = mlx5e_port_manual_buffer_config(priv, changed,
 							      dev->mtu, &pfc_new,
 							      NULL, NULL);
@@ -982,7 +990,6 @@ static int mlx5e_dcbnl_setbuffer(struct net_device *dev,
 	if (!changed)
 		return 0;
 
-	priv->dcbx.manual_buffer = true;
 	err = mlx5e_port_manual_buffer_config(priv, changed, dev->mtu, NULL,
 					      buffer_size, prio2buffer);
 	return err;
@@ -1252,7 +1259,6 @@ void mlx5e_dcbnl_initialize(struct mlx5e_priv *priv)
 		priv->dcbx.cap |= DCB_CAP_DCBX_HOST;
 
 	priv->dcbx.port_buff_cell_sz = mlx5e_query_port_buffers_cell_size(priv);
-	priv->dcbx.manual_buffer = false;
 	priv->dcbx.cable_len = MLX5E_DEFAULT_CABLE_LEN;
 
 	mlx5e_ets_init(priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index b6d53db27cd5..9d3504f5abfa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -367,6 +367,8 @@ int mlx5_query_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *out);
 int mlx5_set_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *in);
 int mlx5_set_trust_state(struct mlx5_core_dev *mdev, u8 trust_state);
 int mlx5_query_trust_state(struct mlx5_core_dev *mdev, u8 *trust_state);
+int mlx5_query_port_buffer_ownership(struct mlx5_core_dev *mdev,
+				     u8 *buffer_ownership);
 int mlx5_set_dscp2prio(struct mlx5_core_dev *mdev, u8 dscp, u8 prio);
 int mlx5_query_dscp2prio(struct mlx5_core_dev *mdev, u8 *dscp2prio);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 549f1066d2a5..2d7adf7444ba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -968,6 +968,26 @@ int mlx5_query_trust_state(struct mlx5_core_dev *mdev, u8 *trust_state)
 	return err;
 }
 
+int mlx5_query_port_buffer_ownership(struct mlx5_core_dev *mdev,
+				     u8 *buffer_ownership)
+{
+	u32 out[MLX5_ST_SZ_DW(pfcc_reg)] = {};
+	int err;
+
+	if (!MLX5_CAP_PCAM_FEATURE(mdev, buffer_ownership)) {
+		*buffer_ownership = MLX5_BUF_OWNERSHIP_UNKNOWN;
+		return 0;
+	}
+
+	err = mlx5_query_pfcc_reg(mdev, out, sizeof(out));
+	if (err)
+		return err;
+
+	*buffer_ownership = MLX5_GET(pfcc_reg, out, buf_ownership);
+
+	return 0;
+}
+
 int mlx5_set_dscp2prio(struct mlx5_core_dev *mdev, u8 dscp, u8 prio)
 {
 	int sz = MLX5_ST_SZ_BYTES(qpdpm_reg);
-- 
2.31.1


