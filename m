Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412CE3658C7
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 14:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhDTMRp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 08:17:45 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com ([40.107.244.114]:31072
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231251AbhDTMRo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Apr 2021 08:17:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FahDqM8VetI6HQh+DjZ7ui6nG53q/Uvw7pvjh7u5GG5iBaWzVWtAWh5vchUnpDBnw8DGxbab32XX/GoU48Oe9zY75bHGg7BColGUcwH668OyaxAdJcLBUyg7y1euH9d84EgI9/aOQ7XYqGEnPPevGGgK1QxS2LjgHuQAMjd0Cw4NZGSfJvhdcQj1pI1NH0xsbMi8ATvuD21dwTdSAl8iYwu4kx16egOgJ3o9S8Ftpbswl3/ChiUqJfPg3g4flfwblKyhn1yYtXuKRIfX0EkEwwV+AlRsnJgFGZc5ATJ+D4hGkpmmxFOCj2nyCwM6drvWeQjMY865ggrkPJnMaZv5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXtXjkUOfI4/EIkyukmaqwQALnK+0mveD8Ct7K7BC+M=;
 b=Zt4jFEFpcB4ZB+Vc+kSuqJGuVam8xbRIupqrmK0lVxKuMOYN228khGnLGurQwoHFd3KoRXctI/EJEJVrBcYNRPLFQ8j7dOrgf5YDBUAffA6sZbiY1QMrHLROZuwfvX5moIa5tOSMo17XC5bMWOGRL4r/DdHCzc6b5Y7B+GupHpj4+wl3g7XZ7pigceCO/A2YGyFvT9cH80p/F77VHg4tHl/m4bBHHM7Whm54QKJE7MaizsuWAnuu0/ix2kbxjpXisyyE40I4RPeuDTxfoj43nKTQP8E8nsZKlCyFaIh15e8LY86ylRu0nBPV0fsP3lWjaN78grhPtWm6XOaexJnPrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXtXjkUOfI4/EIkyukmaqwQALnK+0mveD8Ct7K7BC+M=;
 b=BHSAvXXnDYriRMALeugSEx48b9zV4tIZJOfapg5e040eULsvBfbTPhXIio+jDZB3yGpNqDcTtHhwrzZAXZb1hr5SLa2kqz5wsBr6x4tMKyvG3Ex3/xxpC/sGTKBtDV59ev31/4lkqHsvKOZ/re8RZHosI9U32AD3N20VoU+2WJ84x0mH8NzU8dGxFLwAzh+UK+CxYrI9wvVxTQtvgqhLIIUb0rpo2uNfSROynWRFq4TEP0T1fGQVOINsNu8W5ffNoB86nPXMs0yajxAS8yGHteGSb8A8XMuDgMwdXTfuVSf8KwlfqmHpFq0jM8qh/5UywYz3dK1F1phDucuxplAJlg==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6248.prod.exchangelabs.com (2603:10b6:510:c::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Tue, 20 Apr 2021 12:17:10 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 12:17:10 +0000
Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <1617026056-50483-7-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <YGWHga9RMan2uioD@unreal>
 <44ca5d0e-7aa4-5a9a-8f3b-d30454a58fb4@cornelisnetworks.com>
 <YG7ztT81z8BZDkUj@unreal>
 <8d987675-09f3-542c-a921-072f19243e08@cornelisnetworks.com>
 <DM6PR11MB33061E82DC3C60F2779C87DFF4499@DM6PR11MB3306.namprd11.prod.outlook.com>
 <YH13p0zRz+M9Tmzz@unreal>
 <49397542-7015-5e8f-b473-49a124dd4341@cornelisnetworks.com>
 <YH5ilM02U4cuYK3x@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <0bd262f3-0eaa-b508-2a01-5ad89147538e@cornelisnetworks.com>
Date:   Tue, 20 Apr 2021 08:17:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <YH5ilM02U4cuYK3x@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:208:d4::17) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by MN2PR04CA0004.namprd04.prod.outlook.com (2603:10b6:208:d4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Tue, 20 Apr 2021 12:17:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0099a17b-3b7e-4fdf-21a3-08d903f638ef
X-MS-TrafficTypeDiagnostic: PH0PR01MB6248:
X-Microsoft-Antispam-PRVS: <PH0PR01MB62484242BE1E6B90E9357BC0F4489@PH0PR01MB6248.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2D8dTvOFNt09SMlgO+TWQ958XE0VGz/XjHLLH4UKaBgf7a3ndwCi/GlMxX39m1ThAVP/6pzrDtlm0WCFghUg1k3ojtatJQ+HVnmNxZElqhpUu6AbH5HCtAjvCtX84Cz9c5y7wEdl5JVchOpDUq2wU+Pw+RQrwP7L6Kbqze7F1cuWjZf52fl9rI0nGGDGABvi3KuXKdYUobboRTKBV6ftreixQDbGAo/fL/AKKpeyFaOw2/EWbGIFbBLdnhw+42DukNVnF08hYqH4tzTl6Uj36zx3XX0FRAsqMRUMYETlfxigyVLLBdzEOx/yeADf4zDohB84oJIswUFGG8ZCgMLN4FMw7/rcbSnb8D0WJhW6RFEhDq9fW90ZLSwd0vPXlsGD81LyPfJ3wBsMNn3EQfjPSRQi2cCTOSdiKTxDw747sLFtURowjVkv4ibPxu7CfchCeY3OyF8xeD4Dvdvp0mY8kToRNxZmC6mmjKF5eb7dhYlXm9gax7blvzHoosr+YSJQcRqrpcdW4UPm0GVEg5zDLdB6ZFXi5v4QmpyEX2npfHzOvVsZTnel+AHPp9e+Pr0aVV5I3JmIZTx1a1SebXSE4cg8/MXkN34H/w44hohl/8p1COYmN7uflj6uwWvTBRKgZZY2+nvG5PphCZc9g2iVSGMAnlzJCVD1RCdShEK0HMPWfF4+D2C+4IlzzbBoZG6wnExGrROBwmzYeszln8tO6phLVzWCtBIwpjDfJ7nKEmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(376002)(366004)(136003)(346002)(396003)(16526019)(4326008)(2906002)(44832011)(26005)(8936002)(186003)(66476007)(36756003)(83380400001)(8676002)(53546011)(38350700002)(6486002)(86362001)(6666004)(38100700002)(66556008)(6916009)(54906003)(66946007)(31686004)(16576012)(2616005)(5660300002)(478600001)(31696002)(52116002)(316002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y25pemk1NEtqdjBsSWQ1Y3Eyd3FOWFFCVk1CUHI3VWZNQ041VEVtelF2bjlD?=
 =?utf-8?B?Rm5oekxLTURIQXRGcFZwMEl4QksrWTYrcXlnSENxaHBad0QwU3JyN0VkVUhX?=
 =?utf-8?B?UzlMTzZKSmhvMXR0czJGM3hkeEVNQjVUZ0QvUWRXdUVhV2VuM2lhYUpNaEZG?=
 =?utf-8?B?TGhnY1QyRzBaank1UTVENTlpdlIwWVZYKzB2QjBWQ3JDZlYxaS9NcWlTKzI5?=
 =?utf-8?B?c0I3WUI3REpoTi85a2RoVXJzWUhvUWc4S1lYRzdnVEI1M0ltNTM1V0FTRVNR?=
 =?utf-8?B?Q0NvZWFBQTBuak5OSGNhZWlzTHRCWmVoT1J1R0FzZm5LeDFkb3g3RFNweG51?=
 =?utf-8?B?amxDQlJQRGdwWDNrQjJWT3JldURGb1VCeXdwU1JRZXJaeVFWVHVQbGJyZFhX?=
 =?utf-8?B?eUkxVVZLTHhGWkx3bklwUkk1bDczVHJVWWpKa3VIR2QyMG5kNWp4S0Vxa2dm?=
 =?utf-8?B?V1B0VTk4K1RtckN3a0VXRzVwWGFQa3VGb1BKSm96cFdLekt0ekJSNnNUWmRn?=
 =?utf-8?B?TG5RS091eGxra1lGODNuUWlpbjlSNTFndm9qN29CbWMyOU8rMTVxRHkwdDlY?=
 =?utf-8?B?WHZMRk9obFN1L3Y4UjllSnNnc1paMUxNMllQVDkvWm5PUEMxcnMxQjNwcm9o?=
 =?utf-8?B?eTNWeUg1YytLWnF1MTYvVXI0SFI2bE9EK092UGFjSXFRTVJLeHZwRDJIWjFq?=
 =?utf-8?B?clh0U2dxVlpjTE5mWk1xSjNlNXBNUDdZa1czVEI2aTVNamY2bm1HU0lyTVdj?=
 =?utf-8?B?Q1V2TG5uTUxubnJlbHVHNkd6OG4wSEdvRzg5M00xaCtrUWc0Zkx2MlVCRk5Q?=
 =?utf-8?B?QVFwTjRtTmVqcERTa05LYUZHRm9XRjUyeWZLbnd1cXJYV0lLblpqN0FHU0hS?=
 =?utf-8?B?bGJtc1FQQmZEREF3THFlUXRrNFYrY3gxM3kxMDVFQ1A2clhEVGx0Qm1lTHBp?=
 =?utf-8?B?dXVabGJ3TGRabjhFWDljZU1Wd3lBYlVxcFlsYlhsT1BXWTRSNzRydS96KzYr?=
 =?utf-8?B?N1cxOVg2YjJiSDk5NnV6SW94amtuU0JBeGY5MDUzblBuU1R4WEFiWHpVVjNi?=
 =?utf-8?B?YzlkVWRJUVRrRThmTUE2djg3aVBNWkxqL3RWYzNENWxmY1Ntb2lab1Z4Zm14?=
 =?utf-8?B?QTdMNnVFbWc1MnRHYVRXeUdORE41MGdEZkpiNmFpR0ZZNEY2T21vRVpQa0hV?=
 =?utf-8?B?US9YcmRnSG9iTElDMHB4VzNVM0lmdTJVVEZFOEU4alpla0dVOFBNeTMxMFVF?=
 =?utf-8?B?SEhTTWh0TmNERFl2Nmgvak1lTkFndGNMUUVoUG9LUFVHay9vNnZoY0VJZkZz?=
 =?utf-8?B?VjBGQllvQkxvZWpkUWd4d2w4RXI5SGRTVkJlVnl6KzFrU1R5NlB0N2RBdTFo?=
 =?utf-8?B?UmpwbVJvbWhMOUdBVm9OM0QyZjBGVzZ1THFYRFFRQ3paY1lUVHcwWWloTEpY?=
 =?utf-8?B?cVhrcHVTdnAwTzN3aHdWVVJzUDNVOHJZNElhRTlZNEQzUTlIcnFscWR0anNO?=
 =?utf-8?B?ZXJ4UTd1RHBsVTQreWFZK2Nud2p2bW1SakwxMnMxemh5Z0YvekNlbTd2YVBU?=
 =?utf-8?B?ZG9idDRMSFhTOGJVT0VSQ0NzNXQ1bGljWkx3bE1aZUxlS0IzL0FiRXArTlMv?=
 =?utf-8?B?T0V6UE02a0pTVXhUZStWYWdjTVE5Z2FTZXg5ODZsR0FqaDQwQzQ1SnpQK0dV?=
 =?utf-8?B?L1k3MHExYUs1OWg1ZHo2WFRSYVZXdkI1b2NPdzBkK2dSb1p3TkZ5WlZMUCtU?=
 =?utf-8?Q?pmc6KmBAmJDH349vV816NwC4t8z/znlgXcKqY5E?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0099a17b-3b7e-4fdf-21a3-08d903f638ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 12:17:10.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3U34DvxRiH/vMLyiGTyB9+dNpW4kl7RYrSVnI/mQ361NOsRJFV52AhiMnv/Ig0Nvge/OzECUBY46Br7lc5kAJIaPMpk++G/jeg3TA6SlC3/UfxQ07h4NUkA9gZXt4EB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6248
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/20/2021 1:11 AM, Leon Romanovsky wrote:
> On Mon, Apr 19, 2021 at 09:08:55AM -0400, Dennis Dalessandro wrote:
>> On 4/19/2021 8:29 AM, Leon Romanovsky wrote:
>>> On Mon, Apr 19, 2021 at 12:20:33PM +0000, Wan, Kaike wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>>>>> Sent: Thursday, April 08, 2021 8:31 AM
>>>>> To: Leon Romanovsky <leon@kernel.org>
>>>>> Cc: dledford@redhat.com; jgg@ziepe.ca; linux-rdma@vger.kernel.org; Wan,
>>>>> Kaike <kaike.wan@intel.com>
>>>>> Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
>>>>> function
>>>>>
>>>>> On 4/8/2021 8:14 AM, Leon Romanovsky wrote:
>>>>>> On Thu, Apr 08, 2021 at 08:06:46AM -0400, Dennis Dalessandro wrote:
>>>>>>> On 4/1/2021 4:42 AM, Leon Romanovsky wrote:
>>>>>>>> On Mon, Mar 29, 2021 at 09:54:12AM -0400,
>>>>> dennis.dalessandro@cornelisnetworks.com wrote:
>>>>>>>>> From: Kaike Wan <kaike.wan@intel.com>
>>>>>>>>>
>>>>>>>>> This is a follow on patch to add a phys_mtu field to the
>>>>>>>>> ib_port_attr structure to indicate the maximum physical MTU the
>>>>>>>>> underlying device supports.
>>>>>>>>>
>>>>>>>>> Extends the following:
>>>>>>>>> commit 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's
>>>>>>>>> upper limit")
>>>>>>>>>
>>>>>>>>> Reviewed-by: Mike Marciniszyn
>>>>>>>>> <mike.marciniszyn@cornelisnetworks.com>
>>>>>>>>> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
>>>>>>>>> Signed-off-by: Dennis Dalessandro
>>>>>>>>> <dennis.dalessandro@cornelisnetworks.com>
>>>>>>>>> ---
>>>>>>>>>      drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  1 +
>>>>>>>>>      drivers/infiniband/hw/cxgb4/provider.c          |  1 +
>>>>>>>>>      drivers/infiniband/hw/efa/efa_verbs.c           |  1 +
>>>>>>>>>      drivers/infiniband/hw/hns/hns_roce_main.c       |  1 +
>>>>>>>>>      drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  1 +
>>>>>>>>>      drivers/infiniband/hw/mlx4/main.c               |  1 +
>>>>>>>>>      drivers/infiniband/hw/mlx5/mad.c                |  1 +
>>>>>>>>>      drivers/infiniband/hw/mlx5/main.c               |  2 ++
>>>>>>>>>      drivers/infiniband/hw/mthca/mthca_provider.c    |  1 +
>>>>>>>>>      drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  1 +
>>>>>>>>>      drivers/infiniband/hw/qib/qib_verbs.c           |  1 +
>>>>>>>>>      drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  1 +
>>>>>>>>>      drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  1 +
>>>>>>>>>      drivers/infiniband/sw/siw/siw_verbs.c           |  1 +
>>>>>>>>>      drivers/infiniband/ulp/ipoib/ipoib_main.c       |  2 +-
>>>>>>>>>      include/rdma/ib_verbs.h                         | 17 -----------------
>>>>>>>>>      16 files changed, 16 insertions(+), 18 deletions(-)
>>>>>>>>
>>>>>>>> But why? What will it give us that almost all drivers have same
>>>>>>>> props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu); line?
>>>>>>>>
>>>>>>>
>>>>>>> Almost is not all. Alternative idea to convey this? Seemed like a
>>>>>>> sensible thing to at least have support for but open to other approaches.
>>>>>>
>>>>>> What about leave it as is?
>>>>>>
>>>>>> I'm struggling to get the rationale behind this patch., the code
>>>>>> already works and set the phys_mtu correctly, isn't it?
>>>>>
>>>>> I see what you are saying now. Kaike, correct me if I'm wrong, but the intent
>>>>> of this patch is just to make everything behave the same in the sense that a
>>>>> device could have a different physical MTU. The field got added to the
>>>>> ib_port_attr previously so this is giving it an initial value vs leaving it unset.
>>>> [Wan, Kaike]  Correct.
>>>
>>> No one is using this "phys_mtu" field, except one place in ipoib.
>>
>> Today. I think it would be better to formalize the idea though and have a
>> cleaner interface. Does this cause some problem?
> 
> Not directly, but yes.
> 
> Before your change, drivers don't need to care about this field because
> it is not in use at all, after your change all drivers need to carry same
> line. This is prone to errors.

Perhaps a more common place to set this in the core is appropriate.

-Denny


