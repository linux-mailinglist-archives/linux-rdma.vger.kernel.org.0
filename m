Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A747485A8
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 16:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjGEOIY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 10:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGEOIX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 10:08:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2101.outbound.protection.outlook.com [40.107.237.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24954E70;
        Wed,  5 Jul 2023 07:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzny7MEnn14gvNu2jUU1t5wz8YRllv5/CQeunCdhmdfAZ/KYXnE2rTWD8m4yAH73bgU4ZQpMqPNHN0BCHLBh9Fj0NVvwvJD/jmqqbMe5sDnP8x7MG+TX4OIF+cN0GGf8IqLofizOs7ZU+jIir56LwDClaNabDos9PeRMLQfiSfgBQbRZ/cOJhFN3vnpckLvRJ5KB5K0yJKDKKyc68eMK+wngY2f8k8mJxCGHLEeWE0+xBCk9kxqdDISxoork8KRXVZnrdQGhtoN56w61XpHeHa8dX1eHEPQMgfProoyc7s54GDXV+86dPGXcNyt/30E1QiNx4MJTw0Pm9+pTYW/7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unWiCuCcTtd5C3MNBx4LoGhtBbVywRaNWFilCycNNjA=;
 b=Z6aL5LpnFIizkilCzyOvludSA+8s0LQ7e8VppoonuFsD4Z6wWZ3Rq87Dp8+hg10g1jCu0sTS0QvzIeBMfljLI/9Xk5DLb28aFtmpuAXC7xndyAfdyiwty4mkpzlg8thF2UhnbcwsjkKeOxkvhS2bSrbBzhvp4BJ5DXF4uGzJKQoHJW3Fhva673paUDkTJXG6Hl3wHPBaAwXZmgTmjScvIMwgW0dhYO1AfJ+lkPxdwPqN5aydpZ9n1eeFnh2JCNnKg5ngHDi/h3mv5h4yd0aZBebjb2+V+F5r9nB+n8NpMe8AlnlZZbfrq4xoL38B7gkQwVEjkVSF/sifPYjsuACsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unWiCuCcTtd5C3MNBx4LoGhtBbVywRaNWFilCycNNjA=;
 b=c9aJ661/u1e3UOalFJbUJg0g6Wu6mIs5OnoG8l1itbIT+i0Mxhswv33iSqoZd4tCtsl7BAxD3h74OYNfdu6rUZbzJ2pi1aYHhktPNzpPt6Rhz5Bm+TfDMtrNI5gW4bOjkqgoITFl515HIDLqZkraf9vsmzecuOLGiGPNxJ9DMUN2IM6kEXI7unfqGNPUg7/qHG0V63Q0E0b2TJVLdLpb5UPSlRodvglQPfWBf2MgUWPxlHKqfkxFdqXqbQahG/Gk+zC8w4gfAjOchOzfwSh2ozJ0zKFrcXmiC652QVv2ImfRxnlkkW+8JjCEn/gpifblsbE0r8sxNJCt+8GCmxh+8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from DM6PR01MB4107.prod.exchangelabs.com (2603:10b6:5:22::24) by
 PH0PR01MB6472.prod.exchangelabs.com (2603:10b6:510:17::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Wed, 5 Jul 2023 14:08:19 +0000
Received: from DM6PR01MB4107.prod.exchangelabs.com
 ([fe80::1668:46cb:6d43:5ecb]) by DM6PR01MB4107.prod.exchangelabs.com
 ([fe80::1668:46cb:6d43:5ecb%4]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 14:08:19 +0000
Message-ID: <d7da8ef1-dde3-c7f6-3b78-460d5f8708d3@cornelisnetworks.com>
Date:   Wed, 5 Jul 2023 10:08:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] IB/hfi1: Fix potential deadlock on &sde->flushlist_lock
Content-Language: en-US
To:     Chengfeng Ye <dg573847474@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230628045925.5261-1-dg573847474@gmail.com>
 <20230704114849.GA6455@unreal>
 <CAAo+4rXkMM87OJzim=8dACdV=kWK_1yXeD=W5GZzHoJ2Gz6rtw@mail.gmail.com>
 <20230705055238.GG6455@unreal>
 <CAAo+4rVMH-0zmJfYHmnUF9D5e0pbSdjcdAbWkBdroedQ2JJOGA@mail.gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <CAAo+4rVMH-0zmJfYHmnUF9D5e0pbSdjcdAbWkBdroedQ2JJOGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:208:d4::42) To DM6PR01MB4107.prod.exchangelabs.com
 (2603:10b6:5:22::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB4107:EE_|PH0PR01MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a844178-5963-4557-247c-08db7d6148be
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HX2QoVhpS/xAswfSCN1KpQx12IrDA4+0tuscxf1Sn6PUnAUvRlplkVuBZePcto/dDg+R1Od45V2QbZIAkaM7xIZUzzad5jzgOrStmCy4/eY3YRx2n9RRbfVJBZOi6aTLZclITvHliMX51iqq1HBOLOLZKBL1VrUz11cGpq4bi2gLXlcHPCJqVEQq7zyVTFHX43+OrMqV/yzZGwt+g/Q04FzbFeFLF69+opFH2i+xvBYTVH58TnQ6+yt9+KrdPQ26cVFy7zrJnTl4t0Tobp09hMd2e2PAUn+/Y596pFRtrsTSTyhVn5HZqBt0An+fnKpF5WwsDfpobiLeOMgk3WEBmo3BcdpI1rBkilDg3LA2GMWKiC4QVxbILfvN8e+bMx46OHCRbCPUKnFg9+mQq02HrLF2YrKYFOjuaIFmkUNwemP9v0BD59CIywuO3RPOVCnyuGQMOqL0Sopcfu691GHNZ1pTtbo5/T8KSrdFDb3lRX/3byF8gaRmYLEHlcXTsUpfdH6zADYImBPwKk6OtVfMj7PdXbNPQTbQ7FW5pmaiBjUXS6C0BP5gGtvWdC5h3NNH/XE8lFIbPttzyVgF6in+W75NdDhf4BvdOFYMAvwqpwvstn/FPnk1cZHMa2k06WJQF1A0AF46Ze1CRelSXhCYFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4107.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39830400003)(366004)(451199021)(478600001)(6486002)(6666004)(52116002)(110136005)(186003)(26005)(53546011)(6506007)(6512007)(66946007)(2906002)(4744005)(4326008)(66556008)(316002)(41300700001)(5660300002)(44832011)(8936002)(66476007)(38350700002)(8676002)(38100700002)(31696002)(86362001)(36756003)(83380400001)(2616005)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlJKYjZtNHVpTFVtRHNoZEtuaURPNmorSHkrOGVBMUlPQ0d6YTROdWIrZ1Bs?=
 =?utf-8?B?ckE0NUJheFBmbmd1aktIeE1zMllvS2JBUlBNTCtZM1k5Q3Q1TThWQldPMWo3?=
 =?utf-8?B?YXBGTXpSOE5rSTlmRDV1SmxrS3JjamlPWHEydzJxOHZySFd4VCtIU3piR2ln?=
 =?utf-8?B?cWlGRUQxNXk2SVdLVjh5aERpME1Jd0Q3TmhSRTkzaVROMC9XK1FYWWViYzNF?=
 =?utf-8?B?anJOZUQ5eVZmY3dQYndmVTZDRWlLZW41T2h6T3k1RndCZEQrVU11RnB0dTc3?=
 =?utf-8?B?ZVNIYVN5RXpsaElWeEhaWGgxK2ZNajg0V3V2QzNRRGMyUTJTektta3p6MGN6?=
 =?utf-8?B?cDJxMVlVVmF2OFhzcjdsRDN0YjJRYzM5Q3Fqc2VldXlsZW4vL2cwMDFISGM1?=
 =?utf-8?B?RDBtbjVxY01iaG5IQ3VDWU14VGNMYVc2U2ZadHpNWHdwTGErQS9hbG1SUlps?=
 =?utf-8?B?R1RybWlWbFB0ZHlaYU5FdFhpU3ZkZEZINjhRdDN6VVZGcXYvRVlob0dUQm9t?=
 =?utf-8?B?RHN0RlgwS1gxTWllVGh2bzViOHo5MjIvVGtmTjhRK3BRcEgwTDQrVW5od2oy?=
 =?utf-8?B?dmZ3b2dDWU1pNjc3VFc3WnRFZUxlVUtrZERYUWJ2ZXBxbSthMU5iUm1wVmFn?=
 =?utf-8?B?cVg5dEs2NkFadzJRSHVUNGlXN0tiY0JoMjFya3NEeDVoenNoelhzODY0UnJx?=
 =?utf-8?B?cWhYTkVWRmRlU2U1YzViMFVXMk9Oemw2a29ta3pTNTF2OEVCMzE5WTBNc1Zj?=
 =?utf-8?B?Y1VBS05XQksyY0c4SWJKREc4NEdqc3Jra01sbnZnTDJ5U0hTeFVoWkZtdjdk?=
 =?utf-8?B?NktIUXVKS0NqQmhhZGhKVStmeGR6Q0lvY2dBOXBMMlNoWE9xTS9ab3I2dkZE?=
 =?utf-8?B?aklxWXZJRnpaQml4RmxldW8wTk1PdmJtYnBxWWFtZS9sbkJOaW5UOFRKMUkr?=
 =?utf-8?B?cFkxMlhBZFNVRlIxdE9LQVNIYzR2L2ZFL0M5K1R6ekN4TjlTYjZEek5VOXdt?=
 =?utf-8?B?WWhodjU3bDBBbUhBb2xhRFp1bm42Ynd5U2hua0pBaHRrc25KcmUzZ3o4aEc1?=
 =?utf-8?B?TEZCU2E3TWtYbzZ1L0JsVjM3Q3RQTnJQS2NZVzN6YnNUeG04R05hME0rbEVV?=
 =?utf-8?B?bDNBV0t4WWZlOFdVcXNFQ3dGSldlRGN5V3B3eVhMSDJZN1E2SEN3UUplc3FD?=
 =?utf-8?B?U3V5djUzeG5EZFJpd3pWZ0U2WEw2bmtyODljWGVGTk83dkh5MS9JN2xGVlZQ?=
 =?utf-8?B?VFhOR2tlWGdsUVZkd0Z1cW92NTJpS2NWQU9kK0t0SE5yUUhKT3QrcDRyME5n?=
 =?utf-8?B?Rm9yRGIxWXNyTEc0T245ZXhwc2UxTWNhcDQ0QUR5dWRadDlJbDdGZGduTFRT?=
 =?utf-8?B?Z052Mlg2NmdsaUNoR01SL0RsZEtJRVpjajIrbnNtTGdJY3p4a3dBREYxblZt?=
 =?utf-8?B?TkJJcDByY3ZsU1V1cHdBZGVGVlU3YzlnTjVUNGN6L2k2NkRtTHhXUmxPUnFz?=
 =?utf-8?B?a2QvMUIyQ1ltTUJVVlVTVTFFWjFQNzJaY0RwVDhTK2dnSTYzZ29GRGJ5QUpj?=
 =?utf-8?B?WWJxVUhTL1hEK0xtbTFRWFVVS2VIZDZjaEEvZFVhM09mK2lLQzhLY1RBNlpG?=
 =?utf-8?B?bmt1dS9aY0psSS9PVUdTdDVrSGRMcWVsb0VYdWF5T3ZkN3BzU1U2VmpabXBk?=
 =?utf-8?B?bmZxZ081ei9Gclg1b1dMTnNFSkdPMjFpM1o4TXJGdFBZdW1TTXV5enM2VE85?=
 =?utf-8?B?MWlJd1c4TXBGSm1mZGdPekloTktvdFRsOXhScWM0ZVhuVERsaW1CUUUreHJW?=
 =?utf-8?B?TFVkSExENnloYUFKL3J0cWkyWGV3dmdEK041aEFtdzdFTXJMY2h0VXVudHJa?=
 =?utf-8?B?cW1BRm1OMmY3NDZDSWU4WEJ6WXhmWGR5d0JmTldaNWpsV2ttdTRjN0pGWVVI?=
 =?utf-8?B?a0xnWUxjRlNxYlNQUnBSNWYzQmZsZThVaVpRYmNiOXFBcDFXU3N2L3NZSG12?=
 =?utf-8?B?Zis3M1M1YjJFclFCV2JoRk9tQmRpQ05qQWdlc2xneXh0ZFU4bm5nSWFLdEVD?=
 =?utf-8?B?a3ZQNTZzMlFQZGVLalZ1YVFDd0I2Q1R1aWdPb1JicG9zM0FkeWozVDg5ME5N?=
 =?utf-8?B?Q2lydkFDZm81NlRsUEF4bHE0SjUrMWJLOUZBN0tIbE5ZUmlBSTNpODkrZUdQ?=
 =?utf-8?Q?GoiHkIevrG+WdQt1GEZ8iJM=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a844178-5963-4557-247c-08db7d6148be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4107.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 14:08:19.0307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DM5sFw0OuNJ5WBJKUDRt6cjl4A+Hr778azb+bGF4E7y+renW2HRweTISPXH/CrNJUq8SVhhNMxh4DJoq4Lg/6d/MsPlEMwQ9s8en18g8FAxfhq3YY2+R3VFWAmn4pWaz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6472
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/5/23 2:47 AM, Chengfeng Ye wrote:
>> Exactly, we already called to spin_lock_irqsave(), there is no value in
>> doing it twice.
> 
> Oh yeah, I just notice that the lock acquisition of &sde->flushlist_lock
> is always nested inside &sde->tail_lock due to the goto. Then it is true
> that no need for irq invariant lock/unlock on &sde->flushlist_lock.
> 
> Thanks much for your reply and your time.

Agree. Thanks Leon for looking at this. I was out of the office and just now
seen it.

-Denny
