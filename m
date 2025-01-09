Return-Path: <linux-rdma+bounces-6941-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFBBA08182
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 21:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E1D188C82B
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 20:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF26E1FECA5;
	Thu,  9 Jan 2025 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BchqVN05"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8C2F43;
	Thu,  9 Jan 2025 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455446; cv=fail; b=LxkI7uANPOsaPmUraiMxam9TmwVgKIh1lVi2g0yRM5zpnxZW/EENjifDQhgJUqQeC0hU11Zs7KNV6X31XlsK4a6oiViBlzlvhoxIyazW9XGXeqlwllE0ctA7nw6Xt/RSuGlFKpvtcXbbEtE9Dj/Ljiy4z873QeMFJDlgF8kIcx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455446; c=relaxed/simple;
	bh=abtRGbDQVI0NVRDVxAdmeVKeN8iBbi+9m27rUXNgU5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqerUD6c7ctMy/FTs5s/e8N22OCjRoQd/bRq0vz2nYSVJgrCNyJYuXQB5EDGhieqJLqAH7FCkWdfxHwViM2euPGVykx8Bo8P7sbmVvWWR7/QP35eXayEvf2YRJefxB2pTv61zS3TraaifOHTtGnUPGB44QKOUd0Z14tj0rYHoV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BchqVN05; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6M+K0NlFDENpxSa7ZPNOzO9ByL9xvfHHMIpvXT1+9vikFXbQXwzhH1bnPoDKXTRDjLaObkslMn0F6AtBI5Wvz1ZOPB+8X6ADG6UnvT3PIz0DT+TxYX9LCI6pvgOY7RqHvktxNPeJ6VHvfHrgeO8qqMs+8Je04SIPDfHluT8n+BbfzL67OJV4nxaewTWRjdufndOZMBYNUtebv5TFsWPZBl32GECRk3VEW0y/xLWb1MuM/pCMu+VS7P+HZPK6JgmGUX+oG0IFvpQSdwBAt4LKk3F3TO+4M4RU17WVlF3wN1hfXcqb7AVsZAhk94ralrOsfkU7iXxyi1OCri+3E14Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Anoryq1EifvTlVdMg43ZeDiDQzuO1bNLbIqe7KPxXs=;
 b=uir5h6F3PxqJBU/lObs9AKv/v5nYK++X+s8To7HoXsX+ufojEsFWsEslBuGCujgMRA51XiFGCy+xG8IvL559BlwqnKZIeOydpsx9yOg2OJTbKsxJOEUKfis1Yg0TH8oFdCxrQ4R3xQl4jCawvSJg5LkQB4VkL28iSTsj8Lb2Sor4tv7mlmP0hG+KMXYqnRAxG1nwh/FSffn8P2eubJ1d0D3i26KMackNAOf+uWtVeYr9AI8xLLAzDmdQeft+lgZk0go6Phow4E5xNPjCUj4Hkb+6HgW6Kx4eY1Ef3o+Z9LWoT4PtX0fA58JOOlD2+mFikQ4kgOJ4ayYRX15OTCthkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Anoryq1EifvTlVdMg43ZeDiDQzuO1bNLbIqe7KPxXs=;
 b=BchqVN05W09bzCbLnB+1qKEjIA7Og+GnhG+AQGnbHS8pwWHWg0gLpglHvZzcq1lpS2hOQIw/Pf+xaJS/9OtAf9A00H0dvsMGPXfPDDdP3y426+nN9RGhicO8O4LXPmlUHgxaRo0gT7h5VFP6zGW9JadZHw3xT0gH0YBTZ6jr1jqIyLNrq7loTCpZXYgEGyaUb0vVjNX5mYvU/KZMTGc3tnlp5ohBK3RykHPYeOh3C3is8cqaJ6WasxU0H4u1jYtMbk8UpWhWv+R6uoifeOc0XIw4PVqogrIVxu3NC2c72EQVgN729f6XMhM0ZaYm7dsdXQIZizVvLs1bLfbfVkmbRQ==
Received: from BN9PR03CA0479.namprd03.prod.outlook.com (2603:10b6:408:139::34)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 20:44:01 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::87) by BN9PR03CA0479.outlook.office365.com
 (2603:10b6:408:139::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 20:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 20:44:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 12:43:51 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 Jan 2025 12:43:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 9 Jan 2025 12:43:48 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH mlx5-next 2/4] net/mlx5: Add support for MRTCQ register
