Return-Path: <linux-rdma+bounces-11449-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C7CAE03F2
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD375A444A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E0622DF99;
	Thu, 19 Jun 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eXmHA2K1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC30E227E82;
	Thu, 19 Jun 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333065; cv=fail; b=RjRakRW02eikSumTsv6f18tPRHRRt6Y+gKGtfdGs825PEOhzjKVIznwJqHebqFsAQMsAJx6BZiIU8CX7FTcbouReuAMofzPm/SQKVi8JsOFPLjNlQFtjicLYk8ikXl2bXU4Tx7pROzmORro92LOnKEQShZe3lucqQWv5kbIo8+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333065; c=relaxed/simple;
	bh=2zuP6hxiXRIGcknklDrJxSL6RZkmp+o1JsdSMeFvrmc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QXbNb05gARskjPElB/DWJz5eZ3bCipGcR6mMYCHphjnKyb5FxTwi2xV3/0Siq2i4z2IgJVj1IZ26br0lAXTx1WC2/JijaPP047XM8l74Wi6plZUXPzPBkyYJIe1AtKtZPhkjOnwwBu+7L5yVXerkGkUAgTv0x5kcWr9FmYRhD+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eXmHA2K1; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqJNYg8xne1r3Jq3Kz2UPxz90HwN9gdr/Fw7SsDZWP9Z6RPhiz6XjQnv7pCoU64M5xw6H63Gw/obYuh+X+d4SJus/EP9eoJw9+DbyjXMZq7Y3pKiBM3UsIquVsi07ciK1npMwx1bFeS3AQRvXfu2J0vn5OhLPj8/gWkgjGGDELl1EJJFZQTfAb7fIYK5UYL9mGhchooMpv6NRbEDVYuVBtCKjVLDaQkJpKJ6jtyQa+EY7kfduRM7tmBGG/zUCs2SBuPP40egJh9E/IWi/a8qG2FrKyc6JkF1+bdbuNi8U+rluhOxuv4/LbsMQZi1lVPQAgvk4m4Yp//OvhB+jZW+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRHe2/5jJXY8wXB/hVxJYnu7QX5QYRG9/lFKOIN6J5M=;
 b=enL/7PX6Bjks5TdksoeiDnw5MNWrscKSj5yP7avsI4NIEIa4sIV9wPHVyMBP7/w40y6Ls73HxVUXXF89MWl6FQjM8hYU0JA9xrKWa0Z19k40UnwarOCK3BVIlMJBQgjpgb0slQPx6YDL1zptmuzKEm1QCMba/OM1rqZ20qIQkCroVQ6ckXsz34QqmcRwgUMjyYGwVbvy6/V3xXSj+1zRS8in1EX/DZhmh8xkzqAOccngjqHaniHpfHUFuJCHErIu8AfI1QTGD2j0Rj0OKlcmPEtC/xTOtzPIZPLN7kS/cz6qvf0aW4jY9MFXFlJBkyw77gMUid2E0VgMsxJMfSTDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRHe2/5jJXY8wXB/hVxJYnu7QX5QYRG9/lFKOIN6J5M=;
 b=eXmHA2K1jRGvJkQysDfrb1BfKd4YIjs/kwkjrB+oV4dtKT09BtkSURtciIjoPRuNwkzZsv2w+rw9QhcALQ8CWacbIgp4oY+4C4UqgA2abZ4dWopnZm9mlNutYmVdbJK+cYdEC+KWOGIillIOpssxOoOjNEOHO5yDcVVxqnEx+G2CwpQL791a09LqiCIR0CQzBlhI7LBWFsglYHYzJvKqk3kpx7pHYAjDqDGQFoJoFjdrhrzDqpzFE5HKMfg2XpYrv+KA3MYGczbsN6lfuJaA4IMSjVSSH9wCPMLSGt/g8SiJbwjbjazM/Psl71Xk5drln9dnF2tWh1GcIa2+9PDQwQ==
Received: from DM6PR06CA0077.namprd06.prod.outlook.com (2603:10b6:5:336::10)
 by BL4PR12MB9721.namprd12.prod.outlook.com (2603:10b6:208:4ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 11:37:38 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::ac) by DM6PR06CA0077.outlook.office365.com
 (2603:10b6:5:336::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Thu,
 19 Jun 2025 11:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:37:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:37:27 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:37:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:37:23 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 0/5] net/mlx5e: Add support for PCIe congestion events
