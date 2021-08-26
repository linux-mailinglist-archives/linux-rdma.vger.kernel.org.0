Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD1E3F85FA
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 12:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhHZLAL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 07:00:11 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:45384 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241878AbhHZLAJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Aug 2021 07:00:09 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2021 07:00:08 EDT
Received: from localhost.localdomain (unknown [202.189.3.195])
        by APP-03 (Coremail) with SMTP id rQCowABnSVJhcidhUlhUAA--.46249S2;
        Thu, 26 Aug 2021 18:52:17 +0800 (CST)
From:   kangning <kangning18z@ict.ac.cn>
To:     linux-rdma@vger.kernel.org
Cc:     kangning <kangning18z@ict.ac.cn>
Subject: [PATCH] Fix one error in mthca_alloc
Date:   Thu, 26 Aug 2021 18:52:15 +0800
Message-Id: <20210826105215.2001-1-kangning18z@ict.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowABnSVJhcidhUlhUAA--.46249S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1rtryDuw4rCFW8AryftFb_yoWfGFc_C3
        W0qFn7Xry5CF1Ikrn3X3WkXa40vw1vgw4xuwn0qry3XFWqgF48Jw1vqFW5u3WxAFy5CF43
        t34UKF4IyrsxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbs8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vEFs4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
        ZEXa7sRveHJUUUUUU==
X-Originating-IP: [202.189.3.195]
X-CM-SenderInfo: pndqw0plqjimn26lu3wodfhubq/1tbiBgcFCl0Tfg7GhQAAsz
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

drivers/infiniband/hw/mthca/mthca_allocator.c: alloc->last left unchanged in mthca_alloc, which
has impact on performance of function find_next_zero_bit in mthca_alloc.

Signed-off-by: kangning <kangning18z@ict.ac.cn>
---
 drivers/infiniband/hw/mthca/mthca_allocator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mthca/mthca_allocator.c b/drivers/infiniband/hw/mthca/mthca_allocator.c
index aef1d274a14e..e81bb0fcd08e 100644
--- a/drivers/infiniband/hw/mthca/mthca_allocator.c
+++ b/drivers/infiniband/hw/mthca/mthca_allocator.c
@@ -51,6 +51,10 @@ u32 mthca_alloc(struct mthca_alloc *alloc)
 	}
 
 	if (obj < alloc->max) {
+		alloc->last = (obj + 1);
+		if (alloc->last == alloc->max) {
+			alloc->last = 0;
+		}
 		set_bit(obj, alloc->table);
 		obj |= alloc->top;
 	} else
-- 
2.17.1

