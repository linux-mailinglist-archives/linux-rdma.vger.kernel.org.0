Return-Path: <linux-rdma+bounces-8833-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EF4A68E89
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 15:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC79426487
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 14:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B817A2FA;
	Wed, 19 Mar 2025 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n+Kk+Jyf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C441AB50D;
	Wed, 19 Mar 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393096; cv=fail; b=I56fukfc98wUUTAPzjhgjw2+Z2HbJdRlwMw+b1OnGTYSmIx6D8JdFD5pAQNYgE0C83kyY3A2iL1fGr8BG4wmc7FgM0hKszvA7NiRzhVH3Mkg08V/xZ5Y8QhZam3E0cKOcGWitPjo1Nha6AsJlCEajWlLmMvIW0oUdnzg6PxFKm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393096; c=relaxed/simple;
	bh=l1ypQainMJw2MMrz+i01B/v2yDcWfEBsl468IlNKcvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6dRJPYH51ZtwJXEJ8tAO+pF2qTgiRK2qQJ9eCQXZ3mqvqOeux5eJgKbEzDoVYtB2Kex2t99gR+oO08xkrJjBpFV4X/jB9nx9zl9MetMLH5eRmUII7XBtzKJlll+o8c1kAn4M3OavsM6B/heWgHLlkOtRNhskRB8ZWNQcdNHkiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n+Kk+Jyf; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/3Nk0NqK6fqY986AX/Y4sTahLK99sjGjdUw80t13He7VfKdKtmKBeaJIZZNSMpd2iJ0jgH/Avg4JD0U8LD8bM6FiUbw6c6gLQ10xE3ko1nMS9f+W/MPAkK4lyBcshpKXCNPXo6Ow3UTSvtGrr3PNhbc2L5bAFJQD7TG2AUwoVAwXjhiKdVd6vD0ZvAPcVhKo4nNJUJsmcKY3jSV7BLRlNVq/YXDqc5UvgG07eGT9hCteuxpD6AioWMpVyRmqJDFeI0OpSZSaT4cQM4Qd7NGKG3foaCIPMqht5TFZBpN3CUlkowfdk694Jup1EriMGgvlqw5t+saP+LzWcuhnCBAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+MVX7XUXbcEMJnN95WHYtRbr0bph15h6gAPOAIEGsw=;
 b=TixC6rR/e7Fj09jHDsA09HaoPy7IQCY+pM74tLnGo+hmmVDnL4gVy8JAj6NICNxuJTBG8auC6MqcypskvGEPd22VC302UwQZ0n6XbHR9u+2kWTxCnWgIJ8VSkY7e4qxe/74RphP/gWhsMXd0+/HF2dxWKlqXgn7dWA4gDnky6/jwLMcSwQxdDYLy8PxVpFjY/I8UkeI3nkAVjMD1Efdtd1t/wvH08ZUOL0V1k+isCUMg/jYVMfAHxQrxm0OaUShX4liOwP7K03dP/pLTxrAt4vPu1cHjYVeLuclbdevISbIpsb1osv5DHNV+oPKV4h1e1hnoZYmys67nWu+loRBSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+MVX7XUXbcEMJnN95WHYtRbr0bph15h6gAPOAIEGsw=;
 b=n+Kk+JyfNULeVlOw2gq2sNsouWJYPoBLAZ40jPTInaIO+i5PmMebZSK9/sLIuv25wEzCv9/nOhD/kLl6o5+3IiqeWgU64kUNqE+1cGc/3yv1vdHDK74QP3KGtPy5xekyb5Fff8Xfgi0cp4ahuz2iDBLRmbmnJNp7tKKhC+yFaEUuLdOCA8GxjEJKVTvtrXEnSGp5W4+77YAgEU8s7xAwijmbABFlIAJaMjYZgbYFGLNLIQXPxOdjAlLu1VjwNwUmhsSPTEixlHxaLc4zlQuwm4QNG6+KDBnSdRZLonwj6L92KXxl/SGwFjZ3WYAuenMvWSZugCiL2FaEmY+lAhrEFQ==
Received: from CY8PR11CA0005.namprd11.prod.outlook.com (2603:10b6:930:48::18)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 14:04:46 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::80) by CY8PR11CA0005.outlook.office365.com
 (2603:10b6:930:48::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.30 via Frontend Transport; Wed,
 19 Mar 2025 14:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 14:04:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 07:04:31 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 07:04:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 07:04:27 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH net-next 5/5] net/mlx5e: TC, Don't offload CT commit if it's the last action
