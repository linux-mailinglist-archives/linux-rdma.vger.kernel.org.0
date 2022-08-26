Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28265A2841
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 15:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiHZNLh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 09:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHZNLg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 09:11:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F1DA2DAC
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 06:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fM5N9yjSYabQOLyL7gEmTt6hLhczR5fAWsLDCsTfTLfevhR+4Ug9wuD+h1Xv34kpDUKZesTkrXbo/veGph9sAsIr3lEMR1bHBM/IBkgU7vCaJUAr602yzH+4xpsof/STvJz9FvaWQv+cDo0+9aM0r6D9w4GCirjxgwSa56WmKLe6Lstk9aav5kz2K9/b72iKCUeN7UHWGCUxcMbgR2LvuBueU+P4YCUC6qQgKyi2AdjEA4pAjjqmYUzJkWjLBc/nRRNDmnB745qgnf4ujOy9RnuskeJ3DpXrwwRTHOiP4vxektJiHhmsn1mqMHVwc4Wac8/YwTXEvZB0z3p8myI+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKZ1HdYcK8b19cM4YXZFYR/T7XFqTeFwIox2PZimqB4=;
 b=buOjtizr2m1gsLgV1R4n+e+dG09HiS9JrETpi+AfTymjm3bGhhpCgH9Clkv0wtOvwhTePdQa+qprrtKcAmAyRjeg0frp1DHaWj3suTkw/xHmUPzodFy1cw2qQrkmhJeBrTM7KqCTuNOoq6ssdFS8X1FPMTkjzA05uYYfF/gDSPvD7ljhsX8KYqYD7myK5hysoW/WFGTSi/MM4fZy6R07Yzzwbfr8VkZXwPEM+AKCw9679B6krrpt7vlPq/B5wajsr7fHKXxtsFS3AVHiPLcCAZhossut0O7yBwnAiBSpJxBKgq6HEIehRmBZd0KEdfN2NWQUSnEPs/VoGk2KuFSwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 PH0PR01MB6229.prod.exchangelabs.com (2603:10b6:510:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.19; Fri, 26 Aug 2022 13:11:28 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::21e9:8dbb:6e40:5073]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::21e9:8dbb:6e40:5073%2]) with mapi id 15.20.5546.019; Fri, 26 Aug 2022
 13:11:28 +0000
Message-ID: <8ad2446d-157b-3894-c0a3-f8a57a6e1c34@talpey.com>
Date:   Fri, 26 Aug 2022 09:11:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH for-next 0/2] RDMA/erdma: Introduce custom implementation
 of drain_sq and drain_rq
Content-Language: en-US
To:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20220824094251.23190-1-chengyou@linux.alibaba.com>
 <2c7c248c-34a9-c614-6abf-e2f6640978b8@talpey.com>
 <9ba20242-7591-2ec9-4301-a6478a47fae4@linux.alibaba.com>
 <c7f4ce2d-e43d-50fa-afaf-1535aec2b0aa@talpey.com>
 <fc5dbf48-f3dd-7047-1933-c9e4b86ea891@linux.alibaba.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <fc5dbf48-f3dd-7047-1933-c9e4b86ea891@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:32b::24) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00ca8395-4b4e-436d-7502-08da87647c4d
