Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF315ABA95
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Sep 2022 00:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiIBWDF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Sep 2022 18:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiIBWCq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Sep 2022 18:02:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB535726A
        for <linux-rdma@vger.kernel.org>; Fri,  2 Sep 2022 15:01:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq23so5108315lfb.7
        for <linux-rdma@vger.kernel.org>; Fri, 02 Sep 2022 15:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=kFFiI7byvu9/4wAo+ABXvOasfdkwHI7P+cJA6WG0TyU=;
        b=gHSa20jutWENA+tydUfxp09rV9o2ZUxQMpT/Jjmd23IvvS8LFX1sSDAJ44gqlLxk9R
         V/iWniI4PuIp9j6znioV/hetjED9XLQIovf9yvQcZJTRcK3fnmGAXE7c3eR2lMrmzYUm
         eYJJnkQum1Q4IH2o6QLdpllQGNUut2HigVeMolLPXs5/gYFrzuf9fyt2FkR0YssJKgkk
         021v8oLH0sOiNZxlc+2GOAWHJrxL1WJHqa8z9w5/P2/sn5nRM8C6UDoStmunTYt5YVHk
         7mLK1tNuuWBTzAp5m9cVGsnqwx/rYq7JkYgVR0O6WeK2BC3wXmqwLiBBZYuAG0U3e4WA
         lfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kFFiI7byvu9/4wAo+ABXvOasfdkwHI7P+cJA6WG0TyU=;
        b=ci5KnxccbDqGeC37+dCx/Izy0fkC1Ug/RxfJ+A4fnJgxwP5xWrpnlup6iWSznSI+zO
         2tXqYQm0wd1wIHMBvGYr5Q9QPMjCz/TK0WI6k0GibNQulL+RFklEWkoxWkcAKH2OeR/B
         B9ElveGA+raeNq+dilRD8A1IJOT/iIHB+WMrE4Sgo7fRZUkFi0NwCm+U/YYTm98ixFnM
         RKfsHT+9goU80V7lNDmsp8VKvh8doudYZLO9txDeX2Ja0bQcvLztSfA8vt3jwHtZ1gBP
         8sQxBqN77zNmwmNrDQxNL32DQF3n0aw5MoLkFX4ylhLBsNiXYuHdtnhLYKvTVGc2Q4w+
         jMRQ==
X-Gm-Message-State: ACgBeo1CbDqSCxY+kwqQifgengXcNw105ntorPlOYKnQiP8X5DDbWg7E
        Xebdy5Z7//McC3q5oA0LTbuOog==
X-Google-Smtp-Source: AA6agR6qHbmq1Cy6TPZlsJ6tjixQLJe+9SsO3tvAZwk2j/NeT8Nn9W3C32JQu16Aa1d89BJ9mBd9yg==
X-Received: by 2002:a05:6512:6c5:b0:494:6bab:6cca with SMTP id u5-20020a05651206c500b004946bab6ccamr8174616lff.197.1662156082016;
        Fri, 02 Sep 2022 15:01:22 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u9-20020a056512094900b0048b143c09c2sm361455lft.259.2022.09.02.15.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 15:01:21 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3] RDMA/siw: Pass a pointer to virt_to_page()
Date:   Fri,  2 Sep 2022 23:59:18 +0200
Message-Id: <20220902215918.603761-1-linus.walleij@linaro.org>
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

Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Add Fixes: tag.
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

