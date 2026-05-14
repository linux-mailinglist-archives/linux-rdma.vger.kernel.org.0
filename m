Return-Path: <linux-rdma+bounces-20686-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKh/GwOuBWrkZgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20686-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:12:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0479F540D61
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCA9C3028A93
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6534F3BFAF6;
	Thu, 14 May 2026 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wffw0W6W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76143BF69C;
	Thu, 14 May 2026 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778757098; cv=fail; b=RaRACojVcxeao7qYAPDJYtGfnZkhNgrsRi10Be0zt00D9EvCVoeqTbiYfZYGgPE5oe81I8OKbELV2ciRbXgPVFlHlkvDi/2OJ0Oqbi1uXe87EIEoE9moPXgjluUoRt6uy5YQIT8L6KpJahSVHwPG8uJVyvHfsriO0MF8XiFO8JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778757098; c=relaxed/simple;
	bh=h9lmcb+zqBYthVoW3dmHTWkZcO6PrOBwFbxCmbZKMvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgkPySAgmjk1zy2S54QJz040Rrz1sPvVagE97TUkCY6rYY3IWY83y0zhIgMCtijisMxuq+aWSVkbUEeSO6nFuGTlr2EkqhufeVhx3ATYRahCudqHwAOx6SLyXyGrgcf11ayV6vWrsn/y9nX5YBsbj5HZd6Uer8kFlVHBehIXRkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wffw0W6W; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvJ0TqnNzduD3iybgS1fosh6qUQ5actpUa4rz1NC9ubLJHrONtnDJBjs+PdsrjtdLGDmoM3SIj8VRLeKX494sRd/6N8Cs8tGLD2UPQO4UNBmuxPNP4rI2X0x0PoSS7xwP7Xl8TwyjdN2fZ3EOdo/77B2Drn7+JXSul3wZMpnZYv+m3nmktSCuxdvGMzCUAm7RHh5E83yTTlxj83iLjQfWY3amduRaFkdDnvXdfiGSHdfDunda5uuj+68fZBPUe+XzxQPMKkOS8H/CwCOOFcy3fwUBqqbpMO17u7Ex9FBE58Lmfqw0bFOmMcBmbhD+HaOjFLC1q9KDwj9RP3RPU+auQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gLSjPe0F34ZQ/twBAmhziASDQpOwQSq0k6Wqo3p8qk=;
 b=RJJxllj7/h0s03zl2ED4eYLBcMp7DwrwK9ny/pDw/dmUT+qiIQTzwf+Ywm/PaW9j1GBDQY5hibD7kjR3wwAfrTnnLKcWh3F1uY//XqCOFtJfJBMsbMaKesu2krLvQYg7XaHocnkzqdK66xLLc+b68/ax3Rg+pP4/9J76JK/ZSryQKxEy4EMnSu9Jd8riUkZMdrBr39PorDuwg8nTXG3nf/XDtpNuVzWsVcVXIckPSH9xrxv2hpru+J65i2vBMgEpXUXjYJq3INEENH96kMpUtU8+3LIhZOzHZO8k6srGn1P7JRFpoio07mnZDIozH1FfntkWCUHsAiqa8qc3HL0OYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gLSjPe0F34ZQ/twBAmhziASDQpOwQSq0k6Wqo3p8qk=;
 b=Wffw0W6WrCcFZO4zTMKcTxvQCyIL926SvdbBJcnw+KtUyoGVsSVLLn2NYGv3HFU5eV2Edz8KuPJlDB85MU6SV846ygg9LnFDjjAZCpdPCTJin6p8c4ATwsgjgpsYCR+kYk/PBeFRMc95zAfQpIz+jpg5JHQqTvnG+/q90Goi/Yw7l0FZUaHYotBTbvswyIvGZRfmAhu+spOmOddS+1pnTEU2Z40UN9SPl9iZiczanRRjtTOqSo2AZahNGDo3dpGUIRegBr331UMVeUs0sbMgRy73CdGiug99AtT6TkBbtr8MalRTd1h3XvL5/1+xkNyUIydGd/eZ+RTpIumCLILk8A==
Received: from SJ0PR05CA0203.namprd05.prod.outlook.com (2603:10b6:a03:330::28)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 11:11:26 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::a7) by SJ0PR05CA0203.outlook.office365.com
 (2603:10b6:a03:330::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.16 via Frontend Transport; Thu, 14
 May 2026 11:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 11:11:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 04:11:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 14 May 2026 04:11:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 14 May 2026 04:11:04 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Shahar Shitrit <shshitrit@nvidia.com>, William Tu
	<witu@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>, Kees Cook
	<kees@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 2/2] net/mlx5e: Let kTLS RX get async ICOSQ param in napi poll
