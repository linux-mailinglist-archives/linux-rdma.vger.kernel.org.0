Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C454D7993
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Mar 2022 04:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiCNDLy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Mar 2022 23:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbiCNDLx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Mar 2022 23:11:53 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 92B733EABE;
        Sun, 13 Mar 2022 20:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References; bh=/6HzUGy06hM2SDuTzHlFmrQwBi
        rbmZfP+pzDHCHdknA=; b=Mfgv3i4PImablT+GvCk8FF1KkVJiKCkLs/Bn15Yeo5
        FZA398umSSerAMR0EnXfgLcRWcIBzLbvOcmb1moWvwVQwq1jLijZuvBTBtAgeP+w
        3KUNWCmY/WrZqrWEka/AENorGIjXtJMauyylXLZtLKf00fzXWyvCaY5jrBln3SjT
        E=
Received: from localhost (unknown [10.129.21.144])
        by front01 (Coremail) with SMTP id 5oFpogD3VoQssi5iY9kqAA--.1912S2;
        Mon, 14 Mar 2022 11:10:36 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     leon@kernel.org
Cc:     yishaih@mellanox.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH v2] RDMA/mlx5: Fix memory leak in error subscribe event routine
Date:   Sun, 13 Mar 2022 20:10:35 -0700
Message-Id: <1647227435-46416-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <Yi5A0AkiVTLfkYFM@unreal>
References: <Yi5A0AkiVTLfkYFM@unreal>
X-CM-TRANSID: 5oFpogD3VoQssi5iY9kqAA--.1912S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw18urW7GF17Cr4DJF18Zrb_yoWfJrc_WF
        1qv397Xa45CFn5Cr9rCrs3WryI9r4UWw1xXan2gasIk3y3Ca13Ca9aqFZYvw47JrW5KryY
        yr9FyryxAw4FgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2z280
        aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07
        x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k2
        0xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwESBlPy7ubR6QAxs2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In case second xa_insert() fails, the obj_event is not released.
Fix the error unwind flow to free that memory to avoid memory leak.

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

