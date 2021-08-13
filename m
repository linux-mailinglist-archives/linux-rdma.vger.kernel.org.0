Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9C63EAFD0
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Aug 2021 07:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbhHMF6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Aug 2021 01:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbhHMF6U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Aug 2021 01:58:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13524C061756
        for <linux-rdma@vger.kernel.org>; Thu, 12 Aug 2021 22:57:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id oa17so13803218pjb.1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Aug 2021 22:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=i0qWWQlV8mPEAy/HJJ6WZRO8G5Ltg0w1BbBOQiO+T10=;
        b=T+BQC7mdTCzLIRCAQoNmeGAHfiSvpeb40LqMpE91yLAiEfvJa2epH5A9N8q4jpkPPV
         4uOKwdKT6TsJfYNlMzuh0IjsTZgNe0Q6D7DfywzzkaQAvA96MERqcpAIwSCl9oRFYC3v
         4kKIGeVC1yX4lhJN/vjS4FNnQGvVxIqEYP0kITZPY4Q/L+OBvjMDoWSVLqR4lcVkZTM+
         SIBPFJSenWSY8aTQRH6jhIhS8P3Vn2vqAqXZ49iJCGBEuwfV8NURAy6jkjmq34aKky3K
         87wzQTQEltWN7wEJ84rJD627sEUNggcBz9YYT5e1ymtB4t312zWgFjNMmUzOXEWlWcNQ
         ERIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i0qWWQlV8mPEAy/HJJ6WZRO8G5Ltg0w1BbBOQiO+T10=;
        b=eUmzXslO5Sg6M5HgzscoqisZxLsnmF3M0+KDuMU749Q8VafZBwz2eTJy7aEbPXH6f1
         Thzp3+8j+bsC67HGhPF2Mv8VcSo6KJAPEU8BZ2IXDEmTwG9ZkB5/6gnGgKip+o6b+Pkj
         KwKP14BujGl2rM/EcWWjohC1KS33CB9Rbfsu3iZJ79w2JF+MqOGtB6Fhp5CoGLxIBHdU
         UGj2NsHWOTKxAe/ss5hhKnmYfWsEwqxsuNr5+h8NzjwAVE5HlSZrDOjmF950K2kcoYfF
         7eQaOZqX5XYnERKhMEog/NU8uzm3NbLH0KWFXNsuP31x6sCOiQA6QGJ3n4ERcWr7+vo2
         Ewhg==
X-Gm-Message-State: AOAM530rMjyWSkfhsmknWDDqjD1rf2qheGUDIyKIFwgHejM+f6hpWHHT
        wtm2a1RyGFXu6KMtSEInRVBsWP5GMuuzVIzH
X-Google-Smtp-Source: ABdhPJxx9zeUV6PqoHOQARK91DpqaKm1bIapobXZqOwjq1RS2c7w397JZActgouPxlkBwMxCkjLspw==
X-Received: by 2002:a17:90a:f292:: with SMTP id fs18mr983206pjb.4.1628834273515;
        Thu, 12 Aug 2021 22:57:53 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id y5sm138494pgs.27.2021.08.12.22.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 22:57:53 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     mie@igel.co.jp, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/rxe: Remove duplicate umem assignment
Date:   Fri, 13 Aug 2021 14:57:29 +0900
Message-Id: <20210813055729.19885-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

While initialization of rxe_mr, mr->umem is assigned duplicate. Remove
the redundant code.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 73bbafd32554..6e2e0da2e50d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -122,7 +122,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		goto err1;
 	}
 
-	mr->umem = umem;
 	num_buf = ib_umem_num_pages(umem);
 
 	rxe_mr_init(access, mr);
-- 
2.25.1

