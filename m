Return-Path: <linux-rdma+bounces-14624-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05160C7111D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 21:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B223D29777
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 20:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44280328615;
	Wed, 19 Nov 2025 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tbo0PmlO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4D2DC78E;
	Wed, 19 Nov 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763585352; cv=fail; b=qYVHV8hcoEtWNLA+TdaNr8yjAQKGkkDEFa0+2NtRxsz9enrFYba7ZLVTLlahTxJ2ylNUOkz8ho8dN3v6N+lo9Qtd4oyW0i2Wj4/a+B9Aqmk3HCQQvwEIXUPzhX6xmuohI/M1cdUX1babynCc67Tg8xrcwxYrjbTKF2Rddpp81rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763585352; c=relaxed/simple;
	bh=QUch7ow0tEAVEqbm4mGGPVMRP+OWV2CmbcjbP84gm7M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kVUetN6vsjdIJ2vGvYXbfzosWKQ8VmrAX+Wzwap/NyzN54dYBF3Ls5eAFOV9rnIvgDNc5snLfPbGIsi51fRjWiO7yL8tYOS57t128/m/0PNyS2TzR2heKTyxJ+lA5SLaYFXhKU/kH3I5oZ4qQubp2rFOTSFdj/ZPwS7iXWCA1Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tbo0PmlO; arc=fail smtp.client-ip=52.101.193.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrNLLm6OTOTwDqS+JDDdFAjLMSbR9m3jbH2rs63stivo8Q0JU0SMLTAv1/CSudUN5nMahQm927vTG6fSp1plIUqQ9tcVY8SO8IeDgQtKqmAMkv39Mshj1pMFjebSJZIjwTtlZIOOq+iz56ubKJN0oOX+ODMP8Vc+HAsWgG2n18vRTFxh+tdJKGkZDBlf5P46kIrCkxaUu2YB2ud7jKbFNlIFT3aEc6WuIWNHYvHcUvdB1lQwbcbmpT7Ex1tu4RuXtkED3bFPjiswVW5IAJMBUA79SrA5o6xYlBwg2JJz/x5HnWq9EyTT1bhV/p5avw8KAPI24mUG06t43sNH7dkvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+t7ceFnLgkqB+NEe1NRx7JJMsyMs5WrDSZ0jQ3y4t0=;
 b=Ersu0gl9PO8aXLrBMaczd0SW8wdC7eg4bY7MkkGjncOnPmezNDj5HLXV2JOVPK+GUplG7BZV30ofKI9NMnCsf5xrpMnAWXtUU0MONK7+Rfx5D63ZpUz7n7TF8vmAZiTkUAOVZ4HiEKRJ5dzWXHMOX3vsBH2QMYdzp690NJCgcXE9oUCwEUzopaf9+XwuS16NMhEGv0+TarZRAj4iJkMqTdPh9gI4zL9eDbUnmcY6SdZJM/y6JGwlr7diRhcHHnEHU423+bJGwKQy2bYRzqxX0dBhIAc4qxEthGHu5554AhGfhklN7nAeNxygBT+Va3Er0LFNcxtgq5iN1qk10AXDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+t7ceFnLgkqB+NEe1NRx7JJMsyMs5WrDSZ0jQ3y4t0=;
 b=tbo0PmlOnZ7QBtBKKEFvgsN3RHECuu+yguRCpmS3zu8TGXporwDyIK9KIBfm6YytDqp3+2fDs1xzRXIFNl4t3BHlgMcu8pImwMc7peceDboc5lY7tuLhfgK76Ee1/TL3Pk0053trrDWle016tAzKNrgGCPMKiDBkZUIORpvKcWeLkQaoB7nKFLwCHLxkE/HYFwKlWdbCPhLuwhJH88hVVQdqVkWo242AOBP26r3ZHLTMuttblg+NhWoZUxdY7P4W3WWeGRv9gR2BVBlVR7T3b9WWR/Vj24obDiKL19Rx0YXPaUihTfRfl0SB8iU1zXvBhW0NT+9X269LGXXK50JkhA==
