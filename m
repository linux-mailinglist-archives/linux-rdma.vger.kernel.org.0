Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75EC3426BC
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 21:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCSUTN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 16:19:13 -0400
Received: from mail-bn8nam11on2134.outbound.protection.outlook.com ([40.107.236.134]:17972
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230092AbhCSUTL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 16:19:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMTvPy8/8o9JIAbaYTP9nCUcYUTqudNtB02CT5jUbyTQDPbgZxDe9A4IiOcxT+jcnbvPE/hFxrMjXK2J8H9ICkrukiwYMBvy37bc42xYQncML5z7/yIZxZ9zaIPy2RheJw36Q4P/AWxuLTaCG9TUoGinx6ASnitKtLdOPoBKHdmXuTxnFKi40wKnU7vudtDBAGJCbxIYSnPCvivc2QQWKH4XkJQRNxwPrRqELibre0BuR0KYBmIHKyJLiG7tshkzlv0mpfP59sCq6VDQ+dHBSWaiggE3XTYxrsd4wbBF06lK9AMisrY8zjEZGcSXKwXCF4Po/sXTqgRJDejwMm2efA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TV716uxsav6zWVA8rDQvfMqRnKp0zN8hmtDPWrPeNY=;
 b=BDPBIpU5/jK1QqZPNyF+6Z44n2npL7ulypO6ymd6LcrMmLBE8Q+gMwiwr8sFJGdC+CAE+QytybkTkYxyPMFNgIqL97gfUWDbjCwjBHElschFNo6DOCJZqUYaqrtPTJEmrMQLh4Z9cHOKmr6Ybc9ljA1dd/pP3LscQkWKB2Eem+GUcLHyIABF3w+Song83H+7zU3TrpgaoEGEbNZ1RKPl5bb+p0IBSJOc+MVK2Q2zj4BrNctkq8rPnAvTxzNosOruWtNsuW7BZ9jRonOzyxNRg771CLVniZZGQhJgeaZ5NnYMhPjS80ypNdOz8FQYGh/ztexfNM/MB4Y4FPK0s0DZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TV716uxsav6zWVA8rDQvfMqRnKp0zN8hmtDPWrPeNY=;
 b=lfZwW0AzvwAN0dSkHlfNbsyQRP7DdHiCBDuPGEMal7M/g/lLO80J8khkpscyE2x8llOfHzQg1aM+oqGkxCl3Db/tcfvbxucNmJEiq1d72c5fcs2qO7jR5O38mnuf9rQwUz3Cm8hqJIT1H30es0YEMIwWlfWdPhgz9TJQa+tiP2ui3tSND63BE5W51MIsl+sNpAhXeBPxuXW92hEaW8k9RF1mst3w56+uqc9VVce3kanVrk1JCziT6rXWwSgXm/3kOwVZ34p0p+3hQ+GfixerYohUNmdQyM4PHfYBj4NsJGkebA8CXEnGtrThpTmnryKYLSY1rottgK27kV7wTJl74Q==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6357.prod.exchangelabs.com (2603:10b6:510:1a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Fri, 19 Mar 2021 20:19:08 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 20:19:04 +0000
Subject: Re: [PATCH RFC 0/9] A rendezvous module
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <ed0d861c-4352-8568-b3c0-31a0f1eac228@cornelisnetworks.com>
Date:   Fri, 19 Mar 2021 16:18:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210319194446.GA2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: BN6PR2001CA0011.namprd20.prod.outlook.com
 (2603:10b6:404:b4::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by BN6PR2001CA0011.namprd20.prod.outlook.com (2603:10b6:404:b4::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 20:19:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70501daa-c6f3-4c53-144e-08d8eb143df5
X-MS-TrafficTypeDiagnostic: PH0PR01MB6357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6357433141D2FCDEB2065000F4689@PH0PR01MB6357.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/MaLCT5D/egOofZq/LrHjfFeClk36v22JlI2VGsbZ7pIkTjRtnmLDkj8t63X+Z4vTbNr2ZsMokUnHW3SyedGsQnaooRYVHxa17amFnEn/VymrW+T2qFLR4qELHoBplE41AXbcSf5ZYrLtiGhUL0HyEiOrZe5PLex7sZ9n65iLHQz9EPpnDMYZ8DQB7ACHe/PrQxL7YAYKmyclYWxNDlIsCx98nA1JR9DTd/lFmsNz3jjuggvZt2H87bGYjOABkwaD6eWEyXT5QzkAPIvJXv75FKwiH3LzHAnqjyF0lZ516ssbKHI6k7tqCxY9X3YdkEXpb8ILRMfeL/ZaT9W5az9dYkn42vVWqqgYDfvfCvlLqNuOfmyXq+uqMBJMV24PVmqrAdVAI2IeFDjLvSLWckoekkMTHS4RhywZ2v0pmFiP/Rdf9v5GbMSOS6svMjqD7hpQvX6PQUcUMXzmbpwcX1f97XaxjXN/CSI4eBXrz+CoTemFPY/yyRnaLrNOOr2huRNjnqq1Mwi45y01xo4KPc7WkO/Vi5/iUZN9nP8boYtrwAQoVF1NL3bF7BQ+K4hFaqQBkpaI7V63AN1w2UHhOiv6v8dswnriI5vQpLUQlxQYhz5dzQ2Yws1aOx8STqHT5Yhlvl7z6MvgU1rKQlf9i/rgiOIpsL4W+2YSt/p7H6Sjm11t79DrK1OrAx0W/uyhgPHVanJpJzeEiImXtVT+rYXSXsyH1evDVaPpdNIX+8QVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39840400004)(346002)(376002)(366004)(36756003)(52116002)(31696002)(2906002)(8676002)(53546011)(5660300002)(6916009)(6486002)(6666004)(8936002)(54906003)(4326008)(38100700001)(66946007)(26005)(478600001)(316002)(44832011)(16576012)(16526019)(956004)(66556008)(186003)(86362001)(2616005)(31686004)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cEJDU0NlV0RpK1ZHeDMyWVVGeXZwSThBZlBNSFZKTXQzOTkvenUvUEdUTEpQ?=
 =?utf-8?B?Q094enhHb2pyajhiVmQza2NIWWxFeXRlMVNxYWR1dWloSEQxTURYR3ZERFd6?=
 =?utf-8?B?Sml0bE81YjNJV284RWlqaHlXY3pnRkUzRTVmNFJ5TkhvbE5KbWpzNVRjSkpK?=
 =?utf-8?B?RWx6RFRaSThodWRocXN2clpJWkw2Y0xJSFJHMDIxRDg2L1Q1anl1dU5PSWU3?=
 =?utf-8?B?ZHV2aWtRUUxMdVZMbmJRbHhtM0d1SjNaOU00WXE1UHVrTGVYZkp6eURFdk85?=
 =?utf-8?B?dXkzdGI5NGhtM1RPbWFVWEI0cWp6TmZjUGcvTnRuekRXem1nN3FQNEVEeFhu?=
 =?utf-8?B?Y3RybnNIME84cEhtTEY2cHlqOE9PbytSeiswWGliSDV6NGxkdFhXT2V5SWlV?=
 =?utf-8?B?VXJsZ3RDSlprQjVIN2RQSmUrd2JLK3ViY2xuZU93L3dUaXR4dmdqaGg2TTVW?=
 =?utf-8?B?OHM3YmhpQ3ZUVUM1S09VMExZblVIVHl2ZldLQk9XWlMwUDViOHcxVzN4eHp2?=
 =?utf-8?B?WGFWWEFNUWg0KzM2WjkyNFROV1FTNDZHVjdOVzYxN25YMXJZb0xkMjh4ZGdL?=
 =?utf-8?B?OTdNRGhWSW91TjN5Z25XbXNFSzhTUVIrT2t2a3hzRTF5TzVYTlJKQU5sQzhT?=
 =?utf-8?B?OXQ2VzhhcXdIUTdNNEwzL3JyUkJsWm4rWkh6aGZ6dUh1U0NtajVWeitCTVYw?=
 =?utf-8?B?WkE5YmhGeW4xVzJqZWU5d0Q3OUtMODBIV3Rma1BGU2ZSZGorN1RvRXplQkZQ?=
 =?utf-8?B?YWhtQzg2VlNINnZJeUM2Y2dKaUhZRGRaSFNMZ0RxTE0yWkNWN1AreTVEekNa?=
 =?utf-8?B?TFRYLzRaN054MHdhS2IwaTN4NWYwRFRUZVF6UVFVdGZVZzJqaDhYZEdVWHVO?=
 =?utf-8?B?VmtDc0RweEkyOWU2S3BjMUphVmdCblpvdWxLWDJ4VlRiSkdpYVdVTVVVMi84?=
 =?utf-8?B?eWQvOVVCK0tnUzVmM002TUtFTGFKNmtrSkdWd3RnK3FjS2x2QndWV3VXODRN?=
 =?utf-8?B?OXNZZTIvQ3dFVWRPN1puRlJNNExvalhwUjlTTzFqeUd0S3llS2tzN3daUHRW?=
 =?utf-8?B?VFlyUlZtdktOY0I0amdMUzdoaUJQYnU5cjh5bGZtYStxcjBVdWdwd1hLcnMy?=
 =?utf-8?B?cnBHWVRnV1hOZjF1RTR4NHQzN1ZaVTRZU254d0RNV1JXS2E4eXFOaWw5Zld4?=
 =?utf-8?B?QzRRSUFFMExxaTZ1TVRxbkxMUEVLeFVVakZXZE15cEhJVHRRQkZIaFluNGNy?=
 =?utf-8?B?b2lsUEpnM2JlL1Viam5DTEJQZlJyUGkxcXlwanFyMkVWMlVXTm9ybTRLWTJP?=
 =?utf-8?B?ZHBOUXA0TEFnd3BWdU5iVk12eGM2RnBJSEJoUUYrWm96Y0pnb0ZCS0ROc1Jl?=
 =?utf-8?B?Y3RaTlRCRENUOHRvaFAwcHBSc0N0d1FuRmNMS3ovODVhdHpsRGVQM2lxYUVt?=
 =?utf-8?B?T3M5Wk5QOVEzNXpRVTBmcnFocm1jVURlRHBCR0Q0SERLSGNkdVp3c29yZm13?=
 =?utf-8?B?MUh0MTlheUI3SVl2c09saEZmT0ZJT2h3Q01kUDRmREo4dEFJZWVmWi9WUHpE?=
 =?utf-8?B?cEhhSDN4aWNqKytoU3BnMTNBaFhoMFVSempYVDVSQWhIZmlrNkRjQm9DQWF2?=
 =?utf-8?B?VGw5ajhKV0d5Y3VLQjM5eW9KMGJ1V3JtdXBGK3dnYkV6cXUrMnpuRUlRdG8x?=
 =?utf-8?B?UHExd280cG5pLzcyVnZBQ1Q0SjNNZmo2YnZsRXEzUlg3ZDYyZFBKU2Rrc2Fj?=
 =?utf-8?Q?bximiE6k/S819+d2OasMsLfETTFQE3JCQYC65TC?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70501daa-c6f3-4c53-144e-08d8eb143df5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 20:19:04.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPieQhs10Oeovg6jFN9aEWH6KiRIyOcLKOcE/NDb5J4XqArIMO65E5Bejn5Zun80hmtZWjR3lOrLL7r7PDvGHtnpB/FVR6uLQY1kiEYzfNyW8KhlOsKVG1/suInullYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6357
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/19/2021 3:44 PM, Jason Gunthorpe wrote:
> On Fri, Mar 19, 2021 at 03:22:45PM -0400, Dennis Dalessandro wrote:
> 
>>>> [Wan, Kaike] I think that you are referring to PSM2, which uses the
>>>> OPA hfi1 driver that is specific to the OPA hardware.  PSM3 uses
>>>> standard verbs drivers and supports standard RoCE.
>>>
>>> Uhhh.. "PSM" has always been about the ipath special char device, and
>>> if I recall properly the library was semi-discontinued and merged into
>>> libfabric.
>>
>> This driver is intended to work with a fork of the PSM2 library. The PSM2
>> library which is for Omni-Path is now maintained by Cornelis Networks on our
>> GitHub. PSM3 is something from Intel for Ethernet. I know it's a bit
>> confusing.
> 
> "a bit" huh?

Just a bit. :)

> 
>>> So here you are talking about a libfabric verbs provider that doesn't
>>> use the ipath style char interface but uses verbs and this rv thing so
>>> we call it a libfabric PSM3 provider because thats not confusing to
>>> anyone at all..
>>>
>>>> A focus is the Intel RDMA Ethernet NICs. As such it cannot use the
>>>> hfi1 driver through the special PSM2 interface.
>>>
>>> These are the drivers that aren't merged yet, I see. So why are you
>>> sending this now? I'm not interested to look at even more Intel code
>>> when their driver saga is still ongoing for years.
>>>
>>>> Rather it works with the hfi1 driver through standard verbs
>>>> interface.
>>>
>>> But nobody would do that right? You'd get better results using the
>>> hif1 native interfaces instead of their slow fake verbs stuff.
>>
>> I can't imagine why. I'm not sure what you mean by our slow fake verbs
>> stuff? We support verbs just fine. It's certainly not fake.
> 
> hfi1 calls to the kernel for data path operations - that is "fake" in
> my book. Verbs was always about avoiding that kernel transition, to
> put it back in betrays the spirit. So a kernel call for rv, or the hfi
> cdev, or the verbs post-send is really all a wash.

Probably better to argue that in another thread I guess.

> I didn't understand your answer, do you see using this with hfi1 or
> not?

I don't see how this could ever use hfi1. So no.

> It looks a lot copy&pasted from the hfi1 driver, so now we are on our
> third copy of this code :(

I haven't had a chance to look beyond the cover letter in depth at how 
things have changed. I really hope it's not that bad.

> And why did it suddenly become a ULP that somehow shares uverbs
> resources?? I'm pretty skeptical that can be made to work correctly..

I see your point.

I was just providing some background/clarification. Bottom line this has 
nothing to do with hfi1 or OPA or PSM2.

-Denny

