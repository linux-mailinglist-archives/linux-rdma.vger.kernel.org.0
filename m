Return-Path: <linux-rdma+bounces-13971-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35A2BFBDA4
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 14:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDF118C8001
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B385233DEFC;
	Wed, 22 Oct 2025 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="STwHVQrJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B87080D;
	Wed, 22 Oct 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136243; cv=fail; b=K/IB25ueayA2X4h/qJyrVsQ21GT0uJlcyVOfFb58CqoNyokt44YJlgF10L0xQpShWa/TH+upw/aW3MHA6K7gsjeqxM4UY3lbi66YTU8jmzke1Mf4ErhQymJRqiyyJEnSVDA7qvZQw8xwXRw3hx2T8Rq1VyO3OIhh6+ye6/WWA90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136243; c=relaxed/simple;
	bh=Hujk4fm4dX23g6LYyJTf/2VblM8mPD1hmUCikesM4Us=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iacIomtTr6SPiwEjrachN1p+Gl9Co4tU9wfXNWJ8NrzX7eGRvm52IkWQe53QPcEN6/aNEgHicGCwg+4ekMIWxrlAdqmaYwXpOK1vedlJAWzJ1K8DflqrbPgoAnZdTXiQmDAO/MB2BPMl20B7S2hLb6njfDNAwl7HK4Yz5nOfjK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=STwHVQrJ; arc=fail smtp.client-ip=40.93.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFI1OHbXhjbm3Pg5kW0ZgIcXBTZJNFjrWH1wVtMPZndgHrluvq/5hNyfdNGlugnmWZo7ZN5Ot9OwVX0TuponofjXV33lhrEFkgVjbNKrMH9kdxIO/1y53IhFU5aIe6f1X+1Na9eU9CUXpkxGkNfgtM2mSfxWGz6xdSvIYhNjwmSA3u8+qLFKOa/exXnM+6ZyDaOAzVIX2WJ7vUJaiLtx1WC9Kse2KMf9HOCDpZywaE9t2+uw1UNyYROAWge4+Z/Zv3axvQiZco2xIbU67Da+sDnaKY2iZHb6awTcN1FB7+zMrrkIOmLXFelHXAqzE4f1l+z1dGMVu8Bd0Kz3teMI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU4H4a2TXrrqo6pnsifNWSnLe++V93v70E4WeDYFHwU=;
 b=gPm+60iHWOEBeig1wQycaqziORaeBTPCnUeo6UizjojLntNc2Cf3BU9tGG8hfzpuVudVWQ3fjgJEDxGegVxi/DgStOejtcZImtHSbPdLJXi01b95LfmfyHmfgVBmSt4LBmHUXCQWRhtEqJ9VsuhQml7syIk6e/OpXowBpRA1ikedp5/ApMWZCt44sgG4JgJVfU6klbgNJz16x7PEuWE2E7AURol6M57t5YIR0wz9eHENmutPDXJJv9yG5KWTklm1AHFoxekWQ0HWQcw3CFty4LgkPykbgt9ucotdnsGwoAohGKM3AbIQOGjsvbjVeGb6Vy92i2Vow0XSoPEuTdIrFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU4H4a2TXrrqo6pnsifNWSnLe++V93v70E4WeDYFHwU=;
 b=STwHVQrJ4l15ZoAoiC7EbqyBSv+sc77pFx7DldgtiW0Y75OUv/dZRzVBcYFO5jTrZ8n0SraGle1nYlbJU1WYJXgyfSCDfSeb6gy0/0iEpZzvlMQwDdKvoqiPU1vFCpG4YrWz224LOkj7KI1MrUpRZBQkFie8eWJH05Q3o8A1XXtD0SEA64KNbyuI7Lk86jkFAy0we50c0DrtQ6IXZ6v4XeBhV3DHaq+Sg9YsGS8YlegUDbFX8f0sqWZEwDo6iMNwOOeDrGgJlVX54q0l5fpMK1k0e3lsAlZbSKAZYa0jWfQxgsdecNPw/3WSOjj7CECxMLvSnYvIS15SfNLsnhZeOg==
Received: from PH5P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::12)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Wed, 22 Oct 2025 12:30:38 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::9c) by PH5P220CA0007.outlook.office365.com
 (2603:10b6:510:34a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Wed,
 22 Oct 2025 12:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 12:30:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 22 Oct
 2025 05:30:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 05:30:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Oct 2025 05:30:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 0/4] mlx5 misc fixes 2025-10-22
