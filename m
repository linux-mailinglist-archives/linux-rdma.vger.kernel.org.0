Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83570639311
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Nov 2022 02:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiKZBXZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Nov 2022 20:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiKZBXY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Nov 2022 20:23:24 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7866943849;
        Fri, 25 Nov 2022 17:23:23 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NJv9g5tXGzRpXR;
        Sat, 26 Nov 2022 09:22:47 +0800 (CST)
Received: from [10.174.179.191] (10.174.179.191) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 09:23:21 +0800
Message-ID: <01fc11f9-b798-f690-32d9-7f4d577a8e82@huawei.com>
Date:   Sat, 26 Nov 2022 09:23:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/2] RDMA/srp: Fix error return code in
 srp_parse_options()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <bvanassche@acm.org>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <dennis.dalessandro@cornelisnetworks.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bart.vanassche@wdc.com>, <easwar.hariharan@intel.com>
References: <1669377831-41386-1-git-send-email-wangyufen@huawei.com>
 <1669377831-41386-2-git-send-email-wangyufen@huawei.com>
 <Y4DTMQVenpsEiKHz@smile.fi.intel.com>
From:   wangyufen <wangyufen@huawei.com>
In-Reply-To: <Y4DTMQVenpsEiKHz@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



在 2022/11/25 22:37, Andy Shevchenko 写道:
> On Fri, Nov 25, 2022 at 08:03:51PM +0800, Wang Yufen wrote:
>> In the previous while loop, "ret" may be assigned zero. Therefore,
>> "ret" needs to be assigned -EINVAL at the beginning of each loop.
> 
> ...
> 
>>   	while ((p = strsep(&sep_opt, ",\n")) != NULL) {
>> +		ret = -EINVAL;
>>   		if (!*p)
>>   			continue;
> 
> Better option is to investigate each case separately and gather all of them
> into a single fix.
> 
> For example, this
> 
> 	case SRP_OPT_MAX_IT_IU_SIZE:
> 		if (match_int(args, &token) || token < 0) {
> 			pr_warn("bad maximum initiator to target IU size '%s'\n", p);
> 			goto out;
> 		}
> 		target->max_it_iu_size = token;
> 		break;
> 
> can be rewritten as
> 
> 	case SRP_OPT_MAX_IT_IU_SIZE:
> 		ret = match_int(args, &token);
> 		if (ret)
> 			goto out;
> 		if (token < 0) {
> 			pr_warn("bad maximum initiator to target IU size '%s'\n", p);
> 			ret = -EINVAL;
> 			goto out;
> 		}
> 		target->max_it_iu_size = token;
> 		break;
> 
> and so on...
>
I got it. Will change in v2.
Thanks!

