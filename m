Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F29699958
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 16:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjBPP7S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 10:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBPP7Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 10:59:16 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DB34BE82;
        Thu, 16 Feb 2023 07:59:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLEM5N1cKDBeNPk7hEbV0H3q1Mqu9f2CeISMP1P9n7DeJ7kEQ5iPqgfWmihZeAmHrU9qe8TjWDkV2z7f/BLuyePRN266euI/Yx+NZkgB4iGBJuBqZFNe/xjNf1VA+FNXwprL+KtSH8KthqTfablw259iB2v78bGMqmJG385s8j4AOtsdlW76vka8T17c+mo20q4iy9SORbDeBDk35lOJd/KYydM+Hd1mXePNQLihaopOulG8+tHH6JEHw6C2QV/mGTuhU3tdUsva8lJ/W6c9Ht1ty6RLRLsXna93Exw7VmuSbaH13tnmQfu0X1dt5B7GglSkkX1df83hg51PsGTFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbiyhLmc+fqlMEMVNrHlvz3WRX8tqgg1v6OjDZ0q4PM=;
 b=ErFnoB3oMnd/Jd5aFVV5r4LBSLd10/xgJIOlAaDZWj5l+54Xd/p+CdbmWfI9De37ZQKlH6TMj52b04pAC9LSiLpZfnHzoVGrP4xMYCyON0kViPz+7DSBwS1wxB1Eryx1sgZn1IxaJamGNdZm92w1ZKDQtE/tQblc10rp9gLj+0SlUpOv9IIcreFdQzTEfEqLJlgRLK0pebgnPFLRc8m3jUzPlja0781XmiOKdbs6OM6qRHYe8LipUu1q0TEVA4qvJwFBLhYNa/96U9UbpYa3aNl9esLdf31yQJthD/7Bdhnh7osDzqROdhwErFJC5NNZ/4iEGddbvwH9GC5ixt4wKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbiyhLmc+fqlMEMVNrHlvz3WRX8tqgg1v6OjDZ0q4PM=;
 b=qync2XQ2xjEDXL5JGKQF0WdXdT0hi7Xrwh7nXy153xzG1HGgVzUNJEBlEEghWHlDRGCLWYD+g2zBNNMJnziEUtlrK621tY2Dwep44ro6BUtd5uFwGMZQX56OXwgtsAF7sT4qOTEEkx3o3h/8nP++HdzRljQ2x1GALPI1VTaKhtk3sfDDxe8cSIJvnDBOWBkl4bb0P9eG9iXOrr5om6NrcIy3JOC7yxFnEfnKaSGGGyYUHi0dUah+8LZlGuCGCxyHE8+cXUsLBknZeZFHUHGUVfUKXzrT6+2CNZiG0LcSiHFIlU4B7MDNQv+Y1Gr6OMBvb6AR67w1UH9Q4B9CjkEVBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 15:59:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 15:59:12 +0000
Date:   Thu, 16 Feb 2023 11:59:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Distinguish between sockaddr_in and
 sockaddr_in6 by size
