Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9349739EF1F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 08:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhFHG7e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 02:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhFHG7c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 02:59:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DE2C6124C;
        Tue,  8 Jun 2021 06:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623135460;
        bh=yjBYy7eUwamr31eq9brn5Jc1luf++jw7ukGEARTrWGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oukDiFIKchJGBdt6dBeiF6ziHae7iRyltS8ZZB/426KE762+G5igWlnm8celxGigP
         ZJKNBOJzzb4vdQo02cQlvw1jBZkvcMTUX9mao1KHr9ZJqUHo/AkFecdiqNJqNBc3of
         YsAF8Wd0Gev42wO+zKbgIyioE6Tn0r5IwOIc3xf03hIDZXq9YYMaYkhdeoM0TjWtjh
         afxLCUZrhL2VRrakc4ne7p+e1C8Zh0lCVsDFTC+b4/OpqyJMYMvcFdMGnj6MvSCGWP
         GJhxjNPCpIxft6nrapcpdbPkUhZwlnG7B1fLPAqdaqBjw0Mkk1ju9E5zlaSov6ONb+
         MiS6epNfXlVeA==
Date:   Tue, 8 Jun 2021 09:57:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v1 14/15] RDMA/core: Allow port_groups to be
 used with namespaces
Message-ID: <YL8U4JqzyHl24Rio@unreal>
References: <cover.1623053078.git.leonro@nvidia.com>
 <a1a8a96629405ff3b2990f5f8dbd7b57a818571e.1623053078.git.leonro@nvidia.com>
 <PH0PR12MB5481C3DE73C097E938B4E5D1DC389@PH0PR12MB5481.namprd12.prod.outlook.com>
 <YL74KtkVOxVDT5u6@unreal>
 <PH0PR12MB548195F3EC7E96C1ED2789ABDC379@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB548195F3EC7E96C1ED2789ABDC379@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 08, 2021 at 05:32:56AM +0000, Parav Pandit wrote:
> 
> 
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Tuesday, June 8, 2021 10:25 AM
> > 
> > On Mon, Jun 07, 2021 at 01:29:58PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Leon Romanovsky <leon@kernel.org>
> > > > Sent: Monday, June 7, 2021 1:48 PM
> > > >
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > >
> > > > Now that the port_groups data is being destroyed and managed by the
> > > > core code this restriction is no longer needed. All the
> > > > ib_port_attrs are compatible with the core's sysfs lifecycle.
> > > >
> > > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > ---
> > > >  drivers/infiniband/core/device.c | 10 ++++------
> > > > drivers/infiniband/core/sysfs.c  | 17 ++++++-----------
> > > >  2 files changed, 10 insertions(+), 17 deletions(-)
> > 
> > <...>
> > 
> > > > diff --git a/drivers/infiniband/core/sysfs.c
> > > > b/drivers/infiniband/core/sysfs.c index 09a2e1066df0..f42034fcf3d9
> > > > 100644
> > > > --- a/drivers/infiniband/core/sysfs.c
> > > > +++ b/drivers/infiniband/core/sysfs.c
> > > > @@ -1236,11 +1236,9 @@ static struct ib_port *setup_port(struct
> > > > ib_core_device *coredev, int port_num,
> > > >  	ret = sysfs_create_groups(&p->kobj, p->groups_list);
> > > >  	if (ret)
> > > >  		goto err_del;
> > > > -	if (is_full_dev) {
> > > > -		ret = sysfs_create_groups(&p->kobj, device-
> > > > >ops.port_groups);
> > > > -		if (ret)
> > > > -			goto err_groups;
> > > > -	}
> > > > +	ret = sysfs_create_groups(&p->kobj, device->ops.port_groups);
> > > > +	if (ret)
> > > > +		goto err_groups;
> > > >
> > > This will expose counters in all net namespaces in shared mode (default
> > case).
> > > Application running in one net namespace will be able to monitor counters
> > of other net namespace.
> > > This should be avoided.
> > 
> > In shared mode, we are sharing sysfs anyway and have two options to deal
> > with the port properties (counters):
> > 1. Show them in all namespaces as being global to port which is shared
> > anyway.
> > 2. Show them in init_net namespace only and applications that were left in
> > this namespace will see not their counters anyway.
> > 
> > Why should we avoid "item 1"?
> Because it is incorrect to show port counters updated by application running in net ns 1, to show to application running in net ns 2.
> Once/if there is per netns counters exist, than those counters can be shown using more modern rdma stats command.

ok, I see your point and have no strong position about it.

Thanks
