Return-Path: <linux-rdma+bounces-13221-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F86CB50E77
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 08:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375883BAA79
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AAF2D97BE;
	Wed, 10 Sep 2025 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DJzQvIj9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F7C1798F;
	Wed, 10 Sep 2025 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486912; cv=fail; b=AWrpgZsQrqhYJFpAGaAb/XkX+MFkK6mhuXS9LJhAIMqMufj7Hx2ZnKXtT/LIPyDNQ2WcrdEyKQ0gYnXaG8wLTDYn7+XrR07eRIwR6p9Ld+sxcpm/M/cXRgK5rN22IW3hE2uXdq12F1rCym0BxJBtDyH7oIqav1WLiEwQlBC14M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486912; c=relaxed/simple;
	bh=z5MO+W5F7wY7FVsU6Gtjb1NDMKeeilMD0AOC0FJstLQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OkrCtF7gUXIRO6L0hVwi1aQPYjYueNK+CzKdC0wn3Vv2Fi0QxL/OgHb2X/8zR0/xIEdpogT4X/0B/q5frvBUTJtptoqfjd6M+o80UwZmapUSaM95XlOqlLu0682x0zeGQhAbHAyUmpvrvqCHCIUEYOcP2/FOl5/cXvRJ6WXjc4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DJzQvIj9; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=is0L2Fb2Gp7RAWZ2PHaaZpJNHJyvieApe+I4fphbfyuhaM9IGwWVlkKquBg6lLxD6/FjS816Ghp53phn55JvmzUhGWoqjZqfODAcz5OM1mQ/29NavEf7vLWm70woyWaOrb6tv1X5Tem9hYjbqtDBSZLNrzlSUKOdKfgCYyn2idoNltweY9145ZZ8Hz9+IOmxGxFALdUFqi24FaOXVfpolISTcwF9U8qmzLAU9FGkRBzLDO1yCoZwZqXXbRMTJF4SIcOxoICehlLx6lJBR9L+7dQtmfmsGZXIkc7W7cmJzZukERZZbL08OnMU5pety9TqdIbWVpP0cbY4lEtXbh7VXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThAh43QtzvTHrgCCnb+fgBgZkB35SrajdKPZtZxN9Jo=;
 b=X0p+TyJzDKtuNZC1NK8KPcU4/G0Z+7JBGy2tHfzWeyFr1/bnQZyVaQQ/NCHgLyIITtiNdrlgYjzleV3AGJOQat1m0E9MPQMV9rjKs8AqEG2iwYhAXKDWz1TiwtzxRj1lbZKp5R06QbHIdaaCi71vhB+Nthu1bE5zWdHqDx3tPSPkgO+9w47GC12TbxTcO4fYCyE5DdT09jfuu59aw87tU6FZLNY/+DQw88GM1VBBV/0PAZQzpAGqmilIBWC0hVym+qb0XEcc4a6VApRAq0rzICTaJ4mFPqyRrumXmtzZ/aGiRbMpICGjFhXFA1/BBbWLNus3uozKN7hPq1hfZnsDaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThAh43QtzvTHrgCCnb+fgBgZkB35SrajdKPZtZxN9Jo=;
 b=DJzQvIj9A+BpTWVu+o8bqvRStMVkTr6HTlcneZpvRZg8yNovKtvhgbiXg7hTkBLxEndEv9rX7/i12i1/QlXrryILJA+cgVyvv2EN5z8DfaQEfunT6YBg8E870hVL2byqUKdGH1nWckNHB2SBiSbL4T3qPwVBnnwA+V03/IHMsZydXg2DGH1YtNRjgT3LuwD7UO87uNzIDfhXFZTjtJv8hFDt6VJ+vjQY3RbvU99CvOclaK3wRlgKprm//kfYCkJ4L35+F5OYZDuoYcyVKczz6xEHXuSwQZ98LQD6RQxlyiY2uEfIM32ddC+t/Nn7TqmmocRVg4iUr5UYTZqE2BMaMQ==
