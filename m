Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A17D5A2534
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 11:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245230AbiHZJ4a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 05:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343606AbiHZJ4V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 05:56:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DF16F576
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 02:56:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r4so1447295edi.8
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VmzhV/ezSnvm4gL0tOSe/SBf3LXvGBx6QmleyHvvzqM=;
        b=di/mKF4/Aqk4vP4wxwvjqBC/nfcx39SifNToqtv4Ycjf9n0P2NBXylUe/59EdggY1d
         Hy1IwmIZteQOrwe5wo/vKlB2/CVx11SwsM9NsU5OfU4/wHiCqWSyybSZiRvMGqHo4Iu9
         /Wxjce5jYDye3quXsQ9EcKSIGgbRaIYrNv2HMBlwDCM16bQj4yuY0yMiL+08lpvJN7WC
         bw25wIoa+LxB5hIATJv/8aksicbWQ8Z+X0TDxn55FIckQdLyy+qd/koMg68X8uxEJMnZ
         Jjk94Gk123JqEG5n4HQlBVWnXN8w+QyRV6zrauZamjZy9ObuskahWTnxdPQrFIF+9QTg
         sLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VmzhV/ezSnvm4gL0tOSe/SBf3LXvGBx6QmleyHvvzqM=;
        b=RaSDQ5e/iNPvSem6cPIlgoWVMXJVTE94a1myufs+CGbmP5vINTPzCm4pdjOHY/BIuJ
         8tag8oRL2nM7ktUnicdYkbv5uPL0Lluj/x5d+1ZmXMIo7DQcQHiOfiG+4BOVgzzUhan4
         qZCJr8Wx1KfMY/zX2OiDO6X9M11encNn6hMJQYoS7UBGJGH2MGUYQL8w/Q40hui1YUuY
         vi1eeSu8oxypquc8OMmKU+zErIXa4c/JerSNOWb9+HrDsIEmRrX8AqENTDq/ryrZNiFf
         /O0C5F0gY9NNJ3/w/SRBqInl5OCCCHfFwu9O7tTgp5D68uR9ZivwfZjpQ30M1bF3iX8E
         3C5Q==
X-Gm-Message-State: ACgBeo2Jk1IEXMBKdpoqt+993rnPgxD4t+n3wGX8HydxHMztt7sP1DGD
        93sPqUhqHodYD4kM/CTwWSDAdw==
X-Google-Smtp-Source: AA6agR4xZ/14nOsJNAugRCdiJqIASeZoRGxteR+jzRB3ElL4JkCO4jxYsE+Lj6arkreupBYHiTrENA==
X-Received: by 2002:a05:6402:19:b0:447:901f:6b28 with SMTP id d25-20020a056402001900b00447901f6b28mr6051188edu.392.1661507778188;
        Fri, 26 Aug 2022 02:56:18 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:140d:2300:3a17:fa67:2b0b:b905])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b007081282cbd8sm694826eju.76.2022.08.26.02.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:56:17 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] infiniband/mthca: Fix dma_map_sg error check
Date:   Fri, 26 Aug 2022 11:56:14 +0200
Message-Id: <20220826095615.74328-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220826095615.74328-1-jinpu.wang@ionos.com>
References: <20220826095615.74328-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

dma_map_sg return 0 on error, in case of error set
EIO as return code.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Håkon Bugge" <haakon.bugge@oracle.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: 56483ec1b702 ("[PATCH] IB uverbs: add mthca user doorbell record support")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/hw/mthca/mthca_memfree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniband/hw/mthca/mthca_memfree.c
index f2734a5c5f26..44fd5fdf64d5 100644
--- a/drivers/infiniband/hw/mthca/mthca_memfree.c
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
@@ -189,7 +189,7 @@ struct mthca_icm *mthca_alloc_icm(struct mthca_dev *dev, int npages,
 						   chunk->npages,
 						   DMA_BIDIRECTIONAL);
 
-				if (chunk->nsg <= 0)
+				if (!chunk->nsg)
 					goto fail;
 			}
 
@@ -208,7 +208,7 @@ struct mthca_icm *mthca_alloc_icm(struct mthca_dev *dev, int npages,
 		chunk->nsg = dma_map_sg(&dev->pdev->dev, chunk->mem,
 					chunk->npages, DMA_BIDIRECTIONAL);
 
-		if (chunk->nsg <= 0)
+		if (!chunk->nsg)
 			goto fail;
 	}
 
@@ -482,8 +482,9 @@ int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
 
 	ret = dma_map_sg(&dev->pdev->dev, &db_tab->page[i].mem, 1,
 			 DMA_TO_DEVICE);
-	if (ret < 0) {
+	if (!ret) {
 		unpin_user_page(pages[0]);
+		ret = -EIO;
 		goto out;
 	}
 
-- 
2.34.1

