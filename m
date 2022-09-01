Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E355A8DB5
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 07:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiIAFzF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 01:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiIAFzC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 01:55:02 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A99CEF;
        Wed, 31 Aug 2022 22:54:52 -0700 (PDT)
X-UUID: 1c4bb7b35c3f4b39934073075f8d7343-20220901
X-CPASD-INFO: e866358f380b453c9e91ee249368a376@rohwVmBnZpZfWHKug3h-nVmWaWGVkVK
        De21WaY9jY1aVhH5xTV5uYFV9fWtVXmJdY2RgVHh0bFJgZmJeZXabg3JqUIdiYXlRqH6FeG1VaZRj
X-CLOUD-ID: e866358f380b453c9e91ee249368a376
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:1.0,URL:-5,TVAL:173.
        0,ESV:0.0,ECOM:-5.0,ML:-10.0,FD:0.0,CUTS:283.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:
        -5.0,SPF:4.0,EDMS:-5,IPLABEL:4992.0,FROMTO:0,AD:0,FFOB:1.0,CFOB:1.0,SPC:0,SIG
        :-5,AUF:2,DUF:3755,ACD:67,DCD:67,SL:0,EISP:0,AG:0,CFC:0.229,CFSR:0.159,UAT:0,
        RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0
        ,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 1c4bb7b35c3f4b39934073075f8d7343-20220901
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 1c4bb7b35c3f4b39934073075f8d7343-20220901
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(210.12.40.82)] by mailgw
        (envelope-from <jianghaoran@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 594133427; Thu, 01 Sep 2022 13:55:08 +0800
From:   jianghaoran <jianghaoran@kylinos.cn>
To:     bmt@zurich.ibm.com
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT mips kernel when enable CONFIG_RDMA_SIW
Date:   Thu,  1 Sep 2022 13:51:38 +0800
Message-Id: <20220901055138.1704755-1-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

cross-compilation environment：
ubuntu 20.04
mips-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0

generate a configuration file by make randconfig:
CONFIG_32BIT=y
CONFIG_RDMA_SIW=y

the error message as follows：
In file included from ../arch/mips/include/asm/page.h:270,
                 from ../arch/mips/include/asm/io.h:29,
                 from ../arch/mips/include/asm/mmiowb.h:5,
                 from ../include/linux/spinlock.h:64,
                 from ../include/linux/wait.h:9,
                 from ../include/linux/net.h:19,
                 from ../drivers/infiniband/sw/siw/siw_qp_tx.c:8:
../drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_tx_hdt’:
../arch/mips/include/asm/page.h:255:53: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  255 | #define virt_to_pfn(kaddr)    PFN_DOWN(virt_to_phys((void *)(kaddr)))
      |                                                     ^
../include/asm-generic/memory_model.h:18:41: note: in definition of macro ‘__pfn_to_page’
   18 | #define __pfn_to_page(pfn) (mem_map + ((pfn) - ARCH_PFN_OFFSET))
      |                                         ^~~
../arch/mips/include/asm/page.h:255:31: note: in expansion of macro ‘PFN_DOWN’
  255 | #define virt_to_pfn(kaddr)    PFN_DOWN(virt_to_phys((void *)(kaddr)))
      |                               ^~~~~~~~
../arch/mips/include/asm/page.h:256:41: note: in expansion of macro ‘virt_to_pfn’
  256 | #define virt_to_page(kaddr) pfn_to_page(virt_to_pfn(kaddr))
      |                                         ^~~~~~~~~~~
../drivers/infiniband/sw/siw/siw_qp_tx.c:538:23: note: in expansion of macro ‘virt_to_page’
  538 |     page_array[seg] = virt_to_page(va & PAGE_MASK);
      |                       ^~~~~~~~~~~~
cc1: all warnings being treated as errors
make[5]: *** [../scripts/Makefile.build:249: drivers/infiniband/sw/siw/siw_qp_tx.o] Error 1
make[4]: *** [../scripts/Makefile.build:465: drivers/infiniband/sw/siw] Error 2
make[3]: *** [../scripts/Makefile.build:465: drivers/infiniband/sw] Error 2
make[3]: *** Waiting for unfinished jobs....

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: jianghaoran <jianghaoran@kylinos.cn>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 1f4e60257700..55ed0c27f449 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -533,7 +533,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 					kunmap_local(kaddr);
 				}
 			} else {
-				u64 va = sge->laddr + sge_off;
+				unsigned long va = sge->laddr + sge_off;
 
 				page_array[seg] = virt_to_page(va & PAGE_MASK);
 				if (do_crc)
-- 
2.25.1

