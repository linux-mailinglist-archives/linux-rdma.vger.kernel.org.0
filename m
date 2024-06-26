Return-Path: <linux-rdma+bounces-3509-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB0A917DFA
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E10CAB2686C
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCBA186297;
	Wed, 26 Jun 2024 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t/idwW5b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF92A186283;
	Wed, 26 Jun 2024 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397674; cv=fail; b=SyWdw3Qd9xqBtEFYI+w09l8/xaEFO0lu6EeJa2/842QmFdNG20fprum4Ybe72qc10Mo5lNW+75lHdU/vQt/9WtUjM7Rla3mBMFdFlEZtbdq4EWX2iC7zAEErO++j4uLpnDeFRX/t2Ei0UhB4DEblePZ5rf84NlhRYE8FN2H0NQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397674; c=relaxed/simple;
	bh=ieJVGBVRUroEZwsVSyUQ9E+v8S56vFe/Gebp2TTwfto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ndYbuuzFJVNVYhyR/pZcgpabu7chR32Df8ucr92Meb8CGQO9pKDeS352Hy/aNVbnhXEXanG08yCFWkJIGjeZ0DGx6YEQq3Do6mrmAy+1uJ1gkH3vgO5Cn5NBb/1dxKgHqlUL9sT1LFKk5Pa4DOWHZvwfq8/Vm34RpVspCy2ku1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t/idwW5b; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHj+XwmoI8NkHG57gz0GRq3RwDVz1qV7uZaCsXohtvE81rz67531U1CNT7YPC6Zy1pBLeKq35RhSwyezP0WoXxiMAClxvv/3sESAUS8ABK6lsr8qrpzp/k/qDD1rStiTgvRO62aFUqfpmC7UOhDSCB99EfSy3i0g1kCR0FnDG6VIJDh+jMyVmWIzfhv/uTh0XXHWFY7yjYJO4MBxKqPGtJuisN5TDhBwDNCDGup8Pi2g2tEMhOi4fwe0+JnA3hlnJ3k5/HMIoQv780J3E+kOsXmxmei4Ce+OfBOKVboNWH2DXaDMtaJezD0T4gB5KA3hQCykJH83odVsVEsvruiA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gjqyoOI4mKnsqfT7ZCpujE0bo3aPxy1yV9u1GZzKWE=;
 b=Ef8EsHcRMzmEO4XXDd3sFpuyAiRg270ts2jlbE6xPr0iBxyFASAi4vDxTK/RB4zd2ejYSAM6OEIYqEKDcul4rcOc8UAhNv8bCHdrAOr65u1wgiPmWjV41DnpoU1reFuYesA2Yq0srstWpruwWfIO5O22WdWBkso8P9sA2U6QvHDPsmnBma4LgyK8YB/DRXuBfdxWr8MnZczlymshJJGPaTPFQ+AnHeGERC6Zs6ymExnARabdhZN1sCHKt9Wj94nOcJVOD3G4QBWNH9KtC6nQlXWcnIlkT/dwNfoitA+EygKxBKtTY9lu9gyr2vxPj13MCkNiWwBcVJAfQwTkPc22Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gjqyoOI4mKnsqfT7ZCpujE0bo3aPxy1yV9u1GZzKWE=;
 b=t/idwW5bR8LXoEd3YZm9SREM980jROcqthw4jKcwz4BVQcRfbzN0uQpPfod3dmcjbyIHVAenGzfDAgMmQqs+N7pVL/7zSbbrVdNElbZnecRYDciVfTLCrvH0tqIeihTfIltKgo+/He74BA42iC4qE32p3QuS7YJF4OpUewTsFZi5fq5U/JXsqoXNZn4h4V0AJk9XAyConelPCWo1upS5a+T/iMOrc5Yv6No2BnU4AUKO61xNFPn2Fs3nSR3cp1xsIPhHaQi9oZiQM4ox6u+kfDsli8d25CsQOd7ytTjc3XElQvZBG5rRwvsxSvJOQA8CcMmDb1k+eF/iZppy2Raz8A==
