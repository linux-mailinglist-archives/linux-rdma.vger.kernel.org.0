Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA05E37B4CB
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 06:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhELEKM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 00:10:12 -0400
Received: from mail-mw2nam10on2118.outbound.protection.outlook.com ([40.107.94.118]:59617
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229447AbhELEKL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 May 2021 00:10:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxSC/guWn5nNAWdV64uJFVwBqec1tqgqY605pruvhwH8pJtsRJTRxmKizgZjqxOPMor7zjMJ/JTZUyh8EXMQbP2zRTr7cVBFMFeFlcyR775i5oPIkNaX4JR8ogk9qIrar6ujaxWcv42/HMDTg5Pj6vX1b3P7pkJjQ6QadJz6dtBpYr8FxrLXh4N+4Ujwu958VOpnNTjid17nvu4OvhqzdlELsaePvMX+HznnlyXvWXYCRgQFGrDg7j1OBT7i7t/lwzu6PsdbfmS6rw11RRv8iIBw+9wOwyc58+02zdthtQCzE2kr1gYqXh6IaP0HmS+7jU+LYVb0Qi74PT9uAFQoaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMuaa/zt1HQXC3SI8OwALFmkLJNuS9q/xVeTOixMTnw=;
 b=DeaRaB5DthTJMyhVOoGzCyxwjk3qDRpcyLzLlg7HsSu+RkdA8BywEWH/E68A7g4OBhXLgsHii2m0629dd6Kgw+vKVEAlHo50vvFKoEPM1/EEAH8tavDxySUTkR2fnZxuQro5WfcC1if+W2p1m4bBJdpIH/GWXisNVBv/AllWwXOUqevrYHAoKMuW1rD2uBUNvljy/UgCT5MW71fNQoYkJ6ii36AVFM19jVLvcqiAPgndbg0rgvsSpsjWAaLNZD7tkJyWLc8HcqKa0wBZxc+KBf/0yUeiKE0WlHi3G0ixds5F2ipmW2AOGJNlLvyktLKyrWd21+Wuy9wVhyib6SmfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMuaa/zt1HQXC3SI8OwALFmkLJNuS9q/xVeTOixMTnw=;
 b=Q7/BNuMj/FR8IrTYJXkMuhpgzjqNqkeUIPsZsXec3Sq3J1fC4HOHo5YguNYGbTr3W+yW5woBTjO/zlett3IAXEWpSpoDsf8CLu6DC9Bes4VrES3u3PMknY3Hbilu7VjccZ2kX5bgI6mAAMd3aOB4VFp2cAyceTnQWxM8U4wEgi4AWIb/HVqIMJb8EcuZSR2m6ly4EnSHUiJFn6HlbPg88Ug8nq1BNfK+uZfJu1Qa+wKtubCWB50Bl/RTc5jtTI40QHAJr97IR7HVlJ0LXp+I00g1z4z+7r9KBhTV/XwFywpeUz2S4m9iQ2T9zrobgNGFlMrs2OhxBZxBX9DaiCDoyw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6310.prod.exchangelabs.com (2603:10b6:510:9::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.26; Wed, 12 May 2021 04:09:02 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488%7]) with mapi id 15.20.4129.025; Wed, 12 May 2021
 04:09:02 +0000
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
To:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <F62CF3D3-E605-4CBA-B171-5BB98594C658@oracle.com> <YJp50nw6JD3ptVDp@unreal>
 <BYAPR01MB3816D1F9DC81BBB1FA5DF293F2539@BYAPR01MB3816.prod.exchangelabs.com>
 <YJrasoIGHQCq7QBD@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <6e45f8ca-59d3-354c-bddc-ad7ff449b58c@cornelisnetworks.com>
