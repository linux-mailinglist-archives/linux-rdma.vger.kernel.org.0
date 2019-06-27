Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A795889F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 19:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfF0RhQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 13:37:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46866 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfF0RhP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jun 2019 13:37:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id v9so1319395pgr.13;
        Thu, 27 Jun 2019 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4DOTqG5TcNS9YEGmdvS/IEYW7zwxJJou7I4Tu6dQvK4=;
        b=q+7siww3RqIMgdo9svxfDfUOEd363YURluZoJQYsBnoL1n0iJbmo+QF0ogD5UyEueO
         XTQwuRksqr+UHjM5EvKUs4MMYVZhdB3ISapB8x9PVJcxLPvZVXGlDwC3XJuSn9zFSL0w
         6MCtcOc45nUaaKyz1aI4u5XnA5IaOGvADI89rPHROvL5CfXDbikqGnXzUGLzFPQ45nmi
         7tv6Tlp7jPXiCwmnEMFr+Y7myJ7WiRdVB1KDqMLwh1vgyl+U/nPTvf2ojff/fl7YvitF
         2InpKgXy+B+EYjQp8Cc/rRP9lu7wRX8p+2/RTC9nhhvUTLIg9gylYzPmyvjBs9dN23fG
         8gBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4DOTqG5TcNS9YEGmdvS/IEYW7zwxJJou7I4Tu6dQvK4=;
        b=hXKPbem31UedKaDN5T2O7ncmv1Bd+QJb4gvbQuA4M62Tv4UwOQVaF87LNXFed3ELsh
         Rj6bPO+IxLaM+oIGDr7SaM2HzvXe/vmYGqPbbAdofoIqogx7vRmEoSWC2KmP1i16ZCmz
         zU/5+hN9qrMvNA/G+KDZgCA66/ZAgaQIL4gIAQQgIXZ/yyyj8O6Z7D3Q4yj65sE69tdx
         2aBPH5JSdmLh01IjAv2FXPxbxDxUbsX6+aOBwStdwNGckwOgYuXh9d2epMHn0pY3lv2T
         7C5XaqTJvFGt2+gDhYBVbZY+4emZB8fwqXkoW0VF0WjxezZLvWj7L5/wJkbB6CfMVbi/
         F1AQ==
X-Gm-Message-State: APjAAAVV++FRwbqx4vMzbz4wgR+cpTytkK3+Fzz27B/hh2l/hCXG06Wo
        P+XuHpDFYkqFmDLpwAMz99Y=
X-Google-Smtp-Source: APXvYqwXT/aiooDxRuBPrZAPHQjrLa+YbnW+q2WaswYI176f4/JgQOw29tBqoHw6A0VNJpYLL6bzrQ==
X-Received: by 2002:a17:90a:2706:: with SMTP id o6mr7608739pje.62.1561657035183;
        Thu, 27 Jun 2019 10:37:15 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id o95sm1723457pjb.4.2019.06.27.10.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:37:14 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/87] infiniband: cxgb4: Remove call to memset after dma_alloc_coherent in cq.c
Date:   Fri, 28 Jun 2019 01:37:08 +0800
Message-Id: <20190627173708.2939-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/infiniband/hw/cxgb4/cq.c | 1 -
 1 file changed, 1 deletion(-)

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
-- 
2.11.0

