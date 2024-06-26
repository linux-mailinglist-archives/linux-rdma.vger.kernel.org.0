Return-Path: <linux-rdma+bounces-3505-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65156917DEC
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F37B22336
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D201836DF;
	Wed, 26 Jun 2024 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JG8aF/7c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE5179658;
	Wed, 26 Jun 2024 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397661; cv=fail; b=ijHMkOkewzLuu6Z0oe+slg/VdJDDcPwW8W3G5l72EjY1Fm4DiztL3LNBRtlj1xKpF2vDQZ3aov/N5W0Vk6+KMdkLyk/qUAfjqICdzMr0QSJs/7xQ9Ea8aCZ6Oheo9jRGzoFiVIRSdpFAyyps5R32F2bpL+R4/XqdU7Qcamj+bdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397661; c=relaxed/simple;
	bh=vKRd33xurROsI/fY4JzovGQJZypYzGZuUeK29nbV37o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=B3WNlwkFUbZE9qaBVKp0fXJnYROMg7vjCgLV3MyLDJodoTkR80QSK5I/jIp6l08FAv2ApgN8w2cvzzo0je8HjVyohhAvYmHcVT56ia/7N3ov+D6DKtuMZrH04aLdLCNcBldFQPzQ73ZyRReIv2LyQ5Zx1x4Z/JqYMW/T4AkwQ5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JG8aF/7c; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGNCLvoVzD02PrZmvhOaUsF/Iza6UDCWpX6LwZVmJ1ZSw/w/o5NQm5y0Eunhrlvj02uallbHrzMBcIjzGDV9Fwj9o5UKYcTPb8lbt+MOTSi065omMF47zzVM3XDTClTDtvbcevAvy2qRaSGZujDH7KyJbF2rSh/e568tVQmJrrp9kzTK8LL0XAh9n/1kArOtPHNGOXPDKDfXrFI+7X+v0FiTw9PtldrbiEg4pkzWRIx/6A/tmxvFEvj7oJW5Up4mMRSkiNMVBOQai3RxL12RhQl4WJmFkmYfISavAD/Ou41fyYWbjWc45D+zFABGEin5CcYyXVAJUQkiY1Ff6g0s7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjIL84t4a2Y7anWx92JioqghEPkNpsNe11kOyiWnVk8=;
 b=armQxs4ia1jpMiS+x6gv2d88vwMWtZt2KEgH0hsVt6DLLW+EqdKD5IzyLnReodrPgC40g7mhOM28+64BGUIHpLiqBwGL+wdeU0h+hxSOKLe8ZOgfXeqBz8C0RGHNFXgxNLy6GgyELw67xOGy4we5aMy7dK7Bwx8KMsAbxVqMmBVjLPPga/G1aD6zjb1gfKNrZCThERFFxTr9A7YUmvepUMS6Z+2wDmP8QNfCSi6iyh7/IcMLY7wnujoNYe7KFvhLU7kZo8X67kAXp0M57/vBspelcj7RwTcqzf7vjT9SToAopItAnnwisCjYOZt3cQM3C+tuNZrtx+6JmC8N6ZVWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjIL84t4a2Y7anWx92JioqghEPkNpsNe11kOyiWnVk8=;
 b=JG8aF/7cTDzclP6/NUPXn1+sDutbiROZByDf0St+U/U2AqWreftndZLFb+s8D0UGNAlBf5fFyKHEq0ZdGFoJ6KSvWjXGOPlPvhIhOOtWgxdBRuDomf1DaYxaOyFuCIAOyn5RCJPKcZknxXVoHiFy8DBhI+2Vraa3lB7dUHhBia5+NDBlzj639vrBpgMU0tg5jCyr+baaxKcojebflWz2ce4GMXJYqCSb8vFo3oXhTSnqYBUnU5JBYilBs7fkHd1MZe39XyNI0lz4zJb77WZn9Jyt9wQWp33hrfp2ubn662ycQiBqMgNH+2PxJDKp9BOtx9tWTIDWcs0ekVOUk1qqDA==
