Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8732318C5B9
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 04:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgCTD1g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 23:27:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33336 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726646AbgCTD1g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 23:27:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 415ED726F5B95E81EBF2;
        Fri, 20 Mar 2020 11:27:32 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Mar 2020 11:27:26 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 05/10] RDMA/hns: Adjust the qp status value sequence of the hardware
Date:   Fri, 20 Mar 2020 11:23:37 +0800
Message-ID: <1584674622-52773-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1584674622-52773-1-git-send-email-liweihang@huawei.com>
References: <1584674622-52773-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Interchange SQD and SQE to match the protocol.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 2a117ff..83e94df 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -460,8 +460,8 @@ enum hns_roce_v2_qp_state {
 	HNS_ROCE_QP_ST_INIT,
 	HNS_ROCE_QP_ST_RTR,
 	HNS_ROCE_QP_ST_RTS,
-	HNS_ROCE_QP_ST_SQER,
 	HNS_ROCE_QP_ST_SQD,
+	HNS_ROCE_QP_ST_SQER,
 	HNS_ROCE_QP_ST_ERR,
 	HNS_ROCE_QP_ST_SQ_DRAINING,
 	HNS_ROCE_QP_NUM_ST
-- 
2.8.1

