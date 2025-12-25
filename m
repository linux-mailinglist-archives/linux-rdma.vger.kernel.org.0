Return-Path: <linux-rdma+bounces-15216-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD44FCDDCFE
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 14:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69A50300E154
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 13:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18821201113;
	Thu, 25 Dec 2025 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GOLlkqfc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BA23A1E90;
	Thu, 25 Dec 2025 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766669252; cv=fail; b=oopi69jbXUv+Vq1M+jDXdUcc9ps0oYvSkUVbkVvKVIQ+1nN/U2jXawHghjexqWFCP+uhXsa/5cvMxREY0DqMZO1MqdAkQxLBc/fk3Vz3e8mr/2YVv54Y/MIjKFeS3cxgKDeUFIESEQc61STf1c3SiOy5UP8s1Jol35rfusybGLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766669252; c=relaxed/simple;
	bh=6FOuR2UqVeXoC5X1+VKnBRfECsqZ9wxfCABr35MyBkU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ao9cvUsCkO00nP4SQk9OcGhTT7aX6u07uMhVs4Jh45WR/xU+PYze9g3ZXJyXflahVOQu4YEBpY2jYrzeRpd5iiCdpt6rBLlXKZj6mr8kRCGM2USSdtLWjXfALwFO+G1cvEQdiYzYNvpNKjCdKwjwzhN6j2IujKyBPoV7vRIduYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GOLlkqfc; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewXlkGBUz/z4Pme5x0wIEUoPz1MWYlIfFEG2O7Ogmyd9cGzcRHLKyAgvHKjHXQmvNTRBSBKEbGaTmkZVuYS9+wu53fpaKChrnfnrDGNxMIfTL6U4MzT1fqOvAWs0+gi77p9KN0bIjiPD5iLUonFDCdKiplIizDTXNcJ+PjfCUp+dBUTtdO3nVJp1OHZvNIGDE3GOEd4jWu2kn5SWJXR/HB5Tr1RMvWB7j/R7ivCLLC+6TxnHhxVPSKC6mcrSe43cmhs/ymF0dTzdHjIiBnQRlAU5KXEJq5QvIaupa2spsVA/4qvIZfy2QNln1PyzKNy3P5EBp2z7J8wKcVsa2ATguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYqzPr75AxVwUqatJA0MAydUryqlewERBHBzWVqhzFs=;
 b=ry9UPYw1ID3Q6yxTXUORa5pHB6ZFsMnH5j6316QiG99ZTi1Nud+ynHRcNuxhwg+ME4NmowxkuVfuDaKgYa6dI/iXQfBDpaFiPHdYmxfIUAF3CGiSq+ngAItaENibEiJcJsCuZ+XNR/WrbJBA1RPbRLXjoZ1wYFgvlwuPYBuM+C/rvd/IbqZgfpT32rLWpVqDqYcwQerSP/KbQlBeu/W4DsBJ0ACOtEElcyTht/ycI0XKYclHxC9YSl6XtmxtcD+B/8Shb3s+CM5VZIsMWr9tVEZJN7YHf+/IR2dBLU8Ic2YPi7HWoDPJVwvfBbek6hlr4pcs6ASiR+2ZhQm5V+o52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYqzPr75AxVwUqatJA0MAydUryqlewERBHBzWVqhzFs=;
 b=GOLlkqfc43lMn0B1qGZKvCjZr75PA73RR1hm0RWauMeKZ/FT3NrZRoUT0Avb013rGNuQZHc5W5Nc81iHt+YkUG8ti5cnw2LbrOoNc39B18JCOwqBB6wvebBW66xttEZ2lj3hLJ6NyJRfDdxis9b+1sYLESdSQdsy9QeDO5tPtr6I9ukejJ6ewOLID488p0aq6P1+y0HuAJ+qphdXNfFsbAPDhNlnh73IftEzCm3mhm3RQlGvdDYnbllvKncgkiNK/cbCNmUohl88slVs42iq4u+JxdsDKEm4mK2YmT7ADBxlgXvvSrJr/oGAjE/3h5Cx47nXnQBEoD8kgMS7kOwGWA==
