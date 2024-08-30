Return-Path: <linux-rdma+bounces-4658-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D513496589F
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 09:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D4B1F26280
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 07:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5B2168490;
	Fri, 30 Aug 2024 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uH/FfsZE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B56163A9B
	for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003113; cv=fail; b=hKui2Wr7BZlx974mFf+qD5rVRPLfh52htQ7PQABTVhEnxh1ZTTdUCiWETFPgEHLXN6l6Ssh+V4YY5aV67Q/CziAV0ur9UBSC5uJHx1A0NYl8MyQ93r2D7WJCFv1mwWKNr+5vLyrWIQHQAriJ6DhV4AR0IQnQMlLF5VFkfARWiNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003113; c=relaxed/simple;
	bh=WoxY5jTE8K7Hi+pOuy2vDvDAdSG4FQaMr2c5mgdgvlQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tefrqSJgDRkqZNPyA6PorOHdiHaGg0dQF6xngMN6NhR+wOZ7DLcnFDVCD2NmW5ROGLQtPFDKSsAmyWIvrevB6K+y4/KPaqm5FrVsbaRJcDL0mUFPIyox98E/MNL2SKq3wmjAmTBRwZ89qT/kaXh3YRVDiBz7Fks8zSmayCEVyN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uH/FfsZE; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8IvQGWxumgZC8Ft0WcYJKrQ0N7Weedy77T8HS+NrdfuQH7+SIEZO7+7eXlokfWqEezAzfr+Z9PEml7uSAbxSVxH/eY3CGe5FEagZtGk4qurEoRdj7roS8mpTrVhQfPtdh8sv1RcyCC1qH6473QG/vaSyD1KWWIXaRokVYywSOCwuipFVvdJ0JgRKugZ6MDB/O3uhjnmRbunT0QIGGftT1SCBY5JA7ZHUTWH4PsXS5zNr1RSrXeGKBZVmA/VyrBA11dxTU6TnY02lkYf4euqb0n1FloMexa9mFFymW8nRIAX6/IQP65TbG5j+2y3VnkcPv7MbyTPTcuF2o6oORKuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbNlRj+A1BiyXJq8ot2yGl+qoobU9+ztKe/kOCaWYxI=;
 b=xFlT291/iDDA7vqT6ttxmipmInUL1WQ5cPz4r2uw1KtZjP5MBEE95D9mrF3JOVBMLv2Hf2BHf2L2gydSKo8a9D1ZnfzfxQxhZzdlkhPPBGLwY/M6zTUb+LSphgWuZafXN35HRMcnmv9Nw+nwR1bd2O3a+VKTBGFTR0gMq/Jm/0tgrwy8d1a/dFP1qvU02rFGBUdwJjm7zrz+qj+0bmJS/GNdl9TYlWrHLnu03W+bs9/lyRdviy0CFlGIECvftP+sLwgilVqFvQkVkn57Vs8UMeNMYGxLyP5yBTVkBb+ixLtfo+YwRcw10HVPr4nhxrPkzBKjAe5xTi98HeiK38rVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbNlRj+A1BiyXJq8ot2yGl+qoobU9+ztKe/kOCaWYxI=;
 b=uH/FfsZEs6X4CaFqr8xQIZ1aS+7fWRXQDGcSCVgT9ffmC2sksOo91HhV+wSvXNiiSy6LnZhKZ5kH8bQ70T+lwG6PIh7P6lsSCCOKSHSGDapvmtW3WBqOX4pTsj5zXXu8z2XjKMdmX1Bf0GsN8oSoscuJHmi1kP6FG6Sf8CFsE+FbGwUcFZfeSj9/pIgLkq6iu3/uplwLJfrYpF7xZ2fh0he3DgUAjh+81Bhk3A6wFifPPt4laiQxjrWuNO8IrXM0NeBRfunvna81Dk8Tu9I0jgH2DtmQpJ+zCXWD91AiA6/etniew/Da62ujlF7a3z7UwBvh0FaM8Fz1UhqDUcdTgA==
Received: from BYAPR03CA0025.namprd03.prod.outlook.com (2603:10b6:a02:a8::38)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 07:31:48 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::e4) by BYAPR03CA0025.outlook.office365.com
 (2603:10b6:a02:a8::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Fri, 30 Aug 2024 07:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 07:31:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:34 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 30 Aug
 2024 00:31:33 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next v2 0/7] Support RDMA events monitoring through
