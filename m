Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A135A1F6A
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 05:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiHZDV0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 23:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244299AbiHZDVY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 23:21:24 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5C6CE339
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 20:21:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VNHDQIe_1661484079;
Received: from 30.43.104.248(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VNHDQIe_1661484079)
          by smtp.aliyun-inc.com;
          Fri, 26 Aug 2022 11:21:20 +0800
Message-ID: <fc5dbf48-f3dd-7047-1933-c9e4b86ea891@linux.alibaba.com>
Date:   Fri, 26 Aug 2022 11:21:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH for-next 0/2] RDMA/erdma: Introduce custom implementation
 of drain_sq and drain_rq
Content-Language: en-US
To:     Tom Talpey <tom@talpey.com>, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20220824094251.23190-1-chengyou@linux.alibaba.com>
 <2c7c248c-34a9-c614-6abf-e2f6640978b8@talpey.com>
 <9ba20242-7591-2ec9-4301-a6478a47fae4@linux.alibaba.com>
 <c7f4ce2d-e43d-50fa-afaf-1535aec2b0aa@talpey.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <c7f4ce2d-e43d-50fa-afaf-1535aec2b0aa@talpey.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/26/22 12:37 AM, Tom Talpey wrote:
> On 8/24/2022 9:54 PM, Cheng Xu wrote:
>>
>>
>> On 8/24/22 10:08 PM, Tom Talpey wrote:
>>> On 8/24/2022 5:42 AM, Cheng Xu wrote:
>>>> Hi,
>>>>
>>>> This series introduces erdma's implementation of drain_sq and drain_rq.
>>>> Our hardware will stop processing any new WRs if QP state is error.
>>>
>>> Doesn't this violate the IB specification? Failing newly posted WRs
>>> before older WRs have flushed to the CQ means that ordering is not
>>> preserved.
>>
>> I agree with Bernard's point.
>>
>> I'm not very familiar with with IB specification. But for RNIC/iWarp [1],
>> post WR in Error state has two optional actions: "Post WQE, and then Flush it"
>> or "Return an Immediate Error" (Showed in Figure 10). So, I think failing
>> newly posted WRs is reasonable.
> 
> <...> But the QP can only enter ERROR once the
> SQ and RQ are fully drained to the CQ(s). Until that happens, the
> WRs need to flush through.
> 

Emm, let's put erdma aside first, it seems that specification does not require
this. According to "6.2.4 Error State" in the document [1]:

 The following is done on entry into the Error state:
 * The RI MUST flush any incomplete WRs on the SQ or RQ. 
   .....
 * At some point in the execution of the flushing operation, the RI
   MUST begin to return an Immediate Error for any attempt to post
   a WR to a Work Queue;
   ....

As the second point says, The flushing operation and the behavior of returning
Immediate Error are asynchronous. what you mentioned is not guaranteed. Failing
the post_send/post_recv may happens at any time during modify_qp to error.

[1] http://www.rdmaconsortium.org/home/draft-hilland-iwarp-verbs-v1.0-RDMAC.pdf

> Your code seems to start failing WR's when the TX_STOPPED or RX_STOPPED
> bits are set. But that bit is being set when the drain *begins*, not
> when it flushes through. That seems wrong, to me.
> 

Back to erdma's scenario, As I explains above, I think failing immediately when
flushing begins does not violate the specification.


>>> Many upper layers depend on this.
>>
>> For kernel verbs, erdma currently supports NoF. we tested the NoF cases,
>> and found that it's never happened that newly WRs were posted after QP
>> changed to error, and the drain_qp should be the terminal of IO process.
>>
>> Also, in userspace, I find that many providers prevents new WRs if QP state is
>> not right.
> 
> Sure, but your new STOPPED bits don't propagate up to userspace, right?

Yes. they are only used for kernel QPs. The bits are used for setting an accurate
time point to prevent newly WRs when modify qp to error.

> The post calls will fail unexpectedly, because the QP is not yet in
> ERROR state.

Do you mean this happens in userspace or kernel? The new bits do not influence
userspace, and erdma will have the same behavior with other providers in userspace.

For kernel, this is only used in drain_qp scenario. posting WRs and drain qp
concurrently will lead uncertain results. This is also mentioned in the comment
of ib_drain_qp:

 * ensure that there are no other contexts that are posting WRs concurrently.
 * Otherwise the drain is not guaranteed.

> I'm also concerned how consumers who are posting their own "drain" WQEs
> will behave. This is a common approach that many already take. But now
> they will see different behavior when posting them...
> 

For userspace, erdma is not special.
For kernel, I think the standard way to drain WR is using ib_drain_qp, not custom
implementation. I'm not sure that there is some ULPs in kernel has their own drain
flow.

Thanks,
Cheng Xu

> Tom.
> 
> 
>>
>> So, it seems ok in practice.
>>
>> Thanks,
>> Cheng Xu
>>
>>
>> [1] http://www.rdmaconsortium.org/home/draft-hilland-iwarp-verbs-v1.0-RDMAC.pdf
>>
>>
