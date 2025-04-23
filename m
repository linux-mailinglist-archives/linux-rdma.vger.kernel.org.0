Return-Path: <linux-rdma+bounces-9707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44595A983E6
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7953B0EE9
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B583227F4F4;
	Wed, 23 Apr 2025 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nmc/ObLk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECD0275118;
	Wed, 23 Apr 2025 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397411; cv=fail; b=ewNPlLpGmtUo+x/PJ1SJjeunVPuvgq2l5eMi6nsfSwnp9nbOuXGR+fuP6kSoXuENaqDOt4IDcmmQ0CyAtPan56p+wxyLfnw+1UxG7XkVwRnZpNGZ1NtkX24EErCVLVXlndfBLcvLRXcN7CRmvdjEft3OVP5png4gmB5ImRUn56o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397411; c=relaxed/simple;
	bh=sW6lUPMnzsY7ASAgue9XYiEAEaP+tGWTdVYTTPDb5lg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHTUcPyzbtmkorTZUFdJRthsMHQj6FCxss0iuYlbsSaycBXGbtpUGUgXJ2jN3N02Ow+00jADV61SzTFrpCA140PQ9e8EscVfiWzhc/HvCdpFOK7hDTC7me/epFO+vLYBC57hDwrRzP9gpGAHXmwpSm3+D99jkemIea7MEQBXGpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nmc/ObLk; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/2CqVTV/zj+88zQVmxTaulZKGtY04E5dUpKjnqvwolIhsHbp3xd2sP9WgM/iGy5um2MGxLufYo6zLPPGYXgGQ0yUXuLej5fagYUW2hqYjrWWmFmFXZaGjA9FKyj7IJrmQTgtJY5SYo8xvKEiP0hGIaBt0q+lt58qt8eDdP5DT0BEjq8d0BbRkTGE/B+JRyPLUd1rVIOiierL9rJWocQ3/UjT1zGj7FkxqzZLCav7iMXSXuKYNvhykpnSJG7bWk659O6Ldh4HMoetikP9aa0W5NnbiguzyPlLfDE0fPWgt9QS4OdWiNq3dbzV7et3jzHfWlLUGqLPKnuK0rW2q92OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1bDP87eXPxSYDM3fWNPLuja9C5QwsHEV42+c0WyD00=;
 b=yo08JJQaeFoLMlTpommxAchsMhq5tkE1KTYx4ta45tyIAS7H9iumbR6i4yGdBKBHYq7Wh2rDOUac/2kbDPX6wM/bD+yu/qFOLxCjVXMPEmn9mD349hmbZdAsa6BLZnmqOhY+EYFPVWzF2JYHaPeUQ4ft9tYob7kRBAQcEQAfZWWOV+VzMcdultOV1Py32h7ui3qd07yivjVfH9PURafpu0vPOOvVTDNVniCPbN7KrBGWAUMDQDTsuQWHWeUD3+36LxE7nj57ERvn21CPIsTBH/xFQxjlx0akwYf0psTjP2DUdYgH5prhpbhTqfcyfm6x91soj25/CDhC69GRSO7gyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1bDP87eXPxSYDM3fWNPLuja9C5QwsHEV42+c0WyD00=;
 b=Nmc/ObLklZE2zDcpOab6cJ/Tt7ouABH3RZ/b4vTreBuPxmHYn11frffrW/KcH862zm3yl3PrNTkov4X7kSmk/0mTga3GS7ktsSvR6pklXq7EqeCZzlDVotvfJIhxWEjSG1EH+PmA2fTHcWYQXJOOdxOKRsme8+MXvfqhbt/aE3PUsu6pKS2ulN1Egc/9sFIdcxt1lMpMydBhp/GmVxWPT1Td6chpyY2MQ6EGLU4Puv1g3mR2P0ryNW3dDXRaaG27ZHW7t36WIthrVwj3F5wPj6azk4RwOTAnXmA6VBSLUH8O3eLtQPOczANhDq3/eS3D4XXIHZnL6soOSGboVtWz2Q==
Received: from MN2PR19CA0031.namprd19.prod.outlook.com (2603:10b6:208:178::44)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 08:36:45 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::be) by MN2PR19CA0031.outlook.office365.com
 (2603:10b6:208:178::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 08:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 08:36:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 01:36:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 01:36:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Apr 2025 01:36:28 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jianbo Liu
	<jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net 3/5] net/mlx5e: TC, Continue the attr process even if encap entry is invalid
