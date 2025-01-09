Return-Path: <linux-rdma+bounces-6943-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F280A08187
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 21:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE9B188C852
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 20:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BFA204C0B;
	Thu,  9 Jan 2025 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="krVDmlJv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15751FF1D1;
	Thu,  9 Jan 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455450; cv=fail; b=FnYzGBpQvRuhzLJafM1GwUgDILFXJ9CTFrkqM1bJyGmwhqzJHBWVYYgIqrmYYBGOGyzjUnhMDebeVVTCvVEA7NSDCr65FDb9ly6HNYAiHhsVI2ldlKm5PQebNmKtkwJOj3xrfbQhAkAg0WsyMgkoXQKH/+ub/eby0bDq3JtjKTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455450; c=relaxed/simple;
	bh=HhBdYvz8/tGymhF7u+gXGTfiqyauwj2WqOUTDSpW4b0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRznHmrpmBhZh+m9qqgGJYA+NZIfEUtyVaLrpn2OcVTt/U2Y5ubdNPeZZBn0a8vu1MGPhgCCgyD7SnyYobTpHGfN+37K0mcYQ+Kx2FrW5KM2k+8mxETJhnID3qjfZDaE7/9WXXPwLZv3V4rBC1NG8WoXN/1HMn6orYh4h6SUl7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=krVDmlJv; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ0jvtIeeQI/M8lV0147LJ0WnTV+DJrqB62hrrMGYxs7iqWu7NhulJKwbHfG1evbI19VpxzpS9xlK5Oiv8arX3uR+aiqtfBQCWmiG7lD0wwLG0BYBou/CYUrxW+ygHZZlpj9vwsaFsPzeDxvaTox4bTABV1gGf81vlcT1Qn5IOWxeeBJdqRUc/q9YpzNy9A8w7LMN47T3+rwUdJqXRHQpDAPO3sr7LpAW7Wbcf1NImZjyWw+iVrS5L6L0a/7AP+KhqhK2APNbLrlhgdqex/igqnzqL/seLNhqfZg+bwhdmfD6/FNMvTk8+jyo9I33433sJjXYKoMhZSbH1tiq4q0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpD6yjJ+6iZf/mkUQO2yEaDTnTFofDg6+cYL7Fs8uYc=;
 b=nSNScS2nXtmYC4x5TUwtAsPwt2CCb7W6T+h6luB9PZcCjz3SvaIJiHVrGOeKfrxTvJ279kQ6sptcuoebOC7ovlQfIw6H2FuDhGTwqIRpPFk+NJ8Xi7jaoTpmnFKVTH9tNHfw5U7sEwVtCNF8yfuxFCsOPui9nnqvlfdBx7kHzvvj8qUbUc9SfnKZAW6bAdmLsNoQh6XtGRZTAB5+sIpi53k9iSCLLHqaUaxMYGvwt5pOaBndoLy8IKXe4J9HINlzacDS/vPv59721gAU4b5yaQFxD3gPuTIynAt2+3tryH6yH8kVS3BgG9cOAj5PHmQ1jFBtkEmwvBcO0hHQeFgiJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpD6yjJ+6iZf/mkUQO2yEaDTnTFofDg6+cYL7Fs8uYc=;
 b=krVDmlJv1H871RHmdTzfdBTkqcFRrZiUWGIF8+xiv0MQOKGY26QnU27YxF7BVytnvihkRpC94W8zdrjqQCFIikipudgL0/LbaYPFbsqZqh9zoaq87xS/A+moIgnK6KEWNFAH89CnJJAErLtF4f4QDpl7HLt/+Bp107YDzvtnG5k+uAybBtokSDYI0S3kqzJQvC2Ff2bbuhbq5ojlYsjK9GILl3QT/Xf36IoKEPsS4ytTaED2bK+nKNGVqxXXvCqkUxf6agJnQwsiejHXlqOXeRDbZV8m3ZIvPF5tEF8i2oSP2YDcGZRqAei+gEtjj4+M35FyNyRo0R/0luQyQLQ+Kg==
