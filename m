Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE323DB1
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 18:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbfETQke (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 12:40:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:43269 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731488AbfETQke (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 12:40:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 09:40:33 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 20 May 2019 09:40:33 -0700
Date:   Mon, 20 May 2019 09:41:23 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/providers: Simplify ib_modify_port for
 RoCE providers
Message-ID: <20190520164122.GA21917@iweiny-DESK2.sc.intel.com>
References: <20190516105308.29450-1-kamalheib1@gmail.com>
 <20190516111607.GA22587@ziepe.ca>
 <3c53c827f287df7f46b58c7f5e2fd23207a83683.camel@gmail.com>
 <20190516113750.GB22587@ziepe.ca>
 <8f4116c03236210e3481fae7e4ff51dfbad6c980.camel@gmail.com>
 <20190516151944.GC22587@ziepe.ca>
 <20190517220118.GB14175@iweiny-DESK2.sc.intel.com>
 <70f95f71d1e36c29940a9eab80ac92d9943f6537.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f95f71d1e36c29940a9eab80ac92d9943f6537.camel@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 19, 2019 at 01:07:34PM +0300, Kamal Heib wrote:
> On Fri, 2019-05-17 at 15:01 -0700, Ira Weiny wrote:
> > > > 
> > > > This patch is doing that for all roce drivers that implement
> > > > modify
> > > > port, unless you mean none-roce drivers?
> > > 
> > > I mean just delete it without any change to the core code.. Here we
> > > are now changing some roce drivers to have a working modify_port
> > > 
> > > It is confusing what the intention is
> > 
> > I see what Jason is saying here.  If ib_modify_port() is meaningless
> > then lets
> > remove the call and let it return -EOPNOTSUPP.
> > 
> 
> Please see below the original implementation of ib_modify_port(), if
> modify_port() callback is implemented then it will be called, otherwise
> for RoCE driver the return value will be "ok" and for none RoCE driver
> it will be "-ENOSYS".
> 
> So, what I tried to do in this patch is to return "ok" (like how it is
> done for hns, mlx4, mlx5, ocrdma, and qedr) in the ib_core instead in
> the drivers, and changed rxe and vmw_pvrdma to be aligned with this
> change.

I see that.

I don't really have a dog in this fight so I'm not really that concerned.  But
from time to time these little changes do affect things like the
infiniband-diags and/or the perftests which I do occasionally use.  So there
are 3 questions.

1) Do RoCE ports really require an "ib_modify_port()" function.
	I think "Not"

2) If not, then what is going to happen if someone calls ib_modify_port()?
	I think it should be an error not "ok" but this is debatable and again
	since I don't really have stake one should probably not listen to me...
	;-)

3) Again if not, then where best to return the error.
	I think Jason and I are agreed that the core should just handle this.
	Why duplicate the functionality in all the drivers?  Unless you think
	the answer to number #1 above is "maybe depending on the driver"...

	Is that what you are suggesting?

Ira

> 
> int ib_modify_port(struct ib_device *device,
> 		   u8 port_num, int port_modify_mask,
> 		   struct ib_port_modify *port_modify)
> {
> 	int rc;
> 
> 	if (!rdma_is_port_valid(device, port_num))
> 		return -EINVAL;
> 
> 	if (device->ops.modify_port)
> 		rc = device->ops.modify_port(device, port_num,
> 					     port_modify_mask,
> 					     port_modify);
> 	else
> 		rc = rdma_protocol_roce(device, port_num) ? 0 :
> -ENOSYS;
> 	return rc;
> }
> 
> > Returning "ok" implies that something worked.  I guess that is what
> > happens
> > now...
> > 
> > Also FWIW you are changing the return from ENOSYS to EOPNOTSUPP.  Did
> > you mean
> > to do that?
> > 
> 
> Yes, I changed the return value to "-EOPNOTSUPP" which is the proper
> return value for an unsupported option.
> 
> > Ira
> > 
> > > Jason
> 
