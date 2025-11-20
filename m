Return-Path: <linux-rdma+bounces-14637-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1634FC741D8
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 923994EA9AE
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5C833A709;
	Thu, 20 Nov 2025 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cd1D0Tnm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972B33A026;
	Thu, 20 Nov 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644411; cv=fail; b=LmLzxijVsieJzWucdeQMQuMXw5GH59Pt9ob9db/tp+ra5JsYYULSheeRPhz4jZdGVgwl8YFgEv1kFJe4gtso1PSLcFmNsE2LDWbXgOnWNifUI6NaBLnOmBMNjyiQ9+TmrQ70qRgltA172U76TtYRhMiaEROPQNNDmAbsUkfYNoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644411; c=relaxed/simple;
	bh=cvbu+TYGWr8I482e3JdZi6DE1Dw6t7yTt2XWnE6OZoA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hQaS2bV8Ny0djv5kFR+YspmHVxvnlJMNqs6kV0QsSpWRmueoPinw53YTchOmrzcOFmV2QIFZFbw8iUZwi9DLkWyPZ/zgbuJ/mJQTPQEI4h+4psKnHmKWa8ZPZgANYLX8EVRMI/0+aDX2JvwY6NMy+xlX4lHSzwrRz3D1gCzMapc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cd1D0Tnm; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=genlCUHZqjdGiBqbgVCEc6JB6aVH46tU9g1xrfK6cgetmzKUjY2qsTI+Itw6yw5GsFN/+xX2+gElA8N1HlR+mFo3GQJWwHZ1HXkoKAH6P7luRiCTePpjb1JC0lXkzuMAXJVDIts/Ir/GiFTrHF9yrMjpirr62qpEb/JT9jojcBxHK5xTXAMOhHrDy37u3QFIP3F/aIWX3nPsXWVxY3FZVpIPIQPaoTEy/pLAl/GFVLIFBQSHZTfeC2p0l3k+DkfNtUXR/bgif9qWlLTMMzFBzuytlYsuxo5oU4Ql5ceWwOkSzl1A+/Lg1u1HxrosLCu2k5Y1RUbNEEGe3YVnHgV73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87Sc/t+asddKWEeiFTJPdF2VFlg6xfMms0SecW7lo70=;
 b=jlw0OGNedHOXtIIZ6tdluKgZNS0kpMilhp7nEU4dPMoWaQZmpXd4JfU0MxqEP1+b4aLm3FyK/5oQBatzRtssb4mVWWXwSuRqu9cGC0/cjjaQpxL+n+WS9WnJK9P0NqF+kz8t1VRKQMHt9RaOOOw8qKZaytRf3kHiHOofKD2Y72wlhmd85xTSHGbTJHIQ3iX7LRWtBx3hNDpIHANRPuda38TlhPe9p/EXGcfcLebmut3VlzPkI3dq0Bw0iyOVmN5SwaPYVWR1DKXjm0gbdrTiO/yF2rrlS0PVwbPXwrUsQrQQXzmkxDUT7v+tovm7k8bnE68dO+bkUM2AYAuSNY9QXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87Sc/t+asddKWEeiFTJPdF2VFlg6xfMms0SecW7lo70=;
 b=Cd1D0TnmmY9uKwwVipisUU66HGyP2Vgtxc9BZFkQ2l7op1EqS8W9P5tDT89UPZCEN2c9flwI3jeWD5vnybmX3ztw8QtxnqWX2c+OVxqLe9TGKKmdwfc28qX62OXh0nF4meH9NvLPQFNKouIhujk0q30yOtmvLgi+CSoXkVWciQXJjyM2yDIVmUbkg7zaK5zkCg7UNvODTjpTpi6WMQ4RCRNYp4jec0giZbwNxU0cs8TPYhJAPP/irbDwj4beCnAMLv9XFVD3h2ov5lg/7z6jai0bGvlXVrrWZsXnXnYaAVaXQNLpsrwTaJ0Kd+7tczSW4Pb0iyJfT70xcja1nC165w==
