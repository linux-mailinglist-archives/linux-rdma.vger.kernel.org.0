Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD063DF4A9
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 20:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbhHCSVw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 14:21:52 -0400
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:55521
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239300AbhHCSVh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 14:21:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn6MKmzduyR7+9MhiasQvmxKLpw+GFGBHUYKmAg5XDwNwUr38UnfZktji9sX6yuA7pnnibTSpYF5UFh8eyTb0tqYNoJ80iuIdsSZrkOLgTSPiQdM7vPi3jza/fbl/6jX6eQLnS2e866K/6OoJqjVG6hZUhLBS7DuCYqJ/krn422V85jbLG41jyFEzAzDGlJEYxbM2SeSBF+1wHYgRKbmn2tYPJ1jqd87eh6p2v+5BCNRsU04TX+oVqgJWQtTyi+NN6PG6lIOUGk/nmDDSytu9YDrYQh3RPZEHrt6pl4KqGfvFOLIAVzNOpjC6/NuHtClq7GewPKI58zrksNDO715Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecgU9yGGW61b8Lw3jhWWGB7at7JyWa2Swg6zkuEgm14=;
 b=gbaUpwZlKgsUPr6uf/ytSC/8wM4T8NyUj41GclZmfQjiK9ImHpB42z0b7G8+zpQRGHhlg1Xp825h9wQc6PpdY5kFGNbr2PbCiD6uF0+FaxCtejKPCl4SpbCYTfBMydlCnh7vUGZzIM9Sqr/l8x+XRnoK25h/QIMLHooogYxlgauT25Jft6265WiKpda5GjuA5xSk69m9n5QC4qRZduWHf8bl1TgEERkaM+DGDSFTrnDohcPHhzox0iowyGimiNHH/iR0KVgIAUJL5Tyey1Y/6PJmNVpRSubgE9mBzgEoua7q2RVZ4sW2ATg2waVrxrAPrXPbyZ2MFR/xuzd+DVlFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecgU9yGGW61b8Lw3jhWWGB7at7JyWa2Swg6zkuEgm14=;
 b=tPl2yYD5CqNOh8OKh1PWNvCNC0syptR+SzAr8ah0zxdaZTBmrhkkOt0pfCbg68KzxHeICWxa5fYCk/Kh8COR8ECPpAepOZqcgZySO1JQ6SkmpNXeV3OwbEAX8SsoG7IkB7wesWQk4X9Y7VqGy52wuC9A7bEH885y9MraPsaius8KXC6cM87EBSZobsmXi1zdB9OF94hT4ruRm7VUWTt30CihKQS4C52VEWub1ruXRY1/0B/GSVhjfteflLNfKnINUzUDcVXpY8SvG+QKh61AR6gQPsioLRST/6H+ZZr4zwec8+LVKxHQzjk/7uPr6wXFreGtWvVFxzkgJA6jozt6Fg==
