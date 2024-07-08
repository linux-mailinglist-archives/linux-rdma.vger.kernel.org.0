Return-Path: <linux-rdma+bounces-3726-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2892A1E4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750831F21441
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EF7135A79;
	Mon,  8 Jul 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rojzHguT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDD681204;
	Mon,  8 Jul 2024 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440122; cv=fail; b=V4RBkKmbQNxGho+hacVclba4lh4HbAT5kSHwUo1hjbvIaai0vbmB2MBCtCb0APZ3S7inmUoE8GT/wRn/t/fwi172AgKT8eS1NatgzRoD0YbDsXh/fymr4gnDscsUuR9vVtCIkZbBe4KJ6a/K9nAK1VuZjalKZqbjYxon+64+Opg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440122; c=relaxed/simple;
	bh=12Dr6zuEz2nc2bE2dCzdzt24pNdY8ZFBxTyO1Ij5xvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Vht5y/7RzrnixXvQHoRAwfJ7MjP4+Ku2+5qIBFPF4K+yuP9gIrm9cfAmf2rn6QtB6+xDOoE998nJE7ivu+DXMt0mpmcDJM/3R4UJKOiC/PHMlJtZhxmlElvfO6h7DsqOBJ43U+drJ1kQnUkGtaBCxdqcXpeqVYuLdfLBrHHPwBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rojzHguT; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws7OBmJRKvKfngzUd1YYWZnDCp5lmEHhvgf+TbpDaxDX1sl50TuM1JTcQKiMcyFRNMSjufd7ORgTQBJ3OG7ZmmsiQz2OiqrfuEDFXPJyh9I/96PJTSwyT0SguPSdDDmsAJ/Pvojfmc+x4GXbOs6QSP0wOFH8w40ECNuuR2RSmaLTzTQsAtVr6oJmk0LJZIJ1hjSCZ6qvdbPo1rt7Iait0AhWgo8hUVCewjPIMTN3P9RqVosjykKswNOMor9+x9WEiZUEiL42DWWLgnX1fh+OhvevVN4CBdxU1aHAyOy9lssn5EBo+Ww66B5N2+H6nBb98Y6Gx2ud9SBOYBcNyPjeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCmX+zWkXUAYQ6ml53q+Q3AVZGrx6w5R19RLYsqCCsU=;
 b=PL+6f1NKTsEYG259Q1jOzgC+veJzBhFrZlSfDtTqhsmlgEsyF3eg0B5wraQlonQiPLfbIjgGSB2Yv69pOopcIU4E/e0/FrXYP8D831vDypxBrDz8c8+GHrzcLUY8rZVCebTC2UwXBTjSZDbRLK3f1V37n/q/XRoNWCBdDg0uHUpkfRD9gQ13illaO+ZdTjYkaYQmzPD482UFpjFK4BEe/BsNZy5wb8HMBrOJfwWUxxR/Djh4wOEAebtsLJ0TwUP6xG/zyDNKPE9BQtpMR1uoMut/CNcOVJ9TYXTKURk84S8A1Yq0earDg90hoPRyT6UUvZ34OyYk3+Tr+VooljX1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCmX+zWkXUAYQ6ml53q+Q3AVZGrx6w5R19RLYsqCCsU=;
 b=rojzHguTX3e/K/u/VgnxqHUozpjFf979FXswyJWLf8AwY2/DRx7NpE2GNtNiYtQA6oD3lZ0Q8X24bj8pZCecJL99W+alKm9cW+zyEflUObH9gNGYYS/BgZixT77aUzJNMJwo7d1kWY+WkONSLy43ZzJVngX4wcnQ+IJkftJ2oGrdDE4VQeCSMtVG8tqzK6mPJo9xq5AoHu4KBb6/1BdMELkbWgI9/mJz3ZG48IXIykdaS6n9lzRjOWmWBAJ1j7akrzCCX0XScg263VHoUkpM26fBu1oGuA72vx1q0+1Mx39YqtM2e1hG9YCZPqnz2WLZfiQdn2B/0On5iEanZW1nfw==
