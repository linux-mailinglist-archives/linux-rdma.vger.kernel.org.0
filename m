Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBA67350AE
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jun 2023 11:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjFSJpD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jun 2023 05:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSJpC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jun 2023 05:45:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3E683;
        Mon, 19 Jun 2023 02:44:59 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ql4ZC68s2zLmxQ;
        Mon, 19 Jun 2023 17:42:59 +0800 (CST)
Received: from [10.67.102.17] (10.67.102.17) by kwepemi500006.china.huawei.com
 (7.221.188.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Jun
 2023 17:44:55 +0800
Message-ID: <f43bdd44-0f5c-6f48-fed4-6e0baef2d835@hisilicon.com>
Date:   Mon, 19 Jun 2023 17:44:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2 for-next] RDMA/core: Get IB width and speed from netdev
Content-Language: en-US
To:     Mark Zhang <markzhang@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20230603063833.541682-1-huangjunxian6@hisilicon.com>
 <20230611174605.GG12152@unreal>
 <1b11b9e9-a729-0d61-52e3-6bcf132ca356@hisilicon.com>
 <224af610-5bf2-9740-b698-190453c52d69@nvidia.com>
From:   Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <224af610-5bf2-9740-b698-190453c52d69@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.17]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2023/6/19 17:15, Mark Zhang wrote:
> On 6/19/2023 2:20 PM, Junxian Huang wrote:
>>
>>
>> On 2023/6/12 1:46, Leon Romanovsky wrote:
>>> On Sat, Jun 03, 2023 at 02:38:33PM +0800, Junxian Huang wrote:
>>>> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
>>>>
>>>> Previously, there was no way to query the number of lanes for a network
>>>> card, so the same netdev_speed would result in a fixed pair of width and
>>>> speed. As network card specifications become more diverse, such fixed
>>>> mode is no longer suitable, so a method is needed to obtain the correct
>>>> width and speed based on the number of lanes.
>>>
>>> I'm sorry but I didn't understand the problem statement. Can you please
>>> provide an example of configuration that will give different results
>>> before this patch and after?
>>>
>>
>> I'll give examples with 20G and 200G netdevs respectively.
>>
>> 20G:
>> Before this patch, regardless of the actual number of lanes, the width and
>> speed displayed in ibv_devinfo would be always fixed:
>>     active_width: 4X
>>     active_speed: 5 Gbps
>> After this patch, there will be different combinations of width and speed
>> according to the number of lanes. For example, for a 20G netdev whose number
>> of lanes is 2, the width and speed displayed in ibv_devinfo will be:
>>     active_width: 2X
>>     active_speed: 10 Gbps
>>
>> 200G:
>> Before this patch, netdevs with netdev_speed more than 40G cannot get a right
>> width and speed in ibv_devinfo. Only the default result would be displayed:
>>     active_width: 4X
>>     active_speed: 25 Gbps
>> After this patch, taking an example with 4 lanes, the displayed results will be:
>>     active_width: 4X
>>     active_speed: 50 Gbps
> 
> Can we use ib_query_port() instead of __ethtool_get_link_ksettings()?
>   width = attr.active_width;
>   speed = ib_speed_enum_to_int(attr.active_speed) *
>       ib_width_enum_to_int(attr.active_width);
> 
> 

I don't think so. Actually, active_width and active_speed in ib_query_port() are
ultimately derived from ib_get_eth_speed() in many vendors' driver.

Junxian

