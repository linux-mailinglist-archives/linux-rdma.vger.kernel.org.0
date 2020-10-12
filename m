Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D51A28B5EA
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbgJLNS2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388160AbgJLNS2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB89C0613D0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i5so16889518edr.5
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AKb1ORSrYwaqhwcZIKU1056JH5MXQiyVvSQIqGZ4l/A=;
        b=bYAmr8pUCCzdX18JYZLIKNDXoJxyUaUmJXzgYU3Axtrawn2lB9YGBijRGMJalg5l8z
         B45inLSKKExuFfKgvy7HoFHZRsuDZ/sG60WVlocIhQKzIEtWZMr2D7i1KLRLUpcy9pAi
         901N27f9N/+CxzKhMUyWESviq98UN71Hxtby4wv2F/kGL74RXJJOJVixE9qTPIdi2LYE
         cH0Qvh7RVQDlq/DJYzAcX+ff3l0VB6QgAXKBcuqH7fZT22WyIZ2EbMDh5iFOCnZ5ECLg
         6zkeRIYpaH9fZ6gvT6zYRqUzOp/YkWAPXJIO8hB3gF3nh1oP9VzoH+uq7DUAMYb0gJcR
         xPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKb1ORSrYwaqhwcZIKU1056JH5MXQiyVvSQIqGZ4l/A=;
        b=kcc/TaWWRUOfjRGeIL/6ZpAoZW66iFe8WYy+nrrTF/M0iZAypUDt5lPPWJ6OYSX/gQ
         +J4I8E2AWvVJeethRIMBPZ3YMlfYYRfm8a2SN2u37h6UQ5w3qpmlT8T6fhMEsrK+M+Ka
         QpWMm3nYRjLSvopUarJQg4QQ8SOPx1WHdL217dFPeUqYB7/NUtEYmdL2nDXjlY5kSwpa
         chH2o2BTGeDkscKAsguIm84XCIQoV/KCDMUjm6UkQbwlhF3OuZ2n05pBm4lr9PrKBeIJ
         LzRa3UOB8UYmEflIZgPMEIV43f+5QdSpexsrjPUWCyk3xJPcSogQjg0IfzJpbetfq2/R
         3bLA==
X-Gm-Message-State: AOAM533Mjp8dE5xdl14b4KRrZLbkTE3cTzYoysOlG6Df1xFx1NhEpk+x
        Xk8g9AnPe8FNRvumZOV22k0OCIiK3XK7Zg==
X-Google-Smtp-Source: ABdhPJwuzqS7MP8TrVN64z/o1g73UFJebwSj64EKrdiEYW6xru2CrDP8mEVFhSRm+dpr1LqfsjcoZw==
X-Received: by 2002:aa7:d782:: with SMTP id s2mr14032265edq.111.1602508705952;
        Mon, 12 Oct 2020 06:18:25 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:25 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH for-next 10/13] RDMA/rtrs-srv: fix typo
Date:   Mon, 12 Oct 2020 15:18:11 +0200
Message-Id: <20201012131814.121096-11-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

It should mean region here.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index dc95b0932f0d..6fb39e46e248 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -62,7 +62,7 @@ struct rtrs_srv_op {
 
 /*
  * server side memory region context, when always_invalidate=Y, we need
- * queue_depth of memory regrion to invalidate each memory region.
+ * queue_depth of memory region to invalidate each memory region.
  */
 struct rtrs_srv_mr {
 	struct ib_mr	*mr;
-- 
2.25.1

