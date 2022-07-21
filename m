Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3872557C73A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 11:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiGUJO6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 05:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbiGUJO6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 05:14:58 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DBF3FA23;
        Thu, 21 Jul 2022 02:14:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VK.RF5m_1658394892;
Received: from 192.168.0.4(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VK.RF5m_1658394892)
          by smtp.aliyun-inc.com;
          Thu, 21 Jul 2022 17:14:54 +0800
Message-ID: <6f684f43-4c98-8f27-abea-02ad5f68cef1@linux.alibaba.com>
Date:   Thu, 21 Jul 2022 17:14:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] RDMA/erdma: Use the bitmap API to allocate bitmaps
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <2764b6e204b32ef8c198a5efaf6c6bc4119f7665.1657301795.git.christophe.jaillet@wanadoo.fr>
 <670c57a2-6432-80c9-cdc0-496d836d7bf0@linux.alibaba.com>
 <20220712090110.GL2338@kadam> <20220719125434.GG5049@ziepe.ca>
 <20220719130125.GB2316@kadam>
 <7075158a-64c1-8f69-7de1-9a60ee914f05@wanadoo.fr>
 <5bcd437f-92a4-1c04-796c-41559dd2823a@linux.alibaba.com>
 <YtkA4tBhlSHX76JM@unreal>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YtkA4tBhlSHX76JM@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/21/22 3:31 PM, Leon Romanovsky wrote:
> On Wed, Jul 20, 2022 at 09:58:24AM +0800, Cheng Xu wrote:
>>
>>
>> On 7/19/22 11:36 PM, Christophe JAILLET wrote:
>>> Le 19/07/2022 à 15:01, Dan Carpenter a écrit :
>>>> On Tue, Jul 19, 2022 at 09:54:34AM -0300, Jason Gunthorpe wrote:
>>>>> On Tue, Jul 12, 2022 at 12:01:10PM +0300, Dan Carpenter wrote:
>>>>>
>>>>>> Best not to use any auto-formatting tools.  They are all bad.
>>>>>
>>>>> Have you tried clang-format? I wouldn't call it bad..
>>>>
>>>> I prefered Christophe's formatting to clang's.  ;)
>>>>
>>>> regards,
>>>> dan carpenter
>>>>
>>>>
>>>
>>> Hi,
>>>
>>> (some other files in the same directory also have some checkpatch warning/error)
>>
>> I just double checked the checkpatch results, Two type warnings reported:
>>
>>  - WARNING: Missing commit description - Add an appropriate one (for patch 0001)
>>  - WARNING: added, moved or deleted file(s), does MAINTAINERS need updating? (for almost all patches except 0001/0011)
>>
>> For the first warning, the change is very simple: add erdma's
>> rdma_driver_id definition, I think the commit title can describe
>> all things, and is enough.
> 
> To be clear, our preference is to have commit message in any case, even
> for simple changes.
> 

Sorry for this, I didn't know it previously. Before I sent our patches, I reviewed the EFA/SIW's
upstreaming history, and siw only has one line commit title for simply changes, I followed.

I will update our patches to fix it in a few days, and collect potential feedback
of erdma code in linux-next.

Thanks,
Cheng Xu
