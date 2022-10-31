Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506A46131A4
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 09:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJaIXU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 04:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJaIXT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 04:23:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF657B4BE
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 01:23:17 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N15fm1hVbzpVyh;
        Mon, 31 Oct 2022 16:19:44 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 16:23:15 +0800
Received: from [10.67.103.121] (10.67.103.121) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 16:23:14 +0800
Subject: Re: [PATCH v2 for-rc 3/5] RDMA/hns: Remove enable rq inline in kernel
 and add compatibility handling
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <20221026095054.2384620-1-xuhaoyue1@hisilicon.com>
 <20221026095054.2384620-4-xuhaoyue1@hisilicon.com>
 <Y1wF68CgChG+hM87@nvidia.com>
From:   "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Message-ID: <9b50dae1-e448-047b-8a54-489ff120f00c@hisilicon.com>
Date:   Mon, 31 Oct 2022 16:23:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y1wF68CgChG+hM87@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.121]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This bit is used to prevent compatibility issues in the old kernel. It is not for compatibility with userspace.
It should be a bugfix. I will separate this into a new bugfix patch.
I will change the name to __HNS_ROCE_CAP_FLAG_RQ_INLINE in V3.

On 2022/10/29 0:40:11, Jason Gunthorpe wrote:
> On Wed, Oct 26, 2022 at 05:50:52PM +0800, Haoyue Xu wrote:
>> From: Luoyouming <luoyouming@huawei.com>
>>
>> The rq inline makes some changes as follows, Firstly, it is only
>> used in user space. Secondly, it should notify hardware in QP RTR
>> status. Thirdly, Add compatibility processing between different
>> user space and kernel space. Change the HNS_ROCE_CAP_FLAG_RQ_INLINE
>> to a new bit to prevent old kernel spaces / spaced from enabling
>> rq inline.
>>
>> Signed-off-by: Luoyouming <luoyouming@huawei.com>
>> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 +++--
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 28 +++++++++++++--------
>>  drivers/infiniband/hw/hns/hns_roce_main.c   |  5 ++++
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  2 +-
>>  include/uapi/rdma/hns-abi.h                 |  2 ++
>>  5 files changed, 30 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index f701cc86896b..9ce053fe737d 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -132,7 +132,8 @@ enum hns_roce_event {
>>  enum {
>>  	HNS_ROCE_CAP_FLAG_REREG_MR		= BIT(0),
>>  	HNS_ROCE_CAP_FLAG_ROCE_V1_V2		= BIT(1),
>> -	HNS_ROCE_CAP_FLAG_RQ_INLINE		= BIT(2),
>> +	/* discard this bit, reserved for compatibility */
>> +	HNS_ROCE_CAP_FLAG_DISCARD		= BIT(2),
> 
> If it is for compatability with userspace why is this enum not under
> include/uapi? Something has gone wrong here, please fix it.
> 
> Also, it is better to name this __HNS_ROCE_CAP_FLAG_RQ_INLINE to
> indicate it is not used instead of 'discard'
> 
> Jason
> .
> 
