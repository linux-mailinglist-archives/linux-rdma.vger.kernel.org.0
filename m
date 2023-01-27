Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46DE67EC46
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jan 2023 18:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjA0RRZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Jan 2023 12:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbjA0RRX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Jan 2023 12:17:23 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23FE1C5BF
        for <linux-rdma@vger.kernel.org>; Fri, 27 Jan 2023 09:17:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuHa9OxgOXNXQnOunMuxFA+HfCKrE2Ry/3ox/jJNbrYpvxGjmHJg1LvSeXERkxn2vng0v9/63xV3RMf7QUJtAB0KZxWFTG68xW05nXWv+W9N5vuzbfQc7ZgDXEdaB3AENhSSh1OgZR3vNjaVilamRIodhZWJ0r9qjVRKzOWwbh/VprZGZSWzGITe0UXivwE6VAhZOTFeknuKx1l6vECH1rr0mo6tpn9Qq+eNCDf4dl3UMR0nY/+T3ntW6JxvrZGfy4F4EEvI9MZOqVQYngmdtRsFRmM1oPKES86tVsIiTu3s71ExCzSmNTicjw7ODLe4Rk9E2TsFawnFwjiYWYfhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhLe+Z5YHYsMX0a1i1QTSnstkAfZULlMpyHeCVx0kUE=;
 b=JfgGMjjn2hTC+WRiLfC6XuivGPTETjYFDjDnGj/jNvs105E7z4BgNKiF0nqBpFpImR4qLC/3KrNDC8jhPQmxQiodBVeTwoRuHpvONDruyxZeGTygVf9jBNWU0Cr3tblQ9V9qTE0+W6H+1hsGTELNL6FY60R0aKujDid6Kz4pfeYhifVrQlesc8vXuGM3yqS6BTPvlAPAPyctTwrYlvobg3ZpWGcaTviVNbV/Lty5ZjPuQ/H4SflvA4K/Io5V1dKA04hjjXELHkyww7CwxoXUIRzyKoYravu+SqpAFu8v81hcYa3qDAKZZzSm4Nnpe7jbigMd6gcTOktftn8hN0YhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhLe+Z5YHYsMX0a1i1QTSnstkAfZULlMpyHeCVx0kUE=;
 b=jBCS38jeRqN0CNC8cpfa6tOz9bahGqhNkywan0NM82EGLukOtQZmiKo2UWRo+mz10rUpdeGRqYt2FNLtO5kbb/QSaxMs4azdOaAguZBonNhROhwYLZ2FDAo+15M1nDLiK7M/NMR7SwuxijgYJ90f31/gb1+6YiAIVyLCpgTM7hA0foU0s21Ws+l7fdZvo0WpsSeXtOwbl/bPa17xovppLhZeR5F5bNSHJJTOzrlz95iLTWhS8fFvthunHYagoiES9hAuUUcinY/+C8l+Pbk1nbyTCQwr0VbrfRC6NqeolJhQ0lc1rQ1RdWEU9MbZ7cFgthYCmrRYfcTw9FizNEdFCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 17:17:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.021; Fri, 27 Jan 2023
 17:17:18 +0000
Date:   Fri, 27 Jan 2023 13:17:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Guralnik <michaelgur@nvidia.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org, maorg@nvidia.com,
        aharonl@nvidia.com
Subject: Re: [PATCH v5 rdma-next 0/6] RDMA/mlx5: Switch MR cache to use
 RB-tree
