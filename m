Return-Path: <linux-rdma+bounces-14722-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A43C82A63
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABF6B4E3641
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E9E2BDC0E;
	Mon, 24 Nov 2025 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="urPYirfe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A7231836;
	Mon, 24 Nov 2025 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023334; cv=fail; b=CQ6lGJSSllcpAo7U7mmieRigy9OuqTlcpPSse616mkhzwNvk7/LEZDQnEP37vclXBFc10x3Q1qIG0fTT3iJpFN7z1Xh51CvYJp/NkhQDMsuJH9ovzGPzf7/lbaPGXzpgSKmmFSmKNQ9YgdS8/W9K1RmvR+lcNyF+0HYZtH3WIXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023334; c=relaxed/simple;
	bh=F3uG/1zTPOOsio6BkVbwlNTYQRifhW8NL6QwwvufWmA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nk2c80g785Gd8qWaSaFzDOer5StL3BqoMQDWzIFIqjjcTuMYIOs5B/ufITIFjE5ZEkZPZds23/0sp1UMGxaXOfYTZO3b3caQMwRSxgjXtTV8xw/ywDbMj/NLTw6e7V1PTTm6hR6CSSVlueAUe8S6Kbw8MkrKg/JYWjueByu8TNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=urPYirfe; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jua1oUL8MTEh1In2k16jjLLn7+vq4Dmv22+06VyCKeQnyjbFwCFbXehPFiIHfgXx7wu93E/fn8nIFDwikOq8KEC0K8j8CAxXIuOS5MZLrzhd5R4j14vnbYVKneZjlX0vfVYiG11CuVP/9Run68eOo2vCbZDnC405dwbYbhN4IKoBW9p6oSH8Vptm5rw/C6ghXHV5p364a0okiwlU7fG6Svn+q6+Sg/fVmnXFMcinn4AkCRnkC8MUxYIWoFG1eyLAjnxrpSyc8JsXOV6j8amFiRr5IV+Lb207VXGqGg/0kLDP/8xSLl7a/cBGbHQHHPeWxA+0Fbm1vcA6vSutXXBccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9Y9P6rtH6A4jNojz5G2dXgBTyagRJpfVvxvn9h3Myk=;
 b=bVxRn8Xehu9+ZDsQrWLGA7VCkN4i2IXFOe3MBgE3TvWmJqEEHwNmjRUAmy+38gAglCHCAK9zTFoUs3eXPdOaOQm0A0wdvREuxhwF9l/U5+ehOdqScqF2dgfRSa1d7ylDNr9KXdyiMsKHF/8LKiUIJwFshmKFZ0R6lp3ElN+Trq6tF7Ws3yS/ErT53JO+QmbR7X9jiJ6LJZb9cnuC446JSPd/0UmVA6RctOhEWH+KDlBXIgsk+avvazbdGMyHM5POSXAfNrITlXkTyZaJ6WHczd7WPGvThkElk+hwGbXdcOfUrOXCFfMyHJRTnx7vPgjHswvLnCVxin3CdtyRbQddOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9Y9P6rtH6A4jNojz5G2dXgBTyagRJpfVvxvn9h3Myk=;
 b=urPYirfezl0y32RcKWhvf1oSbfxJSz7aH2UnGFEmrqo2QRpE6kemWP3aPWtCEyT/6hMqaiOz35v1jGeUcyXnv6oRPrXwzcS4eitxKCIAkQe8mZf5Y51vMmA0hOir7YwILiowkyHKjwJH0WkFzZAh+8TrFz5HphDJhPZGeXvWKkXMxIapZo8No9mSz+Wb+3BRYmYVlbosb/jAEgKfUbFzvDIPMfkrpTcVFFhoIGOusrM8EezC8SVJ3iW10MCVo8fs1rTDS8rDSWyWxVm0qx/cQ30IRs7NPcDR1OigmlRkti1LS3n9PdmSgJuBV8TLunEdgQYzzk6rSZc4OPpmYjLN5Q==
Received: from DM6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:5:1f4::16)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:28:47 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::25) by DM6PR02CA0075.outlook.office365.com
 (2603:10b6:5:1f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:28:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:28:38 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:28:37 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:28:32 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V3 00/14] devlink and mlx5: Support cross-function rate scheduling
