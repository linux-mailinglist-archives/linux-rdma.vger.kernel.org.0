Return-Path: <linux-rdma+bounces-12102-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8E0B03610
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 07:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2880A3B0A7B
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 05:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670520E330;
	Mon, 14 Jul 2025 05:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upUJsOue"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31A41FF7DC;
	Mon, 14 Jul 2025 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471657; cv=fail; b=jTkZ1BxHdiCW03cVSKMYoqNNcYmnqN1XLTIm2tFmCyV4IhjSF3XPaX36+sb+D4oKwtgPKeC6RLVXj0bDN+I3qniFogk6kW9ig2E7dianKueEs4q1tqJ4yO1HyJ2szL2SrKT3MfwWFXfSOAFMpB+d2KRBQCLbDkRqunLOLDn3ss4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471657; c=relaxed/simple;
	bh=t8vNTWn2jEOYIBvuGdNzJRzSJOD2hFSQA3kLk0y8liY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqG+UtI6AU8ToIjSJgna8ZEC3WayAezFIQvgNKx8bfBfoA1wdxaE5w1SbpF5gso3rEdC5/3SS7eWEf6wyn5H3QS8h6pY3+cy1fNPn2j6Vj3npnGvOoJa5Dy9VE4LmIBuY6OOJj0WW02N4IRqElwyLVLglvN50qlC4QCY9mTp7XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upUJsOue; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bt1/PREBUFtiJzWiTHdRpgVQfzBCDfOCrayU0JRL5fTwIcB09B5mCqGRowrsroyNzii3jgzAPGBdOIpvhha59QaK6cptWZ59mMUZHy75w4stUhDeQjxraSWniPBBbhRgoNyEzlUt5gDOlG86ZCZvrtpDNnfR0zDoBBGhqQy5uVs+gTdVQww/4ORoGoDTvkJezLUetsMpTo7js4L/gjstS8onOueDEx5W8NjTWji+bZqpYR/fw9WDtWNJCBmxbhce7VUKjjfjiYC99DJFHzLOpkIAGh+TcjaCPZ3rg8uEK8WbaCpO9aQdCVY/OLPRm/FIWXSkco3XY2mi/MuA+56TTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bphQAq++bBw3pqlOnkWeHb8OPwUV5ZIyWbPkJlEIDZU=;
 b=hD4rILe07h7WGB/uHCQ2SiLD6C7EZeNY3UhSGszH/e/6fDTl5HUQLuvZeA7R/gzqlBUSH74gDGvb0zRM1yAjwKJXxJzamI/zO9wVMyTCsOsB+T//s/oYN0DlzpQFlWdKS2sWgEcdvrynoGUJVa37XigUssVBBb1kV/RsKWrIjzG02GuhG37mfMKx0QJfwTEsnz+oLo3R9SLScly0GHInY7TNGP1o9g10fFFSh58qXevDAoXY4WghGq0dResg0m9qzI7j+66cXerleGIVSRfJG2aHoO6jEslJCaMmpVmBOVnclCLpGMvHFJeu74ia0W0NPxjNmsIh2/r7rMEUx9agxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bphQAq++bBw3pqlOnkWeHb8OPwUV5ZIyWbPkJlEIDZU=;
 b=upUJsOuemYY97slTgg0ayIkY/MA9CiuqBrVdgC4vXIowqTWoGrJOpxhQ02qj43xK8R49zSxQpveLYzUkBQH85byB+zEpnA3DxsJw4yitFrGWZ9/l96tahn2OnvMlM6VLW8DKA6LUOcKn2zMs17/C7ov0xYXwxoqoVqSn1//paiScV89ubGws4hiMVhYC8QA5WcZz4B2Nqb8RqJjcWkGxjjlMdPZIJAuKT/Cg83Is7S0lFyZI5Frx+UsGmbh29AOhz49cXNNwhY+VHP172WInXLHUMtC2lQ6QddIpmbOudb3W64zOw88RmTipoXgI1P2v3Uy+zV6uoytPaOdRqHaKsQ==