Received: from BN9PR03CA0464.namprd03.prod.outlook.com (2603:10b6:408:139::19)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 20:44:05 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::f0) by BN9PR03CA0464.outlook.office365.com
 (2603:10b6:408:139::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.16 via Frontend Transport; Thu,
 9 Jan 2025 20:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 20:44:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 12:43:57 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 Jan 2025 12:43:56 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 9 Jan 2025 12:43:54 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Akiva Goldberger
	<agoldberger@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 4/4] net/mlx5: Add nic_cap_reg and vhca_icm_ctrl registers
Date: Thu, 9 Jan 2025 22:42:31 +0200
Message-ID: <20250109204231.1809851-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e2b024-31be-4372-5409-08dd30ee5bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tdZqx5AGgjqjbrdgYp7j74ImtnuXfLNa3BVeSp3kysSv6RA12E9PKZM0et3L?=
 =?us-ascii?Q?n0fiTXvmTeOrV0gQ/f/exZbAYQFpchvZvfzj+gvpma/tdbTynxkYTccHFyDf?=
 =?us-ascii?Q?nZoDr4CNEX7d0ycqHITz4YbenrPhB3e1MDOvXz/LpeRxQUU/SIRCDFIm43Kr?=
 =?us-ascii?Q?z+pSEIW75cd4vtSforHpKsdr99yQJiFKY4K2B86dABBvP8vlJ2Xsvehowi8z?=
 =?us-ascii?Q?bkp/IcLrfCt52F3r7He1kp2X3OvVAfNnREMja65QVSXkgyT2XtIIvT7EBXUT?=
 =?us-ascii?Q?voBxJ35C05dGn5UaUAV52WwLnvE1gHy5bc3fvb137MEoUkAmomghNVJFj9qs?=
 =?us-ascii?Q?0NcDEby+x5vTw6gdtviev8uIIKTb7VJX0GtiQyUplrmyxGjxSkZ4JKh5prF1?=
 =?us-ascii?Q?4EIay3XF1WouWUYiy55temnqW13H+6WW9Cd43QMxBKBF7I90h9DXjgPmMfSN?=
 =?us-ascii?Q?xxF2PdSk2IjCYVpDLFWWhtW1lWz/P6bO6GsLzPtlNql3gqYQ5pr00mQvKfg3?=
 =?us-ascii?Q?B/V8X+5zJ8tcfKYSm1p4QosxfH+/khtUCwggsyV0W9LCJm6PqEYmLoIjuiLj?=
 =?us-ascii?Q?cR/ryuYvqmOs5nw/nck5At8z+orrKgHWkKejx84pXHj9iC5A+1QGgkEtPLq5?=
 =?us-ascii?Q?1Z0m5HRw0KD2FvxpyVzR34zUFIX06Pky333YbEYGcObfmT9qjGuCcL4BLEA8?=
 =?us-ascii?Q?/cnOFEQm0cIcboX6lfX8gOF+2JD4aaPlIiiTFNlOuRNZp5dDuRj4gNhL6Ala?=
 =?us-ascii?Q?JiICzjFr7uDgqr0xz4ynR3VPmjHgwod89C4OARyrOXOS2oeP2LAoDOkBNpl0?=
 =?us-ascii?Q?1hir8laZtSAkYj8pTrJ+4IL+EHAP/QdHHYknlI8o+cql0rLc4zKNgEIOx9Nj?=
 =?us-ascii?Q?TWEqjI3FL3QDHhuVlWgJ3nSewUUX+dIJVFP43hmzBd0/hlPdbd9eu5R89UK0?=
 =?us-ascii?Q?7/aCDC9YlrRreBs2JiTzpmIh6hW/WfFZTHHQKe3pnHCyfQcYZw1OHrlfDuAD?=
 =?us-ascii?Q?0Wa2AfbdrTVBy3avtEVmHWtlOsn1jbzPzY/0RUZEIFQ67gwqMBSOsLUGSYyH?=
 =?us-ascii?Q?AqWlFn7V1WY3UT5DeI9C+0wuYpDGrVj0G0t3OynEfpwwlxsIxIMqJL1Tlk90?=
 =?us-ascii?Q?4tjg+flYcjVuPpYLB1pPEFWgD/QQErgxLodRTn5bawXSTyxQbCRFu8fLosFF?=
 =?us-ascii?Q?yI2e6NKxwQI8FovS9Xe3fXeX1vCGjcr1sQwB6YhtgDB2HRuj5GT3QTeehFDW?=
 =?us-ascii?Q?2IfnLvsdTlxec14TRFxQtoTmR4gUJkgGrZffmktS3vniZy2TjVKcrrZvHmeB?=
 =?us-ascii?Q?2gIP5/hGxJQHIq4hQD6DcUVjRAZclx7fmMsJk5a6+VMm1PSp3xYUPEodRFyx?=
 =?us-ascii?Q?e8DvhnOSuFptVdBhs7LYosh8Qi7RImFxLRpfapAW6bx5vbEP9M4zzxKsJ3H5?=
 =?us-ascii?Q?dXWjktDreeHSSFVWolGnM1q2pqwHRSWusdGL8fEa1MCsbL/gH6pbrnZJeYsm?=
 =?us-ascii?Q?9ozVw66sHal57Ug=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 20:44:05.3694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e2b024-31be-4372-5409-08dd30ee5bb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715

