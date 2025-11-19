Return-Path: <linux-rdma+bounces-14625-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E4C71144
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 21:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE3504E2EA6
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 20:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8889357A5C;
	Wed, 19 Nov 2025 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z13GU3HS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881CC34D4F6;
	Wed, 19 Nov 2025 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763585360; cv=fail; b=OE9Inr+sEQoMnaw4bzRolvpdcqndL13vGPe4n/Xxg5669PFbnW4upzTbN2FfIiI28sDcFt12C6y5T0HTH0ZqD6FwmgAIFV1XrtGSAceMU5hPBKUTf6vr6zhv3Ky6WUChchmBYfhs9DLhj0Rn2lpJg0L4ksl2Ml4csnKZaWq4Fkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763585360; c=relaxed/simple;
	bh=Pf16QcSJWOdZAPOHQIIu1FcTltrTbLN2LbnDoL8QYpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsnOajIUXnHBCtR08YVmLpQ68a9D9irDX3y66NLnBuOF7wBmBWEvMg4olIu82T/lpaUmmKawF2wwLPC6dme301cBZf/sq9YweUyF+lQJpn9phuOkUnVQMFGo/BOpUTIwkrnrIHp+oG74Ng4MoztqZBsuqioJHm0gIKW8amosiXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z13GU3HS; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9eoF0nHXZe6Yj8JXug240WQKGNNC8JQGW4sBsjBd+ogIHd1Wb79MHssK8Y7X0UtlsNU/o9neSJSM2RpwTFJ/1Wt+qzmE0BULJHj2x3ENqYbgllBOU6EFYu3s9JCrBlJhPHS75iNuH72cEBv1GauiXxL+TcnStdhdFCQcqIAkgE60SmNEQkSeb6MhMQ7tPPLoG988t9D8pBvvB78l48/gzNP+Kwc2D0ZUd6h327ePPEml/za0CkvKYTwywEPRpjjXDX/KpYHLL5QQ4f1/TmgxD3+XOXwB7I+SGsC61PBzgzasZTmHrQTRHryFKCk6Jo3KwxTpDfYVkTxQwXspV4uzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWkyx/v4Wlm5lKp/m8ffXWetGH5ykWDjIz/3LRW7Qg4=;
 b=UuIlwITFZxUx75rxe1T1EeGRk3wQJrlE2o8NHaSxA7eUekx8BKP7amOG6lHGFIimg63UIZpUApcooAhDEsXzvtJyP1fHOOaCLoGq1L+Mf3/A5oUNKJazNfr8Fl2CojBCXPSIbyStn4g3gRTH0Z8DWYt90bon8TCHm7zH1Bdfs8O8agPLNlCz7je/7CxM5pGbg+7VDOio+4SsoyuWPK69A3et68XI4X4qkqVhHi+inhU9za6mUqLxFvQNU7Dca/oL5IM42nJmVCqhIm5jN/ONlgIz9z94MS56yVROvLLlpeMCW9c8MqTscEjAE9NinT8JrIzdX3JnBCoIbx7XIZJDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWkyx/v4Wlm5lKp/m8ffXWetGH5ykWDjIz/3LRW7Qg4=;
 b=Z13GU3HSLTQoxh4p3CHCYv/tGGy/IAsSlnnpS+vwuuz6o/0RStmfbBIXPMpGyzri4x0gb6g8watV/gW3Emd/UUOd/ulP0lruSvcZE/prmVuXFkELqocnGH0SmvsJ/fJktUCwZIkmz9REqrdMKGYuCl/D+j8vlJHpIELKLSZPbHqxRUVBFIs1baUmPV29pu3CFKroa9rO+XVdLWcr8MK4rQ1boYR/xGUly/jsMFC+3nunHiSmSzLEvcsy/FaZGw+fy9umvuvLgXo/FxefEvOxVZJOX9ZaJua2tb1Pg3pUfmxkEEZAkB9YO7+HC4n2oe3UW3H7GqcaGp3n01FSYisIrA==
