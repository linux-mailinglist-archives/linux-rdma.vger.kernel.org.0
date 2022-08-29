Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC66F5A4186
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 05:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiH2DhM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 23:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiH2DhL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 23:37:11 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29314057F
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 20:37:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VNW0kTo_1661744226;
Received: from 30.43.104.226(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VNW0kTo_1661744226)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 11:37:07 +0800
Message-ID: <ee614b07-4438-63c0-26f5-581068a4d1c9@linux.alibaba.com>
Date:   Mon, 29 Aug 2022 11:37:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH for-next 0/2] RDMA/erdma: Introduce custom implementation
 of drain_sq and drain_rq
Content-Language: en-US
To:     Tom Talpey <tom@talpey.com>, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20220824094251.23190-1-chengyou@linux.alibaba.com>
 <2c7c248c-34a9-c614-6abf-e2f6640978b8@talpey.com>
 <9ba20242-7591-2ec9-4301-a6478a47fae4@linux.alibaba.com>
 <c7f4ce2d-e43d-50fa-afaf-1535aec2b0aa@talpey.com>
 <fc5dbf48-f3dd-7047-1933-c9e4b86ea891@linux.alibaba.com>
 <8ad2446d-157b-3894-c0a3-f8a57a6e1c34@talpey.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <8ad2446d-157b-3894-c0a3-f8a57a6e1c34@talpey.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/26/22 9:11 PM, Tom Talpey wrote:
> On 8/25/2022 11:21 PM, Cheng Xu wrote:
>> On 8/26/22 12:37 AM, Tom Talpey wrote:
>>> On 8/24/2022 9:54 PM, Cheng Xu wrote:
>>>>
>>>>
>>>> On 8/24/22 10:08 PM, Tom Talpey wrote:
>>>>> On 8/24/2022 5:42 AM, Cheng Xu wrote:
>>>>>> Hi,
>>>>>>
>>>>>> This series introduces erdma's implementation of drain_sq and drain_rq.
>>>>>> Our hardware will stop processing any new WRs if QP state is error.
>>>>>
>>>>> Doesn't this violate the IB specification? Failing newly posted WRs
>>>>> before older WRs have flushed to the CQ means that ordering is not
>>>>> preserved.
>>>>
>>>> I agree with Bernard's point.
>>>>
>>>> I'm not very familiar with with IB specification. But for RNIC/iWarp [1],
>>>> post WR in Error state has two optional actions: "Post WQE, and then Flush it"
>>>> or "Return an Immediate Error" (Showed in Figure 10). So, I think failing
>>>> newly posted WRs is reasonable.
>>>
>>> <...> But the QP can only enter ERROR once the
>>> SQ and RQ are fully drained to the CQ(s). Until that happens, the
>>> WRs need to flush through.
>>>
>>
>> Emm, let's put erdma aside first, it seems that specification does not require
>> this. According to "6.2.4 Error State" in the document [1]:
>>
>>   The following is done on entry into the Error state:
>>   * The RI MUST flush any incomplete WRs on the SQ or RQ.
>>     .....
>>   * At some point in the execution of the flushing operation, the RI
>>     MUST begin to return an Immediate Error for any attempt to post
>>     a WR to a Work Queue;
>>     ....
>>
>> As the second point says, The flushing operation and the behavior of returning
>> Immediate Error are asynchronous. what you mentioned is not guaranteed. Failing
>> the post_send/post_recv may happens at any time during modify_qp to error.
>>
>> [1] http://www.rdmaconsortium.org/home/draft-hilland-iwarp-verbs-v1.0-RDMAC.pdf
> 
> Well, that language is very imprecise, "at some point" is not exactly
> definitive. I'll explain one scenario that makes it problematic.
> 
>>> Your code seems to start failing WR's when the TX_STOPPED or RX_STOPPED
>>> bits are set. But that bit is being set when the drain *begins*, not
>>> when it flushes through. That seems wrong, to me.
>>>
>>
>> Back to erdma's scenario, As I explains above, I think failing immediately when
>> flushing begins does not violate the specification.
> 
> Consider a consumer which posts with a mix of IB_SEND_SIGNALED and
> also unsignaled WRs, for example, fast-memory registration followed
> by a send, a very typical storage consumer operation.
> 
> - post_wr(memreg, !signaled) => post success
> -      => operation success, no completion generated
> - ...  <= provider detects error here
> - post_wr(send, signaled) => post fail (new in your patch)
> - ...  <= provider notifies async error, etc.
> 
> The consumer now knows there's an error, and needs to tear down.
> It must remove the DMA mapping before proceeding, but the hardware
> may still be using it. How does it determine the status of that
> first post_wr, so it may proceed?
> 
> The IB spec explicitly states that the post verb can only return
> the immediate error after the QP has exited the ERROR state, which
> includes all pending WRs having been flushed and made visible on
> the CQ. Here is an excerpt from the Post Send Request section
> 11.4.1.1 specifying its output modifiers:
> 
> -> Invalid QP state.
> -> Note: This error is returned only when the QP is in the Reset,
> -> Init, or RTR states. It is not returned when the QP is in the Error
> -> or Send Queue Error states due to race conditions that could
> -> result in indeterminate behavior. Work Requests posted to the
> -> Send Queue while the QP is in the Error or Send Queue Error
> -> states are completed with a flush error.
> 

Get it, thanks. The IB spec seems to be more clear.

> So, the consumer will post a new, signaled, work request, and wait
> for it to "flush through" by polling the CQ. Because WR's always
> complete in-order, this final completion must appear after *all*
> prior WR's, and this gives the consumer the green light to proceed.
> 

Yeah, this is right, and the default ib_drain_qp do it in this way.

> With your change, ERDMA will pre-emptively fail such a newly posted
> request, and generate no new completion. The consumer is left in limbo
> on the status of its prior requests. Providers must not override this.

For the ULPs that do not use ib_drain_qp interface, we will have problem.

But currently it seems that almost all the ULPs in kernel call ib_drain_qp
to finish the drain flow. While ib_drain_qp allows vendors to have
custom ib_drain_qp implementations which is invisible to ULPs.

Thanks,
Cheng Xu


> Tom.
> 

