Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E199825BAD6
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 08:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgICGG6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 02:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgICGG5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 02:06:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EF9C061244
        for <linux-rdma@vger.kernel.org>; Wed,  2 Sep 2020 23:06:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u13so1261205pgh.1
        for <linux-rdma@vger.kernel.org>; Wed, 02 Sep 2020 23:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/4QvKZBb/mGn1yWZfjleUiofW6BFP93AH88fMJBGbQ=;
        b=BVGnutTsOjiEkog1rX/m20RZyGITJsFq/Zbzh8zmL2UlvN9kdtYIp2RrgYoLRRcC9m
         g2xwVB2bRBMRH12RTlpZPEe2FlEofTDnAAHTgL0++eFF90rrWZveW+AxiViBdGUzDlJ8
         /skVlrEWzU8UqIPgYmfOK7fGkxpMIcywdC47dnV83hw7rsC2vkZYYfjusLa0/mmZK26t
         Hc7AILnieBdWHZBVKHWxvwyz76fBBmIP9PFKIrlKQZGWs5qmw7Qn7O1jKxsVIrrW2i+D
         EOzM44InuLtVKTvMOy4QpoOFjpSkm4l4k8dN0tzi+w6Rl0QlE9b69pzZt9STCC2Ukyxl
         LTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/4QvKZBb/mGn1yWZfjleUiofW6BFP93AH88fMJBGbQ=;
        b=OqO67leZef0F5GJXBVSzYN3KlVlxgI1xV4rqln4ZFlv+ONCPcWnkas3Tfwi6W8+VJU
         eme2cWboC98cfgogwnKHHtmGfhOUm/vvEoyKKR6OyYpovrgztDjrGeprkXuKNOxnCEVG
         f9rU8525tt73JE4HpBj0XRsykOYFf256z02FIVUdyWDzJwUXn+GMRUQLFztqOXe1DsT1
         Q8bNSWWwAgt01bhgtYToEOsiJ1AIkEMwYcCtX1uR21wun5uZXohw9TA++2w/T44THrSG
         nkXb3QCfv993FulLwGf0N+HTAw2mB4HRtjZI0mlHkR8gbXtFat7b+Xfp9w+6XyvxC7ms
         zufA==
X-Gm-Message-State: AOAM531UyI9bubh3nClqgutTby5LNYrERzTRz2GcckqxS2Mt/SYy1aWM
        Qcmqkz5fLgJXmKJz792g3Ds=
X-Google-Smtp-Source: ABdhPJxrO9CDDrlWoVfAQb2DOR02B87mu/g9LhYBnEQnwqO5n5N0otwCkGoZCYYYxzMIPDqTW2c79A==
X-Received: by 2002:a62:7743:0:b029:13c:1611:658e with SMTP id s64-20020a6277430000b029013c1611658emr589126pfc.11.1599113215697;
        Wed, 02 Sep 2020 23:06:55 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.170])
        by smtp.gmail.com with ESMTPSA id v1sm1210395pjh.16.2020.09.02.23.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 23:06:55 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, selvin.xavier@broadcom.com,
        devesh.sharma@broadcom.com, somnath.kotur@broadcom.com,
        sriharsha.basavapatna@broadcom.com, nareshkumar.pbs@broadcom.com,
        jgg@ziepe.ca, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, faisal.latif@intel.com,
        shiraz.saleem@intel.com, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v2 1/5] RDMA/bnxt_re: convert tasklets to use new tasklet_setup() API
Date:   Thu,  3 Sep 2020 11:36:33 +0530
Message-Id: <20200903060637.424458-2-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903060637.424458-1-allen.lkml@gmail.com>
References: <20200903060637.424458-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  7 +++----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 11 +++++------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index d60e3dcea087..34a08ae00f24 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -295,9 +295,9 @@ static void __wait_for_all_nqes(struct bnxt_qplib_cq *cq, u16 cnq_events)
 	}
 }
 
-static void bnxt_qplib_service_nq(unsigned long data)
+static void bnxt_qplib_service_nq(struct tasklet_struct *t)
 {
-	struct bnxt_qplib_nq *nq = (struct bnxt_qplib_nq *)data;
+	struct bnxt_qplib_nq *nq = from_tasklet(nq, t, nq_tasklet);
 	struct bnxt_qplib_hwq *hwq = &nq->hwq;
 	int num_srqne_processed = 0;
 	int num_cqne_processed = 0;
@@ -448,8 +448,7 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 
 	nq->msix_vec = msix_vector;
 	if (need_init)
-		tasklet_init(&nq->nq_tasklet, bnxt_qplib_service_nq,
-			     (unsigned long)nq);
+		tasklet_setup(&nq->nq_tasklet, bnxt_qplib_service_nq);
 	else
 		tasklet_enable(&nq->nq_tasklet);
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 4e211162acee..1f9e8234d0f4 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -50,7 +50,7 @@
 #include "qplib_sp.h"
 #include "qplib_fp.h"
 
-static void bnxt_qplib_service_creq(unsigned long data);
+static void bnxt_qplib_service_creq(struct tasklet_struct *t);
 
 /* Hardware communication channel */
 static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
@@ -79,7 +79,7 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 		goto done;
 	do {
 		mdelay(1); /* 1m sec */
-		bnxt_qplib_service_creq((unsigned long)rcfw);
+		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
 	} while (test_bit(cbit, cmdq->cmdq_bitmap) && --count);
 done:
 	return count ? 0 : -ETIMEDOUT;
@@ -369,9 +369,9 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 }
 
 /* SP - CREQ Completion handlers */
-static void bnxt_qplib_service_creq(unsigned long data)
+static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 {
-	struct bnxt_qplib_rcfw *rcfw = (struct bnxt_qplib_rcfw *)data;
+	struct bnxt_qplib_rcfw *rcfw = from_tasklet(rcfw, t, creq.creq_tasklet);
 	struct bnxt_qplib_creq_ctx *creq = &rcfw->creq;
 	u32 type, budget = CREQ_ENTRY_POLL_BUDGET;
 	struct bnxt_qplib_hwq *hwq = &creq->hwq;
@@ -685,8 +685,7 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 
 	creq->msix_vec = msix_vector;
 	if (need_init)
-		tasklet_init(&creq->creq_tasklet,
-			     bnxt_qplib_service_creq, (unsigned long)rcfw);
+		tasklet_setup(&creq->creq_tasklet, bnxt_qplib_service_creq);
 	else
 		tasklet_enable(&creq->creq_tasklet);
 	rc = request_irq(creq->msix_vec, bnxt_qplib_creq_irq, 0,
-- 
2.25.1

