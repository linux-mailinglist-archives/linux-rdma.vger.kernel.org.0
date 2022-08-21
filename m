Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0159759B458
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Aug 2022 16:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiHUOJR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Aug 2022 10:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiHUOJL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Aug 2022 10:09:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723821E3DE
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 07:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR9nloPhEKwKm6sJyOx12i8aGqUIwq2EnimCt/HRPYEWjDkJlJfFV8AtRz+kksmPV7/NrZEEIJq5qtJPRP9GtZ2VcB7pZn+ijVxPJ1D64iYTfG2g9ebp2CkkDCcniQRMKqi1ZXAO5NFEu5S54UUypLVoONcMdnAsxVHudHHMvprXpMeYtQEgdZH9czh5IDWWHH0Oe90+SeBc6PhbgN2iKFZ+XHIP8+aVEqocA0bEVZJf952JxHG5OPkswQfxRje/jyXAqAvaMFCbMNxALsifVCWWRa9rciDOLR7uCCQYbtEk/m4kICEl5PXkdVI8UfevGCNIAKhtwonTmVjtuAez7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW8+8LV4TP9da3T7WSzact0dbqWYK2tEE5DE925HaZ8=;
 b=Os/ObUMx5iVy2OEyd3AzCtVnBij1mV3GkzDQ4Ywqzq5PJ3p2/9FI8rnStkTdNAL/Q8p5wg85gq6ehIV8u1c+uyUYgFSURsuXsjogyXaOfNxLpLnfQeaRiXCnXGvqdz8Y8xnb77BYPWubuaazaWQNdqMIqSFXetDtRhDce1HcKUYDwuUmWb6fMrmbLHxMbEQ9OtflOWP+I5KgrLKHCac5sEnrF+lZW6Qf0ZFZMJuy0y5mSGwgz5IH+4Fd86SqksZPjrHhVQLdIDCsI2hurPTqhS/IIHZUFER9QHlHtpHOZf0j9V/RhHDA8rCUg3xIQGVEuROT3fKFbAnMtuDy68Zt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW8+8LV4TP9da3T7WSzact0dbqWYK2tEE5DE925HaZ8=;
 b=iFA5CSTdNpFoFMoqTOZ20Z1BI0C/7Y9JIXutV7A4sSwwnuoxNxDqvtjpWZSQRUBVhp5Gqr6OE1e4C2kB+dSPU7UupWCzYii1Kh7f5qQ9N9qUB3xbJ1TFhJcLbfgMEDwLjZh+lIED3nWwqyLde1pEf/66gMs66DSL10Gzh5TcRD0gSSlyWqdE/QpDWB10EZmKDENfJVzqrbLBqp1DiWEN53DRhYYOg46RUL24YE05keVrzSKkefuMuQpwlbOb4SyYd9dUMSrljTR7D8+bqHNtkwRrKrXYVKrPLeQZ4iYvZi5NEWKVIpTLE/UYW/eYmiySF3L4DgxBkTyArAd/tORfDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Sun, 21 Aug
 2022 14:09:05 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::b9f8:7e48:f34a:70f9]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::b9f8:7e48:f34a:70f9%4]) with mapi id 15.20.5546.021; Sun, 21 Aug 2022
 14:09:05 +0000
Message-ID: <472c4a14-e6fd-fe1d-51c0-31b8db8debc6@nvidia.com>
Date:   Sun, 21 Aug 2022 22:08:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH rdma-next 2/3] IB/cm: remove cm_id_priv->id.service_mask
 and service_mask parameter of cm_init_listen()
Content-Language: en-US
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     jgg@nvidia.com, dledford@redhat.com,
        jiapeng.chong@linux.alibaba.com, cgel.zte@gmail.com,
        linux-rdma@vger.kernel.org
