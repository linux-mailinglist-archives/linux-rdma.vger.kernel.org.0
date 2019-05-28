Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3016B2C6EE
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 14:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfE1MrA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 08:47:00 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:24017 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfE1MrA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 08:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559047619; x=1590583619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kWhBaMbNPVsQiz5HPrrc5L03DAvWaAYHGlhTn02lzDY=;
  b=mtw4mUdsBz10V5I67tm17eeFLSfyurLjPxdGuUmTX+18n4Md3bVQ1/iP
   5Cb3/2MFT2tKogUINFqCxL1DmO7oLU6hs+YpPt6aPVRMU2c7lfEYtbyzg
   OBsvRFdlM7YH1dGQb7nXmqsHkdWI5EeF2OEgONUH4Q8YXDl3ulyOszJ9a
   E=;
X-IronPort-AV: E=Sophos;i="5.60,523,1549929600"; 
   d="scan'208";a="676767377"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 May 2019 12:46:58 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x4SCkvRS084982
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 28 May 2019 12:46:58 GMT
Received: from EX13D19EUA003.ant.amazon.com (10.43.165.175) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:46:57 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUA003.ant.amazon.com (10.43.165.175) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:46:56 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.129) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 28 May 2019 12:46:53 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-rc 3/6] RDMA/efa: Remove unneeded admin commands abort flow
Date:   Tue, 28 May 2019 15:46:15 +0300
Message-ID: <20190528124618.77918-4-galpress@amazon.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528124618.77918-1-galpress@amazon.com>
References: <20190528124618.77918-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The admin commands abort flow is buggy (use-after-free) and not really
necessary as it is guaranteed that after ib_unregister_device() is
called there are no user verbs threads running in parallel, delete it.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c | 74 +----------------------------
 drivers/infiniband/hw/efa/efa_com.h |  1 -
 2 files changed, 1 insertion(+), 74 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index a5c788741a04..ec04ced9fd2b 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -39,8 +39,6 @@
 enum efa_cmd_status {
 	EFA_CMD_SUBMITTED,
 	EFA_CMD_COMPLETED,
-	/* Abort - canceled by the driver */
-	EFA_CMD_ABORTED,
 };
 
 struct efa_comp_ctx {
@@ -532,16 +530,6 @@ static int efa_com_wait_and_process_admin_cq_polling(struct efa_comp_ctx *comp_c
 		msleep(aq->poll_interval);
 	}
 
-	if (comp_ctx->status == EFA_CMD_ABORTED) {
-		ibdev_err(aq->efa_dev, "Command was aborted\n");
-		atomic64_inc(&aq->stats.aborted_cmd);
-		err = -ENODEV;
-		goto out;
-	}
-
-	WARN_ONCE(comp_ctx->status != EFA_CMD_COMPLETED,
-		  "Invalid completion status %d\n", comp_ctx->status);
-
 	err = efa_com_comp_status_to_errno(comp_ctx->comp_status);
 out:
 	efa_com_put_comp_ctx(aq, comp_ctx);
@@ -665,66 +653,6 @@ int efa_com_cmd_exec(struct efa_com_admin_queue *aq,
 	return err;
 }
 
-/**
- * efa_com_abort_admin_commands - Abort all the outstanding admin commands.
- * @edev: EFA communication layer struct
- *
- * This method aborts all the outstanding admin commands.
- * The caller should then call efa_com_wait_for_abort_completion to make sure
- * all the commands were completed.
- */
-static void efa_com_abort_admin_commands(struct efa_com_dev *edev)
-{
-	struct efa_com_admin_queue *aq = &edev->aq;
-	struct efa_comp_ctx *comp_ctx;
-	unsigned long flags;
-	u16 i;
-
-	spin_lock(&aq->sq.lock);
-	spin_lock_irqsave(&aq->cq.lock, flags);
-	for (i = 0; i < aq->depth; i++) {
-		comp_ctx = efa_com_get_comp_ctx(aq, i, false);
-		if (!comp_ctx)
-			break;
-
-		comp_ctx->status = EFA_CMD_ABORTED;
-
-		complete(&comp_ctx->wait_event);
-	}
-	spin_unlock_irqrestore(&aq->cq.lock, flags);
-	spin_unlock(&aq->sq.lock);
-}
-
-/**
- * efa_com_wait_for_abort_completion - Wait for admin commands abort.
- * @edev: EFA communication layer struct
- *
- * This method wait until all the outstanding admin commands will be completed.
- */
-static void efa_com_wait_for_abort_completion(struct efa_com_dev *edev)
-{
-	struct efa_com_admin_queue *aq = &edev->aq;
-	int i;
-
-	/* all mine */
-	for (i = 0; i < aq->depth; i++)
-		down(&aq->avail_cmds);
-
-	/* let it go */
-	for (i = 0; i < aq->depth; i++)
-		up(&aq->avail_cmds);
-}
-
-static void efa_com_admin_flush(struct efa_com_dev *edev)
-{
-	struct efa_com_admin_queue *aq = &edev->aq;
-
-	clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
-
-	efa_com_abort_admin_commands(edev);
-	efa_com_wait_for_abort_completion(edev);
-}
-
 /**
  * efa_com_admin_destroy - Destroy the admin and the async events queues.
  * @edev: EFA communication layer struct
@@ -737,7 +665,7 @@ void efa_com_admin_destroy(struct efa_com_dev *edev)
 	struct efa_com_admin_sq *sq = &aq->sq;
 	u16 size;
 
-	efa_com_admin_flush(edev);
+	clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
 
 	devm_kfree(edev->dmadev, aq->comp_ctx_pool);
 	devm_kfree(edev->dmadev, aq->comp_ctx);
diff --git a/drivers/infiniband/hw/efa/efa_com.h b/drivers/infiniband/hw/efa/efa_com.h
index 84d96724a74b..c67dd8109d1c 100644
--- a/drivers/infiniband/hw/efa/efa_com.h
+++ b/drivers/infiniband/hw/efa/efa_com.h
@@ -45,7 +45,6 @@ struct efa_com_admin_sq {
 
 /* Don't use anything other than atomic64 */
 struct efa_com_stats_admin {
-	atomic64_t aborted_cmd;
 	atomic64_t submitted_cmd;
 	atomic64_t completed_cmd;
 	atomic64_t no_completion;
-- 
2.21.0

