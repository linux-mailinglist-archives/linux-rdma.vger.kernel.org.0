Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4EE68331C
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Jan 2023 17:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjAaQ5d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Jan 2023 11:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjAaQ5b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Jan 2023 11:57:31 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2124.outbound.protection.outlook.com [40.107.223.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA8723C69
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 08:57:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAEP3zSRPesWrWkZMKZBXIanRX29OfM43anxsOU/GhmVNFIlr87LsyoudkNKSHqmiLuM/tzKHh1stdLMA2MO+j3ZZOM4+NoMESx5AzRrhFl8fU0zeMIrmgMRqvOrVLWmgEEoDAQg3SPU9QbjiqLVskMhe564Bi0AvLk0FqDyR5Y5P1N7h1fcxnATaa9HBVkAP/vR6KHSxNq6cxFJXRDdd7GUkOclSBr1QWZ0bukV++BG4jQsM1FyDV/+BbKZa3SCrxnK3oG2ssBpoB2t+NEcCx/miGKnLo0NdsCIFeg0JHGbpUdCWeXb31EfE90Q/aTsU+V3UzzrjXxvcZ86Gsj+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WE+bRpAxP5Zs2kuajJzOxeQR5cJuBXU2anrinm/GLA=;
 b=jg6rUhkRWhqoU7XVhe97JvXrYyo8FyE5Ivq/7UFapigWOnTJJqDE4ximLi9IFuL0XDQ92WE39c8v1VOgYTHm16cIhFsmWgKa2TyMdRyBLBKcuMXucYzWD5xM2KDfdNiyC2vY5jhWogTIwpBv65FV9q6djEou3zmMTTvvjGlaxOkX3QHoldlBGm3Oz0G0kDIIROL5mDOoHSvVddMFlUf/19YA7owD8CTwMFREgjv0GQH0Lw5AZirM0+ET78j+9e6Y9MT6eU+zvhM/C8Cg2alZKmEIXqbk98EYAT50+PM5lsPAWuH/DlEEp03Uylhzpi5qbRR7q61uiaANHnF1KM143g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WE+bRpAxP5Zs2kuajJzOxeQR5cJuBXU2anrinm/GLA=;
 b=Zhh2QrHXGJ2wtxdTTzjzQVE5GYMvYnL/ZkUIb2pHcL2uEzd162NcBwdCDs/SF2D5le1eUP695f3mjfMZkdMa5Znw0vP4AUfba1dHERWdHkvvm13nS/SQQqob3A1EY4MZzuMaj7aeDZ40jh/8yRZ2PtAhLGP0HkYuQjR7Kp1atZxEAGL5RamoxFt5UIqMNTFoRoJcZ2b4a5ig60OuaGlWwS5Cso/8uliTiwyco7w8FfxlTFwGhIfD/q5lmwZUmASVJoj2sdvmSTSuK3f+fyD0qEU/mpTvK5q2k5/Uer0tGizFY+j3C4YktkFjopzY6dX84yx1a9XyzGsdtNM9Vmz+pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 SA0PR01MB6507.prod.exchangelabs.com (2603:10b6:806:e7::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.38; Tue, 31 Jan 2023 16:57:26 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 16:57:26 +0000
Message-ID: <cc1c9687-9537-b514-29e0-4fc764d93b09@cornelisnetworks.com>
Date:   Tue, 31 Jan 2023 11:57:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <Y8Pnn8NokWNsKQO/@unreal>
 <472565cb-e99d-95a6-4d20-6a34f77c8cf1@cornelisnetworks.com>
 <Y8T5602bNhscGixb@unreal>
 <a1efafe0-1c8e-60ae-cc77-b3592ea5b989@cornelisnetworks.com>
 <Y8rK16KNpj0lzQ2a@unreal> <Y8rSiD5s+ZFV666t@nvidia.com>
 <a830a1f2-0042-4fc6-7416-da8a8d2d1fe6@cornelisnetworks.com>
 <Y8z+ZH69DRxw+b6c@unreal>
 <6a495007-0c84-3c7b-e3bb-9eadb1b92f54@cornelisnetworks.com>
 <6e74d22f-a583-0cf5-fe06-ac641f976f0e@cornelisnetworks.com>
 <Y9ksq0qce6iopG83@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Y9ksq0qce6iopG83@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:91::17) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|SA0PR01MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e146c60-0f99-4c3f-28b5-08db03ac3aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpw4Z/pG15yUSbwAID74QCwcB0wXo2HcqdXXDIXJ3X+/ff5pwEWhbISKITgU/2m1/fSCQU3tUigwFxc6kDJ3ONzNE8u+1LcFA/dfon8rToAwhjpL1S/eQZHcoHvJUdaElmVYDd8m1scigmHYIYrNJzEhyEiEuLD13KACYQQ88mxvrBZCzePpCQicAGahp0X9+v+QkQW5e/SiJYulCxFye+W2z8RK6k1FHkRLA349kH3hScqujUFgM3tVm8KbwJg79o86vY5FVj8sLpYVTdFpmRzm9WNzGaBNBvcPvwMreOxc5kS57tRi142U8UTk61XqLueBTlCThlm5G0/xI3YLs+XBRAjmz+lfrNdJjjkq58OvrV4wgTOXMXRU5ov6VFjMJzbC11VLxr8xloodp/3+Ob8f2NCCy1jyTWyrVKEJSbyc67g7uhHi5RK+IIbdxohH91Vk3qpxlIyq+u0V+ZIZyEZSKkdTlZgqUGQnbZweVM2iy6Vd2fAjyxDq6er+fcH5S/5YbpxzqmoiohhdaDfeBxNqsT4aiOqFOHJTsouc574vTS9G8WN0/V+dbUu9KX1AhQ7CtzwXa8QnKOGDJ3tP3xXEVpjDhnTzacPGpoRMx9rlWH4e0fFeDjXgsD4FPP8Gt0iOjrGKdCWl1mlLW7yRaiD2JsNARE8KhkrjKORXkLZl0cKczxAb0oEvVGtZvZk83UkBQRBGgyaY1lX9o/RVUpC9Zuq244MeibiAz8eufccDkyrERBLtNO9VE/eB1j+NDOs5g5a8RnTZyldA2gSZxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(451199018)(31696002)(86362001)(36756003)(83380400001)(6666004)(478600001)(54906003)(316002)(966005)(52116002)(6506007)(26005)(6512007)(2616005)(53546011)(186003)(38100700002)(8936002)(5660300002)(38350700002)(66556008)(44832011)(4326008)(66946007)(6916009)(66476007)(4744005)(8676002)(41300700001)(6486002)(2906002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkllYzdoVXA1Q0pKMnZzTC90VDl4MXpJbXU2ZSs5VW5YTnlHbDRITXFiMGR1?=
 =?utf-8?B?U3lpRFdNOEdSZFowVktIVVRvMlJUWnVKU0VROUVkZnZxc0IwSm5HWEVNQXNW?=
 =?utf-8?B?Uit6d0ZHMm1KTGhodkRKU2hWSDhmMUdUK3Z0eE55S3R3UXB4U24rMnpVeHZG?=
 =?utf-8?B?SmhJMCtDMTZzZ0hhUk1VaEdnZUhNZDB0NmxMYUQ0aDQ2dkVHb1dxRzRLbHln?=
 =?utf-8?B?ajZzb29USlJUTlV5QWhHUzJiUGg2REVSTTFhc0VLV21Id1g5TGNMbk9MeE4w?=
 =?utf-8?B?K2hxWmtKbGQrTUhpbHRvbHNOWGlJZEFLNHFQNTl4WU80L28xS29lYzBVRlVy?=
 =?utf-8?B?bzM0aHpMZUxiT3BMbGV6LzVzQ2RSUVUrVXNnTWJXdmxpSXpMbHFuejcxMFR5?=
 =?utf-8?B?YWkrbWFjYVdCa2FtSitrcE1uaGhhV3piWTdsRDNpRzdmSVR6cWpwRVBXYnZD?=
 =?utf-8?B?Z2VRM2NvbklGTWRlQmpvcEpaNFpDb3ptQ2VuQ2JFTFJkOWVWQnBtUzNvVzQ4?=
 =?utf-8?B?ZUFpUUk5Q3ByRHAwWjQ3SEVHZWxvZlhoWnFnM0tiRndkWWhrcjZIaUY0UXRa?=
 =?utf-8?B?QjQ5R2gwamFmeE1jamd1VmVvN2JpbHczWTh6QkI5M0luQXQ0UW1LNE9iSk5k?=
 =?utf-8?B?TVRHZnFjVG82cFlYZ2NsQlpMamZqSVBFVGVjTGw2THZCNTgrcTJ1bU84NmNO?=
 =?utf-8?B?bFhVYm94WUkyU0N3ZWxrUWdnSVRiSTM4bmNtRUFNSDVuNE5IeFJRcUg2L3gz?=
 =?utf-8?B?Ujg0UldBc0RVbTA4WEw2OWM5bjA0eHpvT2FDQWthNGJFdGJxK2MzOHd2MFht?=
 =?utf-8?B?cWxWUERYN0pmRFVKcWFXd0dXUVFDL0lyYUdIempySmU2UWNmZkk4YlZzM3BL?=
 =?utf-8?B?QXkyVkdiMGRlUHozalJxSU5ZR0x4bE1CMyt0RzlYaVJocjJsb2FkS2JpakFi?=
 =?utf-8?B?aVZsWCtZOG1vbEVSUzJCdXJiZHJrNmpiRlM1a1ZacitLemxqaEhuOTlwMjVx?=
 =?utf-8?B?eG9hWE5qM1Zyd09hdjJpaFp1N2sxbEZDejNHMlhHcUZRWklOK3ZxQit6ZzZS?=
 =?utf-8?B?WVlQYjR5MHYzY20wajdFVEpvUCtmeHUwMUdlU0FpdGR6N1UvSTJ1elZiZWE3?=
 =?utf-8?B?amx2aWEyVXVzdlprdGxub0IzaGpxbnErWDAxamo5clowUjhUVHRKZWRnTmRC?=
 =?utf-8?B?TDF6OHJSQ0NKR2E1QnFoTlViYU12ZmlxSFMzYzV6TURTbS9vbmFnY0JHMWdY?=
 =?utf-8?B?Y2ozRGNweDdZU0lkRHpVOGVjZmhic29qUFFualN4QlptcG83Ykp1c3NYVU4x?=
 =?utf-8?B?cSt3SHpXWHEyMlh6YkFpd0xBcytCV1VWeFVpRVpwZHNZR0FNKzJRWk9oZ1Vp?=
 =?utf-8?B?bTBRbXBqT3pyaXN3bW8wYytaOEhlaWZ5bFMzT0pTM3BRUzh2Y3BhS3BKSW0w?=
 =?utf-8?B?cnFCNHloR2ZZOFVub2RVR3RpVnp3TlFTaTBqWU1VWWNGdlh4b3E0UU4rdVpt?=
 =?utf-8?B?NkRIY1B4Nm5LODVBeUk4QkI1b1R5REVHenhYU0pOcXpOMkx1K3FKS1grcVZQ?=
 =?utf-8?B?VmVoUGR2d1pNNEhiZDlKdGNlc2FsRWMwTk1zb0llaTB2L3IvNmhwQmJyQU43?=
 =?utf-8?B?cGVydVdibnJGOVBZejVyVjcrL1BKZWhycy9OZ3grbXY1OHRCWjU2Uk55UXhT?=
 =?utf-8?B?bmkva3BQZ0FpSUs0WU14blo5VVRmdzdlc2JCRzY3TFVzVkxadi9HSFdxbGI2?=
 =?utf-8?B?clNuTURVNXBMTFVLVE1CcTl5a25yVWNnR0pITnN1R2dacjhpdWRLS2RLRUZt?=
 =?utf-8?B?dGJYaWFFNDk4MUVjN3dtaTQ5c3dtd1NxbkdacWY1RFlFU3FRZFFMNDVPaitX?=
 =?utf-8?B?V2J3TC92OFBuUDcvV3dUVWFhbjROQlhEdlFVZE81WG44cGlteFBMSE9ML1kr?=
 =?utf-8?B?QnZnVlQ0R1dyWXhkMXg1bGpuUlpQeVEvUVBKRGZTWFo4TURsN2xaTUx3elhw?=
 =?utf-8?B?WFNrYjl6dXc5UWhsazhkRmtkVlFYaGZFTUhBYVdsc0RxQ2dOb1JmaG4yOVBB?=
 =?utf-8?B?S0MxNGE3cFN3V0haK2d6dGlvWWZOd1JwQXlYdTQ1RmtPY2w2ckJMK2pmcFN5?=
 =?utf-8?B?Y0lTVzlaaVZrZXQ1TWtjbFJmeDZ6ZFgxU1FybWNTVmFTM2QrK0o0Ynp0ZGF1?=
 =?utf-8?Q?tzSQ2Bdi72aYrA+ZWuAtFRs=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e146c60-0f99-4c3f-28b5-08db03ac3aee
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 16:57:26.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJEqu325xVdrTGGS6iu3nIPeUIeCYRN7Q/ImQrbDHE1nNrL3KE29JKxYop7DALKcURIAY91dV/KveuN+AneWJrySMdMMX5GZ6jY6TWuc5xRxgZTkkIDN6L0oAnyceI1m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6507
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/31/23 9:58 AM, Jason Gunthorpe wrote:
> On Mon, Jan 30, 2023 at 04:57:56PM -0500, Dennis Dalessandro wrote:
> 
>> I didn't see this make it out yet. Can this still make it in for -rc? Based on
>> Jason's reply [1] sounds like it will just work itself out in for-next.
>>
>> [1] https://lore.kernel.org/linux-rdma/Y8rSiD5s+ZFV666t@nvidia.com/
> 
> Well, it looks OK to me, you should do a test merge yourself and
> confirm nothing got mangled

I tested this last week by cherry picking:

a479433a6b7a ("IB/hfi1: Assign npages earlier")

onto for-rc, then merged for-rc into for-next. Looks ok. No conflicts.

-Denny
