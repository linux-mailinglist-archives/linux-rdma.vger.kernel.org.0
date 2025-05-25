Return-Path: <linux-rdma+bounces-10688-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D51AC3439
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 13:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3500518941A9
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEF01EF387;
	Sun, 25 May 2025 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qe1Rsyjl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1C1E50E;
	Sun, 25 May 2025 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748173703; cv=fail; b=L1skhhwfxz52rkRp8ogiJQjaPejBYjAw/1ZNyb9xZ6EAOuG66LpqDcEiSuv/6pnxH7HFDkLlTGH7SXtkkqxMRq7/Seq2NkKMvYyJzkUXvvwC3g/lKOuS21+whOuMqwwtsj9nr9MQ6xUQTmhH3Pi/0wDtJWvVpMdPQOSy4tusWoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748173703; c=relaxed/simple;
	bh=gLPYbRjJ91ycOC/D/RKwYAOdrH/0y5bgRUNabHeLcfw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dAzafxTCgXImTse9/ejq3uEO5gsG/BsvbPRrmaT6QzLgz9dB+kvO3PTSl/OffZsdzBfSpR/aivxIhwvqnjn07UFQMcKbkbrmE7wsVkox5Z8bwsnOsD3IYxKeeI5kfKxzVyCn6ycpQ/gwNAg+uQtaN7AW54RrqtyJToy1Qivd3sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qe1Rsyjl; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbFidzwOcp886rmAuooEDD4IVftH835GBsy2UZyuYTYHYkw86CJ9S/7EEB2XEW7686HDr3aVQ7r81rZWsCiN7QJ/bhtakyizTXWLwlS0nl+92PLc0MJN1yA9S1rgdUiwe4bz4eVn3XvgzkjO0+mo1aHFci1KhaAOgtbz+fNOJsongj/zqvk4r1Cy6folgZS15kS8DT5okvUCq0BzGMwBaafFnwgairhwhkP4dFP3w2lRdVFBn6yXnyeW/bB8VPusHVELPppoeLpgYRFaEC53y4kKFPjzVi0HtwcLHE98gU6NSLQXIYirInFh4oKS91+D0Lp19h69b8UFCHoUvYwDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcfhkRqECYTzI+6yIMuzvcEdh7ES7xm6gvHJLdHOVZ0=;
 b=GkKAw9hKkW4+gp0Hzxlq91NY7qWcFs0F7jR7UC6sHQVB8G2ojzu5Eens1j1ydj+wsWZci3va4xnE/XwaV35DhQl51DG69JRzmE09cx5E6jNVNvyGJau/7Z+ugRAdk57s/051LeYTMO/94P2FyH70VYjs5ON/B5OLD8sYOYxGY0qMsmEMtRnjcgWkAPMfFNHhMAm9HLi9KtheQN8BRu/y9twGpLru5Dv2JdpDG3lg/lsZIy+KEFtj2T/qtatznS4REekhmNmtv3JtiW3xem6Ldj0DvE0dfD/XYAgwaUVHT7S0bCzjeV3VKK33OEdb9RCD6gi6ibqFux/3OHvW1WygIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcfhkRqECYTzI+6yIMuzvcEdh7ES7xm6gvHJLdHOVZ0=;
 b=Qe1Rsyjl5lTaUABBltGKHvnf0ztLGYOYspBjuQ2Y/TkdLqabYWnGGAf1SmuqqV/quN95QZd79oed8J/PZV1ATk8dly2jieMuxUy1+BbdHmiL0jrbZE935vS8ljpkFfSA5Or0unxVlprIHzDXaqUkKlHnOS3YcRuh7UDyi34GtNJcSadc8c/vP0eosqXggm+8ux/YN5WAAvqKKtdXrB9Ly5N+UVf1u0LMuhrks6Q5YIYmQV+bSFTdZB6E6W0S6+aPPiaO1baOjO/+ML3YSA1RI+9kQHF7q4EpoIz6kunwSvJfyPu5O5rwXR/l3KpVIFLz48WAjwM06IhfPmrMv/6DLQ==
