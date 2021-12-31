Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395AC482191
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Dec 2021 03:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbhLaCcM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 21:32:12 -0500
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:40736
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242550AbhLaCcK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Dec 2021 21:32:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6rEZOfiDAyw0zIK8Tss31dMpkAQuiXU5LdDi2fUbmktAURF56oqykQn5g06hZa9C+lRfNKy4pgOKqKGuXKD+NkSGZca2FQ97QoLRZJASizKAUqOjdttWWxvd/4evvg5RrZeHfvi1Yij4R9lgKvuXywyJKOw2wCGnJVrIFYt7AmwTi4U5HL75HzIfQPom/0thR46fGGN0RW0mMklf7LxB/LxmcMnvHaiwkNP7NaZfBQCE2cdXiDdldXTHn3dQvMC6wDZbZrnIv9Fq95Apq8AeaLyuzxQMAT8ePfZJm2LRyU7D40orInnp/QuvzrjeE8W7qzgLnwZ+DsltYPAUU9hyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVckT3mO1jGZQNEYCdjH/SMcVBR9MyIoyHeGTA0uzog=;
 b=RiV3nl+rKB4BI+13YAxNw0NqWPNhnbo56DHU2yOnjAXMMDV4XE+k9voLsXB/jKKkBiQYcYix8Bjwe0Hvk/FrZoL3NDAqZsIdCEDOIcVR54aGSAZWewuPNaiuZdtHkiN66dWljxl03ner7364PqpLDBbCOCcKZhTpXOVhyfM4DWJCxgIxDJ527vdyGA04QuxRsa6OhLbtMheuq+IFivok/ZgZAmr52A2gF0c9fN2cusZWp4m6ELmFRQkoylPPVa5/Gr9Lon61rmgjsinSyLq3Fl5YRXSTwE4Jsbx9+QwCvzPzoN44GFv/YPgCP9zUGrZDS7kROl8xKpx8fW7JwD6Bkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10) by
 BL0PR01MB4834.prod.exchangelabs.com (2603:10b6:208:31::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.22; Fri, 31 Dec 2021 02:32:08 +0000
Received: from BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6]) by BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6%6]) with mapi id 15.20.4823.024; Fri, 31 Dec 2021
 02:32:08 +0000