Date: Wed, 22 Oct 2025 15:29:38 +0300
Message-ID: <1761136182-918470-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf16803-9f5d-44aa-1c5f-08de1166ce1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ix/hcZNl17hZRfhRfJayh7JtPKFUt7KLnJMmdp55OxRXpOBHwezOWkdnzAR?=
 =?us-ascii?Q?UT4gLvk38ogd9Wd1Rx73DqlmEvQrLWAMPVinaPnpofvhF00kF2bGunUCIulT?=
 =?us-ascii?Q?rEWFCO5LmZ0bUn6ig3K5ZZCvMrn5ni87D0neueW/uOQximLxutvWA07/0/yb?=
 =?us-ascii?Q?x5AnSOjtu3VsV2cPyihwpQ0gccm6U4A9OuGNmwYuqTBw2lV/Mtgc0DZI+2F0?=
 =?us-ascii?Q?BPfO322X1PgXO0J/Ue560W7B9QouKrCDeKTVr+Zp1yAKlu7IaLxaeuhBNcow?=
 =?us-ascii?Q?U1s3daaGP+1AXJcIIWccpJ+7UMvXw3jyaeX6s+c/bF0Qwvpbk3gk78rjlZj3?=
 =?us-ascii?Q?cncVLUIg2Yxx8JBZlc3YBkMj8Pe/Qhhj12SjrQ0+RQxBpLD/lek8qwihuuZq?=
 =?us-ascii?Q?o7zJnhFtgnkHB/hpbrQI1n8An0h4AdKgD8MJprO2dH7BcA0Df/uViLy/UJJT?=
 =?us-ascii?Q?OtSmOXxQtKLBBaCuvce5oeLXCiP6VuvVBAGhepCoE+LgEwI7d7BzgbBejZAu?=
 =?us-ascii?Q?X2erUs9/KjKWGJWGiRdp99YIpPFQfPvgUs4HtkrMxJFeYGJ5+9yOdQFnMTk0?=
 =?us-ascii?Q?bexXH1ueynMnhlSOonPzQiiw07ftvZkdp6Lek8G2shAITnwwtVX3QobMZAEH?=
 =?us-ascii?Q?hqijXZvqaXvqakMbmc1cMChA1NgKQefbSr6xAo6IE42bMJPE9RXnesbXbdmK?=
 =?us-ascii?Q?bnAw2ZN+EQxD4tK1zvJlnxYUWURJxXa6zmVAL25VbnvAiLlhpqPkCR/0/lkn?=
 =?us-ascii?Q?CznoP9T114bZ8Qr9i7v3BQtjGioHr2QuzOiEceud/Bguob07oC5wimbASs1M?=
 =?us-ascii?Q?Ob4k/Jsz9EFba09vM1QS61R0cSw+3WOht6aSz4nepBZm6S2RgjP/IU3mpAfb?=
 =?us-ascii?Q?hkJCchbgjoHVXeYDp8MJAfieuc8Pe9/OIXliarFbKr46Lf2r70/5PhXZ2Wk5?=
 =?us-ascii?Q?484HtTSpGNNrdzx6mgU547i7WcM3lvZYBpDvGnK8Ib5f7m8zEx2TFoBQktEK?=
 =?us-ascii?Q?mwkkYJ7OXQap/Kq3iSch3w8TvdNfHHXb/mnqdkRydw9jPjJ3tiuemWk+rBHs?=
 =?us-ascii?Q?DTMfuHR146fgruA3O0FJR3ukS8eBG7TfE7J/H7/kwl4W/QEbTxxRNxkFVks7?=
 =?us-ascii?Q?fYxxfJKj7/L2JnDPGWcucqn0WKq5EOHCasQl18epJANrdoTwR181o6YUUwY+?=
 =?us-ascii?Q?EEh8Kg09mObksirtP2KKNOp4vPxQtnM8vwXzSUkZogwwF5mCERNlx3yW1WEW?=
 =?us-ascii?Q?QZjnlfBadLDJ8WC6tGTazfNh7zCT5wVseTk+87UWtWgfMxZ7co2K613i+yjR?=
 =?us-ascii?Q?FpsSJ3VT7GsjVBMfKrmgcyqY+LqJWfjeFmUz5MNmUwtjl+vecMyBT++aaXOl?=
 =?us-ascii?Q?2WuAiuvmEo9NETEbZj333wGoj7xLIG7lTBNKCIAQjBCbfJGNGvbBMsfiU4dF?=
 =?us-ascii?Q?vq5dNUTl4m6Yc+GlWEej2LOUjEScRPeVu1U/p40U+dlBv1WKiX29K60OjxY4?=
 =?us-ascii?Q?X9MaIp1eOop9/TBGcfjzbBPdixodeSgeRZpJDm6uYS+ZjkUsdYg88IQ3cafh?=
 =?us-ascii?Q?Z02coPkf8y5DmqOrn3I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 12:30:37.4177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf16803-9f5d-44aa-1c5f-08de1166ce1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Thanks,
Tariq.


Alexei Lazar (2):
  net/mlx5: Add PPHCR to PCAM supported registers mask
  net/mlx5e: Skip PPHCR register query if not supported by the device

Patrisious Haddad (2):
  net/mlx5: Refactor devcom to return NULL on failure
  net/mlx5: Fix IPsec cleanup over MPV device

 .../mellanox/mlx5/core/en_accel/ipsec.h       |  5 ++
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 25 ++++++++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  8 +--
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  4 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  4 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  7 ++-
 .../ethernet/mellanox/mlx5/core/lib/clock.c   |  2 +-
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  | 53 +++++++++----------
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  4 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  5 +-
 include/linux/mlx5/mlx5_ifc.h                 |  4 +-
 11 files changed, 75 insertions(+), 46 deletions(-)


base-commit: d63f0391d6c7b75e1a847e1a26349fa8cad0004d
-- 
2.31.1


