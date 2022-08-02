Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FD35881BE
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiHBSL4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Aug 2022 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiHBSLx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Aug 2022 14:11:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7601B792;
        Tue,  2 Aug 2022 11:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnE6zNQDyuUS0siMpvdiZgtUDB4P6hs29E1Ayuuv/OHn+ZIMAFTy5ksJJ+foy7zr4H3E84xt+q5Dkh/pnu9FwJH6S3xTU+6m20WopBdkljXKkdIu2E9LXEhnS5ut0guX5P3RB6iHNcWCjXcZ404t0I9OOuGY3/qWv95JopQIvRKgRxwNwFq2z9femijJu63tpIIBKkMnuJHC+4p0TzTvfdfo0+K+g6Z2bSwy5wMkbcaAVEa365vB0a183ZIHW/GIM3cr7MXHI1rGKlJYQ8vHKYeRDBXXsjECy53pAjkVFwVtSJk3J75zRe7yExhdzV5E2ZhsFU2iYNIU8CsNVvk0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDdSu01EgAfM6Bz8wpp3oP5AoxeLhVF9RCImp/ulKkw=;
 b=n5KoAOy0yVVa0hEDdV2B+TkCHpMhiP0cuctylLKkddIDdpM13RdI4Sk4r03Rupobo5PMUr3sUQq8SzB7jFquGfIbSRcrv9inkcfx5jHBO4S2FR5/5ILFgWQRdYwurG6SvaMjO0Fmrl6bwXHIDeOg5KvlVufqM4I5sFWwsC9n4HqS9RvxLXJookFGWhMvUiLDId/rqYR5z97YwcVrG/cUsUOaA8fHxcTT22YG12c+3TUh83mHW+DFXfFXLnMMYEqeb9sIokoubtkMeB7yib9wXjhQ8dSRFX1ckxmIOGFo3qJFCyUqTcmOLa3CrBdL5qIVm1pH69YCJdWzvRW4uPNn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDdSu01EgAfM6Bz8wpp3oP5AoxeLhVF9RCImp/ulKkw=;
 b=JZbe6tziSkdkxf24tCNBqkdGNjvqrlNl58ocr08my+UFmxhkGAK0pCBsPrXjJ2Sj6nD3uWQQT1P6VaIHxPCKHhiNRfJJSM+bnl6O8d03eD4biqUEFNGIEzUIsZp659UgqNAe2NW877XYkI/BOgqFWVKx5iR56On9rntcBtk+WkmRSm4hShpNVSAt+3RwQwpr+eCGUPRs9fTO1wqQY6CY7H6I6+w8g3Od66m6Kh0AGZUNoNZ08XDkFTJ8KN/qQvVPVV4gkzLqkNq9Z7Gw5ShdQ7g9ZE4lZJxFJNcNEhmO21yeSX/GIJHKrzt4QmwQbCy92Ca2FjxVLpZiJ6RyqtC3cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Tue, 2 Aug
 2022 18:11:35 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 18:11:34 +0000
Date:   Tue, 2 Aug 2022 15:11:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/ib_srpt: unify checking rdma_cm_id condition in
 srpt_cm_req_recv()
