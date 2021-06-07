Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6596039DB7B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 13:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhFGLjQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 07:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231497AbhFGLjM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 07:39:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54B7661130;
        Mon,  7 Jun 2021 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623065841;
        bh=4Fjpri+KDpM8VFQjB0uGSbfPCZvhFsguE5r75Vv3ong=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gdkj+VvhIGp6KXf13LwzmqUnHyVMCR5w7v63D1B50WPH5SEVF+DFWMCLg1lz6Va1K
         5nIlG0rxIIwCDdoCaIM8n3uKjZBLWGRotEiXEgn5K8dOTrugGFJT3AejRVVrqW+a3o
         Kl3rpU/81Mr/Azzj/pmwJYt2eNwt0u+ZMl7r9g5a/p3aKEP9q8TJuwxzoJHZOLH4M8
         itp3yCRW7fATq44rE42BXWTtLpAzk9x/YXqDX5QY6GDdZfW/6/jshBHCr3VFjK/qkh
         y14Ae5Eon42AXv9f/0pqCyEK05oTsNInAoiEofqrQxJppQJibrYv3n9hGpa1HwuvpR
         Dq17HJ1YRqyHg==
Date:   Mon, 7 Jun 2021 14:37:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <YL4E7C7tVUMy3poz@unreal>
References: <cover.1623053078.git.leonro@nvidia.com>
 <00e578937f557954d240bc0856f45b3f752d6cba.1623053078.git.leonro@nvidia.com>
 <YL3z/xpm5EYHFuZs@kroah.com>
 <YL36OFkmlxJiqjvc@unreal>
 <YL4Bcm2dOyWKLGJ7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL4Bcm2dOyWKLGJ7@kroah.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 07, 2021 at 01:22:26PM +0200, Greg KH wrote:
> On Mon, Jun 07, 2021 at 01:51:36PM +0300, Leon Romanovsky wrote:
> > On Mon, Jun 07, 2021 at 12:25:03PM +0200, Greg KH wrote:
> > > On Mon, Jun 07, 2021 at 11:17:35AM +0300, Leon Romanovsky wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > 
> > > > This code is trying to attach a list of counters grouped into 4 groups to
> > > > the ib_port sysfs. Instead of creating a bunch of kobjects simply express
> > > > everything naturally as an ib_port_attribute and add a single
> > > > attribute_groups list.
> > > > 
> > > > Remove all the naked kobject manipulations.
> > > 
> > > Much nicer.
> > > 
> > > But why do you need your counters to be atomic in the first place?  What
> > > are they counting that requires this?  Given that they are just a
> > > statistic for userspace, making them be a u64 should work just the same,
> > > right?
> > 
> > The statistic counters are per-port, while the cm.c flows run in
> > asynchronically in parallel for every CM connection.
> > 
> > We need atomic variable to ensure that "write to u64" is not
> > interrupted.
> 
> On what system is "write to u64" interruptable? 

On 32 bits, and yes, we have a customer who still uses such system.

> As these are per-port, do multiple threads try to increment these at
> the same time?  

Yes, CM connection can be seen as thread. Bottom line everything in parallel.

> And even if they do, what happens if one is 'dropped' somehow because of this?

Probably nothing, we increment the statistics only.

> It's just a userspace statistic counter, what relies on this being
> exact?

In kernel nothing, but I have no idea what userspace does with these counters.

> 
> thanks,
> 
> greg k-h
