Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD59477A580
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 10:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjHMIC7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 04:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHMIC7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 04:02:59 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0267D170C;
        Sun, 13 Aug 2023 01:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/yHJUm0j0ixjLClpdw7aL2v/B8tKAnSEOnZYyHZxKSf0cPiqAzzkmnbQ/syJeXXa3uW6ggzoaQiHfLVRpI6SYCZpgM6Ans61TcFKCv/Jl2i2nXs2+a4YmnBc3M33sqsnWvAhVhB9uCi7aNe/1FxVkzzlsjWQ41MI5WdO5E+m50cS+6s8VOfWfX+0HDLcwgSvYr4VvCO3ErbA7zZ5hRmiWXY8MjiWUg8BNMQIyykUhygDQ3fCgqY63I31lZc++e5rW30zDPXgK/B8uIjry5KizocbghLpvHxB6/A1W1DbH3AyzPXn1ftRinnYQqVzBAT+Y3UeHMwrEXyAbUS479tbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjWmYOeYVNMiVR1JGIh4AhX7lTxQe8lGXiknCe7Dg9I=;
 b=YZO7bw+OhTFCFXkxtslu5jtrWoZ8Ji7FRn8SINPqayGtErP6L06H1ffXiU6k38LlQRdJDKvjSlsSI72FpLFGHI9Azc31GN5oPlzkeLIADEIGUT/MI6qZAtAFv5H52ETqhJbZLx8LjLlcKeOJNz3uq2I8onTYRcN7lmEKsKaXPCIFBSgBd6owbUEPBIKQjJprK/XAnHzUBwUXeXfqyAcEqi8GjvqprfhOowS0lOpoUpMo27eqUODbcVI178/wEeotHCbg67svd62ZcMymrcWlydUjt0kQQg/NuvwE5wqK8eCSWtA/TxuenipXRduWfkJrHxzIUAP2WJAuC4SO93lAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjWmYOeYVNMiVR1JGIh4AhX7lTxQe8lGXiknCe7Dg9I=;
 b=hFpvLwAplCjHakkgqyU4NDWaI2QBBcWyHSe8UnafHL1PH5sXVqhfRqoQA0EhIJZCehqzA6fwKqUtNFg6Y/ODvT34lztOzAYiJ8XyOudZOambBruu6aNmmIpcfqYqEzPGaBPxFY83oABgfWRh3f6UyjMakY97bcLIamFH7hjRXir7wCMGQVYKQP7IVd0LyxZnB0SzchZXSqziV/eSSAXRWo2ZfA4oUTtteMtVTgJS0a2AfBk8cVraYklfhU0BTr/WqKV2IQIqHzjVKbTG1mhyAkdPm/ec94oFlHu5ZyS5TCWh2nQ8qc9qriBvUwNGDq7fyB3CnZV66Bt2wyVqk6iiVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 08:02:58 +0000
