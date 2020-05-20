Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248D61DB5AC
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgETNxv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 09:53:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726836AbgETNxv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 09:53:51 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 74CC97AE1E39D6D5AB6A;
        Wed, 20 May 2020 21:53:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 20 May 2020 21:53:36 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 5/9] RDMA/hns: Rename QP buffer related function
Date:   Wed, 20 May 2020 21:53:15 +0800
Message-ID: <1589982799-28728-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
References: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Rename the function related to QP buffer to make the code more readable.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index dca979d..ae7495f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -501,9 +501,9 @@ static int set_user_sq_size(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
-static int split_wqe_buf_region(struct hns_roce_dev *hr_dev,
-				struct hns_roce_qp *hr_qp,
-				struct hns_roce_buf_attr *buf_attr)
+static int set_wqe_buf_attr(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_qp *hr_qp,
+			    struct hns_roce_buf_attr *buf_attr)
 {
 	int buf_size;
 	int idx = 0;
@@ -675,7 +675,7 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		hr_qp->rq_inl_buf.wqe_list = NULL;
 	}
 
-	ret = split_wqe_buf_region(hr_dev, hr_qp, &buf_attr);
+	ret = set_wqe_buf_attr(hr_dev, hr_qp, &buf_attr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to split WQE buf, ret = %d.\n", ret);
 		goto err_inline;
-- 
2.8.1