Received: from BL1PR13CA0300.namprd13.prod.outlook.com (2603:10b6:208:2bc::35)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 10:27:49 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::8a) by BL1PR13CA0300.outlook.office365.com
 (2603:10b6:208:2bc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:35 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:32 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:48 +0300
Subject: [PATCH vhost v2 12/24] vdpa/mlx5: Set an initial size on the VQ
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-12-560c491078df@nvidia.com>
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 5519cbad-342a-4a98-bfa8-08dc95caa091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlRqcHkxMkJSNi9ZN001clROMjAza0F5UkRYWTl5MFM1Y3UzdTNVM0JlVUVH?=
 =?utf-8?B?KzM5cnZhZjhXL3ZsL3lFQ2pzakh6S1pXdDJBcTJpVElGMExWbE5HckN5WUhr?=
 =?utf-8?B?Sk1oQmNsVk4ya2pyMWFYdjg4TUczT0xtQ2J1YTlQaXNIZkRHcDE2WnZNbFRU?=
 =?utf-8?B?NXV3aU5CWWNnSmpBckFDUE85QWNEVE13UmVtK2JJS21QWUVxT3E4UDlSdWwv?=
 =?utf-8?B?V0NJQ0p0VVgwdDZsRjl0QUFJNGwySUpKTVpNQXRoK1ltRmdlMjhZb1RKditI?=
 =?utf-8?B?aFVsdno4S1lkRnYyMVdzNkRlVTJKOTY2a3hnMHF2V3ZIRndxTkhRK0U4bVVj?=
 =?utf-8?B?VVhFbUNaTUQ1ZndGR3FjNnBzby9VdHBsckdrQUk0N0x3VHJ4RVhxVERRQ1RB?=
 =?utf-8?B?V3I2RTBKT1E5K1BDSGd3by84bHlEOXYzaGZseTJtRUlGRkZMWHd1aXhzd2Zm?=
 =?utf-8?B?YXdFOHFYdkFESHYvOXpZbEl4UmhiU0d6WG9hWGsrUERWcW9QQVZzZHhOeStU?=
 =?utf-8?B?SnpzNHRiU3Y1RzJBUE5WeGZLR1JEVStMRklCWVBISzRnajdDaUQ1ZDZVVUkz?=
 =?utf-8?B?a0NldUpIR2psVlVmS0FGYTVHaDJxTmdCZ3QwMVU3MGY3aXNBU0RmMXplMUhK?=
 =?utf-8?B?WndmWWdtODRUSldsejBBYndiWE16NkcvTDJGYzhkR0V0aUxzK2hodzlqc2dt?=
 =?utf-8?B?NVNOdHlNRTlpOFRVS2hqVE9MU09velBwWDh4VitoQVp2a01vMEs3bktsUUxQ?=
 =?utf-8?B?Q0pnb1ZhejA3ODhEVlJvL0lUV1dxOUhOR1l3OTlUajFmMXlQa3V0VEJiU1l6?=
 =?utf-8?B?UUNEc1ByeDZsa2pZUVlXME9LejViUlgzS2FGUFJRSi8yZmhtM2pOTDROU2My?=
 =?utf-8?B?T1ozSHJ6Y25EN3dFcFVGWkJlR0hQaFRkQUdzUlhXWGJPMG43aVRpWTQ5OVFu?=
 =?utf-8?B?RVMrVlB1cnV6eVR4MG84eHhIUUc3TG55ZWg0eFlQMW1JY0d5bUlzdEM1NUhn?=
 =?utf-8?B?bk8zbkFxY1JjWlZEN1pEMnlWZmlsZStkVUtMZW45SjBTVWNVZk5tVjQ5OFpp?=
 =?utf-8?B?L0ZiMytOUXNSR3RwODN3RkpvMklJaGZBNUdUeXZFb0F5bFZEK04veFQySlNy?=
 =?utf-8?B?VHNzZnErTHVCWjRTcExheEQyYkxMRmR4Qk1aWEFJdXM4NmdnUUtlUXhTdU0y?=
 =?utf-8?B?RFQ0aHF4bkJHQmw2bFRrUHliTjM4L2x4UDRXUk1paXp2Mjk3VndNa0wzcU5H?=
 =?utf-8?B?QmFxbGROdDhXaThaT2pONkJiaHkzdlJvakpUMUJSK3liR0xKNklDWGczR2Zy?=
 =?utf-8?B?MWgycjVHN1Q3Tis4L0d4ZktmZUM4MDVvL2lsNWVheEkzRG5MYXAzYXZVM1lP?=
 =?utf-8?B?RmI0bTRiL25sM3FXak80MytxMkh3M0pjWkxNQytyQWRZaFllaStZRzRDMmtw?=
 =?utf-8?B?T3NZcnJJUEJxckpBaVhSbkpvbW8vV1pqUjFWdGp2UzJtaGJBS2dYYW45a0hh?=
 =?utf-8?B?MGJrbjA5cjEyQVhiVVIyUkZUNzc3N1pWdlc2REwyOXF2dWN0YWYzZXhVOXlm?=
 =?utf-8?B?S3dOVlpkNWxqREthMWJBRW93aXFCcTJYaGs0a3ZIalZEN1IvUlRMUTdHcXpF?=
 =?utf-8?B?QlJUTjVFWG1XSUZpaFdleE4vVnlEeWRnWFhMVWc0SzdKbHUrNnZ5bUU3L3Y1?=
 =?utf-8?B?NDBhU3pxc0Q5YTFtQnYzVnNxeVVxNkFqZE9DRmNaSXZoUHVBdTUyZnVPaDRF?=
 =?utf-8?B?QjNPL0ErQzlBSVo3ZGxwZmErdHlTblByL2cwYi9uNXU1TXo1SCtlTFB5a3F4?=
 =?utf-8?B?SFFrZFExcDE2azhXYmtFMkhQdDdUNkhnMnRPbTBHMFZBZ0t5NHpkZld6clRZ?=
 =?utf-8?B?OVZpZW9YMmJVZHVGSytDL0I1MG9uelFtVE54VGUxQkpOb3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:48.7575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5519cbad-342a-4a98-bfa8-08dc95caa091
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833

The virtqueue size is a pre-requisite for setting up any virtqueue
resources. For the upcoming optimization of creating virtqueues at
device add, the virtqueue size has to be configured.

The queue size check in setup_vq() will always be false. So remove it.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index db86e541b788..406cc590fe42 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -58,6 +58,8 @@ MODULE_LICENSE("Dual BSD/GPL");
  */
 #define MLX5V_DEFAULT_VQ_COUNT 2
 
+#define MLX5V_DEFAULT_VQ_SIZE 256
+
 struct mlx5_vdpa_cq_buf {
 	struct mlx5_frag_buf_ctrl fbc;
 	struct mlx5_frag_buf frag_buf;
@@ -1445,9 +1447,6 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 	u16 idx = mvq->index;
 	int err;
 
-	if (!mvq->num_ent)
-		return 0;
-
 	if (mvq->initialized)
 		return 0;
 
@@ -3523,6 +3522,7 @@ static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev)
 		mvq->ndev = ndev;
 		mvq->fwqp.fw = true;
 		mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
+		mvq->num_ent = MLX5V_DEFAULT_VQ_SIZE;
 	}
 }
 

-- 
2.45.1


