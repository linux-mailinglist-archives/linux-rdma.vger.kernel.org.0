Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92077227B39
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 10:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgGUIzZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 04:55:25 -0400
Received: from mail-bn7nam10on2061.outbound.protection.outlook.com ([40.107.92.61]:7905
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728885AbgGUIzZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Jul 2020 04:55:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyWoBuQ5/q8f7GSM5pxp7oX4iypUMU8JrRihVvht5qUo14kbroUGsZeSw+2pAotaqcvYinXgl6uceXG8lwdh4ageLVAvteUcTdtBCvUjt2lSu1SUqGJ0NGQCYfA2R71n1BhwRcuVrdsDz0BDMqAGHwIayxNV45l/r2b6/ZFVHLrELLGxUHx+TnctK4GuX/ZaHqrj+E4IOgazYBfFYCq9mvZAmfa85jvLWVXkWMpSsNC6oc9iDGyGVvx30p82tTCYKAM3gcRmKJtyYRM8nWamiQL0rbk3uuLiYo8Pp56vGm0Q2HASMawAaBi0WWz8bRPp3LjbR9GpUKW7VEZn//EBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeaGCrrDHmqsSeyTGV4X/OwWpWxAHHNG/nNNVIxtZPA=;
 b=jDIqUXgIx1uMb/e5Gf7K1BeulL5n/Y5nTrMa5ONdS8Wr1fsL96Gj//Wl3FsqFn1CqgrymRtwvsvhQhpovmNHWdlA2JGVj/uUkiOov2pHSrjYR13tkSpjnHNxflGqC5/miSkQ1s9qs3n35UVB69vP5U1FtIZFKTdTes+9RiRRgb133o9VfUayWo9wjcw5cLYrcZN4wkDxAQs3n9rQb1uP/T3UaBNsYDDyk8G+rx29w2M781bbd5MTJfGT+pOYmWQHwPhf1tikRGt0yYtYR0QeNK5n/niw1o37eGhZpDF9JW9YEj9+rkmrZxTTjQTTob5k3nE+7VlKzXPeHjWuVdodoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeaGCrrDHmqsSeyTGV4X/OwWpWxAHHNG/nNNVIxtZPA=;
 b=k1L0dIXX99MPttlQHdGZxGeqZvwlQKfFDEcBvBq2K58ylw1w1AGopksnZ5GGsZaohglQEtGCh09N0qvgTCEYOxd7JkIDdrUzfUwBMh/gDVQOBv19Cvei43iR1dYfeHxbxdST3hflV2TqQjemXB1cUqtj6Yhj2nt6CzuMo2d5brM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3967.namprd12.prod.outlook.com (2603:10b6:208:16c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Tue, 21 Jul
 2020 08:55:22 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 08:55:21 +0000
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Stone <daniels@collabora.com>,
        linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Steve Pronovost <spronovo@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Jesse Natalie <jenatali@microsoft.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        linux-media@vger.kernel.org,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local>
 <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2ca2c004-1e11-87f5-4bd8-761e1b44d21f@amd.com>
Date:   Tue, 21 Jul 2020 10:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:208:55::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR04CA0127.eurprd04.prod.outlook.com (2603:10a6:208:55::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 08:55:19 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c78dc7db-fd98-4487-e0ec-08d82d53ccc8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3967:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3967567C61BC043F2058343F83780@MN2PR12MB3967.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8rlvC2wFfrdV23lhT4j0xR0dD9gmUFu7MPEQCWmSOztkQ+OyTxg7R+hbwVYVG9sX9ct+YtOwGgtydW0wE024a1LCCOb35M8TL3QGhA0WtVSoZpLBIhyfviSO+lS4hUwhgNoNCMWXcA8uqlh+7lSbywiYv280mqj5uFUEZtNF+4cajSJRv5si6bhfMVOoAIP0AbZQ4jh+W2B5fRKr5Z5WOfrAXLrWhW0kd0F2rzWodFipMgGshGv3pbbXRl1RLOpZsBRMeOdwk+pse14Qwd90YFxuiAnea6CO38HCCTJjq7koryTqYy8lm7/XFzT9hkw/kIG9JSKBBmO488LJPLJADVXwXcQzxACPYMcwtuOm91LLndwCsllXPSiUfBGIpvaErlnCygVBFDoRFxP1gOPZuUYfH9HK+81xF7IMkVCPFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(45080400002)(8676002)(316002)(66574015)(53546011)(86362001)(6486002)(36756003)(8936002)(4326008)(52116002)(478600001)(110136005)(66556008)(66476007)(16526019)(31696002)(2616005)(66946007)(186003)(54906003)(6666004)(2906002)(5660300002)(966005)(31686004)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: j5mbNK/Jgj9MbhAJ5gwTfJ+CkMspFk073mKcJj4d4yHlqML3H+MZQDLBxiUZKol8Kyk8RpzPLAworAeONdvWfGLuRE1y+ySef7GkbfMo9RjHxx4jufjqPzWyLkJLvXTJlgxhTWNHJxLjBRK8jldOq1TSLM8EIVeDASsWA3AmtsJE5ld5vcZUYQk69bg/Z9118M5pjRfrkGH7hQjRLDkUXQqshD/HLW9b16c/17E4B2m2VrPqhSiX0qT/FrM51TgnhgW2Nv4RP6lVp7Yr4+phiDYQ9Q/nxxGux2tpAGN8XIJQif4L4WcOvnSXLh8YnIp6O9BduFMlqnelVgdiF+qFl8ChKcrenKu7vhuOvkiED1hcimwscTPvRwjNZa7FHb2Prx4t1BBAMfx7y5ZCZqXQn0NOfGRhJG3Cj6pj3hAGJSjVTioQjODcdm/5TJFtC5InsKsGdSdSQU4DmdZuAZaO8J72Mw8gtYL5QAwEemNB3dXiCaWKkFf8rkCAFxGAmV47u5/CiypVMfTXaGwibIqP0SuyYTOc+jOVzqkRpoDdch7lpEIKOujG/WwE/uHugyW7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78dc7db-fd98-4487-e0ec-08d82d53ccc8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 08:55:21.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFZhoKNd61bmkQxYXFVOo0u1t22+F09PgeCmpytZeEgYR9Bqyy9LlVgORb47dDiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3967
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 21.07.20 um 10:47 schrieb Thomas Hellström (Intel):
>
> On 7/21/20 9:45 AM, Christian König wrote:
>> Am 21.07.20 um 09:41 schrieb Daniel Vetter:
>>> On Mon, Jul 20, 2020 at 01:15:17PM +0200, Thomas Hellström (Intel) 
>>> wrote:
>>>> Hi,
>>>>
>>>> On 7/9/20 2:33 PM, Daniel Vetter wrote:
>>>>> Comes up every few years, gets somewhat tedious to discuss, let's
>>>>> write this down once and for all.
>>>>>
>>>>> What I'm not sure about is whether the text should be more 
>>>>> explicit in
>>>>> flat out mandating the amdkfd eviction fences for long running 
>>>>> compute
>>>>> workloads or workloads where userspace fencing is allowed.
>>>> Although (in my humble opinion) it might be possible to completely 
>>>> untangle
>>>> kernel-introduced fences for resource management and dma-fences 
>>>> used for
>>>> completion- and dependency tracking and lift a lot of restrictions 
>>>> for the
>>>> dma-fences, including prohibiting infinite ones, I think this makes 
>>>> sense
>>>> describing the current state.
>>> Yeah I think a future patch needs to type up how we want to make that
>>> happen (for some cross driver consistency) and what needs to be
>>> considered. Some of the necessary parts are already there (with like 
>>> the
>>> preemption fences amdkfd has as an example), but I think some clear 
>>> docs
>>> on what's required from both hw, drivers and userspace would be really
>>> good.
>>
>> I'm currently writing that up, but probably still need a few days for 
>> this.
>
> Great! I put down some (very) initial thoughts a couple of weeks ago 
> building on eviction fences for various hardware complexity levels here:
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fthomash%2Fdocs%2F-%2Fblob%2Fmaster%2FUntangling%2520dma-fence%2520and%2520memory%2520allocation.odt&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C8978bbd7823e4b41663708d82d52add3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637309180424312390&amp;sdata=tTxx2vfzfwLM1IBJSqqAZRw1604R%2F0bI3MwN1%2FBf2VQ%3D&amp;reserved=0 
>

I don't think that this will ever be possible.

See that Daniel describes in his text is that indefinite fences are a 
bad idea for memory management, and I think that this is a fixed fact.

In other words the whole concept of submitting work to the kernel which 
depends on some user space interaction doesn't work and never will.

What can be done is that dma_fences work with hardware schedulers. E.g. 
what the KFD tries to do with its preemption fences.

But for this you need a better concept and description of what the 
hardware scheduler is supposed to do and how that interacts with 
dma_fence objects.

Christian.

>
> /Thomas
>
>

