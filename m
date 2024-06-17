Return-Path: <linux-rdma+bounces-3220-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E54FA90B480
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C42DB38CDD
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA55713F433;
	Mon, 17 Jun 2024 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K99Sf28c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D413F014;
	Mon, 17 Jun 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636917; cv=fail; b=HvEvX/BwEj9CtYqrGGKECoayF0Bm7F6tDn+spMLa3a/DNALh6NfAURe3doDpO1DczWqXAYq/VZl9Xapkt1IN2sPh6ZyJwrSvGEMJhYVlrXpFJ53kdMUQ7/cuiE98zakHjArMyO+3AXMVESc8pVyWXPVVsC8Rhkb/0YkP6os9lxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636917; c=relaxed/simple;
	bh=gUj4p7KRVaXiC1XSZK6/WBZD8QkTJgmXRDR1iE3/gDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y8nuosoUqwQg8EPP6tisJeqkIVcvuWVmlUOtuePbc9D7hHvXuUcfLahtbrV8AJsXjaZ+qCcSbytP/6w02fuHTLntKZksewgpiRJyGYGRI3o3OSAunczOQM4psmDGrREBoH7VFh5gtBhHpCcWeO1rtU3oLhAMNAmmE6sLZoGxATw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K99Sf28c; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dx1Wkum+JL3CWW0BagfoMymE0x3z88Ob0PeFyS5lLKZfwRNPDMNXAi1MUpY+ARbWmi44Y2GsKebfTVAeEa4ktgph4xYQA6p7CKFXNdRtdDxZCv46nh5kiJbDPknh01vVHhExnavC8MeAexagFYPvBT6baW5ii7cMD3AMBQZspd0dgIugrKafNI7VNFYlm0brV4NPE0Tk0wZ/jjqgvrHiNPVv3Pt1Il8Z43VScR2WQIEc4DYhgNKOPU02AzmByuaFPGlEFo9RONzsGxg7Gnxuua3P/y3iMwuv91PmdcpGZJqlc/3uyhz+2V7ylbgj91CHM4Iyw/MphrVvJ8s7d7LRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7h22NAKXJ6fgKMXsv/azK4HQQJSsrYAQ2O1aso+36s=;
 b=SmgaKykUt9LYEg2U+/fVi0FjIxJLSuZikXpbCEJUUP7IYjHR5HEFdQ1K137kbqdVtUTYRha/VRqxaEHmglXGIkwRa1xd/9z5qAv6XFmK4iKt00cvPandZ4bBozvNgfbC666+Z0SnzjwLRgZbcQF/tPzmfBWWHtIimj9Uiw2o7d4eMBY+cWDzm6FB+D6nENopuRvTKZbUbTjPxWe28M41/bByfO9cF2CE3RdwZgITa7ur/OlTQ27V8DAIqf6WJDm2hDzjfuVUdsVZl8opWo+PxC0mGxv+mvIpH0qy0EKpoa7htF0Po1z6G0LGoO/2iGG4JcSIumqFcQB0BTY3q3ShNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7h22NAKXJ6fgKMXsv/azK4HQQJSsrYAQ2O1aso+36s=;
 b=K99Sf28cjH9JiOq4IVTXpFQSSFvztUCS1Z1Pw+63dfZ7x6KBzb4UANzNnMFpZzNOEXYvTKaVBFtpt2hVEK/uoctAn38xqtoBvkbP2FZKqhFYVYjAz6lhbudx9jx47GXgU5pt8DRoDpXlXaiyrcZ+WfB086GZg6dYrEnLDXyG5EofH0lR1O+yLYC4d7AUPEkdzzFMztYJ5IOo7M+1Blspgs541hvgB7zNb32oXhN5P5sQ7cmsq+FDqU2QK0nihWi4SxrhxRMrTlhuP5E0Si5y0DkRjUsQljDThz7K9O1Fi/B8Xn/p1R4wcxAg2bzxDx++UUscWmovgXTePh1PZGP2jg==
