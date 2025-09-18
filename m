Return-Path: <linux-rdma+bounces-13468-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCEBB834A9
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 09:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007E4465DAE
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 07:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E88A2EBBA2;
	Thu, 18 Sep 2025 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uiT2wcAX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBEB2E974E;
	Thu, 18 Sep 2025 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180010; cv=fail; b=gZ3K+O+q3nvm/Ge3UmSBZg93XIVFA2ck/Cr+31tARl84hf9p/UxsWQv91DfOKWqqX8Zzzoz1djxaY5bVLdO7+XOMdix4YtiQPBcAmA1sERcv8bLFrS8G58TS1/+ukFrXBfqGB7Bnbx6dDQTLC/gN5b9rkWw6ZtqYTdqn8XtwxbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180010; c=relaxed/simple;
	bh=tjFh298tE8OkXlcmmHiE1G10KXHl8ZhwIW61TouCE+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGd9dh3VAVQ7MgXrhR8UdG1RfQAq9f2kdOL+gE/eqYnuJv+8hxCjvwfm+Q28j3fHPiAqgXWQ6yVI08iinREBzV4O+L8k5jCGHECa1icUpL7sltKu8oj8E4aW0n77TlfjXDgq9E4s+iu8MyRj1ZF9eo+GqnGbsYBTfjVo1I3Lqis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uiT2wcAX; arc=fail smtp.client-ip=52.101.85.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgVJCI6IZfm96VZtmwACdC6CgELmYX5yHuwjktdlgOUBEL+pkH4DxtpP3KCpure1haESNImll5MgZ5udg5plfHgM9ROtOWny2KnO9sFlw1GfKm6ZducYZsZA2zlgZisk/aBe558TuF0xM+Al7GGY0m5PPonEyw0NfG2LsQDavcwvxgJ4qX2XckRK/lttV5Tuqe7n3Tah8O5kVUBQCzECR/TmDI6pWy2WQ+n+UWYU/ystvWJN4jK/HNry7Gx1GK7xjxrfDq+QMURIUmxFNMRYgvJ0PyW8w0yUWOP/h6pyQT3NyYbU4p4LwjhJXLuJRMwukviw9BVls/mIr5odWXVEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0pHy2PV0P2Bhkt3TsvzB4SpGUsQkNKnwzWkRJRPLUo=;
 b=OmOUs6ZStoqi8xcYiskeEdZmoyZALnhjkKJXv5S+CLxhxM2yJGbWoc8mb97C+FpvD/tQ3j8xTTpT3V44DKjVnYjUWZRNL+R8NeDESyT/Navl56kZOyxKMjeLzow+leZjH+aHBr/g/omXDir3eJ2GLGQkBgJTwEsZvHOL7Lyv+2v8Y/TtGbxcyr5iMI5TnrsvzpWaP+YadwkDTMHrpax/+vZewH53ofqchYgxznqO1Uq7jt034Wo7Kd/f4W/6ZHYNPj3HbjIJKzOx8+kmQnrs4jP5/v9eL/KDZSGyVRHf2iJf6bqpxPRxMupRT8B74wwYyvaRm6rUha8AbfMsVr7xfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0pHy2PV0P2Bhkt3TsvzB4SpGUsQkNKnwzWkRJRPLUo=;
 b=uiT2wcAXeNahinoVwowt1asdXnW8NrCHHVqKaPiXWtHEC679o2UfaBrAKJq/n9HaqvNTPrxfvwOcsj7Wc/qZtduYba2KH8bvJj4UCVukQ1Q8ETJjAzzddPOC55achf/rvvUgxw66nXfItCWuiYnz+/3M6j67KSOcM0rotys/0t65HGvYJNcDBMdICxFTf4U4mrRkToufqH0BPQuCrh9tVXOAOtEfinGXGzIyz+vN1xzMIQmglJqCLQL02ZxlzKd0V9bCO6DdH/q/b7y60Rg2vHFIfvafQErTLVJXf5dnlWD8/m+qGoptQuMlZcYSsvgZuUbcww2+3sW3n8EotJYghw==
