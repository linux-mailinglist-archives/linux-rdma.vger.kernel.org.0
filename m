Return-Path: <linux-rdma+bounces-13705-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDEFBA77EC
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 23:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104383B69A3
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 21:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F97229ACF0;
	Sun, 28 Sep 2025 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TohXP+Gd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171D029A307;
	Sun, 28 Sep 2025 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759093355; cv=fail; b=exhQZN5b+v15BExMZDh8ITu0A4C5lsF0AMlZU3qGFcXgXRFQ1WkcmtaNZ33V3pXsYYzyO/mc95rSAQYkLitc5tJ/zDN8iKM3ToCDkED8jTne111ttReW4FyYaEwFj0pmBXR2prHORVjUcuV6L4atqRU74kfIpyxoPcx+eX+QNto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759093355; c=relaxed/simple;
	bh=gpdZzZl3PFcyFpNwiD4pN6PeTR7097MKM5U1xFDU+Fk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gV5s+RATOhISaTe1UaW35WP7/GUS7TCL4sJXGcLB8xTIt/PCoxlc6ZG81/bWaWPWZOfGvA64iMk43vXYs5SlNqoJ6Oh7jOtXBRnUa9tnn/L5aKjIW7/QVdoBvjVO33X6gACyDo4v9HsUvaqwJuVYEVJ67ws89BYkWxTyV6FBVy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TohXP+Gd; arc=fail smtp.client-ip=52.101.61.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzFDN2x4mShvqrfVaIaUdHq4bKgoA55lJS59Z7LwctSenM0TzTZyWoxEPkl4SxcH/N3ZkScU6T7rKqwiGxlZ/PFkxzGfen7pUHh6h8S42Zvo7bMgsdCSd0UUzEtm4h+hJ+r8c8zeeO7kuAhEO12Rx1oeT6PV/NXtN2LEtKcr+fnb58OMr4VyroGcDf4TbsgV7AFhEKF40YBXj6qsl+u3qpU6GM2TcOBX4IEMU7M1VTNei/FAMp2lkNRfa2Rsv+C1bPX3pvARQOo9OLAPUi9NASTUNP3hS9DfUcN9+wpCgUWXlrDi1uwSeBOCxeSIyWTfccJrcPIVb2ipfy0Yszk4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZZGJuu2haYJ+SyWvlERoYWwGyC9+l0QRfG8g7vMlZY=;
 b=pbUBVV/S1owUrA0U/tPUg7/I+SQkSa+hJObjZMvsRpDb6sdNpgL5KAXeDGeQ00jenOKp0m2BV80dDIGHNV6WWlZOzfXSkCnaus/UayHt9N78Sy3DbRxguJKaj3cCu/xEoES+6qMrZk3RkHdV3jjDqzkS7Ds1+wjN2Nr5CAzhW/sfdF8B3j4wWaag8Az44uX/r1ZvOSwxKoy3KJXWpfJYp9Z9cBPDr8Vd9rl1cuBvzUu+GYzdob3hB9+KXBXztAYzNjiuRQvXOd1kZsPADIZFEZq90TqUzGeOp23FLn4DO5h9+c65lB1nC5WQaVrx2+wtAmb+uH1pMbVcl8BUOHokWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZZGJuu2haYJ+SyWvlERoYWwGyC9+l0QRfG8g7vMlZY=;
 b=TohXP+Gdp5YdDYCjxxu6RSVRzmUFr3ZBjsD/JZVZ0FRb53AT2Igmo8lBiXqV5uLwlfIcBosU2iMC/Ec+ktAW3hPGNgW9e/cZtvh9tXh9gGm5NQ/7u9FZmQZBasbtzRCMPsDhk+Ip/9uz8WV9W2f9TSEbs5SWV+1fs8y/PkxvrRkz9A/svQ82UO/xEq35kyW03N0cLy0RG16jNjSQKDDTEoNPuHQ30EBcgnyE1HqliOoCZdFhOpMNcYhZwgKzArMxrZtvsYCoweBLoY5OUgJ9RvmiBzth5x+yNlclbYeniUoJWRbUU2xHRKJ3WCg5MHGQDX8bv+eY9oiT97KQ1dTsCA==
