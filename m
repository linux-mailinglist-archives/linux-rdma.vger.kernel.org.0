Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DCA4ED2AB
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Mar 2022 06:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiCaEH2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Mar 2022 00:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCaEH1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Mar 2022 00:07:27 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E2A287A1A;
        Wed, 30 Mar 2022 20:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBMx36nT1tsk/MOFTCgXpJEuQDuhmBcC5LfRWYqWURF4F8HuHuHIjhqMH2XfODnE8woHC00xAcvRd+PcFI3/unXEypFw/68onqAmlyTstoR59bQjWxWDB+4kqu/aEbsS6lfD8zIc8gR/PS6Ab/ZaEllMr2cYJ8h5vJZ6+1zFkBl4N6wsEtaXlnQR2YtcRfIQqf+sA+fZwNmxqg1iKEtVBCzYzKSd6k9IzdG4jG/rHPFnoh/y0OOT7O5zkYkyORtw3xGhgT935oDUOpXAWuenAl+aeiu/zpcPQ9f6WNjF1VwUiQUYM0G327cC4fCd7jLHc6XIw7qUjjDzxGY9w3A+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKExRe80xFpuF8GG/ZskSfnEVRV6qTDpW6d42qldtiM=;
 b=hvpxwSS9rgOZJblGb8ZzAZ11hhqcGMSI7w5POnjZH3IJii8dRx7K2KbacKlfJ2hdunStPeUs9OJLpv9xZW3vWKccoqXF6CWy0iS3SCbLeHl5us1cMb3ozktfxNmSXTHa/nxULekJo1145FZtXeQAk28urGa8vcjLT5CCJYb2MKlzQXm3Ddwj+NHqR0m7q8F/Sgz/xb2Hji5086d/Q4buFC4Ls7ppQhLP2Oa0pQqjWynWp4VoQvK0EJSSrOChRZXUytlsevlmEEvhcEqBGw2scEH8IyKgBkgayOpXD7yGU5aSdY8dC1sdJwPqg4ZxSNlM4gOGG9nOjIW5j3l2MZfGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKExRe80xFpuF8GG/ZskSfnEVRV6qTDpW6d42qldtiM=;
 b=NHFT0ZxPjurmHnu583ah4n80O/JIPqM8PU/guHXmaeJrTfm4/ojdfe30+1YmlIZRyEMGepxGchGXSW3ZknaFo/8awtEibmNSrM+IX1dpuT859tEcj7nQUye8LBEEZ3FYqkoo9BX0iT8Bv1wsywWR7SjwR+56KAjdu1sIoruTd3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by SG2PR06MB5261.apcprd06.prod.outlook.com (2603:1096:4:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 31 Mar
 2022 03:03:35 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33%6]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 03:03:35 +0000
Message-ID: <38d43b49-9999-af2d-e3cd-3917c481651b@vivo.com>
Date:   Thu, 31 Mar 2022 11:03:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH linux-next] RDMA: simplify if-if to if-else
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "zhengkui_guo@outlook.com" <zhengkui_guo@outlook.com>
References: <20220328130900.8539-1-guozhengkui@vivo.com>
 <YkQ43f9pFnU+BnC7@unreal> <76AE36BF-01F9-420B-B7BF-A7C9F523A45C@oracle.com>
 <YkQ/092IYsQxU9bi@unreal> <93D39EC2-6C71-45D8-883A-F8DAA6ECFEDF@oracle.com>
 <YkRTidagKVgSUGld@unreal>
From:   Guo Zhengkui <guozhengkui@vivo.com>
In-Reply-To: <YkRTidagKVgSUGld@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR06CA0031.apcprd06.prod.outlook.com
 (2603:1096:404:2e::19) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 331a29c1-7b5b-48ea-2478-08da12c30b5f
