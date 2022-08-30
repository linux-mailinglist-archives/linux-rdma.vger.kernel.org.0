Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A995A6C88
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 20:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiH3SpW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 14:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiH3SpU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 14:45:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5D96438
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 11:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNVwhHYUefzwJEoAu/APsstTxDzJzHHo/g4rTIG+4yDukx2qtYs0vYLHVzxv2/+uYlCwjI2B0yeytOeBawReiD144HovkBf9CNGmOA0qGWWVo1ngXQ1gnxfNyk2zpkdPgP6cWU4zyikKlPkPIrgFHdd6rO7qod9cp8VbuPsjrN9bn7IX7QUG3eL64c/zjmTAtJVjTTBQknVYVT5OHpTSwXb6ePna/gtuvx7KPrLam4a13xkKcIuLACHb5Y/L57XY4FQiwoEIqZUvNteAt1dBKeQmiq12lNDxtflqtY354Ilv5KbAc8psV2XrE7FfmV5b3vRaWMjrtGC69tzao8rntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx7crqB5u3L/+RA2022iRCnhUOI47VKza23znrt2VgA=;
 b=NDvxpOMCuUXU6SRH83hbeyQS+qCjZgsWkFW5+ANEUwxWTQqGbuCv9HEM3JfEaaaHLkobf2blYrJVYjtBYDN6n9IussjbHwiwxiWf0xM7xcfc448rWKyVqfYtNEWpnmyvR0VEgLh8gtGruMk9Ulxx/lWoTetrxon8ZCtxU8Mnz0S6wdM8naSsc9Yd12Gc7m2GSHSMMUiFCLiddv5spRURquON1a3VSUnv6/eeb37E3Rarqjur0B/U251tTbiJikTCsZ1PPK3DzafAdRLfETyptDtq2VtAJxhqXG+LT1/aquThtK2gGBI7bBIGgEnTLylMESs8Mzy+6LW4kVT/aP0b/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 CO1PR01MB6678.prod.exchangelabs.com (2603:10b6:303:d9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Tue, 30 Aug 2022 18:45:15 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 18:45:15 +0000
Message-ID: <70351625-4933-d63f-aed6-f9c5a46cb9b5@talpey.com>
Date:   Tue, 30 Aug 2022 14:45:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH for-next 0/2] RDMA/erdma: Introduce custom implementation
 of drain_sq and drain_rq
Content-Language: en-US
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com
References: <20220824094251.23190-1-chengyou@linux.alibaba.com>
 <2c7c248c-34a9-c614-6abf-e2f6640978b8@talpey.com>
 <9ba20242-7591-2ec9-4301-a6478a47fae4@linux.alibaba.com>
 <c7f4ce2d-e43d-50fa-afaf-1535aec2b0aa@talpey.com>
 <fc5dbf48-f3dd-7047-1933-c9e4b86ea891@linux.alibaba.com>
 <8ad2446d-157b-3894-c0a3-f8a57a6e1c34@talpey.com> <YwjRV3kubU9wnwax@ziepe.ca>
 <29dc35b9-8f25-6a3a-4df3-087c27870278@linux.alibaba.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <29dc35b9-8f25-6a3a-4df3-087c27870278@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:208:23d::28) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5f9bdc1-ec54-4acb-cc43-08da8ab7c755
