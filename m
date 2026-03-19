Return-Path: <linux-rdma+bounces-18389-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLSbEWusu2ngmQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18389-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:57:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E21212C7909
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 118E2321FF3F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 07:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5753A4F58;
	Thu, 19 Mar 2026 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X8lN6mfl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E403A4F54;
	Thu, 19 Mar 2026 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906755; cv=fail; b=ZCIa8At2B6S9789p0Dldpk//MklUVTCmklqHfeZCVsgA8AI2QIKoFJJ3wD2AW0fjH2SxROfDyWwIVccaJYRQixurES5MZe0a2heaVXviKLpVmRgiyYCOosfbZhiT4IIjgzbCAFgYFunUzXSxr+JyBxxkzBBFDW6lv4PYtpv2/+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906755; c=relaxed/simple;
	bh=2fTe8TrsTGdCuIMoErRPgfCwIdC6qLq6iPm3ZRYx3bU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+7dVwDdbIvYzjRNHRd83tbW6prf60ZlOESfBv7pd+z0SWFIfOSluePjIYmJoAvZL0vsWkDSiyhZ7gBSh+TdMPk9NDObT7tL2jMVCtaHrw+AE171g12L/s8JmGcPa8eSmk6HEfiQB9N0HzUmb/hZZb7pxmawvRKRH0EBeqsnltM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X8lN6mfl; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzeE6q75yZ5Z7e7Sklyvnf1xWfWL686rD9petSmXUVR98/kgizOSS1aq9xdi6hurbjmhCF4iJ6BfaSTuWwSAZqsA9JYVu9golFO6o5vs3sR5XxgbXv0AIiaDADp+C2jkAzAPxjUoPuzjhw62uuwvIfZYdLYLJPIMLyBAZj2WEPEdhJNi9CoEFNeqIsZd11ulsuGmzsdQr34wFZPTjtsnbyGcvukjQse+aO5YcRX8o23W+ot5nWZ/P5f6wUIXcYPevEYezHdte+4syY6qdpGoO7TDhuZ6sRMpulwgQlsRphwPX3Tof72i7ygadVkvYLt5XnUAeaaZFmkdNitAiF4NUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9odjKWsBdg7zE15C+ZNqySS3HsX3kzffTh195/L39A=;
 b=yOOEV8gvkwQE7SmKR8JJ0CFH4+e0V/6c6qmL74licu0VZtNxRhn1hjbEMGrnuyiaC81EUTNUeKiYwzbGmVCpi+JKy7LO+wXQBub1pSJ1gN1Pu3ZdV8Bs5xMGLqhnRig6Ju5y7dAf/G5el9JkhY5KQU4d3GuGUb6go8m+mGNbpVtSPGxrInR/y++P0KSkCmWUPhjyQUkCcgg0C/KHHXIH37NjB7SJlhkMRVvXPgeP4O5q0g+zCiO5tt4q8Y4gWRnivobbwnAPCnncdh0m4/RVSfBAqw74oeRYLLXtGPaK3Lj3qf2+22Rsc/kw7tnLvuHHOHpJw30fJOW6AKn0vcGIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9odjKWsBdg7zE15C+ZNqySS3HsX3kzffTh195/L39A=;
 b=X8lN6mflQsak2vUShnQooWonROT2wZRX1ZDdeauobSjS9HtDSmo6d/WYWhAt6iKBeu2YbvKSlCEDZSQvIeFOJ4SMylba7X4zwvQbdYJpVqrcLOfpAPZj4E68UORICyjcrTJQWpnWYgInGCKKRF/krNE9CjbwtIf933sFIIKVFBDcbcvkv3HNAMKjdlo2SQA3+EGDY+DRGzfnfE3tGfm+LXvBSvo5u3xP5uq3ZhcNDcKRJlmDsBSagOgokE8jfBFfvaJXQt5+Mv2kERNqKrI6q7QvfKLh1YfWnf2TUnZvf3NXB51Np/eewZKXj/NGC7qP/YNa0E9G/NBOTY86zZ6jRg==
Received: from BY5PR20CA0008.namprd20.prod.outlook.com (2603:10b6:a03:1f4::21)
 by BN3PR12MB9569.namprd12.prod.outlook.com (2603:10b6:408:2ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 07:52:27 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::8a) by BY5PR20CA0008.outlook.office365.com
 (2603:10b6:a03:1f4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 07:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 07:52:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:52:07 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:52:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 19
 Mar 2026 00:52:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH net-next 4/5] net/mlx5e: XDP, Use a single linear page per rq
