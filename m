Return-Path: <linux-rdma+bounces-3232-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C3A90B4AF
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175A51C219E6
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D61016DC1A;
	Mon, 17 Jun 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F1x9Wobo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F8116CD32;
	Mon, 17 Jun 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636961; cv=fail; b=fLWFhoj4NOTL96nbb/INcIt9og0ZYy6MQYZrYENm5w9Bu3tdwt72xtmmFnSba0jDlxy5/9b8B8XpPpAdOYY1s0VfQ9QQ+iVyEo2Xgk8SFhhddhJF442iK/DQTG2t3loZSquKWQXLPYogbg0mk4CYVeZxIEoSpIe+fc/kG6m0dbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636961; c=relaxed/simple;
	bh=cO9B2CFnexmejsPEZHTRU8ShI2mV3nLiEICpLKNndk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JTn6CZwkVq/S1u2ZN/4rIs7s1tGuezKLYTXFgItbWOu7zTJi0nulQyS+DYdjs+Dnt5LV9A05A9Yhs01UE4U4wW7Dsr0AmYngokv6sxguk15cNsW4u7WH/rVgtaTBJMjV3xVUObD6Iql8dA4Ewwx8FcWNw1l+VSQUBXegmLeSExc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F1x9Wobo; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JG9E3xkX1aF6g3oYzkh7L6BZeElT/6GEDMAWK8pMuXpwcFkznS0M7KKOgYv/jaGo37kbOWnico9VDZf1c/57try0LlxILSKkRQgl6JQJBC/OwShvjwLsKRyBR0XoQxZ0LyuqYo3e7a0CKb5VTXzYDyb0gmdEdUNQXO0AR2BTs5TL9BSm25M69z29NckizvdwJTMttTtceMqX36tx4pZia4iaigktgWaYd2zC8HABkXiS0P/VUOBGpPiHt6o3Zgaavy3WdL6vAPa9FGBNTE3l81au+Xqif5njU7vI3i/QDrXlxXFINjxtTGZm0LjZiO1GP4/Yp2xbOAAzaObXqzNRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNyGSAOjuLKEuGmFqtGAZKOWKdkcBTc2njKCUShGqjc=;
 b=Ef3tLxLZVqzRHY7UZOx5d4pRubxtXjzspTUnTY6pQ02e8uZWHi1okDpDx6UH2EB14N7m+SG3tcl3EyIxC44h/YClXqt6x1zN+EQsg2egEx8g3NohquYp3cs7+dPap5MrG/+49b+l+ueSgzJG/i/hoAUgofR8VZH9g/Tw43cakpyLKS1QZHES0Chi+Y7mDVTIsGSd0b5WVw3pABqwTODHWlrgGGCdw6CiDBoJCaMe8OGsJdDnWHZ+N6SGup4Z1fwzcXshEXkhLvqg6/UyuqeU/C9xHmkvMRDCw3ca1AqO/Dd+chHB2UTrz9qkNI7DOi+MESg1AdX5YNJsoXQSWy9aiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNyGSAOjuLKEuGmFqtGAZKOWKdkcBTc2njKCUShGqjc=;
 b=F1x9WoboTXNCIJ1epBzrXAzt4WInRZU15+6BgqYpoJvZZQqxaZq0nLpaL79XBr4AWzivHyjbt/yxh6qTYfpHBqlKabUM3nalVsAYqQZOieoKNTKnIq5kobckPGTHbHpNEfTcFfcvlA/sF6fKBE7gVCM6nUOC7NIwFdzOFXc0mcvGJDnn9E/k5YOOPwQspunhw3f6PzKWRr+hlMAj6/PNJJeV99pzmoOKmGihDfRalhQqYMmKuCmYF1faUCGFE/MH7GOgt8TJB5K1m9EU9hmopzcEFMCJtbsw1Y/ZIkMK/HNgkJiFXYuMINohZu3DwX254IDFr4X3uBpQAdzOwtSe3Q==
