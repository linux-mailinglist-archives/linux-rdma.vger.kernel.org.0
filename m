Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8093DF486
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 20:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbhHCSSB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 14:18:01 -0400
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:12641
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238252AbhHCSSB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 14:18:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEPVPSatRKGVcaG4eq9T2GoRs23SXGeyNXaR2YS2NzwBNMJ63Tav2q5vg0RiB42VyCo0VlOu5Z4SCdNLzymFl1sKBwn/CfDxZvJy+B+6ZqBlt7rGLHFqPKHUtM7UdC/sjARJOhg/japJwRQJmz9W0j4iT2unE6VDrE8zv9RsiqsRgEEVw3Aq3Ohf3YID/UxznrIQMHjPs2zq+Lf+fjfSPt4a+7YWyXqzHLBldIaIb5BYMJ8OFdPNflAk+m5B1eApfJOum5wEdWoJA/NhF8kb0OE6DpIKlNEE1fzb/AhxrL2UNdYXmGMuuNRNdKVZEYyKl/l6ICH1XTKKZv6OstGa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KC0h+4yoaZej1HwBDecMiCY5nK/FqDqIpOUN7Uf04U=;
 b=XTMoDzJd/DHgg0+rRGyk+KeQgZOIc2vcn55A6SJkbDqtlWCVN4P6b7iGI7zhwwZnhklwAzX3rpJ06gVu4NIsUntAR6oBFLm+EIKffhBP+3WWe2TgrS1UQHCzge4qMjPtTQ4S57u07JGzmIa2Y4Q7WZIHvQr5+mhVXFuDWR6wLZocG3DGvFd4vl2pKfLQiYeefDIeNRXAumv42OG0QAgOhOzRSkRGl3V0+m5LwHPL8msYkao5JsoSMhplWlCoGsIGbXRH1q0gOIbFI3sM55GRNaneEwugMpYPqB5N6k9uSZs6/dAE+3VYxbvHlg19PEDcE9uI9yfCC9CAl3k8SqJk5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KC0h+4yoaZej1HwBDecMiCY5nK/FqDqIpOUN7Uf04U=;
 b=hmCvEoqETUFlYxIbMatDt7dxJzByZQvwLOLiV6JQGpU7op1jkdf3aTptjBeG2Mvr4sBKqaDShRJfisemaOg+/6LTUXtNAp2MSmH96phiuzSkkYUlIqfOagVAJ1roXjy3va3tdCmu3QSiTb48+Zu59QL8JBMla0I/kwvOLgui+4IWxQjIdzIIGBRqeknyrh08f0hq7UWE15Tghg2h5A7PtPG1zitKzHgJxWrQ+PGHzd5NaKyhZSXZsrUi2AThKkpjx8cP++irKdSoJ0ItqsvN95PU2v+CcQ/yVht/xG8IKiJ4FTX9rvtfjsu5a7Q3Bh7fYfhYPWcNKrj0Z8Sv+s/0JA==
