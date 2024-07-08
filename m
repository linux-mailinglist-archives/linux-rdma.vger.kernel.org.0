Return-Path: <linux-rdma+bounces-3737-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0062292A215
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67733B23943
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1E147C82;
	Mon,  8 Jul 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rXDpIksw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C982890;
	Mon,  8 Jul 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440168; cv=fail; b=CaHDELt0Fw31pGcDyjqLKLuWFPXF6IDFZIb7JNadysnnX+w4D60IABcxDXszmVknPxeu37JevXddsYurS3R/MKVF46EI8brs6tUB+4LuJ4OpoD6JjgY1r5Cwe4E2gLWHG5XE+qhSjKvfG0vYqEyIP1Sx0yur7NSAIPnqXvQyLAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440168; c=relaxed/simple;
	bh=Jmg0lX9kI2mTutWfxJaAfBvKbIiZJH9S+WK9WdEv7ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WmON0xJPmDE+uekmSlWWBTlu6eehbtMstmeJKc0RyZokVoHWNJvwiC9D1VRREUSfdzin6lSNH8TjcM8LOjzKyoqIMu1VYxsv/Ddg7YK98OzYvKUpnD7sU5aPDMu7aTOsoo5L1XCng69JFiDo7LckuDAW2Uw7drITgU4gq1PWSoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rXDpIksw; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxLdk45+UkAbwHqJ1y5m5lw69UCByxRjeDuN8VRCeVa5yLq8dLfr3f8BxfGWLfQDdgg/iK+fDi0kpGkxsSEgvpe/TQ2WZB6AduA2bKYUk7KLS/UI1Ak2SWFeNM1sou7peuXiK8LrQF2X6Q7wyh4ct2JoKVBUGrK5mMWiMM7tTOiTQaBS9jCoMQMbXsshXbeP5Uwq4CTe1YbhroJgTBxJbPY8FAgXKvgfjuZJHHKLET2nqTSsxAanmfmSTLzgB3h5rcVcsbcHi8teNr6JeLj+0qgW0XeR2jqhvjxrtJryrCMCexzh6IMmml0zEmE9rEWB11mA+PchUzaeo9fFQ8lAIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZmrnDTDujrCA2ehSWNDSWbCBeJWkGYBl2e1QrP10lc=;
 b=hmbU+3IDBGVAH6xUEkk8m7ULvd8+Jcgwu4UIEfbzYw7MpcuR/KGY/2DKAmAjiuo/b8lEtcQmff0X2h5909YVdlVmyDJ6y291L08Ew1dSjXBE1bxoMckSDIVX6yQWL4nxll0vANlsIwWYUb55uLKvfWIcANzDJWQauLnxiEbEex+I/ias3eAm2Y/zbLrMW421k0P2FbXJYFeeDx7Jpsg02XqnvRRzcA+A5r4nzLgr25k2nmMMpaB3QMhQagiYEaDJZNX3q6LiY3xdLAepkJie574Bn5l1dfYqqfHdyNbzCCl/sqzq8uDAoEuAu1znnva9ZMgcsNqrGOGqdA2YNeVkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZmrnDTDujrCA2ehSWNDSWbCBeJWkGYBl2e1QrP10lc=;
 b=rXDpIksway/CDPUQ9o+kZOqlzSZYdoOggvXgJ++T3Nr28F25dAqf/xPlXlVEl8ZHHXEcM2MhBkoi1qRvAQ4/heKHGqsiORzm7U3va5vAyiYYIbjzdBsUvZxHiEgHUguE6n3XWO43aCLS5sOFFeGDoGGaXhLZDBGnQzCKj3bqbPJde8bwzJbQHylx7LUIWUBXzMALBr9/EOFxpztBxJZ8rE6oNwfMImym8dY9NuKah+9sowkyiWPA5cWwTHjDyW2icmi6+6FzQ11copCz+Mg3m65vEPi2JA0i1LKAGhcHR+qigefR0f0+YraB6e97wclk+TeXXKYVrhtI4o1F8nQcKQ==
