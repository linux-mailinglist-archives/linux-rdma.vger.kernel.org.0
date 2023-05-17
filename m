Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3786705BDB
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 02:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjEQAMC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 May 2023 20:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjEQAL6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 May 2023 20:11:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22B2E52
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 17:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4kW7adKJiBwmMDp185tEk7t2xk0rCtZdc/AcxsD6vQV5LAA/saba1pEbjmE4YRQIfeaRtpN7dSfzdCKrLzwkRckFlqbXcf8iTSHCKxM/S5u+WeiiohU9Vu2r33ItV93rrOtC9+ygylXKBUvpNDCRv+yanxKBrXq/HDEBez9BmIzypZ9ERSs6PQ73RQVWxBMA1z+EvqBgQsUry4kBQgitcb8L5E1CvVB03JNTOe8cfU1rBEI1E3NgleNqEh7x/fiSxjthMhL0otgukRQl1e6lVGgn2e+0n2o+IN4XRsO7gnib1IsshGTrfrpNhABUTsF3QvJWeA1eB8apeo0n/LxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhYXGqhq8Dv+8ATQD2ahU4iCwt5NbwJA3HMLocCcW+M=;
 b=bv3U7SXmQBDuCwBeoHHmRLhqwirq9eheQP98UdjojSwW63Ihc0E7pLUhYOUsI8ntNHFpbkFeaiyTyNwti+ga+NN7gm2yI3BvqjcHe6DOM+6C/7OSyS0nd1CyExMvYQnNI67OWLSwf2zMOO3Bf7RqkLSsnHHw7+sREZOV2ESaXUxoghwISLxkw5ZLlDpHct7lQBoxbpFtwZ5ZDdyqgSPj/3yelyig2SHppisLrcY7IKhL0BbgKjvnB80cTqmt132Z5/rwDW9V41Mm9PVXlIns6+SXD1ldHn+msjt+vyn6AYwUDLR73aDs5Z9EoEp4EXAEz2wgNHk50axlVOPxfZhl+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhYXGqhq8Dv+8ATQD2ahU4iCwt5NbwJA3HMLocCcW+M=;
 b=XRQ4i7pNBn1Em3pBDqwzTysxUvdify6JIoE8PM+dntFLN9ONAvOmv4fhcZg8DrfAmZXNwMc8QkQ4jmTHjg9j4Sxy9xj1BzpJcJlT8nq7g3XKl3QLzaRVECc/7XuuOpLpZ2845ocwdgpXpeBgi/huIqvyvO9c/s0pjV/qviON766vp4Em5RJULFfGI9dj9dgEUAJ7eATs+VztLHqgGc1L7uBegJxjN1zzLsFQbBocKpzqyDbuIbipmIJNWspDK0CSr+hN6g4eb6RomkI7dbZ2Crxz92caYx2tAGS/Ofs3vE+Q1QR/XfY49oE7tC1O0XKCdRjBvMpDyXUw36hJXkCpCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 by CH2PR12MB4955.namprd12.prod.outlook.com (2603:10b6:610:68::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 00:11:45 +0000
Received: from MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::94b9:a372:438d:94a2]) by MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::94b9:a372:438d:94a2%7]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 00:11:45 +0000
Date:   Tue, 16 May 2023 21:11:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, rpearsonhpe@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Convert spin_{lock_bh,unlock_bh} to
 spin_{lock_irqsave,unlock_irqrestore}
