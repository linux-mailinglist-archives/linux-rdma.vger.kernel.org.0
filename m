Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA9270361
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfGVPOs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:14:48 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:58304 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfGVPOp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:14:45 -0400
Received: from [195.176.96.199] (helo=jupiter)
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
        id 1hpa1N-0008A8-KD; Mon, 22 Jul 2019 17:14:37 +0200
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [PATCH 07/10] Pass the return value of kref_put further
Date:   Mon, 22 Jul 2019 17:14:23 +0200
Message-Id: <20190722151426.5266-8-mplaneta@os.inf.tu-dresden.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Used in a later patch.

Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 3 ++-
 drivers/infiniband/sw/rxe/rxe_pool.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 30a887cf9200..711d7d7f3692 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -541,7 +541,7 @@ static void rxe_dummy_release(struct kref *kref)
 {
 }
 
-void rxe_drop_ref(struct rxe_pool_entry *pelem)
+int rxe_drop_ref(struct rxe_pool_entry *pelem)
 {
 	int res;
 	struct rxe_pool *pool = pelem->pool;
@@ -553,4 +553,5 @@ void rxe_drop_ref(struct rxe_pool_entry *pelem)
 	if (res) {
 		rxe_elem_release(&pelem->ref_cnt);
 	}
+	return res;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index b90cc84c5511..1e3508c74dc0 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -166,6 +166,6 @@ static inline void rxe_add_ref(struct rxe_pool_entry *pelem) {
 }
 
 /* drop a reference on an object */
-void rxe_drop_ref(struct rxe_pool_entry *pelem);
+int rxe_drop_ref(struct rxe_pool_entry *pelem);
 
 #endif /* RXE_POOL_H */
-- 
2.20.1

