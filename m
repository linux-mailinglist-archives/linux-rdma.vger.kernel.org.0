Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BB1261D87
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 21:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbgIHTiW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 15:38:22 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5581 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730761AbgIHPzo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Sep 2020 11:55:44 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5794c90000>; Tue, 08 Sep 2020 07:27:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 07:28:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 08 Sep 2020 07:28:11 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 14:28:00 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Sep 2020 14:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anqLbhypsaJ8s0Cf4kU54TMoCPRYg0FEI81wmJkiAfiBgYOOmG4FDilwSU2wmGdRIhXuCXwUaD0Wr7PArlasltWtXuajTjzwEAohq143YgGlRA+xgBWFYZo/CfuLvKB9yQM0PqrZcHLFUfvodr3yXvr+sSh2/HOUR/oCc8IU5Etxp9gdMxrGeaPAlxObPDtosxJl7yExHsOC/92Wb6SjSmPoyz7EqrFvP7PKtzPofKWQbtrRGQSf8VC7FhfzfoiEBfnOiDsCMqIg/VsnEBehyhtrVa0gIqTML4ATn6udDdzIsOF1cFsS2BzcxzbK4ZOKslOYcEfxeqEdWrwezxlHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR6hFxoROnR2xJO8bJ5pp3aj5Q7yY/gQRMEdOB8+K1A=;
 b=ZPOfUEx2ueDW8Du2ZU5Ih2E8zvuqwcb4+wBQvVKhJhwdUwaIzRAYmWGYstrSBxgyEYMaGkEEFKrZm7oosRWXZ9SUcX/D1GxHor2h0jCHyWiVcvfIiFLMZhvA8zu5gj0bDwLowUYf7KABW9zvW2qTE4LgkUUmX8o4O2DasZIAwlnvhsbVLsJ/nFM2fvOpSxz1IWJOfN0txRwgWV/Vppo99bs57DHdX2za9vIq572VwEeAGYLWEKKtA5Qg/IgnCAKfZrP3aBm1W6ufjklBh/w1T0SSiicbyIwiuYewrNH8C+lecB+l/m9c8RGZ5zepD/KVWmgGHp2FqAw+DrCzSQXxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3303.namprd12.prod.outlook.com (2603:10b6:a03:131::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 14:27:58 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 14:27:58 +0000
Date:   Tue, 8 Sep 2020 11:27:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        <linux-rdma@vger.kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: Re: [PATCH rdma-next v1 3/3] RDMA: Fix link active_speed size
Message-ID: <20200908142756.GH9166@nvidia.com>
References: <20200902074503.743310-1-leon@kernel.org>
 <20200902074503.743310-4-leon@kernel.org> <20200908141924.GG9166@nvidia.com>
 <20200908142651.GE421756@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200908142651.GE421756@unreal>
X-ClientProxiedBy: MN2PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:208:236::28) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:208:236::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.11 via Frontend Transport; Tue, 8 Sep 2020 14:27:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kFebE-0030co-Fs; Tue, 08 Sep 2020 11:27:56 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d0d6c4f-2459-44d8-f09b-08d854036236
X-MS-TrafficTypeDiagnostic: BYAPR12MB3303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3303A6FC54A550852A395462C2290@BYAPR12MB3303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKDOraCPha/AJj4zJgEVchKBqVYv/8fO8aZ82+emKMvKABkEI4xA3b5pTvO9xymbJIyiEVMAmzmMxH0TQgUehn8yLBRyZH2TpNOgpZrn06Y9I8VsaeGrOGLgXBF2uPj0fhmsPw3YzEuK14KMPs2z/g6MreLjd6c2csP9NHh+serjQA6PD6hOe9N8HVcRv3CKxQLy44PZnPWEPtySmPZAHTfzTW+c5YVWdj7hJ1CJgCP1qf+tfFxFynL/MUeotxjaT7BvqaELI5Jgrjzv+JWhmCTyYzWKeTzb3xRpSjUT7zsPIfbL9YTobp1RyhQ38eR2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(316002)(478600001)(66946007)(83380400001)(9746002)(9786002)(1076003)(54906003)(86362001)(4326008)(186003)(26005)(33656002)(426003)(66556008)(7416002)(66476007)(2616005)(8676002)(36756003)(2906002)(6916009)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 201XP53659jp1WoTzORVzAbFGhlkQ+rQ0ifPMLrdHN2M1+2riiEbK+J2hKztOXzdrg39hIz6antsdrNM096geRLSP2V00PpVHpALnz1hmowjLogRIHccFg0JhE1xPpnY7Zc/HGMf5/1AZ+4YdgUEOX0l/xpZo7yMS9kAEMX45vCaha352KTGaSACg4AV5nE/0oH/xVEwtUmruvNweytfxLZjoVgXBeWe0ace7sMsFPByH399x6Mfw7tsdThr/UKgVXdAgXcDeTu2dPnNBaDY7mQKsCLJ3JsSimMGfVRgOGCBew10d6KHjN7nolGfEwJ4qtg53IQ/qlVonPCPV6q2SIfsmgbjQ9u2f9vHv1oQOH+0QiCTs3+sEXtp9VlEx8N5NOG+Vf8k/W+THatbZ3oZKfrUUOLTsNg7Uc5ffvVR4S2cxtwmKf/0qH7JD+OWUCoawG0SFt1d1ev3p9JDXoDOYPQ2VN/V4rn25huY6BYfXSKT0EwvGogtBY0r48Cau/pRBmV9YMoJz1oxtiPDptyKvKa71cOjqDCxZ1t5X9EaPS9ZPezWDMXajvLU6J49DfAHS5/GQEs2oh4kEImZoAoNyGdnFJd3jQ/3uTwCbdgt0BQNBe2Qby7qwX0VH4U59/FAf6zvSOfpG1REmXKRIfG8ig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0d6c4f-2459-44d8-f09b-08d854036236
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 14:27:58.4516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eP5Qx+PtvAxtvYNkiW98Bw2vhiICYhQTKIWClj8rfHBigRLrWysPV272zNpCGRyf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3303
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599575241; bh=TR6hFxoROnR2xJO8bJ5pp3aj5Q7yY/gQRMEdOB8+K1A=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
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
        b=hgdf7GcnhpE3ZPlIqATUHd4O7KkdE/Uq5YIsR8l1FCpi52vAfbK1lSEaE0uKECTP/
         YUvDHzAdkdDB94WSruq844lIMmyxlf1mUnZe9IYOmjfnOPvtE3rLN5b4YMRMb+F3yF
         h+L1sUIRcxymT+4oAnYl7rQdbmRFDqSciGdNMd2wxqyKMkIwtZwJq89KlQW5SQmhvv
         VD8Dx6KthrETkj68uin51e9RqPLhxZk0wEI4UDljXqbAHr7z03yf040jRH9QtPIJdk
         aC+Sm7XNfC71XH2HAZAfJxae6Lcq2EPRzV/losY3uWFzrT4ITAWngYRp9p0mFDyGiS
         dDht1yJGk1qBw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 08, 2020 at 05:26:51PM +0300, Leon Romanovsky wrote:
