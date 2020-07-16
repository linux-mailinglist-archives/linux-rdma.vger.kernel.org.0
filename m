Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EDF222B55
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 20:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGPS5i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 14:57:38 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17729 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPS5i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jul 2020 14:57:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f10a3150000>; Thu, 16 Jul 2020 11:57:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 11:57:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 16 Jul 2020 11:57:37 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 18:57:34 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.55) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 18:57:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3SFn2I0Vy8qVjFKa/RtlRomDPlFMJ2UnV8j8JprNEJCHwykFQBr+EKOBqP/jc2D9XKI1a2SvO/Bt1W0jqS5puc8lKaOzx74eM4q3bWtvrCrxhx5TLlYh+e6YlmtL5KQQXct/0c06cvUyfJCpkEeAQc/kYs8xBH2CvhYFitc1SbII4LaebO5+ZBBfgirHUtdKccI35+Z2jz39x6aRuHbuYNgSc8rYo085wr1bzh4v0XtQ+X6XflViyoYCRO8aSB3bSfx9VxQ/Zf2iwmxI6XHIolbuc4mwafdT54jQ5rllyu+nDfYD2UTNivlxD/Op4rH8pQbk3QCyd6yoBn1fb1Y5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX1KamiKlG+YFkFDpH8wZp/tAI4GAU8AufEaiLUTToo=;
 b=kpordPEWxyu3C1sJubk0T0oakueu6veJ6onKArSdw1heikcpJpDqHRfsvaqCC2UOBbNL6Y++qf9XpDlfTuE520BardyxeP6EBc95XMQ/V7xU3GJ/78NQQ5XTwL0mdCmqwl14VbpW0kQBDSK8IWQIOwb4cFickjD3Ukp1trB7essCl8ZUDfMcfBU8iPrJkH3Xsdl5PDHfI+L6n9YOVBXq924daOiQA2+Ko5KiVrWuWC1Y2yZwe6QdrB0iMdCzGpryhN+pvIDrs+sus1IJlvEo5SL70e9GvCujUotTis14UWmO3XeeJq9ME+l1youh7J7LaSnanqO66ZXgNSI3JAqi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1436.namprd12.prod.outlook.com (2603:10b6:3:78::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Thu, 16 Jul 2020 18:57:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 18:57:32 +0000
Date:   Thu, 16 Jul 2020 15:57:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michal Kalderon <mkalderon@marvell.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Ariel Elior <aelior@marvell.com>,
        Yuval Basson <ybason@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 rdma-next 2/2] RDMA/qedr: Add EDPM max size to alloc
 ucontext response
Message-ID: <20200716185731.GD2021234@nvidia.com>
References: <20200707063100.3811-1-michal.kalderon@marvell.com>
 <20200707063100.3811-3-michal.kalderon@marvell.com>
 <20200716171055.GA2645531@nvidia.com>
 <MN2PR18MB31824C9F96D7F0D511D9B261A17F0@MN2PR18MB3182.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <MN2PR18MB31824C9F96D7F0D511D9B261A17F0@MN2PR18MB3182.namprd18.prod.outlook.com>
