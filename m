Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ADE4D11DA
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 09:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbiCHIOf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 03:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245723AbiCHIOe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 03:14:34 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838152FFED
        for <linux-rdma@vger.kernel.org>; Tue,  8 Mar 2022 00:13:37 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KCSdX1h23zbc4J;
        Tue,  8 Mar 2022 16:08:48 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 16:13:35 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Mar
 2022 16:13:35 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Use the reserved loopback QPs to free
 MR before destroying MPT
To:     Leon Romanovsky <leon@kernel.org>
References: <20220225095654.24684-1-liangwenpeng@huawei.com>
 <Yhy5fZrsp79HZKR+@unreal> <0c14fac1-9448-7920-52fd-f353a8e7590f@huawei.com>
 <YiEBlG5ndcbww8u2@unreal>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <5cbda3e1-c4d1-4e09-a529-eb66d13f23ac@huawei.com>
Date:   Tue, 8 Mar 2022 16:13:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YiEBlG5ndcbww8u2@unreal>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2022/3/4 1:57, Leon Romanovsky wrote:
> On Wed, Mar 02, 2022 at 08:44:48PM +0800, Wenpeng Liang wrote:
>> On 2022/2/28 20:01, Leon Romanovsky wrote:
>>> On Fri, Feb 25, 2022 at 05:56:54PM +0800, Wenpeng Liang wrote:
>>>> From: Yixing Liu <liuyixing1@huawei.com>
>>>>
>>>> Before destroying MPT, the reserved loopback QPs send loopback IOs (one
>>>> write operation per SL). Completing these loopback IOs represents that
>>>> there isn't any outstanding request in MPT, then it's safe to destroy MPT.
>>>>
>>>> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
>>>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>>>> ---
>>>>  drivers/infiniband/hw/hns/hns_roce_device.h |   2 +
>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 334 +++++++++++++++++++-
>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  20 ++
>>>>  drivers/infiniband/hw/hns/hns_roce_mr.c     |   6 +-
>>>>  4 files changed, 358 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>>>> index 1e0bae136997..da0b4b310aab 100644
>>>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>>>> @@ -624,6 +624,7 @@ struct hns_roce_qp {
>>>>  	u32			next_sge;
>>>>  	enum ib_mtu		path_mtu;
>>>>  	u32			max_inline_data;
>>>> +	u8			free_mr_en;
>>>>  
>>>>  	/* 0: flush needed, 1: unneeded */
>>>>  	unsigned long		flush_flag;
>>>> @@ -882,6 +883,7 @@ struct hns_roce_hw {
>>>>  			 enum ib_qp_state new_state);
>>>>  	int (*qp_flow_control_init)(struct hns_roce_dev *hr_dev,
>>>>  			 struct hns_roce_qp *hr_qp);
>>>> +	void (*dereg_mr)(struct hns_roce_dev *hr_dev);
>>>>  	int (*init_eq)(struct hns_roce_dev *hr_dev);
>>>>  	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
>>>>  	int (*write_srqc)(struct hns_roce_srq *srq, void *mb_buf);
>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> index b33e948fd060..62ee9c0bba74 100644
>>>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> @@ -2664,6 +2664,217 @@ static void free_dip_list(struct hns_roce_dev *hr_dev)
>>>>  	spin_unlock_irqrestore(&hr_dev->dip_list_lock, flags);
>>>>  }
>>>>  
>>>> +static int free_mr_alloc_pd(struct hns_roce_dev *hr_dev,
>>>> +			    struct hns_roce_v2_free_mr *free_mr)
>>>> +{
>>>
>>> You chose very non-intuitive name "free_mr...", but I don't have anything
>>> concrete to suggest.
>>>
>>
>> Thank you for your advice. There are two alternative names for this event,
>> which are DRAIN_RESIDUAL_WR or DRAIN_WR. It is hard to decide which one is
>> better. Could you give me some suggestions for the naming?
> 
> mlx5 called to such objects device resource - devr, see mlx5_ib_dev_res_init().
> I personally would create something similar to that, one function
> without separation to multiple free_mr_alloc_* functions.
> 
> Up-to you.
> 

Thank you for your suggestion.
I will put the creation of resources in one function.

Thanks,
Wenpeng

> Thanks
> .
> 
