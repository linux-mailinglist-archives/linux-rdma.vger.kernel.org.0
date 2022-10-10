Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818E15F9BB1
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Oct 2022 11:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiJJJNI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Oct 2022 05:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiJJJNE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Oct 2022 05:13:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031BD696CC
        for <linux-rdma@vger.kernel.org>; Mon, 10 Oct 2022 02:12:58 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MmCmB6v5nzpVjW;
        Mon, 10 Oct 2022 17:09:46 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 17:12:55 +0800
Subject: Re: [PATCH] nvme-rdma: set ack timeout of RoCE to 262ms
From:   Chao Leng <lengchao@huawei.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220819075825.21231-1-lengchao@huawei.com>
 <20220821062016.GA26553@lst.de>
 <83992e8f-b18a-ccd3-e0ee-a5802043f161@huawei.com>
 <86e9fc3b-aded-220d-1ee0-4d5928097104@nvidia.com>
 <f7254cc2-88e0-e91f-e4f1-788c5889fcf1@huawei.com>
 <fbee7c67-fd7b-12c8-5685-066b1974aadb@grimberg.me>
 <550d4612-0041-3d84-b1cb-786d0c8e0d11@huawei.com>
 <3030fbb2-5c63-54ea-5be3-b88cf63c6b75@grimberg.me>
 <c86a6cea-09b5-c04c-aa7b-adc6a457acf6@huawei.com>
Message-ID: <328a807f-bfaf-b279-69c5-09be179891ac@huawei.com>
Date:   Mon, 10 Oct 2022 17:12:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <c86a6cea-09b5-c04c-aa7b-adc6a457acf6@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Max
     Can you give some comment? Thank you.

On 2022/8/29 21:15, Chao Leng wrote:
> 
> 
> On 2022/8/29 17:06, Sagi Grimberg wrote:
>>
>>>>>> If so, which devices did you use ?
>>>>> The host HBA is Mellanox Technologies MT27800 Family [ConnectX-5];
>>>>> The switch and storage are huawei equipments.
>>>>> In principle, switches and storage devices from other vendors
>>>>> have the same problem.
>>>>> If you think it is necessary, we can test the other vendor switchs
>>>>> and linux target.
>>>>
>>>> Why is the 2s default chosen, what is the downside for a 250ms seconds ack timeout? and why is nvme-rdma different than all other kernel rdma
>>> The downside is redundant retransmit if the packets delay more than
>>> 250ms in the networks and finally reaches the receiver.
>>> Only in extreme scenarios, the packet delay may exceed 250 ms.
>>
>> Sounds like the default needs to be changed if it only addresses the
>> extreme scenarios...
>>
>>>> consumers that it needs to set this explicitly?
>>> The real-time transaction services are sensitive to the delay.
>>> nvme-rdma will be used in real-time transactions.
>>> The real-time transaction services do not allow that the packets
>>> delay more than 250ms in the networks.
>>> So we need to set the ack timeout to 262ms.
>>
>> While I don't disagree with the change itself, I do disagree why this
>> needs to be driven by nvme-rdma locally. If all kernel rdma consumers
>> need this (and if not, I'd like to understand why), this needs to be set in the rdma core.Changing the default set in the rdma core is another option.
> But it will affect all application based on RDMA.
> Max, what do you think? Thank you.
>> .
> 
> .
