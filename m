Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E0C3CE72A
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 19:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347605AbhGSQXr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 12:23:47 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:50366 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243107AbhGSQVp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jul 2021 12:21:45 -0400
Received: from localhost.localdomain ([80.15.159.30])
        by mwinf5d82 with ME
        id X52H2500Q0feRjk0352JKU; Mon, 19 Jul 2021 19:02:19 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Jul 2021 19:02:19 +0200
X-ME-IP: 80.15.159.30
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA/irdma: Improve the way 'cqp_request' structures are cleaned when they are recycled
Date:   Mon, 19 Jul 2021 19:02:15 +0200
Message-Id: <7f93f2a2c2fd18ddfeb99339d175b85ffd1c6398.1626713915.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A set of IRDMA_CQP_SW_SQSIZE_2048 (i.e. 2048) 'cqp_request' are
pre-allocated and zeroed in 'irdma_create_cqp()' (hw.c).  These
structures are managed with the 'cqp->cqp_avail_reqs' list which keeps
track of available entries.

In 'irdma_free_cqp_request()' (utils.c), when an entry is recycled and goes
back to the 'cqp_avail_reqs' list, some fields are reseted.

However, one of these fields, 'compl_info', is initialized within
'irdma_alloc_and_get_cqp_request()'.

Move the corresponding memset to 'irdma_free_cqp_request()' so that the
clean-up is done in only one place. This makes the logic more easy to
understand.

This also saves this memset in the case that the 'cqp_avail_reqs' list is
empty and a new 'cqp_request' structure must be allocated. This memset is
useless, because the structure is already kzalloc'ed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/irdma/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 5bbe44e54f9a..66711024d38b 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -445,7 +445,6 @@ struct irdma_cqp_request *irdma_alloc_and_get_cqp_request(struct irdma_cqp *cqp,
 
 	cqp_request->waiting = wait;
 	refcount_set(&cqp_request->refcnt, 1);
-	memset(&cqp_request->compl_info, 0, sizeof(cqp_request->compl_info));
 
 	return cqp_request;
 }
@@ -475,6 +474,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
 		cqp_request->request_done = false;
 		cqp_request->callback_fcn = NULL;
 		cqp_request->waiting = false;
+		memset(&cqp_request->compl_info, 0, sizeof(cqp_request->compl_info));
 
 		spin_lock_irqsave(&cqp->req_lock, flags);
 		list_add_tail(&cqp_request->list, &cqp->cqp_avail_reqs);
-- 
2.30.2

