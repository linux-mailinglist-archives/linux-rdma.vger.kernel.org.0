Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E5F246013
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 10:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgHQI3J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 04:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgHQI3B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Aug 2020 04:29:01 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88047C061388;
        Mon, 17 Aug 2020 01:29:01 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v15so7767268pgh.6;
        Mon, 17 Aug 2020 01:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XENeoBCKyWTtiUl0dpWZasQXBk+ronARsAja9/yaUcY=;
        b=hiDC4kHBdr9sGRb0O49pn7dK1h1n/1aohypTOAdIhkxy+HaIoti9xyh+c0fQwri9Hh
         0i5ea2wAD6wJ1xki3DyGHyOt0GObl6K7/smyA04qbHyj2Uzd7BSAEkkgg7qi/bOTN2fY
         rnZlw8+ywWhYRGdn9qQ1n9wkZvTLpsUpsjPX6qf7JX6Uk9os1RJgZ7iNVIKr0pq+3pAQ
         dwyL5AzSAD4VMesHn2rCWgE+po3gUZgrS5oFvgPz5An23jEVAKspUGCCJ6JU+PyT2D+H
         FGJeMYH3nESiSaZ/aW0IDnmhW0Lwhnm009Wk5iU3Zxhx/iLK8agDlMQBfP9SoIXFE/qy
         Pxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XENeoBCKyWTtiUl0dpWZasQXBk+ronARsAja9/yaUcY=;
        b=kW4W6Psm37muVadEjawKS9qCjZeW1u0a+5OXZ1PHCBnNtbtDKoCg/iXAeMDoRi3yj3
         XdhDrW1zG5qSFABuqtFoXnU96X0q+Vv44CI1dDZQ1b+8VxOnqHcZPAzLWhVTv+8y075R
         eZLRZPtHg8ilZP9a20UUMH9Dx8IXxmp9cj0Yt++9sgp4EZXmlZfFLeBixrcAqYblpFoz
         Gq2ZIUW8bv/O352NdadK+yse9BIBO/3AjDavNz3vJwR1sm1ThYl49ayfvGrxCkUw6FXa
         7/0ImF3tdrK3iNEetItEvUvG/F34K8ERrh4zqSsqvaQxjyUWIJBW3xJ+HxHNDW/Ie/wm
         umXw==
X-Gm-Message-State: AOAM530rptWADfvF9hAabeBN8wlsSfKa4t+1WyZmMBwefEyQ/cqGOYPo
        F8Z6OZIVL8UE4Ja6e/FYAeY=
X-Google-Smtp-Source: ABdhPJwDlt4tay3WDgrh7aIeyF6ut8/vBFV4jzLg2Yi/J2EtXODMALsepndnffA7lYPYM2qANeRmjw==
X-Received: by 2002:a65:4786:: with SMTP id e6mr9186339pgs.258.1597652940902;
        Mon, 17 Aug 2020 01:29:00 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id r7sm18948102pfl.186.2020.08.17.01.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:29:00 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        nareshkumar.pbs@broadcom.com
Cc:     keescook@chromium.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 1/5] infiniband: bnxt_re: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:58:40 +0530
Message-Id: <20200817082844.21700-2-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817082844.21700-1-allen.lkml@gmail.com>
References: <20200817082844.21700-1-allen.lkml@gmail.com>
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
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 13 ++++++-------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 117b42349a28..62b01582aa1c 100644
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
index 4e211162acee..7261be29fb09 100644
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
@@ -369,10 +369,10 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 }
 
 /* SP - CREQ Completion handlers */
-static void bnxt_qplib_service_creq(unsigned long data)
+static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 {
-	struct bnxt_qplib_rcfw *rcfw = (struct bnxt_qplib_rcfw *)data;
-	struct bnxt_qplib_creq_ctx *creq = &rcfw->creq;
+	struct bnxt_qplib_creq_ctx *creq = from_tasklet(creq, t, creq_tasklet);
+	struct bnxt_qplib_rcfw *rcfw = container_of(creq, typeof(*rcfw), creq);
 	u32 type, budget = CREQ_ENTRY_POLL_BUDGET;
 	struct bnxt_qplib_hwq *hwq = &creq->hwq;
 	struct creq_base *creqe;
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
2.17.1

