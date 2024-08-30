Return-Path: <linux-rdma+bounces-4659-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C104D9658A0
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 09:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFA8287E60
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 07:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E900316A931;
	Fri, 30 Aug 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Il1AK3tq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE31166F28
	for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2024 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003114; cv=fail; b=sNDQKfA52zpV9T+PRgpxlx0Af4qQ4mT9QEAWk/OJkJrcV2CYiCZSgkurQfinDS37CiAQxBjNj5Cg6YTwEd62vvvT8O4f0GYEQexOzy9cLAz8d/8+wNCIdRAp1EwsLj7+mGQPO0aEX63qXK8lNVC5LhPMX6JL5BepU8ngcqNbLK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003114; c=relaxed/simple;
	bh=EQFkdF98ImVIpiz+D5z6Qiggi1JO6HFXBAoFITwzt6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfpN2btoG3jS6bqCGupRefyeok8lPbDWC9OSKSkwhzVbtPFgdnnVUHXUFxfHPDCZZSMt3GFZ1PltZSLONcYFOwdmTg9+1ekwhRyRgK0ZjbrCayA/Jd1OZi5K6+jOpu2PeCU7vTSyRLwdpueMYoCbGYect6Z9IGFzyaOmfK2R3Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Il1AK3tq; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGdcJgQKEF53RgaYUyYc50Z7eURilnm8cWQef94CeGkJ3KRKPY/ro1ToEtsRJtPFj2QZTTq/5yqJM0BjgykGhIOo/JeFEsb5k/PML19Ua+8kQCBrc7ucWAl48X6etZsPMOuFI+KkDmgziF2zhIqKR01FVM/3u43QbfvH8l5DGGc1fvpVTahBzOFFh/rALIy3fBChn84VIAlMJvNjcg9sHSogMi0ZI7WhI/i+c106YqfV/HwIoHjDwy1mblWCU5thf+cuuEhBkbYzdlATm20nLdaRXqNDdYczg0qBuQ3ZXOS2m3vKqfXWqsPkuCVk34hxFyB6EhJqArqBNOtzmr4qSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cY+B4Nsuo7WtmAU1ohBNCsMm+kGOeHPENTxEA13abtY=;
 b=ZW1iLOuiPn4mVhwKsny1WkMdmGbAK0i+QePZ8153G9HeeHmisJXpeZmr+gPPQ2hbY/EAGfLPWa1+h2zUWOj1jGSSEkbazZtKZiWANKN0ueZrGN/jR0jamIGj6tref41/DeNBWm2Parocwi/y6TWBp+SaolRjAedIJjgfcfPWH96ljY4SYc3teR8yckbbeQry1jgU1b2yw6PWpiJ0pQvZGFd0EVL31KbNQr8RlS624HQhXsdRXX6k2NriEnb1wXOAuGAndf4PXNz5TgwKE4aMYA7a66mZlnIGcfpRqsqFTwU+GHX3ImCBapv1byKUep/ExFxTyDV//cFlruNN9Q92qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY+B4Nsuo7WtmAU1ohBNCsMm+kGOeHPENTxEA13abtY=;
 b=Il1AK3tql6AtJrvvbqN8Bd4xbcuhq8fspvT3yLPHIIgQPEWZuDlIPCPx9YOg2PkVRCKSWFd6c18garNwxnNM6749fstYW4L7Fq1AAMeQ9f9KMoVHQ4yC0EEIyRIB8ijrQW/XXq3cU8ulQp2VekVPSk8MMOGX/cwm1XK2jvucN5FBlhgm3QxdaYz9+1b0yISB1vLuRf3v5rVx3zGTjREOMosiToYkRmDuC8NXi/wv6VjFkYK3GRJyi04cjMr8+On/hreRMEr94/X37yq62J3yUGt+RvjLIVmI3WNQ75IcsfRbZHmbATciui10ijYNlpSfxMfVMx9hRRIB22yGUD3Tfw==
Received: from BYAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:a02:a8::46)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 07:31:49 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::a1) by BYAPR03CA0033.outlook.office365.com
 (2603:10b6:a02:a8::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Fri, 30 Aug 2024 07:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 07:31:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:37 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 30 Aug
 2024 00:31:35 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next v2 1/7] RDMA/mlx5: Check RoCE LAG status before getting netdev