Received: from DM5PR2201CA0003.namprd22.prod.outlook.com (2603:10b6:4:14::13)
 by BY5PR12MB5528.namprd12.prod.outlook.com (2603:10b6:a03:1c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 18:21:23 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::af) by DM5PR2201CA0003.outlook.office365.com
 (2603:10b6:4:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Tue, 3 Aug 2021 18:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 18:21:23 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 18:21:22 +0000
Received: from localhost (172.20.187.6) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug 2021 18:21:21
 +0000
Date:   Tue, 3 Aug 2021 21:21:18 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, Mark Zhang <markz@mellanox.com>,
        "Christoph Hellwig" <hch@infradead.org>
Subject: Re: [PATCH rdma-next v1 0/7] Separate user/kernel QP creation logic
Message-ID: <YQmJHvUBYXjr0cwD@unreal>
References: <cover.1626857976.git.leonro@nvidia.com>
 <YQmGsMPyLQ2decBD@unreal>
 <20210803181312.GD1721383@nvidia.com>
 <YQmIRgF7UOZLSX9W@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YQmIRgF7UOZLSX9W@unreal>
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b11c59f2-ca2f-492f-737d-08d956ab7fe9
X-MS-TrafficTypeDiagnostic: BY5PR12MB5528:
X-Microsoft-Antispam-PRVS: <BY5PR12MB55282CBD605CAFC618C1D948BDF09@BY5PR12MB5528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdQULpOwlmHSHPWuqekVpMqkSsDYTkFHwatiRnRJhAbHPM4SgYPZBbUzaDJ7yzOj+wTptq6t03vK0TY1mKN+6ooE4f/+0r7kXgqzTL10B7ZSWE2d5/oEuYK4O95w8+MYvKcfXZ+v/BW0QAEpWswllHqIO+CwCsuAH0qq/XQmmh9Mx/moour5yUJVTAfSqkQE+CrpQ9lMlOzsBxu80awY6cqiG0RnYspJkNHxBPwzrJYXbzOv1m3yfEBRcTdiXZ5xdEc/AT8XZG3BeH5WDs8l5KP8/TVyXtW7Vx92H4ZglSd5AAHPXTku8xWKhvpqO47dXPwnlha6ya/+6s17czpZ8Zsu3jxImFz1A0E7XnxgVXMgUsczmCijliy9p3jP1LhDazN83MDaebOyaWyvqbtGIjXpQfPLu2gP+aPicq5UsP9Sp4rVjnfiuaNAxI+5bdXbUj7h3HPPAch17u+hG5jhhE2vPjcOSv6a81ig9aSdR9zYSdsuBs0PXlK7OkVrCLB5YhXEXCu4TAoURB4tW0EvrO9kRtwotIrLpQ+uqSJ/VjWgQWA5swC6e9gW6rHPgpB3zpc45o+IpIRkfj/06cuUagSNdNSFxBBkUxnih4OXjWYJCPwQ+xe96/G/8+5QFLwJjsXKbyAWLFri/ZmxA3U+vRWXH82+Nhfmb39V0A+5OCw8PhHBFJ8rV5X+odPHuKmZ3OwPJAt/b0SbXlCOdpa4lEP12J1p3PUZdxaCLcZe+iAQs8tfnI7YRqQX+4/T1q7fnGpIllUd8OQvmzw9XK+g5rARf10uM5yw29PqspVc+1g=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(136003)(396003)(39860400002)(376002)(346002)(36840700001)(46966006)(426003)(82310400003)(4326008)(70206006)(70586007)(47076005)(6636002)(6666004)(6862004)(26005)(36906005)(5660300002)(33716001)(86362001)(966005)(7636003)(186003)(83380400001)(16526019)(8676002)(8936002)(316002)(82740400003)(336012)(356005)(36860700001)(9686003)(54906003)(478600001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 18:21:23.3439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b11c59f2-ca2f-492f-737d-08d956ab7fe9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5528
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 03, 2021 at 09:17:42PM +0300, Leon Romanovsky wrote:
> On Tue, Aug 03, 2021 at 03:13:12PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 03, 2021 at 09:10:56PM +0300, Leon Romanovsky wrote:
> > > On Wed, Jul 21, 2021 at 12:07:03PM +0300, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > Changelog:
> > > > iv1:
> > > >  * Fixed typo: incline -> inline/
> > > >  * Dropped ib_create_qp_uverbs() wrapper in favour of direct call.
> > > >  * Moved kernel-doc to the actual ib_create_qp() function that users will use.
> > > > v0: https://lore.kernel.org/lkml/cover.1626846795.git.leonro@nvidia.com
> > > > 
> > > > Hi,
> > > > 
> > > > The "QP allocation" series shows clearly how convoluted the create QP
> > > > flow and especially XRC_TGT flow, where it calls to kernel verb just
> > > > to pass some parameters as NULL to the user create QP verb.
> > > > 
> > > > This series is a small step to make clean XRC_TGT flow by providing
> > > > more clean user/kernel create QP verb separation.
> > > > 
> > > > It is based on the "QP allocation" series.
> > > > 
> > > > Thanks
> > > > 
> > > > Leon Romanovsky (7):
> > > >   RDMA/mlx5: Delete not-available udata check
> > > >   RDMA/core: Delete duplicated and unreachable code
> > > >   RDMA/core: Remove protection from wrong in-kernel API usage
> > > >   RDMA/core: Reorganize create QP low-level functions
> > > >   RDMA/core: Configure selinux QP during creation
> > > >   RDMA/core: Properly increment and decrement QP usecnts
> > > >   RDMA/core: Create clean QP creations interface for uverbs
> > > > 
> > > >  drivers/infiniband/core/core_priv.h           |  59 +----
> > > >  drivers/infiniband/core/uverbs_cmd.c          |  31 +--
> > > >  drivers/infiniband/core/uverbs_std_types_qp.c |  29 +--
> > > >  drivers/infiniband/core/verbs.c               | 208 +++++++++++-------
> > > >  drivers/infiniband/hw/mlx5/qp.c               |   3 -
> > > >  include/rdma/ib_verbs.h                       |  16 +-
> > > >  6 files changed, 157 insertions(+), 189 deletions(-)
> > > 
> > > Jason,
> > > 
> > > Can we progress with this series too?
> > 
> > It doesn't apply, can you resend it quickly?
> 
> Why?
> 
> It is in my tree and it was on top of QP allocation patches.

I resent the series.

Thanks

> 
> Thanks
> 
> 
> > 
> > Jason
