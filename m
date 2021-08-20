Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5963F2C8C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 14:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbhHTM4H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 08:56:07 -0400
Received: from mail-dm6nam10on2098.outbound.protection.outlook.com ([40.107.93.98]:39848
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238510AbhHTM4H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 08:56:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcQRDx94UyYcLpBDW1kGsX4q9VMSUquWHdMUuZvND+nNpfzcpx5aKMrf0NdL/qplqUiAJPrNphcc61ur9BituKl+XX69W3KLWjmhN0NA2q4G9LFPp8zwuHI+WWWVgLU3EhCk+Ir8VMxzklqkswP/oAyK8VHDOQVnwX9R0+JyuNB+bxV+dY2/Aj9J9W2bSL5Fs5YjvGBo4K4XyUcxCLEQ3deETm5PXUL83of/kpHTcHetD/XCDLR8bKJoh8HtZ0G6sg01g231ZTs3YLv/09VHLiVwdY0uILe9noPEUXLALpPMItRUF4fJIPslrd3ruJjIbp2ULQZqyoCwEcEvaMuQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5M9Np6IH6MCArKHhIc/218EeA0FshQWUWPdd6JkbeY=;
 b=lNm3pwRcaOCJ0SgUxO418hZimbYFuLlgWDZIstf2vi8EArLWqwKvHiQRHdUuNp0nEZ33Y8MaYc4AVWtLdQa4E1Axl9LnH8w9NQx1zL0tSydUKjPpIDWYHNYkSakx7hUoKzEQrQng4CbPYK38O4mcGWM+BTsSK8Dmm8oj9aq1xzBGCktYDNZDLupNkLECw/+WIuckN5566hmEANZ56387vBfXuAkCDvczXlD97QD3/ZMIYTF2o2v/TXHg22Hj/0p+A0OiiutzclcU1voXbVSLUjDCQQXgZsYpyI9cg/fChJW2Zm9nZE3UFAXIXQHe13mcJUBxqLPHJiBJVrdiZgj/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5M9Np6IH6MCArKHhIc/218EeA0FshQWUWPdd6JkbeY=;
 b=iB2QxrKwW/QWTGPtBQZKIoB/JXpItfT49xui3t7R85VR8OmKJec2sdFnBl5yL0co4STbKl9VA7XD0UQuCjV08mW67fe0ZABDtC+rqnO/gIqvcHdw/9fsirHd+lEd1id4YRRRN/hAen+v5vcrjOxw64uG8gXjxRlCZHWwRltegKJrN1inO0Ht5pkoQzcUDOvkO67kEL7bTAVd13MKQyWrgKsBePd7i+bd5HLQcRYRA30w9bjKPWpN7sKhlGXTFbC87tOh4pfvbp+oOpuKa1UYu1/e9kyknmcwdDLzDIEnFaLAl5ceofJmWhIvpZhCo+0TqV3UQYZshIpauYsqsLJo6A==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6104.prod.exchangelabs.com (2603:10b6:510:13::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.18; Fri, 20 Aug 2021 12:55:27 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb%7]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 12:55:25 +0000
Subject: Re: [RFC] bulk zero copy transport
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linux RDMA <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>, kaike.wan@intel.com,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
References: <04bdb0a7-4161-6ace-26d0-c3498327d28c@cornelisnetworks.com>
 <20210819230101.GT543798@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <23c06778-f4ff-4d75-68eb-69f7523077b2@cornelisnetworks.com>
Date:   Fri, 20 Aug 2021 08:55:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <20210819230101.GT543798@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:208:23b::14) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by MN2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:208:23b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 12:55:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d82fd9ae-9a62-4fa0-0f89-08d963d9c770
X-MS-TrafficTypeDiagnostic: PH0PR01MB6104:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB61044E2060677B851201F9CAF4C19@PH0PR01MB6104.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1G9UpONDZqxbJAnuysKujIH3P/hq28FaB7JQP/3dP0nnj6Ra1Y8My9qzlUimqYKcpp/wFRXKstxMJcLf1cqdobZc73HL/EmWH/tpfwVWtdeJnAUywkXv8VgSFTUHdDlFPVksXRzqeknAFcwU/yW9Mvw+j4OMNkxEx8Iumq+R8kSC64i6UkuFEdaMr+dxP87faJbqB7D+GDire8aCeiLIUdMwZZSXIzqp+kFw/336iUYWcAR7TnV+Et+O+s9NqoBKWHbjYCwGv2ghJms1HH1uAZlXZTnfK0Gvl/Yg+5ecODHpDdB/umf4G1OBa2490Shx/Z+4/xq5MdUKxmLRfxAVjOPxPkL4nnzbGeiu/J5jUauk0TgRvDmNbKQhukupUcFBnBDT6uNgQHqGfneURSsnfXcuxV8G/ICTB1Mlswl94BIl6x3+1NM4LGAm3X1d1Yf2nzrXTG9X8JFQRTnciG40bnubYffhlZzrEfI2mPXqHnf3C+LV1isWDMIG9V+xhR+qQe9yoEsqdDZwJo1GisRmUPIABmCDaSFd3VJEh5O7C6558hh45q0bIP4Oq6jv2/EoeR/PvO+Lx/HsNhbWJO5nxX8+/i40I9vUfCzdFP2+bd7PyDvkX61rhVos5aItgBeu/MqAQeCZ1t3qjNZWGaA2UV7ogL1T/uiZW8ByTM1hdPmxnG5WYmtS9nFcCw+4lWddyj4XC2nqHfFRAfLVaePjIpr+MYFn2xLkW52JhyQsh8ELpUCc5OX5QZXzDWwFnTvOyVtP2WP/6wU+bj62G6S8JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39840400004)(86362001)(26005)(107886003)(2616005)(53546011)(2906002)(956004)(52116002)(66556008)(54906003)(478600001)(66946007)(4326008)(6506007)(6512007)(186003)(6486002)(31696002)(6916009)(5660300002)(31686004)(8936002)(38350700002)(66476007)(36756003)(44832011)(316002)(8676002)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUFjOTkzaVYzVTZVUVNWSHFDcHV4U2h2WDQzVUlWbldKN2hQN0hrenlBTnZO?=
 =?utf-8?B?V1R2YnVGbytwWStzVm9WNjcvK0FJRCt1SnlQRXdTRU42QmZtcWJmaXp2N2pT?=
 =?utf-8?B?SGlnSUlIUEtSamVmVTNGUG5nQU1QM3VKUE5ISDMrY3pjSVYrak9rOE1TNXRy?=
 =?utf-8?B?VVpjTGlNeE9abXBlYjJmcEdtU3p3SjdUemR4YmJzSldCd0NybjU0Sm1lV2lY?=
 =?utf-8?B?amZ5aEdKeUdPVHNHbXNBKzlQdDEwUVJLdERsVVVSMUlJNVZpb2xzbFVtUHhI?=
 =?utf-8?B?amFWUVI0OVduR1hNWnBuVkNua1EvRmFDNFpRaTdTelBGNzRsVjVpZFRXbWtr?=
 =?utf-8?B?ajB1ZnFLbDNJcDV6SXo1blRIWmdFV1NiRm9uSzNrcmkyQXZhT1lmR1NDanA1?=
 =?utf-8?B?MFB1WnZvS1l4dC90bHZDMVp0Y2FNblUzSVpBM1ZOU3ZLL2N0d241NzYvR1Bz?=
 =?utf-8?B?c1B4b2ZzTXdWUUhGYnhMUWNKd2ZUWlZoQ21IcXBkMlgyS0ptQi9KNzl5Ym5a?=
 =?utf-8?B?OFRvMEJyZFBaeURuNzRtaW9Db1kyNHovT3U0aWhSS1IycWZOYzRWckM0T014?=
 =?utf-8?B?akE2T2E0YTIvUUFBbDhpR091U2N4ZllIWFVQU285VkYzUlRjRUpzSnNFVGhR?=
 =?utf-8?B?ekI5eTE1KzJmV3ZRUFk5RjhzcmN1TWpQUEw5S1EzK05McjBrRXFQQWdPZWUv?=
 =?utf-8?B?a25ab2N0QysxMTBqOE5DVklkYlhHMEk1dG9pM0Nod1NYdXNDdkMzNTEwRXND?=
 =?utf-8?B?b2pGZ0V5K0tYdk1iVzN6VTA5NGdxaUJPK0N1QUVFSU9qRmU2bXRVUU5yQkpS?=
 =?utf-8?B?a0Zvbmc4dXI3RkRsejk5KytIWVJDVm45L2g1VElKUnVia3NlUGhRU1ExditD?=
 =?utf-8?B?dENLT0UwT0RDcS91ZnZrR25rNHJWRkJlcnBkeFZjSVhsdGhPNmROV2IwaHBm?=
 =?utf-8?B?d2w3SkNaTjlLTCtIc0dBRkpDMjM2UVdRUG4raTdMTXl3TmhmUm5hVzZEcXRT?=
 =?utf-8?B?WWp4VWxWazhoZHpyblF0c0tBV2c4WURwVTlHMDhZSzNlejlDT2loRDhJYU1S?=
 =?utf-8?B?WkQ3UDNWc09Yc1BVQUc1K29ITlNpaDBFcFlHWmR5NUlJbCt5bUg0Rng0d0Jk?=
 =?utf-8?B?MjNLVTVQcGZYTGRLOEdqbkRkZ0IxemRLWEdabTgraXIyRDZMVDArZFdHVFd0?=
 =?utf-8?B?NTNoSmdESzRucEdGVVgxemw5SklXQXhXU2xuOXFxWFR5NFlVUWREMzFCRDR1?=
 =?utf-8?B?YmJqcytWdVBFOWVZVkROT0JobzAwNHFjVk0xeEpra1l6N1UwdGdPNVdBZVlK?=
 =?utf-8?B?b05PeFRxZ3hnOXFnR3VpaUFnNXQyUTZKUHk2b3VtMGVOdFh3NERTa2RBOFY3?=
 =?utf-8?B?UGlVNDYwYzVmWC9NdzFKS0NzN0tmazRPNXRxRGxyTndsb2VPbjBldDY0eXRk?=
 =?utf-8?B?dHk4TkhyWk1Lb0tUNWtFNGx1QmZxcjArZzJqWHBQV0txNUpxditwVklyMzJG?=
 =?utf-8?B?dUVsRWJxR0FTR1QwR3F5M3p2S1BzKzIrWitTY3BybXBObm4yN0ZsOUNoY1h2?=
 =?utf-8?B?NGRsVkhXMVRXMGRHeHgwa3NrUWsyaHVkbHJkTXNBRFVJRlJ1dEdTVjU0RUhC?=
 =?utf-8?B?bU0vVjNVT0FpTTdaanVydGd1ZjY0TnFBN0dOZ0dGQ3hXM0lOWjZMS3FHQ2dP?=
 =?utf-8?B?cWlub3NnVURYa1dTdEFQbm11Ly9aMytaalRvdzF4NHlkWHQrbTIyQ0xjc2M2?=
 =?utf-8?Q?Gv/xGFkn83Y4AnggizGGVXAgNIgLEccJgK5f0o8?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82fd9ae-9a62-4fa0-0f89-08d963d9c770
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 12:55:25.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQ9jaSF8stQ8Mu8pMFErfDwok7Md6MIXxOPh0W0pRZqHlrMKLiCjeooc1KGaVeC/2akaB8FDrqG2ulmSRVD42JBb0YhKvsNKsRVKBy1OJahZYL+Gk7+XFUd2BzKXCx3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6104
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/19/21 7:01 PM, Jason Gunthorpe wrote:
> On Thu, Aug 19, 2021 at 03:09:02PM -0400, Dennis Dalessandro wrote:
>> Just wanted to float an idea we are thinking about. It builds on the basic idea
>> of what Intel submitted as their RV module [1]. This however does things a bit
>> differently and is really all about bulk zero-copy using the kernel. It is a new
>> ULP.
>>
>> The major differences are that there will be no new cdev needed. We will make
>> use of the existing HFI1 cdev where an FD is needed. We also propose to make use
>> of IO-Uring (hence needing FD) to get requests into the kernel. The idea will be
>> to not share Uverbs objects with the kernel. The kernel will maintain
>> ownership of the qp, pd, mr, cq, etc.
> 
> I feel a lot of reluctance to see the API surface of the HFI1 cdev
> expanded, especially to encompass an entire ULP

