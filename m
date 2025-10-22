Return-Path: <linux-rdma+bounces-13972-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6158BFBDA7
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 14:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EC018C7FD2
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA0733FE20;
	Wed, 22 Oct 2025 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PZA7dFLK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061937261D;
	Wed, 22 Oct 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136243; cv=fail; b=S+KLFjjhilOdUhqK18oEFK6L4UcurucSwHDEtUvlzjjdMeSM2SsnxE0PlQ7B8mCrM7yITMAjR4AJCOcSPSHV5BcvmkX8SzIj6ytEQrIKsDsE5bleZW0FMNC3gv1OGLsUD//GxXoUBuvq3jAUjR8WAhIrdrCgNdDGnSTPWvcLYEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136243; c=relaxed/simple;
	bh=3lxwLFoFYlgAM5tdIyVEOyJXooYWc8zeq6wTlnODxAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cI+OpqZapoSQKQFOKp7//XurKYo9F6gHgiMrOCRBgvTcquS1QEyf5li/vl62Cd+7YO01h1gu9Dxp6tO2r7xFJD63V1g8l/TNMh03UDGFRs6zVkOUALF/029o4PRDosBMPw/9Ubt+OK2PmMlVk3YYzBd1L97tmjxIkDPE7nKJLBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PZA7dFLK; arc=fail smtp.client-ip=52.101.43.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mk8lKvYJHwQRyGci3Rwlan1vpjun9LyVuJgf/wzEeNGudppBzYFozlqNkLdoVH5siEkSYjQu5KvAXXiG6a4/Hd7LY510D3mRtCz0X7B0VYXR/viy0R8XJ/IcySzBR/VOTRGT/sncvu2mJeCBWkSj/dzOWiFBGRVFgTq47biszwPFG3dzIHPA8mzjr24iTVKyTgPsQPqpWQSTXbIYj3pAJasAyYrK0POeEkhZtcV1HclFrCObUsSHei9GmF5yGuW3Vqp3U1Gbxh2ELWyizm5dqvk8mBlCd86rODMUf2GPwcJ3G+pZz+peOanXtnsg+NJIIoO5cT7hlPZNKqBxPo5hPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5uWx6AzDXVZ0QR9yCN4ldsWouYELAwAXCrp1ek/P3Y=;
 b=aw/CnRpn0+OOwgtNyKPPXOTFsTZDT7NhbIPByc9x2Yuy/m3btLB3ME1uWRHu8QbY/30seGnsigjem6iEWJoD9x2Ub4zs115UBrC0BHKLZ+fsjcCCNgLfnGfxLBJuWJMWVzqkhxVduMTWQUGUhTxCGHj6YIFisfAW7bJC35A6gWgf1BOgjJITn5IxxMepkRZkUdsahkpiPvumZGd/d+gcH5YhnIaq3X6QlDP60XOxIFzPAg4LI5Kx0pzTlNDHHyLTlvDLWEK2jBxhVA/+NnL3NUPeUDjLXCjyIDXxzy3HMzikNkxzVWXlGNQm7C+KD/02rxR4Oe0SgSAP2ez0KAZoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5uWx6AzDXVZ0QR9yCN4ldsWouYELAwAXCrp1ek/P3Y=;
 b=PZA7dFLKzhJbcsS74GFvh9CbAGD76u4yIgQI14ddEN48sA//7gxymfEVMuX61TG8FTmeu4rlOd8thVrWKs24r9GuZTnoNGoBxmY1x/17oeMLCZ4gAnThhV58xUM8Pv4dnGFBYwzHh7N5w8EwCeGYoi7802f0X39ORrFeqHV1Z4CjE8DogmQRfVqK6PLsTJFe1Tje0boEbIX25n6XJB6g0OPeuSuHGY5js7NchJJMfZrB9EBkiV6P5XXWFLjgoIizOShqrxWSn44I9BSrJV4gGF+wE4lFIHV0zezpOc8y0UwgWyb5QEngiRWjWqvneHBPmefRToyohgZIqaR4Y806Kg==
