Return-Path: <linux-rdma+bounces-4511-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACEE95CA29
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 12:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D7F1F26706
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 10:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E31A188595;
	Fri, 23 Aug 2024 10:11:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AAE186E50;
	Fri, 23 Aug 2024 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407870; cv=none; b=RoNnXOHNJfIP0MkzYDsPp0Jmt1UkczWokJ/1WbkNOpcN/kNtZ587/45vA188cC/wTMCgROtw7E5bL5n0A/NlUMATgSNEck24N4CRU2khDzpyDNR2ZhZL3fQsLSkF2tyhhIiH3hAOt/Dx99l34pOGRHYKJuq3m9NSI/w2ud3hq50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407870; c=relaxed/simple;
	bh=aqTxtfoQXPS9GPhSgzU3BvmOpMsuBgMs+OS4+ZHEHk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJxDcegRvaTYaaHUYD9rBdpd6pjgohpvALTNapAEzBEdSvGbL5YWPcAEia9Zui906YS/ig6bH7fpETMdyDJEy3vWLe2ttYjKlwUUqkczWIbf5dtnOm9chhKz6SvtpEjNuhQjSq2UgE0tCit4SKjeZIS+Z3qFVYmYxX7kwcgvKtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wqwnf5GF0z2Cmvt;
	Fri, 23 Aug 2024 18:11:02 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 9062118001B;
	Fri, 23 Aug 2024 18:11:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 18:11:07 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <dennis.dalessandro@cornelisnetworks.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bvanassche@acm.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 4/4] RDMA/mad: Simplify an alloc_ordered_workqueue() invocation
Date: Fri, 23 Aug 2024 18:18:40 +0800
Message-ID: <20240823101840.515398-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823101840.515398-1-ruanjinjie@huawei.com>
References: <20240823101840.515398-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Let alloc_ordered_workqueue() format the workqueue name instead of calling
snprintf() explicitly.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/infiniband/hw/mlx4/mad.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index dc9cf45d2d32..e6e132f10625 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -2158,7 +2158,6 @@ static int mlx4_ib_alloc_demux_ctx(struct mlx4_ib_dev *dev,
 				       struct mlx4_ib_demux_ctx *ctx,
 				       int port)
 {
-	char name[21];
 	int ret = 0;
 	int i;
 
@@ -2194,24 +2193,21 @@ static int mlx4_ib_alloc_demux_ctx(struct mlx4_ib_dev *dev,
 		goto err_mcg;
 	}
 
-	snprintf(name, sizeof(name), "mlx4_ibt%d", port);
-	ctx->wq = alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
+	ctx->wq = alloc_ordered_workqueue("mlx4_ibt%d", WQ_MEM_RECLAIM, port);
 	if (!ctx->wq) {
 		pr_err("Failed to create tunnelling WQ for port %d\n", port);
 		ret = -ENOMEM;
 		goto err_wq;
 	}
 
-	snprintf(name, sizeof(name), "mlx4_ibwi%d", port);
-	ctx->wi_wq = alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
+	ctx->wi_wq = alloc_ordered_workqueue("mlx4_ibwi%d", WQ_MEM_RECLAIM, port);
 	if (!ctx->wi_wq) {
 		pr_err("Failed to create wire WQ for port %d\n", port);
 		ret = -ENOMEM;
 		goto err_wiwq;
 	}
 
-	snprintf(name, sizeof(name), "mlx4_ibud%d", port);
-	ctx->ud_wq = alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
+	ctx->ud_wq = alloc_ordered_workqueue("mlx4_ibud%d", WQ_MEM_RECLAIM, port);
 	if (!ctx->ud_wq) {
 		pr_err("Failed to create up/down WQ for port %d\n", port);
 		ret = -ENOMEM;
-- 
2.34.1


