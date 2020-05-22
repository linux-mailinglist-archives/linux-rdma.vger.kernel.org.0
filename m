Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4953A1DE794
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 15:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgEVNDa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 09:03:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4890 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729729AbgEVND3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 May 2020 09:03:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 12EC96D99D5D3070CF38;
        Fri, 22 May 2020 21:03:27 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 22 May 2020 21:03:16 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/4] RDMA/hns: Remove redundant parameters from free_srq/qp_wrid()
Date:   Fri, 22 May 2020 21:02:57 +0800
Message-ID: <1590152579-32364-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1590152579-32364-1-git-send-email-liweihang@huawei.com>
References: <1590152579-32364-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

The redundant parameters "hr_dev" need to be removed from
free_kernel_wrid() and free_srq_wrid().

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c  | 7 +++----
 drivers/infiniband/hw/hns/hns_roce_srq.c | 6 +++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index fb71755..e0b301a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -842,8 +842,7 @@ static int alloc_kernel_wrid(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static void free_kernel_wrid(struct hns_roce_dev *hr_dev,
-			     struct hns_roce_qp *hr_qp)
+static void free_kernel_wrid(struct hns_roce_qp *hr_qp)
 {
 	kfree(hr_qp->rq.wrid);
 	kfree(hr_qp->sq.wrid);
@@ -996,7 +995,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 err_db:
 	free_qp_db(hr_dev, hr_qp, udata);
 err_wrid:
-	free_kernel_wrid(hr_dev, hr_qp);
+	free_kernel_wrid(hr_qp);
 	return ret;
 }
 
@@ -1010,7 +1009,7 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	free_qpc(hr_dev, hr_qp);
 	free_qpn(hr_dev, hr_qp);
 	free_qp_buf(hr_dev, hr_qp);
-	free_kernel_wrid(hr_dev, hr_qp);
+	free_kernel_wrid(hr_qp);
 	free_qp_db(hr_dev, hr_qp, udata);
 
 	kfree(hr_qp);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 3018c98..f40a000 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -270,7 +270,7 @@ static int alloc_srq_wrid(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	return 0;
 }
 
-static void free_srq_wrid(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
+static void free_srq_wrid(struct hns_roce_srq *srq)
 {
 	kfree(srq->wrid);
 	srq->wrid = NULL;
@@ -355,7 +355,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 err_srqc_alloc:
 	free_srqc(hr_dev, srq);
 err_wrid_alloc:
-	free_srq_wrid(hr_dev, srq);
+	free_srq_wrid(srq);
 err_idx_alloc:
 	free_srq_idx(hr_dev, srq);
 err_buf_alloc:
@@ -370,7 +370,7 @@ void hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 
 	free_srqc(hr_dev, srq);
 	free_srq_idx(hr_dev, srq);
-	free_srq_wrid(hr_dev, srq);
+	free_srq_wrid(srq);
 	free_srq_buf(hr_dev, srq);
 }
 
-- 
2.8.1

