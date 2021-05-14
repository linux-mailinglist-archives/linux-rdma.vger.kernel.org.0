Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8C380D4C
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 17:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhENPhW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 May 2021 11:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhENPhV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 May 2021 11:37:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E404C061574;
        Fri, 14 May 2021 08:36:10 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x8so29099917qkl.2;
        Fri, 14 May 2021 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Opk4YA82Psd+Q8mksl+F6kI1x1kOPzJPFBLRaMr3inM=;
        b=HbSouYzy/VvObF2hulJDRCyga4Hzp06qrS38Fe5GTOtkkgcxwYz0Ocnma95BPT203l
         snul+DqjvD4YCjVDej53RKpUu4FuYleTN/XRM0Rrc0KGbdMHOoDJbttKTGUb/mSfeswD
         zTbpo+F4/Y00qsGzn0MX+vC93hlMVWhI7qd0JxO7WLiHPGWApotMXFDx6SoRZ5wbOFZL
         hGwWs//FyXzj9f1use0roejhdBeSejuFKFAkIeN5efRXTWKXmU3XAWOwjS5JjiQ4AZzD
         4QicjagwwpWsvYRYHBIkbr1b2dBbzaDKvbbeHCfMTRRZ3cicKnq8+gAnLCgit5Fyk+Ul
         ImkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Opk4YA82Psd+Q8mksl+F6kI1x1kOPzJPFBLRaMr3inM=;
        b=bul0l1SgmVq+ogP8EHoFXj204Br+MfJWix82Kle+0wsRestGkqhZGx/XSXhWUzJfl0
         +Ii0ltRaXEttgaiwJCpsWpQAhENokN7C44wTmFGouH5k6GehDSOi5PB41W0q/uZ2gs6Y
         Z953J+2l+g1hoa3DCU2HH8b9r8vUnpHb0a9+/ZLgBVm0gfLjZz+Ux3ti/VWHV9AGlmyt
         OkJCtWmJd4EiLknIRHVfHM2v8Ac/x6RjQ8mzkoagtWbS+DjMWMm8PL8QY10y+hRjxdwL
         pfBla88EHlXU3UV8NTJ0br+l0Q10pQJgU56n6c8SOlUQYTW41aXf2TW1fwsgJ1QqmZer
         UC4g==
X-Gm-Message-State: AOAM532nCkJI22oE5XsKzFvAMXzqxtb1dKlALDTYtOzySU6ya3WFBAVs
        FY3Mk6iwsKPyV1VyYURxmBW6GK9e8gA=
X-Google-Smtp-Source: ABdhPJyuV8nNUiIIEBT3dmt7ZgL62KnBrvXk0CStzKk3OYc5gQ5ZJvwRYn79YBmKH3duG34FZuwXlA==
X-Received: by 2002:a37:9d58:: with SMTP id g85mr43899555qke.426.1621006569671;
        Fri, 14 May 2021 08:36:09 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c141sm4954723qke.12.2021.05.14.08.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 08:36:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] RDMA/bnxt_re: Drop unnecessary NULL checks after container_of
Date:   Fri, 14 May 2021 08:36:06 -0700
Message-Id: <20210514153606.1377119-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The result of container_of() operations is never NULL unless the first
element of the embedding structure is extracted. This is either not the
case here, or the pointer passed to container_of() is known to be not
NULL. The NULL checks are therefore unnecessary and misleading.
Remove them.

The channges in this patch were made automatically with the following
Coccinelle script.

@@
type t;
identifier v;
statement s;
@@

<+...
(
  t v = container_of(...);
|
  v = container_of(...);
)
  ...
  when != v
- if (\( !v \| v == NULL \) ) s
...+>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 18 ------------------
 drivers/infiniband/hw/bnxt_re/main.c     | 12 ------------
 2 files changed, 30 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2efaa80bfbd2..537471ffaa79 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1098,10 +1098,6 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 		struct bnxt_re_srq *srq;
 
 		srq = container_of(init_attr->srq, struct bnxt_re_srq, ib_srq);
-		if (!srq) {
-			ibdev_err(&rdev->ibdev, "SRQ not found");
-			return -EINVAL;
-		}
 		qplqp->srq = &srq->qplib_srq;
 		rq->max_wqe = 0;
 	} else {
@@ -1279,22 +1275,12 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	/* Setup CQs */
 	if (init_attr->send_cq) {
 		cq = container_of(init_attr->send_cq, struct bnxt_re_cq, ib_cq);
-		if (!cq) {
-			ibdev_err(&rdev->ibdev, "Send CQ not found");
-			rc = -EINVAL;
-			goto out;
-		}
 		qplqp->scq = &cq->qplib_cq;
 		qp->scq = cq;
 	}
 
 	if (init_attr->recv_cq) {
 		cq = container_of(init_attr->recv_cq, struct bnxt_re_cq, ib_cq);
-		if (!cq) {
-			ibdev_err(&rdev->ibdev, "Receive CQ not found");
-			rc = -EINVAL;
-			goto out;
-		}
 		qplqp->rcq = &cq->qplib_cq;
 		qp->rcq = cq;
 	}
@@ -3473,10 +3459,6 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 				((struct bnxt_qplib_qp *)
 				 (unsigned long)(cqe->qp_handle),
 				 struct bnxt_re_qp, qplib_qp);
-			if (!qp) {
-				ibdev_err(&cq->rdev->ibdev, "POLL CQ : bad QP handle");
-				continue;
-			}
 			wc->qp = &qp->ib_qp;
 			wc->ex.imm_data = cqe->immdata;
 			wc->src_qp = cqe->src_qp;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 8bfbf0231a9e..b090dfa4f4cb 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -885,12 +885,6 @@ static int bnxt_re_srqn_handler(struct bnxt_qplib_nq *nq,
 	struct ib_event ib_event;
 	int rc = 0;
 
-	if (!srq) {
-		ibdev_err(NULL, "%s: SRQ is NULL, SRQN not handled",
-			  ROCE_DRV_MODULE_NAME);
-		rc = -EINVAL;
-		goto done;
-	}
 	ib_event.device = &srq->rdev->ibdev;
 	ib_event.element.srq = &srq->ib_srq;
 	if (event == NQ_SRQ_EVENT_EVENT_SRQ_THRESHOLD_EVENT)
@@ -903,7 +897,6 @@ static int bnxt_re_srqn_handler(struct bnxt_qplib_nq *nq,
 		(*srq->ib_srq.event_handler)(&ib_event,
 					     srq->ib_srq.srq_context);
 	}
-done:
 	return rc;
 }
 
@@ -913,11 +906,6 @@ static int bnxt_re_cqn_handler(struct bnxt_qplib_nq *nq,
 	struct bnxt_re_cq *cq = container_of(handle, struct bnxt_re_cq,
 					     qplib_cq);
 
-	if (!cq) {
-		ibdev_err(NULL, "%s: CQ is NULL, CQN not handled",
-			  ROCE_DRV_MODULE_NAME);
-		return -EINVAL;
-	}
 	if (cq->ib_cq.comp_handler) {
 		/* Lock comp_handler? */
 		(*cq->ib_cq.comp_handler)(&cq->ib_cq, cq->ib_cq.cq_context);
-- 
2.25.1

