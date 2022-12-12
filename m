Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3ED64A2BC
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 15:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiLLOAK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 09:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiLLOAI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 09:00:08 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605A66438
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 06:00:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEPE7yp3I4EacTZn0VxfA2xCCqKnYu7kx6nnZoNxqm8ajOp63ofKlfLDBtwfgGfvIm5YcBVy+w6nZaJEYyqp1f1ojN7EeOvjzF4dH6fjHN1tQfukccOIo0K4SEeY+LQF6AXsU0jz1D2CkO9TFyVjJvEB6JHM/muZ0EF1RdLtCG8+kb3qW9PwKSS3z8m8nItQieiA1L8770JYF0pLtkd2bceXo57fP1qYPe1oATbmJJ9AM8TsRQyJnn5wGqXjqYdXiuKA6IiKI3QwSAC/ZN8yTDXEQm9QwZpP20ehhf3AClm94Z+bpSU4LI8YWwMeaMrSbhqnsGYT/NTXahviKPQmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5huCetp8VIB9DSu704bD5fIXXW4apJ5wj92v2Qs+o2M=;
 b=B2C6KXu8xkjMN5tjU1M7OaRseE8gsMuj9WXpcX0DeBv0PmcrfsFyKuxSxgNFVtsU3NdMAMf5j1CwhPwN14VlSLbWVMisH6BAzINrU58OfU7Yi9SqR4EQqByeV1Z4h4n5APyaFlwILHus6P3eBelWQmpshIedj04eZYUThHg+MybdyM5hT3g5Z7Mo1E+4M1GC3Oav4gwcCNJAOZQFxxzUdCpEAeKqq8W5LEsXdcrk1T+HAroZF6mNOU+48o7qhx3FwJ/1ui9LiypyliGhiwka4ompAEbZSfSjbGWjMHA2bnB7zNKSGojPogzpeKzhkE4KGfG3+tv6S8p9hl/TjL8F1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5huCetp8VIB9DSu704bD5fIXXW4apJ5wj92v2Qs+o2M=;
 b=Dxl0eTsWY/t6Sf9XIjokocTPbKmeicXt5zhokM1O67uTlVZTbgB0QXvipwLGjmbwQVtIdLwqbjAkNQMXbY50ykkz/fP+JWD5cC+5GrgeaiGi3u0AMmyKyfMXJEOSaM4RUxgj6ozYbGPAGzETdzX1lbTrt4WMf9mSf9NJbbD1sGx0LjtWHgZKMvvaUzxEh+xKYdPi+LTKwmkCh+Dyk3SZ0MtfXd6/jRZRUqx27nM2MhE5ihN79nEScEgNZYJ81Xp6xi7E53jL4b5ebTt6XxKBMF283WiivBy8FCFQZguWWksJ8vvhen1HWa8TYWwlenAuY5ucBVXk6PFchaTCzYw7pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4857.namprd12.prod.outlook.com (2603:10b6:610:64::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 14:00:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 14:00:04 +0000
Date:   Mon, 12 Dec 2022 10:00:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Patrisious Haddad <phaddad@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Wei Chen <harperchen1110@gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix resolve_prepare_src error
 cleanup
Message-ID: <Y5cz4hYrK8EqgN0h@nvidia.com>
References: <ec81a9d50462d9b9303966176b17b85f7dfbb96a.1670749660.git.leonro@nvidia.com>
 <Y5csPTRDNOIwf49T@nvidia.com>
 <81008c63-50e0-075a-6795-71ea3d08803c@nvidia.com>
 <Y5cv+z6cYWUV3ara@nvidia.com>
 <1a852181-8b9f-5f30-2c4a-fb3cb79802af@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a852181-8b9f-5f30-2c4a-fb3cb79802af@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: 0126659a-0f75-4d0b-f919-08dadc492b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ML19fHwIFQUZi8NoD3vKoFk5ySz9/7/bV6xZeDKLhchvLFbSVmC8I6NAutkaqtaVE3Y7QPFvaPs0AK7F0LF4SWq3LvDOcmbhGlNu0EQvXsJ6yAXZhKveap8Lz5/yHrFPrm+4AFLMkbxcpO7jF/9d9pcFocnL/sF6scMbiIUS5B2X6L24HKbi74g1EpGlm+dtzHz3/fa9cwF8RotpNihrgrAbHDOyu1GPBdG8tvddTuhgSrKO9ockKFwXRC60W0U/4Pc7ovKTpM9b0G8LQTlIewxv9k1egJSxtlPKbFh0sJPA8T5xIjNaQlUZojn8Bk+uQQx+DLDQ/8b5usc2em5kK7dii+ct1/XbEzUX5Iw8qYfCty/CSDin+3yLEx8IKoVEAyHjH3kUggo3Zv2P8jysoy+sqb5G7zpdiqThmfyRFZGUzB24Nm3gLHiZGQCZdOvfq2xykgltvqlKP6IdrMuV8FJbF3KKM0WDVT/FXbKx0/2fb3wbESI8HmFhEaTgyrZqP/ibvUXIydwrNOvPTM4leayhEmuG1iAaG0td3HtRTFGJWJqmiqwNxXajA+Kx28lXj8CRYkaFeNGhq60Mh0qK9JEY6Q/PCSI1gSLYjubcs/rUEHLzokrvzflOtL7EdWSBLUdQoerPaGdmsNnOELLOKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199015)(6486002)(478600001)(86362001)(36756003)(26005)(38100700002)(2616005)(186003)(6506007)(66476007)(4744005)(6862004)(5660300002)(4326008)(66556008)(66946007)(8676002)(6512007)(37006003)(6636002)(54906003)(316002)(2906002)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?24XSCcvPLld2sVsDgDErgID3QdW/E5a6rcEz75u7s6e1j+7aNR8xRI68xM85?=
 =?us-ascii?Q?dc1VhhN03W+kz7nIXw9saI22I/nqkMvfBJHC/8scIhw8Hc9uHWDGehW1K+mM?=
 =?us-ascii?Q?0E4MThZLfsui2nYyMvLgR6q6Br2c1vvWDBvqpQYn2UYE5w5EDkak5kW2JjCI?=
 =?us-ascii?Q?eylU70jZcyRkCHuDWZFk0YkfT3O3meS/ilE94PwIectymoKNVyupLbNOcr24?=
 =?us-ascii?Q?ecRO2gTvyOLyPvQxLQF+nebLETycfTswU1eA5CHwEzvooU9qpBv9aMhCmMf7?=
 =?us-ascii?Q?3K8BFPksqtADyKsn0JxPNJT6hGh58q9hpIWf6XZ2TUmDnoMMDAfWEfCjuaKt?=
 =?us-ascii?Q?h/Tvex/2a7f1IrhgyGv6ML1G7N5NqYPrN1tzVwQe5jJZK9mY29WNwB90o/5n?=
 =?us-ascii?Q?SiYXj8IWzD6elzve2jHQMJSiBbBGvXs5cvxOOEtzvq2CRubzX1cLFNJGtiIf?=
 =?us-ascii?Q?sN4WbewWyMlnJG2h61GV6AFzJhv0nISaTUE6Q6puzbEgbo0c6FiEAHmmDjPb?=
 =?us-ascii?Q?xgasE1LrsDe06dEGpVP4zK6swFptHkU/mN9CScPzoSDp/cAaw+f123P9gfuW?=
 =?us-ascii?Q?ovnMGry3lPIiGVPPTkLqeSsEGWJK0sQASAe9X+VQGp06oJTlVohyOoWSnXhI?=
 =?us-ascii?Q?jaU/a4Gq3mG6mk/FVAZsnJTdlPH8ZJjA+DmKxxrVfW/zlr7BVLBsCt5SnPiD?=
 =?us-ascii?Q?Jq7IIgcXKPYxOohILe/8QwLwI2LuRl3OSFxnnlGMe1f/C0bGT1o/3moQBKmn?=
 =?us-ascii?Q?pLWX/jl/kiZ8k5RxEAkWvVVixlh9m973u+UeV0tNwuDFevezN9TxmFGbb9R6?=
 =?us-ascii?Q?yXjevhYQ1yS7A2F87bD5C36Nx5IbxNwR3b/Z9KQkG12uTqrjufWMaM0BrIOz?=
 =?us-ascii?Q?rChPybL5WCktAqfVQSqeBMPFBPgxcsn8GBmhD8JXHD2f/Z00NfB3NJ3ewH0z?=
 =?us-ascii?Q?G0HQ1ZkBO+lh5U0Bo6eZW8rH938fDynxq2abKqhfbtFGA/sSIdbt49O3OS9Y?=
 =?us-ascii?Q?jMZ8O3Rw512CHYC4htNQeeu04SN2vFiCJjrBhshZPpxUZngg8rACVYoAMRkk?=
 =?us-ascii?Q?e9puzIidWsWpZlV5KmMMRRwjNTI6dbLnhYntT4DILiLMFbSdXq+5OgYcC3n4?=
 =?us-ascii?Q?dG6JjKRA7cp/vAgZOl7x64pTWEVRBicoCKKs4CRJ5qKe+mUQdvEW71Bh4Irs?=
 =?us-ascii?Q?Z8mCmPjU9+fqWIyDNH5mDtOWotUj/XEW31W5JGFut2C24UVZoJPwHIeJnTDI?=
 =?us-ascii?Q?+frC+xvqXOFGUegkXu7JhRmpTc29EDT2ls6qoTmlQkdscin2ph6eH4HQ/JDD?=
 =?us-ascii?Q?2PoB/Lcxhzhgn8OtdleKaPnMErQzPIbpHgdYe31AgIvn4cCoW9SJ/MNOSQVI?=
 =?us-ascii?Q?hMQgG1GsKWXMEHzitI6TxQgGxJQbweNpm9pheqsHPgh37Uwp3kivA/lLP0Vs?=
 =?us-ascii?Q?q55vdS2br9PIURtL0abcNOmB7ayx1PkL0h0E8MlHn3ypTDZf7vYxm1jc0dnj?=
 =?us-ascii?Q?BAdFq2VJMVfqJIGHr4NkS92Tz2B9A8LRCZIqdTNgRJKLtXQjbcZcEMBAnxf4?=
 =?us-ascii?Q?XcXKj/duhg5Qy9cjiH0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0126659a-0f75-4d0b-f919-08dadc492b0e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 14:00:04.2439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1dl7EJMowgEKCesnurLFYtAtn+SaqCjR4mHUHPqDnPD7eRhvBTPEGfNFVyOoVhc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 12, 2022 at 03:55:37PM +0200, Patrisious Haddad wrote:
> Agree, but changing the control flow of this function is really problematic
> , it was even tried before if you remember commit "e4103312d7b7a" , it got
> something to do with port allocation, I'll take another look over the code
> to see what other options we have though.

Yes, we've changed this function many times because it is badly
mis-designed

Jason
