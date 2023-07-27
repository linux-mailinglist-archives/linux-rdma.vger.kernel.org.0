Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7280764987
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjG0H45 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 03:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjG0H4X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 03:56:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4190122;
        Thu, 27 Jul 2023 00:53:56 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RBNGv5Hd1zNmXN;
        Thu, 27 Jul 2023 15:50:31 +0800 (CST)
Received: from [10.67.102.17] (10.67.102.17) by kwepemi500006.china.huawei.com
 (7.221.188.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 15:53:54 +0800
Message-ID: <f5d61a2b-ed36-1048-4ea9-e789550232d9@hisilicon.com>
Date:   Thu, 27 Jul 2023 15:53:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v4 for-next] RDMA/core: Get IB width and speed from netdev
To:     Leon Romanovsky <leon@kernel.org>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20230721092052.2090449-1-huangjunxian6@hisilicon.com>
 <20230724111938.GB9776@unreal>
 <01d762f7-6388-9539-68ee-5425b4d56e58@hisilicon.com>
 <20230727065820.GZ11388@unreal>
Content-Language: en-US
From:   Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20230727065820.GZ11388@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.17]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2023/7/27 14:58, Leon Romanovsky wrote:
> On Thu, Jul 27, 2023 at 11:44:50AM +0800, Junxian Huang wrote:
>>
>>
>> On 2023/7/24 19:19, Leon Romanovsky wrote:
>>> On Fri, Jul 21, 2023 at 05:20:52PM +0800, Junxian Huang wrote:
>>>> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
>>>>
>>>> Previously, there was no way to query the number of lanes for a network
>>>> card, so the same netdev_speed would result in a fixed pair of width and
>>>> speed. As network card specifications become more diverse, such fixed
>>>> mode is no longer suitable, so a method is needed to obtain the correct
>>>> width and speed based on the number of lanes.
>>>>
>>>> This patch retrieves netdev lanes and speed from net_device and
>>>> translates them to IB width and speed.
>>>>
>>>> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
>>>> Signed-off-by: Luoyouming <luoyouming@huawei.com>
>>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>>>> ---
>>>>  drivers/infiniband/core/verbs.c | 100 +++++++++++++++++++++++++-------
>>>>  1 file changed, 79 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
>>>> index b99b3cc283b6..25367bd6dd97 100644
>>>> --- a/drivers/infiniband/core/verbs.c
>>>> +++ b/drivers/infiniband/core/verbs.c
>>>> @@ -1880,6 +1880,80 @@ int ib_modify_qp_with_udata(struct ib_qp *ib_qp, struct ib_qp_attr *attr,
>>>>  }
>>>>  EXPORT_SYMBOL(ib_modify_qp_with_udata);
>>>>  
>>>> +static void ib_get_width_and_speed(u32 netdev_speed, u32 lanes,
>>>> +				   u16 *speed, u8 *width)
>>>
>>> <...>
>>>
>>>> +	switch (netdev_speed / lanes) {
>>>> +	case SPEED_2500:
>>>> +		*speed = IB_SPEED_SDR;
>>>> +		break;
>>>> +	case SPEED_5000:
>>>> +		*speed = IB_SPEED_DDR;
>>>> +		break;
>>>> +	case SPEED_10000:
>>>> +		*speed = IB_SPEED_FDR10;
>>>> +		break;
>>>> +	case SPEED_14000:
>>>> +		*speed = IB_SPEED_FDR;
>>>> +		break;
>>>> +	case SPEED_25000:
>>>> +		*speed = IB_SPEED_EDR;
>>>> +		break;
>>>> +	case SPEED_50000:
>>>> +		*speed = IB_SPEED_HDR;
>>>> +		break;
>>>> +	case SPEED_100000:
>>>> +		*speed = IB_SPEED_NDR;
>>>> +		break;
>>>> +	default:
>>>> +		*speed = IB_SPEED_SDR;
>>>> +	}
>>>
>>> How did you come to these translation values?
>>>
>>> Thanks
>>
>> The IB spec defines the mapping relationship between IB speed and transfer
>> rate. For example, if the transfer rate of is 2.5Gbps(SPEED_2500), the IB
>> speed will be set to IB_SPEED_SDR.
> 
> Are you referring to "Table 250 - Enumeration of the Rate"?
> 
> Thanks
> 
>>
>> Junxian

Yes.

Junxian
