Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19DD87676
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 11:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405764AbfHIJp3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 05:45:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405976AbfHIJp3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Aug 2019 05:45:29 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BF1AC63219FC138F2EA9;
        Fri,  9 Aug 2019 17:45:26 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 9 Aug 2019 17:45:20 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/9] RDMA/hns: Bugfix for creating qp attached to srq
Date:   Fri, 9 Aug 2019 17:40:59 +0800
Message-ID: <1565343666-73193-3-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When create a qp and attached to srq, rq will no longer be used
and the members of rq will be set zero. As a result, the wrid
of rq will not be allocated and used.

Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index b729f8e..5f23c09 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -853,12 +853,19 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		}
 
 		hr_qp->sq.wrid = kcalloc(hr_qp->sq.wqe_cnt, sizeof(u64),
-					 GFP_KERNEL);
-		hr_qp->rq.wrid = kcalloc(hr_qp->rq.wqe_cnt, sizeof(u64),
-					 GFP_KERNEL);
-		if (!hr_qp->sq.wrid || !hr_qp->rq.wrid) {
+					       GFP_KERNEL);
+		if (ZERO_OR_NULL_PTR(hr_qp->sq.wrid)) {
 			ret = -ENOMEM;
-			goto err_wrid;
+			goto err_get_bufs;
+		}
+
+		if (hr_qp->rq.wqe_cnt) {
+			hr_qp->rq.wrid = kcalloc(hr_qp->rq.wqe_cnt, sizeof(u64),
+						 GFP_KERNEL);
+			if (ZERO_OR_NULL_PTR(hr_qp->rq.wrid)) {
+				ret = -ENOMEM;
+				goto err_sq_wrid;
+			}
 		}
 	}
 
@@ -944,8 +951,8 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		    hns_roce_qp_has_rq(init_attr))
 			hns_roce_db_unmap_user(uctx, &hr_qp->rdb);
 	} else {
-		kfree(hr_qp->sq.wrid);
-		kfree(hr_qp->rq.wrid);
+		if (hr_qp->rq.wqe_cnt)
+			kfree(hr_qp->rq.wrid);
 	}
 
 err_sq_dbmap:
@@ -956,6 +963,10 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		    hns_roce_qp_has_sq(init_attr))
 			hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
 
+err_sq_wrid:
+	if (!udata)
+		kfree(hr_qp->sq.wrid);
+
 err_get_bufs:
 	hns_roce_free_buf_list(buf_list, hr_qp->region_cnt);
 
-- 
1.9.1

