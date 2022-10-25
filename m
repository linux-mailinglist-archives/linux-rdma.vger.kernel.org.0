Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB63D60D2CA
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 19:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJYRwE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 13:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiJYRwC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 13:52:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74F186F9C
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 10:52:00 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PHNJgF022926;
        Tue, 25 Oct 2022 10:51:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=IpPI8hA+AQmnP7mldu1W64zrUOnb7degBiG89NOrw3w=;
 b=Z5zNVxIsTylSxN3M9HAaTYzEeVxC6O2M13pze2KPF77GmQHYEm4TWvlBT/refmbynb96
 VMa0tZmZkcbiq1lrOTTAchnd1ftcrbun6f1RG8igQFsWDThhcwlApVKdwYJm4lwAGhXM
 TOGp/ppphVvljf0bwtyuMgxnpZUU4JWeJWCbtbOIHZNVY5dpwrYjYs8lo3R09uQIFmNN
 ULjJabXcBx3fRld9sI1Lh4ch01GV/x4pX27UgQ+2hRuuBcDbWQt/PeT8K6XeZMWMRpG/
 dHgoe5MRKi9Ec5B7vKUZzDQvKwUScvWSJekaIiES6nD95O0hb759nTuQXfGXl4YRepSM 7A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kee8cmgbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 10:51:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcqoacSvWOI++pN8zUqZqkIqu1gZiqG54F5dVeOehQGyZ9e0svfE48jbde+BY/Euh+kElDd14EqAmDssJO18ne91zzj68OZVyCoT5CSP6CyAtOYui8ds1UDe9UwV4QekGFOSkKsIDdp19eSPVeAQOQU/pcZvB+FX6lCercKbnUhDsEZhKjsAImmAjuL52YqfpKrHqym+SctRFT2cPXfOX2Kk5SNKKFjrkayjt7/KM73TRTLJBszZt907qpWiLqJR5IjPoNJ4OU9VfvSIfbDMMDdWYJ+ZCTeodxECUwScVZBXzyKyku+J+DLa5B5Tqr+/o5KopgA28X3Foqsdcsa12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpPI8hA+AQmnP7mldu1W64zrUOnb7degBiG89NOrw3w=;
 b=A42dQwr7illJE5WTgkshVYoHqMl4jB+aDHiyyqPPHsW4BLYDYvE/h1K+c7AjNlzzUcf/GOOnn5TnwQqfh/TbZc34FyyEYeYm23dIE09rIk3Q5lx5RNUwm/rs70PBvHsjNRVn/XoBhzaZBEEqTBgxK9n+dJx1trheRVs//CzFM+yk9ZAuOOmCvbUBaRg9ziwu1voLgqqK7IT7ULH2dBbHvVhAoDRPh7X6UAqgzovhwWOf4muOPrQMcz/lR/lTy1sIakgBupE+xWjQY2y8m3OKBW54LeWNS6iwIIilmAN6BchLWulGjnx8nMeePc1qiLHrbI0K2kD/QzJ0fwUVlArRqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4703.namprd15.prod.outlook.com (2603:10b6:510:8d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 17:51:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 17:51:54 +0000