Received: from BL6PEPF00016417.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:5) by MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.33; Wed, 26 Jun
 2024 10:27:35 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2a01:111:f403:c901::1) by BL6PEPF00016417.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:23 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:23 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:20 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:45 +0300
Subject: [PATCH vhost v2 09/24] vdpa/mlx5: Rename init_mvqs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-9-560c491078df@nvidia.com>
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: b1cf311e-5744-4fe6-7204-08dc95ca98b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|82310400024|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGdlY2JlY2ZBSzcyeWk0V1hxZ0dpYnV6ZmprV0tSTnhSRktyc1Jla253UnFM?=
 =?utf-8?B?WFdVU0w1WmMzWGhSZGY5NmtFVDBDSXR3L3o3QjJycEUyemduTzMwa2V3bVF6?=
 =?utf-8?B?Unh1RVFXNEhXdmZZSUFJQ0MxVzJoOTBDbjcrbU5TZ0pURGxQWHZPMEoybzN6?=
 =?utf-8?B?S1pZdG5oVE5HZDROWmw0TDBqdk1PQW5OZkJsL1Nqbk53cURCT2xmSjg3RXN4?=
 =?utf-8?B?QXMxbW5vZTV0dFpOOWdrZUNENUZ0VndvQlo5VFVYajV0by9KUldhRmNFRUpW?=
 =?utf-8?B?cDQxMWdvR0xHcUtBb0pGZHp2Mmx4NUpnV1l2QURVaFkweDRHbHo0QkNXZ2dO?=
 =?utf-8?B?aGxqYncrYnEyYTFkMllnQ2VGTTR0eFgyWVExczdkUi83cWFPZWlLN0N1NTJi?=
 =?utf-8?B?ZStZY1cyQkUrWk9lejZQWWtZRE9TOTJ0cDdmTHdtUXhHQzVQN2FKVk8xeDJJ?=
 =?utf-8?B?UjRnaEpMWFdJUTRiYm5mQktuSGRaRmU1aUN5SWpZS2NxZ2FxMlFjeXlCNDRB?=
 =?utf-8?B?NGQ1c2lPbkQreG5NUGRJSFpYTUFPaHMwK2pPZ2JhakFobmI1czJiS1lMUTVj?=
 =?utf-8?B?dkk4SDVCNnJYdXp2dnNYNG5MNDJRdktvWVYzNmo5cS9EY2lJWjRXNDA4TTJU?=
 =?utf-8?B?UGRDN20zMEY5TVdrNkdXZldHcUN0NXBlQWhhNnJ3Skd2dXF3TXoxKzRVdkhE?=
 =?utf-8?B?Nkh2REw4RjBjSEgzNC8rSi85alo2U3JVeW03dnFIallDdTI3amxISUdzMGVw?=
 =?utf-8?B?VWRCeGZXVTk5Zy9adnpia0FpOHl3UjRNOEordWJhb3U5UGVlOE5MNXRiL01X?=
 =?utf-8?B?VElhN2o3bHRSQ2tWOHRRbFJmd0JvUmZDR2ljR3Q4MTNBVHdJQ3VPb3JWcWJD?=
 =?utf-8?B?ZzF3eXRKOHlSeTN3dURTUGtUTnR5OE5hZmxUUis2YzlQZG9oTGozVEMybG9E?=
 =?utf-8?B?SUcrZ1BDTFM2bHN4UTlSdFBhSytuZWoyNHMwWWVEcXVvMEdCdWxVRU9JdjY0?=
 =?utf-8?B?NFR5a3o3MVh6WS9pZVpDUldBU2dKcFJhZFkveFRqMUNjbVpHclFmK0srdEJl?=
 =?utf-8?B?alY2UFdhVEc4MzJYdFNQYlRIcjlleEIyRXpBbDRLSUNZWmdrRnVKOFlNRHZN?=
 =?utf-8?B?eGFIcXdnOFdBRWF6U0hteDN2VXJVOE83Q3EzSkMzZFUwRlhET2VoRVA0WGFh?=
 =?utf-8?B?WHhoRXNjRjEydTdpQ1FFK0svL2tlSEd2RmRHdmpNeVRBQkhTUDZyNTdnR2dv?=
 =?utf-8?B?YWp6UU94cXcxTVBFaFNrbHRNT3hzSXVXNFpWd082bDhWcy9HK0w0azFBQTBr?=
 =?utf-8?B?NXgxK3RnOTJMNDZIaE5QbkUxOHN3Q292V2FraFY4VXdhY0xRbTFYMEJreTNp?=
 =?utf-8?B?OFQ3aGZwYWtjL0VYRzByUnZqTnlDZnJvWEZjRlBMeTVuUlpRTlBiMEp4U3li?=
 =?utf-8?B?TnY0bmlNbHdwc1U3QjVBNTNOSmVFK0dzSWFsWTBqbUNyKy9wdU1BekduR1ha?=
 =?utf-8?B?dVhENDBlbkF2b1ZiRmdjZVhZbS9oV1VOa0pOOHd2QjlHbVFyZEM1UTY3NDE1?=
 =?utf-8?B?TlozLzlyNjBteHdtQnpCTUlyOTk1NlpsVXoya0IwRWFZTDRKSGUvY0I2bUpa?=
 =?utf-8?B?ZWZmQnlKa3RVeWl0R1JNR3JibTJNeHdZemo1cXNJcEo4bzdpSE5DWnJRMm4z?=
 =?utf-8?B?ZnFwNUdiMTNway9RY0RhS2VJTE53V0xSL1dvNFFPZEIzVEhubllYZEgyQzdX?=
 =?utf-8?B?dTNKOGtUR2dGWXdSSXpzM3R6MnJYOVAxc0FlTWdGemJ1bElCUEZRNmxtdGpz?=
 =?utf-8?B?ditza2dKM2cydzNqdUtobE8wMC9ub1BiMFdMVHpHYmlPNzFIR1NlMHE5S0du?=
 =?utf-8?B?VEpUN2tjcC9hajIvczBGMzkyRGxaZzNMa01WMlBsNWZVQVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(82310400024)(1800799022);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:35.5918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cf311e-5744-4fe6-7204-08dc95ca98b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977

