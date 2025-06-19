Return-Path: <linux-rdma+bounces-11450-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5413AE03FC
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD3817B41E
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDD823771C;
	Thu, 19 Jun 2025 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MLQhP5kU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624322FE02;
	Thu, 19 Jun 2025 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333069; cv=fail; b=izb6reOJjYeOnxKTWC9BmBn2u1x+7B2Xf295CG8sEM4EfyjMz1zcA7eG9U97VCZhxTiKeZpFazkT/aey2X3CB5bSGedb2Wcxw6ag6gVJfOGlDQgdekTr3XttqDVe11oc632WJ2sZgBVQDVZcqHX/BcHaa0xXOoQMYAz6san1j3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333069; c=relaxed/simple;
	bh=Z95TPb9PRFN6Vdu7kG+TIojHGktb5kF6ijGqEWNlmi4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0MU63hqf8oXV+4TzzB5hRC4FK1v88uJnPgpy1XGZTtYsgSWWrn7SnP0s3mdkSAPDWRgPZNP5/TFYbQ6/I17I9jGmzIHnMFhGFnsYYPBlMpwfkXbH8OvXzOwPFrJynXk6b0wSHHzdwNQlz9MFfR4Dy4X+pDxXs5fLHfRfHDntrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MLQhP5kU; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDhx9sxI/Z751smcu5ZPHzGGMC42AnmJv79HC9ch5en+PQ65r/UZSsfa+IUOPT8AdRHDag0PjqjCpbJHUUD0H/fBwpobCIQr9vW6kbxx/P9/yH9l1AucCPA66cUmn3HMZIVO3y/bbymz1/llMlHYxVL6xZZdi0aJucCuVDKQcF4iDGMiSd2fjmQzqpwawe1S5Lw88SfaJIIvrIHLmae4MnffcZGdcgHVlFKyDoDMxfBc8KO+z6rQFm22YSyLTLa8+LM3hHGQWjQZJN8Yrpx0vVVRpbAQo+7Q+4hViJJpndy3h2IdsGkBtfbS86hrlrcpqksbXrP0gXmPc4wQuNDx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGMbsJQc2tZS9ACKiFpq7/FrBhMZOAgT3zvUuXRBgAc=;
 b=DLBhBdHvifanhzY0afHE4eTW/nqHSGoxSNqUOabRFhmVHSWWfOnOXlNcJAShbbqB3R/rNzZvD6aou27Q3T5xOAfmk+LVpxQWxTiAWXoXgcWPPNj/SWwKtZgO6ZB8yh1Sz9s5iISO9UkjEOza0ezcN+8gX/TgvuxpOZzVvTQzHTNBI6rf4LjNAL7EMgp99e3NaRbCDI/WjurEjvIiy6Tw17qSOxsu65FB2ret06PWGNgLRDuUTX6WNPzTNZJLExSu7zsGr0KO9Nk1Hs+Bh00Bea0v7xdpxkVx8s64z0DHbxAgtXCNpC7gQ9rBfE2TN+Q2uZeoA2mkXuXt2AgHg7fjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGMbsJQc2tZS9ACKiFpq7/FrBhMZOAgT3zvUuXRBgAc=;
 b=MLQhP5kU8qY8BCazykBtkTrG4QgSTho3CkY1uPP5f/0Zs6AqyV3z1WEb7pDJ9n6v9bflyU2Jy6IF6rlEgX3EpOZ5E21qmh/W2TPNVmvuhUpsy9q/CP2xb7kWY4GcoQGxYBJF0KX45WkLm2AfO/vRC1RGP6CiLP0xBKxpWoFMSxlN84Q9cqNQkJy6kW8j4DIcSN0Sc5UMYj2Dv9U7IINp1RZdjo3lUn08u8VEd2lgj93HcqPDK8mkWpkncuY9zkAU8PPlYVAJdgQl9CuNpmhrzJPc8yCW2/4IXhonlwke/EqW7JcRHodDGQO/VaqAkH5yq+2bJ2wPlyVPol1LD4vhNQ==
Received: from DM6PR06CA0097.namprd06.prod.outlook.com (2603:10b6:5:336::30)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 11:37:43 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::1c) by DM6PR06CA0097.outlook.office365.com
 (2603:10b6:5:336::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.34 via Frontend Transport; Thu,
 19 Jun 2025 11:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:37:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:37:32 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:37:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:37:27 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH mlx5-next 1/5] net/mlx5: Small refactor for general object capabilities
