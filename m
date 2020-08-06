Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D8523DA76
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Aug 2020 14:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgHFMw6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Aug 2020 08:52:58 -0400
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:21921
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgHFLNd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Aug 2020 07:13:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH0NP/ByynYeeEiZQ8onp1A8UD4jbLcipHyyWSVVpRTtRZmtYJSLBRWX9m2a54VFfEC7ciklyikClpZ8U5Isz9UmVLHbrXg4sexuexK0jhE+3LtkoXJ5NT5Eo30VYWk9fIpEN1EfK4jG0QPecXN1wbBQ6uHCnOhr4gA+UPacOmkpMBJRijLGQRnB44QERDYdQRjMJAT9z26Uf5w5xpdE6rvKMerDJMc/PrxOweuqn63+U/L6ixYl/2qZ7MWBxr7Zh6heYuHhg0I/n1pkA8V3ZL4tm3doV61Q3mntnI6W4gW09dOfOO7Y9I13TBPVAfoPpHt3J/eUwduGPlPb6v8Wfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4QJgyWSRYNSLa/ihhgH+8UEDfe2SMP92w2nynqI+Sg=;
 b=gqP1bHFRbZF+ses4cvbp241qAbN0TpOTt1o6sF26cCRYWAchgW0eJpXgYYdKc1H4OFeAtxvvuWhZrETD4azUMUhSxJdUuQ71Rd8UdUEO2LPxZajm66nmaNSxA44xGQcMh9kRGXGkJ5py/Ir7hSYHSs2aJGTQnlUxfjtnH6UAaKyd9XhoLJw5y8NvlXtCSucT8A12jSygtj54CFRqptTBZH0HCfPVTpCIVtMyPB/Ohy0nafozEyreUKXgeSgItRQD54HTCF24wbPr+qoIzQjL7ol+Q3gk/CAZQzhZy3RnKO0s2L0LXgsCKS/xMrYa0Tn6I0fTbrxS3+QBrYZwp6qi2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4QJgyWSRYNSLa/ihhgH+8UEDfe2SMP92w2nynqI+Sg=;
 b=frSWXkNSsIq1PM9Su0APPWuRvwZOrBSZqo8TKw8xqkYjgexlOGr1K07coWmiEc49PVlLnyE+Bhh0+H6xkOX7dgtaoYLf4dPnlXkM8f4A8YkRU5pSlbti820fH7J6T7lWUMT4hrTngWs0NZqDEoeRJUHfhKohGtEniDBSJqL7T4U=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM4PR05MB3314.eurprd05.prod.outlook.com (2603:10a6:205:d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Thu, 6 Aug
 2020 10:56:45 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::95b6:b863:de2a:c8e0]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::95b6:b863:de2a:c8e0%7]) with mapi id 15.20.3261.017; Thu, 6 Aug 2020
 10:56:45 +0000
Subject: Re: [PATCH 1/2] IB/isert: use unlikely macro in the fast path
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     sagi@grimberg.me, linux-rdma@vger.kernel.org, jgg@nvidia.com,
        jgg@mellanox.com, dledford@redhat.com, oren@mellanox.com
References: <20200805121231.166162-1-maxg@mellanox.com>
 <20200805131644.GJ4432@unreal>
 <3777c9d9-1d36-f8e0-624f-aa633fd517ab@mellanox.com>
 <20200805160601.GL4432@unreal>
 <6cd8d78e-3017-696b-508c-73c3c8b92802@mellanox.com>
 <20200805163738.GM4432@unreal>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <3deecfcd-b17c-1fe8-88e0-ad45b4008f57@mellanox.com>
