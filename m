Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B089C5A41A9
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 06:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiH2EBQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 00:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiH2EBG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 00:01:06 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CC72E6BC
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 21:01:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VNW39gE_1661745661;
Received: from 30.43.104.226(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VNW39gE_1661745661)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 12:01:02 +0800
Message-ID: <29dc35b9-8f25-6a3a-4df3-087c27870278@linux.alibaba.com>
Date:   Mon, 29 Aug 2022 12:01:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH for-next 0/2] RDMA/erdma: Introduce custom implementation
 of drain_sq and drain_rq
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Tom Talpey <tom@talpey.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com
References: <20220824094251.23190-1-chengyou@linux.alibaba.com>
 <2c7c248c-34a9-c614-6abf-e2f6640978b8@talpey.com>
 <9ba20242-7591-2ec9-4301-a6478a47fae4@linux.alibaba.com>
 <c7f4ce2d-e43d-50fa-afaf-1535aec2b0aa@talpey.com>
 <fc5dbf48-f3dd-7047-1933-c9e4b86ea891@linux.alibaba.com>
 <8ad2446d-157b-3894-c0a3-f8a57a6e1c34@talpey.com> <YwjRV3kubU9wnwax@ziepe.ca>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YwjRV3kubU9wnwax@ziepe.ca>
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



On 8/26/22 9:57 PM, Jason Gunthorpe wrote:
> On Fri, Aug 26, 2022 at 09:11:25AM -0400, Tom Talpey wrote:
> 
>> With your change, ERDMA will pre-emptively fail such a newly posted
>> request, and generate no new completion. The consumer is left in limbo
>> on the status of its prior requests. Providers must not override this.
> 
> Yeah, I tend to agree with Tom.
> 
> And I also want to point out that Linux RDMA verbs does not follow the
> SW specifications of either IBTA or the iWarp group. We have our own
> expectation for how these APIs work that our own ULPs rely on.
> 
> So pedantically debating what a software spec we don't follow says is
> not relavent. The utility is to understand the intention and use cases
> and ensure we cover the same. Usually this means we follow the spec :)
> 

Yeah, I totally agree with this.

Actually, I thought that ULPs do not concern about the details of how the
flushing and modify_qp being performed in the drivers. The drain flow is
handled by a single ib_drain_qp call for ULPs. While ib_drain_qp API allows
vendor-custom implementation, this is invisible to ULPs.

For the ULPs which implement their own drain flow instead of using
ib_drain_qp  (I think it is rare in kernel), they will fail in erdma.

Anyway, since our implementation is disputed, We'd like to keep the same
behavior with other vendors. Maybe firmware updating w/o driver changes or
software flushing in driver will fix this.

Thanks,
Cheng Xu
