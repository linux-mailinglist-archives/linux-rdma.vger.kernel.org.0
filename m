Return-Path: <linux-rdma+bounces-3725-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624392A1DE
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01FB2873AC
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3953880C13;
	Mon,  8 Jul 2024 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sLg6NJ9p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6A84DE0;
	Mon,  8 Jul 2024 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440116; cv=fail; b=b9+HHZG8dw/9QzrRJa9NFTfEs3P/IPZPpm5AboWYzfzWwf6Eo7sFFbSoB5He5k0hc0gs4tUizYxddMA9vKZDrUJcWgdEYwKt4dYLY5jVLE8eCrbkmIJgpwlW4ywTtYZgIp0qTts8EY710wRDRldh53Nh51IlI9h9E/2pHRTMXI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440116; c=relaxed/simple;
	bh=dzufAnZLV9C8YeB28Txk4NRcR/9Q1yOXE+3er4oywEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DxXWc3zerbEZY/FyPWeepZ8UZmhyXDJXW2mjkN8gqM2jlrqrLzWaRqetQWnB4MBOKSrAWs0c/SBBfkplppdCq+ev9WxwjqxJHtRkHS0wGJfsXP4uzA9GfFrJ7w08hjxuzVLsnD76562Si4DIqhrDzJzE+Z3yx0SrEoSmfhJdY2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sLg6NJ9p; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8fAHWwGA7oLvDi5J0OOHe3j+sJHs1h/S5fTiQlhepXiTz7sn6G6Phx0ebyQ2IAAUqpLaART1Oevf+9mq3AFjMid1RgLwTp8tryH1G/1b6KBHogs1HCRBzQjBX3wN/+pZGv8ot2qAYgpApLoM205SSpisL4fck97dwIMF+j9EX1F+ods9cyWj+zsHoNnIm65iev8SMUtwsqQBCHMby68hZSo6q1yhvdh7BKuvZz+LUvL4VUIGUMINAb/nv01QKgwrNXFFrH9F/FYy13dj2iFxzrfgu4gmqHFGmYS+DxWwMm3j0svSHKrjRI1ncUTeY7/cVX2nnuMtrujkZlS10WLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bcDravm1b1q7vkUfcUHo8y2CZ41fChrQGwof1Uwntc=;
 b=nwWftXM4TgwXE5ZgeMw6BJaQF3dqRO9jxWAt/wghdaoLSbnP5p/Cbq5HVzeiFfi0H7WeXXmHbIHrnlftppO8Ek0MASZ9MsZJzqeai4xIHAm2R055e9HtDHjHJnhrpk3xLpKmRxwcDDN6G486EtUrjSsERQ/hGZp/NkZAC4N0ka7qn79CtBp6llOtBELTfYQ4mHovQyAZQXLbvZqBR1JcWJv0SKdHoahITPe4lrCxfkOzDt1DhO71xUJCr10FPBLL9LKIhmUUEBXjqvdCh/prhZ3aLjWP9GarMy5CeBAuWCPAP1v06FNND2G5TA6lR31QuLNuKhDGvXBnLpkfKP2Y1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bcDravm1b1q7vkUfcUHo8y2CZ41fChrQGwof1Uwntc=;
 b=sLg6NJ9pnDJhJzE524FP36ERrcoW/VHHKi83bZiwGNKuZkkPf6PjHL2GfjzZ8IOuvHhdJGSFr+tOof3d/QVSAOXwuqgGusxZa4lo0dWl7vM2zJuwMez4prx1JFlC4YWgb3JsnzYGDU5+QT4Vo8gTiSO0+/+o+vGtsdKAulkVfrLk8LdXbwy6c1Ur7ImouzUtgA3TBVayCxPAIPWpLudoMhplKD2ck4DhEC4bWwQ1UQrt29awNyb2wO/ZWzAuFYpvbGUpr/a4U7AM6o/Fg+MwgM5XIg6UokVKxIstjvSFdrMsyHUDS9ForVHflGXOtBY0lKjLDp0YGWqRUD7J6zA8Uw==
