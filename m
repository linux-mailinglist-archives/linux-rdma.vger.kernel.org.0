Return-Path: <linux-rdma+bounces-14685-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E218FC7DCD2
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FACC4E22C6
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E502989B5;
	Sun, 23 Nov 2025 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jQlLvs2K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAB8296BA2;
	Sun, 23 Nov 2025 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882605; cv=fail; b=Q9QLlwZTyZfivq9y7TZMfw0V2QM5ItWNqaoY0K1jAhBsard5BnOISPe7B4OnyXTU06aXAU/v9nFP7kmUxD/6y3/ac+dt3z9RIZkn0UVTucqi58/u7t4LaGvpoBVHyySiAGilTDeRVdUJDGdtxx48eGUEeDKm+5ElZ0pBxCP+4Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882605; c=relaxed/simple;
	bh=8TS14ZdratUmJLG31LKz6E6sGu557JwMlG8X7sj5Uow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dAnoEYzSuO7BudwihmjNw+M+4L4GTiuPrOwolC00QXAg6VkE4zRrNDshUXYeWmMx/60c+ud25ecGbbJMxgfSbhK01tKxeFh1XjgIQdYrCiRvWd7Ixv8ZFPl3Dt2IvzoOvGGSYjRZpYTFdhBaiOSpgkb5D1XhHyiXDrzxEukCRuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jQlLvs2K; arc=fail smtp.client-ip=52.101.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGYGRc8zpn/0ynHUJhFb+fuVK7UuqadQTKMIOc9qPkl4SVtIZi1+YCQnedl0dQYMo8O3yiBHDlp/QhRX7Kt9R9vKDAI62mF3Yi5NTtxE1lXOr7mXIdDWsFCdLGq1wNvZVrEQvo3Tgmvjzg2pNDw56KNstxfO7rzm1fVYhrES+3OFhHfaw9Igw4UhVxluP9PnxmZDm7RqL8JclGQw7mmf+rLgBXrQcjIktwg6RlkFN3uVlh3c4lZazsxbhJ+pIByEM8XEbPyeWxhZa4j37FdhbYsJ+SqMnJ0axoWxO76oJyxQz3CZGxROvoZe2v36P7c7++idyk5Cdc1N1isAycSUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rTwqryLz0lcMPwAJdSuQgouCXU5/KEHmubL51hmrC4=;
 b=TU3RB8/xxOL5C5HmsqsnXjwHKuEF0p7UzuV1oZ0WmWS0iIQIYLCPStqp3IJomKG8G71yW40rAa5+t+6jeau0qwpgCysMz+8FMK6BJnnSsitfmgAjQghhNQc8bn58GY030qK9PlqImwbDMnVj+7QfHygXK4MyvIEmzuvgYsOSLeeDAlSOvwrz1iqtXXhhWxQyGtLeGSAu/iU5Rr4ib3+DVfO+3h1aDmYC8ZeCwKGDUeyXfS89GAltAeU3jHV4sCHJZXUyDoM9EaUom9HmWYiXJihInKDHal7y+1Nl8jag7uIIloYWcuswTygQ/feiKJ8ibn73H7hQ/MyzCAQ/5ex02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rTwqryLz0lcMPwAJdSuQgouCXU5/KEHmubL51hmrC4=;
 b=jQlLvs2KKHJShmUegj2Ve187Bv0usXorZCuzcPMjR+QCdXK+9/wV2S2GOWaVQo/fclQS7/BL3AGKO5crMmq09pqK7xq4MQAqZYDuWolvhdBYFtQk2sRmKHQcaIkqB7ZTMUwSbwfdjaSBAA7szWmnP6EZ/t5A+GN3H6o0E1/NJ7csyyn8XPui4dKt7aQDaB/cWc11Ght2a9upmtFYNqNrRG/r+NU6rY8RlqKupUszJLdW/k4JcIp+aAgMV8dGgK1QZt9TS95eWFDkUfD9yzfusOfHDX4GFj0/XSN+j+LGdEHt4B8GdpuCnsQj2/ZNbTVcRkWepqw06KrliXcj1B98Zg==
