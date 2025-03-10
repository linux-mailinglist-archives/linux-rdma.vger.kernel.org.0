Return-Path: <linux-rdma+bounces-8548-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E8FA5A6A2
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 23:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4B51664F0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 22:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA0E1E5B97;
	Mon, 10 Mar 2025 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XGGsLeyW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEC21E503C;
	Mon, 10 Mar 2025 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644180; cv=fail; b=nvKvmTswgdr9njPH6b6qaZKNANnNp280VFi2FWkDld7fm842iOP6QRUYIaEVoxZvyU1IVkfyUx54tSK4NiH1Or13M1HHVN1StHZkCT1NYNBdU4h8kkb3GQew0pf+zgBKlbgqGHfi2gRnoo+qqKBcQSCqfwcH4AZSgkF6h4qIg0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644180; c=relaxed/simple;
	bh=juQNpRSaGinaoTp9/JKN5oTsejd5ty6p9MQQ06so5Ms=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sZXuehLzAPcgMdmpslkBxtlm/E8ARLtIGLXQYACdPonRtDrWLqnXkJDLNtXwNQjps0yqnRKsGury0y6tr/p/RO2iCELEP7iAyGDIisFXsQSxdRUY9jdDbjbLl7t0ABD/6fGY6es1o08uuKZG9K993bvczteRKf5qNRCkjIOh+mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XGGsLeyW; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZlf/ewOSfhn5wD8lVTOwuCQ/h8GqdIh2rvGxJFmA4uQ/BBW8z0E2kFtIbKCuIuQaWKJGy0oOGEwkZviy9LV5QV2qBsNDXSXOnD2aOXq74IfmAuDFvixEZmsiYgq9GV6HttM5ZnPYEr0zx30MCqW5V7S45lxXelXQQjr0d3ZjHljDuWr3Sf8upnYmrvRzVKJvlgTWuCq1rXxNB+8jdzjirwIcLIK9UYYNR91hUBx8KLT2Dn65EoaIUKSoIxAudwACf+y3nfn9HIw5B6k4xXr4RCNqb14QjGvKynGQ4WyVDO7Uq/PeA0OyDKYVJhSxKpXkdv2CIkInzn+2ERKugs1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7m6iV0EH04h8y1ryeOKEE+3P1eiA11R9WmPCEoPBxw=;
 b=ek7jwnB9Qr1fBbGXSw6ZLnkbkQ8WjgfZrRmWBrAoda5hvvzrmEhlWkPd6npvDuDKDwHMLFxpv/Y8YSx4bC7MoCLJQan3J7N6FYaFPpe1yb8ZUGRq9nO+eZONRBfeIGr/wJQikisEEIrsOV0Zava7iy2aMid6txL9yecUW2Y7PE9IqqLoLZsYZdcm/34N8WyYNt10psMu5DzAM+G7vGUWodN+1yV6Bcf9tTKembdCfTb44QnPJIV0xB2J1GJVq/E2NTFr4nq5LZV9hpHaIQpwHvp5g/vaeCw3ie6j0T9bZPpTGRJ4P7TItGpIFHSpfbTxygFFGeBB7CxkcFNhj2QxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7m6iV0EH04h8y1ryeOKEE+3P1eiA11R9WmPCEoPBxw=;
 b=XGGsLeyWua/ToNJ0oYh1vLnktGqgKDKNjx/5XCCswXpQHCjMzHnB/BTV/uzph1LTb11swLxyMvdz324oNoPgYkvq+AY8tCZLWWawxmA4EHLnby8fXpw1zqLe0rKJRDwEccTNEsXjw1UZ/UKpPcF2uAXp6inIuMgs574/bcB5OCntX09PhXaL7wOPNdOg1pMoQW8ycojLuly5oS0wyY4i+m43wTP8bI4Zoj30J9sHMULbT/e7t4lyDvzHR96RlReo93tzscCUb43nCdgNrAxuZG2FCF1N1Afbm23/tYpK5eMCTlbvrthV9SLWlXILR+fh4bkruxgWpugTQt2q74xWnw==
Received: from SN7PR04CA0236.namprd04.prod.outlook.com (2603:10b6:806:127::31)
 by SJ2PR12MB9237.namprd12.prod.outlook.com (2603:10b6:a03:554::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 22:02:50 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::34) by SN7PR04CA0236.outlook.office365.com
 (2603:10b6:806:127::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Mon,
 10 Mar 2025 22:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 22:02:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 15:02:41 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 15:02:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Mar 2025 15:02:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/6] mlx5 misc fixes 2025-03-10
