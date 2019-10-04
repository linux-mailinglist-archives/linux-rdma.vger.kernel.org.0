Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC22ACC1C5
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 19:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfJDReK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 13:34:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45992 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfJDReK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 13:34:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id c21so9561822qtj.12
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gCPkVAkRLNwFkUE2gPgITBllCCV8rirv9ieAAsqDBxY=;
        b=KCIQy2T+sEGTICgxb/5NyIl7gFjPonnVoVR3A9qN4orZksVkeVejWXp2qkYsW2VVLH
         phimcK0W2jeHMkOy97mGoaqlAIh+BFTHU+7faLPuiQm8ghG6Lx8oWmwIrJPh2BFgUQJO
         R2OIVjCHOuTVD+cixB04xdgOs5zm5sQwD4jBqlq4ThtI/npS9KtotZo/ViQQD7o9UBOg
         2tCUJp2hHZ1ccGpRQQ11VSsUA6V10W8xbihw/RdidBwU6FQ4L2pPFGt6E9lul66FbHOH
         ohzThYai6CqB2HWcH0PVMKvGxg7AbKu6jxV6QrflIPZOUcNGuEJvCw1AEY1VpqC5Pcoj
         V1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gCPkVAkRLNwFkUE2gPgITBllCCV8rirv9ieAAsqDBxY=;
        b=g9zo85cqjLMeIoSOAESQ20Ngg+f6KsRBVWiqE1XkKpetTtLKM31z9QADls4jQYm74u
         a9YmUKyotCRbRk1r0Z6/QJ9pgXJrrsn4HEe/Tmp48T66mxW4YrcjcTP1T0q93I+Ghpyd
         5Yhyfq0kYjlK+EAyYlYc9awdpxUPdH539Zh5Gtw4/vDrjzKU+8cmBbR4P11U5YbDQfuQ
         Sb/mzUeyfqWtC9YJFnIrN3v6wNyz4ypK7oChoBUwelw+GrypFUsdNIIblyj979z5VI1Y
         dECFWtASVPNfigjpGP4OhsLaS62RtygsQHK1NfRZDwJunEpyO6C+Mq7uhSQckZ0l7bEC
         gimg==
X-Gm-Message-State: APjAAAVEPpYhlRz36ltcoGfLplDhh0IyURqNiOD572Go6G9lbbuPQ9Pl
        L51YEbfMQB11YT5M5fe9Zg9yNdeHgxQ=
X-Google-Smtp-Source: APXvYqwK036Z0J+rpofH2O8Ry93OBVj5mpbZJbkC8PUrVQvkFDlYRkr9BybmxHulWZdxF9ffudOgdg==
X-Received: by 2002:ad4:4a88:: with SMTP id h8mr15240911qvx.145.1570210449598;
        Fri, 04 Oct 2019 10:34:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v13sm2665909qtp.61.2019.10.04.10.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 10:34:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGRSy-0005aD-Es; Fri, 04 Oct 2019 14:34:08 -0300
Date:   Fri, 4 Oct 2019 14:34:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Kamal Heib <kamalheib1@gmail.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-5.4] RDMA/i40iw: Associate ibdev to netdev before IB
 device registration
Message-ID: <20191004173408.GB13988@ziepe.ca>
References: <20190925164524.856-1-shiraz.saleem@intel.com>
 <327441aa-3991-b55b-aa71-7deff4ad6ed2@gmail.com>
 <9DD61F30A802C4429A01CA4200E302A7B5CD869B@fmsmsx124.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7B5CD869B@fmsmsx124.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 04, 2019 at 04:00:13PM +0000, Saleem, Shiraz wrote:
> > Subject: Re: [PATCH for-5.4] RDMA/i40iw: Associate ibdev to netdev before IB
> > device registration
> > 
> > 
> > 
> > On 9/25/19 7:45 PM, Shiraz Saleem wrote:
> > > From: "Shiraz, Saleem" <shiraz.saleem@intel.com>
> > >
> > > i40iw IB device registration fails with ENODEV.
> > >
> > > ib_register_device
> > >  setup_device/setup_port_data
> > >   i40iw_port_immutable
> > >    ib_query_port
> > >      iw_query_port
> > >       ib_device_get_netdev(ENODEV)
> > >
> > > ib_device_get_netdev() does not have a netdev associated with the
> > > ibdev and thus fails.
> > > Use ib_device_set_netdev() to associate netdev to ibdev in i40iw
> > > before IB device registration.
> > >
> > > Fixes: 4929116bdf72 ("RDMA/core: Add common iWARP query port")
> > > Signed-off-by: Shiraz, Saleem <shiraz.saleem@intel.com>
> > >  drivers/infiniband/hw/i40iw/i40iw_verbs.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> > > b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> > > index 8056930..cd9ee166 100644
> > > +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> > > @@ -2773,6 +2773,10 @@ int i40iw_register_rdma_device(struct i40iw_device
> > *iwdev)
> > >  		return -ENOMEM;
> > >  	iwibdev = iwdev->iwibdev;
> > >  	rdma_set_device_sysfs_group(&iwibdev->ibdev, &i40iw_attr_group);
> > > +	ret = ib_device_set_netdev(&iwibdev->ibdev, iwdev->netdev, 1);
> > > +	if (ret)
> > > +		goto error;
> > > +
> > >  	ret = ib_register_device(&iwibdev->ibdev, "i40iw%d");
> > >  	if (ret)
> > >  		goto error;
> > >
> > 
> > Thanks!
> > 
> > Reviewed-by: Kamal Heib <kamalheib1@gmail.com>
> 
> Hi Jason or Doug - This was a regression introduced in 5.4 which
> breaks i40iw. Can you pick this up for 5.4-rc?

I was going to complain that this shouldn't have been done without
also deleting i40iw_find_netdev(), but it seems that is doing something
else. 

Ok applied to for-rc

Jason