Message-ID: <Yulo1SNrjPYZuIFv@nvidia.com>
References: <1659336226-2-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659336226-2-1-git-send-email-lizhijian@fujitsu.com>
X-ClientProxiedBy: BLAPR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:208:329::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71c1669e-ef0d-4c05-0d63-08da74b26f40
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6364:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qRbjCcgwGasIwka0YnPVmlG0BYNAuyz6nvJ6qlI93fI5yXhapSSAK1YzIXJxnhQ3Ip2kj1TWBSbExYnb4qXeHQMV1bxU5XcyezQQio0dtmdbm9SXbw+y9O01K2sdeb1XTqXjRhJDMocriO+rpBR39W2aeIeyghdOyCbqelAWnb+WbmEWJz3mtXjFBZgq4PnhbKXlguGHMzHj6NmGsJrlc8OhsCersG2SA5eKkJ7RXp/wBJrUBPax4devqO3iQ/xNHRddg76VjVuT5LDacTlAy+ewZSG9jDE95zZRHNkykTc8tzAOPXa8Xyi6iZXsXSdOCtZrXFpq+ijzOhVUzv2fAB47Xeb0WH1jX01ZKM/0KL3GVm7inaoGv8di6Ky++Xb4h0wYjow4AalYzkPad3ccq/3EiJAn11/4AbGFp11ouJwrQyFjbC8GvqAUJ4VZSz10s/vfyvktQY8e05x7yWW8P4GXWaav0PoJErSlp2/Wmkg0DLYQgkTHLOJrKv/u9NNjIhzFZP5NfwseA/vfX2PKnranflbfw5tDC833sJ9ttG0pDnKKGqYqYpr9IJcfDelHn3j/CSrq8AmYH1pwiMDLviqntcVAfDIQEH+0LPYhW2CJEI73d4gCa0i3VvdPClOohzCMwhpya/xNtYR6kQ7KC+MrZH+seXCZIB8zjXZwXnaox018QMNz/7uNMBKQiqe4+6u5ta1VFv+/MqaeuUqgj6U3WKV30yEO7lyiRKbQTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(41300700001)(2906002)(2616005)(83380400001)(86362001)(54906003)(6916009)(6506007)(36756003)(4744005)(26005)(6512007)(186003)(38100700002)(6486002)(5660300002)(66476007)(66946007)(66556008)(8936002)(478600001)(8676002)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PdYqzbFkIUYBmS5je89mll9nD9GV75HXH9C92zYhYvdzA30/lgBjVc7Zn7PH?=
 =?us-ascii?Q?v0vzN6rUMrEjbceI8TqxeL/AWN4/2O3MBY8XeiywXr2H2J5Ek0P/ZJZwTZlg?=
 =?us-ascii?Q?wP9b9FfR2QJKqHpgOze/wKHYL2P58h241SdMvFoVquIZoNLq/B3BZPSqcgD3?=
 =?us-ascii?Q?HBiakE92CuD+pSNNd+ZX1xGmOSPDc1uL4Jj2lGjH2Tzg2eZ1ocDYeW+G4/Rn?=
 =?us-ascii?Q?fMeq+d1c02XF4bm3P59MvnQFbR2oMcF5FAVk3e1GjOOkyZ7OCCXQbXP+omxz?=
 =?us-ascii?Q?4BOjqqKs3wardQC4z8QjGKg8fQHTwJiM69xmHgeHkL+pOACFauyQfKm981u2?=
 =?us-ascii?Q?FBeGLw7uh0j3CmVDe6ia5NYnAR8nGz/XZ71pnXbO7Ig2+gVDtoQauIh6nnxG?=
 =?us-ascii?Q?tgSZ+7C4c7Te84HfNHYh8r7+ooYMXIqSkxbpETsidR4prykckac1JMXN/fOy?=
 =?us-ascii?Q?XQq8mqLnrjLT6SAP5mgcoepUlskrrQ2lkfR0u9s34SZdQsJyYlFF9qUEd33y?=
 =?us-ascii?Q?GytASVZmEVeSqSKHbNTqDx7YvDlz0CNQktXAwbZN6V0MBfQleh9ahmtltOSN?=
 =?us-ascii?Q?B0a+9zqc89XJZJz+DAe2hmbyqqLd10dELG7yqo5YJr3ZmfjuNHtXRkk+nUfA?=
 =?us-ascii?Q?p1hU48jefC3z+Wh8AGYBQAGWlLqlIlCF5Y/zVwRks48XvPONIkw+XLKK1mWN?=
 =?us-ascii?Q?VqOxhzPbdaY2rhH+tHfcWF2wz2pLNcRydqAI1DFDhYGwZikH2+B3kapp5RMK?=
 =?us-ascii?Q?n+m3yGCWwR2Sz/a2UySw+67fR0F2fty+2ijnAO4Wmi2a/ApoWBWrdWktzHQb?=
 =?us-ascii?Q?/KyV+mBh3uII7SumUZJlLwUaAyCcnkEa4YiEEn/OIOJzPQ6vQofMvEEZVoAQ?=
 =?us-ascii?Q?VcnnsNiA2psQaiE3g1Ne3+tKb3WKHlw9Zmixmq+2mPfsUI0FaaT739P9dGQN?=
 =?us-ascii?Q?VYZHRrkmNVaC7Uwp8qaPwPy6BjUbeeBt5Q3w/vmXj6/oFCSNeRtBHiZ334/D?=
 =?us-ascii?Q?tywE1pMtAg7TkX8HUck6Gmpfa085X1sKXoLoaKnWJAruvRSvQ45pe/PgX/1t?=
 =?us-ascii?Q?OonQjLBWnUERjY7Cg/RvlX7kS4lYmVwNRRQsNOqZutBQg4mT66AOUL93sM0c?=
 =?us-ascii?Q?UYJOt8ZXbWiAb13PdQaCErOVY9PvJFAfRJ/dKJio4F6v2e7dEoOe64BWkY/7?=
 =?us-ascii?Q?gwNb76GReDJefZD+7Dh35GBPS6OcBU+AhIXHTc9OMshLXL3eu74l+MPptRAb?=
 =?us-ascii?Q?VvU2OrurX7uT2DLI6Gz6kTujoMeXXKfLYkE1nDMSNLj2SvMGKmvoSC7HI/2O?=
 =?us-ascii?Q?XIqTODFPq44A6+UlWE7+pehNxjeplcR10P2Cq+kYOvyydyTR8A2DfvCOHQ8m?=
 =?us-ascii?Q?CzUEVg8VKoFCMmdj9FYbHYdxPcXRpyxTedVpsa4IAtaXGLqtGVfqWdvVrsjH?=
 =?us-ascii?Q?9hIIeTT9UJl2jl2HK73IB28JlxHCkqvzL49T0Q9WYkbNyej1itvwCNQ/3zAV?=
 =?us-ascii?Q?uOyH2OU8NnkgDWO6Gh5l09qa6a7b7THrneowB48W2yIV8u9ugxSyHuwtA4rQ?=
 =?us-ascii?Q?c5hhd3+YUZbNgtvSFZhxJfUN4XYewY+iBt4ij2fG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c1669e-ef0d-4c05-0d63-08da74b26f40
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 18:11:34.7377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkDGTjbmSewq74tLyhR8n208WswblkD8Jf1L2QSEBW8WJMRL5S4SMyM8dURKOpa0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 01, 2022 at 06:43:46AM +0000, Li Zhijian wrote:
> Although rdma_cm_id and ib_cm_id passing to srpt_cm_req_recv() are
> exclusive currently, all other checking condition are using rdma_cm_id.
> So unify the 'if' condition to make the code more clear.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to for-next.

Thanks,
Jason
