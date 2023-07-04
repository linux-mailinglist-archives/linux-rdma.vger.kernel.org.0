Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA9747768
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 19:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjGDRES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jul 2023 13:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjGDREQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jul 2023 13:04:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20713.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::713])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B2E10D7;
        Tue,  4 Jul 2023 10:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1K0badrZiYY+gBC+UezdBPBQ5dtdZmHLWHIDs5T5d69y//f/gs86dJDwaJbFQBKOpvOHDf/MuVHDqP+wvDjfB6+C9PbWXoM6qedpx7EliItR0C1LZ3A3fsKRASwamg27tYNNbv4llwLtC8ZRFRkEELVH0D9hWZfGaSivYCXubO0HEtwsphgYcP8KcZulS98eqi6rrvlv6LFmPhljzM5Tq33UQLFHiN4RsK8idLZa2E8c8grSRcXXKQnpVFFPMDUPyHs4D4fQFW3ug9w6cWa0pioZcM8DJFKf1RGM16Hqtb3F/wV4DkdkWqR533eBiwlffQjX3T5Bm0DsEzyE/RKYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnL+IOh+9OIGkGnahz5oXRu0Vq8+/M1GygCNtCEEEAU=;
 b=NkrSa4RNjxeRZZGnE12WJ9bm9+tOr9Ou4zDY0X+4CAMDf6ABCo3ebE7G3n471rb3XqUC4pQ4FU6CUqNsA+HYdo7eA/8+wqIWrrglacazqj0IA6u5j93e+zH6pBXmfqXcI5kWgxU5n5QriwBNCjRs0phOqhdmDJRcIHFX2qZ9aAh4FqzszJMGarDUJODe5C57hl8wPCQ6mHr5q/o1wfLREQ+EPdRl4k35LwI+sDhH6vNsjwkQFK0W8LOesWn0ObEr1BUIdppelEeztAPvld27Ec+LCUwbTSfnPK2WCC++xlSYAGTTqcqeL7YIeSdcZXySZOIJUa5MKyo+S19O+X8kSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnL+IOh+9OIGkGnahz5oXRu0Vq8+/M1GygCNtCEEEAU=;
 b=AXZ8sgy0pzUnwxFW9o7CvKRni7uxOkmwJcChZwkmy6LbINT4O9vdXSwp9Y7Iy0K8piUEaccz2OBlix5tcsJDw81fldN2At1pfbtVApOzP6HuqRZccYzzCZU7abWjD5RuLkFpGqCb+EcBAs80fiukQh9BfCVJHSe135B8/kF5A5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB5055.namprd13.prod.outlook.com (2603:10b6:806:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 17:04:12 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 17:04:12 +0000
Date:   Tue, 4 Jul 2023 18:04:03 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, borisp@nvidia.com, saeedm@nvidia.com,
        leon@kernel.org, raeds@nvidia.com, ehakim@nvidia.com,
        liorna@nvidia.com, nathan@kernel.org, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH net] net/mlx5e: fix double free in
 macsec_fs_tx_create_crypto_table_groups
