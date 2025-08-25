Return-Path: <linux-rdma+bounces-12891-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 484B7B34429
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9081B2169A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234DC2FB994;
	Mon, 25 Aug 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VleaBwaM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F81E3DFE;
	Mon, 25 Aug 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132517; cv=fail; b=ZoGWYbIfrLk7fpnJdG+ND42N5+6IqUrZEz/rUP6Tm4FdTB5WgsBN3xhQ4BEtOO0odL2f0WdUX1D3b9Bsvlwy1Xnm9NfIl2ZZ15n4t9KeBaK2JZ8rpKjbAcS0/3BZOkl5BJH2ar0DnmwlI92QHDOXVIEnQLB9WQoplBJaXMuiHaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132517; c=relaxed/simple;
	bh=uhSo9pysU3h6WZwatxZZUCyfIUczga4x4lLjnw/quLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZinZR6+11dG5Sxd3e5A+P2iGHHfD7q8zM6oHJ1mF76sEgfofiAyozEEt4uyjNAsBpT0FTXITSfSvLFIf0Sf/KNQ1WKeVJU3JhjgFNiLDD85fj/R2BgzqV8pYj9F12ksz5S6WnNlyQKoSlAGnkNOejbIfJjE1DrGqBKNdMkEyH5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VleaBwaM; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYH732YhZ47RWhsAsaDpgklsR9+dEvt2hLeYQ8SZU3BGx79HixmV3C7BYgNsJxuq6m8JIA4W8RiWtsN/DVOP+NckZroiiV7j/GMXheaCo3F1j/i1MHeJwlQ+e+b9eaUiU4ZaEY+Rw85XAeSZqcK16aRBvnuCpuk081I9G2tYPAqEycvmgSEoI7YD17UzJ3gq9Raie988szT3i90XEbqy+EWESizJKpiRbSxvu0o4L1cjz9zP5NXwEfL6lquemY+LmPkfC1UAl0/9j+8bWWoXM4GTPx3p9sM8ydqHsqH92D1aA+bHpwW8K2n8eQgvBH1dsbL5nP69iobSAByIlervqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWPyZmPOLtzKUnTVhJFX5KGUPCx9gphAmx1IFnFoML8=;
 b=Ju/yvLoq0slfhln8PHsP3QI8LV8QiRwjt9JsQTkBiVTQzw9uHUdbBFDpLqpJka/NYMpQnK+oW9ZoCmpGZA38Oj9fFFqDUl1xib2gnFK5xbiayMM+4+ihE0WruP84CCOkXrjCARamn37/rV3yQciH64GDJqcpbncnEiJLOD5R2E8wRPFbjR20T6KejylxNd3ENV7BVp8Psrzzgm0aFjSWOXqX2JO3W5rEanIo6d0GOSRaZsEsHRB1qTXmQxD6yOHF9RMxMVbLfzCGMvl5/AYP98KvdnN3WfPskM8AiRnOXqRy62lJ9ibx8wMUJ3YSFEw0gSZyijJmf8z52YLJDpNNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWPyZmPOLtzKUnTVhJFX5KGUPCx9gphAmx1IFnFoML8=;
 b=VleaBwaMtVT+VLR5XBzx1+2frK8UzZiRATCkYU7n6qpXQsc8MoF/C2BP+kt5WQJQyNi3e0FRu+ew6dAIt0LnW4GjFIoBIGLTjEgeMKaSjWY0KkO24UU7S5WEpdNcklHVJLO5kZlo7kljLqQQ4hYVx94TVq4R15wqEfvm1eFNwBNYlWQWm4FcNbeXjODDkOQBflXXbzy6CmbM+DtoyWgIDbqLnET9PAXJQCVGW5BcDTGLXMpeVQTCcKTb7KtS6PEYK9EeiwFVIgG3pGJgR19Yg9jb4zB9CMbnPNYw1u1+KWyhJVYUz90MNFDAl0mmRDxKN0m0gwJe+wTo3NKnH6SVPg==