Message-ID: <Y9QHHR1bTQo69Gz7@nvidia.com>
References: <20230125222807.6921-1-michaelgur@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125222807.6921-1-michaelgur@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: d73b1d80-f5bf-4751-ea82-08db008a57cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwL6I9uofAIzS7mThB4A/6iCFRpE54zKd8llqtKWKJM5Y1yEDofSXAwNKg8jMVtVF5ApjCUgE0F7T9g9BXZwMLl5x3OfRt33gBbyF3xijwu03VzV5LNzkRkv33sMlu/686K0SaUM82ArHFAv3j5B0gUokpTZW7GCaLjAqqONu8sUbjXxSBsOFnHheiZBiVNQtQscS6bINyovum7k7Xu0I3SMN+NzPUsZDxuLkpAUvMhIXg+Zkheo30ylwCPxzSwylrdCKFkzbpfPgUW7y9vYEdMZVCSQdWY5OzMirM5mcpe8FJu8J98XlX9hcsnli+Dc16D0M6sZJT6gsgQOUfaHqoEpGdVsbDkHPZEpf+Hs7KSfKVLyRVNrNgpJNz/dN48VpIhFe1wRevnWvMg48oyeKEoF0Dum47i+jGJkClHnGVK6xQmO5yKnymyUCo/PuqJWTaM/kG/G/wp9Nb28Bt+Bx8OtnpuowDk89Hs1WoJaPqdjpF7Lmuc0XqpQSey+RGlEyMgclwhnH914juWcJWszDPBmhSuQWsnQpdzoHtfux2Vg1fsA+BFD9LEnhtz5P7BsUbq8Eb092z3E2oLuQFKEnx/O6MDLoUgGhRntigmtSG8/J3i4+4shHDwL1fwAgyu3uPMT7AztD341ZNe4vXI7sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199018)(6486002)(186003)(26005)(478600001)(6512007)(2616005)(83380400001)(107886003)(316002)(37006003)(41300700001)(8676002)(38100700002)(6636002)(6506007)(8936002)(86362001)(4326008)(5660300002)(66946007)(66556008)(66476007)(36756003)(2906002)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+vF5wDnl8L5hInQZhfnxgu+51XJgob2wyOYIsZkUJOCtcNaW5nD0LGKzdvy8?=
 =?us-ascii?Q?VIBgRXa1bsvI2ACBjsQXI7dq2aVT3nXWkAdGn3RFWSajtZZ3XJeZpswZiZUg?=
 =?us-ascii?Q?fSOnY0yFL/3VpNEG9D6XbK3u80guArxb/IbB5YkyM6qK72aWYj0uOVK+4A/P?=
 =?us-ascii?Q?oSdl+Ogl5ln4yn9451q+tcD8hWtoAg6xJ7SZbdUTdfy2PT63LGUfpjZ12e+s?=
 =?us-ascii?Q?AyQurKpGDx1TqB6sBto584OFx0Z1ZgxlBwI5n9dhKA08xJueReahBV/vhYKM?=
 =?us-ascii?Q?tAk+Jww+RYKQix6PwVqC0ia2bgq8dlTiB6orNyIDGeNleTYntnfSdqhET7kW?=
 =?us-ascii?Q?zoU/vfcc6lS7u4TGyLNqLNg9m1FQwibkCDQf7vzHb+VOjdLUxyxNtXeENy6l?=
 =?us-ascii?Q?lCz0fUwBVbW3hmKnG1Xnzuqg2NnqNJKhLL6s6QoS6EcMMeeJmHW09gjCGvRG?=
 =?us-ascii?Q?SmDcMqea0/CUMeNKfzooJgq71xpsB7w+khQ93M8azeHZS8xwf5lPvtNusrCM?=
 =?us-ascii?Q?VVDzLkI/He3+07NsBSjIN6GQ/zBiZiAkdZQhmQoKq0Px1fwEI5XWptLjFJrf?=
 =?us-ascii?Q?dD+SyFWLqIj/9+xlwklmrejCCd0XYQ6Nph4kHiRTf7boL1eXtgEO1vwIhBBk?=
 =?us-ascii?Q?oQ3nTaiay010MmJ4alfWgvXf2rmWnVRSKU+bp6E8JhqEpGExpiGVYcua6L7C?=
 =?us-ascii?Q?zBHk93slT/xXHOU5QSnXeCDeQCaRjwYcAPb/d211l8rXa0hGqurGoktWNU3b?=
 =?us-ascii?Q?+QXFJA0nLC9SKsIRE6usKwo/jV8ZFmDRyhaZDa2HYxDdrliyYY3jtf00EKx8?=
 =?us-ascii?Q?HyxpTGh1sPezY5CL3Bm9ajM4MIuztPULvpS+1jATj8230ibcxdiErqex8pK9?=
 =?us-ascii?Q?uUiOp1123MX0ilYCpaSPQfaE/LdIXqP6oPK2MVbFpfM8GIId2VLF4a7Rog+i?=
 =?us-ascii?Q?jbE385nqm/HWrmnw2jZmLhU72hiUwMh08pCIJ3l9DCAZUMGr0h+l0adT1ZEy?=
 =?us-ascii?Q?x+yGgzgWyPnue/u65Lh5UOvTzfR2yg3H3U4svODASyJbA4Rr3CGYPXUN10Sl?=
 =?us-ascii?Q?dY8ocWLnR+cdM/UcA6byac71dTed0Y7rWr37B1ys90EjgLNYj/1mj2d1GhOd?=
 =?us-ascii?Q?AFZabo76V0R/1Q2EoAp0fLvrpGvfHy9sCKHkmiGVRZm9WPcvJL2gtLwqw5vr?=
 =?us-ascii?Q?3P7bzu5z9W4LVYObVaDVQA7XPMFyD2XeAvveu6F55uKTDOZzGpqjKhVO44G6?=
 =?us-ascii?Q?H4ljP303p5saZKB0YTMDEEh8eCaWWXZlRxKjaiJu/VnNsLnyW2WiaQakvHpN?=
 =?us-ascii?Q?M8SntcUmF5wqKCPud4Dkj7ztBHTxDfICPObFCVZOpUUXREr32B/KzkT5c56O?=
 =?us-ascii?Q?Ny4L/BiJSBOnLthGa9uZNswvd5Ndk0c8A18qyOUzN1jq45rsct7h9utlCFau?=
 =?us-ascii?Q?koPDjdytusmX+fs5kU5ArzDGG84m3n9sOXIMNSu9cVSz7yDfEhYxqw9XR+kN?=
 =?us-ascii?Q?I1MHzyd+QQtUGfYPUIxfhUbdSbFCjrCyEqFWFo+lovU4ih3u+TvwKorIb3pt?=
 =?us-ascii?Q?Aix/s3WKdlzndkTFhPTXyBr+0hKrMpXsTBA3PCWj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73b1d80-f5bf-4751-ea82-08db008a57cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:17:18.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3wRjeJzuCsPd05PhGDjn1Tz82XsA4Zzj6BxH8DBFY9CIidesRpw2cu8/w18h5AT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 26, 2023 at 12:28:01AM +0200, Michael Guralnik wrote:
