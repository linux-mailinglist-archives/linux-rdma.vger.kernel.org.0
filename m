Return-Path: <linux-rdma+bounces-6211-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EAE9E2DBE
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 22:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5B07B46A74
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 20:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339D620899B;
	Tue,  3 Dec 2024 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C98nAQrj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629401F9F71;
	Tue,  3 Dec 2024 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257839; cv=fail; b=UACx7azodNn/WswRhYlHlDw+z6q2eloGn8AGzW7EPs/mjUU4awCeLChuFLr7q3+/DOjonuoFcJbMo+SjcM8JujnxyJ1ZmujtX9fjJssCzEC4hkHaLRMWamzkNWMnNdjWHI8V7Np5uXuxlwWxDQxYD6T1HsxWhwohYbPrhQFHlOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257839; c=relaxed/simple;
	bh=HIeby63zlBVtNEym/1TK6RajyVz1Sc4CtkbCJmkqEfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kChik8vRaEZ5uBhK6nuMFhyXXOLRSb9A919kxyrGHVsCLDQES/G4INJZasobHUYQv8BvJvsP5jrJV4P0n/gACF6II8xOpFcBMgawsUhgOxbkrLMwawx/HZU8X8oO0VdMbZZMc5Un+/Wk5GOT5iEQXz1AAL1LRNbugn0y//701r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C98nAQrj; arc=fail smtp.client-ip=40.107.100.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpDiwZQ3ozx4kcB1cdWqxBt3DsjVDVyOEwkhlU8lt4K0VrRlMzRLnxaXlEnBjaNnIO23hUIdBmtKE/TnWkc+1WeGM26ftYu6TNimJNwBG98YrVTvYW8YlnIzrcJbdsOsU+soPfokvSBkxG3hRLLfVnKRKQxdxcW2FAnLFTnCnFjeXPIwV0RvBbgi1IwD3yvy1ZpZg1bkPQfAys1hM/HxX86Y9Y3IDKsMMFUYTdGD8QbV0uU4VI7bUIeSPGkBS2SxK/yFUzonJRmIvfUiuiPOYAhm/MbaPukPSsUiwn61NdAS7oJZXeYtbHmjEtbqvBNsWwUMIpWcisY+mPqO5Fq88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B98sCeREJgBNTceVJtAoIDlxW4LsRiUDtglf8xuqaaQ=;
 b=ROGaUHgJjTTQYJNU5C6NIKCPpuFrA1+n9MjLBVSoIQ4Vkz2Tp7FPX7IUtam/Zuk3dQo58X0lEat40EtVtlDxKtpBtYFVrr66D+1KVlyRO1u2wDAFW+GAwqRgPS3lFD5YMoUhR0djKzvxLNuRJKus+5jnzRR+ofaTp0jEt2i/t25FYvmEUMxNSI+tOvtYbNylzuQwUCyZ2CP8KOUf/kxb0GRYNoMvK+gESIrURNZc9Iy+9g+rtP6H74HMVRQBVYUJfyLAnsb5dcx9NFt9K0ZnmC7iMlNtM10fwHAlfucg9G+2qVhpNwDoHFjDEvGrRwSZuv+tyQgqj1QlbVbi8okp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B98sCeREJgBNTceVJtAoIDlxW4LsRiUDtglf8xuqaaQ=;
 b=C98nAQrjKXG+IN3GMoSogPa/SWJKi6z6QlCD53GLRO2mdzJNvB3yjTqHKppjDe8IYiX59zeXRFnQMuNVGBAjE/vPDxwCaT+uaUXww0qhsMT0aLEP4w8gmzGkwzLQ854nSGPvetIUSGmxQT6Zt4LtveOS8QnFfM4EoJ2sXvrUZyHIvfu+dAOb7cFwr/3Vj5BPciBpMKJ5VK628Nkvco41wtff8wHIksRgEuASH5z4CAQ6ULt52N2PcF0NWx41YnjuN2c1RDzAJQcMXuU6Q7ACum2LTcWgZ8tQO8wFxZuwje2ad6Lyt4TjbhS83xnmQRHCUPWwazb7k1X0Y3TEtib5mg==
Received: from CH0PR03CA0413.namprd03.prod.outlook.com (2603:10b6:610:11b::11)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Tue, 3 Dec
 2024 20:30:32 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::81) by CH0PR03CA0413.outlook.office365.com
 (2603:10b6:610:11b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 20:30:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:30:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:30:13 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 12:30:12 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 12:30:09 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V4 04/11] net/mlx5: qos: Add ifc support for cross-esw scheduling
