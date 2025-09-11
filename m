Return-Path: <linux-rdma+bounces-13262-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4254B528C1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 08:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC217B62D7
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 06:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4607625A631;
	Thu, 11 Sep 2025 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rcmOomFA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D491A294;
	Thu, 11 Sep 2025 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572315; cv=fail; b=uksIonCmkf93B5PhCfixBre6hV6eCcD4gxnC5VvRmxQqZtpD2xdbXfFL7HKzsx1g03FimiZ/W62WvCc4d9Nq+k80bNGC70mhVtf9AmVVkpA6qlK+XbUcuEVhHQOTzC9hZSuu4Hg01p8XY3ELj5GW+yE0jTM2tHApInr84j8G4H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572315; c=relaxed/simple;
	bh=2pgJ0IoqbRyzWXYAlrMY4fJznM23EMY1C0n1H4WfEyk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V3JWJbVfMn/+JRSzYyp/nZfqi99Nwcb3GcOLdiND4cEllHAGyNClegpD1T+q+II8nZhOfWm4DkKNNd0nv+8YguulttuT7z6gkhpm4VJ3ZFErjl5I2dSgz3b/vg2fGQ1ryfORvjCNopuDb3ZXm4TYZ9kSQedIdJlaF3GYl5XYfqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rcmOomFA; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbLtoEP92GwRiNbWXYkyMguRfIzNKc5S30d4Z5GgBu/LMqeKS3LSlwuc3sG1erLoWgIBjYXoi9cNiahzRrFhRSyNbYumgYOkN4WqVgdR9Hf3oAKpZiH48MMeH0vAfh1FNOSmKpanlkyjnwyZKubJax6vlR156h8rhRnIdJSpdlTZd2SRBchByt13KkgfNOhBki3R4SYqaE+cJp0eOVJTeBH9s5lV4Yvfqj0Xdt2pgGBNep9RtUNYrYnY/ZFkTr2RmyCgSYexIuOvWd8OUf0AbgmOweihMw5uFsfjJJ6UXmRiHj4jEzsuA2zeKX8xVUaK2KdqW4PAKTN74tJuuVAcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwR6NN9nht1JuwD/+sO99k9XsNKiH5nuzLvdxT9lf18=;
 b=BAuT395ndKlPe39NFFzbsrDhgcc/3INXPauG+WF0QWMcPpwIRHsO0Pm4CUT3BERaI3hH8QWAzphjMUO/z2W1N8oLXfb4fyKzGpRSgzDL/TcTzn20m/hyB0QXNvcWd8YqpkwGehrHE50ASOminoEd7qeaJSxolRFursx4mWKq4WywsUlb+/fz+R7VWyZ+xWumiZfAMnJu19Z0E5UZH/RkaXP36O56HeAfs8qE6NZyImWFeDm1K7tyJUSE2YCM/bH9K5jXTtGJ2N043srWtRTJcabRxBDjzpAYVSaW0rxZfHhsFl6BgIksSmi282GIJcbbDjzn4YjOtOC3DDRWnjLV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwR6NN9nht1JuwD/+sO99k9XsNKiH5nuzLvdxT9lf18=;
 b=rcmOomFAhAsrVByBt7izUFBsEotXFQF4DtPpgJ705R7vi7NITsdFMaHvphrHG7CILthYxG27DaBOQcF8yHi0E/EiBI9KlIYtuWXNj6kBIgZ9TpYkkhNq4PyY63AQ+aDDfXDkWEnGyk8xIdOmOTM++rww46fqsD6kbgxkREx9D+dxHGrFIxtt6WaBadPzaISG4gwCAvHlpHQPi4fr4cPNwAcIsBiLC8pRwVJzz5aB7HW4CEhs8ANh79XuwlEKCFMcVAXBuGO8auQMDF5xsCThvmFcPtFmYbqbFl/bjaUt517ddqdrZlKBij41A8X2lCaADaM2c6zoGJQvIO8p3O1rGw==
Received: from CH0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:610:e7::31)
 by SJ5PPFA5F0E981D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:31:48 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::e6) by CH0PR03CA0236.outlook.office365.com
 (2603:10b6:610:e7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 06:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 06:31:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 23:31:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 23:31:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 23:31:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next 0/4] net/mlx5: Refactor devcom and add net namespace support
