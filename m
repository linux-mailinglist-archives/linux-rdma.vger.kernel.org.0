Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C85E2AD814
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Nov 2020 14:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgKJNyv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Nov 2020 08:54:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbgKJNyu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Nov 2020 08:54:50 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 857F22076E;
        Tue, 10 Nov 2020 13:54:49 +0000 (UTC)
Date:   Tue, 10 Nov 2020 15:54:45 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/nldev: Add parent bdf to device
 information dump
Message-ID: <20201110135445.GC371586@unreal>
References: <0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com>
 <20201103142243.GM36674@ziepe.ca>
 <5e2208ab-9e87-56ae-bc38-5827637eb5be@amazon.com>
 <20201105200005.GJ36674@ziepe.ca>
 <cd3f2926-0491-8540-d6b1-534014190bae@amazon.com>
 <20201108234935.GC244516@ziepe.ca>
 <7a9866b6-fa33-0b95-4bda-4c83112be369@amazon.com>
 <20201109175700.GF244516@ziepe.ca>
 <6c77ad03-db3b-a1f8-cd28-a744585ba26d@amazon.com>
 <20201110134122.GL244516@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110134122.GL244516@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 10, 2020 at 09:41:22AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 10, 2020 at 09:49:11AM +0200, Gal Pressman wrote:
> > On 09/11/2020 19:57, Jason Gunthorpe wrote:
> > > On Mon, Nov 09, 2020 at 11:03:47AM +0200, Gal Pressman wrote:
> > >
> > >>> The thing is, is is still useless. You have to consult sysfs to
> > >>> understand what bus it is scoped on to do anything further with
> > >>> it. Can't just assume it is PCI.
> > >>
> > >> This can be solved with Parav's suggestion.
> > >
> > > Now you are adding more stuff.
> > >
> > > What is wrong with reading sysfs? sysfs is where topology information
> > > lives, why do we need to denormalize things?
> >
> > And yet you have lspci so you don't have to dig through the sysfs files by hand
> > for that topology.
> > Please drop this patch.
>
> If you want to add something to rdma tool it can read sysfs and disply it

I tried it and it wasn't accepted well in netdev community.

Thanks

>
> Jason
