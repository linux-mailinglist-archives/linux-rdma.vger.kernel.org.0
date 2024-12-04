Return-Path: <linux-rdma+bounces-6245-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BE79E4792
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 23:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C102188076D
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92651C3C04;
	Wed,  4 Dec 2024 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AME9v0Wh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0991A3A95;
	Wed,  4 Dec 2024 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350302; cv=fail; b=K2nwvjJf4BxLU8JjfYKfYoJZng+IkbozmPO4Cr1J2R1kpzIDdzphRSr0hWEb04JDkbmwzNeQAJZTgGJrG2C11f1qQWqcANTtjNPNWxH+B9I1MhRkBr8HVLT5wkXA4A/UwSGeg8C0nNMABo97C2RsfEvYQWwfCodVzDvUYYv5MnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350302; c=relaxed/simple;
	bh=iPsY3JNqyCFs/4cH7DQ5hmTTXOdlkygw4+vYBCb59Hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvP1dSdJnedc2KbWKEl/wXazu9sSACcuDAD/tZbvKxjDWKPaD2x71Bp/7dM+9dGLz9XcixswZZi4JYsB+5uuwJRmQFUGpID+jsxg5qiK8gQifXs8zi0aoadkdV6PVbdFkE9T2QBWb1aWdTytbNs6b7r9DI1dfMo1QFscX1GLrOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AME9v0Wh; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+gYq6NAoFCmb3GqfpfaWLbyiO57WnqkfmSMZAqJACmcQL/KIMkgzmPHuZZE0IGEh6yJurlNiNOK07+K99JkqAqp8kZy/K8CKVc91WBCMOdOQV1DKjg4ajJKOfvHqxU5GxLo49wr2GgByvQ3Gl3ePABJbeaedhFQDK8g1NGleJLi29B/OwzM7ovn8M/R1oH8GmgMmdJ8iEAh2PxSewCU8+K6Hp44Z1X+whkyZyeuBTA+JJiWOf5CU7MWym66gBg8CR1xkdnwvUT6tWmFAHDczwG6LVrW/25JyL+bVlJ0ktQsrfJfpBhrOFYifldY8yeYGOblB7Z4VhEaKv13O/kYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO1I/NziVUCoUdIza2q5d1Az/TBvPj866QaNN+JMi5I=;
 b=CTUtFx+2KtWOV1bQgHD/jP1gdX8PqY1YoXfh6iJpb9oul2uokvhRVM28Ioiq0Z6CLBW3P89YU8gEq2WFAVo1sEylD30rx2GdnnRylLwJkgl5DdHQ28A/RdDu+PiJk1z4aDtkqspjpZ85bH77rycQWrlQHMpQfevopuqMQfdSBwqcj46XQoJLV+Dpiwa5pj7y5Nt55yFDI7kGttqMJSuoYCyUaF4dDgDisddWRsIrBv5fTQ14VLnAHRirg/xPaWJQZtiDext8Paf1GFQI7dKUsvic+iOF/zMaB/jp3GRDUy8hPeS9QRmor+zR8BZW7JJr0p48bQOlEfVttqheGcePrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO1I/NziVUCoUdIza2q5d1Az/TBvPj866QaNN+JMi5I=;
 b=AME9v0WhU0LkbGBai5n9uEEAMEJsK5k1Am+QDwk2GLLj7DjimPLNCDHdXTYNPSKv7PJm44RNvyAtv6opwqveNOTBT7nGHXcOcFfNnvNu2YBmQ/uVsDnJVSXC/5NcClks3IexPphuUvDOC4seEco8kXjSf3kwBv1nKilP36f4urSHG8QfSJlRE0Q/VK9JQorHpkoig5BDlGsiU/D/jUpk31qDEKpw4x4HYORWnVHKPMC7XJoKPZb28pG4jLSlrf8lFjChVv2EOCJ6gXawW3ZOm9n6jK7EdTDe5YeGQ7QPX7QbOAR6ouIbrWkSXfLP3D2bCNwgub3lyC/6m7D7uJa4Yg==
Received: from BL0PR01CA0012.prod.exchangelabs.com (2603:10b6:208:71::25) by
 CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Wed, 4 Dec 2024 22:11:34 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::28) by BL0PR01CA0012.outlook.office365.com
 (2603:10b6:208:71::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Wed,
 4 Dec 2024 22:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 22:11:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:10 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:10 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 4 Dec
 2024 14:11:07 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next V5 01/11] net/mlx5: ifc: Reorganize mlx5_ifc_flow_table_context_bits