Date: Thu, 14 May 2026 14:10:38 +0300
Message-ID: <20260514111038.338251-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260514111038.338251-1-tariqt@nvidia.com>
References: <20260514111038.338251-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 71baa17a-dc11-4eec-b2e3-08deb1a98a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	7Q0mAdN+um4iTjpX09StW7wtKhvsIlvGvQO1PyNXDM/COK/pjAv1l4db9d+B6ox8jtd35c65p1+oaXfaV0FR2wRdI6+bSkyWjMDARWtGgeysoi8rl/pRTEiOs4MsEblmmvjhOhxNZfYME+Sld+5kH77abKd2mNIny2D4qxD8TkYZhycNySkGPufYRMQJTIBLTvImRrYMmVP/sfmJnZttAUuyuwO00bXEQVGOOCk6OoT6rEYGGNdBc3OjRZgC4UPb1JAcXKKl8YWT+2TIITcuSw4ZOMj2x1NshoIj4zq1IOlZgah/gz7IUgLPJ0qo3X3IGSBFRNIIKJEqp0QEtOb91zef8zhq0KEmdNl/84CV7RF/1KNX0utCodZGLcdiGXlJUgkwkY0UXot9xH7p2FhLn46sOEUMTvohUheSZbc3nLPDUkmjpYowSvD2AJdFAjLEyIWwP9mV38ZU+UGYU0R2lvkgmaFbDtn3KxnUIiC4O7k3YR6uJ3CGCY3PZ+5F8oaBkp6CVAIN5A1pAovcySKBmfY3JReDc7V0RqKnMdxaqpZ+KLYR1f1eY65bk1mo4BJsTRVTRDF/UEloGXI8nxn4dsr0ylcajWUTjeLbEUwcfBqraHaOOuCieusVAL59lsbW8ja6Txv3G1UFgaDE52CFOSqES1xYGZpruiPVquRn73HdKZp3Jh1+Hk2bdeVWXgRBxf0z27HVE1zkQLKOCRY6+pr81gdsSBLaNQwmJDwhg4o=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l/PIydQMP7sDXLAtXCKb902rU9yRmsDjmJ1t9jNWnId4FWTVTmct0ulWryHRYxT/rILnTmqdwBYFmPc2iuayxjAzVEeaK9StDePT9K1HF7+4KBT2Dc1ZRelqwvq2dY+KDoGuO1tChKX2y+EvjuOHUdeWFl9cp479h7LwToSzc496yO3Mz+xi2Nx8gHBhlCAlGtPHD05OKmY9piRCkFMzqL7wXku4XOeTBXmepkGR0LX/ZARCeN3ybheCeM4P/lhApWYgqvVQ0Isy8JVAPOK9k5McPQDgCqS1RZuQsahvBQWAEX5sw8oMoZdmWXKTYQf/mHfRfkWj//EigSyAQDGPQEZARg/592gKXss1hTp/SGlH5CcMu1NLj7OUJ2UwZDEy0wQhmDIha/3/86JOOWfLRCqH1OyL3rv2JCUR/6sSwX1qTOp+4IRU3Fv/KKAEP6bu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:11:26.1840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71baa17a-dc11-4eec-b2e3-08deb1a98a5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
X-Rspamd-Queue-Id: 0479F540D61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,queasysnail.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20686-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Do not pass channel just to extract the async ICOSQ.
It's already extracted, pass it.

Re-order the checks in mlx5e_ktls_rx_pending_resync_list to optimize the
common flow.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c   |  5 +----
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h | 12 ++++++------
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c    |  5 +++--
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index ac8168ebb38c..bca45679e201 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -744,17 +744,14 @@ void mlx5e_ktls_del_rx(struct net_device *netdev, struct tls_context *tls_ctx)
 	mlx5e_ktls_priv_rx_put(priv_rx);
 }
 
-bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
+bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_icosq *sq, int budget)
 {
 	struct mlx5e_ktls_offload_context_rx *priv_rx, *tmp;
 	struct mlx5e_ktls_resync_resp *ktls_resync;
 	struct mlx5_wqe_ctrl_seg *db_cseg;
-	struct mlx5e_icosq *sq;
 	LIST_HEAD(local_list);
 	int i, j;
 
-	sq = c->async_icosq;
-
 	if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state)))
 		return false;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
index 4022c7e78a2e..93bd383a23d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
@@ -45,13 +45,13 @@ mlx5e_ktls_tx_try_handle_resync_dump_comp(struct mlx5e_txqsq *sq,
 	return false;
 }
 
-bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget);
+bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_icosq *sq, int budget);
 
 static inline bool
-mlx5e_ktls_rx_pending_resync_list(struct mlx5e_channel *c, int budget)
+mlx5e_ktls_rx_pending_resync_list(struct mlx5e_icosq *sq, int budget)
 {
-	return budget && test_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC,
-				  &c->async_icosq->state);
+	return test_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC, &sq->state) &&
+		budget;
 }
 
 static inline void
@@ -70,13 +70,13 @@ mlx5e_ktls_tx_try_handle_resync_dump_comp(struct mlx5e_txqsq *sq,
 }
 
 static inline bool
-mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
+mlx5e_ktls_rx_handle_resync_list(struct mlx5e_icosq *sq, int budget)
 {
 	return false;
 }
 
 static inline bool
-mlx5e_ktls_rx_pending_resync_list(struct mlx5e_channel *c, int budget)
+mlx5e_ktls_rx_pending_resync_list(struct mlx5e_icosq *sq, int budget)
 {
 	return false;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 8df5bc5d0537..143890af516a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -189,8 +189,9 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 				  &aicosq->state);
 
 		/* Keep after async ICOSQ CQ poll */
-		if (unlikely(mlx5e_ktls_rx_pending_resync_list(c, budget)))
-			busy |= mlx5e_ktls_rx_handle_resync_list(c, budget);
+		if (unlikely(mlx5e_ktls_rx_pending_resync_list(aicosq, budget)))
+			busy |= mlx5e_ktls_rx_handle_resync_list(aicosq,
+								 budget);
 
 		if (xsk_open) {
 			busy |= mlx5e_poll_xdpsq_cq(&xsksq->cq);
-- 
2.44.0


