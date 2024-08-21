Return-Path: <linux-rdma+bounces-4443-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FAD9593E0
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 07:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A6A1C20FA5
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 05:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3A165EF7;
	Wed, 21 Aug 2024 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IDe1dEFx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6162599
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217046; cv=fail; b=QR10rdvDCla3jqJwYXik9893KEO3YmTJUcCajDvDSV2kLl06DyMsArkDtSrH6N7QcTwp8TMoVGEYNNG/3/SmVbMegUEFQruZM+Q+pal0YOi3uBdIX8CPQTTVS2zh8uSPaOF8kU5SJ3yfg0SHG/tA6Oa5tN+NJhfIzC+QzUZedx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217046; c=relaxed/simple;
	bh=Je5C3f+CcZSAmB0AMT9meb69fQe7s/01w9SvWGMooE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8QaCqOk5NVpVsiVTAKh56IIEIFYVVZwWrgKLaHtoiZvmP4WX+3KdKFEQqXwzm1gPSIKqSZFdC3GHklPUZdpLNAhn0+tlbHiW4TpF68sZJ6XjkSeoYlRfI9UWrAR9cjTq0qr5Oyrc1ZgY1pfCSkBVWLrg5eMdLpacv+7+EGDFPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IDe1dEFx; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzIboq57UxbcoOWPRR/tSbLj9iMjuC1dSJAIRtHnnIBQIa7S7g4M/IKFTKudfKt836Oehh9o5Q0eyz4/WGvpNUljrDfsxUAn1nZZYmIGS/fbUrwDN+TnRRwKe5wyfTl7toB7ixCbTGQSGyjSvIrLM6iyDsPstBKtfLfMMpew8/h80GL5hOSyTF8tviV4cr5kUTUB/QHILH8cealLrNw+OXG6D0mSannBk63tqYhY3UuRXhHmarKb7A06ZpNrK5KnNZcfmpyecSyJ46bOq4CxfAHCqGWRmW5xUGvU9m2bc+tYiFuhMiUX63qcYki8SSEKUiQyyC+dfU/y7+Jbj/Q7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3X8e2q5H7HzbLMNGEcnFtC+Vm0ucJAlldStCRceoaU=;
 b=Cq8LRQNmEUhifd2H4fNwsg3AE4+lKFYKdlm1fz1cnxeFUTOOivzlI3fZQAh7VePCHe6tz5O9zgzWKA1nHJ5mVgLd9+nHLpMP+t2mNapq1Bgn9/1xYWJu08n8aETjpIUVzgSbxECYhgeZttSwEzp2xn6Zj/JdJk6ijeM8EI/datC2WiIzFeq/fMK+z8E68BzkWRujMdx372t0Bi9cmlkXT4Op+paHcfhx6fP2x29S9oVWLSV4rx7OXsT2jz/Y7SLP45sk+tR5Sjhlq26IMY4BirN5Oyr8QQj853G/xuBC3muvZ27W0v05hSMlzoiRmRwlWax21NqiuSrH7/Jkj8w3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3X8e2q5H7HzbLMNGEcnFtC+Vm0ucJAlldStCRceoaU=;
 b=IDe1dEFxYw7qL1VooI/vYCLGT9lT+UWntQV4uubPtS3uo73zn8I7QNC38MyrDlo4iIS9k3wyRZDenOVGvZfgicQ4JUvxGrC5MzcSQp4Sh6raMsSRv3mrbr1eIlEunwxpdRt5Bgeh/NbS9iTXgOuq3xa1QHQkC2KKxx510nZx478sROa3mpxAgdq7ZjYVz4vPsaDYDI1tnnO4uLN8UUnA3aceOjCMYWFhP0SDpy8LsWXu2dgPAHX10zHHNI2Fk0f0nJQ+L+bLDJ5Us8dWM5d8LSx3ItU7yzuQ9WHv8rf1bGN4OGqMzfNfssU/t0uyXqZ4R2BdLnwyNyuQZ5EcJs0aZg==
Received: from SJ0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:a03:2ef::35)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 05:10:41 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::1c) by SJ0PR03CA0210.outlook.office365.com
 (2603:10b6:a03:2ef::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 05:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 05:10:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:32 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:31 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 20 Aug
 2024 22:10:29 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next 3/7] RDMA/mlx5: Initialize phys_port_cnt earlier in RDMA device creation