Received: from BN9PR03CA0237.namprd03.prod.outlook.com (2603:10b6:408:f8::32)
 by LV8PR12MB9713.namprd12.prod.outlook.com (2603:10b6:408:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 20:49:10 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::fd) by BN9PR03CA0237.outlook.office365.com
 (2603:10b6:408:f8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 20:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 20:49:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 12:48:50 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 12:48:50 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 19
 Nov 2025 12:48:45 -0800
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
Subject: [PATCH net-next V2 3/3] bonding: 3ad: Add support for 1600G speed
Date: Wed, 19 Nov 2025 22:48:17 +0200
Message-ID: <1763585297-1243980-4-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|LV8PR12MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3ca0e4-7395-40a4-be00-08de27ad1605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HXj19oCotGGHdcTDf0I5v7m1Q9Poa20c4HAcWHiotQh/LgwBw84Ct1K6nac3?=
 =?us-ascii?Q?ag9ewUhik/G9r3WWftB8AJYEtGeoKdFVlTrzPsY9mar0FfsX7kr4e0x9z5R8?=
 =?us-ascii?Q?HXQVS3hWh98OzYCFMXB8SUTkHblELobRonONRNEaI5dQS+W+1AmD0MTbz2PE?=
 =?us-ascii?Q?+Uh234b3tKHI9xAz3p9N/6NAiMPaIfPRzlp7xWzut1HV0jpgK6904+V7655P?=
 =?us-ascii?Q?APMVVXuIis7Mdj56oqRuO3Rxv3xrsY5jXbgk8TJfZFSp04dzz0OhF5GB6IwQ?=
 =?us-ascii?Q?9AlchG05IN4Qwy41RetPDque8Xh/6Mmg68/ERbQc8fjjC4b2Y66XD5FFYLVT?=
 =?us-ascii?Q?m7P8gC/VATESMUaVv/AL7FZfQvZ+BqtrOdYnJ/aYopQ5AMqe+BKWCFECPiht?=
 =?us-ascii?Q?2598JDuB7eQmKUBv2I8kCSgCb39jUpHJ3pDwu45qN1lAQ59kNcMrtOHW/2MM?=
 =?us-ascii?Q?Qa3Pj1bsmvIUo31n8VHZ9HQj0Ow6dSTGAX4g+hbV7ul5MB24+R/OgX4smC9h?=
 =?us-ascii?Q?/x1Vf1BnLT54YIVPMIYzVDJOryfw9W8VeJlAkuyBl4BUQCPFPdfrJxiKMXIB?=
 =?us-ascii?Q?8ub6TMZom5FVmkdX4uCylG363XYeecKdTP5HxveM5aI4TDTAytl8M6zKgnWF?=
 =?us-ascii?Q?s1Q5/F/mwIih8S0cSPVdAZAdIsLaSqJUhRqE7cH8viAM4XWPi/Lc+rWuKhJ2?=
 =?us-ascii?Q?HiU0/uC0JHJeBIG6JyYbaQGIMUlL/uxLT3K7nk9mMQbhsTz6nviI+RpAQ4E8?=
 =?us-ascii?Q?+qQc+FLMKp7qlsO/LAlrj11sdCA4HOXSJHIjhzuBNPx2TuRYTL0kE/cNO+NY?=
 =?us-ascii?Q?IoBuI94JWp1+bRX0myKT5TYhL8eLIbDjyedw6yW7PFR2x/ZePPs0lDYqxg/2?=
 =?us-ascii?Q?+JFmB1fifrnM/5E6B1kjJlPAamY6OWB70MUffBlVVkN3A11G+bZljwKay2dp?=
 =?us-ascii?Q?dAlgQseImJhf32TgTJ5XooqlXIezVwKU09oPRAivIx9w9vNruBi3IOANYO8z?=
 =?us-ascii?Q?/SoJAb67W9/MslMN6oQxDCFGB9f42NjXKezBTpJihJ+/Lyk2YGEHg4EKinjP?=
 =?us-ascii?Q?R6qBe9GvjaFR+Rd0Rdxoyad8SzTXXxpGB5wg+imoXfPGQ1RuM7v54hZ7VH5W?=
 =?us-ascii?Q?He0rbtlgPZddN8D9S/irULGnU3EUTTVC98gXhCoF2Lrk1KatxCi6mCmYQ0UC?=
 =?us-ascii?Q?h3K7ljMQJIwvRO8WPkL473emuykydr4PALA5bqx3ZjDOUj8aGaRWICPFloCH?=
 =?us-ascii?Q?ussbDs8hrH+hhjz3ax+RVQdIX8EjAIwOYQ2/+IWxYfuQnR3zrO4HNFf3sxEG?=
 =?us-ascii?Q?dnlPIv0KdTjxd5unM+okRi42HUT62JymrP8gXLryyF4eVDfcWoeFLxSsxz4q?=
 =?us-ascii?Q?g9UsnZhixrD2Uch2Y6cCq2KZ1EnYLvrtFXn/uZdtXbYpMwFT4WV4lEPhpYZY?=
 =?us-ascii?Q?uAvWzEyAU5I4fP2I5Fmcda/QQFf0CNx1+RIc3DxABH2EP26WvviG+Tlyqr5Y?=
 =?us-ascii?Q?eZsvcbl3FEfcKMT19UUmzwMmKcBsQBXfL1WIPcgVv0rKvz80ZKude6UC4JLf?=
 =?us-ascii?Q?c3X+7ubroUjQlZpdMbw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 20:49:08.2396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3ca0e4-7395-40a4-be00-08de27ad1605
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9713

From: Yael Chemla <ychemla@nvidia.com>

Add support for 1600Gbps speed to allow using 3ad mode with 1600G
devices.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/bonding/bond_3ad.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 49717b7b82a2..1a8de2bf8655 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -76,6 +76,7 @@ enum ad_link_speed_type {
 	AD_LINK_SPEED_200000MBPS,
 	AD_LINK_SPEED_400000MBPS,
 	AD_LINK_SPEED_800000MBPS,
+	AD_LINK_SPEED_1600000MBPS,
 };
 
 /* compare MAC addresses */
@@ -300,6 +301,7 @@ static inline int __check_agg_selection_timer(struct port *port)
  *     %AD_LINK_SPEED_200000MBPS
  *     %AD_LINK_SPEED_400000MBPS
  *     %AD_LINK_SPEED_800000MBPS
+ *     %AD_LINK_SPEED_1600000MBPS
  */
 static u16 __get_link_speed(struct port *port)
 {
@@ -379,6 +381,10 @@ static u16 __get_link_speed(struct port *port)
 			speed = AD_LINK_SPEED_800000MBPS;
 			break;
 
+		case SPEED_1600000:
+			speed = AD_LINK_SPEED_1600000MBPS;
+			break;
+
 		default:
 			/* unknown speed value from ethtool. shouldn't happen */
 			if (slave->speed != SPEED_UNKNOWN)
@@ -822,6 +828,9 @@ static u32 __get_agg_bandwidth(struct aggregator *aggregator)
 		case AD_LINK_SPEED_800000MBPS:
 			bandwidth = nports * 800000;
 			break;
+		case AD_LINK_SPEED_1600000MBPS:
+			bandwidth = nports * 1600000;
+			break;
 		default:
 			bandwidth = 0; /* to silence the compiler */
 		}
-- 
2.31.1


