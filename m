Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B63681D8E
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jan 2023 22:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjA3V6G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Jan 2023 16:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjA3V6F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Jan 2023 16:58:05 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2100.outbound.protection.outlook.com [40.107.243.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A8F7EE5
        for <linux-rdma@vger.kernel.org>; Mon, 30 Jan 2023 13:58:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZo4QTigq6S0PsZyweq74ObznvZhs8p2ocP2R5FERNgoFJbE/SwJKiWMhxIcpkXGGpv84gxqV/SQ9L79uNVQ8Hwd2lUmPGeQiav41lStBCrrKXG8T76P1yQUzFY6xxUlbTOq2F5BmJWcwjXula9G/kFck3xVKiE18KpBAqXgp0p4GJMEBYOykgJyTopaOwn2fUN7iZkRMTgrO3d3aOAEiMS94JyTIBiXxzvNbQKIHRh3zSJlwjYOBxjE0BKo50MT4roBYd3ZXXmSL30yXNYXP8fEm2qdfJfRPhWtZajBBgaKEHa3oDaVTqmrEUO6Gjhq0WNqQsGn7ff2ZEyFgKiggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSfyWxUtEIlmo0+BVmYXpOjR4Iu7klacW6KV6qSfft8=;
 b=OHGSWgKv+zxz/GXO1iPS4g9qPfGy2eDaHPHOXdjJ27z3yxfx2gRzzEhF8I9uM2x8wJExS42+JCeOo+yjyHhn43+ceWH9MMwtnWwKV5nNCwh/rVKxpPJYF33Z13GDBTmnSoNgH7cKk9GxmVaP1MULTZGtEXwLq4KncQ+v/izCcMlSDB1OkFcHZVzwXpxG0iYG09E2XZ+ayJVBTydfR436tE1ItPlS/2KvLylR3KxQv6MyKe3d9IshHhTsR2QMLf4patt+RibDkjp411uZ3yJDw5+bYRcYsphHfHxIuufS/wG0dpa8oLGiIVl4u7p5Gt2M8UPw3HSQ4Mcy+4XPec4lBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSfyWxUtEIlmo0+BVmYXpOjR4Iu7klacW6KV6qSfft8=;
 b=a9PTVdmj6WaPefSXaV225ACrz2JjHRodUH4FWNJ0GyOYaHJnjlIBzyLZHnSHQfYfxqIxBJ6rpEaJqzVtjsaTXTdbelopg2g1uccZm3xK5/2DqUbq05kvqJ3dnhisQ0PZ37DTpkkeMJdPW8xa9dQGveginBlNI5zMrlprE0C+Ka5MXk5JhkPZPw8VrklBXLKDihC9s4Q43XNHodMVvxPaIev0UcI2CldafCCLPUyRSuyBGZrCy0OqdYbf4H7luy5OvtBOiOXHLfr/pn5LTf3/KfSrzEIkm1tdkU66PJxqPLFnRnGfNSLgb926AOqhvnj4QPzQh2QvJ2sq0IJwwOIivg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 SN7PR01MB8017.prod.exchangelabs.com (2603:10b6:806:345::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.33; Mon, 30 Jan 2023 21:57:59 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 21:57:59 +0000
Message-ID: <6e74d22f-a583-0cf5-fe06-ac641f976f0e@cornelisnetworks.com>
Date:   Mon, 30 Jan 2023 16:57:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Content-Language: en-US
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <Y718/h2uSTYq5PTa@nvidia.com>
 <3cf880fa-3374-541f-1996-d30d635db594@cornelisnetworks.com>
 <bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com>
 <Y8Pnn8NokWNsKQO/@unreal>
 <472565cb-e99d-95a6-4d20-6a34f77c8cf1@cornelisnetworks.com>
 <Y8T5602bNhscGixb@unreal>
 <a1efafe0-1c8e-60ae-cc77-b3592ea5b989@cornelisnetworks.com>
 <Y8rK16KNpj0lzQ2a@unreal> <Y8rSiD5s+ZFV666t@nvidia.com>
 <a830a1f2-0042-4fc6-7416-da8a8d2d1fe6@cornelisnetworks.com>
 <Y8z+ZH69DRxw+b6c@unreal>
 <6a495007-0c84-3c7b-e3bb-9eadb1b92f54@cornelisnetworks.com>
In-Reply-To: <6a495007-0c84-3c7b-e3bb-9eadb1b92f54@cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0384.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::29) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|SN7PR01MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ca4af8-23e8-4162-fcc7-08db030d0cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6VpckPaNfXz9senp75lJo+n96+1+d8wn6MkgiMh/2veAtdaaSsALW6xpc7Fc1cMgi79uG/1Uyy6uuXtfWWKlconeF1439MHG23ySttVIHsqz9udb88k4QDzoCNxzzLWWeiN0zdAScliqn1w6M/Ug1vVPT7GZ7jATOvEY2+sjHmU2o7qv1K0WIH30r/pLnr2pAVsruIfNexowgdrDn0oF6deVM5RXzb1U/ZvKYUbHjo4QZaL/i3vh6aY7oUPu75V6PQW/HHFDLxiVOt4FAbEeOVZ46IniF7+9G9lJP4aXBs1V2xsU6eNci4xvASwDQYk5bkDmtirIRsYNDLtldKpTh4APyVSNgqWUyWWHdoZm3EWcIk3y8/WA7MSFDLUGrHyjlRWv8IOf6MOEe7+rLJlTmvBciAnZqJWOZZ28nHy59Ln8uCGskPbDOUtLnMGtNfQ4uBVsLXA+GfeTjZ3pdGqzkRMT5lMM37/mAs/pjOJZsrUiL/QDKcm5TzCyvfOq0bHAP2mKFFjqhtVJ4tU7PGNEqrrSoHLAelVsKh1RoAsNlj6R6tVS67iK+rPtTKGeiPcH7F+F8sYTo6UELURRVT4VT8y14cZ4d81PuohH12VYdeA8RXp0L6fe2rOlc6vtPZkdU8u4EVC+tJDGw0boWbNgImI5yeu33DeiX+8MRRdfQbUGdWrB6Gz6ZFYYykT4RDVYv3/n+7jYFKTXfAfyZWBBPDoK7zG7JvOeS0nO3VWqDdU8tKgq6TVfCgnvieQcN0Lglzsh02U+BtQsG/KO+ZhQ90FTF/gBXNgsEX5zmT75GqwjnbVYt/407kjwKku6YnpH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(396003)(136003)(39840400004)(451199018)(66946007)(316002)(66556008)(8676002)(66476007)(6916009)(8936002)(4326008)(66899018)(5660300002)(54906003)(31686004)(44832011)(2906002)(41300700001)(52116002)(6486002)(966005)(478600001)(6506007)(6666004)(53546011)(6512007)(26005)(186003)(36756003)(2616005)(38350700002)(86362001)(38100700002)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTdFendRUlJjVzExbXpnYjYvdEJyeGFNNXF1c29QZkNOZWZDOHc2RTJTNUx0?=
 =?utf-8?B?K1J6Ky9CTUZjOWdqZ051Wm81ZTlmM0JJLzFiMWVsQUdySms5eEdxMzhueHFT?=
 =?utf-8?B?bzdxeEJncStUSDRSVVNGSG9UbEFTTEE1c2NxU1lDVlcvZlBZVURCSDE0cFk5?=
 =?utf-8?B?ZzJoRDhCVW5BN0tqYXhEaXpEaHBIdnNVVC8zZEY0R1VlUGJlSXZiYUZHMnpy?=
 =?utf-8?B?Sk9zdTlsTVhjVWswL3A3NXc5NDVCTGo1OWZNcE1LSDVrYWxEUzNpY3VhVUJD?=
 =?utf-8?B?WDJjZDdTY0pwUS8yclhuQkg1TzIxLzg2Q2NkV3JhZVNWTzJoazhGZ21lM2hs?=
 =?utf-8?B?L3F6aFdQL0tseUlLc0p5eWd6ZVhzQzg2aHRTZHlCM1NOR2N4K3dMY3BuenVT?=
 =?utf-8?B?VGtLVGllUVFzSXh2R0tqTWRVMlBEdmhzNFpIdkMySXVBSitta2k3dGNtOUpH?=
 =?utf-8?B?SGxRMWl2Y1hxazltTGh4QlZtZzZSNzhicjhYd2FxbHpERndTQTVsK1JmaWRD?=
 =?utf-8?B?NlJyQXVzYTN3di9ISm1SSE9UNXZXRGhoRFRCV0R3RVJJc21pZFlqTGdQQjBC?=
 =?utf-8?B?VXZGVkNYK2R4c0tPa3NyYlpwaGovSFdZNWpaNEdVUG5vRmZUTVdtd1dtREdK?=
 =?utf-8?B?MU9DRVBOWXRIZ3NKSlI2K2F3VzN5bU1LWHhsY3FDR0NUd0l2TXpnNWUzLy9i?=
 =?utf-8?B?TlNabFlJQnNNY0w4bTF6OER3L1RxV0pLTENmR3hKejM0aGFsNWZ5OXQ2TEE3?=
 =?utf-8?B?OE1RQU1hMWYzdGQ3K3JocnZFdGdyTnUrcDY0akplWnlSSWlQZEZzSSs0YTRZ?=
 =?utf-8?B?cVl0SWpZVURac1JoK1RERU1qV1NTdGE0Sld3VE5RZlU5RzlGV1JvY1NNZTNh?=
 =?utf-8?B?alQ5MFdWalBQNjBDOGFHODQ2bWZFanU2TWovNjNRb0xjTnZBMUhHZE5ZQW0y?=
 =?utf-8?B?Z3FNaytzY0lUL25IOE80UzBKZ3NyOEdHdWM2aVVtc2llczltUUZRZ1ZoRS9z?=
 =?utf-8?B?Y01uTkY3L0FHa3l3SnNlYzg5L3UzYWt3RHoyTUFmRmljY283MVhjMk0veWdT?=
 =?utf-8?B?YWg5MWR3VmtXYk1ZeCs3ZWxJOEtTbnh2YWdhRFNZbW4rbmlsOElEREpVT1Vr?=
 =?utf-8?B?VmUzSFpGdC8rZHhCbHJsdDRFcEVaNHZmUnR1ZFN0alJNSU1BUkJLMTIyVnk4?=
 =?utf-8?B?MDYwZ1k5TXNEWEtzZHN0blhyaEZ1SUNLeGF5VXM3c1Q0VzBMeXd0UGZYejdJ?=
 =?utf-8?B?SkpuVFhmNkkvS2FUbzYvWkc3ci9OelM0VFVhb3kzSFA5T2tXQ0N3bzVCZmJ4?=
 =?utf-8?B?Q0YxRkY0c0FST0pkSHMrc2VtRFpjNWNsQ205S3dNUWFYdTRXclBIVHNHb0JM?=
 =?utf-8?B?TzJLdkMzK01mWksrQkVmbkF0NHowWGFxTHp5VGxDeHJnUi83cjNhRE5rQlNn?=
 =?utf-8?B?clRaM0dleDdKWDNaNnFLS2hQRjk4dlRna2ZXekVPb0s1UUU3NFdtZ1V6ODRC?=
 =?utf-8?B?aFZEYm43QWUwSFIwUU0rSHJrTzdncncxM2ZmcXd2TklCcUVsSFNiZ1liOEgv?=
 =?utf-8?B?NVFaMFBPRFdBOUI2MnJ3OWppRWloclNFVE42WmZXNmxUVVRoUHF1V1d5dHJm?=
 =?utf-8?B?OGlCWG5LQTMyRC84T0l3b1hvYVhhakdLd05ZSE0zVjZ0czVDYkhJNC9USXR1?=
 =?utf-8?B?TTJvY3IvOEtYTXNRQUVHek9oZlZXU2hEVFNONmd0L3djY3B2YytmUVJLQWVR?=
 =?utf-8?B?ZkZ3cnFFN3AxdXY1aU1JeDNNMVNiWFFUZWNCVm9xNEt5T0FxSDloUnZwdVE2?=
 =?utf-8?B?bUtldnplc1hkZGI5Qys2eEdNTjk4a1pUTW9UOVpGMm42dzNyaHdJaVpEUVcz?=
 =?utf-8?B?KzRqQk9ucHpjVFFHVUpDVnczeFlIM1pOT0RvRWtlSWkvNDZsSHFYYU1PRHFR?=
 =?utf-8?B?WFlCSE44bDJKVEZaOHdDT21maE9sRUJWdEY1L0UxZEZWWFNxeUpGZThqU3lY?=
 =?utf-8?B?TU9qcCtEQyttQ2lGYkxyOTd6dVhlOUE0SWRoVEZEWUovV3ltUVFnbFhlcWdH?=
 =?utf-8?B?dmtYOEdyMzgxVWcwUDh1TzkrN3drTmJnekVXOFJVK01DNHRPdlZnUm5hUXky?=
 =?utf-8?B?Uk1KRFBhWXpvd0dJcXFxd01aRFlTUXhwTTZZeloybDR1WHJGcTlVQVhPamNr?=
 =?utf-8?Q?+1z//1jkU9lc/es0dM5QOG4=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ca4af8-23e8-4162-fcc7-08db030d0cb4
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 21:57:58.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkso7pO9fhW6cswnpVwTGNv3TaNIlnxQq/EruInut6lHaIYgh4VqfhlJPLvrwYe55h63p4Urro00eEfAPa4IMp3+Sn/AyTo876/Saf/cQvIkcplwXfRZ2idyNPAU06Mz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8017
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/23/23 11:49 AM, Dennis Dalessandro wrote:
> On 1/22/23 4:14 AM, Leon Romanovsky wrote:
>> On Fri, Jan 20, 2023 at 12:50:35PM -0500, Dennis Dalessandro wrote:
>>> On 1/20/23 12:42 PM, Jason Gunthorpe wrote:
>>>> On Fri, Jan 20, 2023 at 07:09:43PM +0200, Leon Romanovsky wrote:
>>>>
>>>>> Backmerge will cause to the situation where features are brought to -rc.
>>>>> The cherry-pick will be:
>>>>> 1. Revert [PATCH for-next 2/7] IB/hfi1: Assign npages earlier] from -next
>>>>> 2. Apply [PATCH for-next 2/7] IB/hfi1: Assign npages earlier] to -rc
>>>>
>>>> You don't need to revert, we just need to merge a RC release to -next
>>>> and deal with the conflict, if any.
>>>
>>> Thanks this sounds like a good way to go.
>>
>> You talked about broken -rc, but here wants to fix -next.
>> https://lore.kernel.org/all/bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com/
>> https://lore.kernel.org/all/Y8T5602bNhscGixb@unreal/
> 
> 
>>>> As a side effect of this, can we pull patch 2/7 from this series into the RC?
>>>
>>> No, everything is in for-rc/for-next now.
>>
>> Without that patch there will be a regression in 6.2.
> 
> Sorry it's not clear. Want to move or include patch to keep -rc from being
> broken. Your #2 above. I'm not concerned about #1 b/c it will fix itself in time
> after merging with 6.2-rc.

I didn't see this make it out yet. Can this still make it in for -rc? Based on
Jason's reply [1] sounds like it will just work itself out in for-next.

[1] https://lore.kernel.org/linux-rdma/Y8rSiD5s+ZFV666t@nvidia.com/

-Denny
