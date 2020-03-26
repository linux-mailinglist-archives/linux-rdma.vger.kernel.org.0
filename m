Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFBA2193720
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2020 04:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgCZDoR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Mar 2020 23:44:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34434 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727636AbgCZDoR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Mar 2020 23:44:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 939814EBF17D30A23E2A;
        Thu, 26 Mar 2020 11:44:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Mar 2020 11:44:04 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/3] RDMA/hns: Modify the mask of QP number for CQE of hip08
Date:   Thu, 26 Mar 2020 11:40:18 +0800
Message-ID: <1585194018-4381-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1585194018-4381-1-git-send-email-liweihang@huawei.com>
References: <1585194018-4381-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

The hip08 supports up to 1M QPs, so the qpn mask of cqe should be modified.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 4f90ef7..dd8f93d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -162,7 +162,7 @@ enum {
 
 #define	GID_LEN_V2				16
 
-#define HNS_ROCE_V2_CQE_QPN_MASK		0x3ffff
+#define HNS_ROCE_V2_CQE_QPN_MASK		0xfffff
 
 enum {
 	HNS_ROCE_V2_WQE_OP_SEND				= 0x0,
-- 
2.8.1

