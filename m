Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07408A792E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 05:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfIDDSK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 23:18:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727374AbfIDDSK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Sep 2019 23:18:10 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8EE7DD8FE8F8E1393836;
        Wed,  4 Sep 2019 11:18:08 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 11:18:00 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 2/5] RDMA/hns: Fix wrong parameters when initial mtt of srq->idx_que
Date:   Wed, 4 Sep 2019 11:14:42 +0800
Message-ID: <1567566885-23088-3-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1567566885-23088-1-git-send-email-liweihang@hisilicon.com>
References: <1567566885-23088-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The parameters npages used to initial mtt of srq->idx_que shouldn't be
same with srq's. And page_shift should be calculated from idx_buf_pg_sz.
This patch fixes above issuses and use field named npage and page_shift
in hns_roce_buf instead of two temporary variables to let us use them
anywhere.

Fixes: 18df508c7970 ("RDMA/hns: Remove if-else judgment statements for creating srq")

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_srq.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 9591457..d96041d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -180,8 +180,7 @@ static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(srq->ibsrq.device);
 	struct hns_roce_ib_create_srq  ucmd;
-	u32 page_shift;
-	u32 npages;
+	struct hns_roce_buf *buf;
 	int ret;
 
 	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
@@ -191,11 +190,13 @@ static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
 	if (IS_ERR(srq->umem))
 		return PTR_ERR(srq->umem);
 
-	npages = (ib_umem_page_count(srq->umem) +
-		(1 << hr_dev->caps.srqwqe_buf_pg_sz) - 1) /
-		(1 << hr_dev->caps.srqwqe_buf_pg_sz);
-	page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
-	ret = hns_roce_mtt_init(hr_dev, npages, page_shift, &srq->mtt);
+	buf = &srq->buf;
+	buf->npages = (ib_umem_page_count(srq->umem) +
+		       (1 << hr_dev->caps.srqwqe_buf_pg_sz) - 1) /
+		      (1 << hr_dev->caps.srqwqe_buf_pg_sz);
+	buf->page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
+	ret = hns_roce_mtt_init(hr_dev, buf->npages, buf->page_shift,
+				&srq->mtt);
 	if (ret)
 		goto err_user_buf;
 
@@ -212,9 +213,12 @@ static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
 		goto err_user_srq_mtt;
 	}
 
-	ret = hns_roce_mtt_init(hr_dev, ib_umem_page_count(srq->idx_que.umem),
-				PAGE_SHIFT, &srq->idx_que.mtt);
-
+	buf = &srq->idx_que.idx_buf;
+	buf->npages = DIV_ROUND_UP(ib_umem_page_count(srq->idx_que.umem),
+				   1 << hr_dev->caps.idx_buf_pg_sz);
+	buf->page_shift = PAGE_SHIFT + hr_dev->caps.idx_buf_pg_sz;
+	ret = hns_roce_mtt_init(hr_dev, buf->npages, buf->page_shift,
+				&srq->idx_que.mtt);
 	if (ret) {
 		dev_err(hr_dev->dev, "hns_roce_mtt_init error for idx que\n");
 		goto err_user_idx_mtt;
-- 
2.8.1

