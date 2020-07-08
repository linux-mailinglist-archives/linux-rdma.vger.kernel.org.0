Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3931F218FE2
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 20:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgGHSrb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 14:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGHSra (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 14:47:30 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B9E82065D;
        Wed,  8 Jul 2020 18:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594234050;
        bh=VyvvbSgAag63GaUfjZkW851Wh7/Lb8x2jp8VxZfY5jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPNPFGsXMbvpqOr76YYQYvYqkUVdWpspHLoO6hD72tLY0PynOMh/Dn6Z6u67dlnvm
         k3QaqTEB/pg03r1hcOggKiaAzPQcK2gtHOn7HiRU2EveAJ0fd7UOBs7A3AVxQYLJBR
         29z3qoFUxE7782enGYHOUom6ug4TmSimtqVfdzTI=
Date:   Wed, 8 Jul 2020 21:47:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] IB/hfi1: Use fallthrough pseudo-keyword
Message-ID: <20200708184726.GB1276673@unreal>
References: <20200707173942.GA29814@embeddedor>
 <20200708054703.GR207186@unreal>
 <20200708182835.GF11533@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708182835.GF11533@embeddedor>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 08, 2020 at 01:28:35PM -0500, Gustavo A. R. Silva wrote:
> Hi Leon,
>
> On Wed, Jul 08, 2020 at 08:47:03AM +0300, Leon Romanovsky wrote:
> > On Tue, Jul 07, 2020 at 12:39:42PM -0500, Gustavo A. R. Silva wrote:
> > > Replace the existing /* fall through */ comments and its variants with
> > > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > > fall-through markings when it is the case.
> > >
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> > >
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > >  drivers/infiniband/hw/hfi1/chip.c     |    8 ++++----
> > >  drivers/infiniband/hw/hfi1/firmware.c |   16 ----------------
> > >  drivers/infiniband/hw/hfi1/mad.c      |    9 ++++-----
> > >  drivers/infiniband/hw/hfi1/pio.c      |    2 +-
> > >  drivers/infiniband/hw/hfi1/pio_copy.c |   12 ++++++------
> > >  drivers/infiniband/hw/hfi1/platform.c |   10 +++++-----
> > >  drivers/infiniband/hw/hfi1/qp.c       |    2 +-
> > >  drivers/infiniband/hw/hfi1/qsfp.c     |    4 ++--
> > >  drivers/infiniband/hw/hfi1/rc.c       |   25 ++++++++++++-------------
> > >  drivers/infiniband/hw/hfi1/sdma.c     |    9 ++++-----
> > >  drivers/infiniband/hw/hfi1/tid_rdma.c |    4 ++--
> > >  drivers/infiniband/hw/hfi1/uc.c       |    8 ++++----
> > >  12 files changed, 45 insertions(+), 64 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
> > > index 15f9c635f292..132f1df6f23b 100644
> > > --- a/drivers/infiniband/hw/hfi1/chip.c
> > > +++ b/drivers/infiniband/hw/hfi1/chip.c
> > > @@ -7320,7 +7320,7 @@ static u16 link_width_to_bits(struct hfi1_devdata *dd, u16 width)
> > >  	default:
> > >  		dd_dev_info(dd, "%s: invalid width %d, using 4\n",
> > >  			    __func__, width);
> > > -		/* fall through */
> > > +		fallthrough;
> > >  	case 4: return OPA_LINK_WIDTH_4X;
> >
> > "case ..:" after "default:" ???
> > IMHO, it should be written in more standard way.
> >
>
> I agree. However, that piece of code, and the other below, does not
> concern to this patch.

I'm not super excited about such half-baked solutions. Let's fix all at
once by pre-patch or post-patch to this change.

Thanks
