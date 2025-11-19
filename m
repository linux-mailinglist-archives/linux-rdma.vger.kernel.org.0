Return-Path: <linux-rdma+bounces-14623-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 88617C71132
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 21:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 759873494FE
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 20:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556E2FF644;
	Wed, 19 Nov 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pjGbj1zw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0942D7DEB;
	Wed, 19 Nov 2025 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763585350; cv=fail; b=gSid+yQpExK8p5nAVuL886gBtuuvZWhousuH4CisSCsZ3AQg4JUcLpc7MOs5MvUKSo+oF2g44iboMCy1kz+EI+bCR/I8+atvRn+5Xb7s9h0b8KKuQnpbro21JxlxGmZc/hVBrZ0fqusRZxgRXyq0o98DHuJ/c9WE5zS1ICR9cG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763585350; c=relaxed/simple;
	bh=uDuafrmXrJZT0mkcUQgv1p5DWVB3mYja1GPS3oAPUFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeKb9mxpJzNj3bHRLS0xWKsW+P2bBpiNJ8WRITD2Z8OyNq7b8CeAPNpqFw2LrK0PdcmC0BbmGUNM/NX+D9QIHvIkY2isGe0g+Dy9eF92zRta85QkcTowzxIYt2YKR92V+dMZA8wK9UzZts9m9x6vmVtWkQTlpdUSSVqatDJvMc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pjGbj1zw; arc=fail smtp.client-ip=40.93.194.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLmv3Psl77vQQLx1Nps0MzVP3EbrSqBQ/ikpqViPopLKx4Kfy2qqdoC1+i2bIGUDKKqtBw7csyCih4MzLMPkeq+4qgtAM6dB9NtOviwmeCde636GSVh5SOB/EagOzl4zqy95qh0LNRk6EyUEq9c0zdqv6Zu9ZLhhOJZzlDj4E1VZTsDU4DMmcxGd/PsQuZE4UXAWtUY7dsRXdUvP5p0gznHCVD/P/563I/K4tn1IHNnx7aprm1B1cF+M8NUv2G6GVS6PxNXW8O/ABKiynCnFHuAuOMZJvusGZzvFyqgkw+YhUyP/x5yS5C2R5XCKWjuyaUsD/pm/RDhIZgMKw+q+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoTDnS++Amolvt35bKEwA95gpWXoXK18hO94CMbWy7E=;
 b=yN+1HRbwaEorAZZtrvmJuOz13B9rIAkfgL+v1cUcSXh66ICKWqFY2yEJFbq2p/ApAa718B6Pjt+BjumaNMfuy6hFudTm7jHnswlYpmNKzoltfkqDAeiP6shVceauAoE+x6ev/6q2IfArYKbPVdF3U3Blm6JMNgW8HTP7N/O+Q+KMASvPnf6W5jxXzzoUFCPJxw1pCbK56GIzO9J48MAiWGcH1S/NxxjNDhj11HcRdfppZJQ8O2eqnLBKImpWMnTIU4fPfGjGIO1xK5Od/gb4PbqKmVqqSm/2vs4OB6lfesIlOpQ60NvYFCBqqa5rDZGFOgjev5C4wdCqN75VcnKz9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoTDnS++Amolvt35bKEwA95gpWXoXK18hO94CMbWy7E=;
 b=pjGbj1zwaPJr4WBNl6iN02mfdb3vBqSzHvIKPwYXxSoKDgmW2Jj3Glgn9naczKLl9E+hT9chW5KGnRMoOe1eMmYP6BJMKg+Av2xXJBPF+mZWDrPzxWHXEtPoVSP6sqvP//qoHY/K5RNFz+Pu9lqUJDzdEbIbWThhDJHuTXUTr47WJHal4xf40iMYnW1ORaXd2ELxGtRVdCF+GuqoE+796rTyM0KJ7Ws0SazEcQbsl6Fsh8O0Z7jFvsSyoI/j983yRgTeW+apEktYgaFBh3Xh+P9beLVi2NFAqRYsiDc9LhntXFEUxGD1xGomf7rYW4EwgV5jXE6x7+HmG7XHNG441Q==
