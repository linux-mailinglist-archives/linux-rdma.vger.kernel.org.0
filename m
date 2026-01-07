Return-Path: <linux-rdma+bounces-15340-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F4BCFCD5A
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 10:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DECFE309B88E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C553A2FF657;
	Wed,  7 Jan 2026 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ipTaiAji"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F329F2F83CB;
	Wed,  7 Jan 2026 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777566; cv=fail; b=gZjTXyQtBC/IkcTmk/YA2SEtxw+S7B6Ob5dgBAfJUtBqTMpdw7iB0lKSegnaEBEHqbS1+4b7Xc44AXLUzjOr9GvwSVcZ5SloR/cE8uLkWf+2J09fabVGtLUHNJHdcWfsh9vRdQHpXaT8x1kEwnM9yB76fQiCMQAq6Xp2ZHqFe6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777566; c=relaxed/simple;
	bh=gX3aLPojJrT9VyRn9ZdVno08RqRJd6abC9Q3fzlCF/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKq8uZJmJUusQ3Bmj769AiHGI7d19dBUr4oDRfCQl9QR5ozZuoGmN+QCmCEIYy/pWy7VctCyBRIoAbqvvizXtJd5SDERpfbXtlSlG61AunJYIzaa/6yq2YDbAhKs1D7j+kRKw/vU0bdTcxphl3+KaUce3rYBscMuHiB/dT924yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ipTaiAji; arc=fail smtp.client-ip=40.107.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPDvfsW2mtOGJvkNQSHNBP2OPM7LMiJXYA0gr+bdl4z3SCZnZ+MnrA3ILjPgTaIyHLkOrdBc47FeYnYX86vnlqqxd+BrZpPDeOtNV97/MKhasFWb/wgGsj1pXlEnzxPX+vQ/ppJCrsgBzPRqv+yrjpTJ+5Tk5eNBa1x4T2TBOv1NHm7H98wvtA1la7tb8xWddvMQe6Z4u5XNjxK+gG5BCIGSZgWJwQxMjex7seZOYbra9aO9qLYF+S0NIwNKHZFy+0AVuveAg7aahpRIi6II7d1GegmpskK3bBh4UArcT2RoeR1bl1Lax2PS6mBohJLVUVoURdrm8yex7jtPbaet2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXki0ZkJHBnN1TXWpBpZ7f+qBjhJ+DCoGH+bk0Kwetk=;
 b=AG3xdX7mDNVljgMwNvccG25ayzSxriAwoDYhYDtK3llnDjII61SCmxYgvetsYLn150u3wh+yEQemQubA126VJviZXxx5mOTpbHwKQzLSuIfMNdUGYDrCJVCPcGFu4dtISYdfpGl9k7ax9XNPVltQm0fMBmhaPqG4fDL6wv5NiATKvoEWnbMUP81OUR7cosSNUkkFMKyDLqmbNv3KNQ7Ujhn3fJ3IBTRFC1jxjT8LEM7h7pIMXcqaMUbrefrssQDCGlD+C0ewmZh5cPjE+kcRfHJGFnnXPfcvxma4VdIOgnfiu/Yq2L0WO6YzwzzgJ+dSZimeSuXIVEFU549LhDvUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXki0ZkJHBnN1TXWpBpZ7f+qBjhJ+DCoGH+bk0Kwetk=;
 b=ipTaiAjigvB76Hnda8M3eBDJBcjrmAk/J6uyb8sTOOtgXuGNrtQU33055h1B/2RjeaYWyDKn39myum8Y0nQu8Ngwz4q+C4qWWldF/DFqfLGnlJw55ZqNHW71JZXVNKY+CgePFFO7h6YL1O6VtmS0S4tIZLe9QRGmTwuK+A11oZBh49KO1oKaioJNi+JOcWYeVKI+izG98Lpdqvlk+ECC+n1TGV9OvR4gxUh5uglyVrnA/SI8KkjImKRG10R+eTRZj28FxLmaN2nv7dUf2I+UykxXGM89M37HaeVVsBg4IALAdafX8nUAtr6vTR/clSH/qtrsxCNfaIuEKOzJuEY+aw==
