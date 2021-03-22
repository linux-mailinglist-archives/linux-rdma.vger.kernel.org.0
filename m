Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F5E3446D3
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 15:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCVOMt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 10:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhCVOMj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 10:12:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE6E361972;
        Mon, 22 Mar 2021 14:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616422358;
        bh=P8VREAh3EGFy7ny0u3nZV7mBRKACHIOVoVrDL2SFtOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnnk1XURj2+LH0HXnO95Fy8BFXSeMpasJmgxX+czst8cEMLZzzDxE/koyCxmNBQyc
         SUf+cy33KzKoMuCY37MDMMYqpkmrb2cvs4TnGXgLrtAUO3ALRILYmJdkBROj6U+nyB
         2xmGIH9vVhPcMmOEgMPSKroxpuViW7faldAe8plCqr1pPqegL1nbPULT1vzU1ZD5L+
         4qkt807uLTlNLfgkq0Ws8UZg0dgmg98T0sDWIEQL8GcuurcSHeeIRyY9jYkdpCxJVy
         MMLVczDGXPcHnHmaUieJFEn2iNwkPCovrFHZndh5aPgzpHS42Y8TyY7CFsIj5GoVZK
         4RLUDSC9IcfxA==
Date:   Mon, 22 Mar 2021 16:12:34 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Faisal Latif <faisal.latif@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: Re: [PATCH rdma-next 0/2] Spring cleanup
Message-ID: <YFil0nfFgSSh0mXb@unreal>
References: <20210314133908.291945-1-leon@kernel.org>
 <20210322130012.GA247894@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322130012.GA247894@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 10:00:12AM -0300, Jason Gunthorpe wrote:
> On Sun, Mar 14, 2021 at 03:39:06PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Bunch of cleanup in RDMA subsystem.
> > 
> > Leon Romanovsky (2):
> >   RDMA: Fix kernel-doc compilation warnings
> >   RDMA: Delete not-used static inline functions
> 
> Applied to for-next
> 
> How did you find the unused static inline functions?

Accidentally spotted such in pvrdma and later wrote one liner to create
me a list of functions to delete.

Thanks

> 
> Thanks,
> Jason