>>>>
>>>> This patch retrieves netdev lanes and speed from net_device and
>>>> translates them to IB width and speed. Also, add a generic function
>>>> to translating netdev speed to IB speed.
>>>>
>>>> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
>>>> Signed-off-by: Luoyouming <luoyouming@huawei.com>
>>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>>>> ---
>>>>   drivers/infiniband/core/verbs.c | 19 +++++++++++++++++--
>>>>   include/rdma/ib_verbs.h         | 26 ++++++++++++++++++++++++++
>>>>   2 files changed, 43 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
>>>> index b99b3cc283b6..35f1b670600a 100644
>>>> --- a/drivers/infiniband/core/verbs.c
>>>> +++ b/drivers/infiniband/core/verbs.c
>>>> @@ -1880,11 +1880,19 @@ int ib_modify_qp_with_udata(struct ib_qp *ib_qp, struct ib_qp_attr *attr,
>>>>   }
>>>>   EXPORT_SYMBOL(ib_modify_qp_with_udata);
>>>>   +static void ib_get_width_and_speed(u32 netdev_speed, u32 lanes,
>>>> +                   u16 *speed, u8 *width)
>>>> +{
>>>> +    *width = ib_int_to_ib_width(lanes);
>>>> +    *speed = ib_eth_to_ib_speed(netdev_speed / lanes);
>>>> +}
>>>> +
>>>>   int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>>>>   {
>>>>       int rc;
>>>>       u32 netdev_speed;
>>>>       struct net_device *netdev;
>>>> +    bool cap_link_lanes_supported;
>>>>       struct ethtool_link_ksettings lksettings;
>>>>         if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
>>>> @@ -1896,16 +1904,23 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>>>>         rtnl_lock();
>>>>       rc = __ethtool_get_link_ksettings(netdev, &lksettings);
>>>> +    cap_link_lanes_supported = netdev->ethtool_ops->cap_link_lanes_supported;
>>>>       rtnl_unlock();
>>>>         dev_put(netdev);
>>>>         if (!rc && lksettings.base.speed != (u32)SPEED_UNKNOWN) {
>>>>           netdev_speed = lksettings.base.speed;
>>>> +        if (cap_link_lanes_supported && lksettings.lanes) {
>>>
>>> According to the documentation cap_link_lanes_supported defines if
>>> number of lanes can be supplied by user and I would expect from
>>> __ethtool_get_link_ksettings() to get right numbers after it was
>>> changed.
>>>
>>> Thanks
>>>
>>
>> I'm sorry but I didn't quite understand. Do you mean the critical section of
>> rtnl_lock() here should be expanded to make sure getting the right number of
>> lanes?
>>
>> Junxian
>>
>>>> +            ib_get_width_and_speed(netdev_speed, lksettings.lanes,
>>>> +                           speed, width);
>>>> +            return 0;
>>>> +        }
>>>>       } else {
>>>>           netdev_speed = SPEED_1000;
>>>> -        pr_warn("%s speed is unknown, defaulting to %u\n", netdev->name,
>>>> -            netdev_speed);
>>>> +        if (rc)
>>>> +            pr_warn("%s speed is unknown, defaulting to %u\n",
>>>> +                netdev->name, netdev_speed);
>>>>       }
>>>>         if (netdev_speed <= SPEED_1000) {
>>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>>> index 1e7774ac808f..7dc926ec7fee 100644
>>>> --- a/include/rdma/ib_verbs.h
>>>> +++ b/include/rdma/ib_verbs.h
>>>> @@ -552,6 +552,18 @@ static inline int ib_width_enum_to_int(enum ib_port_width width)
>>>>       }
>>>>   }
>>>>   +static inline int ib_int_to_ib_width(u32 lanes)
>>>> +{
>>>> +    switch (lanes) {
>>>> +    case 1: return IB_WIDTH_1X;
>>>> +    case 2: return IB_WIDTH_2X;
>>>> +    case 4: return IB_WIDTH_4X;
>>>> +    case 8: return IB_WIDTH_8X;
>>>> +    case 12: return IB_WIDTH_12X;
>>>> +    default: return IB_WIDTH_1X;
>>>> +    }
>>>> +}
>>>> +
>>>>   enum ib_port_speed {
>>>>       IB_SPEED_SDR    = 1,
>>>>       IB_SPEED_DDR    = 2,
>>>> @@ -563,6 +575,20 @@ enum ib_port_speed {
>>>>       IB_SPEED_NDR    = 128,
>>>>   };
>>>>   +static inline int ib_eth_to_ib_speed(u32 speed)
>>>> +{
>>>> +    switch (speed) {
>>>> +    case SPEED_2500: return IB_SPEED_SDR;
>>>> +    case SPEED_5000: return IB_SPEED_DDR;
>>>> +    case SPEED_10000: return IB_SPEED_FDR10;
>>>> +    case SPEED_14000: return IB_SPEED_FDR;
>>>> +    case SPEED_25000: return IB_SPEED_EDR;
>>>> +    case SPEED_50000: return IB_SPEED_HDR;
>>>> +    case SPEED_100000: return IB_SPEED_NDR;
>>>> +    default: return IB_SPEED_SDR;
>>>> +    }
>>>> +}
>>>> +
>>>>   enum ib_stat_flag {
>>>>       IB_STAT_FLAG_OPTIONAL = 1 << 0,
>>>>   };
>>>> -- 
>>>> 2.30.0
>>>>
> 
