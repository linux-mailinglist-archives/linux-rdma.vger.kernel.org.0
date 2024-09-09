Return-Path: <linux-rdma+bounces-4834-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0074A972116
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 19:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49519B23D6E
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 17:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DAA17C205;
	Mon,  9 Sep 2024 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZDWF8KcG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3F17ADF6
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903069; cv=fail; b=UfvrHJ9JVWeFWusIMhQSBXVyD76Wkd3LrcJz2LvevuQY72+oMzOwzsKj4T4JrtkbVsk//HPKU4GvNtBft09ZbV+13xmGqMQVJWP2MaE/rw+8V8FSMcEaQCv2D1N7dHpAhX0ec2mby/OQE3s+ePPDX9vW5gtalWax8hz3y+TZm3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903069; c=relaxed/simple;
	bh=Je5C3f+CcZSAmB0AMT9meb69fQe7s/01w9SvWGMooE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5mOaXad5xF9BsaCCQEqNsv5URdHl86rJHQhsEr+XOA/BNouLqwVSiPUvaQnYPmnuMNiQmU9ZG1nlzsuRYz8dwATerHQtZNUyuNiRwmj1MSL1Ln/HqxFAYxr2SudyXxstc2bnBlId1wbgUEqR6K+MoukYpzsdQlMvDoNUgqHeoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZDWF8KcG; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juiU0owayxJtHYUAgCekgfFWL9DL8zXroKex6Pt9AgHTryMAJ1t2sKXSGffETeZ9JEqYFb/JSowuEaEoux2cAW5WpazCNmZkiVgjdt1SpWYRxOJQ8sQNMt9pF4soAIN/oV9kJyi1nsV9S9ia/lOrfpL0L+4jWoHho/XA8i67xsY07RvhtAKyp56Mg3Akq0krA58HMUVWpouIW+qQj+8Kn1mdPcDm2p5dxJd+txTmnNeFlgPRtppf5OMC3fzNiLkuqccZgOarXNKwlv3MhT1Eyh5el7a6sAWPvRfQcEF52nJEcD1w/WKv3/MOHJ0c6aY3pniS5A4mh9HEEZ6WVFmAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3X8e2q5H7HzbLMNGEcnFtC+Vm0ucJAlldStCRceoaU=;
 b=OrNLzjJBDDNDs5OJ9Dgj195S8Qd9VOY7Dd4n8dxDOdjpwsJ3Eni53ga9CRDoi2kj/cxkhPSSoSzSutAuh6++U3C1pIiGMEmXEAMx7TpORCnOsW4SL4O8wNI6imLPcqcH8VwP/+XHqzbtLXYAeDGUNcc3yt4XF1Us3Idvq/1BDtp+1oAD/ZL7obruhjCJCKLRyIeyVgvJmnsG8dE3B9T1t6bhaqdBiXDlV70cr+BMRO9J/9sZOsCsfyuuMbnSORgglZKsde52IK6dCjMm4D1/IfHhhda9UZuMHlJOFcU1B7oi/27PwP300fdYXET7XTYHTu023XZOJPqTuC7LKsXZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3X8e2q5H7HzbLMNGEcnFtC+Vm0ucJAlldStCRceoaU=;
 b=ZDWF8KcGeygP9FewDeD0jSmpiDLsE3yiQVryBFmRhwaXm+c551oXySOsUYqhbUpZM8DVfRry6g4LjlQvrBdr5aZzjY5b7BuhBUwYzUNkhKFFGGEv/ZRzuU5tBIRifalROXKPp38ye2nZnWE+u2gA60ZFBNPvs0BhuD5dFT0E1Aw3FzTZuaqv3mtOKDgTWl+JssFhTpEqqEXkNZFSFslJLexL+QTSyKqc2JhWabAKDuQggB9q+/1lvTD26t3hcXkDiXUzBIOegWj0EfkEeseRJdBCE8r+E9QlkGL9wiV/BO07tnkMea4tg7SSDJzuc2f+nSLxfVnTnjHI6hgfpfwL4Q==
