Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BAE34AD18
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 18:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCZRHZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 13:07:25 -0400
Received: from mail-dm6nam10on2070.outbound.protection.outlook.com ([40.107.93.70]:41057
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230179AbhCZRGx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Mar 2021 13:06:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4kMgYceLaIEl8nfB5fCN2bdwdHgYFQUXDBiph+7CcfO5VUh6Wx7Akw9JxgzEZkpcD8rjX/OOlRfo/IsXOnbFB01Z8Aktnj31rAjzllV91lnjMvOrrdrFcOgCL94azOoVgTA0cVVLw8srkWWNcfPalxEl1v+OhTkAkuwIR66qzVvbw9WfuJ3McbeADLwyZg30rJBvMlXQzBCBq2/T0ZVUDlhycuWYw647/oZkVJSsp0mi7ijVmp8p5QzoUNWELa+EiQc9f2Vg56lN0KI73xcPk1trhfAW06ARGd8Doq7nZH7mz3Yxe1DCrSH7j8Du6E/lWVmuG4TtC2QT2PHVHcktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjtmMLl3H1QSFJOTJU564843X3OqYBDlOHVf/2/PrAc=;
 b=jKuoLBj+jzcSJJcol0g+CAtZt+QD3e4oqAATbetOJMpRBX/JYRXXjBYP6LvlaU2JOTU3hdau+3e72ZcxbhF6DwOY40F09PHRELTViQ7qDe5JLcibiUb5OzpRCIsX7hRLtjhfFrjAfORUBqhJ6xPq+KsC0s2huOPBIcIcTR5LrimliTv7z6kxaKU58EO401L1X/AbVoFv8Jpxcgq8fmn33VzzatxCOnCCf2prbQ097R4Z/gDZYR/7jmbDF8HHXWhvWgFBGnVl5+HkTOKpX22qbK4qcKRzWfm1Hp7OOXsAp6CSkWvcEHJzB5IuvHUulCIcDrC4Bpr9bIME0EVe5ELYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjtmMLl3H1QSFJOTJU564843X3OqYBDlOHVf/2/PrAc=;
 b=Rg8cqmMtlC7uQy2ts+ktDIliWYtFjU+yOxmlKJ16iJL6JYuVKY8JFuCy2d1iX7vzYAMsGpBNXx4Y0QogQb08QAAZc0a4WhPtu6dHK86rVqY/KbxLUqOOGkq9D+GfX1WZWD73Hj5Y4nx/qqHBOmoAyQekA6vwTn2Sze6cpMXVtg5n+9K7WlRJorYNT07gn/GowcwcVnGRk5GPUoW26TzurUCy3hz6gj+7RunCGz1jd2gJLtNjaaVnQoMPsav2curs2btWLbzsUJWZ1T1cGkFqXKo3UjYlZxIAsqS5Dj4PgHkStPWL/ljp5rseh+Yp3uD17Io9+6ZEtH/PeR9x16DlCw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 17:06:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 17:06:51 +0000
Date:   Fri, 26 Mar 2021 14:06:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/core: Correct misspellings of two words in
 comments
Message-ID: <20210326170648.GD863945@nvidia.com>
References: <1616147749-49106-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616147749-49106-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:208:32d::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0034.namprd03.prod.outlook.com (2603:10b6:208:32d::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Fri, 26 Mar 2021 17:06:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPpv6-003d2P-LG; Fri, 26 Mar 2021 14:06:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcbdaa13-8e04-415a-3213-08d8f0798bf8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43882819F617C6A51508EF6AC2619@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kefjGZNsylELF896rp8iW8pMtpW/NFYMO2EnElS8tVX0aYQSfqA82zEKqRY2Bz5zHub7htvneuIYItT1Y4z2gfJJQqPIPmuquLo95W7GFgcvxFsyKJ0GXLtybQcFQQZlN9yVq464o8WbDta6Txz+qecaagjYV7OFVoHHsZa8pKKcaGnldr6LZhoInhIMntFHoAQmD36Kl0PR3nT8EdVv5OqoD8LbSxridpRMQwLEzRXyQlqcP4rImlkh1XHQfNV/IgJFtnPZ711ANPi/vYOq1XPvFz+Jz9Bx4e3WPmtkQK/TPqCbw8igv0KsoIMFpRtPfR7+qLQtKD5C6CKzQK2aU5f4ar1pps+frR27gpLJjDZtdG6PXnbJ9H1MgCGyFfopKhibgl6IZ0IEKZtgJV8JJvv5j8CYphY6uPr42S2rkRqcdbu7zJiiDUUw6Ddr1zHvN6eiZnPOdZRKW+LykQC3DQE9lHslRyky2rMJC2IOkRlZoBRt7BTzHnqjAMiLN29RHl+AdCMb4Orh1qfyOryb7zGBlaPVh9lyonBqTiw48ikw9tyG4jog+pvbiaHBnvnTtueKMA3Abmdbqavx4NWTEfWFQaiSfM5XIFuNHRrbi3NRa2rlVPNWJLQtyA9jhiarLUS/6XRkQJ5QrL6zsZQphLzUd22IDnyoAvvUewHjcayeXE0nrEc17XJtH7kuB8Lm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(8676002)(33656002)(478600001)(426003)(8936002)(36756003)(186003)(26005)(2616005)(83380400001)(6916009)(4744005)(66556008)(66476007)(5660300002)(2906002)(4326008)(86362001)(66946007)(316002)(9786002)(38100700001)(1076003)(9746002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?puhIXxZDSrGkgWFBJD+5ka8+po7ifYtC5IXRfe5EJousOXorV6u8C7yWBPEn?=
 =?us-ascii?Q?5JxQHGcj0HckYChIkV0GBOqgoN6IWGTOcLKK3NW+T+ikR/jNNpNWbpJo3WbH?=
 =?us-ascii?Q?JjoHZrbDL0NoQXqcqUCYDcqB0rNI/tOWqtoGT2Y85R2hQiXdVOAhLiiQuAyd?=
 =?us-ascii?Q?hdxwNSYOvQg6jBLqMBWg9pZ0qTl2N6Gsl0HFXI1L+eW8iUg9ztoLKcFfVPXE?=
 =?us-ascii?Q?Qbx4hMMW1Ae0x5k93gQhwO58Glqc8ViLxOtGRHW/vLjwvTuw4Nn1SVUO1boz?=
 =?us-ascii?Q?KtUzfwvh4e2JBVb8htU1HuNZ+UDcG4SNcmTYkDdgyoMnLSsgIlVgICtrS9FD?=
 =?us-ascii?Q?59yTx7HLPwcLwZOrE2CQZ64asp07ejuPeNMiAQfVNnrbJ2Pd22oEkVq5xxH7?=
 =?us-ascii?Q?XC17H+6orD+klxIaFmSHEa319k+3HeZ3C589hvQFjE9nPastOv+390nr/noG?=
 =?us-ascii?Q?Oodjs3O+BVL81pDNVgk9L14Mq1s/Ya9gWJ8mlyhq1AVqBWJTKxhB5fnBMitE?=
 =?us-ascii?Q?OoUZk+zc9JnXGhPgQkQIraioRGADZEgkuV2jvas7NtMZqpaHXIvUn4PfAU/h?=
 =?us-ascii?Q?TnQUa8cUOVfo2oh6PiVmdqOCJ+PccQitGXvncomAR7g+urlWJ9iu3NAcc9oF?=
 =?us-ascii?Q?NgIyp33wuW/IGI7symqJz1uqUL0NyHCSMyEz3C9su44x9B6GaNWhzJfpDKVW?=
 =?us-ascii?Q?66jokt2+IlT8M5pNVoUg6u1vOjz7WYI4sVUYNk8aNEASW2bdN0JFfzgAfdTy?=
 =?us-ascii?Q?yPs4CTqYJasYiVP5kIlZtmV/dWgGZB8tALMzIa+bbUyIMTEDj+G1ySroA/OI?=
 =?us-ascii?Q?c6Wxk8aizhmHPYaAjfnG1uvFirCN35wZVlBwqsOcRo+CFmWvZerJz7JdIo0Z?=
 =?us-ascii?Q?ChfBKycAcIsSPMsSesGrdhFY5tF4PvOC179iTPnThcPBxK7C8SwLaZeVhbLL?=
 =?us-ascii?Q?77HRZ04TSi5xE+hGKdqE2Xu5AD+Kxt3vyBi9jlRqEqxkse1jfvShdvSJDCq6?=
 =?us-ascii?Q?sbOMWVhABVPUsiry6JQ8+f5Lr7Zk+UYaztSnr0PSwrCJ4fpu0ex33IsbNlYH?=
 =?us-ascii?Q?fxjztx08mrjCjYQSNJ+48Sg5tsyqK0Z9kZ0iO7DjXtPjdpOCwnFnIiPumPp0?=
 =?us-ascii?Q?ITqFnvAzG0MM01dEDYHHWsNrzyv42kDvkGEooawyQ2FiipIuFmTuxkJMMtBq?=
 =?us-ascii?Q?sBTO3VTcFJseUcvCGqNzLk8ibikzLpj/SomIosAy9ZqbJ6copozumh+PgYqs?=
 =?us-ascii?Q?yczkF4wovEZ7WxjBSdGMFjScNmr1hH9n3jxnwMhGoCK0uZLEkxFzjWNh0FVV?=
 =?us-ascii?Q?yaq8nix+21+rOus7tLuPlZO7E796yPedSy5egHOxPVBXyA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbdaa13-8e04-415a-3213-08d8f0798bf8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 17:06:50.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sciCi8597Ijgi5r/BFzKei4LCi/10rPd4DM94ma6lWHibGfukgG6sq/aRCE8kctR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 05:55:49PM +0800, Weihang Li wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> Correct the following spelling errors:
> 1. shold -> should
> 2. uncontext -> ucontext
> 
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/rdma_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
