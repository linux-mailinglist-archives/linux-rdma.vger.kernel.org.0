Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EAA482486
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Dec 2021 16:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhLaPJy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Dec 2021 10:09:54 -0500
Received: from mail-sn1anam02on2059.outbound.protection.outlook.com ([40.107.96.59]:20100
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229453AbhLaPJx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Dec 2021 10:09:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NggPPLKcf8MhW928lhc0Ck2TopQWi51BT48xjClpIRY5hwcO1dsh4HMjoZYZS50yNP2k28sPQuZlc953nch9t2kFbwKmY+gc/2xx4Qhe+ZuKkzDMgjbBBeNnUJLobmNt+Nkl44eXtpBXG11DGYo99u5hawOhoAuw/mumXON7tjTdgH7kbSivDOvTHDSTxIOWsNDrv+Y8kz/laAiIv0pz/MNtochaJpj8th6USAZIa2B2wyUxkriegH9gCJS3g7dCEB209WGofuhGeHyUWwFHKvRVhSEEtsllyKrRldsQqLJyUCKyVam2qUabGTVuG2EKcypRBzeJdeh3T5BNNGIt5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJ2AkyyP6ff8viltNmS+ZjzCZpzHH4gkxtdb+IoNLdU=;
 b=Cslm+V/wFNqKrzBVMUkhABkZ9Cd1mnnraVqOBBKHsluIe1oJqQRhgkgvRQLI/ZvRp5Zb10rFdANfkTlcUJNbh6YFlBAGStW+khyuO1gSV9CkYFB+bPNEBUijoKcowsn2SNfdyYNg+CWW1FMycG8lSNOz9k5I0gHdRluorahwNE+0+LdFkOwQmd68d+blr2av3qkGYNue/63vaNFt6mQyzBi5l2zadZnRroPpTAvult17T99fjDydDuwKpQts0WQ3BWg/Y64pNvvaA+vJc1gotSU8CGsQmYDeElH1o78g5jH7zfvuOBoULqGfKOPJMTjAKWjMt+6e2EGGVpDy/Y9nKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10) by
 BL0PR01MB4978.prod.exchangelabs.com (2603:10b6:208:68::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.21; Fri, 31 Dec 2021 15:09:48 +0000
Received: from BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6]) by BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6%6]) with mapi id 15.20.4823.024; Fri, 31 Dec 2021
 15:09:48 +0000
