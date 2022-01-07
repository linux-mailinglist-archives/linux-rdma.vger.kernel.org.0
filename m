Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31004879EC
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 16:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348142AbiAGPuv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 10:50:51 -0500
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:55978
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239713AbiAGPuv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 10:50:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0yP525urG/L/68ZjjxkEnzTJMK3ULD5VRY8JvNoYLeu7GaUobbIVDDM1xPJhAHpqTK0zkT0hGQhBOMgtA2wRygBxBNY+6A9u9H6iaVPmFLLErSxoy+ndc9O8Djy/uvaLgw8GHftgSiHY9w/kJKhkYUnPBU6mtcfTgPJjUNsy56+3OzYO1HLrT2JdQLTP3nAGmsFlD1eqHuWRt7UbwBffmqJW4GhH1Y90qqMyv/b7bdeGJqavalykx6GJRF316o+uMWlVugJs3k/fQz34m5UEzzz2E+vggZZqslSQv8F+xY0wR2i+6I12TFa2cElRzuYHIHlPMc+fbNtk4+CAyEaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Cesilmv/54h2JCtixvRlyECM97cUYC1Co2pME4eCmY=;
 b=K8Z1/0XodLs/xvE0VCb4tIOtaWl1dwbKdk7pEkMZPpwGaJkHWtMvdP5JEAIgRGDk3N2ao0f8jSs4dDYriMdivB2VKP6G8XeGROzlTXPWzZXe1xkhBjOM68z0RiSlv/6r3pv8cO4GZvXyS4YdFlsp08AlbYkClmVQbBVMBJiyzHvDtlw0SCzESOw/yIJjIIdcviavSpqGnuE4uumKNbWOTxNbMhx8uAFumJ1nWFJzAK+T+6W24vMlMKNlpHTB1dxoGRrcC4AvkUUpQmEizIjcWSw+mgJBuJIYj9+EGurkBoOF71S5eROvfUBjb/alns/UZ9HVFcBvoDDKM5DodzaC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10) by
 BL3PR01MB7026.prod.exchangelabs.com (2603:10b6:208:359::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Fri, 7 Jan 2022 15:50:48 +0000
Received: from BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6]) by BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6%6]) with mapi id 15.20.4844.019; Fri, 7 Jan 2022
 15:50:48 +0000
