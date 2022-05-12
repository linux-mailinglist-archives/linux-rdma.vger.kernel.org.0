Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95E4525061
	for <lists+linux-rdma@lfdr.de>; Thu, 12 May 2022 16:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355470AbiELOjt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 May 2022 10:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355467AbiELOjs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 May 2022 10:39:48 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9812DD40;
        Thu, 12 May 2022 07:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht6lEGueA2kEzOretV4YyAfUMm8XAfrMn5aWVeJf4i6laPxUA3wetn4N9Xt+AD9FMuWgkbjb9+ddBvYXWR8mMeZaSWLDBGpcXJBdalG58CI70Dsg5GU7FVI9Jxp7uN7cddAU+Gf1Gdb2UihLoEvUG7b0i5x19V0wdHlNkxsh8zkZxLG+sUu9GaErJy2uDVkEH2nLGEVsGrMnKdh7HmcqDxLQdxlIplnZaTqMb7dfzW60ua+9HfnCOc6xe0icRtwBecNwPj3CkWC6RuViYm+w1OFPd31BxPTEg5OL3g36sj8uzqDhCvVsqW4h+0GpijlS//TUnC57EfrmhpL+2MDb8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6L39wFxMQdX8qbXDitRVLgSKZg/gzF7uOvPpbhLXE8M=;
 b=nVOnFjkgVOPvLtJZOkaYUPWOHOVHQhnZ7anXGq8ltCY9nQ7RRxhS0+kNU7ZSqDRFOoHmoemkegTDxRf5h7PyklpFrRhU0QPyQiM7R06hYW9VENldqW7bjit+15caw/BVyDEvrQFI/y5+hqFXWwsxTd4zmYk70MFmrg21qQDPAtm5hP1U2RmC+x8xsoS7WB4Gd+vrHQDwgWmuNpOdrpeAzDD5XB+PCAs+/qZ1uU/oSQopUpBI5WKKtbe0IR+fouoCWCgouivCpRVpZJ5Itu9Co7nP8krA2JZfZGE5sKmpIt57hEEyzLjsoYzXzznuuwoNmiLAy5Em/krBnBOoBPp0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6L39wFxMQdX8qbXDitRVLgSKZg/gzF7uOvPpbhLXE8M=;
 b=EF2+eoUw60RPVpSIXwUrbwuhOwJKpUgvGJ3/C3YxVU0NwgXC4+xsuLOdVoMfOaPDyqBb8m5lbYipVKWlKVFt76/w+TcCseV7/Sc39aEF8zi4LdLrI+lhp8p7RxYHEHQL/w57MgGJ5cUCEJd0ZWpSFikqCTy0HvvgC2aOdYopUs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by SL2PR06MB3052.apcprd06.prod.outlook.com (2603:1096:100:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 14:39:44 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 14:39:44 +0000
Message-ID: <88e501de-9653-0570-74da-d1f7b858a2f0@vivo.com>
Date:   Thu, 12 May 2022 22:39:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] RDMA: replace ternary operator with min()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Leon Romanovsky <leon@kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "open list:CXGB4 IWARP RNIC DRIVER (IW_CXGB4)" 
        <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhengkui_guo@outlook.com
References: <20220512135837.41089-1-guozhengkui@vivo.com>
 <20220512141108.GC63055@ziepe.ca>
