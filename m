Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C591CA773
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2020 11:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEHJqT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 May 2020 05:46:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53582 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbgEHJqT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 8 May 2020 05:46:19 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9647353FA0AA7E61F288;
        Fri,  8 May 2020 17:46:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 17:46:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/9] RDMA/hns: Fix assignment to ba_pg_sz of eqe
Date:   Fri, 8 May 2020 17:45:53 +0800
Message-ID: <1588931159-56875-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588931159-56875-1-git-send-email-liweihang@huawei.com>
References: <1588931159-56875-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

When allocating eq buffer, the size of base address page should be defined
by eqe_ba_pg_sz instead of srqwqe_ba_pg_sz.

Fixes: 477a0a387072 ("RDMA/hns: Optimize 0 hop addressing for EQE buffer")
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 81abab0..3039896 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5612,7 +5612,7 @@ static int alloc_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 	buf_attr.fixed_page = true;
 
 	err = hns_roce_mtr_create(hr_dev, &eq->mtr, &buf_attr,
-				  hr_dev->caps.srqwqe_ba_pg_sz +
+				  hr_dev->caps.eqe_ba_pg_sz +
 				  PAGE_ADDR_SHIFT, NULL, 0);
 	if (err)
 		dev_err(hr_dev->dev, "Failed to alloc EQE mtr, err %d\n", err);
-- 
2.8.1

