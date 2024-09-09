Return-Path: <linux-rdma+bounces-4822-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD329714CC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 12:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEEE01F211AA
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434D51B3F2D;
	Mon,  9 Sep 2024 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gGR+BJQp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B421B3F1E
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876332; cv=fail; b=IbVYGMaJLtMdhNwxK42SKmgXvOcKpHPVQb7Q/TDMkF/atR4Yp/nHvEelBSE/dNfYPtUTXW6muFRME/FxDfDUCFspjPICOw9L4qjsGTYM+zZ19AIdeKV8zEkuaYa9Cko4b0735E2bamLniIuDAfvaUVfkMJ8pACWrDdyVDvVE+Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876332; c=relaxed/simple;
	bh=Orp6Tp08ADKQDPxJj9uLRXU+fVBRCYmlQ3AyosyNqBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSpnOMlAaDMtjJCFSVwc69l4nU5X6TCxCW1JKdzfUymK8nejstmNKAQTHuyDos88dOCi5O6Qe6BL66eJhoHAkcGC+E0OfMqQZLGzBfUDRHh/FPnixWKKj7x5JcwPlgITTra9uwOXj5qnln1YbhiFpB8NHdtHZbVhgXac3D+BG68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gGR+BJQp; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfZ03ZNME6yX6w0OhOM/C0HI5orwxOucNCpoguoeNJV5WlpMzK4np2w4mnWTZQ6oJsdb2U3HQRrpDYA2CXubmzBF73igYPZTIdDCUA4jrfFDWF5/Ze1T2rboSuBgsOf8sRYNiuHSbobH9olAdHmhV+flLPKk56svUBs3nUssPgR7EKpcGItIj0+xOG9Gijx8r+mHphBhFlGz3yrV5YhEo0KbXQ1BmTlwE3kW8jFHFTnnrnXjmSeAzKqMIPVhzVybx4VQmRVU6oUuvmK09w87b8G0JXX7HeLuBJEQsworj2D7XML8pw7FJ74TvyzFVM91BjgX5rMk8SA1KEMiRzICPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sNVhDYjlljuerZ0wXeb5L6zpj0qjcPMA7qjC7b8S6I=;
 b=vyHsSbUbomDRdEtQhD5NaE0SNDF6GKHAH9RJTk1wcg5diCpUdicLmRsz9Dtp9/MPTEGiCaGRZyGaWo5pyOrsVW3w3dfrSuPWYisd1GwCVIhkkTwpfcCgzZWQY9qXhmjX6uVliqIQnyflCg09b72RiWZW1tWf7ELI8bhG0yAO3L2ALUdNqZUQpRc+phdkt9QRFBewlFU0FbZ9K6K7yp1EBbGelOikGfjB8W8L8NAoPOWLyL82NSgpU1OgeRFhG938MWFAzxZdr+Cm9reHCB8BXQIlw5LUSqN0N2qmoSEqri4TTYlcsayrghzg+b9700hIoj++94E5FrMIVuseJI2wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sNVhDYjlljuerZ0wXeb5L6zpj0qjcPMA7qjC7b8S6I=;
 b=gGR+BJQpsHsKUeebZzG088vifkRnQBZ6JAWZB71j4szmcR3zfTXqq71+Nkbl6jbImMvB66k9IiwZHIZg9aDY1v2/384VgHwBc5AJVUqcU39+/ThVYZC7JlXif/g3WO8yPw9yGCcP+EI9UuG0TbwhvVVeTo2c8oN3wSmiHN1iigfLURI718KzU/8ZNwkTGCzj56z4fqpbvbKhaEqBwWN7pR4UTrQY7PcpshMY4yaW9YmJ0MPUMbljbhGeo71DWFE41rGpLlPffXd4bW4x6mjVkZDmtRiGYo4GOOUWMrNybdDbhNuLYszCDXEr6JNV4Cryh/dhlCKS4JiCXD82BeWpEg==
Received: from PH7P220CA0077.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::12)
 by CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 10:05:25 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::31) by PH7P220CA0077.outlook.office365.com
 (2603:10b6:510:32c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 10:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:05:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 03:05:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Sep 2024 03:05:12 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Sep 2024 03:05:10 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 2/8] net/mlx5: Expose HW bits for Memory scheme ODP
