Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF1B73C293
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 23:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjFWVVZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 17:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjFWVVJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 17:21:09 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E6630F3
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BOvAIPV5b2s9XXgIiUCDYijQMWfGXsngYuXLkntqOho=;
  b=oBORICMjMDk+FYpoVEcjGxoLDyziR5NvwJoDKLiolbwFfa3Z4eFHZSHL
   3pG0TVOrluOqz7J/IM5bq1h1zIS7MSBXvaH4CZLEPk5H/3YJyn9/lUOID
   kTMHVnE51EZb+5cjH5miFKu9o0CoNvS2Z/vQfu4QQczhF8KbVHXdbHf5t
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686172"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:12 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/26] RDMA/siw: use array_size
Date:   Fri, 23 Jun 2023 23:14:45 +0200
Message-Id: <20230623211457.102544-15-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230623211457.102544-1-Julia.Lawall@inria.fr>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use array_size to protect against multiplication overflows.

The changes were done using the following Coccinelle semantic patch:

// <smpl>
@@
    expression E1, E2;
    constant C1, C2;
    identifier alloc = {vmalloc,vzalloc};
@@
    
(
      alloc(C1 * C2,...)
|
      alloc(
-           (E1) * (E2)
+           array_size(E1, E2)
      ,...)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/infiniband/sw/siw/siw_qp.c    |    4 ++--
 drivers/infiniband/sw/siw/siw_verbs.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 81e9bbd9ebda..32ec85af0314 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -204,7 +204,7 @@ static int siw_qp_readq_init(struct siw_qp *qp, int irq_size, int orq_size)
 {
 	if (irq_size) {
 		irq_size = roundup_pow_of_two(irq_size);
-		qp->irq = vzalloc(irq_size * sizeof(struct siw_sqe));
+		qp->irq = vzalloc(array_size(irq_size, sizeof(struct siw_sqe)));
 		if (!qp->irq) {
 			qp->attrs.irq_size = 0;
 			return -ENOMEM;
@@ -212,7 +212,7 @@ static int siw_qp_readq_init(struct siw_qp *qp, int irq_size, int orq_size)
 	}
 	if (orq_size) {
 		orq_size = roundup_pow_of_two(orq_size);
-		qp->orq = vzalloc(orq_size * sizeof(struct siw_sqe));
+		qp->orq = vzalloc(array_size(orq_size, sizeof(struct siw_sqe)));
 		if (!qp->orq) {
 			qp->attrs.orq_size = 0;
 			qp->attrs.irq_size = 0;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 398ec13db624..ddf83b638cb0 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -381,7 +381,7 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	if (udata)
 		qp->sendq = vmalloc_user(num_sqe * sizeof(struct siw_sqe));
 	else
-		qp->sendq = vzalloc(num_sqe * sizeof(struct siw_sqe));
+		qp->sendq = vzalloc(array_size(num_sqe, sizeof(struct siw_sqe)));
 
 	if (qp->sendq == NULL) {
 		rv = -ENOMEM;
@@ -414,7 +414,7 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 			qp->recvq =
 				vmalloc_user(num_rqe * sizeof(struct siw_rqe));
 		else
-			qp->recvq = vzalloc(num_rqe * sizeof(struct siw_rqe));
+			qp->recvq = vzalloc(array_size(num_rqe, sizeof(struct siw_rqe)));
 
 		if (qp->recvq == NULL) {
 			rv = -ENOMEM;
@@ -1624,7 +1624,7 @@ int siw_create_srq(struct ib_srq *base_srq,
 		srq->recvq =
 			vmalloc_user(srq->num_rqe * sizeof(struct siw_rqe));
 	else
-		srq->recvq = vzalloc(srq->num_rqe * sizeof(struct siw_rqe));
+		srq->recvq = vzalloc(array_size(srq->num_rqe, sizeof(struct siw_rqe)));
 
 	if (srq->recvq == NULL) {
 		rv = -ENOMEM;

