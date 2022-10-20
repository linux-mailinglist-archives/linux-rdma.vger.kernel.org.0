Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC456606586
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Oct 2022 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJTQPv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Oct 2022 12:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiJTQPs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Oct 2022 12:15:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2126.outbound.protection.outlook.com [40.107.94.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8309911542D;
        Thu, 20 Oct 2022 09:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESsTC0iazAdEAuDSO0zqKD1qagfQFEkH9kc1PCTEX7FW2jxl6UD2jB12z2FElZnEuRjg+d84ILnupsgMtKvN1bR5yuo+yOLXvvonEH8fyWXkwy2TrO+ASFi0vNzFbQ6GLbjGW9bR+yy/xZ5+Z2N2yIDvhZ4KLT9leeB6pA8aHm0RZR+Tp7YIzbRx7J/+tIzePXF0FOjYNi7Vobw8QDn9do7ornah9/tIX/GA7puP6cMjDxGl7qm2lb0t9zrHSwEJdPltCxN9kbNlVHctNORUdGDdktmw7y0uy7Xeyy727sYusgvilGcnD+TGeekYHAnYck9bYp9Oy4lmGhnApv9UuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zjwv5rFdvgdvWgPYsaxSCiXmSGoWGbwdW1mBpAQf+pk=;
 b=gVsdMTXoqAQQCA8y8kRzuirjRe+R1+jPFl3qchKbkwm0wF7B5aBW70CQRBVt4N2CbDdzWGjXTSQXrkU5PGMg+HHMyTKG1pLBzFQXGkl2+17UiNkkvqmCyFERc8w+DHQdNE8K341tFTxtOWwNesXzftx/vErcb+2BCXPgpKG9LFnmf2vb/Jfh+BqgjTeFlR+/FrW0CZ3+ryzZlA4AmxPi1Nf9/0Svz/EA7Xnig1IHixu2LxlCczlAq0zbhvQ+DFEa0VkiinswQQEc2/X7oOUDR7aHmBA0CMHQ6hqEQMUd6Z2Sb9cjdWON7OYqTRykrKAjZ6kkPQz23rmanDH/JyCvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zjwv5rFdvgdvWgPYsaxSCiXmSGoWGbwdW1mBpAQf+pk=;
 b=PR1wQ79GShYPG33FB7xBJ2E9D3CymGK3vrJVIawOje33NEcbJgsE3cR/9THVL+uDiICKyuSvCkapUNGsVdI6DKTNbYFegihTQw5ydFvl60rarG1oDt5TSBdA3vvVeHj9wpR9R7NjMpke8iXKBjW/nTslHd35HgzGKtdAj0rsGUel2vGDd4hIVq/+979mQODD8+O+5WhP7RrqoSUKysvkfqpHQtkoqev07E0vLyIOxqEnOYaoBkAEojUOKMfn2o0Peq99EAaA2KoZlwiW2BVAQcG4q61XQrIpvF5QR7CLscpbqggFdOijt+Q98G8FFdTpR6YmrrbP9KadVihBUynU4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 SN6PR0102MB3357.prod.exchangelabs.com (2603:10b6:805:7::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Thu, 20 Oct 2022 16:15:38 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::6c3a:f804:5889:b2ad]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::6c3a:f804:5889:b2ad%10]) with mapi id 15.20.5723.034; Thu, 20 Oct
 2022 16:15:38 +0000
Message-ID: <7de1e986-b6bc-8cf4-d5d6-259037fe7340@cornelisnetworks.com>
Date:   Thu, 20 Oct 2022 12:15:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [BUG] infiniband: sw: rdmavt: possible ABBA deadlocks in
 rvt_ruc_loopback()