Date: Thu, 11 Sep 2025 09:31:03 +0300
Message-ID: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SJ5PPFA5F0E981D:EE_
X-MS-Office365-Filtering-Correlation-Id: 72dcecb7-76a4-4af1-ddd0-08ddf0fce279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ReW/hNLGBqo42ZViZe/BuxtX8d5LvNdyXzHE9EsnRGiyI+EwSs8hV2oosSn?=
 =?us-ascii?Q?5ZWrcnjSvFnvNbqSkhjoUTkQFzVYewS5lu/RXQPtnZtBdpSDWLUOnvnAhuaM?=
 =?us-ascii?Q?NJ5f/jGutw3LzR+GlXWionKT1eN0W1c5k73bBSVwA4UNcNIQJ5gc5fOzBbPW?=
 =?us-ascii?Q?QVSIfIdtvY85gycOlLJIB+S1vz1Fy2U7NJ5kLMONQo3ZCgXSvnPlPUbt6ePF?=
 =?us-ascii?Q?1IxBWeI/LvDBMF7YczE7u0zV3Br5i/lCPmMzGZyHyB9cVjmeyU4dx7/9Kdhi?=
 =?us-ascii?Q?wIL09u3gF3M+P2r+mm7dAdvCN5WsNl6Ea76GIhgpOTGxeJI+zzM5FixzGOyG?=
 =?us-ascii?Q?gfoAC7EilglXs545v/Xgqus61dt2MXvO9HDWB7YWUIkut9AL5lUPV9TO/7gD?=
 =?us-ascii?Q?8EdNBdccVeUixIxtevC/UyJj6GVG0MmmneoH3IgyBG0UQlpvbKMiStFG1M1n?=
 =?us-ascii?Q?+uGi7ZaJxgGKNhpeI7XdRANuBNzmvR8QXBQ8TlxRKYEEzwBo1B8KG0zpXlT/?=
 =?us-ascii?Q?3KZTFEoOgpWVo6ra0jHhjYTvW7nnlnnPapm5gOLKYlFDtvbTZ8oh3OCYIvo9?=
 =?us-ascii?Q?FBk+o+LO2lSFnoz5NWzWApP1n4GbZXJVBsf/QIgB4Q0mOXwtaZ7z/jWCmGpD?=
 =?us-ascii?Q?GH46nJFydiOpBHIAt1X22rQhPokk3oSuhjYq52/1FOIEjR64Da9xltwSJJRr?=
 =?us-ascii?Q?3mCK0bQ3pRKA1FJiED/ZZZ7CkVdrotCH57imdAtLsgeot51ypjnYI3NjUQwy?=
 =?us-ascii?Q?hk3YoY+baSQVfpntGTY9IWO/cPQbmcNDkQdimm4lV+BWTJZn1Kfq/w3TYvAN?=
 =?us-ascii?Q?ocSxZg2MAJom6RibWFY7IFX9UG5eS/cmyIg2nybTBjh1iv7xlq72rLhd0IPj?=
 =?us-ascii?Q?KJh8+cxqJPwzVzrOcDDGqZX2gDfDgJZ4Af6VCGpBV88qHlBSf2dloIIMwuBQ?=
 =?us-ascii?Q?em22EN5Iw2fmwr0t2fcoBZjhvfG0X4K+hVSpGHfKko5pgkoViASonMB6PX0C?=
 =?us-ascii?Q?eVT4LAWW66ZxyPin1ScpquXovDue/BcyepnPWcKs+E5ddqX6gO9gzFRqGt1b?=
 =?us-ascii?Q?e9Q1WgsiZlyvmFDeaqE4ceuNTHI3Q1ZcmIPAwNOXW+0Gf1PGmoQyRrv84ILV?=
 =?us-ascii?Q?PfadGKTKoJDuJSufR+6fq04ifbQliztV+eEfkSudmfHnYcoLARYoSpHAMcyC?=
 =?us-ascii?Q?wCQt2ZXGakhtp3zVx3uoz+RFq0axR+yseMg0NcbGN0QrHjz4Rm0+v1NOznDu?=
 =?us-ascii?Q?SnhQbddiVDrOHhh3o7TX/WcokQgIvrSKXKNyDKEhsVktjQ9OAyoDZZTfFvuQ?=
 =?us-ascii?Q?1pNoDD/mPmMqJ547i2LF6kyAvCf7u3aMak31uq3kxzu8x1We1hUO0kYUl5G9?=
 =?us-ascii?Q?iP7k6cevsKAP76FGNjxBgWK+2NkndAMGfSN6051Ci6IGZD+GsxLWgipwvJxn?=
 =?us-ascii?Q?fsiqIXjXnIwIYMH1g2O3j4J+lkMmut/P4+rnRPPaUWOYrpecYZNYZwboAUJp?=
 =?us-ascii?Q?G/ksg1lPC1ssdy6VRQ25KzQmC+B855hmCpBb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 06:31:47.7107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dcecb7-76a4-4af1-ddd0-08ddf0fce279
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA5F0E981D

Hi,

This series by Shay improves the mlx5 devcom infrastructure by
introducing a structured matching attribute interface, relocating
certain devcom registration flows to more appropriate locations, and
adding net namespace awareness to the devcom framework and its users.

Patch 1: Refactors the devcom interface to accept a match attribute
structure instead of raw keys, enabling future extensibility such as
namespace-based matching.

Patch 2: Moves the devcom registration for HCA components from the core
code to the LAG layer to better reflect their logical ownership and
lifecycle.

Patch 3: Adds net namespace support to the devcom framework, enabling
components to operate in isolated namespaces.

Patch 4: Updates the LAG layer to make use of the new namespace-aware
devcom interface and improves reload behavior in LAG mode.

Regards,
Tariq

Shay Drory (4):
  net/mlx5: Refactor devcom to use match attributes
  net/mlx5: Lag, move devcom registration to LAG layer
  net/mlx5: Add net namespace support to devcom
  net/mlx5: Lag, add net namespace support

 .../net/ethernet/mellanox/mlx5/core/devlink.c |  5 ---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  6 ++-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 10 +++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ++-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  5 ++-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 45 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 14 ++++--
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  | 44 +++++++++++++-----
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  | 16 ++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  6 ++-
 .../net/ethernet/mellanox/mlx5/core/main.c    | 24 ----------
 12 files changed, 126 insertions(+), 57 deletions(-)


base-commit: 1f24a240974589ce42f70502ccb3ff3f5189d69a
-- 
2.31.1


