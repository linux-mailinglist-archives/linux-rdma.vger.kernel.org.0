Return-Path: <linux-rdma+bounces-8549-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06643A5A6A5
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 23:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47B31739B8
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 22:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C47A1E885A;
	Mon, 10 Mar 2025 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FC28WVsa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B31E5B62;
	Mon, 10 Mar 2025 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644181; cv=fail; b=c2TdQxL83IWaQiaQQHGm7CmnC5SNy+KyAkyV+swUkOgnj+FHOBL9BA/43IPvkrANHLrIVFqs2IkNRbZDyzdkD+54g+5pHeM5LvojSKsLalMdiC4CGnyRgiLluBK9+FQOjXhJhRxN8M5buPgU5dH5XyW9BCzXw3ToVl0J3wiShE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644181; c=relaxed/simple;
	bh=26eUROg4aW8Cz5bjQL5gl4cAYHqL9VICCJ+fnHM628M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBfEUD2yLZTE6PryVQ5e+H71vIRzqIaYiztzn9bway4+CIAH+3UJ8tkkXjvIAkyeMC/S9OLTx4PjQqpAS+oCElJRZax4/3Vu4qfqzRn0Mxg2qetuubn93aA/UZZrM/QSeuHKUPjbgtT16xB/6r01CrFw0Phj3zbE96ZI7j1KC/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FC28WVsa; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIKK11b1so2stvzewhvDejCNXTIpbxw0vyB0F+hxCPL+Y7bOCPqEEdafx1x9K4j9Ukf3uhlgh3vLciWzQe/dEmJruyOqcBX+SfrykwYgW6KR3mOpYXTxXVDVGF2M3GZl0RpvbXdw01PbgMK/X1orkIvqhMOT+zpVDjcIAOmg8AwNOPW96U2+//RPQ6QcL6gEESkp/U+El+e5qWI23NeFqooCbRJ8wl4wIPVps63DHsS7SY4lXQcTxgHyTHEOQg4kEM22RM8vHk6DHkjplwhcdfVtatHBTl6FL+IimdGAPkt3u8mLJDdlbEIaoSwGFJhuIRTPLrxrRufUqYFQPmO2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoTN48Px4IkZxWCF61gk+zmpIPcXLa9R0FiiFeKp1m8=;
 b=mRgZHrIyQK3zPxaqpDN1Luw/s6IY+Le4bOyrJevrhEYJAlUp5BMDdjc5fyYU28N0HXdCejNixbyZ1Wzp1fTqdX8EEpVTMulEWwyfv5b/lB2FcOQ4ObX/FXzz0UOAWmXGnRRhZqIDeYSE8wCugORKRtvXssiLE78VjfIQ1fFQhGzamWGA2EzsteJ6W/DLuz+YUGEC8K9EEns3NOdyzzcxum+3uGZPBmZwGq8fsEj61rvwFLconY7SWZl0hCI0zIdXow8qhB9h3ZFNrIDZ+PMxJn/PLIQXF593UbmFCiE4K3Jh+w8bAGf7ceMSFDgc7+J5edr60C4MyJnXkHRMMIA55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoTN48Px4IkZxWCF61gk+zmpIPcXLa9R0FiiFeKp1m8=;
 b=FC28WVsaQ60wtb9/llFHyrt3rvq7tb/oHYLCnQkt3KsO2JSCom1Zd06hte8PtJxlBHKky4j+6wfX6WFd0jCceuXpkNFd5rv9WAYBqmk+EbOziXJdoUswh1QtWmYCTCfMEkxrNR7OLbK3WW1/L1RmaXgAHDqnk0z1/te+1ffB01p7yXJ+Kcweabgg/79s6y5eYagdd3j8VbIqjwt1v7KCN7R4z+LQ6KEsda+QRULJpww/JpB+GrL1lxaVPQ7R2LIIrczWWg1YD6YoNzSVvmJhcV24FgHFbK/G1GPrM4wUE0L8PRDcSI9uY4KJnUDI3XDIXDmeh5r/dqxc416Q3YX7rw==
