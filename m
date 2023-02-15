Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F769798B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Feb 2023 11:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjBOKLC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Feb 2023 05:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBOKLC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Feb 2023 05:11:02 -0500
Received: from exchange.fintech.ru (e10edge.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5A3BBBB;
        Wed, 15 Feb 2023 02:10:58 -0800 (PST)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 15 Feb
 2023 13:10:48 +0300
Received: from KANASHIN1.fintech.ru (10.0.253.125) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 15 Feb
 2023 13:10:48 +0300
From:   Natalia Petrova <n.petrova@fintech.ru>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Natalia Petrova <n.petrova@fintech.ru>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
Subject: [PATCH] ocrdma: Fix potential null-ptr-deref in ocrdma_is_qp_in_rq_flushlist()
Date:   Wed, 15 Feb 2023 13:10:45 +0300
Message-ID: <20230215101045.476291-1-n.petrova@fintech.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.125]
X-ClientProxiedBy: Ex16-01.fintech.ru (10.0.10.18) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The 'qp->rq_cq' pointer can be equal to null in ocrdma_destroy_qp()
function. That's why 'qp->rq_cq' should be checked for null in
ocrdma_del_flush_qp() before it will be dereferenced in
ocrdma_is_qp_in_rq_flushlist().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: fe2caefcdf58 ("RDMA/ocrdma: Add driver for Emulex OneConnect IBoE RDMA adapter")
Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index dd4021b11963..a3d994ee178c 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1660,7 +1660,7 @@ void ocrdma_del_flush_qp(struct ocrdma_qp *qp)
 	found = ocrdma_is_qp_in_sq_flushlist(qp->sq_cq, qp);
 	if (found)
 		list_del(&qp->sq_entry);
-	if (!qp->srq) {
+	if (!qp->srq && qp->rq_cq) {
 		found = ocrdma_is_qp_in_rq_flushlist(qp->rq_cq, qp);
 		if (found)
 			list_del(&qp->rq_entry);
-- 
2.34.1

