Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5893AC878
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 12:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhFRKNA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 06:13:00 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11069 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhFRKM6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 06:12:58 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5vkH5mDpzZgDF;
        Fri, 18 Jun 2021 18:07:51 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:48 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:48 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yixing Liu <liuyixing1@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 03/10] RDMA/hns: Fix some print issues
Date:   Fri, 18 Jun 2021 18:10:13 +0800
Message-ID: <1624011020-16992-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624011020-16992-1-git-send-email-liweihang@huawei.com>
References: <1624011020-16992-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

Remove redundant print and fix a character type mismatch.

Fixes: 0e0ab04b5bbe ("RDMA/hns: Refactor the MTR creation flow")
Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index c039743..d9b779d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -992,7 +992,7 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 					&buf_page_shift,
 					udata ? user_addr & ~PAGE_MASK : 0);
 	if (buf_page_cnt < 1 || buf_page_shift < HNS_HW_PAGE_SHIFT) {
-		ibdev_err(ibdev, "failed to init mtr cfg, count %d shift %d.\n",
+		ibdev_err(ibdev, "failed to init mtr cfg, count %d shift %u.\n",
 			  buf_page_cnt, buf_page_shift);
 		return -EINVAL;
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 3a018a3..17b6ce2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -648,9 +648,7 @@ static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 
 	if (!cap->max_send_wr || cap->max_send_wr > hr_dev->caps.max_wqes ||
 	    cap->max_send_sge > hr_dev->caps.max_sq_sg) {
-		ibdev_err(ibdev,
-			  "failed to check SQ WR or SGE num, ret = %d.\n",
-			  -EINVAL);
+		ibdev_err(ibdev, "failed to check SQ WR or SGE num.\n");
 		return -EINVAL;
 	}
 
-- 
2.7.4

