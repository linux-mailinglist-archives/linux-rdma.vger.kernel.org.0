Return-Path: <linux-rdma+bounces-4513-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0424795CA2E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 12:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AD128737A
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 10:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F206188900;
	Fri, 23 Aug 2024 10:11:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED60187338;
	Fri, 23 Aug 2024 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407871; cv=none; b=iwWe8WMQqBeBkA1hgD/VYzikg0V4zleucTVFB2puAM2MaQyEMkBbCokulNttQBYF/viV5hcPL3UuIQJq5ZIs5yaoRUDjTrGLxEOFfhpoNimCaR+jACcKZ9eiB3bkrdpX+N7ulC08l3OuUNOXN4IXskGkmyY9V8XLRJKJ1XTadZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407871; c=relaxed/simple;
	bh=V8eyLtNXa1oF8GmVWwz4VqoK85/0XnLLzvJSHSEDy+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjyWQMaPOmn40ZQA39zj6bnpeUSwWPEEiS5t89HfFuRyH+2xzYrE61R1m1BbXlMIi57LfIci8Q3RG0E07wX9hgPbeHqssu2VMqYNIC5H7wvoFFPoSN+UMyHj2JWqVeQPOhV03uYxiSoiFly1EPv+3nbieXelL8/bONimXRkgV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wqwlw3Gt4zpTNm;
	Fri, 23 Aug 2024 18:09:32 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id CD9641800A4;
	Fri, 23 Aug 2024 18:11:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 18:11:06 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <dennis.dalessandro@cornelisnetworks.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bvanassche@acm.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 2/4] RDMA/mad: Simplify an alloc_ordered_workqueue() invocation
Date: Fri, 23 Aug 2024 18:18:38 +0800
Message-ID: <20240823101840.515398-3-ruanjinjie@huawei.com>
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
 drivers/infiniband/core/mad.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 70708fea1296..1fd54d5c4dd8 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2939,7 +2939,6 @@ static int ib_mad_port_open(struct ib_device *device,
 	int ret, cq_size;
 	struct ib_mad_port_private *port_priv;
 	unsigned long flags;
-	char name[sizeof "ib_mad123"];
 	int has_smi;
 
 	if (WARN_ON(rdma_max_mad_size(device, port_num) < IB_MGMT_MAD_SIZE))
@@ -2992,8 +2991,8 @@ static int ib_mad_port_open(struct ib_device *device,
 			goto error7;
 	}
 
-	snprintf(name, sizeof(name), "ib_mad%u", port_num);
-	port_priv->wq = alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
+	port_priv->wq = alloc_ordered_workqueue("ib_mad%u", WQ_MEM_RECLAIM,
+						port_num);
 	if (!port_priv->wq) {
 		ret = -ENOMEM;
 		goto error8;
-- 
2.34.1


