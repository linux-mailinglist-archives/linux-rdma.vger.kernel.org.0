Return-Path: <linux-rdma+bounces-11587-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CE4AE67DD
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 16:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB9C18937BB
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2805F2D2386;
	Tue, 24 Jun 2025 14:08:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51E291C1A;
	Tue, 24 Jun 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774110; cv=none; b=WAGqntSU+ChS05/aUBtXvZFNQpw5oRxsrs4dbsgbGdtCqG4FJbZIvzvVhHPJSlZd/ct3jBhM0ycFIt/cHfvVAZ6blkYCE5WsafQ1KKNMrJj5THgyIiIhxQ75Whi1Y/i7/F2TcRMn41npvQ+rRdFgULpE5dJkNqyMKtOeVpFShhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774110; c=relaxed/simple;
	bh=loaHwNBI/gYKVHKNJjfT1pONOJEkBbwHCLkGhDebm1w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UNZOEaMPWOwD+MLZvf4lkYMIqWGykS49J7D1myrwI3XPnflJTauTgEi5e24fqhwLX6TA+SIixpRaDYCr6LcVKPivYAmi2v+Wu+biycYY2O4u3IfTMifvA5ffA8BoQlIEnGFt5wAi7tlxehDN5JBHy1nzzH/DbNGEQW87FE/sDyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <saeedm@nvidia.com>, <tariqt@nvidia.com>, <leon@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH net-next] net/mlx5e: Fix error handling in RQ memory model registration
Date: Tue, 24 Jun 2025 22:07:30 +0800
Message-ID: <20250624140730.67150-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

Currently when xdp_rxq_info_reg_mem_model() fails in the XSK path, the
error handling incorrectly jumps to err_destroy_page_pool. While this
may not cause errors, we should make it jump to the correct location.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ea822c69d137..1e3ba51b7995 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -915,6 +915,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 	if (xsk) {
 		err = xdp_rxq_info_reg_mem_model(&rq->xdp_rxq,
 						 MEM_TYPE_XSK_BUFF_POOL, NULL);
+		if (err)
+			goto err_free_by_rq_type;
 		xsk_pool_set_rxq_info(rq->xsk_pool, &rq->xdp_rxq);
 	} else {
 		/* Create a page_pool and register it with rxq */
@@ -941,12 +943,13 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 			rq->page_pool = NULL;
 			goto err_free_by_rq_type;
 		}
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


