Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404C85A4E0E
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 15:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiH2N3B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 09:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiH2N2l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 09:28:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C6B8C01C
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 06:27:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z6so11142337lfu.9
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 06:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=PbiaZ3GzJ1x9DIcGcBg2AfhRQ909PEbMsIkkpIdPjt4=;
        b=x6aozTe+oKK48W3wkupPSGq0nQrtgAZZgMlKT+Rx16KBjUI1NReo3Y20ke8832jKI8
         TOk2A/KR4bAEcobK2GKPWdQo2h4Tm1WbOvxeXI+BukGVL5Cswl3HEUb/mceiWVzbJS2q
         KfL72XqVgypk4HIFVDNaVPnGe45PyULrkFdZ06LX063Cl3aDvlZTaGQGJ1DQyAPQVtid
         ffzC15/yJViCttZEyZYtI3nD96JIZfbHRqWqwAazkqkTIgY5gyPB6M6+UckHwJgoBmzj
         Hlw4i+1sLAupfo9jPxaB5cRQFu9rgpALHoOYXE/sC4RmHCDhf1G9zrTldBmz02qoUYJj
         fnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=PbiaZ3GzJ1x9DIcGcBg2AfhRQ909PEbMsIkkpIdPjt4=;
        b=hMTRR5ogppMqVBhBhabqqL4mmlTDtpPHlWsJG5y9LlSr8fafi+dHw4tWzdxmOV6oAV
         SiUBRKVztfana7E3Hy/8YHe5a1hW+9T/uL7KFuK6yg7OI0W0NgXtrMbsF9Ot3/i3dhmY
         eaaOUKrT4lJQhKkM5zfFowGGi/AJJG7QZdGkpHRJ5X+F710QSAU7vG/FlWrx+yMjDB5R
         HTSN7fbwsbA+zBgOb6tj4ET/JwtrrMFjLZP0aujogb5XbBHjHjxX2R9rVMBLWeEJjBxN
         FrL/trmIMiZNk+B2Diyp9Ed4OfPIZkp3qHnBxClK8h62x7ET0TZ/CTeo+YGwUY9Eka7Z
         UldA==
X-Gm-Message-State: ACgBeo2up84pBiM8EB9DRVQ/ka70wLDGYqD8IZg1LCl5tBTUPY3QVJ5y
        RImG2EpfacLYazpr30zpyL5I+OliVFBLhQ==
X-Google-Smtp-Source: AA6agR4Hn+Ff+IC4W/OkorkUu5St2YLeXlAJoM3FyEBkKYaCIGSc5/wf9Jx0ZbFcs2A0hgH15BitGA==
X-Received: by 2002:a05:6512:1285:b0:494:680f:390f with SMTP id u5-20020a056512128500b00494680f390fmr2239947lfs.601.1661779670195;
        Mon, 29 Aug 2022 06:27:50 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id be41-20020a056512252900b00492d108777dsm225497lfb.136.2022.08.29.06.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 06:27:49 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] RDMA/siw: Pass a pointer to virt_to_page()
Date:   Mon, 29 Aug 2022 15:25:47 +0200
Message-Id: <20220829132547.115499-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Functions that work on a pointer to virtual memory such as
virt_to_pfn() and users of that function such as
virt_to_page() are supposed to pass a pointer to virtual
memory, ideally a (void *) or other pointer. However since
many architectures implement virt_to_pfn() as a macro,
this function becomes polymorphic and accepts both a
(unsigned long) and a (void *).

If we instead implement a proper virt_to_pfn(void *addr)
function the following happens (occurred on arch/arm):

drivers/infiniband/sw/siw/siw_qp_tx.c:32:23: warning: incompatible
  integer to pointer conversion passing 'dma_addr_t' (aka 'unsigned int')
  to parameter of type 'const void *' [-Wint-conversion]
drivers/infiniband/sw/siw/siw_qp_tx.c:32:37: warning: passing argument
  1 of 'virt_to_pfn' makes pointer from integer without a cast
  [-Wint-conversion]
drivers/infiniband/sw/siw/siw_qp_tx.c:538:36: warning: incompatible
  integer to pointer conversion passing 'unsigned long long'
  to parameter of type 'const void *' [-Wint-conversion]

Fix this with an explicit cast. In one case where the SIW
SGE uses an unaligned u64 we need a double cast to get to
a (void *).

Cc: linux-rdma@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 1f4e60257700..5c7853ba8831 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -29,7 +29,7 @@ static struct page *siw_get_pblpage(struct siw_mem *mem, u64 addr, int *idx)
 	dma_addr_t paddr = siw_pbl_get_buffer(pbl, offset, NULL, idx);
 
 	if (paddr)
-		return virt_to_page(paddr);
+		return virt_to_page((void *)paddr);
 
 	return NULL;
 }
@@ -535,7 +535,17 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			} else {
 				u64 va = sge->laddr + sge_off;
 
-				page_array[seg] = virt_to_page(va & PAGE_MASK);
+				/*
+				 * virt_to_page() takes a (void *) pointer, and
+				 * the va being uint64 creates a special
+				 * problem here needing a double cast to
+				 * resolve the situation: first to (uintptr_t)
+				 * to preserve all the 64 bits and from there
+				 * to a (void *) meaning it will be 64 bits on
+				 * a 64 bit platform and 32 bits on a 32 bit
+				 * platform.
+				 */
+				page_array[seg] = virt_to_page((void *)(uintptr_t)(va & PAGE_MASK));
 				if (do_crc)
 					crypto_shash_update(
 						c_tx->mpa_crc_hd,
-- 
2.37.2

