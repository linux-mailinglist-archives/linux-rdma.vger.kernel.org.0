Return-Path: <linux-rdma+bounces-4500-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA2295C593
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 08:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E3EB22803
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 06:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1327E111;
	Fri, 23 Aug 2024 06:36:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx312.baidu.com [180.101.52.108])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250036F2F4;
	Fri, 23 Aug 2024 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394961; cv=none; b=U4Wbj1+zaKIQvuYf+N/GVAW2cNM63ybq919vFUIKj0/ZeOIIt0faCMYK7udWAPREthLJfk21mzwOPvGSFJJOgqBDBj9r7wrE+PfO2CRgtktpwoRXfnmnrrhXUOc/aNK9NVSYhIDFLRiPzj4XJJuOIc9HvJ1pLxDNy+/kcz9k7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394961; c=relaxed/simple;
	bh=g0zsEWP2Hvlgl3aUUkO6PzcfFjYmAeF7CXO8Lsau0C8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=n4C5bFr5V6u6heLteeN+fJmySyfP4ZGwoyJNVzHNB9vngEklG5QgYdZX+S3LwFF2XToc/A332IYgFvF144cdBPS1sosz6JQvTwHFVJtVhEJjhDFPkXWIehMWB2pCpb77ncNF6/+RUWOX6WTQukiWq6NC65G5yj1r1EM2KL25XAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 381EC7F0003D;
	Fri, 23 Aug 2024 14:16:50 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][net-next] net/mlx5: Pick the first matched node of priv.free_list in alloc_4k
Date: Fri, 23 Aug 2024 14:16:48 +0800
Message-Id: <20240823061648.17862-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Pick the first node instead of last, to avoid unnecessary iterating
over whole free list

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index 972e8e9..cd20f11 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -228,6 +228,7 @@ static int alloc_4k(struct mlx5_core_dev *dev, u64 *addr, u32 function)
 		if (iter->function != function)
 			continue;
 		fp = iter;
+		break;
 	}
 
 	if (list_empty(&dev->priv.free_list) || !fp)
-- 
2.9.4


