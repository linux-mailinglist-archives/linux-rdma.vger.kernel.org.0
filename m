Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A0B24BBEE
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 14:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgHTMgJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 08:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbgHTMgD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 08:36:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A38FC061385
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 05:36:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so1448211wma.2
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 05:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onz6rUkaqog2urhMD2z4DCKHLOBEtINUq5DnAVAlrcI=;
        b=lS3736QkUN1SZ9O/iAAT7cFgW8OL+cwdax/wiXQQwA+KA78g2I5anpb1WAuju/lr1R
         UJ1eBCnCknmQd5nmtIIwmTZ/Oj8O7qyEwqDwPmNGYWYLZVtRBEJWpR3O1jpZqQaAYLzD
         rB71n0W0SYb7owNPNAb8HguDANYTKvFutChJyzgk45J6BkiWinHerG1FapEVhBwnYgZX
         NKdFGAKKCw5AoWmf5YRVF1Vesdzr7GmAzlgkz/zKAsDCADITdA/zOOSv0u/OG6/5wOpY
         zHvnrDmZ4POtLe+5JOqmihS3ymHqkHTjTkUxsNjOzGh82nMXNC6ud8Pqh/6Ed0Q8gdlY
         JWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onz6rUkaqog2urhMD2z4DCKHLOBEtINUq5DnAVAlrcI=;
        b=BqSdwHpRwkLuna8SVDdAZwQr36l4Af/g0n6UOqnYbGyaHJjl9866OY+cJbZXXFCykB
         IFJZF68oSDREBO0ctZAZxlXG5RJTYjcHBiSybSJyx4WUG82Tfmot89qdDrquBUocxEEQ
         j7b8TwZHKEHhUM1B22aQGeby1l7Nhz8o+WeU9O+s2Ec8NTAE5UiihuUWfzxcSLNKOJ19
         QcPloqRDUXW5IdEyp1Gh8hDLCN3sic9PSYNcBIY7Rnk34Vmxg3QH2StHSgrlzW5HLW0V
         thSMVCYJIHMXEzVqB+jVD1tdaLde197c6jOQ2nx9M5OH4KUos4wzxJ6e14yTN9Mud1Je
         FK+w==
X-Gm-Message-State: AOAM530qTDGxE9YHe9vT807VspY640Ec2F44ibQEdlHLP7+SsEfLjnIz
        4plJJkD/ugjOG/SyTtg+uoxjt8FzrLk=
X-Google-Smtp-Source: ABdhPJxUwLixAZdxzy532EioBUy8qcGaDbqAG+Rt9XnfonIZ7dKmzPusa7DdLHHNOO/pDMG/c4Q6lQ==
X-Received: by 2002:a1c:e0d7:: with SMTP id x206mr3591827wmg.91.1597926957428;
        Thu, 20 Aug 2020 05:35:57 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.0.228])
        by smtp.gmail.com with ESMTPSA id t25sm3813075wmj.18.2020.08.20.05.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 05:35:56 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Adit Ranadive <aditr@vmware.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/vmw_pvrdma: Fix kernel-doc documentation
Date:   Thu, 20 Aug 2020 15:35:12 +0300
Message-Id: <20200820123512.105193-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix the kernel-doc documentation by matching between the functions
definitions and documentation.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c    | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c    | 1 +
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c   | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c | 7 +++----
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
index 4f6cc0de7ef9..01cd122a8b69 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -375,7 +375,7 @@ static int pvrdma_poll_one(struct pvrdma_cq *cq, struct pvrdma_qp **cur_qp,
  * pvrdma_poll_cq - poll for work completion queue entries
  * @ibcq: completion queue
  * @num_entries: the maximum number of entries
- * @entry: pointer to work completion array
+ * @wc: pointer to work completion array
  *
  * @return: number of polled completion entries
  */
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
index 77a010e68208..91f0957e6115 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
@@ -270,6 +270,7 @@ struct ib_mr *pvrdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 /**
  * pvrdma_dereg_mr - deregister a memory region
  * @ibmr: memory region
+ * @udata: pointer to user data
  *
  * @return: 0 on success.
  */
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
index d330decfb80a..f60a8e81bddd 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
@@ -90,7 +90,7 @@ int pvrdma_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr)
 
 /**
  * pvrdma_create_srq - create shared receive queue
- * @pd: protection domain
+ * @ibsrq: the IB shared receive queue
  * @init_attr: shared receive queue attributes
  * @udata: user data
  *
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index ccbded2d26ce..65ac3693ad12 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -502,10 +502,9 @@ void pvrdma_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 
 /**
  * pvrdma_create_ah - create an address handle
- * @pd: the protection domain
- * @ah_attr: the attributes of the AH
- * @udata: user data blob
- * @flags: create address handle flags (see enum rdma_create_ah_flags)
+ * @ibah: the IB address handle
+ * @init_attr: the attributes of the AH
+ * @udata: pointer to user data
  *
  * @return: 0 on success, otherwise errno.
  */
-- 
2.26.2

