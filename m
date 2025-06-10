Return-Path: <linux-rdma+bounces-11158-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE8DAD3CB4
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A71D189449E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7E24397B;
	Tue, 10 Jun 2025 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AfDIAQ3l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD323A564;
	Tue, 10 Jun 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568600; cv=fail; b=QGbg+mAPpAEiupiXJlA0riHlxF4JsLH2F6d+Uj8bMcxcqgU+MbAByHANVqN2gmT5bqaaUSyhEi2pbxROweDo79nJmGuKNc4gOyJDPmbaKA1ycVeMCp09Iofy0pb9Ue2LRVNuYZJHQKPKei/2dFk85HhyUoerufCYMyENHYJcgTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568600; c=relaxed/simple;
	bh=O/Q7yh26VkL2enrkoTFCG/FI5Fqy7ar0HP/asCuD+O8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKuQe1pUGpKBoydQBOQynjBAMFflbBIym9xbGVafZJin6MzbyqUs50+usswUwPXjMtWYNROzFIP7kzSTMEfK2OOKjb2Drr1bgD5i6g/Qf4rCQU9cl8f7dC935b9xmjHWK+qo+IQ1R9Gwt039iUmfVZwSwFzMjCl5ufIkoUgEzGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AfDIAQ3l; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVzzk2uwydLA/iXQ+SxoH5ml+7aZMnJa37w0yvgIeLMptFwuJxj4LJLnIcVt90COVkzxYXGPQq1eKGbZXaNy6hgfCqAt01w39TvXTfHajJ2/0IUSS7KCxbvhfdn4g6Om1aUY7zpBP9PUWJObDWhC8tXgbn2tWaIECVxT3vC3pXbWUjI2zWNSKS04eEE76Mbhu0SK1/VZYE1BAx31NCHH2KvKbS2qJQG8b1n4acNxHZorOr1avHIJRrEtRTCD89BkFEJGmeraIDDumrpLNL4fSgcE0lWvxDcqNIT44axRBHgOUap0dDGP9cAHJQ5iJutNjxqXXG62YrCztXhXdnUwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrfnFn433HFVkAN/Lt9eGRL3fwghIk6ERrPrHa0CSqc=;
 b=aPuOUsOcNU0PFxou8uFS0nSZRF3oFsPhBDYi+6GWTLW+39AvjgJub73Y4qLyJKjqZCFdPtlM/xcBUxocW4Evyz9zHCdSUwvAnhQpj/3bnSgYBWHP4/huq5zUmTYCCY+MxW8bMR1RmK5oTcxURGHkIeUQ2IENX9+V9DFnnI7KVmdILTMq38FB24K8LQDm7qhZG64Xc3zzPSlrkLG1dFS5tsmgzfvAVbCUZmmphHIHAFwdYtq5JtqwsBKlu3C6b5xW6NJFcfKqan3h9ioF0H5t6Qnyiiw9R1Pt+mnmiUVkHALoeK8uTkwuNeC0Ct8igfQMNc+GxoZmwiXQlApTbKWc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrfnFn433HFVkAN/Lt9eGRL3fwghIk6ERrPrHa0CSqc=;
 b=AfDIAQ3lyKUVw7S0/1666l5RyM/PTsXE+3v/wa2a6tk27vSLpfDSGhO9pony9KFY5+ejkqM1AJ2ITwi8+GuuDDKizn9dDYRnz4Ngy6OwcU8lDZMMn6FhphSkxl/CeJqtBYBgZzBj/2otc/8il5Nacr4EYi2yUXqwOJcTEkqY1bJ3jg63wU5TnTExLJAQnSY/OmvvzXkVvfXXS3ZxyQPlZWFLy2vUHMHqmWvHgh9VJRQneV5S3CEmTGTCYf9jZzHNGv4ueR43ArYb9kNbi3BLvNQsGxek+wqv1ZfcXdgNFU08aMOd2/uIknEA+oDXhWcZdzNO5HbP3Z+lzAJ1S1TpVw==
Received: from MW4PR04CA0142.namprd04.prod.outlook.com (2603:10b6:303:84::27)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 15:16:33 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::3e) by MW4PR04CA0142.outlook.office365.com
 (2603:10b6:303:84::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.23 via Frontend Transport; Tue,
 10 Jun 2025 15:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:16:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:16:11 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:16:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:16:06 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>, Alex Lazar
	<alazar@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 8/9] net/mlx5e: Fix leak of Geneve TLV option object
