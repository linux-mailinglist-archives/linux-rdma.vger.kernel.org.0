Return-Path: <linux-rdma+bounces-3506-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A568917DED
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 810DFB22E65
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5781836E0;
	Wed, 26 Jun 2024 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CHh8D+4J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E695183096;
	Wed, 26 Jun 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397661; cv=fail; b=k5Q1ASNucZcq08kNC0ZHoI1vvRRJAabsRCSNU1XHodfVupsSTVXnBV5m6XAIJbHUnLGNI8WHVss1e/9ZpcATR5KQ7WH/rCsXiBLWwu0dv6MguzJnNHVPHjcrBkGCDw8ompEKa7SK1ZUNC9vKFraP+NB8EaYrPqeFTE8rDazSW68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397661; c=relaxed/simple;
	bh=Dxzlz7VSaLZaqmiMutMXO215DeRDvUpsG8J3sC1xsrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WwFuFG8hOyJRii87m+xWfuvwHs+C8eYQgRRcTQaYTd9jcnkgHviDW7ES6lBo89uQs0ZgZViy0jNwq6nhtGYKwKWBJ3WDrE5mbE4ZnTbM1v6INlTUaJhzrGSQza4xNQYCNMboWYi0EFMCBdnSJ3ezfZx22tjtjNm+RbuR5dEQYF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CHh8D+4J; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTrzyy7rIhMo6ult32iijf36OZM02JK0/d/rW87galUlfHHtVm//RMmnNevHb9h1lT6m0V+2MT5ar/G+S8EO5Z0DI/vqOCaSLFV7GnftffT8ROAZVG2Xt31z6igQrqPOjpJFI/0UhbB2+g/fKrcTwgfKAGovoz4KLJiygUF++nvGCodnXGp6TZmuveth6u3uSeVXisfetoepfAlVUunPGwXFjp05s6evkW2dKgdHpnSBadA9VYNTGKIfluNnZXZJcutTGDesFAcs9hjjKE4tKGJEJBWiKqFHM9rf4MGtLgM5+GffT/24iC9JQQYxKiXP341RXWAr8hJP+BZvJQVw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD2KcuDuD+3gjYMlqq3nqJyDm33SFFpKTBKFXVud5HY=;
 b=Vl6N5/jTDVtLy1T1IjGXIgZ+h7KU2KOqOduX60fY7IABwZFpbnrgx4Nfdq4dVnsZZDeFCYBz4g5bKaKSM50dsVFbzIrsQvhz6P/RFDJ/XOwsnzOjqzzREgXdbraPSG2LCWBvOTbdIP5AUu/IXkViWUOwRvtNBa0HMsk+cYlChNJNTqQ07rKv1ZI4p83k4TBmp659UYLi31AlLfvG9/3mTBIvCOnHPIJdcHOAxYzV5hzYNAxLT4Jf3ctlhxkjf8tZtNe0RQUw2obCVkbE2dDqlVEgpd2K3NzyNueT+nPK1x83V8hMT9lATz7rhVORd4KTM4fvq/0WYQhi+0fiHQY0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD2KcuDuD+3gjYMlqq3nqJyDm33SFFpKTBKFXVud5HY=;
 b=CHh8D+4Ja2Zj5+0ZSgs/BPa3b5JNB8IOQUfzS1FcyaYu6UlkYuehzOi/Jw9woVBZQFxqfNlIQvFnfDhWPrwbkGJXtWBSXVvyyoG8HBtCslIICI+m1iD2pjvG/STlQls9ZgektphbW0ftRb475OI8vYFoWx++kik+IT+DyUksf7nWqz5sblksQGTboq4iXbmTC7gJ7wpCOkN265CQR3VaXhty2HIrjPF6JPbBIWtKXt8rbiAQ2UOHp0zZv0hsCV00fbQ42NVky+LYSlnGlG7lXRNH5g6A4WzjuXnk0MAACYDqYeRxO+8NnW6pIb68YU23YQX3Thyizvo2+WZtqpcm2Q==
