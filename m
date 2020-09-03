Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592E825BAD9
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 08:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgICGHN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 02:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgICGHF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 02:07:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E10DC061244
        for <linux-rdma@vger.kernel.org>; Wed,  2 Sep 2020 23:07:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e33so1261815pgm.0
        for <linux-rdma@vger.kernel.org>; Wed, 02 Sep 2020 23:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=owfrpNL/RiIwYXs92g1iDTHe3f/CAcnbksFi3Dnvj5A=;
        b=Wyz0rV52Qk3mPzP1tINrNKzp5WbBiz9zCZrfzZlc0WTSGmLIqYHQl+eN3yEuuRu2tT
         6CzApIXl1wa0Hq+EGl58nstj+drrEUyhxTOrqfcx86Ym5HuUzP/335XW55bgE64J8bFf
         juIfD7xKvh3WIwmfZqQF4814dBQMeHJxutsnxrzZ+2pGOnCAlSgt/DJkQXs7HtO5Ly3b
         ig5W66/nRDyJhK8fxajcN7iGNxb6zDliHay5kjP/Iz8PiEdZhwd9utvecWd4l6q6/MSM
         XBaThDfCfoYku5vgNDvvSE46W6/tMWdwbN19S/FR0AYrqJ/ahWtYSIc0EF75hvUtfv/o
         dtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owfrpNL/RiIwYXs92g1iDTHe3f/CAcnbksFi3Dnvj5A=;
        b=Kz8YS3ox62GKdfqXbN1rzlyJVf9hXwk1M795r5m14QWmK0oEHjD0H3ADKk3xnEC1FR
         0R5Zluxg1H0hmKLVhdRmtFKzdNXvhAWXgjHumlHVqGAGhdwrj4Vivravqu8Lgeri42jW
         Iid/9EECL4JvhVKnNQEKwutxJTpSMAtjJn4+34k/xU25vAQjvHWUpn5l4xm57KiimFNs
         9fZIuzUEMg9z1LwrQ9IIiUTn9UsBa09BVZ4JEz3UHQOWDnEAYjdMnkUTDf35otHlEskv
         7C6P6cUgdDyjpir+L8g0SqZnYXAu5KkRpciH2JchSYazvurVx/ebvdKQ4M8iqBY/21Wf
         n2Gg==
X-Gm-Message-State: AOAM532pXKZ/G+e6SOMHzxnoG0col1ulDNImfxnqRiS4NpsWUt2k3gSf
        70V+CT+UuZLYZc4iOPSQE64=
X-Google-Smtp-Source: ABdhPJz7kfAR/+QTLxlgBSI4LyH8WxtPcSg8bnfJnfrvoN6ejpSqsMgTq+j20YSy29F8AaJkNbwooA==
X-Received: by 2002:a17:902:7d85:: with SMTP id a5mr2195461plm.148.1599113224787;
        Wed, 02 Sep 2020 23:07:04 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.170])
        by smtp.gmail.com with ESMTPSA id v1sm1210395pjh.16.2020.09.02.23.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 23:07:04 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, selvin.xavier@broadcom.com,
        devesh.sharma@broadcom.com, somnath.kotur@broadcom.com,
        sriharsha.basavapatna@broadcom.com, nareshkumar.pbs@broadcom.com,
        jgg@ziepe.ca, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, faisal.latif@intel.com,
        shiraz.saleem@intel.com, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v2 3/5] RDMA/i40iw: convert tasklets to use new tasklet_setup() API
Date:   Thu,  3 Sep 2020 11:36:35 +0530
Message-Id: <20200903060637.424458-4-allen.lkml@gmail.com>
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
 drivers/infiniband/hw/i40iw/i40iw_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 58a433135a03..c0cdb25440bf 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -192,9 +192,9 @@ static void i40iw_enable_intr(struct i40iw_sc_dev *dev, u32 msix_id)
  * i40iw_dpc - tasklet for aeq and ceq 0
  * @data: iwarp device
  */
-static void i40iw_dpc(unsigned long data)
+static void i40iw_dpc(struct tasklet_struct *t)
 {
-	struct i40iw_device *iwdev = (struct i40iw_device *)data;
+	struct i40iw_device *iwdev = from_tasklet(iwdev, t, dpc_tasklet);
 
 	if (iwdev->msix_shared)
 		i40iw_process_ceq(iwdev, iwdev->ceqlist);
@@ -206,9 +206,9 @@ static void i40iw_dpc(unsigned long data)
  * i40iw_ceq_dpc - dpc handler for CEQ
  * @data: data points to CEQ
  */
-static void i40iw_ceq_dpc(unsigned long data)
+static void i40iw_ceq_dpc(struct tasklet_struct *t)
 {
-	struct i40iw_ceq *iwceq = (struct i40iw_ceq *)data;
+	struct i40iw_ceq *iwceq = from_tasklet(iwceq, t, dpc_tasklet);
 	struct i40iw_device *iwdev = iwceq->iwdev;
 
 	i40iw_process_ceq(iwdev, iwceq);
@@ -689,10 +689,10 @@ static enum i40iw_status_code i40iw_configure_ceq_vector(struct i40iw_device *iw
 	enum i40iw_status_code status;
 
 	if (iwdev->msix_shared && !ceq_id) {
-		tasklet_init(&iwdev->dpc_tasklet, i40iw_dpc, (unsigned long)iwdev);
+		tasklet_setup(&iwdev->dpc_tasklet, i40iw_dpc);
 		status = request_irq(msix_vec->irq, i40iw_irq_handler, 0, "AEQCEQ", iwdev);
 	} else {
-		tasklet_init(&iwceq->dpc_tasklet, i40iw_ceq_dpc, (unsigned long)iwceq);
+		tasklet_setup(&iwceq->dpc_tasklet, i40iw_ceq_dpc);
 		status = request_irq(msix_vec->irq, i40iw_ceq_handler, 0, "CEQ", iwceq);
 	}
 
@@ -841,7 +841,7 @@ static enum i40iw_status_code i40iw_configure_aeq_vector(struct i40iw_device *iw
 	u32 ret = 0;
 
 	if (!iwdev->msix_shared) {
-		tasklet_init(&iwdev->dpc_tasklet, i40iw_dpc, (unsigned long)iwdev);
+		tasklet_setup(&iwdev->dpc_tasklet, i40iw_dpc);
 		ret = request_irq(msix_vec->irq, i40iw_irq_handler, 0, "i40iw", iwdev);
 	}
 	if (ret) {
-- 
2.25.1

