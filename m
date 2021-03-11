Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E35C336A27
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 03:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCKCaZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Mar 2021 21:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhCKCaB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Mar 2021 21:30:01 -0500
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 Mar 2021 18:30:00 PST
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DE9DC061574
        for <linux-rdma@vger.kernel.org>; Wed, 10 Mar 2021 18:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=8vVaM3fkgb
        ix9fBLTZie1hJ57yzxZgTlG9N1TyuMbkM=; b=A+2p8Is1McTE1BLzFgxDj9dWKJ
        LEGQB6weqhveNHW5waB7ipZr7kbWvam1f0nKIjpZCyZorF1ZyutmwMKqlmTfEoXV
        45bu0auzGRv3sIPbs5cnoVVt0cwpuCAvKs/JKjV9wRl0PHHKUnSmA59ciHLVuPY+
        F2nyPN/JFDQOWOTKg=
Received: from ubuntu.localdomain (unknown [114.214.226.60])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCHjuLHfklg4IwIAA--.490S4;
        Thu, 11 Mar 2021 10:21:59 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] infiniband/core: Fix a use after free in cm_work_handler
Date:   Wed, 10 Mar 2021 18:21:53 -0800
Message-Id: <20210311022153.3757-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygCHjuLHfklg4IwIAA--.490S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4DAFWxArWrZF4DXFyxZrb_yoWDuFX_Wr
        4FgrnrJr1fCF92kr1UuFWxZryS9r4vq3s5u3Wktry5t342krnrCr1xZwsrZw4UXr4Fkanx
        AF9rJr95Cr1DCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0D
        UUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In cm_work_handler, it calls destory_cm_id() to release
the initial reference of cm_id_priv taken by iw_create_cm_id()
and free the cm_id_priv. After destory_cm_id(), iwcm_deref_id
(cm_id_priv) will be called and cause a use after free.

Fixes: 59c68ac31e15a ("iw_cm: free cm_id resources on the last deref")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/infiniband/core/iwcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index da8adadf4755..cb6b4ac45e21 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -1035,8 +1035,10 @@ static void cm_work_handler(struct work_struct *_work)
 
 		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
 			ret = process_event(cm_id_priv, &levent);
-			if (ret)
+			if (ret) {
 				destroy_cm_id(&cm_id_priv->id);
+				return;
+			}
 		} else
 			pr_debug("dropping event %d\n", levent.event);
 		if (iwcm_deref_id(cm_id_priv))
-- 
2.25.1


