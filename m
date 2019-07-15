Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 794E268288
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 05:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfGODRw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Jul 2019 23:17:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38638 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGODRw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Jul 2019 23:17:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so6737624pfn.5;
        Sun, 14 Jul 2019 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OHd9Gj1NXZziz3dxXYZkOlR2we6FjZ7KaJ1LbxYLKIQ=;
        b=VTWUsO+yBwtBB7RQyLiHu1HrtZoePeRGZ2rQ1viBoc7EvixAYcbTQqb71HaJn6uU80
         9n4luCtpd58rqt6PRNBLRu6FqVNGKZ7wKz1mj6OVx/rAtXZMbFkH099rlzbT3QvvFBXo
         hTIFi1y/2mwJV32WyPRi1S4hKl2wAxQ/yii+QeKzPJPRh6G2RwO69FBrO8PLENOpr59C
         LoIemjE0sw0ORIbCUeYDoaSff2GSCbCUHqm+ZL1gWuBh4GtzF9LCK0iQHkuCvJO2KCr+
         9fQtcT4CbcVNRO56qsXMN3zQzYSCKv+h4tx//r7w+NWjjV7LD1ibfuG/vU6e/1Bu5f/h
         QAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OHd9Gj1NXZziz3dxXYZkOlR2we6FjZ7KaJ1LbxYLKIQ=;
        b=njrYKFXwFzjZzfmqGf68PoemIQzEiqM7jFBnhkDYwQic9QT7z9Pt6eiO+f9PBeSZyq
         pm+cViYcpA9Lz03cRHsE/GydHTPD/oYXhPwBvphqLnz7xcZNmOi9d0Um2TXPr2PCsGAK
         a/E+8H2srVMWYdXMepO+oYn8RrN3Gqd/QkThnsnpygb4S0a58qHH/9NECUsRaFW4DVUh
         Thy5ijwz88M9crn1hf7P0Xo8U+VyB7v66RlB1DBVI0D6HtrgMfPywkNy0ZwxfrQVdQ95
         +Yyhv3C8j7Lu2FYDs5l+9bj2T17GxcW7U+N9u4ox7YPkxT3wUINp4pWR/ndyW/QwERM2
         oLlw==
X-Gm-Message-State: APjAAAUpv6Q29biEqj4GkFoc2flPn/pNNectd7wNEl4EmsFIBHT0amc+
        JZ+8S7Prhb+NhKifTctZ5SQSMU719o8=
X-Google-Smtp-Source: APXvYqy3gszgrnb7LI/UUiG1ZPlAKmEXD6r8pNLBxg0ZvGhSO7CNei6Al5BnSvNwXFeY8S858slnVA==
X-Received: by 2002:a65:430a:: with SMTP id j10mr25272177pgq.374.1563160671841;
        Sun, 14 Jul 2019 20:17:51 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id a15sm1926403pfg.102.2019.07.14.20.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:17:51 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 07/24] rdma/cxgb3: Remove call to memset after dma_alloc_coherent
Date:   Mon, 15 Jul 2019 11:17:46 +0800
Message-Id: <20190715031746.6514-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/infiniband/hw/cxgb3/cxio_hal.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.c b/drivers/infiniband/hw/cxgb3/cxio_hal.c
index 8ac72ac7cbac..0e37f55678f8 100644
--- a/drivers/infiniband/hw/cxgb3/cxio_hal.c
+++ b/drivers/infiniband/hw/cxgb3/cxio_hal.c
@@ -174,7 +174,6 @@ int cxio_create_cq(struct cxio_rdev *rdev_p, struct t3_cq *cq, int kernel)
 		return -ENOMEM;
 	}
 	dma_unmap_addr_set(cq, mapping, cq->dma_addr);
-	memset(cq->queue, 0, size);
 	setup.id = cq->cqid;
 	setup.base_addr = (u64) (cq->dma_addr);
 	setup.size = 1UL << cq->size_log2;
@@ -538,8 +537,6 @@ static int cxio_hal_init_ctrl_qp(struct cxio_rdev *rdev_p)
 	dma_unmap_addr_set(&rdev_p->ctrl_qp, mapping,
 			   rdev_p->ctrl_qp.dma_addr);
 	rdev_p->ctrl_qp.doorbell = (void __iomem *)rdev_p->rnic_info.kdb_addr;
-	memset(rdev_p->ctrl_qp.workq, 0,
-	       (1 << T3_CTRL_QP_SIZE_LOG2) * sizeof(union t3_wr));
 
 	mutex_init(&rdev_p->ctrl_qp.lock);
 	init_waitqueue_head(&rdev_p->ctrl_qp.waitq);
-- 
2.11.0