Received: from BLAPR03CA0063.namprd03.prod.outlook.com (2603:10b6:208:329::8)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:01:50 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::f5) by BLAPR03CA0063.outlook.office365.com
 (2603:10b6:208:329::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 12:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:01:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:31 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:27 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:32 +0300
Subject: [PATCH vhost v3 08/24] vdpa/mlx5: Clear and reinitialize software
 VQ data on reset
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-8-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: d98d9366-b098-4650-649a-08dc9f45c055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SC9kaTZpNTNpZVZiZm5ZOXhEd01tZFRGODZrVy9tbUpDeGwvT3U0OGtacXVq?=
 =?utf-8?B?OHlKclR1YlBTNWZOZVdpTGVFRUFXNFVvbFkyZHl0dHhXL0hMMEF0cWhaWEc3?=
 =?utf-8?B?OFpFcFlvbW1BcFl2cUtBTXpQb1ZpcHVrODIwQyt1NFVaeGo0YlNjUUxBcXZr?=
 =?utf-8?B?d0NzUnNHZmhWTk5VUVBvY0pJbXZHS0I2amtESDNQREtPVklpQlFSTXNzQ1VK?=
 =?utf-8?B?S2NyTW43RVFpNlVyaGEyZHJBSjkzWk5tQk13aUpkWGZoaS90WGV0aWRIaU9R?=
 =?utf-8?B?WlJ6MUhzd3lvZFoyK2wxSUl5RXdqdFBmV0c0VERibjNCZEpDWUltay9TRUhm?=
 =?utf-8?B?bGgvMitjaVZLL05CRU83UXQ1WGs0b2VsN2RoMWNQelkreHh0TUJrRTZQVWxy?=
 =?utf-8?B?bGhlQjVXR3g2T1JSZWhuUDBzcEZDK1VQdEt1UjRUdCtNY1EyVVRhWG9mWms4?=
 =?utf-8?B?TExET2JqWHhjT2VXc01zUUloeThZZFpETVcxV1FVTkdweUd0SnYvczh3TGtz?=
 =?utf-8?B?YkV0blcwZG9tanhvTmxHaVM4TC85SFZxdHdmMjYzeFVpTFVIR3lrYUNoTDNo?=
 =?utf-8?B?Uk9QR0lwZUNHdFRZNDlZQ1FXSzlrd2RPNHhNQnhleHRsbnZnUHNzaWJXY0pO?=
 =?utf-8?B?bGkyUHBHNmYxZ3h4WmhIaGVuVTg1L3FkWHVlMEM0dWRpeVBJQlJUcm9YVHl4?=
 =?utf-8?B?ZmVTdkNEWFVrTkFIY2FrTTdyTUpoOGVtYUlRQWhxWWtXbFEyTE5zM1luU21p?=
 =?utf-8?B?Q2pEYTFBUExJeWFNTjlLNWxsS3EwYjZldU40MHdjRk9jWk5WZkVZQlpFUkhQ?=
 =?utf-8?B?ZG1JWGZmRy83RkJlSzdMMHhiZnE0MDdUTHZ4WERLVWJWcUYvUGdGKzBCdEs4?=
 =?utf-8?B?VUlxLysvQjg2NWdNUktQdzdPMCtEeE9ISndEWVBpa3RYRS9LQzFNeW5ueWY5?=
 =?utf-8?B?WVJrNHRGc1B6NStDeXlyWFl1ekhsQVdzaTBmL3BYdUk2UFl1bmhpRWVWQmZt?=
 =?utf-8?B?dEI3MGRnRUNWcUtmUkFFajl2bjJlcTVRM0dzT3V2b3RHQm5RRTJMZWVWaWRo?=
 =?utf-8?B?NXdIcWdkVlhVanA2M256ZXo5Yzh1eEdZQ1JaTDVWdXNGbVB1OXVzWDdRQlZw?=
 =?utf-8?B?Uy9OQlJReW5Yb2ZPa3NSL1FZYUtLSFZvWlpTQnUrdEYvOTl1YW9PV1lHUjRK?=
 =?utf-8?B?QndmVmc5RlY3UUpPNURmUTg1ZjlJbTd3V0taeWJZN0Z6eS9LQmE5Z21nUWxm?=
 =?utf-8?B?Lzd5emIzVTZ6MnRhMW16c3V0UFh6TCtkbUM0NFFwdWxrb2tuc1NtZVdoQ3VU?=
 =?utf-8?B?VGxrVG9ZVWt1TG5INUUzeTZ0bEJjck96WjRsZjVEWWVZbmxRdXZaeFZNVEZJ?=
 =?utf-8?B?QUd6SGhRVmFmUGxyWEN6emZlTU91TEtUZWJmbkpBMlZscjVtV0ZTV0Vwdzdr?=
 =?utf-8?B?cHVVdGY2QVhXVkJoSjVGWXRPMnE0bVhEZEtaVVluTGZjWGkxT2pXdmFyVlRD?=
 =?utf-8?B?SUk4My90UW1uMkNPL3l3ME01OGw4ang1MXZJaGFEUVlTYnNZZ3M1bDB6c2xi?=
 =?utf-8?B?aW9oZ0dYeno4MlMyQkxnWkJEN213eTFwRUs2Z3ZwWlJCQnBDdHc1S2VXL1pE?=
 =?utf-8?B?Y2t5djRYNjdFT1Y4dGUrUEFiMWVtc0RBOG1jbmtvMEpKRVNiSk1OOUJMTVli?=
 =?utf-8?B?SUZVUlNvUGFhbTkwc0ZVdlRFZmgwTEpBYnFCY0tjeFFRWWpRNTdUR3g3aFF0?=
 =?utf-8?B?TzBqc25DdlNJdkZnTDkyWjZ1WE9VNVBTVjYyTHgvMC9PeldGNnJpa0xCNzZI?=
 =?utf-8?B?dHFWcGxiQ0RTR0dMOGxJaEdQN3laTkx0NktQRTFWOUN2aWpkWFEySWZsWCts?=
 =?utf-8?B?aGZVcE9GeHFweVpEbFE3N1l6VFNFNU5PRmE3MGhHZ3NGTmxhU3BINnIrWHVm?=
 =?utf-8?Q?qvAC0fmfuRHXhwZTi1Ba+upsNniPGam+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:01:50.6899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d98d9366-b098-4650-649a-08dc9f45c055
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368

The hardware VQ configuration is mirrored by data in struct
mlx5_vdpa_virtqueue . Instead of clearing just a few fields at reset,
fully clear the struct and initialize with the appropriate default
values.

As clear_vqs_ready() is used only during reset, get rid of it.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index c8b5c87f001d..de013b5a2815 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2941,18 +2941,6 @@ static void teardown_vq_resources(struct mlx5_vdpa_net *ndev)
 	ndev->setup = false;
 }
 
-static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
-{
-	int i;
-
-	for (i = 0; i < ndev->mvdev.max_vqs; i++) {
-		ndev->vqs[i].ready = false;
-		ndev->vqs[i].modified_fields = 0;
-	}
-
-	ndev->mvdev.cvq.ready = false;
-}
-
 static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
 {
 	struct mlx5_control_vq *cvq = &mvdev->cvq;
@@ -3035,12 +3023,14 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
 	down_write(&ndev->reslock);
 	unregister_link_notifier(ndev);
 	teardown_vq_resources(ndev);
-	clear_vqs_ready(ndev);
+	init_mvqs(ndev);
+
 	if (flags & VDPA_RESET_F_CLEAN_MAP)
 		mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->mvdev.suspended = false;
 	ndev->cur_num_vqs = MLX5V_DEFAULT_VQ_COUNT;
+	ndev->mvdev.cvq.ready = false;
 	ndev->mvdev.cvq.received_desc = 0;
 	ndev->mvdev.cvq.completed_desc = 0;
 	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));

-- 
2.45.2


