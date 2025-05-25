Return-Path: <linux-rdma+bounces-10690-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A325AC3440
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 13:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9171895292
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 11:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0221F2388;
	Sun, 25 May 2025 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ggYBP3C9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667FD1EC014;
	Sun, 25 May 2025 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748173737; cv=fail; b=QvU8u3gMecJR2xQPv1WCEtxxCe+qi9jXf+PiRfV7iP8ovnM8cXyFcoIz1sej9MSfHfMVK3ZTPxlw+NLeKxXRy8dlGS1M9MLq9W0GSp5aMu29BzW6rqcr1DN9ulf7eZDv/FlGa00A2nvSyvNUB7YXRvMcJIJUHaUCYvRfckZefTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748173737; c=relaxed/simple;
	bh=w0azo/0Kz34koGSDIs12P01T6VOXPnCnywSc6BvgDjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQpLsGIMNQlq6Q4in6cT0OWE3yyqlFjbIKOa896gJUpyAiJWerN9trCVxMUJywmfBvXBygq+MzbCuJDyRh/OoWuk+sxW58EnkCxefLEB4aDZuSzyitL8NLLNQtDj9oJr9o/oKvvvv/IKnaztxW2QnOA3Rmn5yo7K8ogka7fy0kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ggYBP3C9; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4vhdEx9u9+ZY4ARMiPoxMTpL7kL0A+xcSuzN+4d6hqKqGiHN25cadm43pELwLWbqh//FB5ER0ywspD0/0c+X8ROFL3ssRhDJZgfNiMfz3BcwKxQYp7m55Q1IqC5+W08SqpUryhz0tSwhXuqe3+eE1+nU6ofkNv9p17lertItloDeTjg3J0ny9RS/1JeuyFgAQtLkxLJ+vKkIlekF52sQSdJEIuWVRya8w+m5s09tMBdRLgCfDu+lhM1OeYuCw/JbwGZH4jaGSb7AIWqBci/POg5zF3nEwYvh88J6dJYgdM9hsOZksq1g9FNovxLhfg//6MzJiGCJuhZF2+lNjDA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3relRmNDjDFdtDkf+/+hVO4rSOE/SyaprtR541Pr8U=;
 b=NGvoNXRC4qFVSnFTw+aNx++00uK7P47FaWMNfJKW+bHyqmRXNJP1Hz7qKh3dVsQOzlQY2OWMWuyUW22QGujsZtw4Q6vaKRLYbOuAOEYMEL8Id+9OHI+US/12eKY3tHKXKZIKzVsTEyKeDZyYX5ZfzPZUiVjXHQFj2U4X6WZ12PmsXl8iBlg5ke9ZCrLu2wqcysXyB57fvUfkfW8VOYxdq/bYb4WDAvii3FQgobBuFyMpGmdQnD9q354c+VagbYY9HA7/v4IiGJImHjIoONDaeJ3ZgKTY2IbLDiZtWVRFT9pRt44pFeVAs8ZyFXgtLnfFpYBN3ZwZU/Y/8ZMGT3rqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3relRmNDjDFdtDkf+/+hVO4rSOE/SyaprtR541Pr8U=;
 b=ggYBP3C94+qkhUQVPZdcjigOW24V5mHQrisWK2dNzcji7zyx/ROk8AnUAYkC5tvj4Q/fqJzrKGqeMK4DdtktimP6CZ3HOjr0JoMmKMbQu9Pwg+wUOE3hbt0jZkuCaR8SF+aFKkpGfF6xmL7Py00KBSaZ7mT19/fHnh4jX5OZzYoNK4pkpgM+Bohxb2Ob4AhJqCvZSmw4f19xWjfP0ZW8i0mBHxy+VL7vL8ZqLEmaK/3lPgiwuZeFBG0S7nlBjbYQfAqKRrmzu3VOf0jPVl2VWlfv7faD/+KqPQKKAGXhF7nBhPITLUcdtl5vDi5P5RvaS2JLAzc6p4ko1HbWaLsxbQ==
Received: from DM6PR06CA0080.namprd06.prod.outlook.com (2603:10b6:5:336::13)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Sun, 25 May
 2025 11:48:23 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::f6) by DM6PR06CA0080.outlook.office365.com
 (2603:10b6:5:336::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Sun,
 25 May 2025 11:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 11:48:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 25 May
 2025 04:48:10 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 25 May
 2025 04:48:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 25
 May 2025 04:48:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Yael Chemla <ychemla@nvidia.com>
Subject: [PATCH net-next 2/2] net/mlx5e: Log error messages when extack is not present
Date: Sun, 25 May 2025 14:47:32 +0300
Message-ID: <1748173652-1377161-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1748173652-1377161-1-git-send-email-tariqt@nvidia.com>
References: <1748173652-1377161-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 6540b732-5e2e-4883-79b9-08dd9b820d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dGkaA1S1Vaw142TiullG4DqG58CwT1jd88Hdyw7B85/IHRookYZ2u5N8JDIp?=
 =?us-ascii?Q?GKcMYY+tcjV8WdyL59CK6RroyqbfmIh9D6RdYvloAn/Lv7vM3lvLrW9ezGlX?=
 =?us-ascii?Q?7FfU2xbDkvYeDtV1axCBPHkd3tL/oLourXrqKhWTJytBy2t2IT9mzVi4ZqDe?=
 =?us-ascii?Q?9GEqmfbvizfotjvo+FzaZkEl6dFqcPJ0S7dD0EK5DE/P/Svan23oPemCZSfx?=
 =?us-ascii?Q?/sY4oIKAFFMS/IG5jHcFLeWTEVJMwIeJ6ARm2CISWcZsX+E8Hd3Ilkon5OUO?=
 =?us-ascii?Q?0E148pk84PE6K3TViWJ/imY2wgMSRM6LERUb72Lvza1uy2sHav1NtDpt9J38?=
 =?us-ascii?Q?3fVUfPuzrrknbepNtTf+HVdNNvagJhMQZDNmhy+bMJxiU4bCOQjB1Gbsg5qo?=
 =?us-ascii?Q?L8XxjHw1tZXsNjfgX6OF0L2xb/j4rZnZhB7dR9CmxtaLxJ8jaG/XRuv9Nbq9?=
 =?us-ascii?Q?+VuX0cLwTjJ4Z/M4mjxIF0M31nzScyxhpnp+jYddIwoSeuf8OFOc9+s57I53?=
 =?us-ascii?Q?494DsPKG9YpNc2AekA423O40XnclPRcppvZGnWk16LLRvXpo5Nl8Xvq4mVLN?=
 =?us-ascii?Q?l0yFQbLq5/s9tXpKvRstho0+4KJUaGhBG5jArHsCz7yK3OmBSs3KVvtoyDuR?=
 =?us-ascii?Q?SIiPnfXydvBb+/IUKZtJv4kMOKYl0hHrECSm7ronBGecZnJoitGvH6c5JphN?=
 =?us-ascii?Q?s2tGQLTqq3P3k5krBUvtao5m1FEndzLUb0bpKQ/Rvz3NEgu9K4/l0Aytom+V?=
 =?us-ascii?Q?NHnwEH30n9z36FaHBrl1JG2OoLaUzEUNX4k+tJOlkyCLEbra/FIhjvIUtKdI?=
 =?us-ascii?Q?34dfRKYCAWeqlGU6uQq2EX5zxHnwM6qM74j6mTljmEuJCukcSbwrKwtbgd0O?=
 =?us-ascii?Q?GhZrmQHbqOVEkcEOnvO1/MW2D1FjoKAws+bLZ/ke5PWMhCL7qsFvZSs+VtIk?=
 =?us-ascii?Q?8WRUuACIe2SROjaUxtwLSahp61uh/PfyQTo7bimNTylqhVz2wRj0Km4d6aEs?=
 =?us-ascii?Q?xiHu2tLSGBkzKyZ3brcq1EDQ11UhCDxBXMRntx+X0QqTFqFb7rC/3l3rKxSk?=
 =?us-ascii?Q?EnV52IgbivH3Bnoppl8IkgixF3UmuWEphdM3xGKBM5+autA+EONNsYN/vLDW?=
 =?us-ascii?Q?KGt5UZslmCphbXN+CT8VLGsoGumzr2zp/YiVYCyb5DWXdyVVTxmcv2q/UmRo?=
 =?us-ascii?Q?rpsWF2YgCkvHXcCcASsLvzSe4eQYg0Rz1hQoUQuZn78Tj6E9XcBBQ6wORARd?=
 =?us-ascii?Q?jWEC97RGR8LRRG1otesewO0FuFPm4qBATm9Cv4t6dFG4BGxTBf0Zar/ltPYi?=
 =?us-ascii?Q?i8nxV+8RUhL+TS5WY91LaCYMBmbqhILC1KheNrGh4bEFCIBgZtAZTKQn5khH?=
 =?us-ascii?Q?4yGSnN1OngqKwgpiYHRLkFL3CxiIAEOphcCNE+GmfHJCXHJagooEdZcdkrHZ?=
 =?us-ascii?Q?OszbpXtEXQEGqxxtcoywTbvYCQ5tuMn6/4cEzsqajloB2F9gldMIQ1/frBU9?=
 =?us-ascii?Q?ucoE2qlk2mmlbl0urgOMV1HuEROV7VqyHYxB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 11:48:23.0785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6540b732-5e2e-4883-79b9-08dd9b820d94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

From: Yael Chemla <ychemla@nvidia.com>

Encapsulate netlink error message macros to ensure error message remain
visible in dmesg when the userspace does not support netlink.

This allows drivers to continue providing meaningful error messages even
when netlink is available in kernel but not in userspace.

Replace direct extack macro calls with new wrapper macros to support
this fallback behavior.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  40 ++--
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en/htb.c  |  24 +--
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  |   8 +-
 .../mellanox/mlx5/core/en/rep/bridge.c        |   2 +-
 .../mellanox/mlx5/core/en/tc/act/csum.c       |   8 +-
 .../mellanox/mlx5/core/en/tc/act/goto.c       |  16 +-
 .../mellanox/mlx5/core/en/tc/act/mark.c       |   2 +-
 .../mellanox/mlx5/core/en/tc/act/mirred.c     |  28 +--
 .../mellanox/mlx5/core/en/tc/act/mirred_nic.c |   4 +-
 .../mellanox/mlx5/core/en/tc/act/mpls.c       |   6 +-
 .../mellanox/mlx5/core/en/tc/act/pedit.c      |   8 +-
 .../mellanox/mlx5/core/en/tc/act/police.c     |  14 +-
 .../mellanox/mlx5/core/en/tc/act/ptype.c      |   2 +-
 .../mlx5/core/en/tc/act/redirect_ingress.c    |  16 +-
 .../mellanox/mlx5/core/en/tc/act/tun.c        |   4 +-
 .../mellanox/mlx5/core/en/tc/act/vlan.c       |   6 +-
 .../mlx5/core/en/tc/act/vlan_mangle.c         |   4 +-
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    |  20 +-
 .../ethernet/mellanox/mlx5/core/en/tc_ct.h    |   4 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   |  12 +-
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |  14 +-
 .../mellanox/mlx5/core/en/tc_tun_geneve.c     |  34 ++--
 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |  20 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  82 ++++----
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  45 ++---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 188 +++++++++---------
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  |  28 +--
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |  24 +--
 .../mellanox/mlx5/core/eswitch_offloads.c     | 120 +++++------
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  16 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |  14 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |   8 +-
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |   2 +-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  14 ++
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |  25 ++-
 37 files changed, 441 insertions(+), 428 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 73cd74644378..ebcd07c75722 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -94,7 +94,7 @@ static int mlx5_devlink_reload_fw_activate(struct devlink *devlink, struct netli
 	if (err)
 		return err;
 	if (!(reset_level & MLX5_MFRL_REG_RESET_LEVEL3)) {
-		NL_SET_ERR_MSG_MOD(extack, "FW activate requires reboot");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "FW activate requires reboot");
 		return -EINVAL;
 	}
 
@@ -110,7 +110,7 @@ static int mlx5_devlink_reload_fw_activate(struct devlink *devlink, struct netli
 	mlx5_unload_one_devl_locked(dev, true);
 	err = mlx5_health_wait_pci_up(dev);
 	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "FW activate aborted, PCI reads fail after reset");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "FW activate aborted, PCI reads fail after reset");
 
 	return err;
 }
@@ -126,8 +126,8 @@ static int mlx5_devlink_trigger_fw_live_patch(struct devlink *devlink,
 	if (err)
 		return err;
 	if (!(reset_level & MLX5_MFRL_REG_RESET_LEVEL0)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "FW upgrade to the stored FW can't be done by FW live patching");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"FW upgrade to the stored FW can't be done by FW live patching");
 		return -EINVAL;
 	}
 
@@ -151,23 +151,23 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 	}
 
 	if (mlx5_lag_is_active(dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported in Lag mode");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "reload is unsupported in Lag mode");
 		return -EOPNOTSUPP;
 	}
 
 	if (mlx5_core_is_mp_slave(dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported for multi port slave");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "reload is unsupported for multi port slave");
 		return -EOPNOTSUPP;
 	}
 
 	if (action == DEVLINK_RELOAD_ACTION_FW_ACTIVATE &&
 	    !dev->priv.fw_reset) {
-		NL_SET_ERR_MSG_MOD(extack, "FW activate is unsupported for this function");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "FW activate is unsupported for this function");
 		return -EOPNOTSUPP;
 	}
 
 	if (mlx5_core_is_pf(dev) && pci_num_vf(pdev))
-		NL_SET_ERR_MSG_MOD(extack, "reload while VFs are present is unfavorable");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "reload while VFs are present is unfavorable");
 
 	switch (action) {
 	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
@@ -285,7 +285,7 @@ static int mlx5_devlink_trap_action_set(struct devlink *devlink,
 	int err;
 
 	if (is_mdev_switchdev_mode(dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "Devlink traps can't be set in switchdev mode");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Devlink traps can't be set in switchdev mode");
 		return -EOPNOTSUPP;
 	}
 
@@ -413,11 +413,11 @@ static int mlx5_devlink_enable_roce_validate(struct devlink *devlink, u32 id,
 
 	if (new_state && !MLX5_CAP_GEN(dev, roce) &&
 	    !(MLX5_CAP_GEN(dev, roce_rw_supported) && MLX5_CAP_GEN_MAX(dev, roce))) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support RoCE");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Device doesn't support RoCE");
 		return -EOPNOTSUPP;
 	}
 	if (mlx5_core_is_mp_slave(dev) || mlx5_lag_is_active(dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "Multi port slave/Lag device can't configure RoCE");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Multi port slave/Lag device can't configure RoCE");
 		return -EOPNOTSUPP;
 	}
 
@@ -432,8 +432,8 @@ static int mlx5_devlink_large_group_num_validate(struct devlink *devlink, u32 id
 	int group_num = val.vu32;
 
 	if (group_num < 1 || group_num > 1024) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Unsupported group number, supported range is 1-1024");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Unsupported group number, supported range is 1-1024");
 		return -EOPNOTSUPP;
 	}
 
