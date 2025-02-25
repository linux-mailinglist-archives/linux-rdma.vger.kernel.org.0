Return-Path: <linux-rdma+bounces-8059-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E3CA4361E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 08:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7852117B811
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 07:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F4325A344;
	Tue, 25 Feb 2025 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DDhHNYnm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2325A2C8;
	Tue, 25 Feb 2025 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468441; cv=fail; b=kSeqZJIHrwuz7L/8Z1O/vkx10s8icoT+17GbQdic5arTNPf/YylbMteydYNSQ/PRLuEs3O9+an64wZi9jO3WnDbGPthSwnljxUSIqKJ1h7btSi/zJmtWuGsC92NPOAFw7rG+hHSUn7/Y/rZWlMZujLP6eaJ37Ndpbu4Z4Wa9nJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468441; c=relaxed/simple;
	bh=cNkcvX2BperZcPEB+PXrlToAJqSbYWGtNVhFhsZ36vg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jMDgytdJ4cvCLGL7jSuXpWEbBxKIVrvAo/7U0WlIXiW1r1EkIsDPkJZ5HCCwE2dHJyoVewfXbg9fMLA40NPpbd2QT9Ih2Q0h0AzxNFydJvvH/Aox1DVghlcr3gOEed7tfD2udLo3W9R4I2hc07PTQkwL9gfz5+YQRmRzJQYKHBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DDhHNYnm; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+xcZrZEudk6GRD2qfjmwRIKAStnSckwlbD3Gkhx8tDMyT4EVNqOvNzPvylP4MqHVR8zZsYZUe3cbO1lQgQwl8uYQH8DLjV6uP39gwwRQCPRTyY3CxzngfizyG2bbzgkdBosyQh/thpHln64vR8bHTIb0vNpLu3tQNNmTXiDCgIDMtChiq+bFgYBFaD7nVGVftRn1MdTOySjD4C2CaNkf1ErPVxuHwP5AkYnQEERT9PATcE8FGbMW5q65kuOA0as30oqcgj5rp+MAUHQgKUk0MSp0WNTqVE6ShiqQ7bpdICuZhSWJVHU+rKhh0hxUyG9pCkaPXhcgZv2J10lqsDIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AqJLbH0SRERvR2WfRu4BpLcnlMJ1GNhD5nLS8gNl5M=;
 b=LVJX09RgVf0cOjLVsVXPRSv46m8vNpg5XWUNWgcfZGOJbaR49hh4Ns7Z+kZlFf6OsV4ionOjHsRdzOG1qmW4tt3HnAGEAB3t/OE6K+ryIiJc+Z+F3y2waHZ6PRmqpDd0KZji0ObIC1tE9BwRkQn9v6Fa31Os5F5f5wEYjKu4MzaDDzIpqEHNESfV/A3jJHoMiQm+bcn4pBK2iyuxhLzE43P5p1T4DFU2nMXwAqPoaT+5JICrHjayAVUY911SzA2dOQ1iUY7dIQIGQPxBkhy3WJVRkGQO2LUcDSxyExEaQQwScTe05uny91bVgHnfvtkmGkToY/suak0b5m1zvzdN0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AqJLbH0SRERvR2WfRu4BpLcnlMJ1GNhD5nLS8gNl5M=;
 b=DDhHNYnmyfiTY567pmOUSPKvxE1pnS0+Hgpbp3lj/6FVnfT9Faszrh6leDqyMmCFuakw4oaHNttgUvTFjb3blA536PwwEqB9ZREDxMbONXzOX+ryfrTBGFlmyIBLUHpAUHLejWr9Tk7Pz6W6O6ufV3tepmkHYbxoxTdqaigdFksOo7SB7WLVG09aJ9+6klsEHkw8isoAMgkTBBZoop5kdK/yYahRhvQ4oWLJNNrPJZd0m1rM6BtFb9UudZ/1W8TAR1FgbPwAcBdxLxeCZdLwhXi7Id+kUNHA47Jm9nCzNFKgrGW7qPGkEguRUQ+4qIn4FSBhpjDtUBu4uV0jg6FtHg==
Received: from SA0PR11CA0112.namprd11.prod.outlook.com (2603:10b6:806:d1::27)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 07:27:16 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::a3) by SA0PR11CA0112.outlook.office365.com
 (2603:10b6:806:d1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 07:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 07:27:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 23:26:57 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 23:26:56 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 24
 Feb 2025 23:26:52 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/3] mlx5 misc fixes 2025-02-25
