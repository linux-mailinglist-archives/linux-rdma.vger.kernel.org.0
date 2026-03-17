Return-Path: <linux-rdma+bounces-18245-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGceFecyuWnsuQEAu9opvQ
	(envelope-from <linux-rdma+bounces-18245-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:54:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD02B2A8513
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 299EA301F4B2
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE636F409;
	Tue, 17 Mar 2026 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RiwnAgxL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B91279DB3;
	Tue, 17 Mar 2026 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744620; cv=fail; b=S/I5Ljlnh+G3Jnuxk78F3zGgdlym1ImiB2np+ZQkSBXCvktzj05ke6IyfJA+4BydRjT5HFyyxBIFLzooFOYnq5Bo4uh9hbreGkuDeQ9igYE4+rzhPaSV1npmr5/02fZZoPakQ8qFHHO4gAei/7fd2uTxh0njQravBnjTWcpuZXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744620; c=relaxed/simple;
	bh=KZUv3vEQPuYqhZ6wGevEQ3rc7xII35n/PZ/KNQxnC+U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ka/wPreRB1khmH4hBE+GH3Upml5ZEuUtlgDjdn7M66hoFLloevT6SvtgTyynWeCZZRQbeixU8gssHe1YFATylJkYLlQuRYMBOSdYFd5RJYMMD5sY8NLPYeC6pL33Vk7Jf+zopBKDri4P54z5CDbF4k81O8YJlgFGoZft1kNAnWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RiwnAgxL; arc=fail smtp.client-ip=52.101.85.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I//n9EQjBmkAoVzgFfcq5a9fcIbuVQrsEbPpJvGfaCgqQwgb0NUIK3gFqQJY2p3iC/+f3sitR/hcMJ5IbGuDLnTlkra3g3U9NcyqNpCm4tAgV/Dku13d40Q1Q37zFEbUfdUrC/yGQdUKoaMmdhW44KzLKPKINlRWuWTzFNzCR+eq4ufhPLqqkYBXftdkx/jScgCozTlN4+5cDuCuPDSni4SAzjBQ3a35e9FwHLRZMyQSkL3005OdrTduzKqLX58yWuZwKLizuqsT5/aBJp+EPh6BQJgp6RmnRjO+U33iaLpSaubj7u+ODJWMRvZGgDz36tr7A+FcS0CStLM+VTpuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeIwEJPIP5oduuKI6YB/DjYwUm+5fjA1b9ma0q1vIas=;
 b=IZfN7Eu+DkcFeFzj6EmE1IvFEGok3w4qCWwV5QW4Qo6Z3T6U5kOqSismF9AkwKJF4bZKrILVqI+ax/ozRK9WH7l9dLiah9G3/W3Pp75A8dBloC3zfOKVCexszCfCmYBi/pq/eWI0rZhptTISOPXJOQnmkRBYhO6WJFT8KrZLl2I6erqKFbQ3ByQsskX1QQ9MikQQmcXH+3RrduAFGEjK9RpcvT+0ngISgwjzAkuVldleMw+/pl6zQpN6UWR0tr0ZzUVeBkEMI/uECJrfo4XDXW/RSleoa1kReileEq6D+75LEPHY+93A5kQiss4JTt+LZTQ5ftxdTwq9dhiFhBgJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeIwEJPIP5oduuKI6YB/DjYwUm+5fjA1b9ma0q1vIas=;
 b=RiwnAgxLooLd3CfmqamUGjz+H8xjE3qdJgMXpxKH1h9+Jvhdc/ub6VLqJYjLzBLqd8J9b/rd6atY3NzHS/BpQ+dhkxkclvemPR2AVL3VMrv0MI0OFM68hlg/h2cDeNurH2xi87UEqgBrbqFhpQmba+U1F+3syLa3rxzPc2qKMrix32EEHDrfbk2MuphtUKFM8qbAOvlmJLrCg7cxVhsWLLOFUVeOfWtfkGG4EeHpKC/XkyxNRdedDxm+U451jQSmghd2hz+VjFksLOemQf+3BrHxnxYr5bteWqw1lYemwDbE87pIwpj8Vr3BNWRDGVqlfgckd2Tb2jEQ/w1D++j4Qw==
Received: from SA1PR02CA0010.namprd02.prod.outlook.com (2603:10b6:806:2cf::16)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Tue, 17 Mar
 2026 10:50:13 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:2cf:cafe::a6) by SA1PR02CA0010.outlook.office365.com
 (2603:10b6:806:2cf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 10:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 10:50:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 03:50:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Mar 2026 03:50:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 03:49:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next] net/mlx5e: Add hds-thresh query support via ethtool
