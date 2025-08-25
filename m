Return-Path: <linux-rdma+bounces-12900-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E68B3446E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D632049C4
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29239303C85;
	Mon, 25 Aug 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ePyvUe2l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA830275F;
	Mon, 25 Aug 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132559; cv=fail; b=G3p8cQJWeOZbudp48E7LgR14/ke5+S4+dvrLUQrEdNy3Ng7XLpgRvzUOvYoG0Wsd7JQ2qiM2X/D4w7EeujTDa/GTahaJNJ3Zbwsfm1uD6oLh5lO2krTy05O/7eY2GSAyiehUxsY0m9RfqOWVRAcSbjzd7o4SZ5aC2RtqVcnxlj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132559; c=relaxed/simple;
	bh=hpXuB2zCWw8HttZYXKW8PsAFvshtiDl8kMaAxti6F9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XyKtVtaGaUt2MglIBBR8YHxjGF+KYb8x/FNmmyfu65pux3QZpvjLHIpF+j0aK9o62D25VHdYHKO7AKQ8jq9Y9OThrIxkCk+NX2gRx7p19c6m59PSx8D8cSb7HmFjNm+l8dsnLqn9E3Ovuexl5qfXelIT62Rm4zVhZ2PGrKXwhUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ePyvUe2l; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5hMvxg3ks81Wk6ozqlNVyn2vZnwOAvHR//R/utIlv4+GUfEdWr/QQQd/UQ+WEz4g1f4D9+9LW/orTW+P6Mf2LNDclEopheuuBNFXe2sbW1K5nuyS01IaKlkvqhRtRrfMZBGoY54ZK/jNGDhYqH8BEmJPU2v38+bjgC8SfN4GYzQsZ21GqtIaob6e08/rPAsbosVnGrsLm9STyfFyx65jsqWnsW7KLeMFTZi3COi46aW+qCmntpNJmsg2XFfSzIjeaZOLrVoxp2NnEng63VtZJPzuHBCm7fjulUpmryibg2AazdPDCIy+bU0VuiLt1G8SIkdXUtZ0abN4ggX+cFP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2Ygon9cyjuRofu1I6zDqgjsG4kbY/Vw1C/vzgLi/tE=;
 b=uv6JtmjarR1vRRai4oxPoTeytQsYOOZj0eobBsSfTlpFlIr3VsxXC2DSsePCQud6dVYlskS05/cbh/vqi0OIHQ0vNxpdizCf+/ClZL7WWgaiHVxHMOuhqpMO1uWsTO/JkvpwWFbuNmx1fFkaSYE3sRojprWA/wGLxYltXsIMNkzm53Efe5+0Epq6uSKp7PlOnXvOVSB5b8gHHEKuaR2oRdKyBJrzNWjeXLmpxoAVE7XsF+BCoZJPmgDZ4W5ON+iAKYLuNKS5/8wTj/ibYsZYS1iJxMk/uVCnWpWxMKFFNdsNcor81dXl/AlaiInYkowl4eXzcDELqHdMpI03gffj4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2Ygon9cyjuRofu1I6zDqgjsG4kbY/Vw1C/vzgLi/tE=;
 b=ePyvUe2l2/zfd+0ln//5ibAznS64CJmThEs1Z54VbZ4NelLgXZ/jh80my8EQYx2N0PBA8YAzIqksfF3HNnR2NcngJYnoALV9ORTwbLudUESIzuyMiaGsuKChCUhnIN0C1k9zJ6i2OtVlOPIu4VWlb42uMKLQLK3NnaiGfIKhWxIp/h5PQ0ik8EIHpWJKoN15vNKXocrd39sZXb12WcohfQva4EufFiZT1ZU5+wPuQ1I5Ae10/tjfjpObN9Q5miPNOqpcDob7uPfWTpVvXxmzUkFEOBb/cWKKpKNWzGHKNOuPfpRYPrpcWn8VuxXbX8lB59It8vpd3xXaNygyN8zxJQ==
Received: from BN9P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::6)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 14:35:53 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::7e) by BN9P222CA0001.outlook.office365.com
 (2603:10b6:408:10c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 14:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:35:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:35:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 07:35:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 07:35:29 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Alexei Lazar <alazar@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net V2 10/11] net/mlx5e: Update and set Xon/Xoff upon port speed set