Date:   Wed, 12 May 2021 00:08:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <YJrasoIGHQCq7QBD@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:208:d4::22) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by MN2PR04CA0009.namprd04.prod.outlook.com (2603:10b6:208:d4::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Wed, 12 May 2021 04:09:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f11b6ea6-a227-4a51-a547-08d914fbad17
X-MS-TrafficTypeDiagnostic: PH0PR01MB6310:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6310D3AB2F2A8E2B26D6A0D1F4529@PH0PR01MB6310.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFMBLC5x5uaVVvw2V0tPurlX+F9NjCTXzKboJwM14bMG0h/jFPue5lqxKwxKcsfhhJgDKnPfKXY1ohx/bfGQXRwmNEwJmbirZYlnv/c0LypszBcTZBZgQ6YjkkbgJj0ooTwkoST/P97yhrLC/S/kj3ObAa1DrP6PCU9s7lqYMF9uxlTOtzHymVL0Yj2oavq7yxrBdfzwbMRvc8TRtX9zu1TiBz2v3FfxFO0TrwemO60lTWXYj2OgI1kM6yZxhgeSiNPSM/j9nkhh1gS9y7D9W7C+06+qdrR24DMCGKYpXf33rWM3sKrnRzRGBIfgIKH55Ro5MuxCy8QwxO3NWGpFGNyEX+nSfiawQ/KgtKyvxQoulVYPWhpu88Kk/UkrLbKIsBSksYcTN64JtBXpAYn2WI4KnfOwVl+DjKdAQ06SY8QLl2i0dZQxptHlQqv7oN2f8iQvgW8vYqwzf1+4uE34cLj7qDMmD15cghcupK0H3DApDGblY+COHyotAGtaeeSrGM3k19l4A+tCilxQmc4qp+uYzJWXWa64ToF6jRCXJy2KnjhQoQlC7ZvjISNNL2lgQhRcNTAmPip1uGO4cfjzjchYALMzifo5V3Lv8I5s48qL1nmiwLhKpInK0NOrcTtMkvR6Dh/B/o5woqf9eeyWPQAKn24DeuLQWg686tU54U1MlroayLQoedlt6pPNcNlHWlPi6SXNY0SwAGps4r3Rg5Z5gScc+xtKH+jGVawk/uY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39840400004)(83380400001)(5660300002)(8936002)(110136005)(26005)(6512007)(316002)(186003)(8676002)(16526019)(4744005)(6486002)(54906003)(31696002)(66556008)(6506007)(44832011)(53546011)(66946007)(38350700002)(478600001)(6636002)(36756003)(86362001)(66476007)(31686004)(38100700002)(2906002)(52116002)(956004)(4326008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RFpiYlc2Wmw5MDdLeFc5Z2NjSEJ1VklEUTNIeS9ER0VZL0kwL04vZWFVQy91?=
 =?utf-8?B?N2Y2ZG5vWEs5aGhVUnFodjFPU25iZXp3QXVWU0dNV3FZZVlqZ1VDb0NuYWp5?=
 =?utf-8?B?eEp2NUxta1Bja3V0bWVqKzZSWGptWmU4NzF4d2dvTk15RXNJMU1WSThDaWVk?=
 =?utf-8?B?ekF2VUdrSkE2Nng2ZXR4SzB1TjdKQ1o2Q3EvQllNSTBIYjVQYml2eUkzcHJN?=
 =?utf-8?B?YVgzZEdLWUs5ZnE1YlZ1MGt1akIyMkZMQU5aWDkreXVuTjhSdnNINTI0VVZx?=
 =?utf-8?B?czI0bnp1WHhJclJONng1WDJucXFIYTMyVkFPVnZyb3R3UnRmcS9NYVhCdW5n?=
 =?utf-8?B?ZzVqY0dwRmpPSU1vTHVyQUY0QWRaVG5aRWJicnozMTdieUV2YTdmeWIxbW15?=
 =?utf-8?B?WkUxaWh6TXRCRG9FUWRIUjd4ZU9CQ1pQdllpWVhjUGErZSsxbU5rVXlRTzc1?=
 =?utf-8?B?dVlWdzluT0grQitTYnlwRzhUTWd1Umk3eUpvM0hhUXo0SUwxdjB2VGRubFpC?=
 =?utf-8?B?TFZLcjk4U2hPNitTQlBwSlV6S3hwSXhQOXZjbFhHa2g1NndXdnZzUG5JeC9G?=
 =?utf-8?B?bjRCOVpkazJUWFhTaXE4UmU5ckNzckFxL2tpMG9lT1lJY1I5c0lGQThLUXJR?=
 =?utf-8?B?UlFLRTVYemVSdjNtZW51NUV2LzVld1dIY2UrampuUXRSbjdYS2FqbGtQeTBL?=
 =?utf-8?B?ODN0SXNaTzJWYU5KYTFNbGxIcm1xalFtVWJISHFmQ2NIcWpQTkRlYjdPYVpH?=
 =?utf-8?B?R2g4YXcyQW5YUlJCZ0dDL3BFckQ3KzB4SE1CU0JLdVVSNzlHRTVvbVBkOHpK?=
 =?utf-8?B?Ny9yVmowaTB3alljSEVERmdPVk1NODdxeUFKZE5mNTJVek96R2FZb3ZTMEQ4?=
 =?utf-8?B?Sk1hNkRaNWlmMkxBelRObmxJQmZJRnFqZ01EQzY4eGJjRnA1a1V6SEtBNUVO?=
 =?utf-8?B?VGZSU09xUWhFakFKcWN6Z2ZKK1RMKytNV25iN1pyTGkxUFVNa1RiWk53T1Ew?=
 =?utf-8?B?Ykx2SGQyMkV4SVg1cDBPS3IxdDhXVm5mSU14dUlpZTBpMUdXYUpZeDVRTWY1?=
 =?utf-8?B?TVFSdnFyZjZjaXY0K3VBZFhjekt0eG4raDg0QlhmbmJDaENYSlZOYWtRRkpy?=
 =?utf-8?B?dkptVUlQWnJXbTdwR1ZiSWE2RnplT252VWtXbVM5dUpvSHNEV3V6K1FvRVNV?=
 =?utf-8?B?a1FKdmhsZzBSZkY5U2tJS3QyVkpqd3lybXFIcXRPdEk2WGdZSjVvNDg2eUla?=
 =?utf-8?B?alNQOGc0TmthTGJKditaOUdoODhGWkNiYkJsLzE3emhMN1pUa0V0TklYdnBJ?=
 =?utf-8?B?d3hjUnlOSFh0dFB1blhxR2E5SEhSWWFBN0UvdTU1VHFYU2E3WUgyZU9uK0h0?=
 =?utf-8?B?b2hnYmJSdVFZMms2UHRITy9DbW1TM3NucVFOSmVLQTIwS2hOQjg2QzhzV2xR?=
 =?utf-8?B?QThSTithbnlOY2xBQnVtZUFYMHlwTVhRS2xXYVBCRmhETjBoekFrN3hlS0VS?=
 =?utf-8?B?ZkFjczZNYXI1NTIzZklwUThDanhPRmRhclNjNDFhUmo0WkdCY1pCWWZuQTNU?=
 =?utf-8?B?WE95YkZ6WU94UHhXRG5MK3IydmMvckxLangvREdxYUJNU28yUkNpMTdSRXcw?=
 =?utf-8?B?S3ZhMXdCcGwvQkZMcEF3cTlzT2NQYngxQ2lRVjZZR2U1Q0Fqd0xaaENHRVJn?=
 =?utf-8?B?cU9WdTJ0ejRaMzNQQXMzZ3FnVXp4cGpHWWpkWDVaaXN6UU5tV0JqWWMzdVMw?=
 =?utf-8?Q?EOPAUpQZpJ/57wQvvQNdr435hdx31Y1XLo3RHW6?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11b6ea6-a227-4a51-a547-08d914fbad17
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 04:09:02.4294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVMPNuK7APWiYdDGoiWJHrzqhYWKXUd71oKN5PEBnTiPlj/l28LNlYOPah12LxJaYoMjsoJiCxsp0evBYOo5tsMpY4U1CBvtjO4Vh9TeeEos80BUHlaJd944LP6rdUCV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6310
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/11/21 3:27 PM, Leon Romanovsky wrote:
> On Tue, May 11, 2021 at 07:15:09PM +0000, Marciniszyn, Mike wrote:
>>>>
>>>> Why not kzalloc_node() here?
>>
>> I agree here.
>>
>> Other allocations that have been promoted to the core have lost the node attribute in the allocation.
> 
> Did you notice any performance degradation?
> 

So what's the motivation to change it from the way it was originally 
designed? It seems to me if the original implementation went to the 
trouble to allocate the memory on the local node, refactoring the code 
should respect that.

-Denny
