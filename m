Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45EB5A73CB
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 04:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiHaCIZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 22:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHaCIY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 22:08:24 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238A160534
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 19:08:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VNoxD.7_1661911698;
Received: from 30.43.104.189(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VNoxD.7_1661911698)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 10:08:19 +0800
Message-ID: <21357a83-74ad-c16b-d3ce-87cd7d56c52c@linux.alibaba.com>
Date:   Wed, 31 Aug 2022 10:08:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH for-next 0/2] RDMA/erdma: Introduce custom implementation
 of drain_sq and drain_rq
Content-Language: en-US
To:     Tom Talpey <tom@talpey.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com
References: <20220824094251.23190-1-chengyou@linux.alibaba.com>
 <2c7c248c-34a9-c614-6abf-e2f6640978b8@talpey.com>
 <9ba20242-7591-2ec9-4301-a6478a47fae4@linux.alibaba.com>
 <c7f4ce2d-e43d-50fa-afaf-1535aec2b0aa@talpey.com>
 <fc5dbf48-f3dd-7047-1933-c9e4b86ea891@linux.alibaba.com>
 <8ad2446d-157b-3894-c0a3-f8a57a6e1c34@talpey.com> <YwjRV3kubU9wnwax@ziepe.ca>
 <29dc35b9-8f25-6a3a-4df3-087c27870278@linux.alibaba.com>
 <70351625-4933-d63f-aed6-f9c5a46cb9b5@talpey.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <70351625-4933-d63f-aed6-f9c5a46cb9b5@talpey.com>
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



On 8/31/22 2:45 AM, Tom Talpey wrote:
> On 8/29/2022 12:01 AM, Cheng Xu wrote:
>>
>>
>> On 8/26/22 9:57 PM, Jason Gunthorpe wrote:
>>> On Fri, Aug 26, 2022 at 09:11:25AM -0400, Tom Talpey wrote:
>>>
>>>> With your change, ERDMA will pre-emptively fail such a newly posted
>>>> request, and generate no new completion. The consumer is left in limbo
>>>> on the status of its prior requests. Providers must not override this.
>>>
>>> Yeah, I tend to agree with Tom.
>>>
>>> And I also want to point out that Linux RDMA verbs does not follow the
>>> SW specifications of either IBTA or the iWarp group. We have our own
>>> expectation for how these APIs work that our own ULPs rely on.
>>>
>>> So pedantically debating what a software spec we don't follow says is
>>> not relavent. The utility is to understand the intention and use cases
>>> and ensure we cover the same. Usually this means we follow the spec :)
>>>
>>
>> Yeah, I totally agree with this.
>>
>> Actually, I thought that ULPs do not concern about the details of how the
>> flushing and modify_qp being performed in the drivers. The drain flow is
>> handled by a single ib_drain_qp call for ULPs. While ib_drain_qp API allows
>> vendor-custom implementation, this is invisible to ULPs.
>>
>> For the ULPs which implement their own drain flow instead of using
>> ib_drain_qp  (I think it is rare in kernel), they will fail in erdma.
>>
>> Anyway, since our implementation is disputed, We'd like to keep the same
>> behavior with other vendors. Maybe firmware updating w/o driver changes or
>> software flushing in driver will fix this.
> 
> To be clear, my concern is about the ordering of CQE flushes with
> respect to the WR posting fails.Draining the CQs in whatever way
> you choose to optimize for your device is not the issue, although
> it seems odd to me that you need such a thing.
> 

Yeah, I understand what you concern about. I'm sorry that there may be
ambiguity in my last reply.

After discussed internally, we would like to drop this patch (e.g., failing
WRs before drain, or failing WRs in QP Error State), because it indeed has problem
in the cases you mentioned. And we are seeking for new solutions. New solutions
will not failing the WRs in drain cases, and by this erdma will have the same behavior
with other vendors.

More, the reason why we introduced this patch is that our hardware do not flush
newly WRs in QP Error State currently. So new solutions could be:
 - Let our hardware flush newly WRs, or
 - Flush WRs in our driver if hardware does not flush.
Either of them will eliminate the odd logic in this patch. For now, we tend the
first option.

Thanks,
Cheng Xu


> The problem is that your patch started failing the new requests
> _before_ the drain could be used to clean up. This introduced
> two new provider behaviors that consumers would not expect:
> 
> - first error detected in a post call (on the fast path!)
> - inability to determine if prior requests were complete
> 
> I'd really suggest getting a copy of the full IB spec and examining
> the difference between QP "Error" and "SQ Error" states. They are
> subtle but important.
> 
> Tom.