@@ -465,14 +465,14 @@ mlx5_devlink_hairpin_queue_size_validate(struct devlink *devlink, u32 id,
 	u32 val32 = val.vu32;
 
 	if (!is_power_of_2(val32)) {
-		NL_SET_ERR_MSG_MOD(extack, "Value is not power of two");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Value is not power of two");
 		return -EINVAL;
 	}
 
 	if (val32 > BIT(MLX5_CAP_GEN(dev, log_max_hairpin_num_packets))) {
-		NL_SET_ERR_MSG_FMT_MOD(
-			extack, "Maximum hairpin queue size is %lu",
-			BIT(MLX5_CAP_GEN(dev, log_max_hairpin_num_packets)));
+		MLX5_NL_SET_ERR_MSG_FMT_MOD(extack,
+					    "Maximum hairpin queue size is %lu",
+					    BIT(MLX5_CAP_GEN(dev, log_max_hairpin_num_packets)));
 		return -EINVAL;
 	}
 
@@ -717,18 +717,18 @@ static int mlx5_devlink_max_uc_list_validate(struct devlink *devlink, u32 id,
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 
 	if (val.vu32 == 0) {
-		NL_SET_ERR_MSG_MOD(extack, "max_macs value must be greater than 0");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "max_macs value must be greater than 0");
 		return -EINVAL;
 	}
 
 	if (!is_power_of_2(val.vu32)) {
-		NL_SET_ERR_MSG_MOD(extack, "Only power of 2 values are supported for max_macs");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Only power of 2 values are supported for max_macs");
 		return -EINVAL;
 	}
 
 	if (ilog2(val.vu32) >
 	    MLX5_CAP_GEN_MAX(dev, log_max_current_uc_list)) {
-		NL_SET_ERR_MSG_MOD(extack, "max_macs value is out of the supported range");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "max_macs value is out of the supported range");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 1e5522a19483..66e47ccacda6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -3,6 +3,7 @@
 
 #include <linux/dpll.h>
 #include <linux/mlx5/driver.h>
+#include "mlx5_core.h"
 
 /* This structure represents a reference to DPLL, one is created
  * per mdev instance.
@@ -242,7 +243,7 @@ static int mlx5_dpll_clock_quality_level_get(const struct dpll_device *dpll,
 		return 0;
 	}
 errout:
-	NL_SET_ERR_MSG_MOD(extack, "Invalid clock quality level obtained from firmware");
+	MLX5_NL_SET_ERR_MSG_MOD(extack, "Invalid clock quality level obtained from firmware");
 	return -EINVAL;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/htb.c b/drivers/net/ethernet/mellanox/mlx5/core/en/htb.c
index 09d441ecb9f6..17f2400c3c96 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/htb.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/htb.c
@@ -199,7 +199,7 @@ mlx5e_htb_root_add(struct mlx5e_htb *htb, u16 htb_maj_id, u16 htb_defcls,
 
 	err = mlx5_qos_create_root_node(htb->mdev, &root->hw_id);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Firmware error. Try upgrading firmware.");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Firmware error. Try upgrading firmware.");
 		goto err_sw_node_delete;
 	}
 
@@ -297,7 +297,7 @@ mlx5e_htb_leaf_alloc_queue(struct mlx5e_htb *htb, u16 classid,
 
 	qid = mlx5e_htb_find_unused_qos_qid(htb);
 	if (qid < 0) {
-		NL_SET_ERR_MSG_MOD(extack, "Maximum amount of leaf classes is reached.");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Maximum amount of leaf classes is reached.");
 		return qid;
 	}
 
@@ -317,7 +317,7 @@ mlx5e_htb_leaf_alloc_queue(struct mlx5e_htb *htb, u16 classid,
 					node->bw_share, node->max_average_bw,
 					&node->hw_id);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Firmware error when creating a leaf node.");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Firmware error when creating a leaf node.");
 		qos_err(htb->mdev, "Failed to create a leaf node (class %04x), err = %d\n",
 			classid, err);
 		mlx5e_htb_node_delete(htb, node);
@@ -327,7 +327,7 @@ mlx5e_htb_leaf_alloc_queue(struct mlx5e_htb *htb, u16 classid,
 	if (test_bit(MLX5E_STATE_OPENED, &priv->state)) {
 		err = mlx5e_open_qos_sq(priv, &priv->channels, node->qid, node->hw_id);
 		if (err) {
-			NL_SET_ERR_MSG_MOD(extack, "Error creating an SQ.");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Error creating an SQ.");
 			qos_warn(htb->mdev, "Failed to create a QoS SQ (class %04x), err = %d\n",
 				 classid, err);
 		} else {
@@ -359,7 +359,7 @@ mlx5e_htb_leaf_to_inner(struct mlx5e_htb *htb, u16 classid, u16 child_classid,
 					 node->bw_share, node->max_average_bw,
 					 &new_hw_id);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Firmware error when creating an inner node.");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Firmware error when creating an inner node.");
 		qos_err(htb->mdev, "Failed to create an inner node (class %04x), err = %d\n",
 			classid, err);
 		return err;
@@ -379,7 +379,7 @@ mlx5e_htb_leaf_to_inner(struct mlx5e_htb *htb, u16 classid, u16 child_classid,
 	err = mlx5_qos_create_leaf_node(htb->mdev, new_hw_id, child->bw_share,
 					child->max_average_bw, &child->hw_id);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Firmware error when creating a leaf node.");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Firmware error when creating a leaf node.");
 		qos_err(htb->mdev, "Failed to create a leaf node (class %04x), err = %d\n",
 			classid, err);
 		goto err_delete_sw_node;
@@ -406,7 +406,7 @@ mlx5e_htb_leaf_to_inner(struct mlx5e_htb *htb, u16 classid, u16 child_classid,
 	if (test_bit(MLX5E_STATE_OPENED, &priv->state)) {
 		err = mlx5e_open_qos_sq(priv, &priv->channels, child->qid, child->hw_id);
 		if (err) {
-			NL_SET_ERR_MSG_MOD(extack, "Error creating an SQ.");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Error creating an SQ.");
 			qos_warn(htb->mdev, "Failed to create a QoS SQ (class %04x), err = %d\n",
 				 classid, err);
 		} else {
@@ -520,7 +520,7 @@ int mlx5e_htb_leaf_del(struct mlx5e_htb *htb, u16 *classid,
 	if (test_bit(MLX5E_STATE_OPENED, &priv->state)) {
 		err = mlx5e_open_qos_sq(priv, &priv->channels, node->qid, node->hw_id);
 		if (err) {
-			NL_SET_ERR_MSG_MOD(extack, "Error creating an SQ.");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Error creating an SQ.");
 			qos_warn(htb->mdev, "Failed to create a QoS SQ (class %04x) while moving qid %u to %u, err = %d\n",
 				 node->classid, moved_qid, qid, err);
 		} else {
@@ -558,7 +558,7 @@ mlx5e_htb_leaf_del_last(struct mlx5e_htb *htb, u16 classid, bool force,
 					node->parent->max_average_bw,
 					&new_hw_id);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Firmware error when creating a leaf node.");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Firmware error when creating a leaf node.");
 		qos_err(htb->mdev, "Failed to create a leaf node (class %04x), err = %d\n",
 			classid, err);
 		if (!force)
@@ -602,7 +602,7 @@ mlx5e_htb_leaf_del_last(struct mlx5e_htb *htb, u16 classid, bool force,
 	if (test_bit(MLX5E_STATE_OPENED, &priv->state)) {
 		err = mlx5e_open_qos_sq(priv, &priv->channels, node->qid, node->hw_id);
 		if (err) {
-			NL_SET_ERR_MSG_MOD(extack, "Error creating an SQ.");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Error creating an SQ.");
 			qos_warn(htb->mdev, "Failed to create a QoS SQ (class %04x), err = %d\n",
 				 classid, err);
 		} else {
@@ -642,7 +642,7 @@ mlx5e_htb_update_children(struct mlx5e_htb *htb, struct mlx5e_qos_node *node,
 		if (!err && err_one) {
 			err = err_one;
 
-			NL_SET_ERR_MSG_MOD(extack, "Firmware error when modifying a child node.");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Firmware error when modifying a child node.");
 			qos_err(htb->mdev, "Failed to modify a child node (class %04x), err = %d\n",
 				node->classid, err);
 		}
@@ -674,7 +674,7 @@ mlx5e_htb_node_modify(struct mlx5e_htb *htb, u16 classid, u64 rate, u64 ceil,
 	err = mlx5_qos_update_node(htb->mdev, bw_share,
 				   max_average_bw, node->hw_id);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Firmware error when modifying a node.");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Firmware error when modifying a node.");
 		qos_err(htb->mdev, "Failed to modify a node (class %04x), err = %d\n",
 			classid, err);
 		return err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index f0744a45db92..2a100cd25f10 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
@@ -393,16 +393,16 @@ int mlx5e_htb_setup_tc(struct mlx5e_priv *priv, struct tc_htb_qopt_offload *htb_
 		return -EINVAL;
 
 	if (htb_qopt->prio || htb_qopt->quantum) {
-		NL_SET_ERR_MSG_MOD(htb_qopt->extack,
-				   "prio and quantum parameters are not supported by device with HTB offload enabled.");
+		MLX5_NL_SET_ERR_MSG_MOD(htb_qopt->extack,
+					"prio and quantum parameters are not supported by device with HTB offload enabled.");
 		return -EOPNOTSUPP;
 	}
 
 	switch (htb_qopt->command) {
 	case TC_HTB_CREATE:
 		if (!mlx5_qos_is_supported(priv->mdev)) {
-			NL_SET_ERR_MSG_MOD(htb_qopt->extack,
-					   "Missing QoS capabilities. Try disabling SRIOV or use a supported device.");
+			MLX5_NL_SET_ERR_MSG_MOD(htb_qopt->extack,
+						"Missing QoS capabilities. Try disabling SRIOV or use a supported device.");
 			return -EOPNOTSUPP;
 		}
 		priv->htb = mlx5e_htb_alloc();
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index 0f5d7ea8956f..e47779cda005 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -296,7 +296,7 @@ mlx5_esw_bridge_port_obj_attr_set(struct net_device *dev,
 	switch (attr->id) {
 	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
 		if (attr->u.brport_flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD)) {
-			NL_SET_ERR_MSG_MOD(extack, "Flag is not supported");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Flag is not supported");
 			err = -EINVAL;
 		}
 		break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/csum.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/csum.c
index c0f08ae6a57f..3fc468832894 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/csum.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/csum.c
@@ -16,16 +16,16 @@ csum_offload_supported(struct mlx5e_priv *priv,
 
 	/*  The HW recalcs checksums only if re-writing headers */
 	if (!(action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "TC csum action is only offloaded with pedit");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"TC csum action is only offloaded with pedit");
 		netdev_warn(priv->netdev,
 			    "TC csum action is only offloaded with pedit\n");
 		return false;
 	}
 
 	if (update_flags & ~prot_flags) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "can't offload TC csum action for some header/s");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"can't offload TC csum action for some header/s");
 		netdev_warn(priv->netdev,
 			    "can't offload TC csum action for some header/s - flags %#x\n",
 			    update_flags);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/goto.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/goto.c
index 0923e6db2d0a..cf2bb9d28894 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/goto.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/goto.c
@@ -29,27 +29,27 @@ validate_goto_chain(struct mlx5e_priv *priv,
 			   MLX5_CAP_FLOWTABLE_NIC_RX(priv->mdev, reformat_and_fwd_to_table);
 
 	if (ft_flow) {
-		NL_SET_ERR_MSG_MOD(extack, "Goto action is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Goto action is not supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (!mlx5_chains_backwards_supported(chains) &&
 	    dest_chain <= attr->chain) {
-		NL_SET_ERR_MSG_MOD(extack, "Goto lower numbered chain isn't supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Goto lower numbered chain isn't supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (dest_chain > max_chain) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Requested destination chain is out of supported range");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Requested destination chain is out of supported range");
 		return -EOPNOTSUPP;
 	}
 
 	if (attr->action & (MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT |
 			    MLX5_FLOW_CONTEXT_ACTION_DECAP) &&
 	    !reformat_and_fwd) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Goto chain is not allowed if action has reformat or decap");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Goto chain is not allowed if action has reformat or decap");
 		return -EOPNOTSUPP;
 	}
 
@@ -104,13 +104,13 @@ tc_act_post_parse_goto(struct mlx5e_tc_act_parse_state *parse_state,
 		 * device.
 		 */
 
-		NL_SET_ERR_MSG_MOD(extack, "Decap with goto isn't supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Decap with goto isn't supported");
 		netdev_warn(priv->netdev, "Decap with goto isn't supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (!mlx5e_is_eswitch_flow(flow) && parse_attr->mirred_ifindex[0]) {
-		NL_SET_ERR_MSG_MOD(extack, "Mirroring goto chain rules isn't supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Mirroring goto chain rules isn't supported");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mark.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mark.c
index e8d227595b3e..93c0a7f91e66 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mark.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mark.c
@@ -11,7 +11,7 @@ tc_act_can_offload_mark(struct mlx5e_tc_act_parse_state *parse_state,
 			struct mlx5_flow_attr *attr)
 {
 	if (act->mark & ~MLX5E_TC_FLOW_ID_MASK) {
-		NL_SET_ERR_MSG_MOD(parse_state->extack, "Bad flow mark, only 16 bit supported");
+		MLX5_NL_SET_ERR_MSG_MOD(parse_state->extack, "Bad flow mark, only 16 bit supported");
 		return false;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c
index 1b418095b79a..7fd225c3aefa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c
@@ -44,12 +44,12 @@ verify_uplink_forwarding(struct mlx5e_priv *priv,
 
 	if (!MLX5_CAP_ESW_FLOWTABLE_FDB(esw->dev,
 					termination_table_raw_traffic)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "devices are both uplink, can't offload forwarding");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"devices are both uplink, can't offload forwarding");
 			return -EOPNOTSUPP;
 	} else if (out_dev != rep_priv->netdev) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "devices are not the same uplink, can't offload forwarding");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"devices are not the same uplink, can't offload forwarding");
 		return -EOPNOTSUPP;
 	}
 	return 0;
@@ -65,7 +65,7 @@ is_duplicated_output_device(struct net_device *dev,
 
 	for (i = 0; i < if_count; i++) {
 		if (ifindexes[i] == out_dev->ifindex) {
-			NL_SET_ERR_MSG_MOD(extack, "can't duplicate output to same device");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "can't duplicate output to same device");
 			netdev_err(dev, "can't duplicate output to same device: %s\n",
 				   out_dev->name);
 			return true;
@@ -122,17 +122,17 @@ tc_act_can_offload_mirred(struct mlx5e_tc_act_parse_state *parse_state,
 	}
 
 	if (parse_state->mpls_push && !netif_is_bareudp(out_dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "mpls is supported only through a bareudp device");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "mpls is supported only through a bareudp device");
 		return false;
 	}
 
 	if (parse_state->eth_pop && !parse_state->mpls_push) {
-		NL_SET_ERR_MSG_MOD(extack, "vlan pop eth is supported only with mpls push");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "vlan pop eth is supported only with mpls push");
 		return false;
 	}
 
 	if (flow_flag_test(parse_state->flow, L3_TO_L2_DECAP) && !parse_state->eth_push) {
-		NL_SET_ERR_MSG_MOD(extack, "mpls pop is only supported with vlan eth push");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "mpls pop is only supported with vlan eth push");
 		return false;
 	}
 
@@ -145,8 +145,8 @@ tc_act_can_offload_mirred(struct mlx5e_tc_act_parse_state *parse_state,
 	}
 
 	if (esw_attr->out_count >= MLX5_MAX_FLOW_FWD_VPORTS) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "can't support more output ports, can't offload forwarding");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"can't support more output ports, can't offload forwarding");
 		netdev_warn(priv->netdev,
 			    "can't support more than %d output ports, can't offload forwarding\n",
 			    esw_attr->out_count);
@@ -167,7 +167,7 @@ tc_act_can_offload_mirred(struct mlx5e_tc_act_parse_state *parse_state,
 		return false;
 	}
 
-	NL_SET_ERR_MSG_MOD(extack, "devices are not on same switch HW, can't offload forwarding");
+	MLX5_NL_SET_ERR_MSG_MOD(extack, "devices are not on same switch HW, can't offload forwarding");
 
 	return false;
 }
@@ -258,13 +258,13 @@ parse_mirred(struct mlx5e_tc_act_parse_state *parse_state,
 		return err;
 
 	if (!mlx5e_is_valid_eswitch_fwd_dev(priv, out_dev)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "devices are not on same switch HW, can't offload forwarding");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"devices are not on same switch HW, can't offload forwarding");
 		return -EOPNOTSUPP;
 	}
 
 	if (same_vf_reps(priv, out_dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "can't forward from a VF to itself");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "can't forward from a VF to itself");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred_nic.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred_nic.c
