Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF48672D742
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 04:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjFMCKT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 22:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjFMCKS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 22:10:18 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6B5131
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 19:10:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vl00bxu_1686622212;
Received: from 30.221.101.46(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0Vl00bxu_1686622212)
          by smtp.aliyun-inc.com;
          Tue, 13 Jun 2023 10:10:13 +0800
Message-ID: <a754cbb3-43af-8317-68a4-ff02232ac5a7@linux.alibaba.com>
Date:   Tue, 13 Jun 2023 10:10:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH for-next 0/4] RDMA/erdma: Add a new doorbell allocation
 mechanism
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20230606055005.80729-1-chengyou@linux.alibaba.com>
 <20230611091936.GB12152@unreal>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20230611091936.GB12152@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 6/11/23 5:19 PM, Leon Romanovsky wrote:
> On Tue, Jun 06, 2023 at 01:50:01PM +0800, Cheng Xu wrote:
>> Hi,
>>
>> This series adds a new doorbell allocation mechanism to meet the
>> the isolation requirement for userspace applications. Two main change
>> points in this patch set: One is that we extend the bar space for doorbell
>> allocation, and the other one is that we associate QPs/CQs with the
>> allocated doorbells for authorization. We also keep the original doorbell
>> mechanism for compatibility, but only used under CAP_SYS_RAWIO to prevent
>> non-privileged access, which suggested by Jason before.
>>
>> - #1 configures the current PAGE_SIZE to hardware, so that hardware can
>>   organize the mmio space properly.
>> - #2~#3 implement the new doorbell allocation mechanism.
>> - #4 refactors the doorbell allocation part to make code more simpler and
>>   cleaner.
>>
>> Thanks,
>> Cheng Xu
>>
>> Cheng Xu (4):
>>   RDMA/erdma: Configure PAGE_SIZE to hardware
>>   RDMA/erdma: Allocate doorbell resources from hardware
>>   RDMA/erdma: Associate QPs/CQs with doorbells for authorization
>>   RDMA/erdma: Refactor the original doorbell allocation mechanism
> 
> As a side note, there is no need to perform double not (!!...) when
> assigning to bool variables.
> 

Get it. I will address it in future patchset together with other cleaning up.

Thanks,
Cheng Xu