Received: from BLAPR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:36e::25)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:19:21 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::f9) by BLAPR05CA0023.outlook.office365.com
 (2603:10b6:208:36e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 09:19:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 09:19:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 01:19:03 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 01:19:02 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 01:18:59 -0800
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5e: TSO for UDP over GRE over vlan packets
Date: Wed, 7 Jan 2026 11:18:47 +0200
Message-ID: <20260107091848.621884-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107091848.621884-1-mbloch@nvidia.com>
References: <20260107091848.621884-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2c5806-6053-4838-7866-08de4dcdd79d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BHsZ0zkBfTPuGN2ZG4ZCXRjhjXcBqy/I9Tq7EYu0BQlApRLf8kq2jX6yBRh8?=
 =?us-ascii?Q?hdEcZa9Ya6SHcFloc+T+vQ+lzexQxxhpwtJAi3xUwTq1H+z5hxn1I4xTY7z3?=
 =?us-ascii?Q?Pr0nG4kfRzSr5mF+nkKOd6u2NvlelRI5Q9uXD1nS3C/qf8SQj75blPYEsRO5?=
 =?us-ascii?Q?P++HbUR2Fj3xt3nRuIY7nbmyx7D2jU8NgtBNcI+ckB2cLHWQpF1PS802Qcla?=
 =?us-ascii?Q?2ZO5NK0y9argiXRpRW3Qp/wNn2GJEYPel3d1wqF9U+skk1x6Xjs3528qV6NG?=
 =?us-ascii?Q?QaJ3aLo5JNaX5yfujuH9vgc7dMCk7GEG5eHa8UthWxrOSgLQPHvL4zib4i3N?=
 =?us-ascii?Q?S5/uhehtLhZmvOhdlE3ZgvWvSpse/Wb96e1+xYDJNt/aZVlCxXfSAQr5VFqx?=
 =?us-ascii?Q?wMC0mbIAQ/gqEFgUqYkoNB7qv1F5eoNPGN+6x+s+zddzxCoqfn7MywRMNuFy?=
 =?us-ascii?Q?mILg7STUQ4TlRE2vjbKNOlE2K6tmRLD6Nkg7QU0JsQH/tXAATV5ejMGFhD33?=
 =?us-ascii?Q?JAdTkS56fDEF+IkfmPvRq5287uAK4uR/13ymQD5lbjl3nnkhs7kwjz8CPwpF?=
 =?us-ascii?Q?uaYX9LEj6lOvkJzH5Goc0EtfWKzJHQM934pWukkR3U0po6kgcqmC9sdVf7a7?=
 =?us-ascii?Q?MNTrjaeNzkSNZT9I/nPZr0oHeA4GKwTGLBs17aHrVzMI37MuwfZxmFn6qLbD?=
 =?us-ascii?Q?ukgK0psxqCvCM6v/EmveuMOMUVmjJ3pGjCNdDNHLSAb6m4kxhh+CzdolNJmy?=
 =?us-ascii?Q?TY7xmBvxxRcfhWvrJiZrcZNXSnQT+Tzkb4/yw4dUaK/Jwe9G4qZYVZLsCAsZ?=
 =?us-ascii?Q?V5kBB82UUrN957G4N7mjBbdhpKscaiQ0/gjk4RF7wgWMPRAvs4vwnRnHKCRQ?=
 =?us-ascii?Q?aX3xZOYA2lQx/4U3Pf34/chiYb/qItcQ0/AUhFRZRsHQ9YdE/OE9bA18i+Pj?=
 =?us-ascii?Q?5nxXDsMQSJDcZfuSXn6u++focoJrLIa8kgffYx4C7YZWXMWSXQX05jqOW1Y3?=
 =?us-ascii?Q?Pya2gGO8eqkg2b4liTJtOviZlO9Km8DB+KxoONJIqpF1Umoyak1muy+kX3TX?=
 =?us-ascii?Q?IErCHX+HClr6pr9soj4sFqb3XQ2NLiVPJGNGncgdqKVj4cmBmL64KCDfkEJ7?=
 =?us-ascii?Q?BaqRUxxA6gCX2K0kDJGolGEucP62DznsDvGJTIIJOjQKhcukHbIvRbiJfOdO?=
 =?us-ascii?Q?LXqww+n9CA+83/rJx2uuVnXVwHtSfXHVYYcG7wO5QhkKNKUhYJZb+W+psU40?=
 =?us-ascii?Q?doCTleVr3CeW/qmWWstisc4HVuL74iYTs2oF6HgPg9fKRcQbTWZDPO7slq0/?=
 =?us-ascii?Q?OvzHkRpoTRAgpS+988ciTjfy9xy7e4ivMxle1h7b5CtYSC8H4ZMr5yjk+ItH?=
 =?us-ascii?Q?zNCselZoQzwMapPoe30rV4VZlPGTqTRE279LnCHMSiVBcLJQhbQAd/B/MNGf?=
 =?us-ascii?Q?mTZ/q9eegP7izXEJp+0fAP+/LylXLHBPfsD5oYfBvJqXk9F6H85+fpCiw6mo?=
 =?us-ascii?Q?uCLLlPeqQL7S53BMob9/EaxvM2RSqPlUHTtqU1YqRmQzs/VeFtbGwscGT0V9?=
 =?us-ascii?Q?zVswmzGU4Qj2hksw8aA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:19:21.2580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2c5806-6053-4838-7866-08de4dcdd79d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372

From: Gal Pressman <gal@nvidia.com>

The hardware supports segmentation offload of UDP over GRE over vlan
packets, allow it by adding NETIF_F_GSO_UDP_L4 to hw_enc_features which
will make the vlan device inherit it to its own hw_enc_features.

Side note: it is quite confusing that this change wasn't needed to
offload encapsulated UDP packets regardless of vlan, but that's the way
that the stack handles gso partial features, it assumes they're
supported without caring if the feature is supported in hw_enc_features.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 1734c4dd1d0f..ce71a03a9b71 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5814,6 +5814,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->gso_partial_features             |= NETIF_F_GSO_UDP_L4;
 	netdev->hw_features                      |= NETIF_F_GSO_UDP_L4;
+	netdev->hw_enc_features                  |= NETIF_F_GSO_UDP_L4;
 
 	mlx5_query_port_fcs(mdev, &fcs_supported, &fcs_enabled);
 
-- 
2.34.1


