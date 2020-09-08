Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143A9262086
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgIHUND (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 16:13:03 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16325 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbgIHPLR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Sep 2020 11:11:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5799330002>; Tue, 08 Sep 2020 07:46:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 07:47:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Sep 2020 07:47:02 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 14:46:50 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Sep 2020 14:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXUuqbR+1DoLwLQiNjGYMA/4KcoF9yvKs3inXnkNVfkNzOWNPNFws9c6kgfpfWOTMBohxPR8qbW95izyPnWffJRcFJsMOceacrkqIv+pvPeQ4rHPIoS/eV21PJUCU5KoQ39F8ANVT+GnPkDSEckUHR3Ax+zrcrGrlADobGjvlxhVk1/+F9ksfDRfCL05mP3IFUHMoiIlF+vnrCiMUEgyHz8RdzsX0vgTy31IrD/RdhHG6pWwklewyEUxOai9vDKQOGoXBwNF3/NM49r6Jea2jB2aNoaUjHkvkF9mtjWLl7NPWegGi6/Lc0l6L3EWaYeikcqXlQMU+1XXuddnCEsnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZlP9MiNwSB6ktfMRIfqOCHBIpREtQo38AQVbDi4nFM=;
 b=U6NqVgqO32/Azu5kxYiACuplYmeDLyilMtip8qSwYW6zCFFIyBoAXxAlY+3e2SgPFYqBk9skeWWWlRqKZPlJFUOsBzP3YnCOKU3BWJlYFLX1lPnyOn154dAlDTIX/bI/wxnSPsvcYUYT/VjHdVKcj0nMOrtCGyASdNx9vUpNFW1mKmO4aF3ASn8v1ECtStncuSJwtQZbH2GJd0hITOf/+kahFN/+eoA2TIxTMYG/OgKNOnxkMUXaDq2DPu5K09ZYx0eTeGqNEtBjeqZZwcYy7LGitAy27tjBGLendDZ6Al9L7dKkKTZV6PIpX9baKYmSVLACGwekEhUu14tVCijYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Tue, 8 Sep
 2020 14:46:49 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 14:46:49 +0000
Date:   Tue, 8 Sep 2020 11:46:46 -0300
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
Message-ID: <20200908144646.GJ9166@nvidia.com>
References: <20200902074503.743310-1-leon@kernel.org>
 <20200902074503.743310-4-leon@kernel.org> <20200908141924.GG9166@nvidia.com>
 <20200908142651.GE421756@unreal> <20200908142756.GH9166@nvidia.com>
 <20200908144205.GF421756@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200908144205.GF421756@unreal>
X-ClientProxiedBy: BL0PR01CA0029.prod.exchangelabs.com (2603:10b6:208:71::42)
 To BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR01CA0029.prod.exchangelabs.com (2603:10b6:208:71::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Tue, 8 Sep 2020 14:46:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kFetS-00316A-DR; Tue, 08 Sep 2020 11:46:46 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2e52240-d2a0-4b36-bc52-08d854060400
X-MS-TrafficTypeDiagnostic: BY5PR12MB4067:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB40677DCF6AF3C1A399D35C42C2290@BY5PR12MB4067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opfsA5TPIBODRdZ4mkA2tfNLc8iTqVbPuJlY7OFBcEu3cihuCI9cu9cf8XUpukZ3oWv7YZwJrvl8jFZWkZR5UHx8End6F0XvFFxfhlGJF+JlTSL30qUaOVcIY36rFeFJv/50LEH+SRpi0pobJFiYZSuhU+uqsGvsZUCLJ34V2kiNsc5EvKfwBJ1GicCdxvxj0/MogCL6qnrpea9GIcJtrNwa6tHrsu/iNmRURkv6Iwl8d3kNz9PIgXxAu3xIDNXVJ0MYw/nuDktfM63zWh0CD0B19zPo6m1e6Zzj+zFhBHAl3I6IDIksRncwXXLgDi7g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(26005)(1076003)(54906003)(2906002)(9786002)(86362001)(9746002)(7416002)(33656002)(8936002)(5660300002)(478600001)(316002)(186003)(83380400001)(8676002)(6916009)(66946007)(426003)(66556008)(66476007)(4326008)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UtUdY1Tomo3+mlcjMv53rPKNWXm/8ehilHvWsKNRuRVyEiwqROzyrykeGuQgR99r5bMmD5xFAggm+JkT3UU6HfIe2d1ZWGbUvsXTh6opi8NJdCqzUBVJSx/fLwUYmMh5ZqHYnuBlsUS98R1GIXINX4Rkje+dXWOncBRbS7ka/jqFfTm1DMD4NhTicu/9jrsbsCR6I9pSqLsU8v2z+PHVdSixIu4xq/EaFB3Q7GJeUaStlKhPkGtUJ17AKSExnc573ETyw+bJq0pGh0QiybOk7gYdH6xS3TvZsK2OykfQuiRfZV7bxC09ahQaRSZ2c0vZ2k4+F+oCpXJmGyDy+JgqG71TLRoRT/7176XmB6rBDj8aFILzAKelAo6Ndenplh6PAvpJGk5fBaGl9DJitUb7bm1j+tghq5GvFrxBwpClnG7sPJ4z36zLee9dUbqUIMabE0/as9qh9dW6NvwxySYocQkwpTf/DQttwG15Ep6Dwkk014nNrNfbFLp0w8T5oHRX8eTJ0nEP5xlB4TOowIsCmd3i31DvZYDYUyHiZSr3T6N98cykV2f8hC8u7t2qkZtuM2PFI/Gp8OH7J4iZU7waXipG06sE7RKm0XpUf/mbMo2pWNjJWOhyWs/W4ycNBjvzyGtYrXNmZWig9u2WnGJklg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e52240-d2a0-4b36-bc52-08d854060400
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 14:46:48.8947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhUApjbRrFrtn4+fKimiqNRuL4dK++KDgIZQ2M1Lb69xW2XvhMZhyzlhJklz98Ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599576371; bh=uZlP9MiNwSB6ktfMRIfqOCHBIpREtQo38AQVbDi4nFM=;
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
        b=h7MvVa7ZD0jFBmGttqcLm9SKSxW2jz1BFfQgZdMEyTtlZq3Dl8E4oZzYEvZVURTup
         T8dI7c4uN8NEyQJAE4hiV4sK7HXjFJdCHke9N/tzR9WA8dh9H9TkJpxBQsDppo/EIF
         u8qDgXp4JTaV4qRrP/bxuy1zT8RxysSfhe140lwmAcGYk5gUreZMFAzqMew7E69NH6
         jqmOxMa0NoxEabVYJuvAcWB9QM+qh9+09jeAFq1r7dzmdHsC1SMITovCMLn0k3rwad
         OUk9zHkPaMlEcPbZLcmwSUhxzH4SICZILjhivgH8+2TS5krwbjhDnXu+sJs/BO3F4d
         SBbn+RzTK3Veg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 08, 2020 at 05:42:05PM +0300, Leon Romanovsky wrote:
> On Tue, Sep 08, 2020 at 11:27:56AM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 08, 2020 at 05:26:51PM +0300, Leon Romanovsky wrote:
> > > On Tue, Sep 08, 2020 at 11:19:24AM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Sep 02, 2020 at 10:45:03AM +0300, Leon Romanovsky wrote:
> > > > > From: Aharon Landau <aharonl@mellanox.com>
> > > > >
> > > > > According to the IB spec active_speed size should be u16 and not u8 as
> > > > > before. Changing it to allow further extensions in offered speeds.
> > > > >
> > > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > > Signed-off-by: Aharon Landau <aharonl@mellanox.com>
> > > > > Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > >  drivers/infiniband/core/uverbs_std_types_device.c | 3 ++-
> > > > >  drivers/infiniband/core/verbs.c                   | 2 +-
> > > > >  drivers/infiniband/hw/bnxt_re/bnxt_re.h           | 2 +-
> > > > >  drivers/infiniband/hw/hfi1/verbs.c                | 2 +-
> > > > >  drivers/infiniband/hw/mlx5/main.c                 | 8 ++------
> > > > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c       | 2 +-
> > > > >  drivers/infiniband/hw/qedr/verbs.c                | 2 +-
> > > > >  drivers/infiniband/hw/qib/qib.h                   | 6 +++---
> > > > >  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   | 2 +-
> > > > >  include/rdma/ib_verbs.h                           | 4 ++--
> > > > >  10 files changed, 15 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
> > > > > index 75df2094a010..7b03446b6936 100644
> > > > > +++ b/drivers/infiniband/core/uverbs_std_types_device.c
> > > > > @@ -165,7 +165,8 @@ void copy_port_attr_to_resp(struct ib_port_attr *attr,
> > > > >  	resp->subnet_timeout = attr->subnet_timeout;
> > > > >  	resp->init_type_reply = attr->init_type_reply;
> > > > >  	resp->active_width = attr->active_width;
> > > > > -	resp->active_speed = attr->active_speed;
> > > > > +	WARN_ON(attr->active_speed & ~0xFF);
> > > >
> > > > ?? This doesn't seem like a warn on situation..
> > >
> > > Why? We are returning u8 to the user, so need to catch overflow.
> >
> > We need to have actual backwards compat here, not just throw a warning
> > at the syscall boundary
> 
> We don't have fallback and don't have speed that crosses u8 limit yet.
> This WARN_ON() is needed to ensure that we properly extend
> ib_port_speed.

Until we have some compat story I don't want to just increase this
value, it clearly renders the device unusable, so why do it?

Jason
