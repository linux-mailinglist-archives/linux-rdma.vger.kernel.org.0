Return-Path: <linux-rdma+bounces-3219-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0998390B478
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC9D1F29C13
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFA213E3E3;
	Mon, 17 Jun 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qxnWJFcW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EE013E059;
	Mon, 17 Jun 2024 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636912; cv=fail; b=KLmsCqVtGYH1ik+sj6hW68UW7C2GwxB+f7uQ2+zxUV5Kc/tu9hYl7V27frfNkei8FPwB3lY8Skk5y3Nr3bCjmr+Aliw+WQR/YJc3PTOp8hrx/Ok3875y7xuFaDk6FmiECVwmCTcjhU8xFi3F4BstSsBBuGxInHp5t57d9wQyvGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636912; c=relaxed/simple;
	bh=KM6HnHRhkX/NCrwt8fuvNVo2dCqADkOMKR8Yyn6AIXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=T7cMlqyj3+BB9MCNf0fEMz9p9tfKA5OkUKyHRpfqeg6VgbUUDrVxwbQKhZuY8IT7+XJ8YhMJt+QjARP2g/y1uLRa1QFRAmgZVYG4L9gpo+6zo+KwLo1EbJGd+0RPruFdsESczFRzScwz/OZBW6S3U+dNhScrsiIbU9Jj9W4W8PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qxnWJFcW; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAxW9lL0juDl1G+rRUxEbmkGf9cCFvHrwYts0mFI8SUheuzIBwusk55yO27jTxmD5SFHhkk40CWPOcE5kJl+LYNBkT0kJe/18liJTMVaSHvfFT1u6MyCdvFrLUrFqo4QZbDTzJNomTxM9BvhSYzec3mf43YUZiZ6iYGD/dbOGP5ebZI6dkP7mRId6MJngyEYsOcxtb+JfM0IvHqWs+idBBcxV8GkV4QptMFDPhe+KxabHFnbZn+bV9mDx16VJ+NE265dQcXoVOZfHNuFahZZd5mHw9kOIhasjpR0r89wyHIEsbXqneLfK2HuK9C3LkRq+x+k99SwA4lrh3RLFfKQfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nk5vlO91cHkyNn6trFQSpeGQpFn7KRpGBE8TK7QnI0k=;
 b=GPee2/EzNWhp1GQ6aYjA8Gj9gcL2qLb330iJMY0YZErjgnqkoSWjUoUQKj+pKVxc1LMEDuH6wHFTYxCm1mn0MeF50MLRCXLw3dRfXzq4plzwCxWKktGn3PfCRts4jwtkkg/6x9uooCr08BT06KCD0yfJ+96G77ek9Oa06T4ZIKdgZ184jTmBx5Dw6dyHA7d92Kpev7j8IG78TOLzEfxPYKMT+b8nlfYb7lu1II7J0YHnTTPPdEMay7IF3+7RbDdDxcYn8zEbX2LghqPjxnpK32GTM9bsEBp8+DtekowBWN2BxCVVy0VbOTLQABUiKtAQqrACuAKLkx6KoclhCZGf1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk5vlO91cHkyNn6trFQSpeGQpFn7KRpGBE8TK7QnI0k=;
 b=qxnWJFcW/vo8ToGTsHmk92W3o8Wc25O6nWxEGOlJMBTft/lccrLZPiwV1aFBpTg+6tlNclyDSpM0Kwa0JQgrLUdbWRNjH+L4VzO7gQEQOXt0t0g9jS1eF3bMxFU8THWrzv04qEAKmc/Xa6AZI0v280KL5EHNkfcEHia3/z6ydnSKTl+2PJTIMNYYf6ljWYt6P1X1C5RPLeBWvrqY3zSzZWVvasI+rx6iHxkcQH76zOZbmBX3kmfsJfEZ5CPIGOM5qBQp+aQhHxcCch7UA12idBUhyTV8GULXlolS5kHfbk6+SXNYwbn/uyO75EdGycaEsMjypbvffhdkaOcGrMporA==
