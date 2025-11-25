Return-Path: <linux-rdma+bounces-14760-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC9C86EA3
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 21:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36F7E4E1A6C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 20:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C31333447;
	Tue, 25 Nov 2025 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ccq11nFN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E121927991E;
	Tue, 25 Nov 2025 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101228; cv=fail; b=butkWNMEH324uBO3IFeOK+ahCI3PUPQ3wD+H8Xa83HPKhAaT++QA0V+xFRO7stGjR9qT+4pS2JMf2GtBr8mUrCzWBmdNcNfMSdxkgT6pWp/uZgfN2VlgRFen96CkTV0841NX+vvnCPk1JtdqyZr8EedIiGKUpbvySMPiCKPfSSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101228; c=relaxed/simple;
	bh=zKMYPgp0v2JtnocC77gVsZ8puMhftAyV6+GtZdvByAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RBk/mE8L0XOE4sNTDm+zzErkvkG41VN9HdCBlzQ5ASwDV1WWIR/IZ2ctkjsHTr4dVI0Cn1f6JS+qkN4EUpydhbNwAByd+MhR03zbyO16YPbOHDJnUNntsztw0KhtPbvj2O/g5HxzNV/iHkFGqmQh4ADPiU/wj70xHzSaG4Mt17g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ccq11nFN; arc=fail smtp.client-ip=40.107.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rf5B2H8OFFNnnnYAiLzszrWhl9fvjkau0t7kRu/dJ+kNZlHL+hTyY47gODATt/VHlGQTqo3PC3sQGWIgK1w9G5ORO+BGmi/rTbaoBapED3rxLgd445QnDuBEfRb6Oof1NyVJonqyufXyxN5Gzvr0g3SMRIodDK8l+6mjw4afHxcpueM3JrZJ186CL+YZO1i3k0JLvTrRUDGJK/Ngp2/UmYMFhMLkb4ob/O3lqSrpHSx2kRmUHiUu6An5ZiWwxQWiLTAmxzPvD7DMVSpRHaIEgDaEX+tgC+B1ALq93U4hUJR2g96IjbkjozUT1oExjjmVX44X30SHeJ3BjEugP6uylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5o8DkoFOI+eehk5parE6GuTYQ5KxcJJklG6AmxblO8=;
 b=oqXtpawQXYJn2toQSb4FXfxXU3LSi2o5Qy4bRlzy18KedK1o+1GqG/ILWbXxJ1eZD/JQrzgHyipugWRk0jfNApQy09pA7uB3Ai5PUmU7+5ikLgixKT/NJ/k4XLvdrnnc8FkG2R5zDs6L5Y/8yQKVn5TSFpxwVvRJ5r46Jfzj+B1YfL31GrvI30GI3gKmmmZ6+G2YO9YXpAO6gyltlsPC2bbjn+nA3tqfuIN98ziE5dbJs31Mfk1027ME8dBcEgW8Kh0FnFcbJ7rTz2P+lH2gAC2hJqYIK5Ey76TsxfZhMSFpDWdMgp2PKJ4uieUr8kEzjUOOUlzFBH/HEU2RHBYYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5o8DkoFOI+eehk5parE6GuTYQ5KxcJJklG6AmxblO8=;
 b=ccq11nFNWfdiL+WI6Y7M7DAetskU2D3gFu/yDR9v6KMuKjGRjUditUTEDUBrm/fKfgv1iV/iKZT1PW/NL6J8aRDLJnRJ0Qe2Yx5B1hR1Ip4FBij/OZ5wlYn1i40culBhnYTsDMlLyIjejmYcQsgrYCd6nFnK/+uKgxc+3QAVFk+CUuIkXu44EaD+krOrYW8OMwASzN2KnOujDp5OGMaTJ2Gi1IsQyGgW9xJr+svAL/SOR8zuwXEEAGBgu9GK4aWM2tX9v1hrpdxwNe4Udt+zgIYhPqULbiuozca5bZJh8dMasFtoFZfbXYidzWYce9OZoyO0mGIc6867zKs6HaJ6JQ==
