Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E443C388D55
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 13:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352823AbhESL56 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 07:57:58 -0400
Received: from mail-bn8nam11on2102.outbound.protection.outlook.com ([40.107.236.102]:25003
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345196AbhESL56 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 07:57:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZuNKnn/MIBth+5+a4p5hzwTkP6a/jZR57tLNRVxdYiyXzD6lvI9YS99iUQniJWFXFmr04zQqMG0sqqLKMap4Ps63ySjW6B0Juu0kGxnPyhht0tbB7xLvfTl2zvQjYfJyo48p1KZwS5QRC96w5mPNneGD3QOHkYfuLjW5RwEzAIVhkPRj5Rmu1LBjpa9oDMnbGTGeWrhprEjJp7Faasa6lS/QqAR5kC12dxgV2yss/npj8bAF7XAOVJEZ1GUYvIiOH7gisZD8iOlKk9bTViqlvvoDooT07OWzky3ehUTM4Cx7DhlZBcYFoh+HBdojNl18zVNoFy/AhuYd5lo3SjPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+top43aIREL1SIpRdLJ4ng9XlIoM1bLVvi5Fr0WMJ8s=;
 b=AnE+alj+VIvkOImSTlOsDikzZ+uWREgohy6yX0heZYBz674YrPmy2iGJ5bLh5u/G0pPk+4uKm2D3tTPvBr5ykmBrHA4jIDOV0pPEYSjz44iZ9jeWNV6QPLguEYypxQ5hmZCjoV7jUk05V/QDcNoVS7tiOezIr1lxKhdG+69FKyb06DnuAhr6wWsWXGw60CUR1Cx9U1APAIcaoluPY0ba7dgv4NUQhPJSR5Cn9qY11a0zQl2I/gHVlhXRB5NPoAFZf6UveFnIlAsZbadN66aWvkJdTX2pMuuyDKOy9LFH7djvQMX0qwN8l3Oxj3qUjEeh+FPPKGAs4vfd/pqsF8TY5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+top43aIREL1SIpRdLJ4ng9XlIoM1bLVvi5Fr0WMJ8s=;
 b=CEqeHf+qke1Vui76ZjdN7poA0CaUxpKR4843lDsZafUf9/qUEw75RBOYZSE4x9cTRrLuTheSY7cjDtxwvNWA9T8BAINtv1Pbp8Bb7JREeQ5hnU4I57vc/e1m+sUGZlPBuu63Qo9aN7IjBdzxaOyNRDxvnE5oMuuuby0qOJkPt0mXx4pkLJI7gkoAjNGbvD662KKeN1f8QzBvAEbC1PtT8tJNCLiGcNzKVpUvol9IOXw/xQHOreOmII34m1f7F6MNFPQg7RJLEVSNa1txOYjeFMyX/UeTV9zGzRL+RbAfXmAcYu6L8UGZ+3HiukTL8c3qdfZAYLSIoigSq8EDlwLRsA==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6620.prod.exchangelabs.com (2603:10b6:510:90::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Wed, 19 May 2021 11:56:35 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 11:56:35 +0000
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
 <YJvPDbV0VpFShidZ@unreal>
 <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
 <20210513191551.GT1002214@nvidia.com>
 <4237ab8a-a851-ecdf-ec41-4e798a2da156@cornelisnetworks.com>
 <20210514130247.GA1002214@nvidia.com>
 <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
 <20210514143516.GG1002214@nvidia.com>
 <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
 <20210514150237.GJ1002214@nvidia.com> <YKTDPm6j29jziSxT@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
Date:   Wed, 19 May 2021 07:56:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <YKTDPm6j29jziSxT@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:208:134::14) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by MN2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:208:134::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 11:56:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3241a2bd-c31b-4896-a70b-08d91abd268a
X-MS-TrafficTypeDiagnostic: PH0PR01MB6620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB662079FD82DF212BD5BB8353F42B9@PH0PR01MB6620.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: osp2cPYMxtwwDT3rU5L5uuMW19obEhpqxLAf1xnxNX3QMWkHTKcnKhLvgIHnu6/mDKmTVj8LlSzGPbx7uZfIGZ9YVnmDITbk7NO0GRd+K3lzGQg1ztXxqxa2hR3s0ymDbrGuBgeBuN/ptd9lkdGJbvgSxnRCrCYvYTJgjDDnKmRar1CKrvz3cVm8ebE83o/C1RRapbsrU5p5KR0OSYYCVLdPCKGAwCSYvUTy7pdWoelBGIWYvA3KQ97KPV2+IZXWxt5pck7IUBkKBQt6o5uYWkKEEWeVqAsPgEWNr6/4bZ7uHQPrwfy+fSa0Kd1N+rDTN3M5ge3pPSHDwf+dFtJiNPc8i9BmjY5maDvirSZXr3cJs/guBHEKi9dxIVqjTQhRDjvZFWU2J0r4HNA5uihY/cpQ04AMyVhoilMzsbbWS9SrPUw4rdLb3AliqiR9oc/+us2LMo5J9lrH6yzmXGqgN+AqSSVQc1tDHbIB8n9mjr3ZVnbp4oY0GzCeU2E4UQhE1nXPUf9Ncas6KhyDNvR+/uWdjEp2Ev28YVOhQ92ccLWI/9iZEkSThTRR5L2/Io6V5BjyPNb/crWCJGaRynZQSNVPoZ/iFPBvk3dUzAhPoXEW0jd9ugeVljPxp+7AAFjo6eulOOcmck3xz5xqem6UPBRJ/eg+4XdLvmwC91qWNgaAOZqMUNMa2i9Dr9KMvMEvV0tlR4juaRoJIcr03ldxGv+aNqcOViCYapSaTWDwW+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39830400003)(376002)(366004)(316002)(110136005)(54906003)(2906002)(6512007)(36756003)(31686004)(66946007)(16526019)(66476007)(66556008)(8936002)(186003)(4326008)(8676002)(6486002)(38350700002)(38100700002)(52116002)(6506007)(478600001)(31696002)(5660300002)(86362001)(26005)(44832011)(2616005)(956004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bEVwU2t2Z0l4blJQaXRtMHlPV2lQNmYwZlBvT0JBRjR6c1BlS01ITXZDL253?=
 =?utf-8?B?RWpBYVpwT3pqd2l3YmRaK3BCVUMyc2tQRVkyVFVMNXY0ZW52MXprMDViek00?=
 =?utf-8?B?RkphVXFJYzFQbnZQZ2xaK3l6K3AzRnZGNE1iYUJURzJWaWVCWEpMTWR2QlN3?=
 =?utf-8?B?bXc1NVZacFZlbXlOZmJFNGxBWEM1b3BNV2JvYzBNMWg4Yzd1YTNMNjJzTTlQ?=
 =?utf-8?B?WlRVMmRBUUR3QkRwcWlFTWpUSjE5cnJ2cTZnclE4R081RWVQMnVWMEpXVGtj?=
 =?utf-8?B?azZJd3U0SnMwZEMxQzFGQ3h6VlFVVUxaaTdsL1BDNUoyUG51R2JjU2thamtv?=
 =?utf-8?B?bXdMSDlrSVIwdGxldW5TVFVtSDBUcE1zZ0pPNU80MktDWU5CeGJpNXUrejBZ?=
 =?utf-8?B?aXR1NjcxcWFXMEUzQWVzcTF2T2NVT3VkQlZjQ0E0RWRlZnpXSzEybXd6WDJ0?=
 =?utf-8?B?SU5YNXRLVXNVOGlldWlPU0RwQnkxYk9lTHo2UXhVSEkvKzJJQVF3Zkk0aWFF?=
 =?utf-8?B?TXBmanpic0FlZk5qMXh2bnpJSHFEUmwzWDBwczBLdC8xbW1mY3Zwc1ZJY0hE?=
 =?utf-8?B?Y3RzNGxmTjdBT3R5YitKTG15NnU5alVSTFZlUnB0THl1STRGUE5QL0hLeGxI?=
 =?utf-8?B?ajdUaC95YXcrVjhBTDhYc2RjeE5CMXlocUVEMGkycUZLbTU5YkdSZ0R3Tlp6?=
 =?utf-8?B?MUtiRGdQZ2FlQjR5MlA4V0IzU0RnRWpQSEgxM1FFb0NxRXJlRUF0WTl1THpo?=
 =?utf-8?B?b2dUb3k0K0NrL3EyRmsxeWJCN2ljTU1qb3hTTlZFT0Uyem5SQWRIcEVydmVS?=
 =?utf-8?B?bEZXNnU3djUwNDlTdHFWSldnV1FCWW1GTUVYTlZtNFRLZDArRVF3UXhpWSs3?=
 =?utf-8?B?RWtHNVlzKzRDN0p5T3kzaGJ6djRjTXdjVFZjVC9rUlkva2t0STBPd2Q4U2tK?=
 =?utf-8?B?UHhyUERnZDZlYkVIQ0lRekVQVm9pbjBWMGxQTE5TbG05Q1UrcjdzamxwemRh?=
 =?utf-8?B?VTdrV0IwL2VFdk1iWTJHZWxIRGFHZnhmWnZyTmI1VHhZWHB1TXZIRkRZSzJF?=
 =?utf-8?B?cEFZak5wQ3ErTjZtVW5yM2VncGQrcXE3MEhXcjBiMDEvcHZqUm8vZHR4TUda?=
 =?utf-8?B?dWRFaVgzVmJxcUp1NlRwTDhlVkZkUGJzcDBFYW5UdjhCZ0xPaUluVlpiMVN3?=
 =?utf-8?B?VTczMGlLTU9VUFhreG5SU3FvOWtQZmFQOGRwN3VMamc2emRPU0hsVWt0OXMv?=
 =?utf-8?B?MU5LZXJ4RFBsdTM1U0lSMEJrRjVPemwzQ1UvODJudWdsb3Q2UUg2RzdwZDJr?=
 =?utf-8?B?emFXbnpBK1hQWWxYVlZ2c2hFaHJuaGRVOU8yS1k0M3BMZnZNeUIvRnU3UE9n?=
 =?utf-8?B?dW85WFA0TEFyWU01bHBHTHlFY3ljWlhQRTBnZWdhVEdIRWdHbUROV3dLVG13?=
 =?utf-8?B?THUzNHFPQ1F2U1ZjTDFtYTQxVkxKcVhqbGNBV2N6cVM2cGZiejZYb1Q5Qk9u?=
 =?utf-8?B?ZGpxWGdqMElMdVZqelVQdmZ5VnlTYVVaVVlqWnc2cU9uSmJySEgrcFZONGZp?=
 =?utf-8?B?eGpuSjFUTkFBSk9RdlhXc0x6OXZCNGRGUXhVK1F3WEdLSFhEbVFjNGJvOXlu?=
 =?utf-8?B?ckI1NFEydDJYSlFDTVNGejdxaGRFRjBBUTRySEc2d3VOOWpUK3BlU2JYU0pi?=
 =?utf-8?B?NXBRNHRnT1lpTnZEaDMzamRvWFFETitqejViRDRDcWJsUGExLzdFbE1oazhD?=
 =?utf-8?Q?jG0eBdofCVkTG+DVFupiGWJJvNleTy4jF0tPmu0?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3241a2bd-c31b-4896-a70b-08d91abd268a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 11:56:34.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/NOG8lDQypvfptdv8HjaKdJkcIr0wGXgyRmBcxzs0inZK3fMU20y5Bxqg2QIPHgwiYiw91MDm5N8fG5RLI1SiKoHIVPNBygyYXtB4RlZxGlfHwf/1Ix8ffdsLgELVCz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6620
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/19/21 3:50 AM, Leon Romanovsky wrote:
> On Fri, May 14, 2021 at 12:02:37PM -0300, Jason Gunthorpe wrote:
>> On Fri, May 14, 2021 at 03:00:37PM +0000, Marciniszyn, Mike wrote:
>>>> The core stuff in ib_qp is not performance sensitive and has no obvious node
>>>> affinity since it relates primarily to simple control stuff.
>>>>
>>>
>>> The current rvt_qp "inherits" from ib_qp, so the fields in the
>>> "control" stuff are performance critical especially for receive
>>> processing and have historically live in the same allocation.
>>
>> This is why I said "core stuff in ib_qp" if drivers are adding
>> performance stuff to their own structs then that is the driver's
>> responsibility to handle.
> 
> Can I learn from this response that node aware allocation is not needed,
> and this patch can go as is.

It's pretty clearly a NAK from us. The code was purposely written this 
way, it was done years ago (from day 1 basically), changing it now is 
concerning for performance.

Perhaps the code can be enhanced to move more stuff into the driver's 
own structs as Jason points out, but that should happen first. For now I 
still don't understand why the core can't optionally make the allocation 
per node.

-Denny

