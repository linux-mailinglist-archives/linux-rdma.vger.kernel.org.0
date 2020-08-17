Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F342246018
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 10:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgHQI3U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 04:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgHQI3G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Aug 2020 04:29:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A490C061388;
        Mon, 17 Aug 2020 01:29:06 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so7130883plb.12;
        Mon, 17 Aug 2020 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QbVmlo1JjJ+fo8Hrfp8jbDzD1XVMcpN4Uy9zDhtnXEE=;
        b=nFhwiyKYaN/p+nU496vwSTlNS/FvdfpnsO6ojTqcfaaQIxhpU62MP0r36KyEfgjbuZ
         E5Ow/NgfXHWYWsW+B/sUCnJ/wuB5rTEBzk1IfQBuRLoSSrsheDkqAe/DZgM4wFBl/2Ds
         xtrse3ZP2DeVHgpQ6PIKhoroSVqKswJU2+P+pkwDv6+zAsqGBR+beTorlXyS/HthOx7U
         eT66Z9cOigVFmhSrgcQeo4s+CZ1+H5yN6VpYaWLUDOlUClVUiyeRnG1o9xVenmw7YfK6
         3JZEtC7Sa1iDnxtgnhj++0WdpcmglaLtacJVUkctt6fj8LDVOuQtDz4qoRyQB+oEAcwb
         C0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QbVmlo1JjJ+fo8Hrfp8jbDzD1XVMcpN4Uy9zDhtnXEE=;
        b=EzZy6COB3jW5Hp3Wxrj4RXWMm/RPFowLrqEaFbN7iANmt+FlkHVtgDtcu8btaECjMM
         DzXLyJUZM3v48iXRwSum169cfKcwGu0Skl3CgIir2u9HjFcSMk//LnT46zTcfKBDuCQV
         DzJB8sBLjk/IvwTnIXVW5iS61xEZ4bcmWi5z5aY/ntUMGHjSD818ORaszWZgxOnB4HXv
         vivfCAP18nNrnikJY0E64XOQ7cmnkqSduku34Bv6gSjxtzyW4kViBP6maFuWPV8v6wx3
         uW2JlVrB9AUB99+NpaAmQoUJiWkAzMn1wWXIaEUZsS6DlfKt5EYCFFLrzyk76Ih3PUPC
         /WXA==
X-Gm-Message-State: AOAM532udhKA9WR3RekmOmnqLx2CVLRIpTY1Hv3zHGQ6fEei/LehAnDk
        gwjmby7COnDFni5vYJVamWA=
X-Google-Smtp-Source: ABdhPJyC0bW2sgtvg/KVBfYQhWrpGYO2POIZoL9zNCf+4WS0K+wAiFEcIL3nyF4QiNrd2JhYhPgLeg==
X-Received: by 2002:a17:90a:c201:: with SMTP id e1mr11467481pjt.142.1597652945070;
        Mon, 17 Aug 2020 01:29:05 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id r7sm18948102pfl.186.2020.08.17.01.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:29:04 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        nareshkumar.pbs@broadcom.com
Cc:     keescook@chromium.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 2/5] infiniband: hfi1: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:58:41 +0530
Message-Id: <20200817082844.21700-3-allen.lkml@gmail.com>
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
2.17.1