Received: from MN2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:23a::12)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 07:20:05 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::84) by MN2PR03CA0007.outlook.office365.com
 (2603:10b6:208:23a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 07:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 07:20:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 00:19:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 00:19:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 18
 Sep 2025 00:19:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH net-next 1/4] net/mlx5: Change TTC rules to match on undecrypted ESP packets
Date: Thu, 18 Sep 2025 10:19:20 +0300
Message-ID: <1758179963-649455-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758179963-649455-1-git-send-email-tariqt@nvidia.com>
References: <1758179963-649455-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f497c32-b6bd-4dba-e6b6-08ddf683ca67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PGtv51oYYuhkudbZTOQACVdp4D2B23kOtHBka9MeSw/9naITN2bG+dk1mV7S?=
 =?us-ascii?Q?0R5oQv+HpSmCHhpJou5pL7qXLP8hIh1ImTzyX+NCjA/doS6uuDF6LzcFN2eN?=
 =?us-ascii?Q?ub/rtri9otIkDK+Gk6vM9eF2Qiu1yZl8yGvgonLGpR2gA4vtF3XFJgpU2Bkf?=
 =?us-ascii?Q?LcVVic9xoBV9isDh4FCbdie5NRmfi/AqyQvTCDptxi44FRu1f3aaFXU6ooUP?=
 =?us-ascii?Q?WjdbzaM2+RPsg7u9TRWV5Ze63tsjfqoXO6aB04i7P6k/oyCXltdKymTIdddv?=
 =?us-ascii?Q?0dr+PoGwJ94wLCYrTrIf++8rt9H3C/x9atwbHH+t2ITXwxaOu9kayvnzretC?=
 =?us-ascii?Q?B8vcev07N1rSEDES+S+OK0e0SfpuHI5FjEpUeE5gqnzSKozvOcLSV6Z+Nt1C?=
 =?us-ascii?Q?sZ2u6nivYroluiQoJ5Mm0qf/+s86zg2cBVCtpVqhqG+Pt+IzBR5coyXPTTW2?=
 =?us-ascii?Q?jg41GhHhcuUhwUeqEOOQ8HAcjwObtxMcleH11p1PvX0MJDKLZ+tREGWXwKPW?=
 =?us-ascii?Q?rP+00Yk8NDx3EmpgUYPSjAAELXNX3z4FyjulZENLX1In2rxUzeCqXOB0sGbq?=
 =?us-ascii?Q?XU60SSxUrUMi6JMxPTnVEVyZ7yiyMBwaAW4EyB4NLJM5MNYfApe38jt+fmAf?=
 =?us-ascii?Q?HKQEM2vkjArHpIaRMj3kAH79xCSsq32shCXXdYtgOs+pfBSWmpt3EGMg0ofk?=
 =?us-ascii?Q?gA6WJBpR0qYoGd3dclo1RgduN3hdvg5/O/pz8jzgSs7CPhjnGQjuU3XtVutQ?=
 =?us-ascii?Q?nf110uDP5bLPLxlImfjIiSgwFZDz9GnQzJkLyH6Dbha0piQhtl9KVSbH0AK4?=
 =?us-ascii?Q?R/C0mFOjmMwCIuTLw3kuXdFWnuC6y0903wYYzdNejy4v8ClOLjXDdYYwHVKn?=
 =?us-ascii?Q?wxzzUgi/BVQpuxojstyR4zp/ECsl6+YwPhZxXpZvwnUksGe7hjURlzBhird1?=
 =?us-ascii?Q?B0k90+opPBKm5yAhD10ASUa36DpVbzItKuF88iXc9dH3K5Bf0t+RbbmSo2Tm?=
 =?us-ascii?Q?UdQEwaHIneyM/k8hMEfMxDB+4braxWO5Tf6OMKhHmxy2tgTbyck/Wz1w7RLN?=
 =?us-ascii?Q?bTz3asLrmdPwcWOYmcsTDkoP0EN1651GAWg4GSHmBOA2qVB1xjSxjfvB1kx3?=
 =?us-ascii?Q?o5QlC3uB9eCcXcTRwLeY3kigK3E+2beHNwtd61lRVc0f1rvj+0jiwG3EtrvR?=
 =?us-ascii?Q?VBbWCU5fGpQ9MwBiHomhManVXrnqexXS6CdbEVitUvMWEzvX9oZwzIGmXLzu?=
 =?us-ascii?Q?bjJGtwPux8Uey9lGUpp2UORHB6SI44R2bS3tL791N6tC9hVo/vyFMuhv9hk3?=
 =?us-ascii?Q?qSu0DNig27r9xSMvUmVh4dHa2PswTpzwnfbC3E0PvpIbKKTw3G/kHKYFaXiC?=
 =?us-ascii?Q?y5Gxf2MDFuN1Uee+9l9PMmV2lq2Hi41kUgmKgVrvaH2T+hSx8l1q7puDYLll?=
 =?us-ascii?Q?eAmT3cOOTTuwQ0U/3PJKOEksekt0Is3O06A6CTQNZoVgM/ooMxbSN985fWA9?=
 =?us-ascii?Q?hu+CmOfGPLv4G63Es/6gIGj4JEmhTiLep7UU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:20:05.1515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f497c32-b6bd-4dba-e6b6-08ddf683ca67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

