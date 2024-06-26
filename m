Return-Path: <linux-rdma+bounces-3503-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C48917DE1
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC031C23C4E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2441A181BAC;
	Wed, 26 Jun 2024 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HG2L2mxj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5A17F4FF;
	Wed, 26 Jun 2024 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397649; cv=fail; b=UQJ9Dmrxhf31OxhbU0g8pLFlwkZ2HPI7rK7Grm3T56CUViXLSS9A/ph5jPOiPb5GEvRRzU4t+7Lv6JGjeRsrRZ7uJRXOws1zFKPkL6GIYCwQ34WAtGIDAgoy66NN0qwg7LApEGrpT6sbOjvFni9Pz/K54kXCARW4qypvQdoa/Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397649; c=relaxed/simple;
	bh=7cjNJOBX9jeX49KRJhhB9Z878bN/YVyCDUsqS2Q2vy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XVJAf3OMqnMkNc8/1catF1zCBaZKGHEJup5e87D1/Onvt1/l4sCDwzGiS2Sff42hmHqrEo57r4RXQsJmJ0CGkn3KQn0EGLEDPlODvaRS1WgrPC8wagg8Ba3XzjsyLOqL++L7i6P+VN3PGsfZLyA53CIrWqlRXOXZZtNTSynEfso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HG2L2mxj; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqpwG6K/c5gUjRtydmjLeMrV5hmC5a/xdnrhb7AT4l4A9YuESQ3YR0lTMJ8zpQQ3k5WC2TX0h4KBy35xvDyFsHL+g7y/OR6K2DTHwBA/8OwqFsF9+QJyLrBTC1xszzCasDda9MJ7RlP6twbrIOdOc8FEoay96Hdk2vCSPztdytcxFu8T859x6xqdXl+6JnBBr1zwM5e8Xf+Ze2m+X489iZ9zbswLLYyKcJF2QnygpCi4SzBRjxXS3xb+nhHzE4XosPbx9JtGF0pABDYxo35WkgYenVwBTogVhwSq/cIZdQBAjIIH9rhbruUOEhb1L9XOYI8lT/pF3T7Faea6d+7EWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6+plDX3Exdv64qzQokta757NaNYI3PsLvLf/wcUoQA=;
 b=GORQCfWqTS/zavoIJbVu28WkmPNyYt1rorI4k7x9W6/Iy+eSBOtzGeQLs8duR7oowJX0lcdfb3IcXyuKzVzSs5/5C0vfccXCWqgIyyoNp0NHCVeg3oysdau2/PreOSVDE7oiVRzqJWpw8AEGvn2Jo4MMdaw6Ma4HPb1AekA+DuK8++NOg3+yKStun28HqOWdBgXXRTYXkN1BaLi/2I6VZlTAVHHZvxB2eoH/UCaYCLQju5FEhf9cr3bJTDdAQbf0uptbPprtgPsUSd1y6Q2k3onBs4ArSjm22k/93Y1ew6bIWoR5vi6XcDiqZ5gjkEPcN8DEV8noVqWp2ikXuDU4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6+plDX3Exdv64qzQokta757NaNYI3PsLvLf/wcUoQA=;
 b=HG2L2mxj7ocXXBwMaTZUzzA1mqGMjywHuRCjfbTxoIcjB+wHMlMc9SgEYGbSEWMnQJAQNXoSHBv2z+u8HM3Xypfy5VzDQ5Q29bckHJ23KQx3JBDyhW+nuChCIKy3dYNutOj6SBn3KsYsWGseN8CaDJu6hF2EQTIsq8C/qhJR4eBJ6NBTebyu9gyfyQXm1V/mUMoqj5tOdUcm3h6NqUFFMGtBtQrCYVYA45EXy2sWk2CjvSq0JVeha4/8McynQF3cvIuRPKNROaM4RO8AFv7TnZpUMrS+bGkj5ZAzqW7pD9fNCI4oMku4tgZUppfKmADnjsknIBu6kU440QW11BfWeQ==
