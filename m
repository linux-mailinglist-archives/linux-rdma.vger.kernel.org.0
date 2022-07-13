Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF1E5733EA
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jul 2022 12:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiGMKOS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jul 2022 06:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiGMKOK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Jul 2022 06:14:10 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18204BD6AF
        for <linux-rdma@vger.kernel.org>; Wed, 13 Jul 2022 03:14:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VJDOzn8_1657707245;
Received: from 30.43.106.156(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VJDOzn8_1657707245)
          by smtp.aliyun-inc.com;
          Wed, 13 Jul 2022 18:14:06 +0800
Message-ID: <1ffcaf32-dd7c-a0db-dd5f-1d0819437b45@linux.alibaba.com>
Date:   Wed, 13 Jul 2022 18:14:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 for-next 5/5] RDMA/hns: Recover 1bit-ECC error of RAM
 on chip
Content-Language: en-US
To:     Wenpeng Liang <liangwenpeng@huawei.com>, jgg@nvidia.com,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com
References: <20220713092630.1657-1-liangwenpeng@huawei.com>
 <20220713092630.1657-6-liangwenpeng@huawei.com>
 <7a5655e7-cba6-9c6f-8591-c110de8baf32@linux.alibaba.com>
 <3eda3dd0-959a-b4d7-e67f-f5693f83c903@huawei.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <3eda3dd0-959a-b4d7-e67f-f5693f83c903@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/13/22 6:03 PM, Wenpeng Liang wrote:
> 
> On 2022/7/13 17:36, Cheng Xu wrote:
>>
>> On 7/13/22 5:26 PM, Wenpeng Liang wrote:
>>
>> <...>
>>
>>> +static int fmea_recover_others(struct hns_roce_dev *hr_dev, u32 res_type,
>>> +			       u32 index)
>>> +{
>>> +	u8 write_bt0_op = fmea_ram_res[res_type].write_bt0_op;
>>> +	u8 read_bt0_op = fmea_ram_res[res_type].read_bt0_op;
>>> +	struct hns_roce_cmd_mailbox *mailbox;
>>> +	u64 addr;
>>> +	int ret;
>>> +
>>> +	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
>>> +	if (IS_ERR(mailbox))
>>> +		return PTR_ERR(mailbox);
>>> +
>>> +	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, read_bt0_op, index);
>>> +	if (ret) {
>>> +		dev_err(hr_dev->dev,
>>> +			"failed to execute cmd to read fmea ram, ret = %d.\n",
>>> +			ret);
>>> +		goto err;
>>> +	}
>>> +
>>> +	addr = fmea_get_ram_res_addr(res_type, mailbox->buf);
>>> +
>>> +	ret = hns_roce_cmd_mbox(hr_dev, addr, 0, write_bt0_op, index);
>>> +	if (ret) {
>>> +		dev_err(hr_dev->dev,
>>> +			"failed to execute cmd to write fmea ram, ret = %d.\n",
>>> +			ret);
>>> +		goto err;
>>> +	}
>>> +
>> Here it seems that you miss a "return 0" or the "goto err;" is unnecessary.
>>
> 
> Will remove the "goto err;".
> 

And, if the hns_roce_free_cmd_mailbox is called in both normal and error flow,
Maybe using "out" or some name else is better than "err" as the jump label?

Thanks,
Cheng Xu
