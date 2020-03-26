Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B60C19371F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2020 04:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCZDoR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Mar 2020 23:44:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727647AbgCZDoR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Mar 2020 23:44:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9EB5C7779D08CF2D859C;
        Thu, 26 Mar 2020 11:44:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Mar 2020 11:44:04 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/3] RDMA/hns: Reduce the maximum number of extend SGE per WQE
Date:   Thu, 26 Mar 2020 11:40:17 +0800
Message-ID: <1585194018-4381-3-git-send-email-liweihang@huawei.com>
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

Just reduce the default number to 64 for backward compatibility, the driver
can still get this configuration from the firmware.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 2a117ff..4f90ef7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -50,15 +50,14 @@
 #define HNS_ROCE_V2_MAX_WQE_NUM			0x8000
 #define	HNS_ROCE_V2_MAX_SRQ			0x100000
 #define HNS_ROCE_V2_MAX_SRQ_WR			0x8000
-#define HNS_ROCE_V2_MAX_SRQ_SGE			0x100
+#define HNS_ROCE_V2_MAX_SRQ_SGE			64
 #define HNS_ROCE_V2_MAX_CQ_NUM			0x100000
 #define HNS_ROCE_V2_MAX_CQC_TIMER_NUM		0x100
 #define HNS_ROCE_V2_MAX_SRQ_NUM			0x100000
 #define HNS_ROCE_V2_MAX_CQE_NUM			0x400000
 #define HNS_ROCE_V2_MAX_SRQWQE_NUM		0x8000
-#define HNS_ROCE_V2_MAX_RQ_SGE_NUM		0x100
-#define HNS_ROCE_V2_MAX_SQ_SGE_NUM		0xff
-#define HNS_ROCE_V2_MAX_SRQ_SGE_NUM		0x100
+#define HNS_ROCE_V2_MAX_RQ_SGE_NUM		64
+#define HNS_ROCE_V2_MAX_SQ_SGE_NUM		64
 #define HNS_ROCE_V2_MAX_EXTEND_SGE_NUM		0x200000
 #define HNS_ROCE_V2_MAX_SQ_INLINE		0x20
 #define HNS_ROCE_V2_UAR_NUM			256
-- 
2.8.1

