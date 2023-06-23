Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6827073C27C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 23:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjFWVUB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 17:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjFWVTm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 17:19:42 -0400
X-Greylist: delayed 214 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jun 2023 14:18:49 PDT
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719CC3AA4
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8o1B2LX7Hh8TNSfFwUWyg0VffJUQJIzGAe2D6u+TlYM=;
  b=W3acjQz81RgrW6TdUMeb4r5oVbvfBcJvglLvPyOomZw/Gz8zv3C2ybyt
   AQ/zZDn6VqQdCUL//CFztcf75hpwVKw2+UgTxjLTK+AnY3+yTDXwXfmru
   sa5l3mQ45KeFeCJR8op6gb0OOs7TVWJiQ+Tivrh+kEULUahwlkii+ThaU
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686163"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:10 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/26] RDMA/erdma: use array_size
Date:   Fri, 23 Jun 2023 23:14:36 +0200
Message-Id: <20230623211457.102544-6-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230623211457.102544-1-Julia.Lawall@inria.fr>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/infiniband/hw/erdma/erdma_verbs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 83e1b0d55977..c49160f6ff27 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -462,8 +462,8 @@ static int init_kernel_qp(struct erdma_dev *dev, struct erdma_qp *qp,
 		dev->func_bar + (ERDMA_SDB_SHARED_PAGE_INDEX << PAGE_SHIFT);
 	kqp->hw_rq_db = dev->func_bar + ERDMA_BAR_RQDB_SPACE_OFFSET;
 
-	kqp->swr_tbl = vmalloc(qp->attrs.sq_size * sizeof(u64));
-	kqp->rwr_tbl = vmalloc(qp->attrs.rq_size * sizeof(u64));
+	kqp->swr_tbl = vmalloc(array_size(qp->attrs.sq_size, sizeof(u64)));
+	kqp->rwr_tbl = vmalloc(array_size(qp->attrs.rq_size, sizeof(u64)));
 	if (!kqp->swr_tbl || !kqp->rwr_tbl)
 		goto err_out;
 