Received: from BL1PR13CA0181.namprd13.prod.outlook.com (2603:10b6:208:2be::6)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:01:57 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::4d) by BL1PR13CA0181.outlook.office365.com
 (2603:10b6:208:2be::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Mon, 8 Jul 2024 12:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:01:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:35 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:31 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:33 +0300
Subject: [PATCH vhost v3 09/24] vdpa/mlx5: Rename init_mvqs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-9-afe3c766e393@nvidia.com>
References: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
In-Reply-To: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 8380f6ff-d29a-4da9-fbdb-08dc9f45c47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rkh4YktNUHFBNldHY3dFRWlUWS9MeVFaUHNHU2NkY2I0V0t1Z1BYUjdxSzR3?=
 =?utf-8?B?ZnRWdnV3cmlhN3Z3SHhUVC9IVnIyMUFUSHAxOFhhSWxyaVJpT0xFMHl6c1Vq?=
 =?utf-8?B?Mmt0THllSXJhUjN2N045enNiNWhNUWU4ZU50N1I4ckFORjNHbi9nUEJMOUtt?=
 =?utf-8?B?Zm9hQmxJZFY2TTZGVFVpSzlkWFhxVjF6bzNNbFhUSnhQRENlWW5vK0ZkUnV4?=
 =?utf-8?B?ZmpPLytxTXNYVHNZeHRLQWtJb2NibGZDbVR0MnVWUFBHN1hUWmhVQlZ0akh0?=
 =?utf-8?B?aGNTYXhaOTZ2RHBWY0tqcUhFeVRFSEtxQ2c2OVkybFNGc3ZNM2M1elNJWC9F?=
 =?utf-8?B?MjM0RzVZeERPdnQ2ejN2dy9mUVgzTzgxaHVFamZIYjk1NW85d1BWRlRrUEs3?=
 =?utf-8?B?dkk5NGNxWXRFSm90KzBXYklUM2FzL1FodzJaMDF1T05aOEhtWjZpSVdBRW9G?=
 =?utf-8?B?YzhRRmhHVEVzVmQrcUxZL2VjMENnSjh0dG00YnA5NnZlQVczVmxKVFJzQ0hq?=
 =?utf-8?B?Z3RGZytXc1ZabmdCYzNsRkQ5dGlLaXpuNFBZV2xRTHY3TWN2enFyOFpKMDR3?=
 =?utf-8?B?RGc2SzlBK0ozWU1WN2lXL29SR0p1cDlpNWNtUDhSOU9Qa1Nwck5pcUZtZ1k3?=
 =?utf-8?B?WWpwb0RJWmxHK0JSYzd3MnBHOVg3TWpPWHdQWUM1ajlnZlYzTDQzQUF1bFZw?=
 =?utf-8?B?MnFnQVlCRzZ6VTJ5N3g0KzhWeDF0cE9aTEVNekxHT2w1eW5JYjNxQTByRVhB?=
 =?utf-8?B?L1dHVHBsNExmZ1Nla0YzeFZqKytxL0JJQm9uZGd5ZWU5UjFhWXBQSWN3U1hP?=
 =?utf-8?B?MDFqcUVtKzJvL1h2dmoxNFArcjhEcUZYM1JQUUwzcjZtYUk5dUc4TEdNVGRn?=
 =?utf-8?B?UzVZa09jQm11Rk9Bd0NOT2FQbUU0WVp3UWZXMTZqQlRlcnlqT2JGUTlYbWM1?=
 =?utf-8?B?V0dkRUR0MzdlcGhGc21MQ2Z5eHQ3eVdZNGp2ZmU4YTlhRG93SUZjSjM4Z0pE?=
 =?utf-8?B?V3o0LzFmbVdvdGMvek1BNUJJbG9VVG1UZXJCSUpHbjJUYisxODFVSVlWVjIw?=
 =?utf-8?B?Ums0aVlMM1Z6VmdIYnAzcFhhb3hMU2piaDdVaGdYM1pSSzFSN1FaTC91SFpr?=
 =?utf-8?B?d3NjR21aQVRFREUyNGVDWnIxcnErWnpJcUI1ZmJwMkh6WmJSaUs3clN5UHBl?=
 =?utf-8?B?RndWTTJHSU1iNW13SFczUkRIcFFTTFlTWHVYQ0VTVkdzREFzSXMzbUIvN0ln?=
 =?utf-8?B?MFYvSHBqWTNHV1hRNGdSdGdxSFBEd0g2WHJrM2lVRFlPU0JJOFVFRllsYkJs?=
 =?utf-8?B?R2hsMExGcDBpRWY3QUNNQXhzK0l0b0ZxNjEvcjBqRmd3UG5pNlBoNHR5dzEz?=
 =?utf-8?B?RlNva0VTSUgzSE9SeGxWZllNcFQxMTJmTkdhaW04RzFrNWh4bFRvQzhhRk51?=
 =?utf-8?B?R2l3V2J3YXdjeXIwcEF4VGlQZXdvQVJDaVcyb2ZzalVFUmtUM2dGRW1FSWFV?=
 =?utf-8?B?RUcvRGQvVUNYYjdaMWppWDJjbFljMVFiZEJJZG8vL3FVZWk1Y2Y1M1hYcHZz?=
 =?utf-8?B?L3J3cGtQc01RNVNNTDBrMUpzcllUdWtnYWZqbWRyWi81czVsUmhlSktlMWhr?=
 =?utf-8?B?eTg1OU1mZHRJNE9GTHhkMzFWUWVzZlE5Rm13UDlzeWg2Z0k3dGxZUGExYXJw?=
 =?utf-8?B?bmJtSG83S1hNZ0NVYjJzNU56NlM4d2RpWDRXYkg5bFVuWlB4SnRBY3o4MmVY?=
 =?utf-8?B?UnlYWFplRDZ4K0pqMXFhazdtYmlBUVU1YnZIZUVoWGNOdEh3TFVWa0JlRmV0?=
 =?utf-8?B?cDFHaVdCUEk2NkZ4NzAvd2xQaWxRb2x5ZXp5aTVSMFErZnBXaHNzd0lBQytn?=
 =?utf-8?B?QzVzL3J2WFZ2eHNCVFZsek9RZVRaWDZYNVU5ODFOQTZrM1ZpbjdoZWdCQlk0?=
 =?utf-8?Q?3PM7G0gLAt/whmOxwWE9VkJSC+v6HfSi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:01:57.5730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8380f6ff-d29a-4da9-fbdb-08dc9f45c47d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182

Function is used to set default values, so name it accordingly.

Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
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
2.45.2