Date: Tue, 3 Dec 2024 22:29:17 +0200
Message-ID: <20241203202924.228440-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203202924.228440-1-tariqt@nvidia.com>
References: <20241203202924.228440-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d98d4ec-1c84-4ae5-7a2f-08dd13d95534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rrynmgh3pfMPfEZUKJoSU7JUu6u6pKRfHr/vXuBTyCTkDgINpy2/z462ykFq?=
 =?us-ascii?Q?Yw3e3p71w+1LJ1fxehreSvfI+SLldk/tZs1Y/OA3rTjJ8AJ6B2n40HWME9i6?=
 =?us-ascii?Q?hTGL4rkXQE+XCi7NrzkS7J4ymqLAojPjuZFGpDcQNQBWkktMFE0vOgT80HC1?=
 =?us-ascii?Q?lbSIqthBQHcFzPj3Ly0+NMIBIpcav+iAB1GlfdgunmB9z+d3gVm1AJkT/fsx?=
 =?us-ascii?Q?P7Y+Hl2caOUTH3UCnGBQkqCvHXfEPW8impxIpZLcz0H7AAt7IH3XnKJPtxhE?=
 =?us-ascii?Q?CQbVqFASXkEcPCJgoxqtdbkqPnVMSetnpew4lNPGPAK+DIkksVs1cF6+P/2+?=
 =?us-ascii?Q?J1JJLD8XZuzcbE711TwGTX5E57cVO9yTbIN4x5z8YsTWPjo3qOvPTqxH3h6f?=
 =?us-ascii?Q?Y6cYjelf2JwTzmC2bsMxFACcudRDNvvgsN4yJeGu0BVsqNUe0pCRk8BOHvr7?=
 =?us-ascii?Q?8lwW9UTCv27QvMT1guQEwU/7giv6W1BQuGAvf+jPzpnPWVrwIsvWWFEB5tOA?=
 =?us-ascii?Q?ONpYqKyQvS4VDZDyTYsTXkYaDuTTQfIF5urb58xcXqil8VDJihyNlNFbsare?=
 =?us-ascii?Q?GcEwAOYk4jByxCRTcA5GuFiZlDAcwJI3xnVJip3lXWY+FZoWq1PxZ4zzHEdo?=
 =?us-ascii?Q?xSjnRkud4P6o/HZUaCbcH3nDY6BdfG36j697mn1chuOqfAObKwu0nBkBOUqu?=
 =?us-ascii?Q?M7Gf4bPWGzoXG6OfXFTS/iBs68nEGQdSdDkLvO01PyrE6Ih+rg2XtUpwMT0Y?=
 =?us-ascii?Q?4Y6sxRD3reNrBnFS6yIX65+BIQbrf4StlitaiVp8DQCAHElrggh/NPxXHUJJ?=
 =?us-ascii?Q?lVhSGXz12hw6S0XDyvDwrBtAuW2LtD99ew177EpWCQ1/RSjsMy/rooPjGkvb?=
 =?us-ascii?Q?4V9vAzGfWkTLOwDpcTqsBMpxR/LJ8fVCjPz/iU95W4CJMAjo1FBp3QCJEYZk?=
 =?us-ascii?Q?Q5++HlUs7ImCRX4Dn6gGdm5PUJhbsCeQwQICgr4dcV5gpz+Q+YkiVL7n8QSg?=
 =?us-ascii?Q?6ZGTcIJesHYn0hKoTFtwat9Mwpn9AIHvxRDNmq6m1TxK6ONo1+IrvzoeM1cU?=
 =?us-ascii?Q?SUSrD9tndUXrcaH/zpd9xijdHQZ/EMacjnFJlDasFuD8jPclRt5fACc9Fjuy?=
 =?us-ascii?Q?qd8OiKOsawh8sVYCGNVciZ6TSlhQh4OejeYqK4XazeNbsmQruJRKT3IWgYz7?=
 =?us-ascii?Q?ekF7gtSt9W7LGAT8Y3zAMTHp0J9vQu3qvzLQJLxz3Q0tkmV99NVGijwvmmEm?=
 =?us-ascii?Q?XW4pSP28ymZX2yQ+AMC6Ayu+h45345WB6YCvg5llZl6Aq5Pn3DObu5+QfSit?=
 =?us-ascii?Q?q1accYX7B6yY2X+15B+d2AQBqwBOqZE8C2wnE7FmKinUZSMZvQwsRP3HJDAB?=
 =?us-ascii?Q?1dqJuYKfZI9Kx9Dx4XC0otErx+hdyW2YxD30hIU1XI16vXOeEUQTq5/xuTXl?=
 =?us-ascii?Q?eqZN/zYxpvW9V50fCjF154ddeCzWX7xz?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:30:31.3561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d98d4ec-1c84-4ae5-7a2f-08dd13d95534
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

From: Cosmin Ratiu <cratiu@nvidia.com>

This adds the capability bit and the vport element fields related to
cross-esw scheduling.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 8b202521b774..5451ff1d4356 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1095,7 +1095,9 @@ struct mlx5_ifc_qos_cap_bits {
 	u8         log_esw_max_sched_depth[0x4];
 	u8         reserved_at_10[0x10];
 
-	u8         reserved_at_20[0xb];
+	u8         reserved_at_20[0x9];
+	u8         esw_cross_esw_sched[0x1];
+	u8         reserved_at_2a[0x1];
 	u8         log_max_qos_nic_queue_group[0x5];
 	u8         reserved_at_30[0x10];
 
@@ -4139,13 +4141,16 @@ struct mlx5_ifc_tsar_element_bits {
 };
 
 struct mlx5_ifc_vport_element_bits {
-	u8         reserved_at_0[0x10];
+	u8         reserved_at_0[0x4];
+	u8         eswitch_owner_vhca_id_valid[0x1];
+	u8         eswitch_owner_vhca_id[0xb];
 	u8         vport_number[0x10];
 };
 
 struct mlx5_ifc_vport_tc_element_bits {
 	u8         traffic_class[0x4];
-	u8         reserved_at_4[0xc];
+	u8         eswitch_owner_vhca_id_valid[0x1];
+	u8         eswitch_owner_vhca_id[0xb];
 	u8         vport_number[0x10];
 };
 
-- 
2.44.0