Content-Language: en-US
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, jgg@ziepe.ca,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <afe67a8e-82b8-9a47-0832-527c652cc66e@gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <afe67a8e-82b8-9a47-0832-527c652cc66e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:c0::28) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|SN6PR0102MB3357:EE_
X-MS-Office365-Filtering-Correlation-Id: b22abfb2-b610-4a95-4eca-08dab2b6538e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fg0ePNBTrXaF3llfS8H7h7d94+SiAzxREvjDotBml8NgC8blZO6b89I/wgNKZnvKNU3o7+Gc6yJmLs6rKxTbaAjQTWWNvUDLwQDCFl0O3EDAkH8x5+hQ7XuWgdQtq8bPsLuRE0BeCmRqvKcZ0K3O8bD9RrRKtUlKLVSXTd1LWKsNi6KY9GfDfE9S+3vTDgKJ8GxJAMs1dORMkJ7IBQwKQlV7LLZZIPI4jCJQltPbA724LFpNzzjs39BgrzWkvgOSN0qLDHUP3eKwXEIZ7YUYIMXMS0xG02EY0GScsjd8Ev0t4QZe1mExBJ8CtgPmFYy4+0rckBVdRRK4Temcm6hzS6E+gU531TVRUOM/8bgE4xnukGz0LzFutoihvefrnyLKCk/L31FB4xdJ91cYpLX2pFh7tgAilHg8BFDMrks22lr7xo3kDmmsJ67omf3T8ta0Oy3h23+piP62fEgvgRWwOWbFUiIZL8JL7upi41lEAiJYzG2c96BqR66bcswsGqYttraPm2MM8EZSMdSmciAdqsZY1N6mc2wLwKHeaghyI7f/xi8eJesBN1ATyxGwGCC2+JNtJgzLS0LTucBLcj/cEpZwNp474o46Jp7G2+b4ZQq2U/ObnUQBGrBRlK1Mju3VQ0JKKpWI0UsSqWNVLDMFK47BHm6dBe7lQM7usGDzDogOSAVf5yzxb1GD1dIgOFkg/vrG6aVN2JlgJX0X3AODgzOBilF9wvfIH/cvPQD6t9DnSVRXJ7oVtW/s7RLkg/tDRUVCkuItFOHIMazu3BJl5ptTQKsSADkUNYJgXJOtwGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(346002)(39840400004)(451199015)(31686004)(38100700002)(478600001)(38350700002)(6486002)(186003)(4326008)(2616005)(36756003)(44832011)(6506007)(110136005)(316002)(66946007)(66476007)(66556008)(6666004)(5660300002)(8676002)(52116002)(26005)(2906002)(8936002)(6512007)(41300700001)(31696002)(83380400001)(86362001)(53546011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0xSK0M5elE3OTlGVE4yT3djQ1p5eWV4Uk5vcitLSHNwU3JSbWFhYllURWM4?=
 =?utf-8?B?anpwcFAyMlpGeTI0cVl1TmowM0ZFU2Fxa2loZUgreEIzQUJYWitDNDZxanoz?=
 =?utf-8?B?WlZ5aHYyY0J4TFMraVNLTFF6N3BubVNTbW5vTDF0RjBNZVRMZmtIbkVKYllF?=
 =?utf-8?B?SXMwWFVRL21xYmFBaWEvWThRc3oraVFCTnUvK0pLOVIxTmZJajk4ZklSQ2lq?=
 =?utf-8?B?SW1ET1EyWEhaVTU4ZWdRd1J3eFJFdjloaFpWM1E3cFMwUmp1cUZnUUNxUVBO?=
 =?utf-8?B?VDQwQ1owOTBRYmdFWHJ4TEhNeks1cnk1Z3pidHhNZ3d3eVgrdHo3V2FGRWR6?=
 =?utf-8?B?SGMyK0R5eDYwVHFKaWxkb0N1dmMxYW1WdkFMRk4zYkJMTGpZU0h6dU9zQkl6?=
 =?utf-8?B?V0lpSnU1YlNRcHgwbGFuaXdwRjRGU0paS3VJUVVEbzNPNmI4d0UvdFg5UkR2?=
 =?utf-8?B?ejFFNDZ1N0NuR0V5WWRjLzdPU0NqNksxTVJZRGVuaXhTaWNaVXlSaUljQWlZ?=
 =?utf-8?B?cWQyU1lRdTVFRHRTdXY0cDEwKzFKYWhqanlwZVc2K3lqUVByNXlQNHMxMWxC?=
 =?utf-8?B?UW50YXVmencrUTJXcUdaZjZ4NHlPSWF1MWdvSDNGaS84OVl3dnJRQU42cE9I?=
 =?utf-8?B?NnRrTUl6ZHowb3VBWDBzZXR0OVkraEZnNEEvQzFnSXN6cXYzZTBKaWYwQnMr?=
 =?utf-8?B?U1Mwa216YlE3SG0wbFI3TUhZRUw5UkgrZE91ME5Sa3hmUmgvMjdqbUhlVEVt?=
 =?utf-8?B?a3RnZUd3MlV2K2lKYjBrMlcvdExBWWdRN3FXdzlhZ3BkT2dTVVZneW1SY2V1?=
 =?utf-8?B?aHpjZmpWeWNsaXl3ZCsrNkhZMWpsYy9VdDVuSUsyU21pVitmczRzRUhPSjBT?=
 =?utf-8?B?cWR1RllMTm5lZXBjcU51Yk1neUlYd3Urb3lUbEFnZXhtbTI1NE9MaGVEMWJU?=
 =?utf-8?B?TTdCeWZWVGpBRWloQmdwdXNjc05kNndIYWgxTm1ma2Fia1Vxd0hwdXJoYllO?=
 =?utf-8?B?aUEyUVIxOVFKUUltcEhyRlVURktIYllFeEIyeTZ2TVNFNy81MHV5amc5SzRN?=
 =?utf-8?B?eWV3UjRTNDNpem1Zbi9JWHlMeWtnM1ZPQlNaTWRFSytZMVRJdDRPaUIyd2pD?=
 =?utf-8?B?aHBlbFU5ZVJjMUpKWUNtUlRIV2tYbGtKRzVkVnUrQno2TUNsZmhscnErNHFs?=
 =?utf-8?B?bDl2QXR0K1VwbTkvYTh1RkFFdU1XUDZNMjUvaWdkYjA5NHlkZFRjckN4Z1lE?=
 =?utf-8?B?T3pIOTBYNm5QRVJKMno3YzU5c1lZb3BrQ29DTXVhek9XdlBoZXYyQjg0VTFV?=
 =?utf-8?B?b2lpc2w2bEFPR1JVb3hPb3NyRGJpS2NEbm1pMlByNThySDdtV04rdnRBV1l1?=
 =?utf-8?B?ZmZtQ3pjRHpnMXVlZEtPMmtWcG5sak1Da3R1OStDU1B6WkRJVFY5d3RLekg5?=
 =?utf-8?B?ckZ1UzNTK2NnWEdCKzBKNStVRWxKWjA5Tm53eCthZHlrWFBMeWwrOW5OSCs1?=
 =?utf-8?B?cDZWTmdoOTNleVBlM1ZnWlZ3dTBxRmpwUG1FVW1oOVh2RXk3SmlqZ0lMQnR4?=
 =?utf-8?B?UmxZS00rdGpNcGppcmpwUS94bGQvczlaRG5ocXJpNWVud1dUWmdSZ0xUY1B4?=
 =?utf-8?B?dURBRFYzOStFM3g1aTdDS0pPWTVqZERscHl2MkF4U3V0SjByOTlOTWlPN0p1?=
 =?utf-8?B?M1RiYk03bGpvUVlXTEZaM3duVHdYN3FQdFZMZmxCQ0xaU1lQS2o5Z1dML2ZI?=
 =?utf-8?B?TXB6L2NwV3c1RHhjeHBVK2dSSUFveUpvcVljRnhrWUVWZEgwalVpNWNacUVE?=
 =?utf-8?B?WXFiOUs1bndGV052ME0yNlo1NTRYcTBiTHQ0b2lCV3JCT2xMMzJoOVFmSEZC?=
 =?utf-8?B?NklSY0R2Nml3bTBFcWtYWjd3MjdlWEFmZHlEcGROWDVQWnNOVHovVzgwVkFr?=
 =?utf-8?B?aW5md0VWYUlJeEI5OHQ5RVVaTGN4MEJ0eUo4OWg5a240M2ZzS21qREhWSHpE?=
 =?utf-8?B?WlFtN20zS1k1R2RRc3VjZW9EeG1UUndRcVZIZFJjVEtEUVhjUzRwVVJHQ1Zs?=
 =?utf-8?B?SFNucFlRNyt0QlBKWmlKRHpRcFYwNVBhaFRYdzBnVHU1dy9peS9wOExGZ3BC?=
 =?utf-8?B?ODVHVTRrQU8wa0VtTHBoUkl0NkxITERNSjFPMk1UclRQNFBGc2NsRFpqQ1VI?=
 =?utf-8?Q?mpG/vxfgaDA3/ur5412lY+M=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22abfb2-b610-4a95-4eca-08dab2b6538e
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 16:15:38.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Z0vbKXAussBw0kaalgCdMuWQt7Czqp+woWyIEJNXonptWU14hUNFQVU+zBA3QW0/XAuk+gKgPV9AP1YpMnEpY1W05tgvv2qFG3xe7Lg72vBucxjMklV3w6155p4/vJA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR0102MB3357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/20/22 9:37 AM, Jia-Ju Bai wrote:
> Hello,
> 
> My static analysis tool reports several possible ABBA deadlock in the 
> rdmavt driver in Linux 5.18:
> 
> rvt_ruc_loopback()
>    spin_lock_irqsave(&sqp->s_lock, flags); --> Line 3190 (Lock A)
>    spin_lock(&sqp->r_lock); --> Line 3195 (Lock B)
> 
> rvt_qp_mr_clean()
>    spin_lock_irq(&qp->r_lock); --> Line 698 (Lock B)
>    spin_lock(&qp->s_lock); --> Line 700 (Lock A)
> 
> rvt_rc_timeout()
>    spin_lock_irqsave(&qp->r_lock, flags); --> Line 2595 (Lock B)
>    spin_lock(&qp->s_lock); --> Line 2596 (Lock A)
> 
> rvt_modify_qp()
>    spin_lock_irq(&qp->r_lock); --> Line 1419 (Lock B)
>    spin_lock(&qp->s_lock); --> Line 1421(Lock A)
> 
> _rvt_reset_qp()
>    spin_lock_irq(&qp->r_lock); --> Line 907 (Lock B)
>    spin_lock(&qp->s_lock); --> Line 909 (Lock A)
> 
> rvt_reset_qp()
>    spin_lock_irq(&qp->r_lock); --> Line 936 (Lock B)
>    spin_lock(&qp->s_lock); --> Line 938 (Lock A)
> 
> When rvt_ruc_loopback() is concurrently executed with rvt_qp_mr_clean(), 
> rvt_rc_timeout(), rvt_modify_qp(), _rvt_reset_qp() or rvt_reset_qp(), 
> the deadlocks can occur.
> 
> I am not quite sure whether these possible deadlocks are real and how to 
> fix them if real.
> Any feedback would be appreciated, thanks :)
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

Thanks, we'll look into them.

-Denny
