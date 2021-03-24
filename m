Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED9F347BE7
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 16:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbhCXPQ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 11:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236520AbhCXPQY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Mar 2021 11:16:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C559661A06;
        Wed, 24 Mar 2021 15:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616598983;
        bh=F3ddUJHWLnYzkdpg0jEvAdx0Iv+Fy2MYx8GUAae1E88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ipJSABnJDZZwOK82u71QlD8q533jVL9PcMfe8u32ZQDYpiNH/sYuHhLZsVjIu2n6j
         Vla8unCKeIZVgRUzHZi58Uw/kzBbIIjXHG0m1MWtlM5HmNA7t0fI1sVNcZSNpZH6Ui
         N10Djen+tunvx/NNUnuIZSYPrRC9m+ZhermbOQzsFFsK6GebEKatIA79iEkXEwfxTA
         2zmhnauLFzleTESdp5DoFUz5Jj8+mFDfHZDAXMR4sTXyCGxFiy0WwMOtyk2NTP7hgv
         Z03mbGlh9lvDXIxa7Yoi1WSjfF7YhanUGyoRItBhrPJg9apglYltHhDHuOfPJGxFvU
         T68R3qUcj3ZaA==
Date:   Wed, 24 Mar 2021 17:16:19 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH rdma-next] bnxt_re: Rely on Kconfig to keep module
 dependency
Message-ID: <YFtXw+w7MZFynam0@unreal>
References: <20210324142524.1135319-1-leon@kernel.org>
 <20210324150759.GH2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324150759.GH2356281@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 24, 2021 at 12:07:59PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 24, 2021 at 04:25:24PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Instead of manually messing with parent driver module reference
> > counting, rely on "depends on" keyword to ensure that proper
> > probe/remove chain is performed.
> 
> ?? kconfig doesn't impact module ordering.

Yeah, I was fast with the typing.

> 
> To have a proper remove chain there should be a symbol reference from
> bnxt_re to whatever the other module is

Right, they have probe_ulp() calls or something.

> 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >  drivers/infiniband/hw/bnxt_re/Kconfig |  4 +---
> >  drivers/infiniband/hw/bnxt_re/main.c  | 20 +++++---------------
> >  2 files changed, 6 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/bnxt_re/Kconfig b/drivers/infiniband/hw/bnxt_re/Kconfig
> > index 0feac5132ce1..b4779a6cd565 100644
> > +++ b/drivers/infiniband/hw/bnxt_re/Kconfig
> > @@ -2,9 +2,7 @@
> >  config INFINIBAND_BNXT_RE
> >  	tristate "Broadcom Netxtreme HCA support"
> >  	depends on 64BIT
> > -	depends on ETHERNET && NETDEVICES && PCI && INET && DCB
> > -	select NET_VENDOR_BROADCOM
> > -	select BNXT
> > +	depends on ETHERNET && NETDEVICES && PCI && INET && DCB && BNXT
> 
> Though this is correct, BNXT is a 'tristate' so it should be
> referenced with depends on select.
> 
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> > index fdb8c2478258..a81adb07e5d9 100644
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -561,13 +561,6 @@ static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netdev)
> >  	return container_of(ibdev, struct bnxt_re_dev, ibdev);
> >  }
> >  
> > -static void bnxt_re_dev_unprobe(struct net_device *netdev,
> > -				struct bnxt_en_dev *en_dev)
> > -{
> > -	dev_put(netdev);
> > -	module_put(en_dev->pdev->driver->driver.owner);
> > -}
> 
> And you are right to be wondering WTF is this
> 
> Jason
