Return-Path: <linux-rdma+bounces-3233-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEA390B4B1
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5AB1C22B8D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702EC16DEB4;
	Mon, 17 Jun 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Farr3E8G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1067152E00;
	Mon, 17 Jun 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636968; cv=fail; b=IZi+aCmgEZzarwEvb0RVukYrRBng2uBLe+IvGZdEtZ5Mpt5y1t0fHqNEeAk2cFCcZimrjq+vvslnVoaQXwNo0kDcpw3laLq/m73umUMtJEda5J0BPmzChz04JYAVhBGQIiBFI1FQBVu7eubQUy63wHMd+LXD+vPsMWfGG0o1buI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636968; c=relaxed/simple;
	bh=Uah6IifL6+bJ1VeGiVxQJbD2U72Vm0QHgCqVIfQRhAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tDu/y46BvfUm46TDt3p0f5yM9CdFHVcz95gYseYc7PmlARd7PsaLs1sxDEVJEuPkDu4kFBvLLKs8Z18amLS/r/t/Hx+OLUsWmtgC+2SCW56mcRhQbKdlsP1+/2c89C4Eay4AtOM9DIM3B8vPhs1c7v9Kn5+OfKNaNvG0FZQuG24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Farr3E8G; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBCq4mi+RvxoAd2mT+ClWA6UrpWT0Fi4sYQ1Ieai6OdPU6Up3bWKLvcjbhaDxZ3CQ9ofCDTOzqtBGRrkr1y/QTULXilMz3R5C8k+x+aEJyCw9dRrmrSWhxfnFDfvu97O5R7JfP8EiG9Wksgu7NzBfxYaACE7RiytbvPP6RC6eG20zmXp/72gSfVSIPm1eHHEF7nW2x2gtjvK1iTg/gWPM4nZbDx2mTsnMfIeCqF3mHs1aO/DLMqjd/5lSkvGk+8qESinpLZYLEbtIicmj0uNHVAJSe++5RZdOLQDnXRO4c/ZbL8fhUbXhT/zVcxMAX+vv+1yY++Fdkm6d/qlCqPXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtkwxyFexeLxcbZGAkTqqIHAJkPy4smtcBPdpWb/zD0=;
 b=RLFCMe4V6sFHi4oLpyyDd0s8p6DdlnXqGXJrR/Ho9a30FSJQjuJRrSnIKcidLz+k6piC56CklxEx78mcfgRYKm3Y2XGQS6pWlvL11TB08QhNH8Ad5Al/K96NbuZAXlrZWnkkHomhIa9hIgrnskvwSpzdfa1C0ACrf6W95wYf320T9tu66+TMvpbNjE24VPii3KA0xHWlQS9DzL5T7g1lWhW8lEy+6zRMjIBlFfq9+iwlnicyJYEWj72pzvHVQGcHs9X0BZ6BPwdnj2Cgxhk0AvNscBi9lkJFzMlV7QJiJkFZ2VebQAS0PJsHplAgoBdf1tuKQziBqqJGRwDWNc/N2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtkwxyFexeLxcbZGAkTqqIHAJkPy4smtcBPdpWb/zD0=;
 b=Farr3E8G14/PF9bqVmbZDRN29OATB2nociVCskwByQlT4BFNWvUwUfyXJEgYPTtUW7/bSTmHobmsJTaZpl5u+MkoFDENgbJOqRtc/lAei/uUBebFmhaxjOxek5NQbbLTuvbng1B5D2w4KZQYWvrUuUm4v6JAw90LEH135aWA8rvm82x26DdtqGlFfvQCeZPKhFXLZjC0h0dyBBIrBKm/Vl6SLXubku5EDfEdabeyrNBXWv+/ZUDDPODf2grQZOeyh3ZTBbeKOZAQGATKyJmf/ny0pfo83HsOckMoAIKMarHaIuK8VhsRTiuKCZLNJPeehPDA+3orJS4cqnV/wRO0Pw==
