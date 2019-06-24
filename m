Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC3F750A1D
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 13:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfFXLux (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 07:50:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42336 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729365AbfFXLux (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jun 2019 07:50:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AB2DB5067F30ED123A02;
        Mon, 24 Jun 2019 19:50:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Jun 2019 19:50:42 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 5/8] RDMA/hns: Bugfix for calculating qp buffer size
Date:   Mon, 24 Jun 2019 19:47:49 +0800
Message-ID: <1561376872-111496-6-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
References: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: o00290482 <o00290482@huawei.com>

The buffer size of qp which used to allocate qp buffer space for
storing sqwqe and rqwqe will be the length of buffer space. The
kernel driver will use the buffer address and the same size to
get the user memory. The same size named buff_size of qp. According
the algorithm of calculating, The size of the two is not equal
when users set the max sge of sq.

Fixes: b28ca7cceff8 ("RDMA/hns: Limit extend sq sge num")
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 305be42..d56c03d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -392,8 +392,8 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
 					     hr_qp->sq.wqe_shift), PAGE_SIZE);
 	} else {
 		page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
-		hr_qp->sge.sge_cnt =
-		       max(page_size / (1 << hr_qp->sge.sge_shift), ex_sge_num);
+		hr_qp->sge.sge_cnt = ex_sge_num ?
+		   max(page_size / (1 << hr_qp->sge.sge_shift), ex_sge_num) : 0;
 		hr_qp->buff_size = HNS_ROCE_ALOGN_UP((hr_qp->rq.wqe_cnt <<
 					     hr_qp->rq.wqe_shift), page_size) +
 				   HNS_ROCE_ALOGN_UP((hr_qp->sge.sge_cnt <<
-- 
1.9.1

