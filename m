Return-Path: <linux-rdma+bounces-15735-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE73D3C149
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AEF144404E
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 07:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480C53B8D54;
	Tue, 20 Jan 2026 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VmbRLIBO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439223B8D4F;
	Tue, 20 Jan 2026 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895915; cv=fail; b=Lz8cfoEG7BNNAj2TTeSWGribQPTuqjQoNzeFlmmXrdhiUmj/OREuqriHPrElUFgKghnrYvjz+gpeTBO5fWR2l+ALfnNfYMbx3bp19xx5z2FIZ6n17awaKOOsITNce6fdr5wDmfGUChbEttmbH/z0u4h26EfzJ+0Ft8O/5N+wA2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895915; c=relaxed/simple;
	bh=d8GAWMy1KuTFm9Y6KuATcyvzsZteBEbMd8bfpRjIUGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J/1IJ83IzxVF5l1bCrSDb5hMFxryFFQe2Zl98UjWwJFKDa4PaRhOzfTQblLtYaEySK8EJ3LhZSIuro9MJItELSOB6SmD4lXyV2KjMLeVBnhy/FQSIkFTuACRcXEtF6Ue7JgXBjywCJKhTQvm+MnCvI6f/ZycL7ZW5RWKhDjMeL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VmbRLIBO; arc=fail smtp.client-ip=52.101.43.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSVlC0lH1fQpce46Mgh5FAsjbZpGoMHsJmGLxMah5p949bsgAyOvfI/hQqcjYIkMlmXhU61AbHHSCQTKful5olU5NCIlr3m2UWjBNHdHzH1eek/Z9DSBIQeWpU4jzjCkj11NdQRMnw0YE8RiQtLth1LUUumP7SZ4W36cSUl1BrnzLV8kNU4ycv+7QE3kdEwth+ETHyffqpjS/rxIpVGsxKElvx5uLg4HrVC3OpXpGSZyH0AnuY5XTQs7swYyqMwvX+LmUPLAiNUzyvVrN7i0/a6O8Hffb6eiAtpkY0D3zBvE99Tt3GltnchtMQqUUfKumfDjZFqDNOoGtG+XSMLFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZG4oPI1y6nZXALFkPVgYy+fbX4at9MWrt2um0+Nj2A=;
 b=JQ4pFNGNbxyyvR4jb9pJKkxmmcq2ugBQngilYYP3GxqAthQx/YfbkOX/SuK7IHksB60dOypR8QmuZ0eBqW+6jh15wvGOzi63Pb6P99c36lOYeVeltuX4cWXKaOOOYeyPg+fytPVON6DyzFAVnq7ekwYM7q7s2/PGKvEFT35dz6boBZaITmiuraCaxFSplDDRrQ+BUdQblgHVQut1xLmSUnEXS10R+INWU9+CWKBwJSBGmSl3BShLBQhsLJ8LF8bG1i7/yZSUI7preAgTKURizDvXrG5umsD+Oc73Ovu/YkHUxNQK42TL3xMSGn5g8t4M0EMbO1bwL89bk3cG6BE1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZG4oPI1y6nZXALFkPVgYy+fbX4at9MWrt2um0+Nj2A=;
 b=VmbRLIBOpSCHNnbOdfzm5wkIAOU0yG3/IcfiGQhbXlDNGjQg6Im3LE51D+cgv/mi/3FoCRam9Y3wZhM2902ni88pZpj5BLknFBSoS8bzBnHD3OAwsweM3U1pUsylwLQtE56IACZgkwnffFN9Yqnc9SIEobB+zrnklQacdHkn7TMyJUmIZDnrDi1OmPkOBr7+BrIkUOsxYgIdhWimjj3BgCrOiGtuKShETmFC9Z8pRAv1gKVsy6WgYA9uW6FbXhSk3k+K0W+4ogHRDOi+h/muoEVEm/OVPn4qPE3rRv8ibeTr6IKRmn3SzMOrpqi09UOuagxFV53du48OSgKK1QARFg==
