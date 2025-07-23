Return-Path: <linux-rdma+bounces-12415-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3344CB0EC31
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 09:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D1E173E7B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 07:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB6274B33;
	Wed, 23 Jul 2025 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iLVAPEwP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E25248867;
	Wed, 23 Jul 2025 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256735; cv=fail; b=cdHbRyRzxdGMJYLtSaM9AomJj9QdcYFKBmrHSNGIDvdnV+wrUVtcnOyTybXnAOo7qfgjYwjqrkawDEavYb/frgOwVKuXCY4IxsJ3J7Scsc/AVyWssEnI/WdS/lcirSdywJ828r7r+PVNAZZaU6uJhtDJyXNh8mvoOziIMfc8puk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256735; c=relaxed/simple;
	bh=rRqqB/rTOz07bgoxPQrsfjDtFqJdsbHBWjGs33nSoL0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PXF/jWlyjiWbIO/BFK71KJSchiWwlTcsP5pbYd0KRHxeNrxeoVSYcmqBCIKoRedgtV0p1wLSq0GM91ddjZ0eviZYUApj6VRVjZXWyYNqLm70wjaMHYGyFxSfgIy5RDey08UYeci5DTAdisOQPsN1ghBMrgM4Jg8o86Gz1UMpEsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iLVAPEwP; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UL7/cKtHuvuFgsQrTrTTm3ig41n2nbZxR9DVxdE5cEdZ0Bpqz/XAQ/5TzvsnDqRQI0I8AZFlgbt2pjZmdSfzuNgfBKYzZMVlktZe6cSAZbipZ1WPyzRvTVcgH5Lq/MFVszRX+mJAbnRfq4vcxQRyOtpMAMq71gZp6XvZFvMvNm+npMDLS7xsYfwF8f0P8W7qY84nXYCO6Y7/88OqnnM/7B9vPX9Y34ZWimyjOhGA4Wyn+H3yL7MTDlCd7rsgEGpsP69aqoMmETKR/AIGl9GEpfT9NSnRWzJV3x/8CXX9OhtuapeY1YTUWWjPcCNNDwV8I8v1aDsBIzHcKzEtJYsUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dt5UYG52KkEbw/2CCP0leVsyGA1J4taVJc20p3yCcDU=;
 b=gEEwanIbgiSlzA908y9W7MMlqM+Yyp26Ps3RLPrYSRH4zGlRrA5BZ8wg1JQAzuew7N9YcGH2APnpy1FVX4nRE/wtW/zC6eFzxxmtSvn+an/oaKeg4dn3c/2UF1oLNXU+lD+ycaFKHDdILbmGggXZDkB8ZQIOdR6mPbrYQaqbgylCT2t4nIPGHHrlg0yUPkYxH2SpOImEPOJ7jyZ5QNuCKe7MH9fdvW9oTNXVSHV/WAsubfNN68xGLwhQfNTmgb1Nh4Ys1jgYqDTxSSNwD0ozZmJtoFvDkP+pMc7tUqAJRtNdGVP39PgXagK3QiVhJPfBnDb2IiRK/Qc4kp3LJM1DXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt5UYG52KkEbw/2CCP0leVsyGA1J4taVJc20p3yCcDU=;
 b=iLVAPEwPEBWs0PEpIoWL6Rb8F9CQBD/jghxhIM6DpYoIkN2SWo0I6hhK2dSfZl/k5ApZ2W+9txH09cqMLc8ePcja3skzBk5X5u+TunWu5OEtsO0jolcJxgRds4x1BopLEqrgmFQv8fsETNcPBVcLr+l8Y0SyKdgTHQ51gbM7Xd6VmuumIic3+l9JXlTGJhAPsL8AYNsBWCIrVWppB3DH75qIChtkbDzYKmHe0fkrHGUZ2s7cHGcxLP2z3BM8nLECSeiyH07s2NSeyxcdiLnddar9Hvij/Uq5UHuRLhgJfFaTqX66Gvd51uVyqKtv9+sKJ2QzFoMq+CZH0Zf4xLeShg==
Received: from SJ0PR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:33f::34)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 07:45:29 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::c2) by SJ0PR05CA0059.outlook.office365.com
 (2603:10b6:a03:33f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 07:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 07:45:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Jul
 2025 00:45:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Jul
 2025 00:45:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 23
 Jul 2025 00:45:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 0/3] mlx5e misc fixes 2025-07-23