Received: from SA0PR11CA0061.namprd11.prod.outlook.com (2603:10b6:806:d2::6)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 07:23:20 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::f7) by SA0PR11CA0061.outlook.office365.com
 (2603:10b6:806:d2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.16 via Frontend Transport; Sun,
 23 Nov 2025 07:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:23:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:11 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:11 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:23:05 -0800
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
Subject: [PATCH net-next V2 00/14] devlink and mlx5: Support cross-function rate scheduling
Date: Sun, 23 Nov 2025 09:22:46 +0200
Message-ID: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db0bc9f-6f43-4af6-3a79-08de2a612e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|30052699003|7416014|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KAt2YZsFQtuhWGIOor7Nv1l+9ng7tr+H5Wbiu2+Ly3k5rtJOaezkMt+yWqoO?=
 =?us-ascii?Q?FVPvAFA39qxklt7H6Kuz5ab1EFWdHoVl+i2ro1LozNoBXL5ioVr8r4PwX6y+?=
 =?us-ascii?Q?7SLeUCyCJqKuebE6Fw1nMjfGGqjZR3+63U+iRSpcZN/CdlOuu0zErJrXXyN0?=
 =?us-ascii?Q?1rHEm4ivPZDsl/kgQ9uefHmoC3KBYF8P93PZ6mnca4mYBZkYg7h9wgN9ZwAz?=
 =?us-ascii?Q?pOcY3S28pLJ68RkM9066vFz5sXUIv24KhqJKDNvn8eV6MgNNXJfT/VXBe37v?=
 =?us-ascii?Q?LEoi4cfa8ayPLgG76XFojTtDNXea0AAgMjYmlX65Mx8nXs4yCOeynHox6vNb?=
 =?us-ascii?Q?MFahSlThHsBDiMs/QyNb3EF6npJ4feGt14YFVyVyIsbovHdZrGZe6y/fiRhu?=
 =?us-ascii?Q?iHJo55PdGDCQE0heghAQVmJD5CVzQtxGlLIzOOXrsqjg4jg/nUM53xsLKuDH?=
 =?us-ascii?Q?MlnhnPZuhxArQvuvbjMm25SVL1j6z0z2PQkMbOCrUOHZ3N32AdLBcYWsOLhO?=
 =?us-ascii?Q?U+ABFafl/kpwpRXcP52m07+nZEi0oWC8HoEcVBfpQwZcq+lTN8FYKU/pfsER?=
 =?us-ascii?Q?hpRFluyXkxMhZLRIy4PnqKBdyssVUYjCy5HpkDfyd7/wTOmV5F7aQIlJy5KW?=
 =?us-ascii?Q?+eJ+oASyLdEfoz3t0WTPUW0qYg4+zUtkw0j2+q0MdPf+AvRxfWK/k7ceHEGK?=
 =?us-ascii?Q?upRK3sHmX8WYn1faL/BH+jFk8MkC8CbOK3om/3kYG3iUrPT9SjfNXbetIVGj?=
 =?us-ascii?Q?9Teur5vS4FsO/4XfP4eppRkeUQxpAOIQTv1SFEw6kkSCM7NRVr7AXsPiK7Yi?=
 =?us-ascii?Q?MO3I+qrIDKjKWrs459TwnMGUe41ZB7G2AmQWZ2GFpeQlUloSt+Nv5szATgYF?=
 =?us-ascii?Q?SBBzIXudkNuVlM2xN6dtWzUoECeCwidLegWcd0eSUPlKvH54sTGv3cTFmIPL?=
 =?us-ascii?Q?uOMLKhxKlqEm7id1DSLsDp0zHTHBW7immfIyzRmb8MD7EjayOPWDwJDYGxmU?=
 =?us-ascii?Q?jFH4ncB/bu1Ju/avxFKdmfx+rcWXb9oMZxRMBr+GYkmsdsxXcD8+6i96mrs2?=
 =?us-ascii?Q?2Bd9v0V7EwVKN9Hs71bQE8L7CcsiIMCU8n1LDCaX+VJbGo0/HgzMRr3ACJY0?=
 =?us-ascii?Q?Lx82LPs3WHsk/GfNHxxIHGsspCNQexind9KLGCdUKArpwkOr4pO+c0Pd9xxp?=
 =?us-ascii?Q?KaaXTpqUBJLEoED727RG1fB8tCS2aK/fCFeSknQNGBQQYspZH76LCm8jvk44?=
 =?us-ascii?Q?PBqC9p7AY6vtV/VS8L0eTuqAaqqvWxnbyVL05Yg5Beem9CGfUc1e9EZlBiPZ?=
 =?us-ascii?Q?TgnPPYIOFNUCHUVfXGid9lLDSWXxEYVgfooopfyWk5e47kWAFlCr0toB2bNQ?=
 =?us-ascii?Q?O7gzyWlFaMoVEFUIVdEWC36lK/u0xaBW0cOMNcHIACXd23c8cWXDRkuZy75j?=
 =?us-ascii?Q?sDEgNw0/DaIz66f+2xWwRFZ/sA6NsXUdO/4u3hBvdiz4/13zPMh+dgjVJTUp?=
 =?us-ascii?Q?kLD0Cpv1zeZ+JywSfwdKLoPxiSIFQ5PyAGXXrIe3+RX14Z+q03RlNjSS8wgn?=
 =?us-ascii?Q?4B+11OzCMA5aHH1YNs8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(30052699003)(7416014)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:23:20.4176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db0bc9f-6f43-4af6-3a79-08de2a612e03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

Hi,

This series by Cosmin and Jiri adds support for cross-function rate
scheduling in devlink and mlx5.
This is a different approach for the series discussed in [2] earlier
this year. See detailed feature description by Cosmin below [1].

Code dependency:
This series should apply cleanly after the pulling of
'net-2025_11_19_05_03', specifically commit f94c1a114ac2 ("devlink:
rate: Unset parent pointer in devl_rate_nodes_destroy").

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

V1 of this patch series was sent a long time ago [2], using a different
approach of storing rates in a shared rate domain with special locking
rules. This new approach uses standard devlink instances and nesting.

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
 Documentation/networking/devlink/index.rst    |   3 +
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
 25 files changed, 872 insertions(+), 293 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h


base-commit: e05021a829b834fecbd42b173e55382416571b2c
-- 
2.31.1


