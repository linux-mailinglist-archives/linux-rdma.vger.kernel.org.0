Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A2E6C686A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 13:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjCWMeB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 08:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCWMeA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 08:34:00 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DBF18B3A
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 05:33:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VeUJOOz_1679574835;
Received: from 30.221.102.45(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VeUJOOz_1679574835)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 20:33:56 +0800
Message-ID: <243f9c6f-72ab-c503-33be-24e58e1d4ddf@linux.alibaba.com>
Date:   Thu, 23 Mar 2023 20:33:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <gal@nvidia.com>
References: <e6eec8de-7442-7f2b-8c90-af9222b2e12b@linux.alibaba.com>
 <20230314141020.GL36557@unreal>
 <1604d654-583f-52eb-ff76-fd92647d3625@linux.alibaba.com>
 <20230315102210.GT36557@unreal> <ZBm/deQgMYfdPt/u@ziepe.ca>
 <2c82439c-15d0-d5dd-b1c5-46053d3dd202@linux.alibaba.com>
 <ZBrsexPDqDIej/2/@ziepe.ca>
 <6c982b76-61b2-7317-ab76-8ff0b4fb4471@linux.alibaba.com>
 <ZBsKHBN2NIFA6/YD@ziepe.ca>
 <8c446431-9f86-7267-6051-9c016e23215e@linux.alibaba.com>
 <ZBw9pmTtAlNVffuA@ziepe.ca>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <ZBw9pmTtAlNVffuA@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/23/23 7:53 PM, Jason Gunthorpe wrote:
> On Thu, Mar 23, 2023 at 02:57:49PM +0800, Cheng Xu wrote:
>>
>>
>> On 3/22/23 10:01 PM, Jason Gunthorpe wrote:
>>> On Wed, Mar 22, 2023 at 09:30:41PM +0800, Cheng Xu wrote:
>>>>
>>>>
>>>> On 3/22/23 7:54 PM, Jason Gunthorpe wrote:
<...>
>>
>> It's much clear, thanks for your explanation and patience.
>>
>> Back to erdma context, we have rethought our implementation. For QPs,
>> we have a field *wqe_index* in SQE/RQE, which indicates the validity
>> of the current WQE. Incorrect doorbell value from other processes can
>> not corrupt the QPC in hardware due to PI range and WQE content
>> validation in HW.
> 
> No, validating the DB content is not acceptable security. The attacker
> process can always generate valid content if it tries hard enough.
>

Oh, you may misunderstand what I said, our HW validates the *WQE* content,
not *DB* content. The attacker can not generate the WQE of other QPs. This
protection and correction is already implemented in our HW.

> The only acceptable answer is to do like every other NIC did and link
> the DB register to the HW object it is allowed to affect.
> 

Emm, still not acceptable with WQE content validation? If it's acceptable,
will reduce some works.

Thanks,
Cheng Xu


