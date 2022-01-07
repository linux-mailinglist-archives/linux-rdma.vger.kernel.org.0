Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EA3487D87
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 21:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiAGUL4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 15:11:56 -0500
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:48161
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229889AbiAGULz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 15:11:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7TJgMMS2axQ9AKkzjTncRj9AUsxzdunz34ezDS1cN7r4Usg7Gif1y233d/3dk33c+NMpNM1lJtMuXT4aKESvxnu9BUAoAsJ7zGHNOpNMTnyAhDEUbitwtY5XPlppqXo+Ng1XMibcrC9oDt8d5aicsxyUm+KSzfs4Hcz4lQ9QbmGhKmqm8h1A4gwN1LQdYu5yUOOq/gvLYDSTo+y1ITap+JTxKGa8cVG8UUr6gdnIUBjnRxBT3ccOSOmYVzohsFSlBcT7914HdcRbvE+qfIomdkIIDXHI39na2K24d/ZLq8491XGWmXq1Oo9tezED+L3Yr/HKaegqTotMh8zZfbdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EpCxHI4xR472G5ynhzVtR6r4S5k6nN4d6C6llVrVq0=;
 b=aE6QPqe9sMCGp5fDyoxK6A3K3G+opCtrs7OwQxlnaQ6a+jlww4kX0I1AGTvX/gEGhGWlOUcFfN3HHxGz0xcEUsl6yHaLIDS5igxdcvSOs0rr6J5htnJnbaOmpue1x/E+ZU65uQW4iUBco8YBa0exMsu0o7Uv1++otyBCUI/PIghS6L6OYWI3ZjnmFsRVaIWXQCbvoCq5nuBzW870hX1P3u8ASHlg7WdgUrLKS0upjSxBqLGuTLmEGkPtjzepysx0o5S5gZDillrO9g2Qk4yi56xYtPkndegN8kjRPXlXnhj1XyJUGi6on3PmxLJwcK7mrMbXAs4EpYw7zZdHi1EE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10) by
 MN2PR01MB5838.prod.exchangelabs.com (2603:10b6:208:17a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Fri, 7 Jan 2022 20:11:51 +0000
Received: from BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6]) by BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6%6]) with mapi id 15.20.4844.019; Fri, 7 Jan 2022
 20:11:51 +0000
