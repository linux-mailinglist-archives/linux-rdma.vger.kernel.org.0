Return-Path: <linux-rdma+bounces-7749-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FA3A34CFD
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B063AC711
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585F6266B74;
	Thu, 13 Feb 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="swKtGxeo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B043266B57;
	Thu, 13 Feb 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469796; cv=fail; b=r8xib4SpwzpAeF3AezC6bso8GPqb2VL0fz+0afJ7ICdWpBr7+O2RZEt/8Yn2LsGioVxL/l9ZsqJump1lMcAkdTX+YizmlGM1kQe41I3lNjl1GncRcPPFYLfkYYMIDguClX6nHudWqDcFNUmXY0Fw2MYKL8y7JkntZvViXJb4ZLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469796; c=relaxed/simple;
	bh=67X2KCCvD4r2yIJREe7iNyL0hMK+UcrZy+UUzbMpKco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEnDBirm1A8TL6LZpwAs5GxUlVHRbBsXYmKP9DcxMbgNci/lgBT2oXuYNtXlnaGkinAdEElegJgEPzVTCnzl+v2CEtWoRbTAkP+6rtlKqYy0J+enMtAIclZZsPeGtyfnSk33BTdJ6Aa5Txhk2+eFO5thukK5g12LJrl4z9v0UOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=swKtGxeo; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9moTlLyF1aUgBztRw1fFcNIlnydLLV/tjtdO36+4HtSLcGvHMjYYeGUyzgdE6fMpykVJDyZF+WWaSU9EE4js9O5rrTvOdVDq5IlFFzR9svl6ZRnpSKiMsfRKvB75rnw6kCA4RjMGnXKXVzJRKzqLd2/k+CBiZRR3YHGVBiAR7vQAwRKY1MtyzXGCxPODtdG2J/oduE6y12v4rMpagPgpJwPzz6HWKczgsZ7DzTFf4nfb+wnariTyVS224BfvVfY3FsVw681e3iI2P+8OWlWCrgQR2f3dUCR/v0k8J4usWEaUHXKOEtGu26TiD+VJPJ8ccARpt6EptKZmQhgM1Qq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qlEhmr/sRLGr0IOve+0Da9ekaqDij9SuQ08xeXPNnk=;
 b=Hpd4F1v8yMJgjf6sHW9lV18/be9DA2eVXK8XEql78mEBleYO1KdmJ+c9F/FdXYKeoUpxg017VDMNKXgJtXyGh3HLZ5Ngb782SPd3hgHt2V+vuqRerjv2UrU3Bn94cHuEUjAhezvfsUJDxiibhd5dx4DDoDno67DL287ZEHxYfXRbfPyfJ3qMVGSZH5OoZE02mbNk6Qf1UIiWOoXm4cdObACPMV4zGzOm5upZyU8hjD7E2fqfPf1CQhxSP1tj/l6mhFjS0ccH0PEFneJCytRzANrRWP687+XxLk2QJHwd8XJKnGvtw3F9ZGAmf3EQf2SDDWZwe/y972JaHA9gmmTBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qlEhmr/sRLGr0IOve+0Da9ekaqDij9SuQ08xeXPNnk=;
 b=swKtGxeo+sSArabj/qPhQz3bfQeKjV50pCF0gutlxQRz1OEPHL3IcIgomfhcic3jpnaursFXiDBoUSqnRpl3iD25NU59cLKEbsRqTP6mcC4lMatIhaocf3mqfWl38Rh0HMSMcByt2/yqrGS9vAbwW8icq9+GPsPaN8Q69hYfOx1yvZDp0cqC9SI70LAU1rqsfzByvfOA5zrP7cIiuXQm6fhHQB/VX20VYC2r5E9gB0f4xhRYWAYIHm/TCf99tPlSTfBh2ePvK8m16poDz4XRw4sD131JnZv6ezQH05fWW7Ib4CcSry/7Xqt3scsZ4n5W7tYOV5UnpOpKv++rH2XS1Q==
Received: from CH2PR08CA0007.namprd08.prod.outlook.com (2603:10b6:610:5a::17)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 18:03:11 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::ce) by CH2PR08CA0007.outlook.office365.com
 (2603:10b6:610:5a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 18:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 18:03:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 10:02:55 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 10:02:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 13
 Feb 2025 10:02:51 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Jiri Pirko <jiri@nvidia.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 10/10] net/mlx5: Document devlink rates and cross-esw scheduling
