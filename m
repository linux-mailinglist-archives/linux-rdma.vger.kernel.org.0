Return-Path: <linux-rdma+bounces-4661-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EC39658A2
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 09:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DC0287157
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40741586CB;
	Fri, 30 Aug 2024 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tcg9JYRF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4666166F28
	for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2024 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003120; cv=fail; b=j1ZTLqNqiCzd+lvq16P+WgrFIR2NiSHKTvl7Iv/5FN+aK2mmpKmxvWvYpFczeXAd4+dqMtkmT2LxfwxpMc2x7btEfnMY4pk/oP1NXRDT5a0UaltYvVgDeFGVoE81OgBqHJuii3GsjSYjO3pD1cBZD+isIalHubRLbAT7q4gyopM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003120; c=relaxed/simple;
	bh=Je5C3f+CcZSAmB0AMT9meb69fQe7s/01w9SvWGMooE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0BEReRgtm0Q4++4tyhSw2Q9sDg2nqp9Z6Nm1JQL06V8PlPYqEt1VMsap5ZkYYT2BOUHRiO8XnxsljZN2AdgX+G/eVp97AiPPO/fmsSeFGq7RXUWvnJLuk1pAwGrfQmmDbOkuuGAv7uDyajex7Bwl9gOWiB/96MpY/eSzOQ6jgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tcg9JYRF; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMhWo0L/L9sg+/jcrU2wZYLY6RQ0J3d1aPlukW4Oue7J38v8edTdqQBCzkZOiYDQ1m1ukABzjfKgb81K105qYfbmBNc3aMKqyN2HlfZvhoRe4CLrDBnGW/CUU+zCjMT5ZCAnFm5Y9WkveZGU5Ls9gmUEc04Z+NhTziW0QxQulZuhkKMzaOHc0ZV1oPB8MFUO3/FF6sgCIYeY4iMf51fChHYh38JLVZqswX/YVPsCOA15g5tmzXXNdldoOUd281fpgdXQuPdNPZaW1GNRmYLWOM8WXejb9YMoaJFMzL5JRTEXLIsoVjs7/Tp1CQBGzwt1a13QkqN0WjLOpP42Ru9jRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3X8e2q5H7HzbLMNGEcnFtC+Vm0ucJAlldStCRceoaU=;
 b=ABKCDUAGk+W0DFpv40fB5m056nIkQq/o2tzDvGOwPLbArvsH4eCR7HqEIdjIJwSoz/urrdLoyvMDDZKIB8wFeq1N52PqaB0cSUJAoUL7NAvefhoTcUED1QqA2Gy3osnzjm1PMSznJYwvgbRvxQ60ozVd+fZHZMbxXu/cpVjO5fMfHNcokGfTmDtjZAKwMKCmKzKBEEAraJBHzFreleHrqWJJrrAntb0OXs4rfE0u78MH8Nj4mKGZjFar390T2ZPMged0igHzBo5+OTzb716izkmDjEXdyGfMkOF0noTA8OuAgw+hg4boS+/1tG4IEbRn8CyQWma6/T7P+9dXCwunLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3X8e2q5H7HzbLMNGEcnFtC+Vm0ucJAlldStCRceoaU=;
 b=Tcg9JYRFrNniOhpYUtDe6RI8i5TaPQjjAgka5sbRkK/OLf4NMzr8ij5o/KQMCRss1prG1O5j2FI9OQ9bE7w2gFGoWngOCL4dVeCsANVWHB9G9sTJIj2af6bb+CFcJiB9Ty94GziV0fDlIf4O3cPKa9+NmiZMoV4K+r3WaShfQl1GphhccyY6rEg3J8PipmtBTdzRJRqNdG4oNXPigmytzuvnUq/jdnJJU0jP294gFXwmDPazCCaBFBUGtuGRg/XzTf6lXJ+nV06ro9UbFFsmMfyWoWwcom02tFq44cejTF3AnP6G/1G1umYTOsBUA+G1AaXiUOfGR5NjZUOOjB06BA==
