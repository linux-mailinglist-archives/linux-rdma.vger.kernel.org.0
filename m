Return-Path: <linux-rdma+bounces-9704-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D505A983DE
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8328C3BDE6F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B2274FCC;
	Wed, 23 Apr 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OCLnoCsc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD91726FA5A;
	Wed, 23 Apr 2025 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397398; cv=fail; b=msEJSI2jp0GxCxYw0fnd3IrWWU5fxLwQYJAoDPI48NmHhnXAdO7QbZ7RXcIBMvzyuAx81sN0gCUMzDrHEomR63TruSgOifffzBePgNLKOfLW8nYdj8ZOQ14mU/Dhb3neCwkMmmBIhOjFU2ecmRS7mXv2WbRKsf+8EEP6JNZcF4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397398; c=relaxed/simple;
	bh=7Qp1Nyen5C//+DDvbm+FO1Mz2ZoQ1EN1BWcSEF24NSw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cXpOLguUVaibgKkAHhAmB4ECkuiuuxYAsxE2mG959ZytZGueNE0wgqxK530PNZR63JaY8+sNK3QludvJmDpwxiqpluuKFIOfhLvRAaG1LwM8FHGuHAGfB7NZUBNEyo6Ep3HOZz5roOQ+8P0LeZQpbkaC1emhUsTRmmtTMguFC+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OCLnoCsc; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meTsIM1hnlCemtM6y62NAj3BZDLKrNZjtndDDXTajx3yJ22Sum3Z/h7nAuSO4dGk3Db7jWF58rl+roakJoVcETaHHhGiDGR+ztl6yBc3HYfyYCz+XW/s2GceLIrwKfJgPq6j8hi3WjARhWSbXtvisCKVb4usFLtRzpSbGw6HRLIErFqa7SLJSNt+jgfN0nyYiU2RoJYF41Isl9bc2rdk/YHq0P5dkeAOENhNYTeYbXTYbZTfvlI94efDNNLxS5Kq7nWF6pt6ItrlQ6cU8LFCr4s3tKRTpUCWC7K+TqWdx0YW5gK0MkDBmlWtPw5lfku08slT5yoYTg1dXyq++aHBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRb/wacdKd8K/XtM6XhL7YIlHVErT+7ZdtMiSFD0ku0=;
 b=ez+OfALr3WEDUc69q/RzJljhqOThaxGOGjuyEZc52uBoY7f2exgiZw6EzKOi0DVTKPrmyvSnnb6dqHXLiAj1rinL0Ned15XS//9fUKfmYweZyAW2QNpLq7yzw0gwsb7nfoRXh17BpDlrGRPxLnnkDkku3TtMjU5Xz7YuNSd/Zl2sffp8YQ1ZBruINGZ2863a5GGm9LuZxqViJeQzQpiLKb1RQORZxH/aevmCmoN8kxw9OV7RCly+fA8jj+c7CDoXMY5J7Q1qpLjCxcQcewpVd5wwYBWGx8IKnqfZYlrxM0VQdZJ4ekoHK2V1/NAk7dI579U9etPOvaku3QT4LEr3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRb/wacdKd8K/XtM6XhL7YIlHVErT+7ZdtMiSFD0ku0=;
 b=OCLnoCscHLnt0GtkyxWkjw+Dv04LXL7LVamWvKAea29G91dECB+0cixdM9QGhTxGG+G+Ag+l0dY32Mp/dUuDpIaK1SRWZlV4h4sOFOD4js2M20GUPIm8dP0oUkG9z6oVVdxbFWJiqVwwD9KvR1ShzHpKJ0yJxHhk7R6lyTC5viav1STYlcNyFXuE5zH8LrNGCgkVyx41zFTy60tCmNpgx77iFsLdVcV7preT8u0jn4SkIdf+b3nIxONDbWIY6v/AidkKAzxqN2rGJ9hHYPA2O5vAFmMKhicA8zlPd8+zn0GvhiaalQm/822V+/QQ9U+37xJobCABD1e4WJGBlyEP/w==
Received: from BN9PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:fb::31)
 by DS2PR12MB9565.namprd12.prod.outlook.com (2603:10b6:8:279::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 08:36:33 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::91) by BN9PR03CA0056.outlook.office365.com
 (2603:10b6:408:fb::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 08:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 08:36:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 01:36:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 01:36:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Apr 2025 01:36:14 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net 0/5] mlx5 misc fixes 2025-04-23