Date: Tue, 11 Mar 2025 00:01:38 +0200
Message-ID: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SJ2PR12MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cdd13a-0c2f-4a0b-bc80-08dd601f4c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/xd+rqkEDJxGfigM4OTYG0OrFrmpLaxtbxLPtoKoI+7vkJtROCh6Iuv5IhJB?=
 =?us-ascii?Q?WGOc421989DO5wEmRbW9yNIJtTwanhqPsfZL9P9L2rI806z160EkvoAMGXb6?=
 =?us-ascii?Q?3kXoZjoIEFVc7DA/nCm+XDDGXbZZEbImWGteXWzDDZENiF0PiVtZKeQnZ1zc?=
 =?us-ascii?Q?9Pekb3FHa/oJR+bZKd2GjeWuJfNENF67LdBRLTEJKnMCVkKBmpZXt3jaD/aV?=
 =?us-ascii?Q?58Awa9MlrDCnb9IC5InVEOA4+zMiFT9hULkD8T/WTlrbHYteyHfrLl1mc1wP?=
 =?us-ascii?Q?pRf+mBLuoVlLF7nz4/kog4m1beaZ5lO/kE8l/Ws131Fn3HXkMewq3PvS5kba?=
 =?us-ascii?Q?rk8js4d+Qx04n6C86jgzVOuoqJVlgdQooxhjHmr7juXCxaGINWbGOUipMGow?=
 =?us-ascii?Q?i/cjwRfKEuAZ9wxFiPrFUwlpM9m/kyGTytbacn3IsXowzxs8XJJ6uJSq6/et?=
 =?us-ascii?Q?1SuQ63I1PA0dlyFdC9bVHdCHDV02cwqfFcJB74ON61T53ek0ZEUHNflIRyaZ?=
 =?us-ascii?Q?5Et52HZwMei0LXfsq2PkY4zbQEF4atChjwyEQViEVA7YC9XU//hxlZ9S6GC6?=
 =?us-ascii?Q?FC28KVAvw8IHfYsHBSAfjUPvlKwECykhYkkdKH22RAJu4aqRVbgIZ39nkpB8?=
 =?us-ascii?Q?MKUCW45l6+8U2+H3cAkjP75koV25o5yYKxgszjVbznfSKS4ypVX9nrr7LKzu?=
 =?us-ascii?Q?JY+7bDmVf2Glk+yEHDY9ZzH/B+WwIwqv14klJHiXXyszAYNMY5a0ZkkfekN+?=
 =?us-ascii?Q?pfBOMi+/snLAUidaXo3RDE8qs65TSQOuZ2U9NK305+LpnvPAb1YeHjtMA6Z8?=
 =?us-ascii?Q?SniPe+C3hfo6DW4eSiwob5ly8C2+mV/dHgXkxdE/GiMcU3XJxIuAI9B88fdz?=
 =?us-ascii?Q?IvXBNFpSUQQRtg0i5jT/9pBhW6KtE88coWlKvZ9q2MAo5nNVnEexiIQvrz2B?=
 =?us-ascii?Q?ySDXkF+vc8GC+mYdBorlEcA8xdKpG1x/AcFYXOegvYHi+gwvvoWt4lUxF9lj?=
 =?us-ascii?Q?5Ap1tHaE4oAAr4wS8qGj+XYdGT6yFzLOz0+sjnJ00Gi3615QbKrKXviloVnF?=
 =?us-ascii?Q?9S/K1Yb5H92hMMp6B/czQtjm7jQa2mrOzcfO6JwLEZKZh97mAtV+e+KJG/Mo?=
 =?us-ascii?Q?hifj91zCAle5yDknKFYh7yO8pbPelNvKIzXlOArZvUv759aqbaSweT6R/cl7?=
 =?us-ascii?Q?aM4+mGx/jDcJhGxzpamQQ3fRFps6owVbGE4nA72irWGV8cHs+4Th2u6wd7O7?=
 =?us-ascii?Q?nGhzlRYSvZea4OH/tWNjKwEYu5lvPYaQG9wQdiefY0YNrYscu2uGMVJLbDvF?=
 =?us-ascii?Q?33kaCxrRh+YgoCTgGfOJomxMg2ppHI2SWDuWiW+IzOy9i/UYjTak8pBUWNPm?=
 =?us-ascii?Q?AGO9ISVeqI932OxvDcCODUlfQEXim50RJE2qEwWPEbdO4OFESeoTzOmczdCf?=
 =?us-ascii?Q?lgKaSbYefu7uRZISVnzNDYKonorDtUNINLB7GMGRVtf/xwtqhVE7s0sScCXq?=
 =?us-ascii?Q?bIOYurRMHvZ2sNk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 22:02:49.7085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cdd13a-0c2f-4a0b-bc80-08dd601f4c63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9237

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Thanks,
Tariq.

Carolina Jubran (1):
  net/mlx5e: Prevent bridge link show failure for non-eswitch-allowed
    devices

Jianbo Liu (1):
  net/mlx5: Bridge, fix the crash caused by LAG state check

Shay Drory (2):
  net/mlx5: Fix incorrect IRQ pool usage when releasing IRQs
  net/mlx5: Lag, Check shared fdb before creating MultiPort E-Switch

Vlad Dogaru (1):
  net/mlx5: HWS, Rightsize bwc matcher priority

Yevgeny Kliteynik (1):
  net/mlx5: DR, use the right action structs for STEv3

 .../mellanox/mlx5/core/en/rep/bridge.c        | 12 ++---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  6 +--
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |  2 +-
 .../mellanox/mlx5/core/irq_affinity.c         |  2 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  4 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  3 +-
 .../ethernet/mellanox/mlx5/core/mlx5_irq.h    |  4 +-
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 13 +++--
 .../net/ethernet/mellanox/mlx5/core/pci_irq.h |  2 +-
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  2 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.h  |  4 ++
 .../mlx5/core/steering/sws/dr_ste_v1.c        | 52 ++++++++++---------
 .../mlx5/core/steering/sws/dr_ste_v1.h        |  4 ++
 .../mlx5/core/steering/sws/dr_ste_v2.c        |  2 +
 .../mlx5/core/steering/sws/dr_ste_v3.c        | 42 +++++++++++++++
 16 files changed, 108 insertions(+), 47 deletions(-)


base-commit: 505ead7ab77f289f12d8a68ac83da068e4d4408b
-- 
2.31.1


