Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C217F6CDCBF
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjC2Og6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 10:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjC2Ogp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 10:36:45 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B8359F5
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 07:32:43 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id y14so15971192wrq.4
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680100251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JNU6UNqUS+WuAbKetud+rmauI0T5YLmIIiBYJJBr/Mk=;
        b=IRZhtwgLYqyDJddtWVlWAB0Tl/aldF834NoRRgRViPLwXVY/IXF/wJMdn7qcaQCjsY
         /dqH2w1TGl1y8TnyVjr5EVxV5FXO783D0EaUoVUSr3WuHGnTIXoVLJlZtSWthV5JT7Gp
         AwTjXwvBW0AcbQnghuA83IQ7m+5Rspgm+vYpUHT3v6gAS/1ZAuqab/n9Mv+9RwBDCOGQ
         Ym3NIpey7JUxl5h03zoiPBqppQXKO2J2FHM5szw8FD7R9iM94lkOYfJuIEJIcdqZEEDW
         63o7qXxMb3F2zarZkcV6JsLDVUsAp1U4x1+U8aTJrSZsjdah9Xs1iKhvfg2+9e6ucg5M
         rniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNU6UNqUS+WuAbKetud+rmauI0T5YLmIIiBYJJBr/Mk=;
        b=CK1YnXbG0naT/wpXpq3dC44RxL05Yu4R+J1xfWuiHiyEGTlg9/tPNAV6p2Qg3M+nOs
         Xe0yVingl2omkpVwxCFn63bicWmjMt+5tHUk8LXw84Rogcmmw544630oFZ/3jkMtxWAV
         ryD5DiQkMTIhLhe4WDJh/5nDKk298qoSjY6IG2+xCrcaD/bCTDNqiqqKtyBhKUojq2FN
         Up/m05kqaxnmxR+0x/Aa9XyLyN1H71+7e1EI0lYlImEeJi/5cHU+fhX2DARyih7eUJHg
         +k3S141BcD/m6JvHtpqof7GnquBPuZrrOMY+HLwmtqTwuoZmFNohk084HY0oJ8Fam3pQ
         Tg7Q==
X-Gm-Message-State: AAQBX9f3Gt8pdu9mcAJ9m68+NWIPL+Zw0l4syJhmac+ouuQzZxcomR47
        JpUhmvatdF5foI43mLZgVwMW12Zgk0NMvq6OCEs=
X-Google-Smtp-Source: AKy350YWu8m4GsCwRMcyTMm+yIk6z6s/V+zc2QDgJNprixotZZvBqPMtgdszGSJuj6jG056fFFm5Bg==
X-Received: by 2002:a2e:b018:0:b0:29c:9209:9ebe with SMTP id y24-20020a2eb018000000b0029c92099ebemr6689214ljk.39.1680099826515;
        Wed, 29 Mar 2023 07:23:46 -0700 (PDT)
Received: from fedora.. ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id u10-20020a2e854a000000b00295b597c8fasm5505492ljj.22.2023.03.29.07.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:23:46 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 1/2] RDMA/rxe: Treat physical addresses right
Date:   Wed, 29 Mar 2023 16:23:40 +0200
Message-Id: <20230329142341.863175-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Whenever the IB_MR_TYPE_DMA flag is set in imbr.type, the "iova"
(I/O virtual address) is not really a virtual address but a physical
address.

This means that the use of virt_to_page() on these addresses is also
incorrect, this needs to be treated and converted to a page using
the page frame number and pfn_to_page().

Fix up all users in this file.

Fixes: 592627ccbdff ("RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray")
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/linux-rdma/ZB2s3GeaN%2FFBpR5K@nvidia.com/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New patch prepended to patch set.
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b10aa1580a64..8e8250652f9d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -279,16 +279,20 @@ static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
 	return 0;
 }
 
-static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 iova, void *addr,
+/*
+ * This function is always called with a physical address as parameter,
+ * since DMA only operates on physical addresses.
+ */
+static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 phys, void *addr,
 			    unsigned int length, enum rxe_mr_copy_dir dir)
 {
-	unsigned int page_offset = iova & (PAGE_SIZE - 1);
+	unsigned int page_offset = phys & (PAGE_SIZE - 1);
 	unsigned int bytes;
 	struct page *page;
 	u8 *va;
 
 	while (length) {
-		page = virt_to_page(iova & mr->page_mask);
+		page = pfn_to_page(phys >> PAGE_SHIFT);
 		bytes = min_t(unsigned int, length,
 				PAGE_SIZE - page_offset);
 		va = kmap_local_page(page);
@@ -300,7 +304,7 @@ static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 iova, void *addr,
 
 		kunmap_local(va);
 		page_offset = 0;
-		iova += bytes;
+		phys += bytes;
 		addr += bytes;
 		length -= bytes;
 	}
@@ -487,8 +491,11 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 	}
 
 	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
-		page_offset = iova & (PAGE_SIZE - 1);
-		page = virt_to_page(iova & PAGE_MASK);
+		/* In this case iova is a physical address */
+		u64 phys = iova;
+
+		page_offset = phys & (PAGE_SIZE - 1);
+		page = pfn_to_page(phys >> PAGE_SHIFT);
 	} else {
 		unsigned long index;
 		int err;
@@ -544,8 +551,11 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 	}
 
 	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
-		page_offset = iova & (PAGE_SIZE - 1);
-		page = virt_to_page(iova & PAGE_MASK);
+		/* In this case iova is a physical address */
+		u64 phys = iova;
+
+		page_offset = phys & (PAGE_SIZE - 1);
+		page = pfn_to_page(phys >> PAGE_SHIFT);
 	} else {
 		unsigned long index;
 		int err;
-- 
2.34.1

