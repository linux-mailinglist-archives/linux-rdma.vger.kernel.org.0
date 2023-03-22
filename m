Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FB06C4BB8
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 14:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCVNaw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 09:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVNau (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 09:30:50 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E8D10D1
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 06:30:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VeQxEIf_1679491845;
Received: from 30.221.102.45(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VeQxEIf_1679491845)
          by smtp.aliyun-inc.com;
          Wed, 22 Mar 2023 21:30:46 +0800
Message-ID: <6c982b76-61b2-7317-ab76-8ff0b4fb4471@linux.alibaba.com>
Date:   Wed, 22 Mar 2023 21:30:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com
References: <20230307102924.70577-1-chengyou@linux.alibaba.com>
 <20230307102924.70577-3-chengyou@linux.alibaba.com>
 <20230314102313.GB36557@unreal>
 <e6eec8de-7442-7f2b-8c90-af9222b2e12b@linux.alibaba.com>
 <20230314141020.GL36557@unreal>
 <1604d654-583f-52eb-ff76-fd92647d3625@linux.alibaba.com>
 <20230315102210.GT36557@unreal> <ZBm/deQgMYfdPt/u@ziepe.ca>
 <2c82439c-15d0-d5dd-b1c5-46053d3dd202@linux.alibaba.com>
 <ZBrsexPDqDIej/2/@ziepe.ca>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <ZBrsexPDqDIej/2/@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/22/23 7:54 PM, Jason Gunthorpe wrote:
> On Wed, Mar 22, 2023 at 03:05:29PM +0800, Cheng Xu wrote:
> 
>> The current generation of erdma devices do not have this capability due to
>> implementation complexity. Without this HW capability, isolating the MMIO
>> space in software doesn't prevent the attack, because the malicious APPs
>> can map mmio itself, not through verbs interface.
> 
> This doesn't meet the security model of Linux, verbs HW is expected to
> protect one process from another process.

OK, I see.

So the key point is that HW should restrict each process to use its own doorbell
space. If hardware can do this, share or do not share MMIO pages both will meet
the security requirement. Do I get it right? 

It seems that EFA uses shared MMIO pages with hardware security assurance.

> if this is the case we should consider restricting this HW to
> CAP_SYS_RAW_IO only.
> 

Please give us a chance to fix this issue first.

> You should come with an explanation why this HW is safe enough to
> avoid this.

I need to discuss with our HW guys and implement the similar security check
in HW, and this won't be long.

Thanks,
Cheng Xu
