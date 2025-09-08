Return-Path: <linux-rdma+bounces-13154-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D69CB4898F
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 12:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B32164218
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1BE2F616D;
	Mon,  8 Sep 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PeZIALqC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782772EA752;
	Mon,  8 Sep 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326071; cv=fail; b=Avu213zYDJ30MkpqM6ns2ciZwB+oblKjN0pCQTye7p31RLHvFxaAiN3F56ABaKHQgWmht+H7kPFFiDZPrkDg6y8EuRGqlNZUFkksX4TWRf6UrHeZeUxQP4VU8H/sWoX99Cz+UXz9Bm6dqs+pHTGRvVHZ4MmFcVq7i5bkfRAyUlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326071; c=relaxed/simple;
	bh=TKheL/CQeQtnbSp1hP/+WOBz+GX6MZZHFMoTCijZEqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pFrEzqS+8OH1UQweNWCj3avTF3rUAXMg1zgxLlEiENTgwFyXVoU1fHke/EQThkD1gcoDPQrbzdLCfR5b7JK86gJbUAPm2SLdiXUFZc6o/LAVVi+ncwjNaUlTMmt6qr6YHVQHleSNih/wIyWX/u0H2jKMR4L/82PtfUm2agmfC0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PeZIALqC; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/s5pZp34QtB7tnS46VXZqtZDBf0PbZD4VnxKBFmQRP2Gmt4AQqoPKQqri8wmQ4izXePeLixcD0tGtvj7cA99otPDjw9SbXcorT5yfok0PI/8s5XbKpKkWFm3xJUMv1p5MaSh3OYKE9enFZvKDciZzGgGafQtE3HZe1CwQAoy9yr96d2U4ijyEpGdLmYS9zHmLH7Nn2XZYlVmrOrxw7ea2tpD+kYXiKdO0F1Gg/YdIQmXRSCAwgzhEJdfMPO9k3lXOMAAuBSPa/wiq2VBW4n5dxN4xExyF7J6Jxei3ckwlVrqFE1nSwgaj50wfwCc5zCHdGUxRSZnIyWJUejRgMSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHSSadfTT5ddammFakS/VaDIHehUohWZV2/avdB1Xis=;
 b=lduIhzY87ZawcD740vNysMJUn5lwPPf1NSxDjMDlid3ZJdpDIA5Z5Lq3IJROe75B3usDzIw5vlaRv3FC4J5frqYpGysAzCkid2Y/SkS1qvB2cFCxvbnR5xpX/yNP4I1qZxZYAE9EX8aJMpixL2jP6lU5ZpfS4NsOA7enULcRSCOg2jq1tDU7oMhr2n0kZVB3fYoctarGlob4hwmXWChEaowgD7B49WE/Yax/9HsoHXeakPtcQhQ7OcYLJOWp4VK9a84n88FDi4TxX4od1eAx2X2e9UFdzwzpHYdQye/SY0FYlzw3PvdhUpHKYiRpkm119/Jtu2Jp95paY5aa1mbGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHSSadfTT5ddammFakS/VaDIHehUohWZV2/avdB1Xis=;
 b=PeZIALqCeO/dbwE8MMQ0ce3zLdciKwDk9zurFl+s6HpN7OuvKkGUi3xUT9ncH4DwvsMeZ/mjjry+2NYHTU8TeCPfQF3Eg+Uh1rtIytXDz5MaHGuimRaJbGMC75BWSu/wIqYZW0FOy+ddjaJrHUww9UCZwpoC1iAZ0tmIQ7VQKW+1pfZwLPe5l0lYcUBYO9yXfbkpvG8ILpIgiajq1oyvSjd3Wd1EU0AsX5RgdAhkLhddkBvuLBXNTZ85tOf7Ou0fTf/Rj5DJV2DYodL9inQKxD0SRFPyEg4dFsqc7jjUSb3n6RiFqSbMKzg0nupie4TYaoJF6hDvrVMK5QXzx0CbJQ==
Received: from DS7PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:3bb::11)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 10:07:43 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::3b) by DS7PR03CA0066.outlook.office365.com
 (2603:10b6:5:3bb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 10:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 10:07:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 03:07:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 03:07:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 8 Sep
 2025 03:07:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 0/3] mlx5e misc fixes 2025-09-08
