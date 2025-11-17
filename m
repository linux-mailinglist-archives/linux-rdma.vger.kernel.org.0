Return-Path: <linux-rdma+bounces-14563-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA23C6641D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DABEA2983C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5B03218CF;
	Mon, 17 Nov 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CV6l+IJb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8632248869;
	Mon, 17 Nov 2025 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414398; cv=fail; b=dlhVi8h4oaL6x8SWHbiPtSKheptz7D61AhcVgR8S00IBN5N+zdIWz5yDE7kwgAI1C1JvvLcsW8vlAcq7msVwthvKkDVucHrP4IUxqx1neBEmsOtDMrqGZuKaSUYtAHhmdAGT5tv8tZTlLTP0mxBBQMF1saRX9xndbQJebQQcOks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414398; c=relaxed/simple;
	bh=o992ka1tKdfiGQy4pPGBHeqy47k1kPNfaDG7BpdmXF8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MXDjF9dO/bqnUy/ps4f3JyS+R93eH3eaKCn0Q8hdIFCDRsPEEb6sh46nn0WWXDZkEp1pUiWPX6xxCPC5cEcCw03bv/QLro6fp/xav/65Eb33bNsqM5zQB0MtWtOwq1euRagZs5qDZXDbTbKsKASJm1duwINpoHWX2gxwc2g9Uss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CV6l+IJb; arc=fail smtp.client-ip=52.101.61.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLYD+7s7Ju7wmBBfhAf3rmgmzhUDS0kljemmJF2GExHCoEBgVu/amUfcvyH4NwC44zcq5BqUaJCddGyfM/vq46WE0LkkTjA1MchY0KZtAfJEgKwyUe2RoQCTpwy4IeY9ZhqSnIFxF7iIiDlwkv1/UXikdxYgZGU1piZLItly9zVzHYuSsLgNaOnvW0uR3tQAgUVb8yo46FmjXQkX0KLfCR0EyXrBpCyhIqaGsPrlQikRjLBG56LVipG/FQRH6OFFu05zxCbgZnNtNQFmIYNG0bqqCjyNBkAgOT4KNpGJ7qW07Sid8HM5PQWybDrG9yRVwo7pq4+rLWYoMXCXo8PhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4igAmeMDrjNXafR8IZJWsqFmtYcNpO7MS9ptGaH/zac=;
 b=kPMYOw51gWFSYc9Lwfi0fRpC5lqLxSLt48jRL/l4cVZuWpEQ3kmIGYc8uzoC7bdDm8uiaHqnRmCR/R7nlzBA0OQhvE/uh4RIGBmfntV0Ol2tg503Pqw07KYDsodJvOUvdLjqIxaWMzwWoKHtZLMHL+sZlHEgGFjApR1zW0gbQyHBZ2B8pZSgq5dpJN/Y5egzztVXRZevrbi4ubdSfogWsXDdRsw6qRVcYmDqwpDhq3GqMEeKy4z8pfzkn1P0fAcms9cZ5w5+jkTLNUA0iEj5bDBLdt4ABXHN0g9nPOXV0eC07VRUoO3EbDiXPCFHqoZutexuaOxcIFEEa1cuUXZvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4igAmeMDrjNXafR8IZJWsqFmtYcNpO7MS9ptGaH/zac=;
 b=CV6l+IJbUA7svmSDXz3eBmsIJy5Mwhie/qyEkm3JBGDn7F1HTQz7yXOviSm1Xa0LR+8k+EMKaxgsdKVjT/WfSm9+eUGRQuvpcTCWlP+2x5OACJ54t8yuAMiITpeyKuE630la8gGD+efy9ZiB3IRGzEFyoTg6YEdC6KcAT6QxlVhtpFCSQEKaiajBoxxfoNLLFRT7WK6Zkm2nFXvFMmTH+e/8cPGQoFaeuAwp+c+8lPn3RA63DfqKm50w+xBMZWwrAV6EerMWQnKwsnnqFfgH+lNHXvNGfr0TRp6225bj5e3tyDXVPJ8REQB9/+TaDLtZ2VhSyAZHMilc1eZ3GPlsnQ==
Received: from BL6PEPF00016411.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:9) by SJ1PR12MB6313.namprd12.prod.outlook.com
 (2603:10b6:a03:458::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 21:19:47 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2a01:111:f403:f901::8) by BL6PEPF00016411.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 21:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 21:19:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:19:34 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 17 Nov 2025 13:19:33 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 17 Nov 2025 13:19:29 -0800
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
	<ychemla@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 0/3] net: Add 1600Gbps (1.6T) link mode support
