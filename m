Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092FC3C8B0F
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jul 2021 20:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhGNSkC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jul 2021 14:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhGNSkC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jul 2021 14:40:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6904EC06175F
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jul 2021 11:37:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 8so5237143lfp.9
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jul 2021 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgay9SZO23HJueh17lGiAOSPGczco1l4VBX+KKEkxd4=;
        b=AcdvdpJhvJIBOFfb+DfFMGhZETowGeu68BbPR7iJqI3FogYPK/jsbfuohrVG7lhd+P
         lAJYsf7f2KRpGuoDndshRAmresVPdXPS8KUMDJrhNhw37z1a9aVEh7rOnKQCNtKlKFNj
         375BDM+hFD68qFImpxGhUjHkP/rFckhyvGiX0feq5Agrx5XdR48aZh6U41yPdWmmp2oB
         h+mg1HugpJZ2MC8soyEnYy7ZfVFYtSNDDfHPO81opbvmAeCObUxGieknYBSMRvC6keLQ
         oSl0WQYaks8MJsvPtEuHSxu9KoYrKoGc1E3lhhzFkkh8bp1Q64GDK62H7wTB6mg7i3IB
         jd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgay9SZO23HJueh17lGiAOSPGczco1l4VBX+KKEkxd4=;
        b=nxZOi0ln3tFux8cHCoiQyuLKzDQKLDKkdxQx6FXqWI/0f+gQ0TzrXGZBZlov1dpe7+
         iz9qAi2/xiNqsxhIL06W/gNXyhQtmaO2hp3szu8NBOo7jn8qXjcFDbb60OL0OZt7Iqtd
         c9QiEjNmc7tB9NShPdvoK2Fiqps4EXbexYsWcrjhtXShzamMrvYsWIdHlGKAbLhkc6+a
         sR7Sc4yn8rmlPTpEggZ1DtB27ELSxZUCG1qaxlcT2fzAJcHnkOse+zttqiy67WgEZ8Jy
         jSi1WlweiMbGvaT260kjTCYNCa+bRbRnfnFeSeKcAJuYTN5Azf76I29JkkZrgDZ68fKy
         ncGg==
X-Gm-Message-State: AOAM530798sOxW9ngGpmJZIldlCqaVu+GJMRWHtLkn+/vHlXGUf6AX8C
        2jdcBZ/dr9jlo2elqg8ok6Eb5TTK7qPRwg==
X-Google-Smtp-Source: ABdhPJypojP2SIJxKj84dKtzUEtcTrzuttvYfdZ3SSjA0nyPNWBT1Of+C1mdhpFMzbvBqq97AigUoA==
X-Received: by 2002:a05:6512:1684:: with SMTP id bu4mr8675959lfb.132.1626287827618;
        Wed, 14 Jul 2021 11:37:07 -0700 (PDT)
Received: from Prowler ([5.8.17.170])
        by smtp.gmail.com with ESMTPSA id q13sm219607lfu.272.2021.07.14.11.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:37:07 -0700 (PDT)
From:   lanevdenoche@gmail.com
X-Google-Original-From: lnacture@gmail.com
Received: by Prowler (sSMTP sendmail emulation); Wed, 14 Jul 2021 21:37:02 +0300
To:     linux-rdma@vger.kernel.org, sagi@grimberg.me, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     Chesnokov Gleb <Chesnokov.G@raidix.com>
Subject: [PATCH 1/1] iser-target: Fix handling of RDMA_CV_EVENT_ADDR_CHANGE
Date:   Wed, 14 Jul 2021 21:26:46 +0300
Message-Id: <20210714182646.112181-1-Chesnokov.G@raidix.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Calling isert_setup_id() from isert_np_cma_handler() is wrong
since at that time the socket address was still bound to the old cma_id
which will be destroyed via rdma_destroy_id() only after processing
the RDMA_CM_EVENT_ADDR_CHANGE event.

 - isert_np_cma_handler() calls isert_setup_id()

 - isert_setup_id() calls rdma_bind_addr()

 - rdma_bind_addr() returns -EADDRINUSE

