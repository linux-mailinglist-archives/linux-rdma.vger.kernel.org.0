Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4F62FAD73
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389611AbhARWmT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389459AbhARWlr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:41:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91AAC0617B0
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j18so3909984wmi.3
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UwcXO9+B/oxv6A/KoybP9wlJ+/NSESLhvaDUTUtOpcw=;
        b=Lhk+MLoivrVrOdObXHOIo2zxEaLb2x+SY5pQy+7fzGCYyxQjcY1xNKO/nU2AX6nCA8
         FZtxBiMth26EXC5doFgC26fv16IE7hljYWa9O1C2VOU7Y5iT7CP1C1FfL7s2W7WbmnNY
         xPd/1ttaCzPGb4hrRoA9+sB977GMTjnzT8F01uxkefCZ/UtCVdGlhdjd7QqYXPS9Xuvx
         11z+mjEjhaTiZyq9oOFhlyB2G0/F9wQqQXeXVh7rkzCIX/5+HUqZW4m3kjzhj9MYFl+Q
         RGpUH2RjyajqpWxukZiyNqtnf6nb9C/mhM1r7YDc20Vtc9pXKUhiCbq6xoqgXM5A+B1Z
         EGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UwcXO9+B/oxv6A/KoybP9wlJ+/NSESLhvaDUTUtOpcw=;
        b=bS4KA7lKzM6NdS/nsq0sYSfoMIG5vG+xKR33o6Wn8vO0igndulKJ/xwBx2+oMwECjG
         xU6KNG/p/kkB49KXK/77mRLRcoZzWTRiTsu7GSeu1cjjjuKbua0wCLlr5oDzmLtHhCL6
         wKLnVfqtc1cJgFHdbL+RCfN20oH+Ku1luCku+LZNGWxgorY4sHTZ8qSAPCoq7wdDykU5
         CWnWuFtYc6EKR1TZ3nqeVEgTQXOtyPrUCoqXaPllc9UYfAxbPkgejC3aYS9OkHucR/+F
         s1kn7fQaQuCfhYl3tbw1z99XhPYmYHEsz6VHJDKXZ82H8Fgs1YHAbuou09IwEBBJBFui
         WXcQ==
X-Gm-Message-State: AOAM532WCgc44eM5cu03uE0uaOzGhBuHwOJd54xRaSsAur12QxYZjgQj
        O9d06nE6E+XZJmL/PYu3gHOtqQ==
X-Google-Smtp-Source: ABdhPJxSM2Ir1O9rDuc2mGvNJSYvReDkcuQme4qNM6ICohS8rYxqpVTwQlO9Px5aBDPmLN6Hjhoq0Q==
X-Received: by 2002:a1c:2d02:: with SMTP id t2mr1330841wmt.50.1611009590708;
        Mon, 18 Jan 2021 14:39:50 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH 16/20] RDMA/core/restrack: Fix kernel-doc formatting issue
Date:   Mon, 18 Jan 2021 22:39:25 +0000
Message-Id: <20210118223929.512175-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/core/restrack.c:209: warning: Function parameter or member 'res' not described in 'rdma_restrack_new'
 drivers/infiniband/core/restrack.c:209: warning: Function parameter or member 'type' not described in 'rdma_restrack_new'

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/core/restrack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index ff1551b3cf619..ffabaf3272429 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -201,8 +201,8 @@ EXPORT_SYMBOL(rdma_restrack_parent_name);
 /**
  * rdma_restrack_new() - Initializes new restrack entry to allow _put() interface
  * to release memory in fully automatic way.
- * @res - Entry to initialize
- * @type - REstrack type
+ * @res: Entry to initialize
+ * @type: REstrack type
  */
 void rdma_restrack_new(struct rdma_restrack_entry *res,
 		       enum rdma_restrack_type type)
-- 
2.25.1

