Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C633825BADA
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 08:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgICGHN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 02:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgICGHJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 02:07:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683B9C061244
        for <linux-rdma@vger.kernel.org>; Wed,  2 Sep 2020 23:07:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k15so1384610pfc.12
        for <linux-rdma@vger.kernel.org>; Wed, 02 Sep 2020 23:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0IAAG0FjZzDRtU1T0Ft7OlLUeddkej5M/Q99d+vMwhc=;
        b=Mf+OBcvI7TNvb3+jfyD9difio5rwle6pVPBEmnIzKZHx/CYmTvwgr14f55EcAKnM9f
         qhbmzeHutFxaz8Kkx6nyo1T4RDE9vA9Kf+33jvnTsopFAzCk1wJbHnv4trzleCQ9k7OX
         J/tdBjgw78UIkC7yshJYBUYf7OY/g/ZTHgrsZ/YSDKRKXU+1hyxxyhuNsYlZFIv1Zu6c
         LPQ7gx7+pzZydaTV9zmON/OFfd8AknvKlEcLMbp7pd8I6YF/IUhUe0iDKipollt3iwqf
         m6RaAReuIQDHeeA98pHfBB9xBePSZiGq9gRk4C/ZrNPzHGGw3W68QrMJ2jEK7A927YvK
         DGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0IAAG0FjZzDRtU1T0Ft7OlLUeddkej5M/Q99d+vMwhc=;
        b=RIKGmNxRJO7r9q31l5rlxny7Ygv9/P7ifJyZAC4n3sTeuCQ8uUiZfocC0oGzusKm1X
         eFBIwo8Fuu4Es315io7UtjttQA0//qpoVpdoEhbsGRiItFaCtbNl1bELWyVDnnQNS3C3
         1DK3aKw7J80i61tqc7pLneTIAwrkDHYXmG4ZZIG4fsqHbLkOaj2oNMLTOHS1bL1bpAa2
         mGYBswj3w51hpv4v6RpO68g1R4rgUROAr7qN4VparfKFXpp/XbwUKU8REWYZA5zc3A9W
         WghtABOfzdtqBtLbXyFINAWLVWA+JK5ZcJ/HEysBhs3ie+I0MYBvK/MDVeUXsRfM2WJt
         gl2g==
X-Gm-Message-State: AOAM533HjPDcI4j23d6a8PRc7Rxn3wYqOeI5nCtK3bNR+SEWX+mepPFz
        XMbBWdlGe8slvgqmw/SP2I8=
X-Google-Smtp-Source: ABdhPJyw59KFVseWM7ViaFXbmWmoJMOO10m+8kNtECPM2TH/oq2Y8CMcVKFMm2UmfRPziZx1G1cXiw==
X-Received: by 2002:a17:902:56a:: with SMTP id 97mr2249475plf.130.1599113229032;
        Wed, 02 Sep 2020 23:07:09 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.170])
        by smtp.gmail.com with ESMTPSA id v1sm1210395pjh.16.2020.09.02.23.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 23:07:08 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, selvin.xavier@broadcom.com,
        devesh.sharma@broadcom.com, somnath.kotur@broadcom.com,
        sriharsha.basavapatna@broadcom.com, nareshkumar.pbs@broadcom.com,
        jgg@ziepe.ca, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, faisal.latif@intel.com,
        shiraz.saleem@intel.com, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v2 4/5] RDMA/qib: convert tasklets to use new tasklet_setup() API
Date:   Thu,  3 Sep 2020 11:36:36 +0530
Message-Id: <20200903060637.424458-5-allen.lkml@gmail.com>
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
 drivers/infiniband/hw/qib/qib_iba7322.c |  7 +++----
 drivers/infiniband/hw/qib/qib_sdma.c    | 10 +++++-----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index a10eab89aee4..189a0ce6056a 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -1733,9 +1733,9 @@ static noinline void handle_7322_errors(struct qib_devdata *dd)
 	return;
 }
 
-static void qib_error_tasklet(unsigned long data)
+static void qib_error_tasklet(struct tasklet_struct *t)
 {
-	struct qib_devdata *dd = (struct qib_devdata *)data;
+	struct qib_devdata *dd = from_tasklet(dd, t, error_tasklet);
 
 	handle_7322_errors(dd);
 	qib_write_kreg(dd, kr_errmask, dd->cspec->errormask);
@@ -3537,8 +3537,7 @@ static void qib_setup_7322_interrupt(struct qib_devdata *dd, int clearpend)
 	for (i = 0; i < ARRAY_SIZE(redirect); i++)
 		qib_write_kreg(dd, kr_intredirect + i, redirect[i]);
 	dd->cspec->main_int_mask = mask;
-	tasklet_init(&dd->error_tasklet, qib_error_tasklet,
-		(unsigned long)dd);
+	tasklet_setup(&dd->error_tasklet, qib_error_tasklet);
 }
 
 /**
diff --git a/drivers/infiniband/hw/qib/qib_sdma.c b/drivers/infiniband/hw/qib/qib_sdma.c
index 8f8d61736656..5e86cbf7d70e 100644
--- a/drivers/infiniband/hw/qib/qib_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_sdma.c
@@ -62,7 +62,7 @@ static void sdma_get(struct qib_sdma_state *);
 static void sdma_put(struct qib_sdma_state *);
 static void sdma_set_state(struct qib_pportdata *, enum qib_sdma_states);
 static void sdma_start_sw_clean_up(struct qib_pportdata *);
-static void sdma_sw_clean_up_task(unsigned long);
+static void sdma_sw_clean_up_task(struct tasklet_struct *);
 static void unmap_desc(struct qib_pportdata *, unsigned);
 
 static void sdma_get(struct qib_sdma_state *ss)
@@ -119,9 +119,10 @@ static void clear_sdma_activelist(struct qib_pportdata *ppd)
 	}
 }
 
-static void sdma_sw_clean_up_task(unsigned long opaque)
+static void sdma_sw_clean_up_task(struct tasklet_struct *t)
 {
-	struct qib_pportdata *ppd = (struct qib_pportdata *) opaque;
+	struct qib_pportdata *ppd = from_tasklet(ppd, t,
+						 sdma_sw_clean_up_task);
 	unsigned long flags;
 
 	spin_lock_irqsave(&ppd->sdma_lock, flags);
@@ -436,8 +437,7 @@ int qib_setup_sdma(struct qib_pportdata *ppd)
 
 	INIT_LIST_HEAD(&ppd->sdma_activelist);
 
-	tasklet_init(&ppd->sdma_sw_clean_up_task, sdma_sw_clean_up_task,
-		(unsigned long)ppd);
+	tasklet_setup(&ppd->sdma_sw_clean_up_task, sdma_sw_clean_up_task);
 
 	ret = dd->f_init_sdma_regs(ppd);
 	if (ret)
-- 
2.25.1