Received: from BN9PR03CA0560.namprd03.prod.outlook.com (2603:10b6:408:138::25)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 17 Jun
 2024 15:08:32 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::1a) by BN9PR03CA0560.outlook.office365.com
 (2603:10b6:408:138::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:08:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:11 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:08 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:40 +0300
Subject: [PATCH vhost 06/23] vdpa/mlx5: Remove duplicate suspend code
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-6-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb2f379-086d-4b7d-af47-08dc8edf59e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVZ3RGJhWXgyZTkreCtFZlgrUWkwTVB3YXJiYy8yRC9QdjlMUXluUUZQaTY5?=
 =?utf-8?B?VU5jd0ZlMDFrcXFNc3QvRnNNdHJ2U0IzS3JNdHExdStIRXAyRjdETVRuckZm?=
 =?utf-8?B?WVU5NlFmYzgrbUw5RDB4cmdkQ2psRVhGMEYyK1U5czBYTDFyY0p5dHBxOUJa?=
 =?utf-8?B?cVJBSnVYdHZRcUFlRXBiTnd6SW5oVis5VjB2am9KekNiMGpRYlJrMzUyUCtp?=
 =?utf-8?B?ZEltbFJjdkNyUnF1eGt4T29jR2xDWVM3UkZYOEozU2x6Nno1ZU5qL1VXWHJR?=
 =?utf-8?B?c3M1MEVvQXI4eHh3bStpS1oyTEFqVUxsS2ZZbVRyNEZJNEE3ZkdueVlOblNX?=
 =?utf-8?B?SEVYR1JHMTlVOWsySDRoNjltNEF2ZmlpZGFUdzVrOHVDUGRXbW9yR1pZdlNy?=
 =?utf-8?B?SUxQUGVRV3cxNE56WTUwRmVVL0tIRmg0TGpwZkFoUFJ6SlVRdXBOaVN0L1BO?=
 =?utf-8?B?Qm9WTDMxWGZrVDBwdnhDRHh2SGdVUHhjWlhJZG9kaXlFbGF2RjZKR0xpU2t1?=
 =?utf-8?B?QnFKSDlBKzVoVHp2K3VoM2dJSDA4NDlQRlV1NW83MEJDL0FQQ2JYKzd0cy9N?=
 =?utf-8?B?QVdMNWtqdFN1bnJzR1NwRVE3ZDZaOEhMN0VqcGZoU3V5THpTNDdiKy9CbUhw?=
 =?utf-8?B?VnJZQVBlVjdPQ2p1NnJ3VUhFZWN1dXpnRW4vYzQ0M25vNm52ZC8vYmxPdFQr?=
 =?utf-8?B?REN3UFhLWHMvc1ZyaHRTZFFCbURUQ2UzQVloMlZQTzVRZVV5THdZK2kxeDZF?=
 =?utf-8?B?eWRkMENsOEVwZG5XZlprTHBtU1h3OHJ2dGYrbXhzejl3ditKZUlKa2xSQTUv?=
 =?utf-8?B?bTA3YnBnMEZNWGRNYkoyNGlaRFFKNEFKenhmUW5KUGZ1dFhsN2x0SVpyNTJO?=
 =?utf-8?B?U3U3RFdtTGttWjVMQnVuUEtaSXB1NG5ReXM0bWNsQVZVNWZUNnNHclQ4RER6?=
 =?utf-8?B?VVdldHVYRzZtSTZadUtmQXlhcE5RUks2Q2ZRdVBPZWFOdHhBWkRaMmcxL3Vv?=
 =?utf-8?B?dGQ4SkJhZUdVM0oraUlpSXV5a0xNcHFMQUFlR09TZHE4eFRGM2d3VnZ3S0Va?=
 =?utf-8?B?UmVYcmVmWko1cGpyQUdBWE9pWHBBUHh4ZUFiOHVUZ25XTnZ6TXVtdUZQdURo?=
 =?utf-8?B?RFIzcUE1aU9QaFhVMGhGOUJtYlpHNFdzK29ua0hvTWVncUZXeDlaaVJVS2ZK?=
 =?utf-8?B?NlJ4R0VwV3FqVDdZbnU3cHNXdnNQcnlobFdXRXpLa24vRDJWdk93SkxDdytS?=
 =?utf-8?B?WC9DZTByS0tRSnA5TkhrQitQMTk5V2FKQlJzNkNCTzhmSUlIdWhoTTYyVyta?=
 =?utf-8?B?T3BXa3Q3SnRoMkFpbG1sTGMwclBhTUtVT3grcEFRZklYdjROdXBabzVuOVpw?=
 =?utf-8?B?Q2xzNE0xZlVmNXBsVXF0dERIS1RZbm1GdzBtTVlSeGJLT25mOHd0MWFGaEZM?=
 =?utf-8?B?Y0JxaHhsNWQrMkhmSitSNU1KenNpczVCNmwwYklmK0ZDUjZoZEd5QWNJRXd5?=
 =?utf-8?B?K0U2eldkUU8yWlBJVkprNUM5bTF0aUtKVWFiOXBZYlFlaTlmUjdMRDNiam56?=
 =?utf-8?B?ZHNiRnduN3luSXpXc1RCcnpLS2gyeHBzdGlaelRDcElhRUpOOHJNYjVhRFBY?=
 =?utf-8?B?MVJCRUtONUp6dEhITFhmdFB0NHE1SElHdFJzMlUzMGVmZDFUeGViK1NTSnFG?=
 =?utf-8?B?ODBabmM4K0JlUWQzbVdya1BhUUk4K0UyaWJlN2pFUDU2MlVOWDk3cHJCZUti?=
 =?utf-8?B?OTRGVSthSytRbDc3WEU0M0ZWdnJxcE1pbnlKTkgyT0U1RjBJSTlVN0Z5TVJN?=
 =?utf-8?B?OFJZS0ZXV3RHUFRZYWV2N3BSelU2dkVmVHJ1MzdDa2diQUlNcE13cDduelZB?=
 =?utf-8?B?RTNnVGJRcm9KbXZHcXltMmxLVkE0N0VMc0xaNXpRVE1KRmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:08:31.4943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb2f379-086d-4b7d-af47-08dc8edf59e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431

Use the dedicated suspend_vqs() function instead.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 51630b1935f4..eca6f68c2eda 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3355,17 +3355,12 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
-	struct mlx5_vdpa_virtqueue *mvq;
-	int i;
 
 	mlx5_vdpa_info(mvdev, "suspending device\n");
 
 	down_write(&ndev->reslock);
 	unregister_link_notifier(ndev);
-	for (i = 0; i < ndev->cur_num_vqs; i++) {
-		mvq = &ndev->vqs[i];
-		suspend_vq(ndev, mvq);
-	}
+	suspend_vqs(ndev);
 	mlx5_vdpa_cvq_suspend(mvdev);
 	mvdev->suspended = true;
 	up_write(&ndev->reslock);

-- 
2.45.1


