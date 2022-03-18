Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7644DD233
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 02:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiCRBCW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 21:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiCRBCW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 21:02:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C263F2571B3;
        Thu, 17 Mar 2022 18:01:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d19so8223283pfv.7;
        Thu, 17 Mar 2022 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9Ckwp6SWG8X1rgMLe2CDRJ7nGHgb7ejg7sOeZ28qRk=;
        b=qli9xJO49EbG3zydPu4w8OaWLfv7xd9TZMOnBNfhBQt2hLpLw0jTREiunhqK8TMed0
         yn7Y7K04NLuBLwVhfrJkDclsIdGEk9SZhvO6WUvoGjygG8337vRZj2425SVXiy1O4TnS
         qlGPXsoQ0oMdSRHVx+/HdDWToJTFvr5k6RBH/bxlKMbCHi6Tf53kWIpOuSa37neiZ+OK
         pPGHwVWBfTC1U/YAELbBXo89HXL6MN57kUOQMjsul+YIDHA3sSIcN7Q2i/1rgCn3DAzL
         ZQK4/w4pnhVBNx3TtOCIyIZq2NAHkis0ndLsqSC6jxNBBoeupM14jAxvY4flwNgiJPaI
         kXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9Ckwp6SWG8X1rgMLe2CDRJ7nGHgb7ejg7sOeZ28qRk=;
        b=TAZVqU4Yl3WroqA+PmX310tNWRLy2Xo8NV+FgV9rEGsZrHtQBpcT+PZ4MNVQSyZbZ6
         pHByNtDQaeFdJW0pQUFdh8dIP8kddvgNPUaejiiQ+CHsBpndHhTOcMEX5gJcb190OQh1
         MfgTNnx9iqCvuOHNmgS7JnSw+bfi1sIXPMpp+vqwFsxeEt2l9uL6O/4pwb3NcAxvxHkY
         scNQ3O/5y0jN2r4C81ybfuHaf+lzLzAPHH2S5ZTacWlFXMPGvnEQIB8v71UYTg5rFhpv
         H1buxnKwy9pZZIYX5sz0Sgwq1V9RBr01eRmzAUMFhofkDPSfV4d4cpi2sU1k56XuCpXr
         2v5g==
X-Gm-Message-State: AOAM533GDjXoX07MycHy1ofBFzOnij/BsswG9nz0McjRpWPDwcf//MqG
        /8Q0pSqZ0u7GVQYfLxAu40Of0sy/rE8=
X-Google-Smtp-Source: ABdhPJwBZbY5fk52e4PYIi9qK3VIktPWHY3LLDZfXQFZwHEgisyWzXOwUteKJmd5BQ3PHI82IId9Cg==
X-Received: by 2002:a65:550a:0:b0:374:5324:c32d with SMTP id f10-20020a65550a000000b003745324c32dmr5813739pgr.61.1647565264330;
        Thu, 17 Mar 2022 18:01:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o17-20020a639a11000000b0038160e4a2f7sm6635537pge.48.2022.03.17.18.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:01:02 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mike.marciniszyn@cornelisnetworks.com
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] IB/hfi1: Remove useless DMA-32 fallback configuration
Date:   Fri, 18 Mar 2022 01:00:58 +0000
Message-Id: <20220318010058.2142152-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.

[1]: https://lkml.org/lkml/2021/6/7/398

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/infiniband/hw/hfi1/pcie.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index a0802332c8cb..b8394cd358a9 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -57,11 +57,8 @@ int hfi1_pcie_init(struct hfi1_devdata *dd)
 		 * do not setup 64 bit maps on systems with 2GB or less
 		 * memory installed.
 		 */
-		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (ret) {
 		dd_dev_err(dd, "Unable to set DMA mask: %d\n", ret);
 		goto bail;
-		}
 	}
 
 	pci_set_master(pdev);
-- 
2.25.1

