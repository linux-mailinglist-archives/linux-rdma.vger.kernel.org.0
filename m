Return-Path: <linux-rdma+bounces-3218-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C147990B474
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FB81F2976F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA92B13D8BE;
	Mon, 17 Jun 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i3o11VyN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9C13D2BB;
	Mon, 17 Jun 2024 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636904; cv=fail; b=End7bky1m2/Me+hgBNkISTYzlG/i9oZnyyPx+se0yBZjSCwKhr/VtoLaO8n63KvJSOOIlBaH1Tbvyb2Z3Bs4AqZidGrwxNVsSiVPwbZ1+sMYa9+xhCg4V9Q76MA1sx3+c8JcsB/gOXvG83RXAY9fHWScofmVFTG5z8Ea0dlzb4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636904; c=relaxed/simple;
	bh=TRGc0/41x7iSPk6HeNlCOk/vubauiYx27vgStcTBSfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hfi5R0o/sZXz47LOTT7FpBKxsx4SAWKsZih7kl+tkjFw2y9uEWukYRnC2Sa0Aq+hcpjd8YGTO0akcJM6S18vDl8++LJiXLtJfv9z29LRBP0Y4Ust384q4db8B0rRU0osF944kc8MKiByFEhrDAeNIA5FvQ7WfHhVUiRKV9z5Bjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i3o11VyN; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIiWFlnS+TqDB1MRevRv2X8eC2WLpIbdfKlAtMj6HflMLgn/SCCz6TxT1nUpI87rrIIFTS8EbCGlo7fpUx1AfrWSlNNrJQo99PoB7Yl8VIOyJFIdJ/VdmJw9fuim8TC1g8RV12V90vQCdlYkpzbZRbvUXYvoPYv11Yg50A5et1Ua4Ki9mqGiT/bbW35NHd5EvV51HdgkekLib2NMbGb7GO5M7qX7+BukY3eCxCsPSQNzc4dO0yUA/WfkWhS+R87v4dprqVt4wTl0+qVzRS41JgAI3DfP2EpwCBZ1eXRo7KzzHwEAch/Xi0+pUYYAzXTmQ/0aguZzuxw9Lvw+SI03dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/E6q/KcQcL4M6hpZbGaFa5c0cidw5SEefNg8HKLmz8=;
 b=HGfUwraVuvCeJmSg3lz7Gc9lBlZpyzbf8wazJOruQyVQw3TxOomopWT7FwDlAl/syisYqNNYGjgsHh0ON6DO3TQDYBW2P7jXfCAp8pjNpJ+eRqe3qpdTtFis3XJ8iRRK1YomXPhh59Abjy5vdqlHyq94Gq0OsgFRC1lesZ5cjAjw42YEz3rUSlUiGZkB0B8e+yTY7KncGMPO7Ppzij9Q/Sq+KpGYdFFu0K/6qZ3vjjQnKqjkNt9y3/OCNXxFTpF0uOiwgoyj8MWu0wyvKUizZAXgWm/b3CbdZqhozLgRlXewaTaVFR6lBpyka9ERK14rIlUSDwl0gGWafrggRWoQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/E6q/KcQcL4M6hpZbGaFa5c0cidw5SEefNg8HKLmz8=;
 b=i3o11VyN49/kaqAX4YbmcOJFzCgfSKDuOPMfDer0JSj8idCsbMkeo7qXHdUlDSd5TplLfbxyKAIXHpBF9ftPCX6LVDv6zGA8XrJnuANjws881Hx8tDCTF96bVxZevG9wdlSAqSpUHPDIy7aQ0L/48sPfJsb7t6yQaiNnCmj3Ucy38QIyrgHGkCFE6HBB8+xjs1Ng2AzkUsGFCdHg3ISB4t2aWZv/qwdxCZJeTfngo151OCWs8M6h5OJz8FfYh5Q1Zw5hnup4TsGpDZEAJfwo+OFjGa8eCv8msA9vGcDOUw6CMlEBSbr48c62h/J9HWPoWwfVnejLnwvDTKW2EEEJmQ==
