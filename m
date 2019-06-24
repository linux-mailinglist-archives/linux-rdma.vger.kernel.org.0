Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D86450A1B
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 13:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfFXLuw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 07:50:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728052AbfFXLuw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jun 2019 07:50:52 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9F5FB3194422AEC67079;
        Mon, 24 Jun 2019 19:50:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Jun 2019 19:50:41 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/8] RDMA/hns: Modify ba page size for cqe
Date:   Mon, 24 Jun 2019 19:47:47 +0800
Message-ID: <1561376872-111496-4-git-send-email-oulijun@huawei.com>
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

From: Yangyang Li <liyangyang20@huawei.com>

Currently, the depth of cq only supports 64K.
According to the UM, the depth of cq is up to 4M,
Therefore the ba page size of cqe was modified to
support the maximum specification of cq depth.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7dae2e9..e57dc2c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1618,7 +1618,7 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 	caps->wqe_sq_hop_num	= 2;
 	caps->wqe_sge_hop_num	= 1;
 	caps->wqe_rq_hop_num	= 2;
-	caps->cqe_ba_pg_sz	= 0;
+	caps->cqe_ba_pg_sz	= 6;
 	caps->cqe_buf_pg_sz	= 0;
 	caps->cqe_hop_num	= HNS_ROCE_CQE_HOP_NUM;
 	caps->srqwqe_ba_pg_sz	= 0;
-- 
1.9.1