Received: from BN9PR03CA0764.namprd03.prod.outlook.com (2603:10b6:408:13a::19)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 20:49:00 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:13a:cafe::3c) by BN9PR03CA0764.outlook.office365.com
 (2603:10b6:408:13a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 20:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 20:48:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 12:48:39 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 12:48:39 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 19
 Nov 2025 12:48:34 -0800
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
Subject: [PATCH net-next V2 1/3] net: ethtool: Add support for 1600Gbps speed
Date: Wed, 19 Nov 2025 22:48:15 +0200
Message-ID: <1763585297-1243980-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763585297-1243980-1-git-send-email-tariqt@nvidia.com>
References: <1763585297-1243980-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: c84aa571-edc1-4c38-b06b-08de27ad1080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y+CoDmYYVGpu6zpniGXNtK8O2WHrDiCdzXR/ipoKzaOsx3aBbUYxM6/PmDAL?=
 =?us-ascii?Q?36enig/owA0xdvLckWVOdOXb2kKRt+gpBfU3WjQ9h88OToO15M409yiiitE8?=
 =?us-ascii?Q?1x+arlxu7oR7T10IoCftcBML0WQNeIPSXwel+ajpfMkDD/v9fnPLPu/bGgiH?=
 =?us-ascii?Q?K7WJyhYL1nOTyXeYQK+417YsNFuVjgkNtt1ph2w9WrBhAtOZ6/D6r8UUkb+h?=
 =?us-ascii?Q?lYCpV4Mb5JW8qW8em4eKC9rH0HMPAcrLuQGIl69bQ12MMH+kpv2G/wm4WD9d?=
 =?us-ascii?Q?/1g+Qlo8z6nPprtOAF2IaFQ6tjzn0ppYFIDSeKdthgPREKTLyFYHtYBWQ+Fr?=
 =?us-ascii?Q?gqNL5JexoinM0VactAwY5VHBxSpbPThtE3xOkKeEXyoLOWJz9WtkuMCiNc2y?=
 =?us-ascii?Q?fHkAfOzoRQv8KvcgB69p0P+2xIuMcWdi0hG6QbbueZqpDsDme2bhlHY2wWja?=
 =?us-ascii?Q?VNW1e1FI3gSoUBzekra0GU1vlTne/8BYXlw4QtEW4bQytQP/RPaVE5RRpHEU?=
 =?us-ascii?Q?E/Doh5YRUNCORPS0czPDTodIlHoRSvwfBtPot5tLVOJDlrmvjXj1h0fVlL47?=
 =?us-ascii?Q?UQWYEfAkXAw4kCh2Vi7Ua2mYIpEUretpoAsyGUSsFBSLc6kACEwixTmWTZgs?=
 =?us-ascii?Q?V7IpWYlwhXJAbGrzGSo+zSIdO1zDi2xu6bXMx99g9Ve2XNtAP3/mn8EhVMpW?=
 =?us-ascii?Q?JGQZg7emLvK3mT5V0mYbgfq3QiAVGdRdvKZaJQinIjHd3Gkxzf2QzCVNRtmw?=
 =?us-ascii?Q?0lA94+AkYwCzvPoDZjfak96fo0KIdO3pyglMJaqF3lL4EOjIhkjJ+YqNmie6?=
 =?us-ascii?Q?A8WqjDy8n3H+cdGxP9xlJxrEkgp9oVUMxyAhlMWnztIz/GY4YKxDi1yFukND?=
 =?us-ascii?Q?6RVrlSlicdXBXYm8RgKqawTK8iCxGeClRmYr6MOe0o0lDuY4B/7qWkfYGmag?=
 =?us-ascii?Q?VxzP438KHvcCp46QpeDbmxtnbwIj7+hcqEbYojls6p7vd6b0Qea6cF5VZSQs?=
 =?us-ascii?Q?dNjsneMSd9D+oIB9lbK/eWT9KBIWL38ZiFchr9G8U+2KuNRXKXcb9MRdu499?=
 =?us-ascii?Q?ImTKP9MaRaTYqtbQ5RQYH2MFGSkuw/5XlH0Wc2U73TwlTZiHtv1SD0ojrAj6?=
 =?us-ascii?Q?tHLpphLqY6HfIher2xTQqZpbMwBKYH3how5kkUD4jV9PKhH1h7dVwKh06aC7?=
 =?us-ascii?Q?lhGSQRooQDp0U7iFVV32bbDGSXhvzzK+uPbCVFaZX0yOPSVwiXiVBCcc1Mnd?=
 =?us-ascii?Q?eFonoJrS9CBT2DJwiMmg02BD3uykd77wfHT/ANHfIFVaciBphgm8vLAI2Kc6?=
 =?us-ascii?Q?3xM2pKEAHrQXupu6lZJ3qJB6FgvFAA1/DiiWSAue1wGjGH+Lhs3/j7gxfo+D?=
 =?us-ascii?Q?S8yMcvoxgdPpEtfZtxoZQ3wE92GjlJLYN8WwzY8fiKjgiqJYiMFMkdlx9DcM?=
 =?us-ascii?Q?pVS2G84PYG4FSHxTf3oxnYWA1N1DUoGh6/GK3KOpxT+PBbQI0P/21fnnSdxX?=
 =?us-ascii?Q?F2GWcQT+O7Y/B4z2Bj8lOgymFWEmOFgkh1N4G+fhZU4339S4zXlKOyJLrgTU?=
 =?us-ascii?Q?SkFsJIYMWv+1t9DUMwg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 20:48:59.1431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84aa571-edc1-4c38-b06b-08de27ad1080
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

From: Yael Chemla <ychemla@nvidia.com>

Add support for 1600Gbps link modes based on 200Gbps per lane [1].
This includes the adopted IEEE 802.3dj copper and optical PMDs that use
200G/lane signaling [2].

Add the following PMD types:
- KR8 (backplane)
- CR8 (copper cable)
- DR8 (SMF 500m)
- DR8-2 (SMF 2km)

These modes are defined in the 802.3dj specifications.
References:
[1] https://www.ieee802.org/3/dj/public/23_03/opsasnick_3dj_01a_2303.pdf
[2] https://www.ieee802.org/3/dj/projdoc/objectives_P802d3dj_240314.pdf

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/phy/phy-caps.h   | 1 +
 drivers/net/phy/phy-core.c   | 4 +++-
 drivers/net/phy/phy_caps.c   | 2 ++
 include/uapi/linux/ethtool.h | 5 +++++
 net/ethtool/common.c         | 8 ++++++++
 5 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index b7f0c6a3037a..4951a39f3828 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -29,6 +29,7 @@ enum {
 	LINK_CAPA_200000FD,
 	LINK_CAPA_400000FD,
 	LINK_CAPA_800000FD,
+	LINK_CAPA_1600000FD,
 
 	__LINK_CAPA_MAX,
 };
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 0c63e6ba2cb0..277c034bc32f 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -17,7 +17,7 @@
  */
 const char *phy_speed_to_str(int speed)
 {
-	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 121,
+	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 125,
 		"Enum ethtool_link_mode_bit_indices and phylib are out of sync. "
 		"If a speed or mode has been added please update phy_speed_to_str "
 		"and the PHY settings array.\n");
@@ -55,6 +55,8 @@ const char *phy_speed_to_str(int speed)
 		return "400Gbps";
 	case SPEED_800000:
 		return "800Gbps";
+	case SPEED_1600000:
+		return "1600Gbps";
 	case SPEED_UNKNOWN:
 		return "Unknown";
 	default:
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 23c808b59b6f..3a05982b39bf 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -25,6 +25,7 @@ static struct link_capabilities link_caps[__LINK_CAPA_MAX] __ro_after_init = {
 	{ SPEED_200000, DUPLEX_FULL, {0} }, /* LINK_CAPA_200000FD */
 	{ SPEED_400000, DUPLEX_FULL, {0} }, /* LINK_CAPA_400000FD */
 	{ SPEED_800000, DUPLEX_FULL, {0} }, /* LINK_CAPA_800000FD */
+	{ SPEED_1600000, DUPLEX_FULL, {0} }, /* LINK_CAPA_1600000FD */
 };
 
 static int speed_duplex_to_capa(int speed, unsigned int duplex)
@@ -52,6 +53,7 @@ static int speed_duplex_to_capa(int speed, unsigned int duplex)
 	case SPEED_200000: return LINK_CAPA_200000FD;
 	case SPEED_400000: return LINK_CAPA_400000FD;
 	case SPEED_800000: return LINK_CAPA_800000FD;
+	case SPEED_1600000: return LINK_CAPA_1600000FD;
 	}
 
 	return -EINVAL;
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 8bd5ea5469d9..eb7ff2602fbb 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2077,6 +2077,10 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT	 = 118,
 	ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT	 = 119,
 	ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT	 = 120,