index 7f409692b18f..0f27f5bc0178 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred_nic.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred_nic.c
@@ -20,8 +20,8 @@ tc_act_can_offload_mirred_nic(struct mlx5e_tc_act_parse_state *parse_state,
 
 	if (priv->netdev->netdev_ops != out_dev->netdev_ops ||
 	    !mlx5e_same_hw_devs(priv, netdev_priv(out_dev))) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "devices are not on same switch HW, can't offload forwarding");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"devices are not on same switch HW, can't offload forwarding");
 		netdev_warn(priv->netdev,
 			    "devices %s %s not on same switch HW, can't offload forwarding\n",
 			    netdev_name(priv->netdev),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mpls.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mpls.c
index f106190bf37c..fd2acfd8cb33 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mpls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mpls.c
@@ -16,7 +16,7 @@ tc_act_can_offload_mpls_push(struct mlx5e_tc_act_parse_state *parse_state,
 
 	if (!MLX5_CAP_ESW_FLOWTABLE_FDB(priv->mdev, reformat_l2_to_l3_tunnel) ||
 	    act->mpls_push.proto != htons(ETH_P_MPLS_UC)) {
-		NL_SET_ERR_MSG_MOD(extack, "mpls push is supported only for mpls_uc protocol");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "mpls push is supported only for mpls_uc protocol");
 		return false;
 	}
 
@@ -63,12 +63,12 @@ tc_act_can_offload_mpls_pop(struct mlx5e_tc_act_parse_state *parse_state,
 	 * egress redirect.
 	 */
 	if ((act_index == 1 && !parse_state->decap) || act_index > 1) {
-		NL_SET_ERR_MSG_MOD(extack, "mpls pop supported only as first action or with decap");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "mpls pop supported only as first action or with decap");
 		return false;
 	}
 
 	if (!netif_is_bareudp(filter_dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "mpls pop supported only on bareudp devices");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "mpls pop supported only on bareudp devices");
 		return false;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c
index b14cd62edffc..6c8f7b804802 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c
@@ -28,8 +28,8 @@ set_pedit_val(u8 hdr_type, u32 mask, u32 val, u32 offset,
 	curr_pval  = (u32 *)(pedit_header(&hdrs->vals, hdr_type) + offset);
 
 	if (*curr_pmask & mask) { /* disallow acting twice on the same location */
-		NL_SET_ERR_MSG_MOD(extack,
-				   "curr_pmask and new mask same. Acting twice on same location");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"curr_pmask and new mask same. Acting twice on same location");
 		goto out_err;
 	}
 
@@ -55,12 +55,12 @@ mlx5e_tc_act_pedit_parse_action(struct mlx5e_priv *priv,
 	u32 mask, val, offset;
 
 	if (htype == FLOW_ACT_MANGLE_UNSPEC) {
-		NL_SET_ERR_MSG_MOD(extack, "legacy pedit isn't offloaded");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "legacy pedit isn't offloaded");
 		goto out_err;
 	}
 
 	if (!mlx5e_mod_hdr_max_actions(priv->mdev, namespace)) {
-		NL_SET_ERR_MSG_MOD(extack, "The pedit offload action is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "The pedit offload action is not supported");
 		goto out_err;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/police.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/police.c
index 1bd1c94fb977..b48a7614e416 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/police.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/police.c
@@ -12,8 +12,8 @@ static bool police_act_validate_control(enum flow_action_id act_id,
 	    act_id != FLOW_ACTION_ACCEPT &&
 	    act_id != FLOW_ACTION_JUMP &&
 	    act_id != FLOW_ACTION_DROP) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Offload not supported when conform-exceed action is not pipe, ok, jump or drop");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Offload not supported when conform-exceed action is not pipe, ok, jump or drop");
 		return false;
 	}
 
@@ -29,8 +29,8 @@ static int police_act_validate(const struct flow_action_entry *act,
 
 	if (act->police.peakrate_bytes_ps ||
 	    act->police.avrate || act->police.overhead) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Offload not supported when peakrate/avrate/overhead is configured");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Offload not supported when peakrate/avrate/overhead is configured");
 		return -EOPNOTSUPP;
 	}
 
@@ -138,7 +138,7 @@ tc_act_police_offload(struct mlx5e_priv *priv,
 	}
 
 	if (IS_ERR(meter)) {
-		NL_SET_ERR_MSG_MOD(fl_act->extack, "Failed to get flow meter");
+		MLX5_NL_SET_ERR_MSG_MOD(fl_act->extack, "Failed to get flow meter");
 		mlx5_core_err(priv->mdev, "Failed to get flow meter %d\n", params.index);
 		err = PTR_ERR(meter);
 	}
@@ -156,7 +156,7 @@ tc_act_police_destroy(struct mlx5e_priv *priv,
 	params.index = fl_act->index;
 	meter = mlx5e_tc_meter_get(priv->mdev, &params);
 	if (IS_ERR(meter)) {
-		NL_SET_ERR_MSG_MOD(fl_act->extack, "Failed to get flow meter");
+		MLX5_NL_SET_ERR_MSG_MOD(fl_act->extack, "Failed to get flow meter");
 		mlx5_core_err(priv->mdev, "Failed to get flow meter %d\n", params.index);
 		return PTR_ERR(meter);
 	}
@@ -177,7 +177,7 @@ tc_act_police_stats(struct mlx5e_priv *priv,
 	params.index = fl_act->index;
 	meter = mlx5e_tc_meter_get(priv->mdev, &params);
 	if (IS_ERR(meter)) {
-		NL_SET_ERR_MSG_MOD(fl_act->extack, "Failed to get flow meter");
+		MLX5_NL_SET_ERR_MSG_MOD(fl_act->extack, "Failed to get flow meter");
 		return PTR_ERR(meter);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ptype.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ptype.c
index 80b4bc64380a..7e09c05c4c96 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ptype.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ptype.c
@@ -13,7 +13,7 @@ tc_act_parse_ptype(struct mlx5e_tc_act_parse_state *parse_state,
 	struct netlink_ext_ack *extack = parse_state->extack;
 
 	if (act->ptype != PACKET_HOST) {
-		NL_SET_ERR_MSG_MOD(extack, "skbedit ptype is only supported with type host");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "skbedit ptype is only supported with type host");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c
index 2d1d4a04501b..290f9180ce37 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c
@@ -22,26 +22,26 @@ tc_act_can_offload_redirect_ingress(struct mlx5e_tc_act_parse_state *parse_state
 		return false;
 
 	if (!netif_is_ovs_master(out_dev)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "redirect to ingress is supported only for OVS internal ports");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"redirect to ingress is supported only for OVS internal ports");
 		return false;
 	}
 
 	if (netif_is_ovs_master(parse_attr->filter_dev)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "redirect to ingress is not supported from internal port");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"redirect to ingress is not supported from internal port");
 		return false;
 	}
 
 	if (!parse_state->ptype_host) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "redirect to int port ingress requires ptype=host action");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"redirect to int port ingress requires ptype=host action");
 		return false;
 	}
 
 	if (esw_attr->out_count) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "redirect to int port ingress is supported only as single destination");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"redirect to int port ingress is supported only as single destination");
 		return false;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/tun.c
index f1cae21c2c37..32c97a55345b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/tun.c
@@ -12,8 +12,8 @@ tc_act_can_offload_tun_encap(struct mlx5e_tc_act_parse_state *parse_state,
 			     struct mlx5_flow_attr *attr)
 {
 	if (!act->tunnel) {
-		NL_SET_ERR_MSG_MOD(parse_state->extack,
-				   "Zero tunnel attributes is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(parse_state->extack,
+					"Zero tunnel attributes is not supported");
 		return false;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c
index a13c5e707b83..e9ee242c9722 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c
@@ -40,12 +40,12 @@ parse_tc_vlan_action(struct mlx5e_priv *priv,
 	u8 vlan_idx = attr->total_vlan;
 
 	if (vlan_idx >= MLX5_FS_VLAN_DEPTH) {
-		NL_SET_ERR_MSG_MOD(extack, "Total vlans used is greater than supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Total vlans used is greater than supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (!mlx5_eswitch_vlan_actions_supported(priv->mdev, vlan_idx)) {
-		NL_SET_ERR_MSG_MOD(extack, "firmware vlan actions is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "firmware vlan actions is not supported");
 		return -EOPNOTSUPP;
 	}
 
@@ -79,7 +79,7 @@ parse_tc_vlan_action(struct mlx5e_priv *priv,
 		memcpy(attr->eth.h_source, act->vlan_push_eth.src, ETH_ALEN);
 		break;
 	default:
-		NL_SET_ERR_MSG_MOD(extack, "Unexpected action id for VLAN");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Unexpected action id for VLAN");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c
index f17575b09788..60cbca0d5bcb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c
@@ -32,14 +32,14 @@ mlx5e_tc_act_vlan_add_rewrite_action(struct mlx5e_priv *priv, int namespace,
 
 	if (!(MLX5_GET(fte_match_set_lyr_2_4, headers_c, cvlan_tag) &&
 	      MLX5_GET(fte_match_set_lyr_2_4, headers_v, cvlan_tag))) {
-		NL_SET_ERR_MSG_MOD(extack, "VLAN rewrite action must have VLAN protocol match");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "VLAN rewrite action must have VLAN protocol match");
 		return -EOPNOTSUPP;
 	}
 
 	match_prio_mask = MLX5_GET(fte_match_set_lyr_2_4, headers_c, first_prio);
 	match_prio_val = MLX5_GET(fte_match_set_lyr_2_4, headers_v, first_prio);
 	if (act->vlan.prio != (match_prio_val & match_prio_mask)) {
-		NL_SET_ERR_MSG_MOD(extack, "Changing VLAN prio is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Changing VLAN prio is not supported");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 81332cd4a582..3dd14ffda7d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -1493,8 +1493,8 @@ mlx5_tc_ct_match_add(struct mlx5_tc_ct_priv *priv,
 		return 0;
 
 	if (!priv) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "offload of ct matching isn't available");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"offload of ct matching isn't available");
 		return -EOPNOTSUPP;
 	}
 
@@ -1512,8 +1512,8 @@ mlx5_tc_ct_match_add(struct mlx5_tc_ct_priv *priv,
 			      TCA_FLOWER_KEY_CT_FLAGS_REPLY |
 			      TCA_FLOWER_KEY_CT_FLAGS_RELATED |
 			      TCA_FLOWER_KEY_CT_FLAGS_INVALID)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "only ct_state trk, est, new and rpl are supported for offload");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"only ct_state trk, est, new and rpl are supported for offload");
 		return -EOPNOTSUPP;
 	}
 
@@ -1544,14 +1544,14 @@ mlx5_tc_ct_match_add(struct mlx5_tc_ct_priv *priv,
 	ctstate_mask |= uninv ? MLX5_CT_STATE_INVALID_BIT : 0;
 
 	if (rel) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "matching on ct_state +rel isn't supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"matching on ct_state +rel isn't supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (inv) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "matching on ct_state +inv isn't supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"matching on ct_state +inv isn't supported");
 		return -EOPNOTSUPP;
 	}
 
@@ -1586,8 +1586,8 @@ mlx5_tc_ct_parse_action(struct mlx5_tc_ct_priv *priv,
 			struct netlink_ext_ack *extack)
 {
 	if (!priv) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "offload of ct action isn't available");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"offload of ct action isn't available");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h
index 5e9dbdd4a5e9..bf0980909803 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h
@@ -162,7 +162,7 @@ mlx5_tc_ct_match_add(struct mlx5_tc_ct_priv *priv,
 	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CT))
 		return 0;
 
-	NL_SET_ERR_MSG_MOD(extack, "mlx5 tc ct offload isn't enabled.");
+	MLX5_NL_SET_ERR_MSG_MOD(extack, "mlx5 tc ct offload isn't enabled.");
 	return -EOPNOTSUPP;
 }
 
@@ -178,7 +178,7 @@ mlx5_tc_ct_parse_action(struct mlx5_tc_ct_priv *priv,
 			const struct flow_action_entry *act,
 			struct netlink_ext_ack *extack)
 {
-	NL_SET_ERR_MSG_MOD(extack, "mlx5 tc ct offload isn't enabled.");
+	MLX5_NL_SET_ERR_MSG_MOD(extack, "mlx5 tc ct offload isn't enabled.");
 	return -EOPNOTSUPP;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 2162d776fe35..167097ef8fab 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -926,8 +926,8 @@ int mlx5e_tc_tun_parse(struct net_device *filter_dev,
 		    !MLX5_CAP_ESW_FLOWTABLE_FDB
 			(priv->mdev,
 			 ft_field_support.outer_ipv4_ttl)) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Matching on TTL is not supported");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Matching on TTL is not supported");
 			err = -EOPNOTSUPP;
 			goto out;
 		}
@@ -956,8 +956,8 @@ int mlx5e_tc_tun_parse_udp_ports(struct mlx5e_priv *priv,
 	/* Full udp dst port must be given */
 
 	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ENC_PORTS)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "UDP tunnel decap filter must include enc_dst_port condition");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"UDP tunnel decap filter must include enc_dst_port condition");
 		netdev_warn(priv->netdev,
 			    "UDP tunnel decap filter must include enc_dst_port condition\n");
 		return -EOPNOTSUPP;
@@ -967,8 +967,8 @@ int mlx5e_tc_tun_parse_udp_ports(struct mlx5e_priv *priv,
 
 	if (memchr_inv(&enc_ports.mask->dst, 0xff,
 		       sizeof(enc_ports.mask->dst))) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "UDP tunnel decap filter must match enc_dst_port fully");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"UDP tunnel decap filter must match enc_dst_port fully");
 		netdev_warn(priv->netdev,
 			    "UDP tunnel decap filter must match enc_dst_port fully\n");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index a0fc76a1bc08..cccb06e28ed6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -707,7 +707,7 @@ static bool is_duplicated_encap_entry(struct mlx5e_priv *priv,
 	for (i = 0; i < out_index; i++) {
 		if (flow->encaps[i].e != e)
 			continue;
-		NL_SET_ERR_MSG_MOD(extack, "can't duplicate encap action");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "can't duplicate encap action");
 		netdev_err(priv->netdev, "can't duplicate encap action\n");
 		return true;
 	}
