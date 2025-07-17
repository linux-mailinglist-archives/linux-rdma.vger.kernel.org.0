Return-Path: <linux-rdma+bounces-12233-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AB6B08562
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 08:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3B64A418A
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 06:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B9A2185BC;
	Thu, 17 Jul 2025 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ba8Da4+d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD9217733;
	Thu, 17 Jul 2025 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734958; cv=fail; b=OvyccF1+MD6QEhc02cTPrXysqz/QiNkObYiO3MRXHFsenJTnCEX/VxvJIRDk6rivBGsWJot17/mLCTZY2HscG4Ud4AjKUCENfobKmFsXupE63FPF3OzEsKk/PbkeEnPlHSK3JggGDy/4DZfwpL015nKDTj3+PzUK9LKfbjfsxb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734958; c=relaxed/simple;
	bh=ZtoQEyKkSfHk9BxIFnhC2mY8oTWZL6o5fJMtFRTWJIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEoNhrndb83tD7+GoarKJHOU6KEI0ZVr4f/RQ2giB2PwNPYqNemfQ7NXSthZayyl54PrQh0dP20yXBf0AC+8gqASRcOLZ2IfqpNkEWhOaS0Z6P/JR4WbGmeedFf7sEi3L8viTcP18IyV1r3NYWsc4oBdC5za0v4sUX7uYYDut+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ba8Da4+d; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifEZu9aEMJr5DBz1E+7EvC1ogb+XHs87vPWMBMsOjq6S7E9FGLaNcny8IpJ+xiW1T7Cpwmg0ICqhhHCvPksPE6lQN4rTGGWt2c/1Wsj0rnit/Zjxk1U6q4sMWU7htX+UtJt9JBYM3JsFCvxdmqUlrrjT6wsiP9uPKoXv9cUIHPNMegZJR2lruB81naHXD+oCHnGwV4tSZjChmd3U/8do+3Yrsd/5ARHcgM5mPvy0rsGMPFv0fkiXZi2Cc86aBkd6C/RR77nyTcwWECTAYK+N2O8RD6m/5Lq99efFK3c10OnAXBjn2V9RXRT6VwU4/snGnVle0J/pEn4vJZ2CB6H/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZBltW+RQycl3gaWpEFBokJZev/kRDsoVSUGbixcX+g=;
 b=AKrK7d5h5zYV/UF16G9uWXFSzJhCI1vggDNFxmN/u0VkRXpP+lZ+ogilmXHm6+r9Pwh7z94bWe+uk9UoTO6A2t1OGzFa21fMc+nIxng0gEzfYeIlGuDe1NznpYPZI5QgECWV6qTQ0AGkYqm9yzXfj3T3CbxczNjj91t1ooYpM/YDWuPxed4WTWg9lMob4ZnOE8KCvPbSruYe3jP3DBG8/KzHmQ1tkNaEqrkxkGnCK+MoReBeCOYHFpnIkYVEvx7rnSj18RVLTNPZAV/ybAy28woez4PEcZWGnJHz+9wx6MTWlT0zj0q1SR8jwj1JnXDEmHjj8o/15tBKESjXfGRpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZBltW+RQycl3gaWpEFBokJZev/kRDsoVSUGbixcX+g=;
 b=Ba8Da4+dDKcfU6WvksfeihrWOKNH3CG0itkBYSO0DMtXSnFJS+iB9na/MYLawjNAbWeswB6GnWX/PGAQP3FBLFy/428wAUySiGtTdUEkHKVMsB08OX3Ix0blyj0v2/ygMzJdgQs9Cob/KH0jiFjKIFm2eq1TQdoojIqhwjy5r5QuIs8e5K644KHHAfkFPrl3oUPtkZ1F4y7vrZBLoVBmH9dh0rty3ZxRg7JVJ8hfXlPS2gwC8JrdWT47YfXMQybNqu5/AGM+80gvMa9iZL/gxtVJj1pt7TITjmJGMMznQ9z9Nx3Dq4zQNbL5dofWtp3p0p13uP2RFGntogERxv6tOw==
