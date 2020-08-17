Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE3F246016
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 10:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgHQI3T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 04:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgHQI3O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Aug 2020 04:29:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9510C06138A;
        Mon, 17 Aug 2020 01:29:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g15so3241986plj.6;
        Mon, 17 Aug 2020 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mpTvLV2skT2BsbjdvmvS7WbpiU8WJnm3QiU8cdWEdZ4=;
        b=SNWSPMwsXxcDYbomSRcnWgDAgrZhmhBy8lduJbQaXMy+E9NVBYG03V3AkFcWRmPMvl
         3YRVv+7y+pwFpXYmXN/FA9JNpbFfc15APZ0olb5+4LfFYvYkI2ULJPYTtbJw4zpBR7Xb
         zRu2Fo+vvj/P2ySD7JB2GzVdKKNri4936It09heU52HVUE2NjTL74SZmLUH/qLjUPZp0
         Tra4yxkqiRvg30v9O+rxuRiz6/cO4nQCL7FBR+LPi5yJ0NBFm2uLriS0r0vslsbYNcmi
         N2qL+Z1uEq2ami3M/o0u1zjiFGE7w1IMzyfDoJJW8doGP26pfIfxiiB3+677/1Rwcna1
         kFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mpTvLV2skT2BsbjdvmvS7WbpiU8WJnm3QiU8cdWEdZ4=;
        b=VF7KeOV//SixubgXnDzLRcMSR3/vtOcvPmsmoJxt68jSL6loK9E1k5j3bz1AvXjpL+
         R/xvICq4GI0dx1WJaC+VncNbiATFwV4JcCtMF+JjF16XeiMjQy/1PXOgH99o9MPU/+5+
         e9v9e/0tw4x3ppAybDDGsbvulSDoSPlo0g1sDYN4+rIJhJMozck2kbaActPMHRpnhDqS
         N3FnqIFgVSRpSB+lvDS5jFAiX1kC3LBaJqtwktUL5xn7aGaL8Z5fNUMhk3oQsZKkSK34
         wsx/jB/43w5HNXLdh/Z1vEckUGeWzCw8nj8Z4MPOuNHCol7DY2xnTJJnYWA4wIdOKpD9
         hbsg==
X-Gm-Message-State: AOAM532Nq5Fq5t8JvbEhsy1y+63P4vxsKJVNhOBNwrB1RXK3OmAZWGUC
        Z0CSrr51FHo7ILwLov3odSo=
X-Google-Smtp-Source: ABdhPJzJfA4xlE8UeGwJ9+bgNisAJobpuTK3w/8/kC6OJBAqNyzXiJgEaqpAI3iSlFmnqryEyLwp/Q==
X-Received: by 2002:a17:902:c151:: with SMTP id 17mr9914837plj.228.1597652953478;
        Mon, 17 Aug 2020 01:29:13 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id r7sm18948102pfl.186.2020.08.17.01.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:29:13 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        nareshkumar.pbs@broadcom.com
Cc:     keescook@chromium.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 4/5] infiniband: qib: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:58:43 +0530
Message-Id: <20200817082844.21700-5-allen.lkml@gmail.com>
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
 drivers/infiniband/hw/qib/qib_iba7322.c |  7 +++----
 drivers/infiniband/hw/qib/qib_sdma.c    | 10 +++++-----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index 8bcbc884e5b6..0f6f021e0562 100644
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
index 99e11c347130..eece0d4ce6c7 100644
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
2.17.1

