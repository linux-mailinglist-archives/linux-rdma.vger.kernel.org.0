Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56403EC9E0
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 21:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfKAUsE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 16:48:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38820 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfKAUsE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Nov 2019 16:48:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id j30so3696737pgn.5
        for <linux-rdma@vger.kernel.org>; Fri, 01 Nov 2019 13:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EpE2IFb8QctisnAizWL4LsIRaRavHW7BAKNAzepFG3I=;
        b=Lt10c5Mnw0BW0ihglqAiq82OeCVWML+Q/ZTi1NXdgJjxXyWlHspX6F7sjgOFfI0NUy
         2uW3YNvsxtcwtASi9mVXA4F+nlxT//tCo2Qb4mB+Xe/pxwos19iuV7qDdBGsqsZQ4bHm
         +TkrvmN1naH2BpG7YtMjmym3TEeQlkm3XSLdLG9tmz+2Wxk6/AuVPf5HdWCUThOGnQ9I
         uX4d5qTWYK8JXF5UoLpA5nF3/iKAD8kn7NiLK+wc3Klk9bupP0IOkzEUAGg5MQWDCuri
         Av8NLqYw6t0la8dx/d8SSk9MOx0yR13Pxb2HAK0Tf+0swfdquD3sfAdk8i5BRxHoWF27
         4Lfg==
X-Gm-Message-State: APjAAAXUawY9vkWTZh9dQ0NQmgunZgDZDh0OxTsgGnvyzoGLTdMFA2pz
        bVnShthkwUkdBpTM6d1PdPI=
X-Google-Smtp-Source: APXvYqz0vgYKVgN2s9WK3plNhKC2j4RFZuY9VZ4OFTk+hRRYFM2ObuLolW8lO/W+H5+hPqoHN+XuSw==
X-Received: by 2002:a17:90a:23e2:: with SMTP id g89mr17111529pje.127.1572641283259;
        Fri, 01 Nov 2019 13:48:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c34sm7546057pgb.35.2019.11.01.13.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 13:48:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Honggang Li <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH] Revert "RDMA/srpt: Postpone HCA removal until after configfs directory removal"
Date:   Fri,  1 Nov 2019 13:47:56 -0700
Message-Id: <20191101204756.182162-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Although the mentioned patch fixes a use-after-free bug, it introduces a
hang during shutdown. Since the latter is worse, revert this patch.

Cc: Honggang Li <honli@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Reported-by: Honggang Li <honli@redhat.com>
Fixes: 9b64f7d0bb0a ("RDMA/srpt: Postpone HCA removal until after configfs directory removal")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index c9972b686c27..53dec7d9829c 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2960,7 +2960,7 @@ static int srpt_release_sport(struct srpt_port *sport)
 
 	while (atomic_read(&sport->refcount) > 0 &&
 	       wait_for_completion_timeout(&c, 5 * HZ) <= 0) {
-		pr_info("%s_%d: waiting for unregistration of %d sessions and configfs directories ...\n",
+		pr_info("%s_%d: waiting for unregistration of %d sessions ...\n",
 			dev_name(&sport->sdev->device->dev), sport->port,
 			atomic_read(&sport->refcount));
 		rcu_read_lock();
@@ -3776,8 +3776,6 @@ static struct se_portal_group *srpt_make_tpg(struct se_wwn *wwn,
 	list_add_tail(&stpg->entry, &sport_id->tpg_list);
 	mutex_unlock(&sport_id->mutex);
 
-	atomic_inc(&sport->refcount);
-
 	return &stpg->tpg;
 }
 
@@ -3798,7 +3796,6 @@ static void srpt_drop_tpg(struct se_portal_group *tpg)
 	sport->enabled = false;
 	core_tpg_deregister(tpg);
 	kfree(stpg);
-	srpt_drop_sport_ref(sport);
 }
 
 /**
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

