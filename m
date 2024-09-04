Return-Path: <linux-rdma+bounces-4744-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8D596C274
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 17:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6503128CA50
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AC31DEFD0;
	Wed,  4 Sep 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EDSiZ8bH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2192C95
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463868; cv=fail; b=sijAHaQhidH8d8LU4FQ3OoI/hk3GDgBZH2KRdiW69B+7sDfDS9XDtdB4kPlEH7+kTDfxiBFTEbpfUl0iNUkGNzHLuFZztP0FWjJ4rpwMUUalBawm4DA0vPgZO+D88qB42hjsyJM2Or5r/KZ3++5b1Nucsmws/Un56+CVj+M5pHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463868; c=relaxed/simple;
	bh=Orp6Tp08ADKQDPxJj9uLRXU+fVBRCYmlQ3AyosyNqBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lli+YMeoLnxnQJC3x4SUGa2bc1LoX4LY6bSTMDr09YgzD/WPds4MjVhHYUZTehCmLXYRLNCHGSOWK13OKDO7ViXsDaCp3Qj8TlDlc6s7DvonQ+5XpFCshEfPraGH9VJtamYk5He2CFrtmsX4OBtpTdi71RDB4JVvP9zs1FEhJrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EDSiZ8bH; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoMIszWw46WHJR0857hKSBbQBeTiQ5rwq1k4GShBm7DFz+Sxua1gX7pngClIOsfMC4jjeFxeWvQQJHNsXKq7xUwIaOtIctcGxm6x9OekieWroxxcV5pj3NQac0u+ze0TrNtp8qWg1TN4EdITEKOyLff74Dy4dFldLzOoSqn7ka8fDBz9l7XEa971ZeRkt8rsaJFXVqNjAvqdgGdAnzyT6br4vi49j/l2gm7fUAQSe1vaxfmWr0Rzt5KhFql8HlKdV4NbkgqgB/iK2HyShlaO63Xi9K07ybJ2FyKaQWgOfL4DE24jnqOoTkpVe9BBD2dJ+no6RDtGiGBlOWKudkY+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sNVhDYjlljuerZ0wXeb5L6zpj0qjcPMA7qjC7b8S6I=;
 b=hEDrjR2LVM6qlFOeFtlm/jS27F/wLOjZ8xi8fX+H7t2yDu+tSnnzGNkZgo1s1sA3qnDF/spp67XeoapgwF8mm6vSH+/FMjXuhSVHYsJPIcX41X65xafESXMQ+JLDLluSpPLmbt2waMjf5eMUOVltzTs4r1ZQGQKGQ2/Jh6KgWM4Ij9HrZwGecXVqaZHUsFqogPF7KyRBNnH14WCrjRq/NCkdvCbJqB0ET12G8zyyLdRGNWPkOaqFDVUjoQz9DVa/W4lKyOlsLr9M5LTC8JoWGM8H7LU/soYatZI9mYVxv6FtrsLUYIu/W2EopfKIZS/PZSBs14jrnyq/0Ey6mTYhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sNVhDYjlljuerZ0wXeb5L6zpj0qjcPMA7qjC7b8S6I=;
 b=EDSiZ8bHYqT+p0KZCRImsM1Wy/uPls/JLURZZh7cFMWWgeuU+XH1t1dh3ZvxwyXmGYMpZ3dtRhjtsUbVhpNC1JpK8ViQcF8krRi3GM3bc7uKvS23JwhX0P6vaOaWKydZze9YX1PEr6JP33b7hSeC9onIZDGtGYQ9x/KMaXn/PNETm0sAV/P9L95yBQXpBvswrQpT2BBRHNS1VWWan2XdydVDYNEn/sxhwQ/j8wg3IZrf0yRT19kWiKKRhUqisHNocCJnesjmEZv/pXU01HFW+h9W71HfJ2iypQKA4y3X+VvegMaCIojX/x/Pwj4Q/dPKUrzHPMZmmwX6SbORJKtIpQ==
Received: from BY5PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:180::49)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 15:31:00 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::7e) by BY5PR13CA0036.outlook.office365.com
 (2603:10b6:a03:180::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 15:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 15:31:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 08:30:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 08:30:47 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 08:30:45 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 2/8] net/mlx5: Expose HW bits for Memory scheme ODP