Date: Mon, 9 Sep 2024 13:04:58 +0300
Message-ID: <20240909100504.29797-3-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240909100504.29797-1-michaelgur@nvidia.com>
References: <20240909100504.29797-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: bf78a93f-b340-4edf-ecd2-08dcd0b6ec90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jailp0+qiAXjGaDprN/l31A2dSxweCos5gzy25hP3nU1pLqrQUfHB0ypa6Yr?=
 =?us-ascii?Q?nFKMpu3n5zZgGs8aKQOkNaq3TCGvqD43Ec7sgJsDXQQDyb/r5o1oZEbFURwX?=
 =?us-ascii?Q?xHq2M0p+7yH6yiaLxlc9zHWCFXii8g9D3IHyNMQLE6K1GfVzYZUk35Mjxqez?=
 =?us-ascii?Q?pzrj+9cCZY/DuO2BtvO0dVadyCkQ9IZ2f7ANb29/PHNEeBkK+hc6cpeVlr/V?=
 =?us-ascii?Q?qCgsNkellt2Gug5JQKEUL5wzk5S/ECQcHIRxZltfbO4VgTQAvT7esJRtgQks?=
 =?us-ascii?Q?3klCsPaRePv//0C8oNmj5aDFVyY+MptE0B7mDJstlk0JFgqocIOe/5V23jtz?=
 =?us-ascii?Q?kQiqu0tdsOKyPY7pHr3tZLFNlvSgHzCBaW1CzTxE0ZcU4QjPTS6TV4a2UMDM?=
 =?us-ascii?Q?eawBSphRigngRZESNCTMB1257xlh2iRTDIuTAPIHXuTFDlUZPj7fKqJx+xX3?=
 =?us-ascii?Q?zzvrmiDhMgmXQzvlQXCBoojzIJCGIphg9arZtBT7+OKJSL+lD/7WaEt7e2O/?=
 =?us-ascii?Q?h1fnBFiTjElZhvywZEMyTaQvTsbnxuO+Vyp7ZsOMnlqcrpmxxzsb+GZRu5xz?=
 =?us-ascii?Q?DDVM+JDpxR0KGB7z4jrwB/0irUOAHaRl8moWeADTiLot9T4GwojF6spCF4na?=
 =?us-ascii?Q?yBss69NJ+UmGi+uA6QvKvxZAMd+E61cPAR+RXG8DC+ZROg6jimFWdACTCNWu?=
 =?us-ascii?Q?ce4JdqCJ27fDI9m52Z8FwUqAhsoYTO1dJnIJ70IjTEOzfjde+beTdo2qEq4B?=
 =?us-ascii?Q?5HOBKTRsDu2bdgn8vbXRnnfdeQCj16hbquRADtuXuxkITZY07/F+N8M2TJnN?=
 =?us-ascii?Q?YuHZHx1Zr+WpEBNSiuDNNHFvuSMzaTY4WbbCwWqPTF8lhoyHhN2+fzPhNJJI?=
 =?us-ascii?Q?935ykiaI/y/yGz9g4m+P+JS6hyxRM4zKijYipxlQOpYRmn88vNoTlhR1+hbp?=
 =?us-ascii?Q?WXOyHzAzrFIHUa162aChimGYIHs3urXvPQq//kqbgse3kUjr/Bp4vCvOibzE?=
 =?us-ascii?Q?e2ugTSB3fqQteReHLrEYwpQOCIBqw7KTJ+YaJXXCMsYW9+ebly3yYntQTBui?=
 =?us-ascii?Q?9aLybTzUehR5VgWbUramCa9TaIGWub4DLSxB+3iE7yeOSTZVgz4/t6YGYIYF?=
 =?us-ascii?Q?a2aoREHw2EnXzVFSqjxru26KQFBX2b8cgvgwTZuTowOz25I9BtG255UpWH3C?=
 =?us-ascii?Q?dRJA+y6wwJhrOrCmmyZNt3mCi1PqfsS8wtTTlbamoNvdq0oJP+fSDBnMLW7Y?=
 =?us-ascii?Q?5OCXoxQ9wgGej0R2iPbjUmx1/JN4MhS3GHQlyTN/arcXWcWrAASPFABJPNql?=
 =?us-ascii?Q?ev5Icj6h2/eW72Lm6JNtQ/IsOaqYgT6jOL8bGMWDx3CcuLUyl9loQWjH7fcO?=
 =?us-ascii?Q?hdU2ia1x35c2FGbzx8DDhBZCoNiJD0Y1WEigfPVUJ8FfmVJeEvS5R3CIPo5X?=
 =?us-ascii?Q?unb4bM0zdn2SMld2FJcjfuWli4HqIBvY?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:05:25.0063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf78a93f-b340-4edf-ecd2-08dcd0b6ec90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023