Received: from BLAPR03CA0113.namprd03.prod.outlook.com (2603:10b6:208:32a::28)
 by DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 06:48:26 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::43) by BLAPR03CA0113.outlook.office365.com
 (2603:10b6:208:32a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Wed,
 10 Sep 2025 06:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 06:48:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 23:48:08 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 23:48:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 9 Sep
 2025 23:48:04 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "John
 Fastabend" <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: [PATCH net 0/3] tls: Introduce and use RX async resync request cancel function
Date: Wed, 10 Sep 2025 09:47:38 +0300
Message-ID: <1757486861-542133-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 0654d790-60e4-4da5-01b4-08ddf0360b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QnVb5pGoXIowyCdRIpQJCzjjP2K/Y9i82rJjRLSNPYdhsKLC1WmoR1984lS7?=
 =?us-ascii?Q?8WO6GVNl4xHfBu8WUIzyjXOntgjZ46SiD2shf6uKWMtdgUwiVLpHt3Eeytxd?=
 =?us-ascii?Q?U/WG9qDIC4+eqeYIUcVrQTopGBSodO4CsvbNZOzk6XzckZRap44nL7hKePSC?=
 =?us-ascii?Q?gaUCRdpxTzz91bW3kfiCSqPrQMkDnVte5KtKLchojpIKpof1vGmyy+uBtRqh?=
 =?us-ascii?Q?EHN8tXfZhikSnrxlEjcdIRuP9p8GWop2aWwGZL3VZ24Jcx0doXEsJpYbOU8s?=
 =?us-ascii?Q?7w3hcV28whRjbtQSeFcavSjItgxs8HAFPGmmjTCFkoxHIqN4k2i2Opb0OW1f?=
 =?us-ascii?Q?DdGuQ72TAuzaw3WrHbC9KCI7ksUZ/3m2BERjWCk2MvI9HWm5a9+1d3v3Lmlp?=
 =?us-ascii?Q?7suqE7LGbnsrraPNsznDcUdfeInGtLXEohV5UCjvZ+dbjh6NbMWczMc4oPQ4?=
 =?us-ascii?Q?9L+u7p2XwILz+3VkC9chFT5beBE8Gfw7QLOLBvV3c0Xu5lr+NKEj6HIB6G5W?=
 =?us-ascii?Q?QCh7gR0lJKUtOC57MuiOMGqxqb+Ixx1a4+f3tFNQQULpdNBlsq4xq4YZqzCX?=
 =?us-ascii?Q?M3j64UdOisiOxmh0SeG2nlRQQcuuRaY7kLeld4qfICXBAZxSWrbX35NFYPok?=
 =?us-ascii?Q?1rptgOr4ejVlXd2u/WYMKkR6BAavtAouoHthgnX19Pax5Tqn8/tikttDmsQ9?=
 =?us-ascii?Q?vMJMEeChmkeQxVDmj0gBvqh5ogXNGgHLoXCb1I1h2krf7M6GCsv0u665uqR8?=
 =?us-ascii?Q?sqc4UZkz6p7nAZ+ToS2IBCd2wauNofsjBMGykO237KtzG7mtdTnrIR9dGuPi?=
 =?us-ascii?Q?YEgjwQu3R/KsXIQMbsaCPlOEajAow/pLChH0Kxk3rsiSF2Z4qTR/Cu6qeL+/?=
 =?us-ascii?Q?8b/PyFCFUR8mlkn3WhVtLTv+hHSgnWnc6/qHQ0mdyLDiC8FOSYgNuRB5yM1c?=
 =?us-ascii?Q?I+l1KtzneSw6swm1PHr9vvcOIkZRNZj4No5oKJuG9PsP3Bd1H0Y0yOe0i/It?=
 =?us-ascii?Q?9MSy1+/kAnAEiv/G4f6hwJgKZMdsNK/2YAgh3G+y3amohCn3m54LypLGBKkS?=
 =?us-ascii?Q?tp2xe/VFTNg4yfVy9DNAXt6GHnwDyFRxSzH+JhdqFgjfLXKK8l0fwcCtLD2R?=
 =?us-ascii?Q?WQYheMCBqy+Z97qFG/UntxUUh9vHclZrQ/rlaGHopyYox2leSEwUG0To84Cs?=
 =?us-ascii?Q?+Y1AsMaSTL4dsKraAk5DIsmH89b/QjY/2cyFCbyBcm1jrVvGyVLs7niUxKNI?=
 =?us-ascii?Q?0/1GVCsozgoT119q/TX01NMLNBnd4R6FGiyKZF5q94tRimP42Ck1NRW/SSFw?=
 =?us-ascii?Q?v/0FjT9IZsWANrezQOky9d0gwjhhKLgJoYqaWdchi7GUfVPWeyU8c4KpsSNX?=
 =?us-ascii?Q?n/KJpsSGAiEuvj7S2GxXCOYGkeQXPQXqkLxX/uTMG8BGd0CTu+tblNWPFbmQ?=
 =?us-ascii?Q?4MKEzJ64h7Y88uLYSP1gdNpxwmuvpVr5dwVVhGCilMolFJl2wJA9JjtNiADi?=
 =?us-ascii?Q?rStOU5TBXo0bxoktIPI+2Of5AOT8GJj390c+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 06:48:26.2291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0654d790-60e4-4da5-01b4-08ddf0360b41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745

Hi,

This series by Shahar introduces RX async resync request cancel function
in tls module, and uses it in mlx5e driver.

For a device-offloaded TLS RX connection, the TLS module increments
rcd_delta each time a new TLS record is received, tracking the distance
from the original resync request. In the meanwhile, the device is
queried and is expected to respond, asynchronously.

However, if the device response is delayed or fails (e.g due to unstable
connection and device getting out of tracking, hardware errors, resource
exhaustion etc.), the TLS module keeps logging and incrementing
rcd_delta, which can lead to a WARN() when rcd_delta exceeds the
threshold.

This series improves this code area by canceling the resync request when
spotting an issue with the device response.

Regards,
Tariq


Shahar Shitrit (3):
  net: tls: Introduce RX async resync request cancel function
  net: tls: Cancel RX async resync request on rdc_delta overflow
  net/mlx5e: kTLS, cancel RX async resync request in error flows

 .../mellanox/mlx5/core/en_accel/ktls_rx.c     | 29 +++++++++++++++++--
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |  4 +++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +++
 include/net/tls.h                             |  9 ++++++
 net/tls/tls_device.c                          |  5 +++-
 5 files changed, 47 insertions(+), 4 deletions(-)


base-commit: 78dd8ad62cad4f5af22afc842890d531312bbb8a
-- 
2.31.1