Received: from BYAPR06CA0064.namprd06.prod.outlook.com (2603:10b6:a03:14b::41)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:27:37 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::dd) by BYAPR06CA0064.outlook.office365.com
 (2603:10b6:a03:14b::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:19 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:16 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:44 +0300
Subject: [PATCH vhost v2 08/24] vdpa/mlx5: Clear and reinitialize software
 VQ data on reset
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-8-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: b2199088-bf62-4827-23c7-08dc95ca99d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVhRY2IwN1NWeGV0SXFNZ2hnbjVNcGpyZXdGcG5hRkphbFQzRFJiR1hpdWdD?=
 =?utf-8?B?NXNHcG51NXJRM1hzTkt5NjVRNmU3RE1KK2FHamRhelZpK3RGeUJWUGtiLys2?=
 =?utf-8?B?UHZPOURMS0l1K2lwV25FL1BPNUJ3VGhFaUdzbVh1YlVERjZLZExJU3RXVnU0?=
 =?utf-8?B?YXpDV1I0aE1oZ1Q1K1JaSzRmdFVlK2wyKzJULzdhY05RdkMrZ3Rzai8yRWpD?=
 =?utf-8?B?dnVBN1kwT3FHQXFaNTVDQ2ZkcjRORFRlV0plWmxqTXZpYXFsemQrVFFMWHdK?=
 =?utf-8?B?MzRzNWtQdXF1OG52THN3eUJsOUQ5ano5V1NuTVFwYTlOcEhQTXFxUmxxVUJm?=
 =?utf-8?B?M29pbFB2Wm1yUHJUMXIzd09UenJ3UUpJTHQ2U1dlSFI2ZTVZenY4TzE2OGtj?=
 =?utf-8?B?WFZ6RWk1SzIwWm1PM3h1bHAwTDdYWnp0d1YrOHFZeHJOWlBqQ29wcUJ6WXhY?=
 =?utf-8?B?dXBnRW9hWndZTTlHbVNmZWpxQy9oN3hvRll5MzIyV0t1aUp0cnZNZmtTbWNW?=
 =?utf-8?B?Y3JETnZwNWNDd0ZXK0NSMjZZeGNDWTQ1ZnU1L1FvMExoREFrQUx0a1VmQ0cr?=
 =?utf-8?B?MnY2dEhhYmgzZVVidmNPYUsrd05raWhBZFR6NGxpZ1RhRElWYTdlZW5aSU5G?=
 =?utf-8?B?eE9Uc2ZJMW5uR3JNMXI0RW9mLzdJQytoaWZjZ3V6eFdrWXI3bW11RERRaVJX?=
 =?utf-8?B?VS92cHFhTlBOWlVYRU8ySjhvcktBNVNndEp2NllIekw0eVFUTTFMMnpVSkRM?=
 =?utf-8?B?SFVXKzNscU1kQmlUdTdFZytKVUkzMzZPZ0JqWG9vMW5vWFl2UTV2QmFVQnZE?=
 =?utf-8?B?Q2NzMzRFS0orL0FlbXh3dHBlZ0JPL05BWGJvWXpoemgyWWJDRGhGVXdMWmc2?=
 =?utf-8?B?ZGdGMW9SL08zSFlWOEdZQUk3UWI4MGNHcUZPOS9peFJObjFXeG1BSExtZkts?=
 =?utf-8?B?UVZ5dEpNREF2MnYrZm9JZXZDZmdXN24vWS9VTEdvVEVFMG8vQ0orcHRZT2tB?=
 =?utf-8?B?TE4zY1hLYXlCbDV4eCsxUGJOeEZrMDBtTy9xbjdkQ3lTL0NRM1M3TUx6aTBm?=
 =?utf-8?B?NEFudFR1Y1NBNXRidVZGSU9CM3Y5cXFCbHA2YmJaRk55TlF4QjBkTFh3Zm1I?=
 =?utf-8?B?ZlJBMHN3S0FSMWRQQ0hEUGFnNVlBRUVWWXg0MW8zNysva1FWc1JySWtRSGNK?=
 =?utf-8?B?SHA5bnFKeHpzNWhsbENNNXJDTnc0WjdRUVRvaERMUWp1aHNSOTczUjNSK2Iy?=
 =?utf-8?B?NHZ6dEU4dUZyWFZJOEU5aXRTOFVDNVRzV1dnbXcvTXRHWk90RkJwQ2pBeDZm?=
 =?utf-8?B?b1VaMmFrb0h1aTQ3MkFqODE1RkFxZDF0SzkrbDN5Q2J6eFhybmc1UU5IY0tr?=
 =?utf-8?B?elEveTJmR2pJdzRpcnVJUkZ3dlhYK05VMnFzMzlTdFdZWXV2azY0QVlCU0lF?=
 =?utf-8?B?dTV1ZjQwUnIzKy9DVmI4dXZqYzhGaEZ2blZOZUpiZVZQekxLVDZudFlhaWVO?=
 =?utf-8?B?M01tdXdkVTRuYzZhL3lGNFhJRTZoVVU4Z0o4WS9zYUdmaUZNSUVUTlVrQS9w?=
 =?utf-8?B?T3BHMFJ4d2xHWDI1OVZUQWp4TFJnSThMK3FHb0xINTgzeGFDVDBlcXVVcCs3?=
 =?utf-8?B?Y3BrU1ExbFY5TzhsRkV2R2xxQTBIUThyejF1RGVmNm5hNUlxVU0raysxK1Vp?=
 =?utf-8?B?OUJMQzJ3SktJL3ZUTVR3WnpHbS9yeHd5NUhWaGZRYnZDVmJjdUUxQnp3WURa?=
 =?utf-8?B?a0VtQjl3WmhYby9pcDFjdnY3SDdZOXFxYkNUMTNsemdkclFEays3VUZFdk14?=
 =?utf-8?B?WG9CVGtIaEJzMDZTR2lMNnFwSjV3enVuU0lSazY1UHhHcGRkbnFBOUcyUnF6?=
 =?utf-8?B?NXpCUjE2QVJHYyttMG1rY0FjV1hUQktQaXpWR0xyYTlIMmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:37.5267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2199088-bf62-4827-23c7-08dc95ca99d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099

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
2.45.1


