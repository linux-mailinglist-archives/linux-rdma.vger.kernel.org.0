Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE80270353
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfGVPOi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:14:38 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:58252 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfGVPOh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:14:37 -0400
Received: from [195.176.96.199] (helo=jupiter)
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
        id 1hpa1L-00089i-SP; Mon, 22 Jul 2019 17:14:35 +0200
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [PATCH 04/10] Protect kref_put with the lock
Date:   Mon, 22 Jul 2019 17:14:20 +0200
Message-Id: <20190722151426.5266-5-mplaneta@os.inf.tu-dresden.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Need to ensure that kref_put does not run concurrently with the loop
inside rxe_pool_get_key.

Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 18 ++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_pool.h |  4 +---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index efa9bab01e02..30a887cf9200 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -536,3 +536,21 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 	read_unlock_irqrestore(&pool->pool_lock, flags);
 	return node ? elem : NULL;
 }
+
+static void rxe_dummy_release(struct kref *kref)
+{
+}
+
+void rxe_drop_ref(struct rxe_pool_entry *pelem)
+{
+	int res;
+	struct rxe_pool *pool = pelem->pool;
+	unsigned long flags;
+
+	write_lock_irqsave(&pool->pool_lock, flags);
+	res = kref_put(&pelem->ref_cnt, rxe_dummy_release);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+	if (res) {
+		rxe_elem_release(&pelem->ref_cnt);
+	}
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 5c6a9429f541..b90cc84c5511 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -166,8 +166,6 @@ static inline void rxe_add_ref(struct rxe_pool_entry *pelem) {
 }
 
 /* drop a reference on an object */
-static inline void rxe_drop_ref(struct rxe_pool_entry *pelem) {
-	kref_put(&pelem->ref_cnt, rxe_elem_release);
-}
+void rxe_drop_ref(struct rxe_pool_entry *pelem);
 
 #endif /* RXE_POOL_H */
-- 
2.20.1

