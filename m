Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D719B234B93
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 21:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGaTWZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 15:22:25 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:42992 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgGaTWY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Jul 2020 15:22:24 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f246f6d0000>; Sat, 01 Aug 2020 03:22:21 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 31 Jul 2020 12:22:21 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 31 Jul 2020 12:22:21 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul
 2020 19:22:20 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 31 Jul 2020 19:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REdoEEv3aUN3fbphiiFu3BdDHR0QuyU2z1vHjltQhjyNhGPtCRxBGf5lb034BuuRqLPFnFYkHVIFzdszWEJeStjK16q+v5bCTIlDyJBQSCOb0eZF2LgLCf3JlhtPIJ6wfBzKPGpo6Rl6PAjgCh01UjxJOn+Fk7VOpQ1VzL2zxTre+miQJbn02RlJg/aCu5hZRoh8GGwabyoEVvjpJY6j/vta2lwF2vL/bKP4x30i/MckqGnkH6o/U1c1ZB0+Z50nAnFX74yYvRHUtcXeJxI+u5jpy8ggZeVGJ6lMfCc0xfX29k2Z6z+FBTadQGbkAoO3e7FMs9zqz29mhM/5gmMDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSB0PqJ7xvOvP24IblKzKyIqp7C1915gKveO2TnOEIQ=;
 b=WXYOnrLSKBHfxzLGNYQE/HPJJYRugeTtrCkJD4saMNbJ3y22mp7zhlYh6USRhS9wCuL7vP5pD2NzpMUupDwrDSzHUUTVtkfmK/IqPPr+Dzx2RoQ0U4j1LbYlTP9vN5QA1yc4jEIP0OzC99NrStCPyzqlbtpOS8EzKyNz8gYsBjFBBrg3btejG5IsI3EgSsTXwzIrpHiZUBAUvlyhc692z1eSZNAVl5taTACJv7ss3EOhTdZnloUFqhWLiTp4nQ8bmita63b5sgLJIX+Lvmsm22s+F/QQEY/GAhrBE+lihSUQhO8Wltd9cqfHbxHTgvp7pKUz5KvsdyLM3hQXFkDF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3932.namprd12.prod.outlook.com (2603:10b6:5:1c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 31 Jul
 2020 19:22:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 19:22:17 +0000
Date:   Fri, 31 Jul 2020 16:22:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Zhu Yanjun <yanjunz@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Remove pkey table
Message-ID: <20200731192216.GA525516@nvidia.com>
References: <20200721101618.686110-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200721101618.686110-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR16CA0064.namprd16.prod.outlook.com
 (2603:10b6:208:234::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:208:234::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend Transport; Fri, 31 Jul 2020 19:22:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k1abg-002Ckr-O4; Fri, 31 Jul 2020 16:22:16 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e475b40-8dae-4b48-60e8-08d8358709f9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3932:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3932C326B00EEBE5243BE353C24E0@DM6PR12MB3932.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /T3LWz5htdxq8tS+J24ESWRb2xBfUjySDjw/s9IgqTes78Pz3Nz1wlQhEJAAMwftP3eQyQGDKyfIFp9JXM3UodmvWwOm/WtBAlShbLVwnwbnXYAWs1M3MVY1rm7my0W7WtdPWIEy+CVsr+EO+Ni+1Ory6kXMcwBuWRLtbhJNT521KXine+C8vFuuP8+acTUbEAANbORJr6aunpdPiqps6GKCy9qF7XqlFTR7IBqSs31c0JC9BSfJ1Vu9NIZeplgeI/I3pMSuKo79bjbv5rnzGMPd+Fd1KGQRn0tAD2cUOkMQ1+ODAxeMZKhXDPCXAhlwul5xoohu4JNUNLfYR9g5STz6WZRgjsnAjd/gSinJAW3aqrkwyYPsxd7wKtknB6XK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(2906002)(8676002)(36756003)(54906003)(2616005)(426003)(316002)(83380400001)(4326008)(26005)(5660300002)(1076003)(186003)(33656002)(66476007)(478600001)(66556008)(9746002)(86362001)(9786002)(66946007)(8936002)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: w16a7AeBJal/S97wFrp8u6kB4Cu7x8wiP34aBPalHFKArOpKGPMlfSyFsSzNBNNU693ZxGeSH230RLYZ5/YgY4Omrs9KjzY50tKgkEVkt6BRAB9TMXF0YW6/83F20vC4q8SQosFD8hDmZ5XSGCk0EDyBhdDnflFkWyyDWTr1pQH4uWyR9pY63o2vvCKxkSo3O0m8ai//awmZO5zCM7PeBkf3kTaR1xxaVm40DDRRvvnXxEtfMPSCHGbfWCui5CYvzSwvJoRuOgwyXQerXJHoBJ400Subusl5HrQoshEU4XTJTIbnvDWuJzRyL47MaIEj8aBS8nUgYJLfc8g/u6Ian/x2ritSUpgkZUyEHQLJi3YSZ0yWg2AqV1RsR7mUaRGw9Lf2lh7Z65QyIN6gQc4pJVzwx0V0venMAsip2p+3LDAc8Mo/sIeyGOpXRe8+rhmCEs1H3W10LjM4a93MofD5pAMs2cWKrRW9c/dbrBGLF3E1s/eQzijbCD8uhs9LJIR2W9J3fF35ZsMhWVr3sQVfV+JGQMzWNJZukWWm2+Vp3+Bn1bZz0U57qa+TdSmhydUtywJtUZR88R3XehbePnavysidRLSaMK8REkifJpOyeywfkLz7BHtyfc2Bd5cyBsrzKWZvrgQ9w8vgbNPuiIerxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e475b40-8dae-4b48-60e8-08d8358709f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 19:22:17.9169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKL/U1tcsgPnL7y1A3t4cKQiNCi10rOHSn2/tDAwdaWjQjXOOrZUvBPNfBfBVSsR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3932
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596223341; bh=cSB0PqJ7xvOvP24IblKzKyIqp7C1915gKveO2TnOEIQ=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=iGhAMpw0WC6EeSHtN1aI6M3IjtP82zroVUKnjvTxEa9kC5d5vVt4461g9RIvbstHK
         ke9Xaqn9PPjIHB56mgEnnsO9XdGomtdJ5r9CoxDYSwRab5wpQxrALi1nWIzQpNZg37
         PrxcWnhsElBWf44ksmeXutJOm0Xs3rcdGLpHN9MvP1vkKbbuH+pV5zgHVsMiT15r05
         WHxck9c5Fr4La2TMiaB67W6KK3pdXwnKyY1PdsP/9zIdHGprh5k1m3pdHuVwWLFb4Z
         k3gck5X6QVwabhYfcfotUbu7C6q9I43lFF0hnuaD6iQsYSiFstC2UMZodiar86FgTU
         +eHo7cKDkCSBg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 21, 2020 at 01:16:18PM +0300, Kamal Heib wrote:
> The RoCE spec require from RoCE devices to support only the defualt pkey,
> While the rxe driver maintain a 64 enties pkey table and use only the
> first entry. With that said remove the maintaing of the pkey table and
> used the default pkey when needed.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c       | 34 +++------------------------
>  drivers/infiniband/sw/rxe/rxe_param.h |  4 ++--
>  drivers/infiniband/sw/rxe/rxe_recv.c  | 29 ++++-------------------
>  drivers/infiniband/sw/rxe/rxe_req.c   |  5 +---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 17 +++-----------
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
>  6 files changed, 13 insertions(+), 77 deletions(-)

It looks OK to me, but this is not a 'fixes' so I dropped it.

There is no reason a rxe device should have anything other than a
single entry pkey table with the default value

Applied to for-next

Thanks,
Jason