Date: Wed, 19 Mar 2025 16:03:03 +0200
Message-ID: <1742392983-153050-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1742392983-153050-1-git-send-email-tariqt@nvidia.com>
References: <1742392983-153050-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8c6700-243e-4cd7-f78b-08dd66ef00ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nANyrNjQsE9eiA0qK2nQjvS4qTeJt0AD7alDHP1/E6j11aLWKFJqEIMWZnjD?=
 =?us-ascii?Q?qw2VzHBfzUnLViQrfJ4XcE58pMwC/Ag9QCSWvvPWQEi1R268wSNTV0BctFuc?=
 =?us-ascii?Q?zH/BQZlqt7vVeSNeF54SkvDqI9ps/fFNl9GnRsizAzqjpDMEEx0QfqAlwNFu?=
 =?us-ascii?Q?MNQzewUF3v6vBXqa9uWg45WoE55j57PNgQEJeXTeiIZNA6Nix6+E/Idbl6j+?=
 =?us-ascii?Q?ThLCoQFH5LG2Hlw+5pWWD4oB8XgWo2UuHBbLVZNbFu2iUl9AwNYmmzxN9p1C?=
 =?us-ascii?Q?obHSzgqMca6mZhk7q0SIJUYdkG3Ch4M3WgUmhAdJc3PAi5368NeZXZMurHQ8?=
 =?us-ascii?Q?qPsNTZ/nVoectIRawQD+TdAiFFqOsKGbjXMsqceYnvkHAixFlT7FwEYO5nMR?=
 =?us-ascii?Q?/ZrPcpijYXIN8P0qUd9+zF1BBJKaDx3MMCtHR4S0ri+BW3Ugkg3ZIQSFxQ/G?=
 =?us-ascii?Q?JQRFes2hQ1YtFUucgvRxLXGseLJma4qJpSxKO3ba3OSPnHMHvGBvNF32XP2W?=
 =?us-ascii?Q?i37cZlB177V9ngY8y42JD+P3qbAVIPjugvy1wiG38ucFoQoVg5RyFuFAbrDm?=
 =?us-ascii?Q?B1w+9qeSkjaIhZ16+iyuAW4gLPZTC5LMco4VG4AApWeDmpYueURPn6xYzgCQ?=
 =?us-ascii?Q?LeGHqW1ba+Eu8y29Ruo+xHYNajww558P7XXZa4xoGCFMBFO0BfDCwNvD1+DK?=
 =?us-ascii?Q?ZHCnfNrBlnrVUT89OjXUR/+YNf5F3Qosd4ey1qS/TRXbFUB3nxU2t9wTcaGe?=
 =?us-ascii?Q?66QaOLG5BFtQK6+iZSRELAyUDNw68cMPaeNNfOwomp037mPVvo9oZu5m0XxQ?=
 =?us-ascii?Q?dElt/UAbVEtLsyStMVsGZbGogc6LLNvGBhVTW8x/LDadlq1ibn5kkxH6woeU?=
 =?us-ascii?Q?41ZXZP6IAeB1pX6oaNoIkcxg2LGQo+Q4ZVl4YNXc6v2M5wjrhN1eVo55ojAm?=
 =?us-ascii?Q?mzEfYM6e37HOi7McM4lmRL3scJ1f5BESDHW/TUlMgLhuOfMDlS+DFGRFEpu3?=
 =?us-ascii?Q?IrJRdS+5D1Z85owOIPm+h3g+KR+oO0NlGqyX/E9qWpR2P8G7iqVpsBO6x3WR?=
 =?us-ascii?Q?MYN5KyODoCADmav4mjOrmfYxyiKdGtcVuEvlPc4OKSVoo57nCJH8vkbhINAx?=
 =?us-ascii?Q?CJiG2Tz8EPAd6D7ZgZO1CIt1OpCk3AUlL00ZUYOLTubn1DXhYwEGGsFSgXfB?=
 =?us-ascii?Q?9lgzbSgirL+U2Rb9RYQX1o3YmNBMS2qqTe6FAUhGF7EPGomBNJsqbmZvXIZZ?=
 =?us-ascii?Q?wfGtw0Bm1kPCNzrLzWoKG5bgSY9tq2aqHREyMedqBMNN6KaycKdPdsfk1o2s?=
 =?us-ascii?Q?i5rFy2Jua91xVc0G3OGl2XaGhblEEpm1OZvZjdO9DqB6OjDuvjuFZUP3krn+?=
 =?us-ascii?Q?jnaD1FZqtg93+XGii7vLaTrZrCkvX+TpFmk6AYlQYsDklu7yaWeY+q4HWiZh?=
 =?us-ascii?Q?rto1eLKsgLRsouxHKrdMQCMD1Y+ETeR25ORHBnRc4qWWKHGTCy1xjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:04:45.4796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8c6700-243e-4cd7-f78b-08dd66ef00ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648

From: Jianbo Liu <jianbol@nvidia.com>

For CT action with commit argument, it's usually followed by the
forward action, either to the output netdev or next chain. The default
behavior for software is to drop by setting action attribute to
TC_ACT_SHOT instead of TC_ACT_PIPE if it's the last action. But driver
can't handle it, so block the offload for such case.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c
index feeb41693c17..b6cabe829f19 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c
@@ -5,6 +5,16 @@
 #include "en/tc_priv.h"
 #include "en/tc_ct.h"
 
+static bool
+tc_act_can_offload_ct(struct mlx5e_tc_act_parse_state *parse_state,
+		      const struct flow_action_entry *act,
+		      int act_index,
+		      struct mlx5_flow_attr *attr)
+{
+	return !((act->ct.action & TCA_CT_ACT_COMMIT) &&
+		 flow_action_is_last_entry(parse_state->flow_action, act));
+}
+
 static int
 tc_act_parse_ct(struct mlx5e_tc_act_parse_state *parse_state,
 		const struct flow_action_entry *act,
@@ -56,6 +66,7 @@ tc_act_is_missable_ct(const struct flow_action_entry *act)
 }
 
 struct mlx5e_tc_act mlx5e_tc_act_ct = {
+	.can_offload = tc_act_can_offload_ct,
 	.parse_action = tc_act_parse_ct,
 	.post_parse = tc_act_post_parse_ct,
 	.is_multi_table_act = tc_act_is_multi_table_act_ct,
-- 
2.31.1