Received: from DM6PR14CA0063.namprd14.prod.outlook.com (2603:10b6:5:18f::40)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 12:30:35 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:18f:cafe::2e) by DM6PR14CA0063.outlook.office365.com
 (2603:10b6:5:18f::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 12:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 12:30:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 22 Oct
 2025 05:30:18 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 05:30:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Oct 2025 05:30:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Alexei Lazar
	<alazar@nvidia.com>
Subject: [PATCH net 1/4] net/mlx5: Add PPHCR to PCAM supported registers mask
Date: Wed, 22 Oct 2025 15:29:39 +0300
Message-ID: <1761136182-918470-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761136182-918470-1-git-send-email-tariqt@nvidia.com>
References: <1761136182-918470-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a73a1a-eda4-42a5-6ec0-08de1166cd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p18iZsxGnhuIVVs9lkCQ8nGBHH8Uit7nJ+I90bLT1Rr+HOGLcapLXCFu6gtB?=
 =?us-ascii?Q?EdWxg0CiHdGt+AH8ctrxqpr277sOwThwkEaNll10ph8o6vlBjw8k+nGGprNB?=
 =?us-ascii?Q?x4OCQlOm+AjjSJfTc4kYqOR8UXUy42gSWKCukhEmVEtq9xR3IUQQKQdgSwIY?=
 =?us-ascii?Q?N2PwRdOt/+GeaoIi1bpu8sPE9ulmT3lmKftrC0l1EIIfLKynpxxkd1wZ/fZS?=
 =?us-ascii?Q?sGb8zJ5wbXfsfeFvCWruaqI5SBimN3Nt52jInHEwGVu00A1R35OKozGnQCgZ?=
 =?us-ascii?Q?BJXnkgqDk+HQdP/mQtknj3I+WcICUiyoYsDs8bIiZqvQfj+G/J04GIweBUtB?=
 =?us-ascii?Q?wl+IKlqxmZUaruWevqUqFBtDTS5kxLBLaQ5q6maSOmdHqrIHgsC/jsMNIJep?=
 =?us-ascii?Q?kVXtuh2yhdG7PqxudoZvlP9foQu9LbMOYMRuvPrbpTGUn3OVH/0fUuqS6A2K?=
 =?us-ascii?Q?6psJXz26uVZ1oW5AxVFBGZTtTc7JooKkZ22DQk+a9UxSnQeSqaHdiY6kpFEi?=
 =?us-ascii?Q?g/hoOSKYFvFHqbGfbJaiHSaAK/OxK21hHYYwpq1cSRhj1y45ADpdmYTTZ+ae?=
 =?us-ascii?Q?45VEdz1TRqCGjVbW8Lj/U7XPiHUHYcC2infj1TkhlZIdrm6WkNIp7e1pCAKm?=
 =?us-ascii?Q?S5z6zZnDSf5ukyQDMHEWYzkS8pL5Cu6rMybf51F0SX4KXavRsVkEaqVakVHc?=
 =?us-ascii?Q?FaX4Pr5eRQLyyjAnVFYYCaV+PdIEyWIg+5XXcwL2q1QzTGwGX8BJnJywgy34?=
 =?us-ascii?Q?FMMflJSsr1sQt2eQuJ9UarmZCV1kws9rpaSzXI4YeyLE1Aq+P9ZGrl0nivIN?=
 =?us-ascii?Q?j54VbOYnWA+8BbxRQH1DWfjA10DBaAIbIQMPL54iUk64XznlRVt8H3ydNYK0?=
 =?us-ascii?Q?1NuSoR7/c3t4pjIX1knrwvmzfNJLilr3QEc872IYdCd4oLOez+BZwcD3sBor?=
 =?us-ascii?Q?aOblUQKjh2DWejLCZzs2LYAS4cfPmV8ejCcKN6Lm42s4k5Z4YW2Q9/+MJ2CD?=
 =?us-ascii?Q?7FUb5WhmftRmvslZceB2/ybDtQranE6lTDDmWXmOmNO0xpFc8mAYaasCFIh1?=
 =?us-ascii?Q?YiJdFCu4/X1thrh5/BMY8w5vaC/7k0QTVh3DpuO5NkDpQ7Z6qoZBox10lRE8?=
 =?us-ascii?Q?olvSk/LVpfdABoN4ERwsIOfCJMd6k0RkJlDEa67YbglX3hTfn4xmHhXYvpS9?=
 =?us-ascii?Q?z9MeqlD/cHrIZbKT98jq/Z+PgyQ3J6tmOGPRvHN/ntg76VdTXSnsvxn1DOGN?=
 =?us-ascii?Q?wI5nHMADUfDcaae1AQVUoSH2AwvPHlpqBDGQFDckQ3Pe0AWBbIY9KU12Oxsc?=
 =?us-ascii?Q?xDquf1J/mtMVW9c57sjzGNuHe0fLSxJ5uTyj5VLAfUWXASNFouc1o6zIHF4h?=
 =?us-ascii?Q?7aAD/akR8ayrl278bq8Lvj/wImCp3d1b/KwbgeCa5QANf389Un0nNjNh464K?=
 =?us-ascii?Q?BadOT/HOG6qHh/AKrPoxM9R3p0wyMYY5YCybcnqPw5znSEM8KKa2YYkaCESJ?=
 =?us-ascii?Q?w+GED+Jidn3R5okoU+BBQzqMhhFNEDXEgtLUik5VMsXAgpkUYG5JZZXUONbl?=
 =?us-ascii?Q?rc007gucoBglPm7GeLY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 12:30:35.7443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a73a1a-eda4-42a5-6ec0-08de1166cd1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

From: Alexei Lazar <alazar@nvidia.com>

Add the PPHCR bit to the port_access_reg_cap_mask field of PCAM
register to indicate that the device supports the PPHCR register
and the RS-FEC histogram feature.

Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 07614cd95bed..1b0b36aa2a76 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10833,7 +10833,9 @@ struct mlx5_ifc_pcam_regs_5000_to_507f_bits {
 	u8         port_access_reg_cap_mask_127_to_96[0x20];
 	u8         port_access_reg_cap_mask_95_to_64[0x20];
 
-	u8         port_access_reg_cap_mask_63_to_36[0x1c];
+	u8         port_access_reg_cap_mask_63[0x1];
+	u8         pphcr[0x1];
+	u8         port_access_reg_cap_mask_61_to_36[0x1a];
 	u8         pplm[0x1];
 	u8         port_access_reg_cap_mask_34_to_32[0x3];
 
-- 
2.31.1