Expose IFC bits to support the new memory scheme on demand paging.
Change the macro reading odp capabilities to be able to read from the
new IFC layout and align the code in upper layers to be compiled.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c              | 40 +++++++------
 .../net/ethernet/mellanox/mlx5/core/main.c    | 28 ++++-----
 include/linux/mlx5/device.h                   |  4 ++
 include/linux/mlx5/mlx5_ifc.h                 | 57 +++++++++++++++----
 4 files changed, 86 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 221820874e7a..300504bf79d7 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -332,46 +332,46 @@ static void internal_fill_odp_caps(struct mlx5_ib_dev *dev)
 	else
 		dev->odp_max_size = BIT_ULL(MLX5_MAX_UMR_SHIFT + PAGE_SHIFT);
 
-	if (MLX5_CAP_ODP(dev->mdev, ud_odp_caps.send))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, ud_odp_caps.send))
 		caps->per_transport_caps.ud_odp_caps |= IB_ODP_SUPPORT_SEND;
 
-	if (MLX5_CAP_ODP(dev->mdev, ud_odp_caps.srq_receive))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, ud_odp_caps.srq_receive))
 		caps->per_transport_caps.ud_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
 
-	if (MLX5_CAP_ODP(dev->mdev, rc_odp_caps.send))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, rc_odp_caps.send))
 		caps->per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SEND;
 
-	if (MLX5_CAP_ODP(dev->mdev, rc_odp_caps.receive))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, rc_odp_caps.receive))
 		caps->per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_RECV;
 
-	if (MLX5_CAP_ODP(dev->mdev, rc_odp_caps.write))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, rc_odp_caps.write))
 		caps->per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_WRITE;
 
-	if (MLX5_CAP_ODP(dev->mdev, rc_odp_caps.read))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, rc_odp_caps.read))
 		caps->per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_READ;
 
-	if (MLX5_CAP_ODP(dev->mdev, rc_odp_caps.atomic))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, rc_odp_caps.atomic))
 		caps->per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC;
 
-	if (MLX5_CAP_ODP(dev->mdev, rc_odp_caps.srq_receive))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, rc_odp_caps.srq_receive))
 		caps->per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
 
-	if (MLX5_CAP_ODP(dev->mdev, xrc_odp_caps.send))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, xrc_odp_caps.send))
 		caps->per_transport_caps.xrc_odp_caps |= IB_ODP_SUPPORT_SEND;
 
-	if (MLX5_CAP_ODP(dev->mdev, xrc_odp_caps.receive))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, xrc_odp_caps.receive))
 		caps->per_transport_caps.xrc_odp_caps |= IB_ODP_SUPPORT_RECV;
 
-	if (MLX5_CAP_ODP(dev->mdev, xrc_odp_caps.write))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, xrc_odp_caps.write))
 		caps->per_transport_caps.xrc_odp_caps |= IB_ODP_SUPPORT_WRITE;
 
-	if (MLX5_CAP_ODP(dev->mdev, xrc_odp_caps.read))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, xrc_odp_caps.read))
 		caps->per_transport_caps.xrc_odp_caps |= IB_ODP_SUPPORT_READ;
 
-	if (MLX5_CAP_ODP(dev->mdev, xrc_odp_caps.atomic))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, xrc_odp_caps.atomic))
 		caps->per_transport_caps.xrc_odp_caps |= IB_ODP_SUPPORT_ATOMIC;
 
