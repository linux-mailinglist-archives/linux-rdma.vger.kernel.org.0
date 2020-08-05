Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE91F23CF9B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Aug 2020 21:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgHETWr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 15:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgHERlo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Aug 2020 13:41:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F67C0D9419
        for <linux-rdma@vger.kernel.org>; Wed,  5 Aug 2020 08:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+nJlV1O/GmqKaNwW0iLkSfT4PftOUNePzFDh8oXwKty8scyfQ/HcXZv46Y8H6Fq3JImob5fEVUe6RdUckJxFW/zbtr+VRLRuF1fr4ypndsgOe8bmXKnhYjaZytFuSgOHP5boJKvEYT8/XW3ygQSr2QDf2S+81cjo21MNjGctDQFtWknvK7nLK1fl//uLiQw5ToayFvV4TEMhHYDVe2RagMQzUAyAUn6myErCIUGyElEEqUdXR7rs1KlzNHqp8mBiz+RNZSm1Dbi+7Bn3WntKJUhtpXa+s/Zd/CE5PxdVodSNwerxkqHCVVB9YavxlO2ISbCJcivDFzmN+yxuR2NCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcrqmIymWFs//nBYk5ARltpQrpV7hH1JHQBjr5uPa9o=;
 b=SCKDgV83+MGPAm7cVlqPfmD6HmJJXvHdTqWZGmk5Drkl285eoOOc7KTKWOczC98qzKgKdSydBwLOjKBMdgSLytYbGnXYho60dQ+rAGQLVJj2S1rl8DwIbpW6VOojI4Z7hETVEL3RXr3O+6y8ypgBFZyBWdj+FFWgDeO818v2ZwemWaPjLg0qIqJj6xyQJRay1dVpaqplxTuEgVMkrp5/v1IfS7d/0Bp0YWAIWctRcHBLRxLHqKKg27+K/cRu1CmIzkCla4HvlRYxjjAiWcHcOmx6znxSXwRUCpUTbccksa59x0I+8oWROxpOYjSkSXa6L261zwAR7mTd0eTem6xnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcrqmIymWFs//nBYk5ARltpQrpV7hH1JHQBjr5uPa9o=;
 b=LzfGfqS+YvOlM+86DtWAXYVuIhDJI0+fvA6o9I4nQzThlgUagtFEf8siWuVI8rlhy/lThLy3lTNSbNd5m5R6/w8njrenNLYtAYbdMlLQlryvpASsl6NI1AM+nrmkVfttAAvT/DojV03klGH02PSQqSM2nrmVcSu5v5i5Pw5+Jms=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR0502MB4051.eurprd05.prod.outlook.com (2603:10a6:208:2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Wed, 5 Aug
 2020 15:14:20 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::95b6:b863:de2a:c8e0]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::95b6:b863:de2a:c8e0%7]) with mapi id 15.20.3261.017; Wed, 5 Aug 2020
 15:14:20 +0000
Subject: Re: [PATCH 1/2] IB/isert: use unlikely macro in the fast path
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     sagi@grimberg.me, linux-rdma@vger.kernel.org, jgg@nvidia.com,
        jgg@mellanox.com, dledford@redhat.com, oren@mellanox.com
References: <20200805121231.166162-1-maxg@mellanox.com>
 <20200805131644.GJ4432@unreal>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <3777c9d9-1d36-f8e0-624f-aa633fd517ab@mellanox.com>
