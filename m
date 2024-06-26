Return-Path: <linux-rdma+bounces-3500-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F582917DD5
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2DC1F25E2D
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107017F500;
	Wed, 26 Jun 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IlLe7ycD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD0B17B428;
	Wed, 26 Jun 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397639; cv=fail; b=hodthmYY6alLd3+dBQh+/9VJtsw9/d7ab60IPJTeeGXcNODe/zdxnTEFAMLKYnwcWWAoYmKbblD/2yow4KWarqoJvw5KeGH34rNwHUtpNXeBqp/z6jT6K5f26DAD1/UDha70UapKZls8D9ghK4tz+nKHcKUQPG88lZA+9N7LiAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397639; c=relaxed/simple;
	bh=Lrb09Cm5N5VK0SZvWT5VoPC7EZthINFRB2Q+ObRG548=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M0PibmSVrehabcNazyCodOUOmhSV8MGpcYO+97C+Z8mdLsYeqnYJEitolM671YKC6lb+sHKwXNqjHrg2XnWbM/4HMZM5K6sAw77REFfjOH78LFBpJ1Q/Vk7lMQcEbkX/bI+bmd+V7xiXVFgOtjM4xJLPma4X+PDw0DzX/dZArEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IlLe7ycD; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vu7GygdJAgATz7+RI70hR+BgOZMLEr7ABQ03f8eB6FGgEk2+po9dZAo4EwilrJAF+ESNtTSORJZge82nNhAuFzmSKv4gbjkuWaqJ3y1/CJqRh8C4H1425NnbXByza8UQwevCR3NXdm8PUBLzyXD9U5TpR38bEZ4i/9uzuR8swq7MY7tZCP6AZiHtP286pfXiK9d708Z38DqQKydV5TINkhjQcJQwRCQg3V/TGODqzyXERAnqy7rVt4mOnbmpvV6gzyd1IJzGB8GiUdSqbAP9AG1r+KUpsPFRGR0KtaRrp11AGDGqYW62hDpkbARHCXw5Lbmso4xZV9cIfZt7A4gKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYhkLZGkyT9zbQnqBmUACl4aJSi5TJazcHtqeL9j3gA=;
 b=gTsAn/DcX3bjcGMRsAFxn1WQaOsaYF3y/UVJVUb9hOCYOMhstXYCNBZt7PjUCssm+gRPmYCykfJfoYj+D0Orn5P4AjWiMs51ynCwZqpTVdL/cXXeVChrKEn2oB9CCd2WY7EtEo07xIpPeJlUJcCFwNCQW4UH1QxpBdOaj7iiFM4cIAxw/Y/HHuShXnPN+0bm6DNoN3OV317xSm9uUIX4usZasrx20XJw+oPfjDntaXZoVE5gs2gT5UARBfnO6IOZV7Q5VeuVu1c9E2Vdn06Lw9vQyfRSc2xcfzXn+ibr0QaKSOkiRPqQsQvY2dttEwoxFiTYelbHTtutTSSsrxvanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYhkLZGkyT9zbQnqBmUACl4aJSi5TJazcHtqeL9j3gA=;
 b=IlLe7ycDzbYBzxCWIctMWUJVppDmwYPC4swVbDNkSvQprF5VIR4ibkOzeCqhe1pyzSZ8iKwcsTOix/Gi/Fx43/nIoSsd5lB8i4CDuO0B82Yi8AgeFai//dm9YfEQdv3SPHCGQsEa5I0jeZifoddLvM7elU7NtCV9Y6H+hfqWvrDhtw/DJLi63S66kFoiwd/NMY4j0/0F2n6nK+Hq3hbV8HboSx309KUcx0YA6FQFh13ynAhId6gs4ZkVD77WiYfhql16x3wIA5NaYWoVNdVrpgJI0/XjmzdYvXg+F1n+ZgpicmR69oRZ7/JU0TFeVEFgKRw87bANVhDce30Um3ejBw==
