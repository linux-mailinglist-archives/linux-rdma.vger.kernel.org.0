Return-Path: <linux-rdma+bounces-8518-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB2AA5874E
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 19:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D4E3A17E5
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D571EB5C4;
	Sun,  9 Mar 2025 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LxUQUe2u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2C1FB3;
	Sun,  9 Mar 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741545736; cv=fail; b=Bs2VRSpdxQ0PEFyivtEQwjGWVGdL385wfwDfPZfLiD8ZZVVjx4fCDM0BbakVUHWWVaiT+LBOqIuX0udCdu5IcoiN0dRh40sRqnNWOEYnCMXDjUiMFo7HdVnu1AvrXF1OcFjxtCA+FHpNPlUgOAaJaTVD2u9YHhm2fCaOf+b29VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741545736; c=relaxed/simple;
	bh=Y6PQ1F50njdcWlCdJ7SQb380GIcKTvnQsBpRBroicas=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hlNep0ODf0L9itp2qaVIgAMqHc1RtCJdNRUNNhrqhfzXSt0G8FPaCUfw1p2JgOk3G/p37we4BynMI5AS9RhRzdGCMQbdmErhgI0p5xDxvAmn92UbqZBvI15al6dFzgb963eBmH5MFC0W4cFQb8Omna/uXS9b2TSEFdxhudobatg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LxUQUe2u; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AK94oDwp9AB5j9FsMIKAPC4+Klk6/Dk77Urz17sH8WDM5m5Sh5aDQ2AGEpok4bX7bIQWNsWGRPykExY743Nc5mjvkHiKDu0S7AKDewXKVvOXv3sxadwJk521HdbKXqCjxK8bX/1R5iMfDO9Zbm1V8jUJm49qb8prXcdbm4fcFybl6/+IUUU46tcEaaIS9n5w3ZDdLZB7AlVMgVkxrBQz215UBUO47nmyB8PR0sI/lXU3uw8idpNgzz9HSOqiBDQkR4gzGq02XvnHYzK//QQDp/uKlJBjSiQRU9HkzYxMNtrJbzInysZMK2Bi3OSC11pT1YGqBID+4oJ/zX8Q8P4L0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ONUEfV6MD6JFhhcqr/dQetoyMG0beTW1VsfNESWmtk=;
 b=NaU7lXigf0SRbvD10w1FopF+dvujph1HmowzCjBEG+KLfHAkORPkFpmk01g07cb2qu+GinroxPP07eimYb5bVXg01ypLzYU0XGdjqwlbHd/Nw/BiXVEeQvL8fbNDVpKcFng00Ka3p/CyxXdJAYmdkoWoHuhD4zCNjTSlghAzryaFIX4mcR6eWg5tUG1qmE7dTjbVamSe+L28cuaYrQFqoxBCfFESvMeBKEQJXaNKFISpE0qHWuu6mgTYn9iPk7GV52eSjl4E4JwKDlx8/0DV4yBsAMjvnBOncUp0ChMiOcFsOom6cU+28z4Gkd2+0lxl7Wms6MiSz4Zy7SMuFfi7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ONUEfV6MD6JFhhcqr/dQetoyMG0beTW1VsfNESWmtk=;
 b=LxUQUe2uKEZDQfg4TVJlFaJqfJQkJx20ZyfKbRtEsAd6OmUQfV07VK6w0Dkp4OZF0Ivj9GqBHAblmNP492XkHQLrWZ0a9NJgmW6NiApOOabFKN8VsV+Hk9IfuwjjQVYYqyIsRfKYA1zj3eGrR44ia3HrH81Hw6/ufNrc2KVziOMIdfC5y9Rt3zWYFb9POv2hiAvXEtQarp57EQCHFOEhy8JsqSd/SFoVipXSTzHJPlU3gDXzf2mrb10bwpfeppovjTKdxC40MLzizso3sYhNbEX8aVPCrFHgCJNOKywYvr4yPdZdQNFE4cFCyKm3sBHQNZXrztSyvWhvtXDalKYSIg==