Date: Wed, 23 Apr 2025 11:36:09 +0300
Message-ID: <20250423083611.324567-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423083611.324567-1-mbloch@nvidia.com>
References: <20250423083611.324567-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f8c3e6-1f67-42fb-7427-08dd8241fae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UXqDTmzELnqiqVcBAqvwJt5gPL8PfhVEQ5LHOEJ7NOzi0g87Z/AwmjK6pGHC?=
 =?us-ascii?Q?0XScnFv66rtYOuk4zwFPcUgeID/OOAxODQ0EK9Wa7M9DAWamjYprjLfvGuTQ?=
 =?us-ascii?Q?UKZKgHm1g/7cNoxVTTJxQPeXF4Io++TC2flpO5qzHriyLauh8s2xxK04CI4T?=
 =?us-ascii?Q?4/c4n19StJnaWYGNCmqCwTCSS+4aOQNljVX/VL/iGJzP+lGLHJBV4jkNcDnX?=
 =?us-ascii?Q?dXEPJ6WarzXJ4Oetf+0lQWvEpZ7MXdRk4yker7qGppJ9JEFQXtUnzoZm5Va0?=
 =?us-ascii?Q?JCVlaHJ/YQQXTPRurjq2vmPJo6xo4YW8yIFzwJtydRFr0O+zw+3HPHQ+WL3D?=
 =?us-ascii?Q?4c3oS84AdAY2O908/Jy8iO16pXWlqpB9GvuXKKurUdQJO/oGFTanD4FzPeNP?=
 =?us-ascii?Q?sE+RlBxROKHVl0GEl4Uyt/iBgU5v/7xyAodtRRYOgIfp3MERz4sbIlKJ2guq?=
 =?us-ascii?Q?eXceAanykLMumQLhDxNEt+rX8FDCQZJ9Mm82Gqc1BPq3SNqC4byCzWMMxYvq?=
 =?us-ascii?Q?DVMoTfoBbkRjY5aIcAt4/mzaEC+p16tUXOJsy7HTDbebKv4SuuQ21NxgY3L1?=
 =?us-ascii?Q?fBnn15g6W1SD7JbRppQ16iY+LyPEVCCP7O+iXggYb3kRex6n53jreNSa3kwX?=
 =?us-ascii?Q?T/YEtjygnokghrjas3zWU0l5OCVXSFE5Zbmh3SNJoz4weksO7A2DsxnAKAj3?=
 =?us-ascii?Q?wzhfPPNqgI/8Zqokwc760uw95tfdIjq2fUsV15Cxd7SEm74XvBbgxJqdLPvd?=
 =?us-ascii?Q?rV0L5fKUe5YRR+Qmqa+Jm3vAqseDPCFOYMCQmufv0xN92lAfsQ93SE1fLnq5?=
 =?us-ascii?Q?6EMHZJfSMKOkc4uIrxsvPQDpfkCZTQnIudxWQHZ0u4JKl9Mld/NQ9ymVP0Kh?=
 =?us-ascii?Q?4sLp+izdOc7AIAD9g0fl0PTXgsf2UDYBU8qF9c+wyhRjtUMLip/PA2qxfVyu?=
 =?us-ascii?Q?MAkgR/+fCPzNGez90DFqq/EywHQHvJtYaMKJPOLQsvuXaBv8ScjUn/1+3bls?=
 =?us-ascii?Q?Jr6hXF7Rpqej9yl/OKeETndsX8dwefJF9GBt9Z0o9+f00QJLkgjHwyty7xfN?=
 =?us-ascii?Q?OLBuoGVWIHNWkA3KGJeX/9qyXCBEp9FKUB2jX3VmsMsnnst1KhTnh8V20rIW?=
 =?us-ascii?Q?teXduVNAnAkC1oTTpVbQi/qSh4c6/6m20/T2o5racW5rYlovqM4PXvoASDuD?=
 =?us-ascii?Q?CREUFrZJ08Q05qtf3SCrU67kXX+LX7IIpQUWktkEhcB/r8ui9sW9vO7W7ldL?=
 =?us-ascii?Q?N7BNudwhEaJGTbNiF50i3gzSqRHp16yLBRlBqZ9FLfuE0DGkrxfL8USzz8Qe?=
 =?us-ascii?Q?rAP2mhRaXWM/6Tx1Vbd9S44Rvot5R4XMzv/+b/ssJfuyR7l+e7n0SFdr3mxe?=
 =?us-ascii?Q?rFf1wCAxWq6OKlnIZvWtIDyzH5DMqOzya8xz9saIJT/IgeJdgywy55onfgqd?=
 =?us-ascii?Q?wq6mIj2RzLy8H4zYstg3zeEQGxKyyDGD4ztzTR2RuCW2n/TTfcxUWx1e9VVv?=
 =?us-ascii?Q?Iz/Orf76g1DAWMvPAEjwKUXcdQ3sm22eY1m2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:36:44.8077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f8c3e6-1f67-42fb-7427-08dd8241fae2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

From: Jianbo Liu <jianbol@nvidia.com>

Previously the offload of the rule with header rewrite and mirror to
both internal and external destinations is skipped if the encap entry
is not valid. But it shouldn't because driver will try to offload it
again if neighbor is updated and encap entry is valid, to replace the
old FTE added for slow path. But the extra split attr doesn't exist at
that time as the process is skipped, driver then fails to offload it.
To fix this issue, remove the checking and continue the attr process
if encap entry is invalid.

Fixes: b11bde56246e ("net/mlx5e: TC, Offload rewrite and mirror to both internal and external dests")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 9ba99609999f..f1d908f61134 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1750,9 +1750,6 @@ extra_split_attr_dests_needed(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr
 	    !list_is_first(&attr->list, &flow->attrs))
 		return 0;
 
-	if (flow_flag_test(flow, SLOW))
-		return 0;
-
 	esw_attr = attr->esw_attr;
 	if (!esw_attr->split_count ||
 	    esw_attr->split_count == esw_attr->out_count - 1)
@@ -1766,7 +1763,7 @@ extra_split_attr_dests_needed(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr
 	for (i = esw_attr->split_count; i < esw_attr->out_count; i++) {
 		/* external dest with encap is considered as internal by firmware */
 		if (esw_attr->dests[i].vport == MLX5_VPORT_UPLINK &&
-		    !(esw_attr->dests[i].flags & MLX5_ESW_DEST_ENCAP_VALID))
+		    !(esw_attr->dests[i].flags & MLX5_ESW_DEST_ENCAP))
 			ext_dest = true;
 		else
 			int_dest = true;
-- 
2.34.1


