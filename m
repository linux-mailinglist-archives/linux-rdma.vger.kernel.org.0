Return-Path: <linux-rdma+bounces-7708-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D1DA33B94
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 10:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8272D1884266
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A712135BC;
	Thu, 13 Feb 2025 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oyq470Yk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694EB21323A;
	Thu, 13 Feb 2025 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440068; cv=fail; b=nSL7+lo9ZKwIidp57zZkh+vlsrUYV73UzzpptgS9eUsTxcrZmbF/2CYRj3v8fnbTszi19qhKCYR/8zy2zQKCSBrYpf2T3BVJb5Cq98mUh8D7xtEXdJBEyKzlunKApPSj12H6lIJkX7+JhJcKpRSZN6CYcryZHb5ebdwg9H6mhzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440068; c=relaxed/simple;
	bh=Q3Byw30k+5f/sxrP2oBklwQJhfxuUOyr36lzjpqfxrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNUCgZAMNLN0eI5PKIPxWInNac2hSLVw2xWJpsqEgBjuGyqWZqAKBNCqwBxuaDXY6i9XOvia1EbaiiiLMQTqg10kxAjNWbjmPWK81fsNdiibEAOKDaUf6cS8EwNR+zFJpLJKF9IoDeqwPWK9arhzgwhBTbjK1zXM9895WTnFnrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oyq470Yk; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kl/kbJ8/xEU39pECsyqzKILnNfki3G9N4jq9G1zDX4iHX8r8RvHkFVuFGeiFPD87UNojMUzk0KaPSE3ufaCl6MfGGebOe41AEVNClUlwnJOSdx8waeYx9WaxmEiPkfsZHzHN7GP0kQcstBzYsKFVPRlfH4iMxmxmQ+FTWIMASArMVcLIwQ+udc16ckvh34+zz1pa7rifUjF6F/KHadTguA8C4zZLqCBEPutZqHU6Gcl5sTy6oC/P1UjjOQULP3m6IP4I0C1m9wHYJJdeT7mFbuARm7lCrT6U13ZCkbGp5VocX4IXCy9fm6vkixwdRIIhbnnVpBuI0pMm9i4PqcbNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsgmVhvHX9DNHOCK1ONnVRXKpP0MsVtPXT6F0rt4JUs=;
 b=YNEuHcL/TeGFdVW+cG1Yb3ZtlGeTLG2cTgtA4ym4PL3ANMTYDdZ0YsFVeQz8WiiUviDnDmk/9yw1UAKvnaEpcTqYKhAX/agBt56YFcGrEyVyJojiKnvmVTik8NPNXsgkTRWwfnlVfNQzCnp0DW0DdEW9hjrOhgeVW3Q9TJSaOLg4kTe5HcFGNpvMRwd6xc7gTE9hMhkIkXO84l+7lmdgHLNvoTQ78BK7JuZUuSOn7oavop8YjQffEzpL2gpGYxkKxa/wZT7YZEKxly6Qa5WgOly2DegOGz24daaDSgpYspM3clpthqJzurRxynnT8yqDMscw5/KNhc9ztzWqDY+wvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsgmVhvHX9DNHOCK1ONnVRXKpP0MsVtPXT6F0rt4JUs=;
 b=Oyq470YkOCAC1v4uaKfSWPapkOy3KCPZObmSaV7aW/KSgpNXUAIQIq2BQVXNcoqMmH9Zwp3RJQrMLyTrxeHVhXSHxooPIu3sHMUBwolfKBPrc+zP9Xmdua+bebeCCyNqvBnpjcAZVZijSzyGRuE9VILm9rScmEIl3dMuo9rfUev8LztqnwGcstHfqfggO6iTTVLI6UlaL0+pQW2qkwjVpIeAR9fegKgvYyorsrUQwCgfcfjVY3w8EGROSRkbegJzG0/+9Q6FSkBnoV9P51TEKguuVwlOFRxG5q1xZIuamZ4jZmLicNBJliWTZzWgPBulb90UgIZOGr3+NzYAahB6/Q==
Received: from MN2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:208:1a0::26)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 09:47:41 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::e6) by MN2PR07CA0016.outlook.office365.com
 (2603:10b6:208:1a0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 09:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 09:47:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 01:47:30 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 01:47:29 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 01:47:26 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Shahar Shitrit <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/4] net/mlx5: Prefix temperature event bitmap with '0x' for clarity