Received: from SA0PR11CA0201.namprd11.prod.outlook.com (2603:10b6:806:1bc::26)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 10 Mar
 2025 22:02:57 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::9b) by SA0PR11CA0201.outlook.office365.com
 (2603:10b6:806:1bc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 22:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 22:02:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 15:02:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 15:02:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Mar 2025 15:02:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vlad Dogaru <vdogaru@nvidia.com>
Subject: [PATCH net 2/6] net/mlx5: HWS, Rightsize bwc matcher priority
Date: Tue, 11 Mar 2025 00:01:40 +0200
Message-ID: <1741644104-97767-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: e97da4ee-9137-4593-1c07-08dd601f502c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?usCLOtPs508vh/GEcjusjOsniFOIxqMf/l522+LR16jlfgA4WIaunkcP7GUw?=
 =?us-ascii?Q?uEIa+4FeNCn0Ddm2q7oT3LwKKp3Nu9u/Td6Sycuh2X21AKLzOhgrtoJVM6r9?=
 =?us-ascii?Q?jbErwj4k2HBqUniXNoRacj8uCQ+e3fVr3pfqu237zf4sm/IBUIkjVgaycuA/?=
 =?us-ascii?Q?gP+bmbxWPQ6MCfWzIDg1vsA71a8N2Hcxl9bbdzmWL2UqcGs24S6G5HVZg9SU?=
 =?us-ascii?Q?ddmOvg3kPw3ViiuGBt9kB/COE2zvJmdMeODemHdZ1W1W2wGeEJBqAhuHvGTM?=
 =?us-ascii?Q?QZS2UPYRiBGrfh9/cYDYwNr2OS1UxTgoX5jR+z7yfsvhMlS9McWHqp750d6O?=
 =?us-ascii?Q?RGAwnRa79XTN5qOXEmx4etR2HwlGVftg//cTfDvm/l8idawH7DfZe8llzzK5?=
 =?us-ascii?Q?9EDwXT6bs67bJ+TQuiaL46F2FeG+BU34KMDDz+fDq/F+/O9BJ5BdRd/LGc5N?=
 =?us-ascii?Q?h6LBqjXw5MaxV2MV7EtZsDVI4UKhjqICVqWsxUOLPMnWP3GUDZn+CxKP6HLi?=
 =?us-ascii?Q?Hb6thAZiuew8IVQjtb2bQYEa/OiY/bGQLoVC2gQtWKAVFcY7/aASgQDQch3v?=
 =?us-ascii?Q?d13+3soDRng2QfnbBL1j3dQF7A81Mjy1Tb76mpmRMl7j9QbD/LQxViFwZvSO?=
 =?us-ascii?Q?OwvByGHiIGNSGhskshDlQO6xfTYmeYlmp1efBvf+ksB3NufQlsyErLCdDyPh?=
 =?us-ascii?Q?cpI/ruLaR7g9CYhz1bPDfEz1N6Db0Gho96KHRjKjnM0crvD82PM6Lumv9agl?=
 =?us-ascii?Q?AaFwQPE3InHE/h5hckdCQe2gw2PjeLsQIWuSQChLhCMRBhXtFzNeR8PR45Zq?=
 =?us-ascii?Q?0+hfBRV2gs6HRPex+eaM8/sA96FBVjv3e2bISbxQ8tpbPDrIp8rmSXDf38b1?=
 =?us-ascii?Q?S+2DHiUQ+EdscbSpJ9miBCnEr710YmZkO2oWosM98sYaiSp7uCvX7+hhsmNF?=
 =?us-ascii?Q?WUYctdfgG1nqM7GeokdIQA/2DVRJ9ZehRoqOlOdXuL4rCuwlgCzkY5ySc5M2?=
 =?us-ascii?Q?GvJXX+iUT803R9TtirlFCTCQTAFmpkx2J5+CKAG/GlJ53omn4uwordul6hau?=
 =?us-ascii?Q?RLP6t7LMH149PvQiMQGetv9N39GRmSG5JuhnHmoMOJLKMPFdhDpyjWYJQEy1?=
 =?us-ascii?Q?ecd6cXVRFgZIYRx7XQC3XmjPXceOxC2Xvyz7pvAVsH4en+XMI6pE+PZtauIL?=
 =?us-ascii?Q?rjJNZQy+DVfFoW9RHC1uw35yWnu9PGmQ6jzJE0NKn5/BV4tqyEBucR+hN0Co?=
 =?us-ascii?Q?1rZU67xAk38SXGwraKrZ5QIRbYAml9j//eix7UTwjPL0OaWUfSgPiCYQO3lV?=
 =?us-ascii?Q?wwmwA6SjfPOjDo9sgUalc+1LEOOESe0Rw1uDXFbX4f7ulfVjDys3pAbRjSuz?=
 =?us-ascii?Q?IhkeUbogNoYuk+dalsIx9X9yriCEOW0q5WZLzlW16kP70MBFAjUv7414hmht?=
 =?us-ascii?Q?sXMKSMGs1KQMF+6n8g9RRlMLu5TUiSABbCaDrNW8MrWIq8oIKYo/MWxA0Htp?=
 =?us-ascii?Q?OI4gEVRsI39b744=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 22:02:56.0392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97da4ee-9137-4593-1c07-08dd601f502c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

From: Vlad Dogaru <vdogaru@nvidia.com>

The bwc layer was clamping the matcher priority from 32 bits to 16 bits.
This didn't show up until a matcher was resized, since the initial
native matcher was created using the correct 32 bit value.

The fix also reorders fields to avoid some padding.

Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index f9f569131dde..47f7ed141553 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -24,8 +24,8 @@ struct mlx5hws_bwc_matcher {
 	struct mlx5hws_matcher *matcher;
 	struct mlx5hws_match_template *mt;
 	struct mlx5hws_action_template *at[MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM];
+	u32 priority;
 	u8 num_of_at;
-	u16 priority;
 	u8 size_log;
 	atomic_t num_of_rules;
 	struct list_head *rules;
-- 
2.31.1