Date: Thu, 9 Jan 2025 22:42:29 +0200
Message-ID: <20250109204231.1809851-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250109204231.1809851-1-tariqt@nvidia.com>
References: <20250109204231.1809851-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 369d0e2a-2b91-4f62-abf7-08dd30ee5927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZFO6JxcUly0w2e9Aj5Ln2/0E1em515sdbwvGzg4E2X4ApAI+SyP1Mp0NIg/S?=
 =?us-ascii?Q?uAe5lUPLlwKyWHp8a4MlwOQW/jAK5/j+lQcPYpAUejy5Ft+WRw2YPyX/huby?=
 =?us-ascii?Q?Hh8PLjgTldbDuSk9DB2PBQAgngx3ozXdC0EkW3J6NCENhUZGAFc0vxKBqyn8?=
 =?us-ascii?Q?3ldnjhJVsKIY81fsnuzH9V0cnvSz+NByBVP0+ILBfkBHqZ5KGQM0CBKTVug4?=
 =?us-ascii?Q?1jfvWYjhgwduQ7a0oULHP90VI6Bk1l2/l1c7eHfvLAp/1qVOF7G+f/82Xh1y?=
 =?us-ascii?Q?y25J3awAcWa0pG26Q4Big1A2QCQl0EXPiBjtSwmAz5W/yk6ElaqSn/S30IX8?=
 =?us-ascii?Q?pSRTARRGnkt0OsURcB1Kl5dexxqYjDsudZigC9FhSg/YcDir/gGKw5xP01wP?=
 =?us-ascii?Q?QQJnCORwFavBt2G8/1g/lyjgbdJA55feCHivTI5+QuUrVYRYe2/3VEGeEZVj?=
 =?us-ascii?Q?vV2wTO17sHNvu5QyTX9n1aRgGoykEPCARSD8OpxOlTeyFgGDWBCeDkWbyv0l?=
 =?us-ascii?Q?DqiLygK4NBq211ahWgNjo5DNJ8ZV0ByigUaaCOsSE8AyPOS4SUSX+xsKK5SZ?=
 =?us-ascii?Q?v40UwgUSjc9KV0ZwYtCA7myRAwQMdu7XW40IujjiPoT74k0GyY3kzoMmSHyT?=
 =?us-ascii?Q?U1qGDaJdkAuj60/Tiij837C1AYLgCK1FXMy64/HshsUC6t6rHyvTiAuW9pza?=
 =?us-ascii?Q?yHM4izA/DCfTFf3+UwmIh+uxWCmO8mY415Swbogf+WKRYk2c9JWHYiYW+Ebb?=
 =?us-ascii?Q?2/E5tI1H6DY9cDrRUsjDaiHZq6QnmD60CzmxJHUVXfq9AYUlllVS8U4B02vJ?=
 =?us-ascii?Q?4GKb3PcAfblCxm3UzPiNgJ3SLqm+Gi9Qk5BuiRFYN0GQINaJH/jXX2ydhGk3?=
 =?us-ascii?Q?6xnQXiHEDlP7auFtF7GrhXpA1vtz1cr5vVstVpLSuEy2kkSvZin0osHIYe70?=
 =?us-ascii?Q?5g6V3HAUf/9f7V765cxmeSIYbs98J5CKZFIs20gq3s/Mi3cu4aKtjieMGnaf?=
 =?us-ascii?Q?pZrXoMT0tvQzM0+wkzqw55KhQf4KpWxQyQ6wUcpLdOJoz5n9r12F0A5qfLa4?=
 =?us-ascii?Q?togEYNX6kn4terqa9GjaZUMdnxI/uUpnKIZo3Z1rGRhzd5DSVMEt1ijJE8fp?=
 =?us-ascii?Q?ZSDhHDKNpXVmU0VtHKPNj/77x2kj87iWmOoveaibYhenrh0wmZaH3rrik0N/?=
 =?us-ascii?Q?RXaSLcLS/MLmiy13FbyooLzcpWSbzxQL8LYIRFjGMQ3mjAt19avcv67kY2o3?=
 =?us-ascii?Q?jFadPrYTsq0SrLugGJslIlxackvHBho9iDf7MHd/dF0Ddyo7g5WbdY2Ehz5w?=
 =?us-ascii?Q?wdlerC7VBCTm7hmryCcw3+/VcnKIsVI4nkmloRME1neq47FPl5i7qbx9Uueo?=
 =?us-ascii?Q?tl9t7U8Jzb/BwUZLGKLCDwYPcx1p2AzE3tKj8UDNxlq4yUkKEHMsc4IeG/1y?=
 =?us-ascii?Q?h2FBtgksqYvJfBcpFqWybHlEP1nWp3Gkw5ncAalAhExPf6xsnQkYhmc4J2mz?=
 =?us-ascii?Q?ddaBuGIIS3OTIAc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 20:44:01.0569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 369d0e2a-2b91-4f62-abf7-08dd30ee5927
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195

From: Jianbo Liu <jianbol@nvidia.com>

Management Real Time Clock Query (MRTCQ) register is used to query
hardware clock identity.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/driver.h   |  1 +
 include/linux/mlx5/mlx5_ifc.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index fc7e6153b73d..8f6fe29bc4be 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -160,6 +160,7 @@ enum {
 	MLX5_REG_MIRC		 = 0x9162,
 	MLX5_REG_MTPTM		 = 0x9180,
 	MLX5_REG_MTCTR		 = 0x9181,
+	MLX5_REG_MRTCQ		 = 0x9182,
 	MLX5_REG_SBCAM		 = 0xB01F,
 	MLX5_REG_RESOURCE_DUMP   = 0xC000,
 	MLX5_REG_DTOR            = 0xC00E,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index c3da1581853c..221146278ac8 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10680,7 +10680,8 @@ struct mlx5_ifc_mcam_access_reg_bits3 {
 
 	u8         regs_63_to_32[0x20];
 
-	u8         regs_31_to_2[0x1e];
+	u8         regs_31_to_3[0x1d];
+	u8         mrtcq[0x1];
 	u8         mtctr[0x1];
 	u8         mtptm[0x1];
 };
@@ -13171,4 +13172,12 @@ struct mlx5_ifc_msees_reg_bits {
 	u8         reserved_at_80[0x180];
 };
 
+struct mlx5_ifc_mrtcq_reg_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         rt_clock_identity[0x40];
+
+	u8         reserved_at_80[0x180];
+};
+
 #endif /* MLX5_IFC_H */
-- 
2.45.0