Date: Wed, 4 Sep 2024 18:30:32 +0300
Message-ID: <20240904153038.23054-3-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240904153038.23054-1-michaelgur@nvidia.com>
References: <20240904153038.23054-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e6339e-3a14-441f-e2b8-08dcccf69484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UODhSYvNfVR2G9Mcu/skb8dm/p4ZHNDs944Wv5Fc05dlB18XLUeLUdoL9c/h?=
 =?us-ascii?Q?7sbqEaOVVVa54qHpjXFyS7NYj3PWrECP7ndYU3un1ZsLCvAgmFOATsdXv/HT?=
 =?us-ascii?Q?PoivKB+G3nlrzzaJ4XbiaCE1Ic2fyvKlY3tVMfH22Lay5oTOxSUqqo15K2XV?=
 =?us-ascii?Q?h8wELJFYZUuhFvoZanu9FJohC3VtIaM/jXhkrR1/ktSGB6JMdxSODlGBUtEY?=
 =?us-ascii?Q?TXb7W2Lij77xl7eUY7+59dmnvcS5EkvSg3Y26piE0hMqXCcST3ZIXwrQcBjs?=
 =?us-ascii?Q?T0cOJjnFP90258B5gD2qPCkncY4TH17G4vCxow7Q/wnJhpBpMo986T4IHMpy?=
 =?us-ascii?Q?D42V8ad3/1txRD1r7A7njgp+JMz7Id1KUWmplu1ut7bonioD68/WXYkWRi+C?=
 =?us-ascii?Q?b/rUt9w+80UlrxIgNsePXEtBHVVVFJb2h4LonihJtdY9jrEzVYphT+6sPm0U?=
 =?us-ascii?Q?UT2rgKb2OTXt1tf71s/o2JFVqlDgDnQmOpJ4sjguk9gS0hpk3GAL+DlLOvv8?=
 =?us-ascii?Q?EwKgvnVqEvyOiKZ6wJFE6Cqbp3jGyNoE2F21HgGUsVnkPWB5sjRGQqBI39Xo?=
 =?us-ascii?Q?sKf9bllH44g3gLInpSqehCFf2i3PJpUYMENMQMlrcgChU+QUVOFqobDVpZvG?=
 =?us-ascii?Q?Dh/PpROuwD+nBUE9Yo66Y/dNssiS1ZBl04jjOMzY6sxolmvX6qdoqch4Vc0T?=
 =?us-ascii?Q?H+ZmS6AoghW/OUaqrya4Og5apmM0/RF5KpG18etrB54VFbvxXVIZ5sOOkCU+?=
 =?us-ascii?Q?Ucf2u92pI2F0pT5YPh7WjpJXGPC1N6+NmUOp00BXUpsMs+Ns5eapGHrFeG8Z?=
 =?us-ascii?Q?RZGcW4WiZXUVNrb08YviJtgLNv/bdr3kReKpC1UgLeENljnKFpBpkT4aGCWJ?=
 =?us-ascii?Q?ogJ2l0wuD9NdjyLaYQMhJ9LRTqYFm8a5jsdLkYJThkHVLnzmTLTPoCTRwZy3?=
 =?us-ascii?Q?/OORwMZLUWzD5FddDcikSAdrwJXXy6KEIVkSI6TrBotKM8CRCp3j5s8QEacx?=
 =?us-ascii?Q?BbaadaWhz2KmxxeSQx3gipAwo5aNvXfljagDL8eRhLDpfuLBo9BmU0wlYOoc?=
 =?us-ascii?Q?xrp4Z04GgRORlKDhsSZ3kgzTDlALdUEUNwhg1jS56LJBnxaHUNLruQQ7Ryuk?=
 =?us-ascii?Q?tcpKvecfxJOtTaWgVBIuDrDgHNGVKtmTu9SZK+dhxOREJjnVY2kePSWvNSUX?=
 =?us-ascii?Q?T2r9e/wI7+C/zNgfSUKba/Pc7NkIBrhfFbkjpLuF7vFsLupV0kJApPsneU0K?=
 =?us-ascii?Q?HuRx2nqr1wyj2CQY0YlrKelP6udKUelJMNWHsNey43/SHpMB1kKQxXqcSwQc?=
 =?us-ascii?Q?2OGJXxoYinPaBVw3StkyoJ3Cd43WKxQ2abmFkfRmOaz1jWhWW/5bdDsH+Ah+?=
 =?us-ascii?Q?meVk2Z3aqETYWIdsFXluCLxrewYiadNC2uoYUKRMXz9YUGu10Jzka6ZBAzlC?=
 =?us-ascii?Q?rLfK2ePcNChPWs3Ngv8W/DR+04GQcMt+?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:31:00.5213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e6339e-3a14-441f-e2b8-08dcccf69484
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106

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


