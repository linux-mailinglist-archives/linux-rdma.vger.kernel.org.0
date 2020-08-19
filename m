Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C382497CF
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 09:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHSH4w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Aug 2020 03:56:52 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:20542 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgHSH4w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Aug 2020 03:56:52 -0400
Received: from localhost.localdomain (unknown [210.32.144.184])
        by mail-app3 (Coremail) with SMTP id cC_KCgBnS9wy2zxfb4rfAg--.28925S4;
        Wed, 19 Aug 2020 15:56:38 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Zhu Yanjun <yanjunz@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/rxe: Fix memleak in rxe_mem_init_user
Date:   Wed, 19 Aug 2020 15:56:32 +0800
Message-Id: <20200819075632.22285-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgBnS9wy2zxfb4rfAg--.28925S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1rtw4kGw48CFy7Jr1rtFb_yoWxtrc_Ar
        48trZ7XFWFkrnaka17GFnxWry2yws0qr1kX3WqqFyfA34a93Z5Ca4SvFnxCw4UWr4F9FZ8
        ArZrWw4xCFW5CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48J
        MxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7VUbhiSPUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgcLBlZdtPihowAcsR
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When page_address() fails, umem should be freed just
like when rxe_mem_alloc() fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index cdd811a45120..ce24144de16a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -205,6 +205,7 @@ int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
 			vaddr = page_address(sg_page_iter_page(&sg_iter));
 			if (!vaddr) {
 				pr_warn("null vaddr\n");
+				ib_umem_release(umem);
 				err = -ENOMEM;
 				goto err1;
 			}
-- 
2.17.1

