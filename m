Return-Path: <linux-rdma+bounces-14089-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 233F1C1333C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 07:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B135C4E06F5
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 06:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E8B248886;
	Tue, 28 Oct 2025 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="giLYIv1T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F302611E;
	Tue, 28 Oct 2025 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634080; cv=fail; b=hMkFYU4sY1qMsMsBWaP5yQpNir91b9PFmz3qgCl6Bil77OQwxZGjUNVoNlOOvU0xyro6W1OckrizKo4bfA43j821PlumxM+yQtr+F0hJIpRz1iC4TJzQ0uK2e/EI+Uz/IINhtKZE1150cBn5K+Nlj3gVS5NQBVJi6vW/chIrgs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634080; c=relaxed/simple;
	bh=HEKs8nTUYSU0/uN1jzoDg2V+RMFr9rqJF38enc31AeQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KDVlgM4eX57lxxQDpC4qH5T70IJ6Murp3r4LkRW6etZgMV+DWofw7zOhUCoJYx62ffNcYyFPr5edzcXvvgJ1DbyiMKT9RzGgaJ9FSgnrxfWN5rNpJiKFMtN+pppFEAkngK1Tjg070QaAN7J7duwWzdPJjKjRDQQJVzuJadDfCOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=giLYIv1T; arc=fail smtp.client-ip=52.101.52.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVgAHvLcubFE/AtOfpeeK8iWZZ7+snl0ixPiwMCZbWTYdlLCci3cppQ0b8Ixq7ooBrlK7hAJFuUSLLZ7rPuu0KyUKmIODD65054J+e9fFbIoorPWrwkqOZR1RMdnJYRH1Ej9zDVN7/XW/t/5D19bdUCAJMU2VBJGiGAfipxRIjdJIdZbeMe97gF6yXTpwKa1B9N20EeSLM44bjhE6OV4eoRoR8ORSySgSckhpPD2wd1DOU4ngA6MszQByUeHWTrjQhXf7SNOBpmkvGBhn+8SpRD+Y7OsJ2QXc6KTK4yv8gc/Nduv2il9nSjSk9ComlMbh7DtgXirRfGySRikbx9E4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lH6eZ0jDqH7oC1udI5I/2rOPJbPuSBSuRHPlKO/XpFQ=;
 b=DhqLG/x+8e8ulJz20PKvKMWV1M9178srokoa8PfoOomGfOpQX7Df+7Qv2P5IppPrPn5oOj0UNQWj1kKLnLHaSKLXi6Q7GIhtE9cFopQ33EaFbxu/8/Y7ZkJX7jMj0ZHTLMlXwkNJ2vzMc7YbukEz39K908Y5eMgt9hmmvCBOxm/FvWTtKBH+wNLCe/FYMTRyDn5pjo0VaMfaSphaVH0rjtlmPOuqceOZ4wiW2Tnw5K3dvZF6r0vp0NtZ3qjW2lLSiz8RRQOoGCJP98O8Gcpx6+9WFI8bxGEB42zqYglLrDLVUWV94WX/FLPBS6pVwKFBwNc6AJIAh27e/XCgSONRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH6eZ0jDqH7oC1udI5I/2rOPJbPuSBSuRHPlKO/XpFQ=;
 b=giLYIv1TVnztOvftkEg4VKlq8IkDqX87RO/RP9zv1soKylSiJiChSAsnW9gt+xT6px/5JGYTr/UWkHfq0Y2Eu3SHAXBdA512OM4prjfad6vp2HXSid2vS6yhOLiF9436ySzsBNqM0ciXDN0JMIME2xmkmEFD+W83ROupZdFzKvEazhlgZJxP6sfAcfFyhpeju1/QXMzwLBnTWo+BRQ437Eh66v63xHPE/N6gtZg73NPkwQxyK6M08jYZk/smK0W9X/6ikPjfIi6v2jK+5irbI58Wjq0uS/a9n3Wj0YwkKUY5/HXHX3VlgYyk4RCzmfpCqSNgcaAKWOPkhRPSDJvRLA==
Received: from SJ0PR03CA0361.namprd03.prod.outlook.com (2603:10b6:a03:3a1::6)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 06:47:54 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::ff) by SJ0PR03CA0361.outlook.office365.com
 (2603:10b6:a03:3a1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Tue,
 28 Oct 2025 06:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 06:47:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 23:47:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Oct 2025 23:47:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 23:47:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net 0/3] net/mlx5e: SHAMPO fixes for 64KB page size
