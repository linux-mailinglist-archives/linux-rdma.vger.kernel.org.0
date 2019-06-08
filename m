Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB539BCC
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 10:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfFHIVp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 04:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFHIVo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 8 Jun 2019 04:21:44 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EE11214AE;
        Sat,  8 Jun 2019 08:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559982104;
        bh=VATeqKIGxkr20+fZlSkv2YdmhMd15nqKAvv9tEJcNNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPZmiCTjyDlogw1OBmBSStA+lwnItGspcnAJpV8oHSOk36SFh0bPuioqCDFVQK5dL
         81S7HA9D1iIZPYEfLdqwlxMxKMVagkfOykIGgdDyCtuHzpNYWuhV6v1togy08s99Zq
         fDZDHYtmGPDambQ8ji51jcfkwCD8OO6prf4OF81k=
Date:   Sat, 8 Jun 2019 11:21:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Steve Wise <larrystevenwise@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>
Subject: Re: RFC: Remove nes
Message-ID: <20190608082128.GP5261@mtr-leonro.mtl.com>
References: <20190607162430.GL14802@ziepe.ca>
 <CADmRdJfDLp_C+rVuRqDVfDahtcwSDb8HGgR2_SHmbxD3AUghfw@mail.gmail.com>
 <20190607174258.GO14802@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607174258.GO14802@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 02:42:58PM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 07, 2019 at 12:23:45PM -0500, Steve Wise wrote:
> > On Fri, Jun 7, 2019 at 11:24 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > Since we have gained another two (EFA, SIW) drivers lately, I'd really
> > > like to remove NES as we have in the past for other drivers.
> > >
> > > This hardware was proposed to be removed at the last purge, but I
> > > think that Steve still wanted to keep it for some reason. I suppose
> > > that has changed now.
> > >
> > > If I recall the reasons for removal were basically:
> > >  - Does not support modern FRWR, which is now becoming mandatory for ULPs
> > >  - Does not support 64 bit physical addresses, so is useless on modern
> > >    servers
> > >  - Possibly nobody has even loaded the module in years. Wouldn't be
> > >    surprised to learn it is broken with all the recent churn.
> > >
> > > Remarkably there still seem to be cards in ebay though..
> > >
> > > Jason
> >
> > It wasn't me.
>
> Oh? I wonder who..

I have same feeling like Jason, that it was you.

>
> > Perhaps we were discussing cxgb3 removal?
>
> I know we discussed that :) can we remove cxgb3? :)

Ohh, good, I would like to remove UCM too, we waited enough.

>
> > Anyway, are you certain it doesn't support REG_MR?  I see support
> > for it in nes_post_send().
>
> Hm, not really, but I thought it was one of the ones. It does set
> IB_DEVICE_MEM_MGT_EXTENSIONS so I guess it is OK.
>
> Jason
