Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB173588A4
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 19:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfF0RhY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 13:37:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38004 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfF0RhX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jun 2019 13:37:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id 9so895813ple.5;
        Thu, 27 Jun 2019 10:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f6W5KMKCrBYCenF5FPPVjq886E+702BJmJKn41N9JBg=;
        b=OG/aIxO+S74y6YbVG3h6Qw0ijCfbSN5QlCMmsrFD8TWqeu0QXxdK+R0LKp3kuDfKMU
         0O5hmC2osmcwRITfwEHDdQuE6pi2/PG/qUm8DjeWvg8lZGZvARbZuq02s6P9qnzLtWy6
         Kqg6Dq4lBlg8gn8tJvdJKUxCLRdeaVtd8S8RwyvhHMYtFZP85H4yIZfhQ7X5V8zGGGJY
         xXoXZGRcS5fYeIxaXApL2IivlNUho4IK2VuRQXUk6xydlg/7qKR48mH4LZ1qB3LT2ECT
         j7RAqzk99P+0ybuqWpN1pHZMeSsM3wDthzQo3QzYgeluDqABeHVj5q88X2tQZoFj8pBv
         0dYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f6W5KMKCrBYCenF5FPPVjq886E+702BJmJKn41N9JBg=;
        b=pACLZzGrOHukSJi7W+CKsPEwcAm0ZEo4cvGBiiL23XzrKs9yuA0ki6/MEDy6BxI2mE
         MKA0yS6nxoZ9AvGvN7RIrWO1Wvoqdr1tELPIkDJ3s9Fl+FdbED3MQ2xf8cFJMx3BSlyg
         VSejSd0RCCof1W2BrUt4GTERscvN5Zy+bjZwsL6XTo5GeV/473JX12dSINipj57+A6fN
         ioWObR8XkXK26F7br/mUFzUJo9qNUeCTx9xtQG1rdY8l+rb8seJ3zqp7kevuGsTI1XyO
         NhR10vvDLf6kPEcgMUtFsxI6DQ0s/2kqUwzDyB9BVrtpyMWTwFLXcF+45LjcJo7R/Qxi
         2H/g==
X-Gm-Message-State: APjAAAVGML2joeHazBEeBiYA9PVMYyktkpTZRtPIWfgm9QdHPZ870AnV
        QlVNqlrPYv2zTxQEzoHAf0M=
X-Google-Smtp-Source: APXvYqzrQh4Mvzlmnh5+56v2vNL+LD3S0EIFKRcjYpOiF577m6axKH4uhHVjT3NRcBkLvNza7YeLAA==
X-Received: by 2002:a17:902:1e9:: with SMTP id b96mr5977844plb.277.1561657043187;
        Thu, 27 Jun 2019 10:37:23 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 131sm8020524pfx.57.2019.06.27.10.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:37:22 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/87] infiniband: cxgb4: Remove call to memset after dma_alloc_coherent in qp.c
Date:   Fri, 28 Jun 2019 01:37:16 +0800
Message-Id: <20190627173717.2991-1-huangfq.daxian@gmail.com>
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
 drivers/infiniband/hw/cxgb4/qp.c | 1 -
 1 file changed, 1 deletion(-)

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

