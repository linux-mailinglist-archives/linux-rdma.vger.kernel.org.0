Return-Path: <linux-rdma+bounces-11458-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C110AE0474
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6531764CD
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BC6230BEC;
	Thu, 19 Jun 2025 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tUFEITg4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CFF23D283;
	Thu, 19 Jun 2025 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334149; cv=fail; b=RNvdYuAV56Rj9yt9kuF+E+o+jgpad2UDyo8AGhjPUUjt6Dq9pdB2OL8CCe3D8tmVg8dxZ5Ecv1tO7+tJ4vpvWa+qB6FjhDAlbxbX05CWgotJPyp+bwK96YcqxXjy/yXYa+hpBJdZW7zpSsCxkdrgimgCaiAIypte1uQ0SaQ8OMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334149; c=relaxed/simple;
	bh=DibSIbI8HLsQymoapnXudBUCniAhkrKZ8pM5Z0z3sMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ia7JbyZMRWmb61yoqquV3uh3r3GAPUONNCn3bw8Oz85s5i1JmJwPzARUrJoEBoS0wLKfGhIFbwQXM3ANHBaMJq0cwR4DSZ+3176wilkenUvryxcRC8RnpT1ShoWLwPesoJI78lOgEJUIKzJwwT9189K6oHfcJrzUO28JvYh0QjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tUFEITg4; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9tOSE71OepN2yIbS7jRg/yiqUnsXG44Xd5kV2OZZr9LPT4D995wnYoPyDQnWx80Q1dv3yC0a5cHESPSDrvPMjTYLpQTLu1JVDI8NXpKRWskZuEwL3XKmnrf1NOez3jeW4LVXUXnJmUX4g1tW5VGGyciWT289rYns+d88gCiYXGNrFmdF5V+9NgeklEl/YMPKSJLOn5N6SLPga6aa+f4Jxu4kA730Y5GuBWTMpSjI7tf/Tul7qcdqsvBaO82tMD82UTirgUFoqedh22tzgYRT6yadqSokW9GEZArvLsjr/DAmnMcsRt0xpcyVjlW2YvHGPq3dQofF0xZJQIbbJaofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGSuM9ON+IMEMr8dQbykz3O3D+cru0yBQ/8i28o6LXA=;
 b=V9xbb3HR/ncBZvYAuNoNa4HdMUgunbamDJyAxA5tvM+nk3Jwmdlx3OBXgASBC5nsKc4fJbj6fF8VzrTtPgSvpGN3HQpKm6mikW9gINdP9kXGB8WaqMJVjJX/lLuTXtrkNuTHEaDKNny54ao/ynQuwQ9D+ibVkYyxZAjquEh1kKkFahr+/6oRcpKniW0SHD8ZZ9IdFc7TR1TAM+1CiwtEPy8B4aAm1/Fs+4aFugvq6toSIO0qGCu8Zs/SPclGYdYCF9f2THpaDTblThnvpASzUr6W5iad5nL8xqEBOPvW1pt7e1UsScsqXFBHdhPgqEatemH7natpW6HT6jtT+KafLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGSuM9ON+IMEMr8dQbykz3O3D+cru0yBQ/8i28o6LXA=;
 b=tUFEITg4gXTx7FcmQaEZfEavisXiJkMSkzW/d/IDPofNiZ9UBchwM1F5re3TURtHCmmErpHseEdKgyGsVvJ8IallYal3ZKUjsQo2bvcpxeqztCiXpkbJetfY/HZodirruhA8eWZReVr4CVkcmHHKhp0jGgNxVwwlq6Iiyli3DBw7uColLpcxpuinHBzmn87WqYltKRryErpPgij6jdXSlQ/Q9KZv4S2IIA31rUck6DgwJNyNlI/h5gJWeHRmfpUUSDdT8/mUfccQD6JbIDQDvV7PezsAJUbmHgWPdy69tT2HnyeEHaTdqwgSkeB3a1SpaOPSAeCFKTZmDSmuyx57aQ==
Received: from BYAPR07CA0033.namprd07.prod.outlook.com (2603:10b6:a02:bc::46)
 by PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 11:55:44 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::1) by BYAPR07CA0033.outlook.office365.com
 (2603:10b6:a02:bc::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.34 via Frontend Transport; Thu,
 19 Jun 2025 11:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:55:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:55:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:55:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:55:37 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 3/8] net/mlx5: HWS, Refactor and export rule skip logic
