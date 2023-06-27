Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1214173FEC7
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jun 2023 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjF0OqW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jun 2023 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjF0Op2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Jun 2023 10:45:28 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2484D3A96;
        Tue, 27 Jun 2023 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RmZB8noDrpTEgQ34AyoMdB9Dp2s8sUTzrIorMQcMPuE=;
  b=GjCGi63WWIhe+GQ1WuZtY7p1RpJ9Ss04/hj/GygcSrN0F8lf6k6MzF+b
   yzRzNlhLeIjc9mGf96UTSuog/GrBhy16Fk/+6wcK7vSpr21Me+u+A9MQg
   pxRZpNH8xzpyxzYNzf79A1Gii+do3IX74quXSmqOfuQCWgbDHugM5j40T
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="114936337"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:43:52 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     kernel-janitors@vger.kernel.org, keescook@chromium.org,
        christophe.jaillet@wanadoo.fr, kuba@kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/24] RDMA/siw: use vmalloc_array and vcalloc
Date:   Tue, 27 Jun 2023 16:43:29 +0200
Message-Id: <20230627144339.144478-15-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230627144339.144478-1-Julia.Lawall@inria.fr>
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use vmalloc_array and vcalloc to protect against
multiplication overflows.

The changes were done using the following Coccinelle
semantic patch:

// <smpl>
@initialize:ocaml@
@@

let rename alloc =
  match alloc with
    "vmalloc" -> "vmalloc_array"
  | "vzalloc" -> "vcalloc"
  | _ -> failwith "unknown"

@@
    size_t e1,e2;
    constant C1, C2;
    expression E1, E2, COUNT, x1, x2, x3;
    typedef u8;
    typedef __u8;
    type t = {u8,__u8,char,unsigned char};
    identifier alloc = {vmalloc,vzalloc};
    fresh identifier realloc = script:ocaml(alloc) { rename alloc };
@@

(
      alloc(x1*x2*x3)
|
      alloc(C1 * C2)
|
      alloc((sizeof(t)) * (COUNT), ...)
|
-     alloc((e1) * (e2))
+     realloc(e1, e2)
|
-     alloc((e1) * (COUNT))
+     realloc(COUNT, e1)
|
-     alloc((E1) * (E2))
+     realloc(E1, E2)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
v2: Use vmalloc_array and vcalloc instead of array_size.
This also leaves a multiplication of a constant by a sizeof
as is.  Two patches are thus dropped from the series.

 drivers/infiniband/sw/siw/siw_qp.c    |    4 ++--
 drivers/infiniband/sw/siw/siw_verbs.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff -u -p a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -381,7 +381,7 @@ int siw_create_qp(struct ib_qp *ibqp, st
 	if (udata)
 		qp->sendq = vmalloc_user(num_sqe * sizeof(struct siw_sqe));
 	else
-		qp->sendq = vzalloc(num_sqe * sizeof(struct siw_sqe));
+		qp->sendq = vcalloc(num_sqe, sizeof(struct siw_sqe));
 
 	if (qp->sendq == NULL) {
 		rv = -ENOMEM;
@@ -414,7 +414,7 @@ int siw_create_qp(struct ib_qp *ibqp, st
 			qp->recvq =
 				vmalloc_user(num_rqe * sizeof(struct siw_rqe));
 		else
-			qp->recvq = vzalloc(num_rqe * sizeof(struct siw_rqe));
+			qp->recvq = vcalloc(num_rqe, sizeof(struct siw_rqe));
 
 		if (qp->recvq == NULL) {
 			rv = -ENOMEM;
@@ -1624,7 +1624,7 @@ int siw_create_srq(struct ib_srq *base_s
 		srq->recvq =
 			vmalloc_user(srq->num_rqe * sizeof(struct siw_rqe));
 	else
-		srq->recvq = vzalloc(srq->num_rqe * sizeof(struct siw_rqe));
+		srq->recvq = vcalloc(srq->num_rqe, sizeof(struct siw_rqe));
 
 	if (srq->recvq == NULL) {
 		rv = -ENOMEM;
diff -u -p a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -204,7 +204,7 @@ static int siw_qp_readq_init(struct siw_
 {
 	if (irq_size) {
 		irq_size = roundup_pow_of_two(irq_size);
-		qp->irq = vzalloc(irq_size * sizeof(struct siw_sqe));
+		qp->irq = vcalloc(irq_size, sizeof(struct siw_sqe));
 		if (!qp->irq) {
 			qp->attrs.irq_size = 0;
 			return -ENOMEM;
@@ -212,7 +212,7 @@ static int siw_qp_readq_init(struct siw_
 	}
 	if (orq_size) {
 		orq_size = roundup_pow_of_two(orq_size);
-		qp->orq = vzalloc(orq_size * sizeof(struct siw_sqe));
+		qp->orq = vcalloc(orq_size, sizeof(struct siw_sqe));
 		if (!qp->orq) {
 			qp->attrs.orq_size = 0;
 			qp->attrs.irq_size = 0;

