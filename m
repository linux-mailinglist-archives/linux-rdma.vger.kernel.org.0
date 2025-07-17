Return-Path: <linux-rdma+bounces-12257-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28720B08C75
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 14:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862561AA4C39
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 12:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D75D29E103;
	Thu, 17 Jul 2025 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NkxWfwMG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD329DB96;
	Thu, 17 Jul 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754004; cv=fail; b=lSwkVBsERmoO63WTXufJLCLKQAhRh1/7qVTCCWMgnHhm9XFdTlhLKpYJFxIrRX4NcEec0O6Ndp8PHcu4SK/iBw/mn3BDeqjXS4WzPjCbTBFtAbR4RwexoW/50v2QgeAqldEju6/FP+lQhtK4TVN22G5CNhTvNjSQ7sOVlMOHgmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754004; c=relaxed/simple;
	bh=jYd9S6RBIDpnmOau+xt9oLt3JZWbXWuDAxaovOxKujY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D3cN6HG9/toiIFhScHCpt69sFpZR67h9pempbZ09BsmlZmmXadJT5FJL+cwAqf6+3kFWzaPnXeCn1m4rg5A8qLW9WtCLypuy7bSyiDh8qTObgu9WbjijXbqk/BK+uLi6E0QGfwmcMeNV2pnXfMEieUwKtBdOnGoSMPmhNqRqtBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NkxWfwMG; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SU61lGw/lIVgzdtqjQOoxI6mp0b0uVkNa8LMPMgcAgtZSudqYb3OR7MXpCi0uXDycQmzE5ZLTCWQSS8t/s4NLs+3OckXgba1e517DBqJFgseuwubsoU0tjdlbvcpq6ykNrrBjVCQ1dvKC+nfpdP/+YA+Jww9TDua1TN9kSwgNCn1Tl9dmXqW0tN1B16GCf1ao2wT5gzJkF0MF/5RmRlfukdAnH/9BJgBHXqzs57UgPFVxxW4ctyzcP4I18sUm4Vj7aZt/Xj/DC7l5nvuD/A4uORPoOOlKO30w2N36JczRrbc9YGW9a9XbZJAYVyjS9YykWNXq8Uixjy+Drp3E/FxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5p0AIYNXurjgpkp5cki1aGuHxKmaUHqTj4uy81XpkSA=;
 b=CyEv0PV/Oix+nEeLvX1PLOGGGCPTVrk691FvkuTmT+wpwz6m8Jn2FSCcBfCK1qvfvRJGXp7aUBZvtkYE8tY+URHs/vgDDyykf65baKAaDjMH4ddfLw6Vo3Ts/lGvnDq9NtqY4XMkwEUTbFEyQG4tM3V3HyyI+m4Oe1TSKkamKYVBkVSV7MW4qNPP7aeXzKOkXCUBEKVxN+S3KrHmGhobDcP7kvLVEEzbOivUWF+YYl0M1PxjFgUr29XhvEpqlG9DpEgpWr3itGv2B3/x/wUFSjxhefz1IIO8jZZ58BkU0aafLT7R/j6FRpfJVFvw0P9oVtYBs59C15VzTh5iBxIDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p0AIYNXurjgpkp5cki1aGuHxKmaUHqTj4uy81XpkSA=;
 b=NkxWfwMGT8NR2T4Xi6+xmTLBuWCBfFjoa7pT58wAWXKFRXp0dDlVOUj6sqo447pqd8VIsc+64zZhI8GnFTxviIWh74AEA/AbZIG1VdLlaU9vHL3mS/gVZoA+M0Lw0F2pbzgQNIroNqODs203uaUxrHcR2HSkC9wNuvm4rAQpR8XtVtO4XAucYxjQRI/n+F66vMqatshFY89JtkxoLpy1QxqCgVxXj+EaTuKzwNlXLgcBFWJa2m79L7CvMutLWc5Kq2JG7B/P8r0sep6k3OpuG5btW9yjG7FfMNtkJs6fRlPS96sWpsuFGae1RjFg/gf5K9r97uM3xH91zEqUUNu3Wg==
Received: from BL1PR13CA0186.namprd13.prod.outlook.com (2603:10b6:208:2be::11)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 12:06:39 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:2be:cafe::78) by BL1PR13CA0186.outlook.office365.com
 (2603:10b6:208:2be::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.12 via Frontend Transport; Thu,
 17 Jul 2025 12:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Thu, 17 Jul 2025 12:06:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 05:06:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Jul 2025 05:06:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 17 Jul 2025 05:06:24 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/2] mlx5 misc fixes 2025-07-17
