Return-Path: <linux-rdma+bounces-11454-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC58AE041D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFC81887D2E
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1022DFA7;
	Thu, 19 Jun 2025 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qabH5bqx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDF22B59F;
	Thu, 19 Jun 2025 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333089; cv=fail; b=b3JxB1OTFFC2x2sElopa17+eStlWhScVK5kusPVg0bT7gsdpCRRpBlEC1FvivDpRa5JFXABlHyf6hflvwwU21GGYjUp4h0dxjbVyV2YGl2lh4G7F2Y6NBmqp0oyciw7Ads/bpI++x6bz6KlR2fdsg/0erkRmSjBSTxIK7sFfiKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333089; c=relaxed/simple;
	bh=PSxsQ4p/R+RUJ2+lcKybCiHQyzvbO2L8g4wXKG2NUWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyln4SLjPYPDhpX0Rkkv5Q4gmMDevfBq3vRaQ2lk2uu6SJUz74rUdwBPceprOKnS6ktNKWmlQbof9DB3SJvmDQB0Qk3A38HcLi3YHjUl/x/GnYdT5gb/ePdPgkm49gVlEnzeJhYrnv7kLyboXvVw9su/9YNz4XJPVVZhFX8Rzto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qabH5bqx; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJt87HIKcncPX+LT/XWMr45MWb552vP8niFwldKUYgG/pGZrjJrBkmR3SxILIWkGOtPH8C0MbBNYRa25x6OxnlavqpZ4REzvhxdvv/4D98dAQVBytG6GaoupmUGr9DJwD9e/PYEDppZv4/ttkXUcGXAr8CUd8tuK0nQKLaFPPAPEH6rfbOjCfav3jqFMeahrBD0GqsiHepVsfCWHKV4DwbTTdh+T1uGfWLPPcR99NrEiXloza4PFP9JGhdOhuoUjvpFEXm/b4KxAzNxuGaIantwWlHgaYC6xnvtnyp0gBynqChC/Otfi7cfKidlG9BHVhTIbryymt0Soi+h2Bt9XMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S933YdDqX1lB2xF1I1TdItjBbjuL08cJ96Aueu6pHm8=;
 b=yL/og3T+ZGNePGHunrPWqKvOOrip+Iu+bPtJGH5g4fOG7DURLIczHJUEBkTat45Z52UVB09Fl4fJ2cDMRsJbXY/NiggpSGL4teO17qH4HCqk6vQrYB5RJxbaGwWLpSLYVfjQQ6+xsCMlh2AI7uVmDz+PtqNBcooyVvFLJURKZ99Mdk5LZKxWzREVL6R06pq1si3bBnfGypsPZ+ZNeBUDjYVggWoFk9XyMHt0dUZC7E9LQ4K/BhNPzJgwxp8Q6e+/gHuDlcqTLzjvBHWg3eQBQLE+QPTL8XxTVN5NeYjRokez58J+PBcPlBxum+H1SFCtVYLOl6aadBicOiHJ5ZTekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S933YdDqX1lB2xF1I1TdItjBbjuL08cJ96Aueu6pHm8=;
 b=qabH5bqxWpFP4+xL18AqVEBECXBjKCqBZJQ34YnwI9jqTTlye4qy3tK6vjE970/A7K6PDjZkMO+U4w3vOwbIcyop8WAEgEdIzlcQcleS5Ats0mVYfV6Wd8UpJnM36SvbJ5FyUwVbYfh/s889vMWvt6+k1sn1fUciD3rzVIc4AtfmAXDCN+I5uuECood50Qa41vbqXM22Y8qSJeuYlMVxNvh4LWMj1UXUKJv5whw6a0YcF4Wo4ziDN1yPNXFmn9ECQtn/3yiYX6QdWyH9Jkn8qC7NFvZIux4R/uon/Qro5Nj1OQAy9pw3Tx9vm+3Uim/fEnkdsp885QKWxFQ6GvgEmg==
Received: from SJ0PR05CA0130.namprd05.prod.outlook.com (2603:10b6:a03:33d::15)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 11:38:03 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::a4) by SJ0PR05CA0130.outlook.office365.com
 (2603:10b6:a03:33d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.8 via Frontend Transport; Thu,
 19 Jun 2025 11:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:38:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:37:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:37:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:37:45 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next 5/5] net/mlx5e: Make PCIe congestion event thresholds configurable
