Return-Path: <linux-rdma+bounces-12358-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AD2B0BD48
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 09:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827991881F40
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 07:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D24F27EFFA;
	Mon, 21 Jul 2025 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fb2IJfAl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334A27F006;
	Mon, 21 Jul 2025 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082043; cv=fail; b=To0zKXIL/x4Mz2MCCv7lPzenE/9EFV5RD79mdb2YY79daXQ/svuUHCm/KiVSt+AUPUfXc75PyPVm11gWxaMM3U8JRGn33ERugdCj5VZqsyo48qOtWbJH0sc9z6a4BNSFcpGloU6YNsOuizFKvKDdSeXD5I60jFhMZDdXcAzC5Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082043; c=relaxed/simple;
	bh=CQ/30LJaWrnxdpF8pmEK7u50sQuw+IStXLVa/nmWs4g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L20FmawQXUGGlRDH4Tb/1REZkEaK0XpPGBujOoWA/6lrkDRcbTEEJFDUQ4HDeLNPeQXXQYJsEzDzV9s/5eSwvE6/d9lj3uBYsmeiAEIqFVGdBHOpUyJN/Xn8tD+qKXxHi+MFomrg6EBiX6dHuvYVHYWG+EB5bv6PV+dtl/FzZw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fb2IJfAl; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEpabf6lMQSNjUMHl2AIZSIt8AiZlM8RilFAnJV9aNU/YlYzhBClX9cyD6NGPjVTiq+QIWRonplrK2Q9JZgvBKH+6Vb0FkBOQRolM77xI0+NLTfazmffAjUZ4fzhljoAsLf30Jl+Z89MYaFig7fJiHW5JMuq9q2Qwhp7oMn+1UZZCwgWZrjNHP/4UN8t+1kFH+54gUnjYZgq0kOFEFEMhQGa76/GIXhmOwENFEQWG+yjrKbUQ3VintFW6GZQVSkhmCJzEs7ZJK/qo9CqexO4QLV3+CyvT5lQF/BnGp7l7HCnJ+WRMfWCL/nlMMFCyXIefUmGmNnlBtfgLoNwof21YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEvD5LVOldMYyD81CiqIPkGw2rmfwpnv9IcpmzIGyu0=;
 b=dqn99SAPac/9nAD4/g+sqDSnLKBcM0qZMqz0kiwYKtc9BxgNl8v5QvH1Wok6pnoXZMg/6MMkEdugkTnv8J8uzAwmldbXrgbFExfkyUCo9OjKuwovFcZPAbldeM4PF4n1V299u8sfC9Zw1jnrHRbUpv6Qv884eVayYehx4NFhqvnhQlc3UidvJmPoWraoB7oj2W2sMebQ5qu0XVqwkM9L5MNeeOsOZz+aEPpop2xJqMU5JUDBKI4MdWQmOsraYBa/TVUSBIBPDp//hQpYpTjvAq44HT2Z5EH1LJ9j8/PAGrT+ukF1bBatA75UPhABm9GneY1hsDDToxZjcEeJzr77ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEvD5LVOldMYyD81CiqIPkGw2rmfwpnv9IcpmzIGyu0=;
 b=Fb2IJfAls4qHQ+RVrCubMxubXN2A/U64b1i1gjpmeJHNCpsZ8QvcTE5Mgs4y2zYzUMNQnMkZaPUEt5ztimWVLcaGclv4AJ/Rxn7C2c9NjQJ5HGo2BLmt2mCeWRvERgqaBbwGiNrqZdn+ku7+eJsC2bWKbSgbOIoHYRyJUdhQqUj6DKUrzGNtMvsioR5qlK6+2pKVw2LT+Df6rKF60r2JslX8yr0JR/2EaiBTXxrv27By0hOjHjNKS3JGV5+EEyQPaqf1r5aSXE+DpzWlflACbDAuSL28LPh7gG/APdar2yVjd0OGEMea91hnvIfl+ipuPN7A3uh4Lw8RqMQP/KhrOw==