Message-ID: <d2709848-3026-8104-adf2-bd28a74cc639@meta.com>
Date:   Tue, 25 Oct 2022 10:51:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH] RDMA/core: Remove rcu attr for
 uverbs_api_ioctl_method.handler
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org
References: <20221025152420.198036-1-yhs@fb.com> <Y1gIAnr5jFRn74c8@nvidia.com>
 <20221025162909.GG5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1gPOUIaKOVmK0Ok@nvidia.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y1gPOUIaKOVmK0Ok@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e25899c-0f83-4409-5c68-08dab6b19a69
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqN6RrKGBnb41EvJyL071Yx6ery1PxOk8PKIdLcHuyzZIvVNEMxHc/i/Tpmx5ITrSdvCLXtwLlvMulIV/eRXmt5Dw1xZR0DDhvPQR7bgKqC3pabDRh9+zhF9RJh2HrUAoEFHKeJH2h7l+z3iDqgAeejp6KSDdRZ4MqL6jbYiHZfl/AxeLMT8g6jCMaVK9kORRbULm5J7d36g9ZWf3Gr+au61N/Jb6Y9yPgL1pDqWk8wD1TLL1MSflhY4upsJC/3JL7Vg3mlPYZrJxDoQCj9uvJ97CX+9a67hoMfDqn0/MFaea0u9jZVOgTno2tDmn7gv6EOtmLo/Evi9yis6U4jWjTykr5B/m65uxgVjlfxyOPFg5KhdgSeZ1/xkNzrxX3FY54txlc+q3YLwVj0TuwOMe+Fl/+jmbHAuiLLwbFHaRSNcJousPubqS+aPb3TCHbo+9ytT4rMePcFIv3YGApqQk5KChJvu9sW+1OX2x+2eGkch2lNYJrrLjpf5/pI0U5AlStESSJ85M1Sy7J4Z0HFC7nnetehZKFUgTHSyO6FehADWXJhMJdaFJNW2OfO4WXLFI6blO0ju3HK1Hx823rVf0I1PuPYqkeoCiL0N7wFeT66Xui1onEzda2zP3jR1V5/HjeEguQHnU41hFOoeRXCdMznc/Cp9dyQULuiI8jt+4OluVapB25FLN9wn7iXktW7hRfWopXKiYBVSJiLveJNFzVhQB4y1GsCYZOgNZ6RqkTXrj+TTq9BX5VVA5zdtn5F3P7o5GFcA2nxTVk4MVtpbVni93qCMaKhKuwq1ZYxR5cU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199015)(38100700002)(86362001)(31696002)(110136005)(54906003)(316002)(2906002)(6486002)(8676002)(5660300002)(8936002)(66556008)(66476007)(4326008)(41300700001)(66946007)(186003)(2616005)(6666004)(478600001)(6506007)(6512007)(53546011)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWNMNjFjWTdSSmlyT0Y3dHFINGM5ZndQYTdHTG5nRWg1ejA0UitWWWdPR25G?=
 =?utf-8?B?L0lDNWRDYlQ1QTNKVGY2T3J3WjJId1AreUJYZ3NYSUVyQ0F2U2VRdy83dkdQ?=
 =?utf-8?B?THJCcC83TzUyUVF0cmV4aGE0bFZOUTBxK1lBSDZEWVg4by9qMExKajZ0V1VY?=
 =?utf-8?B?b2l1MkNvb0hrSjFkV012RmtOMkJ6SUFaazV0eXhsRmorTUxnd0R0QmJhUkV1?=
 =?utf-8?B?Wnp1RStvajR3YW1Hb1dvUzlER29TTVYzWW9vMmxybVhkVHc3eVE3b3d2R3hR?=
 =?utf-8?B?am1kS1lDNHF3YlViYW5VL1k5NnNWQ2tOSkpLNXEyOTQ3ZHhOTUFwYnpVbnVW?=
 =?utf-8?B?SENHVEVwYUU1REJHZXExcnZnakNSQVBUaG5Zb2tIVFVqSE91NnhTdzZTVURv?=
 =?utf-8?B?MlJGTzFnK1IzSUpBMG9YcXlOcG9hSFdTbUJ0dE1La3RvVUorbVMwTDR1blNF?=
 =?utf-8?B?SDhRR1M5OGxxOE1UTGRFZGRMcGgwWDV0K1d1bzFWMjkzdCtwREg1VGx0d2Jz?=
 =?utf-8?B?S2JRRWVDK1R2RzN4aUh2aVgrVmNwaG9RUjFYdkNnYTdNL1NJdVFtT1N0aWlR?=
 =?utf-8?B?REMrcWxCSmFpdVF2TFY5ZkJiODVZQjhnaVA2eGl6VjJHY2o3ZHhnT0F3ODFO?=
 =?utf-8?B?TCt6YXlUOExCRkNLNVRFQ1QzNTFxbkpkcFRjNE5EOHRQNzAxSFg5OVlNNFJD?=
 =?utf-8?B?ekc4S0VyRlFZSHJ2U2lybFl0OFh0Mng0S2tjNGxsa2RKRGNWSzNiY2pLd2NO?=
 =?utf-8?B?MS9pNiszZGwxbmRrVVlRWXVtejNubjhkSWVnMTk5Mm1KREFvUjl2b0x3MzZi?=
 =?utf-8?B?akxKK09UNU00Tmk2VGNvWFNaRUdWbHM3aVJqdC9GQ20vUFNBQzVWeEpJR2Fw?=
 =?utf-8?B?RHk2aU84WXBqVDY4WUhMbW96OE93S0dSOU15OFRxRHlnUGxQK1RRR1Rhc083?=
 =?utf-8?B?d0g4QkE2VFF1Y2FhREVmajZwUGJ2TXVldldVUVJobG5LOCt0emlOV3E2QW9D?=
 =?utf-8?B?dmEybnNOMUM0dGJ2akZaUjRhY2RWdTJCY1lkK2pwQ0hGTXhEUExGbmtxOGtE?=
 =?utf-8?B?U2pjeXVTMDJPU1JlZDhIMWlQamhPQk83YnJUcHQ2OHBGL1dVR3ZZU2xXbUtF?=
 =?utf-8?B?M0ZYUXhPajAzaG9EQVcxbXM3L0k1UnpFK3I5WVZwY1l6WllFRTYraVV3VTFn?=
 =?utf-8?B?U3RZWXBOUUdRd2FSa3NLck02UGFuMzFuRFdjN2I1MUI4MlVRNm5NckRGUFMv?=
 =?utf-8?B?Q2xjM0pwR3RkQ1MrUXhKZngzWFpZSXZSTjNxMzRld3g4TjZXdnNhRmd5S2xk?=
 =?utf-8?B?bDNud3BvQ3kreHY5c005bTdwN0Z1U2V1OW5USjNBOTF3M1VuVmt6OW1OaXo4?=
 =?utf-8?B?Sk5pZ0RHUnB1eGpFbEFmMkxkSnpRMUI1OXQrVm5rcVZwYy9FWU9RUDFXbmhL?=
 =?utf-8?B?MysvTEgxbVdxcno2VmVVNXJ0dWNSVU8vSmhvTVRZVHpGbk1EcDRTbVgvUXVL?=
 =?utf-8?B?Y2UzSXloU255OHRGTlB0ejg1VnB4Y2cvc0gxYjBmSFhzeWJwRzFCQUZhSU1z?=
 =?utf-8?B?NmNEZE42Y2ZJWkpWWHFYVzZGREFzZlFhOWtLaUN3SkN6b1VrWWVqaTAwSXpv?=
 =?utf-8?B?R1RpZHVCVWJJSDRhUGZZcy8ySFlHb3hLdGhLdHBvenpaRFZZZ3lLVURIaCt2?=
 =?utf-8?B?cTI1RUtSbkkxK200QWs0ZTZkZ3pPVXBUUlgvZ2tjV05meVNjV01vVnlIQThv?=
 =?utf-8?B?ZldRQ1Y2UzZJS2VKeHJPSnZ3UXVGTWVBdXBWb0RxTThxa1llUDF3RlVZdXc4?=
 =?utf-8?B?Tk5saTVlM2ZReHJjYTg2dE1YcWozTkVnZVM3dFJNbllzdG9leGliYzdPTTc0?=
 =?utf-8?B?bjFtZ2MyY1lIaXIyZ3BxMnZlYkR0cUxaSzRpWjd2cS9XUzhuL09WemI0SkVQ?=
 =?utf-8?B?eCswazNjN0hvT3V3ZllxNlZXKzVzTWlvVEZQREVXREpIbko2TnMxUHRTWWpG?=
 =?utf-8?B?RzJPV25OVHZqaW5wZS9uNFBwMUE5TWRnNjZtNjRMVmRPOXdOeHZNUlVVQnBa?=
 =?utf-8?B?THpONi9hR3JEM0owWUlSM0VrUUkweis0ZXFUWE5md2k5Y0xWeDA2ekJsZHpJ?=
 =?utf-8?B?YmJMN3prM2s4ZGp0MlYrZ3d5elRhSE9YaGNya1dCNXZmR0cvOEhyZDdoWFls?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e25899c-0f83-4409-5c68-08dab6b19a69
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 17:51:54.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Y7nh0Am792IHvC4AHqUhF4EWPjFJKJ8/w33/LhdotNtwJwXEpi9iBNEqmhORETB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4703
X-Proofpoint-ORIG-GUID: X3nCXA1gHt7SYzm3YzJ_OSDfqQbyA7N7
X-Proofpoint-GUID: X3nCXA1gHt7SYzm3YzJ_OSDfqQbyA7N7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_11,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/25/22 9:30 AM, Jason Gunthorpe wrote:
> On Tue, Oct 25, 2022 at 09:29:09AM -0700, Paul E. McKenney wrote:
>> On Tue, Oct 25, 2022 at 01:00:02PM -0300, Jason Gunthorpe wrote:
>>> On Tue, Oct 25, 2022 at 08:24:20AM -0700, Yonghong Song wrote:
>>>> The current uverbs_api_ioctl_method definition:
>>>>    struct uverbs_api_ioctl_method {
>>>>          int(__rcu *handler)(struct uverbs_attr_bundle *attrs);
>>>>          DECLARE_BITMAP(attr_mandatory, UVERBS_API_ATTR_BKEY_LEN);
>>>>          ...
>>>>    };
>>>> The struct member 'handler' is marked with __rcu. But unless
>>>> the function body pointed by 'handler' is changing (e.g., jited)
>>>> during runtime, there is no need with __rcu.
>>>
>>> Huh? This is a sparse marker, it says that the pointer must always be
>>> loaded with rcu_dereference
>>>
>>> It has nothing to do with JIT, this patch is not correct
>>
>> OK, I will bite...
>>
>> This is a pointer to a function.  Given that this function's code is
>> generated at compile time, what sequence of changes is rcu_dereference()
>> protecting against?
> 
> Module unload. We set the value to NULL and then synchronize_rcu
> before unloading the code it points at.

Okay. Thanks for explanation. I forgot the module unload case.
I will look at compiler side then.

> 
> Jason
