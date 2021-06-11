Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332963A3DE7
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 10:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhFKITI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 04:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFKITI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Jun 2021 04:19:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16EF2611CC;
        Fri, 11 Jun 2021 08:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623399414;
        bh=cWwKCFMCJZXC7X39YT4XaDgF/u/unVgrt2qdsyuvX/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xt0tQ0EZ3L1Uc6ZLt+TnhpilBoj7+aGt+YvG8XLZp3M4n1yUdXA1AFWFQhF4QoNZv
         4YINnx/ZQv4JDg7TEKF0oXMkshtdFhmzcsrUlbFgCfGINFkwjTFHki7y/g3AVbZl+8
         di1FKeb9+ImtgtOuyC910MYyCcn24L4arHrF/P4s=
Date:   Fri, 11 Jun 2021 10:16:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
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
Message-ID: <YMMb9NZ0nHRTullc@kroah.com>
References: <cover.1623053078.git.leonro@nvidia.com>
 <00e578937f557954d240bc0856f45b3f752d6cba.1623053078.git.leonro@nvidia.com>
 <YL3z/xpm5EYHFuZs@kroah.com>
 <20210607121411.GC1002214@nvidia.com>
 <YL4TkfVlTellmnc+@kroah.com>
 <20210607125012.GE1002214@nvidia.com>
 <8685A354-4D41-4805-BDC5-365216CEAF40@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8685A354-4D41-4805-BDC5-365216CEAF40@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 11, 2021 at 07:25:46AM +0000, Haakon Bugge wrote:
> 
> 
> > On 7 Jun 2021, at 14:50, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Mon, Jun 07, 2021 at 02:39:45PM +0200, Greg KH wrote:
> >> On Mon, Jun 07, 2021 at 09:14:11AM -0300, Jason Gunthorpe wrote:
> >>> On Mon, Jun 07, 2021 at 12:25:03PM +0200, Greg KH wrote:
> >>>> On Mon, Jun 07, 2021 at 11:17:35AM +0300, Leon Romanovsky wrote:
> >>>>> From: Jason Gunthorpe <jgg@nvidia.com>
> >>>>> 
> >>>>> This code is trying to attach a list of counters grouped into 4 groups to
> >>>>> the ib_port sysfs. Instead of creating a bunch of kobjects simply express
> >>>>> everything naturally as an ib_port_attribute and add a single
> >>>>> attribute_groups list.
> >>>>> 
> >>>>> Remove all the naked kobject manipulations.
> >>>> 
> >>>> Much nicer.
> >>>> 
> >>>> But why do you need your counters to be atomic in the first place?  What
> >>>> are they counting that requires this?  
> >>> 
> >>> The write side of the counter is being updated from concurrent kernel
> >>> threads without locking, so this is an atomic because the write side
> >>> needs atomic_add().
> >> 
> >> So the atomic write forces a lock :(
> > 
> > Of course, but a single atomic is cheaper than the double atomic in a
> > full spinlock.
> > 
> >>> Making them a naked u64 will cause significant corruption on the write
> >>> side, and packet counters that are not accurate after quiescence are
> >>> not very useful things.
> >> 
> >> How "accurate" do these have to be?
> > 
> > They have to be accurate. They are networking packet counters. What is
> > the point of burning CPU cycles keeping track of inaccurate data?
> 
> Consider a CPU with a 32-bit wide datapath to memory, which reads and writes the most significant 4-byte word first:

What CPU is that?

>     Memory                   CPU1                   CPU2
> MSW         LSW        MSW         LSW        MSW         LSW
> 0x0  0xffffffff
> 0x0  0xffffffff        0x0
> 0x0  0xffffffff        0x0  0xffffffff
> 0x0  0xffffffff        0x1         0x0                         cpu1 has incremented its register
> 0x1  0xffffffff        0x1         0x0                         cpu1 has written msw
> 0x1  0xffffffff        0x1         0x0        0x1              cpu2 has read msw
> 0x1  0xffffffff        0x1         0x0        0x1  0xffffffff
> 0x1         0x0        0x1         0x0        0x2         0x0
> 0x2         0x0        0x1         0x0        0x2         0x0
> 0x2         0x0        0x1         0x0        0x2         0x0
> 
> 
> I would say that 0x200000000 vs. 0x100000001 is more than inaccurate!

True, then maybe these should just be 32bit counters :)

thanks,

greg k-h