Date: Thu, 19 Mar 2026 09:50:35 +0200
Message-ID: <20260319075036.24734-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260319075036.24734-1-tariqt@nvidia.com>
References: <20260319075036.24734-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|BN3PR12MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: cefe1482-87a9-42d5-e1e7-08de858c7738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2BmqucMXswTGSJ4+4sqOmSK6DhsvSiLOrYZkPlkcABYBjytCQzOc6fLSBk0EY2BOKtkQd5pPYJtPINoAawL3xXsCwH9Vd3mTmWwEC9OAPfZdoZJig2EIgW60Drt3ZvPkZ4q3N8g5zYZo1jT9V3qUbV2LiNlNsxvaMQcsEa4fXymBOhbXZrMtWiwYmXKQqfhaGCUO3dvgpCpd499WU3j7Ro4grQEryfVPalG9vJSrr00Z0rlZUVLnKAvo3HivJdKF5mYiDeV4oZmHotNNupJ+su8JDtr1ZLL1tmTMBbB31FcVFYF7ikKeeHDqNwiiA2MhbROOiF310hlC9gfoEN5CbHGevEJOnOeJ9TXtEk6kD6kmkyjY0dDkKJ7lroci2zVf86d9awzZFDp0gV4xAMCwcVRO/f1nzJvQiXt/8AZ6uRrEK7Ex+x11lx/kwuEXrd7oq1gwI52Yh2q/QIoN0iLb0Uu89oRsjPi/FOKdLE/Td1Z6tzW0ZheTk8qcGLcp9hdw+vKx1cPknAl0hnvXpzdURG6sLZpzXlGAX22qJa97qMN8hq/TCJO5eMKOnRok3xczCyhmenMPUMWz6Fz8MskfxeDiUFKACR0v6r7L0zJeQ6JXmAlyPMZyDcTF7jge6GYIhj5evVuH25Ci7B868f8O8btEz1qEDSWI/N8HaHmOaWHQ7CtQTC3S1S38ZtGXeMiiojw66gJ87Bwm8JWXUeL/WlLVoxVRDRen3VzyyugpqkAzxkZAKV/EfxPfVxL9B6GKeUJ+dvZcCS0yCb3ZTT+kVw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+3Y0MnE6YPMfDnXuJi7sE3CKPnZDVOQS6K28GpdjOxBMtYg7udwZ0nKwaVdpbc5hvZOedcO3o6FnsZE/E8J9FusjoFOn1zau4Yfxda7qlbYmNHvxPzldQD7aBElbMvFlUJ8AbHWd4Wzq32vG/Sqrl/WRnifroIeCnruoDBnRBzy3W8jQzFnRzDAZC2vdW4FzWcO+VLKSLmZJtfIodUsu/Ky/SCrESdUUKcIukz/Tf4QM5CFfb2/aYe3mnAJueFIoN40Rlvit8i620GUFvQDa/cF1OI/Bvv0Z8sa8IAOFIdkraUTU7+QS96Cgh3fPL37T8aMqGoMRiJ5BOO4Onukn+fC72XYJx8/haq2S/dmvx7pfkB+zis9ITnQ8f2xF2gDA9LcTh9WZ+uwM8RPajbcjkhR0A9mph1MSXmVhETEaAq2lC1b4mtDxjz4UGwZmgKaW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:52:27.4040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cefe1482-87a9-42d5-e1e7-08de858c7738
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9569
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18389-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.938];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E21212C7909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dragos Tatulea <dtatulea@nvidia.com>

Currently in striding rq there is one mlx5e_frag_page member per WQE for
the linear page. This linear page is used only in XDP multi-buffer mode.
This is wasteful because only one linear page is needed per rq: the page
gets refreshed on every packet, regardless of WQE. Furthermore, it is
not needed in other modes (non-XDP, XDP single-buffer).

This change moves the linear page into its own structure (struct
mlx5_mpw_linear_info) and allocates it only when necessary.

A special structure is created because an upcoming patch will extend
this structure to support fragmentation of the linear page.

This patch has no functional changes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  6 ++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 37 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 17 +++++----
 3 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index c7ac6ebe8290..592234780f2b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -591,10 +591,13 @@ union mlx5e_alloc_units {
 struct mlx5e_mpw_info {
 	u16 consumed_strides;
 	DECLARE_BITMAP(skip_release_bitmap, MLX5_MPWRQ_MAX_PAGES_PER_WQE);
-	struct mlx5e_frag_page linear_page;
 	union mlx5e_alloc_units alloc_units;
 };
 
+struct mlx5e_mpw_linear_info {
+	struct mlx5e_frag_page frag_page;
+};
+
 #define MLX5E_MAX_RX_FRAGS 4
 
 struct mlx5e_rq;
@@ -689,6 +692,7 @@ struct mlx5e_rq {
 			u8                     umr_wqebbs;
 			u8                     mtts_per_wqe;
 			u8                     umr_mode;
+			struct mlx5e_mpw_linear_info *linear_info;
 			struct mlx5e_shampo_hd *shampo;
 		} mpwqe;
 	};
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f7009da94f0b..8b3c82f6f038 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -369,6 +369,29 @@ static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
 	return 0;
 }
 
