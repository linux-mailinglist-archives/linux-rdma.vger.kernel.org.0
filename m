Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86CC25BAD7
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 08:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgICGHE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 02:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgICGHC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 02:07:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA73C061244
        for <linux-rdma@vger.kernel.org>; Wed,  2 Sep 2020 23:07:00 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so1391079pfp.11
        for <linux-rdma@vger.kernel.org>; Wed, 02 Sep 2020 23:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qgTAEJ+MvTux0GG6ydOla3bizdzDlSbFfuqk1terVhA=;
        b=rQXPXWsm3J/JEy+yWVe+nbp18l6fBRfEuGjhc0dR2rVcJ2dcR+znf7ueidew1dBguR
         pvy4UNkoo7RAiu55NP89BSB77K8j2pd3GpdYOvhntfbMfDHq/4jhGl1naCGW1zySWRKz
         95M/xuhd4aUc3Jw3d25JNTGZnQS/atQdg65SnzaW45+sACyt68/2sZe8yWLW7ugPvzaQ
         iaGEswsHacLJbPh7EcxPFYxZP2h1RGGDzNWS5A+c+A3ctyNDbBVHQfvF1mFzJPgPmYRv
         7tU7l3JusmWyUJc1L+UcpB/AC3w0gZFzVN1GnBiom1D+WZjrseAQpguHQNd8pJvGHJod
         DR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qgTAEJ+MvTux0GG6ydOla3bizdzDlSbFfuqk1terVhA=;
        b=mtleHwrZaTl5OXZdgWGznp+dhkOH+2dBweKw174gSvTsmBMCOZiyHC3axvKq59OLdT
         mO3REYyPnCMaScElZ2Bkhf80OQRKz2k6DjzRkUIivMrdHFwesqWFFShvWdDC/EAjqAZc
         ENIKRHjwYzOTxar46dSPOcnBkZOoCUohVEIT/zhH3eJGLvEHPThx0EV+DDRXE1jYW7jN
         SnT1W0RPdghDgPpX2tjip3XA8j3zdWOYfSklJZC2r6IoRXTKu5X0bNsuuwIQzoofWbfD
         XrkMKZI2EJ7oSIMqJMeQAXUwT+xK9cKy5GVcrD8PG2U0xBUvQGbVB+Mu7JOmQ44qfWKi
         Eaqw==
X-Gm-Message-State: AOAM532nLvmPX23VXiR+2+YoDjP4yHmMZbiPimp4ibw7L0KoqcmOCGnX
        HI62k5fij/r/MIow6oZlheE=
X-Google-Smtp-Source: ABdhPJxFaZwBIWtaWb79A+o68UJ4VuVLJ2FbbFvBxzbd0GpmBZW1CyNIBrgA+RtNgX+yoetwvueXwA==
X-Received: by 2002:aa7:9a44:: with SMTP id x4mr2213275pfj.199.1599113220312;
        Wed, 02 Sep 2020 23:07:00 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.170])
        by smtp.gmail.com with ESMTPSA id v1sm1210395pjh.16.2020.09.02.23.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 23:06:59 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, selvin.xavier@broadcom.com,
        devesh.sharma@broadcom.com, somnath.kotur@broadcom.com,
        sriharsha.basavapatna@broadcom.com, nareshkumar.pbs@broadcom.com,
        jgg@ziepe.ca, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, faisal.latif@intel.com,
        shiraz.saleem@intel.com, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v2 2/5] IB/hfi1: convert tasklets to use new tasklet_setup() API
Date:   Thu,  3 Sep 2020 11:36:34 +0530
Message-Id: <20200903060637.424458-3-allen.lkml@gmail.com>
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
 drivers/infiniband/hw/hfi1/sdma.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 04575c9afd61..a307d4c8b15a 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -232,11 +232,11 @@ static const struct sdma_set_state_action sdma_action_table[] = {
 static void sdma_complete(struct kref *);
 static void sdma_finalput(struct sdma_state *);
 static void sdma_get(struct sdma_state *);
-static void sdma_hw_clean_up_task(unsigned long);
+static void sdma_hw_clean_up_task(struct tasklet_struct *);
 static void sdma_put(struct sdma_state *);
 static void sdma_set_state(struct sdma_engine *, enum sdma_states);
 static void sdma_start_hw_clean_up(struct sdma_engine *);
-static void sdma_sw_clean_up_task(unsigned long);
+static void sdma_sw_clean_up_task(struct tasklet_struct *);
 static void sdma_sendctrl(struct sdma_engine *, unsigned);
 static void init_sdma_regs(struct sdma_engine *, u32, uint);
 static void sdma_process_event(
@@ -545,9 +545,10 @@ static void sdma_err_progress_check(struct timer_list *t)
 	schedule_work(&sde->err_halt_worker);
 }
 
-static void sdma_hw_clean_up_task(unsigned long opaque)
+static void sdma_hw_clean_up_task(struct tasklet_struct *t)
 {
-	struct sdma_engine *sde = (struct sdma_engine *)opaque;
+	struct sdma_engine *sde = from_tasklet(sde, t,
+					       sdma_hw_clean_up_task);
 	u64 statuscsr;
 
 	while (1) {
@@ -604,9 +605,9 @@ static void sdma_flush_descq(struct sdma_engine *sde)
 		sdma_desc_avail(sde, sdma_descq_freecnt(sde));
 }
 
-static void sdma_sw_clean_up_task(unsigned long opaque)
+static void sdma_sw_clean_up_task(struct tasklet_struct *t)
 {
-	struct sdma_engine *sde = (struct sdma_engine *)opaque;
+	struct sdma_engine *sde = from_tasklet(sde, t, sdma_sw_clean_up_task);
 	unsigned long flags;
 
 	spin_lock_irqsave(&sde->tail_lock, flags);
@@ -1454,11 +1455,10 @@ int sdma_init(struct hfi1_devdata *dd, u8 port)
 		sde->tail_csr =
 			get_kctxt_csr_addr(dd, this_idx, SD(TAIL));
 
-		tasklet_init(&sde->sdma_hw_clean_up_task, sdma_hw_clean_up_task,
-			     (unsigned long)sde);
-
-		tasklet_init(&sde->sdma_sw_clean_up_task, sdma_sw_clean_up_task,
-			     (unsigned long)sde);
+		tasklet_setup(&sde->sdma_hw_clean_up_task,
+			      sdma_hw_clean_up_task);
+		tasklet_setup(&sde->sdma_sw_clean_up_task,
+			      sdma_sw_clean_up_task);
 		INIT_WORK(&sde->err_halt_worker, sdma_err_halt_wait);
 		INIT_WORK(&sde->flush_worker, sdma_field_flush);
 
-- 
2.25.1