Received: from BYAPR02CA0052.namprd02.prod.outlook.com (2603:10b6:a03:54::29)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 17 Jul
 2025 06:49:10 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::34) by BYAPR02CA0052.outlook.office365.com
 (2603:10b6:a03:54::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 06:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 06:49:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 23:48:50 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 23:48:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 16
 Jul 2025 23:48:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Oren Sidi <osidi@nvidia.com>
Subject: [PATCH mlx5-next 2/3] net/mlx5: Add IFC bits and enums for buf_ownership
Date: Thu, 17 Jul 2025 09:48:14 +0300
Message-ID: <1752734895-257735-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752734895-257735-1-git-send-email-tariqt@nvidia.com>
References: <1752734895-257735-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 86fa5bd6-d500-4f1a-604a-08ddc4fe08ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SfepPHzc3D+T034VX7R/lBH8i469xggiHgI4Sdk60gJBg/09EuWcD+tTxReb?=
 =?us-ascii?Q?LIq21Pw4deQCSWWhsvOLLRDAN+eiXANnRZnZTYI7qT3pYlhNmgp3QcJd7T57?=
 =?us-ascii?Q?5At1NvdSvD76avABIf7EpvlXdtLsLpCZspZca5YWVQhNqtoyzS96IztxNACK?=
 =?us-ascii?Q?wGN2s3Adim7xOW5oXCG3jojI6mjvVj3C5jO29VOF/FiRiGh4W2y0myJ+uy9S?=
 =?us-ascii?Q?z7IBGSmM2LfB/4B8w4N0He+fqglkIah5ni073aDsX2Q+CpIf1qbYZxnLSgRC?=
 =?us-ascii?Q?Xt/q1zR39IAzHlJo/B+QG9oZzp62FeCwe/m00fR9LbJPEPX6KznJApMTmPS5?=
 =?us-ascii?Q?T/otolWBEj/J5sx1DkGnlRe/XYSqxmHLhO/cGQEDobzPyOilLxf6LEx0MJWP?=
 =?us-ascii?Q?5uj6kg5J9B2uXBao3oyo22aNy56mos6zn43YcfXdZuP8zD0uUdng1EoAnbjU?=
 =?us-ascii?Q?lyHgPtw90BFyUwr6TPlZF3NP8+J+7AzJDJ+XbRv+eMeQsVcPVH8BjGYLPQCv?=
 =?us-ascii?Q?3X0bLeukaJjCK3ex1Le9o7ETgzIfteh5W2H11MwpvXgcNvUGVncqJhF7NdGh?=
 =?us-ascii?Q?wHMb3xeI6kHyh5xgNUXgqAtHcBf6LnAJG7O908mkamVcRT3X6LtsS0MeDMIV?=
 =?us-ascii?Q?g0xpuId+FVRYeJP9BUOzvWzhGFEQ2TOgkL5OzFKqX/nBYe6rBUV8YephaO0+?=
 =?us-ascii?Q?aJncsLBYpFo/as4TgXzH/hVp947QWVuMvq11eVO5soMO7w2vp0BVsmCWYoVV?=
 =?us-ascii?Q?RGoRLn/gw7waqBUlciMaI61pAj0wcQrMHH7HZwCaA53cwQLxanKcFU+wc2Qm?=
 =?us-ascii?Q?h9ACLE15uff1Ry0JDO9xGAJvkTo+sCd2GGlVfZFmUfGFRB7OReNSsSn+xgTn?=
 =?us-ascii?Q?o/d3ueweR+/DQunjAxZLpgyCDHl5LtcHl2p1t6mhWa+ypchafULLch4mZ/Rk?=
 =?us-ascii?Q?1CWoxbo44zREJ+rGGcDj53XLor1tdJc/sCKrEQW9l7K3bBzO4xIdg31qWUP3?=
 =?us-ascii?Q?IU9s8avsbrbH1oyDxbQLnCq68CZtldXI/9k5PDi98PsjLXw/JkJTLamgEjL1?=
 =?us-ascii?Q?VevOv83lPzLcF23QALRe66xfNHYWyntsirdnhZkCBiAQMKS7q5kYxVNiIZLx?=
 =?us-ascii?Q?96/RTQLlh+xu9E9vNEr0G1K27H9bRao7HPeO/W7uc1qRI+mezB/jlIjFXLUo?=
 =?us-ascii?Q?Tjfze8ljTLKQCwuB9D7P5pfAMCnLZS2iQa7m+/oNiifEqSHBJCrxDVnjGQ0r?=
 =?us-ascii?Q?laxG/lghVrRQp1oWAjh19Gg7UoFS6XCBQDWLsBJrQijvlPJ9h8CXgEsGuyUc?=
 =?us-ascii?Q?Sus0rFaMg9IqqlmPxYRm1/knQStQDlOzABAcs++at39WEb89iJHum7C+4Sc5?=
 =?us-ascii?Q?hNAykeTqnRcjSIV9r2tjaljm5ZRiCtk8r8TTIvU3qnjOMCQu8s+LvduEIuri?=
 =?us-ascii?Q?zzcLL6JJSBJs6Swd+Qd3ynwGfJjQTj56cITCO/1t50J4nRcw1Jd97oTHmMeb?=
 =?us-ascii?Q?kqXSzpwiHu22Y+ydJpl6raURmervTthibXru?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:49:10.1498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fa5bd6-d500-4f1a-604a-08ddc4fe08ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323

From: Oren Sidi <osidi@nvidia.com>

Extend structure layouts and defines buf_ownership.
buf_ownership indicates whether the buffer is managed by SW or FW.

Signed-off-by: Oren Sidi <osidi@nvidia.com>
Reviewed-by: Alex Lazar <alazar@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index c9a7773ac8ec..e1220aa1e7dc 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10474,8 +10474,16 @@ struct mlx5_ifc_pifr_reg_bits {
 	u8         port_filter_update_en[8][0x20];
 };
 
+enum {
+	MLX5_BUF_OWNERSHIP_UNKNOWN	= 0x0,
+	MLX5_BUF_OWNERSHIP_FW_OWNED	= 0x1,
+	MLX5_BUF_OWNERSHIP_SW_OWNED	= 0x2,
+};
+
 struct mlx5_ifc_pfcc_reg_bits {
-	u8         reserved_at_0[0x8];
+	u8         reserved_at_0[0x4];
+	u8	   buf_ownership[0x2];
+	u8	   reserved_at_6[0x2];
 	u8         local_port[0x8];
 	u8         reserved_at_10[0xb];
 	u8         ppan_mask_n[0x1];
@@ -10611,7 +10619,9 @@ struct mlx5_ifc_pcam_enhanced_features_bits {
 	u8         fec_200G_per_lane_in_pplm[0x1];
 	u8         reserved_at_1e[0x2a];
 	u8         fec_100G_per_lane_in_pplm[0x1];
-	u8         reserved_at_49[0x1f];
+	u8         reserved_at_49[0xa];
+	u8	   buffer_ownership[0x1];
+	u8	   resereved_at_54[0x14];
 	u8         fec_50G_per_lane_in_pplm[0x1];
 	u8         reserved_at_69[0x4];
 	u8         rx_icrc_encapsulated_counter[0x1];
-- 
2.31.1


