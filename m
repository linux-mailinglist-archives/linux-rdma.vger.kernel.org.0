Return-Path: <linux-rdma+bounces-13710-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C896EBA783D
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 23:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E78C166657
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 21:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4336729C343;
	Sun, 28 Sep 2025 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mVPpsB5v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD84226CF7;
	Sun, 28 Sep 2025 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759094026; cv=fail; b=C0NMWauyxSy0udKw/DdNtIgeDnGuhVft0qk8epYqyiBfP6QsU6gVMmFRQJy4NtJYsriHbcAMK+MmmL1h7W0Wu1kcpbtGqUEfmLSDmezFdFRLMnFlCoawXlRW6q5OlBTf5IUhdZ2a4mbcOr05+hZeEe3V6zR5uWP36qB4B6yLfQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759094026; c=relaxed/simple;
	bh=NdTm5X+9qWseldskne2Fe9VFU6pXcm+jd6uGYPu89BM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2Af5QGx8/nKPsy2nfa7Ruit42GD9Nguou4p5DxezAGxrzco6LXkchXindiLkxRdm+aJoKeMOyxBGQHXusPFb8Un4OZzccfnB3HIuiZIqqJ4FiUi01XvGf2UuhzOFgZ/WBK3xds/5V2JcgjDr6WZIcRXYTdh8SlOs39NrAo5I7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mVPpsB5v; arc=fail smtp.client-ip=40.93.194.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaiubXU/akpjP42RnyyhAIIne3ulSv90SFieSMdzoaYBVT1/urWoXTnPw2x/AQ0ebs8Qw6P0gSLzQJJxj9p+Mwi5umG3hAI/aB5tDR4cEFzUE91HSuZs4wmTHOqogbhHm1q10LYtYnDVk0IJ2E/PydLRCABauhb9EVglw2YEm5JDIL9Hl2mkRmRa0fjAYdcprpBoSUa2ZHg9JBntenp2kPT3fUUywEiEfq8DYFO/oKZnotX0GWUrMNnhxLkrC4oRtxNgsMiPoLPXkYUdcu2hdlpHOEuZCftb8pZkVYPjsi4kehIt4vij7XJkhE1+lw0Qg0NgaAvHkb2bD3p1IbmNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7fdw1+pX5JhWdSGhNUAe2Me3NAid5bDVvXumbba9u0=;
 b=GuL9mGUMB/Oxt4kxwZisL1xN10K+OYKXr79lcd4arQW68NDMq/KHB1MKLY2QNIlCzUctHBh2p/nRzRr9HpnIujGWLMRH1T3Hea5sFVNEOkiiXkHuAUSURcqoZiyn1gbmT+U189hyEAOXlWY+v/x7lPRJg5a+yabSJOL2UjlOM2K9uZYotb3uXerpgnvg58TyClSnGSte5ewW5UGhJvuehVwtFCXZkzTgs1p6ojqLgVAUoCgmK4BNXA6izxnR+ttzSyjc1mxjH4AdVud5Ua5D1JjrP678+RxAKxa2unafP74ef9PwzK12QHVGsPX9oWYZ2Rce/BZZw/rklFCnfqmhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7fdw1+pX5JhWdSGhNUAe2Me3NAid5bDVvXumbba9u0=;
 b=mVPpsB5vXdJRm6plgNS+pUwhEZY41ZWyJG62/YzjmPUktMbiusOgNF6+Di1iTwSRDkG1WVVCDquvWkL5NzE4bVkUlBDJkmkL1D8b129t1c6wB6LQ+M91a3kdRuuEwT4Ns9+1+O9VU1J+NL/aytYr4AjJqhMBfS6Qrrl7MIwFy05+WzPVTqIThD8gPGbNFGM5SIdUWT4G3CQO+fidJ5+Ymv0PfZCHG0EAfWstPkX9uQuLjUnUxd31O9cpHURHwSwhjUMTiKa17KA3P4Ivh1MD9iV0JUn4CkoMyfEa8h+ucdIV30ENLfWujlH4Sn/H8cJ7euGe0zBk0Dx7UlQBAuZ+EA==
