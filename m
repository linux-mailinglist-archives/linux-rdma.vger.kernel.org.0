Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ACE4C42C3
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 11:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiBYKve (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 05:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiBYKvd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 05:51:33 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4837B23931C
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 02:51:01 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K4mgk3m2Sz9sK8;
        Fri, 25 Feb 2022 18:47:30 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 18:50:59 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Feb
 2022 18:50:59 +0800
Subject: Re: [PATCH for-next 5/8] RDMA/hns: Refactor mailbox functions
To:     Leon Romanovsky <leon@kernel.org>
References: <20220218110519.37375-1-liangwenpeng@huawei.com>
 <20220218110519.37375-6-liangwenpeng@huawei.com> <YheIf4MjkCSrm0XS@unreal>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <28625c88-0daa-65c4-faa0-2ad5fe9d1295@huawei.com>
Date:   Fri, 25 Feb 2022 18:50:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YheIf4MjkCSrm0XS@unreal>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/2/24 21:30, Leon Romanovsky wrote:
>>  #define CMD_POLL_TOKEN 0xffff
>>  #define CMD_MAX_NUM 32
>>  
>> -static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
>> -				     u64 out_param, u32 in_modifier, u8 op,
>> -				     u16 token, int event)
>> +static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev,
>> +				     struct hns_roce_mbox_msg *mbox_msg)
>>  {
>> -	return hr_dev->hw->post_mbox(hr_dev, in_param, out_param, in_modifier,
>> -				     op, token, event);
>> +	return hr_dev->hw->post_mbox(hr_dev, mbox_msg);
>> +}
>> +
>> +static void hns_roce_set_basic_mbox_msg(struct hns_roce_mbox_msg *mbox_msg,
>> +					u64 in_param, u64 out_param, u8 cmd,
>> +					unsigned long tag)
>> +{
>> +	mbox_msg->in_param = in_param;
>> +	mbox_msg->out_param = out_param;
>> +	mbox_msg->cmd = cmd;
>> +	mbox_msg->tag = tag;
>> +}
>> +
>> +static void hns_roce_set_poll_mbox_msg(struct hns_roce_mbox_msg *mbox_msg)
>> +{
>> +	mbox_msg->event_en = 0;
>> +	mbox_msg->token = CMD_POLL_TOKEN;
>> +}
>> +
>> +static void hns_roce_set_event_mbox_msg(struct hns_roce_mbox_msg *mbox_msg,
>> +					struct hns_roce_cmd_context *context)
>> +{
>> +	mbox_msg->event_en = 1;
>> +	mbox_msg->token = context->token;
>>  }
> I don't see too much value in three functions above. They are called exactly once.
> 
> Thanks
> .
> 

Yes, these assignment statements should not constitute a standalone function.
Fix it in v2.

Thanks,
Wenpeng
