Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D35D291CD
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 09:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbfEXHco (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 03:32:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17560 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389035AbfEXHco (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 03:32:44 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9397A9B89059A8A9CBBD;
        Fri, 24 May 2019 15:32:41 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 May 2019 15:32:32 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 for-next 2/4] RDMA/hns: Update CQE specifications
Date:   Fri, 24 May 2019 15:31:21 +0800
Message-ID: <1558683083-79692-3-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558683083-79692-1-git-send-email-oulijun@huawei.com>
References: <1558683083-79692-1-git-send-email-oulijun@huawei.com>
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