@@ -845,7 +845,7 @@ int mlx5e_attach_encap(struct mlx5e_priv *priv,
 	key.ip_tun_key = &tun_info->key;
 	key.tc_tunnel = mlx5e_get_tc_tun(mirred_dev);
 	if (!key.tc_tunnel) {
-		NL_SET_ERR_MSG_MOD(extack, "Unsupported tunnel");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Unsupported tunnel");
 		return -EOPNOTSUPP;
 	}
 
@@ -956,8 +956,8 @@ int mlx5e_attach_decap(struct mlx5e_priv *priv,
 	int err = 0;
 
 	if (sizeof(attr->eth) > MLX5_CAP_ESW(priv->mdev, max_encap_header_size)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "encap header larger than max supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"encap header larger than max supported");
 		return -EOPNOTSUPP;
 	}
 
@@ -1053,7 +1053,7 @@ int mlx5e_tc_tun_encap_dests_set(struct mlx5e_priv *priv,
 		mirred_ifindex = parse_attr->mirred_ifindex[out_index];
 		out_dev = dev_get_by_index(dev_net(priv->netdev), mirred_ifindex);
 		if (!out_dev) {
-			NL_SET_ERR_MSG_MOD(extack, "Requested mirred device not found");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Requested mirred device not found");
 			err = -ENODEV;
 			goto out;
 		}
@@ -1076,7 +1076,7 @@ int mlx5e_tc_tun_encap_dests_set(struct mlx5e_priv *priv,
 	}
 
 	if (*vf_tun && esw_attr->out_count > 1) {
-		NL_SET_ERR_MSG_MOD(extack, "VF tunnel encap with mirroring is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "VF tunnel encap with mirroring is not supported");
 		err = -EOPNOTSUPP;
 		goto out;
 	}
@@ -1844,7 +1844,7 @@ static int mlx5e_tc_tun_fib_event(struct notifier_block *nb, unsigned long event
 		if (!IS_ERR_OR_NULL(fib_work)) {
 			queue_work(priv->wq, &fib_work->work);
 		} else if (IS_ERR(fib_work)) {
-			NL_SET_ERR_MSG_MOD(info->extack, "Failed to init fib work");
+			MLX5_NL_SET_ERR_MSG_MOD(info->extack, "Failed to init fib work");
 			mlx5_core_warn(priv->mdev, "Failed to init fib work, %ld\n",
 				       PTR_ERR(fib_work));
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_geneve.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_geneve.c
index bf969212cc77..eebcedbaf9b6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_geneve.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_geneve.c
@@ -35,8 +35,8 @@ static int mlx5e_tc_tun_check_udp_dport_geneve(struct mlx5e_priv *priv,
 	 * port, so udp dst port must match.
 	 */
 	if (be16_to_cpu(enc_ports.key->dst) != GENEVE_UDP_PORT) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Matched UDP dst port is not registered as a GENEVE port");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Matched UDP dst port is not registered as a GENEVE port");
 		netdev_warn(priv->netdev,
 			    "UDP port %d is not registered as a GENEVE port\n",
 			    be16_to_cpu(enc_ports.key->dst));
@@ -142,7 +142,7 @@ static int mlx5e_tc_tun_parse_geneve_vni(struct mlx5e_priv *priv,
 		return 0;
 
 	if (!MLX5_CAP_ESW_FLOWTABLE_FDB(priv->mdev, ft_field_support.outer_geneve_vni)) {
-		NL_SET_ERR_MSG_MOD(extack, "Matching on GENEVE VNI is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Matching on GENEVE VNI is not supported");
 		netdev_warn(priv->netdev, "Matching on GENEVE VNI is not supported\n");
 		return -EOPNOTSUPP;
 	}
@@ -180,8 +180,8 @@ static int mlx5e_tc_tun_parse_geneve_options(struct mlx5e_priv *priv,
 	if (memchr_inv(&enc_opts.mask->data, 0, sizeof(enc_opts.mask->data)) &&
 	    !MLX5_CAP_ESW_FLOWTABLE_FDB(priv->mdev,
 					ft_field_support.geneve_tlv_option_0_data)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Matching on GENEVE options is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Matching on GENEVE options is not supported");
 		netdev_warn(priv->netdev,
 			    "Matching on GENEVE options is not supported\n");
 		return -EOPNOTSUPP;
@@ -190,8 +190,8 @@ static int mlx5e_tc_tun_parse_geneve_options(struct mlx5e_priv *priv,
 	/* make sure that we're talking about GENEVE options */
 
 	if (enc_opts.key->dst_opt_type != IP_TUNNEL_GENEVE_OPT_BIT) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Matching on GENEVE options: option type is not GENEVE");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Matching on GENEVE options: option type is not GENEVE");
 		netdev_warn(priv->netdev,
 			    "Matching on GENEVE options: option type is not GENEVE\n");
 		return -EOPNOTSUPP;
@@ -200,7 +200,7 @@ static int mlx5e_tc_tun_parse_geneve_options(struct mlx5e_priv *priv,
 	if (enc_opts.mask->len &&
 	    !MLX5_CAP_ESW_FLOWTABLE_FDB(priv->mdev,
 					ft_field_support.outer_geneve_opt_len)) {
-		NL_SET_ERR_MSG_MOD(extack, "Matching on GENEVE options len is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Matching on GENEVE options len is not supported");
 		netdev_warn(priv->netdev,
 			    "Matching on GENEVE options len is not supported\n");
 		return -EOPNOTSUPP;
@@ -213,8 +213,8 @@ static int mlx5e_tc_tun_parse_geneve_options(struct mlx5e_priv *priv,
 	 */
 
 	if ((enc_opts.key->len / 4) > ((max_tlv_option_data_len + 1) * max_tlv_options)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Matching on GENEVE options: unsupported options len");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Matching on GENEVE options: unsupported options len");
 		netdev_warn(priv->netdev,
 			    "Matching on GENEVE options: unsupported options len (len=%d)\n",
 			    enc_opts.key->len);
@@ -233,8 +233,8 @@ static int mlx5e_tc_tun_parse_geneve_options(struct mlx5e_priv *priv,
 		return 0;
 
 	if (option_key->length > max_tlv_option_data_len) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Matching on GENEVE options: unsupported option len");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Matching on GENEVE options: unsupported option len");
 		netdev_warn(priv->netdev,
 			    "Matching on GENEVE options: unsupported option len (key=%d, mask=%d)\n",
 			    option_key->length, option_mask->length);
@@ -243,8 +243,8 @@ static int mlx5e_tc_tun_parse_geneve_options(struct mlx5e_priv *priv,
 
 	/* data can't be all 0 - fail to offload such rule */
 	if (!memchr_inv(option_key->opt_data, 0, option_key->length * 4)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Matching on GENEVE options: can't match on 0 data field");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Matching on GENEVE options: can't match on 0 data field");
 		netdev_warn(priv->netdev,
 			    "Matching on GENEVE options: can't match on 0 data field\n");
 		return -EOPNOTSUPP;
@@ -253,8 +253,8 @@ static int mlx5e_tc_tun_parse_geneve_options(struct mlx5e_priv *priv,
 	/* add new GENEVE TLV options object */
 	res = mlx5_geneve_tlv_option_add(priv->mdev->geneve, option_key);
 	if (res) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Matching on GENEVE options: failed creating TLV opt object");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Matching on GENEVE options: failed creating TLV opt object");
 		netdev_warn(priv->netdev,
 			    "Matching on GENEVE options: failed creating TLV opt object (class:type:len = 0x%x:0x%x:%d)\n",
 			    be16_to_cpu(option_key->opt_class),
@@ -296,7 +296,7 @@ static int mlx5e_tc_tun_parse_geneve_params(struct mlx5e_priv *priv,
 	/* match on OAM - packets with OAM bit on should NOT be offloaded */
 
 	if (!MLX5_CAP_ESW_FLOWTABLE_FDB(priv->mdev, ft_field_support.outer_geneve_oam)) {
-		NL_SET_ERR_MSG_MOD(extack, "Matching on GENEVE OAM is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Matching on GENEVE OAM is not supported");
 		netdev_warn(priv->netdev, "Matching on GENEVE OAM is not supported\n");
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
index 7a18a469961d..0e432654d802 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
@@ -32,8 +32,8 @@ static int mlx5e_tc_tun_check_udp_dport_vxlan(struct mlx5e_priv *priv,
 
 	if (!mlx5_vxlan_lookup_port(priv->mdev->vxlan,
 				    be16_to_cpu(enc_ports.key->dst))) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Matched UDP dst port is not registered as a VXLAN port");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Matched UDP dst port is not registered as a VXLAN port");
 		netdev_warn(priv->netdev,
 			    "UDP port %d is not registered as a VXLAN port\n",
 			    be16_to_cpu(enc_ports.key->dst));
@@ -68,8 +68,8 @@ static int mlx5e_tc_tun_init_encap_attr_vxlan(struct net_device *tunnel_dev,
 	e->tunnel = &vxlan_tunnel;
 
 	if (!mlx5_vxlan_lookup_port(priv->mdev->vxlan, dst_port)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "vxlan udp dport was not registered with the HW");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"vxlan udp dport was not registered with the HW");
 		netdev_warn(priv->netdev,
 			    "%d isn't an offloaded vxlan udp dport\n",
 			    dst_port);
@@ -121,18 +121,18 @@ static int mlx5e_tc_tun_parse_vxlan_gbp_option(struct mlx5e_priv *priv,
 
 	if (memchr_inv(&enc_opts.mask->data, 0, sizeof(enc_opts.mask->data)) &&
 	    !MLX5_CAP_ESW_FT_FIELD_SUPPORT_2(priv->mdev, tunnel_header_0_1)) {
-		NL_SET_ERR_MSG_MOD(extack, "Matching on VxLAN GBP is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Matching on VxLAN GBP is not supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (enc_opts.key->dst_opt_type != IP_TUNNEL_VXLAN_OPT_BIT) {
-		NL_SET_ERR_MSG_MOD(extack, "Wrong VxLAN option type: not GBP");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Wrong VxLAN option type: not GBP");
 		return -EOPNOTSUPP;
 	}
 
 	if (enc_opts.key->len != sizeof(*gbp) ||
 	    enc_opts.mask->len != sizeof(*gbp_mask)) {
-		NL_SET_ERR_MSG_MOD(extack, "VxLAN GBP option/mask len is not 32 bits");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "VxLAN GBP option/mask len is not 32 bits");
 		return -EINVAL;
 	}
 
@@ -140,7 +140,7 @@ static int mlx5e_tc_tun_parse_vxlan_gbp_option(struct mlx5e_priv *priv,
 	gbp_mask = (u32 *)&enc_opts.mask->data[0];
 
 	if (*gbp_mask & ~VXLAN_GBP_MASK) {
-		NL_SET_ERR_MSG_FMT_MOD(extack, "Wrong VxLAN GBP mask(0x%08X)", *gbp_mask);
+		MLX5_NL_SET_ERR_MSG_FMT_MOD(extack, "Wrong VxLAN GBP mask(0x%08X)", *gbp_mask);
 		return -EINVAL;
 	}
 
@@ -209,8 +209,8 @@ static int mlx5e_tc_tun_parse_vxlan(struct mlx5e_priv *priv,
 
 	if (!MLX5_CAP_ESW_FLOWTABLE_FDB(priv->mdev,
 					ft_field_support.outer_vxlan_vni)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Matching on VXLAN VNI is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Matching on VXLAN VNI is not supported");
 		netdev_warn(priv->netdev,
 			    "Matching on VXLAN VNI is not supported\n");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 2dd842aac6fc..dc99d37998c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -413,94 +413,94 @@ static int mlx5e_xfrm_validate_state(struct mlx5_core_dev *mdev,
 				     struct netlink_ext_ack *extack)
 {
 	if (x->props.aalgo != SADB_AALG_NONE) {
-		NL_SET_ERR_MSG_MOD(extack, "Cannot offload authenticated xfrm states");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload authenticated xfrm states");
 		return -EINVAL;
 	}
 	if (x->props.ealgo != SADB_X_EALG_AES_GCM_ICV16) {
-		NL_SET_ERR_MSG_MOD(extack, "Only AES-GCM-ICV16 xfrm state may be offloaded");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Only AES-GCM-ICV16 xfrm state may be offloaded");
 		return -EINVAL;
 	}
 	if (x->props.calgo != SADB_X_CALG_NONE) {
-		NL_SET_ERR_MSG_MOD(extack, "Cannot offload compressed xfrm states");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload compressed xfrm states");
 		return -EINVAL;
 	}
 	if (x->props.flags & XFRM_STATE_ESN &&
 	    !(mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_ESN)) {
-		NL_SET_ERR_MSG_MOD(extack, "Cannot offload ESN xfrm states");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload ESN xfrm states");
 		return -EINVAL;
 	}
 	if (x->props.family != AF_INET &&
 	    x->props.family != AF_INET6) {
-		NL_SET_ERR_MSG_MOD(extack, "Only IPv4/6 xfrm states may be offloaded");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Only IPv4/6 xfrm states may be offloaded");
 		return -EINVAL;
 	}
 	if (x->id.proto != IPPROTO_ESP) {
-		NL_SET_ERR_MSG_MOD(extack, "Only ESP xfrm state may be offloaded");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Only ESP xfrm state may be offloaded");
 		return -EINVAL;
 	}
 	if (x->encap) {
 		if (!(mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_ESPINUDP)) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Encapsulation is not supported");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Encapsulation is not supported");
 			return -EINVAL;
 		}
 
 		if (x->encap->encap_type != UDP_ENCAP_ESPINUDP) {
-			NL_SET_ERR_MSG_MOD(extack, "Encapsulation other than UDP is not supported");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Encapsulation other than UDP is not supported");
 			return -EINVAL;
 		}
 
 		if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) {
-			NL_SET_ERR_MSG_MOD(extack, "Encapsulation is supported in packet offload mode only");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Encapsulation is supported in packet offload mode only");
 			return -EINVAL;
 		}
 
 		if (x->props.mode != XFRM_MODE_TRANSPORT) {
-			NL_SET_ERR_MSG_MOD(extack, "Encapsulation is supported in transport mode only");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Encapsulation is supported in transport mode only");
 			return -EINVAL;
 		}
 	}
 	if (!x->aead) {
-		NL_SET_ERR_MSG_MOD(extack, "Cannot offload xfrm states without aead");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload xfrm states without aead");
 		return -EINVAL;
 	}
 	if (x->aead->alg_icv_len != 128) {
-		NL_SET_ERR_MSG_MOD(extack, "Cannot offload xfrm states with AEAD ICV length other than 128bit");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload xfrm states with AEAD ICV length other than 128bit");
 		return -EINVAL;
 	}
 	if ((x->aead->alg_key_len != 128 + 32) &&
 	    (x->aead->alg_key_len != 256 + 32)) {
-		NL_SET_ERR_MSG_MOD(extack, "Cannot offload xfrm states with AEAD key length other than 128/256 bit");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload xfrm states with AEAD key length other than 128/256 bit");
 		return -EINVAL;
 	}
 	if (x->tfcpad) {
-		NL_SET_ERR_MSG_MOD(extack, "Cannot offload xfrm states with tfc padding");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload xfrm states with tfc padding");
 		return -EINVAL;
 	}
 	if (!x->geniv) {
-		NL_SET_ERR_MSG_MOD(extack, "Cannot offload xfrm states without geniv");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload xfrm states without geniv");
 		return -EINVAL;
 	}
 	if (strcmp(x->geniv, "seqiv")) {
-		NL_SET_ERR_MSG_MOD(extack, "Cannot offload xfrm states with geniv other than seqiv");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload xfrm states with geniv other than seqiv");
 		return -EINVAL;
 	}
 
 	if (x->sel.proto != IPPROTO_IP && x->sel.proto != IPPROTO_UDP &&
 	    x->sel.proto != IPPROTO_TCP) {
-		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than TCP/UDP");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than TCP/UDP");
 		return -EINVAL;
 	}
 
 	if (x->props.mode != XFRM_MODE_TRANSPORT && x->props.mode != XFRM_MODE_TUNNEL) {
-		NL_SET_ERR_MSG_MOD(extack, "Only transport and tunnel xfrm states may be offloaded");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Only transport and tunnel xfrm states may be offloaded");
 		return -EINVAL;
 	}
 
 	switch (x->xso.type) {
 	case XFRM_DEV_OFFLOAD_CRYPTO:
 		if (!(mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_CRYPTO)) {
-			NL_SET_ERR_MSG_MOD(extack, "Crypto offload is not supported");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Crypto offload is not supported");
 			return -EINVAL;
 		}
 
@@ -508,13 +508,13 @@ static int mlx5e_xfrm_validate_state(struct mlx5_core_dev *mdev,
 	case XFRM_DEV_OFFLOAD_PACKET:
 		if (!(mlx5_ipsec_device_caps(mdev) &
 		      MLX5_IPSEC_CAP_PACKET_OFFLOAD)) {
-			NL_SET_ERR_MSG_MOD(extack, "Packet offload is not supported");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Packet offload is not supported");
 			return -EINVAL;
 		}
 
 		if (x->props.mode == XFRM_MODE_TUNNEL &&
 		    !(mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_TUNNEL)) {
-			NL_SET_ERR_MSG_MOD(extack, "Packet offload is not supported for tunnel mode");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Packet offload is not supported for tunnel mode");
 			return -EINVAL;
 		}
 
@@ -523,41 +523,41 @@ static int mlx5e_xfrm_validate_state(struct mlx5_core_dev *mdev,
 		    x->replay_esn->replay_window != 64 &&
 		    x->replay_esn->replay_window != 128 &&
 		    x->replay_esn->replay_window != 256) {
-			NL_SET_ERR_MSG_MOD(extack, "Unsupported replay window size");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Unsupported replay window size");
 			return -EINVAL;
 		}
 
 		if (!x->props.reqid) {
-			NL_SET_ERR_MSG_MOD(extack, "Cannot offload without reqid");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload without reqid");
 			return -EINVAL;
 		}
 
 		if (x->lft.soft_byte_limit >= x->lft.hard_byte_limit &&
 		    x->lft.hard_byte_limit != XFRM_INF) {
 			/* XFRM stack doesn't prevent such configuration :(. */
-			NL_SET_ERR_MSG_MOD(extack, "Hard byte limit must be greater than soft one");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Hard byte limit must be greater than soft one");
 			return -EINVAL;
 		}
 
 		if (!x->lft.soft_byte_limit || !x->lft.hard_byte_limit) {
-			NL_SET_ERR_MSG_MOD(extack, "Soft/hard byte limits can't be 0");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Soft/hard byte limits can't be 0");
 			return -EINVAL;
 		}
 
 		if (x->lft.soft_packet_limit >= x->lft.hard_packet_limit &&
 		    x->lft.hard_packet_limit != XFRM_INF) {
 			/* XFRM stack doesn't prevent such configuration :(. */
-			NL_SET_ERR_MSG_MOD(extack, "Hard packet limit must be greater than soft one");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Hard packet limit must be greater than soft one");
 			return -EINVAL;
 		}
 
 		if (!x->lft.soft_packet_limit || !x->lft.hard_packet_limit) {
-			NL_SET_ERR_MSG_MOD(extack, "Soft/hard packet limits can't be 0");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Soft/hard packet limits can't be 0");
 			return -EINVAL;
 		}
 		break;
 	default:
-		NL_SET_ERR_MSG_MOD(extack, "Unsupported xfrm offload type");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Unsupported xfrm offload type");
 		return -EINVAL;
 	}
 	return 0;
@@ -759,7 +759,7 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 	if (x->props.mode == XFRM_MODE_TUNNEL &&
 	    x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
 	    !mlx5e_ipsec_fs_tunnel_enabled(sa_entry)) {
-		NL_SET_ERR_MSG_MOD(extack, "Packet offload tunnel mode is disabled due to encap settings");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Packet offload tunnel mode is disabled due to encap settings");
 		err = -EINVAL;
 		goto err_add_rule;
 	}
@@ -1086,55 +1086,55 @@ static int mlx5e_xfrm_validate_policy(struct mlx5_core_dev *mdev,
 	struct xfrm_selector *sel = &x->selector;
 
 	if (x->type != XFRM_POLICY_TYPE_MAIN) {
-		NL_SET_ERR_MSG_MOD(extack, "Cannot offload non-main policy types");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload non-main policy types");
 		return -EINVAL;
 	}
 
 	/* Please pay attention that we support only one template */
 	if (x->xfrm_nr > 1) {
-		NL_SET_ERR_MSG_MOD(extack, "Cannot offload more than one template");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload more than one template");
 		return -EINVAL;
 	}
 
 	if (x->xdo.dir != XFRM_DEV_OFFLOAD_IN &&
 	    x->xdo.dir != XFRM_DEV_OFFLOAD_OUT) {
-		NL_SET_ERR_MSG_MOD(extack, "Cannot offload forward policy");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload forward policy");
 		return -EINVAL;
 	}
 
 	if (!x->xfrm_vec[0].reqid && sel->proto == IPPROTO_IP &&
 	    addr6_all_zero(sel->saddr.a6) && addr6_all_zero(sel->daddr.a6)) {
-		NL_SET_ERR_MSG_MOD(extack, "Unsupported policy with reqid 0 without at least one of upper protocol or ip addr(s) different than 0");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Unsupported policy with reqid 0 without at least one of upper protocol or ip addr(s) different than 0");
 		return -EINVAL;
 	}
 
 	if (x->xdo.type != XFRM_DEV_OFFLOAD_PACKET) {
-		NL_SET_ERR_MSG_MOD(extack, "Unsupported xfrm offload type");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Unsupported xfrm offload type");
 		return -EINVAL;
 	}
 
 	if (x->selector.proto != IPPROTO_IP &&
 	    x->selector.proto != IPPROTO_UDP &&
 	    x->selector.proto != IPPROTO_TCP) {
-		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than TCP/UDP");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than TCP/UDP");
 		return -EINVAL;
 	}
 
 	if (x->priority) {
 		if (!(mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_PRIO)) {
-			NL_SET_ERR_MSG_MOD(extack, "Device does not support policy priority");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Device does not support policy priority");
 			return -EINVAL;
 		}
 
 		if (x->priority == U32_MAX) {
-			NL_SET_ERR_MSG_MOD(extack, "Device does not support requested policy priority");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Device does not support requested policy priority");
 			return -EINVAL;
 		}
 	}
 
 	if (x->xdo.type == XFRM_DEV_OFFLOAD_PACKET &&
 	    !(mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_PACKET_OFFLOAD)) {
-		NL_SET_ERR_MSG_MOD(extack, "Packet offload is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Packet offload is not supported");
 		return -EINVAL;
 	}
 
@@ -1177,7 +1177,7 @@ static int mlx5e_xfrm_add_policy(struct xfrm_policy *x,
 
 	priv = netdev_priv(netdev);
 	if (!priv->ipsec) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support IPsec packet offload");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Device doesn't support IPsec packet offload");
 		return -EOPNOTSUPP;
 	}
 
@@ -1209,7 +1209,7 @@ static int mlx5e_xfrm_add_policy(struct xfrm_policy *x,
 	mlx5_eswitch_unblock_ipsec(priv->mdev);
 ipsec_busy:
 	kfree(pol_entry);
-	NL_SET_ERR_MSG_MOD(extack, "Device failed to offload this policy");
+	MLX5_NL_SET_ERR_MSG_MOD(extack, "Device failed to offload this policy");
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index ea078c9f5d15..fe226be83901 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -393,16 +393,16 @@ int mlx5e_ethtool_set_ringparam(struct mlx5e_priv *priv,
 	int err = 0;
 
 	if (param->rx_pending < (1 << MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE)) {
-		NL_SET_ERR_MSG_FMT_MOD(extack, "rx (%d) < min (%d)",
-				       param->rx_pending,
-				       1 << MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE);
+		MLX5_NL_SET_ERR_MSG_FMT_MOD(extack, "rx (%d) < min (%d)",
+					    param->rx_pending,
+					    1 << MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE);
 		return -EINVAL;
 	}
 
 	if (param->tx_pending < (1 << MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)) {
-		NL_SET_ERR_MSG_FMT_MOD(extack, "tx (%d) < min (%d)",
-				       param->tx_pending,
-				       1 << MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE);
+		MLX5_NL_SET_ERR_MSG_FMT_MOD(extack, "tx (%d) < min (%d)",
+					    param->tx_pending,
+					    1 << MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE);
 		return -EINVAL;
 	}
 
@@ -574,7 +574,7 @@ int mlx5e_ethtool_get_coalesce(struct mlx5e_priv *priv,
 	struct dim_cq_moder *rx_moder, *tx_moder;
 
 	if (!MLX5_CAP_GEN(priv->mdev, cq_moderation)) {
-		NL_SET_ERR_MSG_MOD(extack, "CQ moderation not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "CQ moderation not supported");
 		return -EOPNOTSUPP;
 	}
 
@@ -723,33 +723,33 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 
 	if (!MLX5_CAP_GEN(mdev, cq_moderation) ||
 	    !MLX5_CAP_GEN(mdev, cq_period_mode_modify)) {
-		NL_SET_ERR_MSG_MOD(extack, "CQ moderation not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "CQ moderation not supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (coal->tx_coalesce_usecs > MLX5E_MAX_COAL_TIME ||
 	    coal->rx_coalesce_usecs > MLX5E_MAX_COAL_TIME) {
-		NL_SET_ERR_MSG_FMT_MOD(
-			extack,
-			"Max coalesce time %lu usecs, tx-usecs (%u) rx-usecs (%u)",
-			MLX5E_MAX_COAL_TIME, coal->tx_coalesce_usecs,
-			coal->rx_coalesce_usecs);
+		MLX5_NL_SET_ERR_MSG_FMT_MOD(extack,
+					    "Max coalesce time %lu usecs, tx-usecs (%u) rx-usecs (%u)",
+					    MLX5E_MAX_COAL_TIME,
+					    coal->tx_coalesce_usecs,
+					    coal->rx_coalesce_usecs);
 		return -ERANGE;
 	}
 
 	if (coal->tx_max_coalesced_frames > MLX5E_MAX_COAL_FRAMES ||
 	    coal->rx_max_coalesced_frames > MLX5E_MAX_COAL_FRAMES) {
-		NL_SET_ERR_MSG_FMT_MOD(
-			extack,
-			"Max coalesce frames %lu, tx-frames (%u) rx-frames (%u)",
-			MLX5E_MAX_COAL_FRAMES, coal->tx_max_coalesced_frames,
-			coal->rx_max_coalesced_frames);
+		MLX5_NL_SET_ERR_MSG_FMT_MOD(extack,
+					    "Max coalesce frames %lu, tx-frames (%u) rx-frames (%u)",
+					    MLX5E_MAX_COAL_FRAMES,
+					    coal->tx_max_coalesced_frames,
+					    coal->rx_max_coalesced_frames);
 		return -ERANGE;
 	}
 
 	if ((kernel_coal->use_cqe_mode_rx || kernel_coal->use_cqe_mode_tx) &&
 	    !MLX5_CAP_GEN(priv->mdev, cq_period_start_from_cqe)) {
-		NL_SET_ERR_MSG_MOD(extack, "cqe-mode-rx/tx is not supported on this device");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "cqe-mode-rx/tx is not supported on this device");
 		return -EOPNOTSUPP;
 	}
 
@@ -2031,10 +2031,9 @@ static int mlx5e_get_module_eeprom_by_page(struct net_device *netdev,
 		if (size_read == -EINVAL)
 			return -EINVAL;
 		if (size_read < 0) {
-			NL_SET_ERR_MSG_FMT_MOD(
-				extack,
-				"Query module eeprom by page failed, read %u bytes, err %d",
-				i, size_read);
+			MLX5_NL_SET_ERR_MSG_FMT_MOD(extack,
+						    "Query module eeprom by page failed, read %u bytes, err %d",
+						    i, size_read);
 			return i;
 		}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ea822c69d137..2e1060ae904a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3804,8 +3804,8 @@ static int mlx5e_setup_tc_mqprio(struct mlx5e_priv *priv,
 	 * simultaneously with the offloaded HTB.
 	 */
 	if (mlx5e_selq_is_htb_enabled(&priv->selq)) {
-		NL_SET_ERR_MSG_MOD(mqprio->extack,
-				   "MQPRIO cannot be configured when HTB offload is enabled.");
+		MLX5_NL_SET_ERR_MSG_MOD(mqprio->extack,
+					"MQPRIO cannot be configured when HTB offload is enabled.");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index f1d908f61134..5a4ea07e61c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1009,8 +1009,8 @@ static int mlx5e_hairpin_get_prio(struct mlx5e_priv *priv,
 
 #ifdef CONFIG_MLX5_CORE_EN_DCB
 	if (priv->dcbx_dp.trust_state != MLX5_QPTS_TRUST_PCP) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "only PCP trust state supported for hairpin");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"only PCP trust state supported for hairpin");
 		return -EOPNOTSUPP;
 	}
 #endif
@@ -1026,8 +1026,8 @@ static int mlx5e_hairpin_get_prio(struct mlx5e_priv *priv,
 	if (!vlan_present || !prio_mask) {
 		prio_val = UNKNOWN_MATCH_PRIO;
 	} else if (prio_mask != 0x7) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "masked priority match not supported for hairpin");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"masked priority match not supported for hairpin");
 		return -EOPNOTSUPP;
 	}
 
@@ -1107,12 +1107,12 @@ static int mlx5e_hairpin_flow_add(struct mlx5e_priv *priv,
 
 	peer_mdev = mlx5e_hairpin_get_mdev(dev_net(priv->netdev), peer_ifindex);
 	if (IS_ERR(peer_mdev)) {
-		NL_SET_ERR_MSG_MOD(extack, "invalid ifindex of mirred device");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "invalid ifindex of mirred device");
 		return PTR_ERR(peer_mdev);
 	}
 
 	if (!MLX5_CAP_GEN(priv->mdev, hairpin) || !MLX5_CAP_GEN(peer_mdev, hairpin)) {
-		NL_SET_ERR_MSG_MOD(extack, "hairpin is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "hairpin is not supported");
 		return -EOPNOTSUPP;
 	}
 
@@ -1707,19 +1707,19 @@ verify_attr_actions(u32 actions, struct netlink_ext_ack *extack)
 {
 	if (!(actions &
 	      (MLX5_FLOW_CONTEXT_ACTION_FWD_DEST | MLX5_FLOW_CONTEXT_ACTION_DROP))) {
-		NL_SET_ERR_MSG_MOD(extack, "Rule must have at least one forward/drop action");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Rule must have at least one forward/drop action");
 		return -EOPNOTSUPP;
 	}
 
 	if (!(~actions &
 	      (MLX5_FLOW_CONTEXT_ACTION_FWD_DEST | MLX5_FLOW_CONTEXT_ACTION_DROP))) {
-		NL_SET_ERR_MSG_MOD(extack, "Rule cannot support forward+drop action");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Rule cannot support forward+drop action");
 		return -EOPNOTSUPP;
 	}
 
 	if (actions & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR &&
 	    actions & MLX5_FLOW_CONTEXT_ACTION_DROP) {
-		NL_SET_ERR_MSG_MOD(extack, "Drop with modify header action is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Drop with modify header action is not supported");
 		return -EOPNOTSUPP;
 	}
 
@@ -1921,16 +1921,16 @@ mlx5e_tc_add_fdb_flow(struct mlx5e_priv *priv,
 	 */
 	max_chain = mlx5_chains_get_chain_range(esw_chains(esw));
 	if (!mlx5e_is_ft_flow(flow) && attr->chain > max_chain) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Requested chain is out of supported range");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Requested chain is out of supported range");
 		err = -EOPNOTSUPP;
 		goto err_out;
 	}
 
 	max_prio = mlx5_chains_get_prio_range(esw_chains(esw));
 	if (attr->prio > max_prio) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Requested priority is out of supported range");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Requested priority is out of supported range");
 		err = -EOPNOTSUPP;
 		goto err_out;
 	}
@@ -1972,15 +1972,15 @@ mlx5e_tc_add_fdb_flow(struct mlx5e_priv *priv,
 		struct mlx5e_tc_int_port *int_port;
 
 		if (attr->chain) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Internal port rule is only supported on chain 0");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Internal port rule is only supported on chain 0");
 			err = -EOPNOTSUPP;
 			goto err_out;
 		}
 
 		if (attr->dest_chain) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Internal port rule offload doesn't support goto action");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Internal port rule offload doesn't support goto action");
 			err = -EOPNOTSUPP;
 			goto err_out;
 		}
@@ -2216,8 +2216,8 @@ enc_opts_is_dont_care_or_full_match(struct mlx5e_priv *priv,
 
 			if (opt->opt_class != htons(U16_MAX) ||
 			    opt->type != U8_MAX) {
-				NL_SET_ERR_MSG_MOD(extack,
-						   "Partial match of tunnel options in chain > 0 isn't supported");
+				MLX5_NL_SET_ERR_MSG_MOD(extack,
+							"Partial match of tunnel options in chain > 0 isn't supported");
 				netdev_warn(priv->netdev,
 					    "Partial match of tunnel options in chain > 0 isn't supported");
 				return -EOPNOTSUPP;
@@ -2453,7 +2453,7 @@ static int mlx5e_tc_verify_tunnel_ecn(struct mlx5e_priv *priv,
 	}
 
 	if (outer_ecn_mask != 0 && outer_ecn_mask != INET_ECN_MASK) {
-		NL_SET_ERR_MSG_MOD(extack, "Partial match on enc_tos ecn bits isn't supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Partial match on enc_tos ecn bits isn't supported");
 		netdev_warn(priv->netdev, "Partial match on enc_tos ecn bits isn't supported");
 		return -EOPNOTSUPP;
 	}
@@ -2462,16 +2462,16 @@ static int mlx5e_tc_verify_tunnel_ecn(struct mlx5e_priv *priv,
 		if (!inner_ecn_mask)
 			return 0;
 
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Matching on tos ecn bits without also matching enc_tos ecn bits isn't supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Matching on tos ecn bits without also matching enc_tos ecn bits isn't supported");
 		netdev_warn(priv->netdev,
 			    "Matching on tos ecn bits without also matching enc_tos ecn bits isn't supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (inner_ecn_mask && inner_ecn_mask != INET_ECN_MASK) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Partial match on tos ecn bits with match on enc_tos ecn bits isn't supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Partial match on tos ecn bits with match on enc_tos ecn bits isn't supported");
 		netdev_warn(priv->netdev,
 			    "Partial match on tos ecn bits with match on enc_tos ecn bits isn't supported");
 		return -EOPNOTSUPP;
@@ -2485,7 +2485,7 @@ static int mlx5e_tc_verify_tunnel_ecn(struct mlx5e_priv *priv,
 	if (outer_ecn_key == INET_ECN_ECT_1) {
 		/* inner ecn might change by DECAP action */
 
-		NL_SET_ERR_MSG_MOD(extack, "Match on enc_tos ecn = ECT(1) isn't supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Match on enc_tos ecn = ECT(1) isn't supported");
 		netdev_warn(priv->netdev, "Match on enc_tos ecn = ECT(1) isn't supported");
 		return -EOPNOTSUPP;
 	}
@@ -2495,8 +2495,8 @@ static int mlx5e_tc_verify_tunnel_ecn(struct mlx5e_priv *priv,
 
 	if (inner_ecn_key != INET_ECN_CE) {
 		/* Can't happen in software, as packet ecn will be changed to CE after decap */
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Match on tos enc_tos ecn = CE while match on tos ecn != CE isn't supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Match on tos enc_tos ecn = CE while match on tos ecn != CE isn't supported");
 		netdev_warn(priv->netdev,
 			    "Match on tos enc_tos ecn = CE while match on tos ecn != CE isn't supported");
 		return -EOPNOTSUPP;
@@ -2525,7 +2525,7 @@ static int parse_tunnel_attr(struct mlx5e_priv *priv,
 	int err;
 
 	if (!mlx5e_is_eswitch_flow(flow)) {
-		NL_SET_ERR_MSG_MOD(extack, "Match on tunnel is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Match on tunnel is not supported");
 		return -EOPNOTSUPP;
 	}
 
@@ -2535,8 +2535,8 @@ static int parse_tunnel_attr(struct mlx5e_priv *priv,
 
 	if ((needs_mapping || sets_mapping) &&
 	    !mlx5_eswitch_reg_c1_loopback_enabled(esw)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Chains on tunnel devices isn't supported without register loopback support");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Chains on tunnel devices isn't supported without register loopback support");
 		netdev_warn(priv->netdev,
 			    "Chains on tunnel devices isn't supported without register loopback support");
 		return -EOPNOTSUPP;
@@ -2546,8 +2546,8 @@ static int parse_tunnel_attr(struct mlx5e_priv *priv,
 		err = mlx5e_tc_tun_parse(filter_dev, priv, spec, f,
 					 match_level);
 		if (err) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Failed to parse tunnel attributes");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Failed to parse tunnel attributes");
 			netdev_warn(priv->netdev,
 				    "Failed to parse tunnel attributes");
 			return err;
@@ -2566,7 +2566,7 @@ static int parse_tunnel_attr(struct mlx5e_priv *priv,
 
 		tmp_spec = kvzalloc(sizeof(*tmp_spec), GFP_KERNEL);
 		if (!tmp_spec) {
-			NL_SET_ERR_MSG_MOD(extack, "Failed to allocate memory for tunnel tmp spec");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Failed to allocate memory for tunnel tmp spec");
 			netdev_warn(priv->netdev, "Failed to allocate memory for tunnel tmp spec");
 			return -ENOMEM;
 		}
@@ -2575,7 +2575,7 @@ static int parse_tunnel_attr(struct mlx5e_priv *priv,
 		err = mlx5e_tc_tun_parse(filter_dev, priv, tmp_spec, f, match_level);
 		if (err) {
 			kvfree(tmp_spec);
-			NL_SET_ERR_MSG_MOD(extack, "Failed to parse tunnel attributes");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Failed to parse tunnel attributes");
 			netdev_warn(priv->netdev, "Failed to parse tunnel attributes");
 			return err;
 		}
@@ -2643,7 +2643,7 @@ static int mlx5e_flower_parse_meta(struct net_device *filter_dev,
 	flow_rule_match_meta(rule, &match);
 
 	if (match.mask->l2_miss) {
-		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on \"l2_miss\"");
+		MLX5_NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on \"l2_miss\"");
 		return -EOPNOTSUPP;
 	}
 
@@ -2651,21 +2651,21 @@ static int mlx5e_flower_parse_meta(struct net_device *filter_dev,
 		return 0;
 
 	if (match.mask->ingress_ifindex != 0xFFFFFFFF) {
-		NL_SET_ERR_MSG_MOD(extack, "Unsupported ingress ifindex mask");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Unsupported ingress ifindex mask");
 		return -EOPNOTSUPP;
 	}
 
 	ingress_dev = __dev_get_by_index(dev_net(filter_dev),
 					 match.key->ingress_ifindex);
 	if (!ingress_dev) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't find the ingress port to match on");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Can't find the ingress port to match on");
 		return -ENOENT;
 	}
 
 	if (ingress_dev != filter_dev) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't match on the ingress filter port");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Can't match on the ingress filter port");
 		return -EOPNOTSUPP;
 	}
 
@@ -2740,7 +2740,7 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_OPTS) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_ICMP) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_MPLS))) {
-		NL_SET_ERR_MSG_MOD(extack, "Unsupported key");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Unsupported key");
 		netdev_dbg(priv->netdev, "Unsupported key used: 0x%llx\n",
 			   dissector->used_keys);
 		return -EOPNOTSUPP;
@@ -2858,8 +2858,8 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 		    match.mask->vlan_tpid) {
 			if (!MLX5_CAP_FLOWTABLE_TYPE(priv->mdev, ft_field_support.outer_second_vid,
 						     fs_type)) {
-				NL_SET_ERR_MSG_MOD(extack,
-						   "Matching on CVLAN is not supported");
+				MLX5_NL_SET_ERR_MSG_MOD(extack,
+							"Matching on CVLAN is not supported");
 				return -EOPNOTSUPP;
 			}
 
@@ -3019,8 +3019,8 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 		if (match.mask->ttl &&
 		    !MLX5_CAP_ESW_FLOWTABLE_FDB(priv->mdev,
 						ft_field_support.outer_ipv4_ttl)) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Matching on TTL is not supported");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Matching on TTL is not supported");
 			return -EOPNOTSUPP;
 		}
 
@@ -3059,8 +3059,8 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 				 udp_dport, ntohs(match.key->dst));
 			break;
 		default:
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Only UDP and TCP transports are supported for L4 matching");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Only UDP and TCP transports are supported for L4 matching");
 			netdev_err(priv->netdev,
 				   "Only UDP and TCP transport are supported\n");
 			return -EINVAL;
@@ -3090,8 +3090,8 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 		case IPPROTO_ICMP:
 			if (!(MLX5_CAP_GEN(priv->mdev, flex_parser_protocols) &
 			      MLX5_FLEX_PROTO_ICMP)) {
-				NL_SET_ERR_MSG_MOD(extack,
-						   "Match on Flex protocols for ICMP is not supported");
+				MLX5_NL_SET_ERR_MSG_MOD(extack,
+							"Match on Flex protocols for ICMP is not supported");
 				return -EOPNOTSUPP;
 			}
 			MLX5_SET(fte_match_set_misc3, misc_c_3, icmp_type,
@@ -3106,8 +3106,8 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 		case IPPROTO_ICMPV6:
 			if (!(MLX5_CAP_GEN(priv->mdev, flex_parser_protocols) &
 			      MLX5_FLEX_PROTO_ICMPV6)) {
-				NL_SET_ERR_MSG_MOD(extack,
-						   "Match on Flex protocols for ICMPV6 is not supported");
+				MLX5_NL_SET_ERR_MSG_MOD(extack,
+							"Match on Flex protocols for ICMPV6 is not supported");
 				return -EOPNOTSUPP;
 			}
 			MLX5_SET(fte_match_set_misc3, misc_c_3, icmpv6_type,
@@ -3120,8 +3120,8 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 				 match.key->code);
 			break;
 		default:
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Code and type matching only with ICMP and ICMPv6");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Code and type matching only with ICMP and ICMPv6");
 			netdev_err(priv->netdev,
 				   "Code and type matching only with ICMP and ICMPv6\n");
 			return -EINVAL;
@@ -3134,8 +3134,8 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 	/* Currently supported only for MPLS over UDP */
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_MPLS) &&
 	    !netif_is_bareudp(filter_dev)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Matching on MPLS is supported only for MPLS over UDP");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Matching on MPLS is supported only for MPLS over UDP");
 		netdev_err(priv->netdev,
 			   "Matching on MPLS is supported only for MPLS over UDP\n");
 		return -EOPNOTSUPP;
@@ -3173,8 +3173,8 @@ static int parse_cls_flower(struct mlx5e_priv *priv,
 		if (rep->vport != MLX5_VPORT_UPLINK &&
 		    (esw->offloads.inline_mode != MLX5_INLINE_MODE_NONE &&
 		    esw->offloads.inline_mode < non_tunnel_match_level)) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Flow is not offloaded due to min inline setting");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Flow is not offloaded due to min inline setting");
 			netdev_warn(priv->netdev,
 				    "Flow is not offloaded due to min inline setting, required %d actual %d\n",
 				    non_tunnel_match_level, esw->offloads.inline_mode);
@@ -3343,8 +3343,8 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 			continue;
 
 		if (s_mask && a_mask) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "can't set and add to the same HW field");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"can't set and add to the same HW field");
 			netdev_warn(priv->netdev,
 				    "mlx5: can't set and add to the same HW field (%x)\n",
 				    f->field);
@@ -3382,8 +3382,8 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 		next_z = find_next_zero_bit(&mask, f->field_bsize, first);
 		last  = find_last_bit(&mask, f->field_bsize);
 		if (first < next_z && next_z < last) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "rewrite of few sub-fields isn't supported");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"rewrite of few sub-fields isn't supported");
 			netdev_warn(priv->netdev,
 				    "mlx5: rewrite of few sub-fields (mask %lx) isn't offloaded\n",
 				    mask);
@@ -3392,8 +3392,8 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 
 		action = mlx5e_mod_hdr_alloc(priv->mdev, namespace, mod_acts);
 		if (IS_ERR(action)) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "too many pedit actions, can't offload");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"too many pedit actions, can't offload");
 			mlx5_core_warn(priv->mdev,
 				       "mlx5: parsed %d pedit actions, can't do more\n",
 				       mod_acts->num_actions);
@@ -3440,7 +3440,7 @@ static int verify_offload_pedit_fields(struct mlx5e_priv *priv,
 	for (cmd = 0; cmd < __PEDIT_CMD_MAX; cmd++) {
 		cmd_masks = &parse_attr->hdrs[cmd].masks;
 		if (memcmp(cmd_masks, &zero_masks, sizeof(zero_masks))) {
-			NL_SET_ERR_MSG_MOD(extack, "attempt to offload an unsupported field");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "attempt to offload an unsupported field");
 			netdev_warn(priv->netdev, "attempt to offload an unsupported field (cmd %d)\n", cmd);
 			print_hex_dump(KERN_WARNING, "mask: ", DUMP_PREFIX_ADDRESS,
 				       16, 1, cmd_masks, sizeof(zero_masks), true);
@@ -3553,8 +3553,8 @@ static bool modify_header_match_supported(struct mlx5e_priv *priv,
 	ip_proto = MLX5_GET(fte_match_set_lyr_2_4, headers_v, ip_protocol);
 	if (modify_ip_header && ip_proto != IPPROTO_TCP &&
 	    ip_proto != IPPROTO_UDP && ip_proto != IPPROTO_ICMP) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "can't offload re-write of non TCP/UDP");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"can't offload re-write of non TCP/UDP");
 		netdev_info(priv->netdev, "can't offload re-write of ip proto %d\n",
 			    ip_proto);
 		return false;
@@ -3572,8 +3572,8 @@ actions_match_supported_fdb(struct mlx5e_priv *priv,
 	struct mlx5_esw_flow_attr *esw_attr = flow->attr->esw_attr;
 
 	if (esw_attr->split_count > 0 && !mlx5_esw_has_fwd_fdb(priv->mdev)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "current firmware doesn't support split rule for port mirroring");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"current firmware doesn't support split rule for port mirroring");
 		netdev_warn_once(priv->netdev,
 				 "current firmware doesn't support split rule for port mirroring\n");
 		return false;
@@ -3899,7 +3899,7 @@ alloc_branch_attr(struct mlx5e_tc_flow *flow,
 		break;
 	case FLOW_ACTION_JUMP:
 		if (*jump_count) {
-			NL_SET_ERR_MSG_MOD(extack, "Cannot offload flows with nested jumps");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Cannot offload flows with nested jumps");
 			err = -EOPNOTSUPP;
 			goto out_err;
 		}
@@ -4035,7 +4035,7 @@ parse_tc_actions(struct mlx5e_tc_act_parse_state *parse_state,
 
 		tc_act = mlx5e_tc_act_get(act->id, ns_type);
 		if (!tc_act) {
-			NL_SET_ERR_MSG_MOD(extack, "Not implemented offload action");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "Not implemented offload action");
 			err = -EOPNOTSUPP;
 			goto out_free_post_acts;
 		}
@@ -4112,13 +4112,13 @@ flow_action_supported(struct flow_action *flow_action,
 		      struct netlink_ext_ack *extack)
 {
 	if (!flow_action_has_entries(flow_action)) {
-		NL_SET_ERR_MSG_MOD(extack, "Flow action doesn't have any entries");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Flow action doesn't have any entries");
 		return -EINVAL;
 	}
 
 	if (!flow_action_hw_stats_check(flow_action, extack,
 					FLOW_ACTION_HW_STATS_DELAYED_BIT)) {
-		NL_SET_ERR_MSG_MOD(extack, "Flow action HW stats type is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Flow action HW stats type is not supported");
 		return -EOPNOTSUPP;
 	}
 
@@ -4290,16 +4290,16 @@ parse_tc_fdb_actions(struct mlx5e_priv *priv,
 	/* Forward to/from internal port can only have 1 dest */
 	if ((netif_is_ovs_master(filter_dev) || esw_attr->dest_int_port) &&
 	    esw_attr->out_count > 1) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Rules with internal port can have only one destination");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Rules with internal port can have only one destination");
 		return -EOPNOTSUPP;
 	}
 
 	/* Forward from tunnel/internal port to internal port is not supported */
 	if ((mlx5e_get_tc_tun(filter_dev) || netif_is_ovs_master(filter_dev)) &&
 	    esw_attr->dest_int_port) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Forwarding from tunnel/internal port to internal port is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Forwarding from tunnel/internal port to internal port is not supported");
 		return -EOPNOTSUPP;
 	}
 
@@ -4834,8 +4834,8 @@ int mlx5e_configure_flower(struct net_device *dev, struct mlx5e_priv *priv,
 		if (is_flow_rule_duplicate_allowed(dev, rpriv) && flow->orig_dev != dev)
 			goto rcu_unlock;
 
-		NL_SET_ERR_MSG_MOD(extack,
-				   "flow cookie already exists, ignoring");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"flow cookie already exists, ignoring");
 		netdev_warn_once(priv->netdev,
 				 "flow cookie %lx already exists, ignoring\n",
 				 f->cookie);
@@ -5018,8 +5018,8 @@ static int apply_police_params(struct mlx5e_priv *priv, u64 rate,
 
 	vport_num = rpriv->rep->vport;
 	if (vport_num >= MLX5_VPORT_ECPF) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Ingress rate limit is supported only for Eswitch ports connected to VFs");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Ingress rate limit is supported only for Eswitch ports connected to VFs");
 		return -EOPNOTSUPP;
 	}
 
@@ -5038,7 +5038,7 @@ static int apply_police_params(struct mlx5e_priv *priv, u64 rate,
 
 	err = mlx5_esw_qos_modify_vport_rate(esw, vport_num, rate_mbps);
 	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "failed applying action to hardware");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "failed applying action to hardware");
 
 	return err;
 }
@@ -5049,28 +5049,28 @@ tc_matchall_police_validate(const struct flow_action *action,
 			    struct netlink_ext_ack *extack)
 {
 	if (act->police.notexceed.act_id != FLOW_ACTION_CONTINUE) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Offload not supported when conform action is not continue");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Offload not supported when conform action is not continue");
 		return -EOPNOTSUPP;
 	}
 
 	if (act->police.exceed.act_id != FLOW_ACTION_DROP) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Offload not supported when exceed action is not drop");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Offload not supported when exceed action is not drop");
 		return -EOPNOTSUPP;
 	}
 
 	if (act->police.notexceed.act_id == FLOW_ACTION_ACCEPT &&
 	    !flow_action_is_last_entry(action, act)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Offload not supported when conform action is ok, but action is not last");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Offload not supported when conform action is ok, but action is not last");
 		return -EOPNOTSUPP;
 	}
 
 	if (act->police.peakrate_bytes_ps ||
 	    act->police.avrate || act->police.overhead) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Offload not supported when peakrate/avrate/overhead is configured");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Offload not supported when peakrate/avrate/overhead is configured");
 		return -EOPNOTSUPP;
 	}
 
@@ -5087,17 +5087,17 @@ static int scan_tc_matchall_fdb_actions(struct mlx5e_priv *priv,
 	int i;
 
 	if (!flow_action_has_entries(flow_action)) {
-		NL_SET_ERR_MSG_MOD(extack, "matchall called with no action");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "matchall called with no action");
 		return -EINVAL;
 	}
 
 	if (!flow_offload_has_one_action(flow_action)) {
-		NL_SET_ERR_MSG_MOD(extack, "matchall policing support only a single action");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "matchall policing support only a single action");
 		return -EOPNOTSUPP;
 	}
 
 	if (!flow_action_basic_hw_stats_check(flow_action, extack)) {
-		NL_SET_ERR_MSG_MOD(extack, "Flow action HW stats type is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Flow action HW stats type is not supported");
 		return -EOPNOTSUPP;
 	}
 
@@ -5116,7 +5116,7 @@ static int scan_tc_matchall_fdb_actions(struct mlx5e_priv *priv,
 						   &priv->stats.rep_stats);
 			break;
 		default:
-			NL_SET_ERR_MSG_MOD(extack, "mlx5 supports only police action for matchall");
+			MLX5_NL_SET_ERR_MSG_MOD(extack, "mlx5 supports only police action for matchall");
 			return -EOPNOTSUPP;
 		}
 	}
@@ -5130,7 +5130,7 @@ int mlx5e_tc_configure_matchall(struct mlx5e_priv *priv,
 	struct netlink_ext_ack *extack = ma->common.extack;
 
 	if (ma->common.prio != 1) {
-		NL_SET_ERR_MSG_MOD(extack, "only priority 1 is supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "only priority 1 is supported");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index 76e35c827da0..934c7d738736 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -1615,13 +1615,13 @@ static int mlx5_esw_bridge_vport_link_with_flags(struct net_device *br_netdev, u
 
 	bridge = mlx5_esw_bridge_lookup(br_netdev, br_offloads);
 	if (IS_ERR(bridge)) {
-		NL_SET_ERR_MSG_MOD(extack, "Error checking for existing bridge with same ifindex");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Error checking for existing bridge with same ifindex");
 		return PTR_ERR(bridge);
 	}
 
 	err = mlx5_esw_bridge_vport_init(vport_num, esw_owner_vhca_id, flags, br_offloads, bridge);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Error initializing port");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Error initializing port");
 		goto err_vport;
 	}
 	return 0;
@@ -1649,17 +1649,17 @@ int mlx5_esw_bridge_vport_unlink(struct net_device *br_netdev, u16 vport_num,
 
 	port = mlx5_esw_bridge_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
 	if (!port) {
-		NL_SET_ERR_MSG_MOD(extack, "Port is not attached to any bridge");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Port is not attached to any bridge");
 		return -EINVAL;
 	}
 	if (port->bridge->ifindex != br_netdev->ifindex) {
-		NL_SET_ERR_MSG_MOD(extack, "Port is attached to another bridge");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Port is attached to another bridge");
 		return -EINVAL;
 	}
 
 	err = mlx5_esw_bridge_vport_cleanup(br_offloads, port);
 	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "Port cleanup failed");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Port cleanup failed");
 	return err;
 }
 
@@ -1706,7 +1706,7 @@ int mlx5_esw_bridge_port_vlan_add(u16 vport_num, u16 esw_owner_vhca_id, u16 vid,
 	vlan = mlx5_esw_bridge_vlan_create(port->bridge->vlan_proto, vid, flags, port,
 					   br_offloads->esw);
 	if (IS_ERR(vlan)) {
-		NL_SET_ERR_MSG_MOD(extack, "Failed to create VLAN entry");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Failed to create VLAN entry");
 		return PTR_ERR(vlan);
 	}
 	return 0;
@@ -1862,9 +1862,9 @@ int mlx5_esw_bridge_port_mdb_add(struct net_device *dev, u16 vport_num, u16 esw_
 		esw_warn(br_offloads->esw->dev,
 			 "Failed to lookup bridge port to add MDB (MAC=%pM,vport=%u)\n",
 			 addr, vport_num);
-		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "Failed to lookup bridge port to add MDB (MAC=%pM,vport=%u)",
-				       addr, vport_num);
+		MLX5_NL_SET_ERR_MSG_FMT_MOD(extack,
+					    "Failed to lookup bridge port to add MDB (MAC=%pM,vport=%u)",
+					    addr, vport_num);
 		return -EINVAL;
 	}
 
@@ -1875,17 +1875,17 @@ int mlx5_esw_bridge_port_mdb_add(struct net_device *dev, u16 vport_num, u16 esw_
 			esw_warn(br_offloads->esw->dev,
 				 "Failed to lookup bridge port vlan metadata to create MDB (MAC=%pM,vid=%u,vport=%u)\n",
 				 addr, vid, vport_num);
-			NL_SET_ERR_MSG_FMT_MOD(extack,
-					       "Failed to lookup vlan metadata for MDB (MAC=%pM,vid=%u,vport=%u)",
-					       addr, vid, vport_num);
+			MLX5_NL_SET_ERR_MSG_FMT_MOD(extack,
+						    "Failed to lookup vlan metadata for MDB (MAC=%pM,vid=%u,vport=%u)",
+						    addr, vid, vport_num);
 			return -EINVAL;
 		}
 	}
 
 	err = mlx5_esw_bridge_port_mdb_attach(dev, port, addr, vid);
 	if (err) {
-		NL_SET_ERR_MSG_FMT_MOD(extack, "Failed to add MDB (MAC=%pM,vid=%u,vport=%u)",
-				       addr, vid, vport_num);
+		MLX5_NL_SET_ERR_MSG_FMT_MOD(extack, "Failed to add MDB (MAC=%pM,vid=%u,vport=%u)",
+					    addr, vid, vport_num);
 		return err;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index b6ae384396b3..308fae6afc9f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -162,7 +162,7 @@ static int esw_qos_node_create_sched_element(struct mlx5_esw_sched_node *node, v
 						 &node->ix);
 	if (err) {
 		esw_qos_sched_elem_warn(node, err, "create");
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch create scheduling element failed");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "E-Switch create scheduling element failed");
 	}
 
 	return err;
@@ -178,7 +178,7 @@ static int esw_qos_node_destroy_sched_element(struct mlx5_esw_sched_node *node,
 						  node->ix);
 	if (err) {
 		esw_qos_sched_elem_warn(node, err, "destroy");
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroying scheduling element failed.");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "E-Switch destroying scheduling element failed.");
 	}
 
 	return err;
@@ -218,7 +218,7 @@ static int esw_qos_sched_elem_config(struct mlx5_esw_sched_node *node, u32 max_r
 						 bitmask);
 	if (err) {
 		esw_qos_sched_elem_warn(node, err, "modify");
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch modify scheduling element failed");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "E-Switch modify scheduling element failed");
 
 		return err;
 	}
@@ -415,13 +415,13 @@ __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sch
 	err = esw_qos_create_node_sched_elem(esw->dev, esw->qos.root_tsar_ix, 0,
 					     0, &tsar_ix);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for node failed");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for node failed");
 		return ERR_PTR(err);
 	}
 
 	node = __esw_qos_alloc_node(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
 	if (!node) {
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc node failed");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc node failed");
 		err = -ENOMEM;
 		goto err_alloc_node;
 	}
