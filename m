Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11FC26DE7F
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 16:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgIQOd7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 10:33:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727556AbgIQObv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 10:31:51 -0400
X-Greylist: delayed 806 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 10:31:50 EDT
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AFFF493B605CB7CAE668;
        Thu, 17 Sep 2020 22:14:33 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 22:14:28 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH for-next] RDMA/hns: Set the unsupported wr opcode
Date:   Thu, 17 Sep 2020 21:50:15 +0800
Message-ID: <1600350615-115217-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Because hip06 is not supported for local invalidate operation,
here should set the ps_opcode of the hardware to invalid
value.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Fixes: a2f3d4479fe9 ("RDMA/hns: Avoid unncessary initialization")

Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 96c14e5..1a545e2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -271,7 +271,6 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 				ps_opcode = HNS_ROCE_WQE_OPCODE_SEND;
 				break;
 			case IB_WR_LOCAL_INV:
-				break;
 			case IB_WR_ATOMIC_CMP_AND_SWP:
 			case IB_WR_ATOMIC_FETCH_AND_ADD:
 			case IB_WR_LSO:
-- 
1.9.1

