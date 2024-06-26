Return-Path: <linux-rdma+bounces-3517-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCAC917E1E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFCB1F22D8B
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D18818A951;
	Wed, 26 Jun 2024 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rOmvKGm3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217E1891C5;
	Wed, 26 Jun 2024 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397706; cv=fail; b=EkRGFcl9fBwZ3BrL/+2EKihvvYVrTKvzVAZThzaJY1r2rjQgF0I6nNPtSycpyEShfsW9XtJC232YTs0SdgA5iqNWXWQpI993+HDnLM3Y1P8VVEu/2ZKCvpPz0hV2MqWS2P39PLTLaFb/Hl1SI3nPnh2wcryodl7Oymhvpdp/Omg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397706; c=relaxed/simple;
	bh=FEcoyi4MwChTT94/YoCRTjbpe6Lewj5Xkqw5N8AkdAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AfIgjq+ciEYxBDKKcLmTIt+2Pymc1o3EsjqXQ68Vk11B6Gd7kFY3qu5OJCA1Xg+c1Qq+Ks35rbqHp+iIsMOAyW7z4OTlYtLXsxdKCvAsN6apwtE4J2tef9lrbaqYIFev1kdm5lFfyODbIOoVs0MgMJ7nixgEytt23AbWzRkog14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rOmvKGm3; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZo5HXYOzl7nvWs3zPKMIoDd61gs/BGJ8Va2EvgGOltMQzvVdMAFuY4y+fTc+5NLwgoKGCRDn3dyeaR5aoJMzXH5vrE/RFO6Bs3z8a7vK6MgZMzButdETQ6tbKUSQEm8nPEv20APxyY51goNJz94bbUBtle4zcU6R2JPdBeTMcliEFh2ZSnYAm46I2w86b/45/9hG3VPT9VLaVpVJP2dAeRBPCpqM7L7zhSTb/tYAuL1ebcKzEgimImCP+uF6e08cGH8YiIEM2HF7JF0R5vBcPJ8Uf64oRcrbf/dXwvkuwpI6ZX5yCmq+AdUP7XMz0mP/Mv+ho6pGXwN9C+L+uLq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RO9B6pk2HLDFatJ39WrGheP+Kp8n4ALs/ymCH9Z8CR0=;
 b=YqVh63ao2I4wz6ZCwzejSjKM2HgsjplXwlsj+94PsDIqch4rSjGXLvVhwgCtdcJzF1j7ovGCMYbnQOFWFygRJhalw7eq8Kk2B6FsWe/N1nR4uSeSxOSN18t9fGEEsWZAmihEE9AJnvlM0zKRgIawnhHT5h9KfImGP54RW8NLnO58ZNV2fsAcm3UMkzPqqIEdCgQG/l9IpqZVLUgF/cAad+2ZmoIxHdvA4Ca74zyOIB+11dPttS2rDD5KTsZ4pHDUBWnn9Sc7UFyHQ64tX3t3mNL1d/gmX5kFS3L53tjRNk39iOHAabhWqx2/UDDwL+YMADtbANKvHndU5W7LOSU0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO9B6pk2HLDFatJ39WrGheP+Kp8n4ALs/ymCH9Z8CR0=;
 b=rOmvKGm3m4Rm8UuNkAlbaqS7dY4i5CpFp6RnWWr8mHHEJiV6+gedqAZl5Gq/LTJixhKvJu8sHnUAYmVJKzcJn8KQa2cGQbKxo6Vnuuv4IWlKYy4jSOO96lUz7gNDQnMt4ZYhDhlRKNAsIkfm2rfXiSbFB/dsbMM6nGGmQMs5dgYjExtc95Hv9R1ek6yXXVsCl926FI+U/p2uPI0mX6PKFRVIo5VyrG1P98ZfxmNPeQVAwm4JheVjyOLVuJA1l1ZCIxdu1DUWYKpVekfdkI7bMXkQtZ25o0TKlRy+IdjbW0S29fZO5Pt0H1cmuQMiMbwuMBwckl4vEMWUBBDrHfW/Pg==