Received: from MN2PR04CA0031.namprd04.prod.outlook.com (2603:10b6:208:d4::44)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 10:27:24 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::3b) by MN2PR04CA0031.outlook.office365.com
 (2603:10b6:208:d4::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:11 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:08 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:42 +0300
Subject: [PATCH vhost v2 06/24] vdpa/mlx5: Remove duplicate suspend code
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-6-560c491078df@nvidia.com>
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: eea3f7e0-6782-4a62-f440-08dc95ca91ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cU9UOWdwdlZDSDNsT1NOWlIremRCVVpNSHR6b1lIRnAra1lsVzUxYjlrbGl3?=
 =?utf-8?B?NVBUNFZmemJsbjMwN3RzNjlhV3ZSNnBJbUFZaUlDUGVGeUV1L3IzSjlWbXkv?=
 =?utf-8?B?NFNoTmFnTUNPS2lBQ3Z3MmNWRTc1RC9CVjRFRVE5eUtvWkxqOEYxSytoL3Ny?=
 =?utf-8?B?ampWUnZXUjFRZ2M2ZUNaSTdqUE5EOGpROENSMmVyYWF5S0crYTg4azBiVDR0?=
 =?utf-8?B?YnZZUk1oWnVtYmRyc3NDcE1kQXZGdWhuWWNXdVpTVHltT01pVGpXV1pUSlZF?=
 =?utf-8?B?dTM5NWc5bnZDWU1hRnp1VUlHeUtPQlA4VXNQYmZCTmVzelpnSmRCZ1RCZWJZ?=
 =?utf-8?B?RFlTMlgvVmViUUZoOE4waXZQTjhhNmtud2N0UXR4UEwyeEg5aGpiR1pNMUMy?=
 =?utf-8?B?MDIyNDdNMVRnd29sQkZoN1V1L0lSK0o4M2F3eHErUkdCK0hEU0gzdS9FMjJ1?=
 =?utf-8?B?UU1BMWhCemZKZTFSNXlQRGhQZURGK20zVThpM0lRaVR5NWJ6bStjZVpRclB5?=
 =?utf-8?B?eVdNTk1oRGdhNUdCKzdjZkM0Zzd6RkVyQk1MTEQzU2cvbW8yVVZyb3Q0cUIv?=
 =?utf-8?B?WWFQdjhFeEswVTdMYWRsM2U5V0pzYmFobmc2SGVpY0k1T0NuU3dYY0t0ek15?=
 =?utf-8?B?bkNnREVLNmxpbFJ2TFZ1eUMwV2ZnKzZlcTV2WDRyMkp2akJnekZKOEpjVU9M?=
 =?utf-8?B?WHorcmtQbklVQ0hYMjY1UC9iRmVoQ0x6THUwaWQ5cXgvSDRCNmw3aG5NK0Fz?=
 =?utf-8?B?am9FNUJsR3Y3dld0TzVONy82MnkxVjg1OEZtbVk4QlRIUEZ0UmM0dFZJbmlw?=
 =?utf-8?B?b2tVUHFQLzgwNlBObkJMSDhEM1lSd0M0aDJvM2sycS9KS3lGM2lQT2ZqZWhi?=
 =?utf-8?B?bjl1dEt5NEcxMnBJU25aUVhCektWQnl4NytXei8ySSszWW82WTRRTUlEQ1R2?=
 =?utf-8?B?NFYxVnJDbG10R1VqalVmR3QwbE9FckRpVTg3ZVdHZG1OSGFsUWkwM1JnU1Ba?=
 =?utf-8?B?OGhidHlHTW9hWkpTL3hUK2pWWC92ZUNrLzM3cnVEeWJXRE9WMmdsRVN6USth?=
 =?utf-8?B?bXdSM253NEMvNmNIcXdHWnVWaCtwSmNBb3hGaDR3VXZkVjE1Q1lCby9mSmtZ?=
 =?utf-8?B?Q0J2eDhBYWFucHZYeXBhUlNtUnVkRnl4RVI3Y25sNnlLbWZUM2RmTTFROHlW?=
 =?utf-8?B?RGNDV2MzbUt5QXFQSXZobGpmOE4rSHpvd1dibVRBZlFMRmI2cUxxdmtHT3ZE?=
 =?utf-8?B?cDl6d3lSNjZ3Y2ZyY0t4ekhsYndQV0hGT3N1cE5wRHd2TDk4UnRRZmVlZEli?=
 =?utf-8?B?eFF0YUtMT2tmT1VGYmNmcnZBZzNjaFlkVzBYM041WnJGMTkwSkE5dUUrejB5?=
 =?utf-8?B?eE1xcERtdHd5bFVrWlhxcWJ1RU55ZS9iRUdLTU5pVEZnR1ZSR1UwRFI3WCtX?=
 =?utf-8?B?enBpYndKNnhCNDdyVnFqNmRjN2kvOGE3NUVZRDd5VzR4M0NBTnVxRkNwL0dT?=
 =?utf-8?B?RVZta0F6K2djOVg2Q21xSU54aDU5ZEpoVWYyd2c4WkFwVVZZc0FQZWRmMWRn?=
 =?utf-8?B?NnRDY1JLTitoWnEyNUVNY3JObU11enBGR0VWV2FQd3I3d0p2dUh5b2pENFdM?=
 =?utf-8?B?SXgzYlBLZG1ucHltU21RWW5VdFo2L0ZrSU5HV1RnaW11T0hhbm82ZzAweVRz?=
 =?utf-8?B?Sld2TFpXdy9Sd0pHVWdqQ3IzbFFabFVPZVFIb0tqUkV6TVJjUzhtUjdZaWVK?=
 =?utf-8?B?eHpqcWxnZU1EckpEbksvb0kreGJHdnhERkMyZ3UyNzZWdU1EOGo4eTlURU83?=
 =?utf-8?B?dEpyc0ZSb3BKNjZTS2pIakVFcTcrZVlna3lhY0ZLMlEzYXU3STV5dUVJNDl6?=
 =?utf-8?B?cVJaeUZGNXRZeFJyZXdYdS9yOVp1aFB1bEo0REpncVo2dVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:24.1607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea3f7e0-6782-4a62-f440-08dc95ca91ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018

Use the dedicated suspend_vqs() function instead.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 51630b1935f4..eca6f68c2eda 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3355,17 +3355,12 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
-	struct mlx5_vdpa_virtqueue *mvq;
-	int i;
 
 	mlx5_vdpa_info(mvdev, "suspending device\n");
 
 	down_write(&ndev->reslock);
 	unregister_link_notifier(ndev);
-	for (i = 0; i < ndev->cur_num_vqs; i++) {
-		mvq = &ndev->vqs[i];
-		suspend_vq(ndev, mvq);
-	}
+	suspend_vqs(ndev);
 	mlx5_vdpa_cvq_suspend(mvdev);
 	mvdev->suspended = true;
 	up_write(&ndev->reslock);

-- 
2.45.1


