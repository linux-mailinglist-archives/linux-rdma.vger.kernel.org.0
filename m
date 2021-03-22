Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DC1344AD0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 17:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhCVQN7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 12:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhCVQNd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 12:13:33 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8C2BC061574;
        Mon, 22 Mar 2021 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=lZ3vynHBoX
        NDbgzdI1fv77EAJHK6JfqpGU0MgGMY61I=; b=bKnQihNPjvF+27zLc6bdF4zXkQ
        KAXXKheMFhVHxKX1JuFFrwNytbUCq27sOM5gXlCCvVH4j5aMN9+bxBKchja+ac4Q
        fdH7ML5Cn1G/fTXZ+4baluktsIRc4sQ2l3FE47NFrmp0O6fnjS+6cL8AqyOP6PEi
        ezcbApxd5QcE67Z/c=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCXnUkowlhgrbcOAA--.5619S4;
        Tue, 23 Mar 2021 00:13:28 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     sagi@grimberg.me, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH v2] infiniband: Fix a use after free in isert_connect_request
Date:   Mon, 22 Mar 2021 09:13:25 -0700
Message-Id: <20210322161325.7491-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygCXnUkowlhgrbcOAA--.5619S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1UAw1DCr18tF1kAF13Arb_yoW8Zw17pr
        47A3s5KrWDKrn8G3W2v3yDXF4j9w4kJ3WDKry7tw15CanIya43AFWrGa4Utrn8Jr1rGFs7
        XFWUJ3Z5GF1DGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUUVWlDUUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The device is got by isert_device_get() with refcount is 1,
and is assigned to isert_conn by isert_conn->device = device.
When isert_create_qp() failed, device will be freed with
isert_device_put().

Later, the device is used in isert_free_login_buf(isert_conn)
by the isert_conn->device->ib_device statement. This patch
free the device in the correct order.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 7305ed8976c2..18266f07c58d 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -438,23 +438,23 @@ isert_connect_request(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
 	isert_init_conn(isert_conn);
 	isert_conn->cm_id = cma_id;
 
-	ret = isert_alloc_login_buf(isert_conn, cma_id->device);
-	if (ret)
-		goto out;
-
 	device = isert_device_get(cma_id);
 	if (IS_ERR(device)) {
 		ret = PTR_ERR(device);
-		goto out_rsp_dma_map;
+		goto out;
 	}
 	isert_conn->device = device;
 
+	ret = isert_alloc_login_buf(isert_conn, cma_id->device);
+	if (ret)
+		goto out_conn_dev;
+
 	isert_set_nego_params(isert_conn, &event->param.conn);
 
 	isert_conn->qp = isert_create_qp(isert_conn, cma_id);
 	if (IS_ERR(isert_conn->qp)) {
 		ret = PTR_ERR(isert_conn->qp);
-		goto out_conn_dev;
+		goto out_rsp_dma_map;
 	}
 
 	ret = isert_login_post_recv(isert_conn);
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


