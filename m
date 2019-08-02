Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB2D7F697
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2019 14:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbfHBMLK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Aug 2019 08:11:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39933 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfHBMLK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Aug 2019 08:11:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so35990184pgi.6;
        Fri, 02 Aug 2019 05:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBxG4FOJ9DD9Cx5lh35bmxbfWydS0WqQT7U1r29fUWs=;
        b=OnZhIIczB687wVyPg13SbjSYXsSeklMmxlhBksetJU72HEqthGT8Vm0Lwjdm82fO/c
         +GO98ncrNnPT+DJphQ5Wrak5JxReJUPCS7L3OZLxbsLExMvus77vBLjflGQaIHZybrhX
         SblvfEyij5qNwUZYldR9W5Bm3aBeoHqj/lEMgdyIrRqSQ14SGYiA7N6R01OFonkaja2k
         8ySEloGCbSwmg+FqtnoX4oPm5GHCSIYOoJqFoh3V4MH1qLY6JE8xUNXtFuR6GB8WRS0T
         RmVtGjrk8EpIMjUxU6r7FLUyD8a8i70QOyoT8Fp5n8j8H/GQJPkEArg1BGVj9zWxV/V5
         ML7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBxG4FOJ9DD9Cx5lh35bmxbfWydS0WqQT7U1r29fUWs=;
        b=bV2FIp6UiXpR+AU+eGRTfQIyFjM9svhyYlwHuw9LIXkO/dAg+ZULKU1DJu+wFSXVB9
         Per+EwkUHWQyI5BOWUrMdFQRRRNzo3i+IWKwg+XfZ/fIp3K1TZtvGEyCA+95cACzByzS
         wPHTU1CoKdUyv9PYw1R76+3DEpM5Gorhs+f7AEhz5wWNPuEX2y/kIeGnbwfEy24Bv6fi
         Ha+hACIUTaOhBCR+nXKwnvT9kibd4PPBxSqCnogXGBEjEFW8IEmiGOPDD9JbrJq6bied
         I4pgFTT49hSEzhupN3nhqwQHBonDlI3Ov2EmfUvWD8cVvtuGBqI20x6pwOUsSEufFNJS
         CT2A==
X-Gm-Message-State: APjAAAX0WSebEi+lWdeCG32NwvH138fB9xpo4XESs/w1r6TLnfwsvORn
        Md+pyQcGCCWcotn2a7b8ef/etF3QvlDLnw==
X-Google-Smtp-Source: APXvYqwncBG8jexi3vyTdDOj9AzySHzYVQMdIwI7HY1xN+cwAk48joKEkHEYYMRYnK9dfv1Pp8d82Q==
X-Received: by 2002:a65:4507:: with SMTP id n7mr16054961pgq.86.1564747869964;
        Fri, 02 Aug 2019 05:11:09 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id s67sm8162531pjb.8.2019.08.02.05.11.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 05:11:09 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 3/3] IB/mlx5: Use refcount_() APIs
Date:   Fri,  2 Aug 2019 20:11:04 +0800
Message-Id: <20190802121104.1483-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch depends on PATCH 1/3.

After converting refcount to refcount_t, use
refcount_() APIs to operate it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/infiniband/hw/mlx5/srq_cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
index b0d0687c7a68..8fc3630a9d4c 100644
--- a/drivers/infiniband/hw/mlx5/srq_cmd.c
+++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
@@ -86,7 +86,7 @@ struct mlx5_core_srq *mlx5_cmd_get_srq(struct mlx5_ib_dev *dev, u32 srqn)
 	xa_lock(&table->array);
 	srq = xa_load(&table->array, srqn);
 	if (srq)
-		atomic_inc(&srq->common.refcount);
+		refcount_inc(&srq->common.refcount);
 	xa_unlock(&table->array);
 
 	return srq;
@@ -592,7 +592,7 @@ int mlx5_cmd_create_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 	if (err)
 		return err;
 
-	atomic_set(&srq->common.refcount, 1);
+	refcount_set(&srq->common.refcount, 1);
 	init_completion(&srq->common.free);
 
 	err = xa_err(xa_store_irq(&table->array, srq->srqn, srq, GFP_KERNEL));
@@ -675,7 +675,7 @@ static int srq_event_notifier(struct notifier_block *nb,
 	xa_lock(&table->array);
 	srq = xa_load(&table->array, srqn);
 	if (srq)
-		atomic_inc(&srq->common.refcount);
+		refcount_inc(&srq->common.refcount);
 	xa_unlock(&table->array);
 
 	if (!srq)
-- 
2.20.1