Message-ID: <31adf601-f951-0178-9e34-f00b6ed78289@talpey.com>
Date:   Fri, 7 Jan 2022 15:11:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
 <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
 <20220105235354.GV2328285@nvidia.com> <61D6C9F9.10808@fujitsu.com>
 <20220106130038.GB2328285@nvidia.com> <61D7A23B.40905@fujitsu.com>
 <20220107122244.GR2328285@nvidia.com>
 <472f1a2d-65de-91f7-35be-8338ec3c0635@talpey.com>
 <20220107192822.GC6467@ziepe.ca>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20220107192822.GC6467@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:208:32a::29) To BL0PR0102MB3313.prod.exchangelabs.com
 (2603:10b6:207:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d95d5c0-59f8-4673-d10b-08d9d219f142
X-MS-TrafficTypeDiagnostic: MN2PR01MB5838:EE_
X-Microsoft-Antispam-PRVS: <MN2PR01MB5838DC9C77215A202BE5D8A5D64D9@MN2PR01MB5838.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9u2PoxLs335y/DCUqIb4jsW2X4Sy2RpH60nY6p/q2M9cCJqcrDI+zWm2f/AqmxM30GA+ASmGK+pkXPZ9jBM+z2nuutwwlhqr4lq5FO23L/L5PEFc4HX/arXYQpChSAlyzCx05o5GYudyBWX7Gjb9RaAl5gtSGB4mcgUFGPrViPIf5DhA5gZcZaw2LPXbE0Xb2SzkUhcmikNsKl9/4IkSiYZYA282v/k+is4dFDcg3oOuHhhoEv2VCjGqtPayWrghHom0wVdztW3XA6M0Eo39Zq6zAGjnlwR/GrRP0PqSGsQqC58z6pgDfwA9D+UH5H6b4+RVDL/TvY19DzPlLcZ9BXTC9WMwQeXqZXD9bEMYnr8kIw5e1gPFD7y5WDnd/G8gCDG65W0EaNkU6URITHHt8schnrl2J8hGpAjrpdD4DAUu4jwJfCgj5E4fPmFPsHdVpcqqfMHLY0IWOHey8wfzpkAej1ATDfrqZMgiq/v3dLy4iVSKUiVCpqB6sQuR7mLNy4+t4uYMDXLWYJ8OXlJeQAVaGPoy8bLNUOd9/PQQ/ws6Ow46VgxCVwtlrX+oH/kFKRDBXBka7fiNP01kEJtIMCuAkwFxnWtkksaH9Abqb9ypRKNfEJFmoUN3nOHOoHzGFl+x4GMAwc8rKjf/7pY4iX4gwMtA9EOKXbv1Gz+8I/ZsZV3Nzw7A+sQAOALDaPR5bBpXj3Z8of99ONWklFc93pWBovcv39nOqI30Z8CN2uE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR0102MB3313.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39830400003)(396003)(136003)(346002)(186003)(54906003)(2906002)(316002)(31696002)(4326008)(8936002)(508600001)(5660300002)(26005)(6486002)(66556008)(66476007)(52116002)(6916009)(66946007)(6512007)(53546011)(6506007)(8676002)(2616005)(31686004)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0s0QW9lL2E0T1g5dXhnTlR5clJoNFQ1R0R2cjhPeWc0d21lWGphcm85K1dh?=
 =?utf-8?B?T1hKN3lFcUN3QmlkdThsSVQwbzFrd3FvSHBJTFBmcDZHM3pLZVFXN3pBWDA3?=
 =?utf-8?B?N2RsblA5eWQ5MkVIVWlVQzEzWFYyNnJKckZTbndRWG9VTFNoNjJzaEhiWDVM?=
 =?utf-8?B?Ni9oQ3l0SG9Bak4ySjN5OUFDZURuWVkySjRVRFFBa1JzWHpidXpXR1FBamF5?=
 =?utf-8?B?SmJ4dVRjWjdNRytacDJUeUxUNHNZME51RFRJamQwRk1Ldy9vOW1uNmNOSHFi?=
 =?utf-8?B?Mis0MlRKVHR2LzJlWlZCK3dOSnZZMWl5Yk1ub1dIb3owOXl6UThBUEw1S0pD?=
 =?utf-8?B?c002QmQ1eDl6TjFXQ3hJUWZwcDZieHdWSTRDS0xEVU81cFFaUFBQTUZGcEdi?=
 =?utf-8?B?RlpDWkNDRkZqQm03OFZxNFM1YnZTOEJEaEN4eEtQV2NjZTMwaG40QUViQ2Zw?=
 =?utf-8?B?bU5iNDRNY0dUOHFQbG9kRU83bWFDemFmUHYwRkozNEgwWVE2blEzU1FUckxl?=
 =?utf-8?B?K2FQdk5DQWNiTDZDUU03Q2Z1OUtyVGhSUU9UZXV5eHBsM042bURPL3ZrRkMy?=
 =?utf-8?B?RDFLclpMUFp0cDF6YzVCM0pKZTBCelFoWXlhY3dPY2hQNFFqcldvSTB2b1ZJ?=
 =?utf-8?B?dk1zYVpTbGZ2OXhqYlJ0S3FOVXFDQTNlZ2VHK3hVOENEYTVmWU1zMmJHNFlF?=
 =?utf-8?B?bGlRWUl0bXpOZnYyT1dIRHlrc0RkYXh3Zmt0ZUpnNlRKNytCSi9Ba3RyYUNM?=
 =?utf-8?B?d1kxQ200U3dUWmNzb2NucGFqWi9hY2tVc0Z6KzBoVEN6K0txa3pHTGhYdFNk?=
 =?utf-8?B?L2djL1FVM09lTzROU201VjM5ZDNOeUxQTElhSWxOdWVMTHNNSVU2RjU5QW82?=
 =?utf-8?B?L0FQUkpxU05Lc1dDckpPeXdMQ3Z3dVNpWUNjZWZhRGk0dzF4SnF4cmJkcTFv?=
 =?utf-8?B?ZVZ0WkZPQ1RYQnVzcXJwUk9NMkNvQ0VMZ09ZMTF6aU9QOHQ5NWM3TlYrMGlQ?=
 =?utf-8?B?U043bEF4WWFOSnphaHJ1WmlYS09rNmkxUGR0ZG5TZWEzU1ZDOFZpTmN5RjdY?=
 =?utf-8?B?RFIzc2szajAwek5PbnRIb0FmQnc2SkYxTEN2L3ZzQXA5MWhwc1pCRnNxZC83?=
 =?utf-8?B?TjNBK2tXMm5WbHlJalEvbFA2L2NMWStRT1J2Z0Z5N0pMVmlhelRkajNPd21x?=
 =?utf-8?B?eXl5S25RTzBzckdTNS9sK0czcCtIRzBXcmtCRmVLMmF6MllPUi83MjlzSkZ2?=
 =?utf-8?B?VkxYRUR0RG9LWVlGSDBCL0xoQlRDdmNoRXdBai91MVBqQzU4bmEydm1ZbkU4?=
 =?utf-8?B?TlpBNms4QURFVEl6RzBVdjIyTGJSWjU4djV0cTkvQUR3dWFmaTlzc2VRckxN?=
 =?utf-8?B?OXpTVDJmaERYc2RKSzlLdXJVZEtDU0dXUHZBMk4xS2VVeVdHeUp4UERtSTV1?=
 =?utf-8?B?ZkR5QmdKZnhHNmY5RmFKbHUxSlUvVW1JYVZTSkhaMGI1RXVJcEVpUjJDSlhS?=
 =?utf-8?B?eml3S0tXamtMS2tGL2trSVNocWd6TTRDTmJlM1R6eXUrNFRneGxSanhwQ0xS?=
 =?utf-8?B?THpXY3pBbEpvWWo2bzhDRkN2OTlocTR0Zi83RmQ5cXNSb2FyVGdWMisvd0M0?=
 =?utf-8?B?b1hZVDdtcWV0T243OWN4dEZXOFIxYjgwY2k1RThBOWh2c2RublNuc2dJZ2Q5?=
 =?utf-8?B?QS9WTUNoNjd2TUl0eS9YeDJiaVVDVGgxUnk3SFdWWk9xNGo2YlRDbGRYTG83?=
 =?utf-8?B?dDJNVXZrYk42Q3I3cUMwRURYVEh6Y2o3L0hrWnIxSHZaRS93NDNSZmJjQmNo?=
 =?utf-8?B?a2Qwb2VDQ3d3UkJuNktnWUtFazVmbjJFeUdabm5yRk5ET3hyUUxlRjR0a2s0?=
 =?utf-8?B?Nm01QTE0d01ucGxpODJyNlk0VVZpMTYzY0ZpRkMzVXhub1BWWXkxZFF6bC9K?=
 =?utf-8?B?dnQyN0lQUTZyeVhDZVJaQTIyR2xGaXhxOHVOcytwQ0svZGtXdnpzdzVBeko2?=
 =?utf-8?B?ckN3WUxoM1NxUWlOQjRJM1NOMDRqOVNsaFBncGdCOW5qcXlvZU4yYkYyUEs4?=
 =?utf-8?B?WmlZRWZNZGhJNmt2UXVtKzVjb21CMmQ2ZitJcnByUHpyU0dqbE45aERsaDVS?=
 =?utf-8?Q?mxC4=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d95d5c0-59f8-4673-d10b-08d9d219f142
