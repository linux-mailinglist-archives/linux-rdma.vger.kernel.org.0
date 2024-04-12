Return-Path: <linux-rdma+bounces-1928-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149438A2AFD
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 11:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E87281554
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 09:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2A254646;
	Fri, 12 Apr 2024 09:20:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C551C5B;
	Fri, 12 Apr 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913653; cv=none; b=DUWMwxzckHtteGH8erjQ0yYVlfBc3eusvPWkXtq3iLzTe6PVlram3yG0ktxPYcHSHEyhP1Z/pLBA/6KmPqvXyAc5P5PXA7W/1T8KqreOtvcKqBlQx8c6bt+asL1bLqP1JkBR/3ivh+Zbor2Ie5Cw/pI3Exdilak2TCWtYEGa/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913653; c=relaxed/simple;
	bh=31rJ8Dui/r7OSm/CEjqbMvt4wFKJXRDqU2+rwk/A7Z8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QenUnwU0DU7apw7Jdi0SvaD2JgPTts3Pw8MMm73/1UVaG+gmF19iCb3vLxpUjb66ntLT2tCz76MTsfq16Sw/uWHHAZmYEqXRWlwtPUF3f3/Li3LYvNQo/v51hZYYpr37kN2fFlyWlAifa7pJxBWM/AiKSzXVCEc3r2QVR57Kys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VG9y01FzNz1wr4w;
	Fri, 12 Apr 2024 17:19:52 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 728231A016C;
	Fri, 12 Apr 2024 17:20:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:20:47 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 04/10] RDMA/hns: Fix deadlock on SRQ async events.
Date: Fri, 12 Apr 2024 17:16:10 +0800
Message-ID: <20240412091616.370789-5-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240412091616.370789-1-huangjunxian6@hisilicon.com>
References: <20240412091616.370789-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: Chengchang Tang <tangchengchang@huawei.com>

xa_lock for SRQ table may be required in AEQ. Use xa_store_irq()/
xa_erase_irq() to avoid deadlock.

Fixes: 81fce6291d99 ("RDMA/hns: Add SRQ asynchronous event support")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 1 +
 drivers/infiniband/hw/hns/hns_roce_srq.c  | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 4d94fcb8685a..d202258368ed 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -37,6 +37,7 @@
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_cache.h>
+#include "hnae3.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index e4705ccdfa65..7210e53a82f3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -123,7 +123,7 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 		return ret;
 	}
 
-	ret = xa_err(xa_store(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
+	ret = xa_err(xa_store_irq(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
 	if (ret) {
 		ibdev_err(ibdev, "failed to store SRQC, ret = %d.\n", ret);
 		goto err_put;
@@ -136,7 +136,7 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	return 0;
 
 err_xa:
-	xa_erase(&srq_table->xa, srq->srqn);
+	xa_erase_irq(&srq_table->xa, srq->srqn);
 err_put:
 	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
 
@@ -154,7 +154,7 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 		dev_err(hr_dev->dev, "DESTROY_SRQ failed (%d) for SRQN %06lx\n",
 			ret, srq->srqn);
 
-	xa_erase(&srq_table->xa, srq->srqn);
+	xa_erase_irq(&srq_table->xa, srq->srqn);
 
 	if (refcount_dec_and_test(&srq->refcount))
 		complete(&srq->free);
-- 
2.30.0


