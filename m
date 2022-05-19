Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502A652D25B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbiESMWZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 May 2022 08:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbiESMWZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 May 2022 08:22:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3049BB8BF7
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 05:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Arescvz7aizrkrsMf/KpjYByn77K5mCLQwtNEElM0gG2QX6txkbW1iMLaaJ3uG2XXnM8HlFO0QzydSb2KZ4vPGdKT+Xf2srXaM4my8/5f+xBvEH602l4s/EJMjAPG3fZ6NBGlGCFkb/NvYOdmTFAhItqf8R0k5zjWrpVWuIy04PK1te1cky+HxvUmNX5zVBMCLouA/gOqybA4D6P6GEmdI7AqUm8R3/wm/7ad6prIg5vnPuoZIKv0kO1d/P0PGhn+W7btuRCp/jDRMsH/JIYv9cUpbyv+0Ps5SLsVFK1rxYTHunAG5XwHYryYyeyfaNlNtZ1iuF0xut2w+9YKTSQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+lOIMbXpcr1nWln7Qj2Z4oYSaWDP0r97QCqlCrXzDM=;
 b=l0EE9NxdS22pZgJBSxipMuBjimtfpiREirlEa+LQCJGwgsOOiQG2FKIOKVYPSze42t2tR7tE0ssGMf6dkyWlXpvmFkuvdHZFXj/UsOTcUXE7oyRf0etBoJBmwPR0rKjCZNYMjFvkQcvSkulHcy5ex75HiVfE4fXP2X7RJX1jS4a1oK7OYYIF03P9G/dEABhxTDwZOQC0kV+4+gxMwy1vTSEuAnwJcsgVQNG6jwEhJCaXouWtvP6yc07Pikdycynw84XgjbL0pdrbq20B2c47GVyXl0VBCZQ2Kgpr3mmBVneh1HmN8eXRuKoJqKXENazkzBl32LKQkU65bXna7PYbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+lOIMbXpcr1nWln7Qj2Z4oYSaWDP0r97QCqlCrXzDM=;
 b=Bce1WUAjtCsogKrT5FxyoaXQdMBnLfelZbibrAVXoAW/abLiFQ0aIcJknZBJJI28znN6vuNbIrBWucnEEjsA204sfH7tjQMi5OqNGkDbazIrDCP+39/7gwj5xVjZdCQo4tPjSLlAkcwmJBzYp70DaZmrn3MrOg90qfAIkOpJemP/vLJwrZQxzGV9ydm0AtWku+0o0C51fRkVxxSJy5N4XfQQTSf+9KI2zysb5uwFqNyVQZ7eE+3jgyN8i4Scq329Du2M4U6Rdsq5yGjlUJIkqa6P/cW+rM+UZcjzn1/vVUyFOtjB8P2za3AGH9WlwWPfLEK8+om8EtOtUhjMXr3oUA==