> On Tue, Sep 08, 2020 at 11:19:24AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 02, 2020 at 10:45:03AM +0300, Leon Romanovsky wrote:
> > > From: Aharon Landau <aharonl@mellanox.com>
> > >
> > > According to the IB spec active_speed size should be u16 and not u8 as
> > > before. Changing it to allow further extensions in offered speeds.
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Aharon Landau <aharonl@mellanox.com>
> > > Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > >  drivers/infiniband/core/uverbs_std_types_device.c | 3 ++-
> > >  drivers/infiniband/core/verbs.c                   | 2 +-
> > >  drivers/infiniband/hw/bnxt_re/bnxt_re.h           | 2 +-
> > >  drivers/infiniband/hw/hfi1/verbs.c                | 2 +-
> > >  drivers/infiniband/hw/mlx5/main.c                 | 8 ++------
> > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c       | 2 +-
> > >  drivers/infiniband/hw/qedr/verbs.c                | 2 +-
> > >  drivers/infiniband/hw/qib/qib.h                   | 6 +++---
> > >  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   | 2 +-
> > >  include/rdma/ib_verbs.h                           | 4 ++--
> > >  10 files changed, 15 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
> > > index 75df2094a010..7b03446b6936 100644
> > > +++ b/drivers/infiniband/core/uverbs_std_types_device.c
> > > @@ -165,7 +165,8 @@ void copy_port_attr_to_resp(struct ib_port_attr *attr,
> > >  	resp->subnet_timeout = attr->subnet_timeout;
> > >  	resp->init_type_reply = attr->init_type_reply;
> > >  	resp->active_width = attr->active_width;
> > > -	resp->active_speed = attr->active_speed;
> > > +	WARN_ON(attr->active_speed & ~0xFF);
> >
> > ?? This doesn't seem like a warn on situation..
> 
> Why? We are returning u8 to the user, so need to catch overflow.

We need to have actual backwards compat here, not just throw a warning
at the syscall boundary

Why can't it just be truncated?

Jason
