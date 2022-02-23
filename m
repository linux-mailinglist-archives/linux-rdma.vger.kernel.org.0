Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E634C078A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 03:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiBWCDJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 21:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiBWCDH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 21:03:07 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADF410D0
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 18:02:41 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V5FyakQ_1645581757;
Received: from 30.43.106.56(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V5FyakQ_1645581757)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Feb 2022 10:02:38 +0800
Message-ID: <8020ed82-22b0-ee12-8bac-e3bfd66d9178@linux.alibaba.com>
Date:   Wed, 23 Feb 2022 10:02:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v3 03/12] RDMA/erdma: Add the hardware related
 definitions
Content-Language: en-US
To:     Wenpeng Liang <liangwenpeng@huawei.com>,
        Cheng Xu <chengyou.xc@alibaba-inc.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20220217030116.6324-1-chengyou.xc@alibaba-inc.com>
 <20220217030116.6324-4-chengyou.xc@alibaba-inc.com>
 <0d2f5636-3e7b-6dad-3fb6-6fee1067b522@huawei.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <0d2f5636-3e7b-6dad-3fb6-6fee1067b522@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,UPPERCASE_50_75,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/22/22 2:26 PM, Wenpeng Liang wrote:
> On 2022/2/17 11:01, Cheng Xu wrote:
>> +enum erdma_opcode {
>> +	ERDMA_OP_WRITE           = 0,
>> +	ERDMA_OP_READ            = 1,
>> +	ERDMA_OP_SEND            = 2,
>> +	ERDMA_OP_SEND_WITH_IMM   = 3,
>> +
>> +	ERDMA_OP_RECEIVE         = 4,
>> +	ERDMA_OP_RECV_IMM        = 5,
>> +	ERDMA_OP_RECV_INV        = 6,
>> +
>> +	ERDMA_OP_REQ_ERR         = 7,
>> +	ERDNA_OP_READ_RESPONSE   = 8,
> 
> Is there a typo here?
> 
> ERDNA_xxx -> ERDMA_xxx
> 
Yes, will fix it.

Thanks,
Cheng Xu,

> Thanks,
> Wenpeng
> 
>> +	ERDMA_OP_WRITE_WITH_IMM  = 9,
>> +
>> +	ERDMA_OP_RECV_ERR        = 10,
