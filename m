Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4745211A9B9
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 12:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfLKLQm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 06:16:42 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35777 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfLKLQm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Dec 2019 06:16:42 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so2611129qka.2;
        Wed, 11 Dec 2019 03:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/3VanHZmbF0755d2iFbA3E2Cbgc2bj93oc0GoMrmjNk=;
        b=sE9N3zNVZuaeIFqI5DUSTHpF/sxH32iejKagn9ACHdNURHgc0FvK/F8NeZ43Km+Mv3
         94esEzjYq64lt8IXfqWtnNTM+mKIZZApZDprATZXD3cJEHxEs3Px0XOL9Hfg9A2qrAA3
         uh2JdyxiAujoigNRF+lt16CGBbz6ysFUqnnd8CkHOvcFoGReZvV/lGIOD9FnBCnHKm9S
         VfNnXy8FnMSBJ71i1mEKa9sUiE/qYdefMoIPqrm5vx1Cq03gZc3N7mLnT3YdTTqcgVlO
         BDCdTppRddIIrQ3v4dBJsMT4ZYieiJQqPtdYjKSAScdgAv9BWc1tg0B7xX+/+DR0oyjO
         I3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/3VanHZmbF0755d2iFbA3E2Cbgc2bj93oc0GoMrmjNk=;
        b=AzUVHGkfeiSjyXR9FbpCV8veg2A5Q6O4y93IjRbSTx/QRGoQ/X5pJCOrKMMPVMC8eX
         gX2zA0HfUghuwYYmqzXYiVe03480mrvg9JLUH3mn76ex+KLSbW1GxLaGKKMlruV3RF96
         DIPOLlK9MhC2rkK90sWyyC0Uvk1/dIXa7ne22P4zxw4R/is6uC5urYN9Nh6eQk7YmH2k
         H68EYZJ47cP8OoQtZlDNPOwmQtMbr6evne2kMwfVX9kkpsDxW5E4erObWIq5TwQig+xn
         S75255WGtaSjeZ2crwgMdrujbB091lX0Jzer5T8t+ivF9HN54on5+q2SvTlPUxwoWcsS
         z34g==
X-Gm-Message-State: APjAAAUphcfvO9Vu6/yqck9SkH+wILR/ih/9pz+a+y2cEUe6znFlQ8rN
        MmjtNxfHDJt89eQbjoNf59A=
X-Google-Smtp-Source: APXvYqxpqmganWvOu/AytAOAkqr6p++/a7SavUFCa3CB6PyOBOvZE+57eR9t1aCrOnEnvmkmttOBrA==
X-Received: by 2002:a37:9906:: with SMTP id b6mr2191465qke.406.1576063001108;
        Wed, 11 Dec 2019 03:16:41 -0800 (PST)
Received: from linux.hsd1.pa.comcast.net (c-76-124-64-60.hsd1.pa.comcast.net. [76.124.64.60])
        by smtp.gmail.com with ESMTPSA id f21sm752178qto.82.2019.12.11.03.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 03:16:40 -0800 (PST)
From:   Max Hirsch <max.hirsch@gmail.com>
Cc:     Max Hirsch <max.hirsch@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Steve Wise <swise@opengridcomputing.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dag Moxnes <dag.moxnes@oracle.com>,
        Myungho Jung <mhjungk@gmail.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/cma: Fix checkpatch error
Date:   Wed, 11 Dec 2019 11:16:26 +0000
Message-Id: <20191211111628.2955-1-max.hirsch@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When running checkpatch on cma.c the following error was found:

ERROR: do not use assignment in if condition
#413: FILE: drivers/infiniband/tmp.c:413:
+	if ((ret = (id_priv->state == comp)))

This patch moves the assignment of ret to the previous line. The if statement then checks the value of ret assigned on the previous line. The assigned value of ret is not changed. Testing involved recompiling and loading the kernel. After the changes checkpatch does not report this the error in cma.c.

Signed-off-by: Max Hirsch <max.hirsch@gmail.com>
---
 drivers/infiniband/core/cma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 25f2b70fd8ef..bdb7a8493517 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -410,7 +410,8 @@ static int cma_comp_exch(struct rdma_id_private *id_priv,
 	int ret;
 
 	spin_lock_irqsave(&id_priv->lock, flags);
-	if ((ret = (id_priv->state == comp)))
+	ret = (id_priv->state == comp);
+	if (ret)
 		id_priv->state = exch;
 	spin_unlock_irqrestore(&id_priv->lock, flags);
 	return ret;
-- 
2.17.1

