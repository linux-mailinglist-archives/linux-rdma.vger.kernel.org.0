Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADED0639610
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Nov 2022 14:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKZNTM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Nov 2022 08:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKZNTL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 26 Nov 2022 08:19:11 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B531D675;
        Sat, 26 Nov 2022 05:19:10 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NKC3Z0rtXzRpW1;
        Sat, 26 Nov 2022 21:18:34 +0800 (CST)
Received: from [10.174.179.191] (10.174.179.191) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 21:19:08 +0800
Message-ID: <372591f3-c7c3-4c50-dad7-fcd386454709@huawei.com>
Date:   Sat, 26 Nov 2022 21:19:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/2] RDMA/srp: Fix error return code in
 srp_parse_options()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <bvanassche@acm.org>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <dennis.dalessandro@cornelisnetworks.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bart.vanassche@wdc.com>, <easwar.hariharan@intel.com>
References: <1669433704-2254-1-git-send-email-wangyufen@huawei.com>
 <1669433704-2254-2-git-send-email-wangyufen@huawei.com>
 <Y4IARpGaqfvHtu75@smile.fi.intel.com>
From:   wangyufen <wangyufen@huawei.com>
In-Reply-To: <Y4IARpGaqfvHtu75@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



在 2022/11/26 20:02, Andy Shevchenko 写道:
> On Sat, Nov 26, 2022 at 11:35:04AM +0800, Wang Yufen wrote:
>> In the previous while loop, "ret" may be assigned zero, , so the error
>> return code may be incorrectly set to 0 instead of -EINVAL.
>> Add out_with_einval goto label and covert all "goto out;" to "goto
>> out_with_einval:" where it's appropriate, alse investigate each case
>> separately as Andy suggessted.
> 
> It's better now, though you missed something...
> 
> ...
> 
>>   		case SRP_OPT_TARGET_CAN_QUEUE:
>> -			if (match_int(args, &token) || token < 1) {
>> +			ret = match_int(args, &token);
> 
> Check for ret?

Yes, there's a ret check missing here, will change in v3

> 
>> +			if (token < 1) {
>>   				pr_warn("bad max target_can_queue parameter '%s'\n",
>>   					p);
>> -				goto out;
>> +				goto out_with_einval;
>>   			}
>>   			target->target_can_queue = token;
>>   			break;
> 
> ...
> 
>>   			target->scsi_host->can_queue);
> 
> The below can't be like this, right?

Yes, I'm sorry for the breakage, also will change in v3
Thanks!

> 
>> +out_with_einval:
>> +	ret = -EINVAL;
>>   out:
>>   	kfree(options);
>>   	return ret;
> 