Received: from SJ0PR13CA0192.namprd13.prod.outlook.com (2603:10b6:a03:2c3::17)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 05:40:52 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::bf) by SJ0PR13CA0192.outlook.office365.com
 (2603:10b6:a03:2c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.14 via Frontend Transport; Mon,
 14 Jul 2025 05:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 05:40:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 13 Jul
 2025 22:40:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 13 Jul 2025 22:40:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 13 Jul 2025 22:40:36 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
Subject: [PATCH net-next 1/6] net/mlx5: HWS, Enable IPSec hardware offload in legacy mode
Date: Mon, 14 Jul 2025 08:39:40 +0300
Message-ID: <1752471585-18053-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
References: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 34cb871a-b740-417a-63d9-08ddc298feb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?naglqXFJ0skMyrrCtJKaBooRrO51ms92dIcQnG9yPc5MPJUHfaynzj8nUzf7?=
 =?us-ascii?Q?bznTWXZ/lWJctWxKijSa1DP311Y72HGbc3q4OYElMPAyDniTqU/amWc/jmNE?=
 =?us-ascii?Q?SUAAVvxG//YWiH6sMpgbo5cD8RRGCLLeRAxEfiImE1rhWyD+bNp+bHBW9N6h?=
 =?us-ascii?Q?VNAremyryh/iaV/jSPoa7cFUTMiHDpNko8BkYfQb9FxjPazzM9wK0IjxFdms?=
 =?us-ascii?Q?2gGLAXfVmg75SCNx1tPBYoa3WfoWOuWwrq29LpM3lhcTItbF1FHNPGwim9/A?=
 =?us-ascii?Q?L86PGKEdt6REjuXLLdNTcrRgREXWzz9k8T96ItK+vgPTGKegxOsdHsDDeiFo?=
 =?us-ascii?Q?9hA0DHq8mso0l/cF10nOsD2SRWgL+1nI/IO3WJAqq2xSp2bFhnPUy1QvHUhj?=
 =?us-ascii?Q?rIPJiTWnhjd8gzJLrrZVdmoiDDbrJrycMi5hqvVn6+ODCBHXMuO2slVUZIC3?=
 =?us-ascii?Q?6Qq1m+wXkLgjpbk9kIznSoxUj9PdbXzj9AG8lAmJgBGC4K3UbKW+DdH3KC2+?=
 =?us-ascii?Q?RLvEuI7SoILAm4zVU0ZHkLJKib72Edj0cOmQhAV/NA9UvV72PxQJRA5slujm?=
 =?us-ascii?Q?wuAUGlAZeV/YCJJh94f0yzEhmkx+A8spVo8zWADhxxwPvxTl4ICh7KrC75RQ?=
 =?us-ascii?Q?h2KJ672H5ow0tsbK/BF5J0TJ7ug4SXOgYlhIpX1FEQ9eKyt6XSaXZJHx8+jC?=
 =?us-ascii?Q?n6YTQDew9Rj2LGH9FPZaKilncURd0rdRyOMo3HVapBZRk1x8N8wYCEenruwk?=
 =?us-ascii?Q?0FZSc7SnQZyHbBkTXRw0E5+jJM5kKDnszmKIYr+adz8FMDwibT7u+R/UeS4M?=
 =?us-ascii?Q?yjkmiTm/ngYnuiLgzRhirBTmKn2fpAbJmQTmHTlaRpRw5y3FJydjwDuNSplh?=
 =?us-ascii?Q?2H3MGcrUZCXloF3vF14jPCoTKFUudlRRuPqOaqD8vDXhNmf3/uzuVXMQi1z+?=
 =?us-ascii?Q?TETg0RE2IQ/sE+FqABkrzxDzkOkIoUTkrHJCdVn0ozbSpumfveayGShz+8ef?=
 =?us-ascii?Q?FDb53RdDKwfZk2KKVmsyAXS+u8GpimhunuwwD6+TuG6ZdN/m6DnQjIky6ecM?=
 =?us-ascii?Q?po9ceAONkr/NBTSXHpY+e8bVg0wUFQo12wa3Jiph5Bff5mc7KLFpRoUYuOmK?=
 =?us-ascii?Q?5lBn68pXPqD8PbGz8bsDhYA2yMQ5YTFGqLLXHV8oK1E57bnnKlSdrB4oggsr?=
 =?us-ascii?Q?dc5IREFyYHTxq2KR8L2SRP0F6hYvnaypVtYohN9QJavFySa7VYrQwG0wyUl4?=
 =?us-ascii?Q?RgaPX3Di+AuUUs3glj2VbfRuZaWGNPQ7qj+UEUKd25zS23EH615ZehUlY75V?=
 =?us-ascii?Q?tUAERxOY9+pgmnBmr+2VyOKAJtxUDNLZrlPRGyQC97hW3/cUNfup26NRXiZz?=
 =?us-ascii?Q?+lKeoThIJiHjeIxk9LsXXpq5PeYqGFqRCBlXPDl8BnaHzXNvSqsKaRbmkOLE?=
 =?us-ascii?Q?+UEIvF93GddSsNisGpRM6O+bPuQAV9MtwDdWurva5/wtOlXhBTw8gMY/GhZV?=
 =?us-ascii?Q?yRsLM8qGYovOKoCgFzfGGBBfrwqFp8+qOJdX?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 05:40:51.9985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cb871a-b740-417a-63d9-08ddc298feb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421

From: Lama Kayal <lkayal@nvidia.com>

IPSec hardware offload in legacy mode should not be affected by the
steering mode, hence it should also work properly with hmfs mode.

Remove steering mode validation when calculating the cap for packet
offload, this will also enable the missing cap MLX5_IPSEC_CAP_PRIO
needed for crypto offload.

Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c   | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 820debf3fbbf..ef7322d381af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -42,8 +42,7 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
 
 	if (MLX5_CAP_IPSEC(mdev, ipsec_full_offload) &&
 	    (mdev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_DMFS ||
-	     (mdev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_SMFS &&
-	     is_mdev_legacy_mode(mdev)))) {
+	     is_mdev_legacy_mode(mdev))) {
 		if (MLX5_CAP_FLOWTABLE_NIC_TX(mdev,
 					      reformat_add_esp_trasport) &&
 		    MLX5_CAP_FLOWTABLE_NIC_RX(mdev,
-- 
2.40.1


