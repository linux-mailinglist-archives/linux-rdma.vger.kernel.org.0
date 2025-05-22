Return-Path: <linux-rdma+bounces-10516-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E47EAC0494
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 08:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6BE1BA513D
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 06:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ABF221F39;
	Thu, 22 May 2025 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eyPGBSMq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D47221F01;
	Thu, 22 May 2025 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895346; cv=fail; b=g2UQqHgGjd+kzDys8WFZMFDnKCJqdsQKVFtN6lIk5JR/GZm5Pv3IuJhKE1xG00A06CCyGAbBYcWaU4RspZrPiiuJ7+I7EpMIb3WZCliAA5+eHH7rUbsELhc389VfntCjCgCD4nDx37HF3PiXdrf3RejFMrD4w92QMiHxOMQWxig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895346; c=relaxed/simple;
	bh=Yq3QbleyE9yhy9Gps4PQz2E9zRhM4P/AmQGSUrK+ahQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtPsMjyloZxGGLUuKDjCQCWOAKY1Fgu8ttqkQji49eDxSdgEfxfHPYtqM8QEESFoUdIFy5jsqmQ/tzkqV1N1QxM54x/cCTRNM1P9Mpg25RF1ky1/DrAtU4SNa/d1Mm+/MMVtXJWAkdFp1fOJ1o9vAAuUcNeiLa9Ll15aDXV0at0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eyPGBSMq; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeNyModZhR+Xlxc6yj5/f5oTjyPYkasYQzdLs5IeytIVs5JQjbgoJtt4+3FieRJ6oqpGnU1WtAJ69CNw5YQhpUNqTsuTWIIZPbrc6pDBV/3cvLOB/pVXJUqWQyn7iOX4sjFseGO2CJTONcIF4XQJBrZG907w/+D5Cg/ddrJojqLl7TNzonwqyGuO7RDXcv2hDTbTpBqGud40dFzG+rDk3MgLfq60Lf75QTAmV/4mU4ReOeEZ+W+lfPWC9v/JYNP35cqqk2VqYm4ZCHxvp14p3MDu6I+f/ZInKzM3o98Cs+Rvvuaq4nDwPPM1upU3FYdZ6xorQJ7D22ER/QZRIHxflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeIFd4GKBbCouE1/QhryUtXaDNvneAmQOgRRus/tFl8=;
 b=MqeFvojx+jp0zkIBQDzyUOBuHUdzKn0RUjwnQOIFx9Lh8y6miYDoZ1nVa+Gx69JeQBpZDMFxd3wpHn+NOG+R76EwYWK6TKbyjZdX8lUzI3+pQ9Y0Qw1sEz1C/sG93uJZuEvp4BGWsgTPd8pnMfj2+uUmi3CLXup+Uwq6rMwo6mu7G+RcjNTk+2EO3KCkUl7c59Cys6CmrGJAIT2vlIwJUXU5308EcCwmUMLkcrHBX0lQ4pJubhDFcGtiWo3hG0ofzCpDNAbfkqf7U66ueU6N8ySy5L8CBu9s9YgjIsKnglwvwb+KEQrZdMxU5l2ELtlSmbCjQlmzjTH4evxLjCdMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeIFd4GKBbCouE1/QhryUtXaDNvneAmQOgRRus/tFl8=;
 b=eyPGBSMqaiNB6JQQDmZ8Fb+0L52WkYuatP5W4LtHxwBTenQ4+CzFj2mc35HONBZb0Z65r4uOz5ped4jkvCF+P2bhgEKzYPiCCuy2J45KUHqHny9wsr+A2nxJP2eKxBoZ8Kz3gqsgkoZxzFZ/f9lM3utNwhnCeEO3XaRzQU/l96P3irkY2O7td9tm/eCmlV1NugwyqsDPL0FAA3AgS8QyZfp1SOIUGW+4t8JPunk3h51/HW5ywdIoMBIEsW8k+wIeabnYd8ht1lpLumxun+21NsOVzV/s4CfPOLJQJXBgP0KWW3hZ0crUy4sJtKuEvFEmynZVBHHZ6tIIC3B7Oddd1Q==
Received: from BL1P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::32)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 06:28:58 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::b4) by BL1P222CA0027.outlook.office365.com
 (2603:10b6:208:2c7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 06:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 06:28:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 23:28:45 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 21 May
 2025 23:28:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 21
 May 2025 23:28:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net 1/2] net/mlx5: Ensure fw pages are always allocated on same NUMA