Received: from BY3PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:217::20)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 25 Nov
 2025 20:06:58 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::8b) by BY3PR04CA0015.outlook.office365.com
 (2603:10b6:a03:217::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 20:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 20:06:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:06:36 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:06:36 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 25
 Nov 2025 12:06:31 -0800
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
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>
Subject: [PATCH net-next V4 00/14] devlink and mlx5: Support cross-function rate scheduling
Date: Tue, 25 Nov 2025 22:05:59 +0200
Message-ID: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e51e67-c782-406e-033e-08de2c5e3099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|30052699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cIqu14WIfSWQMKYbMHIrYVEKFvQrda6eOYvQdxGfUUoXgqVT+7MwowzbcIdz?=
 =?us-ascii?Q?lyveJOCtIDkuRLfzCn+yE2pu+9Y9b4ZSpZcemzO0LhE7trSNiFsEnSSkRqDA?=
 =?us-ascii?Q?EVJ3WRF383mC+xIrzhwlSm3rzvjCJncX2D0C53eeqWhERJWHH4lxZxPlWMYR?=
 =?us-ascii?Q?hk5ht1Dd+W9SDIGniyLnMkztOp7R/WB6zSZTf/CjrlQwYjUeGI/dXJzp0ogV?=
 =?us-ascii?Q?I6tylaEx/jcpoTCM8B/rRHnxPiNC7sujvM++y62Hrs78MSnwD/31Thfbl5QP?=
 =?us-ascii?Q?SmFII/cwUcidUQ5f9L+I97eDjLKO+XU9BIDupCMN7FqVMnNEhvuSIW/Ax7Nk?=
 =?us-ascii?Q?XlvCmdHEF3hM21D/DpL+pCjyoKBmCLJjIFhZH1A+MJdOwMCqNfi8RdiVve0g?=
 =?us-ascii?Q?xWFRMooZhndpgR/WL/M72AAbVw/b0fp62t7I3jmxV4Qka1tbudV3oBxWMGVD?=
 =?us-ascii?Q?oISNbHdkBhHn+PjxAMlxquUkGMJX++o5wIPLQPP6D+SVcS79fAG4HJUxdhIb?=
 =?us-ascii?Q?Sksob9ku4lDd3wGcnuzgKmyU3LMfO59f98z9Yxyp2GSyHc4WEa7lLGaFMyw/?=
 =?us-ascii?Q?QWMiw6y7I7xy2eeLuOzVc22bThhU3vntrl3UcHeWzVfDnRvdHtorJOmvMsDW?=
 =?us-ascii?Q?v7w5GyAIp4+HaltSwrnMib4biN6gmY2ybAzUrstb3lLmMAFFQsucpkC4yGBn?=
 =?us-ascii?Q?Izz9B4KEo1loBi8QIUbWaXUny8UCOGLCP93n8cAaGsRV2XrSWC5pM8otJ8p1?=
 =?us-ascii?Q?JlxGzf4Rca96ipbef7zOlPoyj35UcMh9GE+iWmIq2vwS1bIbA3rH/BIVYzzK?=
 =?us-ascii?Q?FxMYnRd8M/EmYJq6RWTQw9LdB7+jAyb1g5K4AZ1uWTcYRoIgqPQWUaDJfgvE?=
 =?us-ascii?Q?kuqr8tsfRf9MceiN9nEZwFlHhB+2o9rY418V/vmyVktKK47IbhufSnWVpJR0?=
 =?us-ascii?Q?UTpFqAX9LcgGdoYEHWSwpzlzWouokPSGAySfcX65wDNL3e9xK1KCouZQ0uDE?=
 =?us-ascii?Q?Osxh+c99jNm/YRXxn1QIUkt/iKgHsCQ9b2Gw9khTtbkHJbwGs10TgCCt8vxz?=
 =?us-ascii?Q?TwXnSiKsryp0vTso6Wx+WIFe461+KHgX7Ehdz8mZsyJNoCmqBPXSLLcdupXY?=
 =?us-ascii?Q?PzPeM9Fbb7+QuSxaoDmpWb3ZNzCuZMn//OJ26FaW3NGa1H5RTFRpsPPjU6Ne?=
 =?us-ascii?Q?+gWnCKMM0C+2D2mgsy4gVARby5xjl4Q0B2marnp8PocKV7bH5W7pfn8nhOi6?=
 =?us-ascii?Q?cCLWP+DtDJVq6RgmY8ZwWoZJ41TN8Hb8S6ihYcJhAxgjCXPfSYwI9NYbJEdF?=
 =?us-ascii?Q?InK2rJSkynqLt1k4/dtYOiBj1wyo8Kmc3wNRUnxFGeUBs5nKraejACj8CMjv?=
 =?us-ascii?Q?1MyyDL+zBjTlY2q6MAq2p0sPE/g0CV572ZlqTa0u9CO60UaxH0ZOK0ai62Hy?=
 =?us-ascii?Q?EEZ9Zwxf46NMW7+5claVgR1JBZfex85JLddT0roSnTSikxaN81FbvKaEoRs0?=
 =?us-ascii?Q?Mly4/8hOL2DFMUyrDqjWvWk++7qPchJ7/HTHtKj6M9T0/ISjihLG71w8X2dp?=
 =?us-ascii?Q?p9RAC2Ya/V8zZRFG7MQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(30052699003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:06:58.5725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e51e67-c782-406e-033e-08de2c5e3099
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640

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

V4:
- Fix typo in documentation (Randy Dunlap).

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


base-commit: 61e628023d79386e93d2d64f8b7af439d27617a6
-- 
2.31.1


