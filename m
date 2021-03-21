Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DAE34336A
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 17:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhCUQZF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 12:25:05 -0400
Received: from mail-bn8nam12on2130.outbound.protection.outlook.com ([40.107.237.130]:58391
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229903AbhCUQYt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Mar 2021 12:24:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mn38YadRPfaYUWAJE9IULps8TJKgbNYYZecTPQ8Zhr8iJ6lGpKmYUJU3SydhInz4sdABl4Cw796Dp7sYET45tExwOSKanQOYbZm8uVaKSh/s+oag+fHx/mROtw+JcDzXl4BMjZkYWLPOanW0PZiHcTm+QUTeLXjC4Iu+QGwnJCjiV6rYI92O8Gu+X2BnYIofoid7kdD1m11JK3uZhj+IwWURtNdJvJGun113h5I5rg31UWWfvDVPpscOGU1qL9BNTzCyk1YvxSyI1+WCSbRKRZO/P5EL1G7rqFL1cGfnM8n4x4Ts9Rj5vXTyZHp7m6eVhPTgCffzFBnym3Z1Eo+ycQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMLOYc4LApBK8693+Pv6GFU+pMbl6KWnBK3QdHt16zY=;
 b=mbXexr/9Cz/DUB3qm4CveY91B5EFfg9l07IwhB853om4izEgK4p5OVSX5hJX36fn9/jZ7PJYmHraDl2sK8GK6Ls0Bh9pASXM7LMt+pWjled68H5a+rd9a8Z8Kqwgcvbh9J2Jd3Y1bmm7Kto43A8Mh6b7BWbuIY724uE52NHuFxo2barthcT1WTLEAQGN1SwpmSh4L897Nyb3ydHJGdGA1b52JY9tdjeRM3JYTY1XcRazBXNanxexo7Ntza2GjPxELTUcuiJ9iiYHwbIKl1IbClJ/Ht7TmFBe4ZaENxWJqO5juGxmFFQ3g/eH+ue1OTB485TCbg07TXe9T/z9XWkGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMLOYc4LApBK8693+Pv6GFU+pMbl6KWnBK3QdHt16zY=;
 b=M9MXoFqw1jkDP0gBqgbgnHyAdFZaC623hXWpE6cK5sJ2paJkRqgS+rmGssyAQWuFI/PxRrka5i/YTQOJUg4NoXh799px82hcXJuhXEOdjjZfTqIAj2FY/XcWaRQFNn1LE9J7Q1zR7xEuJ5Wtxdy7lYhao8H8lL9L6PBxj/dR4AZvvE9lzZVbLI/vVVJsZ64qkm7fwvMi3v6jsOz4Ymw8LuHrF5yJDamPTDm1z8JhBLTBXXtTfBgmWlA/McUm/40hj9dbJr8rd6KjaZKuH0gFkFrfVJ4kZxw0zfIYnRTCRvR6w1hFD2imQGv0z9pMiWgaJg5v7rtce/9jzTtvr5Ma8Q==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6312.prod.exchangelabs.com (2603:10b6:510:a::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Sun, 21 Mar 2021 16:24:47 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3955.025; Sun, 21 Mar 2021
 16:24:47 +0000
Subject: Re: [PATCH RFC 0/9] A rendezvous module
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Rimmer, Todd" <todd.rimmer@intel.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
 <YFcKTjU9JSMBrv0x@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
Date:   Sun, 21 Mar 2021 12:24:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YFcKTjU9JSMBrv0x@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: BN9PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:408:f4::28) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by BN9PR03CA0173.namprd03.prod.outlook.com (2603:10b6:408:f4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sun, 21 Mar 2021 16:24:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74669463-94af-4af0-718b-08d8ec85d7fd
X-MS-TrafficTypeDiagnostic: PH0PR01MB6312:
X-Microsoft-Antispam-PRVS: <PH0PR01MB63122BE55546184DF0C21A9FF4669@PH0PR01MB6312.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACYaqHWsM8DInd4cniivyOHpQHdQ5KN+ZNsWL21PGFG9w5CQNKKiLf+d2GMgcIoMgFl0vLxQJvKmbJzuvkvkwMRiqaG0/p0eMvB5x/bwWP97VgCemXH7yeWyOpaQPPEF3po91osjcuKsgXkrNO+VtG/FOR8vJHPPP1sUO3y3viZI4a7Qy3BWFZVCgFp4ZbvAS6Rr4B0wivqv1N+zOmEjeG/Xi4cRwj4YqqZo9Zlf1oEHMY+HrRcuXAkQ3Fy68w4yzTmHYhAP2RmFLNofSasHyWYSJM3GXwEyrLFom2oy8717N7SMpJfcYRQZhqd7islQZVqUSLuu4DhNw8CsMFMItQSuMCaeKiGec70M8K74k+V73K5ONL8OD/+gA2EvCZaAUjm3ct/OrhG93CWMfd786WhMFa+eHTgGriGeGg49wPAjG0EH30uHwr6JL5jly6UEnWPU+tmk1UG8HMNH7Y74I7UWdRb2QVzehr3v+zaIFtUpwoDFW8Hi9kIuP8Pw4yOYVgwIBBjcYU6CDm2Nco04QhkwrtvY/kdbKl3SvrmRCAMbPZYEFuuIoyLJ4VRz589mU0rc8WEaSaxS8S+uhSsLIhnTX2NHcc4b1Nam1/MRinMVBkIEBlE/ZcsazT4RC/wlB1GHbdbHXgCNJMJjSgERs2WmkV7iSGME1ei7G6ppW1tdUMDjuMaoPbfBYw8jiXlZ7gZ19xZxVtX1d3FW7lc4mn/9Xx73K6XFRoXf3OBArZqJy5gMZVd6miZhPV9WePYmkW1DuQE250fIHAFRE12Rfr5w5KUzTW4F5qVZRXFyvXln5cuXapqQCDyJrhFfaSUO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39830400003)(366004)(376002)(136003)(54906003)(6916009)(16576012)(186003)(36756003)(31696002)(31686004)(16526019)(66556008)(66476007)(66946007)(5660300002)(966005)(52116002)(53546011)(26005)(316002)(8936002)(478600001)(44832011)(956004)(6486002)(2616005)(38100700001)(86362001)(2906002)(8676002)(4326008)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZUFFM29EbXhLa3Vkc0pwOVJwR09BSnlFRC9ZM1kzOVN2cTFpMHV1YlFnRVVn?=
 =?utf-8?B?WFhCbHRQQnhVQVU2SmRjd1RudDdmOW1DZ1hHMXh4cml0cnBMdmhVNVNFSlNM?=
 =?utf-8?B?VEtBc29QWUdvZXVuQUVvMkdTQzMwQXo2R0JPRERrcW1rOG5weFYwL0xkL2RN?=
 =?utf-8?B?UXFWZEJ3eTB4aTV6OXFRNGR3UHgremh5a09YZmt2U0VXWi85TVBKMWhUd1Iv?=
 =?utf-8?B?U1I3ZHVqZ0ZDQmhpeTJveEk5WlB6dVFybmFVOVRVcFI2ZlFsOGg4WWQ3cGxw?=
 =?utf-8?B?K1FqSVdFVHQ1bTYxUHpWOFRmVnFGM0NoUWlxcytmQU5LTTZ3VFo2bDRHMkZ1?=
 =?utf-8?B?U2E5SmhLYVVNMy9EWE1WUTFNbDZLUmt5cUhEZ3hwaGpHNjBnYlJRQWZhZEhN?=
 =?utf-8?B?L3RhT3drcnBOQTBSNW5oKzFZaThVRkFuQ3hwc240bTlUeXYzWDBHMmQ5QTJw?=
 =?utf-8?B?ZlZXeHdmaXk4OWNNZkdvanUwKzQ1aWNsdzJGS3pqT2pDQUQ2eXV6VUVhOFRQ?=
 =?utf-8?B?SlZMeGRNMy9US0tPL29BWVJ3V1FQZlY0b0FGbXRLNCttejc4SHFwMVBMWG5P?=
 =?utf-8?B?SnVMR0VQNi9NWWFFVjNQQzBQamQ4WWxLaVRKazZEZWtaQU50NjF5V2xlaDBp?=
 =?utf-8?B?cnB0ZGVKTkI4NmZUYXovSVkycTlwcVl5Q3dSdUFxd0ZDeWNRelF2NS9RVVU4?=
 =?utf-8?B?RXdid3NJbHB1TzE5b0RQSnIrcTk4RElQazdnVFZGSXc2bFVPVGtMS1hIdmR1?=
 =?utf-8?B?akZWK0ZNd3Q5ck10SFNxRzNTQXRJT0JmTjdIWmJYeS9sRnMzYzk0R0k3d1Iv?=
 =?utf-8?B?cjJ4SGNKSEN3MEZQRmIyK2p4WkRqeStTWURveHV3cEpmamF5M0U4WXNJZVdw?=
 =?utf-8?B?NCtObXd3Yi9KS3M0YWVxbElBWGhwbWY2UVBlaUM4a2J4bVE0ZC8yRk52SWti?=
 =?utf-8?B?ZGp6dG1VSndieEVLd2xxTWp2R2t5eERPaEZYOTk5WUllSXlSZGNML0hsbmFL?=
 =?utf-8?B?VWZPbGJmVVdUeThjbDBQd2ZUeEJXK1RPUlorZzRoWGM4M0g0dm9vbzBROUha?=
 =?utf-8?B?V3ZGV3VhRkl4bHozS0VRS3EzWUlTOXU0Mk9STnhFN3YzcVVuTmZwdFJNNnVr?=
 =?utf-8?B?bklSeW1Uci9aL1RnZ3BReTVScDQ4Sy91QW5tY212dzFQLzREa3lxUCt6VTZn?=
 =?utf-8?B?VC9TdHJqSVZHZDJwVUI4VEpzRWFLem5yMkY1SUM1MUN1UjdhVXVaQUtxS1FZ?=
 =?utf-8?B?MEFwMDVuQnNLOGhJTlB5a0Zzc2lMamhFa29WWXdReDRab05pWGdHNEo4elpZ?=
 =?utf-8?B?aGcxTDMxcDF4RWROT21PR1Y0ZFVrdlVJL1d2MVk4a3EwV3kvSTBVUW1EdmxU?=
 =?utf-8?B?RHcybWVwQndLU0xybmQzQ0ErekMzRWI3c2J0V0lIVm1GdDFwdERsMDNzY2JM?=
 =?utf-8?B?NkZUZzF4VktmVWFHL2F6VzBuRklhZXUybnZPVUlpZ3pOSGc3TnVnUy9rKzQ0?=
 =?utf-8?B?NVJmMzdyb2Y0SzM5dUE5cE5rRm95V1lEOXJrV3NpYWdCbUkxYlVIVTFDdEw0?=
 =?utf-8?B?RU11azd0STU0Vi9FL2ZISm1ta3N2K2RNZ2FOMUJ2VVlTK20vRFRoTG93UW1E?=
 =?utf-8?B?WnJCZnNMNXp3bjhnbFo5cVZHbTVkYS9LT2tVZkh1VXM5M2hvNkVaYjRMVVM3?=
 =?utf-8?B?SHdqNUxhN0R6YzNnL0VkWC9meG5BVnFKOFZjWjNnTWUvV3N6SEpsL2QvYzZY?=
 =?utf-8?Q?8SftLvR7cLnPK6g8hLk69TIiV3gCew0Yj2mNY7E?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74669463-94af-4af0-718b-08d8ec85d7fd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2021 16:24:47.3353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYdXp/+0d+6TlcheOu2bYbXbkTaUEAHk9Rm0hSnp+guImqAq3sy4eA8NSzjp0UlPtDWCdALsNe6fLMifO4RDwX3O1c/ubJoxghaPJ5fBxojxsLDIWtuP+VcVkbYM811b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6312
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/21/2021 4:56 AM, Leon Romanovsky wrote:
> On Sat, Mar 20, 2021 at 12:39:46PM -0400, Dennis Dalessandro wrote:
>> On 3/19/2021 6:57 PM, Rimmer, Todd wrote:
>>>>> [Wan, Kaike] Incorrect. The rv module works with hfi1.
> 
> <...>
> 
>>> We have removed all GPU specific code from the upstream submission, but used both the "alignment holes" and the "reserved"
>>> mechanisms to hold places for GPU specific fields which can't be upstreamed.
>>
>> This problem extends to other drivers as well. I'm also interested in advice
>> on the situation. I don't particularly like this either, but we need a way
>> to accomplish the goal. We owe it to users to be flexible. Please offer
>> suggestions.
> 
> Sorry to interrupt, but it seems that solution was said here [1].
> It wasn't said directly, but between the lines it means that you need
> two things:
> 1. Upstream everything.

Completely agree. However the GPU code from nvidia is not upstream. I 
don't see that issue getting resolved in this code review. Let's move on.

> 2. Find another vendor that jumps on this RV bandwagon.

That's not a valid argument. Clearly this works over multiple vendors HW.

We should be trying to get things upstream, not putting up walls when 
people want to submit new drivers. Calling code "garbage" [1] is not 
productive.

 > [1] 
https://lore.kernel.org/linux-rdma/20210319230644.GI2356281@nvidia.com

-Denny
