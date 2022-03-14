Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717E94D908A
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Mar 2022 00:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiCNXpb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Mar 2022 19:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbiCNXpa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Mar 2022 19:45:30 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2074.outbound.protection.outlook.com [40.107.100.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9EB1E3F4
        for <linux-rdma@vger.kernel.org>; Mon, 14 Mar 2022 16:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEF9ltz1QHBdQCWeh/MJEaU1NX31T5Aouc/WxcKoHamzgp1nO4xbuhH/mOKt9wWaJt3BEiXV3YtTHfwu3cr/k2EzxG6CTXS3Q/wUnpFCpjj8Yz3t7wXrl/v1IItQIKmuiMdUyZg1n2C5ulSEqdd7Bid4zBwt07Oovzz++/qPqMIgjR1yJc4e357aFcj9llCQcfEzaitOMd74T6GZAyc5+Y18ho63EYFcM9nEvQ+vEUErjLswYZf2K/YlvaVlHiCvvCO2I0DAn8GcF+hlcnwCagcLkGXL7ljATK+JnNiGKxH4/t69GDzqpACuY2y7Yq5BaSAISkuQrTivjcW8A9R5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mONmbo1Qj9bhAUJuuIA+A32xMw7IQ5pLAi8zuDidQQw=;
 b=n6aseAfComVDaOAO3DqKWR/tScCBxoIo3rs1N7GyU99bAiFZrFDkchK9EgyiaBdgwb5L6RACoLgcGf1741jYRgJZbOk/8lw0xqS9dhoEjIkAEQTBmxtimZOhawza6/kj/ioXCDmXnNnrKYHVeBcOiwU9LcPMXgS4HHs6xwv06/9TV8q1GfmKyMO0Qugyud0VWnUq29X+EKgJii2HiaZO0KgcdYzDX+YsfCRejyKgsNHC4WTXDSdr21HjJooJ+NOalYxG+LKiOVQMerw0Igc2yLitbBAz7w13h3OISuJZImJON/8Oydw6im5mQ+hH4aVoYDguriQck4GpkaNdq6Wt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mONmbo1Qj9bhAUJuuIA+A32xMw7IQ5pLAi8zuDidQQw=;
 b=FjUejmZ2wb4qYf+Tvc4qwUx384Ly1DOHoYP+f31OYqUkfLnoUodM5WcXWFIUVCRCUZOtVW1OMdMdJxU9wSktmzko1hxYnca2r2dbNd9+PGU2UJGCPAx8guFHg0ptgZUu6vOCXUzBT2rFKeL54WRz4VHLol3LedpdKi8v0WaOb3hqWOE231ff5upAAhP1igpEy/Qs6FxrnYiKqJ0xcjG35uaJH4ao4+PxeTS9RD4hQnPMLaarOxQPLfaIotAZq4mJYaBr8Rubz7g4Jp7RQaKHdLeDbsJ4vz9B4RRtoWAoVn8+Mpyy+J9aW0GGQsbhI4OufGsw6SGexPM+2+d00RPLCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3702.namprd12.prod.outlook.com (2603:10b6:610:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 23:44:18 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 23:44:18 +0000
Date:   Mon, 14 Mar 2022 20:44:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 1/2] RDMA/rxe: change variable and function argument
 to proper type
Message-ID: <20220314234417.GB172564@nvidia.com>
References: <20220307145047.3235675-1-cgxu519@mykernel.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307145047.3235675-1-cgxu519@mykernel.net>
X-ClientProxiedBy: BL0PR02CA0098.namprd02.prod.outlook.com
 (2603:10b6:208:51::39) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5141f1c3-f882-4e4d-0499-08da06148e88
X-MS-TrafficTypeDiagnostic: CH2PR12MB3702:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3702C5DDF797CFBC722765BBC20F9@CH2PR12MB3702.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9621lw64RXFajRPBU3IjcYM/XG3++updY0wQsC1QifW+DfaTUV7jTvD4kZVx3giRx8hq7khHaJXHA7JrfTqzns/Z/8xxuWLiOSH2N03Y2Eu1GSRw/0BipvLnSUVhpZc8iJdksu1vYURXXhI1PQwRw14C19TG5dZyTaxbVG4vIwiaGXO8TBENn7A9Ql9K+qrqyKVvjD+Rw0izdeZw599hdFp00kRaxeQMUxQy9E02qGt0P+4ue+6r/pEdb6ozbjscUqMkba5snxlbOl/9aZ8xtzf6wwTHRNconROFmuVM7bcMJSNLv+dgKqqZck1889PDIpXdinvZqbRLhEEbLWfQIpsHNFsdUp6FnpC+7YCDcWeMolMGsR00mlO/5BZtNpObxJpb9yxQUSAXj7Tck0Oc71Dukla7Q/a5dWF7/bQNUaEDhAXoIRAXAyXFsg6llun7QGJ+hMhMXY/JKurgqsLG3kiHr8N4t26vtNRbZtnNLwt1hLqL2t6s6hbQO6EsQYIWdJ+He2osaiti8FmNvHqY6P1hsD1Yif2vVtb2BGvfbVW4L4o0rx5cuqEstJXKg2hSvhyqbug3zagA4DXSlyyiiip3/fSmSpKO2jFN85k9vbRKP/Lm34EDonlPZ3kz4sUW5Tq8e43h8ZREO3X9uS4vUO3opG9M75sVNKH4N0b7T6z7J5HgCAhTJUuuEzBcAjHCV9WiFtOw6DiVTYZozM4jDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(38100700002)(316002)(8676002)(26005)(186003)(83380400001)(4326008)(6916009)(1076003)(6512007)(86362001)(33656002)(6486002)(2906002)(5660300002)(4744005)(66946007)(6506007)(66476007)(66556008)(508600001)(8936002)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0hIUkmw2wsmCRSoIrAoxdKlacwSkBZnh1Tg3/QzipeGk3OcY3HHcO+vAciCE?=
 =?us-ascii?Q?6vW429I69CrMqG0fMm+eCTi0RMyqtHuR/9RaixG2PoX1MLxXX+oXvkVQelat?=
 =?us-ascii?Q?DAG8jBWPbZbEsonKpvv+dTzcCV/MnYlOV61DR10NeaYs9NywuzW17WMPx4FS?=
 =?us-ascii?Q?qrQ6eUcaWXDuWLaJrvsrcs0Ug6bGE9fdSmIftZWC7BiZeuJGoEteckA731nW?=
 =?us-ascii?Q?6xUrxsntDp+qcUHpxRiPG4s5hQNq5wcvpGiuEm/EN2gcnsZElHk6Ori9Q0cU?=
 =?us-ascii?Q?h7YM3Gp5J4scyNNlgPc07ZotkrhXGj6hn25WBMH1CdBVIuTkQuB8uBuKIRuT?=
 =?us-ascii?Q?2BsjZcWeExRq88T4NSrs5fnaAIqk56/HpeQNmgE4NO5ZKFNK8zW3rMKQ2Qzj?=
 =?us-ascii?Q?As1iR8sY3wEm4lj9Nd6IaHDLpb04wOUg4FMBSSxJnzlcN6kl8oeNu9XWsF2c?=
 =?us-ascii?Q?+K4XTZ79oG+TojBKuX6Erw/PAATTBhGUAoDHzgph7mfpbHUzmugxfMheSJ42?=
 =?us-ascii?Q?fks3yJM7gb1dhK9eukbszMAR8X+cz+I8AMbnknt4BFrwTUWnpjkxpr94J39x?=
 =?us-ascii?Q?JmKtUdlBPdbldhPB5R5XsF0FaTWqDzFKyseIqMGamS86uYOnEUqz/8g2o9Y7?=
 =?us-ascii?Q?fXq6yeuHTJV0yQvkwsawHovmimNqyjkLvffInL4eI5JfbeOqISHbbMAsUQXz?=
 =?us-ascii?Q?0P2r4iVm7dv483UKv99LIr9VTctdNMrYwnaLBK6mtnYEWt2zZBga/J0YaTLJ?=
 =?us-ascii?Q?3mg7jNO/6cHOKReCkbk1+3sFfHVe8zOCJclJkRx7NiMPgb1erglg2+0FlJrW?=
 =?us-ascii?Q?9WDsEUn5cgxQTeBZ3HGYwAPc/qXGCTZwJj+HS5zybdGjkYO/QsusmxlVgYVa?=
 =?us-ascii?Q?6ARVsimXHlEEyTaZCTmo5bB2AZC65UWPqlHSc/EVujaT/qMosmkf31MV2Owx?=
 =?us-ascii?Q?2zwr+MgRF/8frU7iSeR8AO5ifBjCgTGP+/AsbxZek8YAbyy5XiP0H66IaRxK?=
 =?us-ascii?Q?DWpmCJnb4vW+8owdrKtJZn+OU09yRc1gxHSPHEY1R6zLl9Ob8IxrlQgiMJQZ?=
 =?us-ascii?Q?rTfRCAGAOBDI31Nn/Y9GBUmlrsE155FUSVjyyVWRbvPb8HeJv/w5ZBxBlnFG?=
 =?us-ascii?Q?fDpNV2UFQZp9EeO/2i/mVezxiafKB1RVIzVjFnCfo09Ajo1ZevxtkPGrvIF/?=
 =?us-ascii?Q?Veltn7V4SzCQmPBjo913yN/n2JVieRV8OMOB3aYaliiH6W9PwkG2EajJVajW?=
 =?us-ascii?Q?+EP8F8T5rQA1V8VSDAKhS4LtCG0WVSUaKUTyFxenLueEslyFpxg92FyzAJok?=
 =?us-ascii?Q?tW7r/MZfoITXbVP+fSUYSj/P74L9WePCVFkjpSc20DfLKhVRCgPIoTKRrGNI?=
 =?us-ascii?Q?mCBgP6RGX3vhLk9GdEeyU0Ld9S3Dl1iAn7asUDMROnkt+QXq3wz98FGDxCs8?=
 =?us-ascii?Q?WvQX0ewv6oxkKcKNiNWFdOpQYYCY6dlu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5141f1c3-f882-4e4d-0499-08da06148e88
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 23:44:18.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3qmXyR0ozLEI38WrpBzSDMihhWyfbOxMBOzM9wP8V+wS8YKEZaKsgKXlox92mEz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3702
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 07, 2022 at 10:50:46PM +0800, Chengguang Xu wrote:
> The type of wqe length is u32 so in order to avoid overflow
> and shadow casting change variable and relevant function argument to
> proper type.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Both patches applied to for-next, thanks

Jason
