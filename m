Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92A1246017
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 10:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgHQI3U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 04:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbgHQI3K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Aug 2020 04:29:10 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A72C061389;
        Mon, 17 Aug 2020 01:29:10 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o5so7779115pgb.2;
        Mon, 17 Aug 2020 01:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kyykNXsE3aRum/D2mjnzWellPPbjCSwid9aYW2g2QvM=;
        b=KsknIix+Gt+AYiYSlj18kVAXTvxTjw5Y60M7D48aZobxD9xP453Z7a7cKXyjfVJUeN
         ut7gPar2PpD28gu0ptnZlbKzyg5ZK7UuUK2RvihxbacbWSLyHvBVItNrH8coeXMkVaPC
         0Zljij06SGwwNg/+YEpASuPxvBbw4AdlwkEfPwTk/M+EPWcY9HDNQZiOlOMiQBNGIqNM
         iteBU5UWXzJalq8QrP80K8M2giC9OHXzpCsYzOX1m63dBQlOMJdBBo8YB7y4bU0Qi4Dw
         d63xIip7q96+OiZBRmgNE4ADsaXqXdPwXixrJAs7L+jCqWckaguNLis91EgR1rWH1lg0
         7s3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kyykNXsE3aRum/D2mjnzWellPPbjCSwid9aYW2g2QvM=;
        b=Yij8fk/esB0SLUVE/xXzcO+6RvLgpEg2UEnT4RkOTu/tJzDyN1DsbwrrxMZyUNqh/g
         qRdqBKO9k/AeyFFfMH6r9X/Zijjr5U9ZpFW04kj+BXdFHH48D6/Q5P7U3OHCQxik5FIW
         AlMzoiVIOiyOqX3aD831srZBEVNJObv2zrV1PD1VPIYGqpIr8Dnh451L1kxdTpQXyFOv
         w6azmn6HQBJZTJtsZ6+fC86LepNBjhk5Hk7wFs/flBx2lN/0tPeXTW9AE7hHU7RlPNJc
         zMWxABX1SUhOpoGl20ox0Ck3aFetfnwe//Eg9wn5Qhkt6EiCa/c6k+dAKmoBMCulV+R6
         mPNg==
X-Gm-Message-State: AOAM530w+5DrE2pElQlZtwdGbUhdqWhX450v6AQsxAL+2RMVhJaPyFGF
        KcfLtD8negcpLFvzsbwEe/o=
X-Google-Smtp-Source: ABdhPJy9ZwzA3R8MBV5JgPU6iNWe82hPxsU/PzmwJHW4XyWHbM7285nXXrL2GFd30HQIHMG6Q2GJ2A==
X-Received: by 2002:a63:36c6:: with SMTP id d189mr8696158pga.392.1597652949647;
        Mon, 17 Aug 2020 01:29:09 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id r7sm18948102pfl.186.2020.08.17.01.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:29:09 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        nareshkumar.pbs@broadcom.com
Cc:     keescook@chromium.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 3/5] infiniband: i40iw: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:58:42 +0530
Message-Id: <20200817082844.21700-4-allen.lkml@gmail.com>
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
 drivers/infiniband/hw/i40iw/i40iw_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 9c96ece5e7f3..229a0658ff18 100644
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
2.17.1

