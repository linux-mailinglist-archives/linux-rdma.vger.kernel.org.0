Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B11C4E84
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2020 08:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgEEG4G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 May 2020 02:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEG4F (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 May 2020 02:56:05 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0B86206A5;
        Tue,  5 May 2020 06:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588661765;
        bh=ap88Sr2POJZMJGOk6UB7vpMr1ZvmH9Sf7kNj0idPqQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cW3na5yNd+b/znZlxXvfSu7SxqOWJslZXHxH7meCkJKTK+u36MukaQIUEj+T9VmYE
         TzSZ/y+MW0WCiKbziFIJjhcgpRfIMg4yymu3qHA8CkgrlKnfrb/G7FPTlYM2hNuPkK
         atd9wQm/APjHBQK8Vxw3Cy2RVSaxAvP9AFHfegec=
Date:   Tue, 5 May 2020 09:56:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] IB/core: Fix potential NULL pointer dereference
 in pkey cache
Message-ID: <20200505065601.GH111287@unreal>
References: <20200426075811.129814-1-leon@kernel.org>
 <20200504175829.GA20458@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504175829.GA20458@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 04, 2020 at 02:58:29PM -0300, Jason Gunthorpe wrote:
> On Sun, Apr 26, 2020 at 10:58:11AM +0300, Leon Romanovsky wrote:
> > From: Jack Morgenstein <jackm@dev.mellanox.co.il>
> >
> > The IB core pkey cache is populated by procedure ib_cache_update().
> > Initially, the pkey cache pointer is NULL. ib_cache_update allocates
> > a buffer and populates it with the device's pkeys, via repeated calls
> > to procedure ib_query_pkey().
> >
> > If there is a failure in populating the pkey buffer via ib_query_pkey(),
> > ib_cache_update does not replace the old pkey buffer cache with the
> > updated one -- it leaves the old cache as is.
>
> The bug described here is that ib_cache_setup_one() ignores the return
> codes from ib_cache_update()
>
> Device registration should fail if the cache could not be loaded, just
> fix ib_cache_setup_one()

Thanks, it is much easy fix.

>
> Jason
