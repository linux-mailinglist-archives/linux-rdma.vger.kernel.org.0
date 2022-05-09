Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A707351FCE8
	for <lists+linux-rdma@lfdr.de>; Mon,  9 May 2022 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiEIMhL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 08:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiEIMhK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 08:37:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0632854A1
        for <linux-rdma@vger.kernel.org>; Mon,  9 May 2022 05:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJiF+VySsCY02z1Jb8g68QrJjFMg/eY//yEKLmcywQ8ue4lYck8tMK7eLn9u+pQZcUtfnLvfHyfwHvbc1R5Hgz8ZxAqDywigsFPRreVChPmdxESKrfFrGsk/XFgrLOVXvbvnWd66jOXqonyMN9sBFvBv7M0Z74Y/73L5cvviHAsaurSuwSWIMRah4GGUZoYs6sKwKVGaH0PFHVYBoi8CgrPVdFAt3OXQuOM1pmk5swwe07bdaAyTlONxta9kKmH/cIuXsmuTErFlmEmh8zq4OAW5E2BNZAc5skqhBZ4qGLtQ//+IuOr5Tp/kt7cyRNIuW2eTbTWUz6V0FT3/iwAGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT7IUIaoRvEJ0YrKIlr/5etVDyUNSJDRMwEeOlzjCXY=;
 b=ebpmWpvuwyoyf8Kyzr+ubwFCbda5GixbNPPHDDFEs+wetZ9OUQoIqgoj6gCXw8HD89L9WsKIJUdA4FQvBGEjmIO0ruVuK3EvhrCvgO+LKhTEqTNmGuX3mmTNO3J80JYj9jzdCkDDWwC7lIBbLsXRVJXNFSKrLzcm2DdUyAnxmTO9qNRPugLt0UH4Aa7oqqjmQ7JYcL4WTHa5KKwTCBHzmRSWsIA/uTdx0mEcoH04Z1sN+kyBVep/ZAQ5OoW8E6gzW0f9b3LV3kteOPyRLD8mFmfRT5gcXDtQ9rGIuI2bpv0R/ufTC7tToqv7QX7Gr2RvxMkdbjqa5D8rhLMu4jVkvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT7IUIaoRvEJ0YrKIlr/5etVDyUNSJDRMwEeOlzjCXY=;
 b=f5czpTPXj325cPE+15UWqZGF0yT+wX+tpuJHOnmXvWq+y5u5gJcA/KkOE/KwcnskFRbWviZcKaXa4Lf1apHBIXj4B4KDB4F2WA1YgAHc0GwbX5lHRwMoOAx5rVOB6DrDIxxMAufvbj3PiTT5UqrlZt0VLUIm85OP+gm2N8DcOMs2VLrlymoyRYX8NF0s/TjZ/4mtW6D3EFsV6lP8wsF/VY7cxyVTE57TzsWLNoKFlVtnOdxGFG4RB1wk130ifDbfob2qq+vOLgnBAuzcSbJBG+X+2EGrZssNSyg62KeB82rc1jq5qm4SGqroE/jf/e3ucRN8kOXPQUluV6fvRlTwEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 12:33:15 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 12:33:15 +0000
Date:   Mon, 9 May 2022 09:33:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: Apparent regression in blktests since 5.18-rc1+
Message-ID: <20220509123313.GJ49344@nvidia.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
 <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
 <20220507012952.GH49344@nvidia.com>
 <CAD=hENd1kTsy42qDmMjcAhB_rO7aa7eP-G377R2DDE7qkqRB3Q@mail.gmail.com>
 <20220509115233.GI49344@nvidia.com>
 <ff097539-3359-cf8a-14fd-7b0d460e8451@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff097539-3359-cf8a-14fd-7b0d460e8451@linux.dev>
