Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B88B4B77F5
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiBOS22 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 13:28:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbiBOS21 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 13:28:27 -0500
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E41E03B
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 10:28:17 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id c4so14967060pfl.7
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 10:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bOkxLoqa7aSs1BzIzOKghMX8VL6JgG8l+i8IWyte58=;
        b=qoslIFPhXoQdywaxfJXcrj3ojKie2Gm8BS45+BgoP4stb0hbYo4X4LWSidLnTenifc
         SgU+2VxXL1DUlifGnClaRu5uzEOgNnn5GZ6NQXGklT6K+2H90ksl13PMkiUadWLk5Gtm
         jnS0sn5pxN31K8q9uzejopEUQYLNjs6Cr0s8EHvukLzBoEUdBEGlRsnsWidA0Pbls4pi
         v/Qxu5NbjuNrvoSFXavsXQeKqhWgiH7qNWUjcguosgdKorAK3Zc6fas/EaLwuGAmt/vG
         qOBNa9B83h4quZAT/s0xpKVRVsMwXYkH0cWcuR/OLJ7Ve8R88XwVTR8CddjGmvMY04KR
         sWZg==
X-Gm-Message-State: AOAM533k6mP3dd66FHr6ZDvEi/2jw70vc0qb8gNoTxk2i7iIdu4wrX88
        0rhurN7ORsExop0TX6pCJ/c=
X-Google-Smtp-Source: ABdhPJyxpGyNNVDX7fV6yKF3oVgjssRgRIA6UvsdKJHeY1WSw1oqOMO/WCotZv7duaoGgbDmwmOlkg==
X-Received: by 2002:a63:2c87:: with SMTP id s129mr140265pgs.327.1644949697168;
        Tue, 15 Feb 2022 10:28:17 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id k13sm43896746pfc.176.2022.02.15.10.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 10:28:16 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/3] ib_srp: Protect the target list with a mutex instead of a spinlock
Date:   Tue, 15 Feb 2022 10:26:49 -0800
Message-Id: <20220215182650.19839-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215182650.19839-1-bvanassche@acm.org>
References: <20220215182650.19839-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch makes the next patch in this series easier to read.

Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 18 +++++++++---------
 drivers/infiniband/ulp/srp/ib_srp.h |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index e174e853f8a4..2db7429b42e1 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1062,9 +1062,9 @@ static void srp_remove_target(struct srp_target_port *target)
 	kfree(target->ch);
 	target->ch = NULL;
 
-	spin_lock(&target->srp_host->target_lock);
+	mutex_lock(&target->srp_host->target_mutex);
 	list_del(&target->list);
-	spin_unlock(&target->srp_host->target_lock);
+	mutex_unlock(&target->srp_host->target_mutex);
 
 	scsi_host_put(target->scsi_host);
 }
@@ -3146,9 +3146,9 @@ static int srp_add_target(struct srp_host *host, struct srp_target_port *target)
 	rport->lld_data = target;
 	target->rport = rport;
 
-	spin_lock(&host->target_lock);
+	mutex_lock(&host->target_mutex);
 	list_add_tail(&target->list, &host->target_list);
-	spin_unlock(&host->target_lock);
+	mutex_unlock(&host->target_mutex);
 
 	scsi_scan_target(&target->scsi_host->shost_gendev,
 			 0, target->scsi_id, SCAN_WILD_CARD, SCSI_SCAN_INITIAL);
@@ -3203,7 +3203,7 @@ static bool srp_conn_unique(struct srp_host *host,
 
 	ret = true;
 
-	spin_lock(&host->target_lock);
+	mutex_lock(&host->target_mutex);
 	list_for_each_entry(t, &host->target_list, list) {
 		if (t != target &&
 		    target->id_ext == t->id_ext &&
@@ -3213,7 +3213,7 @@ static bool srp_conn_unique(struct srp_host *host,
 			break;
 		}
 	}
-	spin_unlock(&host->target_lock);
+	mutex_unlock(&host->target_mutex);
 
 out:
 	return ret;
@@ -3898,7 +3898,7 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
 		return NULL;
 
 	INIT_LIST_HEAD(&host->target_list);
-	spin_lock_init(&host->target_lock);
+	mutex_init(&host->target_mutex);
 	init_completion(&host->released);
 	mutex_init(&host->add_target_mutex);
 	host->srp_dev = device;
@@ -4041,10 +4041,10 @@ static void srp_remove_one(struct ib_device *device, void *client_data)
 		/*
 		 * Remove all target ports.
 		 */
-		spin_lock(&host->target_lock);
+		mutex_lock(&host->target_mutex);
 		list_for_each_entry(target, &host->target_list, list)
 			srp_queue_remove_work(target);
-		spin_unlock(&host->target_lock);
+		mutex_unlock(&host->target_mutex);
 
 		/*
 		 * Wait for tl_err and target port removal tasks.
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index 55a575e2cace..2af968277994 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -116,14 +116,14 @@ struct srp_device {
  * One port of an RDMA adapter in the initiator system.
  *
  * @target_list: List of connected target ports (struct srp_target_port).
- * @target_lock: Protects @target_list.
+ * @target_mutex: Protects @target_list.
  */
 struct srp_host {
 	struct srp_device      *srp_dev;
 	u8			port;
 	struct device		dev;
 	struct list_head	target_list;
-	spinlock_t		target_lock;
+	struct mutex		target_mutex;
 	struct completion	released;
 	struct list_head	list;
 	struct mutex		add_target_mutex;