@@ -435,7 +435,7 @@ __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sch
 	if (mlx5_destroy_scheduling_element_cmd(esw->dev,
 						SCHEDULING_HIERARCHY_E_SWITCH,
 						tsar_ix))
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for node failed");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for node failed");
 	return ERR_PTR(err);
 }
 
@@ -768,7 +768,7 @@ static int mlx5_esw_qos_max_link_speed_get(struct mlx5_core_dev *mdev, u32 *link
 skip_lag:
 	err = mlx5_port_max_linkspeed(mdev, link_speed_max);
 	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "Failed to get link maximum speed");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Failed to get link maximum speed");
 
 	return err;
 }
@@ -780,7 +780,7 @@ static int mlx5_esw_qos_link_speed_verify(struct mlx5_core_dev *mdev,
 	if (value > link_speed_max) {
 		pr_err("%s rate value %lluMbps exceed link maximum speed %u.\n",
 		       name, value, link_speed_max);
-		NL_SET_ERR_MSG_MOD(extack, "TX rate value exceed link maximum speed");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "TX rate value exceed link maximum speed");
 		return -EINVAL;
 	}
 
@@ -832,7 +832,7 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 	if (remainder) {
 		pr_err("%s rate value %lluBps not in link speed units of 1Mbps.\n",
 		       name, *rate);
-		NL_SET_ERR_MSG_MOD(extack, "TX rate value not in link speed units of 1Mbps");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "TX rate value not in link speed units of 1Mbps");
 		return -EINVAL;
 	}
 
