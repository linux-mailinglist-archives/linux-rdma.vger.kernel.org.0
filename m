Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58941DF14C
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 23:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgEVVd4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 17:33:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46086 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbgEVVd4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 17:33:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12so4914033plz.13
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 14:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cMKI/PI9BVrcCOggrtr7KyDylvCF+aXKoXPAnRVfFPw=;
        b=LTQV0wOuuQPHbiD5J2kFnpPbQLgmd6pWoF6CDq3Piz2yDHbjvVzwatE9Vko10YUOD2
         9BjyCLsqxv7OHr4a/2vN2ISYVaAdeTsa6OC5mEqrnXnVvji2tie68R8Z4WTpB8mJqxs7
         V+w7oTz2W1OlVNYkU3WrJ0pR832Bbyrn0VMonfsUEr8Rpc2OXzWY7IAtytxdYxk5TVZp
         sJl73MOv0I5KzTXFxVro1UB2vE/1wZyBpbwL1phNAW59ijVrVyb/dZxAUJLH1HeQ60d1
         ObawQEIpE5aFu8+DWhY88VtoMi8u7cjoAvsDqquGjsdt8kcztbR9ISX6AnyJ3ZlgddrC
         hbDg==
X-Gm-Message-State: AOAM530VGO/hDDBIsZOfciv2jVocxP8eDJqEfg0khiJQwyCk1sxq6sNO
        thzrSLzy/SKzkkWD0FhjuBc=
X-Google-Smtp-Source: ABdhPJx8IdquqlD300TqaOPaTCxb8/BET2Zx2TwRiVnHk//IAKhUY8nSFHR5XBUjxNsWGqROLRdnhg==
X-Received: by 2002:a17:90a:2a4a:: with SMTP id d10mr6866578pjg.32.1590183235221;
        Fri, 22 May 2020 14:33:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:b874:274b:7df6:e61b])
        by smtp.gmail.com with ESMTPSA id mn19sm7480755pjb.8.2020.05.22.14.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 14:33:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH 4/4] RDMA/srpt: Increase max_send_sge
Date:   Fri, 22 May 2020 14:33:41 -0700
Message-Id: <20200522213341.16341-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522213341.16341-1-bvanassche@acm.org>
References: <20200522213341.16341-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The ib_srpt driver limits max_send_sge to 16. Since that is a workaround
for an mlx4 bug that has been fixed, increase max_send_sge. For mlx4, do
not use the value advertised by the driver (32) since that causes QP's
to transition to the error status.

See also commit f95ccffc715b ("IB/mlx4: Use 4K pages for kernel QP's WQE
buffer").

Cc: Laurence Oberman <loberman@redhat.com>
Cc: Kamal Heib <kamalheib1@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 25 +++++++++++++++++++++++--
 drivers/infiniband/ulp/srpt/ib_srpt.h |  5 -----
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 1ad3cc7c553a..8d9b8664ea75 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1781,8 +1781,30 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	struct srpt_device *sdev = sport->sdev;
 	const struct ib_device_attr *attrs = &sdev->device->attrs;
 	int sq_size = sport->port_attrib.srp_sq_size;
+	unsigned int max_sge_delta = 0;
 	int i, ret;
 
+	switch (sdev->device->ops.driver_id) {
+	case RDMA_DRIVER_MLX4:
+		/*
+		 * The smallest max_sge_delta value that works with
+		 * ConnectX-3 firmware version 2.42.5000.
+		 */
+		max_sge_delta = 2;
+		break;
+	case RDMA_DRIVER_MTHCA:
+		/*
+		 * From the OFED release notes: In mem-free devices, RC
+		 * QPs can be created with a maximum of (max_sge - 1)
+		 * entries only. See also
+		 * https://git.openfabrics.org/?p=compat-rdma/docs.git;a=blob;f=release_notes/mthca_release_notes.txt;h=40f3c4ea77a07fe5ded888b8417530471e89d87b.
+		 */
+		max_sge_delta = 1;
+		break;
+	default:
+		break;
+	}
+
 	WARN_ON(ch->rq_size < 1);
 
 	ret = -ENOMEM;
@@ -1816,8 +1838,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	 */
 	qp_init->cap.max_send_wr = min(sq_size / 2, attrs->max_qp_wr);
 	qp_init->cap.max_rdma_ctxs = sq_size / 2;
-	qp_init->cap.max_send_sge = min(attrs->max_send_sge,
-					SRPT_MAX_SG_PER_WQE);
+	qp_init->cap.max_send_sge = attrs->max_send_sge - max_sge_delta;
 	qp_init->cap.max_recv_sge = 1;
 	qp_init->port_num = ch->sport->port;
 	if (sdev->use_srq)
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index 2e1a69840857..f31c349d07a1 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -105,11 +105,6 @@ enum {
 	SRP_CMD_ACA = 0x4,
 
 	SRPT_DEF_SG_TABLESIZE = 128,
-	/*
-	 * An experimentally determined value that avoids that QP creation
-	 * fails due to "swiotlb buffer is full" on systems using the swiotlb.
-	 */
-	SRPT_MAX_SG_PER_WQE = 16,
 
 	MIN_SRPT_SQ_SIZE = 16,
 	DEF_SRPT_SQ_SIZE = 4096,