Date: Thu, 13 Feb 2025 20:01:34 +0200
Message-ID: <20250213180134.323929-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250213180134.323929-1-tariqt@nvidia.com>
References: <20250213180134.323929-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 2600d30d-597e-4c54-0dc7-08dd4c58adcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sewzt4lW7Q3JhIfF7JZQyg3tNXeN3E2d6JDyBfxGeI3gZ16xtsUUC/EFM6Ju?=
 =?us-ascii?Q?5VPb1+5uwb8i4Sn7IxHQZeAMqSdAuaMlQRe4Y+nFL/sg+lzKqdHTVfyFQjpc?=
 =?us-ascii?Q?vt2dJHkfqrd5BNUoXta32HF4vtKIvX/WTRqdC0RQYbJvS/XugMXhhui6hPs3?=
 =?us-ascii?Q?XzjlMd9XCTFUJfLTeHG+40fUTV0MnHFEhpyo2fsv6zFK+Dt1AnuJtl+FJUzB?=
 =?us-ascii?Q?dxilTpLokmSotXRdvH7Rvj0K4Cb+Iq5K1CCz8mG7aUA4k76l+7ADL50gZd/s?=
 =?us-ascii?Q?2YDvpiRwQhrGqCvP4901riAqdWJQf7ZUZolNzkhuut3M08jrCpPyVvR8FC8z?=
 =?us-ascii?Q?B6YRJDWnPzvIowexNPwlupPhqSbje/FcfnZ5u4WzUKXuhB2cpvzc2br8zi3W?=
 =?us-ascii?Q?7ikGzf3NIVmOKTSJMXN7qteDK06p1vvShXgJvblLEkfdLCVzwh+RbAF6mbFf?=
 =?us-ascii?Q?6Q89hyxozev36B+CZgZAz7YoetU4JZRKiNVjzoMF+wTiLpRjHTEckL1OkslG?=
 =?us-ascii?Q?b+yBjHXWHTEldGvWbAalMp5KFrmba+LOKx5BJW2GDxr3BdZv0fmmQebBzdef?=
 =?us-ascii?Q?GG/imV0KDflNWhxqBXOMVft1JUBRsTmPUG8nX4nQH9pxZX8gQGw2axQnwPVh?=
 =?us-ascii?Q?xIIEJnfvv7Wwt0QCIcJnmCn8ZiqIqEC9PyA8d7Zbax4hmvjUPKCZkZ3lPb0C?=
 =?us-ascii?Q?7QJzdSrCjXmbkC6ZTJKCl9nHg11+b4wtPjm8KRrwnmNZvPRyu21QroQHXjZO?=
 =?us-ascii?Q?GjDWlDKYs14td1byryn9GkLgpgzXi5qLKJELENZAARM3rKFybcu8L9H8V6gP?=
 =?us-ascii?Q?kQrrZ9MFc2IuFnhBaVttk2M2sU+G3O1L3w12N6N+ApoAVOpNtHvwTJC73yuL?=
 =?us-ascii?Q?HRD2kJ8aDtXTsa7Kbit7W+o6Z8BPUMNV242tsf02HDri5QkuCsfKpc5J6uPl?=
 =?us-ascii?Q?rtZKyaRfkO8/B2gCnsTSpJ1lffFxptSSoXPqDOKoSIuUfn9o2/WzIKmY5HkD?=
 =?us-ascii?Q?NUYY/5adMCgDACHyCNjs8Am6ACpkh0RQXX3C9mUfiBq13czFT1toMs2LR0II?=
 =?us-ascii?Q?UCfYmIjPGJiV2+eSy8pYN7ZOvfdVCLtvJFujVzvwyLC+rdvFltRVJ6dAq9dv?=
 =?us-ascii?Q?YxBWy8sSKsnOIY6uFxAuoNXvLxyDe7ImQ32agebfqYKQ5Q5biJzM+NVP1xFg?=
 =?us-ascii?Q?AW4DYeKy0a+QmiqTyLy76KAt5lFKuFMHdvNZvY7io9FSKspUZ7v9Xu0dmUPq?=
 =?us-ascii?Q?6zg58aKdClGAbYZgRXFsKEPlDxXARv26YnUs2WZ08ZfEIczZ8gb74JL0hgjZ?=
 =?us-ascii?Q?05XBhNMntQvf31978F9Zv6kaGxyGQ/aD3FTieUGPV6jcTmxi8e+OKyilqoBQ?=
 =?us-ascii?Q?+JXhroqJf/e0jYdb+yr4ZZVI/NH4e494jgI9CSLo4GxOrUjd0LOmyCLc/Ekp?=
 =?us-ascii?Q?ahRVJ0gfO+Co1fIblvyEG0Yk4ZVOie6LMoysKGvyTVt8xx4QYjB+NP/+2faG?=
 =?us-ascii?Q?1sduXKp4y3HP3lw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:03:11.1892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2600d30d-597e-4c54-0dc7-08dd4c58adcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707

From: Cosmin Ratiu <cratiu@nvidia.com>

Extend the devlink-port documentation with a mention that parents can be
from different devices.

It seems rates were not documented in the mlx5-specific file, so add
examples on how to limit VFs and groups and also provide an example of
the intended way to achieve cross-esw scheduling.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-port.rst       |  2 ++
 Documentation/networking/devlink/mlx5.rst     | 33 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 9d22d41a7cd1..1d9e5839eef4 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -417,6 +417,8 @@ API allows to configure following rate object's parameters:
   Parent node name. Parent node rate limits are considered as additional limits
   to all node children limits. ``tx_max`` is an upper limit for children.
   ``tx_share`` is a total bandwidth distributed among children.
+  If the device supports cross-function scheduling, the parent can be from a
+  different function of the same underlying device.
 
 ``tx_priority`` and ``tx_weight`` can be used simultaneously. In that case
 nodes with the same priority form a WFQ subgroup in the sibling group
diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 7febe0aecd53..61e76da36faf 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -298,3 +298,36 @@ User commands examples:
 
 .. note::
    This command can run over all interfaces such as PF/VF and representor ports.
+
+Rates
+=====
+
+mlx5 devices can limit transmission of individual VFs or a group of them via
+the devlink-rate API in switchdev mode.
+
+User commands examples:
+
+- Print the existing rates::
+
+    $ devlink port function rate show
+
+- Set a max tx limit on traffic from VF0::
+
+    $ devlink port function rate set pci/0000:82:00.0/1 tx_max 10Gbit
+
+- Create a rate group with a max tx limit and adding two VFs to it::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Same scenario, with a min guarantee of 20% of the bandwidth for the first VFs::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1 tx_share 2Gbit
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Cross-device scheduling::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.1/32769 parent group1
-- 
2.45.0


