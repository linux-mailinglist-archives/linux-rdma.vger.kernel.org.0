Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45DCBB8A8
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 17:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbfIWPxS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 11:53:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33771 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbfIWPxS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 11:53:18 -0400
Received: by mail-io1-f66.google.com with SMTP id z19so12480561ior.0;
        Mon, 23 Sep 2019 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ah97PWhBQllHvUmQP5lNKcxTltHIduIyS/x+VCiBzGk=;
        b=P/TbzBez5vHy8/yao1OuiUgpxf3Qd4RJaODHAMLc4UVmKtiEiJosxcV7cmYSjs2fyn
         VHCKPSeu+3nIeu4R1Ez0EDXGTXbq/8swT5bIhSyA1278jBzBlu4cFlyAweACoyzCQqis
         r1K3szwlpCsN3a4/PPK9WIJB2l9JTr3ZkTNBC8hD6ZqF+gw9tUVvvZPji+UF6Tq1+Y+r
         Ls2n8QKv8X59r7DIWtgPqpgX2bBEypETlCk6yhNfwWknBM6BckJz/3PqK/D1GNQEYz6u
         PEP0Ah7OVyvdAr6/FbFSdDTgBr7nc3uCQMIfbXIJBTbIxAj6ClfD3VS/QS4NZ9Hrowxy
         qmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ah97PWhBQllHvUmQP5lNKcxTltHIduIyS/x+VCiBzGk=;
        b=WJXhHZEgTa7rsdYMlHgeK69hS0TYtm28yg7P3S6KDQngVoRn+VqeIBqzpaJI2yP41M
         DgKt3/NcZ/ftjCIPgOek08Hj8HFI5EPhGZvyWd9RdIGbQ2bUMyr14sh3jO14SjQ1WX6+
         /kRJnDSxedpsck1T3Zw82MZvWQ2w7nCd0JCebxAuhMcDrPtcel1ugAusUZMhW8tvtCog
         x/gXmX6pvPgfqj0CaeeCFJgKLbkwmqtuTUfRjTJf09r7DQGe0au+zqKMc2uumVK2UiEr
         dHcZYI+5uQQMLkz2ngg6gxHH/EKvt3v1fFWM/JBDCSnguGSMo8l07l8j+Wwsgiue3ZAf
         sD5Q==
X-Gm-Message-State: APjAAAXuHkdBhq+Ia9HQ4b8m00Y5jndXfpXWTPfgfY4ht3lr103dyq+S
        3kiYFj6sibMuDfZD3bOMQ6E=
X-Google-Smtp-Source: APXvYqxSEa3nkHQJ8qte5MAQfQVcainVzehT8UD0UrHT1LadXl/4J9G4yT0WS/80QXvLOZ2tJhZVSA==
X-Received: by 2002:a5e:9e04:: with SMTP id i4mr25866429ioq.175.1569253996678;
        Mon, 23 Sep 2019 08:53:16 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id c5sm8463116ioq.61.2019.09.23.08.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 08:53:16 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     leon@kernel.org
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] RDMA: release allocated skb
Date:   Mon, 23 Sep 2019 10:52:59 -0500
Message-Id: <20190923155300.20407-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923050823.GL14368@unreal>
References: <20190923050823.GL14368@unreal>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In create_cq, the allocated skb buffer needs to be released on error
path.
Moved the kfree_skb(skb) under err4 label.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/infiniband/hw/cxgb4/cq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index b1bb61c65f4f..1886c1af10bc 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -173,6 +173,7 @@ static int create_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
 err4:
 	dma_free_coherent(&rdev->lldi.pdev->dev, cq->memsize, cq->queue,
 			  dma_unmap_addr(cq, mapping));
+	kfree_skb(skb);
 err3:
 	kfree(cq->sw_queue);
 err2:
-- 
2.17.1

