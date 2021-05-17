Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7A7383B69
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 19:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhEQRie (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 13:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhEQRia (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 13:38:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9179E60D07;
        Mon, 17 May 2021 17:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621273034;
        bh=eA5UvK1MR4EtP/OvhDRmqEPqWlYSlN8Uo99kD4dwMw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sk8TDic/xkGrDSIHY4w+mJ9iQ1WvqPkQ6huLnBQfaVJbXjYSUzUP75ZANqaSaTrnL
         iukazmq+APKBj8CBVchBqE/hXTEEJNOlGaSmra7mj72S0YelNNIL/FTHm9vZqZxZ24
         b3irQL0P4E3Z3OY7iZkDwRgtal4ONJPsX/yJ+hZ8=
Date:   Mon, 17 May 2021 19:37:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 09/13] RDMA/core: Expose the ib port sysfs attribute
 machinery
Message-ID: <YKKpx8WlYpSfTggP@kroah.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <9-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <YKKkFyHwki9R1Wkc@kroah.com>
 <20210517173100.GT1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517173100.GT1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 17, 2021 at 02:31:00PM -0300, Jason Gunthorpe wrote:
> On Mon, May 17, 2021 at 07:12:55PM +0200, Greg KH wrote:
> 
> > > +int ib_port_sysfs_create_groups(struct ib_device *ibdev, u32 port_num,
> > > +				const struct attribute_group **groups)
> > > +{
> > > +	return sysfs_create_groups(&ibdev->port_data[port_num].sysfs->kobj,
> > > +				   groups);
> > > +}
> > > +EXPORT_SYMBOL(ib_port_sysfs_create_groups);
> > 
> > You are wrapping _GPL symbols here with a "convenience" function, please
> > make these all EXPORT_SYMBOL_GPL() so I don't get nervous.
> 
> These functions get deleted in a following patch once everything can
> be switched to ops->get_port_groups(), which provides even less
> flexability for the driver to do things wrong.
> 
> The whole subsystem already uses !GPL export so it is very strange to
> see a GPL symbol at all:
> 
> $ git grep EXPORT_SYMBOL\( drivers/infiniband/core/ | wc -l
> 310
> $ git grep EXPORT_SYMBOL_GPL\( drivers/infiniband/core/ | wc -l
> 1
> 
> Anyhow, if it makes you happy I'll change it.

Please do, it's a simple wrapper function.

thanks,

greg k-h
