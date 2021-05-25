Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1173E39038E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhEYOMY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 10:12:24 -0400
Received: from mail-dm6nam10on2109.outbound.protection.outlook.com ([40.107.93.109]:14432
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233399AbhEYOMX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 10:12:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPXXMnPUEMUmN60FmvxBF7l8vLTa9k6x2VU99hinj0ToQ4pN7F+7/0mPodAST8mZznA4V0/DUDQ9GMwQod239Wew33YZR4ETL+QIn2Vp659oV97Ly438D7qiJJ8/hJYMl1c4Vfrz9Pqvrm5zTreru59KNI6JebvOaAYaI/xy+3nzRrEaHcc8bR+jQ6KmaepmGQCuA9qm7++JnbYeXRMSH4YgmY4/6N4yZ/19YI1lyIXbj/g2itE8Xm1YMSkFELjdysO/2+S47KBzelb9abYPJIL59o+sYAySyVsLja5j3mLfeU//dbIvAeSgPXGFe8GJZZdHgF8gMglP4cgTDYPgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA4p8w9qiZON7UIuL6+lY7+7+oGpAC0WYVZv1Si72vY=;
 b=LqtjtoNzS3Sxan8uB2TdIgVAWDmkr+ctp8d7tGejGFy/1g8c1DuutCPoSijn0Kvn6KmqSOzFSvGzC4leDFZ/hx1H3H8PdEw89qhk2qoMGRQeMFEcibjYSwNnQfNyGk43r742IkDni4pbkICbzT5mEbuD4UmZd9d7A+y/AGYAsKY5o43jlrrIytowCvdFWbSxiZDOr5F3VEPMDe928qI5YgDb4JU0LtFYQpCBjbqEdk6162NAPzbqsXKeohE0h/eqPSNVfvyH0leANOyHs+2wTooBiSsExIdFdT37q1bw6lyvGjZsZa4rvN8uX/rtTOs7RywJCBducmu2LtDugnd7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA4p8w9qiZON7UIuL6+lY7+7+oGpAC0WYVZv1Si72vY=;
 b=cXmZYAGeYW1to+4g5eAyXZov5FpKXyJbaBOJEEe9x5xIk0/SB+Gb+oeJLIxTtCS+sq5sLtNfPuRvKschazja5TF+R+LT1Jt+v4XEjyLhxWGHySenLb0JAbyNjtiCSzH6ms6nF6u3xLljn9PFxqxNG2Ir1dfL4+dNy3J4YWTksZE0cg+yD0DOzG54Yoq3+ZQrqe9TwBhGTk3q4uTT48gui501G7iBlmOiNbqvyhwxOtdT7TaX3pH7tym6hvApLVDGRG0te6NgT8pomNuosrEvD5e9LVI0dXXjzUBF0szjN3OoyHt5tG/HGA7N/qgmwZehPgwg2ADLESi67hjsQKPyWQ==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6133.prod.exchangelabs.com (2603:10b6:510:d::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Tue, 25 May 2021 14:10:50 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 14:10:50 +0000
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
 <20210514143516.GG1002214@nvidia.com>
 <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
 <20210514150237.GJ1002214@nvidia.com> <YKTDPm6j29jziSxT@unreal>
 <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
 <20210519182941.GQ1002214@nvidia.com>
 <1ceb34ec-eafb-697e-672c-17f9febb2e82@cornelisnetworks.com>
 <20210519202623.GU1002214@nvidia.com>
 <983802a6-0fa2-e181-832e-13a2d5f0fa82@cornelisnetworks.com>
 <20210525131358.GU1002214@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <4e4df8bd-4e3a-fe35-041d-ed3ed95be1cb@cornelisnetworks.com>
Date:   Tue, 25 May 2021 10:10:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20210525131358.GU1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:208:d4::26) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by MN2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:208:d4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend Transport; Tue, 25 May 2021 14:10:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07aa2c52-b8f5-4a1a-1965-08d91f86e62c
X-MS-TrafficTypeDiagnostic: PH0PR01MB6133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB613301552AA5B34DDF9CBF1BF4259@PH0PR01MB6133.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhF4eRPR2AL+fPRASXLAhaXuo26dY5DI3w5euU39Zsz/IAtDCe4CptQA5hsE0xIyJjTK7StIlifAdby4a7SuusAdSf7tG2xnklmcMU+FWkwBUuAdiRnYV2oZqbPWsL1Mt74VwNgFuEAkgxhXFtBUmYGNFA/CiXX32kd4UOVyaP5Pk/4o34n2tTine37znPKKX9Y8jk8JEK6kc6FZKjXK+qU3Hbki6co3viBnSY+rT3nJUX4LQiR71gJYgYqdsSj0p9wHmXYBeeb6BTgCyZSWOUhdAU09MllyUhZ4+yQL5xRIh+1UOfHJTvYs3HLN+RhWNwexI/lrin4Tv3jn2OoogIcI0TXBZx6j5LjtG1sREdY9X8MfcUk6+4ohmKUym2lcjov+MC7L/4P7G4eOf3hSBrQIIiVOxmuUxqQ6lOkgC3y67a9FQEBMHuzJgy10kO/Tfdr6c7BbuXmaYhMaFV5y2HseoG0nruwJdMUzRPdcinrO499sLJxW/jELBGXRNUy/3a5wV3MBeg9gjX6KJJc3jfzNCwei81R2RWUuZfk0wR/tNlSs+9rZeHcAjC2IHNWGTfYmkt9MOrm3233s8mkUNFXm3ZKu5Z0UR02Ni04EkG3Sh/sdsn8hvkjO/i1DvGqucfna9Y/39SDvN76Y6nXGYwArcIQkqYtNWBWGq7qks3uKthcXsFZOhv4Clz8fZQZm3S8YOPdQZfQi9zfixuFwMV33wPH+ejx7Z+eWNzPqF7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(136003)(376002)(346002)(396003)(366004)(186003)(16526019)(316002)(2616005)(54906003)(66946007)(44832011)(956004)(4326008)(26005)(2906002)(38100700002)(8936002)(38350700002)(52116002)(66556008)(66476007)(5660300002)(8676002)(6506007)(53546011)(31696002)(6486002)(86362001)(31686004)(83380400001)(478600001)(6916009)(6512007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OGJidk90WEJIaUViRmNmdGNvQXBtUi9MYUdubi9FYzEzUTdPcTBEaXN6RDFk?=
 =?utf-8?B?TjNQVWZsR01PWjhML3lTa3NDVHRET2tZUmFkK2xTMEtVYld2WUwrU1Y3MHZF?=
 =?utf-8?B?amRqdDExVEdneDQxVDlRa0wzQkx6L01VdkRxejdyMDlTNTZ6WUw2Mkx0MUtp?=
 =?utf-8?B?UHQ4cXpOUkszSFpESUNFbEk1NHFRY1dpODhBaEcyc3lGN0x1R250UGVnakdO?=
 =?utf-8?B?bnJmaVpzd0xyUDBqWE1hM3paSlFuV2d6SC9XTWF1SW1kZTN5ODljdDFZN0k2?=
 =?utf-8?B?aUkzcmJlR013SzhNeUJ0SHlyYjhLaTlzdmhGeisrelZ6QytuQVgyYXRVbjN3?=
 =?utf-8?B?c29TQi9jV3A2UHVzMVVIQnBKV1BWUnVPVlBqRnllZWdtN05Fd0tCbEREOEU5?=
 =?utf-8?B?MlhLRnFDMVd4dk9SKzl4czZzaHltMzAzc1VvTDg4bkFzK2pZYlZMY0E0a3hV?=
 =?utf-8?B?MlN5NnMwZ2FmdVh0aE5BZ1N1K3BCVXNPdDRaUnFjY3NCNm5aQStLTGxoNlFY?=
 =?utf-8?B?VExsOTZZeWhBdlVXd2JpNm9PbzVZWjd0UE4vZTkzMUgzMEZ0NnRkTEliaW1S?=
 =?utf-8?B?TEZxM3psb1N5Z2JaQ3ZnbjVUekI2VTdVYlZKeURkZzdJYndDNm0yVUlUMVFq?=
 =?utf-8?B?VitCMUg0cnBoLzY4cFZacnp2ZGlqZ3ZVYWNMWXJxeUJtcjhBazZQQ2hPL0Nj?=
 =?utf-8?B?OEM0UE5zUG1TNTNrL2VUeExvUXZhSi9JWi9WV3N4VFBIVFQ0cDJxZmtzcFRl?=
 =?utf-8?B?Umk5TGkySWppd1BqUWl3RHZpNllWYXFFdVo1Q0RKTy9lRlZxc2VYMm9VbDRa?=
 =?utf-8?B?N0JVUk56MGdrdTVralBTSlh5RFlvRlU5VHM0V1pFUVFwUjJuMVRFNUc3RHBP?=
 =?utf-8?B?TmIrY2xFeGxGbVR4aTg3T01Jc1R1a2V2WjhBelpjWG5sem1lbFRPVXB3ZDhs?=
 =?utf-8?B?S3ZjQ21XYThJVmNXYVltRlBSVGpKeXRoeXVJcEpqTDVLQVBsS2JMRS9hdFdD?=
 =?utf-8?B?QjRDUTFDN0lrT1VKd1Rkb2NKbFlWenJUUDRVekdnWlU4ZDZka3Nlam1MTjla?=
 =?utf-8?B?a2hxOWVlYU5xNWZPSWdFN21Va0ozZUNNSEdHT3BYSDYzblFaTVZDMGVvdkRv?=
 =?utf-8?B?TldVbXdvZ1AvVlpVc2pNN25xMFJnWDNCQWFtQSsva2FHZStLL0d5cEVCbXFS?=
 =?utf-8?B?OFoyZVpnUzBQQUxoTEx5ODF6cysyQXJRVjJ1RlJmQTl2YzJ0V1Byc0NycHZR?=
 =?utf-8?B?QzNVWUp2elZpSFZHWFNVRlExdEhVVStyVHhjWDljZG5WV0w2V3BMcE5qTThi?=
 =?utf-8?B?U1ZDRUVBNnNteExJT2NGaHd5QVZWSEcxK2RockJXejI3VVRXV25qSm1wbXZk?=
 =?utf-8?B?cTZ1Q1Y0b240V2xmOFM1V3VaT3Erd3lRR0VSVkVtUUkrZUEwR1ZUMDl4RDJQ?=
 =?utf-8?B?a2g5R3BTNEU5OEFPazhsMklYN3M3a0JzWHpkYkFTc2RWSEt0b0k3N1F2RzlB?=
 =?utf-8?B?bVNkdWZuaGxsTVI0RXFRdmJnM1dzMTh5MVdlY2o5enJMN0kxZGh4SGpTUUNp?=
 =?utf-8?B?cXA0K1g1clA4U00wVE1BZFNxY3NNZktSU29iYS96c0ZTV0hWV1BrRGorT0p5?=
 =?utf-8?B?eURyb3B2RUdaN0RCd1poOHZjRitvTWhqZ2l6TWxzT3VYaVc4UEJaSjU1WWJ3?=
 =?utf-8?B?UGg2TlI0SFJ0L0h2RkZjUXpEa09kbzcvazlFY2ZQWnVkakdkT29TVzZqSXFD?=
 =?utf-8?Q?3BtnMrMoj2laBcbo4Z4DGh1n30zP2RU5npmqy1y?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07aa2c52-b8f5-4a1a-1965-08d91f86e62c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 14:10:49.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RK6lB+zDoTb/d1fG+b0PJD4h4dfuyF9SKUD+fxBpQolj31o3L14L5Zg09OAedPbdWH8dHf2t3m0LhHucpLW7phf+6vJ6S8Hm4HLjfg0blamIxIZlvRplpvhN9+A2PzEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6133
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/25/21 9:13 AM, Jason Gunthorpe wrote:
> On Thu, May 20, 2021 at 06:02:09PM -0400, Dennis Dalessandro wrote:
> 
>>> I don't want to encourage other drivers to do the same thing.
>>
>> I would imagine they would get the same push back we are getting here. I
>> don't think this would encourage anyone honestly.
> 
> Then we are back to making infrastructure that is only useful for one,
> arguably wrong, driver.

That's just it, you argue that it's wrong. We don't agree that it's 
wrong. In fact you said previously:

"
The *only* reason to override the node behavior in the kernel is if
the kernel knows with high certainty that allocations are only going
to be touched by certain CPUs, such as because it knows that the
allocation is substantially for use in a CPU pinned irq/workqeueue or
accessed via DMA from a node affine DMA device.
"

Well, that's pretty much why we are doing this.

>>> The correct thing to do today in 2021 is to use the standard NUMA
>>> memory policy on already node-affine threads. The memory policy goes
>>> into the kernel and normal non-_node allocations will obey it. When
>>> combined with an appropriate node-affine HCA this will work as you are
>>> expecting right now.
>>
>> So we shouldn't see any issue in the normal case is what you are
>> saying. I'd like to believe that, proving it is not easy though.
> 
> Well, I said you have to setup the userspace properly, I'm not sure it
> just works out of the box.

I'm going to go out on a limb and assume it will not just work out of 
the box.

>>> However you can't do anything like that while the kernel has the _node
>>> annotations, that overrides the NUMA memory policy and breaks the
>>> policy system!
>>
>> Does our driver doing this break the entire system? I'm not sure how that's
>> possible.
> 
> It breaks your driver part of it, and if we lift it to the core code
> then it breaks all drivers, so it is a hard no-go.
> 
>> Is there an effort to get rid of these per node allocations so
>> ultimately we won't have a choice at some point?
> 
> Unlikely, subtle stuff like this will just be left broken in drivers
> nobody cares about..

If it's not that big of a deal then what's the problem? Again, you keep 
saying it's broken. I'm still not seeing a compelling reason that tells 
me it is in fact broken. This is the way we get best performance which 
for the RDMA subsystem should pretty much trump everything except security.

All this being said, philosophical and theoretical arguments aren't 
going to get us anywhere productive. Things could certainly be different 
performance wise half a decade later after the code originally went in.

We are already mid 5.13 cycle. So the earliest this could be queued up 
to go in is 5.14. Can this wait one more cycle? If we can't get it 
tested/proven to make a difference mid 5.14, we will drop the objection 
and Leon's patch can go ahead in for 5.15. Fair compromise?

-Denny