Received: from CO2PR04CA0076.namprd04.prod.outlook.com (2603:10b6:102:1::44)
 by CY4PR1201MB0088.namprd12.prod.outlook.com (2603:10b6:910:1e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 19 May
 2022 12:22:23 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::77) by CO2PR04CA0076.outlook.office365.com
 (2603:10b6:102:1::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Thu, 19 May 2022 12:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 12:22:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 19 May
 2022 12:22:21 +0000
Received: from [172.27.14.81] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 19 May
 2022 05:22:20 -0700
Message-ID: <a2f7aab9-f9d9-f5de-505d-d65021d21c34@nvidia.com>
Date:   Thu, 19 May 2022 15:22:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Fwd: Bug in pyverbs for test_qp_ex_rc_bind_mw
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <9c9bbda0-4134-207c-96cb-eb594aab40d4@gmail.com>
 <0793a5bf-e984-94e7-2389-86dfa38729e2@gmail.com>
 <6c64428a-2691-02f6-7c8d-8fe63045c846@fujitsu.com>
From:   Edward Srouji <edwards@nvidia.com>
In-Reply-To: <6c64428a-2691-02f6-7c8d-8fe63045c846@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c479a802-bf45-4109-38ad-08da399239df
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0088:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0088429BA583D01EA12B656BDAD09@CY4PR1201MB0088.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIe7ql8+8QzBzlnFFWPB3bNkZ9jcENNOHQ9iFeJb780zyF9h8j7TanDF349j2kIZFPIimF/oOn8jGgd36BkKNtv77+dtRvW5sY5Ng7us/yVRBdtjjMBsH0kqv7ZFSwCwT86/8S77XhB4Kjz4UuNg0UGOwX8TZyrBXQT+NbHs9O7/gKTnYUv0eWo4lPUHh1+9ZqkOhdc1LTX5koCAQHiZM68FB6Q1zvUd03Pp1gqeQ+1c4HxpKoJQj2kGCoL5LDpE15LaaOKGw5bjJa698mx+V1rd6651lfTorQxK10/hfTr1z+oi4MgZDHKpMJ9jCs9gjeb9JlNOXQ41yhVQdrwL5eCWF1W5f6qaebGEbmZE7eszsr3OmofHyUbcqwsPLnyoBSUCotM3PoKiPrOa6Eecu7YXIeo+uNcPf+VhM+2EtV5L/MchTZM8hJhb4Ff4KJJCxnlGV/2Z9iyLbvR/aJAi9zd93ghEfYW4yTGwtgbm1tXoYKZC+kyY4mEPgTEORvrciGDNmajQUP1txI1j+LmzGN82ZTOS8SEy6QKsk4qdc98arAdmbGL0rLdm39QcmU7Sgwz8vE/maNy3OKtmvNOqjdb+TZ1Qzr7m20e5qKSKCmQ6DPiPZJ/Pf5Y7/QRYgrWPTE/64ZfO4trMakyNH89UOddUPhaeC3VFeKSBexzmkSUg1QmEpg42t+gtEjM4C0rD+bVwUCTzGmv0nG9p3qZFQcwJaqe7P8vdwASRlPjYNuJ5gLYfZ+2m/EZkT6ce0DQPbdTC5DKuaik0bSJSGi/zF1OxDirI/4TY2vcQ8wAVJVp7QZIywGkhqXDvLkXZW2QyJuXsMRB/KkOmDQTg1jz4ww==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(336012)(5660300002)(6666004)(508600001)(36860700001)(31686004)(53546011)(26005)(36756003)(2906002)(83380400001)(40460700003)(356005)(426003)(81166007)(186003)(86362001)(16576012)(8676002)(110136005)(316002)(70206006)(31696002)(82310400005)(16526019)(966005)(47076005)(70586007)(2616005)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 12:22:22.4191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c479a802-bf45-4109-38ad-08da399239df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0088
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/19/2022 6:04 AM, lizhijian@fujitsu.com wrote:
>
> On 18/05/2022 11:41, Bob Pearson wrote:
>>
>> -------- Forwarded Message --------
>> Subject: Re: Bug in pyverbs for test_qp_ex_rc_bind_mw
>> Date: Tue, 17 May 2022 22:41:08 -0500
>> From: Bob Pearson <rpearsonhpe@gmail.com>
>> To: Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>, Edward Srouji <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>
>>
>> On 5/17/22 21:57, Bob Pearson wrote:
>>> test_qp_ex_rc_bind_mw has an error in that the new_rkey is computed from the old mr rkey and not the old mw rkey.
>>> The following lines
>>>
>>> 	mw = MW(server.pd, mw_type=e.IBV_MW_TYPE_2)
>>> 	...
>>> 	new_rkey = inc_rkey(server.mr.rkey)
>>> 	server.qp.wr_bind_mw(mw, new_rkey, bind_info)
>>>
>>> will compute a new rkey with the same index as mr and a key portion that is one larger than mr modulo 256.
>>> This is passed to wr_bind_mw which expects a parameter with a new key portion of the mw (not the mr).
>>> The memory windows implementation in rxe generates a random initial rkey for mw and for bind_mw it
>>> checks that the new 8 bit key is different than the old key. Since the mr and mw are random wrt each other
>>> we expect that the new key will match the old key approx 1 out of 256 test runs which will cause an error
>>> which is just what I see.
>>>
>>> The correct code should be
>>>
>>> 	new_key = inc_rkey(<old mw.rkey>)
>>>
>>> which will guarantee that it is always different than the previous key. The problem is I can't figure out
>>> how to compute the rkey from the mw or I would submit a patch.
>>>
>>> Bob
>>>
>> If in test_qpex.py I type
>>
>> print("mw = ", mw)
>> print("mr = ", self.server.mr)
>>
>> I get
>>
>> mw = MW:
>> Rkey		: 12345678
>> Handle		: 4
>> MW Type		: IBV_MW_TYPE_2
>>
>> mr = MR
>> lkey		: 432134
>> rkey		: 432134
>> length		: 1024
>> buf		: 9403912345678
>> handle		: 2
>>
>> The difference is the colon ':' after MW and caps.
> For the difference, just post a RP to make them identical: https://github.com/linux-rdma/rdma-core/pull/1175
Thanks for the adjustment.
> Thanks
> Zhijian
>
>> I can refer to mr.rkey as self.server.mr.rkey no problem
>>
>> but mw.Rkey doesn't work. Neither does mw.rkey or anything else I have thought of.

mw.rkey should work... I noticed that you've already figured that out 
and sent a patch.

We expose the MW rkey in pyverbs (within the cython code).
If you still have an issue with it please let me know.

>>
>> I hate python. Just hate it.
Don't hate the game, hate the player :) (in this case).
>> Bob