Date: Thu, 19 Jun 2025 14:37:17 +0300
Message-ID: <20250619113721.60201-2-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbc9873-2762-4ab8-9489-08ddaf25b442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/u/ZckQSR9IdGEVrYVR+TSRtXA0iaASeOxsd7KjvEgXMfRL6ivFcZXf//Vzs?=
 =?us-ascii?Q?otTvcgpg2FiCEQnnr4jpUHm44N326baZMa/1q6+Y0Om51pBiG5AJsK8Qd/5f?=
 =?us-ascii?Q?Gy9bttOar4I1fOOkAoE/aA4mXrfL6LR9y46bfkAHO8F1+j++CY10K7ME8u6k?=
 =?us-ascii?Q?qYWQqRrusIrPYyxnTSCbSritozGGkr8WwnAlrBHiqvzABobGT7PrdFDz815y?=
 =?us-ascii?Q?+nxOjC0ccF7/PMSn6JFETTZ4SheTyaCJQqGYT2S4Ju/to4oyBILJb1kbeBsK?=
 =?us-ascii?Q?Bh4OgVRAQ2Hje+09eQmg+1Av4KDY+HsrwE81ICgP0Co67hRaxLjFaY0WWWW/?=
 =?us-ascii?Q?cBVXDkLGCqzxm0FwgLIfW9J6X1gy61lXBz57kcB+XGLisl1POGYCLuRlGj8n?=
 =?us-ascii?Q?YTlk1BUtaNy2gO9mSbLsMADfOliQgrirJ4PLHlmyKi1R30W2sp+hu/PpOo1d?=
 =?us-ascii?Q?mX8lDHIIPXnCWSfJoEn2gkLWvwB/ikmV311MUBGi27RazVeiLKRUKgKxtII1?=
 =?us-ascii?Q?i2mxTPjr7TgE9rbKQpdPyUMTIw9fk7FgZgo7wj9tNp3eswxD7mqUwW0Am+xB?=
 =?us-ascii?Q?ebW2F7Sk1BUE1inJI2k3DXg25CZgMR3KeO0kJAyv70tjy/AcqxWRPKi4WcWi?=
 =?us-ascii?Q?wrLF4mMYiJ+E6Sy4oWx/oTu5Qrg+ccgy4Ny5Nhrd5iX3IbXAXvuNM/bscb8v?=
 =?us-ascii?Q?v+SY9Yumoh5BvWmvy5ejK9dDUYERknPSERgAniH/eyt/+zWbqKEVS/nyVuVs?=
 =?us-ascii?Q?JggVHge1meo9/TB2hVmDT8bSfu/tOdfdJY4US6xwH/ACyIqjrhPs8vFMffzE?=
 =?us-ascii?Q?rY6+PBKvzDh8FWDQD78Xbi7DJ1qeKBY+esykprMVGHx1iPBh7LSqYJD1hl8O?=
 =?us-ascii?Q?rhTuucJq13qS7lNcZX3kljKeBq8ylqcQRKtXrh/4sl1jjZgfF4gA88cqdvJE?=
 =?us-ascii?Q?ZnhBt37jgf024RUBnEUHzeR6XoJCHLEVw2aq9yG+JoZNAB8e3CW+kCZMaLjz?=
 =?us-ascii?Q?zhKKjQ5090eK3zPNBEPKdEk47UayKR2KfzRCLr5CRi5aDUTsl4bQ3W7arFPF?=
 =?us-ascii?Q?p2ZFjlALXzou+vP3euy8VqvS0xlJWY1s6WYZqS8A8vL+amlBTocXWfh7+QbA?=
 =?us-ascii?Q?wu34tyIOaJm03t73dHw7OyqZh4yXz9WsK3D7MJVAMghMa7wIBVmKElxlwVjg?=
 =?us-ascii?Q?W7cMF/LxgnNTx6aFrj6vFsTj4g8yZNfRDyfL8/u8nWD7oGl67BKOofy+Xr53?=
 =?us-ascii?Q?JOIKJUmtYnBin9cY+hSm/fnNHzujzlhNhfbVUFeZdm7LKUo/MbM5mlo+QdPl?=
 =?us-ascii?Q?E4HAxvz5ADA+vzh5Q1hPvJI3m/nbKdt6rum2ilIuyyQZUEkyug5JAXpYBl5K?=
 =?us-ascii?Q?Abup+Eu07ZWStmzVnTFgSEAQXAvLjxqwDYPZiQl1YOmlNrMRwGN655o4tNBE?=
 =?us-ascii?Q?JFC2k3WWD6p85bDH9YcPvgISK4wM4Ax3OSQYcbEG1nBy3+8tbzKxsGF9KTTA?=
 =?us-ascii?Q?9I6Gl8s9CwqsjuP54JgpV1v4HB7wD8o9Z5Dt?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:37:42.8207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbc9873-2762-4ab8-9489-08ddaf25b442
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744

From: Dragos Tatulea <dtatulea@nvidia.com>

Make enum for capability bits of general object types depend on
the type definitions themselves.

Make sure that capabilities in the [64,127] bit range are
properly calculated (type id - 64).

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 2c09df4ee574..5c8f75605eac 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -12501,17 +12501,6 @@ struct mlx5_ifc_affiliated_event_header_bits {
 	u8         obj_id[0x20];
 };
 
-enum {
-	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
-	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
-	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
-	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
-};
-
-enum {
-	MLX5_HCA_CAP_2_GENERAL_OBJECT_TYPES_RDMA_CTRL = BIT_ULL(0x13),
-};
-
 enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
@@ -12523,6 +12512,22 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS = 0xff15,
 };
 
+enum {
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY =
+		BIT_ULL(MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC =
+		BIT_ULL(MLX5_GENERAL_OBJECT_TYPES_IPSEC),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER =
+		BIT_ULL(MLX5_GENERAL_OBJECT_TYPES_SAMPLER),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO =
+		BIT_ULL(MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO),
+};
+
+enum {
+	MLX5_HCA_CAP_2_GENERAL_OBJECT_TYPES_RDMA_CTRL =
+		BIT_ULL(MLX5_GENERAL_OBJECT_TYPES_RDMA_CTRL - 0x40),
+};
+
 enum {
 	MLX5_IPSEC_OBJECT_ICV_LEN_16B,
 };
-- 
2.34.1


