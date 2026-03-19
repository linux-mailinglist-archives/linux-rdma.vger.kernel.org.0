Return-Path: <linux-rdma+bounces-18386-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMzeNuKru2ngmQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18386-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:55:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE3E2C78CB
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 781EA31EA306
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 07:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724C53A5446;
	Thu, 19 Mar 2026 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LZX9SNcr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BA93A5441;
	Thu, 19 Mar 2026 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906737; cv=fail; b=TpYlNL7NuAc+PocFxYhpwC8v7tQOS7uSJj1thP/Kta6igSrLZEXNPoqgEqV4eCrRzCxxJrS6/Dw794IE6btLWQl1nLhN9pwjCMpGrHr/TbVBL3AjflrfM9/HAHSac/gjaw16UhigGW3gr65Bz7mSWPWR0GkG/upjx2pMTfmVgFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906737; c=relaxed/simple;
	bh=3cLzeTQz+axIu9ibQmftIIT703GC8m4rlrkRn9/aDJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1H+ujtPRm4R1GgFZhN7JvD6toLpQVa/RGBjnzcWKWUfPeH6CuQpGslkvGI0k3OPXKhQy8kQge2FrNi1PDLBTKqAjdVZi3mFoTihvWIsRhFFfFHAHa5PHTBLjwJBSJFU421PIWE+vIqeN/hbsd73JOL0fI+gQ8A7c39lHzQ0/i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LZX9SNcr; arc=fail smtp.client-ip=40.107.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hb4t2xfmavOhbTxzlQW54qFBDDxcG320b4CXu/FTvzcqaHrcwRrJLTmXWVVW0nHwM7iawLS2ZMv39A+zQDRUxP/OsfNhpJiaIyoMnu7qzqPGtKqWDGwGbQD7Aoc5oHmDbIT7YRO+xDv5q5cHB59sHIJTGMlCPiyGPgItJ+EmQGzOKWzo+B0u36Zg0DTIHqaPpY1GUubfIF5ruN41GN8IN4TgvaQZYwCg0b4ZARdcsaW/PzoPqsP7swJdt/NC3eWFu3dtNchs4KeSVZlw8yQ3dRM38b2mK2kE/SAzGGAm3Rf8u6ULyHx2/iAxpZAjtGsbWolTpKvtXAnQkRSgp7m+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+qONcD78g1HSL0+uIWC1etG7mC+rtyWlq1dGoNUnGo=;
 b=pZOYEeWB1cuKiy/qZx/72WDlO9mRggWFC/suJlMA+mBi4F99O9ndgfD3CD5i56/YJfAFT/eAR7GxOGybuYK29zSJmZbdxzrMz61IniBKeTfeishaqaYh+3gNtCc1jypDmHFCUnkgCvJK9R6rrr4RvwAmu0aiFyH9npp/1tbzXFYR/d5q38rKZKm9aF3/CNxT/pwk1SJyWutGAmC28iG1oQ5wFkJU/5AVg5ReleotTaYAFlsjgOiI31CkSl/JsAh+oRNrU9wHE4KKre1QiRYYmzq0UhJNlue11Hffn+HXg2I3F57A3oG79/G/plSQTQCtNvNl+zuKpLXoAE6EG+0qyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+qONcD78g1HSL0+uIWC1etG7mC+rtyWlq1dGoNUnGo=;
 b=LZX9SNcrTxA8El1i2OoQekspDTDDM+3pjxQyNsNP/kJinvw8Thaa7wAE7hqmLuB/CEkqROWJtDj38RQJpnLQsGuXNEgyXP1olKTRN0aw+dtNlabHHvPvl/LhxXwv384HEGubP44smglOvgxx6rYzfXqHbc02iMGvjfgY7UxU0DYsBo8CVh1HbAkWRKpjdCe1SsxHJs8kZliQ5RDefFhXCuVS2HTT/mhS+vjwTo2VojtLee7GKELlZE4dPGlyMhucM66DzbfuTch91/Ow40zzkhpNP6Wcc6UT1r3dvmmV4YZhn+/13ovVV8dxq2SBDqg0v+wkhuqG2ZudTooPTn2t9Q==
