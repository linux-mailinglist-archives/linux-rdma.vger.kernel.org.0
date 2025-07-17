Return-Path: <linux-rdma+bounces-12231-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94CB0855C
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 08:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77AF16FAC9
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 06:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EBA21772D;
	Thu, 17 Jul 2025 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QYEdiZs1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE717B425;
	Thu, 17 Jul 2025 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734948; cv=fail; b=gUPIVZb7HP0WE1if3+W5KP5TS1Q6Wb9OPIzLbfARYV6ekrazK+CHHW1jOYHJHlxB5KXTpVtR4zcpBRRc/TopG0owEKMxNGSL2VFUhytgq28afMOEgUIGYQdJTfi9k3IfZOqiTra5TA0fNDF0DWFMSXN4y1UoWkBZep+SyKQsB6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734948; c=relaxed/simple;
	bh=7+7ZYHpM3eDpUNG7j0M9E6wQrCw3QStS/SszMvOh3Rw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AqTUh3e31DxPIqMELmKTR+UqP+hi2lCx0fPuWMEF+i4+nIep63U4cn8Q9/5xyyI/EVoYxQSw1t+9lcS6jAgbUheabJiUyWW8rXMLPHLBejQkUgBKDrC08zcOjt9HGAGfP+byIIGkmqkrivdMRo4inM0pJHmahDUcpCvOKq0Wfvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QYEdiZs1; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsqS3Ptgh3/wtXv4AkX8HZiutUx1RInG9HYv3qU74crQqpwHaspY+QfhpM0S13WUn464Hgt5Mk9aTGSfhxlvsNUFg/Hdttn0qY/UqKWkTJ867nLfDOAAXk0fOXYF6yEKPMCxIMtsDbYMpEENicXjEOLm6dgP6K8bij5l3k21MKgjLQx4v2vqN+7kQf0jiZ9ACYen/AlESpBH+NzkcByz9G2wFL849tNUWApReipyBoyk2LyL3/+fpcNgc2+qUGVQPtJSuoS4xmRBKkXh08XEwBBdZXGQ/pObUn9JXvEQVQU5I6YQCFnIqmzmUrz6+qlo78HTPpvcrHpcD/yKBwvIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juQxD3G6CYOUToyQHQeTDqbR/JUZsHM0T3QEskU/jOA=;
 b=o8I5+TBaD/cQvTu0dqykBUxai6KNPIjHABr+EH7ym6Kc7Q6lA+eB3pA+9HgHrLD5IqiOiIZXjNiFM6+XWuvDfykEFLwC7tfLz4xDdTB3uJOTnzeJq+qGI8f3ZhPyoVEjO5QnOstdZqiyzodQXjAd8iEVyIabM+bn/Kuj4ScHlEGktOrdYoHzzxQgZZ5b5F8wtwzsvR01OylcBjiNclDDFJJpZpfpUprn04gT9NjloSmmmni07fCnuGgQImm4s3KD9KbW+XGU7jq72e4NDzrQP/foOmTQfDO/1QuzJ5yh4WOgSCMKqayg1y5XSh8ztCGFroAL8kzkPSX7pnO95B/Kiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juQxD3G6CYOUToyQHQeTDqbR/JUZsHM0T3QEskU/jOA=;
 b=QYEdiZs1Hzgv1mZPs4+qFCVQSxb1egqUIGneY5PcdGmZjhqFNW8tL+NXLNfsmhuxSk+a8hSpIbJN75hb9NXToYsRaLNY3o7TzRAse3Lp+hA4GU5oef0hRbBe55Bsf5AVAtaKTcsZFdxbG9ez5NwXWL0PSU1/GdDTTcws8shZqTGwPrGj8znZyQxGYlF+Ntc+AOLdNjssoydOHdJ1gyE6G2Cc+M8OHPoAwmQnDa9hbMXfcpgPPkM+5qZhsn91lrYqozvwtQhD6Xk8hX/kc99mk9+x/eEQzTUngD2sS+xJzTIn4WfL3j8jrj+exq5zGhjfbFFHVkrGRcqlx3qNQr6lTg==
Received: from MW4PR03CA0017.namprd03.prod.outlook.com (2603:10b6:303:8f::22)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Thu, 17 Jul
 2025 06:49:01 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::8c) by MW4PR03CA0017.outlook.office365.com
 (2603:10b6:303:8f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Thu,
 17 Jul 2025 06:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 06:49:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 23:48:41 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 23:48:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 16
 Jul 2025 23:48:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH mlx5-next 0/3] mlx5-next updates 2025-07-17
