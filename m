Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9198363CDD2
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Nov 2022 04:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiK3Dbg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Nov 2022 22:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK3Dbg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Nov 2022 22:31:36 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C6B5ADE1;
        Tue, 29 Nov 2022 19:31:34 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NMPqZ4gj3zHwDs;
        Wed, 30 Nov 2022 11:30:50 +0800 (CST)
Received: from [10.174.179.191] (10.174.179.191) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 11:31:32 +0800
Message-ID: <65604aae-b722-4caf-3373-d0f1e4492faa@huawei.com>
Date:   Wed, 30 Nov 2022 11:31:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 2/2] RDMA/srp: Fix error return code in
 srp_parse_options()
To:     Bart Van Assche <bvanassche@acm.org>, <jgg@ziepe.ca>,
        <leon@kernel.org>, <dennis.dalessandro@cornelisnetworks.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <bart.vanassche@wdc.com>,
        <easwar.hariharan@intel.com>
References: <1669687459-14180-1-git-send-email-wangyufen@huawei.com>
 <1669687459-14180-2-git-send-email-wangyufen@huawei.com>
 <b4d78eb0-4492-ac7f-d500-3d49b0dc7aa1@acm.org>
From:   wangyufen <wangyufen@huawei.com>
In-Reply-To: <b4d78eb0-4492-ac7f-d500-3d49b0dc7aa1@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

I'm so sorry for the poor patch description. Is the following 
description OK?

In the previous iteration of the while loop, "ret" may have been 
assigned a value of 0, so the error return code -EINVAL may have been 
incorrectly set to 0.
Also, investigate each case separately as Andy suggessted. If the help 
function match_int() fails, the error code is returned, which is 
different from the warning information printed before. If the parsing 
result token is incorrect, "-EINVAL" is returned and the original 
warning information is printed.


Thanks.

在 2022/11/30 2:43, Bart Van Assche 写道:
> On 11/28/22 18:04, Wang Yufen wrote:
>> In the previous while loop, "ret" may be assigned zero, , so the error
> 
> The word "iteration" is missing from the above sentence. Additionally, 
> there is a double comma.
> 
>> return code may be incorrectly set to 0 instead of -EINVAL. Alse
> 
> Alse -> Also
> 
>>           case SRP_OPT_QUEUE_SIZE:
>> -            if (match_int(args, &token) || token < 1) {
>> +            ret = match_int(args, &token);
>> +            if (ret)
>> +                goto out;
>> +            if (token < 1) {
>>                   pr_warn("bad queue_size parameter '%s'\n", p);
>> +                ret = -EINVAL;
>>                   goto out;
>>               }
>>               target->scsi_host->can_queue = token;
> 
> Why only to report "bad queue_size parameter" if ret == 0 && token < 1 
> but not if ret < 0? This is a behavior change that has not been 
> explained in the patch description.
> 
>> @@ -3490,25 +3496,34 @@ static int srp_parse_options(struct net *net, 
>> const char *buf,
>>               break;
>>           case SRP_OPT_MAX_CMD_PER_LUN:
>> -            if (match_int(args, &token) || token < 1) {
>> +            ret = match_int(args, &token);
>> +            if (ret)
>> +                goto out;
>> +            if (token < 1) {
>>                   pr_warn("bad max cmd_per_lun parameter '%s'\n",
>>                       p);
>> +                ret = -EINVAL;
>>                   goto out;
>>               }
>>               target->scsi_host->cmd_per_lun = token;
>>               break;
> 
> Same comment here and for many other changes below.
> 
> Thanks,
> 
> Bart.
> 
> 