Received: from DM6PR02CA0089.namprd02.prod.outlook.com (2603:10b6:5:1f4::30)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Sun, 25 May
 2025 11:48:13 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::d3) by DM6PR02CA0089.outlook.office365.com
 (2603:10b6:5:1f4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Sun,
 25 May 2025 11:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 11:48:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 25 May
 2025 04:48:01 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 25 May
 2025 04:48:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 25
 May 2025 04:47:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 0/2] net/mlx5: misc changes 2025-05-25
Date: Sun, 25 May 2025 14:47:30 +0300
Message-ID: <1748173652-1377161-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SA1PR12MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f77943d-e6f1-4416-5c43-08dd9b820799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cho7xanldd26ZEFGRMFv5ZlaI4d65L25QvoD4dFMT3TgEsPk7Z+A3oCmcKfr?=
 =?us-ascii?Q?g5t1M9UTm+GHkj0yceky5z0GpOc6xkij1YcqWSXAoK9YgIgdh/G2DgKWgLgn?=
 =?us-ascii?Q?CGRihAxKyfZVzCc54H4HfvpTH+o/07ONhMnjKyuu9R62DtrSuA4NvMZeY5pd?=
 =?us-ascii?Q?ZoR97lqGR2gorTJLn21fo4Wbe4uVM9Q/i9AO4IteTY1g1YerRqM4pLwtRyzn?=
 =?us-ascii?Q?eecb7S3AMmQbiSdgHr7BaQN1Dg3D9O0NOOAnzDjnLoI1M3ekZO44AI6u9LzM?=
 =?us-ascii?Q?CjISormhVeEXeEJTULEFbmV2dMXZttSdDpV+TAc0EknvadFZQvHP0T1E3x1n?=
 =?us-ascii?Q?sai5dfdyuZp8qbIGDInndvBT/WLfRG05XcJ6MNLORMZt5pOFy4G8oAtHLP7W?=
 =?us-ascii?Q?VisYNwBTjsWpC93OlEZx8jx5UEGcw3sJ2pzNIDopabNm+437mUcSI9O4oWj2?=
 =?us-ascii?Q?lxZF+s+CmoANWHTGmjm9/zjQQHq/RI7qrAcRVNprBWcMAdRXeZKaZIiYqpgZ?=
 =?us-ascii?Q?uRMrYXN4ijTP8Hf/q2pNcTk/Lunm6poxNqJM8JvM8rO4jt8obie4eNn844Tp?=
 =?us-ascii?Q?QqBF5rEA0J2yqUK19gSCuUXGgj5aTHVCciL+qF9hH4aCCuZrkv9F3ykp/FSL?=
 =?us-ascii?Q?DnSQGNkuTYJDMkg3k5/0sqD8js+ZC0lSRK1DkKYFhrx/vVqhZ75YqYze6n3u?=
 =?us-ascii?Q?rqHQfaa2nI+pVjulxVAgUubqP0SjULNJUkzeDAg6Opm3QAKaT1v8PQ2IGl/I?=
 =?us-ascii?Q?d+U/hz+EtQOuRBFBhH9Th4ZMouNFBd4H6aM8C/bRbEehJISR3r3kHf2ZfCuI?=
 =?us-ascii?Q?j8TBJNGbJ9pU4wL5VvqDgudf+42YUF4wKUoIm1LzBhF1lWNX8ifFXgb2FZti?=
 =?us-ascii?Q?h7pZ2Kc+xzgGnPMvimEj2TiiUM4JCv7iKKnLjQRQkt2NPANDFD1jxPGbqPY5?=
 =?us-ascii?Q?QYUAQF+ajCguHpL+3o/f/Jm+EUT8ksOrjBh2xyvxNtFXgKCDaCZJnhfL2VYm?=
 =?us-ascii?Q?mYVhfLdoHEe9/GAh9DG9e72dvxQjNP2v88iULdSEBvdpPi6RpDH/VdbKQpDS?=
 =?us-ascii?Q?Sxhchus58fHv/u7gU5Q0+VwSSe9axco7/Z8ifK1P/8cEWEOVjQ74FtWQUfJD?=
 =?us-ascii?Q?3TiBPtuhIK0jvCso0XQATgng+khFvN7VCEZcki70Mejch4muRzm394SI6j02?=
 =?us-ascii?Q?ZGrNpb7zp91HJ9J88XbHpTQ86ZMo/FbT3mIPtm1KbytdBXHHUghhuypt8G4n?=
 =?us-ascii?Q?pZQZJdRJB+f4ypJX2pt+f4BzBbTTsYvi60EfuXm30NFHNla9NaFGRm6qMYmv?=
 =?us-ascii?Q?iUXXKdrv1qqc28Kas5AMv+Rb870sWuv0gHYEesT8qKr2uOZlDcXTOQa9okwz?=
 =?us-ascii?Q?Fmx6ByPNwfBtXv7HNs0qcXAzeMig4130NCC0awsFJVZQE5tHu4vdtDuTrTnR?=
 =?us-ascii?Q?adR+Vj2OcbzE2Wgw2oG2gdWuMPynrOvWE/De+r28DKBzGAkZZZBuQFXRAXMB?=
 =?us-ascii?Q?wEalR5FKQtDFYf6TVaLHSX7FDPLwZLD312Nn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 11:48:13.0474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f77943d-e6f1-4416-5c43-08dd9b820799
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776