Date: Mon, 8 Sep 2025 13:07:03 +0300
Message-ID: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 13668614-57b9-4023-df2b-08ddeebf8d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u4+Q8sn72h27cGAdk4kATq4/FzpFQdTtnGpykT0aLCSDu6PLXHAkuaf1EamO?=
 =?us-ascii?Q?RZRf/Ba55y9q9HbDbSVeL6CMu/yy3yrqsvrH1p2usRnZ4ynbIOkX1lTHgeEW?=
 =?us-ascii?Q?2//dp/5WtBrPlBDUblBYP34qg9gdFa8E5RlfqifDu8k+TFPoAI1NjPQTU7F+?=
 =?us-ascii?Q?7sGBtlf/+rTKQeifrmj7xLe3nozWkh0txL4R2eSr6m1yvHEAU0lzYx3og/yW?=
 =?us-ascii?Q?Po806IkGc0dnVNW4uXfnaAPg2Ns1bwYK1z6hyc5FN3SmKab5gwaTouY79E/F?=
 =?us-ascii?Q?yybAWFcKpFscj5gPXjIJ+ntw0EjfczxbCftG2T1cGp4Qv0z60ZT8MRKi8oU7?=
 =?us-ascii?Q?SRA9qeBYc32G0fXtmcytuot6CHPztpAbzCxkkvgsy6UqbGptZBADWUm+w772?=
 =?us-ascii?Q?CrlHMkXfktA9OYLPwE2qsEv+kwOazCezPzY838v/D8rWO5RA/wVHRYdm4kXa?=
 =?us-ascii?Q?hCELSPchLjKbqqvuF8+dmelIYhswPc1VHXDcXqhNA3NUu6ERV6QUF886JuIG?=
 =?us-ascii?Q?oh7otbwY/0+pWyCm2FydpF52YvpHknu3hgjF2zZaElG5hnbQLPw/EfOUSMtR?=
 =?us-ascii?Q?ufHXJJeVyiVouVLq1ROLwd5H/bVPtOt9hP900saFDGp+OpVmG7NAvBMfw3qU?=
 =?us-ascii?Q?cT0FSQ1FdnxUgl6HmZjiJZelwXo0NxY+CAWuCPv3FsEuNnao9AvTm84LmC2B?=
 =?us-ascii?Q?o/tFWbdx7I4ngH/YzZEz/GjjvYK2gFSgovV110Qp8klAG71fjmIsUw4NSksd?=
 =?us-ascii?Q?Ju2xzq4K6+lQht2kLecPMwpe3kq0gKiqxBjT6+EDXkm9cGzIpkNsnn6NiMaG?=
 =?us-ascii?Q?XqRNor47nwkcq0lnv/F86gM55/EnDG7IQd3IcY4EsPRQ+egSI4w5LALcvSu4?=
 =?us-ascii?Q?ef5Qku4xAy8uQmk0sg4RR9n+yFASpEyUu5H+il8WE0itFcji9X3eWkWjk/kD?=
 =?us-ascii?Q?iqxFjbyFh3iPsivo1zUkCoYiM/QeDjfnSCk6ouXRsh5ldLw5BlT04rQu5LtE?=
 =?us-ascii?Q?Kw6rdciFyo7w2wNco3EQ7j3R29py49PXgdVKhm8aOUiGsfCoCvO2bUZ6kAQR?=
 =?us-ascii?Q?b2UFJ0ODSVauQeY5UatJ/nFxaQxkwfPlBKckmBpvrfe8hqD853Wd0QXnwCzW?=
 =?us-ascii?Q?hmXq5/DPegeRppIWjgEe6Ks9X1Gd0BFoP2WcxApPa9akVAkO1g9fHpT/PvkY?=
 =?us-ascii?Q?q32p3mKNPojvrufbn/bkw6o9LUpts49CeSD6wLic3UhazxtwHEWMLVsOSzZS?=
 =?us-ascii?Q?+DCrrCNq+Gdksk2oVQktK3eFH8ZUSa7ULvZmtpGF+4ahddDQxLNFjfa05ApR?=
 =?us-ascii?Q?DjH/qqkGPUrJBFpctSQuo76yvWcc9Mx0B5w/w6uQjSX2EXVogf0WEzsgOzyl?=
 =?us-ascii?Q?8AApix891/0BR1EwrWSHlJpFOBk9kDpgm+88qjtn6iGNigSs+IcXSu6Pf1Xu?=
 =?us-ascii?Q?T2FzcgXyfiZFZ+bYFda2qyTPF1PvNK8f4ij2iNyEQmB6VzzypMlhROZNTw0T?=
 =?us-ascii?Q?RpraFI1JWzRFmwIGL8v5Q2O7RGxOFv4X3yib?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 10:07:42.7872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13668614-57b9-4023-df2b-08ddeebf8d25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745

Hi,

This patchset provides misc bug fixes from the team to the mlx5 Eth
driver.

Thanks,
Tariq.


Jianbo Liu (2):
  net/mlx5e: Harden uplink netdev access against device unbind
  net/mlx5e: Prevent entering switchdev mode with inconsistent netns

Lama Kayal (1):
  net/mlx5e: Add a miss level for ipsec crypto offload

 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |  1 +
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  1 +
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 26 ++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |  1 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 33 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  4 +--
 .../ethernet/mellanox/mlx5/core/lib/mlx5.h    | 15 ++++++++-
 include/linux/mlx5/driver.h                   |  1 +
 9 files changed, 76 insertions(+), 9 deletions(-)


base-commit: e2a10daba84968f6b5777d150985fd7d6abc9c84
-- 
2.31.1