Received: from BN0PR04CA0163.namprd04.prod.outlook.com (2603:10b6:408:eb::18)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 14:35:13 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::3a) by BN0PR04CA0163.outlook.office365.com
 (2603:10b6:408:eb::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 14:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:35:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:34:55 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 07:34:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 07:34:51 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Erez Shitrit
	<erezsh@nvidia.com>
Subject: [PATCH net V2 02/11] net/mlx5: HWS, Fix memory leak in hws_action_get_shared_stc_nic error flow
Date: Mon, 25 Aug 2025 17:34:25 +0300
Message-ID: <20250825143435.598584-3-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7b4dd6-923b-4efd-8ba8-08dde3e499ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M3O/gYDtlwh9TEAJ3B/f0WmfRT6ffcISY4UPvNDSKpJVPwCmGdeu1wOzwR84?=
 =?us-ascii?Q?G4KXLaFGpY/f9GlP0cmp7IvhMYsQrcgwb3TcV7X8lMVxay50L7zXnXWdBlp4?=
 =?us-ascii?Q?QLa2plswJ4iGIrAUufRTvhP4t3OuqlbryNAK1bWbfQVJemToXmvpqHYfG/36?=
 =?us-ascii?Q?NrXFsALQs0kwLPIxwqQ97LkPjY/UZKHPa/sodvVdJN/7+ObmamUjz658pymV?=
 =?us-ascii?Q?g+JuJY+yW4tdoz/N4cVzQaVaE6wTf8gCFU27xDAw/o73oWkqdKM0aB++HO3G?=
 =?us-ascii?Q?H3tVT5T5kzvaR+5MvoOizOLqpg3TM0YIEBCjFWkhQHE6xLbLGNYfGekU/89I?=
 =?us-ascii?Q?8HIBrMFmwHZ9gskArGssdj8bzSqcGgVMvPeX0WmKL84ucq+DFtnq5tYm22u/?=
 =?us-ascii?Q?yvw2XAYaZK3hg4WFmpZu36vkuAGOseWE+mu/puhEbwahACfSk6r6KV/es/5S?=
 =?us-ascii?Q?xKejk+9N5QdiLArAC/ZCA8raNGknzYRWX2f8NJHZSab99FuAOLuSvPnD8i6j?=
 =?us-ascii?Q?praIFrVX2LXF95hFd1X5gxjipjj1UabTKRcVvvwgEpWekx7BQgu4svu0EzOR?=
 =?us-ascii?Q?fXOtwzxf9gN+e6LGoSSk4KgTtIep4d5sLpuVoSB/ujHKlLLUGrxEjcQM5DLR?=
 =?us-ascii?Q?n3UVM8GgI8KDiXo+D9UJ+PR7o9dBhCMqRaWmvXwhkgCq8dd0Jiin6oDU0tDz?=
 =?us-ascii?Q?vA7Exp+Z5X1kO7wMhde5WNY3poEzfmoHaySgOCU8gtgAePv5b3/AIa6LtDQW?=
 =?us-ascii?Q?zUQoI6GbjFHZsmRkk+hrlw3EMrOTUnQTK2iSojoLy9rDPl63ysdnzWbwfhKU?=
 =?us-ascii?Q?uM3EAge3QfU7dJRDuw42G64ZIYuotzQMBo5dvELr8sa3f7SXGkxiatSeo+Mo?=
 =?us-ascii?Q?mm9PI8J9H0v4Crqu6SVSA6E2hFORX4d5kcFQIWiAmcvvrbWl6kUmB8wLvhJH?=
 =?us-ascii?Q?aURj5Dlgiw3IA89308OjGm/a37DkAc9dDQaecamf9tdsZKby/1+ELf+5zFGe?=
 =?us-ascii?Q?69vb3WuujXEyo8g1sRK77fJkROQZ8KJ/vuzugcFgL52iUlUHLKmOXmhiyXR5?=
 =?us-ascii?Q?irzRot/Rt1Yk7wRze1WxeMJO5Lwfsc8y1VyLxVf/fqGqFRqF6xwxY5lQBzNQ?=
 =?us-ascii?Q?08Na4XZ3uU3U0mM+cG6vSMwH35VBTsl069kor2wcHQtE8UIKxloHn9BfQnjR?=
 =?us-ascii?Q?TywT4fmwFo6ropVUxDjsScYPctTpiB1pgN4R3ihHEAKJxLoJf1mnJ000L/DI?=
 =?us-ascii?Q?KdMylUCnfgdLtqm1XY1oMTtlQXNE3u0uOKrRWgdUFvUp9ORL13bWZRplAzLm?=
 =?us-ascii?Q?CUew0l+VHcrs2YomghNvYmggEuU1y5DWH3esGkpKUqu4OEJBfvE2sAi7ctWI?=
 =?us-ascii?Q?UIFPTlbq98sFZY2shsDYr9bYFo9BZmMEgJBu4/N5Pq4OkBcJwHjCMER8b7GJ?=
 =?us-ascii?Q?gV5QB76Efuav1Odfiw3iunW1XEw9wkLBCk+r+sAgrGamhJnxjo8e9ifX0x2c?=
 =?us-ascii?Q?4xwcrVa9QK90WK0FmfR2G6TcnqvrRx7w9t2N?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:35:12.5075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7b4dd6-923b-4efd-8ba8-08dde3e499ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199

From: Lama Kayal <lkayal@nvidia.com>

When an invalid stc_type is provided, the function allocates memory for
shared_stc but jumps to unlock_and_out without freeing it, causing a
memory leak.

Fix by jumping to free_shared_stc label instead to ensure proper cleanup.

Fixes: 504e536d9010 ("net/mlx5: HWS, added actions handling")
Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index 396804369b00..6b36a4a7d895 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -117,7 +117,7 @@ static int hws_action_get_shared_stc_nic(struct mlx5hws_context *ctx,
 		mlx5hws_err(ctx, "No such stc_type: %d\n", stc_type);
 		pr_warn("HWS: Invalid stc_type: %d\n", stc_type);
 		ret = -EINVAL;
-		goto unlock_and_out;
+		goto free_shared_stc;
 	}
 
 	ret = mlx5hws_action_alloc_single_stc(ctx, &stc_attr, tbl_type,
-- 
2.34.1