X-MS-TrafficTypeDiagnostic: CO1PR01MB6678:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXW2DEY9wqXFURSwrJzbRwNbKZiOmcBZSYbtbxlPWKvy2fQ3NiNwtf5UveoYFozYvwLp61Nbd6KZQJycPXLKTc4vvTvspOOgk3X5dIIMEBenImyGef4HSY9WKK6US1RH23drFpa7RM4/TvNdfrLXy6I9ykXdeCISm40cuUefObme+9UTBQPTAZqbbkrqO7lyEwUAS1BKEHpkIxhwqHSW8aBGAnnoRvzg8TdZyr3dGVtrxxAmWrU5e6mo2RauSRwXNtCpv6Q8mVw8p7fOUabNe+NLtg2uEgn6HYakLxveB7TLL7DIR1adzee4/YLyvjk031BrcPCCRpkvxtTKXxL9VLa+q4fWCzqKKp0iTFNx5CneHAMXO2HXaxubY5zj8YhdSaX+4qoZnYQysfbvRpRBpgOEpiJSCKdodDDTQ5pnV4Nem2PUEfWXPKbENzrGky2yUSvIzAK5hqG1KaTPSpJQ4aHvrOZAB+lj5TRgNYUQY74oPJomfDoIiXgXSE+MnpfR+oO4cSaHKNcgDkUHuOa7K2seLLqRRSDAdd7kNzZVO+/uCMJiZ8yg5UbcnDme54AGzXVP2Uevi3ABAI956nnEtNe2hncszg8u+rdWx30cGsfbsUvw1deUI7u9jY3I56uZr+hm5NBS7prsAXmbQOHobQYA3UaxVQVtGhhpThD1yOznjdxpuxfW2GIkygKgm8VN2ueF+0vl0VyLGJMVlwGcWriQwAsnfHbV/cbJxKECzxS6zX78BR7SNL66iBayW6fvmGZOYFvbQb1ViDRHa8/PgoHLUjDf0S4IQUEqTMcYXUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39830400003)(376002)(396003)(136003)(366004)(26005)(38100700002)(38350700002)(52116002)(6512007)(53546011)(6506007)(2616005)(31696002)(186003)(8936002)(86362001)(5660300002)(478600001)(41300700001)(110136005)(31686004)(83380400001)(36756003)(66476007)(8676002)(4326008)(2906002)(6486002)(66946007)(66556008)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWQrOXVjTms0cUdIMmpWQWphZnd0UDd0Y0tTbEFxQ05mNEhnb1J2NjhEMEVk?=
 =?utf-8?B?N0tDcVo1WnhsVmxFb0gzREhMNGRrNjIzWlVsWUVrdFVPY0xUT3l2N1oxVW1R?=
 =?utf-8?B?V1ZlcVJ3cGNyQXBMSGJ0WWkrTnVFMXd3akp6NUx6RThIcU5JY1lrVis4WER6?=
 =?utf-8?B?SVN4eEp4dW9aWXBtMjFNdzUzNU1oVThBcUsxK21HZ1FKd0x0aUxiVXdvKzNS?=
 =?utf-8?B?QWJDaUxKZ0UrTnY3VWs0OWhvK3ZiZzFNU09Kdks0L2VGMnRCdDFUNFd1YkRP?=
 =?utf-8?B?YnlOWUwxYjN1NlFoUUN3T01SSkN1UmVpUXFyVWptR3NIWU90NnUzRnhNTjRm?=
 =?utf-8?B?Vm9rYUR3ZXJEdnVaSU85VHNieG55M041ckFudVJXYVJKY3ZvQ2FZRVdGNjV5?=
 =?utf-8?B?UDhXWnFlL3BpdVh4R3g2M2swMmdWNU5yS0hLcDVnY0ZXTXFsY0xWc01mSHlo?=
 =?utf-8?B?U0pZVGxJMmY3US94bkNJOUZqTlp6T0M3bWRqMFJSVEtKOC9hQmNPTjNiMFNV?=
 =?utf-8?B?QnM1cmhmdmg4MkRGU2g4VklmeDZCV1paSG5vNHFwYkt2T0dIcGs3YjZRYUJC?=
 =?utf-8?B?ZzdLRzZMUW1pbU5NcmxQdHo1STBGOGR3RSs1aDI4OVJlc1VRNzJ3WFBOQzJ6?=
 =?utf-8?B?eEtNRmpIY1VrZEtGQlk4dnNyUmV1dmowREFqN2ZCN3M3SGVpejhJbHdWVjRJ?=
 =?utf-8?B?OENtMHZjcU5QVlRRQlJuMnA0SHV4NnF0NXpNdW9ZQVc2WmIvdHcyQ1ZMbXZY?=
 =?utf-8?B?SFMyZktUakkrbUpLSWZOV2Z0ZitYSmQ1SEl4WUo1K0M2NWNjWmlqVnFRdnpU?=
 =?utf-8?B?TU9EbmpRTWJFR3pVWUJMOFdUU2lOeGVXcWx3alQrd2RxR1FadUQya0g4RE9Q?=
 =?utf-8?B?ZjV2RGVsdThZd1E2ZEttVmxzZGJmUm5pUGVpUWtsbkxHd3htME94RW9iYkxO?=
 =?utf-8?B?ZnlhNVFwcHdQVHNsMzUrZ2xIeXlsNktmQkUxV1M5VzgrSDlBVXNjOVBGMU10?=
 =?utf-8?B?LzV2WDdBMGIvM3pnMXlUQ3BzU0MyZGVqa01nSjNsYWhramtwT3JtQmlaWjVq?=
 =?utf-8?B?SlQ3QXlneWVEREVqQXcvMXBWMmhGYVo0VG1RNjBqancwZHNRS21Ca3ZkeHli?=
 =?utf-8?B?d1l4bmw1TGNkTU5FNS9KSzNCR3NJM3BkMkF4eE8vVElqUS9tYWdmRURMc0Y1?=
 =?utf-8?B?cVI1d3ExS2tXaE1BK1NWQng0NFI4ZGUrQWVteWsrWkVnU094a2FtV0lCK0NR?=
 =?utf-8?B?aWs1VU9PNXA0L1dBMjY0aUYxR0I2bkgzbUhyRWJjTmJNZnQ4N2loMUN3RlN5?=
 =?utf-8?B?YVpzMHUwTFo1UHhtNUNXdnpuK0VEalNraDYrR2pRaVZOLzdtdlo1L0dCTVNs?=
 =?utf-8?B?YkQ3QnRPaEYvT1dwY1JFMjJFWUJwQ0JVb2xKWEUydjdrRjJ5RldPUmt4Z2JS?=
 =?utf-8?B?aTJFdmpEbTVHaE9leTM5RnR2Uko0NjhwaERTTTh3V2tUOG5rN1NKc1cwWmFK?=
 =?utf-8?B?QUJxSnFlQTh5dEZDYXRlYXB6YmV2MW5hbXZ0c2FIR0FIbnUzSGtOTWVLQWh1?=
 =?utf-8?B?QTN2TGtER2F1RkV1ZG1IeXpiMHJqdkZ2bzRpUFlBWGxxaGRtMTIya2xCRUhQ?=
 =?utf-8?B?ZEdMbzN4SEhpa0FYWEp5NmlZdHBFbFpNNVZYVWJyQ1g5eUwyRWs5Y2tHRjBk?=
 =?utf-8?B?ZGUwNFhjQ3NWRmEyeG03U2VwVTV3VGxFZVpPcEZTYmdWT0F4c0V0cG1Oc1lT?=
 =?utf-8?B?ZXl6VmtjSEJBSTdDUWtzQzZETjZsbWJ4NXlGSUVkZ00yWS9mbmtIOFJ0K1lV?=
 =?utf-8?B?dkVLNjRJN0J5dkhoS2FRcy82bHJOMmFHTkxqMGZWdldsbWJLQjhFa1V5VGxO?=
 =?utf-8?B?ZkkwMEJHd0FpS3ZkYnhyQW4wUWNxMUpCa0VwNHBhOUplY0sxeWM1T1pEcits?=
 =?utf-8?B?czFTcGhLTWtaTldYdVhBMU5ZUGhOY0pabEdZKzFZTTlOWnZoVFIyV01qcGpt?=
 =?utf-8?B?RkxaaWZvNktDQm1YSStEZlZrL2NJT1d3R2R5cTM3SCtPMnAzcVR1bE1sTVdt?=
 =?utf-8?B?MUF6OTlyTTFPNnI5elJ0WjlDT2ZiN1dTcHlaNzUyT0JHc2FEUG1yWnFJS2xQ?=
 =?utf-8?Q?kU3g=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f9bdc1-ec54-4acb-cc43-08da8ab7c755
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:45:15.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVEQt4TgymYoif9WArq7IsTKnncqn2/O9uP5gSg3BKt+eh26p3WL1aFXGrPqQIqS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6678
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/29/2022 12:01 AM, Cheng Xu wrote:
> 
> 
> On 8/26/22 9:57 PM, Jason Gunthorpe wrote:
>> On Fri, Aug 26, 2022 at 09:11:25AM -0400, Tom Talpey wrote:
>>
>>> With your change, ERDMA will pre-emptively fail such a newly posted
>>> request, and generate no new completion. The consumer is left in limbo
>>> on the status of its prior requests. Providers must not override this.
>>
>> Yeah, I tend to agree with Tom.
>>
>> And I also want to point out that Linux RDMA verbs does not follow the
>> SW specifications of either IBTA or the iWarp group. We have our own
>> expectation for how these APIs work that our own ULPs rely on.
>>
>> So pedantically debating what a software spec we don't follow says is
>> not relavent. The utility is to understand the intention and use cases
>> and ensure we cover the same. Usually this means we follow the spec :)
>>
> 
> Yeah, I totally agree with this.
> 
> Actually, I thought that ULPs do not concern about the details of how the
> flushing and modify_qp being performed in the drivers. The drain flow is
> handled by a single ib_drain_qp call for ULPs. While ib_drain_qp API allows
> vendor-custom implementation, this is invisible to ULPs.
> 
> For the ULPs which implement their own drain flow instead of using
> ib_drain_qp  (I think it is rare in kernel), they will fail in erdma.
> 
> Anyway, since our implementation is disputed, We'd like to keep the same
> behavior with other vendors. Maybe firmware updating w/o driver changes or
> software flushing in driver will fix this.

To be clear, my concern is about the ordering of CQE flushes with
respect to the WR posting fails. Draining the CQs in whatever way
you choose to optimize for your device is not the issue, although
it seems odd to me that you need such a thing.

The problem is that your patch started failing the new requests
_before_ the drain could be used to clean up. This introduced
two new provider behaviors that consumers would not expect:

- first error detected in a post call (on the fast path!)
- inability to determine if prior requests were complete

I'd really suggest getting a copy of the full IB spec and examining
the difference between QP "Error" and "SQ Error" states. They are
subtle but important.

Tom.