Date: Thu, 17 Jul 2025 09:48:12 +0300
Message-ID: <1752734895-257735-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 556207a8-0f32-4d48-8862-08ddc4fe02e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MtLWhc2CN/YYe7BHXEaN4IFW2f+oaMj+hRlJWGyCV04mrymZbFYL8e4b65c8?=
 =?us-ascii?Q?c+PPVoLCF4mHARufVn8O78FOQveG57hZWrFY+J3iwEGuUahpKwZMwqefRKR3?=
 =?us-ascii?Q?7Vb0EwIe22oHL1ncqzVNslVjKZOqfKjBm/UXYx+BjKpyn5cFACocOf9kJVtP?=
 =?us-ascii?Q?bogOHZjv3DPR/Et5oGxnuQpr4pl+2Ve5EoJeSGftMEVkfKH+KM9jAjeO8blU?=
 =?us-ascii?Q?BmXW5IZn0bo+GQ7gt441QdDISh2CILjgshBNW8LUtjZ6b4/hc46cmw28IezU?=
 =?us-ascii?Q?fzv4dkdC0ysgAt5oNyiybAUo860pQ43vSvZePzi7DYo5WdMm5cAOQguI449t?=
 =?us-ascii?Q?u0+jXyGtYczixCQt0Pe2O0lRfRlC7rVPa4bVYgCnbxXUonuYlFDMcxWvlz2A?=
 =?us-ascii?Q?gSrVPZ2SXIr037Uyigj7jKTqTl+RzX71RNZkXjAPhk3CLhNG/gjnf5ISHpeF?=
 =?us-ascii?Q?IdCiRnVCJYdJAzZ4qa4LAKS3s1KhB22nd8J6jNHIu5Ml7TZKxyEoiP6p8QeW?=
 =?us-ascii?Q?szv1G5ulQAQ7iC2CdicyLT29AWJDb0ha9MzF7BSkNNq/owDLjWELsb9Odlar?=
 =?us-ascii?Q?xXAtgj1khlkaJiLSSWF0+vRWbbnyJT3CAA/K1SS6hs5NCMHqXArJ/I+FL2iN?=
 =?us-ascii?Q?xaqM4aY2vOCNtVu3M7O31vtS0BEPlSStc/wfPx0qFBQvYSPWUPw2z32G562S?=
 =?us-ascii?Q?A89oPgNyNeWujtSaYsLVwLS9NLmiLFdGc3zFk13uTyMqhe+euvqG1JKtZ2db?=
 =?us-ascii?Q?08FnRl1t3KM7+LlWuYBwbiNaFNUl9dLzd+SPl82Prfl40l7YuR1Qq7A+uEbR?=
 =?us-ascii?Q?XPVllcNstHa8kcXbsS1kurGnI3PQBaMzXlO1Y2zEhXdJCtuqeIMB2DBPG7hH?=
 =?us-ascii?Q?WCbZSHU/WjvvT1CAx2vooieu314pByz0NkBeiCxmEqP0Arr/nbgpkc+WHOMJ?=
 =?us-ascii?Q?J59NNa1Iag8LLfYAMYhpajlW5375LyDO9EbMvSz/9Q2GtbZ3PKR9vfYq6o9I?=
 =?us-ascii?Q?y0SGZ0WTdjR3EcWfTOueSCr/1oawp6YuoFJXetOPRK4Oo67wCdbz71i75Crk?=
 =?us-ascii?Q?FXMtweOM0R14n2E+8bUafW7OxRtexmf6psxHFvE4hfluYqNcJzMHNSFb0BIc?=
 =?us-ascii?Q?1DnQJISexu9SJG7v6jo1Faf46XQGwnHJfBGA+uK1qzDVtmVoVjqk33PhE9Aj?=
 =?us-ascii?Q?TvBNiGWgAoeCN8TiF7ELEnscJTfIa4NRgzRiNiUrpnzvHXL/PUIRa/mEdv5Y?=
 =?us-ascii?Q?BMt9sO59R74QOjqgB/PdqSFo5ySGizeiXxptKPN7Ql1IsLaY35ak8gs5zPEr?=
 =?us-ascii?Q?qAsEb0Cz5dV7ZzDueSbf89SaW00Qh7RqMLmVsClxQ8luMMDdrzDIywG+xXAy?=
 =?us-ascii?Q?/yc8MH2kMV4n9lEc/ILWJ9lnVV2xwHJeUajb2njYhVOigGNbL/dQOD+qCX/1?=
 =?us-ascii?Q?pTv21n+37+GMTVGZKzWR3VHgN6KSHeYYAavMVbTP+Ks9lsdeqe5bA+lZNi9x?=
 =?us-ascii?Q?8rE0ztkQ1HbA+mZ7hPksfpVW7ocXEk/X1XG9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:49:00.4707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 556207a8-0f32-4d48-8862-08ddc4fe02e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548

Hi,

This series contains mlx5 shared updates as preparation for upcoming
features.

Regards,
Tariq


Jianbo Liu (1):
  net/mlx5: Add IFC bits to support RSS for IPSec offload

Oren Sidi (2):
  net/mlx5: Add IFC bits and enums for buf_ownership
  net/mlx5: Expose cable_length field in PFCC register

 .../mellanox/mlx5/core/steering/hws/definer.c | 13 +++--
 include/linux/mlx5/mlx5_ifc.h                 | 58 ++++++++++++++-----
 2 files changed, 53 insertions(+), 18 deletions(-)


base-commit: cd1746cb6555a2238c4aae9f9d60b637a61bf177
-- 
2.31.1