Date: Tue, 28 Oct 2025 08:47:16 +0200
Message-ID: <1761634039-999515-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbc7e6d-814a-4618-a367-08de15edec25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ucbS9yWIJra57JfeE2JKdc8GUylcRpIoLvjbp3RgPjat8FSJx2cnAuaZ6gfZ?=
 =?us-ascii?Q?etg5HdAB8q8QYIUF8pc6yOheWcBPW4aZ/A/D5B3bo5Wf/uPtvFtw+5DncFQJ?=
 =?us-ascii?Q?UMkSOYjeBOFMNue4QO6cLF/cYoh1LoX1EPeiWtTtuUzVgBTTlLiLylULlFII?=
 =?us-ascii?Q?3XRVOyl6YVeh6fE93vb+0W0PwFfh/WbtmyGVGfVBNuNeO34WU2zSS4cJ59bv?=
 =?us-ascii?Q?XisrpA0WvLoLwxcl71OiHkKn6WpY3buDg36+a5qEsW8iKK7KnK7vWTeQqClz?=
 =?us-ascii?Q?4OfLYwE+zEbqtc0HTxYuhk8ZoFImEpk2SXlkLtg22s6Yt2h4UGYITrKR0bIp?=
 =?us-ascii?Q?tKP+y833bJHhzc87cfy4Hw0AiVf0AVRixvGEFLZCZh1jTjW7i06SOVdai9h8?=
 =?us-ascii?Q?cQ0XnjDLAht5GuihaJqnD4wlUvW1TeyPiNMAfMI3mKV+MxLacjbK7BRuPg6x?=
 =?us-ascii?Q?S19qZ4mNyWxrsM2GH/vg0GbzTteBl9+jYQnppoe9duZztwROpxHWc7gPPLoC?=
 =?us-ascii?Q?2ECUBNuMu3FegVnq0O7acEON5Si6U2ey8Cu8O34pn4AFCemZkRVOYw/uyfCP?=
 =?us-ascii?Q?v9VcHC+Rc8cqIafobPUCl36kRnUIxYAPiV5Bz5+0VvIT//4uKIVqF0a74E2E?=
 =?us-ascii?Q?e9Ys4pUaOo15FBM8P0ccxEuePQkyZe8oeYEqA6dlAXYPurR5jXIxKa9N6/Li?=
 =?us-ascii?Q?ETS8mwt/WJXDtiIq1P1AZ9UuXga+ttwkBtrDPcFJes9gimCA6cHo/H4BaoRY?=
 =?us-ascii?Q?i/SulboD7R2GtAsrqUaRPaXGAwC/zmnswfpTxWILLsmTqYkYkl0QWADjyvtx?=
 =?us-ascii?Q?OljUastXxpEqcojxuJGGV0YTyGrPsDmX0lSBHT3SXptmuj6GXcuSQ92UAS7e?=
 =?us-ascii?Q?4hNB67b6xr2lJhiyuMHw8l4NFKY4+XG3uHhOBgnklM7hkh8opjzxtg90plJF?=
 =?us-ascii?Q?dJEP/IzcFTENUzav4gpq/+p33MEu3SLA6leTUiAzLyW5zoK8ypl5gGNKOnUc?=
 =?us-ascii?Q?RKxBs/nynAZkHWJB3L6Y8GT+1IfUvSCZqJDS/C7xE3VCRC0QvjLdfq8RJztM?=
 =?us-ascii?Q?98TWNYc5KwstV1R5TsNffYdLZw+C0KyhtfzWms/glsZ1JZDkFLuisX+yBdgB?=
 =?us-ascii?Q?arsZ3r2zWjN/b31+c+FeRq0nYNe+KKKR9jyeGlh8ri0Dor1CW7YEC32LAJCY?=
 =?us-ascii?Q?ww1My0DbzIFM8TyUHXYu4zDriqpTwauZBa0EtKA/wn8DUbEIIRvd33F2bWUv?=
 =?us-ascii?Q?b9qpmQOsH5841k9t6wEP0kIkB2ZXgQ8hpTGsAhErKfBYaj1HOEjEJWA147Pf?=
 =?us-ascii?Q?bmey0ySp6QD4Szex78RpD2SJNkjM5kq0VAYVglFPf/5hw6Nf+BEpo4/CZE5n?=
 =?us-ascii?Q?cIaIKGuRM69Hm9ii8ZEBLx/BQlnqVl8/BB7/iHcaEedXh89WuEO5ku+iHoPH?=
 =?us-ascii?Q?bt5DWKB4FtmE7uzsDpGz5kYkwrFt3Wg/rhZhnmA6MMdAgtGGjdjVz9sxgM8q?=
 =?us-ascii?Q?jk2iMRYoCmlEzNLsqw2d6djD1xGjVz7+5BzRwETGG3tBgX4EKVLMSUlSZQMA?=
 =?us-ascii?Q?JdbX8P1new0zouO6XLw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 06:47:54.6356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbc7e6d-814a-4618-a367-08de15edec25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270


Hi,

This series by Dragos contains fixes for HW-GRO issues found on systems
with 64KB page size.

Regards,
Tariq

Dragos Tatulea (3):
  net/mlx5e: SHAMPO, Fix header mapping for 64K pages
  net/mlx5e: SHAMPO, Fix skb size check for 64K pages
  net/mlx5e: SHAMPO, Fix header formulas for higher MTUs and 64K pages

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 24 +++++--
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 70 ++++++++++---------
 3 files changed, 60 insertions(+), 37 deletions(-)


base-commit: 210b35d6a7ea415494ce75490c4b43b4e717d935
-- 
2.31.1