+static int mlx5e_rq_alloc_mpwqe_linear_info(struct mlx5e_rq *rq, int node,
+					    struct mlx5e_params *params,
+					    struct mlx5e_rq_opt_param *rqo,
+					    u32 *pool_size)
+{
+	struct mlx5_core_dev *mdev = rq->mdev;
+	struct mlx5e_mpw_linear_info *li;
+
+	if (mlx5e_rx_mpwqe_is_linear_skb(mdev, params, rqo) ||
+	    !params->xdp_prog)
+		return 0;
+
+	li = kvzalloc_node(sizeof(*li), GFP_KERNEL, node);
+	if (!li)
+		return -ENOMEM;
+
+	rq->mpwqe.linear_info = li;
+
+	/* additional page per packet for the linear part */
+	*pool_size *= 2;
+
+	return 0;
+}
 
 static u8 mlx5e_mpwrq_access_mode(enum mlx5e_mpwrq_umr_mode umr_mode)
 {
@@ -915,10 +938,6 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 			mlx5e_mpwqe_get_log_rq_size(mdev, params, rqo);
 		pool_order = rq->mpwqe.page_shift - PAGE_SHIFT;
 
-		if (!mlx5e_rx_mpwqe_is_linear_skb(mdev, params, rqo) &&
-		    params->xdp_prog)
-			pool_size *= 2; /* additional page per packet for the linear part */
-
 		rq->mpwqe.log_stride_sz =
 				mlx5e_mpwqe_get_log_stride_size(mdev, params,
 								rqo);
@@ -936,10 +955,15 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		if (err)
 			goto err_rq_mkey;
 
-		err = mlx5_rq_shampo_alloc(mdev, params, rq_param, rq, node);
+		err = mlx5e_rq_alloc_mpwqe_linear_info(rq, node, params, rqo,
+						       &pool_size);
 		if (err)
 			goto err_free_mpwqe_info;
 
+		err = mlx5_rq_shampo_alloc(mdev, params, rq_param, rq, node);
+		if (err)
+			goto err_free_mpwqe_linear_info;
+
 		break;
 	default: /* MLX5_WQ_TYPE_CYCLIC */
 		err = mlx5_wq_cyc_create(mdev, &rq_param->wq, rqc_wq,
@@ -1054,6 +1078,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 	switch (rq->wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
 		mlx5e_rq_free_shampo(rq);
+err_free_mpwqe_linear_info:
+		kvfree(rq->mpwqe.linear_info);
 err_free_mpwqe_info:
 		kvfree(rq->mpwqe.info);
 err_rq_mkey:
@@ -1081,6 +1107,7 @@ static void mlx5e_free_rq(struct mlx5e_rq *rq)
 	switch (rq->wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
 		mlx5e_rq_free_shampo(rq);
+		kvfree(rq->mpwqe.linear_info);
 		kvfree(rq->mpwqe.info);
 		mlx5_core_destroy_mkey(rq->mdev, be32_to_cpu(rq->mpwqe.umr_mkey_be));
 		mlx5e_free_mpwqe_rq_drop_page(rq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index f5c0e2a0ada9..feb042d84b8e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1869,6 +1869,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
 	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
+	struct mlx5e_frag_page *linear_page = NULL;
 	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 	u32 page_size = BIT(rq->mpwqe.page_shift);
 	u32 frag_offset    = head_offset;
@@ -1897,13 +1898,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	if (prog) {
 		/* area for bpf_xdp_[store|load]_bytes */
 		net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);
+
+		linear_page = &rq->mpwqe.linear_info->frag_page;
 		if (unlikely(mlx5e_page_alloc_fragmented(rq->page_pool,
-							 &wi->linear_page))) {
+							 linear_page))) {
 			rq->stats->buff_alloc_err++;
 			return NULL;
 		}
 
-		va = netmem_address(wi->linear_page.netmem);
+		va = netmem_address(linear_page->netmem);
 		net_prefetchw(va); /* xdp_frame data area */
 		linear_hr = XDP_PACKET_HEADROOM;
 		linear_data_len = 0;
@@ -1966,10 +1969,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 				for (pfp = head_page; pfp < frag_page; pfp++)
 					pfp->frags++;
 
-				wi->linear_page.frags++;
+				linear_page->frags++;
 			}
 			mlx5e_page_release_fragmented(rq->page_pool,
-						      &wi->linear_page);
+						      linear_page);
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
@@ -1988,13 +1991,13 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq->page_pool,
-						      &wi->linear_page);
+						      linear_page);
 			return NULL;
 		}
 
 		skb_mark_for_recycle(skb);
-		wi->linear_page.frags++;
-		mlx5e_page_release_fragmented(rq->page_pool, &wi->linear_page);
+		linear_page->frags++;
+		mlx5e_page_release_fragmented(rq->page_pool, linear_page);
 
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
-- 
2.44.0


