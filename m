Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C371D6BA4F1
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 02:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCOB6M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Mar 2023 21:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCOB6L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Mar 2023 21:58:11 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DBF1B2EC
        for <linux-rdma@vger.kernel.org>; Tue, 14 Mar 2023 18:58:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vdu1T4B_1678845487;
Received: from 30.221.99.181(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0Vdu1T4B_1678845487)
          by smtp.aliyun-inc.com;
          Wed, 15 Mar 2023 09:58:07 +0800
Message-ID: <1604d654-583f-52eb-ff76-fd92647d3625@linux.alibaba.com>
Date:   Wed, 15 Mar 2023 09:58:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20230307102924.70577-1-chengyou@linux.alibaba.com>
 <20230307102924.70577-3-chengyou@linux.alibaba.com>
 <20230314102313.GB36557@unreal>
 <e6eec8de-7442-7f2b-8c90-af9222b2e12b@linux.alibaba.com>
 <20230314141020.GL36557@unreal>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20230314141020.GL36557@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/14/23 10:10 PM, Leon Romanovsky wrote:
> On Tue, Mar 14, 2023 at 07:50:19PM +0800, Cheng Xu wrote:
>>
>>
<...>
>>
>> Our doorbell space is aligned to 4096, this works fine when PAGE_SIZE is
>> also 4096, and the doorbell space starts from the mapped page. When
>> PAGE_SIZE is not 4096, the doorbell space may starts from the middle of
>> the mapped page.
>>
>> For example, our SQ doorbell starts from the offset 4096 in PCIe bar 0.
>> When we map the first SQ doorbell to userspace when PAGE_SIZE is 64K,
>> the doorbell space starts from the offset 4096 in mmap returned address.
>>
>> So the userspace needs to know the doorbell space offset in mmaped page.
> 
> And can't you preserve same alignment in the kernel for doorbells for every page size?
> Just always start from 0.
> 

I've considered this option before, but unfortunately can't, at least for CQ DB.
The size of our PCIe bar 0 is 512K, and offset [484K, 508K] are CQ doorbells.
CQ doorbell space is located in offset [36K, 60K] when PAGE_SIZE = 64K, and can't
start from offset 0 in this case.

Another reason is that we want to organize SQ doorbell space in unit of 4096.
In current implementation, each ucontext will be assigned a SQ doorbell space
for both normal doorbell and direct wqe usage. Unit of 4096, compared with
larger unit, more ucontexts can be assigned exclusive doorbell space for direct
wqe.

Thanks,
Cheng Xu