Date: Thu, 19 Jun 2025 14:37:16 +0300
Message-ID: <20250619113721.60201-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|BL4PR12MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: bf29b255-6311-4a63-165b-08ddaf25b141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GSMLhd8YK87/W5j4uDBwVgMeJ/guK8trgpzvWk/No7fkDfMW7olXijvjAZOF?=
 =?us-ascii?Q?DbZfCJTNfm5/W3+wBFlxvN7Js4PfWb0PGpOMkkeLWk9pauos+S34lhWJ5wLL?=
 =?us-ascii?Q?iDtw7xS2s8vd8mWPs8QMafG1Jv5xyIbUEO3hk5AQ6VaumoCNVCnJm58n+lah?=
 =?us-ascii?Q?piIDILc4P0ZwuioyZQrzjSYYGSKVXz5I2fXvxgVC0pZ3oCi3lcw8iQgslptm?=
 =?us-ascii?Q?/zzsSQL0czG3nFZ4i8ChmrKeByCwlc9Ei1xzZAq156/ILFgS/w57vOWiVdfT?=
 =?us-ascii?Q?rY4ivbRCiy6T4yXOsGlkZf2OWCPKA538dCNSNotGblXpKNXXEFmw21Wu5vtV?=
 =?us-ascii?Q?9zRxsUvBY0/8aNSC7AdVAJMyTTdBC69vEKq/ErWXCUS8OMUdg4vCkzZVQB86?=
 =?us-ascii?Q?vGeMOk86keU2K+qilphBo/d/eoOewyilVt0FFO4d2oxX0vR1FO+MN/RmfHL9?=
 =?us-ascii?Q?tdiaeqJLioKTxSgSlXHwhcslYb85lf/PrKvqi+9Tu3wwsTlBQ6PD7qubO2z/?=
 =?us-ascii?Q?w8Xzlwxg03NwblfWNglw48L04W6q2l/2LZYw4pfRTthUwZ6rIgUys926461t?=
 =?us-ascii?Q?C9WSchWAnyvwTAGUK4hBY3LZ95Dww9WqubwJoZLwsHjB/Rw9fmmvVRbsirLg?=
 =?us-ascii?Q?PYpBNYjNYmsS8SRHIMt4fXnFtM9N99a+tZbsaZqphGmiX7LE1WByZNdfRDX2?=
 =?us-ascii?Q?HfcZxUW9t89wqqjJXH2qy8fHas6Czi8fh5dQ4dLRW7fQ0iZAcAKG/K69qYOS?=
 =?us-ascii?Q?FkpC072Yy6B+//0VFoj/XEoG9QGLaqepfWdfKNX+PDtBzybR4277IPuHHzHo?=
 =?us-ascii?Q?ZkWWYrN2Z4PqzxbMF0pm83cPLGwxv5qxiWgoNU1xxRy1ajK/stwcdL2cw/NO?=
 =?us-ascii?Q?wg5oHrD2SOBeGV0GQsMnXpdEBtqKV8VkAEC6s3a+hZnPEoH8O8vpdiWcsOz7?=
 =?us-ascii?Q?kKRIDIV5Jkz4aNVIqaQV+fQw12PyJD86IZ7BO5VY3n/oPSqF4NmBBqsyTYiV?=
 =?us-ascii?Q?eppThRrJgh1svQ+RBa6BCyx/+SDh0YCr574brF1IOwNjtLACGDiK0G8WNDxX?=
 =?us-ascii?Q?G1aMWKcPySrG0V8o1tASunjg/Gk0KD/aNVRxbtlymyaSWVTzZRVyVA0KRImn?=
 =?us-ascii?Q?MXUdOtNAqDhTF4IbbScYEoux3ymiDLDyg70BulYtxkSNC0MWC8gfXerZtcFR?=
 =?us-ascii?Q?u4ZXg/L9ku86s4gCx9ngX3fQ5RnAW4PN6s9emgtr/GNwTKzpl2FtFlujApul?=
 =?us-ascii?Q?IhERxDtQcbxGY58Flo52jh0uZSlu6QQuW+qhIThemwu/LKU72Hew0ij/vH5F?=
 =?us-ascii?Q?ikiEkCDtGr3bVUVx+N5PxZwOigzi1g2EmqIlYgjdY0IEWskk9jHd6iblyDOn?=
 =?us-ascii?Q?kwSovw96Xink+T5Sx7FF2OYEDSoYvHrbixjSsRp7gCE1Nt6QNSiWyCcSwO6y?=
 =?us-ascii?Q?NJUEEw6zqXjkCLsfAPJMpc8a0Ho63NOR8m3mSM6sfUNfDtMEQTX8tJ9e8/Xl?=
 =?us-ascii?Q?XSbyvn5gHeWsVjH6+uOp7NKyfASocyjpXciS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:37:37.7872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf29b255-6311-4a63-165b-08ddaf25b141
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9721

PCIe congestion events are events generated by the firmware when the
device side has sustained PCIe inbound or outbound traffic above
certain thresholds. The high and low threshold are hysteresis thresholds
to prevent flapping: once the high threshold has been reached, a low
threshold event will be triggered only after the bandwidth usage went
below the low threshold.

This series adds support for receiving and exposing such events as
ethtool counters.

2 new pairs of counters are exposed: pci_bw_in/outbound_high/low. These
should help the user understand if the device PCI is under pressure.
The thresholds are configurable via sysfs.

Dragos Tatulea (5):
  net/mlx5: Small refactor for general object capabilities
  net/mlx5: Add IFC bits for PCIe Congestion Event object
  net/mlx5e: Create/destroy PCIe Congestion Event object
  net/mlx5e: Add device PCIe congestion ethtool stats
  net/mlx5e: Make PCIe congestion event thresholds configurable

 .../ethernet/mellanox/mlx5/counters.rst       |  32 ++
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +
 .../mellanox/mlx5/core/en/pcie_cong_event.c   | 464 ++++++++++++++++++
 .../mellanox/mlx5/core/en/pcie_cong_event.h   |  11 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   3 +
 .../ethernet/mellanox/mlx5/core/en_stats.c    |   1 +
 .../ethernet/mellanox/mlx5/core/en_stats.h    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   4 +
 include/linux/mlx5/mlx5_ifc.h                 |  67 ++-
 10 files changed, 575 insertions(+), 12 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.h


base-commit: d3623dd5bd4e1fc9acfc08dd0064658bbbf1e8de
-- 
2.34.1