Date: Thu, 19 Jun 2025 14:37:21 +0300
Message-ID: <20250619113721.60201-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619113721.60201-1-mbloch@nvidia.com>
References: <20250619113721.60201-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: b32bed53-355f-4247-8d0d-08ddaf25bfb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KthX3GGuTC1gku/XclxF+/nXlrYCkORTpqykF/4+gEfVEGvdc3ht+UOIcCrA?=
 =?us-ascii?Q?ryv0wfw+EUJNSHJV6oAa49TTHokU13xgOSje+8wKFmJEg36HAAjM35vnz4G9?=
 =?us-ascii?Q?qRWkt2DoOArxN5TDrGHHIFcZM7xVSPmiGUQIXD5ZPrzl/KINQ5n+YvdNV+Nn?=
 =?us-ascii?Q?c0MOoSOeJ6Sz+eOaVBwnfPRVi9HXkpONI6Wd+3OW+xQ9NSkh7afuFX5ogH9l?=
 =?us-ascii?Q?Vd/UDrLR2MDY+JeZN7jh3fgS8uoUn84lpfO0DGjwzOxIbtcBK44uNr3EqcQz?=
 =?us-ascii?Q?Tk2ibFhkU//cQt/A3BxwXuM43OysrhQ/9es8lRgkYC9qgDx5Revtk+bWcSSx?=
 =?us-ascii?Q?yXGVpB5Yqri9yDNGkSVysEZr/PPNiDSGFZtHqyJis92QFLJerzBHBhV/bweC?=
 =?us-ascii?Q?3Mm9Ajz8HPvcsqVsWyWiqNtFTs7oShoZIKf7ThUx0LXJFK2i7D1MM+0bBEzo?=
 =?us-ascii?Q?x6kDfS5RiwOoFBpXKix9Qrt3RtfSYH457isUyNISB+51x2nShCbiSF7mnDNG?=
 =?us-ascii?Q?ayapppD5tj3/IFWqQ1dqawhCCoebHFMEQ5zH2Ss9LBJJYcf88iG3xkzbNvoE?=
 =?us-ascii?Q?t6TJMcxXO3Q6pg38cI3OTx3FlEZZsoirL+HybdAxV0dqJg+ZBmzqKv37JMzp?=
 =?us-ascii?Q?bluZ3zVMEQBoeVffEQZvWbXTY+rRv0ci/2ULDLg7Yg2JARayhN05pVlzo1Nr?=
 =?us-ascii?Q?WjAqunwhoPwnR8N+/zDJ+sE6cbeyNrp8mXtojQGPDsIoqxY408bCIHeLB56Y?=
 =?us-ascii?Q?tBbKn+A7Vd955D0uV5IKSK1aajhn/ngLJa6arlhNyB9+q41FMB1P73eqPKgF?=
 =?us-ascii?Q?2uCJ0yi9nALfjGVcl7xpV21S7Q7/41xQ/rZIvv+84pMGAsVwc9yF22MZgtUh?=
 =?us-ascii?Q?CMGO2kzyZiQTzWq8h6RH5nR3UKS2hg/soT/vLSE2e3YEkFBinOR5ZokuV+kB?=
 =?us-ascii?Q?xhy2T0KFOlyLj8IYP+MUrlXRPQTyfSSVw7rAnmxmFHOtL4n+ZhsXIgs/AEIc?=
 =?us-ascii?Q?3jU2pHEv1RxQunKYhvY+83m6tmJEmUIUlhtSuIbNkiQW6QRxKl81WG/nm3VW?=
 =?us-ascii?Q?q1TS22sU+Cp5Sx9QZQ2IuH5tuB1rrUKUbhU/B/q5YZ6ApiESlFXyRpwr6eql?=
 =?us-ascii?Q?LQTVFvncxX1Z7spy+eope3SomMpPXZJ7R1j0QU6BWaMobv59ec7lQsrQ+PxL?=
 =?us-ascii?Q?9RJ5xAxnettkuMY/QkrTkTjxrG8BnuU7foNDvq8NBba/VwGntBL3U1iR1n4x?=
 =?us-ascii?Q?eKDda49WU9qfD1m2dC3RB0VT0W1RstM9RoJrJX6O6bF7XvF1AwOK/f4Hj92f?=
 =?us-ascii?Q?SxR1cC/2+SP9WNFsEtX8ujYvMlKgC/WC9VPLEOV8rEnKpU/Sn7Y63HsCN55O?=
 =?us-ascii?Q?w2PoMu1i6qrSeyrWKssqs2OP9nwAfimTdS2LGR0qKg9tM2wygrp6KUJPSEWD?=
 =?us-ascii?Q?+wzKU2WSn5NQMe0ne4mNBqx/noQ+fRoRIlVAzusQckTnN1x9sKi3QwiKIbba?=
 =?us-ascii?Q?uObNTTSLNtkSMFU5dNwvxBFeG6awO8yS5eCk?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:38:02.0175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b32bed53-355f-4247-8d0d-08ddaf25bfb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323