Function is used to set default values, so name it accordingly.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index de013b5a2815..739c2886fc33 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -155,7 +155,7 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
 }
 
 static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
-static void init_mvqs(struct mlx5_vdpa_net *ndev);
+static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev);
 static int setup_vq_resources(struct mlx5_vdpa_net *ndev);
 static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
 
@@ -2810,7 +2810,7 @@ static void restore_channels_info(struct mlx5_vdpa_net *ndev)
 	int i;
 
 	mlx5_clear_vqs(ndev);
-	init_mvqs(ndev);
+	mvqs_set_defaults(ndev);
 	for (i = 0; i < ndev->mvdev.max_vqs; i++) {
 		mvq = &ndev->vqs[i];
 		ri = &mvq->ri;
@@ -3023,7 +3023,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
 	down_write(&ndev->reslock);
 	unregister_link_notifier(ndev);
 	teardown_vq_resources(ndev);
-	init_mvqs(ndev);
+	mvqs_set_defaults(ndev);
 
 	if (flags & VDPA_RESET_F_CLEAN_MAP)
 		mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
@@ -3485,7 +3485,7 @@ static void free_fixed_resources(struct mlx5_vdpa_net *ndev)
 	res->valid = false;
 }
 
-static void init_mvqs(struct mlx5_vdpa_net *ndev)
+static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev)
 {
 	struct mlx5_vdpa_virtqueue *mvq;
 	int i;
@@ -3635,7 +3635,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	}
 	ndev->cur_num_vqs = MLX5V_DEFAULT_VQ_COUNT;
 
-	init_mvqs(ndev);
+	mvqs_set_defaults(ndev);
 	allocate_irqs(ndev);
 	init_rwsem(&ndev->reslock);
 	config = &ndev->config;

-- 
2.45.1


