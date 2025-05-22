Return-Path: <linux-rdma+bounces-10517-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CB2AC0496
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 08:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1DA4A566A
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 06:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1729B221D80;
	Thu, 22 May 2025 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D4DtOJYP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BFA221FC3;
	Thu, 22 May 2025 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895349; cv=fail; b=Fd50lulB08OiByiShBwDPoKEuIzcinuJEaGIgezvMxT/UwwdEpbD4zKBaio/YBpsaqgLtz8nhjDBKont0H0WxjMgQlFbMr7c7lDnYobQun2FD9mPSIVrqxBSHlvgMqP3yU7j8M3sszJXO76nlvCKJ3C9NcgrZofKEwPOpAaqXmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895349; c=relaxed/simple;
	bh=NeK1HJgV6Q31oNd2yGDwHd0feSD/L0fMFG7tcQ8xLHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTnv47MceMrvf/0CA1sJtQWXGWs50EXMfzXoJajBPQOIE1RPlW96rNH2Flly+ienSfFKm7rk0fNZNkScr7/YT7/0wY2rn7kwO34i50cNqDhhT9zH+FuDa2K++WY38VHIeMZVYWUDy7LaUWp8D5qRcNwOyxWkOOmHAk2ercQ2rl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D4DtOJYP; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPqOURv57JlUzWuSH5xhcGqktIXvuR6ShR/khsQ0ITQStEbLDlVtaqvKcvGwYMvL2e61KgzVA8NPMWolGvBLW3BJ1dA5fVvx62265Rkh5Ck4V0dl1Ylj7hKK56GPuhRyZFDiz24YaGGLCnTn1CoctQ7RBAMeCAW8kiVtSs0amxcUPgdpMW0SpAAurbd8j86xDlIBZIM2fBr9sPNCUmm6jao6M0u9ocDwtZTqWxvQbMlI9fZxOS1+ngmeUbG7k1RKsUj31E4TM63kAfDPZvMJpIhaewQPeiZ4rkztfK1qtPbpAsPB70oQHwyDbh2teVLoyAsP5jsvBb86XvpXo3uq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhKHtrkYrhFQlI7AXjsXPYPTfeuzKozT+JIHEL+6N3U=;
 b=kCAhQMZi2dARTExz0H84gtWoWNr3kqvUTNL3jEStxGl/R5mBmfve+ON3j4mdO4Ugq8amg3ykAYb5Wsd3jnDq+Cdk4SuHbwzokwowp/0653KEtyU8MSpxnvKMexUsE2x5xtBrTQwYaDNyWjmyCi77mweTlFj+IaqOZmMHolJHcn1BCVosILknUrP+y/tM7IhZK50pVcQ3STEVRzmehZsWfz8NWRkvWIyVGM+Fb+QUsnStIlyIoBTqv0XMqRl+TjVWUId4pas4bJZJtCCysQXdeJyYjJ222tgY1qrr7H7bDhPhyoXqv17P5haSTSCAaX+lUFFgyQKAftDW8DE+kPh/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhKHtrkYrhFQlI7AXjsXPYPTfeuzKozT+JIHEL+6N3U=;
 b=D4DtOJYPdQGRh4cDy9El4qzpBZUIYjc0XiZqhkpMvPft4wV0MikCxsheo/4kzaJqZdfh3wymwubsPfsqABjIdrxQPiDs0NA6hXiij35N9vsOoXKWYXzrv+unbNHqHvOOmSIjpVCYuIOd8RZpATCKrktLh8yvKf6H3yrcZs+t1sHVBsuPv0YKmS3eo/NHO7vBnInS+ELqdiPMSvb2b5SpeANcCr86hh5bO3XB3zLvqhbo0JNbwgjIBVzdaXYCQMEdf3UGx0wzVaRPJ0DgNUMt7Uw4GfVovyDHqnJ+2yNocRn+xOzyK2/H7lvHksSnO2nu+ufjycNzvFxBoaT1kINV7Q==
Received: from BL1P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::28)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 06:29:03 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::e6) by BL1P222CA0023.outlook.office365.com
 (2603:10b6:208:2c7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 06:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 06:29:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 23:28:49 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 21 May
 2025 23:28:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 21
 May 2025 23:28:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net 2/2] net/mlx5e: Fix leak of Geneve TLV option object