Date: Thu, 13 Feb 2025 11:46:39 +0200
Message-ID: <20250213094641.226501-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250213094641.226501-1-tariqt@nvidia.com>
References: <20250213094641.226501-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ccf449-944c-470e-8d7f-08dd4c137538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A1vr7BK1kDG3e89FWpygu0ES+qJGAhLsNMYa16hhYuw92rbZkfBT6eiRVcdu?=
 =?us-ascii?Q?Z+KD0OGXGeOas0w3KHK7CWFFF8jzj/+uYOMAHoHN450bgJoNPecMj6LZa6iy?=
 =?us-ascii?Q?IIxZyJE8rl/F3nhO47YMI4Nve0tJdM7eYnYc2xtGPr2xBXrTrY3I5o/qBLNf?=
 =?us-ascii?Q?6vJRZBkMGBeC48C+Qav0w83VO4Ce3uAPtgQKqW4au84X3WtIqUyKvTQ/B2cS?=
 =?us-ascii?Q?r93GQWw8xF2Wk1zXOaYg/kb+Gi0BUZjAbrCT+Dmva8M5xr32xJwmr6OunW5+?=
 =?us-ascii?Q?hvQ+WDYN3zSJQfGBAuYYKa+wr+Y8liy43yjm/NFgZQNXDgyqzkAQr5t0zI9y?=
 =?us-ascii?Q?qxfyPdJQM9RhZ+iPfSygrtlT9zaGjonwTldnJs+LJVK6kfCS7xybcy8Qis0s?=
 =?us-ascii?Q?CFQCv9fNPhPfM3bAfj6JZv/2ZvqHqqWJxJugPvbIQ19iTkejvLRgzm35y36h?=
 =?us-ascii?Q?U2Z5Tcuzi8FG3iet8VpWBiRaRqmzRU0U8SLBvncZNhnbinDBgHdBA9K59IUU?=
 =?us-ascii?Q?Ki8/VLZYTNHFBgBhLQ4Ds8LurtJcUhFlHlqdonfOE1IvHp3y450uU9aNmfiw?=
 =?us-ascii?Q?Tse41sD8JEc8MKZ6dST6f9FxUiV8QQ3dOYIzG/jR+BgRJHJfSGknHCSLd1X3?=
 =?us-ascii?Q?/plUVEiAuf8Eg/AIpNTMn5v3xSG9jYeEAQ+2M9PzsO+Dlcr11Gau4Rfjq10U?=
 =?us-ascii?Q?qcJNAMYgKTaJep9EutQ0rOljQHcj3wkeM5cckh11WN+Zjpa41LZBI4akHg9F?=
 =?us-ascii?Q?5MEOTw2eP9UBzJ1zcBzXc7DoDN7/6bmKa/aiJeol18GnKefehqFRvukc9+wf?=
 =?us-ascii?Q?mEjvbcO7ONwzNrI1zC/kninOzdSjVy2iRGFXv6O7knVNaUdS4KJegpFazzaR?=
 =?us-ascii?Q?fXG9N9NplRNAGvvvP/VD6TvuW5oUdNqTbsDbWVtGy7XoI0+hb41CuyCeZv+J?=
 =?us-ascii?Q?i1vsbL1hQxGeyQ8TQIHwH0RWZ12++XUsf3cGj5BwJUOKMhEW96Nwy2pI0VtZ?=
 =?us-ascii?Q?2qU2PmzyehvouzEtssFVMSSIJL070rHQnOVqtR3+I32SrKYeWH2yNlgvCm8p?=
 =?us-ascii?Q?CLRztcHnFnLVwVkOJv1MRlZCXerB6pttUNrFVtAWQo4reVlrOUoW4WEml+bu?=
 =?us-ascii?Q?QOXF7DIg5icxxQh7UuGaAzHftlQE1Et/LNod+vCZnhEpGwZzTeTHfzjXFBU+?=
 =?us-ascii?Q?aElFLmceEka8dceqo+eyqZo6tBSj7MD5htlVQzpI+BB4wn+Fw8d1t5QMfF0h?=
 =?us-ascii?Q?uwfioZu+v/7XDBhl67+79wY/4oxbqclHlRc/bqP7ff9uIOviEMdVg+0sesEL?=
 =?us-ascii?Q?t0Afhkq+nJQeurcl31xPclHnNRoN/5JSaDKLkVDaTDW0UYt3EnzTKHBy2DQc?=
 =?us-ascii?Q?AkYig6PJyttghhN9XO31bKPZ9SDPV60CUmSGlSHFezvJfGqsfWXrR5YpDMOv?=
 =?us-ascii?Q?2ftKHCQIux36OD0PpcyzCLn1BavxMCtDIaXXYx6VL3TRel2YI1IEFBC08tyT?=
 =?us-ascii?Q?akDxO3phLCrj/c0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 09:47:40.9177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ccf449-944c-470e-8d7f-08dd4c137538
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674

From: Shahar Shitrit <shshitrit@nvidia.com>

Prepend '0x' to the sensor bitmap in the warning message to clearly
indicate that the bitmap is in hexadecimal format.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index e8beb6289d01..a661aa522a9a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -167,7 +167,7 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
 
 	if (net_ratelimit())
 		mlx5_core_warn(events->dev,
-			       "High temperature on sensors with bit set %llx %llx",
+			       "High temperature on sensors with bit set %#llx %#llx",
 			       value_msb, value_lsb);
 
 	return NOTIFY_OK;
-- 
2.45.0


