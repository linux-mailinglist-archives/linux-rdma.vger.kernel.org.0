Return-Path: <linux-rdma+bounces-13528-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF22CB8D7C3
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 10:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AD048206C
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF39323E23C;
	Sun, 21 Sep 2025 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dwwLw50F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8B38F5B;
	Sun, 21 Sep 2025 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758443973; cv=fail; b=MKdVMz1fTLTBQZ9vtKOMIHWoFNWFSq2xQpdc8AN4x2cFotEokJ+gs0KTcY54mSW3Sb7fvIZClNSk+LTOrb7IHKilfWJj+MGvKaEEvhWs37N4YQZFzcM00pjQpFOnjVupoRGzzTOD2733KoLOpI0pOi+y9wVcWrz7jUpoDubXQJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758443973; c=relaxed/simple;
	bh=m2QgHPjGn/etGo1IYOj2WUUor+0X7FoZU+2rNf4L6PA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C6pxDK4irwyl/piKJJtj6aRGFxsc+hM9embtwpmAxaXgPxT4wrt7d3W94lEsrO03Qs0UOwzVeCLY2VOABm7EKC8ujWpj0NA+LQuh720WKF2IiZnhXxmsaA7V3NeOuQ+9AbQixvi/BkaKgUDK3JCcJrJ4Tj/ounIf6YX6IaOpNqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dwwLw50F; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5TEl4EvU1aO2Vx/FRkQ+4XvnuA+J/YR1/ARoZpYf0AT5qBmWIfX34JhRKZ/0qZHAm/L3JlRAUJCKh0RZgLHyWL06UUQ1NUMuGHtOdxK+mncRJXmMLjl5+627RndqLvuJO6kckQFsqb1wa9WbzUDd97HG80DuvDkULi+VfGbp0F7yKxdz6WoHWIogW+l8yblAZabzyNy0SGe41nZCqrrgCozlfsV8qgP46iIpCFRYf78JhN04dMPg+LbOHjlLmvC0U3hTTJiJJ3qanGmPhwWntywqkbZqTSx04L48dcsglCx3XB4uOsXH/OgI0qcZa4UVpz4Bzodkp2Ns4U7c9bpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pwkbjjZs0ZiqX6OODHeuVfNUhdxaUKmm+wykJh1sRI=;
 b=fJ3gMiXMtC2rwv9mYvNBwZgqNz0n8nkJNWX+gRn1jwGc4VblItpvZapaX8koVCTB+aieZ6CEmS/ugBeAkCiOGBGyL3M0gdwkgtW+/XnfyWBCET6ad7+pA/J8BhBSGDVXuRSpob3JE0GnXr2GASnObF7uFFaXHC6AbXAgDZF1kjhWxm5uQ3h5MPhUD5w+JzwjYC3vVaMBYq9/xD0t0jqh7xVUuv+xPyIVyR1L7nJ+xFKk9NaqOuXKOJOblcteWlGwCreA4JrM9tLz+nTS+HmKwK6TQ0T1SgKLMG1cmT+UJVo/Df7oONJ0jj24Vs7f/w1aC9XWvB7rqOx6YOXOGHJYgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pwkbjjZs0ZiqX6OODHeuVfNUhdxaUKmm+wykJh1sRI=;
 b=dwwLw50FupRpCdnxNKi3pDHb4DphmvuHRxODH5RC7JbP0sBMMmQ8cYnUxQUuLR6EOON+psWfr7ARunI2apavdmrW1Usxk1xefKrpj7Ro0K9Gtk6101FGEb5FhE6QR49QxF0yF1cno8+FKeZSWsi4mqIIVnkOdfO5Rt4ICmW/1Q7SHqzPouPeZsHDKGltTHxk5snMcYdKNrv2D78znjMCgy3DIzIeJsKOpzbiH9SAdpHNATmzjz1qFImhdPylCPCvkJNP3QME5x3IlX7FjtUuTeuVDsYh9VjFe9zVdbNFgL0PyWBESwng5fpyv4+dhds1PIqhVhx8NgV9xh9LA7ZQUg==
