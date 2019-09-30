Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 075F9C2AB7
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfI3XR3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44096 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731831AbfI3XR2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so6472478pfn.11
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2yyKJ+48yJsyLDfmpXnIm0mNhIybbQPF2WIfgTuD98=;
        b=MxDzYDft+B8e6AsF6ziYh2ZSujZW8CTSEowaVJfNu0FG6lHK0hsSoIJNKqwJ6qyfVL
         xzcfjhcQw+pLFwj3HcxRUeKjq5VXC6kBQl+0dM+79p7X2EL4Q3+sbNZ0NfzE+xcFRUs8
         NQzk1GBWr5fO7OHKs5+Q7UYei9QGrYUOacj1hDP9XRC3rwAnH1ZDH0jRRRbTrWq7Ik29
         m6xgn9bf/cy8iou1wnqw9bi4cqbe0ZL7M0s+JnkC0ZqxGZ0o21yhTVf4Khcpf3DSE5/r
         qSccSzvk0xPKqOk5hk+37mCnwcz6tUNGKMNsyuZv1MLGiQIderpaFXTo7dyzbuSITCUH
         ciqg==
X-Gm-Message-State: APjAAAXqg4xbzD1SpvPRaNDdBaiS/PVCsUw22ns11CkkVQZdEKlCIhjk
        05RvLrRC9hpAlempyBHMuk0=
X-Google-Smtp-Source: APXvYqzeSecd5KwPqgD9ItA2eaoclpKvABdHoDsmi9b8NFlZh9VP69oSQbIDNd6YMOOWsRYuKBcKDA==
X-Received: by 2002:a65:68c4:: with SMTP id k4mr26642797pgt.180.1569885447963;
        Mon, 30 Sep 2019 16:17:27 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH 07/15] RDMA/srp: Honor the max_send_sge device attribute
Date:   Mon, 30 Sep 2019 16:16:59 -0700
Message-Id: <20190930231707.48259-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Instead of assuming that max_send_sge >= 3, restrict the number of scatter
gather elements to what is supported by the RDMA adapter.

Cc: Honggang LI <honli@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 7 +++++--
 drivers/infiniband/ulp/srp/ib_srp.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index f015dc4ce22c..d77e7dd3e745 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -552,6 +552,7 @@ static int srp_create_ch_ib(struct srp_rdma_ch *ch)
 {
 	struct srp_target_port *target = ch->target;
 	struct srp_device *dev = target->srp_host->srp_dev;
+	const struct ib_device_attr *attr = &dev->dev->attrs;
 	struct ib_qp_init_attr *init_attr;
 	struct ib_cq *recv_cq, *send_cq;
 	struct ib_qp *qp;
@@ -583,12 +584,14 @@ static int srp_create_ch_ib(struct srp_rdma_ch *ch)
 	init_attr->cap.max_send_wr     = m * target->queue_size;
 	init_attr->cap.max_recv_wr     = target->queue_size + 1;
 	init_attr->cap.max_recv_sge    = 1;
-	init_attr->cap.max_send_sge    = SRP_MAX_SGE;
+	init_attr->cap.max_send_sge    = min(SRP_MAX_SGE, attr->max_send_sge);
 	init_attr->sq_sig_type         = IB_SIGNAL_REQ_WR;
 	init_attr->qp_type             = IB_QPT_RC;
 	init_attr->send_cq             = send_cq;
 	init_attr->recv_cq             = recv_cq;
 
+	ch->max_imm_sge = min(init_attr->cap.max_send_sge - 1U, 255U);
+
 	if (target->using_rdma_cm) {
 		ret = rdma_create_qp(ch->rdma_cm.cm_id, dev->pd, init_attr);
 		qp = ch->rdma_cm.cm_id->qp;
@@ -1838,7 +1841,7 @@ static int srp_map_data(struct scsi_cmnd *scmnd, struct srp_rdma_ch *ch,
 		return -EIO;
 
 	if (ch->use_imm_data &&
-	    count <= SRP_MAX_IMM_SGE &&
+	    count <= ch->max_imm_sge &&
 	    SRP_IMM_DATA_OFFSET + data_len <= ch->max_it_iu_len &&
 	    scmnd->sc_data_direction == DMA_TO_DEVICE) {
 		struct srp_imm_buf *buf;
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index af9922550ae1..f38fbb00d0e8 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -161,6 +161,7 @@ struct srp_rdma_ch {
 	};
 	uint32_t		max_it_iu_len;
 	uint32_t		max_ti_iu_len;
+	u8			max_imm_sge;
 	bool			use_imm_data;
 
 	/* Everything above this point is used in the hot path of
-- 
2.23.0.444.g18eeb5a265-goog

