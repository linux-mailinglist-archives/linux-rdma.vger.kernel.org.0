Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5901E1358
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391296AbgEYRW3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:22:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44585 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbgEYRW2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 13:22:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh7so766989plb.11
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 10:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4K9rHHICE3+inYoR2BYCilENf4wIRIaOf+lyZ8wD/kY=;
        b=IUSrCffmKVbIgMdQJxlC/PYBhKJ4lc65dBVaLj7z+7mcVyB8TKpkGumrhYA4iPicx4
         b24DNryWMUas1LJDrKaAE8H1Qm++SIxUj5LswszjpJkvrPKKH8NXF9L3kHkDE655QS6L
         xbOHzk/QA6EyXJWozeawjM4NkfOwRpkHYsOgl5pgApf5a7cSoMlvBwwC9Ie9cUg+zGIS
         NhAbSHeQFC6WxZMy3Xeu0Kb2oghsUP4fp4m2bHa4Sjk+g/uN5YOtZBHVMzp+HTvcjiCC
         jAsHQjzXYkip1TWcoSyKHNN3LgcIzbC4k6u2fo+Li5XvkwnFYBlyxvY6Ao8sD/E7dO8Q
         8Rvg==
X-Gm-Message-State: AOAM530bW4MCmkanti+eVZFjoDpUi70wv+dEqCgn07M1C833f7hiLAKW
        iDkrVJ0ZHdaabxAgcz94/+M3WBrL
X-Google-Smtp-Source: ABdhPJzXoZnjDwcGcNeUlW9igsqPStaCBMP4UDBrw0DXP1z8b9HokIjD5bUKy76SR+4W2RLGG9nt9A==
X-Received: by 2002:a17:90b:3705:: with SMTP id mg5mr20374657pjb.24.1590427347585;
        Mon, 25 May 2020 10:22:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:2590:9462:ff8a:101f])
        by smtp.gmail.com with ESMTPSA id p9sm3213238pff.71.2020.05.25.10.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 10:22:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH v2 2/4] RDMA/srpt: Make debug output more detailed
Date:   Mon, 25 May 2020 10:22:10 -0700
Message-Id: <20200525172212.14413-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525172212.14413-1-bvanassche@acm.org>
References: <20200525172212.14413-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since the session name by itself is not sufficient to uniquely identify a
queue pair, include the queue pair number. Show the ASCII channel state
name instead of the numeric value. This change makes the ib_srpt debug
output more consistent.

Cc: Laurence Oberman <loberman@redhat.com>
Cc: Kamal Heib <kamalheib1@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index a294630f2100..a39ad9fc4224 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -214,8 +214,9 @@ static const char *get_ch_state_name(enum rdma_ch_state s)
  */
 static void srpt_qp_event(struct ib_event *event, struct srpt_rdma_ch *ch)
 {
-	pr_debug("QP event %d on ch=%p sess_name=%s state=%d\n",
-		 event->event, ch, ch->sess_name, ch->state);
+	pr_debug("QP event %d on ch=%p sess_name=%s-%d state=%s\n",
+		 event->event, ch, ch->sess_name, ch->qp->qp_num,
+		 get_ch_state_name(ch->state));
 
 	switch (event->event) {
 	case IB_EVENT_COMM_EST:
@@ -1985,8 +1986,8 @@ static void __srpt_close_all_ch(struct srpt_port *sport)
 	list_for_each_entry(nexus, &sport->nexus_list, entry) {
 		list_for_each_entry(ch, &nexus->ch_list, list) {
 			if (srpt_disconnect_ch(ch) >= 0)
-				pr_info("Closing channel %s because target %s_%d has been disabled\n",
-					ch->sess_name,
+				pr_info("Closing channel %s-%d because target %s_%d has been disabled\n",
+					ch->sess_name, ch->qp->qp_num,
 					dev_name(&sport->sdev->device->dev),
 					sport->port);
 			srpt_close_ch(ch);
