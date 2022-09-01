Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16795A95B5
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 13:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiIAL3h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 07:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiIAL3g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 07:29:36 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3868C139F44;
        Thu,  1 Sep 2022 04:29:30 -0700 (PDT)
X-UUID: d2b2dd2aa5e14c18a6997ff43d0964de-20220901
X-CPASD-INFO: d7ac05970d2d4a6a8d24d0437a085f10@rYebg11nZ2dchHSwg6SBm1iVYmSUXFS
        CeZtQaGOWXVCVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3s3mbg2BjaQ==
X-CLOUD-ID: d7ac05970d2d4a6a8d24d0437a085f10
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:141.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:242.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4992.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:3,DUF:3820,ACD:67,DCD:67,SL:0,EISP:0,AG:0,CFC:0.824,CFSR:0.034,UAT:0,RA
        F:2,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:1,E
        AF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: d2b2dd2aa5e14c18a6997ff43d0964de-20220901
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: d2b2dd2aa5e14c18a6997ff43d0964de-20220901
X-User: jianghaoran@kylinos.cn
Received: from [172.30.60.211] [(210.12.40.82)] by mailgw
        (envelope-from <jianghaoran@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 978108655; Thu, 01 Sep 2022 19:29:48 +0800
Subject: Re: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT mips
 kernel when enable CONFIG_RDMA_SIW
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SA0PR15MB3919F42FFE3C2FBF09D08026997B9@SA0PR15MB3919.namprd15.prod.outlook.com>
From:   jianghaoran <jianghaoran@kylinos.cn>
Message-ID: <3e5b573b-91c1-d9d8-cf1a-8da02ad6b568@kylinos.cn>
Date:   Thu, 1 Sep 2022 19:26:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <SA0PR15MB3919F42FFE3C2FBF09D08026997B9@SA0PR15MB3919.namprd15.prod.outlook.com>
Content-Type: multipart/mixed;
 boundary="------------EC65EF279E17B4400AB6BC39"
Content-Language: en-US
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RDNS_DYNAMIC,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a multi-part message in MIME format.
--------------EC65EF279E17B4400AB6BC39
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2022/9/1 下午3:05, Bernard Metzler 写道:
> 
> 
>> -----Original Message-----
>> From: jianghaoran <jianghaoran@kylinos.cn>
>> Sent: Thursday, 1 September 2022 07:52
>> To: Bernard Metzler <BMT@zurich.ibm.com>
>> Cc: jgg@ziepe.ca; leon@kernel.org; linux-rdma@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH] RDMA/siw: Solve the error of compiling the
>> 32BIT mips kernel when enable CONFIG_RDMA_SIW
>>
>> cross-compilation environment：
>> ubuntu 20.04
>> mips-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
>>
>> generate a configuration file by make randconfig:
>> CONFIG_32BIT=y
>> CONFIG_RDMA_SIW=y
>>
>> the error message as follows：
>> In file included from ../arch/mips/include/asm/page.h:270,
>>                   from ../arch/mips/include/asm/io.h:29,
>>                   from ../arch/mips/include/asm/mmiowb.h:5,
>>                   from ../include/linux/spinlock.h:64,
>>                   from ../include/linux/wait.h:9,
>>                   from ../include/linux/net.h:19,
>>                   from ../drivers/infiniband/sw/siw/siw_qp_tx.c:8:
>> ../drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_tx_hdt’:
>> ../arch/mips/include/asm/page.h:255:53: error: cast to pointer from integer
>> of different size [-Werror=int-to-pointer-cast]
>>    255 | #define virt_to_pfn(kaddr)    PFN_DOWN(virt_to_phys((void
>> *)(kaddr)))
>>        |                                                     ^
>> ../include/asm-generic/memory_model.h:18:41: note: in definition of macro
>> ‘__pfn_to_page’
>>     18 | #define __pfn_to_page(pfn) (mem_map + ((pfn) - ARCH_PFN_OFFSET))
>>        |                                         ^~~
>> ../arch/mips/include/asm/page.h:255:31: note: in expansion of macro
>> ‘PFN_DOWN’
>>    255 | #define virt_to_pfn(kaddr)    PFN_DOWN(virt_to_phys((void
>> *)(kaddr)))
>>        |                               ^~~~~~~~
>> ../arch/mips/include/asm/page.h:256:41: note: in expansion of macro
>> ‘virt_to_pfn’
>>    256 | #define virt_to_page(kaddr) pfn_to_page(virt_to_pfn(kaddr))
>>        |                                         ^~~~~~~~~~~
>> ../drivers/infiniband/sw/siw/siw_qp_tx.c:538:23: note: in expansion of
>> macro ‘virt_to_page’
>>    538 |     page_array[seg] = virt_to_page(va & PAGE_MASK);
>>        |                       ^~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make[5]: *** [../scripts/Makefile.build:249:
>> drivers/infiniband/sw/siw/siw_qp_tx.o] Error 1
>> make[4]: *** [../scripts/Makefile.build:465: drivers/infiniband/sw/siw]
>> Error 2
>> make[3]: *** [../scripts/Makefile.build:465: drivers/infiniband/sw] Error 2
>> make[3]: *** Waiting for unfinished jobs....
>>
>> Reported-by: k2ci <kernel-bot@kylinos.cn>
>> Signed-off-by: jianghaoran <jianghaoran@kylinos.cn>
>> ---
>>   drivers/infiniband/sw/siw/siw_qp_tx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
>> b/drivers/infiniband/sw/siw/siw_qp_tx.c
>> index 1f4e60257700..55ed0c27f449 100644
>> --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
>> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
>> @@ -533,7 +533,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct
>> socket *s)
>>   					kunmap_local(kaddr);
>>   				}
>>   			} else {
>> -				u64 va = sge->laddr + sge_off;
>> +				unsigned long va = sge->laddr + sge_off;
>>
> 
> We discussed same thing a few days ago - see PATCH from Linus:
> '[PATCH] RDMA/siw: Pass a pointer to virt_to_page()'
> 
> While he suggested casting, I think it would be better to change
> 'u64' to 'uintptr_t'. I'd prefer 'uintptr_t' over 'unsigned long'
> for readability -- since we hold a pointer.
> It would also simplify a cast of va a few lines down in
> virt_to_page().
> 
> Could one of you two re-send?
> 
> Thanks Jianghaoran!
> 
> Bernard.
> 
>>   				page_array[seg] = virt_to_page(va & PAGE_MASK);
>>   				if (do_crc)
>> --
>> 2.25.1
> 
Modified with suggestions from Linus Walleij <linus.walleij@linaro.org> 
and Bernard Metzler <BMT@zurich.ibm.com>

Detailed discussion as follows:
[PATCH] RDMA/siw: Pass a pointer to virt_to_page()

Thanks！

--------------EC65EF279E17B4400AB6BC39
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-RDMA-siw-Solve-the-error-of-compiling-the-32BIT-mips.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-RDMA-siw-Solve-the-error-of-compiling-the-32BIT-mips.pa";
 filename*1="tch"

From 659823f2aad1635be4fb1f70cbddb8ae91a3d4aa Mon Sep 17 00:00:00 2001
From: jianghaoran <jianghaoran@kylinos.cn>
Date: Thu, 1 Sep 2022 13:09:34 +0800
Subject: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT mips kernel
 when enable CONFIG_RDMA_SIW
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
 drivers/infiniband/sw/siw/siw_qp_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 1f4e60257700..4bd7ccae614e 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -29,7 +29,7 @@ static struct page *siw_get_pblpage(struct siw_mem *mem, u64 addr, int *idx)
 	dma_addr_t paddr = siw_pbl_get_buffer(pbl, offset, NULL, idx);
 
 	if (paddr)
-		return virt_to_page(paddr);
+		return virt_to_page((void*)paddr);
 
 	return NULL;
 }
@@ -533,7 +533,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 					kunmap_local(kaddr);
 				}
 			} else {
-				u64 va = sge->laddr + sge_off;
+				uintptr_t va = sge->laddr + sge_off;
 
 				page_array[seg] = virt_to_page(va & PAGE_MASK);
 				if (do_crc)
-- 
2.25.1


--------------EC65EF279E17B4400AB6BC39--
