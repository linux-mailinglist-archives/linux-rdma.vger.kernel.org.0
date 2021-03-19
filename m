Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A8F34261E
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 20:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhCSTX3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 15:23:29 -0400
Received: from mail-bn8nam11on2112.outbound.protection.outlook.com ([40.107.236.112]:45025
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230351AbhCSTW5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 15:22:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePAfjDeui3bgKtMp/E+b0lugf8Z7yF06gln2HjaPxatw72A7MVZACh5XlsltP0CUyPaRBys/H0sBoauoUw1gNU71QcpmVTEdz5vwBqSaYr63Qpbj+m6mKwhOc3qZ5jNhTIxtSpARWLwA6oSjV5k7XYMh+DcmOdJ6dhVEHBYjUjKu8LxWKnB1rVJJcSlwL3UX+wXKOg4u4vqNhHpPLj/+/J/fnhi4YSoFBdrmF0PEKIZ2EIoZeXneD17cVdYTPrxcQV4dBvyzVMv9i2FRLjVXg32cR1wSQeIHOkM27pOSmTG1bR/3vqWD+l5ixwlXbNqBxkgKyvPRz3n25E6BzyWClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3SNg2bx87V0NAAWWHLmYsFJqFdXa68IMiaXbF17hNI=;
 b=TY6GROQPLqYi+D69+yqNryP1k9Pd+nXmIC5PGqEPmGv286ZFjh0hZklWIbugZN95aOm4US1uGg+3VN2rx/g5nBBjAM5obiVZ48xmWFWptfhZ3ipM2Pczl8GbP3xHXnt3PEC/Ezv/63JpjvnNkv9OnAH5uIigpvzQzKTTFxIEt57Brq4YIHOChCn21EmtBh/aUug6Yrzn+a0PZSG0IiSVFcEXGTUMlBAqeifslbdXK+4Rw2jZExvGITT5MN1M0609v4HhNRoKWYNt+iBLIzf+1q1Va9x2EnMuEatZwCgXMrKpdxIbnSKpOYeKTyozhYQUjhj/jQb7h2ZaaJjlvWfIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3SNg2bx87V0NAAWWHLmYsFJqFdXa68IMiaXbF17hNI=;
 b=J3FKuSTczHjc468eB2AcKFgG1Qi9kp53r9n4mL1HkAZoVVxvwOOq4U/Yo3x57fc87cO7IqXy1EwMy/7SE7xxf4u75PmJYoWdpNU50LByFJBBFrRwMlD6P+xNZK7EaOncShP4EEaGNjgBzQjNCVEr605A3T3GAYT1t0taOlGjv4ZhjFgz2TzhsQNZrgDgtuGprSuqaQ0lBwEYO8tqRnLpZONdo0HiUdbxAyn4lq+Spy4Han6oEcAirNen4oIn5XPPgbkii+p9UX89sWM50BOQOoXe9JeIRb3153CPB0hkGQ0CgYl7zvA711E7geeYuzINYulV+96JubzQOQeOTLyZeA==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6729.prod.exchangelabs.com (2603:10b6:510:97::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Fri, 19 Mar 2021 19:22:54 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 19:22:54 +0000
Subject: Re: [PATCH RFC 0/9] A rendezvous module
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Wan, Kaike" <kaike.wan@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
Date:   Fri, 19 Mar 2021 15:22:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210319154805.GV2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: BLAPR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:208:32d::23) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by BLAPR03CA0048.namprd03.prod.outlook.com (2603:10b6:208:32d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 19:22:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34854553-49df-4f1b-7302-08d8eb0c64c1
X-MS-TrafficTypeDiagnostic: PH0PR01MB6729:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB672947925F4D4107B424CA41F4689@PH0PR01MB6729.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: No6Icb+sMM+zLezMZehQr1hfDaDJgEOELKtdbJjCF8/q+Dp4sP1qMUN7ObCrJSU/eu9A3Y7MLdFfVa+uGPxgJaMp/ouNyDv6ow4pK32SMt1MyJa4uYWJovxu1TxwAbxwuUrhpXtCom5MnTteuG/agm84nvJE0UWV0gOFrb3TNbswO82F6zloL6o1xGFA4HOm75SSkN4/yLKaqZMBM0uWozX3jn35S92qdVZQeIhwa8T2LEdAvF2yCO78rFUJn+6wTk3PHackZRt5tTUxV4iLhTNE+vgHRXKKZZWRPDPP3fcr7rzhGW22dk98epue5FosGlGKEGxzzss2dlEhQYZ5DZlT7T8+GYA8CkMTJzL0/GXYUrWxZEeMFDuB4xY7SmFgBDUC3xjnLU3MCqIup2Olz5jnW1J+8QjEUlGgyHS02W9FlhHK51ir7l5mb2C6yMhlgMNlI+L+cuUJ88U1LAHlxj99u4xRoo2ElDqAliRzCBAVkqCoW8mdCvqTCwROKtO8MFnYLJ4kJhAbNhf0YkibsLLEdmfZgwJBIx8gSdyzo1YyQhP/PjgSpjqQut71xZ6a1ue1mFYulq7eyx+N/ywxtL09dGCU49CZGaXhT/T0LLvBmpEfQ6gF/kfsfnN/P2kywMY9v+jDWCcxYv+sAqQsyLg+ijRfrjDzmuY9LBM46IUSpzOyPsGHMPzUGyPT7dp6KJ3DqYZFfJBKfZ07DMKqkcpW5rdzxK0Qa5sN6V2lAlE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39840400004)(346002)(8676002)(110136005)(2616005)(66946007)(53546011)(16526019)(2906002)(4326008)(956004)(66556008)(66476007)(186003)(83380400001)(26005)(54906003)(16576012)(8936002)(478600001)(316002)(31686004)(52116002)(86362001)(31696002)(38100700001)(6486002)(5660300002)(44832011)(36756003)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RUg5VVB6ZXZCOTErU2p2cHdTdHVxOWpSd0lRbzY1Z0tEM1JxRmx6WDlQZThC?=
 =?utf-8?B?UElWRHM5ZXl6MFRKN3luZ1VrUHMyaTdNWW50ekl5dGpBdUJRRXROaGlQNFhz?=
 =?utf-8?B?emZOYXFla0V3bHBIT0xaa3QwSXA4V2prOXpQQ3lkN0ZDdVBwejAvdVBqdGNk?=
 =?utf-8?B?emx2THVWY0tTcDFxZWhlSEF5Ym52ZGNJZjdyTi9aRGJqVElCUzF2b2hNZThJ?=
 =?utf-8?B?ZFh0T3BOb25RYVRBT0dkMzVKbmEyRmk5Mng3b1JPNTlGNTdQVzJpVWFseVJT?=
 =?utf-8?B?eFR2NjkzSzhBMWdDb1A2cnpDNkQ0amNSbjVkejlCempUMG5uNHFSM2tGQzMx?=
 =?utf-8?B?U3dteHVOUzRRUkphK3pDU2p1bzlCdWVqbFdLajVOd211am5ySk85R0tHdzl0?=
 =?utf-8?B?NVRTL2FmeStaY3ViZVljdlNOZjFnSTZxVUFiK0cvdW1NcXo0ZFRneUlwaFl6?=
 =?utf-8?B?anBtRHM2TnlwUmRVc3p2YnhvZFk3Y3UrWExDL0drNFdoOGFkaC9aSnhEcnRE?=
 =?utf-8?B?OGY3YzVETTY3YWN4dms5elJUR2NCRE5zWHo5YUZ4UDJnM2JKL29jSE56bm9B?=
 =?utf-8?B?QzE5blZtd01YamRYQzJmOFJqY2lmdkFiY29ISzhoQnd5VTViRW1EWVg2aEJX?=
 =?utf-8?B?Wk5DdGM0TG9iR0tCdDYyTlcxdTNqVHFjWk9Pb3FtenBOZlN2NHNvdU5raUhU?=
 =?utf-8?B?cW1lQ2phYkxuQzlkOURlNXI5ck9tTHV0cjI2SzRWNjlqZFVVSGRydy9uMC9a?=
 =?utf-8?B?UHJWeUI5MldtNndQYkc4RE9TU1d4K1V2MUwvRndFM1YyVlV3VEJTZjJKN1V2?=
 =?utf-8?B?M09MY1lFN0dvY1l1Umc5RnJIVjJIOTdWd3RvNWFLejhqQzJMd1JKOU5QdmZw?=
 =?utf-8?B?QVgxYWs3YkVpR0JBRENyOW91Y2o2SmM3OVEwZG5uKzluVGIrRFNtd1JJMjdF?=
 =?utf-8?B?VEZ4K0J2Vk1qZjVVaGtlUkxKazBwRzg5MWtsbFR1N0ZMaEtZY3JnVG9NWWFr?=
 =?utf-8?B?NDRKUmRhaXdQN0pHY0V2dGFwbXBlUGdiL2lUUkdqODVMOVl4T2F6TXY2T1V2?=
 =?utf-8?B?TlZITGZvVGFOcVNRdlEwcjVWMUlGNVpJUUpBTFlUNG1pWmRPaEdEaVJWK1BG?=
 =?utf-8?B?c0N4OXZUZnJMRkRqK0pRY3R1VmpSVW1Ib1FGUTdGcjFrckV2eGFpNlc0TlVz?=
 =?utf-8?B?Y1BFTkV2UXZOVEppdlZHdllWTlphNkU3enVRVU5DR3EvTUU2ZmRFbFB3Umt3?=
 =?utf-8?B?bHozZEdldTM4cXlveGExM0FQT05jZHp5djJpS2ZiaTA1VFgwVys2cVhqa0Mz?=
 =?utf-8?B?QWw5UFVTZ2RKUzBEY1EyQ1Noc0xBYU5adVR4cnlzS1JtY1FxdW4yNWZTSUFq?=
 =?utf-8?B?Y2VXNTVucStHMjdMK1BVVVBrUjVLVk5NL3d3cEIwSndvZTB3ZkNFeHRNTTY4?=
 =?utf-8?B?REFDQUhHcHZGWUJSQnVPVHhsTlhGWXJaZlViV1VMckVvRVlrMTVoaDNvSUts?=
 =?utf-8?B?bmNSODA1SDZOTXFpS2tiV1k0bUtGS3BYZExPYUdtU2I2TlFjTUhUMkFBeXda?=
 =?utf-8?B?RXFtVHdmNmV6YW5hR3BCVEU3cnNONVF1QThrdEl3TUJPMTB0UVA5R0VNZG11?=
 =?utf-8?B?Y0lwaVVpWnRyTGR6M0Qrd29ZUmxHRmg1SndwY2x5MEFJUGMwYjJZNTBVV3hF?=
 =?utf-8?B?aGlsR0NYRXF0d3YvaDF2UXQwRVNvWjFiQS82dDNzRlRWQ3BobElwMEo0VmlC?=
 =?utf-8?Q?Wi5BHspcILbzjBSooD9MJkDXcOtg+02D2BqRTYH?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34854553-49df-4f1b-7302-08d8eb0c64c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 19:22:53.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLvoIm7+AkcFdx/ytYIIe7DsUpfEtU9OCWzs4K+k29emqtlniysd4vSUr3NxZLE9VHZfCgwMolYQtowaaVvV4StUHR47Rk8Nmxoxjazrc7TaV1lITJp+uurHfJF/zlSI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6729
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/19/2021 11:48 AM, Jason Gunthorpe wrote:
> On Fri, Mar 19, 2021 at 02:49:29PM +0000, Wan, Kaike wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>> Sent: Friday, March 19, 2021 9:53 AM
>>> To: Wan, Kaike <kaike.wan@intel.com>
>>> Cc: dledford@redhat.com; linux-rdma@vger.kernel.org; Rimmer, Todd
>>> <todd.rimmer@intel.com>
>>> Subject: Re: [PATCH RFC 0/9] A rendezvous module
>>>
>>> On Fri, Mar 19, 2021 at 08:56:26AM -0400, kaike.wan@intel.com wrote:
>>>
>>>> - Basic mode of operations (PSM3 is used as an example for user
>>>>    applications):
>>>>    - A middleware (like MPI) has out-of-band communication channels
>>>>      between any two nodes, which are used to establish high performance
>>>>      communications for providers such as PSM3.
>>>
>>> Huh? Doesn't PSM3 already use it's own special non-verbs char devices that
>>> already have memory caches and other stuff? Now you want to throw that
>>> all away and do yet another char dev just for HFI? Why?
> 
>> [Wan, Kaike] I think that you are referring to PSM2, which uses the
>> OPA hfi1 driver that is specific to the OPA hardware.  PSM3 uses
>> standard verbs drivers and supports standard RoCE.
> 
> Uhhh.. "PSM" has always been about the ipath special char device, and
> if I recall properly the library was semi-discontinued and merged into
> libfabric.

This driver is intended to work with a fork of the PSM2 library. The 
PSM2 library which is for Omni-Path is now maintained by Cornelis 
Networks on our GitHub. PSM3 is something from Intel for Ethernet. I 
know it's a bit confusing.

> So here you are talking about a libfabric verbs provider that doesn't
> use the ipath style char interface but uses verbs and this rv thing so
> we call it a libfabric PSM3 provider because thats not confusing to
> anyone at all..
> 
>> A focus is the Intel RDMA Ethernet NICs. As such it cannot use the
>> hfi1 driver through the special PSM2 interface.
> 
> These are the drivers that aren't merged yet, I see. So why are you
> sending this now? I'm not interested to look at even more Intel code
> when their driver saga is still ongoing for years.
> 
>> Rather it works with the hfi1 driver through standard verbs
>> interface.
> 
> But nobody would do that right? You'd get better results using the
> hif1 native interfaces instead of their slow fake verbs stuff.

I can't imagine why. I'm not sure what you mean by our slow fake verbs 
stuff? We support verbs just fine. It's certainly not fake.

>>> I also don't know why you picked the name rv, this looks like it has little to do
>>> with the usual MPI rendezvous protocol. This is all about bulk transfers. It is
>>> actually a lot like RDS. Maybe you should be using RDS?
.
.
>> The name "rv" is chosen simply because this module is designed to
>> enable the rendezvous protocol of the MPI/OFI/PSM3 application stack
>> for large messages. Short messages are handled by eager transfer
>> through UDP in PSM3.
> 
> A bad name seems like it will further limit potential re-use of this
> code.
  As to the name, I started this driver when I was still at Intel before 
handing the reins to Kaike when we spun out. I plucked the name rv out 
of the air without much consideration. While the code seems to have 
changed a lot, the name seems to have stuck. It was as Kaike mentions 
because it helps enable the rendezvous side of PSM3.

-Denny
