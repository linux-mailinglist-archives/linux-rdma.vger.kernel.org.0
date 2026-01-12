Return-Path: <linux-rdma+bounces-15438-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA307D10C3E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 07:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76E6F30B40F6
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 06:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A4631985C;
	Mon, 12 Jan 2026 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aif492j6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD1313E33;
	Mon, 12 Jan 2026 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200703; cv=fail; b=PO7mJFSyFBuDM/hOTLOmS/RTtbHw0EShIDuZB4DbJu6aCI7hlKw4NcukBE/Kt2pdNiXnGtPR6xyiBE+OOqbn0qDIcZmfpt34U5LdHw5Rv7lJIMN5NNAbuVBbXDsIeGy3iN4efSw+MT7KndgnSD4/qV4A/OW6afXNY6sYq+wXbsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200703; c=relaxed/simple;
	bh=neHwEQDoQjlbzNSJPUHL+hqRAc5bLmbymjBaGZA1pQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H/29HPRNmRC1CgjUXl6NWnXRfMoZC0F76ZgraPz1Mt9PFwStB5rXTrRAcRbxkrAljBYr5+tQithDGGRLHgleAXkAQzxtjcTzS7Ty0YPFrLTxDwZ4dc/pALYU7xUqyqXYd0Tp4AQtenI7uoO0nkPIc7UuAD74MOKmszxaUd4H9W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aif492j6; arc=fail smtp.client-ip=52.101.61.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDCq5AlFGpiwRgaxLI6C2muVXSIrsDbg8pyIdsHCW1en2HrKYkwqijTlyoiCeu0YaZItdpqDIfGXtI7BYphHLaeMzb2Z878HnHIPLjjPgwrxk6r2X6xdqsTTdxYmLxiSJvwcMnr1qHh53QnyBWuMOkP8N7/N5hmkZhleDIv0qGyJawbCXIRfNt85atq+t1Q/mza4XziqkrZyqIaCfJecOYmnZFKKAK2IU0492yp4Ih1+ga0tlnqBZD8hkVsKv47WHKdW3ltkGTI+br6LVr4YTEQexVXF03Mx6sH/sy3C8IoMRPr81+AcaBGUtgaBeHVPLeb6AfYgoBoPdRKZGYtEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NNZ5/a3nDqHUHkYcWNDUMGgG59tn8CE8v3O0Mqv9OE=;
 b=M5CYR8YTBA8d7w0dqnwHr9rBgchAZmtMLevga8CoZD+u/wuSVWsdvObx64vWX2Th7LpCNx69HmfZo05u1dMkRWy88I5k9ss7XtlM2uQhT4S+VJLtiVkNo4eEquB2B8v1wnQM+x2bDUjtW0pwiHrpeidQDr7VLGePGgRsf5RpfqBSqHFZl7erSaxG/EuVifQSfQPtRjITBL9GQFOdaKx/DagiRLrAB9fLKmT0ECcQItI2LQtHIGBdoE00FuIx0Mrij1p6eqp2rCl3Gll79Tx+FnrcVvx6l5XlA5ZKxN1o+EdGlfpLHpPgW34sVjme2DRWsUbLzBYxWRfoi7HVtnNE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NNZ5/a3nDqHUHkYcWNDUMGgG59tn8CE8v3O0Mqv9OE=;
 b=aif492j6xkrAMwTrM73XCzWQKIoigA1LooFLx19sAts0QfEul1brPdK+1myFFQjgJHAG/mqT2AmjZOipqOw4sS6bvp2Qj7wF934fUHjyRNm4yKeRjZWWj4yLQ7Wb01EOc6apwJCvFS/yMNXYCH2UioTSLxCp21jwmUzuNuk63iOf4bXqtMMVzboOB2pOvboHZPJYdd8vaUKWkd67Fov9yAdXXZl0mKBJVXzRhIi4hT0x48v+xZmu6Znow1fKVFZRjUZN5Aq9oJe1HLRhRUflEWuUoLABQ+BrjuoaHThYhozTk5kBDWn5gplig4l0HyEQ+Sb2b3xK0O53+IjaeXYtDw==