From: Jianbo Liu <jianbol@nvidia.com>

The TTC (Traffic Type Classifier) table classifies the traffic and
steers packet to TIRs, where RSS works based on the hash calculated
from the selected packet fields. For AH/ESP packets, SPI and IP
addresses are the fields used to calculate the hash value for RSS. So,
it's hard to distribute packets to different receiving queues as there
is usually only one SPI in that direction.

IPSec hardware offloads, crypto offload and full (packet) offload were
introduced later. For crypto offload, hardware does encryption,
decryption and authentication, kernel does the others. Kernel always
sends/receives formatted ESP packets with plaintext data instead of
the ciphertext data, all other fields are unmodified. For full
offload, hardware will take care of almost everything, kernel just
sends/receives packets without any IPSec headers.

Currently, all packets with ESP protocols are forwarded to IPSec
offload tables if IPSec rules are configured. In a downstream patch,
the decrypted packets will be recirculated to TTC table, in order to
use RSS, which does the hash on L4 fields after IPSec headers are
stripped by full offload. So those packets handled by crypto offload
must filtered out, as they still have the ESP headers, but apparently
no need to be decrypted again. To do that, ipsec_next_header is added
for the packet matching, as it is valid only after passing through
IPSec decryption.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |   8 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   2 +-
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.c  | 108 ++++++++++++++++--
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.h  |   3 +
 5 files changed, 109 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index 9560fcba643f..cdc813ae9f23 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -131,7 +131,8 @@ struct mlx5e_ptp_fs;
 
 void mlx5e_set_ttc_params(struct mlx5e_flow_steering *fs,
 			  struct mlx5e_rx_res *rx_res,
-			  struct ttc_params *ttc_params, bool tunnel);
+			  struct ttc_params *ttc_params, bool tunnel,
+			  bool ipsec_rss);
 
 void mlx5e_destroy_ttc_table(struct mlx5e_flow_steering *fs);
 int mlx5e_create_ttc_table(struct mlx5e_flow_steering  *fs,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 265c4ca85f7d..15ffb8e0d884 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -916,7 +916,8 @@ static void mlx5e_set_inner_ttc_params(struct mlx5e_flow_steering *fs,
 
 void mlx5e_set_ttc_params(struct mlx5e_flow_steering *fs,
 			  struct mlx5e_rx_res *rx_res,
-			  struct ttc_params *ttc_params, bool tunnel)
+			  struct ttc_params *ttc_params, bool tunnel,
+			  bool ipsec_rss)
 
 {
 	struct mlx5_flow_table_attr *ft_attr = &ttc_params->ft_attr;
@@ -927,6 +928,9 @@ void mlx5e_set_ttc_params(struct mlx5e_flow_steering *fs,
 	ft_attr->level = MLX5E_TTC_FT_LEVEL;
 	ft_attr->prio = MLX5E_NIC_PRIO;
 
+	ttc_params->ipsec_rss = ipsec_rss &&
+		MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(fs->mdev, ipsec_next_header);
+
 	for (tt = 0; tt < MLX5_NUM_TT; tt++) {
 		ttc_params->dests[tt].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
 		ttc_params->dests[tt].tir_num =
@@ -1293,7 +1297,7 @@ int mlx5e_create_ttc_table(struct mlx5e_flow_steering *fs,
 {
 	struct ttc_params ttc_params = {};
 
-	mlx5e_set_ttc_params(fs, rx_res, &ttc_params, true);
+	mlx5e_set_ttc_params(fs, rx_res, &ttc_params, true, true);
 	fs->ttc = mlx5_create_ttc_table(fs->mdev, &ttc_params);
 	return PTR_ERR_OR_ZERO(fs->ttc);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index b231e7855bca..7deb6a9b7f4a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -974,7 +974,7 @@ static int mlx5e_create_rep_ttc_table(struct mlx5e_priv *priv)
 						MLX5_FLOW_NAMESPACE_KERNEL), false);
 
 	/* The inner_ttc in the ttc params is intentionally not set */
-	mlx5e_set_ttc_params(priv->fs, priv->rx_res, &ttc_params, false);
+	mlx5e_set_ttc_params(priv->fs, priv->rx_res, &ttc_params, false, false);
 
 	if (rep->vport != MLX5_VPORT_UPLINK)
 		/* To give uplik rep TTC a lower level for chaining from root ft */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index ca9ecec358b2..850fff4548c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -9,7 +9,7 @@
 #include "mlx5_core.h"
 #include "lib/fs_ttc.h"
 
-#define MLX5_TTC_MAX_NUM_GROUPS		4
+#define MLX5_TTC_MAX_NUM_GROUPS		5
 #define MLX5_TTC_GROUP_TCPUDP_SIZE	(MLX5_TT_IPV6_UDP + 1)
 
 struct mlx5_fs_ttc_groups {
@@ -31,6 +31,7 @@ static int mlx5_fs_ttc_table_size(const struct mlx5_fs_ttc_groups *groups)
 /* L3/L4 traffic type classifier */
 struct mlx5_ttc_table {
 	int num_groups;
+	const struct mlx5_fs_ttc_groups *groups;
 	struct mlx5_flow_table *t;
 	struct mlx5_flow_group **g;
 	struct mlx5_ttc_rule rules[MLX5_NUM_TT];
@@ -163,6 +164,8 @@ static struct mlx5_etype_proto ttc_tunnel_rules[] = {
 enum TTC_GROUP_TYPE {
 	TTC_GROUPS_DEFAULT = 0,
 	TTC_GROUPS_USE_L4_TYPE = 1,
+	TTC_GROUPS_DEFAULT_ESP = 2,
+	TTC_GROUPS_USE_L4_TYPE_ESP = 3,
 };
 
 static const struct mlx5_fs_ttc_groups ttc_groups[] = {
@@ -184,6 +187,27 @@ static const struct mlx5_fs_ttc_groups ttc_groups[] = {
 			BIT(0),
 		},
 	},
+	[TTC_GROUPS_DEFAULT_ESP] = {
+		.num_groups = 4,
+		.group_size = {
+			MLX5_TTC_GROUP_TCPUDP_SIZE + BIT(1) +
+			MLX5_NUM_TUNNEL_TT,
+			BIT(1), /* ESP */
+			BIT(1),
+			BIT(0),
+		},
+	},
+	[TTC_GROUPS_USE_L4_TYPE_ESP] = {
+		.use_l4_type = true,
+		.num_groups = 5,
+		.group_size = {
+			MLX5_TTC_GROUP_TCPUDP_SIZE,
+			BIT(1) + MLX5_NUM_TUNNEL_TT,
+			BIT(1), /* ESP */
+			BIT(1),
+			BIT(0),
+		},
+	},
 };
 
 static const struct mlx5_fs_ttc_groups inner_ttc_groups[] = {
@@ -207,6 +231,23 @@ static const struct mlx5_fs_ttc_groups inner_ttc_groups[] = {
 	},
 };
 
+static const struct mlx5_fs_ttc_groups *
+mlx5_ttc_get_fs_groups(bool use_l4_type, bool ipsec_rss)
+{
+	if (!ipsec_rss)
+		return use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
+				     &ttc_groups[TTC_GROUPS_DEFAULT];
+
+	return use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE_ESP] :
+			     &ttc_groups[TTC_GROUPS_DEFAULT_ESP];
+}
+
+bool mlx5_ttc_has_esp_flow_group(struct mlx5_ttc_table *ttc)
+{
+	return ttc->groups == &ttc_groups[TTC_GROUPS_DEFAULT_ESP] ||
+	       ttc->groups == &ttc_groups[TTC_GROUPS_USE_L4_TYPE_ESP];
+}
+
 u8 mlx5_get_proto_by_tunnel_type(enum mlx5_tunnel_types tt)
 {
 	return ttc_tunnel_rules[tt].proto;
@@ -279,7 +320,7 @@ static void mlx5_fs_ttc_set_match_proto(void *headers_c, void *headers_v,
 static struct mlx5_flow_handle *
 mlx5_generate_ttc_rule(struct mlx5_core_dev *dev, struct mlx5_flow_table *ft,
 		       struct mlx5_flow_destination *dest, u16 etype, u8 proto,
-		       bool use_l4_type)
+		       bool use_l4_type, bool ipsec_rss)
 {
 	int match_ipv_outer =
 		MLX5_CAP_FLOWTABLE_NIC_RX(dev,
@@ -316,6 +357,14 @@ mlx5_generate_ttc_rule(struct mlx5_core_dev *dev, struct mlx5_flow_table *ft,
 		MLX5_SET(fte_match_param, spec->match_value, outer_headers.ethertype, etype);
 	}
 
+	if (ipsec_rss && proto == IPPROTO_ESP) {
+		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+				 misc_parameters_2.ipsec_next_header);
+		MLX5_SET(fte_match_param, spec->match_value,
+			 misc_parameters_2.ipsec_next_header, 0);
+		spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_2;
+	}
+
 	rule = mlx5_add_flow_rules(ft, spec, &flow_act, dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
@@ -347,7 +396,8 @@ static int mlx5_generate_ttc_table_rules(struct mlx5_core_dev *dev,
 		rule->rule = mlx5_generate_ttc_rule(dev, ft, &params->dests[tt],
 						    ttc_rules[tt].etype,
 						    ttc_rules[tt].proto,
-						    use_l4_type);
+						    use_l4_type,
+						    params->ipsec_rss);
 		if (IS_ERR(rule->rule)) {
 			err = PTR_ERR(rule->rule);
 			rule->rule = NULL;
@@ -370,7 +420,7 @@ static int mlx5_generate_ttc_table_rules(struct mlx5_core_dev *dev,
 						    &params->tunnel_dests[tt],
 						    ttc_tunnel_rules[tt].etype,
 						    ttc_tunnel_rules[tt].proto,
-						    use_l4_type);
+						    use_l4_type, false);
 		if (IS_ERR(trules[tt])) {
 			err = PTR_ERR(trules[tt]);
 			trules[tt] = NULL;
@@ -385,10 +435,38 @@ static int mlx5_generate_ttc_table_rules(struct mlx5_core_dev *dev,
 	return err;
 }
 
+static int mlx5_create_ttc_table_ipsec_groups(struct mlx5_ttc_table *ttc,
+					      u32 *in, int *next_ix)
+{
+	u8 *mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
+	const struct mlx5_fs_ttc_groups *groups = ttc->groups;
+	int ix = *next_ix;
+
+	/* undecrypted ESP group */
+	MLX5_SET_CFG(in, match_criteria_enable,
+		     MLX5_MATCH_OUTER_HEADERS | MLX5_MATCH_MISC_PARAMETERS_2);
+	MLX5_SET_TO_ONES(fte_match_param, mc,
+			 misc_parameters_2.ipsec_next_header);
+	MLX5_SET_CFG(in, start_flow_index, ix);
+	ix += groups->group_size[ttc->num_groups];
+	MLX5_SET_CFG(in, end_flow_index, ix - 1);
+	ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
+	if (IS_ERR(ttc->g[ttc->num_groups]))
+		goto err;
+	ttc->num_groups++;
+
+	*next_ix = ix;
+
+	return 0;
+
+err:
+	return PTR_ERR(ttc->g[ttc->num_groups]);
+}
+
 static int mlx5_create_ttc_table_groups(struct mlx5_ttc_table *ttc,
-					bool use_ipv,
-					const struct mlx5_fs_ttc_groups *groups)
+					bool use_ipv)
 {
+	const struct mlx5_fs_ttc_groups *groups = ttc->groups;
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	int ix = 0;
 	u32 *in;
@@ -436,8 +514,18 @@ static int mlx5_create_ttc_table_groups(struct mlx5_ttc_table *ttc,
 		goto err;
 	ttc->num_groups++;
 
+	if (mlx5_ttc_has_esp_flow_group(ttc)) {
+		err = mlx5_create_ttc_table_ipsec_groups(ttc, in, &ix);
+		if (err)
+			goto err;
+
+		MLX5_SET(fte_match_param, mc,
+			 misc_parameters_2.ipsec_next_header, 0);
+	}
+
 	/* L3 Group */
 	MLX5_SET(fte_match_param, mc, outer_headers.ip_protocol, 0);
+	MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
 	MLX5_SET_CFG(in, start_flow_index, ix);
 	ix += groups->group_size[ttc->num_groups];
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
@@ -709,7 +797,6 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 	bool match_ipv_outer =
 		MLX5_CAP_FLOWTABLE_NIC_RX(dev,
 					  ft_field_support.outer_ip_version);
-	const struct mlx5_fs_ttc_groups *groups;
 	struct mlx5_flow_namespace *ns;
 	struct mlx5_ttc_table *ttc;
 	bool use_l4_type;
@@ -738,11 +825,10 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
-	groups = use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
-			       &ttc_groups[TTC_GROUPS_DEFAULT];
+	ttc->groups = mlx5_ttc_get_fs_groups(use_l4_type, params->ipsec_rss);
 
 	WARN_ON_ONCE(params->ft_attr.max_fte);
-	params->ft_attr.max_fte = mlx5_fs_ttc_table_size(groups);
+	params->ft_attr.max_fte = mlx5_fs_ttc_table_size(ttc->groups);
 	ttc->t = mlx5_create_flow_table(ns, &params->ft_attr);
 	if (IS_ERR(ttc->t)) {
 		err = PTR_ERR(ttc->t);
@@ -750,7 +836,7 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 		return ERR_PTR(err);
 	}
 
-	err = mlx5_create_ttc_table_groups(ttc, match_ipv_outer, groups);
+	err = mlx5_create_ttc_table_groups(ttc, match_ipv_outer);
 	if (err)
 		goto destroy_ft;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
index ab9434fe3ae6..aead62441550 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
@@ -47,6 +47,7 @@ struct ttc_params {
 	bool   inner_ttc;
 	DECLARE_BITMAP(ignore_tunnel_dests, MLX5_NUM_TUNNEL_TT);
 	struct mlx5_flow_destination tunnel_dests[MLX5_NUM_TUNNEL_TT];
+	bool ipsec_rss;
 };
 
 const char *mlx5_ttc_get_name(enum mlx5_traffic_types tt);
@@ -70,4 +71,6 @@ int mlx5_ttc_fwd_default_dest(struct mlx5_ttc_table *ttc,
 bool mlx5_tunnel_inner_ft_supported(struct mlx5_core_dev *mdev);
 u8 mlx5_get_proto_by_tunnel_type(enum mlx5_tunnel_types tt);
 
+bool mlx5_ttc_has_esp_flow_group(struct mlx5_ttc_table *ttc);
+
 #endif /* __MLX5_FS_TTC_H__ */
-- 
2.31.1


