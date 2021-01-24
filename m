Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C76301A45
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Jan 2021 07:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbhAXG6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Jan 2021 01:58:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbhAXG6S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 24 Jan 2021 01:58:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F4E222C7E;
        Sun, 24 Jan 2021 06:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611471457;
        bh=T058F01zF3WUiMhdtNeu5LJy4hIxG7HBsTCAhCzfVLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TlzE22pohgFhpMJP+hGjYmor0WShR8ZEKSBuAnVDY1KcaKZdhWm7DmmY612u2lHVs
         Gwv0SahM38H+J2f5WODm+uiun2qvJ0oLXkAGqvcPOBcb8HnOwDfye7ucoW0naYNHU6
         j9957svhfbBTDTBD7q0c0ghr4NXUhQpPIixlN/ArwmynpiAoXGOVw4KVVBFy26K9vd
         fTE/EFYFz8VQVbZTI6DNQ4pJa7lRAXPYhk1olrpLvrv9rK2tbQgkMUTOL3G8pUTV/s
         23dFAT3x5CdAgQwVsn7diIkxrSTleI6bMRSXD+vjvE1GqdH8tCF7qlKaT+MF/N8Ip1
         vfhM40uqnYC0w==
Date:   Sun, 24 Jan 2021 08:57:33 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Lameter <cl@linux.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] Fix sendonly join going away after Reregister event
Message-ID: <20210124065733.GE4742@unreal>
References: <alpine.DEB.2.22.394.2101211318530.120233@www.lameter.com>
 <20210121161124.GD320304@unreal>
 <alpine.DEB.2.22.394.2101220817050.126441@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2101220817050.126441@www.lameter.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 22, 2021 at 08:24:57AM +0000, Christoph Lameter wrote:
> On Thu, 21 Jan 2021, Leon Romanovsky wrote:
>
> > >  	spin_lock_irqsave(&port->classport_lock, flags);
> > > -	if ((port->classport_info.valid) &&
> > > -	    (port->classport_info.data.type == RDMA_CLASS_PORT_INFO_IB))
> > > +	if (!port->classport_info.valid) {
> > > +		/* Need to wait until the SM data is available */
> > > +		spin_unlock_irqrestore(&port->classport_lock, flags);
> > > +		goto redo;
> >
> > We have all potential to loop forever here, if valid doesn't change.
> >
>
> Right. So what is the right solution here? The sendonly check function could return
> an errno instead?
>
> 0	= Sendonly join is supported
> -EAGAIN = SM information is currently invalid
> -ENOSUP = SM does not support sendonly join

I would do the same flow as in update_ib_cpi(), use retry count and loop
with delay, but without workqueue.

>
> Since all SMs out there have had support for sendonly join for years now
> we could just remove the check entirely. If there is an old grizzly SM out
> there then it would not process that join request and would return an
> error.

I have no idea if it possible, if yes, this will be the best solution.

Thanks