Received: from DS2PEPF00004561.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::505) by DS5PPFBB8C78349.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::660) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 18:42:09 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:61f:fc00::37b) by DS2PEPF00004561.outlook.office365.com
 (2603:10b6:f:fc00::505) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8558.1 via Frontend Transport; Sun, 9
 Mar 2025 18:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8558.0 via Frontend Transport; Sun, 9 Mar 2025 18:42:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Mar 2025
 11:42:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 9 Mar
 2025 11:42:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 9 Mar
 2025 11:41:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Cosmin Ratiu <cratiu@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Yael Chemla <ychemla@nvidia.com>
Subject: [PATCH mlx5-next] net/mlx5: Add IFC bits for PPCNT recovery counters group
Date: Sun, 9 Mar 2025 20:41:37 +0200
Message-ID: <1741545697-23041-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DS5PPFBB8C78349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb8061e-893c-4057-4f5e-08dd5f3a1920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GOejs5ABq00PlVNCuIwjiMvfYfkEOsYDDa773ZXDosrayUYOxoph3+kUfDCl?=
 =?us-ascii?Q?x3IKNLOFY0L+8uwf+CB9ac8pHcRaQaEUGHlx8yOWwiEi1KRwkjvPx093J/ml?=
 =?us-ascii?Q?l0gjS0h+Z50afLVTrQ5o91DrYUDXnkuCKk4PgFRf3LIZiJCZFwfKhKsX7O7U?=
 =?us-ascii?Q?OR59NBovvtgqP5adsuTccpTqom/5G7tWrsP2S9UnSrjSovhp1sXgy3gzT5YQ?=
 =?us-ascii?Q?ejuO0WnRMXUg9qdr7CzvQgmvwT0Ru8fHZN/pZGXd7p0r7Ckk0SumrGRhzYEm?=
 =?us-ascii?Q?pj4kItHqVKnDizOxwfe2XvPXT8e+nrUtsKZIfgqkVoBx/kgjLFz2kT1ApR2Z?=
 =?us-ascii?Q?e7Xki/WtrutefJUvkRdldunIv2QkmP+7dwEsBtTOmrG7Oh1bopO91/tGZodQ?=
 =?us-ascii?Q?7pQdhVyr0HyR0bueqeBXRnckhkO7alr/PDBfmMxZEjnLrmiwgCIjUM2tExp8?=
 =?us-ascii?Q?NPZ5roikoJnYDxwh8kAS3kT53SCaktWzihH3zmqpVW9nFX2540Iy0t/Fozh5?=
 =?us-ascii?Q?WB/YgrfL3xCKRj02E5mKd8GH6A/mfkRs4EA5SgX8yBicWITafToWL96bGlsI?=
 =?us-ascii?Q?+aYPkO2e9gM955y9NIUVf8eSCntA5jLa1eqV97+tX4ytVXlNyVBSZt5/5ny6?=
 =?us-ascii?Q?Cpwt1icKTcCnE3WQRuKuiHr4vqsLbDqTVCjjZmtSYfu3A2SBlJIeBcNELl3Y?=
 =?us-ascii?Q?pl8a59t9O9yB6GSaYkrIi8YNrCUTs9uQxOVhIuOwzC7hqgvkhBKknfh/hyQX?=
 =?us-ascii?Q?AzuwwO/nm8L1zhzBsCAQwS4FuVNffSehBi/xLcQWMjqJCASLC9eKW+Wnpiny?=
 =?us-ascii?Q?9ah7drCi8pXxpCcwr76st3HtICnIBYiu/H4v6dUQpc0g1bM+n42Z5Wu7J6YN?=
 =?us-ascii?Q?nyXdmMK88fBaNfE1JilXn6gSlwqUXvsibiXlAdKVRF5S3B+Q6/bqLAZSXBl5?=
 =?us-ascii?Q?9hMw3SdeUkDTZ1dzm/xUrW+5IUHwLKMtaSIF7WYYfGmPxuW3Vn9EhrqAuPM9?=
 =?us-ascii?Q?z5E9o90lGx50Ywu4W09eaz+xmXqFxF8NuiRqf6+VLrGXmqYFcjpqV4XmJ25n?=
 =?us-ascii?Q?cLqDSVoDazG4/kUFwowbiqydeRcgynN6+RWZnEgA7gLsNg+8vD8m3ZinNvOt?=
 =?us-ascii?Q?BFIqjTRB4zJDFUlWSt0i5CX8okgCXIR+gAodXDFBTdclApl6ec7bZ5jOHuqc?=
 =?us-ascii?Q?Z3dcEhT0KHiKzG+wJrh1V3dvonSa7RxZmluULslkMZdLElzEQB3pHBkUu4pt?=
 =?us-ascii?Q?BMe0iJlrZgFnpUmrqv52DbZp5+s7qyLlg6yneEEzb1jrSsH72yPabzbn2WyZ?=
 =?us-ascii?Q?8czfW5q3atXF79WKnBS8OGwSNc8lFn0FN9SjWaVvm98FbTuFrmq2tONa4dl5?=
 =?us-ascii?Q?5mE4g7R+OBsCuP24xhA1KtTFRzMXc5zaVrFHt6pRf6dY8emQgS3ky9w0lyyV?=
 =?us-ascii?Q?xoSARoedIV1FulSIQ0XSKUK1Brh23HkZxt4pQEWwNMVa1qJ/s5jFHRabfmy2?=
 =?us-ascii?Q?Y9KhUMa/s9vUdu4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2025 18:42:08.9518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb8061e-893c-4057-4f5e-08dd5f3a1920
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBB8C78349