X-MS-TrafficTypeDiagnostic: PH0PR01MB6229:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5dKj77TYvHpZllvx+KjgfwfZOXc77lh7CR2tbce5LhIIppZRt4letCj6gauaXxCqLmCZx1cQikh55xoImmASWdSB6J1VjpGHNgjLotcf6zemcsMyYOhSENgCUeREHjKCNhiJnej4FTZa7dOk5CBQmEEJ8sbEyrTjtN7usjLTkQIHZpcO0JkSARnTEny9jviZ6B7aLLqk83vWlqmZHeN97PZG5kZHguu9jtCKpgU7+AS/VNrW2bR0AeuU6nJvUsJfN+NLNxZ7mBIz70sKxgcM+zpg4VJk/cHI/kCx86XWdL46q8FGSPITCWauv1CraC1d/9ZBl7ye6XIhVW3+YNiuFe0jdfUw/1OfuxCDy7Lxk1GsP2Ht4VZBTfCgGedhe/EddO6WhWPIicgQWi10YnwFBWz1ioT9I5Hefhb4Jso+CRy9QO1VKxxUYgEfvn3weU/gBR6TpuO8x51E6qVbzADbAL+dtp0NiEtsgGuQz4q+H3xrgZl70dArwAdH2oQ81QTYaJporQ53A393UXIqx7GcOUU8j3T08c2jMRuGLjS8OYYsnDyjG9v4ww/XSOevZO1b6Q/vQqwwU4ycCEvSbiTGu5z7XybLLUaJJeSF6axDBvYSpKbL+6uEmcQqfYCC0hWQ3NzrlYpdiSUb7H4O9jGrivnW5AmF5269293prNRg6+cQ6Fb+GJIHpjR8uM0hd8shYjPQZm+SH30ts5HAFrUdbGVqBV32KTSanMk3A9LonnYSY1KPknuSA+kbUY/430hQ1PjqnQNbTbgLkrg49zx/nSN2DR9KDVIRgqmC5HNkwQKXR9RDAABiAlefavF41Yj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39830400003)(366004)(346002)(136003)(396003)(66476007)(83380400001)(186003)(66946007)(2616005)(86362001)(38100700002)(38350700002)(31696002)(4326008)(66556008)(316002)(8676002)(31686004)(6512007)(36756003)(8936002)(2906002)(53546011)(41300700001)(6666004)(966005)(26005)(6506007)(6486002)(478600001)(52116002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEp6Q1Q2MjN6NFBzRGV5c25rSEcvaVJjb05aa29aVmUwTENpSlAwekpkS0dy?=
 =?utf-8?B?RWMzbFoyTHcwcC9oM2o5MGwrRFAxMXRFemI1L3N2UXc3QmtNdVB1b1Y3azdF?=
 =?utf-8?B?cmV4RnhMYTFQZDJnWDdsamd0VGg3K2diY2NmL2pOK2ljRXpRaDZLeFB1N1NR?=
 =?utf-8?B?YlgyeUtFT3NkL0tJNVVkMWU1WVhQSy9qbTFwRk9ZaWx3ZGNXSG1tR1A1Q1V6?=
 =?utf-8?B?SisrK1N1aGhYVUk3YnZ6VVFkUTdaVDl6ZlVVU2RSTFl5MG9DdURwVXdLU2hC?=
 =?utf-8?B?d3RnWEVnc1BMdmVTQXd2TitDVWlhNnlRV2V4R2VsUTIyaUErTHZNdjVLYjd4?=
 =?utf-8?B?enpCWnNyTVVOK1pMeFFNVGFmOWdsNTdtTzVUK0pZOThVSkpwQlJ6SGtsTEF4?=
 =?utf-8?B?eGJnUkhkUnJ3eDR1VmhOMmxsSWlZSXZ4MVFUdnU2NlFBU0FoaWNXMjNjVVhU?=
 =?utf-8?B?RFdPM1c5ODFhUnBWSlF5ck13Q2RTbWNrYS9TMTdjaEVYYUkzTGY2Ukg4VUd5?=
 =?utf-8?B?dzhuNWtMSzE0R0dJZnlybFZzd0RJK0JVQUUwWHpib282Vlorc1F3dXc3dTQz?=
 =?utf-8?B?V0FhOG9VdGhqMVdBL0pQUHdYaVdSR25qZ0xTY1ZWWm9kRUZ4N0ZiY0Q1QkM0?=
 =?utf-8?B?M0NsdDY2MWhEY1JkcVk0LzZkS045TG9PWEg1SktzRTVHUEk1N0VoWkQ5bWgr?=
 =?utf-8?B?ZCt5bkxyREtzVE1rL2pldkJHa3p4UE1XS1JsVk5Gc0RFU2l6dnlxTldvSkVU?=
 =?utf-8?B?cldqbUtzRXFGdDdtZ0xpMnJQWG8vVCtDbWtDblRYWlg3QnhpNUdkSE10bm5x?=
 =?utf-8?B?RlRJYVk5eHQ1WEY0MndONzdTc0ZvNjM5OW5zcFROY25ickpaOWkwQmx0Um13?=
 =?utf-8?B?TVB1bW8rSDlGc0FiVFhyV0YwN1FYOVJmeU04NkZkQWZ1QkUzQ2VBaUhRWS9D?=
 =?utf-8?B?dE50Vm9sdHdReDZ4eURneDR5OGRzejBNKzhVblNUelQ1OTREUUVyRFdOVGhQ?=
 =?utf-8?B?U0UraFBUR0pjc3FCVzVnVWU1OXRHTXV1c0loekppVElkTHFxK0t2ekVHaVZm?=
 =?utf-8?B?Sy9HMGtvaGpkNDQyMFpPbnlSNmF1eGJ3bEk3dHBsTHFzSU8wQVpyeUZvditr?=
 =?utf-8?B?UFVyQXB6eXB0TzM3OGk1OEwzSWlWOFdJWHl0Z3VZUUs2cUEzZFRqVk1Lelhn?=
 =?utf-8?B?S1BHL21jTDJPL1ZVSHNoTnlCSzRCeTJFbkNUNVhzL0llVldzenZTR0xBZUVH?=
 =?utf-8?B?YnIwYUNDWEJndS9kcnpVN1dSa3dIVnJURk53Qlh3ZVg1aWhOUk0vYzk1UE1E?=
 =?utf-8?B?VzJpa0puN1U4ZXdlNUdPRHUxVllyRFhWYVBkZndLZitlZmg3LzJVd05ENGtm?=
 =?utf-8?B?T3dHc3RkcXRmNHFnbnI2OEtkeTBRVC9SN2M2K2xyWEZzTnRKVzhzZFlucFF0?=
 =?utf-8?B?TktIZVlpcEk1eUd3T3crWTBLQ0JWYm9YVjRQdUdUM3phYkJLSjdlT1NsQ1VP?=
 =?utf-8?B?RXN2SmdRcUJSeDQyMFJ5WlpTak04d3hlSndNYVVRbHl2VkhyMjU3OURuK3Zi?=
 =?utf-8?B?QW9VMlltb0MwMkRob1ZoekQ0OEIzK3BXV1E4R2NHMEwxcVVIckFHbXVTejhm?=
 =?utf-8?B?VzFabU1ESHVuU05zck5lZDNGc1l6eEtwRmhVWEZaMGJVTVZFUTNYVWU2Sm5m?=
 =?utf-8?B?VnBseE5HeDJPMm1QMjZjSmRYK1VLYUZXMVZ0b1NmczJrNHZ5dDMzT3c1a2ZG?=
 =?utf-8?B?d0Vkdkt3T2RVeTNxc1FYVi9taExpbURVaWVRK0loMkxCYkovVUlJWXV4NFZr?=
 =?utf-8?B?MWJMTk11NTRTWWhTQmlhTzhubHErK2d1MVBEVGxpL2NmZnUyTmVxODdiVWti?=
 =?utf-8?B?ZFNDOGRzMzFCckRRQmxEYjZYb2NXcGtnUHRDSUR3QnhFTU1lTk5NTmJKL0NW?=
 =?utf-8?B?RjhXTGFIenNJa0dvRjhWREFxWmFFNVNjU2pkN1JESkVXakgwTDBDYXhGZlAw?=
 =?utf-8?B?UG1VREZMa0dKKzlKVDExcFhPUzkvL0hJb09nYUVYR0NxWGVzd084ckpENUxp?=
 =?utf-8?B?Vk0zUVZZdXVtelNwbzAxa2V5bVJQV2JsbFplRDgyWGxVa21RdkFIUG1senpq?=
 =?utf-8?Q?Bv3I=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ca8395-4b4e-436d-7502-08da87647c4d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 13:11:28.0620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6OLYZMXKBBEMQ33mNtYXpzc30A2any3OIqOPH4KavigNQTFo82eCDz6XGinCakz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6229
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/25/2022 11:21 PM, Cheng Xu wrote:
> On 8/26/22 12:37 AM, Tom Talpey wrote:
>> On 8/24/2022 9:54 PM, Cheng Xu wrote:
>>>
>>>
>>> On 8/24/22 10:08 PM, Tom Talpey wrote:
>>>> On 8/24/2022 5:42 AM, Cheng Xu wrote:
>>>>> Hi,
>>>>>
>>>>> This series introduces erdma's implementation of drain_sq and drain_rq.
>>>>> Our hardware will stop processing any new WRs if QP state is error.
>>>>
>>>> Doesn't this violate the IB specification? Failing newly posted WRs
>>>> before older WRs have flushed to the CQ means that ordering is not
>>>> preserved.
>>>
>>> I agree with Bernard's point.
>>>
>>> I'm not very familiar with with IB specification. But for RNIC/iWarp [1],
>>> post WR in Error state has two optional actions: "Post WQE, and then Flush it"
>>> or "Return an Immediate Error" (Showed in Figure 10). So, I think failing
>>> newly posted WRs is reasonable.
>>
>> <...> But the QP can only enter ERROR once the
>> SQ and RQ are fully drained to the CQ(s). Until that happens, the
>> WRs need to flush through.
>>
> 
> Emm, let's put erdma aside first, it seems that specification does not require
> this. According to "6.2.4 Error State" in the document [1]:
> 
>   The following is done on entry into the Error state:
>   * The RI MUST flush any incomplete WRs on the SQ or RQ.
>     .....
>   * At some point in the execution of the flushing operation, the RI
>     MUST begin to return an Immediate Error for any attempt to post
>     a WR to a Work Queue;
>     ....
> 
> As the second point says, The flushing operation and the behavior of returning
> Immediate Error are asynchronous. what you mentioned is not guaranteed. Failing
> the post_send/post_recv may happens at any time during modify_qp to error.
> 
> [1] http://www.rdmaconsortium.org/home/draft-hilland-iwarp-verbs-v1.0-RDMAC.pdf

Well, that language is very imprecise, "at some point" is not exactly
definitive. I'll explain one scenario that makes it problematic.

>> Your code seems to start failing WR's when the TX_STOPPED or RX_STOPPED
>> bits are set. But that bit is being set when the drain *begins*, not
>> when it flushes through. That seems wrong, to me.
>>
> 
> Back to erdma's scenario, As I explains above, I think failing immediately when
> flushing begins does not violate the specification.

Consider a consumer which posts with a mix of IB_SEND_SIGNALED and
also unsignaled WRs, for example, fast-memory registration followed
by a send, a very typical storage consumer operation.

- post_wr(memreg, !signaled) => post success
-      => operation success, no completion generated
- ...  <= provider detects error here
- post_wr(send, signaled) => post fail (new in your patch)
- ...  <= provider notifies async error, etc.

The consumer now knows there's an error, and needs to tear down.
It must remove the DMA mapping before proceeding, but the hardware
may still be using it. How does it determine the status of that
first post_wr, so it may proceed?

The IB spec explicitly states that the post verb can only return
the immediate error after the QP has exited the ERROR state, which
includes all pending WRs having been flushed and made visible on
the CQ. Here is an excerpt from the Post Send Request section
11.4.1.1 specifying its output modifiers:

-> Invalid QP state.
-> Note: This error is returned only when the QP is in the Reset,
-> Init, or RTR states. It is not returned when the QP is in the Error
-> or Send Queue Error states due to race conditions that could
-> result in indeterminate behavior. Work Requests posted to the
-> Send Queue while the QP is in the Error or Send Queue Error
-> states are completed with a flush error.

So, the consumer will post a new, signaled, work request, and wait
for it to "flush through" by polling the CQ. Because WR's always
complete in-order, this final completion must appear after *all*
prior WR's, and this gives the consumer the green light to proceed.

With your change, ERDMA will pre-emptively fail such a newly posted
request, and generate no new completion. The consumer is left in limbo
on the status of its prior requests. Providers must not override this.

Tom.

>>>> Many upper layers depend on this.
>>>
>>> For kernel verbs, erdma currently supports NoF. we tested the NoF cases,
>>> and found that it's never happened that newly WRs were posted after QP
>>> changed to error, and the drain_qp should be the terminal of IO process.
>>>
>>> Also, in userspace, I find that many providers prevents new WRs if QP state is
>>> not right.
>>
>> Sure, but your new STOPPED bits don't propagate up to userspace, right?
> 
> Yes. they are only used for kernel QPs. The bits are used for setting an accurate
> time point to prevent newly WRs when modify qp to error.
> 
>> The post calls will fail unexpectedly, because the QP is not yet in
>> ERROR state.
> 
> Do you mean this happens in userspace or kernel? The new bits do not influence
> userspace, and erdma will have the same behavior with other providers in userspace.
> 
> For kernel, this is only used in drain_qp scenario. posting WRs and drain qp
> concurrently will lead uncertain results. This is also mentioned in the comment
> of ib_drain_qp:
> 
>   * ensure that there are no other contexts that are posting WRs concurrently.
>   * Otherwise the drain is not guaranteed.
> 
>> I'm also concerned how consumers who are posting their own "drain" WQEs
>> will behave. This is a common approach that many already take. But now
>> they will see different behavior when posting them...
>>
> 
> For userspace, erdma is not special.
> For kernel, I think the standard way to drain WR is using ib_drain_qp, not custom
> implementation. I'm not sure that there is some ULPs in kernel has their own drain
> flow.
> 
> Thanks,
> Cheng Xu
> 
>> Tom.
>>
>>
>>>
>>> So, it seems ok in practice.
>>>
>>> Thanks,
>>> Cheng Xu
>>>
>>>
>>> [1] http://www.rdmaconsortium.org/home/draft-hilland-iwarp-verbs-v1.0-RDMAC.pdf
>>>
>>>
> 
