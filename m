Return-Path: <linux-rdma+bounces-3744-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4533B92A231
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99679B21DCF
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD56A14EC57;
	Mon,  8 Jul 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xpog2HKR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058614E2E3;
	Mon,  8 Jul 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440183; cv=fail; b=SxqoHgfIq1emg6L5TeysR5+G7/ta1KOka5vb/xTtSoMQ6pcOWVidu9nyHeBlOqqk/cUJ9NQd2k1aJWjety5DAG91HZ1FUjxcJottdZrD+htdsa/h6nLZycBeTXm7d7H+re6WSludg45Jw/Wc5/TNz+Ewu2A9AZ1ygM+YbK4fYwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440183; c=relaxed/simple;
	bh=alpx4DHW++4vPyW2+DZYTz5s+xhITTe/eBUA+Ib9QPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=t9QtNYOZLgnwefwff7tF9TsEd3xjb76a8m1p5P5KdFYg85WGYs7D1/a8bM2MiOU198GKhn+QokWCcbEsWSRWWL0bY28arwRh29uAK9bN6t3cs8B2djwCSR6fWqCqtV2Xm7nHD9vKn4IeemuAi9VcgNcgsu8omQGvLwSWAmtcsZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xpog2HKR; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeG13vFw/fHcO39/KZ71Tbkala6TffSxG+IAe6vvBEpWsLlAc5YYvPnim35EDhLhoR9KL8fXDvMmPHdQ0VSzpqd5nTQgSjF1Ge70DG/FpLINx0bbBmX67AS+qASzsyT2fHHAEiAh/r7zwL8QvNqoJGOYQ0kA0CQXzpYHGeipcga3QdBJsgs0trmHLGmWo/ARhCGQxyXxkJ1RYu0odYylk3T3IvlbCOqfJg9yLDT5NVLyx7FsszoEmk/vMvAJtIzXrSjCnUBN3GUjcojcm/dHzaMLAlVuIqbhav8R/C/XGq7YoSRKXBGmTlXmBBeM9r5SM3EHi1DkFxNy4TQeXhKZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KU05PAbc7XWmqajIj841Tg7fnNV9AYqRZIy+qRdkNds=;
 b=XAQ6dwu1wMWw8ZCy6c8IOxuln1NOwgEBjZ3zLFi37/Y8ZvGATS6IK9bAItbOLrCxYGs77hEftjT7cSHN8nbRoCN14i5Awc18PhHHnBjZB4VWbHoEOAkU7g/ojbCXf0IzyZYdZya7z9LX3KLYwgzm4gllIKdjxqQ524BT3LuYMQoCuTKBrCi480sTa1A/5KLOF0ZHHGPMvRgH8HBhGHOIQ4ax0tTWRE1V7p0YE6pSy+8tSYxwjo9Ja5bEjX8f12AWju58uycWeGr9gZnUw1gVtCESkCOFs55CcloSovT71vdtBPJxILo7p7DJ+qJO7KX6BKFCeNOerQ6MJv/n7i1rEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU05PAbc7XWmqajIj841Tg7fnNV9AYqRZIy+qRdkNds=;
 b=Xpog2HKR9zNllqL3zSNl+okSrBGxEt2XQYrt2F+c1xkOQ9SXkjfGbdmWg8Bjmyy1UB+w43NJoge5JH686q/B25Ffcwzv9gJal7+7lWd+NnFX8THBXPEwboEpY4INCeV18+8fs4Zu4nFYPndavcfuK9A3RmTtKbKlZe08Q72W6vmb4VOpSXcGaEJKRsIaicrM/I1ZuusId8rpuDtRHFpCBtA9pwXP1eBsKDFTsnphE9CVkKFU+XSmiiaOJdWanm+qeDEsDOa2C8DHVPf/f19ON/rSAZE88n0o+7GV2kY2RiSRqgI/GrG9PtiVuumWtPBJ/PSZy/2uMDaIVveKCQWGdQ==