From:   Guo Zhengkui <guozhengkui@vivo.com>
In-Reply-To: <20220512141108.GC63055@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52306978-f283-4760-8bba-08da3425412e
X-MS-TrafficTypeDiagnostic: SL2PR06MB3052:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB30524A831D488DF37DC1DB94C7CB9@SL2PR06MB3052.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCDHBE9xK4xulvKSkS+NhvS4F/C4inR/eKNr+Rm6cHhJTGxayhw2wI9YnS9590fR87klm/Zy2xnMYNfpVYfvkh8DDtS/duX9GzK0XUzHnJDfwF387usuc4bk1FQ5nuUrOs59RyA6ApMQTqfc6SR4SRQNVc0WO3GxJoNbXLgsxwI0o9L474RrM6aQ2sNYzZfX+gv2V2opDzTZL89hzBA2D8z+aNwgrfccsmy8JNSiOGfGDB2L4e1wQ/nceq6tOwoG+jyQ3Iv0IWPT0B3olx+IvfQF+g+PGJZd7mcGttgeF/54r+AZf6x0RjBEOM+FnJ44PtzWpxW1NIeunUWfuPbVVt/uEf+9pLJdnZnBQkp+kKJDkCcurIFV1JPbH4HAx+OSUqvkALkGhnpWnF6qiipVmJRvBoIkOnzDN+dZudlh2lO9NYx5gyQt9pYb6dgJDFe64a+z3gWlNYRbIDj5/FWgVTFkZsW99qknBGZ1W6rMPduSgX49Lz/0+F7d+6LMytz84L1SrhFKY72ld4fCqhdvxVHSEEKImF0pf7vNCF3p2w1NuVkYiXYs4sg1u9Cxo6UMNYqqqnwA85sYJn7d2rdSl9Utu/0z1k9urDNVeqVT+CcgwiU40NSLqLt74qqR4RzfQmDhsvOC7c9ncI+h8DSEa0f/iMXYGA1lX3QrOqPtzZPIcCo708ARCKqhtqiHb2jSe6xIsndBrz9SIKdWXsbyX00nSH/3C+jIR0Qw+j5Rlr+mnkzyc4iRbSUvBY0Tm4rPvXeJn2vkrvh8kMKaMBeRSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(2616005)(26005)(6512007)(6506007)(53546011)(52116002)(36756003)(8936002)(4744005)(31686004)(2906002)(5660300002)(86362001)(31696002)(54906003)(508600001)(6486002)(316002)(4326008)(8676002)(66556008)(66946007)(66476007)(83380400001)(186003)(38100700002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGF6aHc2MTA2TGhIS3l0UHlJL05CWDR5QSs3QWNIYlRnZGhySjRyQmFqcTdG?=
 =?utf-8?B?b09GZDBpQTFSREM1NXlpbGYxVEkvWE1yK2F6bnNDUjhkZkJsVEx5bDVKK2pN?=
 =?utf-8?B?YmtEdER4cDBRTzdSUk5HU1VhUDVHTHkzekxmNkdqQnZiNVJ4MDd1YlZRcXQ3?=
 =?utf-8?B?aUk5MGVXU3ZzVFVZa0hsVDBQYnZISFk0VGZiRnVtZFNTQjIvT2MyazQzWklP?=
 =?utf-8?B?VVNiQXVVZzdjZVRibjlpeG1xandYcnJkSUljNFFvaUVEcWFhSVR1U3ZSRlMy?=
 =?utf-8?B?d2dXTXpIVjROcDBqa05tUkFzMXZzZGxvN05RMWNvc2F3V29FRzY2c01ITzdR?=
 =?utf-8?B?bWh4UWR3RmpOU0ZFZ2JIOS95c0VPQ1JCc3N6VWJPV0w5MVlMZWIwNDlkQ0FX?=
 =?utf-8?B?YTBBQzVJTDJackRkR1cveUhmMGRGQW03S2p0bTZ2ZDlKOUNoSmdJUUEyekRs?=
 =?utf-8?B?ZHB2WHFZd28ybGsvWkVMd2NVb0g5aXZuWXdqRGtlNmtjeStuOWpVcERsejBD?=
 =?utf-8?B?d0xmaDJlaVJ2TWRHZGNrc0xleWh4Y0hpdjR1OFgyTEJXYmxFbkFON2ViU2N5?=
 =?utf-8?B?M1VhMXZCZ0dyNk9IZUtiMUlhR3l3OGFOb25UVE5QTFRtRDhUMVExdWhHSnA5?=
 =?utf-8?B?OHFzQVdBMkdZOTR0dUFKM2srNlJyTk1VMkxscTNwWFg2aGtzM0s3aGQrWHZW?=
 =?utf-8?B?T29HUmhxMzJsbXV2alZGSmxJN1ZQYlFSRkVvSDRLNGNZN2tOMXc2YStNa1po?=
 =?utf-8?B?NXlyL0JxV2NraUpJTEZMdTV3Q0R5eWtHT2hLUFRRSzQ1Qjl1SVFOUEgzb2R1?=
 =?utf-8?B?WFlkQnF5UWVKc2loTTVJb0owRkxOZVZpUFlKcmpHeEZqRTRwQXM3azM1ZW5G?=
 =?utf-8?B?eWFhZCtPYlVvM2R4Z3ZjanE0bFNaRzFGZWRqZm9pV1I5aisyaTZ5RExWbFov?=
 =?utf-8?B?VWlLbXlvNUg1Z1JwMXpmWlJNeHZEZm1wLzV5M0N5dVoyRTBJNnlWeHlWV2RS?=
 =?utf-8?B?emZ6WGZ6d2xoZXVnL1hPTTVNWlgrVVhTNjhSb3E0b3JtMmh2TVRJbURaWGg4?=
 =?utf-8?B?bkUzbGt4WDlldDZVV043b0ZoTElaZzhpTUIrKzU0QjM5MDJHNG5Ic1ZzaXhm?=
 =?utf-8?B?Qkszdkx4ZG1lTGN4Y1J2SFB1WHEyUGxvYVFwM2pnSzU0Wkd6dWtKQmppTSsv?=
 =?utf-8?B?b0x3Y0NEMitDb29wUUl5K1YwMTduUmxzWjNDc2pwc3ZCSWdHUGNtQllYeW55?=
 =?utf-8?B?dTF0T1lzYUljZkM4amxRdHRSV2FpWlFudlI5UUU3SllDajVMRzJkTW9IWkMw?=
 =?utf-8?B?UU1nUWZRcXhOUnl3T3VVVkpyWThhSlphNnBLMjdQb0N3TUFJV0xBVVBmV3FE?=
 =?utf-8?B?NTFPODBuQ0lyVEd6WGdsVDRFWlF1UUo1RU8wL1U2anJaRmNhRnJRR3VQNVZS?=
 =?utf-8?B?RVg5Y3RobEJGQ1Y2TS9hSU9rSWtTT0dIbGFvaDVwekJ3bzc0SXEvdm5lbnJ2?=
 =?utf-8?B?OHlUTGtCTkVRNGE1dHg3Tkc0b28wdTdXT0dWYTNuelg3QXgyaURPSUFGeS9z?=
 =?utf-8?B?RU5vUkxWRTFWSTFZeEdiemkvUTJ0bUtVK1d0ZTVPNE1hSFNrZjNHVXVMaFpE?=
 =?utf-8?B?LzVmMnpFQSsxbXZmcC8vMWFPWXI2YmV1aklqWjJ4cFNuZGc1WHcwaDk0T1VD?=
 =?utf-8?B?eHZ4MHdwSUJSQjRwM0dCNXRQN3h4UWZlSXJzSTdlZTY5blI3L3M2WGc5dzBs?=
 =?utf-8?B?N3pKaDd3aTdZYTZGUEpOM0R3bGdERTNvcGZBVEVnMUtTbERqYnhkM2c1QW8y?=
 =?utf-8?B?N0xQbG42VFM5M3FmWEdrVWs0VXJVTkk0RElxd0Z1MjM0SllwZFA0QnA1NU1X?=
 =?utf-8?B?UndmMzI3M2N1elRRcGIwVmVvSHR1UlllR0NYOUgxNlBkR1dYTXc5dUZYc0xZ?=
 =?utf-8?B?bXRlU0lmbFlCdGVZemdDT2tKdE9QbktGMHQ4OXVZeTBmcnZ0M2k2dTlMeDV2?=
 =?utf-8?B?TlRWRmJTRWgyVFFVaFBrcE9uVWhOSUlHOXUrU0xTUHR4VDIzM1BkV1Uwa3pk?=
 =?utf-8?B?WUN3dFN5eVJPNE5uamZiOE1MWXIweTFNSnQvVmRvNDVBZUNrZzBQbVVrSnNk?=
 =?utf-8?B?ZjYrYTJzWWZHbWdTQTNHUytXM08veldtOFlXRkFOOGFQa2UwMThveVh5M3B1?=
 =?utf-8?B?cm96anRVd2hNYVJjeVI5ZVd3SEdjRWJLakszOHNvYkw2VzRaZGl1R3QzNGdu?=
 =?utf-8?B?T0hOakxmTER4UGFIUUxIL2NHa1NnVGNoOG9SQmt5RVFDalAzNXhGUHZCdjNi?=
 =?utf-8?B?T2xjb1M0aTlZSW1VdG9TaVhWQmhOa2NZRmZlT1o2WXdNQXl1bDJGZz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52306978-f283-4760-8bba-08da3425412e
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 14:39:43.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wkho+Xbh6nLIitISyrrMLdeuLsnYeuYJ06zz5Q1jlo4H8ml5Y42+qB/1NpsZSd5DldHFOL7s5yodFDzg8Jl/ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3052
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/5/12 22:11, Jason Gunthorpe wrote:
> On Thu, May 12, 2022 at 09:58:37PM +0800, Guo Zhengkui wrote:
>> Fix the following coccicheck warnings:
>>
>> drivers/infiniband/sw/siw/siw_cm.c:1326:11-12: WARNING opportunity for min()
>> drivers/infiniband/sw/siw/siw_cm.c:488:11-12: WARNING opportunity for min()
>> drivers/infiniband/hw/cxgb4/cm.c:217:14-15: WARNING opportunity for min()
>> drivers/infiniband/hw/cxgb4/cm.c:232:14-15: WARNING opportunity for min()
>>
>> min() macro is defined in include/linux/minmax.h. It avoids multiple
>> evaluations of the arguments when non-constant and performs strict
>> type-checking.
> 
> no, these are all error return patterns, if you want to change them to
> something change them to
> 
> if (error < 0)
>     return error;
> return 0;

Do you mean we need to stress that they are error return patterns 
instead of taking "minimum value" style code?

Zhengkui

> 
> Jason