Date: Fri, 30 Aug 2024 10:31:23 +0300
Message-ID: <20240830073130.29982-1-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d55e06-5ea4-4ea4-3cdd-08dcc8c5ce91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CAe1zz1Byb2w9tg0+4gBQOYmoxBvM5pPyWZyBCo/DemVKV6qGVV763K8HRaB?=
 =?us-ascii?Q?p7oEXdhcTrSmFUh6o+CTVuLrvdpESL3A1ZvwrJ212n08zw+MeTIhJiXbXq/Q?=
 =?us-ascii?Q?WYWjwcteoOHQSHkXLeGLuKKeCNUL3XtFAwhVyqSyzE+d+sBtjvImr9mN0wXG?=
 =?us-ascii?Q?QosyGhVU+b71wrCkxjxecxtxwBfzlWa81mj2rfd5tqzdfa2zihOQuu19HHMs?=
 =?us-ascii?Q?HUwGRASLMwpRKRJjfeeIMIdSV3TwpMXul0TucN7c274KkxHWVluMS5uDOm8l?=
 =?us-ascii?Q?dXE8sm3L1K0sOUFj8sSA1LvoRVAzJx228tSuvtnbY5WHk84nw8i6zO6aR5ls?=
 =?us-ascii?Q?d8dGRcwBDd1fc/3nGuM9QuWVBX3L+9XPsak6OfnzZvZjPBsmJlC6M2qRaCuo?=
 =?us-ascii?Q?diZV8YHhnqHLcgagqcUSl9QlwIqMlXzqQDpPoUJQBnx2J3NR1+yKvv8it1pN?=
 =?us-ascii?Q?KKL6IqHBBQCwsg20TiextKJHdxjep9RVuCdijyMBZGj1oeu1cOuFv+9v2BaH?=
 =?us-ascii?Q?Rk00N70/qClmgsjzloGi6Vy7CQtT135ybZFNYIRlKaqo/x+hqD/inncYRulq?=
 =?us-ascii?Q?bigcGlnxIy8OZxIGvlruQfeuHKrPFHSc4OJ4jmivlNw2sBpuooUgL0xL6JJX?=
 =?us-ascii?Q?vYLrlbf693iqOLaV/oy5rh1pVSzBJ1OQop8rnfMflzA5LKAhS7rR5NRln6vt?=
 =?us-ascii?Q?gyTiqlf+8stmbfjEaiexVBFcEk2/OYaI1IogIBRZB2175KzA/HmrI9NZ2A3e?=
 =?us-ascii?Q?YyirljRuv/Vi06rP6y1nLJ8vuCCpYjsT+Yki7uCzrqCD/K0zC+e7IXkpOmk9?=
 =?us-ascii?Q?rtnsWg4nt6QjQ5/aphcXs2tO481AWqmoFuzRoaCDgubH3UWB44Om67GmmKB9?=
 =?us-ascii?Q?SbAwGx4IrZOP4tOPJOxIPRBl9GUZPyx/1lo96fU+/VRZYZgWH3hDKPH6sxn9?=
 =?us-ascii?Q?i0UE9ok1y7ot1kxqhRhzEnMAB7SyXZuptom9C+2yWA+HflooqgGoDRQt3Wpt?=
 =?us-ascii?Q?d64uprlr+KwYFQIKgV/ZC9ZjfjL+iLy2BgQsGBf/yGGtjDFec3VWB+ncHSGO?=
 =?us-ascii?Q?QCviJCeH8R8JcxoU2EsXTjKfefBVFSyZGjZH8tr9L8q8IADE0qNo1oLotmD3?=
 =?us-ascii?Q?0n9V+UxjJ80oDlqPNeWUzACL3nApb6shmx1ni9Zsh/EnlWSaEcfgMoqDQw5d?=
 =?us-ascii?Q?PvR8k9HT0u1u5zKka2Yum0ZRRKJVG19S7k0oDonHkUjVttAAXnogRizq9OU2?=
 =?us-ascii?Q?p/H8jREySVAjI16psu24jNbZurCLIFCrHexSEqLUH4yPtGXEtqDA7vKT04YC?=
 =?us-ascii?Q?Mvh+9B4TxJVoZ1sFhd+d/imGx1EVeaROGGeRlEW5sZM6uWPt8jwkx8m2Dn6D?=
 =?us-ascii?Q?S8SY1sZPaJp/JEmPv1pT3OPXeVtq+3WqJbhZjH7ws0n+MNrQRlPhObpH5QMs?=
 =?us-ascii?Q?AnkXPlTT/wywNogE5U+uNy5I9ER2jjNU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:31:47.9036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d55e06-5ea4-4ea4-3cdd-08dcc8c5ce91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414

This series consists of multiple parts that collectively offer a method
to monitor RDMA events from userspace.
Using netlink, users will be able to monitor their IB device events and
changes such as device register, device unregister and netdev
attachment.

The first 2 patches contain fixes in mlx5 lag code that are required for
accurate event reporting in case of a lag bond.

Patch #3 initializes phys_port_cnt early in device probe to allow the
IB-to-netdev mapping API to work properly.

Patches #4,#5 modify and export IB-to-netdev mapping API, making it accessible
to all vendors who wish to rely on it for associating their IB device with
a netdevice.

Patches #6,#7 add the netlink support for reporting IB device events to
userspace.

Changes in v2:
	- Fix compilation issues with forward declaration of ib_device
	- Add missing setting of return code in error flow

Chiara Meiohas (4):
  RDMA/mlx5: Initialize phys_port_cnt earlier in RDMA device creation
  RDMA/mlx5: Use IB set_netdev and get_netdev functions
  RDMA/nldev: Add support for RDMA monitoring
  RDMA/nldev: Expose whether RDMA monitoring is supported

Maher Sanalla (1):
  RDMA/device: Clear netdev mapping in ib_device_get_netdev on
    unregistration

Mark Bloch (2):
  RDMA/mlx5: Check RoCE LAG status before getting netdev
  RDMA/mlx5: Obtain upper net device only when needed

 drivers/infiniband/core/device.c              |  43 ++++
 drivers/infiniband/core/netlink.c             |   1 +
 drivers/infiniband/core/nldev.c               | 124 +++++++++++
 drivers/infiniband/hw/mlx5/ib_rep.c           |  22 +-
 drivers/infiniband/hw/mlx5/main.c             | 197 +++++++++++++-----
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  76 +++----
 include/linux/mlx5/device.h                   |   1 +
 include/linux/mlx5/driver.h                   |   2 +-
 include/rdma/ib_verbs.h                       |   2 +
 include/rdma/rdma_netlink.h                   |  12 ++
 include/uapi/rdma/rdma_netlink.h              |  16 ++
 12 files changed, 394 insertions(+), 105 deletions(-)

-- 
2.17.2