Received: from DM6PR14CA0053.namprd14.prod.outlook.com (2603:10b6:5:18f::30)
 by BN7PPFEE0F400A9.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Sun, 28 Sep
 2025 21:13:41 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::48) by DM6PR14CA0053.outlook.office365.com
 (2603:10b6:5:18f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Sun,
 28 Sep 2025 21:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 21:13:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sun, 28 Sep
 2025 14:13:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 14:13:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 28
 Sep 2025 14:13:24 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, "Gal
 Pressman" <gal@nvidia.com>
Subject: [pull-request] mlx5-next updates 2025-09-28
Date: Mon, 29 Sep 2025 00:13:09 +0300
Message-ID: <1759093989-841873-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|BN7PPFEE0F400A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 131a3b5e-0556-49fa-3df8-08ddfed3e67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k1MhRU3RZs276SmQR13TASkeNuyVM/kqONq9VVt/f+A6ctWRHKoIV2bCIiab?=
 =?us-ascii?Q?mD79k9sf9w40C0vX5t+plnmw/LEnwiFDE0STOrrzYwh8EywrHxTLhGxC4QFN?=
 =?us-ascii?Q?i5zagiYIntNlIwyzB7wa8x/WG2SQ9Ob2htbLj0biVHKzHW5YJF5/NV+t4tP+?=
 =?us-ascii?Q?oVdbjT1IMjyo0DMgl/nB6s9EwLBEvEacT1GqwyCtP98c8Cb1o252R8oNy7Hx?=
 =?us-ascii?Q?VRfp9ASOnWf0HUDKnOcJ04US/hwOdK+o69B9HcjhCZM/bPkk6vylRm7qBGF4?=
 =?us-ascii?Q?/7WLhg7YQ3kid+WdkK3HMscELtTjD7CR40ZHA0Hw+REIBDRAcxlIeyxWw3Hc?=
 =?us-ascii?Q?I7cfqucETKGr12DNboCKTNIfpygUlffvFkfBQfSUIzvaicNUdwcVv4SWdTDM?=
 =?us-ascii?Q?MuQ3ZXOgxa+bUQNP85Ez0bKABW/BYe7E2k0lBLxb5shbvQRvFgUgC9CuZk8B?=
 =?us-ascii?Q?Y2JYhpAyfnL14Lpt5g5LuJmPooA+wIwc4V62UoKgawIyExxOXVv+FP+sC4xs?=
 =?us-ascii?Q?p1hVv9FhEJHsdmdXtYWx87xEaQz8FRHs3ANZjvYCI8dd2mk/ua8hmr60QAb6?=
 =?us-ascii?Q?mmxT4a5LByQnJBOqUsgTwsp+U4weVwQMBzftD0BrdTJOxSLSvVHN7G1GW4X7?=
 =?us-ascii?Q?QHT8E4/7qKtir+QTWvJ4Sem06SZz4sZF+a3E8Kp5uo3ElETN1XQHjFHvRmki?=
 =?us-ascii?Q?y83yvubk5M3ERdEHJy82eCMlM+E8jeOYMrHeOX+yPkZQWCbMd6IGVZZrBaYh?=
 =?us-ascii?Q?CounZ1iJLwsbCyasAr24qc+zjsnxXxXWPXwM3ECuUvhToHXzVs71hQPER9m0?=
 =?us-ascii?Q?xUktYoC7ofgWTtsxG5WvzJl0pECfks/xWqLsQmIQ3VTq+Y7AzHBPg4dZ5gNg?=
 =?us-ascii?Q?Fkxwon1zXL850upNtPrT7GcC4Uj56UB3ux+yIrTpgN42HzJsH++yPyyYBzpU?=
 =?us-ascii?Q?5GymDWt1i7GEFp3m2GOyiPTbEtwkFuyv1y0dln4ZObiKGzVvUbisqoZ1b0q2?=
 =?us-ascii?Q?NDR6nnndDI+YfN0aGyQfSCLwN6if8rSAi1erM8sb8Grbr+S4xbImT9Tw8HQX?=
 =?us-ascii?Q?kCmWTWa/mrdVv9dNOh3i+n1uoT78QsiUAFRauQMTiM0OBuQ4h019c+hKH/Qn?=
 =?us-ascii?Q?dUOtCwR8nQwZHloA6D1C/6i/3akdSCZCBMJ/Y+pWMMauY8RVuRBdQp1wPf1j?=
 =?us-ascii?Q?cMe55rHJhH0fuOOBacvYvTfvpizyw1rSWY4v2UoVw4I9aTe+jOcgyuMaY7bW?=
 =?us-ascii?Q?E6CkTJxEwf3l2lSLpEkZzRu56nfwAPEbBq53H+zxizmbFibdvNbQjwn+29Lm?=
 =?us-ascii?Q?zpWEoc5oNlD6p/iyjlT+99nZiQx+3vlP4emysyTX+pq2s1veyZsTdk3egIA4?=
 =?us-ascii?Q?krkQyULhVAB7QVnCBQkVVXrBH5kykynVcYVeNMPaQZ31IVVH2nRNQf5HyaXB?=
 =?us-ascii?Q?ln5Q9fw7PfWkIriv1a5b2hcz1aMGIlttjmfIIhHGYTmSsj1lY4yfhmaqDH2Q?=
 =?us-ascii?Q?myzJ8ks9lIueKw6Gf27cBykNkSzE5NIrFHJv/ktdPZ5pKnTWXlVHZ3sBzPFk?=
 =?us-ascii?Q?jGmynuxcDXeqXy3rp9k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 21:13:41.3748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131a3b5e-0556-49fa-3df8-08ddfed3e67d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE0F400A9

Hi,

The following pull-request contains common mlx5 updates
for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------

The following changes since commit a3d076b0567e729d5f21a95525c4d096b1f59e79:

  net/mlx5: Add uar access and odp page fault counters (2025-09-18 05:32:22 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git tags/mlx5-next-lag

for you to fetch changes up to 137d1a6355131457723b51a34192320d93d15654:

  net/mlx5: IFC add balance ID and LAG per MP group bits (2025-09-28 03:36:36 -0400)

----------------------------------------------------------------
Mark Bloch (1):
      net/mlx5: IFC add balance ID and LAG per MP group bits

Tariq Toukan (1):
      net/mlx5: Add IFC bit for TIR/SQ order capability

 include/linux/mlx5/mlx5_ifc.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