Received: from CH2PR08CA0018.namprd08.prod.outlook.com (2603:10b6:610:5a::28)
 by LV5PR12MB9755.namprd12.prod.outlook.com (2603:10b6:408:307::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 06:51:39 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::c8) by CH2PR08CA0018.outlook.office365.com
 (2603:10b6:610:5a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 06:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 06:51:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 22:51:20 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 11 Jan 2026 22:51:20 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 11 Jan 2026 22:51:16 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, "Alexei
 Lazar" <alazar@nvidia.com>
Subject: [PATCH mlx5-next] net/mlx5: Add IFC bits for extended ETS rate limit bandwidth value
Date: Mon, 12 Jan 2026 08:50:08 +0200
Message-ID: <1768200608-1543180-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|LV5PR12MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: c76fb72f-271f-4b6e-da41-08de51a7096d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JrXTlEzIiIXs8MlhDtzxt3ImC5742i2SumPGkyebOk8XosnHBbsGtm9NvPSS?=
 =?us-ascii?Q?+YjxBvypruLDzqPN6SdrgUfjh+W39nNkRdN2V2/5GE7dr3//69TGfAEPPwvu?=
 =?us-ascii?Q?zDry/TgC3K3RvBs95ZoYSKteIndjpaxdfF99pYSwUENG5ULl196ct5hHvvxE?=
 =?us-ascii?Q?Cdmn3Tv0+X1nvC78XsIz6z8JHbwQOfKTd/LPzTAQoL0Y7EfnkudTQaRj+tLu?=
 =?us-ascii?Q?kYLcrRRBwJQHmdrLxZSnjM4iwaCV90uibDyAuNwuUdKE6xp3yA8U3WFVbZgH?=
 =?us-ascii?Q?LZlnZe7YqjjJoeS7LUSNGBLsOuVLgpWYbmaioK09ghLIcOGj6pJX0PbsorwU?=
 =?us-ascii?Q?vFqx3g2bRum2je3qhqk8qgdglG6BUU0hhtx4f5UqsJ4j2xosku341oHRb9EJ?=
 =?us-ascii?Q?ZmBIQnBcSWSM299yL2ef4W/cDRFluVjFhsLclgj0xtMdXlBjTE53+iarrIEM?=
 =?us-ascii?Q?63U7hJeDr5q7B7fNrGWbHI+KBLy9efc3ELuBxSaMdbyDk4On65Asayqz89yk?=
 =?us-ascii?Q?/XBNdnYNs1uQCTftHN7xDjo8imZnJOzXKIT2GzzpnFEnrn8275SSrHMhG51g?=
 =?us-ascii?Q?3XMbtPgw1ay+SDMtlQGLSTbz1TpK18e+Kt9GrKoyAPIvLMiLdWjInmJyaPx/?=
 =?us-ascii?Q?QNnt3lkrWtI2Slt4UWww8J2GDDLdN5BjagyMaCsiEr3Fh2eb0Uwu8R7ZZ2O2?=
 =?us-ascii?Q?KbSObNxzDmWE3YfjDRwpxHhdPdJHiDKHkS14GuWRdfXfSmQMgA4ieu0r7/+W?=
 =?us-ascii?Q?Id9RtMbXwq6Z9SeTR7oczFRIT5VQnuHbv9rB1utqksfFwVYlorlXoqJFaVAh?=
 =?us-ascii?Q?AjbbhVty00W6CVF8njOgMz8XngP379IKPKOMWzNY0jN7xdIq4WYw1ZBYMNg6?=
 =?us-ascii?Q?4zbhwXjqZ1ZFA57Q/q281k9zI+EWa86iyGYMev31mwsLCr3o2faCKVSP17zF?=
 =?us-ascii?Q?XHhbaQjoly6jazjV7jrFARfLSqhUyGqay+KW1L1vvS8KBhXl77mjWhBy2T68?=
 =?us-ascii?Q?vo/oiyDBSgrpMcl9kUSkDQ4wGlE9Lcw/DTwRVhfdRB8uWh1mZigoktHJlDWl?=
 =?us-ascii?Q?2D9LKSZFyAXkMXGSmWhJ85xuK22bB0cISFdUbK4vdDazD+7JB7HM7LSt0urM?=
 =?us-ascii?Q?sBd8XBI8H56LxnuYqB9rJlVvsEpp23lc/5hMkXNOPQ9ckQBsYjsl/ZeYmfr6?=
 =?us-ascii?Q?xQMYGWPB4vfKd5KuelYGa4n4l2jw6BTROq59ff2j+eei18yLNzTvgHMkmZ3I?=
 =?us-ascii?Q?+F/YliRr9RljyYK7zrw77EzbLCFd+SoffFf8UDQE5q2ol91VqmLidT6+Rdjb?=
 =?us-ascii?Q?eb6l6FSUBqwyTrjAyjpl2hJXk/6x5AjZ5SIY5yKNKuK+U8hxvqrcRpD7WIZs?=
 =?us-ascii?Q?yN4qe4O/T8s92+Ozh4gxva28wBFBC3rxqso5uWZzzgSHZmjVwvKrxCOAGDx1?=
 =?us-ascii?Q?bSjfemhuHfq8NBZRGyst6hA7z8i7baj7EvTF3MUlhv4D3vqjJjmcKTizcJJc?=
 =?us-ascii?Q?nVqyF+kYV0GE0qTgd1sZzfTNHg26Ek+SRQHT0SzYja0E12Zp5Q67Al9duIP5?=
 =?us-ascii?Q?FRUpGiGCjO40Bfv2lLc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 06:51:39.1439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76fb72f-271f-4b6e-da41-08de51a7096d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9755

From: Alexei Lazar <alazar@nvidia.com>

Add hardware interface definitions to support extended bandwidth rate
limiting in the QoS Enhanced Transmission Selection (ETS) configuration.

The new fields include:
- max_bw_value: extended from 8-bit to 16-bit in ets_tcn_config_reg,
  simplifying the implementation by using a single field instead of
  separate MSB/LSB fields.
- qetcr_qshr_max_bw_val_msb: capability bit in qcam_qos_feature_cap_mask
  indicating device support for the extended 16-bit max_bw_value field.

These interface additions are prerequisites for increasing the per-TC
rate limit beyond 255 Gbps to support higher-bandwidth NICs.

Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index e844cfa4fe0a..775cb0c56865 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -11009,7 +11009,9 @@ struct mlx5_ifc_qcam_access_reg_cap_mask {
 };
 
 struct mlx5_ifc_qcam_qos_feature_cap_mask {
-	u8         qcam_qos_feature_cap_mask_127_to_1[0x7F];
+	u8         qcam_qos_feature_cap_mask_127_to_5[0x7B];
+	u8         qetcr_qshr_max_bw_val_msb[0x1];
+	u8         qcam_qos_feature_cap_mask_3_to_1[0x3];
 	u8         qpts_trust_both[0x1];
 };
 
@@ -11965,8 +11967,7 @@ struct mlx5_ifc_ets_tcn_config_reg_bits {
 
 	u8         reserved_at_20[0xc];
 	u8         max_bw_units[0x4];
-	u8         reserved_at_30[0x8];
-	u8         max_bw_value[0x8];
+	u8         max_bw_value[0x10];
 };
 
 struct mlx5_ifc_ets_global_config_reg_bits {

base-commit: f0b2fde98065e49795ce6824837b3f53fdf16e5d
-- 
2.31.1


