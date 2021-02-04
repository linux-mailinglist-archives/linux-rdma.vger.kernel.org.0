Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C272A30F75A
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 17:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbhBDQMa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 11:12:30 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17396 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbhBDQLi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 11:11:38 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601c1c870000>; Thu, 04 Feb 2021 08:10:47 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb
 2021 16:10:47 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 4 Feb 2021 16:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrhlXEqtsQ8tSCNCRfxm7wWiKto6mx5sWxxgHMLmNIkO/uvfSAXa4gxC3SJwk3IKwsYqiF0QmdParQMV1ZVlQQc+41AzRrynqWHa+yIv/aYPkZPZhdws/F4RPqpFg6YbKRbye2wSMOoOKT4FjlyIKHkz7ofsdoMYnGKXhhftvdgKbnMSlVS8S3GT1zIJN151R8LZSvOMb+v/L0mhXDZ4ZZ/xkP4XIXi/eNSkNGXsxtyIPWreDHRhkMwQmx7WRXCRUGFc39XD92j7UDOEJk57kK6s0r5NeIBZnY0QqsC8Civ/5OSrc3/p2V3ZsDXsWNTKeAbx8Sd/X1HVlQ73R6pLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VQMBPWSAUk7E4PGaLTEG6XkwVBZVX5b3H4O0VTwJ4U=;
 b=IlHXBL222tbYUKuTzA1By2TkmWXpuMggDk+b+YlAb6bKrg5ncvv8z6Rj4LesS4vZxHPGzP47AuY0sUb3Z8vtYbr/DUHLWzTqGh3zFSkxE0YIMLfZu5UJrhwNaIkImo/ZxGC09DEIhb6S7rhkHfYtNeeK6mWW5jRMIGk46snilyc3esbR97eXmhS2yaju8CW/d3chVc4u/Xo4dh8jNbb5MQSWQYBVMIHsAnjq9aa8r98FeLlA5OhdZL2XegfjBMANejAn3zdhJulPLIKPzK1B9DOhqQ1uQib4qaCdQxDC/u1L+duzcIYQid1NXduMLNxLdEVnLMJHat+hYqaaOD9RUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1340.namprd12.prod.outlook.com (2603:10b6:3:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Thu, 4 Feb
 2021 16:10:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3805.033; Thu, 4 Feb 2021
 16:10:45 +0000
Date:   Thu, 4 Feb 2021 12:10:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Amit Matityahu <mitm@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1] RDMA/ucma: Fix use-after-free bug in
 ucma_create_uevent
Message-ID: <20210204161043.GA831972@nvidia.com>
References: <20210125121556.838290-1-leon@kernel.org>
 <20210203200116.GA740542@nvidia.com> <20210204160820.GD93433@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210204160820.GD93433@unreal>
X-ClientProxiedBy: BL1PR13CA0305.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0305.namprd13.prod.outlook.com (2603:10b6:208:2c1::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.10 via Frontend Transport; Thu, 4 Feb 2021 16:10:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l7hDQ-003Uhd-0E; Thu, 04 Feb 2021 12:10:44 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612455047; bh=6VQMBPWSAUk7E4PGaLTEG6XkwVBZVX5b3H4O0VTwJ4U=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=etpFWkQkrOnjhLIBzsdfFm37lVMDjHTbHybLnYstx+ztRn414h3UsyXaHyWiiBhKN
         9eTZ5TzI5MiypT3a+sYcSdqzf668XN1HmlHKZHjPtICzOup0mNHMNBAx41c/pRlgoE
         zy5CU4omyFH6mGFt3RpzddmS4OF/B9xHrbSFt4mfN6jQcWKonYOPSyW64d7+Psa0Ik
         MplnjrP4RoF5hskpjvUPhNUCpyDQP0biOTGP40C/r+XgryK+dCuHLFZ6gU3GQocSAg
         m22VHCpSn0Kf4ucpzurEW0jI4i8GtAvdff/QSMXgUdjKkOs1pYAixRYbRRo81VQS9K
         3epr9eNfR7Axw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 04, 2021 at 06:08:20PM +0200, Leon Romanovsky wrote:
> On Wed, Feb 03, 2021 at 04:01:16PM -0400, Jason Gunthorpe wrote:
> > On Mon, Jan 25, 2021 at 02:15:56PM +0200, Leon Romanovsky wrote:
> > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > index e17ba841e204..7ce4d9dea826 100644
> > > +++ b/drivers/infiniband/core/cma.c
> > > @@ -352,7 +352,13 @@ struct ib_device *cma_get_ib_dev(struct cma_device *cma_dev)
> > >
> > >  struct cma_multicast {
> > >  	struct rdma_id_private *id_priv;
> > > -	struct ib_sa_multicast *sa_mc;
> > > +	union {
> > > +		struct ib_sa_multicast *sa_mc;
> > > +		struct {
> > > +			struct work_struct work;
> > > +			struct rdma_cm_event event;
> > > +		} iboe_join;
> > > +	};
> > >  	struct list_head	list;
> > >  	void			*context;
> > >  	struct sockaddr_storage	addr;
> > > @@ -1839,6 +1845,12 @@ static void destroy_mc(struct rdma_id_private *id_priv,
> > >  			cma_igmp_send(ndev, &mgid, false);
> > >  			dev_put(ndev);
> > >  		}
> > > +
> > > +		if (cancel_work_sync(&mc->iboe_join.work))
> > > +			/* Compensate for cma_iboe_join_work_handler that
> > > +			 * didn't run.
> > > +			 */
> > > +			cma_id_put(mc->id_priv);
> >
> > Just get rid of the cma_id_get in cma_iboe_join_multicast() and don't
> > have this if
> 
> Why do you think that it is safe to queue work without refcount?

Because we cancel the work before we destroy the memory - the work
serves as the refcount now

Jason