Received: from BYAPR08CA0066.namprd08.prod.outlook.com (2603:10b6:a03:117::43)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Fri, 30 Aug
 2024 07:31:54 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::95) by BYAPR08CA0066.outlook.office365.com
 (2603:10b6:a03:117::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Fri, 30 Aug 2024 07:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 07:31:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:42 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 30 Aug
 2024 00:31:40 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next v2 3/7] RDMA/mlx5: Initialize phys_port_cnt earlier in RDMA device creation
Date: Fri, 30 Aug 2024 10:31:26 +0300
Message-ID: <20240830073130.29982-4-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240830073130.29982-1-michaelgur@nvidia.com>
References: <20240830073130.29982-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 4618a753-cd05-4400-c1c3-08dcc8c5d255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HTST9H0dlQZNijcWCy09rZabPDkJmwHrFhZKPPF/WQjOcNoEeoqmjZTg6lMc?=
 =?us-ascii?Q?kA//suHHO0sLM8InYa9o650wJtB/G+mGIsdBHxrE/MOGMIj2MzKjhKNkISkF?=
 =?us-ascii?Q?Um5+jNXA0ZadRe28hfq0EqtBJ1qVvhhOQEBx/bFcn+XppYtxO2t8RqWlf2Rf?=
 =?us-ascii?Q?tyFcEHhNKzKQExhsz/IO/epk65ndual2+pB6bBERNb/0RN7s1aayRo61iPPI?=
 =?us-ascii?Q?yKfv/DzcU3WucwYVRAdaCd7uy4nU82BS3wf6TXZc17Tmlg+vyBHZV2PgguyH?=
 =?us-ascii?Q?CgjPSF85gRsXCdvAN4fTH21GiEm4yqiLZt/7e06qP4nknU4T0zgE4AI5wXaj?=
 =?us-ascii?Q?zK4D8PyTRGZN+Iuam4S0aCMysNYWkk4/PQN0rGGwOXYjKV+Hd/JDukC+pNp3?=
 =?us-ascii?Q?0OTv5vPNtJqApeRdEIwV/W9HnzXkYc+LGMtd8AOKO3r2z+dKf1IqUhKSJLde?=
 =?us-ascii?Q?RcyQZYYM/uD4XdZ+VmNky7QUkTw7ORP9OHdeufxMT+upWkKXBW6Wi/TPbbuM?=
 =?us-ascii?Q?lW5koqqQPAr6qxkQA+Aa19Zg/3iKGl6zyqhQIB0+Zec/MFaX/w7JmXS3Nr8p?=
 =?us-ascii?Q?xLqTEt5pmua9Xwuaq4np4enDhHHd1Pcc4AVFftnuTLsIjCh5FiSG3rCuEu1y?=
 =?us-ascii?Q?+VJOxxw5eiLMAM/GnErCHaQKkaa8WTQ6gXC4LJO/weVTYujW1iG1XbHml0hl?=
 =?us-ascii?Q?8Zk/ZgEgfHtKBbG8fjaqmCHxWfuNvPSnzabEGHKCk7z3gN7kYc4M/7+kuaGG?=
 =?us-ascii?Q?dnaAPopMTMQzuQVbr+ZYuc/gMRY3bIfGKol4aFcQA/ptLyuNTD/E3j5Mj7Vj?=
 =?us-ascii?Q?HUx8AqoERbKsGamTBdClQda4ZuMdI4QjQSvBqJkyOtOXk9pVvzj23PTvlwtg?=
 =?us-ascii?Q?N2fCei5DgL3dN4kLCY4wWmoSaP44Rl3BqEyNxXMRGzi2HNC/U22kE90TQQ9p?=
 =?us-ascii?Q?imReP4wOc3/eOwvGFUEUd08IAGuV0sM/BR9JpP+8a145OMBWxSI1Yv8ouZTd?=
 =?us-ascii?Q?QIrGXiZ0iKYzSXUpU9Yobt8HDP8tFZ6yED0N3ohl3HnxSAbwqCa5fKTLtEy4?=
 =?us-ascii?Q?encG9OtUZFjYAkBdg0ZlY1QPulG5XLgwt428jmq/0rRLNOybOBjftvDjN/sC?=
 =?us-ascii?Q?liQP/MRHLLfNhSIBXsG6X9we3ViAi8rB+e41TCJwRqvSSZxIrMlUldf+TN9y?=
 =?us-ascii?Q?pyb9nbVgh66bJyrn6xYCywUjFfsR0ctBB3GSN9n9D0K5n5nyB1I6KMOS7JTl?=
 =?us-ascii?Q?71QWUqHNZ8ugxCoRlG6+1vizqYKKXKlcPjEgdgaLLs/R5j4nLyH4exQvRgki?=
 =?us-ascii?Q?7czSH3dwOjuGeeDrFcJ7E0d7JYz04H5jl7UR3zDRKlxn/NjOhn5xPUBWkztF?=
 =?us-ascii?Q?/Kw0QO23LCCSYo2LK7f6Vt5YFsmjDXJ1OqwyhzotMy3Lv3wzqeKABMhssfjx?=
 =?us-ascii?Q?JYBDfTZXkOFrWbrKobAlJnYw6CrunErc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:31:54.2403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4618a753-cd05-4400-c1c3-08dcc8c5d255
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976