Received: from SJ0PR03CA0332.namprd03.prod.outlook.com (2603:10b6:a03:39c::7)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 07:13:57 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::bc) by SJ0PR03CA0332.outlook.office365.com
 (2603:10b6:a03:39c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 07:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 07:13:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Jul
 2025 00:13:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Jul 2025 00:13:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Jul 2025 00:13:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
Subject: [PATCH net-next V3 0/3] net/mlx5: misc changes 2025-07-21
Date: Mon, 21 Jul 2025 10:13:16 +0300
Message-ID: <1753081999-326247-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: 14dbb789-ddc4-4dc1-f457-08ddc82628a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AYR7ec/XD6mpIFwycMXPXdjAgfisRQCCcpC/UzpnGIUG5XMedgaVbuFt7PVn?=
 =?us-ascii?Q?gF7jL8U1u2fsFS9Yf2T1jXKFrX9EnyMa6Nj1x6bIB3ZYiRkQJUC2MrrVCVdB?=
 =?us-ascii?Q?QBq0M7dMbMajWyjKVbKE/cbrrYfZHA8wxYCNEXbaAIpxqOtAMjC29hx3Gk0m?=
 =?us-ascii?Q?mZy23QVHIJNkdIKXDNEzqMP6kdl/TEELjShSBevjduK7mGhDgg9bkvzX3IYV?=
 =?us-ascii?Q?TCsBoqFWHAHXFX1XSpaSCNb2jf8roeicfbGtDM0MPujaj5MKi7Z+LzicnGmx?=
 =?us-ascii?Q?suo9EortAYmpkX4NWhG0YKY0wnJyNGHnnFAEVdX1m7GuqRqPRlDUrPmyCrRd?=
 =?us-ascii?Q?mgAcX7YzRWahLUjIhhBXwivyyWqIAsSF2A25Q7FzkT/5RhVewWLOgNWMqrnl?=
 =?us-ascii?Q?FUyPfBUBFpdXbqNWj0wnhH8CFQMziAP7dqoDhNRtPNGZBS7lwWe2rkqmKsa9?=
 =?us-ascii?Q?UmyCFjag4CJEkbSCWsXcyV2zb/+acQqIw0kpd6SzIVk4iubxDBb0hcBScQzC?=
 =?us-ascii?Q?Ia7FUuMY0e2IYvENpQj+tflM+7FyBLcMWChpeyNpgFT52cJVN/zq7M4d421z?=
 =?us-ascii?Q?paGPCUueF2wOlh+Qx2KsUlZqXW8xk6M6SZO6pBw5iL+Cie6BWURs1jyuSuO6?=
 =?us-ascii?Q?4yf8bMp14qB138xZ01dC9ELLk9DRissuyMi4CaWL4qbpzrYf0NwNIRPLh0uP?=
 =?us-ascii?Q?3xB/oQdS5L73s8ijkKx1kpUto0h6zWmkvTa+o/WEBJAjJqGzs7mEx2wreKtb?=
 =?us-ascii?Q?KPjUOQCvivS61/+iIF0J+1Ejv854oXgTDqxrAaLv4EI7534SCLUFeQaiYBJ5?=
 =?us-ascii?Q?bfXn6iz03puatRBAy8QLAcuEc9gx3qeC671oYFcdOSRG6gJ4wrIN7mZkwZ5F?=
 =?us-ascii?Q?hmYSCtLHLwquEaUvzuiwhvh1M7hex2K6QV+WA7OjkOg8FahMd0ZKnFpykINe?=
 =?us-ascii?Q?S5tfJJFYN3qwkqoOFqE0VTJ7/7N8A7ga6+hF3POBtTl1+Y0H3P780tKEoBxv?=
 =?us-ascii?Q?5WsmuSi7NUiAqEpZoFrX3NJS8ZWr0IeHoqZ2D16FMkJEZALXLRu7VEi4tWrb?=
 =?us-ascii?Q?voLTVcH8lv0spPCFQPOVL2kZkNuumaOLK1Tlq7sAeZC8LkiAu3SDAW+l/Y98?=
 =?us-ascii?Q?g4mzeXnICyVxvhNzJC+rQPldKzvCznFLtj0uNLpBSUPXNQHDLVwIxAu9HWEU?=
 =?us-ascii?Q?TTR4+v5AUVXNFHfc87bSlUQX7tuHbRtkem18ioKMmXRvtcDplxev1I8Rwl4J?=
 =?us-ascii?Q?VrCXZEh95urAX9DpFq4lS3k1nQmFXMumspWYwdk+Zrcho0OA3az90r69LdmD?=
 =?us-ascii?Q?OcdJ8K5a0rdmn5kLsAotKAGCXJwIEjRfsrXhufS7qCYKIkWmCjIfKZrSNhPa?=
 =?us-ascii?Q?oSv9/UGpXIlpOOlhJXtJa7C/21txR79H+7fTlNajL810SHQlHgz/GJLZsxlf?=
 =?us-ascii?Q?V/ZYwF8L/AI+Y1sZlkNv1xT+mAiKg17+DIiBIXrCTC2Kk8lOQ1MVIdxo6MK5?=
 =?us-ascii?Q?/P1RWJckh83XnLLs13g6x3WowUbtBHlP0BmC4iloOZsPU6B3KlQFKhr2zw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 07:13:57.2750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dbb789-ddc4-4dc1-f457-08ddc82628a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068

Hi,

This series by Lama contains misc enhancements to the SHAMPO parameters.

Find V2 here:
https://lore.kernel.org/all/1752675472-201445-1-git-send-email-tariqt@nvidia.com/

Regards,
Tariq

V3:
- V2 partially accepted, re-spin the 3 top patches.
- Fix RCT style issues.

Lama Kayal (3):
  net/mlx5e: SHAMPO, Cleanup reservation size formula
  net/mlx5e: SHAMPO, Remove mlx5e_shampo_get_log_hd_entry_size()
  net/mlx5e: Remove duplicate mkey from SHAMPO header

 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 10 ++---
 .../ethernet/mellanox/mlx5/core/en/params.c   | 45 +++++++------------
 .../ethernet/mellanox/mlx5/core/en/params.h   |  6 ---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 27 +++++++----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  2 +-
 5 files changed, 39 insertions(+), 51 deletions(-)


base-commit: 4701ee5044fb3992f1c910630a9673c2dc600ce5
-- 
2.31.1


