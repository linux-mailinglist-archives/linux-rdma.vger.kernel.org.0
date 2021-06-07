Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A684739DCAD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 14:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFGMlj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 08:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhFGMlj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 08:41:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E4EB611C0;
        Mon,  7 Jun 2021 12:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623069588;
        bh=Zjlt55KMswnh9QqGbwu3mbMkjV9KlBZv59wVoY8s6lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdktRMOhRdqo8mujxRH7TjuCV5c13oGNlAG8M+c43vJUQwVFxmhDvlaltSIq2PdsU
         x4bExb/WGg371tivgQcy3STYNmtaUq2RKKIvRjV5g/qyrQhWwFoHRNHJYbZR/o1zEy
         vox2wktMQMExdVNmV5EVzN2lc8zOLzJRdFyghS/A=
Date:   Mon, 7 Jun 2021 14:39:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v1 10/15] RDMA/cm: Use an attribute_group on
 the ib_port_attribute intead of kobj's
Message-ID: <YL4TkfVlTellmnc+@kroah.com>
References: <cover.1623053078.git.leonro@nvidia.com>
 <00e578937f557954d240bc0856f45b3f752d6cba.1623053078.git.leonro@nvidia.com>
 <YL3z/xpm5EYHFuZs@kroah.com>
 <20210607121411.GC1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607121411.GC1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 07, 2021 at 09:14:11AM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 07, 2021 at 12:25:03PM +0200, Greg KH wrote:
> > On Mon, Jun 07, 2021 at 11:17:35AM +0300, Leon Romanovsky wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > 
> > > This code is trying to attach a list of counters grouped into 4 groups to
> > > the ib_port sysfs. Instead of creating a bunch of kobjects simply express
> > > everything naturally as an ib_port_attribute and add a single
> > > attribute_groups list.
> > > 
> > > Remove all the naked kobject manipulations.
> > 
> > Much nicer.
> > 
> > But why do you need your counters to be atomic in the first place?  What
> > are they counting that requires this?  
> 
> The write side of the counter is being updated from concurrent kernel
> threads without locking, so this is an atomic because the write side
> needs atomic_add().

So the atomic write forces a lock :(

> Making them a naked u64 will cause significant corruption on the write
> side, and packet counters that are not accurate after quiescence are
> not very useful things.

How "accurate" do these have to be?

And have you all tried them?

I'm pushing back here as I see a lot of atomics used for debugging
statistics for no good reason all over the place.  Especially when
userspace just does not care.

thanks,

greg k-h