Message-ID: <ZGQbwBeIqk6YMKuf@nvidia.com>
References: <20230510035056.881196-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510035056.881196-1-guoqing.jiang@linux.dev>
X-ClientProxiedBy: MN2PR19CA0004.namprd19.prod.outlook.com
 (2603:10b6:208:178::17) To MN0PR12MB5859.namprd12.prod.outlook.com
 (2603:10b6:208:37a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_|CH2PR12MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc00ede-fe8a-475a-6c97-08db566b4cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+e5w7ECm64+tEQwXKY6fd+K9sojfheZhH91RPYTPZhjkrFi7dFtVcID+deIK6yv3hCpNPAWZx6JAOgw5mkVitodrUBEJ6JHqbKAB5d7GryxAPuvgeRsHf2QILiDzzIHni2rWgz1DqOGP5zmHJKwk+scomF6oooqCJQECcZ38WBd5iG287NEmWcwAdp3pAEeBuJKRKLI7l/5sstBEsMLL9vly5KPbg9Z+fd2O4EMl+TuQRKplOuWjVmCa+MaspRKSvEgxQY5VTJ4aN0/WSuXlwV6IkGAj8z9+cEDogHHjxCCb3Cg784bJ5WhRbHAJeh4ZYrsrMrSuPDXO2DPh6thdWSyUobcOhg+NW8J3wa55EBPqFgTaeUuKytNA2V9Kt9SjHBNMG59pHlXEL2un6aDDK4cRyEHyQjfG/WFPiH6E9Bxts/6XaTNeRcdEV1m0dD37BOEzr+iRe80WD638rPb4J/0R8iDbVmCZQDAs9q8+jikgUtsmVtEsLmNWt9SkLYF/6wjiWONprY6bqJ7YQv6IVgBnGkXqSOPSuASPvK51IZiZOdlXJlhY+uOhpq0sN2E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5859.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(6916009)(4326008)(36756003)(2906002)(8936002)(5660300002)(8676002)(41300700001)(86362001)(316002)(66476007)(66946007)(66556008)(478600001)(6486002)(26005)(6512007)(6506007)(83380400001)(186003)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ady0v01iEv8LMgF4lkCYt+egg0haNDExUxP8rR0rHRckcHRqfcrWLRo8F8pf?=
 =?us-ascii?Q?2jH21VSMUk05pwGNsc/A5AaDVfP0HH94vhya7fxcC3WUdom0VoQI/veNXFOa?=
 =?us-ascii?Q?HqEBOZNvipOQvpfY5cjOqk0Xk2UiDOtAglwn5oRMkmim1pUsjuzU7kp8S7Ja?=
 =?us-ascii?Q?a1MLI5DC6qRiC6IOH11mB+7EU7ZQOsacBiIx77HWw6AHQ7qxiC1sxEBpOdNg?=
 =?us-ascii?Q?bkOeEy/45LZWeweHYBUoWgE3+EZBJ3sS0EzJHOYiQ4WV5TTn0z7wLXb3NMvo?=
 =?us-ascii?Q?3/BwV7kXCjrRunqoVuWcleknb4FOkPWsIjIOt83fBnNtnvSzIT2OvyJS78fG?=
 =?us-ascii?Q?i7+Pa1F/zi0z7duRU/6fLCTbhjl/DXbceNT0VT8OfasZq8AI3XXMijPx1Ay/?=
 =?us-ascii?Q?VsqXbPzaXFNIYhBaeVL6mJPFHxAi2nbyANXcf32c3bGmuELwIKMdgOYnyM3R?=
 =?us-ascii?Q?6FMsbju9enBeBns7v5TOS6uJSfduu/c+nP1eR0Bem0cYiPy3nIIXAO+nobVo?=
 =?us-ascii?Q?Mu+fyu+AAqMA/uksTfBluhBD6HMP9WP+H/GPf0+uFKsM/UqJzv05Sq5RK0HH?=
 =?us-ascii?Q?bvkiDmtfRsKRtxP7w0i8J/ip3D6EofemL03N6zg5J7seKBAM8j+vRL+EVv7W?=
 =?us-ascii?Q?oJSlnoxn2gdIW4haSfTbmS5WjRPuOIt3/5CHz1CFFLzYTbFpVTRdAVPe0Lxn?=
 =?us-ascii?Q?gyvAGwKXhlEjQjqiZQhTDPbdh/xvz8uOwr5I95CnParFUxIeROE1XjkjGvYL?=
 =?us-ascii?Q?gxj1dnkydmlg43Pauu4jX/dQIkcPGRYcTCTR5qTpzDU4tVcQIq1Syi/JUpXi?=
 =?us-ascii?Q?NvRSzzB8tzf70MXbeeBTw2D4sH/SLMIwDPM7ZgbbriM1R7dXTNTV+WU02a8Z?=
 =?us-ascii?Q?3k49C2ivhGZbfvt2fLQgDfOTdImh+rkFVFctHZOrffHpXwB/fl3abP5fK4c8?=
 =?us-ascii?Q?QBF75LDIGaLwdkHZJOfbJoUbdxLdU00PVjxeKm7kzfDTYKDFENhwk9120RXr?=
 =?us-ascii?Q?WYTMVB4qWxm5aLjiRzP/44EyUzJcENLZne/FkgwA4DF8+J+ESX9Qm9N8H2Da?=
 =?us-ascii?Q?G3pvmjBGMpjhqhY2cjxWn3x+QA57tC8waP19no5vemdA9re4xtlYc66cA7Bz?=
 =?us-ascii?Q?n9+Wg+bbRu6RCJJXG0p0Zl6cQRF8M/H2BcAZnDTUmUz2uri+UI6H5IeRfhYs?=
 =?us-ascii?Q?yn9/2/cSQn3by6C3xSArkFmLGlqECL5/QaCR5pdkHGbfSKMTOB07cdbwwz7F?=
 =?us-ascii?Q?DzzmWXnWcA5aetFY+yzSryF5nZFrRQn+aA0+AhJYay2EyQvaZinQSSJPdUmV?=
 =?us-ascii?Q?PUTVtOBtdkL4Nq27LzZfURVYC07huZBnHseYvHnt45/zM/xpqpjgude5KlcE?=
 =?us-ascii?Q?BONvTHYMgn4mqCYq51vxKZyclR2CmMUgQM36qjL3rbaODUmxmDOeGyemw3Ei?=
 =?us-ascii?Q?I4TSUwCGn6+oCHZqZePhSIwlDvgpmKfG7oQnPFMdp5MCQkjJV5MU1rFy4IXI?=
 =?us-ascii?Q?1KpXvF0M8v4v6UyD5Ovbvg9UXhCx/YNdleX3JRpobtC6GGZ32gUVlqvpj86Z?=
 =?us-ascii?Q?mxv6747M9DgkxtxKnaNaYHaahvDiVwfH+IYshHLE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc00ede-fe8a-475a-6c97-08db566b4cb9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5859.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 00:11:45.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcO4OfeeQtOI7vNEFVJGQ1RJazqL5wdg09w8WWXkLqmivrCDKo/VqEYeC7VOYe1W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4955
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 10, 2023 at 11:50:56AM +0800, Guoqing Jiang wrote:
> We need to call spin_lock_irqsave/spin_unlock_irqrestore for state_lock
> in rxe, otherwsie the callchain
> 
> ib_post_send_mad
> 	-> spin_lock_irqsave
> 	-> ib_post_send -> rxe_post_send
> 				-> spin_lock_bh
> 				-> spin_unlock_bh
> 	-> spin_unlock_irqrestore
> 
> caused below traces during run block nvmeof-mp/001 test.
..
 
> Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c  | 26 +++++++++++--------
>  drivers/infiniband/sw/rxe/rxe_net.c   |  7 +++---
>  drivers/infiniband/sw/rxe/rxe_qp.c    | 36 +++++++++++++++++----------
>  drivers/infiniband/sw/rxe/rxe_recv.c  |  9 ++++---
>  drivers/infiniband/sw/rxe/rxe_req.c   | 30 ++++++++++++----------
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 14 ++++++-----
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 25 ++++++++++---------
>  7 files changed, 86 insertions(+), 61 deletions(-)

Applied to for-rc, thanks

Jason
