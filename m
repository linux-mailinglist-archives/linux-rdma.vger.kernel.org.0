Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB47B1E135A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389523AbgEYRWc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:22:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39346 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbgEYRWb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 13:22:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id w20so3863690pga.6
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 10:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQgX5pBPHUT8PJw0TS32WLCIl7+LLGoh84FEwLrugTI=;
        b=rqV4vIDLaFRKQi9DeAW/n+Lk8G0Er914K2F11kIoL6BBLgcIjCKyzRRNlhysDUueVh
         1p/cyRGkPQ31Z+7zyK0WjumpFieHaRIbw4iZ2LqSJIzGtRIP0XwIs2T1rpjBV4YyQWZs
         HNGxxlMzlHIs3xc6omQiC0nexNzGS5Mpgg24a2sQjkp0YRTjR3a+1bfhLLlZxhgYmTsd
         aBfGjN6f4h2oJkaCtKsIVUh7sUnfR8v9ga0Cpg/RfT0/W+8wEZkXZCc3Xcj2tR+s5O44
         9Fp7dkk5YXBuYQW8qvmqOI+7ugnJ22+91ojDEymnktUXXdSh6gGlhKnlsWb/nLqs0zx+
         6jWA==
X-Gm-Message-State: AOAM5335lcUiFs27OdadZmYjrHbZtNjPfa4kv5Ukmj2dHUmLDyygbq2Q
        R9hq6wuOB4Kd9aJPsqZSCFM=
X-Google-Smtp-Source: ABdhPJxbfr+goayARI9hzYrx2M3WE+LuUAHotUQEJVp+LdE0/r/66igSmzseCqR83yCdNkCr0HDkvg==
X-Received: by 2002:aa7:8d8a:: with SMTP id i10mr14904461pfr.193.1590427350750;
        Mon, 25 May 2020 10:22:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:2590:9462:ff8a:101f])
        by smtp.gmail.com with ESMTPSA id p9sm3213238pff.71.2020.05.25.10.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 10:22:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH v2 4/4] RDMA/srpt: Increase max_send_sge
Date:   Mon, 25 May 2020 10:22:12 -0700
Message-Id: <20200525172212.14413-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525172212.14413-1-bvanassche@acm.org>
References: <20200525172212.14413-1-bvanassche@acm.org>
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
 drivers/infiniband/ulp/srpt/ib_srpt.c | 3 +--
 drivers/infiniband/ulp/srpt/ib_srpt.h | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 1ad3cc7c553a..86e4c87e7ec2 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1816,8 +1816,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	 */
 	qp_init->cap.max_send_wr = min(sq_size / 2, attrs->max_qp_wr);
 	qp_init->cap.max_rdma_ctxs = sq_size / 2;
-	qp_init->cap.max_send_sge = min(attrs->max_send_sge,
-					SRPT_MAX_SG_PER_WQE);
+	qp_init->cap.max_send_sge = attrs->max_send_sge;
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