Received: from DS7PR05CA0103.namprd05.prod.outlook.com (2603:10b6:8:56::18) by
 CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:58:29 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:8:56:cafe::8a) by DS7PR05CA0103.outlook.office365.com
 (2603:10b6:8:56::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 07:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 07:58:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:58:20 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:58:20 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:58:14 -0800
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
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V5 00/15] devlink and mlx5: Support cross-function rate scheduling
Date: Tue, 20 Jan 2026 09:57:43 +0200
Message-ID: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 7819a02c-1dfa-40d5-b830-08de57f9b2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|30052699003|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V37z3ACluEafbz2ztzyqdSzkw2JMZjJYHe4gbqYC2BOK1ufo/pI5njSsUuYq?=
 =?us-ascii?Q?eKKBK5MmiLdvBWd0aZzGEQG0RHt5MnrixQGnM0KLhvw4Ywyck6dOOntMCv9/?=
 =?us-ascii?Q?5kwj6dRwhhkJ+X8KsgjGism43vf1PiVOhqvjSMSE5hPPlN3rr8jlzvH3vnCw?=
 =?us-ascii?Q?+g/oaSA6xCPHbSynZL/Ee80YEeG5Jc1AE7DFhZ82J7tUBld6Q5sRPuPduI3M?=
 =?us-ascii?Q?oSvk+rU9GRS0ZSHj2L6X/gVMnbu4NPh7TdxlbwGQunsW6ztG69sahAZGRZ36?=
 =?us-ascii?Q?l+WxXfEwy+/cLjq0s4SqAZR2552FjElK8bOijwHTet3Pwgf+2DEByYwOEope?=
 =?us-ascii?Q?CUyRe9vGyBBdJwzgyOQxS5gQmHeSRFdujKnl6ztVrr+14o5k7X/j/4W6NYsp?=
 =?us-ascii?Q?EFUe2kYiYYdxv1ifQwrFmqyvkKlg813L+O0iD7fxWkSc1wt0kKAy/y85To97?=
 =?us-ascii?Q?nGjOhabc8aCLqLABLMUWv0Il3+8t0kyHlhc9kJsOlcr4HDHnZv5ucJHHio+3?=
 =?us-ascii?Q?Ax/7fQvTYFUhdlrSabfZ9wnPoaytnsSBIPjmIE/AdGBtg4BX766/baQ+NDML?=
 =?us-ascii?Q?Rl+Cou0F6F3egS4Y0VqmxwYwdjWmOFdtPLzmioCMsDCvdCK8wChhG1SXv4+e?=
 =?us-ascii?Q?Cr6gLuf6wIS/XRIt9wDYpG+kbZQPiu5FnEtNr/x8TTCdAIT8bOkWZfOrOIy3?=
 =?us-ascii?Q?Lpg3swGBsmZGQa8n68bcQx9UqsHT2D81H2UbB2MXqS2zbGTSt/tttNpqYx5J?=
 =?us-ascii?Q?D1tBBja1igrR469QfKlhWqyxO5Cdj1aj8CH+piJx5bs3pbPocqv5Cneb/Fkr?=
 =?us-ascii?Q?Lvt2l4rDfmtn9DLNgpsPc9nauOTOyKi9B3g+7NaMtVC4/pFk9rbFe+lc5Drh?=
 =?us-ascii?Q?i52Dkmvyg9PhjO15WztY9aZviM0CKiCSmPqgwiM4/ytDTqc0pG53Mp1iOsgY?=
 =?us-ascii?Q?FX+cyH1xqmv9YX+dbpjBp7TmoAstn7+W+FNal+lVx+v6hTWwSD4oqqApP4lA?=
 =?us-ascii?Q?0lORgLA8r/uLEKnur2GDr7+TB6v3u2mcvdlyV/hFG7bhdNxNTTkwj+iR7DtM?=
 =?us-ascii?Q?RmGjKqhiUSvHa4K13h9LTKiGblc/AMc5CJvWMdU93Nb9rYjSsroYqLOeh0JC?=
 =?us-ascii?Q?/2HqnptS2Po7fpW3+hKkQN3pgaxwdTu3horPpZISR58Zw23PKZFKZxVSS8uo?=
 =?us-ascii?Q?mclnp6zIGV/mH8bD0Z4fb5n4WQuqyBAZLayuMtVwpEkBHItjyn3QSl/UMPuQ?=
 =?us-ascii?Q?uLQRNddDFUzBq49HBSuWczfIgZLhiWkuGAgNQyMDmir+81bE7qjXc7blgOm2?=
 =?us-ascii?Q?je8dxbclzHca89gD6JwOGs2lUHmJ666ajWLo4kp5EthLdgSiF2W2VvD84Drc?=
 =?us-ascii?Q?rvtZfvGdOONvF9r6EuI25TcGU/WDspYdZQ4swbE8Tj7bG9ZBj2w0rBVPSm0T?=
 =?us-ascii?Q?bN07nIHjOUJW4JA6EYmhGyr2Xzed6xTyym8z3KmPyUw5IEZ44gzkUp123zHW?=
 =?us-ascii?Q?7MA6ihFbHBsYosWHI/Kni+f/25YoNvremIS+t0eEQLIHM8fyhpYCCCIXK2B5?=
 =?us-ascii?Q?bkYRqCu17F0YPdEuAYcZb/+N+OmP81OIwl4cevU8sA8k8/l1/tM7xMqaNnc4?=
 =?us-ascii?Q?porMwUA0QAf1LnXl1d3R22rqh9jkTko0yDua8B7GUf8LiLaAqok61TMrOQCj?=
 =?us-ascii?Q?PbS8gA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(30052699003)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:58:29.1665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7819a02c-1dfa-40d5-b830-08de57f9b2e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521

