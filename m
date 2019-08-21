Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590BF97A89
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfHUNR6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 09:17:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38410 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728413AbfHUNR6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 09:17:58 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F24F38A2CBEA3E1E0EE1;
        Wed, 21 Aug 2019 21:17:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 21 Aug 2019 21:17:47 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 7/9] RDMA/hns: Remove if-else judgment statements for creating srq
Date:   Wed, 21 Aug 2019 21:14:34 +0800
Message-ID: <1566393276-42555-8-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
References: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

Because if the value of srqwqe_buf_pg_sz is zero, npages and
ib_umem_page_count are equivalent, page_shif and PAGE_SHIFT
are equivalent in hns_roce_create_srq. Here remove it.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_srq.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index c011422..1a42172 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -191,15 +191,11 @@ static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
 	if (IS_ERR(srq->umem))
 		return PTR_ERR(srq->umem);
 
-	if (hr_dev->caps.srqwqe_buf_pg_sz) {
-		npages = (ib_umem_page_count(srq->umem) +
-			 (1 << hr_dev->caps.srqwqe_buf_pg_sz) - 1) /
-			 (1 << hr_dev->caps.srqwqe_buf_pg_sz);
-		page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
-		ret = hns_roce_mtt_init(hr_dev, npages, page_shift, &srq->mtt);
-	} else
-		ret = hns_roce_mtt_init(hr_dev, ib_umem_page_count(srq->umem),
-					PAGE_SHIFT, &srq->mtt);
+	npages = (ib_umem_page_count(srq->umem) +
+		(1 << hr_dev->caps.srqwqe_buf_pg_sz) - 1) /
+		(1 << hr_dev->caps.srqwqe_buf_pg_sz);
+	page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
+	ret = hns_roce_mtt_init(hr_dev, npages, page_shift, &srq->mtt);
 	if (ret)
 		goto err_user_buf;
 
@@ -216,19 +212,8 @@ static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
 		goto err_user_srq_mtt;
 	}
 
-	if (hr_dev->caps.idx_buf_pg_sz) {
-		npages = (ib_umem_page_count(srq->idx_que.umem) +
-			 (1 << hr_dev->caps.idx_buf_pg_sz) - 1) /
-			 (1 << hr_dev->caps.idx_buf_pg_sz);
-		page_shift = PAGE_SHIFT + hr_dev->caps.idx_buf_pg_sz;
-		ret = hns_roce_mtt_init(hr_dev, npages, page_shift,
-					&srq->idx_que.mtt);
-	} else {
-		ret = hns_roce_mtt_init(hr_dev,
-					ib_umem_page_count(srq->idx_que.umem),
-					PAGE_SHIFT,
-					&srq->idx_que.mtt);
-	}
+	ret = hns_roce_mtt_init(hr_dev, ib_umem_page_count(srq->idx_que.umem),
+				PAGE_SHIFT, &srq->idx_que.mtt);
 
 	if (ret) {
 		dev_err(hr_dev->dev, "hns_roce_mtt_init error for idx que\n");
-- 
2.8.1

