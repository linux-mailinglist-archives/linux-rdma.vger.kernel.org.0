Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664514D6729
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Mar 2022 18:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbiCKRHd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Mar 2022 12:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiCKRHc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Mar 2022 12:07:32 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 79A0EA9954;
        Fri, 11 Mar 2022 09:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=yUZNbj+mFhT5GgO79ZxbHQUCuPOmg45HEXuYwzHNgEQ=; b=b
        l/cLrUP11fdJ1KL0f/zCeNs45kBab316RJZzweydFKgIjSVXNqho32NsLjH0ve9A
        /RZchKdCA2om0oiyAbT2Y+yOGqw4uLEOQE3yjfEBQdUzaMXMpwfZSzgu0qUySYF/
        5zouxF5FDVmluiyyPDhzDEvCE6wfjQ+hpcgfuY9eB8=
Received: from localhost (unknown [10.129.21.144])
        by front01 (Coremail) with SMTP id 5oFpogA3P1N7gStiYnwIAA--.11214S2;
        Sat, 12 Mar 2022 01:06:03 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     leon@kernel.org, jgg@ziepe.ca, yishaih@mellanox.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuyq@stu.pku.edu.cn, Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] RDMA/mlx5: Fix memory leak
Date:   Fri, 11 Mar 2022 09:06:01 -0800
Message-Id: <1647018361-18266-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 5oFpogA3P1N7gStiYnwIAA--.11214S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr48Ww4kWw18ur48GFWUCFg_yoWDGrb_Gr
        1qv3s7Xa45AFnakryDCrs7WryI9r4UWw1xXr1vg3Wak393CayUCa9aqF9Yvw17JrWYgFyj
        yrnFkr1xAw4FgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbx8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
        jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48J
        MxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwESBlPy7ubR6QAjsk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[why]
xa_insert is failed, so caller of subscribe_event_xa_alloc
cannot call other function to free obj_event. Therefore,
Resource release is needed on the error handling path to
prevent memory leak.

[how]
Fix this by adding kfree on the error handling path.

Fixes: 7597385 ("IB/mlx5: Enable subscription for device events over DEVX")

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/infiniband/hw/mlx5/devx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 08b7f6b..15c0884 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1886,8 +1886,10 @@ subscribe_event_xa_alloc(struct mlx5_devx_event_table *devx_event_table,
 				key_level2,
 				obj_event,
 				GFP_KERNEL);
-		if (err)
+		if (err) {
+			kfree(obj_event);
 			return err;
+		}
 		INIT_LIST_HEAD(&obj_event->obj_sub_list);
 	}
 
-- 
2.7.4