From: Akiva Goldberger <agoldberger@nvidia.com>

Add nic_cap_reg and vhca_icm_ctrl registers interfaces for exposing ICM
consumption.

Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/driver.h   |  2 ++
 include/linux/mlx5/mlx5_ifc.h | 22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 8f6fe29bc4be..b957391529b3 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -163,7 +163,9 @@ enum {
 	MLX5_REG_MRTCQ		 = 0x9182,
 	MLX5_REG_SBCAM		 = 0xB01F,
 	MLX5_REG_RESOURCE_DUMP   = 0xC000,
+	MLX5_REG_NIC_CAP	 = 0xC00D,
 	MLX5_REG_DTOR            = 0xC00E,
+	MLX5_REG_VHCA_ICM_CTRL	 = 0xC010,
 };
 
 enum mlx5_qpts_trust_state {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index d7c91f152735..2a40b1fd50e8 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1830,7 +1830,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         regexp_params[0x1];
 	u8         uar_sz[0x6];
 	u8         port_selection_cap[0x1];
-	u8         reserved_at_251[0x1];
+	u8         nic_cap_reg[0x1];
 	u8         umem_uid_0[0x1];
 	u8         reserved_at_253[0x5];
 	u8         log_pg_sz[0x8];
@@ -3327,6 +3327,14 @@ struct mlx5_ifc_dropped_packet_logged_bits {
 	u8         reserved_at_0[0xe0];
 };
 
+struct mlx5_ifc_nic_cap_reg_bits {
+	u8	   reserved_at_0[0x1a];
+	u8	   vhca_icm_ctrl[0x1];
+	u8	   reserved_at_1b[0x5];
+
+	u8	   reserved_at_20[0x60];
+};
+
 struct mlx5_ifc_default_timeout_bits {
 	u8         to_multiplier[0x3];
 	u8         reserved_at_3[0x9];
@@ -3363,6 +3371,18 @@ struct mlx5_ifc_dtor_reg_bits {
 	u8         reserved_at_1c0[0x20];
 };
 
+struct mlx5_ifc_vhca_icm_ctrl_reg_bits {
+	u8	   vhca_id_valid[0x1];
+	u8	   reserved_at_1[0xf];
+	u8	   vhca_id[0x10];
+
+	u8	   reserved_at_20[0xa0];
+
+	u8	   cur_alloc_icm[0x20];
+
+	u8	   reserved_at_e0[0x120];
+};
+
 enum {
 	MLX5_CQ_ERROR_SYNDROME_CQ_OVERRUN                 = 0x1,
 	MLX5_CQ_ERROR_SYNDROME_CQ_ACCESS_VIOLATION_ERROR  = 0x2,
-- 
2.45.0