Message-ID: <17122432-1d05-7a88-5d06-840cd69e57e9@talpey.com>
Date:   Thu, 30 Dec 2021 21:32:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <9f97d902-aad5-db0f-f2dc-badf913777c4@talpey.com>
 <fd561077-358e-e38d-a7d0-5c61593eff6a@fujitsu.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <fd561077-358e-e38d-a7d0-5c61593eff6a@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::15) To BL0PR0102MB3313.prod.exchangelabs.com
 (2603:10b6:207:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f979402-01b5-4d58-0a04-08d9cc05bdc7
X-MS-TrafficTypeDiagnostic: BL0PR01MB4834:EE_
X-Microsoft-Antispam-PRVS: <BL0PR01MB48349ADB24D29911E0340BA1D6469@BL0PR01MB4834.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7mP8tW5/AP4C5Hs9T3/goMyAnoU9SV/+i6fGIZfNESC1h71gSJfn7AtY3y9RLD8TPZwp5kkQV2nE9RJzhqgY6ebjmbO4H7didk5l1f8fw+FPI8Pywa6Q8C/aS9sNzpP4rx2lSCAf51baFlRp1+F7QELSU6DTO6dPMmdkryCHtfpBK0rXuxPDZnIyQ0U3iAWCe4V41PEu1bJNX/QBNV1kL8FxZCxJ9g19g/EfOGW6J33478efmVPYulTsfNY31tBfgkQtAlUMUk1P2HSI9tX+MOrvEu+Ya302xkRvRJKs0j7ZnCfOLoCAta0ptaTtzWqAEejaI3+GCl9H8ELSjHYdEYdlespxYkbQWe9lxw/vzFN34XULhCm87adh75s7qdwuvK07ECqOKr+t2BGzUZUoFOKgSmBifjY9e4pzlEWnBiSKZXVdhR2UTDTqUTA9g/oTw+LM6r5qahUHpU6Bea9Vr6dw4HEVESpL3ecyq7b6Ha0qJxlPDv6/dqf4dbliOtlSG/PLsYiH0BCKE+bylLSSRC1hXXusxMibtsQFjTNeYHHwlfArzoH3MjDVW9JNGaiHo/7j+FEg/nP7YVjpEk8TirPhaOr2UWsD4RcIAaYYo1o0cgJGRganPTOE/BM2nTDkoN222PQhxw0vHVXE783rM58NPsjNTDNFIavQ0WGCIqm6tMkiBTAKOQCER1yL5sZP8YDDDBpnboPwsIKlfbf1oUdsIgzT6bVDHIvSjziQGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR0102MB3313.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(346002)(376002)(396003)(366004)(66556008)(2616005)(6506007)(83380400001)(86362001)(316002)(66476007)(26005)(36756003)(110136005)(54906003)(4326008)(186003)(7416002)(38350700002)(31686004)(8936002)(2906002)(52116002)(31696002)(6512007)(508600001)(38100700002)(8676002)(6486002)(66946007)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlN4N3FLWlM3a21GV0VNakIvQU8ySmhlTW84ZTNWTTZZZ0NjTFdGdE9vSm4y?=
 =?utf-8?B?ZUJSdnBqYWdiSlduWVc0YUdIcGRVeEpndEVNZURGNkd2aFAxelJQQ2l1eXBL?=
 =?utf-8?B?SHo2VmdaVWhTeGdaNXZDbnF4enlzZURWekk0R2xNSENHQTd6eFJkRWIzbXlx?=
 =?utf-8?B?eWx4Q1BCb1FtSlE4WmIxU295Q0cyYmZxZkdxWDJqbFYvaG5DQndqK3U0R2ps?=
 =?utf-8?B?UlZwQlIrWkxBL3FlZmJZUHpaZmVOQ053WWRIQVRhM2pENFN3d1FYWXV6anIy?=
 =?utf-8?B?bjNDa2lRQjBqYnBnQUlLZjYxZDQyUlVzeWFKU2NjTTlTZFdZMzJ1MXFjMk45?=
 =?utf-8?B?aW5FbGVtRDY2N2xSYjJZd2M5SlYvbkNId3dZWlFPZVVha2p6RHZoTzRZTURp?=
 =?utf-8?B?Y1ZvSWpiZ1BkNTZQV0wrS3MzTCtVUEd0ME56c3dSdmk2d2dZUlVPdklFemNo?=
 =?utf-8?B?ZU1WZnB2K3l4K3FTV3JsWlFvWnlUU1c4alNuUmg4amgrcThjQll1NjlDVnhh?=
 =?utf-8?B?cTBMTlhEZHdHdFJRRWNSV3JsOWtGQ0RGSno0U2twWEIwdGh4NzB4eVlYSEZh?=
 =?utf-8?B?QVJYUGpYN2pUajduSHcwUTA0Sjc0bUpEdzBIT0Q1YXNKQWNZYzlkMjN3cTRL?=
 =?utf-8?B?ZndYMm9ubFMrcXc3cEZOMGpDMW1mcmxwUnVxNVhBenZhNkhEVXpvYjdyQWhF?=
 =?utf-8?B?Umw0dFF3UEpHL2ZLM2REekd2TTBoNzV6TmJKS1pCR2VDSGZ4WDUrMHFlZDND?=
 =?utf-8?B?bGxMSHdxQTBCcHh3Y0JENG5KNkdKL3RPbTlSZjdUVXF6N0haaVgybEZxWk5X?=
 =?utf-8?B?YjdxZG5zVWsvY1FnYkV4emJEODIxTGtDRldjK3dTdzJlWUNXN3AydFFnMHdO?=
 =?utf-8?B?TTJDRWRLR2R1SkZ6QU02NFFUV3g1YmNiUURuQ3ZwdEFiTlc1b0J2TFI1Q05y?=
 =?utf-8?B?RFk4dllvUE9NMjV2MFFDZW91d0NYaG1HbXphRWk2M2wvQWg2UmVxd0lqR0px?=
 =?utf-8?B?UzE1ZGdISFNnek9yUnFWMDNzRk12MGtrc0Fud2o0WHNRSHIvSGsvRjF0YWE5?=
 =?utf-8?B?bjhCY3NURGJSdVZrM21tVXEvdFVCYkwxZnk2ZDExaUtOYkwrSVJwbndmdDIv?=
 =?utf-8?B?R2krclFjaEgya3ZmL2VrTTRZSkZNNmJ0NVJWYkkrSThIalpKQUhmM255TFIy?=
 =?utf-8?B?RWFyR1dzV1BSMmQyMC9KMkdEcVBFaStYc0d3UVhFQjkvUmgxVWFJWDNXV2F6?=
 =?utf-8?B?ZTUvd3VGUW96M3E0OEtKendlaHl6ZElTanNIanVaTW9hSzg2Y0hTUTVBZU85?=
 =?utf-8?B?TkM2QitzdDJCN0ZwUXlIeG9oRTJVMkV6cUljYkpmRFpWcWgrOWtweklKWTNR?=
 =?utf-8?B?eTQweThUd29rL0d4R2grSE1MbHIzTlVKbzdzUVVncHRyV2Y2a1BsQ1N3VlBv?=
 =?utf-8?B?UkZ0Q0hXSG82Y1QyQmxxTUVYL2JUQjdwVGRwWFdiSitsZUVmcXpCRXUyMW9L?=
 =?utf-8?B?NkZPcWszSjZNR0pRd1FIMFpHbStvZUkybVBmRkNxZTdpQ2RHY2lMR2xDMzcv?=
 =?utf-8?B?RDlSazRmdmhiYW5tSnBqSkJMOUpWM08xNXNQYWpaQ1FIczROaE53QjhWRFcx?=
 =?utf-8?B?YVkxeXVzWXZjZnFPS3J2empwdUlWdkY1WmNlWGN1ZjZ0S05IUkRJa29oTWJn?=
 =?utf-8?B?U0dOUVZ4RFFWMG11bUdobjJVNXVCbGRyTUsvOUNCd1JsSFRvWHRvcU9LN2Ez?=
 =?utf-8?B?ODVQdmo5eEs5WlRlbWNBalNVUmdlQm1zSFU0cVZvTlAxM1JiWXQzbzhocFRD?=
 =?utf-8?B?NjdSV1FFN1lSUit5RERJSFFIaE9PQTMrNjhGdWpKQTRkanZRbXpWcC9vMm82?=
 =?utf-8?B?SzArQ3M0UmRXNzQzTUQveWdKYUtLeEF2WDIrcjZnZks2ZWVZYmZSQ20rR1BS?=
 =?utf-8?B?KzVEMElrQk5tV0c3N1VjclBtUVozTVl0eDVtdklJUHFLYVcrbDU5amFTaHMv?=
 =?utf-8?B?WXgxTHlaZitLMW43c3hjb0MrSms5Qmd5ZDQwamgrZU1XZ25iYi8vK2RxS0FN?=
 =?utf-8?B?SWpjSnl0MXB5UzQwNm9YR3RtTFZlMkI0Q2VDYVNrdVE1N1lsVi9uOVp5RmJQ?=
 =?utf-8?Q?Y0/M=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f979402-01b5-4d58-0a04-08d9cc05bdc7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR0102MB3313.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2021 02:32:08.1726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUJjmMoyg7eqaWT2J9n91gt1VS4AI4Zk3jZkFxYevp2VTTFFqiCWVWGwFuFImxKC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4834
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 12/30/2021 8:37 PM, lizhijian@fujitsu.com wrote
>>> +static int nvdimm_flush_iova(struct rxe_mr *mr, u64 iova, int length)
>>> +{
>>> +    int            err;
>>> +    int            bytes;
>>> +    u8            *va;
>>> +    struct rxe_map        **map;
>>> +    struct rxe_phys_buf    *buf;
>>> +    int            m;
>>> +    int            i;
>>> +    size_t            offset;
>>> +
>>> +    if (length == 0)
>>> +        return 0;
>>
>> The length is only relevant when the flush type is "Memory Region
>> Range".
>>
>> When the flush type is "Memory Region", the entire region must be
>> flushed successfully before completing the operation.
> 
> Yes, currently, the length has been expanded to the MR's length in such case.

I'll dig deeper, but this is not immediately clear in this context.
A zero-length operation is however valid, even though it's a no-op,
the application may use it to ensure certain ordering constraints.
Will comment later if I have a specific concern.

>>> +
>>> +    if (mr->type == IB_MR_TYPE_DMA) {
>>> +        arch_wb_cache_pmem((void *)iova, length);
>>> +        return 0;
>>> +    }
>>
>> Are dmamr's supported for remote access? I thought that was
>> prevented on first principles now. I might suggest not allowing
>> them to be flushed in any event. There is no length restriction,
>> and it's a VERY costly operation. At a minimum, protect this
>> closely.
> Indeed, I didn't confidence about this, the main logic comes from rxe_mr_copy()
> Thanks for the suggestion.

Well, be careful when following semantics from local behaviors. When you
are processing a command from the wire, extreme caution is needed.
ESPECIALLY WHEN IT'S A DMA_MR, WHICH PROVIDES ACCESS TO ALL PHYSICAL!!!

Sorry for shouting. :)

>>> +
>>> +    WARN_ON_ONCE(!mr->cur_map_set);
>>
>> The WARN is rather pointless because the code will crash just
>> seven lines below.
>>
>>> +
>>> +    err = mr_check_range(mr, iova, length);
>>> +    if (err) {
>>> +        err = -EFAULT;
>>> +        goto err1;
>>> +    }
>>> +
>>> +    lookup_iova(mr, iova, &m, &i, &offset);
>>> +
>>> +    map = mr->cur_map_set->map + m;
>>> +    buf    = map[0]->buf + i;
>>> +
>>> +    while (length > 0) {
>>> +        va    = (u8 *)(uintptr_t)buf->addr + offset;
>>> +        bytes    = buf->size - offset;
>>> +
>>> +        if (bytes > length)
>>> +            bytes = length;
>>> +
>>> +        arch_wb_cache_pmem(va, bytes);
>>> +
>>> +        length    -= bytes;
>>> +
>>> +        offset    = 0;
>>> +        buf++;
>>> +        i++;
>>> +
>>> +        if (i == RXE_BUF_PER_MAP) {
>>> +            i = 0;
>>> +            map++;
>>> +            buf = map[0]->buf;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +
>>> +err1:
>>> +    return err;
>>> +}
>>> +
>>> +static enum resp_states process_flush(struct rxe_qp *qp,
>>> +                       struct rxe_pkt_info *pkt)
>>> +{
>>> +    u64 length = 0, start = qp->resp.va;
>>> +    u32 sel = feth_sel(pkt);
>>> +    u32 plt = feth_plt(pkt);
>>> +    struct rxe_mr *mr = qp->resp.mr;
>>> +
>>> +    if (sel == IB_EXT_SEL_MR_RANGE)
>>> +        length = qp->resp.length;
>>> +    else if (sel == IB_EXT_SEL_MR_WHOLE)
>>> +        length = mr->cur_map_set->length;
>>
>> I'm going to have to think about these
> 
> Yes, you inspire me that we should consider to adjust the start of iova to the MR's start as well.

I'll review again when you decide.
>>> +
>>> +    if (plt == IB_EXT_PLT_PERSIST) {
>>> +        nvdimm_flush_iova(mr, start, length);
>>> +        wmb(); // clwb follows by a sfence
>>> +    } else if (plt == IB_EXT_PLT_GLB_VIS)
>>> +        wmb(); // sfence is enough
>>
>> The persistence and global visibility bits are not mutually
>> exclusive,
> My bad, it ever appeared in my mind. o(╯□╰)o
> 
> 
> 
> 
>> and in fact persistence does not imply global
>> visibility in some platforms.
> If so, and per the SPEC, why not
>      if (plt & IB_EXT_PLT_PERSIST)
>         do_somethingA();
>      if (plt & IB_EXT_PLT_GLB_VIS)
>         do_somethingB();

At the simplest, yes. But there are many subtle other possibilities.

The global visibility is oriented toward supporting distributed
shared memory workloads, or publish/subscribe on high scale systems.
It's mainly about ensuring that all devices and CPUs see the data,
something ordinary RDMA Write does not guarantee. This often means
flushing write pipelines, possibly followed by invalidating caches.

The persistence, of course, is about ensuring the data is stored. This
is entirely different from making it visible.

In fact, you often want to optimize the two scenarios together, since
these operations are all about optimizing latency. The choice is going
to depend greatly on the behavior of the platform itself. For example,
certain caches provide persistence when batteries are present. So,
providing persistence and providing visibility are one and the same.
No need to do that twice.

On the other hand, some systems may provide persistence only after a
significant cost, such as writing into flash from a DRAM buffer, or
when an Optane DIMM becomes overloaded from continuous writes and
begins to throttle them. The flush may need some rather intricate
processing, to avoid deadlock.

Your code does not appear to envision these, so the simple way might
be best for now. But you should consider other situations.

>> Second, the "clwb" and "sfence" comments are completely
>> Intel-specific.
> good catch.
> 
> 
>> What processing will be done on other
>> processor platforms???
> 
> I didn't dig other ARCH yet but INTEL.
> In this function, i think i just need to call the higher level wrapper, like wmb() and
> arch_wb_cache_pmem are enough, right ?

Well, higher level wrappers may signal errors, for example if they're
not available or unreliable, and you will need to handle them. Also,
they may block. Is that ok in this context?

You need to get this right on all platforms which will run this code.
It is not acceptable to guess at whether the data is in the required
state before completing the RDMA_FLUSH. If this is not guaranteed,
the operation must raise the required error. To do anything else will
violate the protocol contract, and the remote application may fail.

Tom.
