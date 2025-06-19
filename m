Return-Path: <linux-rdma+bounces-11451-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8B5AE040F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD11188315F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA3123C4EE;
	Thu, 19 Jun 2025 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n4PNPyqQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860E423B628;
	Thu, 19 Jun 2025 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333073; cv=fail; b=ZT7FAH5GE1bMF7QvvgpYm1vuu7wMgY7dLHNsiL1octqVLy0ZNcRnlJR7pdqEymh96ViYrZ6g9uyjBMrK8tXmmXFB+Om/uf0YGfN38HPGLFs/9KzB8ROfXwes4qlp3Rk8oCD9JxQBeUmw1aEJBI8b74OZnGhqqDDHNmZ42VjHmkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333073; c=relaxed/simple;
	bh=zf/qBt5wEoOUX3Jt/Be/avjCf0anEwTXtB8fvTPthF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxk0/O3t8aT7RxAQBXTe1GTWk+i2bQHWacXPTGkqTR15S11F4wRkP/YEFwS/dQeBF1jfd9aLEIO1r+H9a9GGGv10H08ZieSrMneg0LE0UBLb9fndeHbCTvLfVuKN3uCtIygOKc2LQsjPXn/rXAxR6uBe8jXvCDtcvuN7yeezRtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n4PNPyqQ; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pt9COKUK3tVOOIWew8krNnfum3K8VUd6JBRfXwZd05vXEumrbba3O1oShtenFWD7bwxXKYLAQR6EFWkpW4X8d+ACX7QxOQY8WQSTcb6lBAhOpZLnBRsyI8hj1/5IFaunIMEC4NzZZUqjKU8rfH4KvMoOVwQzFDWG3z0v9Ibc5ssTVVUohBRQapzFK/qkxkJLEX5AnLYTX+JFF/HZO1rMgAGRONUrITFzI0GuEfrIrkgyq/4aF0CNUVWCF2omLXUaRLOWFWE0KM84qM7LTEbUF8yO37cBpihY/flBDhX8ENBngU46N3LwlRGyT7aODNKwDytHIV381MzVCVP6DxO7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YLdx1uK6O2Djb6C4o61ns60JoQSKkpUeeqLjIILdIU=;
 b=pvQEqBscpJRiLrec22O+4lTyS9mKjCDv/7IDOjXfE81PUhPgpFvmIfSNJ6mFK1RDqv3rV1wD0r2scQQnKz/dVnCqR2iClyZL48m+dTBnJ4hT82xmb4NVCi1K9e0gX92gNxpHXODXoIEi3lfVZpfgMJvGoFJDYj3+LLLof7nw14yFc/a2/HI32dCtK/sDxqm4Od5R6ecUI8A1+1dJy58IUMVKGn4ADaKwyqm1QwyaekTkrI3mM4WGshrtV5FrjJWnjsphrT91PPT/mbypfy7bUeANKZWHJ2iCCN+AokpyMMgoJPSlMpFOwvXjN+7cTjXZaD0r63b/153OUBvp8Fhw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YLdx1uK6O2Djb6C4o61ns60JoQSKkpUeeqLjIILdIU=;
 b=n4PNPyqQ2u3hj7LpgyruXuJdClEDPmQaaB0Pqkchv22p+3oNiPs2gX3Yt9FRcwi5q3gX3aaDUdo1/QwwOrj7JHcza633TI8EndEPyo+5rT4qa9+4Awv/1ZILeoQddnPrReRCJkEYrctXLdKiiyyWPC6zQfceVTotzHl0Pp9GMIwLmjTfklb390ATmRnWalmUdrtsU5artOCeUZJ4/qTBVYTHSlRK5x3IvTLSuLVMoWc4T44NVAkQzEUTX0ACTI/6oCuIjjNlyH6076Q9/dSPjX7lqAkyJ73DSPV+TnEbGnOPfUCJDDxczuVxXBYwl7Y9YBk6RD2xBIjjQcb/SaodBA==
