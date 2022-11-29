Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02C563B743
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Nov 2022 02:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbiK2Baf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Nov 2022 20:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiK2Bad (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Nov 2022 20:30:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF5340934;
        Mon, 28 Nov 2022 17:30:31 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NLl6X25tnzqSk0;
        Tue, 29 Nov 2022 09:26:28 +0800 (CST)
Received: from [10.174.179.191] (10.174.179.191) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 09:30:28 +0800
Message-ID: <632848a1-d363-7a20-8dd3-fae6645fc28d@huawei.com>
Date:   Tue, 29 Nov 2022 09:30:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 1/2] RDMA/hfi1: Fix error return code in
 parse_platform_config()
To:     Leon Romanovsky <leon@kernel.org>
CC:     <bvanassche@acm.org>, <jgg@ziepe.ca>,
        <dennis.dalessandro@cornelisnetworks.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <bart.vanassche@wdc.com>,
        <easwar.hariharan@intel.com>
References: <1669470654-45828-1-git-send-email-wangyufen@huawei.com>
 <Y4SiPfXbMoSc1E6M@unreal>
From:   wangyufen <wangyufen@huawei.com>
In-Reply-To: <Y4SiPfXbMoSc1E6M@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



在 2022/11/28 19:57, Leon Romanovsky 写道:
> On Sat, Nov 26, 2022 at 09:50:53PM +0800, Wang Yufen wrote:
>> In the previous while loop, "ret" may be assigned zero, so the error
>> return code may be incorrectly set to 0 instead of -EINVAL.
>> Add bail_with_einval goto label and covert all "goto bail;" to "goto
>> bail_with_einval:" where it's appropriate. Add dropping some duplicative
>> "ret = -EINVAL;" lines, as Andy suggessted.
>>
>> Fixes: 97167e813415 ("staging/rdma/hfi1: Tune for unknown channel if configuration file is absent")
>> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   drivers/infiniband/hw/hfi1/firmware.c | 20 +++++++++++---------
>>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> <...>
> 
> 
>> +bail_with_einval:
>> +	ret = -EINVAL;
> 
> Sorry for being late, but no. It can be seen as anti-pattern as it
> causes to the situations where unrelated code changes can potentially
> overwrite return value. Please set valid return code before calling to
> goto.

OK, will change in v4.
Thanks
> 
> Thanks
> 
>>   bail:
>>   	memset(pcfgcache, 0, sizeof(struct platform_config_cache));
>>   	return ret;
>> -- 
>> 1.8.3.1
>>