Received: from PH7P220CA0067.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::9)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Sun, 21 Sep
 2025 08:39:27 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::e7) by PH7P220CA0067.outlook.office365.com
 (2603:10b6:510:32c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Sun,
 21 Sep 2025 08:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Sun, 21 Sep 2025 08:39:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 21 Sep
 2025 01:39:17 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 21 Sep 2025 01:39:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 21 Sep 2025 01:39:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, "Akiva
 Goldberger" <agoldberger@nvidia.com>
Subject: [pull-request] mlx5-next updates 2025-09-21
Date: Sun, 21 Sep 2025 11:39:00 +0300
Message-ID: <1758443940-708689-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 642c9a10-e76a-44db-48cc-08ddf8ea5feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MK9sqCNXMoauF9pBGPaS0YzHm5uTSpsQH2Ct9tNbD7zyEstz0ro/6wxOjEu6?=
 =?us-ascii?Q?lkSkNbd4Bj6NJZkGGBFQYbVoN7oxitDwcCwpOGJujaCNZmspCRG/69+nDizR?=
 =?us-ascii?Q?rTwzqS1bLkTJRUnpq3FdQd3uCK3ZJXBIfwjKi1suHiBKrK1cMvNZTQ60Gzjk?=
 =?us-ascii?Q?rngpktNe+pJtRTOLup0v2H1MZOnlIOGxLtbxAo5HxBIHKyijupYeotbP/QBY?=
 =?us-ascii?Q?rLWq1z3SNxsIbo+w8gMTgAJ7uBwaBJBz1ekjdxV8Nqonq74NcQX+zcf+0V5D?=
 =?us-ascii?Q?B9k0zTS9/XH0aRbVI0MuI+8xP76YRbRHhbOSJUQp6mjw2+ausvs8Qdg63RDn?=
 =?us-ascii?Q?AVN22kKe+C2zJ2L4dOJNhcqaoFpEoVdX5R36qZhhv390k1CFfxDKyZxV0Qer?=
 =?us-ascii?Q?cRK3Ma97g//mmEQc8FulhfDzXZtSTjWiUwRKbYf+6Sgeup7tMKevhjtIMHBy?=
 =?us-ascii?Q?pQwSNhvepicEGXOtFPLkZEb5Xk0ucqSeOLdcslXvOJSCe8Bl2515QVDEZLj8?=
 =?us-ascii?Q?MToxRi8GaimUG4uXj8XULKdtrT05ZWly4uK7DkLKlX7N8Scp/Un1i9oUZK+d?=
 =?us-ascii?Q?24q2J++gAkKWrm76m07V3j+w9mBFnp7LFcKcpYQWBPUSPWjsl+GFTM3uhOTO?=
 =?us-ascii?Q?Wl1guTg5UbIDFnlyY/vyyI1oOPSad8T9k7FJ4lvu4E9VTx+7X+0yh7ABtLrN?=
 =?us-ascii?Q?/udj7w4zpbp8RnOROc06yNSMtsRaAGZzohf6OBsxuRCqA9bxcQ07PKeWZOia?=
 =?us-ascii?Q?aVbxr6JCciM+IZPEwWvgedS7fkHtu0tfrJuB8vohBbejZmexThM2wsA9o0GO?=
 =?us-ascii?Q?SfUvrrekUhP7ut353ksD2UfM0mCKvqQTkRBzxMPVUhRn+RJ+P9HyunkPN3ch?=
 =?us-ascii?Q?ZW7a5nYfLjqCs2KOO0d9KDdhODCC69pn2IU949BQgxrSTloSnW0D69dTCtXH?=
 =?us-ascii?Q?ojqYqx50UKKwpa0ITWHAD1fsnS7fSpu13TnXBHttY8W1eivv4YSk73S9RLLh?=
 =?us-ascii?Q?neykKd7YOnn5EVSgMH6wlrpNS7EFfUk3ay5xeST97aSSvPc7tJKHNtUy1saf?=
 =?us-ascii?Q?DE4RN/noilfYrJPl317gtNYU9XTcet5MOk9fpQ4n/89w3Jvj3KOBnRTtWjip?=
 =?us-ascii?Q?FMdXKoKtfVlZTsX3vf4MutRz4X8l4gYm1efUE7dJrdL4w9neXhJVCHu0fzpS?=
 =?us-ascii?Q?+RkACX0B2k5Pxx7cX3Ho8sdJmhBLGrdQ1wBvJO47A1dIccOzO6K9mQuOl1I7?=
 =?us-ascii?Q?Fzwl/89JCP7FSgk+wLw5/I85QkIedu9fKR4PGB5JPxCYlz9xbofjHg5czZp9?=
 =?us-ascii?Q?nLON8QNeDiNXtJ84VE/PvR0CCEYmNwZj3bH66o6d3a8YmzRxLiBoEjKMLnQy?=
 =?us-ascii?Q?oQi2kmR34WEGnELZw8d3PCqY4c/lbVvx80DRZZusGt2G8i3lMW2Zbf/DGmpM?=
 =?us-ascii?Q?eHiZXQ6+tc+XoO+Uxhc7U9lGU8QzGNoByDndkBOsAmPtIT5Lj2YmV84RQcql?=
 =?us-ascii?Q?GqESMdw1Oa7HL5Um2Nu+WaXqiijf+DSSibE2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2025 08:39:27.0702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 642c9a10-e76a-44db-48cc-08ddf8ea5feb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

Hi,

The following pull-request contains a common mlx5 update
patch for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------

The following changes since commit 2ac207381c37eebc49559634ce5642119784bc7c:

  net/mlx5e: Prevent WQE metadata conflicts between timestamping and offloads (2025-09-17 04:38:10 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git tags/mlx5-next-counters

for you to fetch changes up to a3d076b0567e729d5f21a95525c4d096b1f59e79:

  net/mlx5: Add uar access and odp page fault counters (2025-09-18 05:32:22 -0400)

----------------------------------------------------------------
Akiva Goldberger (1):
      net/mlx5: Add uar access and odp page fault counters

 include/linux/mlx5/mlx5_ifc.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