From: Dragos Tatulea <dtatulea@nvidia.com>

Add a new sysfs entry for reading and configuring the PCIe congestion
event thresholds. The format is the following:
<inbound_low> <inbound_high> <outbound_low> <outbound_high>

Units are 0.01 %. Accepted values are in range (0, 10000].

When new thresholds are configured, a object modify operation will
happen. The set function is updated accordingly to act as a modify
as well.

The threshold configuration is stored and queried directly
in the firmware.

To prevent fat fingering the numbers, read them initially as u64.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/en/pcie_cong_event.c   | 152 +++++++++++++++++-
 1 file changed, 144 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
index a24e5465ceeb..a74d1e15c92e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
@@ -39,9 +39,13 @@ struct mlx5e_pcie_cong_event {
 
 	/* For ethtool stats group. */
 	struct mlx5e_pcie_cong_stats stats;
+
+	struct device_attribute attr;
 };
 
 /* In units of 0.01 % */
+#define MLX5E_PCIE_CONG_THRESH_MAX 10000
+
 static const struct mlx5e_pcie_cong_thresh default_thresh_config = {
 	.inbound_high = 9000,
 	.inbound_low = 7500,
@@ -97,6 +101,7 @@ MLX5E_DEFINE_STATS_GRP(pcie_cong, 0);
 static int
 mlx5_cmd_pcie_cong_event_set(struct mlx5_core_dev *dev,
 			     const struct mlx5e_pcie_cong_thresh *config,
+			     bool modify,
 			     u64 *obj_id)
 {
 	u32 in[MLX5_ST_SZ_DW(pcie_cong_event_cmd_in)] = {};
@@ -108,8 +113,16 @@ mlx5_cmd_pcie_cong_event_set(struct mlx5_core_dev *dev,
 	hdr = MLX5_ADDR_OF(pcie_cong_event_cmd_in, in, hdr);
 	cong_obj = MLX5_ADDR_OF(pcie_cong_event_cmd_in, in, cong_obj);
 
-	MLX5_SET(general_obj_in_cmd_hdr, hdr, opcode,
-		 MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
+	if (!modify) {
+		MLX5_SET(general_obj_in_cmd_hdr, hdr, opcode,
+			 MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
+	} else {
+		MLX5_SET(general_obj_in_cmd_hdr, hdr, opcode,
+			 MLX5_CMD_OP_MODIFY_GENERAL_OBJECT);
+		MLX5_SET(general_obj_in_cmd_hdr, in, obj_id, *obj_id);
+		MLX5_SET64(pcie_cong_event_obj, cong_obj, modify_select_field,
+			   MLX5_PCIE_CONG_EVENT_MOD_THRESH);
+	}
 
 	MLX5_SET(general_obj_in_cmd_hdr, hdr, obj_type,
 		 MLX5_GENERAL_OBJECT_TYPES_PCIE_CONG_EVENT);
@@ -131,10 +144,12 @@ mlx5_cmd_pcie_cong_event_set(struct mlx5_core_dev *dev,
 	if (err)
 		return err;
 
-	*obj_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
+	if (!modify)
+		*obj_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
 
-	mlx5_core_dbg(dev, "PCIe congestion event (obj_id=%llu) created. Config: in: [%u, %u], out: [%u, %u]\n",
+	mlx5_core_dbg(dev, "PCIe congestion event (obj_id=%llu) %s. Config: in: [%u, %u], out: [%u, %u]\n",
 		      *obj_id,
+		      modify ? "modified" : "created",
 		      config->inbound_high, config->inbound_low,
 		      config->outbound_high, config->outbound_low);
 
@@ -160,13 +175,13 @@ static int mlx5_cmd_pcie_cong_event_destroy(struct mlx5_core_dev *dev,
 
 static int mlx5_cmd_pcie_cong_event_query(struct mlx5_core_dev *dev,
 					  u64 obj_id,
-					  u32 *state)
+					  u32 *state,
+					  struct mlx5e_pcie_cong_thresh *config)
 {
 	u32 in[MLX5_ST_SZ_DW(pcie_cong_event_cmd_in)] = {};
 	u32 out[MLX5_ST_SZ_DW(pcie_cong_event_cmd_out)];
 	void *obj;
 	void *hdr;
-	u8 cong;
 	int err;
 
 	hdr = MLX5_ADDR_OF(pcie_cong_event_cmd_in, in, hdr);
@@ -184,6 +199,8 @@ static int mlx5_cmd_pcie_cong_event_query(struct mlx5_core_dev *dev,
 	obj = MLX5_ADDR_OF(pcie_cong_event_cmd_out, out, cong_obj);
 
 	if (state) {
+		u8 cong;
+
 		cong = MLX5_GET(pcie_cong_event_obj, obj, inbound_cong_state);
 		if (cong == MLX5E_CONG_HIGH_STATE)
 			*state |= MLX5E_INBOUND_CONG;
@@ -193,6 +210,19 @@ static int mlx5_cmd_pcie_cong_event_query(struct mlx5_core_dev *dev,
 			*state |= MLX5E_OUTBOUND_CONG;
 	}
 
+	if (config) {
+		*config = (struct mlx5e_pcie_cong_thresh) {
+			.inbound_low = MLX5_GET(pcie_cong_event_obj, obj,
+						inbound_cong_low_threshold),
+			.inbound_high = MLX5_GET(pcie_cong_event_obj, obj,
+						inbound_cong_high_threshold),
+			.outbound_low = MLX5_GET(pcie_cong_event_obj, obj,
+						 outbound_cong_low_threshold),
+			.outbound_high = MLX5_GET(pcie_cong_event_obj, obj,
+						  outbound_cong_high_threshold),
+		};
+	}
+
 	return 0;
 }
 
@@ -210,7 +240,7 @@ static void mlx5e_pcie_cong_event_work(struct work_struct *work)
 	dev = priv->mdev;
 
 	err = mlx5_cmd_pcie_cong_event_query(dev, cong_event->obj_id,
-					     &new_cong_state);
+					     &new_cong_state, NULL);
 	if (err) {
 		mlx5_core_warn(dev, "Error %d when querying PCIe cong event object (obj_id=%llu).\n",
 			       err, cong_event->obj_id);
@@ -249,6 +279,101 @@ static int mlx5e_pcie_cong_event_handler(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static bool mlx5e_thresh_check_val(u64 val)
+{
+	return val > 0 && val <= MLX5E_PCIE_CONG_THRESH_MAX;
+}
+
+static bool
+mlx5e_thresh_config_check_order(const struct mlx5e_pcie_cong_thresh *config)
+{
+	if (config->inbound_high <= config->inbound_low)
+		return false;
+
+	if (config->outbound_high <= config->outbound_low)
+		return false;
+
+	return true;
+}
+
+#define MLX5E_PCIE_CONG_THRESH_SYSFS_VALUES 4
+
+static ssize_t thresh_config_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t count)
+{
+	struct mlx5e_pcie_cong_thresh config = {};
+	struct mlx5e_pcie_cong_event *cong_event;
+	u64 outbound_high, outbound_low;
+	u64 inbound_high, inbound_low;
+	struct mlx5e_priv *priv;
+	int ret;
+	int err;
+
+	cong_event = container_of(attr, struct mlx5e_pcie_cong_event, attr);
+	priv = cong_event->priv;
+
+	ret = sscanf(buf, "%llu %llu %llu %llu",
+		     &inbound_low, &inbound_high,
+		     &outbound_low, &outbound_high);
+	if (ret != MLX5E_PCIE_CONG_THRESH_SYSFS_VALUES) {
+		mlx5_core_err(priv->mdev, "Invalid format for PCIe congestion threshold configuration. Expected %d, got %d.\n",
+			      MLX5E_PCIE_CONG_THRESH_SYSFS_VALUES, ret);
+		return -EINVAL;
+	}
+
+	if (!mlx5e_thresh_check_val(inbound_high) ||
+	    !mlx5e_thresh_check_val(inbound_low) ||
+	    !mlx5e_thresh_check_val(outbound_high) ||
+	    !mlx5e_thresh_check_val(outbound_low)) {
+		mlx5_core_err(priv->mdev, "Invalid values for PCIe congestion threshold configuration. Valid range [1, %d]\n",
+			      MLX5E_PCIE_CONG_THRESH_MAX);
+		return -EINVAL;
+	}
+
+	config = (struct mlx5e_pcie_cong_thresh) {
+		.inbound_low = inbound_low,
+		.inbound_high = inbound_high,
+		.outbound_low = outbound_low,
+		.outbound_high = outbound_high,
+
+	};
+
+	if (!mlx5e_thresh_config_check_order(&config)) {
+		mlx5_core_err(priv->mdev, "Invalid order of values for PCIe congestion threshold configuration.\n");
+		return -EINVAL;
+	}
+
+	err = mlx5_cmd_pcie_cong_event_set(priv->mdev, &config,
+					   true, &cong_event->obj_id);
+
+	return err ? err : count;
+}
+
+static ssize_t thresh_config_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct mlx5e_pcie_cong_event *cong_event;
+	struct mlx5e_pcie_cong_thresh config;
+	struct mlx5e_priv *priv;
+	int err;
+
+	cong_event = container_of(attr, struct mlx5e_pcie_cong_event, attr);
+	priv = cong_event->priv;
+
+	err = mlx5_cmd_pcie_cong_event_query(priv->mdev, cong_event->obj_id,
+					     NULL, &config);
+
+	if (err)
+		return err;
+
+	return sysfs_emit(buf, "%u %u %u %u\n",
+			  config.inbound_low, config.inbound_high,
+			  config.outbound_low, config.outbound_high);
+}
+
 bool mlx5e_pcie_cong_event_supported(struct mlx5_core_dev *dev)
 {
 	u64 features = MLX5_CAP_GEN_2_64(dev, general_obj_types_127_64);
@@ -283,7 +408,7 @@ int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
 	cong_event->priv = priv;
 
 	err = mlx5_cmd_pcie_cong_event_set(mdev, &default_thresh_config,
-					   &cong_event->obj_id);
+					   false, &cong_event->obj_id);
 	if (err) {
 		mlx5_core_warn(mdev, "Error creating a PCIe congestion event object\n");
 		goto err_free;
@@ -295,10 +420,20 @@ int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
 		goto err_obj_destroy;
 	}
 
+	cong_event->attr = (struct device_attribute)__ATTR_RW(thresh_config);
+	err = sysfs_create_file(&mdev->device->kobj,
+				&cong_event->attr.attr);
+	if (err) {
+		mlx5_core_warn(mdev, "Error creating a sysfs entry for pcie_cong limits.\n");
+		goto err_unregister_nb;
+	}
+
 	priv->cong_event = cong_event;
 
 	return 0;
 
+err_unregister_nb:
+	mlx5_eq_notifier_unregister(mdev, &cong_event->nb);
 err_obj_destroy:
 	mlx5_cmd_pcie_cong_event_destroy(mdev, cong_event->obj_id);
 err_free:
@@ -316,6 +451,7 @@ void mlx5e_pcie_cong_event_cleanup(struct mlx5e_priv *priv)
 		return;
 
 	priv->cong_event = NULL;
+	sysfs_remove_file(&mdev->device->kobj, &cong_event->attr.attr);
 
 	mlx5_eq_notifier_unregister(mdev, &cong_event->nb);
 	cancel_work_sync(&cong_event->work);
-- 
2.34.1


