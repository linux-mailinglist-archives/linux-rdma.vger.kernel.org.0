Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1786C6A7D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 15:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCWOLB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 10:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCWOLA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 10:11:00 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3D82E80D
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 07:10:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VeUexdK_1679580626;
Received: from 30.15.217.14(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VeUexdK_1679580626)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 22:10:27 +0800
Message-ID: <8677b42c-3f61-b83d-cd97-68591778944d@linux.alibaba.com>
Date:   Thu, 23 Mar 2023 22:10:25 +0800
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
References: <1604d654-583f-52eb-ff76-fd92647d3625@linux.alibaba.com>
 <20230315102210.GT36557@unreal> <ZBm/deQgMYfdPt/u@ziepe.ca>
 <2c82439c-15d0-d5dd-b1c5-46053d3dd202@linux.alibaba.com>
 <ZBrsexPDqDIej/2/@ziepe.ca>
 <6c982b76-61b2-7317-ab76-8ff0b4fb4471@linux.alibaba.com>
 <ZBsKHBN2NIFA6/YD@ziepe.ca>
 <8c446431-9f86-7267-6051-9c016e23215e@linux.alibaba.com>
 <ZBw9pmTtAlNVffuA@ziepe.ca>
 <243f9c6f-72ab-c503-33be-24e58e1d4ddf@linux.alibaba.com>
 <ZBxOoxynDEql7wHT@ziepe.ca>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <ZBxOoxynDEql7wHT@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/23/23 9:05 PM, Jason Gunthorpe wrote:
> On Thu, Mar 23, 2023 at 08:33:53PM +0800, Cheng Xu wrote:
>>
>>
>> On 3/23/23 7:53 PM, Jason Gunthorpe wrote:
>>> On Thu, Mar 23, 2023 at 02:57:49PM +0800, Cheng Xu wrote:
>>>>
>>>>
>>>> On 3/22/23 10:01 PM, Jason Gunthorpe wrote:
>>>>> On Wed, Mar 22, 2023 at 09:30:41PM +0800, Cheng Xu wrote:
>>>>>>
>>>>>>
>>>>>> On 3/22/23 7:54 PM, Jason Gunthorpe wrote:
>> <...>
>>>>
>>>> It's much clear, thanks for your explanation and patience.
>>>>
>>>> Back to erdma context, we have rethought our implementation. For QPs,
>>>> we have a field *wqe_index* in SQE/RQE, which indicates the validity
>>>> of the current WQE. Incorrect doorbell value from other processes can
>>>> not corrupt the QPC in hardware due to PI range and WQE content
>>>> validation in HW.
>>>
>>> No, validating the DB content is not acceptable security. The attacker
>>> process can always generate valid content if it tries hard enough.
>>>
>>
>> Oh, you may misunderstand what I said, our HW validates the *WQE* content,
>> not *DB* content. The attacker can not generate the WQE of other QPs. This
>> protection and correction is already implemented in our HW.
> 
> Why are you talking about WQEs in a discussion about doorbell
> security?

Malicious doorbell will corrupt the head pointer in QPC, and then invalid WQEs
will be processed. My point is that WQE validation can correct the head pointer
carried in malicious doorbell, and can prevent such attack.

It looks like the first kind of the doorbell types you mentioned before, but only
conveying the QPN.

Thanks,
Cheng Xu 
