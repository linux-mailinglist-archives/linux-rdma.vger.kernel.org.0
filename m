Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC6C7F00B5
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Nov 2023 16:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjKRPyF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Nov 2023 10:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjKRPxD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Nov 2023 10:53:03 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348B71FC3;
        Sat, 18 Nov 2023 07:51:45 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7dd65052aso33807947b3.0;
        Sat, 18 Nov 2023 07:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322703; x=1700927503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phxxXofFhF+VjGYxpvuhMgjdcfI/PSJyd4/4jUAT2FE=;
        b=a5eesQm5O5JlmTp25FdxAsMuE7ZxUbyEvxra9wNcgqF4HasdgmMdaBOnyuKe8Lni68
         BNj7pLsw4KCBvmUmqH1wcclGY+yyp+l/VtGcBlXNwSjchXwTajKqO7GSzUU3sfNyrwi2
         JDdg1U579Ay14OlS/8DKkiy2vSTY6Hjekkivf6NPU6/NUvzlaFpG5ZgLUUT/rYmH1gIJ
         dTG2LFgNy3Gp3d77fRodIlGnfSTHji9GUlt5fN0rHSjV1rRQRUhiYSnIeAdNHXyKDSR0
         hpN8jcPeNdMJhikWMX/zeg/9YGO60YWSIMhLUVwMTSvm/ScIOMF4Uvg3GJYRen/7wT9n
         Idfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322703; x=1700927503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phxxXofFhF+VjGYxpvuhMgjdcfI/PSJyd4/4jUAT2FE=;
        b=xBmHlC75oOuWzumRnfFouqx8fPIrKuYJMhVSYBBmkjc9rSepUW/H8jCnmvswPyzjlM
         Y/cHDc+KOrLHAGUt7utk9Sp5mNO4o8jmdCZqFs/EzFDo5xNKDgayRYLxWJuEZWu7U7OC
         1NouYGyWN+3KcA+Ihv3FYvJYYumS1UMtxTM9FzH80zGJZ8UAUx/7jlfAq16NkbcU9bnX
         tmmttx4hn4oc3v1UWBadGahclL8qYWh0GHSwtskcHYG4veSOKeF2BZohEs/cT7hHsVFO
         9sxUkRqzsYWY9vySqU9IZ3/7c0DET9WpLttwYIw1hh0dgjrWuCcSwUz+RoW8axzLPfKN
         K9PQ==
X-Gm-Message-State: AOJu0Yx5NEoS4oSGaUyTvKkRM6W5fKgPnjedPR4JV6sVY1MIu+SpRhrj
        h6SJa09wHbPDb/d4VJLb4HWMUSAAT0/HJ4Kf
X-Google-Smtp-Source: AGHT+IG7xraS3i1lSLIwVNn87X3jl4n4U8OES6bJWUTWk+DaM7OZ2mTSeaQ2nJYkbf0r4npTVy6Xaw==
X-Received: by 2002:a81:920e:0:b0:5a7:b036:360c with SMTP id j14-20020a81920e000000b005a7b036360cmr2839457ywg.23.1700322703364;
        Sat, 18 Nov 2023 07:51:43 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id t195-20020a8183cc000000b00582b239674esm1172512ywf.129.2023.11.18.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:42 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 23/34] RDMA/rtrs: fix opencoded find_and_set_bit_lock() in __rtrs_get_permit()
Date:   Sat, 18 Nov 2023 07:50:54 -0800
Message-Id: <20231118155105.25678-24-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The function opencodes find_and_set_bit_lock() with a while-loop polling
on test_and_set_bit_lock(). Use a dedicated find_and_set_bit_lock()
instead.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 07261523c554..2f3b0ad42e8a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -72,18 +72,9 @@ __rtrs_get_permit(struct rtrs_clt_sess *clt, enum rtrs_clt_con_type con_type)
 	struct rtrs_permit *permit;
 	int bit;
 
-	/*
-	 * Adapted from null_blk get_tag(). Callers from different cpus may
-	 * grab the same bit, since find_first_zero_bit is not atomic.
-	 * But then the test_and_set_bit_lock will fail for all the
-	 * callers but one, so that they will loop again.
-	 * This way an explicit spinlock is not required.
-	 */
-	do {
-		bit = find_first_zero_bit(clt->permits_map, max_depth);
-		if (bit >= max_depth)
-			return NULL;
-	} while (test_and_set_bit_lock(bit, clt->permits_map));
+	bit = find_and_set_bit_lock(clt->permits_map, max_depth);
+	if (bit >= max_depth)
+		return NULL;
 
 	permit = get_permit(clt, bit);
 	WARN_ON(permit->mem_id != bit);
-- 
2.39.2

