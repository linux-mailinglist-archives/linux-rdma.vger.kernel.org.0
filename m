Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2535D37B79C
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhELINk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 04:13:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2639 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhELINj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 04:13:39 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg6rM4g5HzQmQd;
        Wed, 12 May 2021 16:09:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 16:12:23 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 1/4] RDMA/hns: Remove unused parameter udata
Date:   Wed, 12 May 2021 16:12:19 +0800
Message-ID: <1620807142-39157-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620807142-39157-1-git-send-email-liweihang@huawei.com>
References: <1620807142-39157-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

The old version of ib_umem_get() need these udata as a parameter but now
they are unnecessary.

Fixes: c320e527e154 ("IB: Allow calls to ib_umem_get from kernel ULPs")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 3 +--
 drivers/infiniband/hw/hns/hns_roce_db.c     | 3 +--
 drivers/infiniband/hw/hns/hns_roce_device.h | 3 +--
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 4 ++--
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 800884b..488d86b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -234,8 +234,7 @@ static int alloc_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 		    udata->outlen >= offsetofend(typeof(*resp), cap_flags)) {
 			uctx = rdma_udata_to_drv_context(udata,
 					struct hns_roce_ucontext, ibucontext);
-			err = hns_roce_db_map_user(uctx, udata, addr,
-						   &hr_cq->db);
+			err = hns_roce_db_map_user(uctx, addr, &hr_cq->db);
 			if (err)
 				return err;
 			hr_cq->flags |= HNS_ROCE_CQ_FLAG_RECORD_DB;
diff --git a/drivers/infiniband/hw/hns/hns_roce_db.c b/drivers/infiniband/hw/hns/hns_roce_db.c
index 5cb7376c..d40ea3d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_db.c
+++ b/drivers/infiniband/hw/hns/hns_roce_db.c
@@ -8,8 +8,7 @@
 #include <rdma/ib_umem.h>
 #include "hns_roce_device.h"
 
-int hns_roce_db_map_user(struct hns_roce_ucontext *context,
-			 struct ib_udata *udata, unsigned long virt,
+int hns_roce_db_map_user(struct hns_roce_ucontext *context, unsigned long virt,
 			 struct hns_roce_db *db)
 {
 	unsigned long page_addr = virt & PAGE_MASK;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 97800d2..d93dfba 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1248,8 +1248,7 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 		       struct ib_udata *udata);
 
 int hns_roce_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
-int hns_roce_db_map_user(struct hns_roce_ucontext *context,
-			 struct ib_udata *udata, unsigned long virt,
+int hns_roce_db_map_user(struct hns_roce_ucontext *context, unsigned long virt,
 			 struct hns_roce_db *db);
 void hns_roce_db_unmap_user(struct hns_roce_ucontext *context,
 			    struct hns_roce_db *db);
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 230a909..c6e120e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -826,7 +826,7 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 
 	if (udata) {
 		if (user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd)) {
-			ret = hns_roce_db_map_user(uctx, udata, ucmd->sdb_addr,
+			ret = hns_roce_db_map_user(uctx, ucmd->sdb_addr,
 						   &hr_qp->sdb);
 			if (ret) {
 				ibdev_err(ibdev,
@@ -839,7 +839,7 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		}
 
 		if (user_qp_has_rdb(hr_dev, init_attr, udata, resp)) {
-			ret = hns_roce_db_map_user(uctx, udata, ucmd->db_addr,
+			ret = hns_roce_db_map_user(uctx, ucmd->db_addr,
 						   &hr_qp->rdb);
 			if (ret) {
 				ibdev_err(ibdev,
-- 
2.7.4