Message-ID: <ZKRRA7KPr9ymAdK1@corigine.com>
References: <20230704070640.368652-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704070640.368652-1-shaozhengchao@huawei.com>
X-ClientProxiedBy: LO4P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::8) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d8b448-4c7d-4c4c-7908-08db7cb0b052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bX9IY/bdGNv2XhFCesA4290pTLFEF8pXkVizvyN/kh8Zvk5+5E850T7qUilPpJ6WY75+1TgsYcvtWmOC9hZaG7axd2051eoA0QAGjianO37m58kZoie9vOGTz27lHEodRAqWM8GWQtmNkeoew3VfGZr72zsVpmta0gAVGOzUXBp2vjUlUAZWvKlqcdPhkNjlRh/QT/9UwZxFvHpW12vr8NWY6RJ4+jJz4f0ziLntOe5dxYplfapM2kIe/AioT55R+aLnWgXk9xh06x0nPuvvpm0e1sA2aFbD6CCq1pYnTYRIArS97S4DLYTfyknLkHq3ey5LXySPA3a2KKetK1nj8d6Hwpys0iwZnGl2J+cW5ON1TlQRv41l4VppLrfXX2U/a8YRVkUeyv/EwyDJSdPBmRfZPjHmpiLUAIKvdQxjK98QCi+BNILBWpsLaSi4f4h61gUSJ+/5JNQFjoWe9zqeDzvt+9TcReSHa2rzG/bG3tRj15GWfVlx6RdqgJgZLuJ0ObVr4A8pzHcO8U0J80Pk0L9A7s+GmYzSl3OZsgT2PyjwNPSfnNQd5edkb76miYOfgoUpjmwdu2LRr5Tk5qEAR6JQFvY3XNvA1MxiOzxhwO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39840400004)(396003)(451199021)(26005)(478600001)(6666004)(6512007)(6506007)(86362001)(2616005)(186003)(38100700002)(66476007)(6916009)(66556008)(4326008)(66946007)(6486002)(316002)(8676002)(8936002)(44832011)(7416002)(4744005)(41300700001)(2906002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6cUJsYq3G0UvJYd6hpb4VBRNhxSvwqTU/fpNyG5VDrKftNAaNP/h8x07K8Bl?=
 =?us-ascii?Q?zLrEWASUhiAKXhjyqtNqlmqtErYk/y6keIUxU77qMnkwRFI3JIiJq0m8474J?=
 =?us-ascii?Q?GDLYOiLjRdsl+GzglsP36dxebYqJjTw+atS1KjcXl9zD+c0Pn/aYWfVOIbYs?=
 =?us-ascii?Q?b6XrQneVZ0jCRi3DJUFfkkglc8q7ITjvObCMuhtSJyuNfIPSvJy1M7S0LR65?=
 =?us-ascii?Q?FkE321wf7ocrVajObkzCbzkSor1Ho98ZyxAtqkxnkDdFMq/dz2GbFihJzQZL?=
 =?us-ascii?Q?GN5QcjzQf7BkXJi9kSxjSqBk+bXsZkdj7K5G3/Rn0y44ENSaAd2UH3kxxThM?=
 =?us-ascii?Q?UpRCnqrGwwmzus1pooPI8sy1ik5QgJuvgy5reZU7hJdd7hpg1utgyrMYrD1z?=
 =?us-ascii?Q?+iSXVCJIGlJYCzTL+a9zS/CMuTpIsym+WFhXr+KQWInupVCEjk0UrUlAxbbS?=
 =?us-ascii?Q?PVtkIRWsm3ClOT6TIVpFLsRQFmznVrEl0N//n8kWHYBzYid9MC69IaNBL5rO?=
 =?us-ascii?Q?dMPckW0Pq4FIoi4x9IEkbPdGOg34dKfaVCyzQFgHNIIAy2lFiYjJ9Iwtk8A3?=
 =?us-ascii?Q?IvLs9bIhG+TLEyZr/mzQgRAf4iFAV2ghdo+qoICt06f7hWc3eyLB+C+iRT+b?=
 =?us-ascii?Q?fR/y7uJZImP2wNBvje7NsfqxDqh0iAO3mJ2OJa4bhOgtwkigF9x2IfHTcHZQ?=
 =?us-ascii?Q?vBPIKJQ9KZu2sMna2U2ktk5aG7r2aoOBrfw5DSP5r6hFHyDy0tK2axbV8Y/P?=
 =?us-ascii?Q?XeK5AcHI5uZq9rJ7N2ez3V5W+KGft67LxogT/Br7UMMsVeRv4LYyFdo+7T9A?=
 =?us-ascii?Q?nVNZbzEu37I5szdfit1qQtfVpIWWVAc0/J00d8frwlt6kfZmoL/Un6n1vcEP?=
 =?us-ascii?Q?1eHKgWfUaAunUdbrxUKOinC/9vZHujmg1l7V68DoJc+ox7jvk2f6+C3h8gM4?=
 =?us-ascii?Q?lXwYjPPm6BuWFS/ce4CkJVMZqG6nMRwEVZIHSqDHmii5jKCCGcUqCo3/CIAH?=
 =?us-ascii?Q?ZRv+G1/4TiDujSUV5nB5KowmeJw1/ZCJuQ0xp97xUs2DSobJJ9/LL6DgMvV4?=
 =?us-ascii?Q?MYtdN4SeVMzzuGDinCJKesWTa+e6F7ZkrlnqtnLl1sUqd0cTZ38zDpLDjEQ5?=
 =?us-ascii?Q?eQGFYtKZwW0IYSwfIOy82BZL3NhGDpdKcHwB1rZS/NjcoW7k2+TuzaAgW9A7?=
 =?us-ascii?Q?koQzSg/ex2RiaDBsS/5uocr0zTXry037KZAxnbg7h+uMYEs/GtC/scAgx/cy?=
 =?us-ascii?Q?EVgxUDR3/GsDpZrJaRsEk4ewn0r5hJ5EcTOhrtdEr792RHymU+NWCyxeiJr0?=
 =?us-ascii?Q?vYk6+KglJVXVCWDfLYZiVQNtH2hPErLvhR3sWsO8/70QQ0jDr7lu7iqi4/X0?=
 =?us-ascii?Q?KOAr4qOCxH/XOQhb9hZ2km90IvDJJGkv7xfD1fsfOwZ6futFMtzZNfT4xVRE?=
 =?us-ascii?Q?O2OOG5THqot04gtHFU8aZL4V4KFO3l1nF107qqtRxQO5kNyg7ulfFpvttr+p?=
 =?us-ascii?Q?QyHYHcnYB79LG+7RbrqwlWE3+XvLvYae0cGgd6PH76zI+0IS85LSHxZ798Hv?=
 =?us-ascii?Q?+I3L3li1A5Ir2ltJ1/Bt6g+Ga7p0f4KgOyBX+9vbuHNAz7rgfbGOqRaGlew0?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d8b448-4c7d-4c4c-7908-08db7cb0b052
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 17:04:11.9102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kG4qW0BiHhIGJ3O3cp0Q8wKB90APynXFfeQe5qE+GcwcKsvTIMu0Ii9Ls9CuZQyP48WDotGRmlMYd/iXa1EjFmBWsSm2aMdU03yyAk9VCi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5055
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 04, 2023 at 03:06:40PM +0800, Zhengchao Shao wrote:
> In function macsec_fs_tx_create_crypto_table_groups(), when the ft->g
> memory is successfully allocated but the 'in' memory fails to be
> allocated, the memory pointed to by ft->g is released once. And in function
> macsec_fs_tx_create(), macsec_fs_tx_destroy() is called to release the
> memory pointed to by ft->g again. This will cause double free problem.
> 
> Fixes: e467b283ffd5 ("net/mlx5e: Add MACsec TX steering rules")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

