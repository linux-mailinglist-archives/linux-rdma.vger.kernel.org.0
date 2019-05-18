Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381952236E
	for <lists+linux-rdma@lfdr.de>; Sat, 18 May 2019 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfERL4X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 May 2019 07:56:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38868 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729848AbfERL4X (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 18 May 2019 07:56:23 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1CC044E1C0D9D9CFC968;
        Sat, 18 May 2019 19:56:21 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 18 May 2019 19:55:58 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/4] RDMA/hns: Update CQE specifications
Date:   Sat, 18 May 2019 19:54:58 +0800
Message-ID: <1558180500-93157-3-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558180500-93157-1-git-send-email-oulijun@huawei.com>
References: <1558180500-93157-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

According to hip08 UM, the maximum number of CQEs supported
by each CQ is 4M.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index edfdbe2..0ac177a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -54,7 +54,7 @@
 #define HNS_ROCE_V2_MAX_CQ_NUM			0x100000
 #define HNS_ROCE_V2_MAX_CQC_TIMER_NUM		0x100
 #define HNS_ROCE_V2_MAX_SRQ_NUM			0x100000
-#define HNS_ROCE_V2_MAX_CQE_NUM			0x10000
+#define HNS_ROCE_V2_MAX_CQE_NUM			0x400000
 #define HNS_ROCE_V2_MAX_SRQWQE_NUM		0x8000
 #define HNS_ROCE_V2_MAX_RQ_SGE_NUM		0x100
 #define HNS_ROCE_V2_MAX_SQ_SGE_NUM		0xff
-- 
1.9.1

