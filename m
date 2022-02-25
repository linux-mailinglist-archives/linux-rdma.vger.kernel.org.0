Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE24C4F2A
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 20:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiBYT7F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 14:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiBYT7D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 14:59:03 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9D9C4283
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:31 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so7816500ooi.7
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gRxGQVeQ8gc5qGppqiVvlRcLT/m93C3ZpTQfTwSLWFc=;
        b=WDOFCoMqM+Uo2lk3CiesFZty5jnYza9Z6Qlmli9yRtFGtT2Zdo7Ic+R0S/W5cKyupz
         EimIREwqSyPwrnk+9JQWhQ5rxfMEutvnDdsmGrX5L2Hf7W4T2LMCHNeRUeI9/kA3cT0M
         YRBrbjaENB4WePjBqXtyo2hm4SS2CQU7cYx/Ac4WKmZoDMTHSvpmK5Hpv2VnC8KjLsNL
         6IBlsWZySPZXA9HaHwjrz9EI0mLOgYFZjEQiKIFIfUH40agp/X83gPG6zkjtMv3Nslwr
         CRb/CmI+xuks7iKXShXOfXHcGbA8RqV4rl5gDJzLEINm9TQiEzyVsfYoaPbEgrXQZHro
         KeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRxGQVeQ8gc5qGppqiVvlRcLT/m93C3ZpTQfTwSLWFc=;
        b=wUW1UblgpeNxUDJpNXQe6US+Oe71acrf1MeboiBCHQlNPxrb+tjCZevDytP4Q0raZ8
         gmiIGC+HIMQwQ9r8iMw1OUHMh1kLM3tykW0qXxNEgalhjNGBwj1qc+UfGgHpZeGZM8em
         ggZG2Joq6lVph7Nj0tp+vGfUe3/CgRoXMuymvAhzF02JWhyswcgYfIyTF2go+CHSJmdt
         PQCy0OEmcSK1x+kgw3XB8K/xshcRNPrRuFhcbDdczNzR7URBaJXMyRBquTHq1EjXe+PB
         3qPhGdYwHq2ro9hzTw/MKkHsAY9yTp2Lz/5TobDY2y4tr9PXrqJ4Ub8qPtST5F34i12R
         K/lA==
X-Gm-Message-State: AOAM533aPhuf7nBqfhGVrmu+XrasczRK8Uqkvqd8Rqj02UNcCqngBBfE
        mSZyQYYOEpdHGLRjlNm7l8I=
X-Google-Smtp-Source: ABdhPJwhxNkzG3Np0hAYTRM2vq3NyO0svmziyZZ/YDGlWaog5dFaxUDpwZBZ91zdkXOzO5U+kx4vGw==
X-Received: by 2002:a4a:c506:0:b0:31c:ce0a:717e with SMTP id i6-20020a4ac506000000b0031cce0a717emr3446563ooq.72.1645819110878;
        Fri, 25 Feb 2022 11:58:30 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-bf76-707d-f6ed-c81c.res6.spectrum.com. [2603:8081:140c:1a00:bf76:707d:f6ed:c81c])
        by smtp.googlemail.com with ESMTPSA id e28-20020a0568301e5c00b005af640ec226sm1578424otj.56.2022.02.25.11.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:58:30 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 03/11] RDMA/rxe: Replace obj by elem in declaration
Date:   Fri, 25 Feb 2022 13:57:43 -0600
Message-Id: <20220225195750.37802-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225195750.37802-1-rpearsonhpe@gmail.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix a harmless typo replacing obj by elem in the cleanup fields.
This has no effect but is confusing.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
 drivers/infiniband/sw/rxe/rxe_pool.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 0a1233b2d4c5..2e2d01a73639 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -12,7 +12,7 @@ static const struct rxe_type_info {
 	const char *name;
 	size_t size;
 	size_t elem_offset;
-	void (*cleanup)(struct rxe_pool_elem *obj);
+	void (*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags flags;
 	u32 min_index;
 	u32 max_index;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 7fec5d96d695..a8582ad85b1e 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -39,7 +39,7 @@ struct rxe_pool {
 	struct rxe_dev		*rxe;
 	const char		*name;
 	rwlock_t		pool_lock; /* protects pool add/del/search */
-	void			(*cleanup)(struct rxe_pool_elem *obj);
+	void			(*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
 
-- 
2.32.0