Received: from MN2PR05CA0043.namprd05.prod.outlook.com (2603:10b6:208:236::12)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 17:30:59 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::9e) by MN2PR05CA0043.outlook.office365.com
 (2603:10b6:208:236::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 17:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 17:30:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:40 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 9 Sep
 2024 10:30:38 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, <dsahern@gmail.com>, "Michael
 Guralnik" <michaelgur@nvidia.com>
Subject: [PATCH v3 rdma-next 3/7] RDMA/mlx5: Initialize phys_port_cnt earlier in RDMA device creation
Date: Mon, 9 Sep 2024 20:30:21 +0300
Message-ID: <20240909173025.30422-4-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240909173025.30422-1-michaelgur@nvidia.com>
References: <20240909173025.30422-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f8785a-9cad-4cb6-1330-08dcd0f52b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dDRHD0IE56WymZsv8kf44eI9pjxY8Ip/ipH4R4RDmghwBW6RoG6JTKNpZ4U1?=
 =?us-ascii?Q?fm/MUp73SgDaO3qCXY9vHZ3NeidHf2jF/4iQnuJJSK4IzkKW0+f5Fch6Tflw?=
 =?us-ascii?Q?I961Ify2Ba7JHkrHTNNsUH7gkU2l2eobUti8UY8JJ9OB+Kth3IflHOePRmUe?=
 =?us-ascii?Q?ypgOuokW3tAGthWXINPiNffELGRBQTsc4OmzPw4KOJy3QTdsuD0JGxp00unQ?=
 =?us-ascii?Q?sutns2IHpiFRimoPwKlqqAuZVjTa4kDNNhhf+rjGlU5gLqE5zM9bL2nFn0re?=
 =?us-ascii?Q?M5//3h+nGEbxrAbMyX4BsMyU1wVrOvU7UqlSZxPiWzWZ7BnHcXJXUDLRFCIF?=
 =?us-ascii?Q?lH9zHc45+XGcH+6+8s05yfdpNib8mkWdVNX8knpst8Fo9G1nkD5htiP0ntnf?=
 =?us-ascii?Q?WLyi6pZVyIXylhnsFaNIozUfXKMZ13ikmpPAfyVV1ARCfb5j9OnX5EVZORG6?=
 =?us-ascii?Q?wDILfOW9ltt0yRyPqY8UufU4m6QU2h1h9kqPUHYsRtxOfyJSKAmAMfF42G39?=
 =?us-ascii?Q?9nTjQZrBxYtPz7vU76LwXWe5Ayh5KN25I8+98q6GyzrUqcSvVy8s+hG6vIQl?=
 =?us-ascii?Q?3SQscrvKmXp6equNk9cgXeieTkBD5IfFrE7H0AHYsPtAN0BLP2jQ33E93TdO?=
 =?us-ascii?Q?7ZwsZfi3Hp0Nrl3iMI3zOpVudg1xF/QzDpKAg5liWrgZ2wfglmMV5vNXeQFb?=
 =?us-ascii?Q?kv1K/OT6FD/DQNA092IPF6/XXbpAeOMm1grsdqz89db1ZGwILgjr54yHuykQ?=
 =?us-ascii?Q?H6a0AEWIVTKrpTg/NVZ0EwX5g+hENmpbwiO/M5+S5bZJb6vipEssd7ZfPSxH?=
 =?us-ascii?Q?3y0L63AmI4nz9XAnPpeHD17ltwfzOeyJSKyDyx7Pj/uFtr8S/U4cPw1DVSKi?=
 =?us-ascii?Q?PnNpQvdCCmxNp1vjIPzkfV6UM0WVPO/TAMdUwxX6kbzhcs6mDAw8+jz2MlYb?=
 =?us-ascii?Q?1e53RXEd6cO/FmZA8dh21xdH1mwmpcmxJ7vGt9hlXMQ4ARWpsBwJWx0eLDYR?=
 =?us-ascii?Q?pahncn/1WKceBvXMm0Nqg/e7U8J17r+az4paE3PZkQ6j/lll0Bz6sTVNUHky?=
 =?us-ascii?Q?D7hb5VZbwOXomgP6y6YWxFxJgUffv+Q8vJpPgJ2ECq5sKEadQt9PxPA6B5Hk?=
 =?us-ascii?Q?YWaB6vrOGsd/nvhnxs/eFRMYaPJ2ytX8QNZJ8frVakJbF/YejDz9iFpl1Atf?=
 =?us-ascii?Q?G0V3L4PpYLo/8RxshN61NwbTK3wAOoTqDSMeN3NzWdgSWBMfuKDDxHB53ABH?=
 =?us-ascii?Q?HTTg0junixSGZOTRMHyLn8rR9AHPSxdq7ZNuxF1rBVFdoEns+zuHLofwfPoE?=
 =?us-ascii?Q?KOE+FEnC8HEWoT8x9h8AqsBGa5CW5KZlvdkQIQo5oKQt+G6Xx+EMolXJVzmX?=
 =?us-ascii?Q?8xiLGauLQ3AsUll5kyx/Dv1XC9Cdy7m4hNd9rP18ip92M0m0vh09FZVZaItX?=
 =?us-ascii?Q?vxNLW+Xq51rWWxffPDrXkF8G4lpkaDLI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 17:30:59.4098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f8785a-9cad-4cb6-1330-08dcd0f52b8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234

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