Date: Thu, 19 Jun 2025 14:55:17 +0300
Message-ID: <20250619115522.68469-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619115522.68469-1-mbloch@nvidia.com>
References: <20250619115522.68469-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 212af4bf-bdca-4e77-ec97-08ddaf283907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?thupbgD+eddhT/GEvAMBNDxv8uR9C/0V/+jXfHdFJt3zbZ9MvEsfdz05P7+s?=
 =?us-ascii?Q?UH2O2FbOwiGF0RVs02XkgqZF+Yt8C1jKCzYZKaAIH3IaeilwkI0mDjtfPLd9?=
 =?us-ascii?Q?mSQG0v/2CBZPAtIK3EIPZZZWPFhli27wI5bpyyYtscDggd47RlVAUDLBLivg?=
 =?us-ascii?Q?JuPpkOOeW7S+PHPF0g9dI8Ux8+q/eFMlpSIlIGZjlPDuI9E5u7MQWCy4GyRS?=
 =?us-ascii?Q?KHF0jgF+eUsI/xQrUTkFxU6k3QD91nH+CSZq47Rvg7HDeTQQFmWx4r2i5098?=
 =?us-ascii?Q?vHkCbhsp/5HCRGItLScdOkqnmlwOyB1QpCySe8cRc4++OMtg1n1zGa207PxX?=
 =?us-ascii?Q?pZMPkWFvy1FeljCMr+w9C7jpveQBQ37ssf3JFDlkfjxCjOoqndKrUUVo8l0h?=
 =?us-ascii?Q?ytCITcz046+/avBsiEenhkaeIGr1psiP75ioO8QemnLA+MofuUvmUDsOg80J?=
 =?us-ascii?Q?EgmerAs32Y6z/9zWaQ6f70ab5tPTEmJiLtbc3UR+B22E+gZyEboOuy/ynLji?=
 =?us-ascii?Q?ZH/8y19qqVb02ysxYlTKvSB/bDUB5d4eJpTUQdz1O0HAEHdSQlnHVybHNRDA?=
 =?us-ascii?Q?6LmE5qjsGwVxYh7DBHfjwQpm8Pi+vvok93LrT8aZskPsUyrJ287vd2T+/eCG?=
 =?us-ascii?Q?VVVZm5xa++ka3Wok54ecYLNeLKil/kuKWhSh+aCQ3VqvIOZPUyXtzukXDZZ8?=
 =?us-ascii?Q?ETenMLOCinB8iF2CD48NCzRZ0nHxV11wFhko+fXbxSjHODCoEHh5Zy2B/60Q?=
 =?us-ascii?Q?KY8sCQhu21YUaTyz+RZVgnsUCRuLE6mq7hDLh8ibinx7du7KebqdTR19d41Y?=
 =?us-ascii?Q?A4zib8fPJ+PJE25JKW9VY0ENH9tcnPS00eRKHqVeMF5FIqvgmnxMRiLSbi2I?=
 =?us-ascii?Q?yS33aFcvU1vI/t005xa1sEcCaeQFsjrla4JRgYOpz5TCwFrmPtSRqsyMTGJi?=
 =?us-ascii?Q?l/+5k6bDmFnJLmU158GyOyGjZ2nb6xK8jnQdanZKpstgKkqDb8muW7u2Vx5x?=
 =?us-ascii?Q?ZmDM0NPmwr2pSiRPOhUKJZX6x+ezHexqgjeXUYqYTkhCjKtswgCM5NNoHJn7?=
 =?us-ascii?Q?99NVrW86jRKmzbi7ZA1DvhrcynZgi3rzQf/VcWp1NqXHuP67gbptWh/jReoZ?=
 =?us-ascii?Q?m5VHSUh7J/c0nzF9sqZHpGFZHdosFqIFMEICzkLsMg3eamxaRULGE42u8xIK?=
 =?us-ascii?Q?2evDcUMBShHD16v64bYkbzLE36XpDKJR7ptw2bCUpjrEsYsXHG/wQS4ewLxU?=
 =?us-ascii?Q?J9sd5Die/wOVwEd+hYF0h2xDwpkUvZpRUSu+0Rom4ZA+2BwWtjFjd4BlQ/Ve?=
 =?us-ascii?Q?41D7wUmWfo3oOSDDYXV8zVafF5ToMtzU7pFhTIbmWwCgQQDqdmvOf5yo3Faw?=
 =?us-ascii?Q?qSnTQYtj5v3zqJOVUrvVqoXoct9w0V6e/94pwTPWsg79XoJ2GN2SQKAhTMNJ?=
 =?us-ascii?Q?ZQ2O5ax/mZmvoSwvHKKvPvGX+/jGGFHEpD17zMF+OCyjenTEm8Nfhjm0Pahf?=
 =?us-ascii?Q?WN0ebk8bv7Ixk/1eGIjRRAsLd5ojnfL0WhDp?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:55:44.6479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 212af4bf-bdca-4e77-ec97-08ddaf283907
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429