Received: from SJ0PR05CA0089.namprd05.prod.outlook.com (2603:10b6:a03:332::34)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Thu, 25 Dec
 2025 13:27:26 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::16) by SJ0PR05CA0089.outlook.office365.com
 (2603:10b6:a03:332::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.2 via Frontend Transport; Thu,
 25 Dec 2025 13:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Thu, 25 Dec 2025 13:27:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Dec
 2025 05:27:26 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Dec 2025 05:27:26 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 25 Dec 2025 05:27:22 -0800
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 0/5] mlx5 misc fixes 2025-12-25
Date: Thu, 25 Dec 2025 15:27:12 +0200
Message-ID: <20251225132717.358820-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bc11e1-5268-487b-2f79-08de43b95890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dIkeiytatbwhyQD+QJa60LkLAYN3kAeF/FIRWsZU1sxq1FyXtXXXHeNyYh0S?=
 =?us-ascii?Q?3jMw2FK02su4n92ZZBUw3eeicWwiQjEx0JeiUsB905sglN/RlhqVGIAxrcQQ?=
 =?us-ascii?Q?FeyhAjIZWTE5N561yqteIEAg+bIhPq/JNUcsLA7eQoCJ/gbQX7qfXzZxBa+h?=
 =?us-ascii?Q?hjfGayx808qidyZliLYwde5S/XCMScUG7T0lK88tifkIbp2XC8pK3diJVYOg?=
 =?us-ascii?Q?+/S9BbSGvOJfThvjypw3NXpnntQjHQC6DYanE8DXMoMIt4DdkqifRtd04u3w?=
 =?us-ascii?Q?DYTNj5bqbNusKVLIU3iHayHyjFljK2Y6uDUolYxOjb+4UbTsc6/LLfjOELoi?=
 =?us-ascii?Q?i4/428odPrSwB4NWAaIKlVt3jKIaPg0BCin4Hn4s/xwYkvPoyEDm/CI++a6f?=
 =?us-ascii?Q?01ZoeTC0Mmy/6Ghws5v7aO1Bo/SYUS0mzN8Baprre7KsahZVlKeRy41CkwH/?=
 =?us-ascii?Q?pcm8uGIIxP6XXYxUY2oE4GP095YgtodnSK1uZGJs9uK8BCRQqek2JNHvkduU?=
 =?us-ascii?Q?zqXrkPF5k/0vavY4B1HMxhUN7XIso2OSDnJbz1OWsJle26xsgnaktuV4Q4TM?=
 =?us-ascii?Q?0uH+oO1DWWCAVBUGD4JV09hQ2C9UV8brerjE4Fy1GiESbJLnaUiE4k0RGK8l?=
 =?us-ascii?Q?qCJAMqTgymaWUs6IjY+O5pPvV48HoeWMJFmMWVrpmwf6kCXgxLFk6u/6jdq/?=
 =?us-ascii?Q?F6gcOqC7am4FbNp1Pu5UVaDDfRZ+fNdk9WUXy8BdFwqhOW/ex+HOSHm/4usH?=
 =?us-ascii?Q?yXiPXKCGIhMH2yjTEB3UkqobvzbmnlQ1RkkwowyIWGkk51AO3H62OtgAOcYR?=
 =?us-ascii?Q?lCoFNlRj/EjVetNE9Puz3mhTjizy2ecJ1wcBgL82IA/E6NiXX3Gq+kXWWa7C?=
 =?us-ascii?Q?MPl4fnHYiEJCuoI1wDNGdP2P7Q59tBzap/aXiHGHdAKqHW8feZ2JKAqCWy/Q?=
 =?us-ascii?Q?V3mkjDoV9v1R22AzQwaA9Hn9ROwCL9kuYvk9qpw1tLsb8DTcUmLEV8VwiK2G?=
 =?us-ascii?Q?wFm6AgFpP76JQsJhiBZo+4WMGwdepMT5PRF22WwDOJhJ97gM+u9OgJgKUsYh?=
 =?us-ascii?Q?EpTa5gebjw4dVW8cdAT53YnqoaIT3oBYAkCiOaKx6dzl0+P7UmJt0Q6OYmGc?=
 =?us-ascii?Q?oAZsto6sarShFk6r0hBzm415Rtotn7GvjJXOdfsP8yVa6z1obkkSWUk0aWTM?=
 =?us-ascii?Q?IKOhkPrWq9IVJKvNAkAuhAWKRw0eN496KfO7EjtryB2Nn/K884kkL5ZPvUjN?=
 =?us-ascii?Q?y4bu7Q79pqhXDuYLdtO40+Wq0F3jrp/EJKZmbL6WTfdkTECtZvKNLwIS/qqv?=
 =?us-ascii?Q?MAkNwc+hfJcyj+uHwd0/SSsGW28U4LOGNK5CaTI+J4UL6sB26wNFj+XLtZas?=
 =?us-ascii?Q?4Mr3ZlYTMG8hUgDW5oCWw9YES/TEkek8Mqs2qSabrXneysppP0jCQS/XdGNj?=
 =?us-ascii?Q?w0GJ7QW7s/QyiSeqoXaPi7XGgCEGRl2Ekd9FJVdhv5i9Pu86/E0zl3NpYWfR?=
 =?us-ascii?Q?qAhVQw3oQKoJouQ+8n940hQAqh045j8KDd5LENVDN6IDihmzJnEtxHsBtE4q?=
 =?us-ascii?Q?QMw4GgxVJxK46Vlnres=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2025 13:27:26.6808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bc11e1-5268-487b-2f79-08de43b95890
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Alexei Lazar (1):
  net/mlx5e: Don't gate FEC histograms on ppcnt_statistical_group

Cosmin Ratiu (1):
  net/mlx5e: Dealloc forgotten PSP RX modify header

Gal Pressman (2):
  net/mlx5e: Fix NULL pointer dereference in ioctl module EEPROM query
  net/mlx5e: Don't print error message due to invalid module

Patrisious Haddad (1):
  net/mlx5: Lag, multipath, give priority for routes with smaller network prefix

 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.c | 14 +++++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  9 +++++----
 drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c   |  9 +++++++--
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |  9 ++++++---
 4 files changed, 29 insertions(+), 12 deletions(-)


base-commit: 6402078bd9d1ed46e79465e1faaa42e3458f8a33
-- 
2.34.1


