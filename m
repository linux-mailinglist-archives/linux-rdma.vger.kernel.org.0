Return-Path: <linux-rdma+bounces-3235-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9735190B4BB
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CEC1F26947
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB31216EB72;
	Mon, 17 Jun 2024 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YUJz+LgR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45A152DF2;
	Mon, 17 Jun 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636970; cv=fail; b=MdThaeoXAFG5nJq1UyLZ7JmMOOD6rC8dCnl1fnofsAG7V4VzoihDK9riGtGmurtm8tzCVPSTWvzDxP84bgCvsm7dtf5x7Jnxh9tJ9540seR+pO6OjdwoIpXiEbOsZkiKrXO/DMIwC/E4/GKpgtg1R4SmyAQMHGO2deCURwEWvd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636970; c=relaxed/simple;
	bh=nTfUA3+eeP+LjaQ2b4SdWdE3/SHoPs4LUPwULAsEpKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hFNgCYW7p2AaEB1yM3YPu2a2GBgArYcGZg6EkG7tDn9x0ep3mebC3GUziivA1rDVI1dc9RzUqZG7sb/mtvSXMPtSsK0dI7iSmelbIklLOizG84GIRCyQJnXXK0P7XFw15chFRKZxKyKypYQtI0hKwfUCGW2ZaAmAakPqvRiY6QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YUJz+LgR; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUCOie/OYXHpvBOZeDLZN7CFcD8BMyAmtnoipWS3mb10msO3Y4L6+DJbjMLKLY0j0sD1x48HxNsR1Op8w6upeGTSmkmPDDQO/B2esRndZRoaTL6LrMpjmOVX6UBBQ+xoqJGAd9FL9JdWGxqv44gaR04lnunnnZL/OPSqOgkAhfI50VSOqImwyPAT6MiOWyAww6IwRDJrXuKkFp+tmBpDiDmCPpMu3QGE0y4NUdurwuhSBa6ppnEnMiJeKf5DZMoScqpuozJBaHMsQQt6Dj/3cewtVuDEa/wi7hWm9H6DoG0+pAV4VkZa15ikiw1kooH10chBLBi0ShM10XTVPAML2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2P/m400lrNpunlyWcf3KblMIoK4PdhXSvMi48p9v58=;
 b=KBHNDk+wnFgKvk9imjpBfv44+kTdWD3CoWS+zIQDPtsHg+R+StM4fAnpE28yzPPHKiiyrMBq+UoqfwF/82QHCGk7UyDW5VVNuuVGWGdA0wPRxp3t3NBRzjBrkTqQSMMwuYliYwvutqMBupUayV5VyuQG4t8WnfVAn6ZXWJQviEDL9CECw06sm1Txcd0l+2r3sRHF17+f01fFh0Bkr3bAsYIo8m/OybkQ6F3mhngFwQ8nC+7PEhbTQ4v43dNy8tk500GIitsRypZChutzSMZdqbf5RzrfV39zTWFD7RSbNjpqmzTnAhw9FyQfQuLIDTbJC5UE57BQn2Sg2T9i8Qgdpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2P/m400lrNpunlyWcf3KblMIoK4PdhXSvMi48p9v58=;
 b=YUJz+LgRSGrzEQOjxMmHInObbEr9BU+zq24bbbXufdGOUIAWrycj6yQlYzba8kBAotLLZ+2aST/8oZuuAyJExISCYcvSm5BYsB+sSxls9YStzvl3ucdaG4DDmzXh/OZCNRLEUvgAF4JISRbeV8NAHV1W4vMnCwFgIAiDGA74fJYDTV80KzXuUNEpeZpVy10o4DJQgN3OE/+XsljeDfa/IG/sto3dh3K/3EMbSTCv4aW0NyATSXOY4m5xh9GzebDTFR1PnqM7497MkYyABpkvtvOGewZjI2kw5C3fGypZvM/xRyEe8lRzpT41jBwEgsf5hFsTN+ylZqS6hYie6cqMQg==