Date: Wed, 23 Jul 2025 10:44:29 +0300
Message-ID: <1753256672-337784-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: afc228c5-9d5a-4442-028d-08ddc9bce525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T10s3LrEKl/ue7ufN+I58r1phxDeU9OXOaipL9xXBS05yGnoIGJbwU07cdL2?=
 =?us-ascii?Q?Q+HhTJu8HDuXnobPvat59ttUDAD49lsJ/q9y9eyz2Mjo13Z2+bN84Gz41Nhd?=
 =?us-ascii?Q?Y4A3r9Vp5HvLdRaYgAglXBShUHMxX6aIxTdgWHKOe0TghI72hkGETeiw3WhJ?=
 =?us-ascii?Q?OIYHecdgcRmtNO0hECU2nsjk9lr+s4X+MVC4kvsDk353YAHilyolwoXyhuxf?=
 =?us-ascii?Q?mhzgCyl9qr9zQJG62aaTBYHlvXr/1GPnezOfvo0SGNo3/ChguglDVKEjm1Fn?=
 =?us-ascii?Q?+QQZp2RpK0F/F5Sy8qxa3EryXmCO9XzWSmyfZvkVUqAWpOS2fa6cp6TlFHlq?=
 =?us-ascii?Q?I5yBzrtBpRyY3nctFw7Vfa5mFSts5rw6a3FrxEBRxSY2Jt0H4C0w65s808vg?=
 =?us-ascii?Q?85UbZf3MNfnJGrslHlghU1fWoRYvaBeRqwj4pJgJfwCUmTEElOO4rejzRKLs?=
 =?us-ascii?Q?91dTK5IySx22UDiQTDpUdPMNOBGpHVCQz4NWMqdJNfB+Ab507X+nMtNW8v3R?=
 =?us-ascii?Q?g9obXlabSIMpfcnNpm/Ymi2dtE0sM22xdZUrS8qksPwDVDKz5xeMfM3/FsR+?=
 =?us-ascii?Q?aw3L6RW0OPJfoQ13ovljD0y5Bw7hhgtslHUzCFwHe6SRILQWwxGNblsbFvh1?=
 =?us-ascii?Q?oeEdl486oLdsiqy+6DP1TMZbYSPQl0qxMV7HL9L17nPinxCFD1qOAjjAsImK?=
 =?us-ascii?Q?9MCHUA046eOuffYwrM+fE9xv03OYGzMGPloHU0QPUDTEL+FR4WZ5jhI/tJFk?=
 =?us-ascii?Q?qUJCMXPMpQ7hoNw7uQUCLU1euInhpoXFZqFisrN09cHx3A/Tx70b32SOGuqx?=
 =?us-ascii?Q?Hz7+biuOJLUk5YxK0YFMVVSae7PABdelJXtKtauycRsEkZgbH9etQVYD7zuy?=
 =?us-ascii?Q?UzpJ6wMN5y8Yq1FGbYLli8m1xUT8Xx+eUsV+9ylbL0xzPL7xqoEpti8mbxuD?=
 =?us-ascii?Q?mZx7O+FUI9EtqIBXXWkcaAcMSoniW9GUBiauQw6rUU9Qo77zUXcTtaGkyoCK?=
 =?us-ascii?Q?Nqbz2zTvkPrWE08gu1pWefJ2FYw6+WzcSzXn5vY1u/30btnZvGCSfXLZoQBZ?=
 =?us-ascii?Q?nYL+qGeYB2XnhHvuMuFhMHmf90jJlYp7pbKGj1bKiGu8e0C9bCfberZUb6Jd?=
 =?us-ascii?Q?1tqTgjcTLRGdHqiiUhJCBDn86yYGUhS09A9Y3sqU1hYlm9wyM1rF4dEJXCbL?=
 =?us-ascii?Q?pKzDmNtJqFIvzmaXHRNfErMisUz8UZ466CAT8lNXIzj3AgI1uRQiBbrvt0i8?=
 =?us-ascii?Q?t708LmDPrDRd4G+BKsrdF28nSg5iw+MYTQflqhbugeTtU3nooAdl4gpf+Yrw?=
 =?us-ascii?Q?wsshQ8aAGPBps6mt01FaZYNehOFyM4qh7oYC9YtfspqCNpgenbKvT2G1NsRO?=
 =?us-ascii?Q?oOGhWHZXvt1z7cwXxFCWLoHSFWtr3CvUV3Bo7GJgB6a9Z9NvAjkfZ8+mBjJF?=
 =?us-ascii?Q?IyS6LxZKSfRXlDEwNemWkgVQIxnCYe/DlKT+N+rDXL+VTq40zXwFT3bunr+d?=
 =?us-ascii?Q?tFyKkRgLlhSzKHhdi+NyxD5PAHqTG4oFkK/i?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 07:45:29.0540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc228c5-9d5a-4442-028d-08ddc9bce525
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

Hi,

This small patchset provides misc bug fixes from the team to the mlx5e
driver.

Thanks,
Tariq.


Alexei Lazar (1):
  net/mlx5e: Clear Read-Only port buffer size in PBMC before update

Jianbo Liu (1):
  net/mlx5e: Remove skb secpath if xfrm state is not found

Shahar Shitrit (1):
  net/mlx5e: Fix potential deadlock by deferring RX timeout recovery

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../mellanox/mlx5/core/en/port_buffer.c       |  3 +++
 .../mellanox/mlx5/core/en/reporter_rx.c       |  7 +++++
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c  |  4 +++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 26 ++++++++++++++++++-
 5 files changed, 40 insertions(+), 1 deletion(-)


base-commit: 67e9d0b40bd7990d6eab63b5afedea3c17578993
-- 
2.31.1