Date: Tue, 25 Nov 2025 00:27:25 +0200
Message-ID: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 42529291-42ac-4702-07c3-08de2ba8d589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|30052699003|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mCGOufzYjx6hAj36/ammScIZ9mKE0/NVQpjLokWHd1He7l0woFrUZVJsxcJe?=
 =?us-ascii?Q?btmI4SID4F9LtirFU6HmdwD7wRfbAdVhaf7oZC5NSEFnQoFKiHVeErH4yp3a?=
 =?us-ascii?Q?ZbtV1z782v3Jtjhx5HCF4OHFkE3oD8whgbkoTNg4FJsxZgvGLOL1XjsA0GRV?=
 =?us-ascii?Q?7adRlPhoPKHGREyhhW+Lmrd+iPmgCQvvES7vkyqz0p34bHS3907JJTUp2dyO?=
 =?us-ascii?Q?2UBr/6WhwPMUt1Pv+azH421wZVY2F9UinErRrBrbH0hvfqtLmbGxU2wv1G94?=
 =?us-ascii?Q?EQ6/DssilvCsYjqe/3JrGI/PH/YNiQfJgeJTzIOPtYx6ii3JgOcS/HEhM4My?=
 =?us-ascii?Q?83bZkNrKQF6sh8+GR0ZRuETthUanlSe35B+EzCmdNjn6pgR0y1FVWQvDF7f3?=
 =?us-ascii?Q?94HS6PBV6QYSGdujt9j51UVhTaRLvoPJl/QYs7cu8oradsvMLd+8Swm0Ycsy?=
 =?us-ascii?Q?ZL2hDFgeso+yiwIcYrxDH12aYqBhkWW8u50OtY52DIts2DsAx4nyQeo6Cv7G?=
 =?us-ascii?Q?8LGOipdm5MMy/IWfShDGPL7ihJjMWkzFxzC2OFsFrm42fFvFOS17V4syNkSt?=
 =?us-ascii?Q?ZdqS/9KizNH72aG5donValjADU5+Bee4zmy6tS2ooEOm8+UXOZ/xpbn5tQD2?=
 =?us-ascii?Q?U5XcsNb6kjEg/MBz1OwKCio6qqcsMFMaA/+u35wbHOpltCIlHZw7S960zFzX?=
 =?us-ascii?Q?IGlz3gIXxIWWroi2kgOTw83ljlwAdVjGVJZg45TXeH5dyYG9TTs/UsgHJ+Dv?=
 =?us-ascii?Q?0mee60RlDKrRwYSkgHp3ciAsrXymonXz/hsMoNmb3xc3JPjjFYfEfcsHtrcW?=
 =?us-ascii?Q?nIN/UJwNEQCoQmZ4/ZS7I+kP3Tcy9Mzh3gl1CpH8bKH3svH2Yw0p9A1l2G47?=
 =?us-ascii?Q?cagfqTNyMEEFWDeRMSBzTCl2bnVlbH3OlLqzcGJK7U1xXGB56byCyR3aO+7t?=
 =?us-ascii?Q?NRPsOZ8k0AUBC5N/N4skSgbXQJqDovrSaDp98g3aOhuVcy0UGEN6I9d78ny1?=
 =?us-ascii?Q?jrZRg72Vi3YykvqPWNSY97KiRDgBRnXJukAXQUWVUU11ZcHg9Njca/BiR9gx?=
 =?us-ascii?Q?hAQxA+xEefCq668Nf7qFCfAIwREm2aBTcrOEen0uBuEIxaouXUHPAQ8OCHeX?=
 =?us-ascii?Q?ELCB/LINMl2oFkQwcPj7x2CQDo+uml51hTNEnJ7qSQ+sIoLTCp2yzBmo9EUk?=
 =?us-ascii?Q?fYboGk2lqzWMaIrQbWclg4DLmi62cIDcN2/AU6kmwTYsYlg8n3MZiZVc0pNj?=
 =?us-ascii?Q?3bXIIiIGyYAeW2wkm270Vhpu8tecAuhy9/fARP1CJwGCDe/BUhJDYlxGqk0c?=
 =?us-ascii?Q?SJc929/C8BYHq6QpFA7lgjMdJQjuyC9/LPW42H/LXUD0k3i34e38Do4Jx0Et?=
 =?us-ascii?Q?L9C8RjmBYbJUV/tGXYy7nmfeWyaJ3XevHTi5DcvOGiGpY9wryD/aXAq4e7pv?=
 =?us-ascii?Q?G5d5zC90vM0N8LKBvgwKvdBgJEoQb1oKK0ScEfGIhkVstP7FRDK7Xb8JeaKW?=
 =?us-ascii?Q?CqmGrF6DLIS4Sh7o8P911Uz0o6iUDk3AztbzLCQZ6vlhz09sf09ZkaswPnW/?=
 =?us-ascii?Q?7nqqFLgEguBJizIX8vE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(30052699003)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:28:46.8928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42529291-42ac-4702-07c3-08de2ba8d589
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849

Hi,

This series by Cosmin and Jiri adds support for cross-function rate
scheduling in devlink and mlx5.
This is a different approach for the series discussed in [2] earlier
this year. See detailed feature description by Cosmin below [1].

