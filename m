Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68906EBC01
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 03:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfKAChN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Oct 2019 22:37:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727455AbfKAChN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 31 Oct 2019 22:37:13 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5B6D9ABFA2CDF7E02E6C;
        Fri,  1 Nov 2019 10:37:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 1 Nov 2019 10:37:03 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-rc 2/2] RDMA/hns: Correct the value of srq_desc_size
Date:   Fri, 1 Nov 2019 10:33:30 +0800
Message-ID: <1572575610-52530-3-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572575610-52530-1-git-send-email-liweihang@hisilicon.com>
References: <1572575610-52530-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

srq_desc_size should be rounded up to pow of two before used, or related
calculation may cause allocating wrong size of memory for srq buffer.

Fixes: c7bcb13442e1 ("RDMA/hns: Add SRQ support for hip08 kernel mode")
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_srq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 9591457..43ea2c1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -376,7 +376,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	srq->max = roundup_pow_of_two(srq_init_attr->attr.max_wr + 1);
 	srq->max_gs = srq_init_attr->attr.max_sge;
 
-	srq_desc_size = max(16, 16 * srq->max_gs);
+	srq_desc_size = roundup_pow_of_two(max(16, 16 * srq->max_gs));
 
 	srq->wqe_shift = ilog2(srq_desc_size);
 
-- 
2.8.1

