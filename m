Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AEA70E110
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 17:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjEWPzH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 May 2023 11:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjEWPzG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 May 2023 11:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE0E8E
        for <linux-rdma@vger.kernel.org>; Tue, 23 May 2023 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684857257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G6+SidhthmUWW0pWZsLmfPzXnfIJfQ1i+Vck8waSr4c=;
        b=ZRipLkNC/NJ0g6FBzZRgEkWIHMNUQgu3oMWSqbZzu6eFGNpAiFefoA+d0503Vz9oP9uP5F
        qc0cBJgq19XMEe8nPIASaiQaDshu6lH5cJ0KFmPyKvEYuapeOtuAT0gSo03dLkQN3YGHVz
        i6Y4x3S9hdk48rtc8lguX4tZ/x4q/34=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-3qNpfRQMMqyGilhX4A6y_g-1; Tue, 23 May 2023 11:54:13 -0400
X-MC-Unique: 3qNpfRQMMqyGilhX4A6y_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 417A61C0A58B;
        Tue, 23 May 2023 15:54:11 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.35.206.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D6B6492B00;
        Tue, 23 May 2023 15:54:09 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, parav@mellanox.com
Subject: [PATCH] Revert "IB/core: Fix use workqueue without WQ_MEM_RECLAIM"
Date:   Tue, 23 May 2023 17:54:08 +0200
Message-Id: <20230523155408.48594-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

when nvme_rdma_reconnect_ctrl_work() fails, it flushes
the ib_addr:process_one_req() work but the latter is enqueued
on addr_wq which has been marked as "!WQ_MEM_RECLAIM".

workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work
[nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]

Call Trace:
__flush_work.isra.0+0xbf/0x230
__cancel_work_timer+0x103/0x190
? rdma_resolve_ip+0x257/0x2f0 [ib_core]
? __dev_printk+0x2d/0x69
rdma_addr_cancel+0x8e/0xc0 [ib_core]
_destroy_id+0x1b/0x270 [rdma_cm]
nvme_rdma_alloc_queue.cold+0x4b/0x5c [nvme_rdma]
nvme_rdma_configure_admin_queue+0x1e/0x2f0 [nvme_rdma]
nvme_rdma_setup_ctrl+0x1e/0x220 [nvme_rdma]
nvme_rdma_reconnect_ctrl_work+0x22/0x30 [nvme_rdma]

This has been introduced by
commit 39baf10310e6 ("IB/core: Fix use workqueue without WQ_MEM_RECLAIM")

Since nvme_rdma_reconnect_work() needs to flush process_one_req(), we
have to restore the WQ_MEM_RECLAIM flag on the addr_wq workqueue.

This reverts commit 39baf10310e6669564a485b55267fae70a4e44ae.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/infiniband/core/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index f253295795f0..5c36d01ebf0b 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -872,7 +872,7 @@ static struct notifier_block nb = {
 
 int addr_init(void)
 {
-	addr_wq = alloc_ordered_workqueue("ib_addr", 0);
+	addr_wq = alloc_ordered_workqueue("ib_addr", WQ_MEM_RECLAIM);
 	if (!addr_wq)
 		return -ENOMEM;
 
-- 
2.39.1