Message-ID: <0a226c28-9565-55cf-7680-432b28a02cfb@talpey.com>
Date:   Fri, 31 Dec 2021 10:09:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Content-Language: en-US
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
 <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
 <61CEBF4E.1090308@fujitsu.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <61CEBF4E.1090308@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0025.namprd19.prod.outlook.com
 (2603:10b6:208:178::38) To BL0PR0102MB3313.prod.exchangelabs.com
 (2603:10b6:207:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c173f5c7-7584-4de9-bacb-08d9cc6f9625
X-MS-TrafficTypeDiagnostic: BL0PR01MB4978:EE_
X-Microsoft-Antispam-PRVS: <BL0PR01MB49780BAC4125F8F63842181AD6469@BL0PR01MB4978.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xEJjDYbWbqJB3vCtsnK1Cjckcu6USh6Ncvgbvp9EQ08T0zV+v0g86wV2UZG+SAEO0CkKAE2oL4ru9CcxTw+TdPE+2zHitShD6+JTjLYqkRdMA1B053CfqYlsckvzjX71wHQr0Xx2NGQXj7Ifju0N0htq8JpjueaG2tig751LSi2w4PU5uDhtltoVWlyhRKJMqmez0s2z0QoxDOyeLz2DQoA0PWIRfGUWWgC9CdnLL+30gMC4xNUED/ARoQ3NJHdGjQYLFR6IXuMzz6JKS8M1882d3YwjTn75xm4J33pD/K5HJdWNqwkFJ4Uggs23ikDUDQzrIZouSj1ZcKo9Zn+Fl3I6jDbNJ9He9bS6PBC9qS33QHlhdO6PT4QWHuFJyIoE7vYBJ5j4Y+YpFuyx8mIK+CmGg7DangEkbn+45+5Kry6Kqc+IN7zXdbm/fjHP5bHjV4tel3IoVB0lVtbtiErHYa+uOe7SYD+qQp1/xoZqnHLhDhmn6u1YmFm4cqza4u7Fy1r8xeFOGDRIdLNsok6E1SaC0Nb50J17xkpCdPD9rj8I/RFIi3M49AAXjn9GwYAwRd5dsUokHp9W1Bse7mN6DGoBLtru/Q9KmpaSFjWye7IMsL+6D2TYNQvcqsrfdjvvHkvV4D9DzOyAWvoMPrtAzewqQ2IXnh3GsX2gBZpeiuDkzARfVMnV/Of0T4OvE13zJwmP8jlaJ6+OBzTp8Pth6H1iPs2aPMf/wVMukEKbanY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR0102MB3313.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(346002)(366004)(39830400003)(31696002)(6486002)(53546011)(6506007)(316002)(38350700002)(66476007)(5660300002)(66946007)(66556008)(31686004)(8676002)(26005)(52116002)(2906002)(4326008)(186003)(8936002)(6512007)(508600001)(38100700002)(36756003)(54906003)(6916009)(86362001)(83380400001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXlDRzArMzJoOXNLTTRmZll6cXFEN0d1SWZKVC9OUW1tWThTV0c4ZDdtZU8w?=
 =?utf-8?B?U3BrRkJlUG8yVy95cGFPcVlPa1NBSk5yUlVJam9FcVgxUC8vUm11Y1ROUXdF?=
 =?utf-8?B?aTE5MFFIUVBkZ1NUSUFWakhoYnVHUUhsR3lUSldsYWcrZnozeG95RTNHVWNS?=
 =?utf-8?B?Q2VQdXVSakViTFhFQjlFRzIyeDRLUDlKOTF3c2c0RStOa3BpVTU0NHRlcFRZ?=
 =?utf-8?B?b0p1QmxMOGVGRzlUdTRZVlRzNXBPSVVOZFhyODRmbkdvbHRhY3J4WktUL09n?=
 =?utf-8?B?UFk2MURzblFwOUdEY1NjYUprUFJMeG1uZ25KK1Y3ZTRFUGVtMlZ6QTVRdjdm?=
 =?utf-8?B?N1lnM1FPU2xteFZSSjNXRDY0NTEvZjAvbTN1RVRkT3V2eWp5WUVtbWNoQU11?=
 =?utf-8?B?eWJXeGtpODYyNE9ORFBINWpCOStRVVFtRUlrcnIvcUNvZ28zclZQSzg3TjY0?=
 =?utf-8?B?VDJMeU5RaGl2KzN1SFh0Y3NMdFZLSkE4WmZFUzlhNjJFd3NIbFJabEM2WGJ2?=
 =?utf-8?B?bDlEUFJNYXo4VG9EOVJVLzRKdTlQSG54UWxOYTFpM0Rvc0JEZjJaQzM4blZ0?=
 =?utf-8?B?cGE2YVBjaGF6RGh4cXNTblVkMTJGS1FybzF3aHZja0FaVi9EVHFyNWdDOWZj?=
 =?utf-8?B?TDJlTzVibGE0ekpGdGpyak5PSkJwZndVd0NES0pKcktndmM2RG1yYlhwRFIv?=
 =?utf-8?B?MWZNdFdQV3dpT1FiWTVkb245bFp1OFlkUm5ONjlFQTFSOXFDZUpjWk1DbGhO?=
 =?utf-8?B?RGhVcWI2TTAreEJ1OUY5TkpaSC9nWmxoWGtkQnJmMG9UTTZ3aXRhTlE2MHZH?=
 =?utf-8?B?OHBIOVpnYmhFZnBQaG54alBBLzVBRnlyczJTZ094Uk5vd3pUODNmTFlidGR4?=
 =?utf-8?B?WkxsSVNRT2wyUnYxOVpoTG9sN0FiSzJnaSsvMHh1Y3RIM3FjMXNhVUhXVkV6?=
 =?utf-8?B?RmZoOFdQYTY0czlkRTJHZjVxbG1ZWjc3cWpFVDlZWUV6WnFSQTJIM1dpcDRq?=
 =?utf-8?B?NHJPQm5XNDVHU3pGbUk3UWlraW1zaXlsVHplcDVzcHZxc3dsVFVVKzZTNk1W?=
 =?utf-8?B?bUpoM3d0djRPSi9xTmdiNFgxZFJsRkdOS3BxU1BWMlM1Smg5eDQxUk03QTdq?=
 =?utf-8?B?eWRDZkU2ZTRFL3RXN0NtaHdQbGcyMlNka3N3RTIxc3VEQ1FkajgwWWdsZnJp?=
 =?utf-8?B?SU5sd2RvWWN6YWxub2NFdEE3cEpwS0ZWR1c1L1cxUWxkdnlKWTFleFI4YUF0?=
 =?utf-8?B?N2hUWjFmY1liZ2JpK3lWMmkrMzFCSHEvODdEdWt3OU5jV2F3dklqVXVud2w0?=
 =?utf-8?B?OGtWcmJpM2NDRVR0M085ZTYwTlo2MVEzUlpJK3lCeWZHK082LzlqMXlkQ0xm?=
 =?utf-8?B?d2pteE0vOFhpQWlvd3JIcDE1UlZPZHFMdXIxN09CaG5KUzNLR1daSkgxU3hC?=
 =?utf-8?B?UGYzek12ZUx2K3FqM3JQZWNPM0xsTkZOZGtsMDdZVlpXNTQ3SzUzRFVuWEtR?=
 =?utf-8?B?SEhjclVFcnM1aExBRnltYzZQYUszVExmZHVQZEdvUkpHQ3RNc3pGV1hyREFW?=
 =?utf-8?B?N3dTNElsNlByOVZlNXVHVjdRQWo3Q3lsbXloeTZtbW80UFF4Z0x0dzg3TXp1?=
 =?utf-8?B?cG5KL3hOWXpnWHVzY1FLZEtSektQeVQwanphK244WXREdVdBeGdSSmNkMDRU?=
 =?utf-8?B?aDZXdlJVSEQ0N3V3MHpqY3BwcEI1NWZuOU9vd1RMNEFvWWllWWZzdDFBT2JN?=
 =?utf-8?B?NzlOVldMSDFlNXFadlBhZ0pMYk1ORXNFaWVZUWdDZStzb1pURjVGWW5lSlBj?=
 =?utf-8?B?WS84ZGJkdjFGemFHQjZ5UExXaHorS3M1d3dFcDh5MHBzZDZkbE5QbHBGNVZD?=
 =?utf-8?B?OWx4aktnOS9FN25TT0dSOXowT0VnTHlINDBlRzlSVkxZZ3U5djIwSU13eVor?=
 =?utf-8?B?SWNHWFZsWXlkRGV1ZnBpOXlNV3dsWHhqWmZNYTFrSHZ4MmJqMHhlR0tsc1Y4?=
 =?utf-8?B?eGN2TEMzWFZzbGYzb3RhSlRqRFZRTERsZnVwMk5qQXQyV1BOMGtXZnVTb0Ft?=
 =?utf-8?B?QXdlMkNwZkhyVUpXZ2dKQ0c4aHcvL05ZeWJXZ1hza0hrS3Z6RjVRdUxtbHYr?=
 =?utf-8?Q?cb/Y=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c173f5c7-7584-4de9-bacb-08d9cc6f9625
X-MS-Exchange-CrossTenant-AuthSource: BL0PR0102MB3313.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2021 15:09:48.3376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldrnK/WSzjBfRWgK0YnCtwNIN0z/1mfrKwAsSKjLodEL1eVQZObUbaAGMbHMmHC+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4978
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/31/2021 3:29 AM, yangx.jy@fujitsu.com wrote:
> On 2021/12/31 5:39, Tom Talpey wrote:
>>
>> On 12/30/2021 7:14 AM, Xiao Yang wrote:
>>> This patch implements RDMA Atomic Write operation for RC service.
>>>
>>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>>> ---
>>>    drivers/infiniband/sw/rxe/rxe_comp.c   |  4 +++
>>>    drivers/infiniband/sw/rxe/rxe_opcode.c | 18 ++++++++++
>>>    drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
>>>    drivers/infiniband/sw/rxe/rxe_qp.c     |  3 +-
>>>    drivers/infiniband/sw/rxe/rxe_req.c    | 10 ++++--
>>>    drivers/infiniband/sw/rxe/rxe_resp.c   | 49 +++++++++++++++++++++-----
>>>    include/rdma/ib_pack.h                 |  2 ++
>>>    include/rdma/ib_verbs.h                |  2 ++
>>>    include/uapi/rdma/ib_user_verbs.h      |  2 ++
>>>    9 files changed, 81 insertions(+), 12 deletions(-)
>>>
>>
>> <snip>
>>
>>> +/* Guarantee atomicity of atomic write operations at the machine
>>> level. */
>>> +static DEFINE_SPINLOCK(atomic_write_ops_lock);
>>> +
>>> +static enum resp_states process_atomic_write(struct rxe_qp *qp,
>>> +                         struct rxe_pkt_info *pkt)
>>> +{
>>> +    u64 *src, *dst;
>>> +    struct rxe_mr *mr = qp->resp.mr;
>>> +
>>> +    src = payload_addr(pkt);
>>> +
>>> +    dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset,
>>> sizeof(u64));
>>> +    if (!dst || (uintptr_t)dst & 7)
>>> +        return RESPST_ERR_MISALIGNED_ATOMIC;
>>> +
>>> +    spin_lock_bh(&atomic_write_ops_lock);
>>> +    *dst = *src;
>>> +    spin_unlock_bh(&atomic_write_ops_lock);
>>
>> Spinlock protection is insufficient! Using a spinlock protects only
>> the atomicity of the store operation with respect to another remote
>> atomic_write operation. But the semantics of RDMA_ATOMIC_WRITE go much
>> further. The operation requires a fully atomic bus transaction, across
>> the memory complex and with respect to CPU, PCI, and other sources.
>> And this guarantee needs to apply to all architectures, including ones
>> with noncoherent caches (software consistency).
>>
>> Because RXE is a software provider, I believe the most natural approach
>> here is to use an atomic64_set(dst, *src). But I'm not certain this
>> is supported on all the target architectures, therefore it may require
>> some additional failure checks, such as stricter alignment than testing
>> (dst & 7), or returning a failure if atomic64 operations are not
>> available. I especially think the ARM and PPC platforms will need
>> an expert review.
> Hi Tom,
> 
> Thanks a lot for the detailed suggestion.
> 
> I will try to use atomic64_set() and add additional failure checks.
> By the way, process_atomic() uses the same method(spinlock + assignment
> expression),
> so do you think we also need to update it by using atomic64_set()?

It is *criticial* for you to understand that the ATOMIC_WRITE has a
much stronger semantic than ordinary RDMA atomics.

The ordinary atomics are only atomic from the perspective of a single
connection and a single adapter. And the result is not placed in memory
atomically, only its execution in the adapter is processed that way.
And the final result is only consistently visible to the application
after a completion event is delivered. This rather huge compromise is
because when atomics were first designed, there were no PCI primitives
which supported atomics.

An RDMA atomic_write operation is atomic all the way to memory. It
must to be implemented in a platform operation which is similarly
atomic. If implemented by a PCIe adapter, it would use the newer
PCIe atomics to perform a locked read-modify-write. If implemented
in software as you are doing, it must use a similar local r-m-w
instruction, or the platform equivalent if necessary.

Tom.
