Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D2421FFC
	for <lists+linux-rdma@lfdr.de>; Sat, 18 May 2019 00:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfEQWAe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 May 2019 18:00:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:46256 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfEQWAe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 May 2019 18:00:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 15:00:33 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga007.jf.intel.com with ESMTP; 17 May 2019 15:00:33 -0700
Date:   Fri, 17 May 2019 15:01:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/providers: Simplify ib_modify_port for
 RoCE providers
Message-ID: <20190517220118.GB14175@iweiny-DESK2.sc.intel.com>
References: <20190516105308.29450-1-kamalheib1@gmail.com>
 <20190516111607.GA22587@ziepe.ca>
 <3c53c827f287df7f46b58c7f5e2fd23207a83683.camel@gmail.com>
 <20190516113750.GB22587@ziepe.ca>
 <8f4116c03236210e3481fae7e4ff51dfbad6c980.camel@gmail.com>
 <20190516151944.GC22587@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516151944.GC22587@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 12:19:44PM -0300, Jason Gunthorpe wrote:
> On Thu, May 16, 2019 at 02:52:48PM +0300, Kamal Heib wrote:
> > On Thu, 2019-05-16 at 08:37 -0300, Jason Gunthorpe wrote:
> > > On Thu, May 16, 2019 at 02:28:40PM +0300, Kamal Heib wrote:
> > > > On Thu, 2019-05-16 at 08:16 -0300, Jason Gunthorpe wrote:
> > > > > On Thu, May 16, 2019 at 01:53:08PM +0300, Kamal Heib wrote:
> > > > > > For RoCE ports the call for ib_modify_port is not meaningful,
> > > > > > so
> > > > > > simplify the providers of RoCE by return OK in ib_core.
> > > > > > 
> > > > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > > >  drivers/infiniband/core/device.c              | 23 ++++++-----
> > > > > >  drivers/infiniband/hw/hns/hns_roce_main.c     |  7 ----
> > > > > >  drivers/infiniband/hw/mlx4/main.c             |  8 ----
> > > > > >  drivers/infiniband/hw/mlx5/main.c             |  6 ---
> > > > > >  drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  1 -
> > > > > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 ---
> > > > > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 -
> > > > > >  drivers/infiniband/hw/qedr/main.c             |  1 -
> > > > > >  drivers/infiniband/hw/qedr/verbs.c            |  6 ---
> > > > > >  drivers/infiniband/hw/qedr/verbs.h            |  2 -
> > > > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  1 -
> > > > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 38 ---------
> > > > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 -
> > > > > >  drivers/infiniband/sw/rxe/rxe_verbs.c         | 18 ---------
> > > > > >  14 files changed, 14 insertions(+), 107 deletions(-)
> > > > > 
> > > > > We have more roce only drivers than this, why isn't everything
> > > > > changed?
> > > > > 
> > > > > Jason
> > > > 
> > > > Not all of them implements modify_port().
> > > 
> > > Then why didn't we just delete modify port from the other drivers?
> > > 
> > > Jason
> > 
> > This patch is doing that for all roce drivers that implement modify
> > port, unless you mean none-roce drivers?
> 
> I mean just delete it without any change to the core code.. Here we
> are now changing some roce drivers to have a working modify_port
> 
> It is confusing what the intention is

I see what Jason is saying here.  If ib_modify_port() is meaningless then lets
remove the call and let it return -EOPNOTSUPP.

Returning "ok" implies that something worked.  I guess that is what happens
now...

Also FWIW you are changing the return from ENOSYS to EOPNOTSUPP.  Did you mean
to do that?

Ira

> 
> Jason
