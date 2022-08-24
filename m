Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C0E59FCC7
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 16:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbiHXOIz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiHXOIv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 10:08:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CB56714B
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 07:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTDBZsFU6Ut8lD8MX5Ab4zUOZ89ididtskYcP2T+YVwFkPKWkCYHT8u4fa/vY3ENT/CYd6npGZlG8OXc5WNB+HQOjeFY9Bp8KIGJl1tU4GX9Jk0o3ou+iAwtmjydsJxNAGUqV/Un+RhRtnKTW9LLzbw1Ho1yYri1AQ57JJNnSLv4Xd/tLccKuNx5fF2R2YuvuU5PfEv3RZh9cLXIBjHEWFZeii0Tb+ziUyfTJY4xKaU1Z0omo8oYp2u1bG++aXvtDsqu+GopAyF75jOpO12ubkpbUs0Ev9XQMuizpwQp2fhP49o3hbqLnINkbQX4GAKYuZ7nblT0KoN2mqeMCq2p4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owNZz3Nb6mEaZGUpdOBDZIodJUsQRifHOZv8wb6sC5E=;
 b=MrePj6rwwaFnNStausP+XAfvkRU4SLFNu1nnWnjXSKi2gcAMbzEGx/b35/i6GqA8NF0uebGZLRYYVG9mLMUe1yZ1iGASVq4/pAC8afA7FC7pjkilnYW+7PuozXwU1hXaL5uQLnpr0BB6Wuqf73lJevxfaC63PSnjj05/eTHZfIOb1qfp9W3pQEi4yazhJ0us9eqA7KTuR+67m/y0rXwOBhPXiOwRpul6WyL9SPhzbRboVkMfWR81xbU0M53ztX1BO9INXJtcb6oMO2VwITdLpcLWKmv4jy6MpIukKEKrIYv9EK4PNOZoQ5ozOPUEms3a0ci76G4AY/B+ECDd/fE3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 CY4PR01MB2776.prod.exchangelabs.com (2603:10b6:903:e8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.22; Wed, 24 Aug 2022 14:08:45 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::21e9:8dbb:6e40:5073]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::21e9:8dbb:6e40:5073%2]) with mapi id 15.20.5546.019; Wed, 24 Aug 2022
 14:08:45 +0000
Message-ID: <2c7c248c-34a9-c614-6abf-e2f6640978b8@talpey.com>
Date:   Wed, 24 Aug 2022 10:08:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH for-next 0/2] RDMA/erdma: Introduce custom implementation
 of drain_sq and drain_rq