Date:   Wed, 5 Aug 2020 18:14:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200805131644.GJ4432@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0059.eurprd03.prod.outlook.com (2603:10a6:208::36)
 To AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.138.179.55) by AM0PR03CA0059.eurprd03.prod.outlook.com (2603:10a6:208::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Wed, 5 Aug 2020 15:14:18 +0000
X-Originating-IP: [89.138.179.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3959e0a0-c5e7-4bba-5482-08d839523a11
X-MS-TrafficTypeDiagnostic: AM0PR0502MB4051:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0502MB405132F2D01C448FE5F6463FB64B0@AM0PR0502MB4051.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bWwg0l9QgxA74VIM1HNGNrDe2lzP2sl4xrKD/E3LrZEcTbiMuoINEPaAz9uH0DeQu8bRbxDLSXFoiOXlCDDNvn+HLPcuNlxHW5gbkl0P/2AwENaIrqBZKPw4JwU1/k+eYg6DsWXfIHDpzH91SDzzo6EyptuRaxhH3p8kPKoT18yXzI7GxENqemPVnViGYZZowXZFO0L/bNG42BmgimIVuTZlnd68ZY/fMKITAJndulJmfIyjtDt2kwFBGY9PUWtA+xBDqTOLxRgZIcMKiJ0Cmqada5XlYFdEdsJZMrK2T59NOjnuS8BS0kwHwcKVIw/u4l1B+G2AFiniah+3Alfm1Pc/OLJ9zAIxHz+GocSgU3MXwT7yEm+YXMmyTyUOwvN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(5660300002)(53546011)(37006003)(186003)(83380400001)(26005)(86362001)(66946007)(36756003)(6636002)(6486002)(52116002)(16526019)(31696002)(478600001)(66556008)(8936002)(956004)(2616005)(316002)(8676002)(66476007)(2906002)(6862004)(107886003)(4326008)(16576012)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8jdfNDFRCDjDI3K0VuE6Y93L+QAD4RZLXgeWLk/S7qH1mnB6LF6RBP0kQm6YryR/QzUW6U9joMksdHB4fFcKKNzElyHy9wNBKfDMiT4vHlQ9FMaW/0VDKV3YO4Hn2+NahvLBAl0MeGtUPYtFLDXEcEQFmQVTpp/r3HiDh55Lc7BKpNj9Jir61VKQCE9Ybwfqp6UQcgOCwlowxaOFnU31eWtBGeuaQ8FmWtuB5oo/YRh5Ehg/I0YHGU1RolnuNsIPxzgBvHl2m7LFDgdJhJ3JG0m8ENX3w/ukuByZWm6JPb+ZKtt/EDxyq5LqDTIrP+YO6kk4qZ8aH08yzVuRBOB+G4hXxN4rdtRy129v1F1P7RN1r90PtJ8TK3c64Hi6SjAPxeAS3XjHBktGIZZPh44RS8vCt+oz/xG0Dbbt4Un2/KpGAKD9mThUHqpw//ItGdluv2TjV8lqMIWMIzUW6ahlPgs786LquUjz+Hn1wWtdFvlFeVToJhgPenUJxhdkT6lFnl9SCCsCcurF9MncEG+jsIvJYvPIIu4dikbBWWhF53XgSWUPUk/iKHVu2v91zMSz615EO4tUfVvUKm1Y+bZ22G5Awatq3Vqc7+RF+L11nsUiB5Qye+p977pksADHToh0lLlrU9y+SQvXJaszTDXBRQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3959e0a0-c5e7-4bba-5482-08d839523a11
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB5810.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 15:14:19.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlKm+OHuhURK91FQuO4IMVHOM/YPooRBLEf4iY5Egk8Wez6gjih+8zTY174wwhRytkQvlv4k+vt9dIa9Eb7EpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB4051
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 8/5/2020 4:16 PM, Leon Romanovsky wrote:
> On Wed, Aug 05, 2020 at 03:12:30PM +0300, Max Gurtovoy wrote:
>> Add performance optimization that might slightly improve small IO sizes
>> benchmarks.
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> ---
>>   drivers/infiniband/ulp/isert/ib_isert.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> I find the expectation from "unlikely/likely" keywords to be overrated.
>
> When we introduced dissagregate post send verbs in rdma-core, we
> benchmarked likely/unlikely and didn't find any significant difference
> for code with and without such keywords.
>
> Thanks

Leon,

We are using these small optimizations in all our ULPs and we saw 
benefit in large scale and high loads (we did the same in NVMf/RDMA).

These kind of optimizations might not be seen immediately but are 
accumulated.

I don't know why do you compare user-space benchmarks to storage drivers.

Can you please review the code ?

Sagi,

Can you send your comments as well ?