Date: Tue, 17 Mar 2026 12:49:34 +0200
Message-ID: <20260317104934.16124-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 54086903-9a92-42f4-d3db-08de8412f7e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ispzQ5kFkacEvv616FUiMco7HHGZuyW/9lRgoGoduktVlbcKCVA9dJfExH/+nTgMjDsimFzVGCUU3DHAY6/BFKOgnAu7KwV0gsGzU7mT6W7qyZFgUm6bFBvsMklFh/BVK0diu7Mro2OuYjzr+J5pbvrz4hceLsmJnTOM3XEXc0dblj3Qcig1bgUQP0vEm7sAX4My24kOn/Iu33PPbdEFVnG3jwmeIiX6YlAVNGj22ru6em8iuBpjyHLI0ukvGOZwWfiTOFlLYo+M2q4x0ZEyywMOmvHazvpvDFeT1B85kmqIMCWOcpl4d+s/UsckvDylJsIfmVcC4wGfSPyj95G2tN3xrW4c+CJZ7jB/SpkJGkXe1YiDEOw/RViUIBz23GN8z51xdQ/Ddqfv5D3O32psDv91U602p9zmdDISXENAsrRj3DvHoa6aul4bdcUjj7uWNqwPQ8PnkEbddKvCWPaJS6DMt+NWwaHNNF/2Uyr0jybPmfwbi2EEcMTZn1jGbMkFjZDz0Lg8qRKps7AGazz1C2E63lusWWcVzRC01Ph349AQLKTwHxhi1B2DFRC66JDiRupwxDMyjOx7wxiKbMsjb3i3G18+qAyEkaAq8BNrY+Aqf/RvzmOYQknR3alcyqYKJ1qvafA/WSJy1+3Gwhw2W8NKs5IhfiNB6v1RnrJsevCiH3OooW5iVkzaIaQLq8ifrr/BkGkBvIbk0Kv/XRgWCrXHZ4Xdrn7/5E3YWt9TXCJ+x5x7Z1+Be3W8v6GN51y9LAw4OwGCl/JEyRQLBkJ3Og==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3MXmkX/E3xImWMmzuVdAT7L8lb8dRLSGFBV+pyweFfaxf+amRxnGeqJJqJ+tlllOYSynbkyR44cWoejzXygHPjFWUl9rzmLBdMaponelNGb6FFQfqB06wlaVRQ5a6j3wUhlhXcEeKy9xe8SmgDDimgUZ4vVHXMxgFebWPtQt18EOZFCk7j3TIUE02/1M0yv+loB+4QTWk5GgvCVbft3lgFUBF4qwSrpSP3VMEmYBvABKjltlQUNxojUMqPJuGNL+Mfa7LQLLs2bH6n0RuwOV0spQOW7+ydRtYc1p2w7jcHNlf9HwZLUXFyUkxJScwatDkpYGBh1hL7bMCnXy00qO5r09r0mbhitjT1KAXF/lSwtTOGv1biYmFae7XUp+qjvU+tdYgD8a6CHEynlCQJXaip+57pK9H59cs2GBeMsxPLCSy3eyk3P01H7aU29RSj4k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 10:50:13.5404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54086903-9a92-42f4-d3db-08de8412f7e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18245-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CD02B2A8513
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nimrod Oren <noren@nvidia.com>

Add support for reporting HDS (Header-Data Split) threshold via
ethtool. When applicable, mlx5 hardware splits packets of all sizes with
no configurable threshold, so report both hds-thresh and hds-thresh-max
as 0 (i.e. always split regardless of size).

Signed-off-by: Nimrod Oren <noren@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 4a8dc85d5924..bb61e2179078 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -371,6 +371,9 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
 	param->tx_max_pending = 1 << MLX5E_PARAMS_MAXIMUM_LOG_SQ_SIZE;
 	param->rx_pending     = 1 << priv->channels.params.log_rq_mtu_frames;
 	param->tx_pending     = 1 << priv->channels.params.log_sq_size;
+
+	kernel_param->hds_thresh = 0;
+	kernel_param->hds_thresh_max = 0;
 }
 
 static void mlx5e_get_ringparam(struct net_device *dev,
@@ -2735,7 +2738,8 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_USE_CQE,
 	.supported_input_xfrm = RXH_XFRM_SYM_OR_XOR,
-	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
+	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+				 ETHTOOL_RING_USE_HDS_THRS,
 	.get_drvinfo       = mlx5e_get_drvinfo,
 	.get_link          = ethtool_op_get_link,
 	.get_link_ext_state  = mlx5e_get_link_ext_state,

base-commit: 348baefbb635cbb448e154f38c93657d4cf23936
-- 
2.44.0


