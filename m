Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E014DE732
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Mar 2022 10:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiCSJTk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Mar 2022 05:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiCSJTj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Mar 2022 05:19:39 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C75132EA8
        for <linux-rdma@vger.kernel.org>; Sat, 19 Mar 2022 02:18:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7aDvi9_1647681495;
Received: from 30.236.17.167(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V7aDvi9_1647681495)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 19 Mar 2022 17:18:16 +0800
Message-ID: <fb8404d7-65a5-bc02-30c1-710154123e0e@linux.alibaba.com>
Date:   Sat, 19 Mar 2022 17:18:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v4 05/12] RDMA/erdma: Add cmdq implementation
Content-Language: en-US
To:     Wenpeng Liang <liangwenpeng@huawei.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-6-chengyou@linux.alibaba.com>
 <7292f337-9532-d1b2-b755-fb2630ed55fb@huawei.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <7292f337-9532-d1b2-b755-fb2630ed55fb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/18/22 8:57 PM, Wenpeng Liang wrote:
> On 2022/3/14 14:47, Cheng Xu wrote:
>> Cmdq is the main control plane channel between erdma driver and hardware.
>> After erdma device is initialized, the cmdq channel will be active in the
>> whole lifecycle of this driver.
> 
> <...>
> 
>> +static int erdma_poll_cmd_completion(struct erdma_comp_wait *comp_ctx,
>> +				     struct erdma_cmdq *cmdq, u32 timeout)
>> +{
>> +	unsigned long comp_timeout = jiffies + msecs_to_jiffies(timeout);
>> +
>> +	while (1) {
>> +		erdma_polling_cmd_completions(cmdq);
>> +		if (comp_ctx->cmd_status != ERDMA_CMD_STATUS_ISSUED)
>> +			break;
>> +
>> +		if (time_is_before_jiffies(comp_timeout))
>> +			return -ETIME;
>> +
>> +		msleep(20);
>> +	}
> 
> Here I feel confused, why not use time_after as an exit condition?
> I would be grateful if you explain this timeout exit mechanism.
> 

They are the same, You can review the definition in <linux/jiffies.h> :

/* time_is_before_jiffies(a) return true if a is before jiffies */
#define time_is_before_jiffies(a) time_after(jiffies, a)


Thanks,
Cheng Xu

> Thanks,
> Wenpeng