Date: Wed, 21 Aug 2024 08:10:13 +0300
Message-ID: <20240821051017.7730-4-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240821051017.7730-1-michaelgur@nvidia.com>
References: <20240821051017.7730-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 44767838-1a7e-4e05-dab5-08dcc19f9a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iGCRKz3CxeCGptqCMgv2S+cAh8CSroocf+5F0EkuBb97eU7bgOFImrK4JmLU?=
 =?us-ascii?Q?nbXHFRSU6nIe2XjnzkWNENE+7MxahdsMVVXOwLdi0HPV1cgWhcUdkD3aagS7?=
 =?us-ascii?Q?//5P3iJ/lJqB667wnHaz+RZMN1ZYRTs0mT7CXPDSiW4LfdPnzmraAcrk5UKF?=
 =?us-ascii?Q?+U/ViHRtpNCI3oUujXw5O50ZohvMw0oeG0qYjZ2i1I+42pnXMu+g7avMBoB0?=
 =?us-ascii?Q?evs2V1D2ZUvFQx6q6RFVqPGrhCFc/30poaxNd5IArFIbENJ8/pP/q+aQHAWE?=
 =?us-ascii?Q?1WGWZRykjlWyhBDx6ClEgZMrAlhvNLapdv1XJEVUe7y3QWlqx3+iqdhVHH8y?=
 =?us-ascii?Q?C3AKox5rGD/rExn8aPf76WZZQYMpb+9dFF7sMLpSyW2CDJOzxmZOmBYUFtKm?=
 =?us-ascii?Q?5X0cr+Fcnotr9dCIGz+ycwTVwXDNFV2AJLD1QtZE/X77gnggcRmmVrFF2eEy?=
 =?us-ascii?Q?eunelh6gIgBWhXKKiKPLDuVtC3Il2Tqz40e26ltnXq9Z4dQkjwZj3Anr8Xfa?=
 =?us-ascii?Q?e8DRCc2mWKvAY67LK5unAu0qbLT6Za/3XvTREYEDrHdrSw5gc4D5QKb5ECSR?=
 =?us-ascii?Q?iLmp77imrXg0a6kU/bMknvx520YgDfQCxKF36FP8iFxYc8TspHbFG3vBqHSo?=
 =?us-ascii?Q?YNZsV1fpUuoWTgn1/ROlQXD5GTwBe5vZlv81huVMKnd04+/+xze+XsqDG9uc?=
 =?us-ascii?Q?Zn57Ghbd8ahDX16SaPxX/xVJxEjc89U2Lny0rCA/KWubidi+AThuw9vyB/ki?=
 =?us-ascii?Q?L6XGa3cBzSxpgfVOw4hbRp2paETMaVJ4gzJMxqpRw7g/4i2kq9VhZRqTz7Q+?=
 =?us-ascii?Q?VgaiZ09HAcM38rcEkDoDAm7LD+CiqHCDctyKdENhsxUC3uM9+gzvGG7uGAqS?=
 =?us-ascii?Q?cu5TzbUw3dfxEUuCN4wFCFZnThAptLQt5O0N8iMf4O3P75Nv7vtjehjPDX8Z?=
 =?us-ascii?Q?RbC4EW0367OXa0aZQNgELPVCog1gr4PPpvD7BJNbyo/SlbC4UwN4vf89cX6z?=
 =?us-ascii?Q?0G8WPZANnTT/wBbrqVNDZgtyXwFbAcA3nSrIUjrR3EJTL7VL/Vbpf8UrQL8s?=
 =?us-ascii?Q?1mZ0Eib3Y8WnJ3acbOS9uYVUdurKb8DWilvujKm5n0n0jlroaYctcgCUO23l?=
 =?us-ascii?Q?vFFrv5rxcMxn439rDpIYFMz3hjhwoOpgqHQvTgyMK8l2ikZ17GSinGgAPYZ/?=
 =?us-ascii?Q?DT1fl0necf8OZUhr+uPI4vuQawXoKJyiSDQmAZkIvio6XEHRb6tbqSMpplzB?=
 =?us-ascii?Q?maz60VDZfDK4AJ8Pm8e+AHHyZU/VniZT4qMAlYay/rWgQzKmEgCZF6GqnWNB?=
 =?us-ascii?Q?vv4dqWHv/t+0NeTfjOgcw5eoRw1RPt4GjMEz0IMbRcPJmP0EPXiI5D7a9qtl?=
 =?us-ascii?Q?rHS0RqC00TVtgyGE+vy17uM+jT01U/EcuDdTDGBGrXyXpovHEVITPlp0FpUk?=
 =?us-ascii?Q?j7F0hN6EIYq22+zvAZXNhJHSNv2wDWlC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 05:10:41.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44767838-1a7e-4e05-dab5-08dcc19f9a62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501

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


