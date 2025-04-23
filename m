Return-Path: <linux-rdma+bounces-9708-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE48A983DC
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8ABB7A811A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 08:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06831280A5F;
	Wed, 23 Apr 2025 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lS+WIGSZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426DD275118;
	Wed, 23 Apr 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397417; cv=fail; b=RHoP3nxytBakuknn9VJ8FHIbv5qYKossBYcRuQpqG6qwKnwLF/BVR7+fVDwOPz51BkDoxmUlvDVuJY8Lyk4t4SJoZGCxVwFYYxs9KfEszZSH42yJFCMwdEQxm3/m3OaZxNWeraQpKg33B8HMRaHhy/ehrYmg84pnGfZo0JjQJh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397417; c=relaxed/simple;
	bh=q5bJgQagCzEanAJq0pAHCDKTVDfnUDYxEYEplUif9V4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdLxUZiUlFJxUpQAD3FYKb2Ady7H6VogozLRXvtkscpHTgHBjd397Fp3P37vPPlsOlQ37YqlTVpAtnDhiTmhAhnwPT3U45ortlamLDwlaqn4h1XxZUiumR7vkU3qCZNaYf81K3Cn7uilayqYKoVRP15k5X78qlKzQIGdEQ/fGSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lS+WIGSZ; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDGybDeaSn5YlzGrxcdl9ojNKmVWviAZ2HUM88h68p9KYOElvyj2dV7QMOCUk1Pa39B3OYE96qHPTX4B+DCBo3igTtIwkD2Zwjkimmk/z5vphMeKgZKjF+eWYBOMrr8eLaHE649lOcb+NRoV45di9f3HDgkZ/3rss+PEnYcpnsrZI9MYmat7lRfHAdOrGlLKrwBmCbv1O6016XFqmELKvK35KteVaqQw1EcCIeQx2i9/TJKh2XUuWwcI8ztGHg20pyW5anKh97drXdqbuUMUy7wCDX21nozE4mRJ2Sr3FX9eFDpyShMPEIOEmPFbCuBiA0kOb6eOuOTDdOv4zW+QuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuLsWTWIlxmmI7742Y8KZyxubJ9feDhmVqQzDjxsFtQ=;
 b=EI5JJgeYbHd3VlVAe1/e8S1amf/s+ACkzG/owFddDhsRI+S59EPu7QcTUltWi+aKlcQxO9Kaa6PWpYLzHn/GK2OqiIfuv1BHG00Re1A1ohn9UIDJB1VMSu5BOnEp42XHpukuiHsiJA7mFV422cw0Mi3UCZ2LPL0b7FbODLr7rgQ6D6VVwfjf1wRHM3Pmuub3FEqSyAQn/7GMKR8SihXl86ut2L2UHf7YHGSKL/AEbhZTgwO9oNBYMyUxoEYIDePji+WN7u5G4WWcS5IEc582xkwBP793AzOU6ympyu3BtB6tr9QFaRIqHdjDPLqytAHs+zb+8jIxPgvXJIymzsmtFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuLsWTWIlxmmI7742Y8KZyxubJ9feDhmVqQzDjxsFtQ=;
 b=lS+WIGSZAmpM6AlgMMGfdPoP1z0L/YlUhkJnxPpFSXfNjIZJQ2TwPkxDvaLmaaXbjHK570B2gmBApcoNn7WCxCb8V22sZDxtRDykLnXPub1E6j7MLFMWjgkDa2B4w+xxCUrZeqK5A7P+3JyekZm+8SB7dOwrHfG1iDEmwKrELYCGObuIpC2xPE1bJBNpTuD6wyoQVmajeettaX21gSHZlGVWP1ieTBw22h2H19rof74Y1YPKWSKwzvHRyntkpOfzfZYQR63bmXyhdopTj4LuWTiVK16CLVRYaf8/Us6VYgxLBT/P08751t+qkijo24VO6VuTyfRolO1SRIOb7MxJPw==
Received: from MN2PR19CA0016.namprd19.prod.outlook.com (2603:10b6:208:178::29)
 by CY3PR12MB9608.namprd12.prod.outlook.com (2603:10b6:930:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 08:36:52 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:178:cafe::f6) by MN2PR19CA0016.outlook.office365.com
 (2603:10b6:208:178::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 08:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 08:36:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 01:36:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 01:36:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Apr 2025 01:36:33 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net 4/5] net/mlx5e: Fix lock order in mlx5e_tx_reporter_ptpsq_unhealthy_recover
