Return-Path: <linux-rdma+bounces-3222-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D9690B485
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FB21C22769
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EAA146A94;
	Mon, 17 Jun 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CIDkWPyF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64FF145A1F;
	Mon, 17 Jun 2024 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636925; cv=fail; b=oUkRQT34fg4erCPJa+wPDJOvktI/y2JRxooAU2wKkXHBoLIsIxdkRbR59ISCTYZ4nCGefXztvLwdUXfKIr4CjTGXHRghULGJJahbPLIKOPeFDpZGJaX4wn42Hp7g9QwVJQWoFgdVenT+uGDDS6xGFulGHC3JnOmaa4yp2FMvLHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636925; c=relaxed/simple;
	bh=/GcAG51JzSd41406OQJOJV5R2SAJ/EXb73/Zmue+8zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ojP3ekWb5aXEoQ7emQrLcPJdGbYmAz2PqOIwMydigYSna4K5irwpJqc7bFOwgCiYDxSGNJy7l7t0l5l0R+Ndy4ItEwkAN82tkmKvv30n6dCtVrBOhIdo3co7ZrmaO6Osy0d6+QFNkqR8/89DBCb4CzHtfZhOKoTgoS7dFi4KCy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CIDkWPyF; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgO59ytYSFv3ydMta/ZBX54XsE+n8pU1PviBy7F3Cal3PxaiwZlbXqFmgy+2PIjXeEmIHgQjeaaFbNpETGs0gL7Cxq59VbalytVJsPHXPbr0m9235ZoFRNNgoSLm5VygE/XTZEK4aV7yk9KqJ6bhVNIiR5LQviVSGkY6iZ7ZI8HzOLqqA4BR8GzrdsqwB39hgUEUSRrRryPiY7Xk1YgwduUVaxd8Lib+lea0g/ZUepoCSfMHDnKI73RWZ0daZyDcxkhQlog3mbeMDvVwjqwcCyVMPQk+l6+0rwmNGa/W+lm0eb+M0c03LF3k5uA+HV0x5NXjoz60tQnche9iNmkJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br7FTYfEmEm/j676tWsLBfs55UWg5gCW5oR/lgiGrFk=;
 b=f9zMygx5HArPlEWTSNA9LTAo3xtW44xAfgl8hHO27uTgpWTuA0PlxlN+R9TCA8WxlhR05YOzwR5puXXZymkEYM93nPvxNLiej9LM/bvgqGL6rL42abNY9SpiNTB1syw7F3BzlF3Gv3h6aXPjGhqr+DNvOe+UqsFEXbUkvRWxwchRV6qDj042vuoY/uOhQ+XiRxX+WxQYJMaAJwmjTRrei5e6yU9DVuaPr1/BATHCvg+enoDGlw/iYnBKcwjv7jPkl8Sqxl7vE4rzydtKuRbhgBO6Wn8rBTZ6EL4dyu+8FDvpZcOnapHFPNbXhRKeIjvogU/sa8rEb5MJ8rybS+8Yzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br7FTYfEmEm/j676tWsLBfs55UWg5gCW5oR/lgiGrFk=;
 b=CIDkWPyFTu7whgtyY5lJnS9sSNAKjHk1YViKxXv9ziOtjHmD/mS5nVZ1AV9j0tlCrE8BP3xqX3PVhErSz+zr67Wu3kPGV1+enSdyB2LS+gq9e82ztcSZz3GeAxrZ7GLMxkwGQX0ht31IVjiwDR+xiI1Bn6EN6ytBq68nb9NSvkmdkJgNBVYkFnSB1E/J93sNZZQGhnl1e/70iede4IarAyh6zP9JBDrE96d8NdBovcGuxuKeJ7GAH2KnEkZ8HGn9J72ihldoP1gzc8jXx9BIwQYi7SHfSeRSrIUKJ7Yz12BNQXR0gn1XSJDwM1NZhdLQzSHw6sy/RHYO4pFVbhD0Pg==
