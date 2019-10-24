Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F1CE3785
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436820AbfJXQLU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 12:11:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436819AbfJXQLU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 12:11:20 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96687205F4;
        Thu, 24 Oct 2019 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571933479;
        bh=JHS9LfnI8mlY4v8BYnzXSqD1wlK1ORulPtiFocFLPio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mz/+JKVMzO+uhXo/fMBYiO9SFhYuHYENgQp4eqOU0oNndgR6SxwYCnBTR5GfK2L3U
         5SQuTB/Mg5AtJ3VTz3+oJIE7jDDhxaSiubi9PW3OCeFjxAOSSHX/SzGbSC3ny5WKrP
         RAlCCRKvnm+YnL7OVy1ZxMjCmKSwYKGdjGT6a670=
Date:   Thu, 24 Oct 2019 19:11:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] selftests: rdma: Add rdma tests
Message-ID: <20191024161115.GT4853@unreal>
References: <20191023173954.29291-1-kamalheib1@gmail.com>
 <20191023174219.GO23952@ziepe.ca>
 <20191023201008.GA30186@kheib-workstation>
 <20191024063909.GQ4853@unreal>
 <20191024133944.GA20148@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024133944.GA20148@kheib-workstation>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 04:39:44PM +0300, Kamal Heib wrote:
> On Thu, Oct 24, 2019 at 09:39:09AM +0300, Leon Romanovsky wrote:
> > On Wed, Oct 23, 2019 at 11:10:08PM +0300, Kamal Heib wrote:
> > > On Wed, Oct 23, 2019 at 02:42:19PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Oct 23, 2019 at 08:39:54PM +0300, Kamal Heib wrote:
> > > > > Add a new directory to house the rdma specific tests and add the first
> > > > > rdma_dev.sh test that checks the renaming and setting of adaptive
> > > > > moderation using the rdma tool for the available RDMA devices in the
> > > > > system.
> > > >
> > > > What is this actually testing? rdmatool?
> > > >
> > >
> > > This is a very basic test that uses the rdmatool for checking two of the
> > > RDMA devices functionalities.
> > >
> > > > This seems like a very strange kselftest to me.
> > > >
> > >
> > > Basically, you can take a look into other subsystems selftests (e.g.
> > > net) to see that it not that strange :-).
> >
> > Yeah, selftests is in-kernel dumpster, everything goes in. It doesn't
> > mean we should follow this path too. The in-kernel tests are great to
> > check interfaces and not external tools.
> >
>
> OK, I see that you don't like the idea of using external/Userspace tools.
>
> So, what do you suggest?!

You need to decide WHAT do you want to test.
For rdma-core APIs, we have pyverbs, see this PR
https://github.com/linux-rdma/rdma-core/pull/567

For sysfs API, shell scripts in selftest is a good place.
For netlink/verbs API, you will need to write C-programs. <-- don't recommend this path.

>
> > >
> > > Yes, the first test is very basic, but the idea behind it is to utilize
> > > the kernel selftests infrastructure to test the rdma subsystem, I plan to
> > > introduce more tests in the near future, hopefully other folks from the
> > > community will join me too.
> >
> > You don't have any version checks, the idea that you can test latest
> > kernel features with installed "rdmatool" in distro is a little bit over
> > optimistic.
> >
> > >
> > > Thanks,
> > > Kamal
> > >
> > > > Jason