Message-ID: <Y+5SzsEkbXp6GBgN@nvidia.com>
References: <20230208232549.never.139-kees@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208232549.never.139-kees@kernel.org>
X-ClientProxiedBy: BL1PR13CA0391.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c1ebd2-2379-4464-5db4-08db1036bf09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Er0JlCcsk7uhzAfF5q61O3l3hpTyNliLhGnFi87bdCWhbGJlhQkklAeiu98mtNQLggvYDP2l3gmgitKcv8A1bdHZeauwkWEeXJMPxU7Wv6ZS8aSYPKoQFqKWrMEdXZWeyM5smPJVIVP5zCqSAhkhlMhQWrD7zIgpQ1vF4YlVJX2Kxxnz2PKXuvF6fNO0Ly06BQw9XZBj5JdP+o2WG3rTbJ5goub6sLOUM+Bnq56JvT7HhEMjnBxBJNt5JA4lCXBja5Z3YB5OSrOGWj+GkvO2/XDjTdUNaMjlQSjCtskSMvy28zdAyYu/hfLwaQSO285ES07u7xxI01fo8MtatSEKhscuPYe2WjyQRyJq8sN9MOK0GLUmsoP3Tgo6DVUA25U2+aJjAVB+ttevlVH/upQJPD5SPHCecDrqbvTPxoR17gCYVQ4PowFEOU8Lw93vjMAv3M6cdpy3MV0jdQxKnNGMEqCtqCO7gXipyMA48t+jittzRW0RoIv570eDBE6fEgGRSgAPKDwXOlruQkaV0cqJjUOfxrr2Bg+Qjc3PGjKfLFWBaxz3QFDYmRGy11r/vFx7fioCbUOO76/PSWM0YVU9sQ4xzB3LRlEmiFynzgIxcbIR46KyDKI3whkz/IUaZsCnTskv7QUgSBYPbzTOXKVh7KlEfJMoqwl6Pj1XjYfaMfAfDP7xMqGuj3glE/w2+Qa1KJw4Uu89RhIYL9tmV/XY2Gn7bcddNcE+SaSEbcNSRbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199018)(41300700001)(7416002)(8936002)(478600001)(6486002)(966005)(316002)(5660300002)(4326008)(6916009)(66946007)(66556008)(66476007)(54906003)(8676002)(2906002)(36756003)(38100700002)(83380400001)(26005)(2616005)(6512007)(186003)(6506007)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZM4FyiYz6w6UB/jcqRWVbvItN3ORT4OimESlZcHc62dYg4kaJpM8tTkCBelR?=
 =?us-ascii?Q?nSLUqrOlBRnIeEKJyvSN0et5tqO63jBoV0rqsstDlgugXlEX2fp7YH+jOVUJ?=
 =?us-ascii?Q?jr+jC7IXbJLKBbdUCf1FbwKsiHtcR1OR9Gju/NkVYicz+OWmvKdXn3fQuJ3L?=
 =?us-ascii?Q?ngBTuhWwJimYzykF8lZ6vxUpFAc1aiLZLcp4z982jXzO8+m9t4GJ47A2tUxw?=
 =?us-ascii?Q?NSwIHFIstOk5E/DWqfdkbvmsoF12P5I+6OwPWSG5/dDB9Ekvu+EHonuQf+Zn?=
 =?us-ascii?Q?bvanSg4mr+AKqKafrd12tv0H6EPS+sbQ49c0n22K7uXgPqwcNsvXfJr7h8qV?=
 =?us-ascii?Q?IR+vs73A5ao38H54ICD51GC61tYpV0rgN+078x7oZa9ZTraLj4idwdBdYy93?=
 =?us-ascii?Q?QlfbyeZX189rfa+p5E6UQjRMAtq1EpCKu2eXecc9q9PGbz14qy/VZTV6jS+i?=
 =?us-ascii?Q?sFQTJWT39bkj7L+2D/vJIf3yaiS4P4QEuoFTcwRZCXre4pVMzrvi5u98IY5t?=
 =?us-ascii?Q?FwGFseaHpr+KaHu0odFio4iZkKVRh32P9Bc7cCarIYJKTVSrI3MpNnCh0j2J?=
 =?us-ascii?Q?NdiwqQDemJQ+63scwwuEjXZHSki8nhvS4GFC5PFFiHf1vo5zg9Wp5B30u8AA?=
 =?us-ascii?Q?+D9vtTQ7/axlZ7Un6JhuAA2uzR0PXX3aafMc5ooJk4WzJdIvIjCtMQyncq0X?=
 =?us-ascii?Q?heG1I0tc8BxHU1gkBZP/j7X7sAYsylXQ+q7LX02JvjNQRyFXV0rjQC+D8bmh?=
 =?us-ascii?Q?2jjCtcfBZZS9v8xJU8h1qL5qKOoKZjVQcpLQTQCpD5oxChZEcNNZg84q5hMV?=
 =?us-ascii?Q?0dxem7DPVGVT12zQI+uhLylzqoLRrrH/FVKCMQ575EU7jLmuaAJf0JQEXJgF?=
 =?us-ascii?Q?ecN+DcRVzAcshbUjCYMR5R1UFe+Q+3dBoiH6vck3rWH/UqtBtiUBRxxYnsgH?=
 =?us-ascii?Q?UOSwTGDdrt35dt93Nx09KKdIhd4Z4PieDlfmMGVob/YJ8eEleKEAtnJKscWm?=
 =?us-ascii?Q?Fuy0QuSUWMSSaij+hUIerSnfnHuMQ6VZqp4uGcKCy6rMXsBuzF7sYDgbrEhm?=
 =?us-ascii?Q?9SCBUKE8kbLInlxEMl5aHZnCHiZs/WS+O+tn92b4eSM3HekGOKCej8FvEI3m?=
 =?us-ascii?Q?VBurt4G6zUMCfrCHHnjI01sr+6s3NN0v2q78C9z4E2PHCyFSidUAhfjxtUs7?=
 =?us-ascii?Q?Kj9DvwgAfEIQxhB4lVOqb2bR13MNOj9raT8Nw9LafgGaRcGTKcNxSBjt9d4G?=
 =?us-ascii?Q?ch4s9wqQqcZhf1kZzQZD1BXRtUYGY1c/QOOFVQx3PwaOGbZGckUfz57LYpWc?=
 =?us-ascii?Q?KbJhxHmncBvA6PTcq1Ef4Z6cmBVWDbnm1sIiJ/y1PvRkK3tixu/l6xTYLyks?=
 =?us-ascii?Q?/N/kWv9wpwYDFyjLi8YNpZTOUugBNvutoj5m2vVa83v7Pr+wHncRwY9DLTVs?=
 =?us-ascii?Q?IT0uKb6RELLT+MqmR/JZgNqPZmrbvx0lc/GuD5+u2vzysazh91ob9C9LZT8d?=
 =?us-ascii?Q?1BB4IQNtL0A80H3lY7qbJxpR0Kaf7D92f02tH/Aki0Gw300BfTjTihd3aM+8?=
 =?us-ascii?Q?Uhc444iDx85BjHogojIl23wXfehmtevDzu/7zhnw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c1ebd2-2379-4464-5db4-08db1036bf09
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 15:59:12.4584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIM9kZn9WZ8Nn/U9HKNh9fEyh6FLs0/0oN1xg2yrGBKlaefgEPQBZKISCmBXypyG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 08, 2023 at 03:25:53PM -0800, Kees Cook wrote:
> Clang can do some aggressive inlining, which provides it with greater
> visibility into the sizes of various objects that are passed into
> helpers. Specifically, compare_netdev_and_ip() can see through the type
> given to the "sa" argument, which means it can generate code for "struct
> sockaddr_in" that would have been passed to ipv6_addr_cmp() (that expects
> to operate on the larger "struct sockaddr_in6"), which would result in a
> compile-time buffer overflow condition detected by memcmp(). Logically,
> this state isn't reachable due to the sa_family assignment two callers
> above and the check in compare_netdev_and_ip(). Instead, provide a
> compile-time check on sizes so the size-mismatched code will be elided
> when inlining. Avoids the following warning from Clang:
> 
> ../include/linux/fortify-string.h:652:4: error: call to '__read_overflow' declared with 'error' attribute: detected read beyond size of object (1st parameter)
>                         __read_overflow();
>                         ^
> note: In function 'cma_netevent_callback'
> note:   which inlined function 'node_from_ndev_ip'
> 1 error generated.
> 
> When the underlying object size is not known (e.g. with GCC and older
> Clang), the result of __builtin_object_size() is SIZE_MAX, which
> will also compile away, leaving the code as it was originally.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1687
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Mark Zhang <markzhang@nvidia.com>
> Cc: Patrisious Haddad <phaddad@nvidia.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org> # build
> ---
>  drivers/infiniband/core/cma.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

This seems hacky, but I guess I can see why it is unreasonable for the
compiler to track the sa_family in this case.

Applied to for next

Jason
