Return-Path: <linux-rdma+bounces-12894-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E448DB34445
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892143AA44A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B130A301009;
	Mon, 25 Aug 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FIsFOoMJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987921E89C;
	Mon, 25 Aug 2025 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132526; cv=fail; b=aUHx6ZYAzMmXMOPMiwVp7LDAcRRzgPS7nKfMuDrJyppHCexRpSjyB5QARyHbOEhzKVLWwPDtCqjJFifxoC2Jn4R5AVC837CBSIja3OmEQcxA02NeijEFl8SnZw9BQpr3CjlvBJz9mKjfgz2IpT/yyd0YMihRSwAb2H0E2wcyWHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132526; c=relaxed/simple;
	bh=/n7FJQX5ttpIq2ad0MbSwZzZsr0Rxz8+5TmLc2OaTlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rw46quJouRcWDzHcxjJ+78IJTF0xaZUuCnZaveY4VE+PdR6Y2ekjGOJCd37DiOBDsOAH0fciLwScC87A/Ti2ZCSvNt5/NSwK07lxbrSLJ+Ub83oOj5yne0XOl9JCRbdy+4ckeCyuoMq7BAhROHiBzKgso+m6rbeHQNjr/Aft3dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FIsFOoMJ; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqlgBabxcHclZrn9AVX4vvvzDnnX7neJYu8xfL8nOf+ZQr3qFRP5Gq4ZgrENaQOlmpYMxou/3J2ZLJtDpcML3qVYLRFM6KbcJm+D5D997d8cL6jRWe6fbuW23AKL7DkfWywXXtsf/3CGeM7g37dad3+7LrcQUfTBO0pcuVaX7EdmzSx+FLzkvCZ3qV/A+na9W9MN+vuvzGaAZAFbsXxDuHlKNIcaoZlrVD8VtMVRY6lnvKx2iPILYzR+7EaQw1xUjfRiALONzo1znzXGwQs98K6anBwcgQi2d/W9oJal9GdVx6GHNkQWRyuRu83YSpCMtvoxI7C4pFaPrUYqz1FyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxT4xanGOcEgu3Vn+vOkaorVoIU0gaPMOCvu6Lh+DkA=;
 b=Fb8ljsb6ax4ktnbpA0WsVZ6nrbRgFIxx+SgO1MpiOO/bKUqkWB44q8qeXpHvXZkseEv610TeOWgnRFO8wTGzX0itDCUEOzJLRnkiD3BdmJxL20bX1Z44FcWNRSVPpYCJqGTCAc+Hck3ct2t9sE4eklwtYMerdaqCtsu4HN9goTjgdzsRuGMLWG23c/06yMFgOHBiLE5rksQnjmwpSJbLPf5z7ZSoeOlx4Udi4JvqoYedlVOIqjsBmGc5n1Y4EqrBLqC0GUaZ2jSKs2+zEcIuK+oR9fr4c1hco0OdmDWFqIxqDgF3OdJtTebNO0IJlSMpdioPWxRVa7DsV9mm8HNH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxT4xanGOcEgu3Vn+vOkaorVoIU0gaPMOCvu6Lh+DkA=;
 b=FIsFOoMJ80SGLXShgLjhtQLaX6+BHvRoLY9AD9Y9yrvQ8ZEGwkJs8Dui6lENwvzOv/4CNbalT0umc753Z90GzmdqBC1YVqtchbXh7wFVqi7ifFHHp58CZRw2AjmW/0f7pkvR/KHb/XaBHeAfjCH/OuHr0aU4DqAQRuVtVdoMDZxEpN6supmEpD4cKq5ojYKe8XKRkOFndjgJzAMjL1v9GMJApID5lm7mJ8dlHGHV01lwE6J9NyLfAA37q/leAJ3EOkCjVkMBGEXzp68FVjhTlbJA/fL7Mm2492M4hsYNTp5nU+hqVSf+Xy89et205gVtEJ01YkN5j5LdUySo/ZPfkg==