Date: Wed, 23 Apr 2025 11:36:10 +0300
Message-ID: <20250423083611.324567-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423083611.324567-1-mbloch@nvidia.com>
References: <20250423083611.324567-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|CY3PR12MB9608:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdd680c-0608-4d67-85ad-08dd8241fedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wsfYsm1q8tMiBt9LB1EFrZM96nWZkOuatmJejjDHZiB70UDQ6zeFROJBvCM4?=
 =?us-ascii?Q?kJbRqQTeD9AXWQ2Q20ni+b9O9lrNBWMNbBCCBD5OlvnN1N4V0ioaT5KCstnx?=
 =?us-ascii?Q?1UY0zj/hm+mLMjyaO0RYdY0jVtZm4mu1pvvLtCs3Q8TyyRp7WGA+oMJryNjY?=
 =?us-ascii?Q?PV2187wpQe7N2gCBheYIyfub0kCS7Slyc1MESRaDiw6H6rOtbIgY5nV3ahyZ?=
 =?us-ascii?Q?lQGikB4XWEJeMiq2217HkS4D7qMcbs2fAOMyDssIUm4YsxrKx0R3wX1u1RuE?=
 =?us-ascii?Q?93tEWDspwPzdvwCh+WDsyGipwsDY3QOwINyZ8asVPcLovYrII6u9C0nmpPwi?=
 =?us-ascii?Q?bXBuKtE3Pdl8ueGa18uXk9X3NR4oJLbX1cvVuv2LQOBhTsh5dwiV6fSuWEXM?=
 =?us-ascii?Q?Y0ZKpeZemLMzYLzhWfbeZiBdCjSeOE8iRsca6sYh53oAs6VfsnKqGiaU1W4x?=
 =?us-ascii?Q?sPoZCuxxC67dugSG3xBV0pxFsJ8C7Jjj8TrHHx2bltKRPEk5VygwfEX+u8tK?=
 =?us-ascii?Q?noKlIDL9fHayzk8br49yh/lguwxZsuziuwNveOJcTvPeXAWoO5tzTDVxOz/P?=
 =?us-ascii?Q?M85RpLkqfanmcDKR4GgQ3Ur3LirrcHZYjP35p88DcJIkLzw53/sNR6KPazAl?=
 =?us-ascii?Q?f3ZsSmj3/vtCHo64oC6Bs1GIXhQ3XSmzzF0S5dx++9O9mQls7q95W/wfPPDh?=
 =?us-ascii?Q?wqMd1oVdOyJszGML0SVrvdvuZTnlWGmIYToURcMiYTjfuvnuqIH4TrMlBirF?=
 =?us-ascii?Q?Yj4wvw7JOgAzjh+iCJ/mQxfvknAPPLQioH5JYtgW4l4/KZ4CfDwh1Kl4kx1t?=
 =?us-ascii?Q?cjRGp1NrkmAwHfcPK5vCWejEvEVxrXaWLsJdMhR8Eh+DUO4UmoC4zyv7oFpO?=
 =?us-ascii?Q?u7ZI53jdIAKLalUncMofRn4vWxWpSY3+jwuKvaMzrSDd1UVyU8RyChiFTC7T?=
 =?us-ascii?Q?K4H34VtIeghBRKvfTmbZSKvv5YgU/MuO3js1T6Hf2DNYGVBCpWDnU6c0bvM7?=
 =?us-ascii?Q?m2K+sVhYSxJR69RSFOCUOqkKXN0dW806fvWd2kPCfIB2SOn9/eRXz9biObGO?=
 =?us-ascii?Q?e6vXElKBUJDsBSS9GkxYSLjaRcSUkfA7wclNQ8QuEZk1LyF3wz8BDdRPgaQk?=
 =?us-ascii?Q?gcYuyH4LVLcXfxX+//LTQ5NrOepC7btJnH0iyva+efcTdbVPMSwOtCisVfF5?=
 =?us-ascii?Q?lhMgzrPayv0c4UBxYPTOslYxdIRwWYiEM9dwk/w26MKM8pJdMEKOOQwjIive?=
 =?us-ascii?Q?arz3lHTuEbinHDiIonctmSzScujRGq3SSFOeeboccPTlvj/W0+t1OswdL9UJ?=
 =?us-ascii?Q?gUzHGkgjhaeQLKCymgnwJOOXr5QZQLJwrebJgDSeWJvDyG1o6RUw4JJRmjbu?=
 =?us-ascii?Q?ejtuc4Kf9dLIoFEB6f7f8hi74pKdS7ASmV4WlgcbokBCeZyBI1rEAqEY7O0H?=
 =?us-ascii?Q?OiLLDOeVVUkcpX+Ccgvyh2KyDEp6BYjAscYPDZloZKZO3J0Wnk2gATLEUJB9?=
 =?us-ascii?Q?qNvRfsa+EHOjLdkuRZ3B1vlMpXtLbXmYlciQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:36:51.5079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdd680c-0608-4d67-85ad-08dd8241fedd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9608

From: Cosmin Ratiu <cratiu@nvidia.com>

RTNL needs to be acquired before state_lock.

Fixes: fdce06bda7e5 ("net/mlx5e: Acquire RTNL lock before RQs/SQs activation/deactivation")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 532c7fa94d17..dbd9482359e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -176,6 +176,7 @@ static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
 
 	priv = ptpsq->txqsq.priv;
 
+	rtnl_lock();
 	mutex_lock(&priv->state_lock);
 	chs = &priv->channels;
 	netdev = priv->netdev;
@@ -183,22 +184,19 @@ static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
 	carrier_ok = netif_carrier_ok(netdev);
 	netif_carrier_off(netdev);
 
-	rtnl_lock();
 	mlx5e_deactivate_priv_channels(priv);
-	rtnl_unlock();
 
 	mlx5e_ptp_close(chs->ptp);
 	err = mlx5e_ptp_open(priv, &chs->params, chs->c[0]->lag_port, &chs->ptp);
 
-	rtnl_lock();
 	mlx5e_activate_priv_channels(priv);
-	rtnl_unlock();
 
 	/* return carrier back if needed */
 	if (carrier_ok)
 		netif_carrier_on(netdev);
 
 	mutex_unlock(&priv->state_lock);
+	rtnl_unlock();
 
 	return err;
 }
-- 
2.34.1