Received: from PH0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::35)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 19 Jun
 2025 11:37:46 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::12) by PH0P220CA0012.outlook.office365.com
 (2603:10b6:510:d3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Thu,
 19 Jun 2025 11:37:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:37:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:37:36 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:37:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:37:32 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH mlx5-next 2/5] net/mlx5: Add IFC bits for PCIe Congestion Event object
Date: Thu, 19 Jun 2025 14:37:18 +0300
Message-ID: <20250619113721.60201-3-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SN7PR12MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdf4e26-33d8-4ef5-16f8-08ddaf25b625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5PcqY1OoaJQoo9XZUZgnlJqTlB+RfBacNB/JxAIzB2KHrKfrQqaloNLWYq6Q?=
 =?us-ascii?Q?wiDl7V34Z04XnWG7zq4CjEPiKhYYoiTOGgycxWvFblx0BL9Fi0jvtxk+qJlh?=
 =?us-ascii?Q?IMGK6Xg5ycZpDDGBooQdcwGAbrUALAYgXQVfC9uZbJpQkXaw7mMrPzQFbYrv?=
 =?us-ascii?Q?uaopjd0gL3C3qf1lx76JvAW7LwQr5PPKtXSae6z3uW0aB8tCZ5udnxLZWiHH?=
 =?us-ascii?Q?sEHz6RbzAQiyiRXIeq+fGlLkJT1g7w/as9iayKsq3w5iVXNpbT/P1Q/P4rHu?=
 =?us-ascii?Q?sw4QV46iaQRWYEcy61MQNhJ8KDs2tt6eowx3rFPMix/fLNWSUlVVoSaNwZq0?=
 =?us-ascii?Q?xfVKWOx6d4x6TW7mmzafnguSuT/mM259w2SSgwL/ITEbafdESj87/WIZWQ3U?=
 =?us-ascii?Q?Ir+7DBSXoevU8784CdzxsY3xJbpFBIVXpoIpWJpzcYFczKvPG4/9hMCJDZTR?=
 =?us-ascii?Q?rhboQtJUKtzhQzdzFrQB4qTy3wPnsjK1Lq+4tGBSIJGirwHlTE9d0zeRmoOW?=
 =?us-ascii?Q?r+9eb3TiDlXrnIwr8QCfqjhKL/PqTPcQmX95DNQsKTH/KhozFEscxcvAinuy?=
 =?us-ascii?Q?d2dgVIX9nkzM4wFIFQyTTBSw8jkSg4AfV0vJxuY6G1RlS1Wf1xbjGQuO8lTQ?=
 =?us-ascii?Q?BjzrJHEl5VkdBs9ZKCMxg3gz80y66t2iNAzkpkNdOvSHV6JQB1d1bMBtGmCE?=
 =?us-ascii?Q?E5ScMn2uWziV7gs2uCLJ8DMfwcSz86VHPniR3ttNnS6krFdu9zoxXfWtteC8?=
 =?us-ascii?Q?QJnMvXNtx540xrH8LU0vbI4y4AigCZxA6YuPtBN3DGfAfJPpUXzxjel/WlRZ?=
 =?us-ascii?Q?foj6THJDupY8ZJWA3idQFICPUtto1ver6UUOm1noG6xopsaMvzBzrUjiGdFA?=
 =?us-ascii?Q?+DfRhwaEcLwHzYc6IHMB8o8YUR7LXymnv0S4vLVOa+3/swmcB9O7Qcc1sYd9?=
 =?us-ascii?Q?Mlrcx9KfQ4nYvYRKCgdSNpMFWZTA9HWYK0PXqMCE+qvmW9ZSexYx7RFiYjiE?=
 =?us-ascii?Q?7Jjs1DVsgVrexWNA+Mhcm7Lh+NRdpk0TrIYd7sbuyq9HvLQyyAKRFsQXHHNV?=
 =?us-ascii?Q?3P86Dm9uayG74/4cW6JD9+Jp4Tm8nJJE5Tb7iAdCyix8Nandh2yC8hZZwViG?=
 =?us-ascii?Q?kWdj7d2H3gfrf1nBE4S9Wh2VakcRJ+hBuHsYnHnqF4jXo+iZbpZC6vBajc4U?=
 =?us-ascii?Q?/mq1WLY9hhnU5oUcOE85C45zJVcixJT7oLawmKU7AhHfLA1MU7eJVi2zFpMW?=
 =?us-ascii?Q?LxDRwtVERJAREaFuOkgn7dwUMDUsCuMFy+vUy56PBjhmQEb2wZjMlhATRS/g?=
 =?us-ascii?Q?8JFs049I9CmWR44QbCvxj53kWIi3v8+m5yV42d/k3kBUcX4xiYjLg7AhnNzM?=
 =?us-ascii?Q?Mkq8iGWl2kot58T8G87/pevFI/6eCab1EwUFztZXtQEMUlE448d+eHcbYXGq?=
 =?us-ascii?Q?bFg18CUdj77gNp11MCmbeQBXY143sd5OS0w3tYGtWkONOowfYuRKFXrJ5SCJ?=
 =?us-ascii?Q?AcihokHDPctcMgTk5PXBNJhitN0F/PdnB5W/?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:37:45.9910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdf4e26-33d8-4ef5-16f8-08ddaf25b625
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057

