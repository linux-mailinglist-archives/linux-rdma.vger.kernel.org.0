Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAA4571641
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 11:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiGLJ4M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 05:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGLJ4L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 05:56:11 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053DBAA835;
        Tue, 12 Jul 2022 02:56:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VJ7lbUe_1657619766;
Received: from 30.43.105.186(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VJ7lbUe_1657619766)
          by smtp.aliyun-inc.com;
          Tue, 12 Jul 2022 17:56:07 +0800
Message-ID: <820bc0be-d044-ef52-3255-26b973b04cf4@linux.alibaba.com>
Date:   Tue, 12 Jul 2022 17:56:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] RDMA/erdma: Use the bitmap API to allocate bitmaps
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <2764b6e204b32ef8c198a5efaf6c6bc4119f7665.1657301795.git.christophe.jaillet@wanadoo.fr>
 <670c57a2-6432-80c9-cdc0-496d836d7bf0@linux.alibaba.com>
 <20220712090110.GL2338@kadam>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220712090110.GL2338@kadam>
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



On 7/12/22 5:01 PM, Dan Carpenter wrote:
> On Mon, Jul 11, 2022 at 03:34:56PM +0800, Cheng Xu wrote:
>>
>>
>> On 7/9/22 1:37 AM, Christophe JAILLET wrote:
>>> Use [devm_]bitmap_zalloc()/bitmap_free() instead of hand-writing them.
>>>
>>> It is less verbose and it improves the semantic.
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>>  drivers/infiniband/hw/erdma/erdma_cmdq.c | 7 +++----
>>>  drivers/infiniband/hw/erdma/erdma_main.c | 9 ++++-----
>>>  2 files changed, 7 insertions(+), 9 deletions(-)
>>>
>>
>> Hi Christophe,
>>
>> Thanks for your two patches of erdma.
>>
>> The erdma code your got is our first upstreaming code, so I would like to squash your
>> changes into the relevant commit in our next patchset to make the commit history cleaner.
>>
>> BTW, the coding style in the patches is OK, but has a little differences with clang-format's
>> result. I will use the format from clang-format to minimize manual adjustments.
>>  
> 
> Best not to use any auto-formatting tools.  They are all bad.
> 
I understand your worry. Tool is not prefect but it's useful to handle large amounts of code in
our first upstream, and helps us avoiding style mistakes.

While using the clang-format with the config in kernel tree, we also checked all the modifications
made by the tool carefully. We won't rely on tools too much with small changes in the future.

Thanks,
Cheng Xu