@@ -953,8 +953,8 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 
 	esw_qos_lock(esw);
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Rate node creation supported only in switchdev mode");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Rate node creation supported only in switchdev mode");
 		err = -EOPNOTSUPP;
 		goto unlock;
 	}
@@ -991,7 +991,7 @@ int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_s
 	int err = 0;
 
 	if (parent && parent->esw != esw) {
-		NL_SET_ERR_MSG_MOD(extack, "Cross E-Switch scheduling is not supported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Cross E-Switch scheduling is not supported");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 0e3a977d5332..5b9a7822c99c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2357,8 +2357,8 @@ static int esw_offloads_start(struct mlx5_eswitch *esw,
 	esw_mode_change(esw, MLX5_ESWITCH_OFFLOADS);
 	err = mlx5_eswitch_enable_locked(esw, esw->dev->priv.sriov.num_vfs);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Failed setting eswitch to offloads");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Failed setting eswitch to offloads");
 		esw_mode_change(esw, MLX5_ESWITCH_LEGACY);
 		return err;
 	}
@@ -2366,8 +2366,8 @@ static int esw_offloads_start(struct mlx5_eswitch *esw,
 		if (mlx5_eswitch_inline_mode_get(esw,
 						 &esw->offloads.inline_mode)) {
 			esw->offloads.inline_mode = MLX5_INLINE_MODE_L2;
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Inline mode is different between vports");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Inline mode is different between vports");
 		}
 	}
 	return 0;