Received: from SN7PR04CA0079.namprd04.prod.outlook.com (2603:10b6:806:121::24)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:08:19 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::2f) by SN7PR04CA0079.outlook.office365.com
 (2603:10b6:806:121::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:08:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:04 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:03 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:00 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:38 +0300
Subject: [PATCH vhost 04/23] vdpa/mlx5: Drop redundant check in
 teardown_virtqueues()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-4-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0e43a6-c2f8-4626-a1c8-08dc8edf5222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0hQMUxtWHB2MUF3dmJhVUhZYkxsb1o3UFloMWJBN3RxUHhwT3dycjhxYVZL?=
 =?utf-8?B?Q0JBTU9LdStkUHBuYUJNZU5ySXNKZGJQeGlFVXF4VVNkZjloZ3pkUUFHT3VM?=
 =?utf-8?B?RGM4TnRpUllvYzhwNysxMWVFa1dRak80Ly9JdEFIby9teHFlcWpGVVNRVUZn?=
 =?utf-8?B?RmVvK0lXNUpuaTA4aGZyUGIzNytSMCtkTitmSDY2ZU1YVFBtZWVuYkVuTjh3?=
 =?utf-8?B?VkZzblNveXVwL2dZU2k3RVRjbCtURDBzUFpKRldSdDRTMEJReFhOK3dERXRl?=
 =?utf-8?B?dDUxOCt6Y2tEVG5tZ1dJVXNCbUVkNjVJV3ZEbjBpNk41TnVQVC9sbW9BbDJT?=
 =?utf-8?B?aEZrc09zUk5jbE9GSndQalpPdjUxNHlBdzFFd0kxSzFtTnc1OUlML2RxR0hm?=
 =?utf-8?B?NENlNUZMSHA1VkxOY2FOOXZiWis5ZlcvNVVmNzJPcC9GVkE4S2k4NG1NWXgr?=
 =?utf-8?B?TUd4V2x4MTdhS1htcWhrRUVncVBJMkRwQlRqdlJuN1hHS2ZZL3Y5bnhjekh3?=
 =?utf-8?B?U3lQVm5XRkErL3JoVFdQcy9udEc3am5kOEc2ZnRtMGt2TmpROUQxd2dhZW9h?=
 =?utf-8?B?S0xmUk91MzhKQkJMSW1BYloyejFGdFMvY3ZGT0k0czhlYlpYcXRVOXFUTkpk?=
 =?utf-8?B?OWFZY1B6RFRiZUdtMndtQzBteTNIRjRuaE9IYjhwbTFNS3dDTjRjbFpBeHhD?=
 =?utf-8?B?dCt5QTA2WHlMSnpIcyt6N3dkWXhHUUFybUpXWXJNUWhEZDZ5M0ZVWWU0WU5p?=
 =?utf-8?B?YnVsdzZyMVBtNThhd3dHWW5GcU5QWjI3SnI1VWIzUHl2Uk9HQW55bHVodThT?=
 =?utf-8?B?SEEzUnRmb292Z3Zwd2wrNjNIMS9xQmJWSnFQV0QxWXpGaWNrbjNubWpJM21P?=
 =?utf-8?B?Ykl0MnlZZU9nZjJ2QmZpY3M5d3VFeXA0SjljNzFKMUdRQm1VZ0ZCSjVBSzJU?=
 =?utf-8?B?eUwxS2lNbDJzOEtSRDhKaGFaWG8vRzhWSjB2VXY1cm9iUVlSQU9NMXVueGt4?=
 =?utf-8?B?SGRudTZia2R1Y0h2MzQ2QmllVmJzMm80d0F3ZGR0QVdzWW44VG0vZGpKNFVC?=
 =?utf-8?B?MjV6UDBNL1dpSVIrUUhvc2p4eWdXYlhKeGRWWVBEd1YxTWVwR3lhZmZITkt2?=
 =?utf-8?B?Mk5UcU5SWHhVQkliVEJJS2JtWGdTMWR3YzRNZkdFbi81K3FjRXBYQWlwZ2RL?=
 =?utf-8?B?SkJNeXc0d0hEc1RkK2ovM1lMRGhqVFBlWEFwWTFPRk94Y1dQbjIySWtWdjNV?=
 =?utf-8?B?Vll2SXNTdHc0ZDAyYThsLzFiZFJqeWw3MDRTRTJEeVdubmp2c0l1dCtwdXhu?=
 =?utf-8?B?alNKZTZoZ2NmNGUxV1Zhd1NrbkFLb09qWkY0bXJjQ3lXNGVwQ2hweVRoZ0t1?=
 =?utf-8?B?WW13RXBaS0VsK3JyUW1neld2d3hTSU92VDRCV2lnbDdia0pRYVg3QTJYdHh6?=
 =?utf-8?B?cEJmRFdhOTJMVFFWdnhyYjJkOWlnOEd4NnpEeExlbk5HbC9EbUpyZEZIbzlj?=
 =?utf-8?B?VFNHd2h0M3h5cWY4a245K3pTS0ZuYjZVMjJTWHBuT2NnVTVrT0xMbUFuM3JT?=
 =?utf-8?B?N2NqczdiakFmbzM0SDlyZ0JFcWRLTFNzYVd3b056aW9DVXk1SlNEdXFRSE9S?=
 =?utf-8?B?YjRNOTBnb2ZDd2ZMWUlRdkJVSjRzOEpPV2l0TDlXV0ZPUVdXb0NCa2ZvOUZl?=
 =?utf-8?B?dVQ4TjBNV05yOEJRZzRpWGNlRDlWVldCNFkzbjZ6WitEOXA4Mlo5aXJNQnpt?=
 =?utf-8?B?MHdqNkcwREVyNW0vNjh3QzEzZHpud08vOG9kSnh2Z3dMaCtDUVU1elVWSU0x?=
 =?utf-8?B?UG85eTlxRjdacDBFUy9aY0k1b0xnTmFEQURZNi9uWE43dmtkTjh2NEJ3ZXcr?=
 =?utf-8?B?KzRhd0Nzc0piNEZ4WGVoanpIQTNmemIzR0VJSjczYU5DK0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:08:18.5370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0e43a6-c2f8-4626-a1c8-08dc8edf5222
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

The check is done inside teardown_vq().

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b4d9ef4f66c8..96782b34e2b2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2559,16 +2559,10 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
 
 static void teardown_virtqueues(struct mlx5_vdpa_net *ndev)
 {
-	struct mlx5_vdpa_virtqueue *mvq;
 	int i;
 
-	for (i = ndev->mvdev.max_vqs - 1; i >= 0; i--) {
-		mvq = &ndev->vqs[i];
-		if (!mvq->initialized)
-			continue;
-
-		teardown_vq(ndev, mvq);
-	}
+	for (i = ndev->mvdev.max_vqs - 1; i >= 0; i--)
+		teardown_vq(ndev, &ndev->vqs[i]);
 }
 
 static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)

-- 
2.45.1