Received: from SJ0PR13CA0057.namprd13.prod.outlook.com (2603:10b6:a03:2c2::32)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:09:21 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::c) by SJ0PR13CA0057.outlook.office365.com
 (2603:10b6:a03:2c2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.27 via Frontend
 Transport; Mon, 17 Jun 2024 15:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:09:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:58 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:55 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:52 +0300
Subject: [PATCH vhost 18/23] vdpa/mlx5: Forward error in suspend/resume
 device
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-18-8c0483f0ca2a@nvidia.com>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: f81206d9-9180-46ad-5831-08dc8edf74c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VENyVGF1RlRVQmdCMU9NN3ZGNWhyYWNEcGlTOUI4eUNhODQyM3l0V0JQOXZU?=
 =?utf-8?B?cE1GUWtELzdaekFqMWFzdWVFKzliUllDTmlhRTZuN0hvand4TVFHSzJRZU1o?=
 =?utf-8?B?QlFMZ1NUWjR3MkpGTmZpVEdJTERWR2FqMlZyN2szanluUm54aXpoSjZWVUlJ?=
 =?utf-8?B?YmxBNEVMNWFzSEpZaURRblR6Nm1wSHl1YVMxVGlUYXdFSTQ5UHlPeUl5S29B?=
 =?utf-8?B?dk1GWnRxZFAwSTU4Z0hIb3R4RUt1cmxXbXpLZ1FBNHZSZjFvcnhEeW9naWxy?=
 =?utf-8?B?YnVtMWRZZEIvdjVUcjFLU2x2Z1pGWWR4dUx3UUxuamMweWpnQi9GbVBQR0I3?=
 =?utf-8?B?ZVJIRHN1VWs3TUpEZ0pkMnVKY09NYUd3TWtvRDFsMFMrbnJLV3h3TnFlb1lK?=
 =?utf-8?B?TFhWWHF4L0dFWmhncmhYREhoQ0I3b28veGJVYXJTaXR1SFBMM1NNWmV3ZFJM?=
 =?utf-8?B?ZzRUOTF2M3pUT0ZzaUFBYklZR2k2REZIc1BqTzlLZDRuVDJzeGVwOTFKNk1l?=
 =?utf-8?B?ZHdNZVNyeGhxYWpjY1NLNHBJM0Ura1RpQ21INzlzL0UwT3BUTjAxVmNuU0Z5?=
 =?utf-8?B?bjdJS1daL2lSMXp6QjZlV1dJQVlhZVJ3U3dmcU9meGU0bTJraWpDblZkc1VH?=
 =?utf-8?B?elBTeWd5MnhwVkp5WGsySmc3bXF1bkNUK1ZZdzZhZW9Fc1ptSFlsRzFBeWJi?=
 =?utf-8?B?cmtzVVJHYWNIZTRwZmFtMm9qZDlIYk16L3BYSVN5TFZ4bW9tREJmNm1sRkFz?=
 =?utf-8?B?TmZ2RUdNdld1eDYyUldpZXcyZC83UXdReitqNFNyZ1QrUytFYXdFVTdOazA5?=
 =?utf-8?B?SHYxS25keU14Sm85eC9mNjI3eGRtKzFSZDhBTHVoejlCS0duUlJWMk92Sjhj?=
 =?utf-8?B?aEMwbHJpNUY1emhtQ056MW5Nd0hhQUR4dGthTEV1Y0F5UXYwdWtTL2NGWDVM?=
 =?utf-8?B?a0pYMzlZaTAvSFFQdFpZWStiOWFlMnpWbFk3YXNUa0dZL2xQcVdvV1lFcThp?=
 =?utf-8?B?b1dURzRoVXh6eDFZQkszd0Zrbm5VOWEvWnhacU9ZeFF0MnpSZUlPdEF5SUNj?=
 =?utf-8?B?aVk4dVhmdHNqeWovL1JRRCtrT3JMWlZiSHNQeHJUdkNXVlJDRys0NWZ0ck9y?=
 =?utf-8?B?QzF3RFAwZUV1UWdORXZSN3Z3Mis3TFFadm5wbkFTNDJoWHRic1Q1Si9GdmhD?=
 =?utf-8?B?dEtZLzlnV052ajJSa0g1aUM0UlZPblVEOUdhckd0R1Z5SjQvZWdEMUdUVXdN?=
 =?utf-8?B?K3R0OWNFVzVBVENidUc1QU01ODlyRlFHeldWeEY3ZXdNT3Z3NmtPN1BobHBv?=
 =?utf-8?B?YjgrbkVyQVJnWStFQUs2SlN4ZnJQdDFZcTVUZ2FrSUVkVklzaVVSQUU5V0lQ?=
 =?utf-8?B?clE2Mkg0RXFtSmVGdDRwSVp4eW13eVloaE1nQ3h5OS9xbzNYNGNyYUE5VnI3?=
 =?utf-8?B?STBwSjBscUN3N1d5bDhhRVQvUmNSNThWZWRTbGpISW9rYUNwM3hhS1J3NStI?=
 =?utf-8?B?Zm0vY3VDU2QxVDA1aXdvTTdTdXptWGhJZ1pieHRrYVFoNW5NTzFraUw3ckRw?=
 =?utf-8?B?VEg5SERuYUxSakw5QW9VUVpKd2tHeFR1amV2QUlZWXFHWW9YWVZFR09SM0Zp?=
 =?utf-8?B?OWZVMTRXaFovb21pT0IzaHphbkphVVFkUVhhMEdVVlM4b1duOW5CWGgwOGNl?=
 =?utf-8?B?VC8vYjJXWW51YjBQZm9pSkhpek5pdVZ4bjhLWnZ6UzhyWnEyUzVnYWhHTEp5?=
 =?utf-8?B?RVBlb0lkdUhhKzBzL01CWlhvamxZU0lWQ09qR1BScTdiZStkUTdsaEtmNFV5?=
 =?utf-8?B?ais5eXRJRUJUVTBGUXk2bUMzQkNHTTZaNFpDODVDeWhWc21BVlFHck1HcWRs?=
 =?utf-8?B?TDN4dUhxY0IySnhPVk1obHNQWm0xY2RvS2FlVnFubzNkdUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:09:16.7552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f81206d9-9180-46ad-5831-08dc8edf74c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303

Start using the suspend/resume_vq() error return codes previously added.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index f5d5b25cdb01..0e1c1b7ff297 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3436,22 +3436,25 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	int err;
 
 	mlx5_vdpa_info(mvdev, "suspending device\n");
 
 	down_write(&ndev->reslock);
 	unregister_link_notifier(ndev);
-	suspend_vqs(ndev);
+	err = suspend_vqs(ndev);
 	mlx5_vdpa_cvq_suspend(mvdev);
 	mvdev->suspended = true;
 	up_write(&ndev->reslock);
-	return 0;
+
+	return err;
 }
 
 static int mlx5_vdpa_resume(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev;
+	int err;
 
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 
@@ -3459,10 +3462,11 @@ static int mlx5_vdpa_resume(struct vdpa_device *vdev)
 
 	down_write(&ndev->reslock);
 	mvdev->suspended = false;
-	resume_vqs(ndev);
+	err = resume_vqs(ndev);
 	register_link_notifier(ndev);
 	up_write(&ndev->reslock);
-	return 0;
+
+	return err;
 }
 
 static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,

-- 
2.45.1