Message-ID: <130d8b4d-3565-eba1-c56a-58155d3303b2@talpey.com>
Date:   Fri, 7 Jan 2022 10:50:47 -0500
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
 <0a226c28-9565-55cf-7680-432b28a02cfb@talpey.com>
 <61D563B4.2070106@fujitsu.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <61D563B4.2070106@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:208:91::18) To BL0PR0102MB3313.prod.exchangelabs.com
 (2603:10b6:207:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d104d10e-987e-4b9e-825f-08d9d1f5796d
X-MS-TrafficTypeDiagnostic: BL3PR01MB7026:EE_
X-Microsoft-Antispam-PRVS: <BL3PR01MB7026C4A714A8E705C2097494D64D9@BL3PR01MB7026.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfShS57fMhwWgLp8zAPv423JSLVRCf+8yAvYMO/ff2vnpg4UcWYHV2KhGC3UwK/Xec5bdzLltWAjUArzF2L8KJuS1qJ051NhLQxj1nYxvfiwI/6v0dZJFYBkYfBKbB3UfchCzyG4QOOvkI2Wt4KqV4aMAo+WGbz11TcQhlnIEknHrFDccIyNtu1l5joUidMunI+YlT1u5AU6mb+8u4nG+8UHkv4+U2aph8GhyBZsPXGLDZWh0b+weGjZiubFsNSbK8cEcd7bfquAfzuzWeKcy/ZpMJ85eJeTseUXUzlM8rUEGuZkznjsTaB8HIEIPOmr1sZFw5lVOEtx4NH8zF4g7E2/QISghrroECWFIF4Maf6155gPXQ2IrR3wiklt+NMNg3SrHB8GGZhT0l5cfhMK6w/J1aZOleEm5fcaKMNHMgXZYVGrcBbCtqyyQCDnpwo3oSDDaj4/7CzoPpfuQHp1Kl1AI9nIeCqNeTAXd5q95HLqeujo9eGb+exT+ThOUBUS3fJYkcYyLlDOn8oceyGcyLTqcA9G81KXmSWhjchmmsvwCA70LyzRyO6oD8k8elgzUUiGPQ1VIYcnDRRILx8aX0zaaj3wXZezfrQcLw2CSpECQwV/gK4nm3ufwcMLQvWujuiI0o3OYfBLn+/WvKZjm1OdGDKEHDpLPAIxhmTjc2vNdZnvojYdg8n7YOQTaIxPZta3gWCPGHiCFtw5BVzLwsyYROrQbH4BJOOzBe4fkK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR0102MB3313.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(396003)(376002)(366004)(346002)(2906002)(316002)(6506007)(53546011)(186003)(26005)(31686004)(6486002)(508600001)(52116002)(6916009)(83380400001)(2616005)(5660300002)(8676002)(86362001)(8936002)(4326008)(36756003)(31696002)(66556008)(38350700002)(66476007)(38100700002)(66946007)(6512007)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXVPWWNjcVN1ZTM3RHNsNHBVS056YWc1Y2VQMC9UTUx5UWl1bWlReXJPQnZ4?=
 =?utf-8?B?ZlhaNlVUNE1xTll1OGp0RWpoOWhlaERPU2NVUnpoVkMxOHFiY21ZVmwzUkNs?=
 =?utf-8?B?TDRhYldLL3A0Q0xwT2R1bXB4ZEJsYmxsN0xlck8wcy9IMkhleHplK3ZvSFR2?=
 =?utf-8?B?OW9CRUtJWEVuYUk2TnJ5Mld3czY3NUljWFZ0ak40S1Z3SVJjbkh3Z0ovMmNW?=
 =?utf-8?B?NmJRSlhMWWFSZXBiRjJQcTNXSWpFb0JTbjJxbzZSdlFZaDVGajBFbjdOQWd5?=
 =?utf-8?B?Nk93VUhOYmhMOUVyRnArZWprMUt5RU5abTFUWGZ3Z3l1TFVmS1pHYm1ua3Fm?=
 =?utf-8?B?Z0Q2Y3hka2g5TitiOGd6MkJ2UTRRcndIcEFhZ1pIbEVvZTdHclZVbEdEa0lX?=
 =?utf-8?B?UkdKTGRzU2pxRjRoQnFCblR6WFFJQ0RKNjhMaDB2L1pzcFplQTE2NUo5b1lj?=
 =?utf-8?B?cktFaUZBMmtwZHAzaFVOQVRNcTEvMEtOMndYVzJxU1Z2cFhZUXNoeGJnWm80?=
 =?utf-8?B?RGZ5alFJbHlIY1haaUNzcVMyeXBNc0VvSVJJSDF3TkYwcER3MzNPelpEOHlO?=
 =?utf-8?B?cUxkTXZVWTM2TEFSVnlHbStDclNGV2phNFk0MDd0REp6UVBlYm8wVFZFbytL?=
 =?utf-8?B?cld5YWJENlAyZDFHWTZRVFFBcEtKWjRIMzdxd1lHa2xydUhaZ3ZrM1h2NVQy?=
 =?utf-8?B?WG5SR2hhS0h0MVhScDh1bWY0bDB4OURydGdVYTdGUWYrMk95TFJUUjVHeEk3?=
 =?utf-8?B?K3hxUC9IbXZDY0crVGF1cW9UZ2k4cnNhRXJITHN6U0ZaTG9ydm52Yk8wem5v?=
 =?utf-8?B?QVNiMWxkZFJDNGFaRWZWcVF6ZzI1RTNWQnZ2bzZjWm9hMExUdGRCM2w0TzE0?=
 =?utf-8?B?OUtuNmFzSDlSTnNnQnAxWERCK3liVjk2WDBzQ3lnNlFNMjQxdzQreHVvaFdM?=
 =?utf-8?B?N3NXUXQwaDZxMTkwbTNHQ3VZT2J3YUZEYUpZNEhpTDg0cUtVK25rWXBhOWRL?=
 =?utf-8?B?a0VwdytuVWN6K0hmRzREQk1POWRITHdZMVpaN0ZSOTRhUHd5MWRtZXNzRTNT?=
 =?utf-8?B?ZHp4SytFOUN0eG5qYlRZcVpSL0tDOXpDbS9oV0ZCVEpodUdnTExYQ3c0Q21P?=
 =?utf-8?B?R0o3SnZFNGJkbHU1K0hIbzhVVzNyS0EvRlFGREFIV0I5VXlBVkFMNVpMVVdp?=
 =?utf-8?B?WGVWZXI4S1VzeW9kWFc0Rm1SUEppenNyd1d0TWhpak5QUGlwem9Da0lZOVB0?=
 =?utf-8?B?aWRoSUE4UW1rYnlnQVJzYUZQU2swMGpFVnJkai9mdlRENTBjMUhtbjhKY1Bq?=
 =?utf-8?B?UVBNMWViVDBxZFJudE50RkZJb0lRb0NsbHlYakdrMTRqSW54ZnpubUUvQVJu?=
 =?utf-8?B?dnRSb0xLTlRsbnJKcWxlVk51Si9WemswRmZETTJvRXkxZFg2c3Jlb2JNUHZG?=
 =?utf-8?B?cmI5aHNubS9zR0FPV3NhRkNYM0NBSVpTZDcyeXJHQldEcDIyT3ExeExUY3pH?=
 =?utf-8?B?LzFMc0dXZlNXVzgyNlNGUU5PSUpzOU5TZXFOVElzWWhPN2RIL01pL0ZXZmsx?=
 =?utf-8?B?N0t5bDNoSGRvZko2M2p5MElaN1lZbnVrZ2xDSkI1MFdiSG1ta3p1Wk0rNkQ0?=
 =?utf-8?B?UEgwQ0NkLzZYWHRBb0tOYVp2WlRFMFFVQTN1cXM0Tm12aHF0OStrVVgxVGV5?=
 =?utf-8?B?akVxcHpabkk4eFAza0pUNzZLRU10TGsrKzYxZUp0aEZZRzFCNHhjS3o0SHRa?=
 =?utf-8?B?TEpIZGluUkRFQ2VReFh1U1J6VHl3NkhjNjFTK2dDTDFmMmc0TDd6L25pMU1B?=
 =?utf-8?B?OWtjNnFwOXloeXJiUldUME5BcnN1NERmYVU5VnZjVUhRWFlDNW1zNERMRTFr?=
 =?utf-8?B?VWpUL3hvSzl0eDVIcmpnVnhLblVXT1BPZXdOanc2YlZtUXVVRnMvNGpETCtV?=
 =?utf-8?B?S3AzdDhPWnJwd2QrYnYvVW1nc0pyVE5idHlsS1ovbVF3M0UzOVdEbGwwQ3Vn?=
 =?utf-8?B?SUluQzZvZjlxdEdMZHlYWUpKVUdtbUJUa1ZCcTJIam9OaVc3V3NIbnNmY1Bn?=
 =?utf-8?B?dFdYYitOblZTbXVhWFBDaVU4VGhDSUZ1SUViTmtrVU81U1BIUkN0dEpkc0hW?=
 =?utf-8?Q?5XU0=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d104d10e-987e-4b9e-825f-08d9d1f5796d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR0102MB3313.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 15:50:48.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7llyyEaBpxEOkxWZYnwLHwtM9RfbpPI13YyPAXUSfkBHR4Zv08jCiBSxekJEfaxJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7026
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 1/5/2022 4:24 AM, yangx.jy@fujitsu.com wrote:
> On 2021/12/31 23:09, Tom Talpey wrote:
>> On 12/31/2021 3:29 AM, yangx.jy@fujitsu.com wrote:
>>> On 2021/12/31 5:39, Tom Talpey wrote:
>>>>
>>>> On 12/30/2021 7:14 AM, Xiao Yang wrote:
>>>>> This patch implements RDMA Atomic Write operation for RC service.
>>>>>
>>>>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>>>>> ---
>>>>>    drivers/infiniband/sw/rxe/rxe_comp.c   |  4 +++
>>>>>    drivers/infiniband/sw/rxe/rxe_opcode.c | 18 ++++++++++
>>>>>    drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
>>>>>    drivers/infiniband/sw/rxe/rxe_qp.c     |  3 +-
>>>>>    drivers/infiniband/sw/rxe/rxe_req.c    | 10 ++++--
>>>>>    drivers/infiniband/sw/rxe/rxe_resp.c   | 49 
>>>>> +++++++++++++++++++++-----
>>>>>    include/rdma/ib_pack.h                 |  2 ++
>>>>>    include/rdma/ib_verbs.h                |  2 ++
>>>>>    include/uapi/rdma/ib_user_verbs.h      |  2 ++
>>>>>    9 files changed, 81 insertions(+), 12 deletions(-)
>>>>>
>>>>
>>>> <snip>
>>>>
>>>>> +/* Guarantee atomicity of atomic write operations at the machine
>>>>> level. */
>>>>> +static DEFINE_SPINLOCK(atomic_write_ops_lock);
>>>>> +
>>>>> +static enum resp_states process_atomic_write(struct rxe_qp *qp,
>>>>> +                         struct rxe_pkt_info *pkt)
>>>>> +{
>>>>> +    u64 *src, *dst;
>>>>> +    struct rxe_mr *mr = qp->resp.mr;
>>>>> +
>>>>> +    src = payload_addr(pkt);
>>>>> +
>>>>> +    dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset,
>>>>> sizeof(u64));
>>>>> +    if (!dst || (uintptr_t)dst & 7)
>>>>> +        return RESPST_ERR_MISALIGNED_ATOMIC;
>>>>> +
>>>>> +    spin_lock_bh(&atomic_write_ops_lock);
>>>>> +    *dst = *src;
>>>>> +    spin_unlock_bh(&atomic_write_ops_lock);
>>>>
>>>> Spinlock protection is insufficient! Using a spinlock protects only
>>>> the atomicity of the store operation with respect to another remote
>>>> atomic_write operation. But the semantics of RDMA_ATOMIC_WRITE go much
>>>> further. The operation requires a fully atomic bus transaction, across
>>>> the memory complex and with respect to CPU, PCI, and other sources.
>>>> And this guarantee needs to apply to all architectures, including ones
>>>> with noncoherent caches (software consistency).
>>>>
>>>> Because RXE is a software provider, I believe the most natural approach
>>>> here is to use an atomic64_set(dst, *src). But I'm not certain this
>>>> is supported on all the target architectures, therefore it may require
>>>> some additional failure checks, such as stricter alignment than testing
>>>> (dst & 7), or returning a failure if atomic64 operations are not
>>>> available. I especially think the ARM and PPC platforms will need
>>>> an expert review.
>>> Hi Tom,
>>>
>>> Thanks a lot for the detailed suggestion.
>>>
>>> I will try to use atomic64_set() and add additional failure checks.
>>> By the way, process_atomic() uses the same method(spinlock + assignment
>>> expression),
>>> so do you think we also need to update it by using atomic64_set()?
>>
>> It is *criticial* for you to understand that the ATOMIC_WRITE has a
>> much stronger semantic than ordinary RDMA atomics.
>>
>> The ordinary atomics are only atomic from the perspective of a single
>> connection and a single adapter. And the result is not placed in memory
>> atomically, only its execution in the adapter is processed that way.
>> And the final result is only consistently visible to the application
>> after a completion event is delivered. This rather huge compromise is
>> because when atomics were first designed, there were no PCI primitives
>> which supported atomics.
>>
>> An RDMA atomic_write operation is atomic all the way to memory. It
>> must to be implemented in a platform operation which is similarly
>> atomic. If implemented by a PCIe adapter, it would use the newer
>> PCIe atomics to perform a locked read-modify-write. If implemented
>> in software as you are doing, it must use a similar local r-m-w
>> instruction, or the platform equivalent if necessary.
> Hi Tom,
> 
> It's OK to replace "spinlock + assignment expression" with 
> atomic64_set(), but atomic64_set() only ensures
> the atomicity of write operation as well(In other words, it cannot 
> ensure that the data is written into memory atomically)
> let's see the definition of atomic64_set() on x86 and arm64:
> ----------------------------------------------------------------
> #define __WRITE_ONCE(x, val)                                            \
> do {                                                                    \
>          *(volatile typeof(x) *)&(x) = (val);                            \
> } while (0)
> 
> x86:
> static inline void arch_atomic64_set(atomic64_t *v, s64 i)
> {
>          __WRITE_ONCE(v->counter, i);
> }
> 
> arm64:
> #define arch_atomic64_set                       arch_atomic_set
> #define arch_atomic_set(v, i)                   
> __WRITE_ONCE(((v)->counter), (i))
> ----------------------------------------------------------------
> *
> We may need both atomic64_set() and wmb() here. Do you think so?
> ---------------------------------------------------------
> atomic64_set(dst, *src);
> wmb(); *
> ----------------------------------------------------------------

No, I don't think an explicit wmb() is required *after* the store. The
only requirement is that the ATOMIC_WRITE 64-bit payload is not torn.
It's not necessary to order it with respect to subsequent writes from
other QPs, or even the same one.

> In addtion, I think we don't need to check if atomic64_set() is 
> available because all arches support atomic64_set().
> Many arches have own atomic64_set() and the others use the generic 
> atomic64_set(), for example:
> ----------------------------------------------------------------
> x86:
> static inline void arch_atomic64_set(atomic64_t *v, s64 i)
> {
>          __WRITE_ONCE(v->counter, i);
> }
> 
> generic:
> void generic_atomic64_set(atomic64_t *v, s64 i)
> {
>          unsigned long flags;
>          raw_spinlock_t *lock = lock_addr(v);
> 
>          raw_spin_lock_irqsave(lock, flags);
>          v->counter = i;
>          raw_spin_unlock_irqrestore(lock, flags);
> }
> EXPORT_SYMBOL(generic_atomic64_set);
> ----------------------------------------------------------------

We're discussing this in the other fork of the thread. I think Jason's
suggestion of using smb_store_mb() has good merit.

> Finally, could you tell me how to add stricter alignment than testing 
> (dst & 7)?

Alignment is only part of the issue. The instruction set, type of
mapping, and the width of the bus are also important to determine if
a torn write might occur.

Off the top of my head, an uncached mapping would be a problem on an
architecture which did not support 64-bit stores. A cache will merge
32-bit writes, which won't happen if it's disabled. I guess it could
be argued this is uninteresting, in a modern platform, but...

A second might be MMIO space, or a similar dedicated memory block such
as a GPU. It's completely a platform question whether these can provide
an untorn 64-bit write semantic.

Keep in mind that ATOMIC_WRITE allows an application to poll a 64-bit
location to receive a result, without reaping any completion first. The
value must appear after all prior operations have completed. And the
entire 64-bit value must be intact. That's it.

Tom.