From: Yael Chemla <ychemla@nvidia.com>

Add recovery counters group layout of PPCNT (Ports Performance Counters
Register). This group counts recovery events per link. Also add the
corresponding bit in PCAM to indicate this group is supported.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/device.h   |  1 +
 include/linux/mlx5/mlx5_ifc.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 8fe56d0362c6..904804e995aa 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1517,6 +1517,7 @@ enum {
 	MLX5_PHYSICAL_LAYER_COUNTERS_GROUP    = 0x12,
 	MLX5_PER_TRAFFIC_CLASS_CONGESTION_GROUP = 0x13,
 	MLX5_PHYSICAL_LAYER_STATISTICAL_GROUP = 0x16,
+	MLX5_PHYSICAL_LAYER_RECOVERY_GROUP    = 0x1a,
 	MLX5_INFINIBAND_PORT_COUNTERS_GROUP   = 0x20,
 	MLX5_INFINIBAND_EXTENDED_PORT_COUNTERS_GROUP = 0x21,
 };
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index fea8af42f954..2c09df4ee574 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -2645,6 +2645,12 @@ struct mlx5_ifc_field_select_802_1qau_rp_bits {
 	u8         field_select_8021qaurp[0x20];
 };
 
+struct mlx5_ifc_phys_layer_recovery_cntrs_bits {
+	u8         total_successful_recovery_events[0x20];
+
+	u8         reserved_at_20[0x7a0];
+};
+
 struct mlx5_ifc_phys_layer_cntrs_bits {
 	u8         time_since_last_clear_high[0x20];
 
@@ -4846,6 +4852,7 @@ union mlx5_ifc_eth_cntrs_grp_data_layout_auto_bits {
 	struct mlx5_ifc_ib_ext_port_cntrs_grp_data_layout_bits ib_ext_port_cntrs_grp_data_layout;
 	struct mlx5_ifc_phys_layer_cntrs_bits phys_layer_cntrs;
 	struct mlx5_ifc_phys_layer_statistical_cntrs_bits phys_layer_statistical_cntrs;
+	struct mlx5_ifc_phys_layer_recovery_cntrs_bits phys_layer_recovery_cntrs;
 	u8         reserved_at_0[0x7c0];
 };
 
@@ -10584,7 +10591,9 @@ struct mlx5_ifc_mtutc_reg_bits {
 };
 
 struct mlx5_ifc_pcam_enhanced_features_bits {
-	u8         reserved_at_0[0x1d];
+	u8         reserved_at_0[0x10];
+	u8         ppcnt_recovery_counters[0x1];
+	u8         reserved_at_11[0xc];
 	u8         fec_200G_per_lane_in_pplm[0x1];
 	u8         reserved_at_1e[0x2a];
 	u8         fec_100G_per_lane_in_pplm[0x1];

base-commit: 15b103df80b25025040faa8f35164c2595977bdb
-- 
2.31.1


