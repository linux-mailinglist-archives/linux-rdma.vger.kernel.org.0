Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE5734F68
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jun 2023 11:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjFSJQM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jun 2023 05:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjFSJQA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jun 2023 05:16:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5638ADA;
        Mon, 19 Jun 2023 02:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPKwZD5ZnIrehfaaXkELh0OeGGdhQ3EB7CPSVqyywHRu0qNg4FTpvarScglsi01nMhFRGVMWAe/CuHJX1r/9d5sLjujka76iA/sUTe8hmnwwF34MzOAQzsBparMso6nEC3wf+fT4kgGV38B4VyutJxNIdwvRplafDOYHntfXnNupLwlwmQyHsYOMC/nKvDKZ9AU3yvxAzAGGRq+PiT6b+W6wXFnDqdgF2kDhapwJ6z3OkABMTYi9+RqmikcAL482TQxSRfy8iU9RIj1eF7kOpxTCDhvP8Y2zb64GXzJkl/fow73vytSGB+0legGrizvjeE5jFuGpgSVXrzeuxm88gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY526kvKVuMvnjuPjmjEk28OKsx8ZkH0zTbtVLgJomE=;
 b=bbWlFCoXK2DjSFnrCxGKVANjXyYfSDlDQFyaVwuFoOIqXlFUT/2Cy7UHT9KauoskkVxNSWAV06VR/FIuo06dHQOBNKvZSN/LGH//u+2b3dJCJmfl++GPrbegJnF/rznZ00+MvmrVg33/ntfJddJXCUKs18HhYY6T6Wg+Hk6sM0XYhdzvCLRu+WdHkpWCUBvIPMpZSe/VwJnmvyvkvxfYvEbJE1LVAm2N2dQn/r8svRROu8dUpwhCs8DLe8D4vhUaLDsXz3QupRmDNLznJn2XmaUnmtEVurQ+UYRLywPTi+mIBptw7K34GYZDfUoLXTp/ih22NEerVlpPxM9EVcKkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY526kvKVuMvnjuPjmjEk28OKsx8ZkH0zTbtVLgJomE=;
 b=o6Pwkxp1FXoVKQjmbEuI1sgszMs6mR+ZqSt6Q21yAsphu9jDQNCOnXEL2z0WA3Gt5R4EIItA0iVG4sr3w7bq2s0cfgtCRMxjPn/IsicuPMbxBuCaMy8zeb1+e+pBABPuKswLCUlKPHXejdUAetpYc188LxEMbh1rCDyGNZ2XvN3BUQKbu97oil1NInfxL494H/nthvgP/NwgP2qfwRg9/FUzLeafrLbcoUc1DPdKzzbvLSt8HlCuHaPIdeDXWMckoNnq2NM9cQU1c91tgCy53wPHeD6rzavB20ve12ckjjs68l3annNNjG/vHzmsuqZQ8htarJ61aApZ/oy/Ta3fUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MWHPR12MB1373.namprd12.prod.outlook.com (2603:10b6:300:14::19)
 by BN9PR12MB5366.namprd12.prod.outlook.com (2603:10b6:408:103::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 09:15:56 +0000
Received: from MWHPR12MB1373.namprd12.prod.outlook.com
 ([fe80::8597:ad16:27bf:a10c]) by MWHPR12MB1373.namprd12.prod.outlook.com
 ([fe80::8597:ad16:27bf:a10c%12]) with mapi id 15.20.6500.036; Mon, 19 Jun
 2023 09:15:56 +0000
Message-ID: <224af610-5bf2-9740-b698-190453c52d69@nvidia.com>
Date:   Mon, 19 Jun 2023 17:15:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 for-next] RDMA/core: Get IB width and speed from netdev
To:     Junxian Huang <huangjunxian6@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
References: <20230603063833.541682-1-huangjunxian6@hisilicon.com>
 <20230611174605.GG12152@unreal>
 <1b11b9e9-a729-0d61-52e3-6bcf132ca356@hisilicon.com>