Received: from BL6PEPF0001640C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:13) by CYYPR12MB8871.namprd12.prod.outlook.com
 (2603:10b6:930:c2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 12:02:57 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2a01:111:f403:c901::1) by BL6PEPF0001640C.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:20 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:19 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:02:16 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:44 +0300
Subject: [PATCH vhost v3 20/24] vdpa/mlx5: Use suspend/resume during VQP
 change
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-20-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c55a67-27d8-45e9-ab67-08dc9f45e829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjhNeUExS3djZVZQYS81cGNrMmd4U3Q2MHBJSlFrbTdRQUZqUVU3eC9JVE5w?=
 =?utf-8?B?NGg5WURmNmdhaGRDS2F0cWhNYTdTRlNQcGhVcGNWcDF0dVB3NzNtRm5ZK29G?=
 =?utf-8?B?NGpJeWd2ZHNHYXJ0alZPTlpQZDRzUnVyVWlRajY2Ulh4SVhOeXdrUm1yTC9N?=
 =?utf-8?B?bnhsRGhmbzV0aE55TjhlV25mSGJyK1h4dUg3ekFReUpBeGNQSHY1RTBVeWJl?=
 =?utf-8?B?Q0hTRjlVKzVKTS9taFVjVUN3WnJ4M1kxMWJrb1hBUmc0d3loUFRkZUFtOEpV?=
 =?utf-8?B?NjBkaVJ2NjdyZzRwdXE2S1B5WTYrWko4d1J0QlhqR2RucTBtRHFzNS9pbUtJ?=
 =?utf-8?B?WVZIZVdOd3BaSUVMZEFOU2dLSXpLOXVLUFAxWlRIRy83bGhkN2NlRDBHNlBG?=
 =?utf-8?B?YmxOVVUvNW5Kenh2cXdVMU5UTzBQalZvWWQ5U0szUUZCQ1l2cE1zeW5VK0FT?=
 =?utf-8?B?VGxiWXNHeHd6elYvenpCYUNZa1EzQWpZTXk1ZkVDclQzalh6MFBtOXdNeHFW?=
 =?utf-8?B?WDNvRnk5TnpSVTlBSlR2ajBxSm16VDdBSFJtMW5ISGhxZWtjVUhSQWozWDlP?=
 =?utf-8?B?eGx3RVNkdk5CQ1docnI5MzRSdVNGZ1d4LzlrdjBvd0ZTSXhNdCtNdjRNc3hk?=
 =?utf-8?B?U2ZSZW12QnR3aStMZzduT2pOZjVYOWEzWEw3R2RVc29GTDhrSGVRclJkNzhM?=
 =?utf-8?B?bGhlL0NMWGVtTzh3dERub3BybFZFWWRNKzYxZzR4MWVTUXpWSDcyQVNpUld3?=
 =?utf-8?B?elMyNGt3bmsrQ3dGVTFodjFVazlaYUxzRXl4elpwWXNnTnRGNkZUWlBUVFo3?=
 =?utf-8?B?TmxnRFo2R2Fyb09TeklCMEVTV1pYNithZ09veDdWNjVaaTFsa1hSQ1hUTE1y?=
 =?utf-8?B?eHNZOUFPSDB2cXc1eEJrWkN6MHh1cFpxdWFaZ2czUEJ5MXdaZTVXZGNHcmZL?=
 =?utf-8?B?dDgzNHA2Skh0aGI0Vk1JVDVNRHB3TkhKdE5BZWVDb0xHUExqWWFWZ2VsLy9o?=
 =?utf-8?B?enVpR2RPYzhJRGZGc1FJcm54cFpGZmtxQ2lmK2lxa29UTzBQM29NV1hBSFZy?=
 =?utf-8?B?TzY3Q0Z1MjlGZVI2ci96dEhBL0NQbGYwVitmUUYyNkpIb05uSU92bkFuYmFM?=
 =?utf-8?B?Uk54RmdreXZRQVNDaHdHbWFVUVMvSTNMeC9RakdWK3RqSExPdkRUM0J4WFRj?=
 =?utf-8?B?RXM5U1hZcWo0dXdZdW5BaTZ4M1NwNVFnOXBYQWpSWDlhTTB2ck02NWY0TlBC?=
 =?utf-8?B?Z24xOTNrZWQyQ21RQXdrNUJkN3NtTE1sYVRLZ2V1enc1cHBqc3JvWm9xdVFy?=
 =?utf-8?B?WHIzK3RqL3FLb2xWaTZaRXM5RW12cVMwak9RS3pvcHdlcy85Wm4zTEcrcWdh?=
 =?utf-8?B?MDIvNEoreHZJQ1ArdWVRelJMcWR5NS9jMUsxbTd6cFNEY2FFRDh2UE5LcXF1?=
 =?utf-8?B?M1hiOFBoRmNubHphZDdGbWt6TUdOUHpmemJYRnlDVjJLdjBXSHlVcXA1QXdq?=
 =?utf-8?B?YUtxTnJHR25wQ3g2NFlta084TGVra3RjRmFjaDdRN2o4aldTMk9iWkZnVGM1?=
 =?utf-8?B?T0dsNUwzMlpSZ21jeGxRZXVhSEpoZVIzM1pzUUdGdXVQQ2dIY3ZHeC94RWRv?=
 =?utf-8?B?Qk41aW1KbVVXS282eWpaR0lrZEliS3VBSVQyNktneTQ3UVo3RHZjNHlwSGJm?=
 =?utf-8?B?dnd4d0V3aC9SV1NoY3YyWUdRRzRpRVRmNXdhUG9jMS9UbnlMdVk2MUwwUDR4?=
 =?utf-8?B?SzMrdHhlYjFxY2xoMVpNVExpd1NBSGVWNmlsaUViQ3lFTTlCMlV6SHV2dThC?=
 =?utf-8?B?RXV4a3YwSkJCT2FNdVJkU0FveVNpbHlhbWU4S1BYYmthUzNRbmdQWGM3RVcz?=
 =?utf-8?B?OEVjYmk1Q3BTM0hVeCt1S3FCaUllV1RiMWxudmdHblBia3U0SWFEL2M0bTRw?=
 =?utf-8?Q?ZHIKDcuw5TJzCI3CTaTafQTisp7fBFi8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:57.4497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c55a67-27d8-45e9-ab67-08dc9f45e829
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871

