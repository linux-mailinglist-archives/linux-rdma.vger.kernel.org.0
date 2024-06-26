Return-Path: <linux-rdma+bounces-3502-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8083B917DDE
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AC1289733
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E30E181B84;
	Wed, 26 Jun 2024 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GHekPkn/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9B18132B;
	Wed, 26 Jun 2024 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397649; cv=fail; b=W3RB9L2MlG51heo4y278uwrUpeHIlwiq27db/Q1FxNdTj1+LhulMKn1AN85lm0yGnEQOXRFc4yZupWumeatQgAux7Jj5d1pH39sbZXqPVvSu57/IJ7jLs+YVM7LsbG3io0gl/e9UBkrlHNrcCfatf1mh5WDAIru2JoNU4bh6ij8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397649; c=relaxed/simple;
	bh=M6lRV9NoNAW1TJuej2I0DQYN0elhD2WJuKjGOC1Yx8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ggCHCQpf6oXn2TEUGdV0smmbvPar+Iafpn1fP/OvUNew/gFUe5LCChdWsKXe3s64TSgrG9bHs2eO0vScLyosaDebEjvbANPNlocVvmXzATJtdm49N6YnIAXi502KQl/O86qRwjTI/xWJCuHRwE4thRM3LbEAjLzwXPNS+TIsj2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GHekPkn/; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbWD6c1VvCr0r+nvYQEvHAke+QH71/KYgeLzAWTvjHr/IY/ivU/wHGzSTrcm+JtCnQILMZE5Q3UY24K3bHUwoDb6CMD+i0SgzYAcItktv51a4A73S6ig8YvgDWOvDzCAFA6ESIzE/HhNiDKS/srF22vy1P34rnyQD7R6CkzIi/jZXmDxrXNqlVGwiPQJBltJpl0g9xwunARu4sI6/buHWJc5eYjEdwyb6y8UV62qMcY+2+XpXWXCuOM4XRt5yzWOtcb43qI60zbxh1o7iTlM0ykTSXo/LkLq0UVBhAp00/1Fmz7FLKyUwAoV0nooLaU7yprNj8O1dajyaQYRMBjs7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leowHrkD84gmnKN+yKy7J0oPt0knQQGSZA0JhAUzmWQ=;
 b=glQCEl2nG1Nfs089vhd+MzzXGC2sGfIndkka+Au7d0zQqE1G2A9PEDP7/dphaBCquAEPeIIcR+ar+CwYW0ZpSrkO3jLePuJ76bXcCZcciD0sfRlf2EUmGOt2Fcy2gmzJ2a0Dwsc1A/IefBTDhYJlCidmfXnem43Hg9W4hGtary0naOwiWubn1HYd5oCRN9UJzMTbfI+FmPCT6SASpch7SF+29EXCi7iA0ZMfTYvA4wddA9kt2JT48cZQcmn+ImqrfOESMIqNfAMwOanseXwUTAZPqZGgE6O6GZvUePVgs66T+bqpKyf0xQHBiVgg7TdUfASgGRJ6wSsoQ3nuUByrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leowHrkD84gmnKN+yKy7J0oPt0knQQGSZA0JhAUzmWQ=;
 b=GHekPkn/+092kh+1koNIg3JDC5OVklgJJSptos8bgUo9dQymezeNi+C+zfl6BjSr6zku8FxJsV2QM3zzcebXAUjNQxa3Xlovx7CK6a4rH9droVPDCZ7zS3aW3Xm2P6LDdblovtXoiN5mHeO2M7AC2g1NdzW2Jwdml35QpLfWI9eud4/41HqoVfKCVj4HYlXlYMAkHGSwiNg6Z5fZuHBJ738tKohKGAf+e0ogARcYBjlNL2S+aEXqmz3tuJpA4E1/Ub7IWzD9cnFkJhdSG/euHEI1QFEbSXAAyU7BNtWENmzq0cy9gaGA6tUS8WT6dI/zC53Y2gn9HHoP53P9mzG+kA==