Received: from SJ0PR03CA0122.namprd03.prod.outlook.com (2603:10b6:a03:33c::7)
 by SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:09:25 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::41) by SJ0PR03CA0122.outlook.office365.com
 (2603:10b6:a03:33c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 15:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:09:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:09:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:09:06 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:09:03 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:54 +0300
Subject: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f09d0db-13e3-46d6-6d88-08dc8edf79d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|82310400023|1800799021|7416011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzMzVUR3YS8ybkpRbldNZllWWEJrVUpSV0FnUS9tNnpFNEwrdTVkek9GK3cw?=
 =?utf-8?B?M3d1R3ZsUXlPamI3b1RqWXhLd1lSNk1aaHd6WWNQWGNZdE12Q1IyTkc3QjlQ?=
 =?utf-8?B?azNqZ0RDbDFRTFV2bWNoTVFEWWNyc0t3UFQ1V3JlaEZ3ZDR0eUdZbXZzUnJO?=
 =?utf-8?B?dHVFWEwvZm82eFhWaXRpV09UY0xhdU1uT2ZMYmJBMWlSZ3ZsQTZrQk5GMHR0?=
 =?utf-8?B?c21zZzI3SW9yQ2tpSWZYVTY0dEYrRzA4OE1tMWhhanlFMndyQ2xLdm96UG9K?=
 =?utf-8?B?VzBOUjI3Zkh5ZnExS0xWWDkzOVR3UVllcXZuMnAzWGtKWTFJSDVPR2dxalJY?=
 =?utf-8?B?cHFtaHJEbGwzNGN0RnRscCtxVVVWdTl3eFBRNzNaN3VMbzFpY2FKVHJySzlU?=
 =?utf-8?B?U21rQjAzNHpVZDQyWXdLNXUzSFNCZzJxdVROM0dGUHJMaG1hVDh2cDV5WlNR?=
 =?utf-8?B?SjcwRWZtUlRQUjdrY0RFTWdmdSt1M1FRS1B3SEZyamZOR2dnVmRkM0FZTUtO?=
 =?utf-8?B?SzYrNWZ6OUUvYjgvSkRITjluOTc3REx3TmliODMvaVBFVVQxZ2ZicmxkZ3hl?=
 =?utf-8?B?OWQ0WVNPL09hbTR2NzF6alF1ZnRoRWZyTVVuMk8reTZUZmRESm5HelBWdWFi?=
 =?utf-8?B?THR0V2MyMks0MFRPUFpOcWpMZy9OZWdEMFJPM3M4V2FMUi9uY0ZqdXV1QjNo?=
 =?utf-8?B?amJSS3hZTHlsSmd6d2NRVXJ6dUxJZmZOSmlNRVY4c2tmM1dyOHBhaDlPOGJo?=
 =?utf-8?B?M3Ztd0Z5aHphN3hjdWV2QzBnMy9RYW8zZUZoMFhqRnh0OEJpZEt1QTRaSFlo?=
 =?utf-8?B?bW5iamRuYi9veCtzcUMxb1dGUG5PeEJKWXNEeWhyZXVEaWRSblMrN2kvWVlG?=
 =?utf-8?B?a013NkVnYVJUWmpTZHpiWUJBdzcvL3NjTTJWQStTRExGMzVjY1FIOXk3VUhU?=
 =?utf-8?B?dW5paHNKMUY2cUZmck9iQXdvN2pSeTExODFKMTFWUTlpSXZrM2pLTThPOFc0?=
 =?utf-8?B?aWpZM1Fwd0liNkJuRnBnVEthKzFnZ0hFa3UyV2pCU3dFY2xLMzQvbmhwOHJy?=
 =?utf-8?B?cHdySnNoYWtKaE0rdEdBR2tzU2xWSGRySDFQNmYwdWxzeUhUSGJxdG1xS0FD?=
 =?utf-8?B?dlFFa1ZIaVg2NW91cUhpWDZhS1BKaCtiUVhaM1BubTd1dkJLM01VcHByMG55?=
 =?utf-8?B?SzVqM1VHSlFEZGpzMzI2SGpDYm85aWN0QXBXRUNROFRwWVBNQlhHc041SVRZ?=
 =?utf-8?B?YzAwTTJGV2tIcjVjei9sSm0vSGJiQWpma2hzYkU0NndZNVFDeE5hVXNNQ3VO?=
 =?utf-8?B?K0t4ZCtxbVZrVHAxd1ZjK0ZEdlNLZGFqV2lsTnk5Z0hoYmgxWjdVdFhUNjMr?=
 =?utf-8?B?czZhdUpucStzMS9oY0JsUTVDUzVuTzdIYlM0RStEemUwWUR6bVJHZ243clZw?=
 =?utf-8?B?Z2MxMHFHNlJUaVZvc1cvRkxhUnlacEVqSzhFVkg0ZlViYUU3YVNoWTg0cUhm?=
 =?utf-8?B?WEI3NmxjRFpIRXJKWW9ITW1iakZLdTl3Z1g4dEtJcm5BT0U4U09LUW9DMFlJ?=
 =?utf-8?B?U1p4WGcvQU82WGhwV1g1WFhTb3dzZ0NURDlPYk1pVHZ1aE5mbFVzeXdjb3lj?=
 =?utf-8?B?d3FScDlaZE5JVzk3VlVzNE5weDc5TmZNa0x6TUdHTkhZRERFczZlZFNpSnFq?=
 =?utf-8?B?OVBRUGQ3bDNSV1JZUTJEMmQ2cXRpRVhTc2V5R0ZuZTBQMTRsK0M2eVlFUDln?=
 =?utf-8?B?SHlFN0ZnbXc4cGFlTGJBbHlpQitOWjRPbVNCbkUwR1hGZkRVRlU1Z1hWVjFZ?=
 =?utf-8?B?WFM3L0IwdFY1a1lLY3BFNzhzYWkxV0xvUEZPNkUvOU9hZkNXUk5JTndjcG5Z?=
 =?utf-8?B?YmxOZFV2YVpUSkRybTdITENJc014RSs3ME9kQ0pKdXZpMFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021)(7416011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:09:25.2205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f09d0db-13e3-46d6-6d88-08dc8edf79d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239

Currently, hardware VQs are created right when the vdpa device gets into
DRIVER_OK state. That is easier because most of the VQ state is known by
then.

This patch switches to creating all VQs and their associated resources
at device creation time. The motivation is to reduce the vdpa device
live migration downtime by moving the expensive operation of creating
all the hardware VQs and their associated resources out of downtime on
the destination VM.

The VQs are now created in a blank state. The VQ configuration will
happen later, on DRIVER_OK. Then the configuration will be applied when
the VQs are moved to the Ready state.

When .set_vq_ready() is called on a VQ before DRIVER_OK, special care is
needed: now that the VQ is already created a resume_vq() will be
triggered too early when no mr has been configured yet. Skip calling
resume_vq() in this case, let it be handled during DRIVER_OK.

For virtio-vdpa, the device configuration is done earlier during
.vdpa_dev_add() by vdpa_register_device(). Avoid calling
setup_vq_resources() a second time in that case.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 249b5afbe34a..b2836fd3d1dd 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2444,7 +2444,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
 	mvq = &ndev->vqs[idx];
 	if (!ready) {
 		suspend_vq(ndev, mvq);
-	} else {
+	} else if (mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) {
 		if (resume_vq(ndev, mvq))
 			ready = false;
 	}
@@ -3078,10 +3078,18 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 				goto err_setup;
 			}
 			register_link_notifier(ndev);
