Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B8B5A070C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 03:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiHYB7Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 21:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbiHYB7G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 21:59:06 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B996A9E8A3
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 18:54:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VNB6BhJ_1661392448;
Received: from 30.43.105.159(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VNB6BhJ_1661392448)
          by smtp.aliyun-inc.com;
          Thu, 25 Aug 2022 09:54:10 +0800
Message-ID: <9ba20242-7591-2ec9-4301-a6478a47fae4@linux.alibaba.com>
Date:   Thu, 25 Aug 2022 09:54:08 +0800
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
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <2c7c248c-34a9-c614-6abf-e2f6640978b8@talpey.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/24/22 10:08 PM, Tom Talpey wrote:
> On 8/24/2022 5:42 AM, Cheng Xu wrote:
>> Hi,
>>
>> This series introduces erdma's implementation of drain_sq and drain_rq.
>> Our hardware will stop processing any new WRs if QP state is error.
> 
> Doesn't this violate the IB specification? Failing newly posted WRs
> before older WRs have flushed to the CQ means that ordering is not
> preserved.

I agree with Bernard's point.

I'm not very familiar with with IB specification. But for RNIC/iWarp [1],
post WR in Error state has two optional actions: "Post WQE, and then Flush it"
or "Return an Immediate Error" (Showed in Figure 10). So, I think failing
newly posted WRs is reasonable.

> Many upper layers depend on this.

For kernel verbs, erdma currently supports NoF. we tested the NoF cases,
and found that it's never happened that newly WRs were posted after QP
changed to error, and the drain_qp should be the terminal of IO process.

Also, in userspace, I find that many providers prevents new WRs if QP state is
not right.

So, it seems ok in practice.

Thanks,
Cheng Xu


[1] http://www.rdmaconsortium.org/home/draft-hilland-iwarp-verbs-v1.0-RDMAC.pdf