Received: from CH0PR12MB5330.namprd12.prod.outlook.com
 ([fe80::6db5:a0f2:942c:d18]) by CH0PR12MB5330.namprd12.prod.outlook.com
 ([fe80::6db5:a0f2:942c:d18%4]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 08:02:58 +0000
Message-ID: <82d495bd-18f0-4db3-9940-f96584271080@nvidia.com>
Date:   Sun, 13 Aug 2023 11:02:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Devcom, only use devcom after NULL
 check in mlx5_devcom_send_event()
To:     Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Li Zetao <lizetao1@huawei.com>, saeedm@nvidia.com,
        leon@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org
Cc:     pabeni@redhat.com, shayd@nvidia.com, mbloch@nvidia.com,
        vladbu@nvidia.com, elic@nvidia.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <20230804092636.91357-1-lizetao1@huawei.com>
 <face8e0a-b3f6-85d9-ce1d-8afecdafe2a8@linux.dev>
Content-Language: en-US
From:   Roi Dayan <roid@nvidia.com>
In-Reply-To: <face8e0a-b3f6-85d9-ce1d-8afecdafe2a8@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::20) To CH0PR12MB5330.namprd12.prod.outlook.com
 (2603:10b6:610:d5::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5330:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6f491f-b74f-43a5-875e-08db9bd3b4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjLrV8HIJskAiQd1sZhT60Q1vyc/275kOdLInYajTWY8GVq4qniJ+/DNEumsvs4VVMINISLchMJ2ufnyVtQTBbkvvT8BcdR/0+viBSH4pLIcKa9xLcz4EKO1FTZhEz4TMrZxyiHlALEMoEu5IHPQdLrloWtPcRyKoywpw+BzyEFqtqUx4B8ZEYNPCXn/0BAIipUdbdANrmYQZDEqCAztP+u7h/gg/DkwRBl+q58k0d3wlwyzDQ7RqozCp/2m6w+WAQoOu+1E48bx3h4eiay9qy0vJetc8hStezWTrl0csX5l//KhphCwjWiPxG6GhrMkRncXFW0vS5HkRG2BqalbI2kSPhxy8tn7nt8de+Z0Lc5Wiani7bSp1eYjZRqRdpqPyH9WYO7VhYQRFNaaLacU2EgZaKHZl0+eOFAxzxOLlhIeA33fNi6CieeT/DJVO+cYyfqBGR9tmCLH70C3NDqNrnnvt6aP4U/OWGCuDi7eOJiYvqvy1AGLEvmDKTZz1NgvpB1vBYvkq75qKXiLXTfY12pTHrAnaIZHHShZHEpC9S2AU5lW7+QfDqnYt3nH+HAclDa68UT09pzQ92MmVQlA68ddprLTUKTVi2U1IRN14jA+UL5gPKq7pHRgK+24B8cdnCvfTt1UBnZYL4Ks5po96EjN59oKKTrajgWxvYrmx9jYNoj7U2PpgRPCsc1lR/69
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5330.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(1800799006)(186006)(451199021)(38100700002)(36756003)(86362001)(31696002)(6512007)(53546011)(6506007)(6486002)(6666004)(478600001)(966005)(2906002)(31686004)(2616005)(26005)(83380400001)(316002)(110136005)(41300700001)(66946007)(66556008)(66476007)(5660300002)(8676002)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REFzWmhJN2lFWmlhQThiM1psVVZMQWg4dFB4N0FXZ2xmcjZHdU1pTzd4M0Vu?=
 =?utf-8?B?S3V5a0swSStROW1QeUVpT2lvN05jZjRyYUdXWXJsTFlYNElKT1RBSTZSMTQ0?=
 =?utf-8?B?cWZKNTMzSGxocVNnalFOM1cwKzRQTjNvMUZtamN1ZWpWYnU1ZTNVc1VTZlVX?=
 =?utf-8?B?aGlFSC9SOTVtZ1VKOHB5VjNidjNmRVRtWjIzSXJ2ajNjbE1zNE5UN2dkSElV?=
 =?utf-8?B?RnZqcUhtOUpiTnVicDE2RGljUDJGUVArTEpNMG5NMWdiRFY4WnBwYUZFVmI2?=
 =?utf-8?B?OUl0MWxxbm9FdWpsNldNREVnbzErWC9MNnd3L01ES3RXRlFSNmx0cjB5REVC?=
 =?utf-8?B?L1NGV0hmUWhYRTNjVmtKd0pWSkU4SDBpVTFIc2VaVlFqN1ZXUlZyS3M1NEp3?=
 =?utf-8?B?b21mNnMzczNKSVFyY3VTNXJpSDNMSDdsZzhOTnU0aWVNdmZsL25jMWFWQy9D?=
 =?utf-8?B?aHI2bTA4dzB4cnozV2F3UHFiU05Xc2RScWhrTG5TdmJBZ2VWUzc0L2l3bnZi?=
 =?utf-8?B?anJBOTlpRXpLSTlDYzcyRThiQlF2UStKUlJOTnR0bnkyREdQR3ZUbFljZ1cx?=
 =?utf-8?B?a05XR01MTkNmVHpyQUR4MXE4WkdtSHRkRE9ibXNCOVJCR0dCM3I4ZWY4Zm5q?=
 =?utf-8?B?a0J4UWtWNk1NcVR6eXBGa0xzTkVIUGxPOVUxTU9LM3ZkcytjTGZieVNhTFdY?=
 =?utf-8?B?dmRFd3pFQjRGblR1ZXVReFJVQUlBQmdrYStBaVpwTGNQSFI2Y0ZLU2lvS0w0?=
 =?utf-8?B?SGlkclBxbk9aQ3dzRmI5TlM1T0FkRkM3OVEvT1pQQVlGVDhZUU1pZHloOXpm?=
 =?utf-8?B?Q01zaCtYUldDQ1hpNVB0Z0dINjUwVlJoRGY5MmVDbXdmeVNvWGJOb2sydzZs?=
 =?utf-8?B?dEJXSzYvUTF1YTQycndyS3pSSFRzeVVzRzlBZlVxR0xrS3FFZmJHdUYyd3hq?=
 =?utf-8?B?QTRURGQxOW9oTVgxMm42WTl2QVIvMHVsYnhlcnRiNk9kbUw0UlJCelNNTXJG?=
 =?utf-8?B?dGRsM3ppUXlYR3pUU1NSVEhxVm9hV3NZRUNXMEFvTUJvZ1ROSEc1QktpR3lR?=
 =?utf-8?B?RTRVY1RXL21XbU44dzhteUF6TDRaRGhoejNkNXpwaXpGMUFLRFJkek5TOHc5?=
 =?utf-8?B?aXA1ZWN1WXhzT1RHaFJBampVUnhTcENuajVYNmxpNGxiTExqalcvQ1oraklH?=
 =?utf-8?B?WDAzWGlwL2ZwRng5TXBhQmM4UW5zUmRlN0pINzdORjhLVlhWUXVleVI1ZUpD?=
 =?utf-8?B?RmRsUXNUc3V1Uko3c0g2VzM4bGxsc09YdjJDakpGSFY3RzcrUWcreGkwOGZy?=
 =?utf-8?B?UkRQNEN4SFM2TEUyelpORnVhMUtZaXBjdG03cnZOWEdPclNGUjhKWmxNMGo5?=
 =?utf-8?B?bmRUdE45Qk4xZ2IvQm1GN0drTlJkSkRRd0ZlNGRlR1V2MktJSUIxdVUrNmIz?=
 =?utf-8?B?Tnk0ajAvN3BJNlJWaHVNVlUrSytObDJSeHJRa3RXN2o2UmxidWpsT1dCRTFv?=
 =?utf-8?B?NWVEdld3aWpLNEJySTRqa0FnKzY5eVVOTDErdDVlZ083QTRkbk0xWUdzK28w?=
 =?utf-8?B?QlRmTXpmL0xWUmUwd09zKzY5VXJobTZ2c1QwaStEeW1rM1lPTXJ6aE1YWkN6?=
 =?utf-8?B?VWx0ZFdXUVVMRk5ESWxNa0o1Rk5GSTZwbTNUOTc0MmdOR1o4R1V1dEJCdnpr?=
 =?utf-8?B?SjdLazk0NGdYOUQ5Mk5RZjNxRWhvSkRoMUNFWCtudFZzaVBzdFdTS3VuWnFB?=
 =?utf-8?B?M252Yk5EZjBYeWkrZkZSaVZJbi9TajVqRnhWb3czTFoxcm5QbjBLb3Rvc2Zz?=
 =?utf-8?B?QWJPUm15djVObXZqSUVMT3dlaWE0OUJVaGpUTGRRajA2bHZIUTk3K1hLU1cy?=
 =?utf-8?B?ZzNDUEpjbU95bHhqbUpkMlJ1YkZtT1BPT0NlM2Z0V1NMU2hXa0ZXK3NoallH?=
 =?utf-8?B?OEI5VVE1NmJzS1F0eDdqSXRlUGdQeW5iSmM3a21rK0VEV2ovUkVtZk1NOXdF?=
 =?utf-8?B?dHZSeWpQRUJqZ2ppNE8yTjRqS1Nadm1qUzJ2bjI4RnE2ZkdNWG9xM2Rhb3F1?=
 =?utf-8?B?THBKME9UdE5Nd1NIdTNZVStSRTRaTEE1bW44c1dUZW5KbDRzdzJ4eDkzNlZU?=
 =?utf-8?Q?1eRQC5gI90h6WqGG3Po3tUG8y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6f491f-b74f-43a5-875e-08db9bd3b4fc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 08:02:58.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rB+cI3HzTG2V9KaWIrTiyPUwCQ4SoOSI1mDrxO9jpAzi1dSH19L0ZQ2gzQTKZcx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 04/08/2023 23:53, Vadim Fedorenko wrote:
> On 04/08/2023 10:26, Li Zetao wrote:
>> There is a warning reported by kernel test robot:
>>
>> smatch warnings:
>> drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:264
>>      mlx5_devcom_send_event() warn: variable dereferenced before
>>     IS_ERR check devcom (see line 259)
>>
>> The reason for the warning is that the pointer is used before check, put
>> the assignment to comp after devcom check to silence the warning.
>>
>> Fixes: 88d162b47981 ("net/mlx5: Devcom, Infrastructure changes")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Closes: https://lore.kernel.org/r/202308041028.AkXYDwJ6-lkp@intel.com/
>> Signed-off-by: Li Zetao <lizetao1@huawei.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
>> index feb62d952643..2bc18274858c 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
>> @@ -256,7 +256,7 @@ int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
>>                  int event, int rollback_event,
>>                  void *event_data)
>>   {
>> -    struct mlx5_devcom_comp *comp = devcom->comp;
>> +    struct mlx5_devcom_comp *comp;
>>       struct mlx5_devcom_comp_dev *pos;
> 
> The code should end up with reverse x-mas tree order.
> The change itself LGTM.
> 


Hi Li,

Are you going to submit v2 ?

Thanks,
Roi


>>       int err = 0;
>>       void *data;
>> @@ -264,6 +264,7 @@ int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
>>       if (IS_ERR_OR_NULL(devcom))
>>           return -ENODEV;
>>   +    comp = devcom->comp;
>>       down_write(&comp->sem);
>>       list_for_each_entry(pos, &comp->comp_dev_list_head, list) {
>>           data = rcu_dereference_protected(pos->data, lockdep_is_held(&comp->sem));
> 