Received: from BL1PR13CA0438.namprd13.prod.outlook.com (2603:10b6:208:2c3::23)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.33; Wed, 26 Jun
 2024 10:27:15 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::e1) by BL1PR13CA0438.outlook.office365.com
 (2603:10b6:208:2c3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:26:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:26:59 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:26:55 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:39 +0300
Subject: [PATCH vhost v2 03/24] vdpa/mlx5: Drop redundant code
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-3-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: c8056d13-2eae-4990-1f26-08dc95ca8c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|7416012|376012|1800799022|36860700011|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1dHbkMwVWZlaUhka2ZMNnNQREtxQ09LSURPb3JwWlk3MjBLZ3FWQWttWnpl?=
 =?utf-8?B?T2tvQTRWTFFLTDgyeUE2c0hHVG9Tb3VSYldhM2hJbjdTKzQremsxTEpMSkNx?=
 =?utf-8?B?a1Jzcm9yc1BiRDAzRFJYa1JuS0xYTUFtQlc2VVlJb3ZvVmJGOC90UUNQUEd2?=
 =?utf-8?B?VkdTOWtVeTkzRkx6UUl5TjB0RXJyMFlOZ2tyNlV3dXBkdnRIY0krelNjeXBS?=
 =?utf-8?B?aGNJTjNMUmd0MkFtM3BJL01lbTVyaFdwY2NtZE9FeFFteWtTcDNGUDNYN1I4?=
 =?utf-8?B?Q0l1OHNIVFBmeEJlRDdyNTlrUGRaMWZGWURPWGlXMHVxdWptTTJ4YmhqL2hK?=
 =?utf-8?B?S1FLdFdwV05mNVpta0ZYeUlJNFRZb1lVTUYzOFIzZThMejNuYWVYSGdOTWR1?=
 =?utf-8?B?Wm5PTVRZdDdPeTZ2ZTl3eTQwL0tVNVNvVWwrV3BzLzlmaXBPQkU3Tm5DNnZZ?=
 =?utf-8?B?bUFpMW1uQjFReG9kc0NNSHdxdm90WkovMW9lMmtmRVNWRVRCWk1wMElBTGZW?=
 =?utf-8?B?YUtVNmZ4ZWZSZS92b21vNjBQbVREWWNoenB4MHVOdlJUUERNWnEvR0lKYWFz?=
 =?utf-8?B?Ui9wOGtLTElrNFRqRSt0bDEyK1NEVklQUGpKQ0lBek4xUnZaWUh1OUo0SHlM?=
 =?utf-8?B?aXZKN0s1eG82eXhtU1Y2b3lmSGhQbnpnS1JWeTFBZGVnQUEyWlNNV1hYNTkw?=
 =?utf-8?B?QTJvNWFMVlIrcEc4WTJpNlpsT0xmV0NLbTFEWnpwemUvOFZ0NHpBWTdhVE84?=
 =?utf-8?B?aExHOWdyN3g1ME5XcjNjTU9ub3RKRloxOS9iZWl2UU1rWUhuSzVGQVA0RWVq?=
 =?utf-8?B?bGJkYm9LQ015MFlma1ZnTDlRSlp0UlFuTEowM2EwN1FJWUc0ZExUS0xISWZC?=
 =?utf-8?B?VzhlRFhoUXIvV25xVU1qbjh1Q1gvZ3pLdytucDVlemUwa2lGZDZGVWNWUFlH?=
 =?utf-8?B?TWlTUWpkcjBBS2NiT095c2JndG9WUkJTMW1lK1pzZEN6YTdWZFdVRkM2N20x?=
 =?utf-8?B?Q0loaU1vRVpuTlV6ZVpRVlU4WGsrczdBZDdIT2l1T1p4OHVOZFRQTzZoeWhw?=
 =?utf-8?B?TUdXQzVFVmNxQTd2TTdiT3hZRTB6S1MzanZFUU9XWkxzbXFqZVp5bEdxYmFy?=
 =?utf-8?B?Qk9QeXhFWHQyZXF2eUtBNkYydjZIOFVMYk9NV1dDc0dLbVRKWUU1dm9kQ0xv?=
 =?utf-8?B?VzhDQzlGZjRYN3U3WlJUZ00vTTdRUmtLbkx2eHNSQStKOHJGZlhSbjQ3ZGxo?=
 =?utf-8?B?MXlPeDIwVms5MEdxaDQ2K2k1V3JoMHIxL25YclRRdkdUd3dOcDRtcHhNS2ZE?=
 =?utf-8?B?VUZjRENQdGhFaW9sY1JhYVEyQzhUb1JqRGRUNDJEcFE4UXVtZ2NZSktFQXJO?=
 =?utf-8?B?c0lhQ25NRXozVzdwK3IzdmVRa3pmaGtoVjM1cjFGYUsxZDJDUTlYVWd4K05o?=
 =?utf-8?B?SzRIQ1p5Q1h6VWRRdHNRSlNoc2tpSVVlRHc1enNBb1U0MXdvd2NSZi8wMEYz?=
 =?utf-8?B?YVFCL2tQUEE5aFJycUh0eWRzbHVoVHFkM3Nhdi9iK1EzNCt6ZWY2ZmFUMEZN?=
 =?utf-8?B?THlrVE5FU3hpNVFFbmdoWGt1TW8vRlI5Mk94WFFhbGVaTzlPWit2dGVsb05M?=
 =?utf-8?B?VDdHUWVqYlpzZ0c3Q2VjVDllR0p2RmxJQUdGQlRCREpoWi9ZeTBtUWRxWlo0?=
 =?utf-8?B?YXhLYTVXVVVUSHBSbGxFenZXLzgxTEZYNytZVFc3blVXTzR5YitOTmpJTE11?=
 =?utf-8?B?b2pyWWlsaGErNmYrOTlEWVVtcHdyWElvUmxIQjB0OGQxZkJ3NmtRZTNrZGk3?=
 =?utf-8?B?Y2RZdldxNVpMVEhnejlqUmo3OEpjMUpaYjB3WXBMZGlVWFdZck0rSUFLUHRw?=
 =?utf-8?B?dmVvRlQ0TTB4c2VXS0pEUC9GM1Y2VUJrclFmeENBVVhDdklwRmthUHdIaG1m?=
 =?utf-8?Q?DEI8msh5cRBQFpS8iSl1Wqjh+8ediEAd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(7416012)(376012)(1800799022)(36860700011)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:14.4609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8056d13-2eae-4990-1f26-08dc95ca8c1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382

Originally, the second loop initialized the CVQ. But (acde3929492b
("vdpa/mlx5: Use consistent RQT size") initialized all the queues in the
first loop, so the second iteration in init_mvqs() is never called
because the first one will iterate up to max_vqs.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 1ad281cbc541..b4d9ef4f66c8 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3519,12 +3519,6 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
 		mvq->fwqp.fw = true;
 		mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
 	}
-	for (; i < ndev->mvdev.max_vqs; i++) {
-		mvq = &ndev->vqs[i];
-		memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
-		mvq->index = i;
-		mvq->ndev = ndev;
-	}
 }
 
 struct mlx5_vdpa_mgmtdev {

-- 
2.45.1