Date: Mon, 17 Nov 2025 23:18:57 +0200
Message-ID: <1763414340-1236872-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 8653932c-997d-40d6-aa5f-08de261f08f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lykk8E1xCHQ1tqS0wc+Z3Z/HOLdx8eDvmxGSP9N9NZpcW5HVnUOc5gTZodjw?=
 =?us-ascii?Q?MWVGfYxJniRrbRO/P3wi/WKeTjrE0Y0KQrAT7nejN7SjZKphdLcWv1iSJ1qB?=
 =?us-ascii?Q?sGtFzUl7r8JkbZVCrTl8Zjn5E8MFwcbLK6cEg611L2Pyo1GbHV/pZqNzQnGR?=
 =?us-ascii?Q?PSQlfcp37Vc511aPUKbopU4k309dOM5oc1aIfvvLI8xta7Qu/FIbqZs6pyoF?=
 =?us-ascii?Q?GqQE1YPhzl90aZD7ZfATdW0OyHOBP20fJqNDZVUJ5q7eA7fGpHn+gGWKcnWu?=
 =?us-ascii?Q?3R9/oUlZNabWtjjVzGfYcIIXBW9mJfbgYc2RBAZOu+zz0sMt+2IhFRecnUwd?=
 =?us-ascii?Q?pU0roC0EzqYK4nUFqF1qDud0zFhZAB/qhuoNhDz1sOBcPSt6hhJanLOarOqt?=
 =?us-ascii?Q?65L8Uu/RFkOne502dNn9oiMcWv5AOGpOHErYTSMNg/SyaqvpGV2D5BuODD2m?=
 =?us-ascii?Q?0KMF/4fjFpwNGeXsaJPthPFtpSvNNnrRXO/TYL8VU7p+1cO+0+bfPQrvGPT+?=
 =?us-ascii?Q?26V5MOryzh1Ryr7gBZArfyR5en1PZvDG+4YFnIpiOXAYp0c+zTmiiFZxMGgY?=
 =?us-ascii?Q?051cHChrAgU/Yn7For5RS8M+SGhvFNkrz4VYFAct3qw+hA0rWvN1dcWg/EF2?=
 =?us-ascii?Q?yz/W8BrCuosM1xdE1vrBdFf44/ohw81b+sjFH5+TZGqjEXcH7v1V/p7bkLQT?=
 =?us-ascii?Q?v68bgxinDFdf59iyzbFY/udM5+aYLxad1ZEliavrnOErP9BQZih+IFsN/uhc?=
 =?us-ascii?Q?MyKAbPZpZuMrFBlRjS2+0mgxJEFKPPtucmtqxDF8Mh0EvJpdUi/Kcx7lSwoX?=
 =?us-ascii?Q?hzz70l31bKvhvLyeXZ4pYEe073C3g19AlUms240UalcEF2JWzaDQzL6Tz+aC?=
 =?us-ascii?Q?Spi+I1C1eAP9oy5cfRwWDggMpB97lfxRUfmEwo/i6LFCPT6XjAt5waxwLQ5R?=
 =?us-ascii?Q?hJ8xSmTw64VLsFBLdLgeIVksHtgbXdWAYlrrxITfXNAzYqzbp7nvdA+mLNTk?=
 =?us-ascii?Q?tgnKKOUnWSUqqbrjlHZP5t14vx/ygsCXyRO0noWlABE8C7gmK67TCCV68hVa?=
 =?us-ascii?Q?677RgKSosXn177LMbYQJFf81Pi/GHmD/KrW381Z4VhJIAvBbPuLzPULbJ5Aa?=
 =?us-ascii?Q?pgRgoWwshGf010Zi7tvh3Zh4/Z66mik5qQ3LtoqNgRH4jeGU+mGG2iOIQN7v?=
 =?us-ascii?Q?MaNvZj4mvRuieVway3LT4lrTIOdoQxThn8cF9YP+ZfO3TFzN3iqqew4HbXbD?=
 =?us-ascii?Q?iiTlmiP76zJDzd4pmzru+niB7JM7QJOFLvmoEfuFLG7b/Irm+lT6PggdwLRu?=
 =?us-ascii?Q?dzOFkuBVKgq2PlvNMRSipmRZQkYwlZzXnv8Zp2P/n5QtFWLcGqs1Zagn/JYc?=
 =?us-ascii?Q?cTblnAezDkf/1yCLf5xxbCjgbH4FqqR02gOf1cW3S2RSsjfKcT4Z3SjA5FBD?=
 =?us-ascii?Q?UpMvUs4agenk3pqI7qJ8oYc/lI3/59HWnTrRxg9umhJAz6kQ/+rF3EelWbqP?=
 =?us-ascii?Q?UEYecYKT0ygGBw/wJ80vm3//IqE6BR0Da7elRm7/0oetIqq1cgda148Kibia?=
 =?us-ascii?Q?pZ88BeHY/vuZc/0rdh0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:19:46.7581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8653932c-997d-40d6-aa5f-08de261f08f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313

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


Yael Chemla (3):
  net: ethtool: Add support for 1600Gbps speed
  net/mlx5e: Add 1600Gbps link modes
  bonding: 3ad: Add support for 1600G speed

 drivers/net/bonding/bond_3ad.c                       | 9 +++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/port.c       | 1 +
 drivers/net/phy/phy-core.c                           | 4 +++-
 include/uapi/linux/ethtool.h                         | 5 +++++
 net/ethtool/common.c                                 | 8 ++++++++
 6 files changed, 31 insertions(+), 1 deletion(-)


base-commit: c9dfb92de0738eb7fe6a591ad1642333793e8b6e
-- 
2.31.1


