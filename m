Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12BE25B192
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 18:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgIBQZR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 12:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgIBQZR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 12:25:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CECC061244;
        Wed,  2 Sep 2020 09:25:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so9903wmm.2;
        Wed, 02 Sep 2020 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IM8g9T+1paRJIrOJC76fHo0IpLaUyt8i4HL4OIdzFuc=;
        b=B2+GQz00nIQZOtBPEZoLKRASyI8CwIfL6it7dkhK5H4BAaxeqjpmswv5wfu8j3X6te
         2Okl7N5w3cpyjLmEqD0GVdtWw3zczf0Bo1qz6FDl0BhIXsERo8Lu0vlZBmTaLIMm5UkF
         tpO//JFMYSPB+ZT/CaOBYhrSnT+Bch9WDYQDnTC49CfHqBW/jUrbJzkLbJcpWS6EGjR2
         b9VmW38Us0m/V+PGDFvqJxPt0QFwkBvzOuI1nt7LPRbDafgGkK8N7VtxhhYK6q8UAKUD
         +/ArC/pCnz6X00D3RAK8v2qw6DQZ2zuBpLx+j8Vk4o7uBILBlmqIP7f56qnj/Vho7zkT
         hqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IM8g9T+1paRJIrOJC76fHo0IpLaUyt8i4HL4OIdzFuc=;
        b=Z1GEJgn8kj+Sk7oZsEjIdFqHL6tHN6F4r8OeY8tpxIFJVOZeBcbXvLsYni05IxxMXl
         AP97P3VC4Uap/RMfnkZO5qOiW5RWpuoWnPtTZZ3oh0ukBVzimPPP333K8pysdBHz+qXr
         EgGFZnlcyzB3xsqiTW57SfugjLwAw+CPZG1+2wM8OcQ2E+YwQT5WIyvZFmVVNS3d+uz8
         LILPXGRUwBfF6BcLYu3bbGCJX4n4tbZlUYz210rPjQs+331kg6t0IVtg8fUe26BNxmdF
         hWDdpY9YjffIURznXbArUoKUzmJ/1FAcXx24naxiMeY8iGKxaRdMsX8nagvxWnpWoYAU
         vqeg==
X-Gm-Message-State: AOAM532Z4HhGL18sK1gRzl/PASuzS33TGVGyYCnzpnT3ShEsqp66VTA+
        ttc6hhfUM2oTHBD/e/qCNsE=
X-Google-Smtp-Source: ABdhPJzJiXUwTBLVaQlzQfXxywxTActdtTjuZnc5B7izvhRc3Q7JcYCaGG/bMYaa8N9VfBA/iJagUQ==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr1372933wmc.23.1599063913866;
        Wed, 02 Sep 2020 09:25:13 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id y6sm206120wrt.80.2020.09.02.09.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 09:25:13 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/ucma: Fix resource leak on error path
Date:   Wed,  2 Sep 2020 17:24:51 +0100
Message-Id: <20200902162454.332828-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In ucma_process_join(), if the call to xa_alloc() fails, the function
will return without freeing mc. Fix this by jumping to the correct line.

In the process I renamed the jump labels to something more memorable for
extra clarity.

Addresses-Coverity: ("Resource leak")
Fixes: 95fe51096b7a ("RDMA/ucma: Remove mc_list and rely on xarray")
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/infiniband/core/ucma.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index f2c9ef6ae481..a5595bd489b0 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1453,7 +1453,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	mc = kzalloc(sizeof(*mc), GFP_KERNEL);
 	if (!mc) {
 		ret = -ENOMEM;
-		goto err1;
+		goto err_put_ctx;
 	}
 
 	mc->ctx = ctx;
@@ -1464,7 +1464,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	if (xa_alloc(&multicast_table, &mc->id, NULL, xa_limit_32b,
 		     GFP_KERNEL)) {
 		ret = -ENOMEM;
-		goto err1;
+		goto err_free_mc;
 	}
 
 	mutex_lock(&ctx->mutex);
@@ -1472,13 +1472,13 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 				  join_state, mc);
 	mutex_unlock(&ctx->mutex);
 	if (ret)
-		goto err2;
+		goto err_xa_erase;
 
 	resp.id = mc->id;
 	if (copy_to_user(u64_to_user_ptr(cmd->response),
 			 &resp, sizeof(resp))) {
 		ret = -EFAULT;
-		goto err3;
+		goto err_leave_multicast;
 	}
 
 	xa_store(&multicast_table, mc->id, mc, 0);
@@ -1486,15 +1486,16 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	ucma_put_ctx(ctx);
 	return 0;
 
-err3:
+err_leave_multicast:
 	mutex_lock(&ctx->mutex);
 	rdma_leave_multicast(ctx->cm_id, (struct sockaddr *) &mc->addr);
 	mutex_unlock(&ctx->mutex);
 	ucma_cleanup_mc_events(mc);
-err2:
+err_xa_erase:
 	xa_erase(&multicast_table, mc->id);
+err_free_mc:
 	kfree(mc);
-err1:
+err_put_ctx:
 	ucma_put_ctx(ctx);
 	return ret;
 }
-- 
2.28.0