Hi,

This series by Cosmin and Jiri adds support for cross-function rate
scheduling in devlink and mlx5.
This is V5, find V4 here:
https://lore.kernel.org/all/1764101173-1312171-1-git-send-email-tariqt@nvidia.com/

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

1. Representing the underlying physical NIC as a shared devlink object
   on the faux bus and nesting all its PF devlink instances in it.

2. Changing the devlink rate implementation to store rates in this
   shared devlink object, if it exists, and use its lock to protect
   against concurrent changes of the scheduling tree.

With these in place, cross-esw scheduling support is added to mlx5.
The neat part about this approach is that it works for SFs as well,
which are already nested in their parent PF instances. So with this
series, complex scheduling trees spanning multiple SFs across multiple
PFs of the same NIC can now be supported.

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
devlink: introduce shared devlink instance for PFs on same chip

mlx5 support for cross-device TX scheduling:
net/mlx5: Add a shared devlink instance for PFs on same chip
net/mlx5: Expose a function to clear a vport's parent
net/mlx5: Store QoS sched nodes in the sh_devlink
net/mlx5: qos: Support cross-esw tx scheduling
net/mlx5: qos: Enable cross-device scheduling
net/mlx5: Document devlink rates and cross-esw scheduling

[2] https://lore.kernel.org/netdev/20250213180134.323929-1-tariqt@nvidia.com/

V5:
- Made parts of shd generic devlink infra (Jakub).
- Stopped using __free (Krzysztof Kozlowski).
- Moved some generated netlink in the correct patch (Simon Horman).
- Addressed cleanup bug (Jakub).
- Clarified uses of shared devlink in documentation.

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

Jiri Pirko (3):
  documentation: networking: add shared devlink documentation
  devlink: introduce shared devlink instance for PFs on same chip
  net/mlx5: Add a shared devlink instance for PFs on same chip

 Documentation/netlink/specs/devlink.yaml      |  22 +-
 .../networking/devlink/devlink-port.rst       |   2 +
 .../networking/devlink/devlink-shared.rst     |  95 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 Documentation/networking/devlink/mlx5.rst     |  33 ++
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
 .../mellanox/mlx5/core/esw/devlink_port.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 332 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   9 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  14 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  17 +
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  91 +++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  14 +
 include/linux/mlx5/driver.h                   |   1 +
 include/net/devlink.h                         |  13 +
 include/uapi/linux/devlink.h                  |   2 +
 net/devlink/Makefile                          |   2 +-
 net/devlink/core.c                            |  48 ++-
 net/devlink/dev.c                             |   7 +-
 net/devlink/devl_internal.h                   |  11 +-
 net/devlink/netlink.c                         |  67 +++-
 net/devlink/netlink_gen.c                     |  23 +-
 net/devlink/netlink_gen.h                     |   8 +
 net/devlink/rate.c                            | 290 +++++++++++----
 net/devlink/sh_dev.c                          | 163 +++++++++
 27 files changed, 978 insertions(+), 298 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
 create mode 100644 net/devlink/sh_dev.c


base-commit: c5e7b1d1cc8a6cb8b709eef34c93a9458427ab2e
-- 
2.44.0


