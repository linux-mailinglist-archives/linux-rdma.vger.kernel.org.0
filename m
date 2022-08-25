Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB2C5A16BF
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiHYQhg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiHYQhf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 12:37:35 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40796B943B
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 09:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ2NFWJKeBGT7AM2U3aDidxQ4/m8KNHudRlNdKQKwC8U5yvkin0zxKDhrMVKn6PXvlqlhGNYQ8RzF0SJnchrIbYsPGAmP7OLbwk/FHEdJ8kCsrWy1MWJG2Gj7iuo4XrHMkfbSjqsCIooZsbLqFaPid+pluARFgX7YUz2LM8jBSoqZ1vgUB19NendLI+1VXN2KdcPoaht+RX9cq5v/U55d+2AcmCTHXUZae1nlOU8mlPwXIOjyWVBI+mGytFIhpmvIKbYTMuI6t1PC2ZSnlfK4Rfb3VAP2cXIz6WsrincSISiB7dsVdZoRopCS/mLBZPonaoUKGpUomoYe3ko7x5KOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05WMdVXntrd9VzDMd/3l0WlSmJytDCrNNWZZT4uKzRQ=;
 b=fRhiy7z2b3QK6O2kUu2wAajIRyBFJMeNW2qSG1itGhbPJfPhiy8aG8YUTHXzlil0VuwDRaA8hkGrQfRxAVJDLPQ8WHmJK9YY05kzbpt2jTG13g5ijdPnDT29LjsAVm5ZvbxIrX/sEfMPsiY8L8w1LV40qI4Em9ZpPN3SoPmY3U+NJeAtRFV8Vpo+sLKTFSq35mIBmHZXfcHZ1O+2+P+e7Fg6verIA9tOhYrwfr6LQ3BrjCjQEUR0LCMDt79g16QBVuMVY/s7TEqNpalzU//3MYcYWzj2zngJq2hNYuDG29q9GfE1rLju9LMcG2JfI/Aug/KTWtyUvpVK27yVCTo6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SN2PR01MB2048.prod.exchangelabs.com (2603:10b6:800:1::25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Thu, 25 Aug 2022 16:37:32 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::21e9:8dbb:6e40:5073]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::21e9:8dbb:6e40:5073%2]) with mapi id 15.20.5546.019; Thu, 25 Aug 2022
 16:37:32 +0000
