Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB61DF14A
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 23:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgEVVdx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 17:33:53 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54724 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbgEVVdw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 17:33:52 -0400
Received: by mail-pj1-f65.google.com with SMTP id s69so5537750pjb.4
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 14:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4K9rHHICE3+inYoR2BYCilENf4wIRIaOf+lyZ8wD/kY=;
        b=TtoHtuDmnWNeWTX1udhbDJeqs1XnLz5WbCwaKo+Nv+c0JgnO7YhYeRtIUhWhUAlxhK
         ZwfQiZB8gaCkU25kVcYQsumlqcY4rE8RIZEyOj00Y/pTHm8crufOUWrK5y+H4oK/Jjum
         BOY7gMsfCBjlPBmYoiPoN16BJJTU5bBnRE2Go0r9Hy39TlSe9A3kDfqZ5SjRZ3q8OP78
         gtUqJjgfitcHd+tvh0uhxzicvekD+HEr84ASQzXiUcejLM/ZrxR5SPTPAcwCYAV9UVuK
         xm34RPMWJe93TR+23EKoXcZV/SmAqhtuEH0dBC+/qs8S9cVnuLC618Vck89rfIKgZgqm
         37XQ==
X-Gm-Message-State: AOAM531UAQepnf5gbY9SvCk8PyuCaNew/QqUT8ogv59ym7goHR6nju+q
        Wzl0MR/pgyDOdkjktzT5YHYn7a1i
X-Google-Smtp-Source: ABdhPJxQLRdOvif77tOPMoeTTIELVGGxIrGCaJEU4vz67I/5f36v6hjZie4ANkuYdE5vk7m5L4oOfA==
X-Received: by 2002:a17:90a:1485:: with SMTP id k5mr2140769pja.108.1590183231897;
        Fri, 22 May 2020 14:33:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:b874:274b:7df6:e61b])
        by smtp.gmail.com with ESMTPSA id mn19sm7480755pjb.8.2020.05.22.14.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 14:33:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH 2/4] RDMA/srpt: Make debug output more detailed
Date:   Fri, 22 May 2020 14:33:39 -0700
Message-Id: <20200522213341.16341-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522213341.16341-1-bvanassche@acm.org>
References: <20200522213341.16341-1-bvanassche@acm.org>
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
