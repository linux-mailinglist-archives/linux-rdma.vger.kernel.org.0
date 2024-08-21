Return-Path: <linux-rdma+bounces-4441-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 716BF9593DE
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 07:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FE71F22948
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 05:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D485F1547F7;
	Wed, 21 Aug 2024 05:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qCbSIo3b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9BD2599
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217040; cv=fail; b=HCnK4W8k9csV+izMlPL5KU5aXhmeMHqYo0NwgUxjuyExIqyDEEj7+kMAg9mqqn9sJahuO6P4Dr0D9utd5JI5IlBQ95EWUsZBSZ8i7MXdwLpXAWqirrabbK8oLf811v+inGgTegcXiulHNYUekkfkopTA+eP/ZHphuhQC/ghqZrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217040; c=relaxed/simple;
	bh=5NKIDdkjSi4TycFfB6APus0HJTA/gb7edzbsicbdrXA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rYj78Zc73g/KEa7uQmHqhchY0QOAiUIYStYveCwtPqVx8cYsFzlKysxrslJzx76Ktfm2zRwkbGnx6e+WTZdaF75pKHEGo7sPEP0LrpRwtDgzIX04rcxp4DbOVYwCCyZx0MRgLW5dqqF3pY5Bc1ov9eDXjrUzSWzzc+Lj/ZVCt0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qCbSIo3b; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOlKyDDvr86oiI1e6EvtBmNV30cmhq+IqBbffXBjs3KEORfpq6YzaMPKYi/QfMOU2K3trWh6cg6KpokwCXEcSuL8kFl9kvn+qp7QjoGVzuBaYhVTETr1/F9Gwv9gzZJ1fcqDAFgqmFutDjv3dbeUmDvwpGyHZq6NGTuOBdmSJSRYxuZ1/R7KMantOQtxbyT3FvCKo4twPGwTI73teMVS7iUNISxolNAbYpIUOuLN4/TIQIVpOI1Bze0liV9x0wMD0BF2+exGSGNecpiHQgqGDI6/aF4HL/Y28rLa5KK7HeUEwY8yNkOjTm6kCMNYvmphY9FI4K87Pgpa6ZWdlzKwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLTkSLZEhJYC69BMKBFrT4M05+blrTegWHaEnDPBITw=;
 b=D7MRmGYkG1SJXcuh9haSFwwqQAH73zQpDU70vF1FwM36DyVQnUBHezdTlhbFUtfNzHD8W9qdxhorH2pQgKWCqnRilc6uwKyi6yW6zBmNl1kiSvFo66qVYcc/gK4XESieELnN8p21T8DIFUnnMQo27PLmENanZD90xjBt+YaOs6niuutMYaa23LnYsO0oIkhGB8CvXMiGqt4EBpC9wwX4ti+tC2eyMUwp1e93W8f2lplCMJSLx5H+/J0o2oI5iPWyjYelGbA96wyzZYvY1iE+ILpukyCoCOmTubCQGDLkcU8lZo7O8VxcpqaM9PsMaRAZ4PX1yot0OEycmSR9LxPEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLTkSLZEhJYC69BMKBFrT4M05+blrTegWHaEnDPBITw=;
 b=qCbSIo3b6zOM+9REBAR9GRpcvR/dbGjwX76SHhzY7zv+GV9JfT7ejssq7nWHnbNGeG5BGII4+hwa5X4OH2MaOO9xy9fLwHV31tsFXKYuz26bpCkAwgQbQGdEaSG0VgT1w+M+BDNgTrlJHpRE4eLpb3IY1DPaMtJp89kkFT34YTpkHtPE/0xl5QUX08pCR8iyImqhMuY95AwIbzgyE813EKUGjr3BqU7MSypdgLVXWEJu/j3x7f+7zcHSM3YOg8QSbFSE30WwxFd9+5pXIZ1uY9GCOf8bI7Bqj7VDZC6F/gz/gwe42IN45UDRQkZNPY9D+L5GrGhB/R4Jc8tjK7inbw==
Received: from BYAPR07CA0047.namprd07.prod.outlook.com (2603:10b6:a03:60::24)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 05:10:35 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::62) by BYAPR07CA0047.outlook.office365.com
 (2603:10b6:a03:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Wed, 21 Aug 2024 05:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 05:10:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:23 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 20 Aug
 2024 22:10:21 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next 0/7] Support RDMA events monitoring through