Content-Language: en-US
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <1b11b9e9-a729-0d61-52e3-6bcf132ca356@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:820:c::9) To MWHPR12MB1373.namprd12.prod.outlook.com
 (2603:10b6:300:14::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR12MB1373:EE_|BN9PR12MB5366:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c5820f0-606e-4415-c614-08db70a5c926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +PfHTuPBbvn9rC8XRXZvA9O6H3nuHLWGVnqe/mWax7sl3a1uG5F+ARDsAkgPxClfXLp8Nu0889/rFkw2CU2iD1+CezpD4CCNJlzOMJ/YfoGhKVLn5+0IX6WYs13knm/KPDhVkwp9c38xijzKMG7SPjvbHXnaCQi/Fax9iiMb59n/YS6+36AB44a2PqlSKSfr//B0K06mqSYNmtjCj9nG7Fe2u3jLlHBXXzG6GfVJO5QJVQicGrAV3EUVHqaLIpzyzYMCmjKbcrfE4R8y+ugRJSjH6ZNK6EmZWe1uidyPCwM8p+XcC5W3QFvY2iZqt65ZuV1yKoRoY26vlEs2FB0rq1EXVlNiPHLviSS+w4HAsQeJ8vcljT0oYXwGsCsXTl5pdb5u6BTLO6m+DXL6O2lbVXA4CbXycfRt65r8wi4+uAHC6X1HsxeKc+oqGmmGYIcCg24f4FMIUc+HFTtn+r40liA5Vg0hVpEPXq4qjoHEQNiCVcePHl4LtKyx9fOjJ6E37btFv8NUGz8/qsE7BwKrdxDWqZGnNMjMXfpg/nG1KEGpUewG/BSuVSqK8ZuITaS+kFapi3ue0fvCs210Sda0NfDYeWMc1BzQ2q/s7Ijz2A7WA8DktxnDK2PsGYNREFw/b73eVGMiwHOYbaxTGbTHrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(186003)(110136005)(6486002)(6666004)(31696002)(86362001)(26005)(6506007)(6512007)(53546011)(478600001)(2616005)(31686004)(38100700002)(316002)(83380400001)(66946007)(66556008)(66476007)(4326008)(41300700001)(5660300002)(2906002)(36756003)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmNqMGtGSjNuaTJ3UFlLZHZpd0pRZ0hYejFvS1I0d0d5RStWeEFNZU5JSFV2?=
 =?utf-8?B?OXVwZzFLcUlhb1RranpLRElER2pDV1IxYmtVZmxHVGR1OThMbU9STHoxdTNG?=
 =?utf-8?B?Nkg5LzBWeENRZnRwQ3NIVTh1QVBWd3VBSzMwVUJqNWJMQlZLK2h3TlZ0WFdy?=
 =?utf-8?B?bUhPQkJVOThHalpzTkJWamRXUFB2cTFvRk9ZQW5vR0JQMWlIZit3enBKbXJS?=
 =?utf-8?B?VEl0OElQRklyWmdYcGIwekpzZUkyWm84cHlpU3h4MDgrOXNqQ2pYaWJUeXZV?=
 =?utf-8?B?UEI1NEhZa21TMVgrU0pXRUZTU3BadkM3ams0SFJzZWwzRDJjR25EdGhOZ0sz?=
 =?utf-8?B?eE1kYnZhY3dVWFpuK0dScXF6cFEyTkZKR1RCb1lWK2NUY01QNUlKWVR3Y0hm?=
 =?utf-8?B?c29qR0RRRDhkT1NycjZqMjVUbmhlM0FQZ0pBeEZCTWxzN2tOc094TUZSVkhS?=
 =?utf-8?B?OEZHaDBQci9uTE56TVQrbE42MnV6WjZNcHMvNGFCNHRKdG02ZXlYQnE0MEI4?=
 =?utf-8?B?c1QxQUx4TE94RVZ4Yk9OZm9wTEh5bkJTMWhQai9xUFFmTjl3bjBrMEMzK2lR?=
 =?utf-8?B?MVJNbTQvbkg2a1ladFRpTFVnYml3bHhOMXdianNweERKOFkzT3U1RnhwSWsr?=
 =?utf-8?B?RGppTHlyZ2t5clhiY3pxb3FidG1MbFdEYTMwMi9nMlhhYXFQK2xPbm0zZUtC?=
 =?utf-8?B?MDhma3FwYm9PUDBRSitTRGl2NVJTR3ViZG1RVFVzdStGYVpzZ0pzRDVFUE1l?=
 =?utf-8?B?K1gwaG5VM1Fwc0NZYjhiOEZncE5GcldCMkR2eXpTRm5nOFI1aWFQU1Z5Snpl?=
 =?utf-8?B?WWFtMjZpdDlXVU9yb3JKQkhWUENJTXI3bTZBVFRlQk8wQnQ1WldoVTFFTUUv?=
 =?utf-8?B?ZmRPbGRuOUEzYldJcENxSnY5WHFFeFd1aTdPRDJ4YjVraWlHNXJhVlcwS0JT?=
 =?utf-8?B?TC9LSzVPYzRycllJOEgvUGp0eVVHdXFnWXMzWS9HaUJQaGFiazhlV0NRUTd4?=
 =?utf-8?B?cWowcG1PN0dVOTFFVlh6TENSNHVCV3pkeDc1SFloNVZ2a0d5ZHRmWitzNXhl?=
 =?utf-8?B?TTlseTRaTlRpYnNxcUZjMDlMR0YyS1d0MkJkc0JZZlExaFpYWXEvcnhIMktV?=
 =?utf-8?B?cG12Rk5mVVBMREFPaXRhSk5xOG9ZclYxMHpmZXEyNi9DbVV4L2V2TjQ5Q1ln?=
 =?utf-8?B?amF0dFl4bHo3Y3hZbEVCSFFvQjl4Q1owUCtZbjE0eEwyeVF6dHAxSVJlUDRW?=
 =?utf-8?B?WVEyU0NXWU9GZ2VQR1N5a0tLR2VNaDdlYlZybm1XbGMzLzB0SjlvMmxnajNw?=
 =?utf-8?B?NzMvUjhsc3luQjFLOUE3UXlPOFh5NmJDckVIL3RKV09FMjNyRGJ4QkJrSkoy?=
 =?utf-8?B?eUhhYTdRR011T0NhRmZERzNGYUFFM3QvM1AvWXVxclJsSU9Kc215ZVliZGl4?=
 =?utf-8?B?b0NROFNJeDlKS3F5YmZza005bS9laXpvZjRFaHpjQlo1ck1yK3JHb3RHZS91?=
 =?utf-8?B?TU1WVkMzR3Jvb0FsSWlUeFdpUVRkeE5UNnZOdHRLeGhVcEFnc25hUThmaDNV?=
 =?utf-8?B?SGNPb2thVjdlRkpxNHVaa0Nyd3ByQllYWCtockxTaG1KMm1HR0NnVzFHWnRT?=
 =?utf-8?B?bUdFOWRjZklDcnRIVmU3RkN0TUlBbEN0SmZSSm04Q2cvR0ZDemw5eGhOTncx?=
 =?utf-8?B?Rk4zVXZXUmszUjNEZ2ZoanJ1eVFiYy9tc0hVL3R5UVZNZWZDdWw0UTJSWlZQ?=
 =?utf-8?B?WUJoWXZ2OGpscHp0aWpoUWZWeVdWRmxZaFR3cmVSRzZZN0dlSHZGTHp6UGty?=
 =?utf-8?B?cXp6bVpOeDJUdzJzV0JEZzJ1NmVKWXYvSlErbXVVVW5veUVyRnVuVzNqWkdN?=
 =?utf-8?B?ejU5VitqTmhyYTd3SzcwcTlsV0kvMUQ1UzZnZkpNcjNIMWNadHpsNDZWSVZX?=
 =?utf-8?B?QXBHMVRGVGV1U2lHc0tIZnhWWW9BaGlhME1QS2h3aHFnUmsxKzNxQzVTNkhO?=
 =?utf-8?B?WldGNjhXZk1WaWhqZlJ6TWZTOEt0TFRabThydW9KN2VJZm9TUzViSk5lbGtU?=
 =?utf-8?B?Z2hOTkxZWHhPOW9lZ3VLc3JqejNCZUZ2VlUyU1Y0akcrVnJCRjVxMXYrcW5s?=
 =?utf-8?Q?pX87Ojch0w5abYp9iAPf+yKlK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5820f0-606e-4415-c614-08db70a5c926
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 09:15:55.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7qzW/RTKwJKdvnDlg9E70jO4I2B/TqIr6st9BuPC8h4KG5duNb9/6DYOVm01jZY7n7FXkBob+u5oAUsQmbvWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5366
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/19/2023 2:20 PM, Junxian Huang wrote:
> 
> 
> On 2023/6/12 1:46, Leon Romanovsky wrote:
>> On Sat, Jun 03, 2023 at 02:38:33PM +0800, Junxian Huang wrote:
>>> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
>>>
>>> Previously, there was no way to query the number of lanes for a network
>>> card, so the same netdev_speed would result in a fixed pair of width and
>>> speed. As network card specifications become more diverse, such fixed
>>> mode is no longer suitable, so a method is needed to obtain the correct
>>> width and speed based on the number of lanes.
>>
>> I'm sorry but I didn't understand the problem statement. Can you please
>> provide an example of configuration that will give different results
>> before this patch and after?
>>
> 
> I'll give examples with 20G and 200G netdevs respectively.
> 
> 20G:
> Before this patch, regardless of the actual number of lanes, the width and
> speed displayed in ibv_devinfo would be always fixed:
> 	active_width: 4X
> 	active_speed: 5 Gbps
> After this patch, there will be different combinations of width and speed
> according to the number of lanes. For example, for a 20G netdev whose number
> of lanes is 2, the width and speed displayed in ibv_devinfo will be:
> 	active_width: 2X
> 	active_speed: 10 Gbps
> 
> 200G:
> Before this patch, netdevs with netdev_speed more than 40G cannot get a right
> width and speed in ibv_devinfo. Only the default result would be displayed:
> 	active_width: 4X
> 	active_speed: 25 Gbps
> After this patch, taking an example with 4 lanes, the displayed results will be:
> 	active_width: 4X
> 	active_speed: 50 Gbps

Can we use ib_query_port() instead of __ethtool_get_link_ksettings()?
   width = attr.active_width;
   speed = ib_speed_enum_to_int(attr.active_speed) *
	  ib_width_enum_to_int(attr.active_width);


>>>
>>> This patch retrieves netdev lanes and speed from net_device and
>>> translates them to IB width and speed. Also, add a generic function
>>> to translating netdev speed to IB speed.
>>>
>>> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
>>> Signed-off-by: Luoyouming <luoyouming@huawei.com>
>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>>> ---
>>>   drivers/infiniband/core/verbs.c | 19 +++++++++++++++++--
>>>   include/rdma/ib_verbs.h         | 26 ++++++++++++++++++++++++++
>>>   2 files changed, 43 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
>>> index b99b3cc283b6..35f1b670600a 100644
>>> --- a/drivers/infiniband/core/verbs.c
>>> +++ b/drivers/infiniband/core/verbs.c
>>> @@ -1880,11 +1880,19 @@ int ib_modify_qp_with_udata(struct ib_qp *ib_qp, struct ib_qp_attr *attr,
>>>   }
>>>   EXPORT_SYMBOL(ib_modify_qp_with_udata);
>>>   
>>> +static void ib_get_width_and_speed(u32 netdev_speed, u32 lanes,
>>> +				   u16 *speed, u8 *width)
>>> +{
>>> +	*width = ib_int_to_ib_width(lanes);
>>> +	*speed = ib_eth_to_ib_speed(netdev_speed / lanes);
>>> +}
>>> +
>>>   int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>>>   {
>>>   	int rc;
>>>   	u32 netdev_speed;
>>>   	struct net_device *netdev;
>>> +	bool cap_link_lanes_supported;
>>>   	struct ethtool_link_ksettings lksettings;
>>>   
>>>   	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
>>> @@ -1896,16 +1904,23 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>>>   
>>>   	rtnl_lock();
>>>   	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
>>> +	cap_link_lanes_supported = netdev->ethtool_ops->cap_link_lanes_supported;
>>>   	rtnl_unlock();
>>>   
>>>   	dev_put(netdev);
>>>   
>>>   	if (!rc && lksettings.base.speed != (u32)SPEED_UNKNOWN) {
>>>   		netdev_speed = lksettings.base.speed;
>>> +		if (cap_link_lanes_supported && lksettings.lanes) {
>>
>> According to the documentation cap_link_lanes_supported defines if
>> number of lanes can be supplied by user and I would expect from
>> __ethtool_get_link_ksettings() to get right numbers after it was
>> changed.
>>
>> Thanks
>>
> 
> I'm sorry but I didn't quite understand. Do you mean the critical section of
> rtnl_lock() here should be expanded to make sure getting the right number of
> lanes?
> 
> Junxian
> 
>>> +			ib_get_width_and_speed(netdev_speed, lksettings.lanes,
>>> +					       speed, width);
>>> +			return 0;
>>> +		}
>>>   	} else {
>>>   		netdev_speed = SPEED_1000;
>>> -		pr_warn("%s speed is unknown, defaulting to %u\n", netdev->name,
>>> -			netdev_speed);
>>> +		if (rc)
>>> +			pr_warn("%s speed is unknown, defaulting to %u\n",
>>> +				netdev->name, netdev_speed);
>>>   	}
>>>   
>>>   	if (netdev_speed <= SPEED_1000) {
>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>> index 1e7774ac808f..7dc926ec7fee 100644
>>> --- a/include/rdma/ib_verbs.h
>>> +++ b/include/rdma/ib_verbs.h
>>> @@ -552,6 +552,18 @@ static inline int ib_width_enum_to_int(enum ib_port_width width)
>>>   	}
>>>   }
>>>   
>>> +static inline int ib_int_to_ib_width(u32 lanes)
>>> +{
>>> +	switch (lanes) {
>>> +	case 1: return IB_WIDTH_1X;
>>> +	case 2: return IB_WIDTH_2X;
>>> +	case 4: return IB_WIDTH_4X;
>>> +	case 8: return IB_WIDTH_8X;
>>> +	case 12: return IB_WIDTH_12X;
>>> +	default: return IB_WIDTH_1X;
>>> +	}
>>> +}
>>> +
>>>   enum ib_port_speed {
>>>   	IB_SPEED_SDR	= 1,
>>>   	IB_SPEED_DDR	= 2,
>>> @@ -563,6 +575,20 @@ enum ib_port_speed {
>>>   	IB_SPEED_NDR	= 128,
>>>   };
>>>   
>>> +static inline int ib_eth_to_ib_speed(u32 speed)
>>> +{
>>> +	switch (speed) {
>>> +	case SPEED_2500: return IB_SPEED_SDR;
>>> +	case SPEED_5000: return IB_SPEED_DDR;
>>> +	case SPEED_10000: return IB_SPEED_FDR10;
>>> +	case SPEED_14000: return IB_SPEED_FDR;
>>> +	case SPEED_25000: return IB_SPEED_EDR;
>>> +	case SPEED_50000: return IB_SPEED_HDR;
>>> +	case SPEED_100000: return IB_SPEED_NDR;
>>> +	default: return IB_SPEED_SDR;
>>> +	}
>>> +}
>>> +
>>>   enum ib_stat_flag {
>>>   	IB_STAT_FLAG_OPTIONAL = 1 << 0,
>>>   };
>>> -- 
>>> 2.30.0
>>>