Date: Thu, 22 May 2025 09:28:05 +0300
Message-ID: <1747895286-1075233-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747895286-1075233-1-git-send-email-tariqt@nvidia.com>
References: <1747895286-1075233-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 314932ed-ab48-404d-755c-08dd98f9ef23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ys82Wl6FtdNHzD8m0T6F9ZeM50MeVOkUxwsx5GgisEiCgWYBrorUUMXL8PK1?=
 =?us-ascii?Q?Csni9aZsatk8LFtlU1KOXVGCOm3yWtsD4I2IDtb02XluqwaqPPZwv4fFST+k?=
 =?us-ascii?Q?DmmxPooO9RBOL+zJpRq0P/Dpynjep/DO0BnJCtsDABhO+X8Vq6ZDnZ0LM8Ic?=
 =?us-ascii?Q?bMXWlZxsbsUnJAZNoCn7VrIWDOkcQ1I6ltvo6cV4NIzRzGU1gC6ZcksZ2NBR?=
 =?us-ascii?Q?nzyBpMj8/+s7ONoQUPn7NSYoOrK9SprSeDyy6DbzP6XGJ6hn7laKr3XKJ77V?=
 =?us-ascii?Q?HeSLhX6ppUS29yVXaQsFCrkV2iu+n8l2rwTvob3pbZKmmxVqDnRvTu0ghiZb?=
 =?us-ascii?Q?++VSNzgdB8yvasDP21I55EnWwSE83ISXHXRds+x0BniqVttGSQiK3HRjIaeV?=
 =?us-ascii?Q?FXsJ0vS0m+sZFl1t9BTNTr80pFwCyxAwA8Zc1P9YgjtryDhOj9lYFPnQn33k?=
 =?us-ascii?Q?7Y/UWxhJASTgSyyTT4vpCX+ooL021LNvey9E/asBDaGl6KhXG8iBlZ9+Eni1?=
 =?us-ascii?Q?WkPNh9Gtk5/TyHvpOKJhitRKYZaqutDsssTXjsjLVmiBGAzh2ZVf8WzXsnmw?=
 =?us-ascii?Q?lagypuGZJMMUdD8u6kEcMsISNmMo/xAD0njo25vUCVcWejkGz/FP6MEEHjw8?=
 =?us-ascii?Q?MMc08KQts4F+5GpWVXC7tFu4V76asx3FtWXHHMUrjzsFrZFutRB0sQu4ruTe?=
 =?us-ascii?Q?OcTlw4APo+gshqPT9Xpd7Iy9FueBCKxhpZJdYc+24iA6AV+oI9RmAkPAEYrt?=
 =?us-ascii?Q?CIPICKGEvgPNP2VRfQ02sbpf4Qryux3Ct6OV5SgQkIjBs94qtrogKE5btt/e?=
 =?us-ascii?Q?ElZz6naDbTXmueWSM0NWfnR2TF0jOqci1TvzAR6ATofXNcHXT0RBNCYsEafj?=
 =?us-ascii?Q?sV0IVxNS3qJNHX6cCJKyCxqzQqHaILBvKBrR9bkS2TL4Fs4FBk3N/Gp+HgX0?=
 =?us-ascii?Q?gYhsmE80rPu09kOhdZWUmIn2LnPb012tp1TRz5y5QGnBxF6edPf/z4QOpEY/?=
 =?us-ascii?Q?6T84fgdQdeoH1GxlnULdf9/VrD6fZL22RmG+ad6y5I5IlJHBPWkv9cxJWgqU?=
 =?us-ascii?Q?JhaB222PAUcWoildslxtdhDpM90iF0gS0+NXuuHoHgNrvRGYpx2FTsnVVupx?=
 =?us-ascii?Q?bJA89yr1QCjBZIU1cEn3Df/faAU+pZOe/1HyvC0IAPVHlGkF1kJ2pA0hRE/2?=
 =?us-ascii?Q?CnXd+fgutMnvmOXPQbPCS+aJf6qI8TqfgX47HTx0l8ZObC1dkahzMi+AVNnS?=
 =?us-ascii?Q?1+SArrvpvze5WCpOJ4xs+6vDapUkt4MaiAWT1LUpGp0rRvRQXkgtBOhvVmr0?=
 =?us-ascii?Q?JygAxArf8SVdHG05C08L34xNYzqnudXoMz5W3unGe1XJpWy13lu4QaR9Gj9N?=
 =?us-ascii?Q?0fKbGIPp3Skc9uppXHub3Zkzfk8vPeAVpvJgoijMbRAoeO2cu+rVxyulSV1Z?=
 =?us-ascii?Q?+f+QWgKdTEiDVaHM5PDmwiUVTGLM1vsJhf+bkJW5db9Ob9QDkKjtETuO7P9U?=
 =?us-ascii?Q?LxknWae9ww45KhEHlH2lZ8aEXrvXIpUf1llQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 06:28:58.0828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 314932ed-ab48-404d-755c-08dd98f9ef23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923

From: Moshe Shemesh <moshe@nvidia.com>

When firmware asks the driver to allocate more pages, using event of
give_pages, the driver should always allocate it from same NUMA, the
original device NUMA. Current code uses dev_to_node() which can result
in different NUMA as it is changed by other driver flows, such as
mlx5_dma_zalloc_coherent_node(). Instead, use saved numa node for
allocating firmware pages.

Fixes: 311c7c71c9bb ("net/mlx5e: Allocate DMA coherent memory on reader NUMA node")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index 972e8e9df585..9bc9bd83c232 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -291,7 +291,7 @@ static void free_4k(struct mlx5_core_dev *dev, u64 addr, u32 function)
 static int alloc_system_page(struct mlx5_core_dev *dev, u32 function)
 {
 	struct device *device = mlx5_core_dma_dev(dev);
-	int nid = dev_to_node(device);
+	int nid = dev->priv.numa_node;
 	struct page *page;
 	u64 zero_addr = 1;
 	u64 addr;
-- 
2.31.1