Date: Mon, 25 Aug 2025 17:34:33 +0300
Message-ID: <20250825143435.598584-11-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825143435.598584-1-mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 964ab421-dbaf-48e7-0de1-08dde3e4b1da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rfaEVmh7/3WGrMHa4X8WXxADImtCo5bNE8qqfqAkMfJVNmKikehtFykKNH/2?=
 =?us-ascii?Q?hDD3eBxuhOemtpqd4VNXddZlseKPy8Zgy6sr1fYWyJdi+HTTKWUI3Zb1qc6V?=
 =?us-ascii?Q?FQlTK0ZDfRD6xidTLGcVafSk5T+x8N2AoZ7bsKj9IPa42nvRvjZyOlmg2rXP?=
 =?us-ascii?Q?b7udNg5zP4RZsNINWRr0VxMJW5e7Hfo3uabmBnsd59pIpA7Oo7xmHXcU2e3V?=
 =?us-ascii?Q?hrGYDVYSqsokRySV1+3yV41GegNK+rWdiCCR7OqxEEtd6XmUAYus3eN4MrEa?=
 =?us-ascii?Q?UC3CLNEWUER4GoyhBAP3WJLqw/+ZnJUpeCkn5SIAXLSKi1w8ou3G2foBnbu0?=
 =?us-ascii?Q?fiHNFF9Q5+qUqqMignBI7lNo/5kQeRNXw0JvQul2Ps16ZjMbkUrXPHien9DI?=
 =?us-ascii?Q?3mCmkuY2Wcu41yz9AgwRLKtEEotTfM9MOucWglbBempl7S5IHu+U1AJ1Kc0M?=
 =?us-ascii?Q?hoYaLlEmoNjPd5i6DZAbGr+IYr82wTaF/GWolTrhPLgpAYnXD6zzeKTbXZkL?=
 =?us-ascii?Q?t9X6Wf2dNsvFucqDCM+F04FLFuAhcCUbImiCrEwchdee9O3cQtwApoidf8Wf?=
 =?us-ascii?Q?sxucSL6QcDEF4ontNDTL9EoPj9vi5tUHyo0tYskLpR0g7mVeSudeuHswD97x?=
 =?us-ascii?Q?ar4EiPO0gQ+6zYDWI1XD+GnANfol445XKp2suTa4slf+SwL0LonXTbfElqKj?=
 =?us-ascii?Q?uEISWF9SnOEKtAE4As/6Ab+6nLUUN3icLN9DsOLH7g2SnIyovIrUMrhAnMM7?=
 =?us-ascii?Q?/cwCYI5G82LEdLu0UCMPBTc+O/uX/7drPFPEuF0ChBLYb1gmvxlwOkarCydv?=
 =?us-ascii?Q?nSIoQcapA8gRqltRNMpLpR8NQfH8u1iYYVSEul/ZUchrWIdM+qp+AOFkvBfk?=
 =?us-ascii?Q?SF0swAbYYghrKe0G8HAw/EgVZgzj2ng/yy7XP913zHN9PK/JamQMA+Az54am?=
 =?us-ascii?Q?J3kPV2W4wq3Hc7+WO2FXDRAY9gNTGSZOGIT0WQQdfSTdC7xk4tGBqo11YCub?=
 =?us-ascii?Q?cGQ034MyoHFYkgpWYvR3wsiwv3GzoIpWx6aS28SFlXocP2Z0YGKYQk1MezCI?=
 =?us-ascii?Q?UKweYpIfrx+lDrRgEhbsvkVPS9RULNXcMBDPO02KVEvfeY+BtUrmoS7GMLh4?=
 =?us-ascii?Q?jTBFmd/Xg0Vo1OdWq/PpAQ74q9g+XmZb4USo+4+ggFO8yHFqMHnqGXu7OtlF?=
 =?us-ascii?Q?gqInlPU08hjHXHJo5noEEQV1/WO15ES1bVqSrHf/e5HWSGFlCJLLHArYhcUM?=
 =?us-ascii?Q?5iqEIWuITww0U/R5W6IWeLE3v0II3hl8gy+jskeUr5RlrA9OHW52OwAjjBab?=
 =?us-ascii?Q?FF8OpxQoXcx1uybbanp/z470rwHqXUl7tkLI/Q2sEmN5K1Fsx9mKOW/MosGJ?=
 =?us-ascii?Q?x5x3HSbj/od2RHFWWrfmT9swPYzd3MDL4Dl7Y5u7nylsiplMBnI1FEThftMg?=
 =?us-ascii?Q?cGx1C9vhUfEf4Wk0BzwIuCfCwfgGm0IlvqplhhEyWwUIAhqH+26eQidJ5QC6?=
 =?us-ascii?Q?hYMBIjpGFDw0rP/xtxVUf/MTTSiUowvz6V2a?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:35:53.0581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964ab421-dbaf-48e7-0de1-08dde3e4b1da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

From: Alexei Lazar <alazar@nvidia.com>

Xon/Xoff sizes are derived from calculations that include
the port speed.
These settings need to be updated and applied whenever the
port speed is changed.
The port speed is typically set after the physical link goes down
and is negotiated as part of the link-up process between the two
connected interfaces.
Xon/Xoff parameters being updated at the point where the new
negotiated speed is established.

Fixes: 0696d60853d5 ("net/mlx5e: Receive buffer configuration")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 15eded36b872..e680673ffb72 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -139,6 +139,8 @@ void mlx5e_update_carrier(struct mlx5e_priv *priv)
 	if (up) {
 		netdev_info(priv->netdev, "Link up\n");
 		netif_carrier_on(priv->netdev);
+		mlx5e_port_manual_buffer_config(priv, 0, priv->netdev->mtu,
+						NULL, NULL, NULL);
 	} else {
 		netdev_info(priv->netdev, "Link down\n");
 		netif_carrier_off(priv->netdev);
-- 
2.34.1