Message-ID: <c7f4ce2d-e43d-50fa-afaf-1535aec2b0aa@talpey.com>
Date:   Thu, 25 Aug 2022 12:37:30 -0400
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
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <9ba20242-7591-2ec9-4301-a6478a47fae4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::20) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1b8d760-ceef-4dc0-30d7-08da86b81b9d
X-MS-TrafficTypeDiagnostic: SN2PR01MB2048:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCaxKTwINW95NaiRnDEqeg2UYFqwVy2xRHy1CP64YPh8SClZ7pfyxdnyZ3AG91rnHLOasQe4gXuct5wlSdnoRoF4i5EbJ82yerjfY/3Yxz80a/p7QxoIRZB9AldAzTsubmYpAvqDM6IEP8PvYE8zQeTKKY5ejKgSdPmA09zWOI6D0GNJOGsbdro6L4KH1WTj65qp5HUFc/6Qn7DH9L8JoMRueXi8+t5EcfIlt1WajXMlkC4acB6QIt20irn6p4X2W0RUZUvW/IE0+a9NaHQW2A8S6xN0HdCK4HM9HUrQZzRpYtzOMk+NrsWFv0IfoqFHofqrHAmGgrWJd2zpilA2Ohj0ooNIJdJqDdPeViWaw7/yMSfrKW22yuV/Q5IHv3AK9drWO6gVbtxWLC0JPag9HlMkvS54dXzj+E29sCZfq0pI1lP/hqoYrQuRCoIx7xKzkLNus2r9C5ZeoWfaWuIVz8/t81iRcON3uxzVvIw42GotGOjBB5/tZnseq7u58JBw0QfKePxgqmV9YofJnJM5HKtNmdynuo4ol9da1OunkFqaxGSZIH9kLPAZBooyB6w8xqMHEnoV2ov/MMvmgCY5q3cJ8pHUh2fj/sFeaG7jcK656NM9/6fBnRlzL/je8QiZV0Fp+U/agw+d9fIaoRHpx5QZGwz9kpG70XTCbzclhqBbir3/IpVodeZvPHwEKf1OiVsRJq4oGgo5b15e1aUrzvlH2qi1EdEAKQjZgo60QweMWq6uDjst9LWuXn5R/QWmG82015Sjg1ZMhJinZB9Ge78Je0av1Q0X3QWNPZYF9psUiukkTe5uTaNubuBOXUTNh60usbn5FYjkznXMzJmePw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39830400003)(366004)(136003)(396003)(376002)(41300700001)(38100700002)(86362001)(38350700002)(31696002)(8936002)(966005)(2906002)(8676002)(66476007)(66946007)(66556008)(5660300002)(316002)(2616005)(6486002)(186003)(31686004)(83380400001)(478600001)(6506007)(53546011)(52116002)(26005)(6512007)(36756003)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUx4S1FBRWYvakdtRGtqblMwV2Zwb1lrMExUNHd6d1ZmeHNjQ2lqaHFrbUxr?=
 =?utf-8?B?SVEzQ1llakdKTkJPNkdWamJMMHFoMDdiTzJSZTZuLzFHOVFza0tIWk5YSDRm?=
 =?utf-8?B?b1hBY01EQTRmQ0wzZzgzb3poUDhnOUNUd3ozOGFrV29rWlpYbkJ2bUp6NVNa?=
 =?utf-8?B?RHg1Snh3bFJXd3JhcGc4T2VaTVlHYUdZSjlyc0tBQ0VMMXcrYWtVNU5VN0ht?=
 =?utf-8?B?WmxRMUNtdWdFM1lYMm9GcW90OEQ1SVUxdllVQitmeTl3cVJZZVd4SWtseDJ6?=
 =?utf-8?B?ZHdya3lmR0FzU1RmWkEzdmpTZ1N2bXEwcjZsQTI0L1ZRanU5bmJZVTY5bkNY?=
 =?utf-8?B?aUdJOWU2Ujd5dDRaVlRQOHo3V3hRMEJ6eHp3djhUNHowR2hySlVVQjc0LzRh?=
 =?utf-8?B?R2pjSzZSYnhON2ZKNFNoWjZaZXJqSkpERmNwV004bklaMjdhRXZSUDBQdzJB?=
 =?utf-8?B?SXVaMFVjVm8rVmN3eTNCNG0zbGNHck54MVdwa0NTSGZOQ2xRajhVeDgyQkJN?=
 =?utf-8?B?eDc5L2dHVGN5Y0dxNjhmczVWUE5EVlBwRmxCeVk3ZmovUGdrL2hpLzZyeTFt?=
 =?utf-8?B?V1VVWVVMSndjL1lqTkJSMEE3TGs2bHBBZzBoNzIvdHRaajhlYVpKL3JtY21k?=
 =?utf-8?B?dWNTbzFyR3RvZW5Ybk9xbG83ZEFsNGZuRTg0bXVjMCtiTWZ5T1J6L3RTQ1M5?=
 =?utf-8?B?Zmpnd0szN29zZ2F5L21vcDBLYmNrNkZVRGNZTW84b1RYUXVHUkYyMm1kbXJY?=
 =?utf-8?B?S2tYSjNnNlA0RTh0V1FhSURmQUlibnZCM0w1RFdweDNzcDhad2VLaGFqS3JH?=
 =?utf-8?B?VWlLckRGa2JyMERtN24wNS9lbWtmdHhTNjNxR09OM1ZiVW1sNUM2elp5Z25t?=
 =?utf-8?B?RlRZR28wOVhJd1ZaekFMdVRpTWs4MUd0bDIxNUJtVTF6SXZNaUpzMnpMV3VI?=
 =?utf-8?B?STFlcWdGN1hpSXBmcVJHVTk3QmxKdVMrN0xBdVV1K05nd2MzVlV5eFQvUlFm?=
 =?utf-8?B?RUx4NERFNXRzMWdjeSt2RWF1U1pzY1RXNzBPT201UCtuM29qZXVrL3dUR1Fl?=
 =?utf-8?B?S1FGT21uWFlsZFVxSnZOR29qTDJFbGZxb29obG9idWFPdHE2bnkvbWFSVXFj?=
 =?utf-8?B?UlZNanZlMUwwWk50bjdJV0VrMEtJb1JLeXVGOGdsV3FGQmxINXJxN2hhaHhX?=
 =?utf-8?B?MWk3c2c0Y05pblBQSkZYYlNIOXVCK2x1N3dZZm1jeC93LzdNTjR6VDAvZEhi?=
 =?utf-8?B?NE5JSDNONWZPUlhVbnIxbWxlOEw4enF1NWhBTVdCREJER0NRclNwaTkwdFJS?=
 =?utf-8?B?djNvQ0NkT29zdzIrbnN3RVdrYzRteXVBUFhPbVhvU3dsalB0c3RxYmF3b3lE?=
 =?utf-8?B?Z3RnWmY3Yldla0M5MTYvVzRJYmlYZG85SUk2aUFJbVlHT3pMODArUHlqb2NQ?=
 =?utf-8?B?MzVmR2hJbHFCUGMrWjBiNUk1YnNXYUplZkJOUUw3aWQ0YjZJREFxRU9TVEx5?=
 =?utf-8?B?S2hLeWljT21LT0QxS1haUEs5eWdQSEg3VGN5NWhMRDg2dHlnWG9mYTBZOGxV?=
 =?utf-8?B?Z2Q0UklhZ2lpc2xRbEpGVXhZRUNKUXo0cDVVRzV2OGhCVFZSKzlZd0xiY0RE?=
 =?utf-8?B?S0M1WWdxcWdQM1pYT1phT3hpZXdLeGZPUXlsZXVpVlVHdnJJKzNZTmZiUmYx?=
 =?utf-8?B?Sm52ZHpqTlg0cFBldkZtSkYwRENZeThYRVRBcjVtK1l6UytmMk1SVEJEOC96?=
 =?utf-8?B?OXRXdC9NK1VaS01VVFE3cWI2Zk8rREVJcWxPempvYXNwZGFRUjkzdEF6bEtC?=
 =?utf-8?B?NzNLVndXSTVoRmVwSkd3QUpLVndGeHJZRklJaXpNdi8zc3BrSHpmaWJ6TnNs?=
 =?utf-8?B?ODdYcW96V2FwdTJkNWRoaXphaGY4MUtHVDU3RWxhR3cyT24xS2Y4Qk0yYnlN?=
 =?utf-8?B?Vy95cHRuTDdxaGNFQVRnQTVGZkJGdFdLQlU4eUZMWE5aaE1CWUQ4VlpWN3g2?=
 =?utf-8?B?a3lOR3BPQUF3R0ltRTRZd1dXMFNMUkNDR1BYcU5JSGEyalJET2FCZmVhYnAv?=
 =?utf-8?B?YWJSYWNqbEtvNDVYaE5wMU1qQ2tIVDJNMG1UaDh0M0Npam1uWi9hZ3hpUkkv?=
 =?utf-8?Q?XK8I=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b8d760-ceef-4dc0-30d7-08da86b81b9d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 16:37:32.3299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9j30HQpJXw7qfBaBGJCMF7fPv9VSoyOvJBlGk5A9Rb2NXYZCQkuaWZeWs7JD6bI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR01MB2048
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/24/2022 9:54 PM, Cheng Xu wrote:
> 
> 
> On 8/24/22 10:08 PM, Tom Talpey wrote:
>> On 8/24/2022 5:42 AM, Cheng Xu wrote:
>>> Hi,
>>>
>>> This series introduces erdma's implementation of drain_sq and drain_rq.
>>> Our hardware will stop processing any new WRs if QP state is error.
>>
>> Doesn't this violate the IB specification? Failing newly posted WRs
>> before older WRs have flushed to the CQ means that ordering is not
>> preserved.
> 
> I agree with Bernard's point.
> 
> I'm not very familiar with with IB specification. But for RNIC/iWarp [1],
> post WR in Error state has two optional actions: "Post WQE, and then Flush it"
> or "Return an Immediate Error" (Showed in Figure 10). So, I think failing
> newly posted WRs is reasonable.

