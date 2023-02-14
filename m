Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1827B69686D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 16:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjBNPsa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Feb 2023 10:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjBNPs1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Feb 2023 10:48:27 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12057E38C;
        Tue, 14 Feb 2023 07:47:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so11956375wms.1;
        Tue, 14 Feb 2023 07:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWHllFyKrR+xZQxHI6mDR0G17o8Ie4DvLljLVm9vbJ4=;
        b=OjBhCm7Ms7Kjj1WLp7I+kjsuqw7ZbG2qmA7L0ubPUOBQqvMSQ98MY0SXhwpy0cp3CV
         LkA1ncAZsO8eqNL7hfHaTB7RfTKasHZ4b264BwYrYcKvfYpcyS+eQuJ5J8KeYyDRjrGT
         xCjWRNA1PRWepGaKIIUD7Xo4fwh0k/7VFdb7EQgTwcsejqtA/huPjSY9rlg+eZJTxjIV
         U9mCww++VeMwuHiA9bL8fiYzAj8zKUiCIYzTE+RuPvYRD3HPKkC+oEqQfd6rETFVaWjM
         qZP+D0kUappl0Nhf3Gf+/kjbZnlE/UWPHcnarFpKFhO05cj0kkk/8eEOAffOtGh+OYQU
         yR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWHllFyKrR+xZQxHI6mDR0G17o8Ie4DvLljLVm9vbJ4=;
        b=JgUTUV+ynaYFhFHpoK0F6zpc0g6zEEDn7W9YTkNHiovCOZc6420qgWl4QWh4jOCMPA
         LJ4DlTlrcOVKmFGp7axN1bby+xortW3eU+z6VtOFmkrCo9ShCRV2dgJL55eRC38m64+H
         0SC0zmCww0seOT+wsVduh/2Z3/xwyBgDsm6dshL9AuwSvNlZYByOGiTVN8tviIShtfJE
         vyolavje7iiFoVUtqndV2AeAe3We0pNe4s5BwD+3/C5cMyljuWbV8ZE7N0bOvButwObS
         kMKnKlXbqV4l8cGSGh7d3X9C6bczufLA0I1WuAMBTb7rBFXWK9nG6Px0EGq4o3KhBZrS
         FXIQ==
X-Gm-Message-State: AO0yUKXe+cR8e9z4aIrfNL+NhP932BNLs49m2QQW3o757nNmgHz0zjQB
        wBWbf6sW4NNdOt/b2H7KAVsWIbabRbTvAQ==
X-Google-Smtp-Source: AK7set9R3FCNQIaiuE2OnUjkdq2NvcG9+wDyE1yEn/T+DAfAZmaun4y3AdvzakKbIZuZoZ6/WJcqxg==
X-Received: by 2002:a05:600c:2e96:b0:3da:50b0:e96a with SMTP id p22-20020a05600c2e9600b003da50b0e96amr2351231wmn.29.1676389663859;
        Tue, 14 Feb 2023 07:47:43 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003db01178b62sm20652159wmm.40.2023.02.14.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:47:43 -0800 (PST)
Date:   Tue, 14 Feb 2023 18:43:38 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Steve Wise <larrystevenwise@gmail.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iw_cxgb4: potential NULL dereference in
 c4iw_fill_res_cm_id_entry()
Message-ID: <Y+usKuWIKr4dimZh@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

