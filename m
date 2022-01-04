Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE19B4845BE
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 17:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiADQCv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 11:02:51 -0500
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:58080
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234011AbiADQCt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 11:02:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gD/CAYJ9oT6UW2ipbJgCeNBSzgZyoJTw0DP8rnmuTlg7n4EfMHd1qkTv4FEuzaAtS2nnANC8+1G7i5pkKBioMfIU0oBsuIPyUzA7oCuKqKK46JdbxchlybRkTK3dgDPQLVWaKiyjaEsGDSoP03JM7yoWdcOGuvjXTtN+Lx6Ivrz930q824XebXjJzVEzi2Lp+5cyKU5bFukeMq63leyiCH9B2Q8w5wl4zfcPWS9Fr0mA+xeEuUEOPeowLN9AA4l8po46Zn4q6PlWb3goUXq00TxJtcYQ4kpf8deB590mEEw7+eDokvsQIWKZXIhhWPMwtlpAujRPOmOMcAxK+PTpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iuq9ENPkHb1BbTC/t5wmhgIf6tX7lSbCyqqYTIybyyA=;
 b=cEDfQj/T52VIf2z0Imiumclz/CNjoqOLHYs0Qm5x2oEelPurvCTVIXV1+IeQLoUsDwRZf0BWHBmwLGrPC3nwwXhRmb7okPUDvWuWN82iVreqTjdb91/N5tUf2TdGEsbC4FRepKlQuB2rvIihSkf1us+YHMooChE9Fan0UUUSu5jMKMpixPruo7jLjQbv/zmNuqJN0SERze2Idnzkn8VWycNJQR1OAlofe61nEedPbTJ8Az+BjDe/L3up4Tf1FzFSK6pyySa/K2b5qNO7bMCArgA0k6SXD/EFOfaTilo+focZhXUvE2I3dGPArzYZmolVYJg62PRqPXqqsl7mIwXPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10) by
 BL0PR01MB4899.prod.exchangelabs.com (2603:10b6:208:63::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.14; Tue, 4 Jan 2022 16:02:47 +0000
Received: from BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6]) by BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6%6]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 16:02:47 +0000
Message-ID: <a751109c-ffbc-c939-c4d8-ffff8d85b017@talpey.com>
Date:   Tue, 4 Jan 2022 11:02:45 -0500
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
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <9f97d902-aad5-db0f-f2dc-badf913777c4@talpey.com>
 <fd561077-358e-e38d-a7d0-5c61593eff6a@fujitsu.com>
 <17122432-1d05-7a88-5d06-840cd69e57e9@talpey.com>
 <33284887-163e-6d6f-a3b8-c9c9b597d160@fujitsu.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <33284887-163e-6d6f-a3b8-c9c9b597d160@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:208:160::37) To BL0PR0102MB3313.prod.exchangelabs.com
 (2603:10b6:207:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6fec361-77c9-4d2a-9958-08d9cf9ba67a
X-MS-TrafficTypeDiagnostic: BL0PR01MB4899:EE_
X-Microsoft-Antispam-PRVS: <BL0PR01MB489941ABABEE7F3464097F32D64A9@BL0PR01MB4899.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zp/l0af538LtyczAJhFBkg1dw37youLHcnMRbxx85NvTyC+ps1r3UZ6bkCX2nmcOZ1VP0gqqy7Dhq+Sh3N/Lduzf0CRiq+57mYi7PEVk1w47pw2GDeeTSFomDJ5TBkB8x+3UwHnySbDAKZwQ9kysQZjCOxD+NrTVionz/86IATS2z3WWRc5GrNFIlChOCjlIbBpu0yWibG7LzSlk6ipTqU/0gApKX8W2Wbi0jAvu8OdnuXP96ky1QxfTptCgVZzv0X/xHMMm6UGT6dG2l1JY7V3m+s23Lssu3BW0z+IKIJqGVvA7OK34lv9Hw6wd9DEoVp2sEJSKhsnZA5Y1qYz7s42wvhCRFPvJvrREihZ/6k+IP0cPaTcOJDgAJ9gCqtGCitm39vITnQY16fEkdI5CkVkeUd+K3wqyBwmyFjVYlIdC9WIj2lCRSJ/91HIhuToeCbrCYYt7yPY9c8p3SZMTiV1JjfeL203XouSd4H+A0McXJHx9CCmYxIaaPEzkcUL7m2NjSsmuZnzfBvYSetkrOXg8N10OXadrpKgQi3kulyhMLbhXhQJg0cCgnidwSYIdsprb9xHSNJwrTuFy9BStrYhVNVrQgrp0F8x6gU8iys3IGB4CSGmAQejvfFGDEW7fba3tDcMq+5N11Kuw9i6Eq2ezg74tDH0L3T2RiKYXe01vEg/iy2OeGhK926mLHmWvwmNApRJbWfspVBmZDsNh3I93FabUOrfvj8LsS1L9ihc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR0102MB3313.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(39830400003)(136003)(7416002)(316002)(6512007)(52116002)(508600001)(2906002)(6486002)(4326008)(186003)(26005)(36756003)(83380400001)(38350700002)(38100700002)(2616005)(8936002)(86362001)(8676002)(5660300002)(66556008)(66476007)(66946007)(110136005)(31686004)(54906003)(6506007)(31696002)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0Z3TDh1TGNjVWlTUEVrbEtWczZDc1lwZ0JRVCtwaE5RVlhaOEpuaUtBY1Qw?=
 =?utf-8?B?VXNwbjdZOVppdm1VRk01S09KZ3FVNnBHdXhwWlRBVHhGRDk2VTJIL1NOTUtq?=
 =?utf-8?B?aXdVVG96bDJndWJSVG9Kc09WRW9jcUticlZ6aHpxL253QVFzVUFBaHFvdndz?=
 =?utf-8?B?K3d6MjFjMkxvYTJObmpzOUZGb08zY3FNcWl6amlKRVlKMDRzdzBSZ0xXZDVN?=
 =?utf-8?B?bHNsTXV3MGZrclFkOGhyYTllNU8yN1hOUWE1c3ltZDRvaWxnM2hYejRIbEJZ?=
 =?utf-8?B?Kyt6aktKeENuY1lBUHg2SHlpQS9KbE13SWQxaklVZVR6cXhLUDhGYTlJTGlx?=
 =?utf-8?B?YVNvSzZDMGxucHBuQnIwNmVCQmhjTlBIbm9xUUtYKzZLb3VCVlhIODV6VHFQ?=
 =?utf-8?B?cDUzc1pSVHZ0VGVSVnlSdElXbWhKTkd6TGRmWnpwQ2xIcTRDejRLTXBNOUxR?=
 =?utf-8?B?d3BYL2tCbjlyTlR4VGRSQ3FBend3cCtjRVZhbHNHdUJDa1BaNWNOYkNiR2pO?=
 =?utf-8?B?cmJBcGpzdTVIUklpK1hxNDFSQWVCS2ZUc1RWSzNxclNoakVlcWlzdlhILzlX?=
 =?utf-8?B?ZTZxc2JVamRnemZ4cFJMUFNON3VzMEdGUWVkUFlFSXVrSnRQL1ordVM3dEVt?=
 =?utf-8?B?QTI0UTljZVVNSnl1ellZK3M5bXE0VU5Pd1JaUjVJWmR2YWcwSVpvbnFsSDlq?=
 =?utf-8?B?eG1HWmw2L0xtR2lBMzRHN1k1RzVCRTNueHBzaUIyOGUwc3RFL21UaDZLanlS?=
 =?utf-8?B?OE0zV0RDb2tRRUxLQ2xrOFhRT0tjTGJ5T1JVZ0I3RzdNWi94TU55WXNMTlFl?=
 =?utf-8?B?S0xrbkk1S2t1VWJiQnlUZi9Hc0VkQ0RhUUZ1Z2RYcHZ0SkVvUXNjV3BIK2or?=
 =?utf-8?B?NnRpSDN6NGlEV01LNDVpK0RkSkpaeitqUHhqb2xYOEhOSU9IOG91ZXZoSDFX?=
 =?utf-8?B?TU5ZMXEyeTdPeUFKS0pBK3NBL2VvV2cxbjRzKzAzYWhWU2plVVJDakE3NHpl?=
 =?utf-8?B?dG1KN2t3VSs4NlRHQ05ydTJDTElFMDJUYUVlZlBacXNDbTF6ZXlCN05rYUJO?=
 =?utf-8?B?SWRiaXJ6ZlQwdlhQV3FIc2pFdCt2dDdzdS94ak5JQkg0Ri9aL29aRDVPTCtK?=
 =?utf-8?B?MFdNSC9QckhtakQybG96dEVqSWdvRGhKcjUyU2MzeGVLUERxNEhMZFU5bE1O?=
 =?utf-8?B?cFo1cnIwQ3Vob2pHR2IrMjQxUUZGMDE0bjJtNTBiMlJWc3M1TUpJcmVXd3Bl?=
 =?utf-8?B?VjhFRDdRU2RDYjRhRGxYekdtVlJSQTdtMURGQk5kVEJJdXBpVWVlZ3l0cW9l?=
 =?utf-8?B?VEk2a0ppWEU3cWsvZThvWG82a0dEOFYyTFNwWWpVcVB1R2FOVll5emlvSzZR?=
 =?utf-8?B?ZTNSTmg1djN6RDRkRWFYMmw2ZDRyRFpqcTltaDlKWnhNRERRL2V3UVJlNWhI?=
 =?utf-8?B?RTdJMzROclpLS213a3lxcFk0YlZYUVNRN3RMbGRXQnQvam01L0FWNlUvUm1q?=
 =?utf-8?B?YWhWSGt2WWdjZXhrWEFtMTMvTG9abGUrTVk0YzJSdXhkZ0NpRHl6a1ZjZlh0?=
 =?utf-8?B?OVpaUEdDU1hVNkxuc0R1MEI0R3FDdnloYkNlWEhlMkdUSGVLU1VPNDNRblpJ?=
 =?utf-8?B?T3lrZXlPRjBFOUhKaVE5NlhmVGs0cTZwSzg0ekRFa3dhaFVybVR4K2EzRDZI?=
 =?utf-8?B?UHlBZGhZaUhmV1dFVnhyMkdrbzljbVV2R2IwYTdNS3JRWkdBMHE0ZExINTky?=
 =?utf-8?B?dHh6aUJjTGxFM2JZdHlQYUZNSThoc1A5RC9PaURpVzh0Snpsa1Y2TUl2WUpB?=
 =?utf-8?B?eThmN01iblVDanlIa1pVWUFuM2V3Y2hOTHhXVWROei9HaWk5VDJ4TTI1MjMy?=
 =?utf-8?B?OGtXSm1KWStUd05Jdm9vYUNMRWttVHU0bUtKaDJRTmVPN3haQ3UvbkRCbGR1?=
 =?utf-8?B?b2NUOUVrdVJDV2hUcHNna3BZSzJBVU02TDMwbFk3TXZSMHlEc096VGFnSi9k?=
 =?utf-8?B?Njg3cmc3VHNkUXRERDAvYXRzUkZKVE5UeEw1Q2JoV3RXQTNBWmNVR0RvOVNH?=
 =?utf-8?B?ZWFwZEJBU2x5c0NWS2gyM1owdWROaVlRSVBtUndhQmJRck5EZnc5aWxaYjQ5?=
 =?utf-8?Q?sxMs=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fec361-77c9-4d2a-9958-08d9cf9ba67a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR0102MB3313.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 16:02:47.2068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wh7RJXgHbOKPiv7pMMmOm23DNWzXFcpXRxigE9Zi1wQYBBtsX5Fj1iWyDOTbtzM6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4899
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/4/2022 3:51 AM, lizhijian@fujitsu.com wrote:
> 
> 
> On 31/12/2021 10:32, Tom Talpey wrote:
>>
>> On 12/30/2021 8:37 PM, lizhijian@fujitsu.com wrote
>>>>> +static int nvdimm_flush_iova(struct rxe_mr *mr, u64 iova, int length)
>>>>> +{
>>>>> +    int            err;
>>>>> +    int            bytes;
>>>>> +    u8            *va;
>>>>> +    struct rxe_map        **map;
>>>>> +    struct rxe_phys_buf    *buf;
>>>>> +    int            m;
>>>>> +    int            i;
>>>>> +    size_t            offset;
>>>>> +
>>>>> +    if (length == 0)
>>>>> +        return 0;
>>>>
>>>> The length is only relevant when the flush type is "Memory Region
>>>> Range".
>>>>
>>>> When the flush type is "Memory Region", the entire region must be
>>>> flushed successfully before completing the operation.
>>>
>>> Yes, currently, the length has been expanded to the MR's length in such case.
>>
>> I'll dig deeper, but this is not immediately clear in this context.
>> A zero-length operation is however valid, even though it's a no-op,
> 
> If it's no-op, what shall we do in this case.

It's a no-op only in the case that the flush has the MRR (range)
flag set. When the Region flag is set, the length is ignored. As
you point out, the length is determined in process_flush().

I think the confusion arises because the routine is being used
for both cases, and the zero-length case is only valid for one.
To me, it would make more sense to make this test before calling
it. Something like:

+static enum resp_states process_flush(struct rxe_qp *qp,
+				       struct rxe_pkt_info *pkt)
+{
+	u64 length = 0, start = qp->resp.va;
+	u32 sel = feth_sel(pkt);
+	u32 plt = feth_plt(pkt);
+	struct rxe_mr *mr = qp->resp.mr;
+
+	if (sel == IB_EXT_SEL_MR_RANGE)
+		length = qp->resp.length;
+	else if (sel == IB_EXT_SEL_MR_WHOLE)
	{
+		length = mr->cur_map_set->length;
		WARN_ON(length == 0);
	}

	if (length > 0) {
		// there may be optimizations possible here...
		if (plt & IB_EXT_PLT_PERSIST)
			(flush to persistence)
		if (plt & IB_EXT_PLT_GLB_VIS)
			(flush to global visibility)
	}

+	/* set RDMA READ response of zero */
+	qp->resp.resid = 0;
+
+	return RESPST_READ_REPLY;
+}

Tom.

> 
> 
>> the application may use it to ensure certain ordering constraints.
>> Will comment later if I have a specific concern.
> 
> kindly welcome :)
> 
> 
> 
> 
>>
>>>>> +
>>>>> +    if (mr->type == IB_MR_TYPE_DMA) {
>>>>> +        arch_wb_cache_pmem((void *)iova, length);
>>>>> +        return 0;
>>>>> +    }
>>>>
>>>> Are dmamr's supported for remote access? I thought that was
>>>> prevented on first principles now. I might suggest not allowing
>>>> them to be flushed in any event. There is no length restriction,
>>>> and it's a VERY costly operation. At a minimum, protect this
>>>> closely.
>>> Indeed, I didn't confidence about this, the main logic comes from rxe_mr_copy()
>>> Thanks for the suggestion.
>>
>> Well, be careful when following semantics from local behaviors. When you
>> are processing a command from the wire, extreme caution is needed.
>> ESPECIALLY WHEN IT'S A DMA_MR, WHICH PROVIDES ACCESS TO ALL PHYSICAL!!!
>>
>> Sorry for shouting. :)
> 
> Never mind :)
> 
> 
> 
> 
> 
>>
>>>>> +
>>>>> +static enum resp_states process_flush(struct rxe_qp *qp,
>>>>> +                       struct rxe_pkt_info *pkt)
>>>>> +{
>>>>> +    u64 length = 0, start = qp->resp.va;
>>>>> +    u32 sel = feth_sel(pkt);
>>>>> +    u32 plt = feth_plt(pkt);
>>>>> +    struct rxe_mr *mr = qp->resp.mr;
>>>>> +
>>>>> +    if (sel == IB_EXT_SEL_MR_RANGE)
>>>>> +        length = qp->resp.length;
>>>>> +    else if (sel == IB_EXT_SEL_MR_WHOLE)
>>>>> +        length = mr->cur_map_set->length;
>>>>
>>>> I'm going to have to think about these
>>>
>>> Yes, you inspire me that we should consider to adjust the start of iova to the MR's start as well.
>>
>> I'll review again when you decide.
>>>>> +
>>>>> +    if (plt == IB_EXT_PLT_PERSIST) {
>>>>> +        nvdimm_flush_iova(mr, start, length);
>>>>> +        wmb(); // clwb follows by a sfence
>>>>> +    } else if (plt == IB_EXT_PLT_GLB_VIS)
>>>>> +        wmb(); // sfence is enough
>>>>
>>>> The persistence and global visibility bits are not mutually
>>>> exclusive,
>>> My bad, it ever appeared in my mind. o(╯□╰)o
>>>
>>>
>>>
>>>
>>>> and in fact persistence does not imply global
>>>> visibility in some platforms.
>>> If so, and per the SPEC, why not
>>>       if (plt & IB_EXT_PLT_PERSIST)
>>>          do_somethingA();
>>>       if (plt & IB_EXT_PLT_GLB_VIS)
>>>          do_somethingB();
>>
>> At the simplest, yes. But there are many subtle other possibilities.
>>
>> The global visibility is oriented toward supporting distributed
>> shared memory workloads, or publish/subscribe on high scale systems.
>> It's mainly about ensuring that all devices and CPUs see the data,
>> something ordinary RDMA Write does not guarantee. This often means
>> flushing write pipelines, possibly followed by invalidating caches.
>>
>> The persistence, of course, is about ensuring the data is stored. This
>> is entirely different from making it visible.
>>
>> In fact, you often want to optimize the two scenarios together, since
>> these operations are all about optimizing latency. The choice is going
>> to depend greatly on the behavior of the platform itself. For example,
>> certain caches provide persistence when batteries are present. So,
>> providing persistence and providing visibility are one and the same.
>> No need to do that twice.
>>
>> On the other hand, some systems may provide persistence only after a
>> significant cost, such as writing into flash from a DRAM buffer, or
>> when an Optane DIMM becomes overloaded from continuous writes and
>> begins to throttle them. The flush may need some rather intricate
>> processing, to avoid deadlock.
>>
>> Your code does not appear to envision these, so the simple way might
>> be best for now. But you should consider other situations.
> 
> Thanks a lot for your detailed explanation.
> 
> 
> 
>>
>>>> Second, the "clwb" and "sfence" comments are completely
>>>> Intel-specific.
>>> good catch.
>>>
>>>
>>>> What processing will be done on other
>>>> processor platforms???
>>>
>>> I didn't dig other ARCH yet but INTEL.
>>> In this function, i think i just need to call the higher level wrapper, like wmb() and
>>> arch_wb_cache_pmem are enough, right ?
>>
>> Well, higher level wrappers may signal errors, for example if they're
>> not available or unreliable, and you will need to handle them. Also,
>> they may block. Is that ok in this context?
> 
> Good question.
> 
> My bad, i forgot to check to return value of nvdimm_flush_iova() previously.
> 
> But if you mean we should guarantee arch_wb_cache_pmem() and wmb(), i have not
> idea yet.
> 
> arch_wb_cache_pmem() and wmb(), What i'm currently using are just to hide
> the assembly instructions on different architectures. And they are void return.
> 
> I wonder if we can always assume they work always When the code reaches them.
> Since all current local flushing to pmem do something like that AFAIK(Feel free
> to correct me if i'm wrong)
> 
> Thanks
> Zhijian
> 
>>
>> You need to get this right on all platforms which will run this code.
>> It is not acceptable to guess at whether the data is in the required
>> state before completing the RDMA_FLUSH. If this is not guaranteed,
>> the operation must raise the required error. To do anything else will
>> violate the protocol contract, and the remote application may fail.
> 
> 
>>
>> Tom.
