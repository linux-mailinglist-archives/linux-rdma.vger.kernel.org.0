Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE4E36428B
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbhDSNJr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 09:09:47 -0400
Received: from mail-bn7nam10on2114.outbound.protection.outlook.com ([40.107.92.114]:25696
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239662AbhDSNJj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Apr 2021 09:09:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN1O+8gYWH61HQvXJ5iUFHZUFqfyMdItoxMOPa7QCkhryan+8Scb3zks+y7nr0KB6qkB4IAibPnJACbYjCuQ3C0M0YWrB5Ycgq9b+OeWkbYdqIXAL8bM3QqSpD/kEwW9F5bb2Wy8HaNF64i/Elwt6l9vVx7mHkTXIwjDVGa6hVwhZycSNtseasl1kzKhlHOAJ142OHihZ7TjxR5LMPTNAQK7VSBVWaEBwRxpkBj+yDbJkx0rV9a40DQG8N93v0Enq3e9tztJeylMpv6oPRIpq7pO2fmLRG/r4bFZXQOTBb5ywHsFWNxsvRlzZbLLXdM52gXSs+3fFmJY0Ac9rtj9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM6et0tgeuphCqdDRpA1rRslbFC/ub+HzFdzRhtN+sY=;
 b=Idros5mDDX4XUJ0Diokr9GuBijFm/Mbvv3Kd9uNN96wtduy9AsXZfZ721udcq8I5RG3AXgWbXhqkPVSgQJFLOdfvrfNDWl/Q2pjuo6aVCl6F5q8v3y1FLi98xXMmsjHJpZG2LFHoBaK8FiZrwDnEQ7w8yS/FK/p1UcVzcAFF/ei9/tEtBILtGB65VNRwywZYHVN0ib80zhrE19d8cd+hS5EFQcQDkkjrgqnui2vBSolxJmmoyvy4PWOkoUq5enDcGHySY7crIxnAeDOh33HcSKlqo/kUj8R8Jaxg67WhlxNASK+t3BEiZwBogKAqVpLDj6BG+IcwG2PsyiheJL6rfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM6et0tgeuphCqdDRpA1rRslbFC/ub+HzFdzRhtN+sY=;
 b=Sj0QTIQWwkGSJjnbrolY9NnCbJY0++5y4jxHasZDcOStzBUw4a5Oz4GehAR8WIWYEPLqfKRAafgfryCUwQxy7PE3uMzhTLU5Pevs+aVq3+inwCLaSyDJWMctaBv8PeYH+UnVkF0DOFSvBETR+u+wgHYfUVXPytDAhYY3akyU0o9DiKIfAywc0EfMUag8x1q6qnmS30KupSx8OJQs+vD3EKSY7futq9RSPD5HJGuMAdZzEoClY216gEKUlzav8eH9r0puKREsxdk3Rhi/p0Pwo94iR8ISHTRFSHTIiC/1fTDTclEIgHRVNciDCqezsWdiJlr1oz9L1QJvJrOJPpPX/g==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6117.prod.exchangelabs.com (2603:10b6:510:9::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.20; Mon, 19 Apr 2021 13:09:06 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 13:09:06 +0000
Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
To:     Leon Romanovsky <leon@kernel.org>,
        "Wan, Kaike" <kaike.wan@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
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
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <49397542-7015-5e8f-b473-49a124dd4341@cornelisnetworks.com>
Date:   Mon, 19 Apr 2021 09:08:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <YH13p0zRz+M9Tmzz@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: BLAPR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:208:329::29) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by BLAPR03CA0084.namprd03.prod.outlook.com (2603:10b6:208:329::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 13:09:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca6ad97f-5851-4dc4-0b5e-08d903344f81
X-MS-TrafficTypeDiagnostic: PH0PR01MB6117:
X-Microsoft-Antispam-PRVS: <PH0PR01MB6117BEB8B4D1B04083634FFDF4499@PH0PR01MB6117.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ak/m5yH+DIP5JCP1r2hRQUSfyxuzJMTr6D0Ex9lxQjfok3gGc71qul11TD1hsotXVRtOFE3Y46mUG7rJQlhRnAGkV3zTzzEOCvLeIKNtB+gP+IFnHUjkBxbIZXx6k0LPEACoNl2nAr2Ic5n3vVYHroQ6yjaJqXE86dTjvtTM8l++2cF01E7eUX8Sy302TH56m1WcxWWrLNFkvHA/7DUrwBHg+resdpbbk+u7l3hKkmC3qFo837ASKUpL1pPxq/orig4shLJw1bUS7WH6eijuUILJMIL+D0cDvxpQex8DwmI4euLXb8WQBlZEXyeX6k0cCr77/T5E3uR3Ci2Txaz6W9/is3q2xyGIb8aAomAnlZY//OF2DHyFVDmWwELqpbdJJIyMJbh2ch1aDh10IvTFrIe7A7hAOhsBA2JdPqDPEAf561mGC4oSFFDSTygSQasA3l8s7iOomziopP+aqaiz2WL5YKXVDkHcOXjuyH+U/DZgcO+W5HQuUlXu7zrH/eKIXZEg9Xjzf285nxJVVHz91cSPZSG6jXLH9ng5L1od4ZTgUZ0wFQn7FKaumcy72Y0JtHtKFPgGyr1nU+r7mRwk0/SqUrBDbuyvwtzyYLT0e8FYdMclr0h3Xs3rPtzCfck6g6pAtlEGzHFwOYjiERfHVI0pRuLck1Dw7lDaUxe+x8tsdg45NhGjGBs1gcoqZAKa687kdBYkeArcxspAIfsH4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39830400003)(6486002)(16526019)(5660300002)(8676002)(4326008)(31686004)(52116002)(66476007)(8936002)(316002)(186003)(53546011)(2616005)(66556008)(2906002)(478600001)(16576012)(6666004)(36756003)(54906003)(110136005)(26005)(83380400001)(31696002)(44832011)(38350700002)(956004)(38100700002)(66946007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U3FSTklHRHZ0QkFud2dMQjBrM1Q4U0N2NXl4cG5YVURNT1ZydHljQ0FtdWw4?=
 =?utf-8?B?RUNLTlhvdHFGVzFOdVhLT29zbG5OSUNoRkZGb21oWkg3Ykp4QndBUEV3QjFn?=
 =?utf-8?B?Y3Jkb0JWUVh6UGRMTjNVamQ5K0lIbkQvbVZHOW5HZWFDQTAzUENCNkJQeFFF?=
 =?utf-8?B?NDhqSkxnbHk2OEJJZ21QNGpUQk5Qb3JWOU0rN0JLN1I3MEQwVG9YY3lqU1lM?=
 =?utf-8?B?L1IwRVhUYmdvZXUwbGptZUV0RmhwUGhLTDNheWNZZnB2V3hMdWkvMVhXK1pp?=
 =?utf-8?B?VmdqYjVpQWFZTnR5L3FZb0syZmIxSzkzZFB5QmhKQ1JQNW5xbXNHcEowVTBj?=
 =?utf-8?B?L1FaWTlLY1BKSFNWcEpDRUtoNG1uWnlHazVVbUFOazVaeFV2VmhlRVRYdGli?=
 =?utf-8?B?Z05NaFArZkRwakRtQ1lzSHJaMUNDOEg5ZlZtVldpNC9ML1J4VmVRYVZSaUsr?=
 =?utf-8?B?MzZlQWRPREVxQzFuWFd6UFMyeGZubTI3aFBWcm0wSVhIWWNuV0plcmtlaWw3?=
 =?utf-8?B?TGpTS0pVRUFHOUlka0lnYlpGa3JKNk5oZnQ0ME1CNkxZY0xINDJnOW1yeVp3?=
 =?utf-8?B?dGZsbXVuZy9BZldtNnpTY3VBTkNlRG1LZFdSeWtoZW1PYUMvMWRrSnJQZ01E?=
 =?utf-8?B?STE1Uml1SEZsUDc5dkVNQ2dvR011b05FTmpvdFU0Y2FSSXJTU2hvKzIyYTUr?=
 =?utf-8?B?OTRaeElleG1MZXNBeEt5TkZLbUNmQmtPNitBSC9UY1IzaU83MHlIbGlFbWJE?=
 =?utf-8?B?WTNuODRwbDBCU0UxWThnR3EvS2RKeGZKSC9Qa09IRHE1R0Z4clppZDdqSGs2?=
 =?utf-8?B?UFE1bjhoVlVJVnlpTjlhQUxsTi82a0JydW5jSkJrRkU3aWpCaTlIUkhHMTZB?=
 =?utf-8?B?aWM4RkxkUkJ0ekxMcXh1QXozTVJaRlo1b1JiQ0lnMWZ0NTVBWHpaQXdlMmlu?=
 =?utf-8?B?c0M3SWF1UFpRZE5nb3ZFdHNmQmVEMHQ1OVJHc1NWcS9JWEo1K0VqYnA3bGFn?=
 =?utf-8?B?NnhhcFNIb1lscnFSZERJdDZBRVVDZTVWcVppMjcrZ0V5ZGJ5YWxya2VPU095?=
 =?utf-8?B?U3U5Rk5Ndm5UVHF2bWM4bFhsSVRSbHZrVDZrUzQwSzBGWUhUaERFRWlUejFL?=
 =?utf-8?B?ai9UQUZpSjJoM1R3eW14SDNkMDV1K3N0cHJPS2tiQlRNaFFUWEpQTmxDQ0p1?=
 =?utf-8?B?UHlabWhvTXFteTlQR1dLK21WN3VmLzg1R3BGSkhFWVBjbWx0emJ2Wm5wUUU1?=
 =?utf-8?B?a1lHRzJZU1g2TGxXdStUaW9LaEgxUHdjSTFEOE8xVHRWYVB2MGwrNnNYMHJ4?=
 =?utf-8?B?ek1oa2lWNGY2Z3JMVjI0bDVRS1dKTTRDbUVXemZVSEVJWldRWkZZT2lpMUxm?=
 =?utf-8?B?MmRpbzREMzQ5ejcwSnRFNmZOUG9ad2huTXpwalh4Ly92aFM0MXpOcGovVWRn?=
 =?utf-8?B?QkRUTlVxNEgwVHAxQ0NrY0dsNjhEU08yK0hVM1pUQ3NOYzR0VnNxVTc3aUx3?=
 =?utf-8?B?bk45cWFCZjkyMzdyekJIT0hBZ3JFdndScy9LVTdiQlBkN1FtWjhpYkdZdlBC?=
 =?utf-8?B?Wldva0pvVU1EUi9YVmZKbDlCSlRnZm52UXlkT21IRmlmbGVxQ09WWStMQ21y?=
 =?utf-8?B?MTFPT2haMXFHTy9iWFBnVjErbkFyMFljeHhUMDU3aHJmMGZNQXV1cFM0cXlE?=
 =?utf-8?B?VzhWSTVpclQ3MFdvRUo1Q0NPS25vQ0Jma0UyWnkvM1VhK0JNUDREVmIrbmVu?=
 =?utf-8?Q?lRSTJpinUewszRNf/JVIeqHhscLbDgqGGnLwJqB?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6ad97f-5851-4dc4-0b5e-08d903344f81
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 13:09:05.8368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoc03asBy4UGPyYYeMo5i8gUiHcMwJ8QWg+Z/jfDhC4rIm+DwuZpcllS5egcpbrVcZFF8PlClzXGRFWlEP0wClVNuxHN3Cyjq11+Xv6MhzkvNa/wX8moDo72Zm6wmK5R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6117
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/19/2021 8:29 AM, Leon Romanovsky wrote:
> On Mon, Apr 19, 2021 at 12:20:33PM +0000, Wan, Kaike wrote:
>>
>>
>>> -----Original Message-----
>>> From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>>> Sent: Thursday, April 08, 2021 8:31 AM
>>> To: Leon Romanovsky <leon@kernel.org>
>>> Cc: dledford@redhat.com; jgg@ziepe.ca; linux-rdma@vger.kernel.org; Wan,
>>> Kaike <kaike.wan@intel.com>
>>> Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
>>> function
>>>
>>> On 4/8/2021 8:14 AM, Leon Romanovsky wrote:
>>>> On Thu, Apr 08, 2021 at 08:06:46AM -0400, Dennis Dalessandro wrote:
>>>>> On 4/1/2021 4:42 AM, Leon Romanovsky wrote:
>>>>>> On Mon, Mar 29, 2021 at 09:54:12AM -0400,
>>> dennis.dalessandro@cornelisnetworks.com wrote:
>>>>>>> From: Kaike Wan <kaike.wan@intel.com>
>>>>>>>
>>>>>>> This is a follow on patch to add a phys_mtu field to the
>>>>>>> ib_port_attr structure to indicate the maximum physical MTU the
>>>>>>> underlying device supports.
>>>>>>>
>>>>>>> Extends the following:
>>>>>>> commit 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's
>>>>>>> upper limit")
>>>>>>>
>>>>>>> Reviewed-by: Mike Marciniszyn
>>>>>>> <mike.marciniszyn@cornelisnetworks.com>
>>>>>>> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
>>>>>>> Signed-off-by: Dennis Dalessandro
>>>>>>> <dennis.dalessandro@cornelisnetworks.com>
>>>>>>> ---
>>>>>>>     drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  1 +
>>>>>>>     drivers/infiniband/hw/cxgb4/provider.c          |  1 +
>>>>>>>     drivers/infiniband/hw/efa/efa_verbs.c           |  1 +
>>>>>>>     drivers/infiniband/hw/hns/hns_roce_main.c       |  1 +
>>>>>>>     drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  1 +
>>>>>>>     drivers/infiniband/hw/mlx4/main.c               |  1 +
>>>>>>>     drivers/infiniband/hw/mlx5/mad.c                |  1 +
>>>>>>>     drivers/infiniband/hw/mlx5/main.c               |  2 ++
>>>>>>>     drivers/infiniband/hw/mthca/mthca_provider.c    |  1 +
>>>>>>>     drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  1 +
>>>>>>>     drivers/infiniband/hw/qib/qib_verbs.c           |  1 +
>>>>>>>     drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  1 +
>>>>>>>     drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  1 +
>>>>>>>     drivers/infiniband/sw/siw/siw_verbs.c           |  1 +
>>>>>>>     drivers/infiniband/ulp/ipoib/ipoib_main.c       |  2 +-
>>>>>>>     include/rdma/ib_verbs.h                         | 17 -----------------
>>>>>>>     16 files changed, 16 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> But why? What will it give us that almost all drivers have same
>>>>>> props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu); line?
>>>>>>
>>>>>
>>>>> Almost is not all. Alternative idea to convey this? Seemed like a
>>>>> sensible thing to at least have support for but open to other approaches.
>>>>
>>>> What about leave it as is?
>>>>
>>>> I'm struggling to get the rationale behind this patch., the code
>>>> already works and set the phys_mtu correctly, isn't it?
>>>
>>> I see what you are saying now. Kaike, correct me if I'm wrong, but the intent
>>> of this patch is just to make everything behave the same in the sense that a
>>> device could have a different physical MTU. The field got added to the
>>> ib_port_attr previously so this is giving it an initial value vs leaving it unset.
>> [Wan, Kaike]  Correct.
> 
> No one is using this "phys_mtu" field, except one place in ipoib.

Today. I think it would be better to formalize the idea though and have 
a cleaner interface. Does this cause some problem?

-Denny
