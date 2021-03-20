Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F26342E69
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Mar 2021 17:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCTQkD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 20 Mar 2021 12:40:03 -0400
Received: from mail-bn8nam12on2101.outbound.protection.outlook.com ([40.107.237.101]:46329
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229780AbhCTQj4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 20 Mar 2021 12:39:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5WdlnoAbvGux7tU20cV/N6T7ZOhlTCZX895LENaoylbc2b9kRrNh1XIwPOa/5rvAL9+Hb+hnXTrSie6yRkaVZucO3BmU6yibhkSL/nu9SWBzh2yTkExWZUaYq9DpoBU8ewSXg07IReBmsL9vJGnYmIgBQDb9VJwknkJaNGORuw+NQ+TtZuG44sstWePObSUPbcZKA4FVSewCFBovZjNpSL2DlktgJ7CKN3lOn20b8cKkQs1mPQEzJvsMNpR+VQxca3u+kAekZ35xKSwo5sIPwg/MX7bhiBpZy+RLeE2jpihJBoZTR61eTPy9QcA/Ly5XXPy8sPA7AKC/uO9gfTWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8+Bu5iTY1CVqga9VBfgUGY/ZexT94G4OPKzSVWdoN8=;
 b=MWHLzmTXWM5XRROBdm1tva0uO6rVfeL+diod0m4hN2tRkIZpMz9P4SDosw9ehaHZP/3XXDpnQdjC2OGyMixD/wAWscDulZ6YOoT6ZkVqoUTxHpd3OOMG9MqZ89oY5WKy7x3Hsq/0gQ1R93UWYPj+5DjB6kcxoPpqQq2rmpIPOcA41hVOcgmeOLMaqgAdk37fBQebmk55H7Qt94Aa+ZIs4eJAMz0JUZP9pK0dCnt3ThFYRLYluAlVxys14ZX6B0v6PN9NhxqoKCjmRBGZAD80CMo4Tf4IftjH2jDkdSg30MnmnfTY2nEocYV1uoW82oj2Q/1JGEThdOVaZW0W1O1zYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8+Bu5iTY1CVqga9VBfgUGY/ZexT94G4OPKzSVWdoN8=;
 b=mkbWWkkEUB/UWHW2thAqcEFXsRnpNFQtQ8dq4a/l8U7TpmV3NgjtNuHL1KrxypUf0Ohrr0rmYxmb+CrGgfxFidjkKE2VqWMwwq+TlAmq5wfpJyOgZnyRvasvqWO01Q+abjR8NbEoWaGHNshzmXS+wYSXaaPPOuAzdsm0Uk/RMl+VzPx+za6m5wbQwqU2tp9XOqkHkoBV59QXjoSOBU7yyJEgWWqGQ3Pq8YtBdXCn3dpr2G/wdeo3/OZB3wouTDdg8/vZhm2TSvMTOCYcNDR6dUcWxsvzE9GWHlhHl+LB5k3nXXZUY5hUdNTj758GQ7oqSMaWZ1HTBWsYXYLNP9luMg==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6668.prod.exchangelabs.com (2603:10b6:510:79::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Sat, 20 Mar 2021 16:39:54 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3955.024; Sat, 20 Mar 2021
 16:39:54 +0000
Subject: Re: [PATCH RFC 0/9] A rendezvous module
To:     "Rimmer, Todd" <todd.rimmer@intel.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
Date:   Sat, 20 Mar 2021 12:39:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: BLAPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:32b::8) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by BLAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:32b::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sat, 20 Mar 2021 16:39:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 827e6e5f-23fe-440a-d497-08d8ebbeca21
X-MS-TrafficTypeDiagnostic: PH0PR01MB6668:
X-Microsoft-Antispam-PRVS: <PH0PR01MB66689020FDB2B609B9DA3309F4679@PH0PR01MB6668.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbwPwbFrNFsYHcqood+3EaUqbkbNSkZRzD0xVu5xXikU/rpGOHHZ+N8wikjBIqTVtgN5DOl1dLg9g2Th0eFycmVLed08zV13ejodeDKdZTJ4MBX4oEHSuvC7sUXAeX9wgGOtZke/ZHSvKi7Ua8Vj/SI2yVpqhIKIZora47cdwCdc5JPJDB+67Mk89HF9NiIN1rY0he/c4GHt+sufq4v/LQ5LTDCt6qS0svYsqS/FlNggBU3UvqvhsQu6fsIvXiHzVDVdI08fqei4ZJcGLsUUmB9dgCdi87KROAmvXx5vwvTlTWfZ/KNb7kkim3b2UrCnzj0BX5yoQHzt3sM3ZDV2+32ltD3aEUZMgD9Kl1VutyL/9vtOaQ2AR3atnk0BVicWycU3DTjHWqdOAk6/+8Jc6TkZWKODeQ8nCL0jbSfYz9doS+Ss4U9OAU9ykPJSxj33mhL89x3t7xq4B5JIPSnhtqx1y+zbCly+ky/5mz47kFl3WDVTbmJvPFTEOflt2Vjo8FUCVyoM72Ks61YhV5hUltGhPCZVjWLxGmZ3EoN0K26U7IX0phNMVHvhYwxnXhL3x4elw7lYm8OcTZx3bVAYIvxGWBtkBacSgxm5pVAo0e5CGbnwEtQ5RlRWlGnKrEb6zV9zzH+KkuiHE03gUBhsC7rMDztx/ex7v6Fo2WvRBiriZOT5xjD+/3a/ySrrwyhlt2oI7FH+aiYksz26HuTSHozAopaCS9SD1souij3U9bqVv2E/xJqCJBYWkD1SNBEWRnY48u9+7dD9v/HyxSJ/ibt4UKeQtDu8UDb+3NMy/YD6F7nfi2H0Oi96PxRCLl5h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39830400003)(346002)(136003)(366004)(38100700001)(66946007)(8936002)(186003)(66556008)(52116002)(6666004)(2906002)(53546011)(16526019)(31696002)(8676002)(478600001)(83380400001)(66476007)(86362001)(6486002)(956004)(31686004)(966005)(316002)(54906003)(26005)(16576012)(110136005)(4326008)(2616005)(5660300002)(44832011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?STUxSGxLanVldlpyUG5GbGRvdXV1am92c1ZpaW5FbTBpQzA4djd1T25WRnVJ?=
 =?utf-8?B?Y0tDbWdEV2l1bVZodGtnUUhrdG9XR0VvVzE2K0d1YXZiVmpOcnVqdmNrbVVQ?=
 =?utf-8?B?QXBFT0F3ZTFTcVg3OTV1T2tmTVV5N25uNWxzU29VbERoTTAyS1NLOTBZWWFr?=
 =?utf-8?B?VG81b09tT3pNcDJkTW5ERmFFR0kzNk1VVGpxRjV4OVEvMmhya2xVSHhudnMy?=
 =?utf-8?B?dGx2WFVlQ3MwcGk5eUE2SFd3OVRyLzhNQUplMVl2T2tFZjJ1ZHg1UlVZZWps?=
 =?utf-8?B?SjFnZ0wvdXVJVTYvbHdCLytscXh0V1Jyckx5bkRGYTkwUyt4MU9KYW5GMjNa?=
 =?utf-8?B?dHFtTWtCWFRKTXVmSUpOdEwvVUUxU2lZNFl6d2RIalhaNVpiZkpyYWU4VW9v?=
 =?utf-8?B?a0hoS3pkaThxOEsvWDA5N3JtSWFkRnBXdUd0OGlkb1B5MTVIRU9ZVW9xSTZu?=
 =?utf-8?B?MUsyKzNGUDBCMnFvcGR3TlNFaGlpekxGNDFXRENVa3U5b3JvV0tTaGFUbkl5?=
 =?utf-8?B?Q2lzS3dyZFp2MFpuUFE0alpPMkh6WkNqNUE0emlHSGVrRTJaWkNRT0UwVnls?=
 =?utf-8?B?dEVYZzNVeTRESXJwUmFnSTFYVzN6WDR5ZVFEQ01IaGJUWVk5b3JYV1JVRzFM?=
 =?utf-8?B?RU5oSitidUdDbHZPcHB5dHMxaThNMEcwN2VmZDB4R1AxYkF1eXhXeCtRMUEz?=
 =?utf-8?B?TzlnLzFORWU4NlFTbm5QVkNpWkR5RS9qZG1NOTZxVlV4Z3B1NWdKK1dIc0hT?=
 =?utf-8?B?VXRwT1E2Q3RLcE1ZNVAvbnUrK0pOWVNxNWwyY0JUd2NHTUIwQlhlS1Yrd1pS?=
 =?utf-8?B?Q2N6MTJzRytjRGVuVFVBcU5tMDk2aGtlTTZ2aWpGVUg4QzZLb0xEWUsrTG1n?=
 =?utf-8?B?T2g1bmNxSGJoV1AzUnZtUEcxN3JObDA1NEhHVlM3d2NMZXJJWnRpNFFFZmNB?=
 =?utf-8?B?RFVwRHgrU0NORE9MSGd1b2hjNjUwU0llUEtWTXJVS0RsVTluMHRiQWhRd3d6?=
 =?utf-8?B?WWJ3dHFIRlZkSjJzdDlJaGtNVEhpWmRWdzdGMW5GUDlHcnhmMjdYa3FrVDl2?=
 =?utf-8?B?WElzdWV0eStMQlRQZVdleEQwYklIcHBuMXJuK2xOUDVSb0tISXNMK0lncThK?=
 =?utf-8?B?RkUvU2ZDalprblZFZjdwd3RBSW85UHZJcTZTbWFhZ1RZVmVWUGdrczVnVDBS?=
 =?utf-8?B?a0V0ZmpYK0Q4TDRSSXYzTncva0UzaUQwWjZkRWNMclhzZEt6M3A3QklPOGpl?=
 =?utf-8?B?TG5lN25WMDlubmEvYU5LZEp5Tk5uR2ZoVnhIWmhheUZXTHMvRlNtSkxVcUtT?=
 =?utf-8?B?MmVxcEZTUk8xY044SG9XNmkwR2xoSVcvVzRydHArYjk5V3BGcVg1TmMybGNN?=
 =?utf-8?B?bUFtdTh4dExBLzdKa0dDWkV0ZFZmVG5GMW0veEgyQmRIM1BXaW9rVE5JaXdh?=
 =?utf-8?B?V1ZEcVN2a1lPZEZCNHhwdCtweDliaTMvdWxDUnVHUWZjRTROZmx6VTMzU0Vx?=
 =?utf-8?B?ODB1V3FjL203Y2ZTV2hoamlYZ3dWSXJ5ODM1MFdPTloyYndUZk5XUE5RY0VK?=
 =?utf-8?B?c09pcW94ZkZjWXdWOWhySXdlQlArb01XZHZKVWpMdnJPZDhaRlBUT2dHQ0Mx?=
 =?utf-8?B?QXZ2RHJBVEswN3JDMGJ1K2VRN1ZkMUQvc1NOUlVEMEhzTjZvb2kyUHNqVUdF?=
 =?utf-8?B?ZEJiN2c4TEJhbGFiZTNIR3M0SjFFV1BVQk9XV0NFYTZITGluU3Y5VWVpeFJ4?=
 =?utf-8?Q?VNSd/NKd9kXaoNPH9DO/7mXd+3viilF3bdc4a/x?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827e6e5f-23fe-440a-d497-08d8ebbeca21
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 16:39:54.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NUHhAT6lBUsSHgmeot1T1inWM6paEgcEiSk0KQ/OIhnalGG7ZnVLJ3YXx8RBHCbke9PObBFQmWEZdmMhMiYYWtQxJSOGBEjJZlKh+c6L6MQqC9YLFsn6ALrGy5yNgC2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6668
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/19/2021 6:57 PM, Rimmer, Todd wrote:
>>> [Wan, Kaike] Incorrect. The rv module works with hfi1.
>>
>> Interesting. I was thinking the opposite. So what's the benefit? When would
>> someone want to do that?
> The more interesting scenario is for customers who would like to run libfabric and other Open Fabrics Alliance software over various verbs capable hardware.

Ah ok that makes sense. Not that running it over hfi1 is the goal but 
being able to run over verbs devices. Makes sense to me now.

> Today PSM2 is a good choice for OPA hardware.  However for some other devices without existing libfabric providers, rxm and rxd are the best choices.
> As was presented in Open Fabrics workshop today by James Erwin, PSM3 offers noticeable benefits over existing libfabric rxm and rxd providers
> and the rv module offers noticeable performance benefits when using PSM3.

For those that haven't seen it the talks will be posted to YouTube 
and/or OpenFabrics.org web page. There are actually two talks on this 
stuff. The first of which is by Todd is available now [1], James' talk 
will be up soon I'm sure.

>> I haven't had a chance to look beyond the cover letter in depth at how things
>> have changed. I really hope it's not that bad.
> While a few stylistic elements got carried forward, as you noticed.  This is much different from hfi1 as it doesn't directly access hardware and is hence smaller.
> We carefully looked at overlap with features in ib_core and the patch set contains a couple minor API additions to ib_core to simplify some operations
> which others may find useful.

Right, so if there is common functionality between hfi1 and rv then it 
might belong in the core. Especially considering if it's something 
that's common between a ULP and a HW driver.

>> I also don't know why you picked the name rv, this looks like it has little to do with the usual MPI rendezvous protocol.
> The focus of the design was to support the bulk transfer part of the MPI rendezvous protocol, hence the name rv.
> We'd welcome other name suggestions, wanted to keep the name simple and brief.

Like I said previously you can place the blame for the name on me. Kaike 
and Todd just carried it forward. I think Sean had an idea in one of the 
other replies. Let's hear some other suggestions too.

>> No pre-adding reserved stuff
>> Lots of alignment holes, don't do that either.
> We'd like advise on a challenging situation.  Some customers desire NICs to support nVidia GPUs in some environments.
> Unfortunately the nVidia GPU drivers are not upstream, and have not been for years.  So we are forced to have both out of tree
> and upstream versions of the code.  We need the same applications to be able to work over both, so we would like the
> GPU enabled versions of the code to have the same ABI as the upstream code as this greatly simplifies things.
> We have removed all GPU specific code from the upstream submission, but used both the "alignment holes" and the "reserved"
> mechanisms to hold places for GPU specific fields which can't be upstreamed.

This problem extends to other drivers as well. I'm also interested in 
advice on the situation. I don't particularly like this either, but we 
need a way to accomplish the goal. We owe it to users to be flexible. 
Please offer suggestions.

[1] https://www.youtube.com/watch?v=iOvt_Iqz0uU

-Denny