From: Chiara Meiohas <cmeiohas@nvidia.com>

phys_port_cnt of the IB device must be initialized before calling
ib_device_set_netdev().

Previously, phys_port_cnt was initialized in the mlx5_ib init function.
Remove this initialization to allow setting it separately, providing
the flexibility to call ib_device_set_netdev before registering the
IB device.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/ib_rep.c | 1 +
 drivers/infiniband/hw/mlx5/main.c   | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/mlx5/ib_rep.c
index c7a4ee896121..1ad934685d80 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@ -104,6 +104,7 @@ mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 	ibdev->is_rep = true;
 	vport_index = rep->vport_index;
 	ibdev->port[vport_index].rep = rep;
+	ibdev->ib_dev.phys_port_cnt = num_ports;
 	ibdev->port[vport_index].roce.netdev =
 		mlx5_ib_get_rep_netdev(lag_master->priv.eswitch, rep->vport);
 	ibdev->mdev = lag_master;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c75cc3d14e74..1046c92212c7 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3932,7 +3932,6 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 
 	dev->ib_dev.node_type = RDMA_NODE_IB_CA;
 	dev->ib_dev.local_dma_lkey = 0 /* not supported for now */;
-	dev->ib_dev.phys_port_cnt = dev->num_ports;
 	dev->ib_dev.dev.parent = mdev->device;
 	dev->ib_dev.lag_flags = RDMA_LAG_FLAGS_HASH_ALL_SLAVES;
 
@@ -4647,6 +4646,7 @@ static struct ib_device *mlx5_ib_add_sub_dev(struct ib_device *parent,
 	mplane->mdev = mparent->mdev;
 	mplane->num_ports = mparent->num_plane;
 	mplane->sub_dev_name = name;
+	mplane->ib_dev.phys_port_cnt = mplane->num_ports;
 
 	ret = __mlx5_ib_add(mplane, &plane_profile);
 	if (ret)
@@ -4763,6 +4763,7 @@ static int mlx5r_probe(struct auxiliary_device *adev,
 
 	dev->mdev = mdev;
 	dev->num_ports = num_ports;
+	dev->ib_dev.phys_port_cnt = num_ports;
 
 	if (ll == IB_LINK_LAYER_ETHERNET && !mlx5_get_roce_state(mdev))
 		profile = &raw_eth_profile;
-- 
2.17.2