@@ -2480,8 +2480,8 @@ static int esw_port_metadata_validate(struct devlink *devlink, u32 id,
 
 	esw_mode = mlx5_eswitch_mode(dev);
 	if (esw_mode == MLX5_ESWITCH_OFFLOADS) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "E-Switch must either disabled or non switchdev mode");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"E-Switch must either disabled or non switchdev mode");
 		return -EBUSY;
 	}
 	return 0;
@@ -3616,7 +3616,7 @@ static int esw_offloads_stop(struct mlx5_eswitch *esw,
 
 	err = mlx5_eswitch_enable_locked(esw, MLX5_ESWITCH_IGNORE_NUM_VFS);
 	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "Failed setting eswitch to legacy");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Failed setting eswitch to legacy");
 
 	return err;
 }
@@ -3754,15 +3754,15 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		return -EINVAL;
 
 	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV && mlx5_get_sd(esw->dev)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't change E-Switch mode to switchdev when multi-PF netdev (Socket Direct) is configured.");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Can't change E-Switch mode to switchdev when multi-PF netdev (Socket Direct) is configured.");
 		return -EPERM;
 	}
 
 	mlx5_lag_disable_change(esw->dev);
 	err = mlx5_esw_try_lock(esw);
 	if (err < 0) {
-		NL_SET_ERR_MSG_MOD(extack, "Can't change mode, E-Switch is busy");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Can't change mode, E-Switch is busy");
 		goto enable_lag;
 	}
 	cur_mlx5_mode = err;
@@ -3772,8 +3772,8 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		goto unlock;
 
 	if (esw->offloads.num_block_mode) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't change eswitch mode when IPsec SA and/or policies are configured");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Can't change eswitch mode when IPsec SA and/or policies are configured");
 		err = -EOPNOTSUPP;
 		goto unlock;
 	}
@@ -3786,8 +3786,8 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	mlx5_eswitch_disable_locked(esw);
 	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV) {
 		if (mlx5_devlink_trap_get_num_active(esw->dev)) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Can't change mode while devlink traps are active");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Can't change mode while devlink traps are active");
 			err = -EOPNOTSUPP;
 			goto skip;
 		}
@@ -3832,8 +3832,8 @@ static int mlx5_esw_vports_inline_set(struct mlx5_eswitch *esw, u8 mlx5_mode,
 		err = mlx5_modify_nic_vport_min_inline(dev, vport->vport, mlx5_mode);
 		if (err) {
 			err_vport_num = vport->vport;
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Failed to set min inline on vport");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Failed to set min inline on vport");
 			goto revert_inline_mode;
 		}
 	}
@@ -3842,8 +3842,8 @@ static int mlx5_esw_vports_inline_set(struct mlx5_eswitch *esw, u8 mlx5_mode,
 			err = mlx5_modify_nic_vport_min_inline(dev, vport->vport, mlx5_mode);
 			if (err) {
 				err_vport_num = vport->vport;
-				NL_SET_ERR_MSG_MOD(extack,
-						   "Failed to set min inline on vport");
+				MLX5_NL_SET_ERR_MSG_MOD(extack,
+							"Failed to set min inline on vport");
 				goto revert_ec_vf_inline_mode;
 			}
 		}
@@ -3892,7 +3892,7 @@ int mlx5_devlink_eswitch_inline_mode_set(struct devlink *devlink, u8 mode,
 
 		fallthrough;
 	case MLX5_CAP_INLINE_MODE_L2:
-		NL_SET_ERR_MSG_MOD(extack, "Inline mode can't be set");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Inline mode can't be set");
 		err = -EOPNOTSUPP;
 		goto out;
 	case MLX5_CAP_INLINE_MODE_VPORT_CONTEXT:
@@ -3900,8 +3900,8 @@ int mlx5_devlink_eswitch_inline_mode_set(struct devlink *devlink, u8 mode,
 	}
 
 	if (atomic64_read(&esw->offloads.num_flows) > 0) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't set inline mode when flows are configured");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Can't set inline mode when flows are configured");
 		err = -EOPNOTSUPP;
 		goto out;
 	}
@@ -4004,15 +4004,15 @@ int mlx5_devlink_eswitch_encap_mode_set(struct devlink *devlink,
 		goto unlock;
 
 	if (atomic64_read(&esw->offloads.num_flows) > 0) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't set encapsulation when flows are configured");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Can't set encapsulation when flows are configured");
 		err = -EOPNOTSUPP;
 		goto unlock;
 	}
 
 	if (esw->offloads.num_block_encap) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't set encapsulation when IPsec SA and/or policies are configured");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Can't set encapsulation when IPsec SA and/or policies are configured");
 		err = -EOPNOTSUPP;
 		goto unlock;
 	}
@@ -4027,8 +4027,8 @@ int mlx5_devlink_eswitch_encap_mode_set(struct devlink *devlink,
 	err = esw_create_offloads_fdb_tables(esw);
 
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Failed re-creating fast FDB table");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Failed re-creating fast FDB table");
 		esw->offloads.encap = !encap;
 		(void)esw_create_offloads_fdb_tables(esw);
 	}
