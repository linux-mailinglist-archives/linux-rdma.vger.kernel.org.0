Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9014194B7
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 15:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhI0NBs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 09:01:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:12004 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhI0NBr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Sep 2021 09:01:47 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HJ2kz22RhzWNHf;
        Mon, 27 Sep 2021 20:58:51 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 21:00:07 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 21:00:07 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-rc 2/2] RDMA/hns: Add the check of the CQE size of the user space
Date:   Mon, 27 Sep 2021 20:55:57 +0800
Message-ID: <20210927125557.15031-3-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927125557.15031-1-liangwenpeng@huawei.com>
References: <20210927125557.15031-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If the CQE size of the user space is not the size supported by the
hardware, the creation of CQ should be stopped.

Fixes: 09a5f210f67e ("RDMA/hns: Add support for CQE in size of 64 Bytes")
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c | 31 ++++++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 1e9c3c5bee68..d763f097599f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -326,19 +326,30 @@ static void set_cq_param(struct hns_roce_cq *hr_cq, u32 cq_entries, int vector,
 	INIT_LIST_HEAD(&hr_cq->rq_list);
 }
 
-static void set_cqe_size(struct hns_roce_cq *hr_cq, struct ib_udata *udata,
-			 struct hns_roce_ib_create_cq *ucmd)
+static int set_cqe_size(struct hns_roce_cq *hr_cq, struct ib_udata *udata,
+			struct hns_roce_ib_create_cq *ucmd)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(hr_cq->ib_cq.device);
 
-	if (udata) {
-		if (udata->inlen >= offsetofend(typeof(*ucmd), cqe_size))
-			hr_cq->cqe_size = ucmd->cqe_size;
-		else
-			hr_cq->cqe_size = HNS_ROCE_V2_CQE_SIZE;
-	} else {
+	if (!udata) {
 		hr_cq->cqe_size = hr_dev->caps.cqe_sz;
+		return 0;
+	}
+
+	if (udata->inlen >= offsetofend(typeof(*ucmd), cqe_size)) {
+		if (ucmd->cqe_size != HNS_ROCE_V2_CQE_SIZE &&
+		    ucmd->cqe_size != HNS_ROCE_V3_CQE_SIZE) {
+			ibdev_err(&hr_dev->ib_dev,
+				  "invalid cqe size %u.\n", ucmd->cqe_size);
+			return -EINVAL;
+		}
+
+		hr_cq->cqe_size = ucmd->cqe_size;
+	} else {
+		hr_cq->cqe_size = HNS_ROCE_V2_CQE_SIZE;
 	}
+
+	return 0;
 }
 
 int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
@@ -366,7 +377,9 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 
 	set_cq_param(hr_cq, attr->cqe, attr->comp_vector, &ucmd);
 
-	set_cqe_size(hr_cq, udata, &ucmd);
+	ret = set_cqe_size(hr_cq, udata, &ucmd);
+	if (ret)
+		return ret;
 
 	ret = alloc_cq_buf(hr_dev, hr_cq, udata, ucmd.buf_addr);
 	if (ret) {
-- 
2.33.0