Date: Thu, 17 Jul 2025 15:06:08 +0300
Message-ID: <1752753970-261832-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e53eb90-4dcc-4f1d-0a19-08ddc52a62c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?alYeXxxN51zGC0oW2OxmyytSwuyNLpRaHP48aN6it4dznGwSne3s8+7yyhFd?=
 =?us-ascii?Q?FD0yS5hGbiYbGYjH4Kl8FbhBZMvkcruQUYyt7NwVxqAsHiqjHR0nMOZWONy1?=
 =?us-ascii?Q?G525WfP7musXRo5Z3dob7NVq6mq8L4gK25xdkS60At9Rt2/S/2bIaxooYefH?=
 =?us-ascii?Q?GoFSCjk7f9AhMCqzV8oNXGit+yGL5l2Pe0nakJj+yeDkuRVB1mVUvKDzv1v+?=
 =?us-ascii?Q?ehfuyhe/MNZ+hBvyPwVu/jptNnErRFvW5lNH++xRHeLyVusaS9Mzv3adKz50?=
 =?us-ascii?Q?QCoKmcU+oDrfig/MV5bTygnoj4f+TFds2n/RBwDox1z2veYOTt/amNkBpSOV?=
 =?us-ascii?Q?/+0Y8j30NLGQcs1QwICBJRGkf35uWOE97mfa1mydBD8VFz5bUJc7pAGmGheE?=
 =?us-ascii?Q?Pn55r/XqjUugQ17+72RI0PM7LIRSylJGxWF9btrCNb8IoyTOxWCwzIj3uUyG?=
 =?us-ascii?Q?jmHt3mv/5jPXD2dLLd/1GfPriYCWOPhxfG1oYO4Y+Hgksg2m1GD5gHL3/i1i?=
 =?us-ascii?Q?P7yVsdJ5OTLD9CV0EDP/TBPKTAStXvkICQCNwacvfejtl6aU1T4dThvwQCmt?=
 =?us-ascii?Q?u4NvvLB+gqAoMApnCgfoHNKFFi3JfOhx74D5F4IW+RGxKS4pY/LrWF5Mbdfb?=
 =?us-ascii?Q?g/vf7NYG6x1n7OjRKDPPhdMb61ZFlO6dlaaOCsI9i78LCK33R3gSnCsswPG6?=
 =?us-ascii?Q?BNz6ItyCtprgFxvM6musRvkLiAVMN6wsRjcRxhBRweiPjmhIjOgWzfESZuxv?=
 =?us-ascii?Q?4P9NYhUUMc6CcNfvmfZc35l8YtTj+pmeiXnctXAHYtotEOrKuvDjim610Meh?=
 =?us-ascii?Q?Hr9dFk3Kpj64ErBpe4RcHxsTUsDxnheTK3djRmGKXE3cNWBJqtwJb4uZon4j?=
 =?us-ascii?Q?YwuAxrJOKRGpIYq5f7PFpjFXVy9P44C2jAApd+9tNRBMqUdRRwNI4/3zP+4D?=
 =?us-ascii?Q?EHKmiect6N8TTHDSjizVDFlqhhEnGQF+mrBMfvKlX/XibG3xVssljXgENolN?=
 =?us-ascii?Q?hp14bEpePJhPTbcelugpnVpR93OO9KXPwhKL3oqJdjCZlBW4pXXTbvp7aBET?=
 =?us-ascii?Q?EzbtHlzVNxcCRvsVofEltnu/I9KrLmatzrm72SbyCAeiNPqI6iOnT2NVx10s?=
 =?us-ascii?Q?xworjfZjG643Yuk1vzm+43kwGDe++wiHYoEFtoqw4lTVnblEUbsT633VmvRQ?=
 =?us-ascii?Q?Z6bNFy6CqlC6cFvjK8VcwnLZhNbf07KmZHtpDhRxRpSn459SISxCBUxLPpok?=
 =?us-ascii?Q?JdfFwP2rSVNmnNkFAEITZ/vCwEzYC83sjDymS1oaaTGahewT/kwt8TgxGyBO?=
 =?us-ascii?Q?vwBdnYI5I+zHLve47tATiPioTKGf7yUCjULnYQiqNuzB69vjFyY2CFgMnIQI?=
 =?us-ascii?Q?LO/prU5Ap3LIOyaiFlJ1/N8ulYAyA100oYaV3zf25DpEbt39sb8L3O0dF+8L?=
 =?us-ascii?Q?naikV38TKMJr359Z+18PDL4m8u2yj0iO61VFYcKaidFQB7AIdXijzppsjmNy?=
 =?us-ascii?Q?vwwRJyuqkQ+P2b11A7CDp7xT2OHqQcHkjxgU?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:06:39.1790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e53eb90-4dcc-4f1d-0a19-08ddc52a62c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275

Hi,

This small patchset provides misc bug fixes from the team to the mlx5
driver.

Thanks,
Tariq.

Chiara Meiohas (1):
  net/mlx5: Fix memory leak in cmd_exec()

Shahar Shitrit (1):
  net/mlx5: E-Switch, Fix peer miss rules to use peer eswitch

 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |   4 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 108 +++++++++---------
 2 files changed, 56 insertions(+), 56 deletions(-)


base-commit: ae3264a25a4635531264728859dbe9c659fad554
-- 
2.31.1