From: Dragos Tatulea <dtatulea@nvidia.com>

Add definitions for the PCIe Congestion Event object
and the relevant FW command structures.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 5c8f75605eac..0e93f342be09 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -12509,6 +12509,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
 	MLX5_GENERAL_OBJECT_TYPES_RDMA_CTRL = 0x53,
+	MLX5_GENERAL_OBJECT_TYPES_PCIE_CONG_EVENT = 0x58,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS = 0xff15,
 };
 
@@ -12526,6 +12527,8 @@ enum {
 enum {
 	MLX5_HCA_CAP_2_GENERAL_OBJECT_TYPES_RDMA_CTRL =
 		BIT_ULL(MLX5_GENERAL_OBJECT_TYPES_RDMA_CTRL - 0x40),
+	MLX5_HCA_CAP_2_GENERAL_OBJECT_TYPES_PCIE_CONG_EVENT =
+		BIT_ULL(MLX5_GENERAL_OBJECT_TYPES_PCIE_CONG_EVENT - 0x40),
 };
 
 enum {
@@ -13284,4 +13287,41 @@ struct mlx5_ifc_mrtcq_reg_bits {
 	u8         reserved_at_80[0x180];
 };
 
+struct mlx5_ifc_pcie_cong_event_obj_bits {
+	u8         modify_select_field[0x40];
+
+	u8         inbound_event_en[0x1];
+	u8         outbound_event_en[0x1];
+	u8         reserved_at_42[0x1e];
+
+	u8         reserved_at_60[0x1];
+	u8         inbound_cong_state[0x3];
+	u8         reserved_at_64[0x1];
+	u8         outbound_cong_state[0x3];
+	u8         reserved_at_68[0x18];
+
+	u8         inbound_cong_low_threshold[0x10];
+	u8         inbound_cong_high_threshold[0x10];
+
+	u8         outbound_cong_low_threshold[0x10];
+	u8         outbound_cong_high_threshold[0x10];
+
+	u8         reserved_at_e0[0x340];
+};
+
+struct mlx5_ifc_pcie_cong_event_cmd_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
+	struct mlx5_ifc_pcie_cong_event_obj_bits cong_obj;
+};
+
+struct mlx5_ifc_pcie_cong_event_cmd_out_bits {
+	struct mlx5_ifc_general_obj_out_cmd_hdr_bits hdr;
+	struct mlx5_ifc_pcie_cong_event_obj_bits cong_obj;
+};
+
+enum mlx5e_pcie_cong_event_mod_field {
+	MLX5_PCIE_CONG_EVENT_MOD_EVENT_EN = BIT(0),
+	MLX5_PCIE_CONG_EVENT_MOD_THRESH   = BIT(2),
+};
+
 #endif /* MLX5_IFC_H */
-- 
2.34.1


