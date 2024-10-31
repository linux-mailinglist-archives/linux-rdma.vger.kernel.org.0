Return-Path: <linux-rdma+bounces-5649-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005569B7704
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 10:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CF2284903
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C11E1891B8;
	Thu, 31 Oct 2024 09:03:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE5156967
	for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365396; cv=none; b=clSE8aSduuVAx/6bEVWA/fW5OEk609BvgM+b0mmjbgbe7A84dHDkcZIc5Flk2AhEGPCAbQ4QY75tVOqBKXI9kGhgPCWDCM48iG6woinIMYJ5+Xlz6qzKYzKSEXTr2Q8yjD9OKsnuOkpgZDDZEOsCXQxvqW6qyxAgBJqH6qH5pOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365396; c=relaxed/simple;
	bh=nENkouSDTwDH9WfPzp0MWFd41UcSQklfyJYOChjKhVU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JwLRW9XfmWtq/t5q9noIUDLUhxXYCESlyj5w1+bl/l4u9RwCBw2L3U2OAtIp6JpU4N7QJTcYH8bihMPGTuYq9JVkvW3ucs/ryYpVFLZdD+8+qBqotEPn6j/Q78x8lcOtgpOlAHcItn3O7yWP55p9dSoFf3wjVlIKu3KkjqOljsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XfHzj0X7Jz1jw1f;
	Thu, 31 Oct 2024 17:01:37 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id 31C11140156;
	Thu, 31 Oct 2024 17:03:10 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200003.china.huawei.com
 (7.202.181.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Oct
 2024 17:03:04 +0800
From: Liu Jian <liujian56@huawei.com>
To: <zyjzyj2000@gmail.com>, <yanjun.zhu@linux.dev>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <rpearsonhpe@gmail.com>, <kamalh@mellanox.com>,
	<haggaie@mellanox.com>, <dledford@redhat.com>, <monis@mellanox.com>,
	<amirv@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <liujian56@huawei.com>
Subject: [PATCH rdma v2] RDMA/rxe: Set queue pair cur_qp_state when being queried
Date: Thu, 31 Oct 2024 17:20:19 +0800
Message-ID: <20241031092019.2138467-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200003.china.huawei.com (7.202.181.30)

Same with commit e375b9c92985 ("RDMA/cxgb4: Set queue pair state when
 being queried"). The API for ib_query_qp requires the driver to set
cur_qp_state on return, add the missing set.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Liu Jian <liujian56@huawei.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
v1: https://patchwork.kernel.org/project/linux-rdma/patch/20240809083148.1989912-5-liujian56@huawei.com/
 drivers/infiniband/sw/rxe/rxe_qp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index d2f7b5195c19..91d329e90308 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -775,6 +775,7 @@ int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
 	 * Yield the processor
 	 */
 	spin_lock_irqsave(&qp->state_lock, flags);
+	attr->cur_qp_state = qp_state(qp);
 	if (qp->attr.sq_draining) {
 		spin_unlock_irqrestore(&qp->state_lock, flags);
 		cond_resched();
-- 
2.34.1