Date: Tue, 10 Jun 2025 18:15:13 +0300
Message-ID: <20250610151514.1094735-9-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610151514.1094735-1-mbloch@nvidia.com>
References: <20250610151514.1094735-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: a76df46c-cc32-4936-2672-08dda831c8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?39tbd5S9Jo2vPcetuHeAXFmo7pDxQ5YM/7t/m1+2oWlRrQkjyCuiWhElVC7t?=
 =?us-ascii?Q?1ZSZYqTBmUqk4fzcW8aZ1g6ixfzjWpyfrEGc7obxAVH8cYyqyhX0rJf2sZqo?=
 =?us-ascii?Q?07TCZuixl4XmySbVKhunugyC51rYlJGwfOAjYaI/uLH92uo8PbIO4sg2Np6H?=
 =?us-ascii?Q?elKfBQxoqsvYUP97+sh8+QJDCcKrNR1mCwDNa1paHt+LQ6o+GNCAwhP9NWU9?=
 =?us-ascii?Q?vA5xGxFU2jvtgtvGU2EhVofqXBNhnomppf+RKehKZoIMT53rc2pRRm83TJhq?=
 =?us-ascii?Q?ioAwOXCNbGsrMKjGZB/M80ocIl6E50urXgNPZ1z+ZPKis+rIbBH1Q99ndseJ?=
 =?us-ascii?Q?f2VE3kgak4Ef1IGCmrUsYAf2xr09CfxQ3fR1CdQf99uP4QfdHfFPwXBzM2Ky?=
 =?us-ascii?Q?dja1BxebIcdkMR/zonycQf+4Hpcs7fYz5rAEbsOLK98ryblHHaDHaubhOmBC?=
 =?us-ascii?Q?fe8MMYVv3sRZ8IOuuXzrnJp1gopa5mYg52CPQlgItNK5AALsLuSzx/XM4U1U?=
 =?us-ascii?Q?8p/55XU2J++Nhq4WnIq/ozYFMJzdZTpzC0pX7/UQ4RSTJdybc5WzjaUQ/6Id?=
 =?us-ascii?Q?ShDmNeN0gwHoDBI3i7tzwouS3srGHHddS2+e9v/AGJTeyaAaCw9bi1i9+J+m?=
 =?us-ascii?Q?L28xP0wSk/KY+RCDImWUSgR81iMdJk9VkzSdwQcQC2MExGksPPeowtaSNO2E?=
 =?us-ascii?Q?KTc1NI4RdF/tHxyNcNmTJ31/WKaXNVk/t7+ndLEGI6dh/SNWYfwKZ3w/HXSC?=
 =?us-ascii?Q?Vl05NpeON+vrEU9spAsx3iDe0HljCgnFcxlrxWREixaGbUWNK5qSvkxXOoyn?=
 =?us-ascii?Q?UxgNVn2LKIhyPTBlVXnlGavA27+GS4bP+h78/83oiMHuuqpT7ZO5VhKb3bxC?=
 =?us-ascii?Q?qcFdzYRxK34w2Eqrx30G3+2aJlE6Q/TGS8dF1nC3dDDvEjnOnMRw4xgevIpB?=
 =?us-ascii?Q?qBhY+V3BbAYSMphHQEV27JRXtHdlAmYWf8ExcmDFxZj9zNP4hlh4I2OmJC9c?=
 =?us-ascii?Q?QX/CDPJuu1CyfKtnjPMypP5SdwfgvRsWXmUBiNs+2kpofWx4SrQBMAXhUixG?=
 =?us-ascii?Q?C8XB2Jiw4fUB/sJmUgOet+lZNn1BUByrHpbGe0ow2WVnRhyHB7hnLFZybF2G?=
 =?us-ascii?Q?wxVPotWBr7Y0WIJstb7lQnq1uRWp120pfCui3ZHQO0FeKY0v/71upPe6Hyut?=
 =?us-ascii?Q?oknzXX6R3WQVd+zqiCclAhGocJt2fzxP+vnEKmx8YLt5RCpyzk7xtWObxMvB?=
 =?us-ascii?Q?kpRb2UoJQVURbfxbBpF+hCpDLtmf0K6dDfqcHtCtB5RWjv1AU3/P4InsGgMN?=
 =?us-ascii?Q?rdWq4cg0IQ4Ndtt0xp0eplnfq/GIOs0o3mxDnSaTquxtbEIcMpNssNUWdZEy?=
 =?us-ascii?Q?0X3USxdd5N4BtwCPACqpbpbvqdkU94s0Esvr7Wy/fU1yH3/NqiTiG1UKhx39?=
 =?us-ascii?Q?e7C+sp7nyXG7JdHxUgiFY9OjqVy4aUN+9YQd60VXaul7zyDm8x78OrE+HUYQ?=
 =?us-ascii?Q?ckKAF3U3+bCHQ0C+SbeoMAmDQPoMQin4yRmT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:16:33.1418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a76df46c-cc32-4936-2672-08dda831c8d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829

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
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Alex Lazar <alazar@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index f1d908f61134..fef418e1ed1a 100644
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
@@ -2574,12 +2573,13 @@ static int parse_tunnel_attr(struct mlx5e_priv *priv,
 
 		err = mlx5e_tc_tun_parse(filter_dev, priv, tmp_spec, f, match_level);
 		if (err) {
-			kvfree(tmp_spec);
 			NL_SET_ERR_MSG_MOD(extack, "Failed to parse tunnel attributes");
 			netdev_warn(priv->netdev, "Failed to parse tunnel attributes");
-			return err;
+		} else {
+			err = mlx5e_tc_set_attr_rx_tun(flow, tmp_spec);
 		}
-		err = mlx5e_tc_set_attr_rx_tun(flow, tmp_spec);
+		if (mlx5_flow_has_geneve_opt(tmp_spec))
+			mlx5_geneve_tlv_option_del(priv->mdev->geneve);
 		kvfree(tmp_spec);
 		if (err)
 			return err;
-- 
2.34.1


