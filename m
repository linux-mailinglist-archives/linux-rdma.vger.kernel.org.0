Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273B81848A9
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 15:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgCMOAN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 10:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgCMOAN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Mar 2020 10:00:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 503B72072C;
        Fri, 13 Mar 2020 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584108012;
        bh=tpA9x5BqxVqJ3K4DxnDtZse8/g9LA1WAfhCt+n3yzYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dp9nZOzkRItzuMHRn2K9grvCYB2YKGzeT/I0XJfxHM617+lLQF9Y4KMX+uD02xdPi
         GhHimt7EidxyGSy30ImjFwXdSNDZSyTxZm47II6gVPcApD+DLXcbJbEFIxn4lRzhhP
         UruCxcsRHFyfTV6AIT7dt294rNMLZGMALpUQKOlo=
Date:   Fri, 13 Mar 2020 16:00:06 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 00/11] Add Enhanced Connection Established
 (ECE)
Message-ID: <20200313140006.GJ31504@unreal>
References: <20200310091438.248429-1-leon@kernel.org>
 <20200313135303.GA25305@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313135303.GA25305@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 10:53:03AM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 10, 2020 at 11:14:27AM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Changelog:
> >  v1: Dropped field_avail patch in favor of mass conversion to use function
> >      which already exists in the kernel code.
> >  v0: https://lore.kernel.org/lkml/20200305150105.207959-1-leon@kernel.org
> >
> > Enhanced Connection Established or ECE is new negotiation scheme
> > introduced in IBTA v1.4 to exchange extra information about nodes
> > capabilities and later negotiate them at the connection establishment
> > phase.
> >
> > The RDMA-CM messages (REQ, REP, SIDR_REQ and SIDR_REP) were extended
> > to carry two fields, one new and another gained new functionality:
> >  * VendorID is a new field that indicates that common subset of vendor
> >    option bits are supported as indicated by that VendorID.
> >  * AttributeModifier already exists, but overloaded to indicate which
> >    vendor options are supported by this VendorID.
> >
> > This is kernel part of such functionality which is responsible to get data
> > from librdmacm and properly create and handle RDMA-CM messages.
> >
> > Thanks
> >
> > Leon Romanovsky (11):
> >   RDMA/mlx4: Delete duplicated offsetofend implementation
> >   RDMA/mlx5: Use offsetofend() instead of duplicated variant
> >   RDMA/cm: Delete not implemented CM peer to peer communication
>
> These ones applied to for-next

Thanks

>
> >   RDMA/efa: Use in-kernel offsetofend() to check field availability
>
> This needs resending

I'm not convinced yet.

>
> >   RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
> >   RDMA/uapi: Add ECE definitions to UCMA
> >   RDMA/ucma: Extend ucma_connect to receive ECE parameters
> >   RDMA/ucma: Deliver ECE parameters through UCMA events
> >   RDMA/cm: Send and receive ECE parameter over the wire
> >   RDMA/cma: Connect ECE to rdma_accept
> >   RDMA/cma: Provide ECE reject reason
>
> These need userspace to not be RFC

Sure, thanks.

>
> Jason
