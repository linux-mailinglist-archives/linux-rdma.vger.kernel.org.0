Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374482C7229
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Nov 2020 23:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbgK1VuY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Nov 2020 16:50:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8160 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730410AbgK1SlB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Nov 2020 13:41:01 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CjnfC0bZWz15SZ1;
        Sat, 28 Nov 2020 18:24:03 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Nov 2020 18:24:19 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/3] RDMA/hns: Bugfix for calculation of extended sge
Date:   Sat, 28 Nov 2020 18:22:38 +0800
Message-ID: <1606558959-48510-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1606558959-48510-1-git-send-email-liweihang@huawei.com>
References: <1606558959-48510-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

Page alignment is required when setting the number of extended sge
according to the hardware's achivement. If the space of needed extended sge
is greater than one page, the roundup_pow_of_two() can ensure that. But if
the needed extended sge isn't 0 and can not be filled in a whole page, the
driver should align it specifically.

Fixes: 54d6638765b0 ("RDMA/hns: Optimize WQE buffer size calculating process")
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 5e505a3..7321e74 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -432,7 +432,12 @@ static int set_extend_sge_param(struct hns_roce_dev *hr_dev, u32 sq_wqe_cnt,
 	}
 
 	hr_qp->sge.sge_shift = HNS_ROCE_SGE_SHIFT;
-	hr_qp->sge.sge_cnt = cnt;
+
+	/* If the number of extended sge is not zero, they MUST use the
+	 * space of HNS_HW_PAGE_SIZE at least.
+	 */
+	hr_qp->sge.sge_cnt = cnt ?
+			max(cnt, (u32)HNS_HW_PAGE_SIZE / HNS_ROCE_SGE_SIZE) : 0;
 
 	return 0;
 }
-- 
2.8.1

