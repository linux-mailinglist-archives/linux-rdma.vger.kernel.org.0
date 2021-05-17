Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E30383B51
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 19:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhEQRcv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 13:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhEQRcu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 13:32:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1401760724;
        Mon, 17 May 2021 17:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621272692;
        bh=JsGHYeSP0hhZSlk31IHaCrFS1rNj2raQgu9qUFg5aRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/UpqfNtHK2u8KoYkLAKH8yin5LOc58RDzQ1OsuvrF1cLIoHF3FRVMij8MSpZM6Wq
         Stii26t7Lc/BeU9yQ6cx+f2ssgBQFdWdpX30TS4NjDEgEFgoZrq7iLIZdw9I7yGDHu
         5DWOhKMInyiBUad6vqs4qyFlUW/vnw7+5eW4WnUw=
Date:   Mon, 17 May 2021 19:31:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 11/13] RDMA/qib: Use attributes for the port sysfs
Message-ID: <YKKoclygfHI5uUbo@kroah.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <11-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <YKKj2Fx+9t0KnoGr@kroah.com>
 <20210517171347.GS1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517171347.GS1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 17, 2021 at 02:13:47PM -0300, Jason Gunthorpe wrote:
> On Mon, May 17, 2021 at 07:11:52PM +0200, Greg KH wrote:
> > On Mon, May 17, 2021 at 01:47:39PM -0300, Jason Gunthorpe wrote:
> > > qib should not be creating a mess of kobjects to attach to the port
> > > kobject - this is all attributes. The proper API is to create an
> > > attribute_group list and create it against the port's kobject.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > >  drivers/infiniband/hw/qib/qib.h       |   5 +-
> > >  drivers/infiniband/hw/qib/qib_sysfs.c | 596 +++++++++++---------------
> > >  2 files changed, 248 insertions(+), 353 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
> > > index 88497739029e02..3decd6d0843172 100644
> > > +++ b/drivers/infiniband/hw/qib/qib.h
> > > @@ -521,10 +521,7 @@ struct qib_pportdata {
> > >  
> > >  	struct qib_devdata *dd;
> > >  	struct qib_chippport_specific *cpspec; /* chip-specific per-port */
> > > -	struct kobject pport_kobj;
> > > -	struct kobject pport_cc_kobj;
> > > -	struct kobject sl2vl_kobj;
> > > -	struct kobject diagc_kobj;
> > > +	const struct attribute_group *groups[5];
> > 
> > As you initialize these all at once, why not just make this:
> > 	struct attribute_group **groups;
> > 
> > and then set the groups up at build time instead of runtime as part of a
> > larger structure like the ATTRIBUTE_GROUPS() macro does for "simple"
> > drivers?  That way you aren't fixed at the array size here and someone
> > has to go and check to verify you really have properly 0 terminated the
> > list and set up the pointers properly.
> 
> qib has a variable list of group memberships that can only be
> determined at runtime:
> 
>         if (qib_cc_table_size && ppd->congestion_entries_shadow)
>                 *cur_group++ = &port_ccmgta_attribute_group;
> 
> So it can't be setup statically at compile time.

That attribute group can have a is_visable() callback to allow those
files to show up or not, instead of having to determine this when you
are setting up the list of groups.

But that's your call, not a big deal, overall this series looks like a
lot of good cleanups to me, thanks for doing it.

greg k-h
