Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF67B528182
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 12:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbiEPKI7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 May 2022 06:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242394AbiEPKIG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 May 2022 06:08:06 -0400
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21430DE9E
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 03:07:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VDIS35K_1652695661;
Received: from 30.43.106.100(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VDIS35K_1652695661)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 May 2022 18:07:42 +0800
Message-ID: <e53fc221-adea-ad2d-2525-508b28f3ee54@linux.alibaba.com>
Date:   Mon, 16 May 2022 18:07:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH for-next v7 12/12] RDMA/erdma: Add driver to kernel build
 environment
Content-Language: en-US
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-13-chengyou@linux.alibaba.com>
 <20220510131841.GB1093822@nvidia.com>
 <cb86ec72-5878-6bba-1f4f-e0c2f25e45c9@linux.alibaba.com>
 <b8379e45-509e-0f4f-8295-a6719f5706d4@linux.alibaba.com>
In-Reply-To: <b8379e45-509e-0f4f-8295-a6719f5706d4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/16/22 3:11 PM, Cheng Xu wrote:
> 
> 
> On 5/16/22 11:40 AM, Cheng Xu wrote:
>>
>>
>> On 5/10/22 9:18 PM, Jason Gunthorpe wrote:
>>> On Thu, Apr 21, 2022 at 03:17:47PM +0800, Cheng Xu wrote:
>>>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>>>> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
>>>> index 33d3ce9c888e..cc6a7ff88ff3 100644
>>>> +++ b/drivers/infiniband/Kconfig
>>>> @@ -92,6 +92,7 @@ source "drivers/infiniband/hw/hns/Kconfig"
>>>>   source "drivers/infiniband/hw/bnxt_re/Kconfig"
>>>>   source "drivers/infiniband/hw/hfi1/Kconfig"
>>>>   source "drivers/infiniband/hw/qedr/Kconfig"
>>>> +source "drivers/infiniband/hw/erdma/Kconfig"
>>>>   source "drivers/infiniband/sw/rdmavt/Kconfig"
>>>>   source "drivers/infiniband/sw/rxe/Kconfig"
>>>>   source "drivers/infiniband/sw/siw/Kconfig"
>>>
>>> keep sorted
>>>
>>
>> OK, I thought the order follows the rule: "comes first, appears first",
>> so I add our drivers to the tail of "drivers/infiniband/hw/..."
>>
>> Since the current list is not sorted, and if it should be, I will fix
>> this in next version.
>>
>>>> diff --git a/drivers/infiniband/hw/Makefile 
>>>> b/drivers/infiniband/hw/Makefile
>>>> index fba0b3be903e..6b3a88046125 100644
>>>> +++ b/drivers/infiniband/hw/Makefile
>>>> @@ -13,3 +13,4 @@ obj-$(CONFIG_INFINIBAND_HFI1)        += hfi1/
>>>>   obj-$(CONFIG_INFINIBAND_HNS)        += hns/
>>>>   obj-$(CONFIG_INFINIBAND_QEDR)        += qedr/
>>>>   obj-$(CONFIG_INFINIBAND_BNXT_RE)    += bnxt_re/
>>>> +obj-$(CONFIG_INFINIBAND_ERDMA)        += erdma/
>>>> diff --git a/drivers/infiniband/hw/erdma/Kconfig 
>>>> b/drivers/infiniband/hw/erdma/Kconfig
>>>> new file mode 100644
>>>> index 000000000000..c90f2be1ea63
>>>> +++ b/drivers/infiniband/hw/erdma/Kconfig
>>>> @@ -0,0 +1,12 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only
>>>> +config INFINIBAND_ERDMA
>>>> +    tristate "Alibaba Elastic RDMA Adapter (ERDMA) support"
>>>> +    depends on PCI_MSI && 64BIT && !CPU_BIG_ENDIAN
>>>
>>> Why !CPU_BIG_ENDIAN? That is usually not OK.
>>
>> we want use !CPU_BIG_ENDIAN to disable the erdma compilation on big
>> endian machine, because we only have little endian machines, and
>> don't support big endian machines. I have no idea why it is usually not
>> OK, could you explain it any more?
>>
>> Thanks
>>
>>> Did you run sparse on this?
>>>
>>
>> No, I will check this. I think this may be OK, because EFA also use
>> !CPU_BIG_ENDIAN in the same way.
>>
> 
> ...... Is
> cleaning the warnings necessary for upstream? If so, I will work on it.

Please ignore this, it seems easy to clean the warnings, I will fix
them any way.

Thanks,
Cheng Xu