Received: from BN0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:408:e4::26)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 15:08:39 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::f9) by BN0PR02CA0021.outlook.office365.com
 (2603:10b6:408:e4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 15:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:08:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:19 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:19 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:16 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:42 +0300
Subject: [PATCH vhost 08/23] vdpa/mlx5: Clear and reinitialize software VQ
 data on reset
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-8-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 9892c8fe-e06d-488d-5461-08dc8edf5e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VCtmTFBFMVBLSDdobm82SkNQYW9SQ3hKUkhKMkR0cUVHTkI2ZXMzelcrK0Vl?=
 =?utf-8?B?UFptaUZ2bUo2RStrSnUrRlpnaUFxWjhGNDR0Kzd0dkpvVjdaWDQyOUZLSFlh?=
 =?utf-8?B?MUNhSjdYN04yMSs1Uk82TWc4TFM2SXh1S3dEd2xadzFvb1FiazFiK3hOTlRv?=
 =?utf-8?B?d05IYWUvQVVFazllZThXWFgxamNmRDlyT09lQ2xLREptM092NENJckJrMlpG?=
 =?utf-8?B?YkRSZ0ZaNWxoeE1JN0FmekNxT0E4VFJjSDZmVkpaajA0aW04dHVmZUlDbE01?=
 =?utf-8?B?akl3V2htZ0ZwZld3QjdzOXdUdS9KWnJ6UEczamh3WTNoNGR3ZSt4ZHk1WjNC?=
 =?utf-8?B?c0tNYkRnQ1QyeWsxS3NDNjVUVGRYYitSVk4vVkNSZXQwUmZ4b1FsRzlHUHQ2?=
 =?utf-8?B?TG5TTnJubVFzNmxiMkIzSktMU2l1NEdkNDFwKzhQMTVRcjE3ODg1NUt2czV4?=
 =?utf-8?B?Z1cwTjF2WW5nVGtUUWFNZkxOcVpCZmMzZERXWkVKTU11MTYxbXFLY1ZRbTdl?=
 =?utf-8?B?eXZIVGhlVlY3d0ZwV0M4YysvcXRjZmhzdG1KL3ZVSFJCdkNiRnpzR3ZxTlhK?=
 =?utf-8?B?UVJPSkkwa3J0dXNsMzA2ejJDNXE3OTdKcDdpRUkyaU9XR09hbDdkNjNtSklU?=
 =?utf-8?B?Zld4eUhHYmJQVjVhWWt1b2Q3UUg4VmEyQktpaEFJSGNZTlVZc0U0L0JOZzRM?=
 =?utf-8?B?aUd0ekNNeWxhZmVJdWxIOWZ4NU9TRnhVRjArbVhWT0RFTk9rN3pJenZvMllo?=
 =?utf-8?B?UHlONVZQM2Jxck8rSm5DbDhxd1N6ODFBeHZWcVJXR012U21pSXFqMlJJdGtC?=
 =?utf-8?B?MTVsTUY2dzBpQkp1K2NvNDQ0WGUyRkNYUCt5aXNGUmNYdHdhMjBhdkhteUgy?=
 =?utf-8?B?Uk8rVHMyWXNlOFpKaGNNTENVUlQ4cHdUclRvOTVyeC8vS09BNUVNUkdEai9P?=
 =?utf-8?B?cWQ1eURwTGZDaDg3ODQ2ZVRQZkZOQkZzSVdOWkFnSGJEV2lzRmo0aUZaL1V5?=
 =?utf-8?B?ZXRseXpsMzdVY2RveTFFOEVDS0VMMjh6OEcrQloxZXpIelNIM0ZqdC9VK2JL?=
 =?utf-8?B?ZW03Y1ZBbUxOUmdnRERHcC9RZVpValJvK1NkTnlPVHJzdVdwZTBtNDZGOUE0?=
 =?utf-8?B?RkNZaGFIRmVUbXhsMnRETnJTUEUwRnNDQUwySHJHZER1QUhsUzhiQjRCaFA0?=
 =?utf-8?B?VG4zaVI3aXRKYW1EclZRZmdGek0xUzVUcVdDK1d4QU5id2hyZnhMNjZJN2pD?=
 =?utf-8?B?ZFRHSkVlZ3dmVjFYK2FJTzVwVCt4dUpTdE1odG03a1h5Tnk1cUgvaWMxMk5n?=
 =?utf-8?B?N2ZiSGJ5SkhoYWpBVW9RK09IZmszRFVoVmFleDlTWjVyQzFHTk5wMjc4RHNY?=
 =?utf-8?B?VnA3QTAwbXlpdzRCNEhKUVljMTN2TVFhS1A1U2NUMFJWZlJuR2p1cFFiUUVa?=
 =?utf-8?B?cHpuTjJjWExJZUloYWFLMmwzNFJ1TUl0ODNMNldvVmZ1SHUyV1FJS0toVUFp?=
 =?utf-8?B?NzllVGJ6R2JsWExzd2dEdUVuWmh0OU8rQkRkY21ObCtKUnNEdC9oeGhYZEpp?=
 =?utf-8?B?cUg0dXNHaUxuaXlMZm9OZGQ4Ri93cUQxa2Rub2JjcThKUnU4a1NFak5RQ1Jy?=
 =?utf-8?B?UDRTK1IrSVkyazltUFdRbEdoVUpFUGFhcHFqekVROE1ya1IxTUlUU3V6RU5n?=
 =?utf-8?B?Z01KTk5weWxiT25UbG9XQlBJS3dvSkJSOXdVTkk4WUxjcE41eWx3c1BQMVQw?=
 =?utf-8?B?OEI5UVgvc252akpxWUNySzJ0S0IwdWlJZ3FNb3V5eUhXc2JsQWU3YjExdlhS?=
 =?utf-8?B?cmNPejU3eUFuM1plR1ZHcnV5VVNsMHdTb3FvTTI0L1NjZlluWnJjc2hjcENi?=
 =?utf-8?B?QW9MZDZVY21CcEFQK3E5VUlQN2oxb1lMMjBjeGhLZm44SEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:08:39.2605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9892c8fe-e06d-488d-5461-08dc8edf5e86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654

The hardware VQ configuration is mirrored by data in struct
mlx5_vdpa_virtqueue . Instead of clearing just a few fields at reset,
fully clear the struct and initialize with the appropriate default
values.

As clear_vqs_ready() is used only during reset, get rid of it.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
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