I share the same reluctance as far as exposing it to anything beyond HFI1. The
idea would be for the ULP here to not need to know about what the thing the user
is talking to is. For now it's the hfi1 cdev but could be something else.

What I'm really thinking is this ULP would come up and register with rdmavt.
rdmavt. Rdmavt would call back when it has a HW device register, set up the
rings and the ULP would use the IO URing to get requests to and responses back
to the user.

> As you know I think that cdev is very much the wrong way to design
> driver interfaces, and since all the work is now completed to do it
> through verbs I'm not keen on any expansion.

I agree. What this allows us to do is deprecate the writev() interface that we
have. Instead of writing in the descriptors we will use the IO URing mechanism.
Once we have this working it should be pretty straight forward to move the rest
of the cdev functionality to verbs IOCTLs or whatever we call that interface. So
this is sort of a stepping stone vs ripping the band-aid off.

> But I'm confused how you are calling something a ULP but then talking
> about the HFI (or uverbs even) cdev? That isn't a ULP.

Just referring to HFI because that's obviously what we'll make this work with.
However in theory it could be any underlying verbs provider.

> A ULP is something like RDS that spawns its own cdevs and interworks
> with the common RDMA stack.

Agree. I'm saying we treat rdmavt as part of the common RDMA stack. Yes I know
in reality it's HFI specific, but the intention was to be more generic.

> I suppose I don't get what you are trying to sketch. Maybe you could
> share the uAPI you envision in more detail?

It's all still very high level. We just want to start the conversation early so
we can make sure we march in the right direction from the start. I'll talk to
Mike and we'll come up with a more detailed view for the uAPI as a next step.

-Denny