-			err = setup_vq_resources(ndev, true);
-			if (err) {
-				mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
-				goto err_driver;
+			if (ndev->setup) {
+				err = resume_vqs(ndev);
+				if (err) {
+					mlx5_vdpa_warn(mvdev, "failed to resume VQs\n");
+					goto err_driver;
+				}
+			} else {
+				err = setup_vq_resources(ndev, true);
+				if (err) {
+					mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
+					goto err_driver;
+				}
 			}
 		} else {
 			mlx5_vdpa_warn(mvdev, "did not expect DRIVER_OK to be cleared\n");
@@ -3142,6 +3150,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
 		if (mlx5_vdpa_create_dma_mr(mvdev))
 			mlx5_vdpa_warn(mvdev, "create MR failed\n");
 	}
+	setup_vq_resources(ndev, false);
 	up_write(&ndev->reslock);
 
 	return 0;
@@ -3836,8 +3845,21 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		goto err_reg;
 
 	mgtdev->ndev = ndev;
+
+	/* For virtio-vdpa, the device was set up during device register. */
+	if (ndev->setup)
+		return 0;
+
+	down_write(&ndev->reslock);
+	err = setup_vq_resources(ndev, false);
+	up_write(&ndev->reslock);
+	if (err)
+		goto err_setup_vq_res;
+
 	return 0;
 
+err_setup_vq_res:
+	_vdpa_unregister_device(&mvdev->vdev);
 err_reg:
 	destroy_workqueue(mvdev->wq);
 err_res2:
@@ -3863,6 +3885,11 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 
 	unregister_link_notifier(ndev);
 	_vdpa_unregister_device(dev);
+
+	down_write(&ndev->reslock);
+	teardown_vq_resources(ndev);
+	up_write(&ndev->reslock);
+
 	wq = mvdev->wq;
 	mvdev->wq = NULL;
 	destroy_workqueue(wq);

-- 
2.45.1