Both IB and iWARP allow new post-WR calls to fail synchronously if
the QP is in the ERROR state. But the QP can only enter ERROR once the
SQ and RQ are fully drained to the CQ(s). Until that happens, the
WRs need to flush through.

Your code seems to start failing WR's when the TX_STOPPED or RX_STOPPED
bits are set. But that bit is being set when the drain *begins*, not
when it flushes through. That seems wrong, to me.

>> Many upper layers depend on this.
> 
> For kernel verbs, erdma currently supports NoF. we tested the NoF cases,
> and found that it's never happened that newly WRs were posted after QP
> changed to error, and the drain_qp should be the terminal of IO process.
> 
> Also, in userspace, I find that many providers prevents new WRs if QP state is
> not right.

Sure, but your new STOPPED bits don't propagate up to userspace, right?
The post calls will fail unexpectedly, because the QP is not yet in
ERROR state.

I'm also concerned how consumers who are posting their own "drain" WQEs
will behave. This is a common approach that many already take. But now
they will see different behavior when posting them...

Tom.


> 
> So, it seems ok in practice.
> 
> Thanks,
> Cheng Xu
> 
> 
> [1] http://www.rdmaconsortium.org/home/draft-hilland-iwarp-verbs-v1.0-RDMAC.pdf
> 
> 