Content-Language: en-US
To:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20220824094251.23190-1-chengyou@linux.alibaba.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20220824094251.23190-1-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:208:23c::24) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e34ba84d-d6e2-487d-af4d-08da85da2855
X-MS-TrafficTypeDiagnostic: CY4PR01MB2776:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wofljVvyKw0YngL5BY5o8YmPGVclxD/L02F/u/YUFpAh+KzT7tkQP9wzwOFguD6873DJc9Hzu+Ptq97AHuRL9jIhbkWduip9XsP+dtNQC3qyhw6u13TC6mHG2yIV4p5UsIhhvVOih3Hl85v0964kc91JwWiDVMe9ShNIeMV8rC7EFQNEdmqu8jns+k+AJb+67BAsklXLtoE0kK04XgPv07nffIeKqM5OpRDc6C5XRg+04T6RRv5BupVxWpuGHqeZ4FQ5nWbjAR2gdkcu3YHb20An2RIJe9CsXniauq+O31jnH+2BthuqBKuQbJLZlwODNYmLOlO05QibBNFOcb62o5xlNUYCzLfnHDeDZe1BKQTmJhfPp2CN+xNgw8qNTguoAxj9B4hPPMdBmMYJNiCtixs06Yvxwdzn+ADIlPFeiAECsHz6d2gPucLGtkMQPVEzsnCOhH19kGcAdbo69hWrlDjCZBwv1rUXdS/7Tlyw6F5BZKdQq52m031JJR+nQ82iazhs0rnHruqAen/Z45WIHxAUPpt6cTc7qMlcQVCmKf9o9MZekX06ynoLPMiPpA7kGQnq39prJIvi/gjNLgAZLiDRLqCpPela7ljRTjn0QOAst46YgvHtGSdFqAUysOu+uQIZTuZcfv9HNEfxERa1fK0POhIFjINNuiWAlv3I8/EHuna1gVT7kQPCS65nP5J1FpNaSlxPfuJ5WXWi4m/SVemKr+/Pglgrv1LezPart3/6BkRY+yQw/rCmTwZDvByP6M5MpWaJmnlRYGIzh/7UNFWru4v9e0USZxMjKD328IU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39830400003)(346002)(396003)(376002)(366004)(31686004)(41300700001)(6506007)(26005)(478600001)(6512007)(38100700002)(83380400001)(38350700002)(6486002)(86362001)(53546011)(2616005)(52116002)(316002)(66476007)(66556008)(8676002)(66946007)(5660300002)(31696002)(4326008)(8936002)(2906002)(186003)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFcwQUdiS1RCM1FFMFhtM0J0K3QrSW96aUF4dG5XQVJlaW5NQXc0ZkVKVG5F?=
 =?utf-8?B?VWlYQy9tYW5ia0NTVmJmZnBkakZDdHdjTzVxTEFFTmZmbmZ0U2UxNWhTemhJ?=
 =?utf-8?B?MGJsWE53VXJnUDY5R2lYVzVkb2VBc0E3bEJCZ3hTQXV3dzJ1dzdrU0VBd00x?=
 =?utf-8?B?d0RJY0twZEZBaFZJdVRIMDFucFZKNG1PNnBUTm84TUNCY2Z5SlAxMysyTFlF?=
 =?utf-8?B?VGRQaFlRNE1KZXlKc0pzMS9vSmJvWFJBYks4UzlFZVhIMmgwTGM2UkVuNFpT?=
 =?utf-8?B?ZnQvb0FvdENPS0lXaER4SWFCbGpyNjFIeUp1cTVEaC82WUlCYVl6L3UzWkZI?=
 =?utf-8?B?WjlCSjBRL3o0NHBLcFgzZlBodXltSndsMW04aU80djNxU3dzak5HMXZGb3l3?=
 =?utf-8?B?cFJQdUZYRkY2d0J0Q0Q1SC9TamFpZUVyS1FKZkVSd2lDNTlBYlV6Nm43eTk0?=
 =?utf-8?B?Rjc4VzQwTXlVc1NWVVU5dzdkaW9SOU9yc3VsUEVJVzlHUG1ISzBwby9mc1dm?=
 =?utf-8?B?citaUGo0bkdSdmNSYU82Szg4ejVvQ0xjZGNlaVdFWmlKSzQ1aXp5bk0wM2tq?=
 =?utf-8?B?SWRQRmpPQVAzU0Zaci9vVUg5MGZrYmlYUWpwVFhTMXFGME96R3pFMDFjckt0?=
 =?utf-8?B?OEtHNUwyQUh6RDZCRERsUTFyc3ZMdDlDcU5iVnY3aTdUSStDcTRYV0tjKzJ1?=
 =?utf-8?B?azFoM0UwLzEvY0EycEFpT0Z5c3NHbUQrVUJnS1BORXlTVkF1RzBRVm45NFZM?=
 =?utf-8?B?c1lWTWlKbHoyMmFVc0RXdlNZT1VRdEZYMXNqUjlXRmdXNFhBeWFuR0RwTVhP?=
 =?utf-8?B?aFBtblNUa21KeGJKMXZKU052aXUvVkRQeWhYUllUUk9FdndaVFpsc09pcmEw?=
 =?utf-8?B?WEc1OVVBTGFhQ2tYWlV0V0krSUJHWTFlTzNhL1ZUY0lLMEx5aGdVK0o3cWpo?=
 =?utf-8?B?NnFySHZaS3p0ZjNVeUZ5aTdSd3R2ZldpOGxKOG0vRmM4cStRVXhaM2JUK29R?=
 =?utf-8?B?cUE1ZHZsT0RPTll4Tm9EdTROYm5RZHAzS0NaNEg0T0xINDdWTklxclpocmxV?=
 =?utf-8?B?N1ZYV1V0Z21NZzVKYUZKT3ova1N6WG9FL3o0OHNEZW02WmxOa3l0SEF3enR4?=
 =?utf-8?B?YXM5eGRkb2JCVC8xM09PYTVJelhoeUJ2TCtGME1XTEd4NFp4ckgvSUNHb1pI?=
 =?utf-8?B?ZUpTVjh1SWhNT2NMN1NLR2piYUN1M2U0eWJjZ0ptbVcrbjh4TTdPSFVlN3FC?=
 =?utf-8?B?YW9oTVYrUzNGR0I1MjNaN3ZDWEExc3ZrYlZpWjIzUzBlNEEzREdsSmNjbU5E?=
 =?utf-8?B?bVV5MG0wVjE1ZnIxejVzYWQyL2hYT1phVEJGT0l6S0dyTjdHUkhUR0Z0bHF2?=
 =?utf-8?B?SVdiUEIwZEk3RmVqb3M3YWxiY0RkbVczQXhxbkRHS0pCQ3BGQjA0cU1mQzZW?=
 =?utf-8?B?d3pnSWltYWlOOHIyNHhJNHBQWTZLa1JMUDZKQlVyR0ZTbGNHS0FLNmZqci9K?=
 =?utf-8?B?dWtjaThsaUx5OXFTTlBwMXVPWWdkdkhRUWx0eGQ5Yy90ZmZzWE1GTkJ2Tk42?=
 =?utf-8?B?RE1HTXZtS0Z5T3F3QlpneStLYWZoZFhvQVJ4T0xPOFdJS2lURWFGQlNmSE44?=
 =?utf-8?B?ZHNqdjI2VUJkS0dDaVVIaGlUUmxGKzJBKzZKQ2ExSVhQN0VINldNTWdpclpU?=
 =?utf-8?B?NERwTnBTcDNxODE3Zktvam1UVmxQOXBoRG13cXkrL21oNThFTGc0RFhOMFZ0?=
 =?utf-8?B?VVlvdWFFRHVvbW9YeDNCM25zTkxubVQ2MzdWcU81UUM0SStGZ3lrbGYzOXpw?=
 =?utf-8?B?WUNXMDdLVktiNDRJZnU2dHdCaUZwem16d0ZkbmFKdDF0NE1nYXdsSGc0cmtw?=
 =?utf-8?B?YkNKRHMyWUxVTHdvaDB3bFpGOHlUSU1TM09vc3NYS1MwcXdXMG5XYlBScE5y?=
 =?utf-8?B?UmlqRmpvRkxLaEh6bVNINmhwWWhDY2hPem0vRi9OYnMzeTk1M0ZBZk9NN0l2?=
 =?utf-8?B?L0RSb1UrMTBGUy83ZVJmcVBNektSMFlVLytSY0VjdEx5VXNhOE9JN3Z4SkUr?=
 =?utf-8?B?WUhxNDNMWStlKzdOdlB6VEU0aEoyYmY1L0d4MnM4Q3NGQmhPQnY4OHVSN1lv?=
 =?utf-8?Q?Erlw=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34ba84d-d6e2-487d-af4d-08da85da2855
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 14:08:45.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsfdRQ6KODEg+Ww1naZSngUimdya7rl60hwUebcqqm64TZ/hRI7ROr7OhzfaIjyt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB2776
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/24/2022 5:42 AM, Cheng Xu wrote:
> Hi,
> 
> This series introduces erdma's implementation of drain_sq and drain_rq.
> Our hardware will stop processing any new WRs if QP state is error.

Doesn't this violate the IB specification? Failing newly posted WRs
before older WRs have flushed to the CQ means that ordering is not
preserved. Many upper layers depend on this.

Tom.

> So the default __ib_drain_sq and __ib_drain_rq in core code can not work
> for erdma. For this reason, we implement the drain_sq and drain_rq
> interfaces.
> 
> In SQ draining or RQ draining, we post both drain send wr and drain
> recv wr, and then modify_qp to error. At last, we wait the corresponding
> completion in the separated interface.
> 
> The first patch introduces internal post_send/post_recv for qp drain, and
> the second patch implements the drain_sq and drain_rq of erdma.
> 
> Thanks,
> Cheng Xu
> 
> Cheng Xu (2):
>    RDMA/erdma: Introduce internal post_send/post_recv for qp drain
>    RDMA/erdma: Add drain_sq and drain_rq support
> 
>   drivers/infiniband/hw/erdma/erdma_main.c  |   4 +-
>   drivers/infiniband/hw/erdma/erdma_qp.c    | 116 +++++++++++++++++++++-
>   drivers/infiniband/hw/erdma/erdma_verbs.h |  27 ++++-
>   3 files changed, 136 insertions(+), 11 deletions(-)
> 