Received: from BLAPR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:32b::18)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:02:40 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::13) by BLAPR03CA0013.outlook.office365.com
 (2603:10b6:208:32b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:03 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:03 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:59 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:40 +0300
Subject: [PATCH vhost v3 16/24] vdpa/mlx5: Accept Init -> Ready VQ
 transition in resume_vq()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-16-afe3c766e393@nvidia.com>
References: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
In-Reply-To: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 946b0729-f28c-44fb-59e1-08dc9f45ddf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk41U0ZFN1FiOW5XbnQ4SmowZVFXWjdXV0ovY1hJZXJSMXNXYmhKQkpUem1w?=
 =?utf-8?B?UEdpNFpsVDV3S04wbEFMNENxblQ0eU5qRGNWOGduR3VuRmo1R2lHSkpaYU1n?=
 =?utf-8?B?cUFrSk1YR0RGM01QOEF5dFp1c2czU0ZkVXNzYjhsa0JvWDRJUC9YV3FmZ2xH?=
 =?utf-8?B?NFpxN0hiM1RBUlcxcHJRK3ZENGd6ejczRmdadnU5Y3U2YmltbVVsRjBURyty?=
 =?utf-8?B?eGgzeHE3V0haODNhR2kvaGVySHZYSHZXYTg2Ukt0Vkx3U0dLM2p0VEpQK3pT?=
 =?utf-8?B?cTVaTTJIL0E0OVF4MGovZnFGbWpxRmtOanB3T2ZLRmt3NWhUYlFLYmUxWUY3?=
 =?utf-8?B?UmlkdmRMdE9PSnpYOXVkblhSamVBSHhQT2pMNFFtc2FFd3FtSGpMcVRMRk8z?=
 =?utf-8?B?NDdxYUhqV1czd2hYT0dzVmhUeFZjTkg5Y2VwNVlrbFRKN2lhU1g5dVVJbS9L?=
 =?utf-8?B?clFPSjhkR3BEcUhlQXpLM282SXRzRzBjOFhNd3Z5RUQ3RFM3anRseDN0SVU4?=
 =?utf-8?B?Znozd3ptaU1HMUROdk9seUliejF3V0haR3ZOU3RpZHdRekU4cHFtc00wcmdU?=
 =?utf-8?B?ZnExd2l5eXFIWmxDQ3RaY2tGam1WYjY5YkZwZWJQRjh0MFNrdHRWL2RUWWd4?=
 =?utf-8?B?dDB1NThmRktuZEMyUUhSaWM5enY1ZWFyMTJ3NFhja3EzVWo1U25JZHJoS1lN?=
 =?utf-8?B?ZE14SzJOZWJRc1ZBZnhhSko2d1A3WGE0NHNaVmpQQmljeVpYejgyelhSanJZ?=
 =?utf-8?B?SHB4QWRlaFBJNyt4eUNiOXJNa2FLTHgvNjRQT0xnQXQ1aVVVTWduT1NNMnpz?=
 =?utf-8?B?ckdmQVIySWZzaC8yS2trWUxXQTRqVmlRcE5CZjB0MVhrelZtMzNLTVIzeWRo?=
 =?utf-8?B?SEVDMEVNVVZsZ2hDVGZRQXpyNnJMSFlyMzBEYnZGdVN0YzFSZmpWUnc2UGl5?=
 =?utf-8?B?RkxxZkJmU05QQWQyeXN0TWttTlppUUl0dXBodngwYnVzTERJTWdHUHppTllD?=
 =?utf-8?B?NG5LTXBnUUFyQW5zdTV4WnMra29EblBQWHlrQWZKYWlvQUM1OGQ4TzRrakpm?=
 =?utf-8?B?MVRqZlkyTlp5eFVQYkFVN2l5QnppVXJsZVBvY3ljbjVlQmU0b1FvR3BHbUdQ?=
 =?utf-8?B?Y2hhcDR5RTVLL094QkVNYjYybEloTWF3VnAyVk05dklNa1l5V3M2bFRGekVK?=
 =?utf-8?B?V2tRcXZZTWxSMC9Wc1dEU1IyWmRQU0JDZlphSk1DNzRISjh3djg3YXNBaWZZ?=
 =?utf-8?B?ZHNZZTV5STRTTnJrUUd6dVJjcFkveGR3MG8wY1Myc3l1QjhFeHlGa0F0cFV4?=
 =?utf-8?B?bnZHZ3Q4SXJrNFVCeEZHVml4bVN2ZjQveFhwbUdGWGU1T29rNFp2RnRFRmtG?=
 =?utf-8?B?Vmh4UUZDbU9meE9OWGljNmdFVUxlOGJlZWhMcE81RE16Y0VJa1Q2V1lDU015?=
 =?utf-8?B?ZEg2QmxlNWRHK1hpV0lZMlVGb0kzTGJPcWNrc05waWRvQmRTNXg3VTIxZWMx?=
 =?utf-8?B?MVRsQmZPelJSYnpmcUJRUXJwN0VvcHJGKzhuem1nQ2JZT3ZINGhMMFJHOWN3?=
 =?utf-8?B?Wld6K01QMktSQWFNbnkrbFlobE9BU3k5TDNyOGlyMGV4TE4wSnlJa0hSc21M?=
 =?utf-8?B?Wk9uS0tPYkliYzJiOGExMVRKTERRMks2QnNNR2NVYlN1U0lwTnpqU0NIZzhj?=
 =?utf-8?B?VTUzQ1RmMGRDVUxsdDJlWU41ek5QZFlXQXVUeFd6WDNYc3lOMVpRdzBLYnBl?=
 =?utf-8?B?ZXl3a0dRR2dMQXRjUUNLc1FmbWo1QVhiQlFFajYwZnhZQnNUUnVXTy9ycUlG?=
 =?utf-8?B?T0Z4dlBrN1BleFBPQVMrWjhvUjViS1gvTExQUXhqemNuU2hGUzUyMkZLRUdq?=
 =?utf-8?B?Szl6UzhjY3laNGZZcTdKSXkvTk1pdk1Gem9WbVJYUGEvRlJBazBRZHVMdTAr?=
 =?utf-8?Q?IMWiVYAEOmU3xC+bBENv6GiI9o8s1E3G?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:40.3871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 946b0729-f28c-44fb-59e1-08dc9f45ddf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506

Until now resume_vq() was used only for the suspend/resume scenario.
This change also allows calling resume_vq() to bring it from Init to
Ready state (VQ initialization).

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 0a62ce0b4af8..adcc4d63cf83 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1557,11 +1557,31 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
 
 static void resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 {
-	if (!mvq->initialized || !is_resumable(ndev))
+	if (!mvq->initialized)
 		return;
 
-	if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND)
+	switch (mvq->fw_state) {
+	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
+		/* Due to a FW quirk we need to modify the VQ fields first then change state.
+		 * This should be fixed soon. After that, a single command can be used.
+		 */
+		if (modify_virtqueue(ndev, mvq, 0))
+			mlx5_vdpa_warn(&ndev->mvdev,
+				"modify vq properties failed for vq %u\n", mvq->index);
+		break;
+	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
+		if (!is_resumable(ndev)) {
+			mlx5_vdpa_warn(&ndev->mvdev, "vq %d is not resumable\n", mvq->index);
+			return;
+		}
+		break;
+	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
 		return;
+	default:
+		mlx5_vdpa_warn(&ndev->mvdev, "resume vq %u called from bad state %d\n",
+			       mvq->index, mvq->fw_state);
+		return;
+	}
 
 	if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY))
 		mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for vq %u\n", mvq->index);

-- 
2.45.2


