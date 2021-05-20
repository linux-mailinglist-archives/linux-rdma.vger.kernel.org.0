Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A3538B957
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 00:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhETWDr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 18:03:47 -0400
Received: from mail-bn8nam08on2118.outbound.protection.outlook.com ([40.107.100.118]:30040
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230270AbhETWDp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 18:03:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEZfTq+HTqXiGam1B1yFSpZwLA8/Hjkkga+ubvsxaHK2DrNoyinKa7ZDehBJknX0Z42AmTL71R/rmoH+70ypL7jzeNpv0hESUxVccVCFbDiXrC01qYz/bzOO/Z38B/Xp6PUAK6Sk2CG9UOx3tfdsetw6NZugfNtE+EUCLik21O5uPCXh6fUWWSbnMaYxektV9iRCGlqKTzEdkEASLExWeW4nIf//YbqDujHlqsbkq4TDlYFVurdm0miJw9Xdfpw7kJGrAm3RND4gCD5wag+PtVaR9ryEYBvQZL8QsPWYfCF3iCW9QNUDkQ4earG94xQ+1QAcLy5ebp6d0zBB4SQFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWDYjlIOhuJLKb5krRn3ncNwm8xjetPfunuT4EGfASU=;
 b=kr7WaJPvpzH38OunAdxWYHYT8fMK+LbOXE1ir/2FY+o+IVapyRvmq2a4P3qRVftdy+8w51oKJ5sPda6C0ByA7tFQLHxb5MPzU0FlRDmwZePdqDpt98WJ2CSi61AwW89TnF1RHtA2vvZnIDA0IgP4Zxd0qQoG3ElK/IO7szUBA7N659aBeeldwqXCpVqInYk59MQgCTr1lycmw1xB3whSg1qN7G3waJJFPWaCaSJ7WQz+lFcbJbuIebPeLD0CrDUyri62ryhhknpkQXIXdX2bTz1N1zQhRikzR8p9pZu2+Hb26idPo8mm8thMVIABaDx368Km2+OeJ9lUKrTchce9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWDYjlIOhuJLKb5krRn3ncNwm8xjetPfunuT4EGfASU=;
 b=EUZDGrnDQe+YtMKnvVMrC3nGMiDSwIMDFDBBH9Hscxhz/v6dOQAQ4/rc5YFNUvowWZXtogClrQhZ61wHlH3Tjkg4VvDHNpBDSD3l7qKFMdrpCbk9m6NzMIgz/u8GHiLYhp3ujmABvRKNEB/MzqhJmkmmVrXMxXsqsw8mQZInhpRihNpLCueGkJ1m29TldLZbj1Aj3g9LugJSn5L9WOgF7UNSwCg5QGiX2jSFiv9lsHcsx6hdCS5MfbUAw0HWcoFVa7zUFYvJAuUYc/7ziyejNZKUIwBzqJchX/q/VthrVAkatI2o3adzq84Og2Wjn5SFUtOGc5KnR8PJOqZkv8plLw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6446.prod.exchangelabs.com (2603:10b6:a03:29e::12) by
 BYAPR01MB4854.prod.exchangelabs.com (2603:10b6:a03:8e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Thu, 20 May 2021 22:02:19 +0000
Received: from SJ0PR01MB6446.prod.exchangelabs.com
 ([fe80::495c:e39b:be49:9f00]) by SJ0PR01MB6446.prod.exchangelabs.com
 ([fe80::495c:e39b:be49:9f00%7]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 22:02:18 +0000
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <4237ab8a-a851-ecdf-ec41-4e798a2da156@cornelisnetworks.com>
 <20210514130247.GA1002214@nvidia.com>
 <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
 <20210514143516.GG1002214@nvidia.com>
 <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
 <20210514150237.GJ1002214@nvidia.com> <YKTDPm6j29jziSxT@unreal>
 <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
 <20210519182941.GQ1002214@nvidia.com>
 <1ceb34ec-eafb-697e-672c-17f9febb2e82@cornelisnetworks.com>
 <20210519202623.GU1002214@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <983802a6-0fa2-e181-832e-13a2d5f0fa82@cornelisnetworks.com>
Date:   Thu, 20 May 2021 18:02:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20210519202623.GU1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: BL1PR13CA0288.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::23) To SJ0PR01MB6446.prod.exchangelabs.com
 (2603:10b6:a03:29e::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by BL1PR13CA0288.namprd13.prod.outlook.com (2603:10b6:208:2bc::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Thu, 20 May 2021 22:02:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f565080d-af9a-4786-2799-08d91bdaec84
X-MS-TrafficTypeDiagnostic: BYAPR01MB4854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB485447ADB77A0D88F2F55152F42A9@BYAPR01MB4854.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z29o8sIP9xZ4AN2VtlPDFeZy2F7AHPYV2KdOMju+lBwRUTYv5tP0jqSnzwZlTqxoTBOwVEcS5XjGsdmu3WF4M2E0LuPvYMbtArHuvAzAK4fc9sqEhNz6BMjIzT0SZ2vL595/Tv+KZ0Ctmu1uo5mujYk4aYrKaddsiBlRRZBWJTgP6uDJrvjK5YY3V5V9ThLNKKh6i45Rzk0TI5CjyL9t2SSNfklX7Apmbr7NqwscrB8yNKsg1zmdbvC5nqZ5ztNfYQu3M+8FTu/qKmukrCqfLAlLS9Nol5Woa7ex9EccBH1mwRxCKPJTTNVlYJifkdl85Dha2YdSJEKVLK4F3RxzlV2/5mXwH1/iL1VTgJ24dgsWwqa3H1D2FP6bfM16zRll260AwU4BnRcippknwRxhSBya41zmbnUdBQbbvuhu2G54l7izskDOv7d1oYrYatHd4kcbxr32hENFjQERkEudOXCsnRVwgqJmn1TX1ur0SbLgd2hwHnKoeRS4tpmuNSNVEKtkn86Z0ItxA2gB6kVtjoEzJ+W+cR9G+YdCdH2sxcfXA2zGpKfAjvlUHJb6/9p2hJ9SfELWkVrHnLfj7qaQMSEsnZxY0yVWjLyj6ZGZIl8+9VJTIrJv0jG6yWxeeVe85c+Ci2FPMyFhAyWEVd//OklvO9LjhrV6sFrsY4/eQpyL0UmfopSbxo2onUcPDl9ZZzEmB6hz6JGmS2OJdHGCoUBCZvr/Bcdq5pFlRkrPRvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6446.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39840400004)(396003)(66556008)(66476007)(8936002)(6486002)(66946007)(478600001)(31696002)(8676002)(44832011)(38350700002)(86362001)(38100700002)(52116002)(316002)(2906002)(6512007)(31686004)(53546011)(6506007)(26005)(54906003)(16526019)(186003)(36756003)(956004)(6916009)(5660300002)(2616005)(83380400001)(4326008)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dUFvcVJYUWd0Yko2b2hpU1IwUEVxb28wd1g3T2tya3VUeTg4aTk3N3RuWi9X?=
 =?utf-8?B?VmxMTlFuVzFYMHN4RnZyVmpGQk9laEVWQmc1bEVoemtYUDFwUHVuYzRSc0FT?=
 =?utf-8?B?c3ZYOEp2eUQ3QTZjRnJMYk52UHJ6T1BuN3kvOUJSVHZJRzdxTitFcG1HRlRZ?=
 =?utf-8?B?Tnp1UVRxYUJxUEtINWNMY0k5dHVIanRSVStZY05hcGwxZlQ2bk8veGxiSHBu?=
 =?utf-8?B?MUpzWFVUYlEreVRmNHB3RjJOa0k5MXFVZmc3N3ZNOXlBVHhmd280Z3VLSlhw?=
 =?utf-8?B?b2NUNTVjUzh5d3NKV1JRYVFoczNwVGozeFh0OTBJV25uMkRzUENJaEpOQWx3?=
 =?utf-8?B?SmtCWlRaUmpwWVErc1BVZVhhZUpvdmwzcGppNkNRSE4wVnprU1ZrZ1NuNUph?=
 =?utf-8?B?aGpFd2w3R2Rza0QwN2h5RlhuVmpjazl1cGFJVGVVTVlmNEdQT0g2SnYwQ21F?=
 =?utf-8?B?RGRQaVd4amxNRnpEdURvakRhamF2cm1yblBnSHgyWXFmUmxtMElUMzlQQnVo?=
 =?utf-8?B?eis4bjM2d1hOaGlwbFdmYndDd0M3N09DV1R4SnZDZWRLZy9jM3hHQXZTOVEv?=
 =?utf-8?B?dDQzUkI3dE8yTTBXSkQ0M3ZSZlZvakJGNGo3WDBzMVIrbEgvSnZoNmJzNXRl?=
 =?utf-8?B?T3RleGxQdWdaMm1KR0kramZnQ3dTZm1KWWhkeEZRWHhHWnBKemp2SWxoV1Ur?=
 =?utf-8?B?SGYyc08wYmFSdUZTZEZpTFFWNjJaVXNnQ0szSnJ6b016UnB6RTMvNTlLODN5?=
 =?utf-8?B?N084WTNmTGVmczlTUE42WHVqdE5wRGdWTFl6MTF1VkRJMkYzS2VjU29MeHUz?=
 =?utf-8?B?TUVoK1dnbnVXTHRVNkw1M2dTMXJnYWNlaFdsbU5pOXp6dXM5eDdySXErNFYv?=
 =?utf-8?B?WXppWS93MHBXemdSZ3lnOFJHWGp5SU5Cd2Fmajc2aEdQQmxTKzlmbnhFbGV1?=
 =?utf-8?B?OFpYZS93NXBtSDdVMDBrYm9WM21NUDdPWWJyK1hQb2NxZWx0aDIvdVNNRVhx?=
 =?utf-8?B?YVNmSVJPbEgyd3JvQTlFYytHMkswcC9xc254c0Z5L3gwV3ZyUHFGd2tpaTc5?=
 =?utf-8?B?akxmRW1HaXlOaHl1VDdNYUF5QzJERzFERVU4RFI4MEJ4czN3SmhlOWxKWWsw?=
 =?utf-8?B?eDhZOXl4d0xjRnVpaCszTzNucG1PR2hGeUpIcWg2eDlWSGMzZ0NMWmVKb29Y?=
 =?utf-8?B?YS9pN3dkNjNyeTVSZkowUG1MZUV3K1hHZUxwTGxsY1dheWF4VkJPcktKSGlX?=
 =?utf-8?B?b0JRS3ZIVjR4SzdSU1BXV2NwWFpyd0tEaExpU3hmdVZMcHlsbDAwU1o0RmMx?=
 =?utf-8?B?dEo3N2xkUURHM3B4NlBvWW5ZK0trYWZ2Z1BLQW9LWk1yUEU3Q2hjZ052YUVG?=
 =?utf-8?B?WEMrSUF3UlJxeUEyRzBuYTlCL0RIVFBicEZLWC9Xc3lWelBLbVBSdVpDSi9F?=
 =?utf-8?B?ZlZEVU9ZcWd0UTZsMmxDZTJxdy80UDE4bWVzRG1kekJzRi9vTGVuUVoyMXlu?=
 =?utf-8?B?UWl2SHhlcFpBTXU3UkVLeFkzZ2pOR29IODRvMWlmT0gwc285c2tZalJ3cDR1?=
 =?utf-8?B?Vld6T2lac25NMnJtM1VFcU9iT1Rmbk5PUWlKYklzQVIyMnlhYU1JVmpOU0sx?=
 =?utf-8?B?MTIrTStoa0x2ODJqUTlWVFJveWJ2UnFnRDJJK09nSGNLVzg2Ni9pS0VhN01U?=
 =?utf-8?B?Sy9WU3VqQkQvVGdXUHA5RExaQWZSMllXT3VYQzNuRzB1eXFXRzRhc1M4dzAv?=
 =?utf-8?Q?yxqmXTYntA8xTL4kRWUtTXD9bHt0nFeL7AWtqEN?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f565080d-af9a-4786-2799-08d91bdaec84
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6446.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 22:02:18.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnN8XeM8rdQkkftbx69x98FKlyYRHbE79LX/Tpyfy/ASgw3FNCsnY71swLgd4Qa68LMo7Td0zfTiwGLZspNzOwnOv9t1Cr6PuTCFrOccu787teX1CuMhkwda3BnWYeAb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4854
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/19/21 4:26 PM, Jason Gunthorpe wrote:
> On Wed, May 19, 2021 at 03:49:31PM -0400, Dennis Dalessandro wrote:
>> On 5/19/21 2:29 PM, Jason Gunthorpe wrote:
>>> On Wed, May 19, 2021 at 07:56:32AM -0400, Dennis Dalessandro wrote:
>>>
>>>> Perhaps the code can be enhanced to move more stuff into the driver's own
>>>> structs as Jason points out, but that should happen first. For now I still
>>>> don't understand why the core can't optionally make the allocation per node.
>>>
>>> Because I think it is wrong in the general case to assign all
>>> allocations to a single node?
>>
>> If by general case you mean for all drivers, sure, totally agree. We aren't
>> talking about all drivers though, just the particular case of rdmavt.
> 
> I think it is wrong for rdmavt too and your benchmarks have focused on
> a specific case with process/thread affinities that can actually
> benefit from it.
> 
> I don't want to encourage other drivers to do the same thing.

I would imagine they would get the same push back we are getting here. I 
don't think this would encourage anyone honestly.

> The correct thing to do today in 2021 is to use the standard NUMA
> memory policy on already node-affine threads. The memory policy goes
> into the kernel and normal non-_node allocations will obey it. When
> combined with an appropriate node-affine HCA this will work as you are
> expecting right now.

So we shouldn't see any issue in the normal case is what you are saying. 
I'd like to believe that, proving it is not easy though.

> However you can't do anything like that while the kernel has the _node
> annotations, that overrides the NUMA memory policy and breaks the
> policy system!

Does our driver doing this break the entire system? I'm not sure how 
that's possible. Is there an effort to get rid of these per node 
allocations so ultimately we won't have a choice at some point?

> The *only* reason to override the node behavior in the kernel is if
> the kernel knows with high certainty that allocations are only going
> to be touched by certain CPUs, such as because it knows that the
> allocation is substantially for use in a CPU pinned irq/workqeueue or
> accessed via DMA from a node affine DMA device.
> 
> None of these seem true for the QP struct.

Will let Mike M respond about that. He's got a much better handle on the 
implications.

> Especially since for RDMA all of the above is highly situational. The
> IRQ/WQ processing anything in RDMA should be tied to the comp_vector,
> so without knowing that information you simply can't do anything
> correct at allocation time.

I don't think that's true for our case. The comp_vector may in some 
cases be the right thing to dictate where memory should be, in our case 
I don't think that's true all the time.

> The idea of allocating every to the HW's node is simply not correct
> design. I will grant you it may have made sense ages ago before the
> NUMA stuff was more completed, but today it does not and you'd be
> better to remove it all and use memory policy properly than insist we
> keep it around forever.

Not insisting anything. If the trend is to remove these sort of 
allocations and other drivers are no longer doing this "not correct 
design" we are certainly open to change. We just want to understand the 
impact first rather than being strong armed into accepting a performance 
regression just so Leon can refactor some code.

-Denny