Received: from MWHPR02CA0019.namprd02.prod.outlook.com (2603:10b6:300:4b::29)
 by MWHPR12MB1839.namprd12.prod.outlook.com (2603:10b6:300:10b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 18:17:48 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::f3) by MWHPR02CA0019.outlook.office365.com
 (2603:10b6:300:4b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Tue, 3 Aug 2021 18:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 18:17:47 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 11:17:47 -0700
Received: from localhost (172.20.187.6) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug 2021 18:17:46
 +0000
Date:   Tue, 3 Aug 2021 21:17:42 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, Mark Zhang <markz@mellanox.com>,
        "Christoph Hellwig" <hch@infradead.org>
Subject: Re: [PATCH rdma-next v1 0/7] Separate user/kernel QP creation logic
Message-ID: <YQmIRgF7UOZLSX9W@unreal>
References: <cover.1626857976.git.leonro@nvidia.com>
 <YQmGsMPyLQ2decBD@unreal>
 <20210803181312.GD1721383@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210803181312.GD1721383@nvidia.com>
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 067383bc-5fe9-48ae-2dfe-08d956aaff74
X-MS-TrafficTypeDiagnostic: MWHPR12MB1839:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18399A9732CBDBBC555A63F7BDF09@MWHPR12MB1839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /k+DaM49uXxuRe7/Cwersg2+L3QsMz9JaxLLz+IfDnJkuFYGT0lKcR1/Tp+3lb/w+R5IKUl2+ffHQC+C4EYEjmHUZsyetzsKZI04s4OKZUjp2hMe8SZU1K8/nactC1olF7zXK7Piy+4INhxmF12dF7sdPoam+vukIe0p+AunxiNQ5QO0M1TrdxAp01JObPRPKl5rydaWr4uswT6w7/Rl8cWNimzcHNuhLAzwWgR/PSQuQEP7j5TglewpgEJTj+5HXyreiXLZamn1rU2QpG2zhgKvlyY697FcF0cHllCGSd/FS/C29z7O/wVDofG0FecYJmJI5F/L3RMP3BHVOf7HSCwg6yHaBFtj/l5EjMqcIuuSXYLndhZeLP8+nJS7qUiEiJ+DgFsUdvd/qcw/O6BFwezgXLP1ekjHJghO3NgXfP73ETpXal79X2Xnrb2rNOXOkO736LkgBNwRWpl6Q4cTn3VQU4bZiuIcchPlfsNzUMeXgPe4JQQUmkkgewTV8zqXkTbi5/9g+6dyly5brI1uAIvD/7GNlDWpTlan8+d/5gg1T4oEUnib6AVu2G6LCIbV0VTImYkTjNVE9+8lnvEk8d76CRIPY3LkFs3s3furF/HprbUMdgSl27u7fSv4g7a6HKa1lwhjczR12N/RB53wZ/5cvXzg6C6N+Njm2fnruVLbj6g3Wqm44irTLzS1pDje5S3QhLUVsKH2b8u4qr0Z/UGzPUGAHyUFwgDK5MF5wSDuZywAeYV5xcS3NXoNaEqd6Flir7fMFOkYwIxTqX1OtnluXAK6r0JilXYz190TMqU=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(7916004)(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(46966006)(86362001)(82740400003)(7636003)(2906002)(426003)(36860700001)(6636002)(356005)(316002)(336012)(33716001)(8936002)(478600001)(54906003)(4326008)(83380400001)(9686003)(186003)(82310400003)(70586007)(26005)(70206006)(16526019)(8676002)(6862004)(5660300002)(47076005)(6666004)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 18:17:47.7970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 067383bc-5fe9-48ae-2dfe-08d956aaff74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1839
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 03, 2021 at 03:13:12PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 03, 2021 at 09:10:56PM +0300, Leon Romanovsky wrote:
> > On Wed, Jul 21, 2021 at 12:07:03PM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Changelog:
> > > iv1:
> > >  * Fixed typo: incline -> inline/
> > >  * Dropped ib_create_qp_uverbs() wrapper in favour of direct call.
> > >  * Moved kernel-doc to the actual ib_create_qp() function that users will use.
> > > v0: https://lore.kernel.org/lkml/cover.1626846795.git.leonro@nvidia.com
> > > 
> > > Hi,
> > > 
> > > The "QP allocation" series shows clearly how convoluted the create QP
> > > flow and especially XRC_TGT flow, where it calls to kernel verb just
> > > to pass some parameters as NULL to the user create QP verb.
> > > 
> > > This series is a small step to make clean XRC_TGT flow by providing
> > > more clean user/kernel create QP verb separation.
> > > 
> > > It is based on the "QP allocation" series.
> > > 
> > > Thanks
> > > 
> > > Leon Romanovsky (7):
> > >   RDMA/mlx5: Delete not-available udata check
> > >   RDMA/core: Delete duplicated and unreachable code
> > >   RDMA/core: Remove protection from wrong in-kernel API usage
> > >   RDMA/core: Reorganize create QP low-level functions
> > >   RDMA/core: Configure selinux QP during creation
> > >   RDMA/core: Properly increment and decrement QP usecnts
> > >   RDMA/core: Create clean QP creations interface for uverbs
> > > 
> > >  drivers/infiniband/core/core_priv.h           |  59 +----
> > >  drivers/infiniband/core/uverbs_cmd.c          |  31 +--
> > >  drivers/infiniband/core/uverbs_std_types_qp.c |  29 +--
> > >  drivers/infiniband/core/verbs.c               | 208 +++++++++++-------
> > >  drivers/infiniband/hw/mlx5/qp.c               |   3 -
> > >  include/rdma/ib_verbs.h                       |  16 +-
> > >  6 files changed, 157 insertions(+), 189 deletions(-)
> > 
> > Jason,
> > 
> > Can we progress with this series too?
> 
> It doesn't apply, can you resend it quickly?

Why?

It is in my tree and it was on top of QP allocation patches.

Thanks


> 
> Jason