X-ClientProxiedBy: MN2PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:208:23c::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f88ff424-b706-4ae5-1ac5-08da31b816c6
X-MS-TrafficTypeDiagnostic: MW3PR12MB4508:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB450832484B75CC00334BC519C2C69@MW3PR12MB4508.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRnLADxgjg6wG+ea/YsanNscH/pXs3lx0+mxQzpquIwTVZPuIP1ItoXbEp7dyQhBSaWCTqNGhYoFmg99RrEEJQtQsYcv3Cs9irjivg2DJiC3/LWWJjvvU/OD70B9i5jHdsmkszj3bQ4BliAwAvpuQ7HfJG7EXUWa/owCwghdwdnD0cmn4vC8IcDr6Vv+q8T74KnuF8RNSjMxmB8CiaF44cM9ORIaF8nCvW0UR+TJ3wA5SWoVXqTGDUHI1kzR0ibV1cLQvjejdYtc6bwHPxLbH2d0Trym0S7WYDyG9EE1P/eOCNMrXsrGErhTTR9tr8QWIn5v8kpxUjOe0rhVUmbboxAPQbh4uVAN3c73RcTVi3VpXJCm/aYuRvi1+h5tDuJE2KTXDQiMXbh8Uptb6Z7T6wshLbvyy/w0SH5KmwmQZ1zh2FTjia5r8Y4iOD8qO2PCTkU0cYb0Ytw1CqzctFqMyWr8ywxJ891pvMbUiXNGdfJHcEmpImnW0Ekj83viY9eKnH16asjSyy/ZiAogB7xQO53V9c0rYmwfLnOH7KFEWgesGEpc1JcidDDBM1xAZgwMXL9fCfYIS4aSOqECc1aFil2D4ecltwZ2OPjsDekTURDUtOdbxDmDDrdHwnFS3AvDHV1hy1MiBnUitcxhJrOdtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(316002)(36756003)(1076003)(6916009)(2616005)(83380400001)(186003)(66946007)(8676002)(8936002)(86362001)(4326008)(26005)(66476007)(66556008)(6512007)(38100700002)(6506007)(508600001)(2906002)(33656002)(6486002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K09zT3p5aVlQMmZTb0V6THRpRE4xRndEemNGVjV6TVdmZG5TekJwVXVxa3Z0?=
 =?utf-8?B?b1p5T1B3Z0hWM0pXMXBXdzQvRjBhRHRCYWlxZnBjNlZzTUFFYUtIb0F3bTZ6?=
 =?utf-8?B?Y2VJczA5S1NGQ1FzRDdLVVNpRzgyaG9wRG5vZG5Gek5JV1VLd1JzbkdxYURW?=
 =?utf-8?B?YVllYmNmMnVnbUVnSEUvMDJreFVCbnZvQ1pmbkZUT0pxeFlDTnBWdFJkOTV2?=
 =?utf-8?B?QnNyVkREVytHaEloRS9pcEJsc0VRQ2cxZ3NJei9aYW1rSllpSWJRbVpRdGY2?=
 =?utf-8?B?ZzJvNUJCbU9OMm5TalVGUFVRUnFtZTMwUEZXZ0R0T0RsNXhiWkcrZXArZ3RG?=
 =?utf-8?B?TExtaHovOFh3Q0RBUzU3OEoyT0d3U1lTZEZXV0U5cW1GTHFFaHVhNVAwb0V6?=
 =?utf-8?B?MVVUUjFjOWFBbkxmNmQwL3Jzb3h0Zyt3ZWlZSVFwa3RPSE5KZHR2bTVWTTBi?=
 =?utf-8?B?SldwTzNValhtbDlGYkphc0VSNk9CSEVSTWMrcEMyWnpMcjdSKzJKSDMvSnRP?=
 =?utf-8?B?NlF1VVNiZGxDd3JNWldtZ2Nrc1pRaG9xbStXUUhSbURNUXBBOUcyb0czaCs2?=
 =?utf-8?B?Zit0SUgxNitycURDUGg5UzJ3aFJVZElhckNQSU94YU4zSnl6VzJML3diWTJr?=
 =?utf-8?B?ZGlmNFJKVTlFbk02TWxQNW9CN3g1aUdHRHZVRmc0cHUxNVVDeTZVTnhOUUxU?=
 =?utf-8?B?Z0dpR1NIcVdjZys1RnU0QTVvMHdmT1M1a2Ezd2tpaTQ3N2daQStUUnZLbExH?=
 =?utf-8?B?Q2xQYXpBb1ExMnBITUlCNHNLY0NGbFZNOHpDSmdudzlvdHdxblpHOFdwR2Z6?=
 =?utf-8?B?Yk1wMHExUjFRbVovSUljOUd2cHgvZ0dNRU9GMy9FNTkrMXZRbWE3aXR4U2Rj?=
 =?utf-8?B?dFNJSVRBcVlxanZQaUJjTmZMV1hqdTA0eFNaR1RYclBqcitMOTg2ZE1SdjBX?=
 =?utf-8?B?bFYwMFVucGl3RWFydVBDZU9pWVJmK0pSL1dXcTROa25EQ00rdEtzTEZRd3o5?=
 =?utf-8?B?VW1weTBVekZZTHBRei82aTNMcmp1Q2NIQlVJaG43UEh6MzVTZmZqcXdBazRQ?=
 =?utf-8?B?cG1id2xKRkJjYlgyRDE3elA2eE1FOVdYMmNxNkkzN3diYmlsNEpzcElkSU5r?=
 =?utf-8?B?R3drUWtKa01pZWdzRDlIY3hZU2IwMFdjVzFDQjNvNzNWVE9hVTM2Zm5uaU1W?=
 =?utf-8?B?cVJxem16aWY0bS8vRG9tNTRXOXpmTkE3QzVOcm5TVVRwK05zTzJ1SDl2SnIz?=
 =?utf-8?B?Ry9PYkp1VHF3YmIrV29oRFVKM3llOUlES2hzMDE0YzBVWnVTdk5UUkl0aGlh?=
 =?utf-8?B?NXdqQkdTcmEwajhCOXVuMzFHV2QyWURjaUtrbXplcU56MzgvU0E4ZzFDN213?=
 =?utf-8?B?aGM4M08vMnVxQ2M1UU43T3JnUnZIUVVuL3ZXU2kxTmw3a0NrK1BHblRGUlVH?=
 =?utf-8?B?MHQxSUNxK2J2eVRHMGpqY0F4eWdIelN1SlNtc3RkeFpHYUpXV1BwcE5Fa1pv?=
 =?utf-8?B?V3p0d2swTFFIZEdKZ05LWFp3L1ZhRVBIT0owWDVJTTNpT3FYRWR1V3lXL1pI?=
 =?utf-8?B?dkxwRk5LUElXYUk2QWw1eUxHblRObHdUcUp2RU5oMFBwaHBjaHMyNmN1LzBL?=
 =?utf-8?B?ZFAzb3RQUG1hc3F4STNrbDZoZEh3RnExUHZ1V2paU1FoWmpkODRlQlRpL0Jt?=
 =?utf-8?B?ZGxSYU9LL3MzTWgvUW5KaWN0Wlg0YVhOMENrekRBKzJ4dHlZa3VKK29jYTFm?=
 =?utf-8?B?cU5RdUZFQW04RzRlcW5zcHlqOXlhREVrZkdsU0hIZXgybWkxL3YrVkgwdkl4?=
 =?utf-8?B?Q1QvdXFZMUk0WjBwN3NGa1hmTXRhWlpPRTJVUmVxS2RodHlOMVl3Qm5YL3Zj?=
 =?utf-8?B?RlZOQVJoMEt4b3hsOHY4UUk3NGhiMXF3OW1wVktSKy9jelFTcDhqRGF6czY1?=
 =?utf-8?B?amd5WXNRamhON2lJOW1RT1cycWtsZmV5bjNwc2NNemVSNTQxWWVmRXRuMUw0?=
 =?utf-8?B?Uk1zeHFwMXpnWXNvSkphSVhVRlRTWS9sMk41cnpDcUI2TDF6WW5xV1F3d0ZG?=
 =?utf-8?B?OGdGQkJpRkhQdzd2eXFSMEMwdHpPSE11TE92MjBER2tpRVZFTDlYWlp6VERI?=
 =?utf-8?B?ZEVZdjNlN0lXSzBpZ09meG1KT3lzeGxQYjBma29TUmo3V3pocjN4Tm5CTS9v?=
 =?utf-8?B?eFN3V3VmQkNvaHJ2MmJOVlA1STdkbzFEV2tRanh0UzJrcHhSSmh2dUVSWm1o?=
 =?utf-8?B?aDI0OFQyMDUxNTVwQkVTQ29aYU1SMmJMSE04Z25HM29Iam10SWNSRzBSTTRz?=
 =?utf-8?B?NEtDTU80TVExKzJuK2JlVXh1WWdIblhwNzJLUm05YnhrRnMvenh5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88ff424-b706-4ae5-1ac5-08da31b816c6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 12:33:15.3421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkOJsOPhMqMbU4dJ/FWILl+7RIww5ZhgmtdywfSkpzW4wdS/6vtXq7G03dS9Wd3K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 09, 2022 at 08:31:22PM +0800, Yanjun Zhu wrote:

> [   36.700285]  <TASK>
> [   36.700291]  dump_stack_lvl+0x70/0xa0
> [   36.700323]  dump_stack+0x10/0x12
> [   36.700329]  __might_resched.cold+0x102/0x13a
> [   36.700350]  __might_sleep+0x43/0x70
> [   36.700368]  wait_for_completion_timeout+0x40/0x160
> [   36.700373]  ? _raw_spin_unlock_irqrestore+0x4f/0x80
> [   36.700381]  ? complete+0x4c/0x60
> [   36.700403]  __rxe_cleanup+0xaf/0xc0 [rdma_rxe]
> [   36.700431]  rxe_destroy_ah+0x12/0x20 [rdma_rxe]
> [   36.700440]  rdma_destroy_ah_user+0x3a/0x80 [ib_core]
> [   36.700464]  cm_free_priv_msg+0x44/0xf0 [ib_cm]
> [   36.700477]  cm_send_handler+0x10b/0x2f0 [ib_cm]
> [   36.700510]  timeout_sends+0x1aa/0x230 [ib_core]
> [   36.700544]  process_one_work+0x2a9/0x5e0
> [   36.700567]  worker_thread+0x4d/0x3c0
> [   36.700582]  ? process_one_work+0x5e0/0x5e0
> [   36.700588]  kthread+0x10a/0x130
> [   36.700594]  ? kthread_complete_and_exit+0x20/0x20
> [   36.700604]  ret_from_fork+0x22/0x30
> 
> [   36.700650]  </TASK>

That is the AH bug again, nothing to do with RCU.

Jason
