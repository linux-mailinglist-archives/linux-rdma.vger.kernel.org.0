Return-Path: <linux-rdma+bounces-11650-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4714CAE9531
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 07:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A921C258DD
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 05:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F10217F55;
	Thu, 26 Jun 2025 05:31:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D23122154D;
	Thu, 26 Jun 2025 05:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750915912; cv=none; b=DUE2uLEw652Km6k7ZmNVFV+/7JmRWnS30CpkAbU0Vl8hwQcCv06Ju6TyYmb3+3kne59z6ZY3i1CE7a16DJYHvqjAj+ntuKOgr5T8yBGHXdSWqSsG5d54lsOpeYN70F2BO5tqHi7ZEdXqstkOfyJ4LzeXbHZGOKip/rOv8/n8SSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750915912; c=relaxed/simple;
	bh=vdSUFQeeyIJ89RhCHlWCFkrSHUMQ2p4GRKCblLQVHaw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fX2TvI015a65iblhO95LISyDIZ1+rCRjmRP6nMSRQZTRSBYwhMcGErmFEDYamn6h3OHWL4Ohz19wBwtzSKBxUpgikj32W++7si7nyeMH8mgXBudOtmrGtzSJ8+gWqY6Prr/5ijW54ADv+Hx16tTRWNDtAP8US5KshRm8oQRhdYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <saeedm@nvidia.com>, <tariqt@nvidia.com>, <leon@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>, Zhu
 Yanjun <yanjun.zhu@linux.dev>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next v2] net/mlx5e: Fix error handling in RQ memory model registration
Date: Thu, 26 Jun 2025 13:30:03 +0800
Message-ID: <20250626053003.45807-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc3.internal.baidu.com (172.31.3.13) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

Currently when xdp_rxq_info_reg_mem_model() fails in the XSK path, the
error handling incorrectly jumps to err_destroy_page_pool. While this
may not cause errors, we should make it jump to the correct location.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Acked-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index dca5ca51a470..e8e5b347f9b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -952,6 +952,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 	if (xsk) {
 		err = xdp_rxq_info_reg_mem_model(&rq->xdp_rxq,
 						 MEM_TYPE_XSK_BUFF_POOL, NULL);
+		if (err)
+			goto err_free_by_rq_type;
 		xsk_pool_set_rxq_info(rq->xsk_pool, &rq->xdp_rxq);
 	} else {
 		/* Create a page_pool and register it with rxq */
@@ -985,12 +987,13 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		}
 		if (!rq->hd_page_pool)
 			rq->hd_page_pool = rq->page_pool;
-		if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
+		if (xdp_rxq_info_is_reg(&rq->xdp_rxq)) {
 			err = xdp_rxq_info_reg_mem_model(&rq->xdp_rxq,
 							 MEM_TYPE_PAGE_POOL, rq->page_pool);
+			if (err)
+				goto err_destroy_page_pool;
+		}
 	}
-	if (err)
-		goto err_destroy_page_pool;
 
 	for (i = 0; i < wq_sz; i++) {
 		if (rq->wq_type == MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ) {
-- 
2.36.1


