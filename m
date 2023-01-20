Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228D1675C06
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 18:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjATRuv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Jan 2023 12:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjATRut (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Jan 2023 12:50:49 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A5E73EDB
        for <linux-rdma@vger.kernel.org>; Fri, 20 Jan 2023 09:50:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fckJ5ZWyg4S3tbRxJO7ry/lpwSN5na4nOIFjmUV4qdN6MDDbpsVRwuuvRi045q9B8/saWmWP3/BVFRhAhi7qBxGSlRJS6D8VH0DPh/FlWqYf5WXpHL4mrhzlcgZgDOoaU85L7M6z13DGnt348JbDcswscYCYMDQE6ExtT0QtuOZT4LmjEqq+pZnW5K1K2UXoWUXJXOEcjws3zhaTdoD8/4jeVCEVKsOTZJCMYlcxNcde9VcyuJfe2L3OW9KzKzLVm/IN3Y/C3prqmsVHsuqUURDZJoAMrARj4zYFBu+4J+veYtuym8iX3oyCAi/mI/8AIga97c7FTnbhaCnP5Z1gnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/sdSenVX1yYb9RJNIi4w4OppKVQuFaxDFPwHQm2py8=;
 b=PLIiiTjyEUXCXAPFlEVxxu9vpGlIby6Vq3UXlmaKWdxHPM5b11JRrtixnkBRuvXnSwsudHju92IFBvH7IntVZ/6F+wlbJO1NU7xtB1H4d+LYSfKmNPJ22Ufu5ygbBZKAOm1sniG3uFi1BNRaOUxVnb6UIeXrEGQmEUwx4Cf/Iq2dWZAy+0w5YUUh11hTxaZQxnFltJ6YcBCxz20obPyYJrffwD1dOH499H3lBIPUa+Xt7cIUT0M0dfO5/4B9CAT0saV7MSdFkiwizeYJxaSV7W8+XKoTgYusVPyWK41VLsW3EjsZ2hrA0S3cUfXamQZohOW77Am9IuG8gWrZnIxAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/sdSenVX1yYb9RJNIi4w4OppKVQuFaxDFPwHQm2py8=;
 b=doR531rSKKvzzyaAfkU/zF9YSDGRmDkN/26y9BHK4B6EsWpiDKoUKMQs4r0nUr+BXKK1WHxPzEmn7HKdlUqkgALBsqZvdzBp8LqGWYYoI8J8+hVDORu8SqpB8ceNPVtuaJ6i6lEEODRrvmPZ4nkdhQ88iTu3VCIlGxMcg2le+IWwA+Pwuz9uB8slWJWMCaF3DLoKUXQEFSJVMPNhfi1b4CddeA16CzmDF+zqyJpRw6InUIbLi1liAL+YH/VY+RjHpLQ5Zx15fF/e3pWwrc+JJdv+hDEjKALuUOGtkXKXcYR/49Vzqa6dc1bdbEK4TQ3UK5yJSdn69nCas4Ehv6KSEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 BL0PR01MB4354.prod.exchangelabs.com (2603:10b6:208:85::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.24; Fri, 20 Jan 2023 17:50:38 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 17:50:38 +0000
Message-ID: <a830a1f2-0042-4fc6-7416-da8a8d2d1fe6@cornelisnetworks.com>
Date:   Fri, 20 Jan 2023 12:50:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
 <Y718/h2uSTYq5PTa@nvidia.com>
 <3cf880fa-3374-541f-1996-d30d635db594@cornelisnetworks.com>
 <bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com>
 <Y8Pnn8NokWNsKQO/@unreal>
 <472565cb-e99d-95a6-4d20-6a34f77c8cf1@cornelisnetworks.com>
 <Y8T5602bNhscGixb@unreal>
 <a1efafe0-1c8e-60ae-cc77-b3592ea5b989@cornelisnetworks.com>
 <Y8rK16KNpj0lzQ2a@unreal> <Y8rSiD5s+ZFV666t@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Y8rSiD5s+ZFV666t@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::6) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|BL0PR01MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b7162c-6151-4343-91a6-08dafb0ed713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPYpKBT6bSzHWmF79gVUyEytwvUlzDiy7DsHg2C2AYXxxeO9zb+zMRPhgCnLuMFEqwAQh/7kXDiBoUjwrmHU0JYpFx5MIQrB7LFrJTbK9A+28IRKZuGORRbc+Ak+xvKOjdFkYh/t0TU/hL+L+vpU4iOen42Oosi3wbecHD6/5w0K6Xj9Ug/fvqLtw4ecbt3lNPK1331w5+2E9ayvpbZZkpSQFjzYLlVndgtDFxoddlswxERjBoibPDH7TGhPU2cgf18zMe7IZl+i5n49mBRYf6BeBOaLdlbmWx2HF0xIiv8cyjEW6KX4TBULx+KITtbalYo5RS5QMQKQDT2LO8cl6xN2IhAqzUW/z0FrK6NFW6nQ+tnir9Pp96pI0nE83cao/OEbsJ3gpfriepbgpFpQo2A6HJpLLwN9B65LUOr+q0ERjRh+NS68RQhz4tVf/HSRZoB0cr/p+npzMC5Hh+20KxuOxspqT9JQEvHevRK7RV/c8IHnyjZChdLQDDt2qaum4xQKzBJcEQUlKROLQDxJksS7Db4yk07s3llYrdCP0IPvj43Egcz0qUeSODkGESZIVpBjQqnkf6Q1Wg4eYBklVA5FoHmdetljg/uUpEkUfsPubhiPVzsyFrY2iZSsdZfHmeLNdJbFbpRW8KESZ4jNy5wxypl7VqBORMTEk1ILC7yax0Fso5I0/9YkUjPVevj579zGkMrY+RW+Yhqd9zRyJfbe16YXYVbYhr8B42DzO5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39830400003)(396003)(346002)(366004)(136003)(376002)(451199015)(66476007)(38350700002)(38100700002)(66556008)(5660300002)(478600001)(86362001)(31696002)(316002)(8936002)(66946007)(4744005)(2906002)(44832011)(4326008)(41300700001)(8676002)(26005)(186003)(2616005)(6666004)(110136005)(53546011)(52116002)(6506007)(36756003)(6512007)(6486002)(31686004)(66899015)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V01OM3MweUFlQW9wbDNGUjJOZy9NVVhDdzNHdkZXaFRnWUNIM2FhNVg3anJR?=
 =?utf-8?B?S0t3YURDa3dXd3VJQmRPTEFJbWtGa1hpdTFGVlU4amd1RnNBcVdoSEV2OHEr?=
 =?utf-8?B?UGkwZ3VZTjBoTEhWcE90bndEVWNqK0NuVHBlck9nemN5b0pXcVpvTXNxNWlo?=
 =?utf-8?B?WEZ0eTR3aE1HSkpLR1JVMzUwM0JlVkx5aFdGQVc1cVo1Y1VqUC85OEJ5dzB2?=
 =?utf-8?B?WjgzOTh4aGYyQTBCTklnSVFhR0JnOFExZXhNOWxpNTl6ckpWdzdseTIyenkr?=
 =?utf-8?B?eFlsQ043Z29LR1Y5UGgrd29jYllaUVJsbkkrWlluNlVod0FkVVFKMEFtT2Jv?=
 =?utf-8?B?OUo3VVI5L2hmVkc3RGRXVTJCeWZrdERNUlVOTFE1UUJ2SlgyYmlrbXBOWFEz?=
 =?utf-8?B?WERsMjNha1hEMGF6akF3eStZQ0JlVWIvazRONUY2SGdTdEhHa25NTUh5Um1M?=
 =?utf-8?B?YmdJZ1ZQTVQ4WDhabVBKdDdEc2FYUTErUFQ5NCsydjV2SjdzTE96ZEYxNEFM?=
 =?utf-8?B?NytkTFI4a1R4RlZlTEhJeVV6dmdrTkhpWC94VEE1VTFKUkdBSVdqWWxvZVg3?=
 =?utf-8?B?enVyWndDWkQwSGVDRmZKL0d5bnhEOHh1Tkx2eVNYZHQyM1QzRFdhRzJERTBL?=
 =?utf-8?B?cWxVZDB4VncvQ3A2amhEZUpyMWFOVGxYL3hoUWU2c1E4ZG1aY3VvZTU1WDlL?=
 =?utf-8?B?UHBQZUMvNFd4YTl4cStrR1d3Nmc2cDJGZHI1S1hDQXMrM1p1bkkrTWZ2c0dW?=
 =?utf-8?B?K2pINTdBRzNtSWp0Rlo1UTR5ZUp5V2pMaTRHbjFPMS9SdUdSZlMvb0w4Rmtp?=
 =?utf-8?B?aW5CTXdySTRlZlpGV1JubC9Ed1RvaDFTVUhaL2lDYW5IVEdWK3VDM1BXTGhC?=
 =?utf-8?B?bFo5VTlVSWJKbWdhNXB6Sk9hL0poajFkSlprMFRlcFRaYnpzY2FGY0xybFdk?=
 =?utf-8?B?U29ZSWNJblY1N1hIT0tFdDVkcHNHaW5nank3UFIxTEFKSGxQN0cwdDE2ZThR?=
 =?utf-8?B?QkxyTmdJN1NjYTJDTzdYNXNTNUd3cDZnMXpJVTJZcEVrMHNWK1A5eGFsMU80?=
 =?utf-8?B?NUExemxDaWx4V3hPREllVEhBdjQvdWJCWjJhdVZ3ck8vMmlvQ1dVaDBzRkpm?=
 =?utf-8?B?dURyZkhKSlBLaHFTRzc1d1hQYUhGa1cwVGlTbTBPcVBuSGFXVVhqczdBczZt?=
 =?utf-8?B?ZUdZa1ZvODU4OUZEODg2dFZ5dmZtNGRFM2tzZklxMEpRSWZKYjVncUNpemYx?=
 =?utf-8?B?RVJDZ3phdVVSMU95VFhnY1lVVjE0S1ZKMDJRcVpJQTJzVWJQNmpwWGc3UDlu?=
 =?utf-8?B?ZlJwMkNjSUs2cWNGQWdXV1RRS2dVSzlUa1dKNXFDZ1ptcXBubHZ0ZnJubS9a?=
 =?utf-8?B?bkJLSkNKRG9lem1GNFFvdi8yMFRxWXZMNWlybUtaakxNUFJRd1JhRXpibkZI?=
 =?utf-8?B?ZEY2UHhaaUtlQk1pdStwdVl0alFVVGNuY2lNdXdXRFdvYWpuYXdCR3A2b2pa?=
 =?utf-8?B?dDI4WDdzVC9kMlJkMzlYbWNiY2xGbEo5VC83RVRkbnAzM0EzMmtteU10bFFa?=
 =?utf-8?B?em1BcXFFVS8zNmVMaUVCVW1qYWcrTGo0YUlpanJkcUFsdEtMUUhhWmh4ejVU?=
 =?utf-8?B?eTNsZittRVBwK2Zic2pRVzR1WkJablczRGpkUHFVcGJ6U2JQNHR0QzBaaitu?=
 =?utf-8?B?TlZwb0tSWVZOdnFDa3FwRDYvK2V3ak5HNWlKYVFxdDFtaWRXN1VJU1hDdHhz?=
 =?utf-8?B?SVVpUXZwRFdzWFhiV292eFNzRDZaRTBpSWxFaDN4czBIdHBudGQzc0hFazA4?=
 =?utf-8?B?alVsRFVnOGRvMkhhZVYzT3dpQXJtdzRvUEIvQmdCR0E4RnE3M0EvZlhGbkgy?=
 =?utf-8?B?RE9KaTV3cnFIdHREaUtkOElRQ1hHVzVoUWxiZFhNd3VzUXhGRnZJaVNQR3Vz?=
 =?utf-8?B?cmZSZjArdHV3ejVQbHB0S3YyV3cyY2lUa1dxT0FwZTU2eG0vSEk0Rmd3Uisv?=
 =?utf-8?B?Tld3c0JiTXhaYnhqS0F6UlQrQm02bVIveW9SN2F5bXlXWkllbGpIY1Jncmdv?=
 =?utf-8?B?a05Xa2VGT0gzUk5sUGNtZXJTb2dUOStIcDFueU9zVG8rdzBBNTJDYnh2bGRJ?=
 =?utf-8?B?VTk0YmlpK3NkbmdKb0NEUEVhSWQ3UEtsd3RmYjlSY0xiU1VDV0w5SGptVHdn?=
 =?utf-8?Q?3TzbgF+AC/rV72dQs3IhpeE=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b7162c-6151-4343-91a6-08dafb0ed713
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 17:50:38.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYV3FcPjp3fwqo6Pa4CgYdYTTsb9RlfiwdDLjQsv0rNYcayojDouy8P+0XQk/uELsQyQpSj6m4M8BBsmK/l9iR6IbfqnxdaXCWkvnP1AyKAWqN+rAan/tyPk6EN7jUUR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4354
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/20/23 12:42 PM, Jason Gunthorpe wrote:
> On Fri, Jan 20, 2023 at 07:09:43PM +0200, Leon Romanovsky wrote:
> 
>> Backmerge will cause to the situation where features are brought to -rc.
>> The cherry-pick will be:
>> 1. Revert [PATCH for-next 2/7] IB/hfi1: Assign npages earlier] from -next
>> 2. Apply [PATCH for-next 2/7] IB/hfi1: Assign npages earlier] to -rc
> 
> You don't need to revert, we just need to merge a RC release to -next
> and deal with the conflict, if any.

Thanks this sounds like a good way to go.

-Denny