Resume a VQ if it is already created when the number of VQ pairs
increases. This is done in preparation for VQ pre-creation which is
coming in a later patch. It is necessary because calling setup_vq() on
an already created VQ will return early and will not enable the queue.

For symmetry, suspend a VQ instead of tearing it down when the number of
VQ pairs decreases. But only if the resume operation is supported.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ce1f6a1f36cd..324604b16b91 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2130,14 +2130,22 @@ static int change_num_qps(struct mlx5_vdpa_dev *mvdev, int newqps)
 		if (err)
 			return err;
 
-		for (i = ndev->cur_num_vqs - 1; i >= 2 * newqps; i--)
-			teardown_vq(ndev, &ndev->vqs[i]);
+		for (i = ndev->cur_num_vqs - 1; i >= 2 * newqps; i--) {
+			struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[i];
+
+			if (is_resumable(ndev))
+				suspend_vq(ndev, mvq);
+			else
+				teardown_vq(ndev, mvq);
+		}
 
 		ndev->cur_num_vqs = 2 * newqps;
 	} else {
 		ndev->cur_num_vqs = 2 * newqps;
 		for (i = cur_qps * 2; i < 2 * newqps; i++) {
-			err = setup_vq(ndev, &ndev->vqs[i], true);
+			struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[i];
+
+			err = mvq->initialized ? resume_vq(ndev, mvq) : setup_vq(ndev, mvq, true);
 			if (err)
 				goto clean_added;
 		}

-- 
2.45.2