Received: from CH2PR19CA0018.namprd19.prod.outlook.com (2603:10b6:610:4d::28)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 25 Aug
 2025 14:35:18 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::c1) by CH2PR19CA0018.outlook.office365.com
 (2603:10b6:610:4d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 14:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:35:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:35:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 07:35:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 07:35:00 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Hamdan Agbariya <hamdani@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>
Subject: [PATCH net V2 04/11] net/mlx5: HWS, Fix pattern destruction in mlx5hws_pat_get_pattern error path
Date: Mon, 25 Aug 2025 17:34:27 +0300
Message-ID: <20250825143435.598584-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825143435.598584-1-mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c24b81-71e6-4a05-a8d9-08dde3e49cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zsBj875fmuPEH1hO1O5hWRzBEGELWETGgWPzsSC0oU6zZpB58WzfMJKf/3dN?=
 =?us-ascii?Q?lNvfDYpwoYzQWOmcOkoO2UjnCHUY/7ZMixLx9AA6RjZR0LJBLHRs6GudMreH?=
 =?us-ascii?Q?He1xGqH7PhbD47JEDQNlWSV7x4P+6+cdKxGmr0r4o/lckuDZKLj7W8XrkZwK?=
 =?us-ascii?Q?fO/NgLxyJws8y23NldnYEkbTfBDlkMdwMgYnIxYBzwXR8BBEPuck5TET9Oc5?=
 =?us-ascii?Q?nVnCPP5rfaMo/5TxXg5SoP1QO5xTp4Tr/nl5DdLgIKQohjXYh6F2l5e1vrSE?=
 =?us-ascii?Q?X+Xbzwp7aL9sy+VxjMsU1g30O20p784l8tnNnag46T0xq76II/B0kX3EP4Ff?=
 =?us-ascii?Q?tnK0IJXHKGgl4UqxFiiOU8iYecR91+jzRHLfxbIlmgIAIDIzC1XNWuN0U2Xd?=
 =?us-ascii?Q?LCm6M8I3c1j3jtbk3o8Sot7IC6NDeFiMeo9XKLQ2QOUpt7ZD1LghP2LQ20vZ?=
 =?us-ascii?Q?MkdKx4A3n9ujc0azxDM21cW2az5spu6axyDSw2O96qLhqjNWOeKpNN0qEiB+?=
 =?us-ascii?Q?SGto68Rs/W8h+vi8StCyMTgCTuyt0wB82EwfqJYAbJ18DPYUNPheGX9fRkCo?=
 =?us-ascii?Q?cAF4J+eALao+Zot6FnbrSGJTf+nSLs7mXthYuv+1IuNXf5ihvaNvUwgG+s+I?=
 =?us-ascii?Q?w03Zm1FB0d/M+PvHtwGuszt7jVuAWImIFdn2ACDLitMwsQsu6fCjmezvyGlG?=
 =?us-ascii?Q?YXt2NJwbUAY5a1hwPd43u232r74Ww1e2BJNYeLn8c2unE5JnsRCu/RlVTNCd?=
 =?us-ascii?Q?Gm+oR0RUHOy5rgjTbnuFQEojFU6kgQt9Fy/i2wmSAhHZXZz7m4ogDxpWOaS9?=
 =?us-ascii?Q?dk3D02R/CA9v3Y5RXVodW9c6PU9eYLbjrnEjCV6OlFJRjM6uFw2hHW3olmZL?=
 =?us-ascii?Q?QrqxJV7W67GZlqqQcKuXtRDg/UiV0IwJsqN+KD1iqJWN7Xv11Sg71fG8JQ19?=
 =?us-ascii?Q?5GDdhJfqRG7MVWLVoh7t7DdahP2jsbeEORFRA0+ioWz4zanMgJF5xMoyDaAz?=
 =?us-ascii?Q?YZECqLL8vYJ6dsQim0nJS967evTCAx24+lQRAIYm13ZjwlVBMqw8EcdyBHdR?=
 =?us-ascii?Q?yFYPIiBrqEMjqCOwvTjYK78/b97KH0APGdUL05usrqGVCdmgpF1FcaMPFCbO?=
 =?us-ascii?Q?pIsMYSC3ufCSOhU/+7ChNakI7GhMoGX36DCWVwWVKPtPl1cXMJB3rdNzRHOj?=
 =?us-ascii?Q?WYwlQwW/Ps/XZjnih4eQSFqrQcq8imWX23OBR4XJMr43VnDzoQG2+U0Wkrnj?=
 =?us-ascii?Q?vhsrr7DJ8mwMo0plZH08CoJOjKjRxYRc7d0Jb3hzo7z9OI6Ud8M31xJhKfI0?=
 =?us-ascii?Q?MFcOrC9k9hil/e6bVIOvk4KzIggQKwy1r9RQAEI94F4t9Vmk9xs//0rb8muk?=
 =?us-ascii?Q?+ugGXfSh8VjxaahbXLUkKLj3DoBInOEJUr5gYOJEbiUEWWBF1bY6AU7pURTM?=
 =?us-ascii?Q?It9ZLqIOsmJDAtk+NNVU8rCYPjt83i/lF3UKu9jH6ncyQsIgmpadh+Q8wmLA?=
 =?us-ascii?Q?vI99aAnBFDag9rK167jflIw5UBdjkrrXFiT5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:35:18.0644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c24b81-71e6-4a05-a8d9-08dde3e49cf5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

From: Lama Kayal <lkayal@nvidia.com>

In mlx5hws_pat_get_pattern(), when mlx5hws_pat_add_pattern_to_cache()
fails, the function attempts to clean up the pattern created by
mlx5hws_cmd_header_modify_pattern_create(). However, it incorrectly
uses *pattern_id which hasn't been set yet, instead of the local
ptrn_id variable that contains the actual pattern ID.

This results in attempting to destroy a pattern using uninitialized
data from the output parameter, rather than the valid pattern ID
returned by the firmware.

Use ptrn_id instead of *pattern_id in the cleanup path to properly
destroy the created pattern.

Fixes: aefc15a0fa1c ("net/mlx5: HWS, added modify header pattern and args handling")
Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
index 622fd579f140..d56271a9e4f0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
@@ -279,7 +279,7 @@ int mlx5hws_pat_get_pattern(struct mlx5hws_context *ctx,
 	return ret;
 
 clean_pattern:
-	mlx5hws_cmd_header_modify_pattern_destroy(ctx->mdev, *pattern_id);
+	mlx5hws_cmd_header_modify_pattern_destroy(ctx->mdev, ptrn_id);
 out_unlock:
 	mutex_unlock(&ctx->pattern_cache->lock);
 	return ret;
-- 
2.34.1


