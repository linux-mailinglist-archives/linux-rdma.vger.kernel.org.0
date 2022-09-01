Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883685A98F6
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 15:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiIANfF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 09:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiIANej (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 09:34:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080726384
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 06:33:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq23so24445847lfb.7
        for <linux-rdma@vger.kernel.org>; Thu, 01 Sep 2022 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=f2Jmuk4oY7t2eRNpfid+gBR7Z6DqA6RaeOA5wDMFfwU=;
        b=k/d/f8plo1+unMSMBU91O0FGvbnVf76fdh1KiCNZKC+ZXX47iZmQqGUMeIq0scZArD
         9DXvFZDmSWUb8uhroueJjn4cl+MIi8yHKQhLlBcE09kK0PfOfhlyd/22YlQ6H+4n7RwL
         0/SqHvvEdzy7a1rZBbb8O4c7TMv61EoUo89RZoKO0adgkCx2rhZaZtpSmyae18on85+P
         bhaW1eNnz79dQeGI0GnqcU2VYiePcH2gU/s5DAuexQlhdpdKbhMchefKZ3cvWqFz9ES1
         8Lu3TSw5RVbrtBfAw74G4HgqRW/3wGHsLTjfGClAgmE8C6pqbX9y+s5XDtfUTxa3QYGT
         dwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=f2Jmuk4oY7t2eRNpfid+gBR7Z6DqA6RaeOA5wDMFfwU=;
        b=IeHVxI6B9WQE56MB5oYs/PDQcam1kJN0n1wDbEY8dO1YxTtBkId6ihWgxAz67F2gOt
         hlRARoY4X/dnt4yt0k4RiQ0B2Mq6zzPnOa2jJUevYzN9N22Xyl7IY0Zgr2HaRRO0GDL5
         Oiq5CDF7YvGE9YGaXgo2VvO/nlOLslSEAInw7xfwgH7Js6EbFbK6UaFaRpbIpf3R35QJ
         gZEptH7UJ8cWRe4dF9R5CfUgLwzR5NrxYeE5R8M21wWN9cORm8tQG2287F6UBtlXtVvC
         HbHDMrnmhNc9fQv5ON90UjAZI6pQNbxIdijFV2Nz2fjrJCEozIlmdIAqTsAgRNAu331/
         QBFQ==
X-Gm-Message-State: ACgBeo1p2kaLyiiGtUsNT8vLkXhbMUJvrNAx7lXauoHC71L89i7RNbz6
        ezg9FNut1IGhLADLymIMqPnK6g==
X-Google-Smtp-Source: AA6agR40zDUYhlrnrMf9++avXirszUTWOudpv5+X9/uK/hULBixn+/NzPE3HxtotCqQCbMMykRr66Q==
X-Received: by 2002:a05:6512:3e0b:b0:494:735c:c7ec with SMTP id i11-20020a0565123e0b00b00494735cc7ecmr5394927lfv.373.1662039180922;
        Thu, 01 Sep 2022 06:33:00 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id s20-20020a056512203400b00492e95f9782sm1010445lfs.86.2022.09.01.06.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:33:00 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] RDMA/siw: Pass a pointer to virt_to_page()
Date:   Thu,  1 Sep 2022 15:30:56 +0200
Message-Id: <20220901133056.570396-1-linus.walleij@linaro.org>
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
SGE uses an unaligned u64 we need a double cast modifying the
virtual address (va) to a platform-specific uintptr_t before
casting to a (void *).

Cc: linux-rdma@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Change the local va variable to be uintptr_t, avoiding
  double casts in two spots.
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 1f4e60257700..7d47b521070b 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -29,7 +29,7 @@ static struct page *siw_get_pblpage(struct siw_mem *mem, u64 addr, int *idx)
 	dma_addr_t paddr = siw_pbl_get_buffer(pbl, offset, NULL, idx);
 
 	if (paddr)
-		return virt_to_page(paddr);
+		return virt_to_page((void *)paddr);
 
 	return NULL;
 }
@@ -533,13 +533,23 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 					kunmap_local(kaddr);
 				}
 			} else {
-				u64 va = sge->laddr + sge_off;
+				/*
+				 * Cast to an uintptr_t to preserve all 64 bits
+				 * in sge->laddr.
+				 */
+				uintptr_t va = (uintptr_t)(sge->laddr + sge_off);
 
-				page_array[seg] = virt_to_page(va & PAGE_MASK);
+				/*
+				 * virt_to_page() takes a (void *) pointer
+				 * so cast to a (void *) meaning it will be 64
+				 * bits on a 64 bit platform and 32 bits on a
+				 * 32 bit platform.
+				 */
+				page_array[seg] = virt_to_page((void *)(va & PAGE_MASK));
 				if (do_crc)
 					crypto_shash_update(
 						c_tx->mpa_crc_hd,
-						(void *)(uintptr_t)va,
+						(void *)va,
 						plen);
 			}
 
-- 
2.37.2

