Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2034DE755
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Mar 2022 10:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbiCSJom (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Mar 2022 05:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiCSJol (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Mar 2022 05:44:41 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6DF292D82
        for <linux-rdma@vger.kernel.org>; Sat, 19 Mar 2022 02:43:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7aISKG_1647682996;
Received: from 30.236.17.167(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V7aISKG_1647682996)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 19 Mar 2022 17:43:17 +0800
Message-ID: <95ff44f2-e442-4e99-990d-2ef2fc9c1178@linux.alibaba.com>
Date:   Sat, 19 Mar 2022 17:43:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v4 06/12] RDMA/erdma: Add event queue
 implementation
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-7-chengyou@linux.alibaba.com>
 <57cd0171-5964-228f-b004-06cec1e4daae@huawei.com>
 <20220318181850.GG64706@ziepe.ca>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220318181850.GG64706@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/19/22 2:18 AM, Jason Gunthorpe wrote:
> On Fri, Mar 18, 2022 at 07:43:21PM +0800, Wenpeng Liang wrote:
> 
>>> +static int erdma_set_ceq_irq(struct erdma_dev *dev, u16 ceqn)
>>> +{
>>> +	struct erdma_eq_cb *eqc = &dev->ceqs[ceqn];
>>> +	cpumask_t affinity_hint_mask;
>>> +	u32 cpu;
>>> +	int err;
>>> +
>>> +	snprintf(eqc->irq_name, ERDMA_IRQNAME_SIZE, "erdma-ceq%u@pci:%s",
>>> +		ceqn, pci_name(dev->pdev));
>>
>> Parameters in parentheses are not vertically aligned, a space is missing before "ceqn".
> 
> Generally I will recommend such a large amount of code be run through
> clang-format and the good things it changes be merged. Most of what it
> suggests is good kernel style
> 
> Jason

Thanks, Jason. We already use clang-format since you recommended it last
time.

We review the changes made by clang-format case by case, and merge most
of the changes. With a few cases, we handle them manually.

For this case, clang-format put the ceqn at the first line, making it 
too long (80 chars), and then the two lines of snprintf look like not
balance. So, I put the ceqn to the second line and broke the alignment
by mistake.

I will handle this carefully.

Thanks,
Cheng Xu