Received: from BN9PR03CA0549.namprd03.prod.outlook.com (2603:10b6:408:138::14)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 15:08:26 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::9) by BN9PR03CA0549.outlook.office365.com
 (2603:10b6:408:138::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:08:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:07 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:04 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:39 +0300
Subject: [PATCH vhost 05/23] vdpa/mlx5: Iterate over active VQs during
 suspend/resume
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-5-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b4d955-72b4-465d-951e-08dc8edf56e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|376011|7416011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWZLSFcxWi9PbDhHcHcwdW9XMDNVazlRYmlWTTZ6M25aQ1lhZFhvVExGYW5R?=
 =?utf-8?B?QmI4eGRmUCs2RCswbnczSUwvSTY0NHlvTDdOTWhGNjVFNDl1Rlk2NG81bkp4?=
 =?utf-8?B?SU9OZXh3UENBTVVHYlRkMUpFUllXUWM1a1ZTQnRndjlsY1Rsd3BleXFrQ1J1?=
 =?utf-8?B?NndRYzNscG5sOUhic2pFRTh0a1Q4SUhmaUxKYzl5RlJjaVNDK0JqNGZuM25M?=
 =?utf-8?B?cFVnM2x4bFNHUTBYc2gwUkg2MnJpR2c1eVV0UTM5SVp4UDVtNkkwc0wrODlE?=
 =?utf-8?B?ek9BK3NEa0FSWm9oZ1JtZVJVRVhjTWYyalp1b1FvM3Y2dmpJM1BMWVVFaisr?=
 =?utf-8?B?L01idDNqQk0rcUlBWFBadEJ3QTVnRjFMaXBEQ3FyUEMrWTJCSjlYWjB3Znox?=
 =?utf-8?B?VWNVYzRUdFVqaE1iYkY0VkVnQU93eVdURnNaK1Y5TlJ1MUh5RHhieVFqV1JL?=
 =?utf-8?B?cE1JUlBOeUtKZURXblh5cGVUOW5IeXhQdzJoM29NNm9GNnVEOUtsYzRZcjVa?=
 =?utf-8?B?eXQ3b0k4UE9PVDNua3FDTFJJVkF2TERsazRXYXFPRC80dVl4djZjd0E4OVBE?=
 =?utf-8?B?TG5tMGdYbDdJRnhpVWhtNTgvY0Z4UHNmdG5NS0pwbXo0VlVxRGRVaHF3TnVk?=
 =?utf-8?B?NmROK3hnWHZkb1hZdmRNQW4ycVB5NnFtL2xMVTNDNk5VaW1vblNuMCtsT3pQ?=
 =?utf-8?B?OGRabSs1MXdlTlhnRTB6SFBwbkdHaDA0QnFjcmppS2dMYXJoc2gycmNGeG9n?=
 =?utf-8?B?NmVmSTJoVmpEUUFFOHlaSUpJSWVnVENLWmRDWkJ0dkFneHJVc0MraExRVlpq?=
 =?utf-8?B?Zzl5ZDhqWmR4a05PcTV3NDlUM0UxODA0V1ZhS0NjV2lIb2tRaVJQbDBhcVNV?=
 =?utf-8?B?KzcvaDBjWVNFNTE3WkdaZTRGRkM5NUR5UHBXQkUyUlZzaXNHaFFyenJXWWl6?=
 =?utf-8?B?YmROLzhDNjlFRDBRQTgxOEcvZXBBcHBjN0FMdXUyYW4reGZ4UFJkWHNlTHJ4?=
 =?utf-8?B?L1NoMm53R3JhUXRlZmsyeUFVdmY0NnRXWGx0ZEYxUmR4SlczUlFzY0xCZjR4?=
 =?utf-8?B?VXE0YVVyU2pLb0FtM3lXR3pxU2RTWk40MDV6MUliaDlMWkxldU5aYm5BWTFQ?=
 =?utf-8?B?bDlwYkZNbkNVeCtNeFBjME5nRHBTNFdtMlFzLzFIeHJBU0Y4d1QrL2NrZnF6?=
 =?utf-8?B?U0l6S3hNb1I1V1AxMFQraVJFTnEzLzd1b0M2R0p4dGw0cTdUejVJTWc1TWpF?=
 =?utf-8?B?bkIvNlQxdm5QOFJidnZoV1FQemhGd2xxc3hxSUsxcUNMYjRHaGdtZHg1d2dy?=
 =?utf-8?B?NkxBYnpLYk1BUm5JYkFwK1o5eFcrbFVWdVY0WnpuK2ZFQ2o0NnJOMWlFZ2oz?=
 =?utf-8?B?WnBIMTVaRkYzWFNOSk9HZ2VyL2s3V01wSEZrNVFMS3hmVW9OYWlpSW1tc3d6?=
 =?utf-8?B?L1psR3hLRElMTFhsU2RyNEFIWEk5anZTYThxL0FjVEVBUEVPVjBuL1VDYzNs?=
 =?utf-8?B?bzdiVWxrVVRHditqakZ6eUloMmwyWmt2dzZnNEROUzJiODIwSVI2SWUvVTNv?=
 =?utf-8?B?OFNidEM5N2V3b3pJYWozQUYxbDdBTkdVQ2lLUytOS3VvWkNMYkdxMTlpd0JK?=
 =?utf-8?B?anRzZFh2SHVvQTBNdmJUNFEvTjlYenA0Qk1vVUxBb3IzZUE4dlRJeXY3M05y?=
 =?utf-8?B?eEFzanVCbGEyR0lGM2RwOE5SRmNNM0swSU9JdDhHTExGZmhMLyt4bHJ1VURa?=
 =?utf-8?B?WnlDRzRkcENtKzVQZ21panZFWjdUZDQ5REV2ZEpEby8zR1VDY3VXNnZFOTVu?=
 =?utf-8?B?K2h4Z2EvTzMrSGpJRStnQWVWTVYzOHVXZTZmQVFYbUQrTStlci9Kdm9CM2xm?=
 =?utf-8?B?NHpwSWJEd2pwUThETjVPcFdpK0tzOUY0Y1VmTlZ1b1hOZkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(376011)(7416011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:08:26.4630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b4d955-72b4-465d-951e-08dc8edf56e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622

No need to iterate over max number of VQs.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 96782b34e2b2..51630b1935f4 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1504,7 +1504,7 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
 {
 	int i;
 
-	for (i = 0; i < ndev->mvdev.max_vqs; i++)
+	for (i = 0; i < ndev->cur_num_vqs; i++)
 		suspend_vq(ndev, &ndev->vqs[i]);
 }
 
@@ -1522,7 +1522,7 @@ static void resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mv
 
 static void resume_vqs(struct mlx5_vdpa_net *ndev)
 {
-	for (int i = 0; i < ndev->mvdev.max_vqs; i++)
+	for (int i = 0; i < ndev->cur_num_vqs; i++)
 		resume_vq(ndev, &ndev->vqs[i]);
 }
 

-- 
2.45.1


