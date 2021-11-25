Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C868745E12F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 20:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbhKYT6g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 14:58:36 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:57591 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbhKYT4g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Nov 2021 14:56:36 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id qKo6mbfFjqYovqKo7mK7mm; Thu, 25 Nov 2021 20:53:23 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 25 Nov 2021 20:53:23 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] IB/hfi1: Use bitmap_zalloc() when applicable
Date:   Thu, 25 Nov 2021 20:53:22 +0100
Message-Id: <d46c6bc1869b8869244fa71943d2cad4104b3668.1637869925.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid some
open-coded arithmetic in allocator arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/hfi1/user_sdma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 5b11c8282744..a71c5a36ceba 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -161,9 +161,7 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 	if (!pq->reqs)
 		goto pq_reqs_nomem;
 
-	pq->req_in_use = kcalloc(BITS_TO_LONGS(hfi1_sdma_comp_ring_size),
-				 sizeof(*pq->req_in_use),
-				 GFP_KERNEL);
+	pq->req_in_use = bitmap_zalloc(hfi1_sdma_comp_ring_size, GFP_KERNEL);
 	if (!pq->req_in_use)
 		goto pq_reqs_no_in_use;
 
@@ -210,7 +208,7 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 cq_nomem:
 	kmem_cache_destroy(pq->txreq_cache);
 pq_txreq_nomem:
-	kfree(pq->req_in_use);
+	bitmap_free(pq->req_in_use);
 pq_reqs_no_in_use:
 	kfree(pq->reqs);
 pq_reqs_nomem:
@@ -257,7 +255,7 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
 			pq->wait,
 			!atomic_read(&pq->n_reqs));
 		kfree(pq->reqs);
-		kfree(pq->req_in_use);
+		bitmap_free(pq->req_in_use);
 		kmem_cache_destroy(pq->txreq_cache);
 		flush_pq_iowait(pq);
 		kfree(pq);
-- 
2.30.2