X-ClientProxiedBy: BL0PR0102CA0041.prod.exchangelabs.com
 (2603:10b6:208:25::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0041.prod.exchangelabs.com (2603:10b6:208:25::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 18:57:32 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw94V-00BDrn-Cv; Thu, 16 Jul 2020 15:57:31 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edd550b2-90ec-49b4-1710-08d829ba189d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1436:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14363E19E2D5D4BF58656270C27F0@DM5PR12MB1436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tN2oyOFz1jgzc9lIl/OyLRJWR0V64ZjU8RnLpvvSHflbvMYkqax5Qouwr3BfTYwPxF6yvA36OMYsjhvA4Pdl3ZzsPx3NqsEmQWP2YHCC6ZFqJaU4/qtigSdRwZ1FkkWNzVUCDAN/RuKx0DNLXMOF97o7xoS6UqIsnWprKQ915fNUOxGZfVAqICmyWTUPAjH1onptonMBVaUrsb+gVZS/X6HLtGD9ei159p11Wh+QAQNV7TRfwrE9p2mKtfh96YQ2HCoFMFE6AWmtCaPzquj6G59XUSCfsUcjCMGN7FnVwK1FD0j/UDmjBI8dSc6rkzflZKjnYtaWAphGYd7/BMVKnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(2616005)(4326008)(8936002)(426003)(478600001)(8676002)(83380400001)(186003)(86362001)(36756003)(26005)(5660300002)(1076003)(9786002)(9746002)(33656002)(66476007)(66946007)(2906002)(6916009)(66556008)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: clfe/VmbdAUwjlJkczPHoYEsk0HrkY9rAL4Y1uHuYHOAue9MGeBXJbUirrRwYtAfs2iQ/1QqXIhIV5JRexuBgYwgFyAI8IBZxiMElNKsUfnXhCybgehnX1Je9whxY6A/SO4P7pJ17ptOe+nCzOD8tecHY7pVEwelWT6EhhoN3ea8YaYj2l2dOGaLsV9LB0+G/Zwe2a4wNKrNLSR1Xw43rALQmyGt5pgJoqIrhaaWwW2lOg88d5pXgQmby3ad4ty9tbJr/2wAllU1/R6A3Q+Mo6PEHIeSilgiwWKAfaw7704pwuA3XcZmsZ2FcPO+RvveIRns+OiFMrDpXBg6qfsn/e3Ub8+Z5UsGVgUj1ne/hh1WiFw6AKMNiRZZPGdPdGQ/r7DSMkKLMhU14rsMbgHaqkRK8WP6/nOW5gNh87U56aiMagfx0uwafrSnsd1UMDQwDM1SqEyAzrWZ1snWLOX/DNJ55lGGDhMsrDgD7NF6I9w=
X-MS-Exchange-CrossTenant-Network-Message-Id: edd550b2-90ec-49b4-1710-08d829ba189d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 18:57:32.8038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2RdgPIfDhrz+lHhEsGWv2NrjJwS8O6hO7cVsrmlyTlRzlu3u+1ukpty6ugcCgoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1436
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594925845; bh=CX1KamiKlG+YFkFDpH8wZp/tAI4GAU8AufEaiLUTToo=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=copA7P7B5f+j1KuS0IDKRLq853lWBM/WLCmcTneKimHFuih1399eBkQyWHtBakffK
         3nC6J1NPPHb0DKSZqpsMf/wOpHeq4LtEHRZzBeISJRN386uUN43w79vJ+DmODVwdow
         Ldn7OhZcsogW3XOPxCklRQ0a/Ddue8ZEGiJIVbqRSbho1zzLEMcj4BY7eoFeumTqv/
         dK7+dZw9KS4Yjyu4NQqFUGvUB1VGtl7G5pFbJOieV0axqMGfEyBzWScpvDMWr8nGtl
         oB8zoUNPj6T0OsFQ+1yV7LEMUGYBtKGF5BLgmFVBhIgKDoK0vftm7eCMWRT+oSOEg6
         cJKTlakoGVNFA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 16, 2020 at 06:17:29PM +0000, Michal Kalderon wrote:
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
> > 
> > On Tue, Jul 07, 2020 at 09:31:00AM +0300, Michal Kalderon wrote:
> > > User space should receive the maximum edpm size from kernel driver,
> > > similar to other edpm/ldpm related limits.
> > > Add an additional parameter to the alloc_ucontext_resp structure for
> > > the edpm maximum size.
> > >
> > > In addition, pass an indication from user-space to kernel (and not
> > > just kernel to user) that the DPM sizes are supported.
> > >
> > > This is for supporting backward-forward compatibility between driver
> > > and lib for everything related to DPM transaction and limit sizes.
> > >
> > > This should have been part of commit mentioned in Fixes tag.
> > > Fixes: 93a3d05f9d68 ("RDMA/qedr: Add kernel capability flags for dpm
> > > enabled mode")
> > > Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> > > Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> > > drivers/infiniband/hw/qedr/verbs.c | 9 ++++++---
> > >  include/uapi/rdma/qedr-abi.h       | 6 +++++-
> > >  2 files changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/qedr/verbs.c
> > > b/drivers/infiniband/hw/qedr/verbs.c
> > > index fbb0c66c7f2c..cfe4cd637f1c 100644
> > > +++ b/drivers/infiniband/hw/qedr/verbs.c
> > > @@ -320,9 +320,12 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx,
> > struct ib_udata *udata)
> > >  				  QEDR_DPM_TYPE_ROCE_LEGACY |
> > >  				  QEDR_DPM_TYPE_ROCE_EDPM_MODE;
> > >
> > > -	uresp.dpm_flags |= QEDR_DPM_SIZES_SET;
> > > -	uresp.ldpm_limit_size = QEDR_LDPM_MAX_SIZE;
> > > -	uresp.edpm_trans_size = QEDR_EDPM_TRANS_SIZE;
> > > +	if (ureq.context_flags & QEDR_SUPPORT_DPM_SIZES) {
> > 
> > Why does this need an input flag just to set some outputs?
> > 
> > The usual truncate on not enough size should take care of it, right?
> At this point it just sets some output, but for future related changes around these sizes
> there will also be fw related configurations, we will need to know whether the lib supports
> accepting different sizes or not. This is for forward compatibility between libqedr and
> driver. 

I would be happier to see this flag introduced when it actually had a
purpose, as I really don't like the pattern of conditionally filling
uresp, but OK. Please delete this if when you make use of it the flag properly.

Jason
