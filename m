Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A444F63E73E
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 02:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiLABt4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 20:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLABtz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 20:49:55 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E82D1F0;
        Wed, 30 Nov 2022 17:49:54 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NMzWp6rzvzmWKj;
        Thu,  1 Dec 2022 09:49:10 +0800 (CST)
Received: from [10.174.179.191] (10.174.179.191) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 09:49:52 +0800
Message-ID: <0b726968-bfb8-ab9a-8d03-4d072d410597@huawei.com>
Date:   Thu, 1 Dec 2022 09:49:51 +0800
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
 <65604aae-b722-4caf-3373-d0f1e4492faa@huawei.com>
 <1d27a774-cf83-6e36-4fa1-c0635ebfd79e@acm.org>
From:   wangyufen <wangyufen@huawei.com>
In-Reply-To: <1d27a774-cf83-6e36-4fa1-c0635ebfd79e@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



在 2022/12/1 2:00, Bart Van Assche 写道:
> On 11/29/22 19:31, wangyufen wrote:
>> I'm so sorry for the poor patch description. Is the following 
>> description OK?
>>
>> In the previous iteration of the while loop, "ret" may have been 
>> assigned a value of 0, so the error return code -EINVAL may have been 
>> incorrectly set to 0.
>> Also, investigate each case separately as Andy suggessted. If the help 
>> function match_int() fails, the error code is returned, which is 
>> different from the warning information printed before. If the parsing 
>> result token is incorrect, "-EINVAL" is returned and the original 
>> warning information is printed.
> 
> Please reply below instead of above. See also 
> https://en.wikipedia.org/wiki/Posting_style.
> 
> Regarding your question: not logging an error message if user input is 
> rejected is unfriendly to the user. I think it's better to keep the 
> behavior of reporting an error if a match* function fails instead of 
> reporting in the patch description that the behavior has changed.
> 

So the following modification is better?

                 case SRP_OPT_CMD_SG_ENTRIES:
-                       if (match_int(args, &token) || token < 1 || 
token > 255) {
+                       ret = match_int(args, &token);
+                       if (ret) {
+                               pr_warn("bad max cmd_sg_entries 
parameter '%s'\n",
+                                       p);
+                               goto out;
+                       }
+                       if (token < 1 || token > 255) {
                                 pr_warn("bad max cmd_sg_entries 
parameter '%s'\n",
                                         p);
+                               ret = -EINVAL;
                                 goto out;
                         }
                         target->cmd_sg_cnt = token;
                         break;


Or the following is better?

                         if (match_int(args, &token) || token < 1 || 
token > 255) {
                                 pr_warn("bad max cmd_sg_entries 
parameter '%s'\n",
                                         p);
+                               ret = -EINVAL;
                                 goto out;
                         }
                         target->cmd_sg_cnt = token;
                         break;


> Thanks,
> 
> Bart.
> 
> 