X-MS-Exchange-CrossTenant-AuthSource: BL0PR0102MB3313.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 20:11:51.4432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1o/3h3kZHPAu7bM7bLc215b+w9iU6WHZHvaNxP2pNhswVrwp3RWV6z9Qei5mi5ni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR01MB5838
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/7/2022 2:28 PM, Jason Gunthorpe wrote:
> On Fri, Jan 07, 2022 at 10:38:30AM -0500, Tom Talpey wrote:
>>
>> On 1/7/2022 7:22 AM, Jason Gunthorpe wrote:
>>> On Fri, Jan 07, 2022 at 02:15:25AM +0000, yangx.jy@fujitsu.com wrote:
>>>> On 2022/1/6 21:00, Jason Gunthorpe wrote:
>>>>> On Thu, Jan 06, 2022 at 10:52:47AM +0000, yangx.jy@fujitsu.com wrote:
>>>>>> On 2022/1/6 7:53, Jason Gunthorpe wrote:
>>>>>>> On Thu, Dec 30, 2021 at 04:39:01PM -0500, Tom Talpey wrote:
>>>>>>>
>>>>>>>> Because RXE is a software provider, I believe the most natural approach
>>>>>>>> here is to use an atomic64_set(dst, *src).
>>>>>>> A smp_store_release() is most likely sufficient.
>>>>>> Hi Jason, Tom
>>>>>>
>>>>>> Is smp_store_mb() better here? It calls WRITE_ONCE + smb_mb/barrier().
>>>>>> I think the semantics of 'atomic write' is to do atomic write and make
>>>>>> the 8-byte data reach the memory.
>>>>> No, it is not 'data reach memory' it is a 'release' in that if the CPU
>>>>> later does an 'acquire' on the written data it is guarenteed to see
>>>>> all the preceeding writes.
>>>> Hi Jason, Tom
>>>>
>>>> Sorry for the wrong statement. I mean that the semantics of 'atomic
>>>> write' is to write an 8-byte value atomically and make the 8-byte value
>>>> visible for all CPUs.
>>>> 'smp_store_release' makes all the preceding writes visible for all CPUs
>>>> before doing an atomic write. I think this guarantee should be done by
>>>> the preceding 'flush'.
>>
>> An ATOMIC_WRITE is not required to provide visibility for prior writes,
>> but it *must* be ordered after those writes.
> 
> It doesn't make much sense to really talk about "visibility", it is
> very rare something would need something to fully stop until other
> things can see it.