Hi,

This small series contains misc enhancements to the mlx5 driver.

Regards,
Tariq

Maor Gottlieb (1):
  net/mlx5: Warn when write combining is not supported

Yael Chemla (1):
  net/mlx5e: Log error messages when extack is not present

 .../net/ethernet/mellanox/mlx5/core/devlink.c |  40 ++--
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en/htb.c  |  24 +--
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  |   8 +-
 .../mellanox/mlx5/core/en/rep/bridge.c        |   2 +-
 .../mellanox/mlx5/core/en/tc/act/csum.c       |   8 +-
 .../mellanox/mlx5/core/en/tc/act/goto.c       |  16 +-
 .../mellanox/mlx5/core/en/tc/act/mark.c       |   2 +-
 .../mellanox/mlx5/core/en/tc/act/mirred.c     |  28 +--
 .../mellanox/mlx5/core/en/tc/act/mirred_nic.c |   4 +-
 .../mellanox/mlx5/core/en/tc/act/mpls.c       |   6 +-
 .../mellanox/mlx5/core/en/tc/act/pedit.c      |   8 +-
 .../mellanox/mlx5/core/en/tc/act/police.c     |  14 +-
 .../mellanox/mlx5/core/en/tc/act/ptype.c      |   2 +-
 .../mlx5/core/en/tc/act/redirect_ingress.c    |  16 +-
 .../mellanox/mlx5/core/en/tc/act/tun.c        |   4 +-
 .../mellanox/mlx5/core/en/tc/act/vlan.c       |   6 +-
 .../mlx5/core/en/tc/act/vlan_mangle.c         |   4 +-
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    |  20 +-
 .../ethernet/mellanox/mlx5/core/en/tc_ct.h    |   4 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   |  12 +-
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |  14 +-
 .../mellanox/mlx5/core/en/tc_tun_geneve.c     |  34 ++--
 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |  20 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  82 ++++----
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  45 ++---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 188 +++++++++---------
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  |  28 +--
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |  24 +--
 .../mellanox/mlx5/core/eswitch_offloads.c     | 120 +++++------
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  16 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |  14 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |   8 +-
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |   2 +-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  14 ++
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |  25 ++-
 drivers/net/ethernet/mellanox/mlx5/core/wc.c  |   3 +
 38 files changed, 444 insertions(+), 428 deletions(-)


base-commit: 33e1b1b3991ba8c0d02b2324a582e084272205d6
-- 
2.31.1