X-MS-TrafficTypeDiagnostic: SG2PR06MB5261:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB5261F52680FC7B8EF2B55947C7E19@SG2PR06MB5261.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4W2DmVku6whG6PfydteLbBpi8nRpOARKISEL7jwh38Mc4lqgM8hGTBK5vd9HKwF6xTQ8WpwVKd4lc1G4c+P8Cf47JFS3Whwl6IN7h0DVJV5a/MYUemsGbLUW1QZYk/HbqEiUBkqSr+otSPURDrXDBByyh+dXHZqXRgE/qc+nc2EoiIDmDNCb2vVKfXuTCMnguV8ZLDoBfEHsL6WyxpJh4B1A9ASxAhQOae0rw5d88mJ6FzZEItZS6ogm/mozhhrz/eJ9iD5FlF2M1e0NTAbWGtPnLAaDEnuPK87m6wxTpraMEtPEgYYOJNJi5N+GBfJOZ/BPfOAR4hXSULL2zaORT3PaugeTtVhULjJm/I3OjzE8iN8s1lxuk1yGv7uI9e1sClKgPIuWs4uAf16mmg31A+p0ukG1ha7uKU3ReOw39/eoopfxeBlHEUY7lkms7obcKqf8jn2UrvZ9a5E9kXwvqblUqxnqKJAh4bO3Bc7OWejDQQc8yNkPRmXnVxfibRMGvh2fFud2a1XPZQuc8ezvSVFFSMdqQg7fTmosy9GK0B+BJ5SObbOSyBMSC5bAUu0y7PMiFkVmVKoqvRt5s9+x6PET4+yT+9bqhgdVi5eBhzVNQ4kjZDY4svI+QBjhey5/Qub56U4PNZxd5g50BH0tRh/KAhsKHSBEeLIKULoRnMtAb53azWHgd3Na2DKv00KDSzUIkBj+8jlji6uBi85rRCiXPa81RdwoNbkgqSpVNAWDyM+RbUUFhWdMczRBSuvkjIPK+MziSxbXeXxmKi0PXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(38100700002)(83380400001)(38350700002)(508600001)(6486002)(2616005)(26005)(186003)(52116002)(2906002)(4326008)(53546011)(66476007)(86362001)(8676002)(31696002)(6506007)(6512007)(54906003)(66946007)(66556008)(6666004)(36756003)(316002)(110136005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWI5MC82cTJPYXpNWk9OKytiMkwrVzY0cHZ5Z3d5Z1FaVlUrajlmQ0xhdVNW?=
 =?utf-8?B?ZHJUcnBkM1hOdi80NXduNUNyeVZVenhtOTBiZldpdyszV1dzdm9Yc05hRDhn?=
 =?utf-8?B?TkVHRzB3WGhnSzBoclA2ekJNUnB4TFVYUEZCbEE1N1RYaXF3Nis0TlhFRjFJ?=
 =?utf-8?B?Z1JCWEY1RnNrZDVLR2ZhWlQxY2piclB1NFRFT2hSdFBJUjFmVzRIYTNGV0dq?=
 =?utf-8?B?RCt1UVdKOHZmdU1ndlZSazcrekNPOGV5dENBZXJuaTh1OWlxN0kvRXRlaEhM?=
 =?utf-8?B?RlNoSDAwM3dVQUNGUXdvSUUzb3lHQTl3Vkd3U3ljcURoWnZPVWxvSUsvMzV6?=
 =?utf-8?B?Tyt2MkZyeC91aWJqNXhxSUdiV2xTaUxudVltQStqTGU1Y1lyMUFOdGJwK1B2?=
 =?utf-8?B?Tm1aeGlKMFZvb2JUUm1RbU5IZTEzeHhmNHpJL3Q2Y29QVFBmYTdLSGtCdFo4?=
 =?utf-8?B?bkMwYm5vNUtZclhVNGtkTmgwWVVNYTl6VDFXUlNscjRtak01NDI3aWJ3NGpR?=
 =?utf-8?B?anA1ak9LbFRaZi9BN3RZeW1UYTVxb1cyWFU2N2xWTGNJLzA2KzNIdnFVVXFX?=
 =?utf-8?B?aGwwbFRzZ0w4R1FYT1F1ZUVQSFN6d3owd2RkVEZ0dmFjZkx0ZHF3L094WTdS?=
 =?utf-8?B?c3ZLR1pYVUFMaXFvZW1xRDlEeDAxMFo1bUtjQlRUcGk5Ykp0emZlVW44Wm5y?=
 =?utf-8?B?UnpPSXlGb2g2c0ZodmJRSEw0VkJrQmJpYXNZaDI3L09aNjR6UWpkbzM3TThZ?=
 =?utf-8?B?UEtpQzNpWU1UWklONkorY3dQYW4zbjNPTVRqa2IzT2ZuQzhBWTJLNml4TEhI?=
 =?utf-8?B?c1VJK3NyQWxlWXJ6MHRWbk45MCtkNG12cmdaaVJrZExxT1lnT2dKc0RPZkZJ?=
 =?utf-8?B?Q0VuVzhjQU9jcVVDL1pVckI3K2V0anBZTS9EaEZ4TGdPOTdEc3h4dGtaN2Jp?=
 =?utf-8?B?aGpmdFpodzRBWVJtVWpZOERuZUt3SEJkc05PYTVtbVFpMlgyTVROOEJlbkYr?=
 =?utf-8?B?NkIwRndoQVk2djltWlZvMTlza21jTWMzQTlZTWdhOGVpbWx2ZGlSMzgwSHkr?=
 =?utf-8?B?T3laWnV5OUMvUmhiTE5ESGpTV3RCdmVYT2RpaWd6ZWllYU02L0NhdS9nOEh4?=
 =?utf-8?B?dUNNWUxWVlh1V1pvblUydkRZampKL240MXdEbUpXMUc1YW40bGJENTR1NGQ2?=
 =?utf-8?B?S1g2UnBKZ1hhTHR2Y05IdkhSQ1pFVnR4a1V4dXg0dWlPZk9nMmtocGFidVZm?=
 =?utf-8?B?emh4bDMzSHpiUXZ1anZzQXZaREkvOWE1MUlsK1Q2SlNvTS9MWmRpNG81WU16?=
 =?utf-8?B?YXpMaytKU1J6ZTRwTmpPZms0SGs3RnBFaHVYTmpPQjVoV0d5Zmw0NGlVWWxP?=
 =?utf-8?B?cXRJN2FuKzQrUUJJNm4xbFY5SEpaWXpXbi9nd2F4Y2RXQlNMYkFQaTNtYmpR?=
 =?utf-8?B?WW5zL0tqZXZTaC9FeGZMcWRGYkFGRTV6NVVjSnFwNGF1SmFUVFVzZDZoVFFQ?=
 =?utf-8?B?RWZjeTg0dkJiemkxZjIwMm5GMHYxdU9yQVpJUDlORWgvTlpkOStCbm5KTVhi?=
 =?utf-8?B?VmdraFRRR2U4OG5ZRWxKWkpUcWVzWFU0UkcycTl3ZjI2MllVUzdQVENuRVB3?=
 =?utf-8?B?MGpIQi90Zjhid0g3VjZqOHdHWnBNZzVFMVdiUWFXMXRZNzBzS1RLMmc1cCtX?=
 =?utf-8?B?Ty8yU3lEdmRFZjFndG96U3Q5dm5mK3dFWHZsQlVlLzdyc2VrZjhacmNGZmpI?=
 =?utf-8?B?RG5SVEVMc1R5bEdGK0tRTjRPTmdvbzdWTllEU0lWb290R1AwMjBrRllGOGhE?=
 =?utf-8?B?cVh5eDVYOXIxWTcxV0gwTXVCcUFzNFIxcG9RVWE0NXV2N0gwTmU2TE9SQW1k?=
 =?utf-8?B?c0toY2dOODkwdVhOVVpzcXh5OFVEcjRENGgrSGpmNkVZK0Jicjlxc1c4amR6?=
 =?utf-8?B?SklUVEIxUnQ0NDNEZ0NRa1puM2VSNUp0RmhUZG9IZnZtYzUvK2JHWDlJazBF?=
 =?utf-8?B?VjYxVlU3V3JteG1LT2pIQmkxL2JsdFNiYU9xditjM0xEVXJoVzBVUEIxT0J6?=
 =?utf-8?B?YmJoMmE5U25UYmVjOElSbFpzKzd4LzM2Sksxb0NvbEdFc1RTcDVMa1FRUFNl?=
 =?utf-8?B?c010OWdDWVpUcW52aGdjeE9mNllGdlhKYndvclQ5SDduKzBJTFBGdHBFTUhl?=
 =?utf-8?B?eWQ3Um1PWXUrbDRPT3JCVXNwL1lBV3dDNkYvei9lRWVaYjBwaHZsK2ZCaGZW?=
 =?utf-8?B?NzFBMzFVM0tuM2dxaElMdkJjVnpnRjFialhmbDk3WG9DVzFJUE9SaWZKWUIz?=
 =?utf-8?B?TnZjVDRTTi9jb2RSZ09YMHFwNGp6emxGRElNK3pYZ3hjR0p1VXVJUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331a29c1-7b5b-48ea-2478-08da12c30b5f
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 03:03:34.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqg8ZJ2EMvpx+37ZOef9rl8+SzGnampjnfwLwFIJpXuRPVeMY6oCBqjPFyff9L6WZbgQb4wgjUqiHPjTEc8m2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5261
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/3/30 20:56, Leon Romanovsky wrote:
> On Wed, Mar 30, 2022 at 12:26:51PM +0000, Haakon Bugge wrote:
>>
>>
>>> On 30 Mar 2022, at 13:32, Leon Romanovsky <leon@kernel.org> wrote:
>>>
>>> On Wed, Mar 30, 2022 at 11:06:03AM +0000, Haakon Bugge wrote:
>>>>
>>>>
>>>>> On 30 Mar 2022, at 13:02, Leon Romanovsky <leon@kernel.org> wrote:
>>>>>
>>>>> On Mon, Mar 28, 2022 at 09:08:59PM +0800, Guo Zhengkui wrote:
>>>>>> `if (!ret)` can be replaced with `else` for simplification.
>>>>>>
>>>>>> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
>>>>>> ---
>>>>>> drivers/infiniband/hw/irdma/puda.c | 4 ++--
>>>>>> drivers/infiniband/hw/mlx4/mcg.c   | 3 +--
>>>>>> 2 files changed, 3 insertions(+), 4 deletions(-)
>>>>>>
>>>>>
>>>>> Thanks,
>>>>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>>>>
>>>> Fix the unbalanced curly brackets at the same time?
>>>
>>> I think that it is ok to have if () ... else { ... } code.
>>
>>
>> Hmm, doesn't the kernel coding style say:
>>
>> "Do not unnecessarily use braces where a single statement will do."
>>
>> [snip]
>>
>> "This does not apply if only one branch of a conditional statement is a single statement; in the latter case use braces in both branches"
> 
> ok, if it is written in documentation, let's follow it.
> 
> Thanks for pointing that out.

Should I resubmit the patch including unbalanced curly brackets fixing? 
If not, I can submit another patch to fix this problem.

> 
>>
>>
>> Thxs, Håkon
>>
>>
>>>
>>> There is one place that needs an indentation fix, in mlx4, but it is
>>> faster to fix when applying the patch instead of asking to resubmit.
>>>
>>> thanks
>>>
>>>>
>>>>
>>>> Thxs, Håkon
>>

Thanks,

Zhengkui
