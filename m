Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D5D1A66E6
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 15:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgDMNX3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 09:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729816AbgDMNX2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 09:23:28 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AD442075E;
        Mon, 13 Apr 2020 13:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586784207;
        bh=TbC05SrXmLprzLXIS3HtLQDJo9IdaoEWoVrlCwFXbxw=;
        h=From:To:Cc:Subject:Date:From;
        b=UpK/4UYN9p2ZjtiKr8gwvztIVBhGsUkb8fbWQs+lsty3yEEe0TTDqfujiD8lCvrJE
         iXPsce1rEVmCLIBUj56Pqucp/05zLGjHR1yGzZNxKpfnoV0AjyfLU7XU877kXr1Ifb
         WSrWpws9QbJ4gxRhv74zvomxUJx3RHIEV9/K4M2o=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/cma: Limit the scope of rdma_is_consumer_reject function
Date:   Mon, 13 Apr 2020 16:23:23 +0300
Message-Id: <20200413132323.930869-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The function is local to cma.c, so let's limit its scope.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 3 +--
 include/rdma/rdma_cm.h        | 8 --------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 26e6f7df247b..1fbb0841d047 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -91,7 +91,7 @@ const char *__attribute_const__ rdma_reject_msg(struct rdma_cm_id *id,
 }
 EXPORT_SYMBOL(rdma_reject_msg);
 
-bool rdma_is_consumer_reject(struct rdma_cm_id *id, int reason)
+static bool rdma_is_consumer_reject(struct rdma_cm_id *id, int reason)
 {
 	if (rdma_ib_or_roce(id->device, id->port_num))
 		return reason == IB_CM_REJ_CONSUMER_DEFINED;
@@ -102,7 +102,6 @@ bool rdma_is_consumer_reject(struct rdma_cm_id *id, int reason)
 	WARN_ON_ONCE(1);
 	return false;
 }
-EXPORT_SYMBOL(rdma_is_consumer_reject);
 
 const void *rdma_consumer_reject_data(struct rdma_cm_id *id,
 				      struct rdma_cm_event *ev, u8 *data_len)
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 71f48cfdc24c..ea8e794785ed 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -389,14 +389,6 @@ __be64 rdma_get_service_id(struct rdma_cm_id *id, struct sockaddr *addr);
  */
 const char *__attribute_const__ rdma_reject_msg(struct rdma_cm_id *id,
 						int reason);
-/**
- * rdma_is_consumer_reject - return true if the consumer rejected the connect
- *                           request.
- * @id: Communication identifier that received the REJECT event.
- * @reason: Value returned in the REJECT event status field.
- */
-bool rdma_is_consumer_reject(struct rdma_cm_id *id, int reason);
-
 /**
  * rdma_consumer_reject_data - return the consumer reject private data and
  *			       length, if any.
-- 
2.25.2