Received: from MW4PR03CA0282.namprd03.prod.outlook.com (2603:10b6:303:b5::17)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:27:24 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::5f) by MW4PR03CA0282.outlook.office365.com
 (2603:10b6:303:b5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:07 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:04 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:41 +0300
Subject: [PATCH vhost v2 05/24] vdpa/mlx5: Iterate over active VQs during
 suspend/resume
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-5-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 254fd3ac-3824-4797-c323-08dc95ca91b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|82310400024|376012|7416012|36860700011|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0RBZHNFNzRsekI3ZzhvU1duOFlXUG45NXFIcXdrdHVLQUErSDk4bzdtdE0x?=
 =?utf-8?B?Q3M4VWcrZTdpRFhqVW50TmVzNnhGWXlFeGYwcXE3eHhlZktCMW82eFo4UUQ4?=
 =?utf-8?B?ekJhcWg0TWRxc3Nrd01zQ1M0NHpDL0NrenhqSC9BZFRzQVZncXhORjl0R3BW?=
 =?utf-8?B?OFY0RUdoQ1FnUGhqOHhUeVdQcG1oK2ZEbHZwRXhxa0RteVg1T0FlWUJtamRG?=
 =?utf-8?B?Y0Z5UEFUVFVSQzhjUHJlbUw5enVNS0RaRU53bEo4U2kvbXVPeTEyU05aVXJH?=
 =?utf-8?B?SWhJY3BXSEt4WkhKQzNza0R5UzZMWkpKWmJxMXhSckx0ZjNxTk9CUFN6UXc5?=
 =?utf-8?B?ajNOd0tHdXp3elF0U0VFTVBVREVEaWs5dDZWWGpLRFpNUk9ZZmhSQXZEM1VI?=
 =?utf-8?B?cm03OHhkSjhzUXRIQWR5TzRkcVNyYjhTQit5TmRNYi9sUXd2YnFwd0R6Y0c0?=
 =?utf-8?B?aXRpaThnYzF2UWVtbUtMeGg0eGRRWTBWeFRLQllvaGMwajVCRG5TK3J1MSs5?=
 =?utf-8?B?eW1yUm56ZjBycktNVnAvVUpndlY4QW95SVMxd2liSUxSSC9KMFpPSEtySjMv?=
 =?utf-8?B?anl0Z0V4N0ZmNzZrQjA3Y0sweFJCYnpCaUpRNE1iZ1o1UDkvblRnWDdCVkZY?=
 =?utf-8?B?Z0luOTkvOTQwOVJBeGVsVFdZSkR3RUhudURHbjFsUWN0anFkdkNDOGNzUWRR?=
 =?utf-8?B?TWRWeGdZcWp5NWRKV3Vvd04yakZQKzBJYXlvZi96SkxaSVlKWXZOdjA4L1lN?=
 =?utf-8?B?cnQ4YjVlRXVUSjBwSlVhZjdrRGh3MmVBTDZlNVNzbU5HNWFBa3N6RzlNd2ps?=
 =?utf-8?B?UnM3cXNFclVYb2FIS0dZNUs3aHQ1c2FJdGliNjBxZlI0NkUxTXQxbEV3SkY5?=
 =?utf-8?B?ajlJZlNUU21MbW5NdE45ZVBZUEw1RlNlY1hCemFXNVgreVpRVXk4eC8zakVY?=
 =?utf-8?B?cjl0Mm5nM3RWRFRDT0xGc3VYSGFJMmNVZ0xaMEtvbkJWczA2NU0vZ0FUdjUy?=
 =?utf-8?B?VytKaEFtNzJ3K0VCcmFsQkErMmF6NXNKTVBCcUFkY1M5WE51dkZiNE1QMEkx?=
 =?utf-8?B?c29ZL0FtcmJ5RGllb3NTUENkc1laMmV6K0JrZlEzcDNZYVMzeW1KSlc0VFpT?=
 =?utf-8?B?U2JxQndkUWZlM0tSZVNxcG1tYXZOTExEUW10WDJsOWNBd0V2UWY0dDk4K250?=
 =?utf-8?B?cWUzTUlnQnhLNEFlRnA2SGFUY2ZKbmpVanNqQnVvdUo1eGhTa2crSXc1dyt3?=
 =?utf-8?B?dHFuaUFCbG9wazJUMW1rOWtSVTFpZ3lHSUdHWlVlbnFZMXFPNHg4L1lVQjh4?=
 =?utf-8?B?bjJQT0EwdU1ZakdyMCt0Qms0eENEUkpTbE5lb28wQ25wODlqVTk0ejQ3NFNi?=
 =?utf-8?B?ZWlnU2ZnRHpxNDgwc3B0OXhNdnU3U2N2dGtaR28wQlJMenlHYWkwZzFjdEt5?=
 =?utf-8?B?SUlENlV6YW1vZlgyc2sxc25jUFRDV2hnc25Qb2d4UGZXanlHdDdjQ3pRcFpr?=
 =?utf-8?B?NVpZS1Z5MERwVEdwREpKejkyNnliZ2FWeTdkRnFKRWxDcTR1MnZCSC9NYjRO?=
 =?utf-8?B?eS9nMVpVdVdHeEs1ZUo5a3EwTVpjZEgzNUZjcEVyZi9rbHI1eFBJTlZpQ1Av?=
 =?utf-8?B?cmxKcnE0UkRBdE9Xdm1USmJmMXl5dWY1VzJuNlNGQlVlK09YYmNRQWRvczVq?=
 =?utf-8?B?U2FSV1hhWXRhWEcza3dmckpsM1lnVjVKTVc3bG45QmZuak43NUh4aVB5QjVm?=
 =?utf-8?B?c01pS01lRFBhdnV6RWlta3E2RmY4RVM3TFFHM2dWc3dOUG5rcWVlM0VZY0M0?=
 =?utf-8?B?b2oxV0lLZWJVbUJiYlBoVk4yZlNoSU9idnRlZ2Nkeis4QmVCckpNd2NxaEhm?=
 =?utf-8?B?TC9RNmlLNEVKK1BySFVKYisyb29lMmdkS2hmVW1BTStySVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(82310400024)(376012)(7416012)(36860700011)(1800799022);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:23.9421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 254fd3ac-3824-4797-c323-08dc95ca91b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698

No need to iterate over max number of VQs.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
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