Move the creation of the cma_id in workqueue context and delete old
cma_id directly, not through returning the error code to the upper
level.

Fixes: ca6c1d82d12d ("iser-target: Handle ADDR_CHANGE event for listener cm_id")
Signed-off-by: Chesnokov Gleb <Chesnokov.G@raidix.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 41 ++++++++++++++++++++-----
 drivers/infiniband/ulp/isert/ib_isert.h |  2 ++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 636d590765f9..de5ab2ae8e17 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -597,10 +597,26 @@ isert_conn_terminate(struct isert_conn *isert_conn)
 			   isert_conn);
 }
 
+static void isert_np_reinit_id_work(struct work_struct *w)
+{
+	struct isert_np *isert_np = container_of(w, struct isert_np, work);
+
+	rdma_destroy_id(isert_np->cm_id);
+
+	isert_np->cm_id = isert_setup_id(isert_np);
+	if (IS_ERR(isert_np->cm_id)) {
+		isert_err("isert np %p setup id failed: %ld\n",
+			  isert_np, PTR_ERR(isert_np->cm_id));
+		isert_np->cm_id = NULL;
+	}
+}
+
 static int
 isert_np_cma_handler(struct isert_np *isert_np,
 		     enum rdma_cm_event_type event)
 {
+	int ret = -1;
+
 	isert_dbg("%s (%d): isert np %p\n",
 		  rdma_event_msg(event), event, isert_np);
 
@@ -609,19 +625,15 @@ isert_np_cma_handler(struct isert_np *isert_np,
 		isert_np->cm_id = NULL;
 		break;
 	case RDMA_CM_EVENT_ADDR_CHANGE:
-		isert_np->cm_id = isert_setup_id(isert_np);
-		if (IS_ERR(isert_np->cm_id)) {
-			isert_err("isert np %p setup id failed: %ld\n",
-				  isert_np, PTR_ERR(isert_np->cm_id));
-			isert_np->cm_id = NULL;
-		}
+		queue_work(isert_np->reinit_id_wq, &isert_np->work);
+		ret = 0;
 		break;
 	default:
 		isert_err("isert np %p Unexpected event %d\n",
 			  isert_np, event);
 	}
 
-	return -1;
+	return ret;
 }
 
 static int
@@ -2272,6 +2284,15 @@ isert_setup_np(struct iscsi_np *np,
 	if (!isert_np)
 		return -ENOMEM;
 
+	isert_np->reinit_id_wq = alloc_ordered_workqueue("isert_reinit_id_wq", WQ_MEM_RECLAIM);
+	if (unlikely(!isert_np->reinit_id_wq)) {
+		isert_err("Unable to allocate reinit workqueue\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	INIT_WORK(&isert_np->work, isert_np_reinit_id_work);
+
 	sema_init(&isert_np->sem, 0);
 	mutex_init(&isert_np->mutex);
 	INIT_LIST_HEAD(&isert_np->accepted);
@@ -2288,7 +2309,7 @@ isert_setup_np(struct iscsi_np *np,
 	isert_lid = isert_setup_id(isert_np);
 	if (IS_ERR(isert_lid)) {
 		ret = PTR_ERR(isert_lid);
-		goto out;
+		goto free_wq;
 	}
 
 	isert_np->cm_id = isert_lid;
@@ -2296,6 +2317,8 @@ isert_setup_np(struct iscsi_np *np,
 
 	return 0;
 
+free_wq:
+	destroy_workqueue(isert_np->reinit_id_wq);
 out:
 	kfree(isert_np);
 
@@ -2466,6 +2489,8 @@ isert_free_np(struct iscsi_np *np)
 	}
 	mutex_unlock(&isert_np->mutex);
 
+	destroy_workqueue(isert_np->reinit_id_wq);
+
 	np->np_context = NULL;
 	kfree(isert_np);
 }
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index ca8cfebe26ca..5fdc799f3ca8 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -209,4 +209,6 @@ struct isert_np {
 	struct mutex		mutex;
 	struct list_head	accepted;
 	struct list_head	pending;
+	struct work_struct      work;
+	struct workqueue_struct *reinit_id_wq;
 };
-- 
2.32.0