Received: from BN9PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:fb::21)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 20:48:57 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:fb:cafe::39) by BN9PR03CA0046.outlook.office365.com
 (2603:10b6:408:fb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 20:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 20:48:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 12:48:36 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 12:48:33 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 19
 Nov 2025 12:48:29 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jay Vosburgh <jv@jvosburgh.net>, Saeed Mahameed <saeedm@nvidia.com>,
	"Tariq Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
Subject: [PATCH net-next V2 0/3] net: Add 1600Gbps (1.6T) link mode support
Date: Wed, 19 Nov 2025 22:48:14 +0200
Message-ID: <1763585297-1243980-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: db0b5c66-3f16-4395-2771-08de27ad0d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A8noJ2txdHNqeA2m0aaEJk1BikxV/HB0FgFETmFXC14lB0ySbJB4k4Ofs0jl?=
 =?us-ascii?Q?kV3WK/A0XhqXKzL6R/v09pJQuTl53BnhsAra+gFE7wfB5BSqhKPxllZnZrTH?=
 =?us-ascii?Q?K9kkqPDLkRA8cXn6G/aeMqJyVDPbffFxBMz2QG5UFbXCOO0Zj/RdCAVQ1LRG?=
 =?us-ascii?Q?CSed6FuhdBcqRWG+M9GBW0bKjN8ZZdO8wRS0lbmjskNltfJfsIzIXIAWkAtE?=
 =?us-ascii?Q?QpsZUqWkBoEyq5Sc2pd26LXFQTGHON0F6GPCokzTBXs1d1+FJHQGdsxz1Uzn?=
 =?us-ascii?Q?Ai5bQxdXw7DqvjNit0MOilMN05WrCKdlsqCXe6W1xA34C9o5utYvd5Wgnqu/?=
 =?us-ascii?Q?ZQbCkBRMNomwy9N0UcZd/UUFAtsH1dnrSploiIr+uLiHaDyg4oColn4aMSbK?=
 =?us-ascii?Q?8qvVL0hWnrLfUoEQR5eSWGc0QWfJwQaQaSk1NGdQfdaj2kQCHUUbGjAQcFZi?=
 =?us-ascii?Q?dURc1YaUZY8X5UJ2a1g2gg9v+Xt+uxsK1w2rwAUPsfJXrzwf2GKnsxA2bnpC?=
 =?us-ascii?Q?Sl9f3/Hx44AC/BMVYRm5Y3Y8Wety5gPdDYeG6Nj2SQ2NlvZaQdtGaohPpXlE?=
 =?us-ascii?Q?oIc0laDR8Q89EmzSmg8+or4+r8x/5Avtjbvm+iFsAO45WdxwitBs7y0iuWdU?=
 =?us-ascii?Q?zlsRzYgJXeaBml/hyE5WSNVG4I0NErlK8iNuLA7kDsRul7/0YxaoVGfzdfpj?=
 =?us-ascii?Q?t8Os/+VtWbKD0nn5TAiek0fAKFzns5bKhnAol2D2/IhisISUXFFdr2A3IyKg?=
 =?us-ascii?Q?wx/+iRLP5jV0P0n+UeMUlmmNu101D1g8hskseYzQqTZIm1RUXjxnSVPpHVp6?=
 =?us-ascii?Q?XbK1J2rnbzSbVyT711QIOBZ1yspvHFv7x+YhxMII4Mt76aD+UQ0RbRzG4nrR?=
 =?us-ascii?Q?Cpf+vbQnFIlZd7wx5CLOkK4JY2+7uyLf1AZtMjkzW3Bilf7AV4poDQFt6tWA?=
 =?us-ascii?Q?8QFULHorf1nOA+Tba3yJmOzohczisbWeqbvjAD4++GMETI/afHjelXeh6TXK?=
 =?us-ascii?Q?3jdaJqVkjbI/ivJw3TfE32EpCaPMkivSEVQpqDNf3FLUwUYsbBlFQkN+XbLr?=
 =?us-ascii?Q?XxwmWJVaI5ym0Kgx5MqzIGEk0BW4z1UYEkkAr1xNgnh8J38nVIbI3GNve1FL?=
 =?us-ascii?Q?TsfMgfujL2MTQTY5pcKGfOV85dLQjY7M6DgQuOFlHrohrRs/iZ05cac4rniJ?=
 =?us-ascii?Q?G7fWsa6YjnkMV31Qh3LLgRMC++5JCJnIcywxySszgvY35mklPVTITxAVfRyf?=
 =?us-ascii?Q?3qEY3vfeZ/lrxvvMLUXH50gwJPS80LnH53TNcAqb/IcMnOXZYF7JKJNp8Nvi?=
 =?us-ascii?Q?MaaBEX4IJ9SVDAsyZbjn7KThCiCLG0Xn+3cNQVVkOrXIrCLZ7DcoELDgy1/p?=
 =?us-ascii?Q?mhs7HQAzuMXE7NeD+N7aKlX00ZAyOUG+FdUiI+1a8wHzgBIpzslnJvwDoPqJ?=
 =?us-ascii?Q?h8g4lBf9vpwUnGxt5iD3/W5FYeXJ/ElzGbm9E0+Jjds8ij2VfbgExyG0sdRX?=
 =?us-ascii?Q?aGGDEH4sjpmZkw3pCZUzWKsNF718U1FrZcxC57UJjjN99ZN1nDhWNzi25Nlh?=
 =?us-ascii?Q?Y836h6iRAiFFcRNXZOw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 20:48:53.5467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db0b5c66-3f16-4395-2771-08de27ad0d32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556

This series by Yael adds 1600Gbps (1.6T) link mode support.
See detailed description by Yael below.

Regards,
Tariq


This series adds 1600Gbps (1.6T) link mode support end-to-end.
- Introduces 1600Gbps ethtool link modes based on 200Gbps-per-lane
  signaling from IEEE 802.3dj, including KR8/CR8/DR8/DR8-2 PMDs.
- Wires up mlx5e to advertise and handle the new modes (8 lanes x
  200Gbps).
- Extends bonding 802.3ad to accept and operate with 1600Gbps links.

User-visible effects:
- ethtool will report and advertise 1600Gbps modes and PMDs where
  supported.
- mlx5 devices capable of 8x200Gbps lanes will expose 1600Gbps.
- LACP (bonding 3ad) will accept and utilize 1600Gbps partner links.

Compatibility:
- UAPI additions only; existing users are unaffected.
- The new link modes/PMDs are additive and aligned with IEEE 802.3dj
  200G/lane definitions.

Testing:
- Verified ethtool reporting/advertisement and 1600Gbps link bring-up
  using simulated mlx5 hardware.
- No regressions observed at lower speeds.

References:
[1] https://www.ieee802.org/3/dj/public/23_03/opsasnick_3dj_01a_2303.pdf
[2] https://www.ieee802.org/3/dj/projdoc/objectives_P802d3dj_240314.pdf


V2:
- Update drivers/net/phy/phy_caps.[ch] (Maxime)

Yael Chemla (3):
  net: ethtool: Add support for 1600Gbps speed
  net/mlx5e: Add 1600Gbps link modes
  bonding: 3ad: Add support for 1600G speed

 drivers/net/bonding/bond_3ad.c                       | 9 +++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/port.c       | 1 +
 drivers/net/phy/phy-caps.h                           | 1 +
 drivers/net/phy/phy-core.c                           | 4 +++-
 drivers/net/phy/phy_caps.c                           | 2 ++
 include/uapi/linux/ethtool.h                         | 5 +++++
 net/ethtool/common.c                                 | 8 ++++++++
 8 files changed, 34 insertions(+), 1 deletion(-)


base-commit: 865a5d1a29be48875ff68c6ba7e8377180ab8e33
-- 
2.31.1