Regards,
Tariq


[1]
devlink objects support rate management for TX scheduling, which
involves maintaining a tree of rate nodes that corresponds to TX
schedulers in hardware. 'man devlink-rate' has the full details.

The tree of rate nodes is maintained per devlink object, protected by
the devlink lock.

There exists hardware capable of instantiating TX scheduling trees
spanning multiple functions of the same physical device (and thus
devlink objects) and therefore the current API and locking scheme is
insufficient.

This patch series changes the devlink rate implementation and API to
allow supporting such hardware and managing TX scheduling trees across
multiple functions of a physical device.

Modeling this requires having devlink rate nodes with parents in other
devlink objects. A naive approach that relies on the current
one-lock-per-devlink model is impossible, as it would require in some
cases acquiring multiple devlink locks in the correct order.

The solution proposed in this patch series consists of two parts:

1. Modeling the underlying physical NIC as a shared devlink object on
   the faux bus and nesting all its PF devlink instances in it.

2. Changing the devlink rate implementation to store rates in this
   shared devlink object, if it exists, and use its lock to protect
   against concurrent changes of the scheduling tree.

With these in place, cross-esw scheduling support is added to mlx5.  The
neat part about this approach is that it works for SFs as well, which
are already nested in their parent PF instances.

An initial version of this patch series was sent a long time ago [2],
using a different approach of storing rates in a shared rate domain with
special locking rules. This new approach uses standard devlink instances
and nesting.

Patches:

devlink rate changes for cross-device TX scheduling:
devlink: Reverse locking order for nested instances
documentation: networking: add shared devlink documentation
devlink: Add helpers to lock nested-in instances
devlink: Refactor devlink_rate_nodes_check
devlink: Decouple rate storage from associated devlink object
devlink: Add parent dev to devlink API
devlink: Allow parent dev for rate-set and rate-new
devlink: Allow rate node parents from other devlinks

mlx5 support for cross-devuce TX scheduling:
net/mlx5: Introduce shared devlink instance for PFs on same chip
net/mlx5: Expose a function to clear a vport's parent
net/mlx5: Store QoS sched nodes in the sh_devlink
net/mlx5: qos: Support cross-esw tx scheduling
net/mlx5: qos: Enable cross-device scheduling
net/mlx5: Document devlink rates and cross-esw scheduling

[2] https://lore.kernel.org/netdev/20250213180134.323929-1-tariqt@nvidia.com/

V3:
- Remove mistakenly repeated devlink interface in docs (Jakub).
- Add Jiri's review tags on ML.

V2:
- Rebase.
- Add Jiri's review tags on ML.


Cosmin Ratiu (12):
  devlink: Reverse locking order for nested instances
  devlink: Add helpers to lock nested-in instances
  devlink: Refactor devlink_rate_nodes_check
  devlink: Decouple rate storage from associated devlink object
  devlink: Add parent dev to devlink API
  devlink: Allow parent dev for rate-set and rate-new
  devlink: Allow rate node parents from other devlinks
  net/mlx5: Expose a function to clear a vport's parent
  net/mlx5: Store QoS sched nodes in the sh_devlink
  net/mlx5: qos: Support cross-device tx scheduling
  net/mlx5: qos: Enable cross-device scheduling
  net/mlx5: Document devlink rates

Jiri Pirko (2):
  documentation: networking: add shared devlink documentation
  net/mlx5: Introduce shared devlink instance for PFs on same chip

 Documentation/netlink/specs/devlink.yaml      |  21 +-
 .../networking/devlink/devlink-port.rst       |   2 +
 .../networking/devlink/devlink-shared.rst     |  66 ++++
 Documentation/networking/devlink/index.rst    |   1 +
 Documentation/networking/devlink/mlx5.rst     |  33 ++
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
 .../mellanox/mlx5/core/esw/devlink_port.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 324 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   9 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  14 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  18 +
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 183 ++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  16 +
 include/linux/mlx5/driver.h                   |   5 +
 include/net/devlink.h                         |   7 +
 include/uapi/linux/devlink.h                  |   2 +
 net/devlink/core.c                            |  48 ++-
 net/devlink/dev.c                             |   7 +-
 net/devlink/devl_internal.h                   |  11 +-
 net/devlink/netlink.c                         |  67 +++-
 net/devlink/netlink_gen.c                     |  23 +-
 net/devlink/netlink_gen.h                     |   8 +
 net/devlink/rate.c                            | 287 ++++++++++++----
 25 files changed, 870 insertions(+), 293 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h


base-commit: e05021a829b834fecbd42b173e55382416571b2c
-- 
2.31.1


