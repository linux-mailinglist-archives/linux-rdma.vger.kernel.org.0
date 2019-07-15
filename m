Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C242C6828B
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 05:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfGODSA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Jul 2019 23:18:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41631 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGODR7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Jul 2019 23:17:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so7510668pls.8;
        Sun, 14 Jul 2019 20:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MWph+F2q7pgDhwwto0Vrel41tbz5XzXP/KFnu14R0Fo=;
        b=WFrAcQp8JxCVJVtIpdDo6UBTHTNY7ZRNwH3xBIaG24g+JJJAaK85QR9iBl2V/AE9qG
         xIqSZtDB2Ge/3DUskhgzGXITeJXJk1q1n8eb4xmKMzi5oBgbDynXU6hh2Q3Y0fitF7Jm
         Eh9KPKUuk0icCwkTnW0DK54Od98Y6PAm83fVt0dPndRdiHeS/iZCqMc8OCEYjmsS2AfK
         UFeM2r5mic0Ui7Dd6LpZXICP6jU5TqR1zFHI5uLCaeJMlTfdj6EaRA53pyzZ3x2qyTZu
         H2tfkJson1o9yDO3bvNmX4dTceZE5PQNV9xCriyp0ulcE3z5SD+8U0GU+/3QnoIglIlm
         Lc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MWph+F2q7pgDhwwto0Vrel41tbz5XzXP/KFnu14R0Fo=;
        b=O9ntGGFoxh5Yz05K36DJoVaqRz+jNI5SnG2ZgzxLoU//W59dtMHecqdbbu1bVsX0ln
         0mFET05F3dGiznPsn9u4ZvORTjKMm/Og9kN+vUxLdpjSwgOPESr7SNQMhSXfsjIaX3vY
         0T8wFcUem9wVDlJfb8PqpLZQg3LV0odxXyJ/eTCzRWB3YdFg0uh8YtPym316YWMroccX
         vpSx2C12zOWcoTIcEYWM7XB0HNPCuEZcrMLyMu0V1ckUBFjApe8Tn+kHEUejGwuzgGJL
         4ANbQYJA1IuAdChM2XLx5Z7U7QOsSpF5QG5trsGBMYg3yw23ig3dMBrChIqLWDvTNXI0
         AjPA==
X-Gm-Message-State: APjAAAWaRQQuVPBt7BjqmuHvjcLRgunJXH7/l3E89i1CHAAag/Wr8Kxg
        QQxxiGsjlFXwu0i6QDl1pgg=
X-Google-Smtp-Source: APXvYqxUh3eCid6DOB1tllsOgHS0lEhRftUZfBotJVlPTz8pebE8d2CEoDlTAdMSXdhG77M3o19p/w==
X-Received: by 2002:a17:902:9004:: with SMTP id a4mr25968124plp.109.1563160678856;
        Sun, 14 Jul 2019 20:17:58 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 21sm15113420pjh.25.2019.07.14.20.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:17:58 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 08/24] rdma/cxgb4: Remove call to memset after dma_alloc_coherent
Date:   Mon, 15 Jul 2019 11:17:52 +0800
Message-Id: <20190715031752.6560-1-huangfq.daxian@gmail.com>
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

 drivers/infiniband/hw/cxgb4/cq.c | 1 -
 drivers/infiniband/hw/cxgb4/qp.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 52ce586621c6..fcd161e3495b 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -104,7 +104,6 @@ static int create_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
 		goto err3;
 	}
 	dma_unmap_addr_set(cq, mapping, cq->dma_addr);
-	memset(cq->queue, 0, cq->memsize);
 
 	if (user && ucontext->is_32b_cqe) {
 		cq->qp_errp = &((struct t4_status_page *)
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index e92b9544357a..4882dcbb7d20 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -274,7 +274,6 @@ static int create_qp(struct c4iw_rdev *rdev, struct t4_wq *wq,
 			 (unsigned long long)virt_to_phys(wq->sq.queue),
 			 wq->rq.queue,
 			 (unsigned long long)virt_to_phys(wq->rq.queue));
-		memset(wq->rq.queue, 0, wq->rq.memsize);
 		dma_unmap_addr_set(&wq->rq, mapping, wq->rq.dma_addr);
 	}
 
-- 
2.11.0