Date: Tue, 25 Feb 2025 09:26:05 +0200
Message-ID: <20250225072608.526866-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 045d7546-fef9-423d-41ee-08dd556dd15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cGfD/SBSUGg3eQiMCijD8exsO2C0j4oO5JL2U0OmC0SDsPl1O3SNQR9cdZy1?=
 =?us-ascii?Q?Rj+QKje8JlfoYZTnVni9Ia2hTJ2wVbV/2Un3BchmFS9Tq2tdLWWAXV+E9P8V?=
 =?us-ascii?Q?HH3GEiGVeFfKCZ1+ngbzuXS42jvaThpcJvrYzbtC1TOZDE2ddZUIS3ertYsL?=
 =?us-ascii?Q?2/Ej7rR/+VFtDhYXAzFwvA0jRgThO9AAjsQc0QVcbvW4vvX5Fy49imMxbUgH?=
 =?us-ascii?Q?PjpV1K/N0eIBaN1kPGcFPJ5PV2roJnpharIRi1qg/xwH1vPg1SMOd6d2YkKs?=
 =?us-ascii?Q?/yh5jfHLWvHteyoksWOEzFenYAQ3w86LKHj+JTr+DXFItfs+Z9+cHe2ARkFe?=
 =?us-ascii?Q?EjEhwdJu1iNffTuDMutrlozcdOc4tlkUmadgIwdj7hxgGa4j4bMUXK3cjDwL?=
 =?us-ascii?Q?yMfQQsURHxIyA/DuVs8FdR6sKxRrFh69viREF3Xdb+SRiFFvh9LmKrbjJE7+?=
 =?us-ascii?Q?8ZZDmCuD+GzQpYlMjTQbGJJCMQ4QN0OzloB+dAsv0smiG78XmfwSsq3/dXcc?=
 =?us-ascii?Q?AVzQ5GlUqM1vYtGCutKfq97+81R6C23OZM2Zd1wT/I/xGkviGsbEaCLBAoy2?=
 =?us-ascii?Q?Jzj5EUN3z0GjBpL3NCG1Uw6nHs642kkCX8W9LBTnfTY0HgnzKSaD18/TIt7R?=
 =?us-ascii?Q?ZaVeG1ACmS0qQPL+Yefdfrf/fGEcRGJr2H/zlgPUr3Zj22ZUC+CagxKx7eBI?=
 =?us-ascii?Q?y+fDIm7dp9vBpLQXLlMs3PEkgzneSqMYj9X/ABzK6YilQEP3udkS78h/PDG1?=
 =?us-ascii?Q?eFfES4jTngGE1iUaq6UIahevhX279X7FDr3+2g/dHbdIxO4x4NsmtuKdlkra?=
 =?us-ascii?Q?GhGVdb0i/5qEJw5UsYYaRsBG6Rzr5WubBt1qK1cShS90A+NKnfFloINT+fZr?=
 =?us-ascii?Q?GVY30UGj8dRrbdyLl7cXQ7TD83RrnSEmbH0KkjJkCx8h5e81w4AeIjYYKAN+?=
 =?us-ascii?Q?5aGosSKbNFZK629ODGQvTVfe1pnWLjOZsBDKUQhWvTEfA5J8KRjzUOj2fgMn?=
 =?us-ascii?Q?uMYpqxtqzOU63EB1RquHaKZkjh7GwMwSzaSPgxo78aqxQnj4USmW9dwPRngp?=
 =?us-ascii?Q?xPwRx3HscqYXJIpn4si1agT3PdGvNETWLTxutv4jXKXInhh8TJdygEssiFGr?=
 =?us-ascii?Q?vSwS+Ze/ldFLiLBt96qIZRCJEqjMcJaPiFp/SgYM0RloW0LCHBj4l5ACOq6Z?=
 =?us-ascii?Q?19xJuRAtiDZ/Oj3rkI/hNJEc252ckIwweYjaWOCiHOych6imJrEPm+eNGFYb?=
 =?us-ascii?Q?HSAH7coPyAPVWjEMumtLHyfvEpV19JflFO8h5gXA0kfSmB8WTlFgtdaY7ejh?=
 =?us-ascii?Q?KKghwYBROb6YTUa5SUkz8XBQs4ViFhv/rdxA875q+K/znJwuvGg8R7Ti2xWl?=
 =?us-ascii?Q?SQTwCq16dxw1IusGENBFlBfQC5231fx6PyMNI7punCGDlS7lr78CHC57wR3Q?=
 =?us-ascii?Q?6RnI1omRPhaI0rD/2v4/yQpPPyBI99yrigVG5fJmg5RdbUy+jIZ4CuuIgE2z?=
 =?us-ascii?Q?UMdCV/QXDhNS6p0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 07:27:10.7287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 045d7546-fef9-423d-41ee-08dd556dd15b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190

Hi,

This small patchset provides misc bug fixes from the team to the mlx5
core driver.

Thanks,
Tariq.


Carolina Jubran (2):
  net/mlx5: Fix vport QoS cleanup on error
  net/mlx5: Restore missing trace event when enabling vport QoS

Shay Drory (1):
  net/mlx5: IRQ, Fix null string in debug print

 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 8 +++++++-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)


base-commit: 28b04731a38c80092f47437af6c2770765e0b99f
-- 
2.45.0