From: Vlad Dogaru <vdogaru@nvidia.com>

The bwc layer will use `mlx5hws_rule_skip` to keep track of numbers of
RX and TX rules individually, so export this function for future usage.

While we're in there, reduce nesting by adding a couple of early return
statements.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/rule.c    | 35 ++++++++++---------
 .../mellanox/mlx5/core/steering/hws/rule.h    |  3 ++
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
index 5342a4cc7194..0370b9b87d4e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
@@ -3,10 +3,8 @@
 
 #include "internal.h"
 
-static void hws_rule_skip(struct mlx5hws_matcher *matcher,
-			  struct mlx5hws_match_template *mt,
-			  u32 flow_source,
-			  bool *skip_rx, bool *skip_tx)
+void mlx5hws_rule_skip(struct mlx5hws_matcher *matcher, u32 flow_source,
+		       bool *skip_rx, bool *skip_tx)
 {
 	/* By default FDB rules are added to both RX and TX */
 	*skip_rx = false;
@@ -14,20 +12,22 @@ static void hws_rule_skip(struct mlx5hws_matcher *matcher,
 
 	if (flow_source == MLX5_FLOW_CONTEXT_FLOW_SOURCE_LOCAL_VPORT) {
 		*skip_rx = true;
-	} else if (flow_source == MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK) {
+		return;
+	}
+
+	if (flow_source == MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK) {
 		*skip_tx = true;
-	} else {
-		/* If no flow source was set for current rule,
-		 * check for flow source in matcher attributes.
-		 */
-		if (matcher->attr.optimize_flow_src) {
-			*skip_tx =
-				matcher->attr.optimize_flow_src == MLX5HWS_MATCHER_FLOW_SRC_WIRE;
-			*skip_rx =
-				matcher->attr.optimize_flow_src == MLX5HWS_MATCHER_FLOW_SRC_VPORT;
-			return;
-		}
+		return;
 	}
+
+	/* If no flow source was set for the rule, check for flow source in
+	 * matcher attributes.
+	 */
+	if (matcher->attr.optimize_flow_src == MLX5HWS_MATCHER_FLOW_SRC_WIRE)
+		*skip_tx = true;
+	else if (matcher->attr.optimize_flow_src ==
+		 MLX5HWS_MATCHER_FLOW_SRC_VPORT)
+		*skip_rx = true;
 }
 
 static void
@@ -66,7 +66,8 @@ static void hws_rule_init_dep_wqe(struct mlx5hws_send_ring_dep_wqe *dep_wqe,
 				attr->rule_idx : 0;
 
 	if (tbl->type == MLX5HWS_TABLE_TYPE_FDB) {
-		hws_rule_skip(matcher, mt, attr->flow_source, &skip_rx, &skip_tx);
+		mlx5hws_rule_skip(matcher, attr->flow_source, &skip_rx,
+				  &skip_tx);
 
 		if (!skip_rx) {
 			dep_wqe->rtc_0 = matcher->match_ste.rtc_0_id;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
index 1c47a9c11572..d0f082b8dbf5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
@@ -69,6 +69,9 @@ struct mlx5hws_rule {
 			   */
 };
 
+void mlx5hws_rule_skip(struct mlx5hws_matcher *matcher, u32 flow_source,
+		       bool *skip_rx, bool *skip_tx);
+
 void mlx5hws_rule_free_action_ste(struct mlx5hws_action_ste_chunk *action_ste);
 
 int mlx5hws_rule_move_hws_remove(struct mlx5hws_rule *rule,
-- 
2.34.1