Date: Fri, 30 Aug 2024 10:31:24 +0300
Message-ID: <20240830073130.29982-2-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240830073130.29982-1-michaelgur@nvidia.com>
References: <20240830073130.29982-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9ca0db-f13a-4dad-57ad-08dcc8c5cf90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?96FLl789/VRO6gAxU+GqTYgW/nIIgXYic4Knrg1u8oAOrw8eDCkAdlRcx1Zg?=
 =?us-ascii?Q?Abbwri2S0HIQAwnJoUsD2JFxr6cbSpsHo6I7tdYhELLQRjhPOaoFaaocozzO?=
 =?us-ascii?Q?i25VJn83EtlwIcdAin+Rbo+dICFLavB3yx1gXAEMZJf9avdD6bQCi8S0krgi?=
 =?us-ascii?Q?3wBkHn+owmgZ6/YmseGdsqzTVmCqHGzdp96BX5536OXNzBOwdUZWFe3jpL2J?=
 =?us-ascii?Q?I0waOqXeOHEWXA0rYSwY/FE0fUd0bVQi4Nx5OCHA/zGDuZ1y7hYODWEBl4UC?=
 =?us-ascii?Q?tCIo4tk6Mjob3QN7iqLmQGfDPU/nT8kESqmKkEaSKSIh0gswPt5izqf9wCta?=
 =?us-ascii?Q?56X8QORIte03339Dvace08m5E2ZQEuMV+WaTRQe340ZTmyGkmNkK5vSDhkHU?=
 =?us-ascii?Q?Nzws+6vtuKjw5QZrbWhT7sIX9wJu6mnXwKXYzQ3gTe3TXS3NlTSpBRGop4Zp?=
 =?us-ascii?Q?qIRg22azUfPHUqIwxOY87KHkM+zjSQVy4eRzD8k2x1fURuYvKGe2I+Kfanjb?=
 =?us-ascii?Q?ADTK3x/4iUqfVUfWRajT0acZHfbIxGw7ggPwMgUFgbvSHxu5EhXMN/AWbi6M?=
 =?us-ascii?Q?QkzFZq0Uax8QzLz3Sw+qNWvLrKMgIOxAeA08xjXt8SaE/OJKPZMCDXSq/yB2?=
 =?us-ascii?Q?VoFZ28XxYWfCbnPcTk58CCm0gwtwWl8dQLCNh/+4WI7Y3e2F9D7HZHx3FGbA?=
 =?us-ascii?Q?D9XXFrZ1fVT0fqqIC5c/OlBC7Xjiw1gOidluBG5ET4w7BZSXYlbC69f6RXiL?=
 =?us-ascii?Q?6tKlCTCyoPy6uF4CzuITcl3CJqnC2FOUuR8WVSnVAmPEBgVVXkdjlJbmkO7y?=
 =?us-ascii?Q?OiiUZsEd3fRfZzMvQBOQQBtEv0B9AgIjJDLUimvqRT8xdY/vA7XbS+i9bZkA?=
 =?us-ascii?Q?CpL5dkUcFpZu2uLvDRQP70Vi6JhrWCTno9mJp7tkLfxNgbNk0/2Ya924pQD9?=
 =?us-ascii?Q?RvYawsSzo8SKg60f3g3S+YKdlGrOlECZCbcbJ0XEAW3atxtZ9/x884XZXcl7?=
 =?us-ascii?Q?xFO9tyKMoR9J3hLp0yZtRIkt1/bOLKF2LDY8lIPgMAeCCaHrAea3HjfxGOii?=
 =?us-ascii?Q?b7Snubr+RPwnxsMqrD1L0LGVpUpAz1kN7HE8TrTqRwyf/8tKWGwMBr2HpI5v?=
 =?us-ascii?Q?PB+QmcYv20BJ7C/UV2cutEDmGtaHrLy/zTyZML6XRwzN6Mw8yDP5FrNK063e?=
 =?us-ascii?Q?o6ZZCMI7/j/tL4gGxVUDKWsn4YXIfxIVlJcEFwOBNbK+TyGmi1Q+CyrfnCQd?=
 =?us-ascii?Q?bRalJF0W0MGgJKLLS+WWFKLmmv4H0vrFU63szXDZ38fqOLLpYpywbFPcHR4k?=
 =?us-ascii?Q?5iKLZznV1NH0+Bsn4LBzKBoBkT6AOhQdYt5A8Pcr7xiJSiVqYBuuPYPLL7VD?=
 =?us-ascii?Q?yT0l12UeNyDGlOhLZXpe3GReZW/SXTb2orzZHScj4uS/aYN1DFfiY1odAOqZ?=
 =?us-ascii?Q?B/J74AFm630wH0DWot6ukNGOQTX1O/O+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:31:49.5911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9ca0db-f13a-4dad-57ad-08dcc8c5cf90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873

From: Mark Bloch <mbloch@nvidia.com>

Check if RoCE LAG is active before calling the LAG layer for netdev.
This clarifies if LAG is active. No behavior changes with this patch.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b85ad3c0bfa1..cdf1ce0f6b34 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -198,12 +198,18 @@ static int mlx5_netdev_event(struct notifier_block *this,
 	case NETDEV_CHANGE:
 	case NETDEV_UP:
 	case NETDEV_DOWN: {
-		struct net_device *lag_ndev = mlx5_lag_get_roce_netdev(mdev);
 		struct net_device *upper = NULL;
 
-		if (lag_ndev) {
-			upper = netdev_master_upper_dev_get(lag_ndev);
-			dev_put(lag_ndev);
+		if (mlx5_lag_is_roce(mdev)) {
+			struct net_device *lag_ndev;
+
+			lag_ndev = mlx5_lag_get_roce_netdev(mdev);
+			if (lag_ndev) {
+				upper = netdev_master_upper_dev_get(lag_ndev);
+				dev_put(lag_ndev);
+			} else {
+				goto done;
+			}
 		}
 
 		if (ibdev->is_rep)
@@ -257,9 +263,10 @@ static struct net_device *mlx5_ib_get_netdev(struct ib_device *device,
 	if (!mdev)
 		return NULL;
 
-	ndev = mlx5_lag_get_roce_netdev(mdev);
-	if (ndev)
+	if (mlx5_lag_is_roce(mdev)) {
+		ndev = mlx5_lag_get_roce_netdev(mdev);
 		goto out;
+	}
 
 	/* Ensure ndev does not disappear before we invoke dev_hold()
 	 */
-- 
2.17.2


