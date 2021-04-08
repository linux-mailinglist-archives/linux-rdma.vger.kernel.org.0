Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A72358203
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 13:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhDHLer (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 07:34:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15974 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhDHLeq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 07:34:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGJyb17SYzyNLT;
        Thu,  8 Apr 2021 19:32:23 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 19:34:24 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <selvin.xavier@broadcom.com>, <devesh.sharma@broadcom.com>,
        <somnath.kotur@broadcom.com>, <sriharsha.basavapatna@broadcom.com>,
        <nareshkumar.pbs@broadcom.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>, <eddie.wai@broadcom.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH -next] RDMA/bnxt_re: Fix error return code in bnxt_qplib_cq_process_terminal()
Date:   Thu, 8 Apr 2021 11:31:37 +0000
Message-ID: <20210408113137.97202-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 995d463..d4d4959 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2784,6 +2784,7 @@ static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
 		dev_err(&cq->hwq.pdev->dev,
 			"FP: CQ Processed terminal reported rq_cons_idx 0x%x exceeds max 0x%x\n",
 			cqe_cons, rq->max_wqe);
+		rc = -EINVAL;
 		goto done;
 	}
 
-- 
2.9.4

