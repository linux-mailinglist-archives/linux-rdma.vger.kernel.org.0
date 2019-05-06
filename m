Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F16BB15422
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 21:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfEFTED (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 15:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfEFTEC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 15:04:02 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA82E20830;
        Mon,  6 May 2019 19:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557169441;
        bh=BL63HtN7QhSeLqplJdjJ5e8V5JdhUinGYQPCnm2hFGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIQrJ/cWkm8jULrg9VGMqINApSOpGxBlxF5BIbUDhltE6V8YyJoohZZkLrgqs6Rar
         nKN1CAqGbxJR2BDo91dCR+k1A4c62fJN3PsoM8upbz+y6aliikxW2QSCAPF5tbAPaz
         dHyMwX580bktqaN78xxFAUVT6aXy0GwxguNCBlpA=
Date:   Mon, 6 May 2019 22:03:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Tejun Heo (tj@kernel.org)" <tj@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Subject: Re: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Message-ID: <20190506190356.GO6938@mtr-leonro.mtl.com>
References: <20190327152517.GD69236@devbig004.ftw2.facebook.com>
 <20190327171611.GF21008@ziepe.ca>
 <20190327190720.GE69236@devbig004.ftw2.facebook.com>
 <20190327194347.GH21008@ziepe.ca>
 <20190327212502.GF69236@devbig004.ftw2.facebook.com>
 <053009d7de76f8800304f354e3cbde068453257f.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D3737D@fmsmsx120.amr.corp.intel.com>
 <580150427022440ab0475cda91d666322ef7e055.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D38297@fmsmsx120.amr.corp.intel.com>
 <20190506181610.GB6201@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506181610.GB6201@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 03:16:10PM -0300, Jason Gunthorpe wrote:
> On Mon, May 06, 2019 at 05:52:48PM +0000, Marciniszyn, Mike wrote:
> > >
> > > My mistake.  It's been a long while since I coded the stuff I did for
> > > memory reclaim pressure and I had my flag usage wrong in my memory.
> > > From the description you just gave, the original patch to add
> > > WQ_MEM_RECLAIM is ok.  I probably still need to audit the ipoib usage
> > > though.
> > >
> >
> > Don't lose sight of the fact that the additional of the WQ_MEM_RECLAIM is to silence
> > a warning BECAUSE ipoib's workqueue is WQ_MEM_RECLAIM.  This happens while
> > rdmavt/hfi1 is doing a cancel_work_sync() for the work item used by the QP's send engine
> >
> > The ipoib wq needs to be audited to see if it is in the data path for VM I/O.
>
> Well, it is doing unsafe memory allocations and other stuff, so it
> can't be RECLAIM. We should just delete them from IPoIB like Doug says.

Please don't.

>
> Before we get excited about IPoIB I'd love to hear how the netstack is
> supposed to handle reclaim as well ie when using NFS/etc.
>
> AFAIK the netstack code is not reclaim safe and can need to do things
> like allocate neighbour structures/etc to progress the dataplane.
>
> Jason