Date: Wed, 23 Apr 2025 11:36:06 +0300
Message-ID: <20250423083611.324567-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DS2PR12MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: 20327b23-210e-473a-5ba1-08dd8241f356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DBkDLau73r3c9iP3lSw1ZWrwVuZD3BBGSVhvxmEIfhWEKVzMU/+C67e/SNwQ?=
 =?us-ascii?Q?VhE8hyHkSP2bixVfd7cNt27BKAa8HpHxypY2rRj9cPio64AZX9G6ldD93djV?=
 =?us-ascii?Q?u5CMpwf4qpICd31sAcbyNw61fLDVtXvWsBaIbV6oTpFryqGgKzbb8Apa5+Jv?=
 =?us-ascii?Q?0ufMLjcQghEHR2hT6DUclOpDzArj061KqDPr2X5AjowBBsP+j4b1OvFfrxGc?=
 =?us-ascii?Q?kAjBPJvHRxMX0QLIxRL6NzXUtCBO31+99UIIlk7mFKR/E5wfUeeb3IhsWXl8?=
 =?us-ascii?Q?zCoOzcRf6CgfsscNy4DNIzynCebMo/8mXAkyB3Dzh/zdMMlRF2L46kHRZef9?=
 =?us-ascii?Q?Sva6n5Dj7IFKqqUe3blvMTWXqnx4VSBvpFFMvHyHZY5t4jYHxXg7MMQE1LKV?=
 =?us-ascii?Q?d9YGuJFfWCG5x/WqpKWLjLXf3lD80L5kiPXOVfyXA66zpT+imfi+op3valsD?=
 =?us-ascii?Q?Ye1rovWJ34JWu0NoK+qbxCUWcy6lob4A0cAhEfnYFXDYWY8cE/rqY1kK5gCH?=
 =?us-ascii?Q?bg5PGZRyl7O2KbrAZSFYYleRdniUIG8fOq+6qqHWBqexJGvYkBaMa5FcsHVf?=
 =?us-ascii?Q?0EP4B9KNayjV7SIqSsOZ829LuGA/vegz6q+y8NaSYlule1qadclK2Pgfaf81?=
 =?us-ascii?Q?D9rLvvM9Z4tRcCV3VNwy9v3ZlpmN+ehP/+DxiHcE/BSaPC8SyK8+/gZ/+BGG?=
 =?us-ascii?Q?qApbaMn5w7cGUgnhEar2N7E9eUNAPcuilfUwfBRctX/A7EGF2+JePBmDELf1?=
 =?us-ascii?Q?5FtSd1l8cbw6joaM6Kl6Te6d4OPBW0qWVTDKgp/CE+qcBqBoXCGoKb72rB2P?=
 =?us-ascii?Q?2ky9Cwbx4BxqB+vJ+MheOQCi4Pffa1DW97GnQcdSZez+vutLQCaqGfO0Fr8s?=
 =?us-ascii?Q?XS1ZpvxCft3mv8M0ugE7KziI2nGHJWVZuP5diVKjv72D3k9yOjKhuV4F61GV?=
 =?us-ascii?Q?jeQ4J47Ut/Lak2YGNdJmoR2F2S5sNEWuwqkTRne1GYeympGcSLZBRNNOygnu?=
 =?us-ascii?Q?fFm/k2+0AMmOD+ufM6t5Bo944RMtSUyQweKdeNUBF56K1ATH25qfy3jLmEPW?=
 =?us-ascii?Q?o0JStimnmIgczD1FNLGpSyxHb/6BDDFN1X5ngbQHTowoQ/ps/XbacOLkMZOs?=
 =?us-ascii?Q?AXtj7GMB/50FaKt2cW2UqYBCfl/B/w4FIoTCrbB7EpNMr6/cIRiA0ce6X75u?=
 =?us-ascii?Q?+WJTZ/usTZLF0RUJONwMi6u0gJOzHL6TczLBQw2BxSYtrCtknWnr7hjQH3w8?=
 =?us-ascii?Q?B6TtAAy91IbZ5WJZsagNCdc4YAB4EgVkCvl2UVIf3blUYRjoPW3j/0zrv1AU?=
 =?us-ascii?Q?4igJ15D16sDLnycALlGueccNiccMjEPh7HWtVdpEdwa53TzV5AZwzlXGBdpL?=
 =?us-ascii?Q?c0Assu+6pEF5CciVaP2gQI6xVOXJCXNhk5JvGtnSQyPgCSRuUHttYnJtkkvp?=
 =?us-ascii?Q?mJAS58aaA4POuu5FOaycmkffotKI/Hei50GTz1GJ3gnYiGjy06kH3Po8mONH?=
 =?us-ascii?Q?9G/LCxIyQTQMtNAvN2T1WQ/VGwVnBHI5F94x?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:36:32.1611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20327b23-210e-473a-5ba1-08dd8241f356
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565

This patchset includes misc fixes from the team for the mlx5 core
and Ethernet drivers.

Thanks,
Mark

Chris Mi (1):
  net/mlx5: E-switch, Fix error handling for enabling roce

Cosmin Ratiu (1):
  net/mlx5e: Fix lock order in mlx5e_tx_reporter_ptpsq_unhealthy_recover

Jianbo Liu (1):
  net/mlx5e: TC, Continue the attr process even if encap entry is
    invalid

Maor Gottlieb (1):
  net/mlx5: E-Switch, Initialize MAC Address for Default GID

Vlad Dogaru (1):
  net/mlx5e: Use custom tunnel header for vxlan gbp

 .../mellanox/mlx5/core/en/reporter_tx.c       |  6 ++--
 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      | 32 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  5 +--
 .../mellanox/mlx5/core/eswitch_offloads.c     |  5 ++-
 .../net/ethernet/mellanox/mlx5/core/rdma.c    | 11 ++++---
 .../net/ethernet/mellanox/mlx5/core/rdma.h    |  4 +--
 6 files changed, 44 insertions(+), 19 deletions(-)


base-commit: 491ef1117c56476f199b481f8c68820fe4c3a7c2
-- 
2.34.1