Date: Wed, 21 Aug 2024 08:10:10 +0300
Message-ID: <20240821051017.7730-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e530e0-7dbe-443c-3a40-08dcc19f9678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BHkW7LZ3lcdyQzZVVlIbhBODfKEO5uhpkVeV0QkRjlOZL/AS8ReLNr5lEHE4?=
 =?us-ascii?Q?HtpHl1Zn1nYRQT8OYRoILGx1P0jrA1T0hPuLY7iZ8ADU5LZoZuXeI8fy8Ttd?=
 =?us-ascii?Q?jvdqTJ/YU0DiFq871TZd7YMTzQJaVczPCBlt1wgapFC9Ea7sTC89ALG2Glcl?=
 =?us-ascii?Q?gW3m/+J+yf4bPovF3nT4BMW70qCHMtKeCcbr5lrI0gWaDmTnJVzB+g/fJ+R7?=
 =?us-ascii?Q?Hga3ihENMj0U5/w/4feHVmzj+fY5z3ii6SeOWwq4V05F1si5FPTbi+sHm/AF?=
 =?us-ascii?Q?i5CHMy7PS0PfvTu4Bm7WjlpVT+QzGjx1Sf2rAQNIVOhA5U9cMmFChQEZ7UJJ?=
 =?us-ascii?Q?gyyNKXoYEGtRAiEJjUNwYynPjb2KjsyM+fUHAzpnbsC+RuzSfjKwzsh+sZMB?=
 =?us-ascii?Q?0r2xgfSNjrKwcw0KY/d6AQC24wYdyWnb/L9QrgRRIaO31E2DgZkVZZXpqUst?=
 =?us-ascii?Q?buGOtIvm9d7xXQU72a9t9bBXalxHp9h2eMlcigyi5wXd9MmFZ2JSsQNRjNVl?=
 =?us-ascii?Q?kIBdD9cDovrChgScYCiPl6DYqoUnrohm2maibBFrpU4ZI1MQHbDZEPw8KM0a?=
 =?us-ascii?Q?WkY/lFQlwcpqqry2Y0VTiZhUXCr0jfCUVcdPK0UMVZGrZvYe0U3lHEyVql5y?=
 =?us-ascii?Q?nc4mIHs61CYw3ZLZUy1Gbd9MlE6FRHZ2aaO58xOET3eso1BLOMC8V/ZPWPLl?=
 =?us-ascii?Q?bO4dRVpHdGpqF4zlCCwN/RWaZrMM0m+IenfB6c91cMJi4tXSlFBqhHqP07GE?=
 =?us-ascii?Q?+4qt4y7nGaOwOOjqNXo7zdHKy/zb3Ueka8hLB0oLkvyHnFljdPxgkVAlwWg7?=
 =?us-ascii?Q?rwoeSkzoC0MzIkyNFK9alBXIZuqCTteHeMjObtwughaQbfZnkBR5q7a6G35b?=
 =?us-ascii?Q?wwjIYMK55vsvVr+TmVyWjsJ1CynT5vSg4lCYiMYvPZjkr3Ma+1TQbkY4r8PW?=
 =?us-ascii?Q?vzDYiWgJdU9B+3KB3I1Wa8EkaRWBcSPCjDfQhY2JliwqaG/+EXAoACTC1Kqw?=
 =?us-ascii?Q?IT+FAXI/mS7XVAQBNPW7h0m7jT91VNViIM40KcWQDBTxxrZQHPkbj92/QCzK?=
 =?us-ascii?Q?AmzwAhinm5tbFTJLTyppy/kO/3Fr/PXOxrvkj2/MhopTmwaTARbHDusf312Z?=
 =?us-ascii?Q?hmOgwIGUQRXbXrpcaa/yAAm38+ZlmWdr3Ar7JGCrsX6VkL6QkMuLyo13slBU?=
 =?us-ascii?Q?RixCSsD/axtxlaLizrwN/KGAe1xwZPisTjNIRsKR6+DwtFnJvjBY4zXsFtAE?=
 =?us-ascii?Q?tk+JIU8hUOytCyTKGEkzauLjCyyNL++AKw9CQs+m3XAK/KCOV4TR3JL7Rbvr?=
 =?us-ascii?Q?GwBXQ+Eb/oEEz5DyAXsdbuD1sNkhOAjgNz+6U1FOTz9derXEb12BBvKwLjeq?=
 =?us-ascii?Q?r0X8pxFfha5pRb/0YM+yDsVG52TOBXLp6Z7XvbnCL/gvSjZ2SfokFr2S7jX6?=
 =?us-ascii?Q?2Kgn40XrQJCDdW+v4MxKH1UoqNRr30KN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 05:10:34.7721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e530e0-7dbe-443c-3a40-08dcc19f9678
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408

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
 drivers/infiniband/core/nldev.c               | 123 +++++++++++
 drivers/infiniband/hw/mlx5/ib_rep.c           |  22 +-
 drivers/infiniband/hw/mlx5/main.c             | 197 +++++++++++++-----
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  76 +++----
 include/linux/mlx5/device.h                   |   1 +
 include/linux/mlx5/driver.h                   |   2 +-
 include/rdma/ib_verbs.h                       |   2 +
 include/rdma/rdma_netlink.h                   |  10 +
 include/uapi/rdma/rdma_netlink.h              |  16 ++
 12 files changed, 391 insertions(+), 105 deletions(-)

-- 
2.17.2


