Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E699E288991
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 15:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbgJINHO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 09:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732863AbgJINHM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Oct 2020 09:07:12 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B59BC22248;
        Fri,  9 Oct 2020 13:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602248831;
        bh=6O50+OZ1yp6c6Sg6JmX3/Xz4Ma2Jxy94ltatPKyBMxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRfzeJbB4F56xZFW95SO4e7l9hBGBcwghgWj8x5bXbP3heP8AHPCxdxkAF718acTP
         ROhrxl+OzkuZYHr3IgMWZuHoyngB//9pYM+j6gbHNWngG51jtk6hR9GN4jmy0mgZcE
         Bu2Ia9rTso8iKNZ0yHdQMrtIqquFgFk5i2l6yw5o=
Date:   Fri, 9 Oct 2020 16:07:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>,
        linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: reduce iSERT Max IO size
Message-ID: <20201009130707.GR13580@unreal>
References: <07e53835-8389-3e07-6976-505edbd94f2a@grimberg.me>
 <20201002171007.GA16636@chelsio.com>
 <4d0b1a3f-2980-c7ed-ef9a-0ed6a9c87a69@grimberg.me>
 <20201003033644.GA19516@chelsio.com>
 <4391e240-5d6d-fb59-e6fb-e7818d1d0bd2@nvidia.com>
 <20201007033619.GA11425@chelsio.com>
 <1a034761-3723-3c70-8a44-25ef2cbf786e@nvidia.com>
 <fe4ff8ac-fd0a-ed6f-312b-51be9a9fdcc6@grimberg.me>
 <20201008053002.GC13580@unreal>
 <5ab4fea9-fefb-d138-cc3b-03f87cd6ee66@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab4fea9-fefb-d138-cc3b-03f87cd6ee66@grimberg.me>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 08, 2020 at 09:20:41AM -0700, Sagi Grimberg wrote:
>
> > > > > I think max IO size, at iSER initiator, depends on
> > > > > "max_fast_reg_page_list_len".
> > > > > currently, below are the supported "max_fast_reg_page_list_len" of
> > > > > various iwarp drivers:
> > > > >
> > > > > iw_cxgb4: 128 pages
> > > > > Softiwarp: 256 pages
> > > > > i40iw: 512 pages
> > > > > qedr: couldn't find.
> > > > >
> > > > > For iwarp case, if 512 is the max pages supported by all iwarp drivers,
> > > > > then provisioning a gigantic MR pool at target(to accommodate never used
> > > > > 16MiB IO) wouldn't be a overkill?
> > > >
> > > > For RoCE/IB Mellanox HCAs we support 16MiB IO size and even more. We
> > > > limited to 16MiB in iSER/iSERT.
> > > >
> > > > Sagi,
> > > >
> > > > what about adding a module parameter for this as we did in iSER initiator ?
> > >
> > > I don't think we have any other choice...
> >
> > Sagi,
> >
> > I didn't read whole thread and know little about ULPs, but wonder if isn't
> > it possible to check device type (iWARP/RoCE) during iSERT initialization
> > and create MR pool only after device is recognized?
>
> Its already done this way. The problem is that there is no handshake
> procedure in iSER between the host and the target for what the maximum
> transfer size would be, so currently isert sets up to a worse case of
> 16MB. This has implications on memory requirements.

Thanks for the explanation.
