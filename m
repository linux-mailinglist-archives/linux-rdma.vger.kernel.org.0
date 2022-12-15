Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180F564DF50
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Dec 2022 18:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLORHZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Dec 2022 12:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiLORGr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Dec 2022 12:06:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C432A409;
        Thu, 15 Dec 2022 09:04:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 100DE61E69;
        Thu, 15 Dec 2022 17:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66B1C433F0;
        Thu, 15 Dec 2022 17:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671123832;
        bh=kuxI/BBKaNyRPYQTkGs7MRmFMKCTA++V1xZsjKYbOlM=;
        h=From:To:Cc:Subject:Date:From;
        b=mi5R9qkOU//MdebYEpuCCVyvCOQ+zCd4uJBosNzujiKGxb3CEX6FwMbchvgz4N7Fn
         qqEhFw6OXVItMb3TUe73L/YE/v/hgPKkJMLHI7mZsECZGRKT7XZ8XyLjhkhv77N2nh
         QErm5CH9KCRIIMVqyj926W/iU3reJBfF9ms7w08nROz6bKSt1Z/r4LqNP8EklbmCis
         mDRV5soOxjg2xQb8E0HtQ9gEcL9pu7OYOmzPliiMibz1NlC+lL1f2iehQEDjh18MT1
         UqVsBbtEtEAUT9sfGN1XEZ4HNrZFQ1/aGsvXVhN5rj8flWQ+QJynbpkvwYkoE4u4FR
         dHNdVncq07I+Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/siw: fix pointer cast warning
Date:   Thu, 15 Dec 2022 18:03:43 +0100
Message-Id: <20221215170347.2612403-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The previous build fix left a remaining issue in configurations
with 64-bit dma_addr_t on 32-bit architectures:

drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_get_pblpage':
drivers/infiniband/sw/siw/siw_qp_tx.c:32:37: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   32 |                 return virt_to_page((void *)paddr);
      |                                     ^

Use the same double cast here that the driver uses elsewhere
to convert between dma_addr_t and void*.

It took me a while to figure out why this driver does it
like this, as there is no hardware access and it just stores
kernel pointers in place of device addresses when communicating
with the rdma core and with user space.

Fixes: 0d1b756acf60 ("RDMA/siw: Pass a pointer to virt_to_page()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 7d47b521070b..05052b49107f 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -29,7 +29,7 @@ static struct page *siw_get_pblpage(struct siw_mem *mem, u64 addr, int *idx)
 	dma_addr_t paddr = siw_pbl_get_buffer(pbl, offset, NULL, idx);
 
 	if (paddr)
-		return virt_to_page((void *)paddr);
+		return virt_to_page((void *)(uintptr_t)paddr);
 
 	return NULL;
 }
-- 
2.35.1