+	ETHTOOL_LINK_MODE_1600000baseCR8_Full_BIT	 = 121,
+	ETHTOOL_LINK_MODE_1600000baseKR8_Full_BIT	 = 122,
+	ETHTOOL_LINK_MODE_1600000baseDR8_Full_BIT	 = 123,
+	ETHTOOL_LINK_MODE_1600000baseDR8_2_Full_BIT	 = 124,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
@@ -2190,6 +2194,7 @@ enum ethtool_link_mode_bit_indices {
 #define SPEED_200000		200000
 #define SPEED_400000		400000
 #define SPEED_800000		800000
+#define SPEED_1600000		1600000
 
 #define SPEED_UNKNOWN		-1
 
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 55223ebc2a7e..369c05cf8163 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -233,6 +233,10 @@ const char link_mode_names[][ETH_GSTRING_LEN] = {
 	__DEFINE_LINK_MODE_NAME(800000, DR4_2, Full),
 	__DEFINE_LINK_MODE_NAME(800000, SR4, Full),
 	__DEFINE_LINK_MODE_NAME(800000, VR4, Full),
+	__DEFINE_LINK_MODE_NAME(1600000, CR8, Full),
+	__DEFINE_LINK_MODE_NAME(1600000, KR8, Full),
+	__DEFINE_LINK_MODE_NAME(1600000, DR8, Full),
+	__DEFINE_LINK_MODE_NAME(1600000, DR8_2, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
@@ -422,6 +426,10 @@ const struct link_mode_info link_mode_params[] = {
 	__DEFINE_LINK_MODE_PARAMS(800000, DR4_2, Full),
 	__DEFINE_LINK_MODE_PARAMS(800000, SR4, Full),
 	__DEFINE_LINK_MODE_PARAMS(800000, VR4, Full),
+	__DEFINE_LINK_MODE_PARAMS(1600000, CR8, Full),
+	__DEFINE_LINK_MODE_PARAMS(1600000, KR8, Full),
+	__DEFINE_LINK_MODE_PARAMS(1600000, DR8, Full),
+	__DEFINE_LINK_MODE_PARAMS(1600000, DR8_2, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 EXPORT_SYMBOL_GPL(link_mode_params);
-- 
2.31.1