-	if (MLX5_CAP_ODP(dev->mdev, xrc_odp_caps.srq_receive))
+	if (MLX5_CAP_ODP_SCHEME(dev->mdev, xrc_odp_caps.srq_receive))
 		caps->per_transport_caps.xrc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
 
 	if (MLX5_CAP_GEN(dev->mdev, fixed_buffer_size) &&
@@ -388,13 +388,17 @@ static void mlx5_ib_page_fault_resume(struct mlx5_ib_dev *dev,
 	int wq_num = pfault->event_subtype == MLX5_PFAULT_SUBTYPE_WQE ?
 		     pfault->wqe.wq_num : pfault->token;
 	u32 in[MLX5_ST_SZ_DW(page_fault_resume_in)] = {};
+	void *info;
 	int err;
 
 	MLX5_SET(page_fault_resume_in, in, opcode, MLX5_CMD_OP_PAGE_FAULT_RESUME);
-	MLX5_SET(page_fault_resume_in, in, page_fault_type, pfault->type);
-	MLX5_SET(page_fault_resume_in, in, token, pfault->token);
-	MLX5_SET(page_fault_resume_in, in, wq_number, wq_num);
-	MLX5_SET(page_fault_resume_in, in, error, !!error);
+
+	info = MLX5_ADDR_OF(page_fault_resume_in, in,
+			    page_fault_info.trans_page_fault_info);
+	MLX5_SET(trans_page_fault_info, info, page_fault_type, pfault->type);
+	MLX5_SET(trans_page_fault_info, info, fault_token, pfault->token);
+	MLX5_SET(trans_page_fault_info, info, wq_number, wq_num);
+	MLX5_SET(trans_page_fault_info, info, error, !!error);
 
 	err = mlx5_cmd_exec_in(dev->mdev, page_fault_resume, in);
 	if (err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 5b7e6f4b5c7e..cc2aa46cff04 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -479,20 +479,20 @@ static int handle_hca_cap_odp(struct mlx5_core_dev *dev, void *set_ctx)
 		}                                                              \
 	} while (0)
 
-	ODP_CAP_SET_MAX(dev, ud_odp_caps.srq_receive);
-	ODP_CAP_SET_MAX(dev, rc_odp_caps.srq_receive);
-	ODP_CAP_SET_MAX(dev, xrc_odp_caps.srq_receive);
-	ODP_CAP_SET_MAX(dev, xrc_odp_caps.send);
-	ODP_CAP_SET_MAX(dev, xrc_odp_caps.receive);
-	ODP_CAP_SET_MAX(dev, xrc_odp_caps.write);
-	ODP_CAP_SET_MAX(dev, xrc_odp_caps.read);
-	ODP_CAP_SET_MAX(dev, xrc_odp_caps.atomic);
-	ODP_CAP_SET_MAX(dev, dc_odp_caps.srq_receive);
-	ODP_CAP_SET_MAX(dev, dc_odp_caps.send);
-	ODP_CAP_SET_MAX(dev, dc_odp_caps.receive);
-	ODP_CAP_SET_MAX(dev, dc_odp_caps.write);
-	ODP_CAP_SET_MAX(dev, dc_odp_caps.read);
-	ODP_CAP_SET_MAX(dev, dc_odp_caps.atomic);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.ud_odp_caps.srq_receive);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.rc_odp_caps.srq_receive);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.xrc_odp_caps.srq_receive);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.xrc_odp_caps.send);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.xrc_odp_caps.receive);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.xrc_odp_caps.write);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.xrc_odp_caps.read);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.xrc_odp_caps.atomic);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.dc_odp_caps.srq_receive);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.dc_odp_caps.send);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.dc_odp_caps.receive);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.dc_odp_caps.write);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.dc_odp_caps.read);
+	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.dc_odp_caps.atomic);
 
 	if (!do_set)
 		return 0;
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index ba875a619b97..bd081f276654 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1369,6 +1369,10 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_ODP(mdev, cap)\
 	MLX5_GET(odp_cap, mdev->caps.hca[MLX5_CAP_ODP]->cur, cap)
 