Received: from BYAPR11CA0101.namprd11.prod.outlook.com (2603:10b6:a03:f4::42)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:28:22 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::a9) by BYAPR11CA0101.outlook.office365.com
 (2603:10b6:a03:f4::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:28:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:08 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:28:05 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:56 +0300
Subject: [PATCH vhost v2 20/24] vdpa/mlx5: Use suspend/resume during VQP
 change
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-20-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b5f09c-f89a-486f-3efa-08dc95cab438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|82310400024|7416012|376012|1800799022|36860700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTVoRm9uNUFRWEcvcHlNK3FENFBGZ3llc1NPdVNSZGFKWWVDVjMvcEF5ajRI?=
 =?utf-8?B?T1Y4bk5QR1ZSemZUVkMreVg0S2ZYQ2c4SCtyQ2VraWN4S1JkNTh6ZXpWVTZk?=
 =?utf-8?B?MUhFdml5ZzdQcFZCZ3ExTFBhQXVsb3VhL1ZGdkF6MWdWWDFSVmduNm1WWmxO?=
 =?utf-8?B?QVJ2UjgwZVljeUU1a0Niem1kQlpieTdoMFVEU2RQc0FtY2dVNUFlYzh0VmU3?=
 =?utf-8?B?Zk9aNG0wbC9XdVA5NjFiTlZJODVkdGkwM2NzQnpydUpSWVZ0SWFXRlphM2Nu?=
 =?utf-8?B?UjNzWml6Vmx6WjZkMkY0RjVmVWZOdHBwTkMrSWJ6dmM5VVFOdHRPcHRhYktz?=
 =?utf-8?B?K2J0RklyZ2tqNjdXa1FFL3RQeVQzYUNCYk9BNVkzSjZILzlYeFZPUGtnK1hx?=
 =?utf-8?B?RWE5Z0ZGNUJPZTRhci9PYVAwYStpOUJsWlovdjFJYkc0NWIrQ1U2dFNON2pJ?=
 =?utf-8?B?ViswNXlLMm84RzlNWUQ4YWhEUjVkU2VQZjZhaFdDMTdTMTdqT21qdXdKN2pI?=
 =?utf-8?B?Y216eWRaKzVmMXBTQkJBbTFleVZaNTlqcCtPNHhKMm1zS3hoc0lRKzBOa2VM?=
 =?utf-8?B?UGx4RjNRY25kNUMyVFFaVHEzcWIrN1ordkNVSEZSWDZaVjJuM0lGbTNsMFZq?=
 =?utf-8?B?RDlXcEg2ZmhiRXErZnRqczNkUm9MblIrRys0S3dkMmhuVmZkdTFrZFVPejkr?=
 =?utf-8?B?clpCUVVTanlwSkhBN291MGN5QUJBL1ZqYkR2cGIwaWl0TkRURjFaNGVCT1Qz?=
 =?utf-8?B?MUNxNXliZkJ3UnZ2M1k4RU5kQXlvVTdPaUVVK3ozQXloa1JTWnVrV29pSk9v?=
 =?utf-8?B?UFI3UmxMb2pBaHp6czM0NEE1aFBpRWROWnRIWDFKb2ZJcExaamo3bjYyc3Az?=
 =?utf-8?B?WmVjWWZyQVJPcHRoY2dRWktPbkFiYmwzaWRxeGFLWTNQQ3ZXSy9CRjVKaG1m?=
 =?utf-8?B?NjdnVTFHUkZoVHBJcmZwb0NoTmVLckpVa1hGTllNMW1weWpiY2t3M1o0cUZn?=
 =?utf-8?B?Q0E5MUpQOW5YZUxNY1Y1ZE9LNkcySU9EKzVCMTZuc3JEK0c0V3NwNy9zU3Nz?=
 =?utf-8?B?THBrclBkSHlFQVRXR1JrU3gvRkRDQzJqb3RKU01SdzRIOHB6Z0VqVS9Xck5o?=
 =?utf-8?B?d3J4Q1BBcDd2MVZ5WVBUeVhUNFh6U0dUS0o1QWx1bVl3MVRIaUh1aVdlZ0FD?=
 =?utf-8?B?WDd4ZDJRaUlTNHRjVDhqbmhBSFN1TDJValJlZE5GVjk1RXV0aHBpRHIySTFn?=
 =?utf-8?B?bUF4MU9pbS9lTER6amk2Q21aSzhvcVJ0dkt3dk5ncGRJWk5VUjBMcmlYYUZF?=
 =?utf-8?B?cUFnVFEzcTUxMStSOGpyUjZSU3VtWlFUaWgyeGwwWkdLRm55OGowRTFRV3R6?=
 =?utf-8?B?em44Qzl4Q0xDR2ZuY281RjlnNm1aNjBnV0lHQ1RYaFpyZG9OdndlWkx1WkZF?=
 =?utf-8?B?Sit3aEk2U1d2UHhqN0ZDT2hlT0JaSEhueXp0NVNjUThZTHVYVitWOFlLUFVi?=
 =?utf-8?B?VzRrZ0d5MzJ0Umg2STNVeHdzaXczTExiQlJUWDJqcDFDVlYvZG1Uak0zTWVW?=
 =?utf-8?B?WU1EbFkzTHNwazcwbFlXNGJrcmFNQVNhQ0RNUDBXdksyakZ6K1VueGpCSEFJ?=
 =?utf-8?B?NWtkMENYU1puY3dRdWJtTHF0UWx0NjVkWEU2cy92ZzJCS2UvWGNUOHVSTE5K?=
 =?utf-8?B?amRoN0tZN1pQODlHME1Nc2d2dHZtc0RvMEo4enhRbEFybVlyU1hNb3Bpcmp0?=
 =?utf-8?B?SFp4U2Roc1NpVTZjQUJCb3Z5VUl2dHcyTEdIMFhld2ZnRzRUOTZBRjFvSW1v?=
 =?utf-8?B?dEM1TlZndjB6VU9BQTRrZWZFN0ZLQ1NUcFBiVDhld3h5eHRmREpWYzViL0lQ?=
 =?utf-8?B?ZkRCZmVDL3BGZzNsb0RPREhFUUxpc0hocitiM0N1UXpZRWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(82310400024)(7416012)(376012)(1800799022)(36860700011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:28:21.8347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b5f09c-f89a-486f-3efa-08dc95cab438
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078

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
2.45.1


