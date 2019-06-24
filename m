Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAF750A1C
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 13:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfFXLux (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 07:50:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729387AbfFXLux (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jun 2019 07:50:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A35E2F1D6E824DD09F89;
        Mon, 24 Jun 2019 19:50:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Jun 2019 19:50:40 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/8] RDMA/hns: Bugfix for cleaning mtr
Date:   Mon, 24 Jun 2019 19:47:45 +0800
Message-ID: <1561376872-111496-2-git-send-email-oulijun@huawei.com>
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

It uses hns_roce_mtr_init in hns_roce_create_qp_common function.
As a result, it should use hns_roce_mtr_cleanup function for
cleaning mtr when destroying qp.

Fixes: 8d18ad83f19b ("RDMA/hns: Fix bug when wqe num is larger than 16K")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index edd62b4..7dae2e9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4568,7 +4568,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 	    (hr_qp->ibqp.qp_type == IB_QPT_UD))
 		hns_roce_release_range_qp(hr_dev, hr_qp->qpn, 1);
 
-	hns_roce_mtt_cleanup(hr_dev, &hr_qp->mtt);
+	hns_roce_mtr_cleanup(hr_dev, &hr_qp->mtr);
 
 	if (udata) {
 		struct hns_roce_ucontext *context =
-- 
1.9.1