Received: from BL1PR13CA0320.namprd13.prod.outlook.com (2603:10b6:208:2c1::25)
 by CH0PR12MB8530.namprd12.prod.outlook.com (2603:10b6:610:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Sun, 28 Sep
 2025 21:02:29 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::34) by BL1PR13CA0320.outlook.office365.com
 (2603:10b6:208:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.8 via Frontend Transport; Sun,
 28 Sep 2025 21:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 21:02:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 14:02:27 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 14:02:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 14:02:23 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: [PATCH net 0/3] mlx5 misc fixes 2025-09-28
Date: Mon, 29 Sep 2025 00:02:06 +0300
Message-ID: <1759093329-840612-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH0PR12MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a3baf7-c2d0-46fc-6c4e-08ddfed255a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2cbfG5UHDI8i9NEC87/Lr3KB2c3JxfDsmcpeWUJS4e3RbeDBNhvwb490Spv/?=
 =?us-ascii?Q?giI1/JpZJVkdfXjOSDqSu7nnuTbrhoeGHjqcbrFeHXDCUeQapDWRKu+wRkRr?=
 =?us-ascii?Q?Ig+STd9PpPX5C0qqD8o9p3wXVTca+/dK2FZKdh2xh3jb0aWBdjQvYMYY/NTt?=
 =?us-ascii?Q?ZnjVgRJL+9nRQCCeOubEOQQm06bA2kYv+QgBmzeZWnO700HJ5htxQNK9X2ON?=
 =?us-ascii?Q?IbYly/Kpaw2yJuy8tCP57FdC6yGNKwNspPEkYwQIB1krrpCV2LUwwwWkfsoV?=
 =?us-ascii?Q?X52JZX2yaxVE3WeDsB0qS0ICI1mc1/+EibMvkDbypyac52b0uUoAPosizL/D?=
 =?us-ascii?Q?7wc09LDecFVdtmXRnPrkU1ij/uMO/yJZmQKyj3H5Albj4KcwMgm1c557A22q?=
 =?us-ascii?Q?IgMmHBKIfdgg/Zs7P7EhKk6Qs0msEHs1BcyoZD7ITDe97CDVwAS9THlliq1c?=
 =?us-ascii?Q?I0fIjApVSsr5lYU/txdhlaR8XGEwihAkBZ7EcNEJyNq5ucaVRyKULEoWfOv0?=
 =?us-ascii?Q?PZ4QTDiVFibEqsTpkqGarylC1VPBf+10E3E8t+08zXDgkVtJTd3H2dN/hNpt?=
 =?us-ascii?Q?650Yhkmi4N4nfNj8AMJTr9MdfVamprQA6N2vwyNO1wCe4z+v27Ca2eRtvxSc?=
 =?us-ascii?Q?BYwT3bT3vsSflHNA6ZW6O/OtD/GByFifL9XjCDn7WHNaRyaV6D3SXSNqMBNk?=
 =?us-ascii?Q?EkyHHPaugCE9ceQtUAmn+I5fv7vuea6O/ossqoBLVyZ11yhn48kHfEX7siqA?=
 =?us-ascii?Q?eO5Vik7UbUkY6drp/kyEG16hzzMQd65uujajJjtfxOtpEew7nWSm598cLXhX?=
 =?us-ascii?Q?ujpCoGzd9yVlcwb5N3UDUWUty3XzeLJ2XZCZ6m3d7CyAn9Nix1ifnFOnuTjf?=
 =?us-ascii?Q?EUm5MWyQvDsYNijp8k4wfEVLPYItWEp7I4TfFGD7qyvgYe8DnSw42U5NCoIq?=
 =?us-ascii?Q?4kQbpuiyRhrf/bthVlyZpmwEFsMP+rGn0+3Ld44Q+9LZq92TSysuE1J7DjWz?=
 =?us-ascii?Q?o5jj0S04l+sy3eN2rEsk0AtCEdgUGlIR2gQ+8VV6WD2waAdozfmBBCFR7tVJ?=
 =?us-ascii?Q?m4cWDDeLeo7ZQ+wz90qeFRWMOM/7S9or2XfhdcGstq4Shm0OEPgkrYkTt2cN?=
 =?us-ascii?Q?sgMS21Z/iyy/om3QvADUSbv2sBi7i1d/5WmuVEnUbcwhXhaq8aVNBSsBefJe?=
 =?us-ascii?Q?Edzp7x4n7B5Ysnrzz84iMCQslrKtnsMvskP/eohSFtJsMGx9FGxXh8P4BBtl?=
 =?us-ascii?Q?GHYn3HGeL/yXvIU7elfUIkY0bPuzo6fQ1S/TyFWV5y4S+iLFRf4Lvk7UaNnB?=
 =?us-ascii?Q?z8XIkS6OPIjh2zfkGtqHDU0kRZEt6MniY9LhztzY95yyleZUl3wQF+bOGsUk?=
 =?us-ascii?Q?pWafoh8y5ZzX4pWsnpHkdI15nJPcDgPHXynT5Uv/zk8YmeD7kFNJIWOf+S1s?=
 =?us-ascii?Q?oJYH2Nj2ZAS0CbnzNPtn9ivfRND6CCsP3EB3tOlax8KbGfzDx5Be1QEoo00T?=
 =?us-ascii?Q?dfKGCWb2yrR8/Qket1RAvEcJ0N4TDo6HjFDa9ZupL9bYhCtjjNMJpPD1QrhB?=
 =?us-ascii?Q?qgo8El8KwhSXmU1x238=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 21:02:28.7093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a3baf7-c2d0-46fc-6c4e-08ddfed255a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8530

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core
driver.

Thanks,
Tariq.


Moshe Shemesh (2):
  net/mlx5: Stop polling for command response if interface goes down
  net/mlx5: fw reset, add reset timeout work

Shay Drory (1):
  net/mlx5: pagealloc: Fix reclaim race during command interface
    teardown

 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  6 ++++-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 24 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/pagealloc.c   |  7 ++++--
 3 files changed, 34 insertions(+), 3 deletions(-)


base-commit: 012ea489aedab1a4c08efbd936bb7be91a06d236
-- 
2.31.1


