Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03D5696876
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 16:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBNPtN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Feb 2023 10:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjBNPtM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Feb 2023 10:49:12 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2743C32;
        Tue, 14 Feb 2023 07:49:09 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so11995000wms.0;
        Tue, 14 Feb 2023 07:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWHllFyKrR+xZQxHI6mDR0G17o8Ie4DvLljLVm9vbJ4=;
        b=PpO4vFlYHyjHMtpC8Mz2jg+gdCtxxKGHSpk2/VEWkKYZgf7iTz8cDHO7jSFmTIIiSI
         ehwFTcEgcKtbAhPl5lmgvTh2Amt5OB1oLwqOjRl1EjOGRWAnUhcOpGJmZYGUjpyNLkDG
         hRL9bskiPpU9ntUuq4Y8f6ToQM6e72EVZlESrL8zzi9tIxmLLpCytH88l7XBy5AalbRE
         JqX+b1nJ2qn8qBOQ2HXm3/g4jFqqNcwXLw/7SK00OHxm/AordXwEsKOyvSbieqsHf0tC
         oq+DWhxKhFZ9Y668oETRSNWzfHYQ+QKNPhQSEMHL9kQ56Xeps3Lm13GyIGNc6WQct3SM
         vfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWHllFyKrR+xZQxHI6mDR0G17o8Ie4DvLljLVm9vbJ4=;
        b=koX2W8ZS+AqoDir6rckqUXhdi01hae5/PNB1rNqyF19/rM9NJYN2lf49QwuIdeq1su
         CkhOVPRkK5v7EhTrV5KjuzLOiDFbQbWaAg4sqd8x9hH822cpi1nLCZHy9I2B/nY0JfnX
         ADaqK/K/fVWC5Ujug/Amn6eVcpNnPYo9iPUvr+Z0FL85yXIliCZcImZhxuROzi2peQHy
         4yTtDLwqemh//ZflaMcKrWrZyxY966j0i+z7Rubf0ipq/1IqbXRQoEgnQVQnThfWT7mv
         xtKBiLbQQ/vNpXi3Y2RUoIq50BTF6c7KMhwDAhlQadrkv2k1Ahckc2dHD61FtTAKHcjj
         yNjg==
X-Gm-Message-State: AO0yUKWypT/OGw1k6smhRamfD4GRQTYwZwm6CU62BIIKzY93CE2D1G2h
        CBHFrY9HxwXSHfTDYcirj7w=
X-Google-Smtp-Source: AK7set9rjRZPUVh5jSiIATnm7Rmz7aKfhtMGcbYUrP0JOrfy4NjkD5Dt/3jnGeGvjwG6ZtxSehC+xg==
X-Received: by 2002:a05:600c:91d:b0:3df:d817:df98 with SMTP id m29-20020a05600c091d00b003dfd817df98mr2502200wmp.10.1676389747871;
        Tue, 14 Feb 2023 07:49:07 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id he7-20020a05600c540700b003e1f6e18c95sm2024328wmb.21.2023.02.14.07.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:49:07 -0800 (PST)
Date:   Tue, 14 Feb 2023 18:49:03 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Steve Wise <larrystevenwise@gmail.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iw_cxgb4: potential NULL dereference in
 c4iw_fill_res_cm_id_entry()
Message-ID: <Y+utb9JSKpgAeiWC@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This condition needs to match the previous "if (epcp->state == LISTEN) {"
exactly to avoid a NULL dereference of either "listen_ep" or "ep". The
problem is that "epcp" has been re-assigned so just testing
"if (epcp->state == LISTEN) {" a second time is not sufficient.

Fixes: 116aeb887371 ("iw_cxgb4: provide detailed provider-specific CM_ID information")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
From static analysis, not from testing.  It's possible that the current
code works but this change makes it more Obviously Correct[tm].

 drivers/infiniband/hw/cxgb4/restrack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/restrack.c b/drivers/infiniband/hw/cxgb4/restrack.c
index ff645b955a08..fd22c85d35f4 100644
--- a/drivers/infiniband/hw/cxgb4/restrack.c
+++ b/drivers/infiniband/hw/cxgb4/restrack.c
@@ -238,7 +238,7 @@ int c4iw_fill_res_cm_id_entry(struct sk_buff *msg,
 	if (rdma_nl_put_driver_u64_hex(msg, "history", epcp->history))
 		goto err_cancel_table;
 
-	if (epcp->state == LISTEN) {
+	if (listen_ep) {
 		if (rdma_nl_put_driver_u32(msg, "stid", listen_ep->stid))
 			goto err_cancel_table;
 		if (rdma_nl_put_driver_u32(msg, "backlog", listen_ep->backlog))
-- 
2.35.1

