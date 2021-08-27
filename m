Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8D03F9175
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 02:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbhH0Axk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 20:53:40 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:57626 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243811AbhH0Axk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Aug 2021 20:53:40 -0400
Received: from localhost.localdomain (unknown [202.189.3.195])
        by APP-01 (Coremail) with SMTP id qwCowAAnUtBPNyhh70WtAA--.33361S2;
        Fri, 27 Aug 2021 08:52:32 +0800 (CST)
From:   kangning <kangning18z@ict.ac.cn>
To:     haakon.bugge@oracle.com
Cc:     linux-rdma@vger.kernel.org, kangning <kangning18z@ict.ac.cn>
Subject: [PATCH v3] Fix one error in mthca_alloc
Date:   Fri, 27 Aug 2021 08:52:28 +0800
Message-Id: <20210827005228.15671-1-kangning18z@ict.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowAAnUtBPNyhh70WtAA--.33361S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1rtryDuw4rCFW8AryftFb_yoWfAwb_C3
        W8tFn7ZrW5CF1Iyr1SqF17Za40vr1rKw4xuwnIqry3XFWqgF48Jw1vqrWrua1xAFy5CF43
        t34UtF4IkrsxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIkYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z2
        80aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
        4I1lc2xSY4AK64IkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        XVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x0zEHUDJUUUUU=
X-Originating-IP: [202.189.3.195]
X-CM-SenderInfo: pndqw0plqjimn26lu3wodfhubq/1tbiCQcGCl02ad-GYAABs4
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

drivers/infiniband/hw/mthca/mthca_allocator.c: alloc->last left unchanged in mthca_alloc, which
has impact on performance of function find_next_zero_bit in mthca_alloc.

Signed-off-by: kangning <kangning18z@ict.ac.cn>
---
 
 I squashed two commits into one in this version.
 
 drivers/infiniband/hw/mthca/mthca_allocator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/mthca/mthca_allocator.c b/drivers/infiniband/hw/mthca/mthca_allocator.c
index aef1d274a14e..1141695093e7 100644
--- a/drivers/infiniband/hw/mthca/mthca_allocator.c
+++ b/drivers/infiniband/hw/mthca/mthca_allocator.c
@@ -51,6 +51,9 @@ u32 mthca_alloc(struct mthca_alloc *alloc)
 	}
 
 	if (obj < alloc->max) {
+		alloc->last = obj + 1;
+		if (alloc->last == alloc->max)
+			alloc->last = 0;
 		set_bit(obj, alloc->table);
 		obj |= alloc->top;
 	} else
-- 
2.17.1