@@ -4255,12 +4255,12 @@ int mlx5_devlink_port_fn_migratable_get(struct devlink_port *port, bool *is_enab
 	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
 
 	if (!MLX5_CAP_GEN(esw->dev, migration)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support migration");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Device doesn't support migration");
 		return -EOPNOTSUPP;
 	}
 
 	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
 		return -EOPNOTSUPP;
 	}
 
@@ -4281,12 +4281,12 @@ int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 	int err;
 
 	if (!MLX5_CAP_GEN(esw->dev, migration)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support migration");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Device doesn't support migration");
 		return -EOPNOTSUPP;
 	}
 
 	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
 		return -EOPNOTSUPP;
 	}
 
@@ -4306,7 +4306,7 @@ int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 	err = mlx5_vport_get_other_func_cap(esw->dev, vport->vport, query_ctx,
 					    MLX5_CAP_GENERAL_2);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
 		goto out_free;
 	}
 
@@ -4316,7 +4316,7 @@ int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport->vport,
 					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA migratable cap");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA migratable cap");
 		goto out_free;
 	}
 
@@ -4336,7 +4336,7 @@ int mlx5_devlink_port_fn_roce_get(struct devlink_port *port, bool *is_enabled,
 	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
 
 	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
 		return -EOPNOTSUPP;
 	}
 
@@ -4358,7 +4358,7 @@ int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
 	int err;
 
 	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
 		return -EOPNOTSUPP;
 	}
 
@@ -4378,7 +4378,7 @@ int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
 	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_ctx,
 					    MLX5_CAP_GENERAL);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
 		goto out_free;
 	}
 
@@ -4388,7 +4388,7 @@ int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
 	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_num,
 					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA roce cap");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA roce cap");
 		goto out_free;
 	}
 
@@ -4430,7 +4430,7 @@ int mlx5_devlink_port_fn_ipsec_crypto_get(struct devlink_port *port, bool *is_en
 		return PTR_ERR(esw);
 
 	if (!mlx5_esw_ipsec_vf_offload_supported(esw->dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support IPSec crypto");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Device doesn't support IPSec crypto");
 		return -EOPNOTSUPP;
 	}
 
@@ -4463,8 +4463,8 @@ int mlx5_devlink_port_fn_ipsec_crypto_set(struct devlink_port *port, bool enable
 	vport_num = mlx5_esw_devlink_port_index_to_vport_num(port->index);
 	err = mlx5_esw_ipsec_vf_crypto_offload_supported(esw->dev, vport_num);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Device doesn't support IPsec crypto");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Device doesn't support IPsec crypto");
 		return err;
 	}
 
@@ -4473,7 +4473,7 @@ int mlx5_devlink_port_fn_ipsec_crypto_set(struct devlink_port *port, bool enable
 	mutex_lock(&esw->state_lock);
 	if (!vport->enabled) {
 		err = -EOPNOTSUPP;
-		NL_SET_ERR_MSG_MOD(extack, "Eswitch vport is disabled");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Eswitch vport is disabled");
 		goto unlock;
 	}
 
@@ -4487,7 +4487,7 @@ int mlx5_devlink_port_fn_ipsec_crypto_set(struct devlink_port *port, bool enable
 
 	err = mlx5_esw_ipsec_vf_crypto_offload_set(esw, vport, enable);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Failed to set IPsec crypto");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Failed to set IPsec crypto");
 		goto unlock;
 	}
 
@@ -4513,7 +4513,7 @@ int mlx5_devlink_port_fn_ipsec_packet_get(struct devlink_port *port, bool *is_en
 		return PTR_ERR(esw);
 
 	if (!mlx5_esw_ipsec_vf_offload_supported(esw->dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support IPsec packet");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Device doesn't support IPsec packet");
 		return -EOPNOTSUPP;
 	}
 
@@ -4547,8 +4547,8 @@ int mlx5_devlink_port_fn_ipsec_packet_set(struct devlink_port *port,
 	vport_num = mlx5_esw_devlink_port_index_to_vport_num(port->index);
 	err = mlx5_esw_ipsec_vf_packet_offload_supported(esw->dev, vport_num);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Device doesn't support IPsec packet mode");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Device doesn't support IPsec packet mode");
 		return err;
 	}
 
@@ -4556,7 +4556,7 @@ int mlx5_devlink_port_fn_ipsec_packet_set(struct devlink_port *port,
 	mutex_lock(&esw->state_lock);
 	if (!vport->enabled) {
 		err = -EOPNOTSUPP;
-		NL_SET_ERR_MSG_MOD(extack, "Eswitch vport is disabled");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Eswitch vport is disabled");
 		goto unlock;
 	}
 
@@ -4570,8 +4570,8 @@ int mlx5_devlink_port_fn_ipsec_packet_set(struct devlink_port *port,
 
 	err = mlx5_esw_ipsec_vf_packet_offload_set(esw, vport, enable);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Failed to set IPsec packet mode");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Failed to set IPsec packet mode");
 		goto unlock;
 	}
 
@@ -4601,14 +4601,14 @@ mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port, u32 *max_io_eqs,
 
 	esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
 	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Device doesn't support VHCA management");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Device doesn't support VHCA management");
 		return -EOPNOTSUPP;
 	}
 
 	if (!MLX5_CAP_GEN_2(esw->dev, max_num_eqs_24b)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Device doesn't support getting the max number of EQs");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Device doesn't support getting the max number of EQs");
 		return -EOPNOTSUPP;
 	}
 
@@ -4620,7 +4620,7 @@ mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port, u32 *max_io_eqs,
 	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_ctx,
 					    MLX5_CAP_GENERAL_2);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
 		goto out;
 	}
 
@@ -4651,19 +4651,19 @@ mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
 
 	esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
 	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Device doesn't support VHCA management");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Device doesn't support VHCA management");
 		return -EOPNOTSUPP;
 	}
 
 	if (!MLX5_CAP_GEN_2(esw->dev, max_num_eqs_24b)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Device doesn't support changing the max number of EQs");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Device doesn't support changing the max number of EQs");
 		return -EOPNOTSUPP;
 	}
 
 	if (check_add_overflow(max_io_eqs, MLX5_ESW_MAX_CTRL_EQS, &max_eqs)) {
-		NL_SET_ERR_MSG_MOD(extack, "Supplied value out of range");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Supplied value out of range");
 		return -EINVAL;
 	}
 
@@ -4675,7 +4675,7 @@ mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
 	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_ctx,
 					    MLX5_CAP_GENERAL_2);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
 		goto out;
 	}
 
@@ -4688,7 +4688,7 @@ mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
 	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_num,
 					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2);
 	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA caps");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA caps");
 	vport->max_eqs_set = true;
 out:
 	mutex_unlock(&esw->state_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 23a7e8e7adfa..cfaa9eeb5c6a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3705,28 +3705,28 @@ static int mlx5_fs_mode_validate(struct devlink *devlink, u32 id,
 		bool smfs_cap = mlx5_fs_dr_is_supported(dev);
 
 		if (!smfs_cap) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Software managed steering is not supported by current device");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Software managed steering is not supported by current device");
 			return -EOPNOTSUPP;
 		}
 	} else if (!strcmp(value, "hmfs")) {
 		bool hmfs_cap = mlx5_fs_hws_is_supported(dev);
 
 		if (!hmfs_cap) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Hardware steering is not supported by current device");
+			MLX5_NL_SET_ERR_MSG_MOD(extack,
+						"Hardware steering is not supported by current device");
 			return -EOPNOTSUPP;
 		}
 	} else {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Bad parameter: supported values are [\"dmfs\", \"smfs\", \"hmfs\"]");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"Bad parameter: supported values are [\"dmfs\", \"smfs\", \"hmfs\"]");
 		return -EINVAL;
 	}
 
 	eswitch_mode = mlx5_eswitch_mode(dev);
 	if (eswitch_mode == MLX5_ESWITCH_OFFLOADS) {
-		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "Moving to %s is not supported when eswitch offloads enabled.",
+		MLX5_NL_SET_ERR_MSG_FMT_MOD(extack,
+					    "Moving to %s is not supported when eswitch offloads enabled.",
 				       value);
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 5442a02c4097..12727ada6f86 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -149,21 +149,21 @@ static int mlx5_fw_reset_get_reset_state_err(struct mlx5_core_dev *dev,
 	switch (reset_state) {
 	case MLX5_MFRL_REG_RESET_STATE_IN_NEGOTIATION:
 	case MLX5_MFRL_REG_RESET_STATE_RESET_IN_PROGRESS:
-		NL_SET_ERR_MSG_MOD(extack, "Sync reset still in progress");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Sync reset still in progress");
 		return -EBUSY;
 	case MLX5_MFRL_REG_RESET_STATE_NEG_TIMEOUT:
-		NL_SET_ERR_MSG_MOD(extack, "Sync reset negotiation timeout");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Sync reset negotiation timeout");
 		return -ETIMEDOUT;
 	case MLX5_MFRL_REG_RESET_STATE_NACK:
-		NL_SET_ERR_MSG_MOD(extack, "One of the hosts disabled reset");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "One of the hosts disabled reset");
 		return -EPERM;
 	case MLX5_MFRL_REG_RESET_STATE_UNLOAD_TIMEOUT:
-		NL_SET_ERR_MSG_MOD(extack, "Sync reset unload timeout");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Sync reset unload timeout");
 		return -ETIMEDOUT;
 	}
 
 out:
-	NL_SET_ERR_MSG_MOD(extack, "Sync reset failed");
+	MLX5_NL_SET_ERR_MSG_MOD(extack, "Sync reset failed");
 	return -EIO;
 }
 
@@ -191,7 +191,7 @@ int mlx5_fw_reset_set_reset_sync(struct mlx5_core_dev *dev, u8 reset_type_sel,
 		return rst_res ? rst_res : err;
 	}
 
-	NL_SET_ERR_MSG_MOD(extack, "Sync reset command failed");
+	MLX5_NL_SET_ERR_MSG_MOD(extack, "Sync reset command failed");
 	return mlx5_cmd_check(dev, err, in, out);
 }
 
@@ -210,7 +210,7 @@ int mlx5_fw_reset_verify_fw_complete(struct mlx5_core_dev *dev,
 		return 0;
 
 	mlx5_core_err(dev, "Sync reset did not complete, state=%d\n", rst_state);
-	NL_SET_ERR_MSG_MOD(extack, "Sync reset did not complete successfully");
+	MLX5_NL_SET_ERR_MSG_MOD(extack, "Sync reset did not complete successfully");
 	return rst_state;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index d058cbb4a00c..664158240afb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1212,11 +1212,11 @@ static int mlx5_handle_changeupper_event(struct mlx5_lag *ldev,
 		return changed;
 
 	if (!mlx5_lag_is_ready(ldev))
-		NL_SET_ERR_MSG_MOD(info->info.extack,
-				   "Can't activate LAG offload, PF is configured with more than 64 VFs");
+		MLX5_NL_SET_ERR_MSG_MOD(info->info.extack,
+					"Can't activate LAG offload, PF is configured with more than 64 VFs");
 	else if (!mode_supported)
-		NL_SET_ERR_MSG_MOD(info->info.extack,
-				   "Can't activate LAG offload, TX type isn't supported");
+		MLX5_NL_SET_ERR_MSG_MOD(info->info.extack,
+					"Can't activate LAG offload, TX type isn't supported");
 
 	return changed;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index aad52d3a90e6..98801269f1c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -205,7 +205,7 @@ int mlx5_lag_mpesw_do_mirred(struct mlx5_core_dev *mdev,
 	if (ldev->mode != MLX5_LAG_MODE_MPESW)
 		return 0;
 
-	NL_SET_ERR_MSG_MOD(extack, "can't forward to bond in mpesw mode");
+	MLX5_NL_SET_ERR_MSG_MOD(extack, "can't forward to bond in mpesw mode");
 	return -EOPNOTSUPP;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 2e02bdea8361..80256db6b5f9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -98,6 +98,20 @@ do {								\
 			     __func__, __LINE__, current->pid,	\
 			     ##__VA_ARGS__)
 
+#define MLX5_NL_SET_ERR_MSG_MOD(extack, msg) do {		\
+	if (extack)						\
+		NL_SET_ERR_MSG_MOD(extack, msg);		\
+	else							\
+		pr_err(KBUILD_MODNAME ": %s\n", msg);		\
+} while (0)
+
+#define MLX5_NL_SET_ERR_MSG_FMT_MOD(extack, fmt, ...) do {		\
+	if (extack)							\
+		NL_SET_ERR_MSG_FMT_MOD(extack, fmt, ##__VA_ARGS__);	\
+	else								\
+		pr_err(KBUILD_MODNAME ": " fmt "\n", ##__VA_ARGS__);	\
+} while (0)
+
 #define ACCESS_KEY_LEN  32
 #define FT_ID_FT_TYPE_OFFSET 24
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 0864ba625c07..97ad445a6fdd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -63,7 +63,7 @@ mlx5_sf_alloc(struct mlx5_sf_table *table, struct mlx5_eswitch *esw,
 	int err;
 
 	if (!mlx5_esw_offloads_controller_valid(esw, controller)) {
-		NL_SET_ERR_MSG_MOD(extack, "Invalid controller number");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Invalid controller number");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -98,7 +98,7 @@ mlx5_sf_alloc(struct mlx5_sf_table *table, struct mlx5_eswitch *esw,
 	mlx5_sf_hw_table_sf_free(table->dev, controller, id_err);
 id_err:
 	if (err == -EEXIST)
-		NL_SET_ERR_MSG_MOD(extack, "SF already exist. Choose different sfnum");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "SF already exist. Choose different sfnum");
 	return ERR_PTR(err);
 }
 
@@ -167,7 +167,7 @@ static int mlx5_sf_activate(struct mlx5_core_dev *dev, struct mlx5_sf *sf,
 	if (mlx5_sf_is_active(sf))
 		return 0;
 	if (sf->hw_state != MLX5_VHCA_STATE_ALLOCATED) {
-		NL_SET_ERR_MSG_MOD(extack, "SF is inactivated but it is still attached");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "SF is inactivated but it is still attached");
 		return -EBUSY;
 	}
 
@@ -267,26 +267,25 @@ mlx5_sf_new_check_attr(struct mlx5_core_dev *dev, const struct devlink_port_new_
 		       struct netlink_ext_ack *extack)
 {
 	if (new_attr->flavour != DEVLINK_PORT_FLAVOUR_PCI_SF) {
-		NL_SET_ERR_MSG_MOD(extack, "Driver supports only SF port addition");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Driver supports only SF port addition");
 		return -EOPNOTSUPP;
 	}
 	if (new_attr->port_index_valid) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Driver does not support user defined port index assignment");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Driver does not support user defined port index assignment");
 		return -EOPNOTSUPP;
 	}
 	if (!new_attr->sfnum_valid) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "User must provide unique sfnum. Driver does not support auto assignment");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"User must provide unique sfnum. Driver does not support auto assignment");
 		return -EOPNOTSUPP;
 	}
 	if (new_attr->controller_valid && new_attr->controller &&
 	    !mlx5_core_is_ecpf_esw_manager(dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "External controller is unsupported");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "External controller is unsupported");
 		return -EOPNOTSUPP;
 	}
 	if (new_attr->pfnum != PCI_FUNC(dev->pdev->devfn)) {
-		NL_SET_ERR_MSG_MOD(extack, "Invalid pfnum supplied");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "Invalid pfnum supplied");
 		return -EOPNOTSUPP;
 	}
 	return 0;
@@ -312,13 +311,13 @@ int mlx5_devlink_sf_port_new(struct devlink *devlink,
 		return err;
 
 	if (!mlx5_sf_table_supported(dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "SF ports are not supported.");
+		MLX5_NL_SET_ERR_MSG_MOD(extack, "SF ports are not supported.");
 		return -EOPNOTSUPP;
 	}
 
 	if (!is_mdev_switchdev_mode(dev)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "SF ports are only supported in eswitch switchdev mode.");
+		MLX5_NL_SET_ERR_MSG_MOD(extack,
+					"SF ports are only supported in eswitch switchdev mode.");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.31.1