Received: from SA1P222CA0148.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::14)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:13:23 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::fd) by SA1P222CA0148.outlook.office365.com
 (2603:10b6:806:3c2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:13:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:08 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:13:01 -0800
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
Subject: [PATCH net-next 00/14] devlink and mlx5: Support cross-function rate scheduling
Date: Thu, 20 Nov 2025 15:09:12 +0200
Message-ID: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ed1fbb-ad1a-4678-6b0b-08de283695b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|30052699003|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cl9vhuWhhoDEfj/gTFMer9FLMayEFSonHyqNe2j4ZsVjKajHRrhBVYwxf89Y?=
 =?us-ascii?Q?RzZZEUzlwe1RuBzP4C3szvTzu4zM25NnyUyXX0fM4ccrwMI1UiJEqOGLuoLW?=
 =?us-ascii?Q?lh87cDmVseYWxP8iN7Bhru9hLEdSg0pKMl7c9yfzt+14ya26norK8QWCfJDS?=
 =?us-ascii?Q?zciU0bl7w56X8liwABcqa36Mnm+62GVBtd/lLdFdOUZBEzvNnvf/81jJvDsz?=
 =?us-ascii?Q?buskAiY2kFLcIKrnu044yvc/yPZCT/DL75aDaXtaduqNsDyRMdh97CA79lgP?=
 =?us-ascii?Q?DgfriVvT4c5g6AX/DxXkG/4GJXVik76MSLoSrGdmluYxqVdUeIvVdvxZe1ei?=
 =?us-ascii?Q?GVDzMXtb8KRRgFDhx2Tlba9c/WHT0RhGGJgbO/QZ2kRhXuUuSpvRJzttr906?=
 =?us-ascii?Q?ZWJ/FPz9c2GelLnu5lLWABBAf0qemy1Aek5CYPpwjCZUMsgoqr170yDl3px1?=
 =?us-ascii?Q?qthsrCaOEMHavYeS8qcckfjUt5VORiRFFMLbHmbUOzZjMj2jmOHmQgafC4NT?=
 =?us-ascii?Q?R+9RequOv8M01SpuRjzg26ZQXJX59E3hRfM1syMp1WUxz9NUkrN4NspM+gWt?=
 =?us-ascii?Q?Ztm2tCo4DXAvHhaHBKV5qw5q9zRV+h7F5zyrLSoRlKh9YvlKgLj3R2jiMaRO?=
 =?us-ascii?Q?taJX9PmwqhyuUTjt+73LIf8ldpiVOghDj4cVBejuupNXiayJL2zki1BLHTmv?=
 =?us-ascii?Q?hbiGUNM70SW8ssxG/cu0pj3E0r2MXgP7vIEiQ47yJLZW3jEJCN9S+IQHCwwN?=
 =?us-ascii?Q?bQkprc0YpcrhVu5Y+lgcp5lYf2JPCqD0zLzS3YkMT46MXZbUn7yR8iImCtaE?=
 =?us-ascii?Q?4n8RhjMsgOf7dHVixBoOkkcBZUrm+ODboxqW6RdPO8XjDMUvhZvcMzy0ddzn?=
 =?us-ascii?Q?aWB24zpv0PuaVItodHqflBYqjiqEWLbOSl6L02tAlLS8hFAiJ/YCCayvB84o?=
 =?us-ascii?Q?PTGyS9MuofuHFsEck8zpxpgZWEtgjhLg4VnkV8DgwvWlyf+Ta8NsfNI0QYgB?=
 =?us-ascii?Q?2mn7D1ZtLb2eBEjCzfoC9fT0L3ZN1FNBJUBIXm1roQltdJGALEiutLqkUe90?=
 =?us-ascii?Q?cf4oN4HDh5lwETboH8CPnxfY1X5OZ715EnFVOkNupuEwf465rEoWjFg8aEQW?=
 =?us-ascii?Q?U5meH/t0O9oKmrDe9giHoHp+fpGcVuJTyZOOAZ9k6pucDhSruzEU+iz7W4AQ?=
 =?us-ascii?Q?MR+/TcNQKMYqlRVmmFGj/zktqmVsbb/222bvEvCdigmeWk/7QOKkIuqik35y?=
 =?us-ascii?Q?BIIn/PObvcQwom86+LwNdOWn5go4e7FkgxTTJR3BSmavkiGCo7r/74JWgcEt?=
 =?us-ascii?Q?zPOPZ1dUhA/F441KelcwJqlGMq0mv1Tm3ZSiX0H/Ok2tW5j9hj6wOIq5BeFZ?=
 =?us-ascii?Q?a/shlD+ZWGJ0QqfFKdA3d1OH4BRBWL4wc7cDQGBs9ID+b374bkuVD6L1nfwj?=
 =?us-ascii?Q?Pg/cDwRhVwKVvENkL5Fp9cEOzBNDVXfT+SgmTVpB0UBtobjKmbARcGOJKsJZ?=
 =?us-ascii?Q?9Z209TeznHPUdsaTQYu/EJILJJsfkNoRkMThQ9jnvWzNf4/nZl2kNW8Vd/XM?=
 =?us-ascii?Q?1Fe02ly5KT4ReY84Low=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(30052699003)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:13:23.6962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ed1fbb-ad1a-4678-6b0b-08de283695b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928

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

 Documentation/netlink/specs/devlink.yaml      |  22 +-
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
 25 files changed, 873 insertions(+), 293 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h

-- 
2.31.1


