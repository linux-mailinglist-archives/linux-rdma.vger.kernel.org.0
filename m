Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA10221EF9A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 13:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgGNLnN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 07:43:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728036AbgGNLnM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Jul 2020 07:43:12 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5FBE0228E075206E389B;
        Tue, 14 Jul 2020 19:43:07 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Jul 2020 19:42:58 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-rc] RDMA/hns: Fix wrong PBL offset when VA is not aligned to PAGE_SIZE
Date:   Tue, 14 Jul 2020 19:42:15 +0800
Message-ID: <1594726935-45666-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

The ROCEE use "VA % buf_page_size" to caclulate the offset in the PBL's
first page, the actual PA corresponding to the MR's VA is equal to MR's
PA plus this offset. The first PA in PBL has already been aligned to
PAGE_SIZE after calling ib_umem_get(), but the MR's VA may not. If the
buf_page_size is small than the PAGE_SIZE, this will lead the ROCEE to
access the wrong memory because the offset is smaller than expected.

Fixes: 9b2cf76c9f05 ("RDMA/hns: Optimize PBL buffer allocation process")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 0e71ebe..6b226a5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -120,7 +120,7 @@ static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 
 	mr->pbl_hop_num = is_fast ? 1 : hr_dev->caps.pbl_hop_num;
 	buf_attr.page_shift = is_fast ? PAGE_SHIFT :
-			      hr_dev->caps.pbl_buf_pg_sz + HNS_HW_PAGE_SHIFT;
+			      hr_dev->caps.pbl_buf_pg_sz + PAGE_SHIFT;
 	buf_attr.region[0].size = length;
 	buf_attr.region[0].hopnum = mr->pbl_hop_num;
 	buf_attr.region_count = 1;
-- 
2.8.1