Date: Thu, 22 May 2025 09:28:06 +0300
Message-ID: <1747895286-1075233-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 52831330-b224-4c97-a279-08dd98f9f201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rvhiu8T5s13eYqB8rZ8G+k2e09U7CXbqtoyU4igNCpZ/k94mMzUUfJKCuwOY?=
 =?us-ascii?Q?/RHHNeTo5+Cxb6R6K6gM35mU397DuXlyTRqJoRAD+hw7avZ/kR8wkIUKMk9R?=
 =?us-ascii?Q?2cfko2VEhPEQbgjwxmPvteSr4mZmHZt+VFFhW+nMj3qO6iLEzLVyNs+WdCBL?=
 =?us-ascii?Q?Lu0l8X7dexoGzQ8d2OdOb7wXptgl6XrU4JSzFm/u98NrAb2F7p6nGrA5+CHS?=
 =?us-ascii?Q?paWTpfOlrXUeVnUnhcHaiZS1h52xY9+dsPhOeFfVe9A8XWvr6dMuG0OCBTY/?=
 =?us-ascii?Q?NhrTxucZRBIduQ1Y5vyHzjlWH2ZsM+gYo2jG97vqRRrKJc3f3AKxPCwNB+np?=
 =?us-ascii?Q?TivZ4oOYbA5F9d2SL7RgU3XR4kCncyNRoyOuziTYnIA5MgP85n0MZtRfzkhS?=
 =?us-ascii?Q?8HpTr13k1E423TPUyZMhvx+Y7lHDgL3aHhPHQF+GMEPT3nhz4luODKcubX/f?=
 =?us-ascii?Q?sgXB0PZD9vTsSlrdNn0Y34vtse0ZddyQjw5dOribLu0IrbAlHuFJwEFPiK6Y?=
 =?us-ascii?Q?XghLJq9qhwszoPYIrZ5HjH+OuiXmGYGRExgx5xQlFNnFB5+acpXrWvfHIkTs?=
 =?us-ascii?Q?+Rgk4UjafINzt1EG+u03xx8fHWHWyetSRhK1Ok81x/0inWkpvD2yv+eOmog3?=
 =?us-ascii?Q?rxIJMyU/2Fc9T3Kau1WoppYWdVaSujjYXKip7x6xbvZ8E4Vdmjl4RVir3l0f?=
 =?us-ascii?Q?E3GfCdVFSQp5KX0OKZLHrXw7dLVto7Plms3BH/uq+aDF087Pg6GfXvPOzJwJ?=
 =?us-ascii?Q?cuh9GqnCjLHrQIRKDseJVzGEznly2reCy50izaFwTzMZ+VyaKB/3MaCEXaHZ?=
 =?us-ascii?Q?L1+crtfVLV8/Lm+LzbQexPDwD32tvUHZer1wc3TLYm6E9e6KaFgeL96STN7b?=
 =?us-ascii?Q?9sLyxE0pSdBWB+oC8kAeMpUG2yuGUTzYNmyHm93Zz6N4qb9DrI8m21+O7XCT?=
 =?us-ascii?Q?wmBexvtGsUftspWlOZs+JxoLGKjXWcTbZNq/wfBmS+6kPlCMm8BYEk0LSw0E?=
 =?us-ascii?Q?g6F+7LKvXDBjEUUJpx143tuNcJP4DqMFqSNfz+n+UB0GChLLQp9bqRsBgqVI?=
 =?us-ascii?Q?HZ6D6j/O3dtEj02wRlvzW7y3r3ttegXt8Onep40BFZkojGZoi6ycgu41IpAe?=
 =?us-ascii?Q?Zuogo4EuRZS0vsMCa1YaFTYKR9RIwhL5zZhI9hPk57J2uQ1aiJLqvGAoq+D7?=
 =?us-ascii?Q?7pNc2lWwlJppthjVCh2gir4fnouBzbu/p6NR16fi19tuatPWzln3KDQMLQXh?=
 =?us-ascii?Q?9ngM8ZKwSapYEzSyI2AEk3EHm6f3noysoXWr2vf7EHbx/J6Kuodj1I+Hg9IY?=
 =?us-ascii?Q?yHhS9Pok+ect08NVBHH7EZabjV+1RHud+sWzec6T6qQL5BUDt0pE2+tRNo3z?=
 =?us-ascii?Q?5Zed0UQypExHnoQWfjfxDXAO/P0h+F4M3nVE5rr2GO6t9Eg53BKqRD/bYNuk?=
 =?us-ascii?Q?LxdYuwQijlLBhr1q8jYbCXYBVHC3x4jy6DQZxXFEjmU3wWcU4OiNSizVruhw?=
 =?us-ascii?Q?ANkNFTW7Ho+yjQuf3ZkwqFPWPNyJGy3gwV/b?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 06:29:02.9389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52831330-b224-4c97-a279-08dd98f9f201
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418

From: Jianbo Liu <jianbol@nvidia.com>

Previously, a unique tunnel id was added for the matching on TC
non-zero chains, to support inner header rewrite with goto action.
Later, it was used to support VF tunnel offload for vxlan, then for
Geneve and GRE. To support VF tunnel, a temporary mlx5_flow_spec is
used to parse tunnel options. For Geneve, if there is TLV option, a
object is created, or refcnt is added if already exists. But the
temporary mlx5_flow_spec is directly freed after parsing, which causes
the leak because no information regarding the object is saved in
flow's mlx5_flow_spec, which is used to free the object when deleting
the flow.

To fix the leak, call mlx5_geneve_tlv_option_del() before free the
temporary spec if it has TLV object.

Fixes: 521933cdc4aa ("net/mlx5e: Support Geneve and GRE with VF tunnel offload")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index f1d908f61134..b9c1d7f8f05c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2028,9 +2028,8 @@ mlx5e_tc_add_fdb_flow(struct mlx5e_priv *priv,
 	return err;
 }
 
-static bool mlx5_flow_has_geneve_opt(struct mlx5e_tc_flow *flow)
+static bool mlx5_flow_has_geneve_opt(struct mlx5_flow_spec *spec)
 {
-	struct mlx5_flow_spec *spec = &flow->attr->parse_attr->spec;
 	void *headers_v = MLX5_ADDR_OF(fte_match_param,
 				       spec->match_value,
 				       misc_parameters_3);
@@ -2069,7 +2068,7 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
 	}
 	complete_all(&flow->del_hw_done);
 
-	if (mlx5_flow_has_geneve_opt(flow))
+	if (mlx5_flow_has_geneve_opt(&attr->parse_attr->spec))
 		mlx5_geneve_tlv_option_del(priv->mdev->geneve);
 
 	if (flow->decap_route)
@@ -2580,6 +2579,8 @@ static int parse_tunnel_attr(struct mlx5e_priv *priv,
 			return err;
 		}
 		err = mlx5e_tc_set_attr_rx_tun(flow, tmp_spec);
+		if (mlx5_flow_has_geneve_opt(tmp_spec))
+			mlx5_geneve_tlv_option_del(priv->mdev->geneve);
 		kvfree(tmp_spec);
 		if (err)
 			return err;
-- 
2.31.1


