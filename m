Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F322C2ABC
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfI3XRg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46457 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731852AbfI3XRg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so6466457pfg.13
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ov1JeuWLrT5nJIZWkm/784ePsDn9xbIvZ12ZQdk1C00=;
        b=RdM8ivNfIp5pIIIj22BC517kmp8tSLipKUhoJUEqebiRgxbXjHRXUNAfEFfPJvQpDc
         wcNcHd8eqqgtHmNoCIzR9kv9TZC12EmsUiSe10tWX/M0GwqKdWbUqV0isycu7GtFmwrz
         5hDSrP/UqbB9GL5K9omW+WvJ07vUSQya+2Dqae9dab3cyPqQJrRzRERU3DO3nvIl355h
         ZdYZxPfSKIbpKrydrr9Bbp7RzPgI+M3aiMMZhmkzigL/lxgpNwzGKS/mJQE+hklCqTKr
         Y8w7cxkoTnX/myesjGX3sGMpSQYVaMHDKMD0inKxwCjCknGwiYww4RPfAb9twSY55E/k
         2GAA==
X-Gm-Message-State: APjAAAWuP+SZKhN4FVNXD61vyFkHwHPY5b2iJeTd8iVjOVZfXUnvA23H
        Ji37i9Tbp8ReIbaws8ECDqk=
X-Google-Smtp-Source: APXvYqyNYoCTctAhbu9foUYt3bDNqUSc/dwGTG2jFKTTTO7EJfDZ49syEsXJVGiNlcu7syIg2ntF7g==
X-Received: by 2002:a17:90a:b114:: with SMTP id z20mr1926562pjq.113.1569885455103;
        Mon, 30 Sep 2019 16:17:35 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH 12/15] RDMA/srpt: Rework the approach for closing an RDMA channel
Date:   Mon, 30 Sep 2019 16:17:04 -0700
Message-Id: <20190930231707.48259-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Instead of relying on a waitqueue, report when the identity of an RDMA
channel can be reused through a completion.

Cc: Honggang LI <honli@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 30 +++++++--------------------
 drivers/infiniband/ulp/srpt/ib_srpt.h |  3 +++
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index dabaea301328..88e11a250c96 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1928,41 +1928,22 @@ static int srpt_disconnect_ch(struct srpt_rdma_ch *ch)
 	return ret;
 }
 
-static bool srpt_ch_closed(struct srpt_port *sport, struct srpt_rdma_ch *ch)
-{
-	struct srpt_nexus *nexus;
-	struct srpt_rdma_ch *ch2;
-	bool res = true;
-
-	rcu_read_lock();
-	list_for_each_entry(nexus, &sport->nexus_list, entry) {
-		list_for_each_entry(ch2, &nexus->ch_list, list) {
-			if (ch2 == ch) {
-				res = false;
-				goto done;
-			}
-		}
-	}
-done:
-	rcu_read_unlock();
-
-	return res;
-}
-
 /* Send DREQ and wait for DREP. */
 static void srpt_disconnect_ch_sync(struct srpt_rdma_ch *ch)
 {
+	DECLARE_COMPLETION_ONSTACK(closed);
 	struct srpt_port *sport = ch->sport;
 
 	pr_debug("ch %s-%d state %d\n", ch->sess_name, ch->qp->qp_num,
 		 ch->state);
 
+	ch->closed = &closed;
+
 	mutex_lock(&sport->mutex);
 	srpt_disconnect_ch(ch);
 	mutex_unlock(&sport->mutex);
 
-	while (wait_event_timeout(sport->ch_releaseQ, srpt_ch_closed(sport, ch),
-				  5 * HZ) == 0)
+	while (wait_for_completion_timeout(&closed, 5 * HZ) == 0)
 		pr_info("%s(%s-%d state %d): still waiting ...\n", __func__,
 			ch->sess_name, ch->qp->qp_num, ch->state);
 
@@ -2089,6 +2070,9 @@ static void srpt_release_channel_work(struct work_struct *w)
 	list_del_rcu(&ch->list);
 	mutex_unlock(&sport->mutex);
 
+	if (ch->closed)
+		complete(ch->closed);
+
 	srpt_destroy_ch_ib(ch);
 
 	srpt_free_ioctx_ring((struct srpt_ioctx **)ch->ioctx_ring,
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index ee9f20e9177a..d0955bc0343d 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -264,6 +264,8 @@ enum rdma_ch_state {
  * @zw_cqe:	   Zero-length write CQE.
  * @rcu:           RCU head.
  * @kref:	   kref for this channel.
+ * @closed:	   Completion object that will be signaled as soon as a new
+ *		   channel object with the same identity can be created.
  * @rq_size:       IB receive queue size.
  * @max_rsp_size:  Maximum size of an RSP response message in bytes.
  * @sq_wr_avail:   number of work requests available in the send queue.
@@ -306,6 +308,7 @@ struct srpt_rdma_ch {
 	struct ib_cqe		zw_cqe;
 	struct rcu_head		rcu;
 	struct kref		kref;
+	struct completion	*closed;
 	int			rq_size;
 	u32			max_rsp_size;
 	atomic_t		sq_wr_avail;
-- 
2.23.0.444.g18eeb5a265-goog

