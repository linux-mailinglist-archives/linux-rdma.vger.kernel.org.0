Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9528D149B0F
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 15:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbgAZO1T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 09:27:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387401AbgAZO1T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 09:27:19 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B91220720;
        Sun, 26 Jan 2020 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580048839;
        bh=p5uFWleGZqGJ3+V/SQ0aOLEdDvS9nk5CJ+orU2vI5T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isfkyFXHiS0f3xuVKDneFg4GwLBRKLqPhKwNrH5lKt74fNOHY2d76rKavRa2Tv0r9
         yeFpbO+OJdXlG/7yiS6mwYw4bTG7cOJQFpwnCxGQko3eSklOpCTkqRNkNAAGrBo7i8
         lGAkdORvUiMJyLfvy3oNxBXv7e1twR7soscAAFRg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 5/7] RDMA/cma: Use refcount API to reflect refcount
Date:   Sun, 26 Jan 2020 16:26:50 +0200
Message-Id: <20200126142652.104803-6-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200126142652.104803-1-leon@kernel.org>
References: <20200126142652.104803-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Use the refcount variant to capture the reference counting of the cma
device structure.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 7e16d1b001ff..a5fd44194d77 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -199,7 +199,7 @@ struct cma_device {
 	struct list_head	list;
 	struct ib_device	*device;
 	struct completion	comp;
-	atomic_t		refcount;
+	refcount_t refcount;
 	struct list_head	id_list;
 	enum ib_gid_type	*default_gid_type;
 	u8			*default_roce_tos;
@@ -249,12 +249,12 @@ enum {
 
 void cma_dev_get(struct cma_device *cma_dev)
 {
-	atomic_inc(&cma_dev->refcount);
+	refcount_inc(&cma_dev->refcount);
 }
 
 void cma_dev_put(struct cma_device *cma_dev)
 {
-	if (atomic_dec_and_test(&cma_dev->refcount))
+	if (refcount_dec_and_test(&cma_dev->refcount))
 		complete(&cma_dev->comp);
 }
 
@@ -4657,7 +4657,7 @@ static void cma_add_one(struct ib_device *device)
 	}
 
 	init_completion(&cma_dev->comp);
-	atomic_set(&cma_dev->refcount, 1);
+	refcount_set(&cma_dev->refcount, 1);
 	INIT_LIST_HEAD(&cma_dev->id_list);
 	ib_set_client_data(device, &cma_client, cma_dev);
 
-- 
2.24.1