> This series moves the MR cache to use RB tree to store the entries of the
> cache. By doing so, enabling more flexibility when managing the cache
> entries.
> 
> The MR cache will now cache mkeys returned by the user even if they are
> not from one of the predefined pools, by that allowing restarting
> applications to reuse their released mkey and improve restart times.
> 
> v4->v5:
> - Commit message fix: 'Remove implicit ODP' instead of 'explicit'
> - Fix return value of init function in case of no ODP in configuration
> 
> v3->v4:
> - remove 'change-id' and 'issue' git trailers
> 
> v2->v3:
> - Refactor MR cache init flow
> - Move rb_key decleration to rome unnecessary change in following
>   patches
> 
> v1->v2:
> - Rearrange patch order to first introduce the RB-tree and only then
>   introduce the caching of previously non-cachable mkeys
> 
> v0->v1:
> - Fix rb tree search from memcmp to dedicated cmp function
> - Rewording of some commit messages
> 
> Aharon Landau (2):
>   RDMA/mlx5: Don't keep umrable 'page_shift' in cache entries
>   RDMA/mlx5: Remove explicit ODP cache entry
> 
> Michael Guralnik (4):
>   RDMA/mlx5: Change the cache structure to an RB-tree
>   RDMA/mlx5: Introduce mlx5r_cache_rb_key
>   RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow
>   RDMA/mlx5: Add work to remove temporary entries from the cache

Applied to for-next

Thanks,
Jason
