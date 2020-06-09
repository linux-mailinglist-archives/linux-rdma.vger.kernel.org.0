Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B921F3B12
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2020 14:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgFIMr4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jun 2020 08:47:56 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54176 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgFIMqX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jun 2020 08:46:23 -0400
Received: from Q.local (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 787005A7;
        Tue,  9 Jun 2020 14:46:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591706777;
        bh=F3Ya/6PQv1SlRbTx4KyzibdoKoXxwCzeytd+fhCKwkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDySORNGnG1mum/ZNj+SeAgtP5e5qLE7lerIUS6G8lIW0rlzBn5tg0A04g0h50g08
         VgXqzuAxVGnCEwaxszxwGexbdxm5jEDbH64LPNeWS8UZkp/3JS1M/kXr4VKNHm1S4b
         85JaNNvIoSy80En3mX8pTLj77i5VWuUqfTYYIwR0=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jiri Kosina <trivial@kernel.org>,
        linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/17] drivers: infiniband: Fix trivial spelling
Date:   Tue,  9 Jun 2020 13:45:55 +0100
Message-Id: <20200609124610.3445662-3-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The word 'descriptor' is misspelled throughout the tree.

Fix it up accordingly:
    decriptors -> descriptors

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/infiniband/hw/hfi1/iowait.h      | 2 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/iowait.h b/drivers/infiniband/hw/hfi1/iowait.h
index 07847cb72169..d580aa17ae37 100644
--- a/drivers/infiniband/hw/hfi1/iowait.h
+++ b/drivers/infiniband/hw/hfi1/iowait.h
@@ -399,7 +399,7 @@ static inline void iowait_get_priority(struct iowait *w)
  * @wait_head: the wait queue
  *
  * This function is called to insert an iowait struct into a
- * wait queue after a resource (eg, sdma decriptor or pio
+ * wait queue after a resource (eg, sdma descriptor or pio
  * buffer) is run out.
  */
 static inline void iowait_queue(bool pkts_sent, struct iowait *w,
diff --git a/drivers/infiniband/hw/hfi1/verbs_txreq.h b/drivers/infiniband/hw/hfi1/verbs_txreq.h
index bfa6e081cb56..d2d526c5a756 100644
--- a/drivers/infiniband/hw/hfi1/verbs_txreq.h
+++ b/drivers/infiniband/hw/hfi1/verbs_txreq.h
@@ -91,7 +91,7 @@ static inline struct verbs_txreq *get_txreq(struct hfi1_ibdev *dev,
 	tx->mr = NULL;
 	tx->sde = priv->s_sde;
 	tx->psc = priv->s_sendcontext;
-	/* so that we can test if the sdma decriptors are there */
+	/* so that we can test if the sdma descriptors are there */
 	tx->txreq.num_desc = 0;
 	/* Set the header type */
 	tx->phdr.hdr.hdr_type = priv->hdr_type;
-- 
2.25.1