Date: Thu, 5 Dec 2024 00:09:21 +0200
Message-ID: <20241204220931.254964-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241204220931.254964-1-tariqt@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e373ce-5fc3-40ff-097a-08dd14b09d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NvI8shlXm+0U1hnqt7zjuCXleL0Yk5fJ57glGj1b7KpiM2cPIK+s9svbgoCm?=
 =?us-ascii?Q?QQPw9C1lBfqViYgDi1pnB4Bcyexn+MVaesByrrk6cLLqtDXsFO5XmDumUUrf?=
 =?us-ascii?Q?43IughgoLsxn0FW3zPkbD1Z9hFurPlfNKQJhQwfS1gl0alguyfKxsALYQAvF?=
 =?us-ascii?Q?7HDSZ20iCK6GRlAlCM/oP+rx+Lel61Q+mWTFhcm5ouSlxPpu9NU1RvgzpsWp?=
 =?us-ascii?Q?bNaRpEwJ9PGJy8ppknaWYBq5zK1WIeDl01koPwmfM5XrbM/BnrO4eOGp2Mix?=
 =?us-ascii?Q?0DdC3unNiDg2txE4C7WEZabLlNatZT2m0lXG4rKEOlAyLf1RVwjDHLrl0g1D?=
 =?us-ascii?Q?RusCKCqY5RX8RucvCT03FNgYidA6ACKAmG0VDeP8A8sS0iGza79RUNtYMmmu?=
 =?us-ascii?Q?AongDOcNgMCQ9nK7w0oiJqQZBXOdz/BZgj9lxlNKKwxg/8QsN1I2KJnK3W6Z?=
 =?us-ascii?Q?oxmrpC/Eytonfi/p6OjKM16+yRRjzlkyXDterj3iDL2Xl5tcflSIdcRLYRb3?=
 =?us-ascii?Q?z9VClBBUib/YcpS9nEBcwxukkV2BY5QdwA6XzDPjk73B0h0RN0NwOrOx1HDg?=
 =?us-ascii?Q?l4fp2MEwjaiEVOhbabgJYkYuVsJLXOqQ8niKt/ZrNFEU4khb6M3+pf4xLtQH?=
 =?us-ascii?Q?U1ef1b2gYDIAWLwNeEOcFwjQTipmh/osKzSP04wtmi1ss5GoiP5n7LXch7LE?=
 =?us-ascii?Q?KJ9lHJzYGVUuWhDzg7ktlCoUPYRu/zYHva8d5ZxPniY0jgPrXkd8R/hDBOyC?=
 =?us-ascii?Q?2arkj4Sjv6NgKjBbpcl7bb+23u/F4lXfR4wOnGOUq/vKx0uEx486hlDWoLs1?=
 =?us-ascii?Q?sSIvsz/VhgXuBRlUAGyHtIlPU/WnJRg5mAfnUCMDjk7+Q7Tm4rhH85aR1YhN?=
 =?us-ascii?Q?44lCkkf9rZAdkjc9h8kX547SmvZwsK29rY1wtIMH3tAA91jrvA3egpxIUT/f?=
 =?us-ascii?Q?H2myZgs//VTi0AIblQporp/4P7bUUfyf6QVupvRdrzYFYHsdHqM01RKgZfLS?=
 =?us-ascii?Q?LRnIyCGLU7TUGGrpCzqfhwa6huKz3e5Nel0Z3yS09iJbSuPA4YYneurQQTTT?=
 =?us-ascii?Q?2EEglSHz6omsG16BsFTj2DFRZEPOJ/JqDxoU7TEmjzvh6/r0IaTWfAA3wppe?=
 =?us-ascii?Q?znAb/7wJ7hn1rUBq6Nuy9J+6Cfz+p0/7HjSrFsSEHVWoDjyent2+F/G1w/7n?=
 =?us-ascii?Q?6bSmr6j0AxrRgiE2UdpD7A0FOExbloMtiTT634rRfCxaMQsJ3iTDUxfFldrQ?=
 =?us-ascii?Q?98l3Qbng9F2o/d9rFNYdxG0HEvplkEPRRkJYXVkfSmCVE1sNrIsJVufEvQv0?=
 =?us-ascii?Q?KLXV5eOWEZSIh60SB6WsDZs1/WyWYtEsutu2Wz6SqTkPWJU75P5x0po/Ney+?=
 =?us-ascii?Q?3GvTsKroZwxjUfRw3JhbnjXqOonbRnOY9Ojtn3QIQ1ReSb6O69ntydk7H0ay?=
 =?us-ascii?Q?eWc+gB8vmjTAOZ63MfKYTQtyPMr2heC8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 22:11:34.2612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e373ce-5fc3-40ff-097a-08dd14b09d70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265

From: Cosmin Ratiu <cratiu@nvidia.com>

The nested union at the end is not in the same style as the rest of the
code, so un-nest it to make the style uniformly applied again.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 4fbbcf35498b..f3650f989e68 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -6324,6 +6324,20 @@ struct mlx5_ifc_modify_other_hca_cap_in_bits {
 	struct     mlx5_ifc_other_hca_cap_bits other_capability;
 };
 
+struct mlx5_ifc_sw_owner_icm_root_params_bits {
+	u8         sw_owner_icm_root_1[0x40];
+
+	u8         sw_owner_icm_root_0[0x40];
+};
+
+struct mlx5_ifc_rtc_params_bits {
+	u8         rtc_id_0[0x20];
+
+	u8         rtc_id_1[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
 struct mlx5_ifc_flow_table_context_bits {
 	u8         reformat_en[0x1];
 	u8         decap_en[0x1];
@@ -6342,20 +6356,10 @@ struct mlx5_ifc_flow_table_context_bits {
 	u8         lag_master_next_table_id[0x18];
 
 	u8         reserved_at_60[0x60];
-	union {
-		struct {
-			u8         sw_owner_icm_root_1[0x40];
-
-			u8         sw_owner_icm_root_0[0x40];
-		} sws;
-		struct {
-			u8         rtc_id_0[0x20];
 
-			u8         rtc_id_1[0x20];
-
-			u8         reserved_at_100[0x40];
-
-		} hws;
+	union {
+		struct mlx5_ifc_sw_owner_icm_root_params_bits sws;
+		struct mlx5_ifc_rtc_params_bits hws;
 	};
 };
 
-- 
2.44.0


