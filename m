Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611741BF58A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 12:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgD3Kbv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 06:31:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbgD3Kbv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Apr 2020 06:31:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 30BB244ACE97CD95C589;
        Thu, 30 Apr 2020 18:31:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 18:31:38 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/3] RDMA/hns: Fix comments with non-English symbols
Date:   Thu, 30 Apr 2020 18:31:29 +0800
Message-ID: <1588242691-12913-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588242691-12913-1-git-send-email-liweihang@huawei.com>
References: <1588242691-12913-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a comments with some chinese semicolons that cause encoding issues
each time hns_roc_hw_v2.h was modified from a IDE. So fix this by using
correct symbols.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 82dd9f6..05bfe07 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1241,10 +1241,9 @@ struct hns_roce_func_clear {
 };
 
 #define FUNC_CLEAR_RST_FUN_DONE_S 0
-/* Each physical function manages up to 248 virtual functions；
- * it takes up to 100ms for each function to execute clear；
- * if an abnormal reset occurs, it is executed twice at most;
- * so it takes up to 249 * 2 * 100ms.
+/* Each physical function manages up to 248 virtual functions, it takes up to
+ * 100ms for each function to execute clear. If an abnormal reset occurs, it is
+ * executed twice at most, so it takes up to 249 * 2 * 100ms.
  */
 #define HNS_ROCE_V2_FUNC_CLEAR_TIMEOUT_MSECS	(249 * 2 * 100)
 #define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL	40
-- 
2.8.1