Date:   Thu, 6 Aug 2020 13:56:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200805163738.GM4432@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0039.eurprd07.prod.outlook.com
 (2603:10a6:200:42::49) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.155.75) by AM4PR0701CA0039.eurprd07.prod.outlook.com (2603:10a6:200:42::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.13 via Frontend Transport; Thu, 6 Aug 2020 10:56:43 +0000
X-Originating-IP: [217.132.155.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9603962b-0cce-4dc7-54a0-08d839f768a5
X-MS-TrafficTypeDiagnostic: AM4PR05MB3314:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR05MB33144F3A4D2B7F18B9672678B6480@AM4PR05MB3314.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXRHi0oN4WR8b/tDp8aWdIFs6d5SrTgNHFchlDiNijtJrZq6C+1cHVIE4hzu352a9RMnEjRSKK6p5FLLTOo0yKcuvL6uCa8rQNtmkyZSzU3m4yvEt6rZRsp7sL1y4zTOc2snrlc5RJ29vljYLgk6w4ZiOqpMw6/0joAS4xrbR24d8yoZxclZN4065Hiix0twRKa5kqUCRrSsRQiKjfyPWbioAMS15cRk48zYnmrOCARRSBFQVOoG+0IMfiDb3ILhnPyKbBYY32V3AzGBD/wM6ohuklf4Mupz5vYvEdrOAv/guaImQQ29y8jkVajGuMVjKoog3pcuQFGnPxRJgcIZKAr8CeQheJfVlhoZYFEdC2wNsg4ZJ8vlmKeokoFQNQjD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(107886003)(16576012)(478600001)(16526019)(316002)(66476007)(6862004)(36756003)(66556008)(6486002)(83380400001)(5660300002)(37006003)(4326008)(31686004)(2616005)(956004)(52116002)(8936002)(2906002)(6636002)(66946007)(53546011)(186003)(8676002)(86362001)(31696002)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ejKtUqri6bcpddJzhGzK7R2aIh8HCh7pFD+4a01gQugOHchRDKXlWv+sgEV4vL4ZxYECwOf3yvaiMcCz/ABf2SQeqKgOvi8fuj96JFN0CiKt2QFxoCkARaqUVBLI/53aCgftBfIShcYJF12swNSOs0lyJXRrUa9F4CTTILdTVX/ySLtUprgNgfioCHi+vER7IB9PPUV1NLThyu077S1RJ6RYS9EleoiIt5pA09DeG4eF07VtBCHzHlJAMIWex51fAqNj6NDk8/UMNCmCLaq85EQYL6Nr20xprmDfkCOZGQLVHjnATLQixJvDeLklLeO3A4efAoogLhjzFgVeD62AJtmgXYO/cPLxeN620jEuWqwvNHrJIKqa7JEwRqPaNMlj8D3cOM9xUofAvNnxSNHB2OdPME25HLHhV0SxhVX6fBV8wQ6a7mj7ISrsqqdyJjM319Y28qGJ3KGLHvBb17U1fY/RqGE/BzalpYde4HHiYAq7E7vS1ZsAITOXzLSQVYYxSyE081T2lZLLOArghulGJMPHk6HaD/OKR3y2QsTopGKleciWAEH4Q7PSrAUOuBbUFCo+sAZmjWvslZVnQE3foHT+JiHnUFIgvx7fjK5rsN1OGEct1cHJP7NWsQLP6UbcMNZAzjyZyYwIhc5bTBVVpA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9603962b-0cce-4dc7-54a0-08d839f768a5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB5810.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 10:56:45.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dk9GhqeCaU/3PSVkdDfWpj5S4mtQ+QHjrWrB1u7izio3PmQx4gwuQuQHOKOVcPAdLMoWtnBW4ikxMwN2oFWlbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3314
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 8/5/2020 7:37 PM, Leon Romanovsky wrote:
> On Wed, Aug 05, 2020 at 07:28:50PM +0300, Max Gurtovoy wrote:
>> On 8/5/2020 7:06 PM, Leon Romanovsky wrote:
>>> On Wed, Aug 05, 2020 at 06:14:16PM +0300, Max Gurtovoy wrote:
>>>> On 8/5/2020 4:16 PM, Leon Romanovsky wrote:
>>>>> On Wed, Aug 05, 2020 at 03:12:30PM +0300, Max Gurtovoy wrote:
>>>>>> Add performance optimization that might slightly improve small IO sizes
>>>>>> benchmarks.
>>>>>>
>>>>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>>>>> ---
>>>>>>     drivers/infiniband/ulp/isert/ib_isert.c | 4 ++--
>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>> I find the expectation from "unlikely/likely" keywords to be overrated.
>>>>>
>>>>> When we introduced dissagregate post send verbs in rdma-core, we
>>>>> benchmarked likely/unlikely and didn't find any significant difference
>>>>> for code with and without such keywords.
>>>>>
>>>>> Thanks
>>>> Leon,
>>>>
>>>> We are using these small optimizations in all our ULPs and we saw benefit in
>>>> large scale and high loads (we did the same in NVMf/RDMA).
>>>>
>>>> These kind of optimizations might not be seen immediately but are
>>>> accumulated.
>>>>
>>>> I don't know why do you compare user-space benchmarks to storage drivers.
>>> Why not? It produces same asm code and both have same performance
>>> characteristic.
>>>
>>>> Can you please review the code ?
>>> There is nothing to review here, the patch is straightforward, I just
>>> don't believe in it.
>> Its ok.
>>
>> Just ignore it if you don't want to review it.
> OK, just because you asked.
>
> I reviewed this patch and didn't find any justification for performance
> claim, can you please provide us numbers before/after so we will be able
> to decide based on reliable data? It will help us to review our drivers
> and improve them even more.

As I said, these are incremental optimizations that probably won't be 
seen immediately with 1 or 2 changes. But accumulated small 
optimizations can reach to 3%-4%.

If you don't believe in this patch - ignore it and review others. I'm 
sure you have a lot. Let other maintainers review it.

You're also welcomed to remove the likely/unlikely macros from all Linux 
kernel and let's see what comments will it get from other maintainers.

>> The maintainers of iser target will review and decide if they believe in it
>> or not.
> Sure, I don't care who will provide numbers.

I'm not talking about providing numbers.

>
> Thanks
>
>>
>>>> Sagi,
>>>>
>>>> Can you send your comments as well ?
>>>>
>>>>