+#define MLX5_CAP_ODP_SCHEME(mdev, cap)                       \
+	MLX5_GET(odp_cap, mdev->caps.hca[MLX5_CAP_ODP]->cur, \
+		 transport_page_fault_scheme_cap.cap)
+
 #define MLX5_CAP_ODP_MAX(mdev, cap)\
 	MLX5_GET(odp_cap, mdev->caps.hca[MLX5_CAP_ODP]->max, cap)
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 1be2495362ee..fcccfc34e076 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1326,11 +1326,13 @@ struct mlx5_ifc_atomic_caps_bits {
 	u8         reserved_at_e0[0x720];
 };
 
-struct mlx5_ifc_odp_cap_bits {
+struct mlx5_ifc_odp_scheme_cap_bits {
 	u8         reserved_at_0[0x40];
 
 	u8         sig[0x1];
-	u8         reserved_at_41[0x1f];
+	u8         reserved_at_41[0x4];
+	u8         page_prefetch[0x1];
+	u8         reserved_at_46[0x1a];
 
 	u8         reserved_at_60[0x20];
 
@@ -1344,7 +1346,20 @@ struct mlx5_ifc_odp_cap_bits {
 
 	struct mlx5_ifc_odp_per_transport_service_cap_bits dc_odp_caps;
 
-	u8         reserved_at_120[0x6E0];
+	u8         reserved_at_120[0xe0];
+};
+
+struct mlx5_ifc_odp_cap_bits {
+	struct mlx5_ifc_odp_scheme_cap_bits transport_page_fault_scheme_cap;
+
+	struct mlx5_ifc_odp_scheme_cap_bits memory_page_fault_scheme_cap;
+
+	u8         reserved_at_400[0x200];
+
+	u8         mem_page_fault[0x1];
+	u8         reserved_at_601[0x1f];
+
+	u8         reserved_at_620[0x1e0];
 };
 
 struct mlx5_ifc_tls_cap_bits {
@@ -2041,7 +2056,8 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   min_mkey_log_entity_size_fixed_buffer[0x5];
 	u8	   ec_vf_vport_base[0x10];
 
-	u8	   reserved_at_3a0[0x10];
+	u8	   reserved_at_3a0[0xa];
+	u8	   max_mkey_log_entity_size_mtt[0x6];
 	u8	   max_rqt_vhca_id[0x10];
 
 	u8	   reserved_at_3c0[0x20];
@@ -7270,6 +7286,30 @@ struct mlx5_ifc_qp_2err_in_bits {
 	u8         reserved_at_60[0x20];
 };
 
+struct mlx5_ifc_trans_page_fault_info_bits {
+	u8         error[0x1];
+	u8         reserved_at_1[0x4];
+	u8         page_fault_type[0x3];
+	u8         wq_number[0x18];
+
+	u8         reserved_at_20[0x8];
+	u8         fault_token[0x18];
+};
+
+struct mlx5_ifc_mem_page_fault_info_bits {
+	u8          error[0x1];
+	u8          reserved_at_1[0xf];
+	u8          fault_token_47_32[0x10];
+
+	u8          fault_token_31_0[0x20];
+};
+
+union mlx5_ifc_page_fault_resume_in_page_fault_info_auto_bits {
+	struct mlx5_ifc_trans_page_fault_info_bits trans_page_fault_info;
+	struct mlx5_ifc_mem_page_fault_info_bits mem_page_fault_info;
+	u8          reserved_at_0[0x40];
+};
+
 struct mlx5_ifc_page_fault_resume_out_bits {
 	u8         status[0x8];
 	u8         reserved_at_8[0x18];
@@ -7286,13 +7326,8 @@ struct mlx5_ifc_page_fault_resume_in_bits {
 	u8         reserved_at_20[0x10];
 	u8         op_mod[0x10];
 
-	u8         error[0x1];
-	u8         reserved_at_41[0x4];
-	u8         page_fault_type[0x3];
-	u8         wq_number[0x18];
-
-	u8         reserved_at_60[0x8];
-	u8         token[0x18];
+	union mlx5_ifc_page_fault_resume_in_page_fault_info_auto_bits
+		page_fault_info;
 };
 
 struct mlx5_ifc_nop_out_bits {
-- 
2.17.2