References: <20220819090859.957943-1-markzhang@nvidia.com>
 <20220819090859.957943-3-markzhang@nvidia.com> <YwIYXI9xTSpw4Vtj@unreal>
 <8863ab45-8b9f-3f1b-32c7-2c8f7e06b8ea@nvidia.com> <YwI3gG23YhD2zg0k@unreal>
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <YwI3gG23YhD2zg0k@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To CY4PR12MB1366.namprd12.prod.outlook.com
 (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec9926ab-2487-4be9-1cd6-08da837eb514
X-MS-TrafficTypeDiagnostic: PH7PR12MB5782:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CaM8sGL8E0wF09MgXW4jabx2z0KQxypSHGQ7vcXeFhv2Z1/OIJjQK1bEOU+Y3tbGvbOhTS5Fdupy7ou9La5zjKPfGpusM3S4JlMe+eqE9A9TJSGeQeRF8gR4OkkgsmlYbMhaTm1SO1MombFilHi9FS/sFYCQwo4n5YEWk8FInisnDMyRMx402n9A8vjkfnyIwzq1CCvLk2Y7Tm8a+svj3N07bg0V4dfXFko1CaJ8z5mY+Utk4sX4nrvzkap3KziuARJFaFozb9B9yoXcycGMKyfcKqDhYPhjKydmn+mZpGqy9FX2/8xLZlrhpJPsErUdX+ULPN7g8ZyPr2ihq1r0JVTVGYQ2478wqa3d6NodWQveVRdQcMutatxk9UChUKC8f7UshVfIs3w+3p7OCfwwVQJVbXHhUXL9EHAnglcAuOVas03pcP3ygMXBt1quUTRwIF0+p4b7mJ8+tpL7sfqthnxIckXaBwKqlN3lAPGbM0aaMUdwCBIPsPKqHvO9IJrmf+OZR75Lk7eF5fo9eQQ6wDT8+xe7p6uwiJm6+JgLNZmfVXHsTfZv85sJymzlofoixOfDfrZaX8vhpgBjzcC7lKnd89mMMx8//fzaeBnoq3PJgcmxdN8+y08QykaZffbqctrOXLb1QZDO3QFavHoEBGofYiI04rBo/63ay5s8DjMaZZeccBZZLfTMioWF+sYAvoxeqPNk6ExovI82MhNK8yzQyC9APIytfGGsdwfEKy1ufoApaztGXt6cKqX+MkCSPjFNXFRoTtnUYc9+x37gj2ewKvOwvyyGtYGSdXaSulw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(86362001)(31696002)(6636002)(66946007)(66556008)(38100700002)(8936002)(37006003)(316002)(6862004)(2906002)(66476007)(4326008)(8676002)(5660300002)(83380400001)(6512007)(186003)(2616005)(6486002)(26005)(478600001)(6666004)(6506007)(53546011)(41300700001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3lrQUVHaUtnTXJHeGNKSGtPZXJRQTQ4Wjd6SHFGZ01zbDkvd0xETzNDR0pk?=
 =?utf-8?B?Tkd3WVQwaEcvb3BwbXprVmt6QWJBNFVkcnlOMUowUkhrV0sxRDcvUzNTYlR2?=
 =?utf-8?B?U1FaSlJ3UXlaakV2SHhOVlJBS1g5dXlSTHZzOXVjSVJJWVhIYktYS1BzTklQ?=
 =?utf-8?B?bFJkcCt5ZXd3MDQ3bU5MQk8xWTl5bUpKSWRFTEZyOHY1dmlQdzcrVnFGdTRw?=
 =?utf-8?B?K1RNMVhmS3ZqQnBOVkdlTjR0My9NbUpRQjE5Mm5WbTk1UmJXZjJpNW1EMlJk?=
 =?utf-8?B?dVpUNUYyYW9QQ3ZPUUVsTUgzYVdpTHpKSit6R2hWdm5pcjJZVDFLNUVZbHJF?=
 =?utf-8?B?bnNQYlc0V3pzVjBjdmNUeVFtaThCTFc0ajd2NkQ4VmYxZ1oydFpHcWFzNUZ2?=
 =?utf-8?B?QURDNyswZktadjZBRzFvcDVKU1NkTUFJU1RLNEVMSWhEcHRzcVdpcUZSZUt6?=
 =?utf-8?B?OUxMOUpwMzZ4Q3hXVG4weks3UTgybTRzcSt2QU5IczhON2NKSHBiWWt4VTZV?=
 =?utf-8?B?SmZDK2xiK2kyUTE4UWtPOFVFRlVPZTFqNEwyM1hFODdiTkdxNkFSZlNaRXpD?=
 =?utf-8?B?eUdTL01rUjZBc2xBMUxNdlVlZHQ2a1Q3eUMvV3hoQmRpaUtJVXVCRUpFd1JS?=
 =?utf-8?B?Wm9pNCtjbGVEREdhd0xNZENEY2hCdmhvNTNmcFVhbjE5YkF4TUFIbG1abXh5?=
 =?utf-8?B?NnV1NlkwL25EelJkbGlFWWpPb3V6N01SOFd1VzlZV280Yzc0bXhOMVNQT0V2?=
 =?utf-8?B?Z1ZXM01yUWdjRlBBTnMza2ZBclU3a0lBSEN3ZFhtS3FKSEh0bUxGWlUwNzVT?=
 =?utf-8?B?L2drVjhuSkszWVRpaEwramVzMFM1ZWVLRDBOVExSUC9najgvZVBSRWIyc2NU?=
 =?utf-8?B?M1l5ZnFRc0pEU0tSRSszR0JBWUplOEN2WUwyTndFOW4yMGFKRExZSDE1UFlL?=
 =?utf-8?B?WkkyRlhiQndka3VDcE1HY0VwdUtNNE9rVUQrWWF5UFFYTWxMbTVQcXQwOVk2?=
 =?utf-8?B?cXdUVVZ2NWtDTTd5eGJJZi9EaXJJbWZ4OXUwam11NHdxYjZzU1ozd0U2ZzJz?=
 =?utf-8?B?WkpOVlNYNnNBZ3RUT3R4dGZqUWNvSC81c2dsb2FCTlRZRDN0RTR4ZFRQMStv?=
 =?utf-8?B?Mm9rdmdxbVlpSVhHcUZZNk5sS0FYRDd6L0d6czJWOWdabG1IV1JvdEQvcmo3?=
 =?utf-8?B?eklGSHpPOUttL3NLanhVcDluL2JsbmR5dWlkTEIwQlNsVXdFckxIUDQzNmpS?=
 =?utf-8?B?dDhTWjYxUk42aFBCdDNkbVFnc3Vob29Ya1pVaFlHVFg1QmVJOVVweEZMR3Vo?=
 =?utf-8?B?TTFyZ0RHKzE0eTFmc3d0SWRwUTc2NjlYR09sRHdkNzF3M0h1cEJiSmRlRy92?=
 =?utf-8?B?S0FBd0lwUjk2K1VYU1ZmLzlvTytUMkFGY2VuTGdKVXFDMEZHWkU4UzFwSWs4?=
 =?utf-8?B?aGY1ZENzV3BVQVU0Tjd0NUxmZFErd2tuTGV0K2dpWmhqTmVwaFlpZjIrb1Na?=
 =?utf-8?B?TTFrbVNTQ1A3ZGtjQ2g5dHpmZG1sMXFLMHpZZngraCs1SlhqR1Z3QTBuRXpB?=
 =?utf-8?B?b1dFSTBGbFI4U1RkSklFandoQUJTTnJYTW9zbHF0OE9ITGJBZUFvb0Zua2pJ?=
 =?utf-8?B?WWplanQrK0EwV2NaeEhxc2lva3NZUFdObXh0WlAwY2pUbTlzQXNQdmJYb2ow?=
 =?utf-8?B?QllDNU1zN3hwNGZaa2ZVZG9TamhIekF1a00xWUIrNEtzMFNhak9PaXBibHg3?=
 =?utf-8?B?YXRYd2NqVzdzYnZxZ0ZPMVowODF4VlRPdXEvYXpqVEViRnU3ZG5sdGllVnlj?=
 =?utf-8?B?TGZuK1R0azNpcG45VDkrQm1mRFN0UDZyY0YyYmVmY1pCVmZpMXU1VHVGT2FC?=
 =?utf-8?B?Vjd0UUFGV0pIcUljNmVXMHpsdzdyZ0dBQW1GSnUybUdhd3ZZVXhxVXE3ZGJw?=
 =?utf-8?B?aHhGVGxKazc3MXVUQVJkaFJVVCsrNWczNnFNMWRIRWhqN20zc2tWalR3M2NU?=
 =?utf-8?B?QlhQMHdCQ2ppM2pBQ3BFT1c2UkkySTM0YlZzVHNaL1Q3ZkZpa2pJMHI1eHZh?=
 =?utf-8?B?OEUva1FvZk5EQzh1UGVYcTFkeE9od1huMTJFNE03Ri9xaUQ0c1BKdkFtNzJN?=
 =?utf-8?Q?L8QjoF5PK0JrcdnJzYYaG0V5I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9926ab-2487-4be9-1cd6-08da837eb514
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2022 14:09:05.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cK1hMUMKJrEpPzcIsCP15H0BQ/7WtdPArWaD1waWgtuR+B1Q/WevGIOKgJtLsuurhdSU/ku3umFhs8Imj77fyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/21/2022 9:47 PM, Leon Romanovsky wrote:
> On Sun, Aug 21, 2022 at 08:50:08PM +0800, Mark Zhang wrote:
>> On 8/21/2022 7:34 PM, Leon Romanovsky wrote:
>>> On Fri, Aug 19, 2022 at 12:08:58PM +0300, Mark Zhang wrote:
>>>> The service_mask is always ~cpu_to_be64(0), so the result is always
>>>> a NOP when it is &'d with a service_id. Remove it for simplicity.
>>>>
>>>> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
>>>> ---
>>>>    drivers/infiniband/core/cm.c | 28 ++++++++--------------------
>>>>    include/rdma/ib_cm.h         |  1 -
>>>>    2 files changed, 8 insertions(+), 21 deletions(-)
> 
> <...>
> 
>>>> -	if (service_id == IB_CM_ASSIGN_SERVICE_ID) {
>>>> +	if (service_id == IB_CM_ASSIGN_SERVICE_ID)
>>>>    		cm_id_priv->id.service_id = cpu_to_be64(cm.listen_service_id++);
>>>> -		cm_id_priv->id.service_mask = ~cpu_to_be64(0);
>>>> -	} else {
>>>> +	else
>>>>    		cm_id_priv->id.service_id = service_id;
>>>> -		cm_id_priv->id.service_mask = service_mask;
>>>> -	}
>>>
>>> If service_id != IB_CM_ASSIGN_SERVICE_ID, we had zero as service_mask
>>> and not FFF... like you wrote. It puts in question all
>>> cm_id_priv->id.service_mask & service_id => service_id conversions in
>>> this patch.
>>
>> The id.service_mask field is removed in this patch, check the change in
>> include/rdma/ib_cm.h
> 
> Right, you removed service_mask and described it "is always ~cpu_to_be64(0)".
> As far as I can tell, this is not true and in this "if (service_id == IB_CM_ASSIGN_SERVICE_ID)"
> sometimes we set cm_id_priv->id.service_mask to be 0 and sometimes 0xFF....
> 
> Why is it correct to remove cm_id_priv->id.service_mask in this hunk?

1. service_id == IB_CM_ASSIGN_SERVICE_ID:
   cm_id_priv->id.service_mask = ~cpu_to_be64(0);

2. service_id != IB_CM_ASSIGN_SERVICE_ID:
      cm_id_priv->id.service_mask = service_mask;
    It's also ~cpu_to_be64(0), because cm_init_listen() is always called
    with service_mask = 0:
      ib_cm_listen(..., 0) -> cm_init_listen(..., 0)
      ib_cm_insert_listen() -> cm_init_listen(..., 0)

So it's always ~cpu_to_be64(0)..

Thanks