Received: from CH5PR03CA0009.namprd03.prod.outlook.com (2603:10b6:610:1f1::22)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:52:11 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::e2) by CH5PR03CA0009.outlook.office365.com
 (2603:10b6:610:1f1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 07:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 07:52:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:51:56 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:51:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 19
 Mar 2026 00:51:49 -0700
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
Subject: [PATCH net-next 2/5] net/mlx5e: XDP, Improve dma address calculation of linear part for XDP_TX
Date: Thu, 19 Mar 2026 09:50:33 +0200
Message-ID: <20260319075036.24734-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bbc28d-422e-4ffe-7a91-08de858c6dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WA+JeGMZUHXmAC0RcLwlEhCgwc/02Yot83ONTdzXcQNu2Yt96X2HC0uWciHggZRPh19IXW/bLI4UeeK2vLoDX1vv2+TY+/4UHvfovU3ITgED5wpzZt64a7i0e3PkILNWruKEcAn9XXgSr/yv67gcr1lb5co1kHe+edM52AXF2P2nC0pgdzBfXO8tK0J+Ky5BvCH2YSc6clhfCOOMYGeuz48o+cA849UVedBg6iqd6xRG65/YjhBLJbFZsYrjI8AFq1kFmQjR8D/IWAxDEfQC06g6O5JclzHv6cZZ2b3jNwP6oIBYFzxpNcFZZafyBhGcuVK3zpEuTEvEAvPe+rHzU/thcY+XkhDE8JaHlObU/Aj+WDAhNH6DhuLPvGZ0+/06HswxpOaoZULaTQ8q9O+phzcQ0Rp+KH4w8fljRtleJcysPtk4IxyMPOWQJZCfxERgsEXQT/OPzHc3dY2kDPffT9REajz2cwQQYBFH3+yHe5k+fgA9rTfLeTVBun+otVO6YR7SMYfRHxkmmYam92tZez17KiGUtVUrobNkZ8cK7uh6kf306dQ8fIjzGUKcH7g8GvZQNdm1yRVd8pt6ZxYcHDhtX4rBIxnbVw/A8RKfvd8Knu4+7+B6sw/0RXO5H0WeOEzTbSUWYO8T03pt19bok1JTxsTLYkgAtlO9RqVo+5jUeoAC9HJ1IeYId+obNtiyE+tjKAqilUHKxHymZefFKzW7mAbeYzfjEAiePXjtfw2BjxPJ+Mfti9gr9Q+mejeFb0DzZuiyAiqaEsjENwfFrQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BPCl5eNf3omxsSce9PevLJfoisIOcvfys4YYLhVSiwpFcnedslccRvADGijvRx3q9Zt9KMcBmNJQLLLDM27bidX4Rrp+utAYjLgB7tTKdOmdmmrR8LFwKzn7tVrJzdO5U+OPlXURHpLcKk5MN7PHk1Ev4U9AyjX58ktDEJI+qQ+DUCMGFH5oX/D99IXvs3c5mwkW5R9W7p0kpYQAd4V1B89E3L7PQc1KFhrFnKWW3bUE3ZfLgrnt3MzmPUFAHbp0Lkx1EuDRKPM1rgg2WgOhpIAGpj2u6A6JBFg8Lq2tzuGqscV/zjwVV/r++8VfjSA36VuZfvGZEP0ydBqdjmkwx+2QSr5w5woHygv7jEWUlmbLonAnssq5Zq1nBzF47DD3Y2PbqLrjCDq35vqOOddrknhlfRHxicfuHeI62vkygFssF+5iO8RBOSL6zOkxKFhr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:52:11.4581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bbc28d-422e-4ffe-7a91-08de858c6dbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18386-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.940];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7FE3E2C78CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dragos Tatulea <dtatulea@nvidia.com>

When calculating the dma address of the linear part of an XDP frame, the
formula assumes that there is a single XDP buffer per page. Extend the
formula to allow multiple XDP buffers per page by calculating the data
offset in the page.

This is a preparation for the upcoming removal of a single XDP buffer
per page limitation when the formula will no longer be correct.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 04e1b5fa4825..d3bab198c99c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -123,7 +123,7 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 	 * mode.
 	 */
 
-	dma_addr = page_pool_get_dma_addr(page) + (xdpf->data - (void *)xdpf);
+	dma_addr = page_pool_get_dma_addr(page) + offset_in_page(xdpf->data);
 	dma_sync_single_for_device(sq->pdev, dma_addr, xdptxd->len, DMA_BIDIRECTIONAL);
 
 	if (xdptxd->has_frags) {
-- 
2.44.0