Received: from SA9PR10CA0015.namprd10.prod.outlook.com (2603:10b6:806:a7::20)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:09:15 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::57) by SA9PR10CA0015.outlook.office365.com
 (2603:10b6:806:a7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:09:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:09:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:09:02 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:59 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:53 +0300
Subject: [PATCH vhost 19/23] vdpa/mlx5: Use suspend/resume during VQP
 change
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-19-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: ff145d02-25c3-4663-b00b-08dc8edf73bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG12eUsyVDBBYmU3QWJrbUZkWjRyYnYyazBtVDVZeFB1NFBhQURVYlF0N0tC?=
 =?utf-8?B?QUNlbDZVOWlUbVdnSUE5dU9OekMwaXRUMzQvT2U4KzBESG5IMHhXL09PWVJq?=
 =?utf-8?B?bXdXSlNSRWdtWkxzVDd6VDB3eXdjdDlqZTZodDF0MHlKZmZLOGRVMUZoYWll?=
 =?utf-8?B?M1Mvb0U3MkM3dk9BSVF6UTYvelFUckRtdTZMeVhjRndwMmJjWmIyS2lEV0Vo?=
 =?utf-8?B?blpIM1M2R29Wb0QrS2FOOUtNeTJNMTc0T1pZYkZRU2hSZHZBZFBySDVRWmY1?=
 =?utf-8?B?S2Y3dUg1bm40dENlYUF4aGZ4aGgzVlpwOWQ2MmpZQ1Y1Tm1LYjBPMkRlUUti?=
 =?utf-8?B?QVU4eGRUSW9Rb3FsTkVLYWdOejF2UTViaHNqdjU3UFZQOW1nNytIeE83bmtJ?=
 =?utf-8?B?eFlpckZDVW51VFR1WEF4ZEFpcVlxcDV1SHhBMUdoaHB3bFpaYUFSbFZNTTNj?=
 =?utf-8?B?Q3dsdjQwOWpPOE9mbFJoWXYrY3NReEpBNlZ0QUE2VmJVUWNzQ1FqbmpYTk8y?=
 =?utf-8?B?eC9RaTNyRU5KV0Z3SkdGTEFKVmNITDZTYVZLYnYyZFc2bVM3S0NsV21uaTk1?=
 =?utf-8?B?YUlCbWZBcE9CSjJTdFNWbm1JNGEveDVMdWFzajRHbzFoRWo1SFhKR2xDS1Jn?=
 =?utf-8?B?WWJQZkIvQ08xWmFnSDhScFFXM2NjRXJkVDUwS3hOZFpwKzc5K1M5RGRmT1Fp?=
 =?utf-8?B?K0dCKytZMG1saDhJTFQxMHJkOEQxRzBiUlZyNDNQYTBOMGFKY0FJMDgrVExB?=
 =?utf-8?B?Q2QzalltZzczbTFyOW41bEtmMzFVMHV5L1pNY0VOdkk0RUc1eXp1cVhxRURJ?=
 =?utf-8?B?TDlUMURYcGFrWjU1M1JJbWR0K2RYOG5SeWRGeEZaOG1WTHpXUVJabTdiaVZP?=
 =?utf-8?B?ZEU0SWdGNGFSNkZxYVozOGk3U3B1cUdwZmprT3Q0dTRKeVVScU8waTBSQytC?=
 =?utf-8?B?WXpDVVRFL3E1b2lZbmNSNVhlZUlqUWoyM3dWRFM4TUwxcDhBN3d0TklQUHJC?=
 =?utf-8?B?WFJTY0pvcXRTczFhenJ4eTU2YTg0UHdyQkNFQ0ZpdzUrMWkzclo1MWxyNzlk?=
 =?utf-8?B?TXNLVUNSNHlUMFBmVXpaOVRXTFpwNVd3c3VXTTVlK3lGU1FXR2VZY0FSRm5G?=
 =?utf-8?B?bDlLb2dOb2o5T2lMN2JuRklkTExzeU0rVUZuZUNyLzY4YndqRTljbUhWOFRD?=
 =?utf-8?B?UGxmOWxzL214ZExaMTR3Z3p6LzRkWUpQM1RWaytWSWtyUzFjWFl4c05QS3ht?=
 =?utf-8?B?TW5EK3pVY1ZrZ2FzV2pJdEhsNHFDTGFvNlFYRitoT0pybTBQa1hRSW1rWWRv?=
 =?utf-8?B?dHA5TmNWbi8rSXZ4NW9ZNjVFYjAydW1uSHhRUWdJRXh3OEpBck8waHVveGw5?=
 =?utf-8?B?eG1BSDJESm5sZWVzZWFwc3ZtRWtJZlZPZDFvMVdKVVh6TjdKdDhSZlJWV3ZT?=
 =?utf-8?B?VlB2OUV2YjQ5OWpaek9zbzhLS2tQdDhnSmNDbXhkRVdQSmJ0dFNZUFdhMEpj?=
 =?utf-8?B?VGRJVk9mMHZ6ZEd6bW00b09ZVFNRSkd5K0tnbGdvNFVVVVZRMURjVWhaQk5Q?=
 =?utf-8?B?b0dSeHYvTjhLOVRwMmZqSENsei9WenRxT2lrL1o0VTZIRTgyblRnM05DdytD?=
 =?utf-8?B?MTlLK2dZQXRmVHNDbVpqTHAxTFpoVTdxTGxudDA3WkpjYXdGcC9WWnJSSzFB?=
 =?utf-8?B?azNmeEowVTYwR3NXTGNjd1k3Y3JlaVlpVEQ3a3hTdnU2dm9ETCtNQi9ka2pn?=
 =?utf-8?B?SHBnZG15UWlSUEovQ2JRTVBza2VNMEpaVENlNi9PNWNVT0NNUmRnOE92RVN6?=
 =?utf-8?B?UlB2NlB4d0RTTHN6aU85cDJHTWhaRk9WSHB4VUdEZ2ZuTW5SNmUxR21oYktP?=
 =?utf-8?B?dVpBek5UMS9IaWtGc09Ub1JQLzMxR09qY01LempVbGxoOHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:09:14.8958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff145d02-25c3-4663-b00b-08dc8edf73bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771

Resume a VQ if it is already created when the number of VQ pairs
increases. This is done in preparation for VQ pre-creation which is
coming in a later patch. It is necessary because calling setup_vq() on
an already created VQ will return early and will not enable the queue.

For symmetry, suspend a VQ instead of tearing it down when the number of
VQ pairs decreases. But only if the resume operation is supported.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 0e1c1b7ff297..249b5afbe34a 100644
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
2.45.1