Jason, sorry I wasn't precise enough in my terminology. Yes, the spec
is not concerned with "visibility" full stop. The new concept of
"global visibility" is added, and is what I was pointing out is *not*
required here.

> What we generally talk about these days is only order.
> 
> This is what release/acquire is about. smp_store_release() says that
> someone doing smp_load_acquire() on the same data is guaranteed to
> observe the previous writes if it observes the data that was written.

I like it! This definitely looks like the proper semantic here.

Tom.

> Eg if you release a head pointer in a queue then acquiring the new
> head pointer value also guarentees that all data in the queue is
> visible to you.
> 
> However, release doesn't say anything about *when* other observers may
> have this visibility, and it certainly doesn't stop and wait until all
> observers are guarenteed to see the new data.
> 
>> ATOMIC_WRITE, then there's nothing to do. But in other workloads, it is
>> still mandatory to provide the ordering. It's probably easiest, and no
>> less expensive, to just wmb() before processing the ATOMIC_WRITE.
> 
> Which is what smp_store_release() does:
> 
> #define __smp_store_release(p, v)                                       \
> do {                                                                    \
>          __smp_mb();                                                     \
>          WRITE_ONCE(*p, v);                                              \
> } while (0)
> 
> Notice this is the opposite of what smpt_store_mb() does:
> 
> #define __smp_store_mb(var, value)  \
> do { \
>          WRITE_ONCE(var, value); \
>          __smp_mb(); \
> } while (0)
> 
> Which is *not* a release and does *not* guarentee order properties. It
> is very similar to what FLUSH would provide in IBA, and very few
> things benefit from this. (Indeed, I suspect many of the users in the
> kernel are wrong, looking at you SIW..)
> 
>> Xiao Yang - where do you see the spec requiring that the ATOMIC_WRITE
>> 64-bit payload be made globally visible as part of its execution?
> 
> I don't see this either. I don't think IBA contemplates something
> analogous to 'sequentially consistent ordering'.
> 
> Jason
> 
