Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7A6344649
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 14:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCVNyj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 09:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhCVNyO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 09:54:14 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75C81C061574;
        Mon, 22 Mar 2021 06:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=ZvmwOEawDG
        9M5i/TCmUlPJq/nlotbbYqY4IROl3iLcs=; b=MsAu2As48t7p5V+VsuWkAZNDW9
        CNfx49DqNX7ItZhn+weTD63uPJoK9ZTk9RCg2R3f0Hw+wiXidHJvLE8Ib3pX42ny
        FUyPusGxKYDRK9B/ACoKf3ys9G9n528aqkD8OP9YL8D20529A3Taja/GadMOfkIe
        gUtS1+3h8/z+OYP9I=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDX36d2oVhglAQOAA--.4840S4;
        Mon, 22 Mar 2021 21:53:58 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     sagi@grimberg.me, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] infiniband: Fix a use after free in isert_connect_request
Date:   Mon, 22 Mar 2021 06:53:55 -0700
Message-Id: <20210322135355.5720-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygDX36d2oVhglAQOAA--.4840S4
X-Coremail-Antispam: 1UD129KBjvJXoW7GF43KrykKFy3tr48Aw18Zrb_yoW8Jry5pF
        1DAr9YkrWDKr1UGa17ZrWDXFWYga1kAa4DKry2yw1YkFsIya4IyrWUC34Utr1UJr1fGFnr
        XFWUJa95CF4kJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUjkhLUUUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The device is got by isert_device_get() with refcount is 1,
and is assigned to isert_conn by isert_conn->device = device.
When isert_create_qp() failed, device will be freed with
isert_device_put().

Later, the device is used in isert_free_login_buf(isert_conn)
by the isert_conn->device->ib_device statement. My patch
exchanges the callees order to free the device late.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 7305ed8976c2..d8a533e346b0 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -473,10 +473,10 @@ isert_connect_request(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
 
 out_destroy_qp:
 	isert_destroy_qp(isert_conn);
-out_conn_dev:
-	isert_device_put(device);
 out_rsp_dma_map:
 	isert_free_login_buf(isert_conn);
+out_conn_dev:
+	isert_device_put(device);
 out:
 	kfree(isert_conn);
 	rdma_reject(cma_id, NULL, 0, IB_CM_REJ_CONSUMER_DEFINED);
-- 
2.25.1


