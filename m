Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE801FC56D
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 06:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgFQEzr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 00:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgFQEzr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jun 2020 00:55:47 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CB4420786;
        Wed, 17 Jun 2020 04:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592369746;
        bh=+vwlwmL9XvgtPa987bjs2Q0bXYbNopHa1BMpTBH24sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZx0E53HPQXbdwRzR1WFggBlpit0GcRRdwes42kkF8LcVGlbx9vP2Vgf449TTlUzo
         s4nXfGGdr+oSTnOYEKygq8l3ppjQvMLKNtY86TRO4I196FLOcqgEFzn/XfTQ1ngYb6
         oDduR5woNX18U8xSgs3NTzNwyRFJ9ZdOdtQhDBvs=
Date:   Wed, 17 Jun 2020 07:55:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Move provider specific attributes to
 ucontext allocation response
Message-ID: <20200617045543.GF2383158@unreal>
References: <20200615075920.58936-1-galpress@amazon.com>
 <20200616063045.GC2141420@unreal>
 <cba7128b-c427-bc26-5f43-69a22463debc@amazon.com>
 <20200616093835.GB2383158@unreal>
 <f6773480-5954-b58b-21f0-f5ee4ec7238b@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6773480-5954-b58b-21f0-f5ee4ec7238b@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 08:44:37PM +0300, Gal Pressman wrote:
> On 16/06/2020 12:38, Leon Romanovsky wrote:
> > On Tue, Jun 16, 2020 at 11:53:11AM +0300, Gal Pressman wrote:
> >> On 16/06/2020 9:30, Leon Romanovsky wrote:
> >>> On Mon, Jun 15, 2020 at 10:59:20AM +0300, Gal Pressman wrote:
> >>>> Provider specific attributes which are necessary for the userspace
> >>>> functionality should be part of the alloc ucontext response, not query
> >>>> device. This way a userspace provider could work without issuing a query
> >>>> device verb call. However, the fields will remain in the query device
> >>>> ABI in order to maintain backwards compatibility.
> >>>
> >>> I don't really understand why "should be ..."? Device properties exposed
> >>> here are per-device and will be equal to all ucontexts, so instead of
> >>> doing one very fast system call, you are "punishing" every ucontext
> >>> call.
> >>
> >> I talked about it with Jason in the past, the query device verb is intended to
> >> follow the IBA verb, alloc ucontext should return driver specific data that's
> >> required to operate the user space provider.
> >> A query device call should not be mandatory to load the provider.
> >
> > Why? query_device is declared as mandatory verb for any provider, so
> > anyway all in-the-tree RDMA drivers will have such verb.
>
> I don't think the concern here is if the verb exists or not, my understanding is
> that query device should be used for IBA query device attributes, not other
> provider specific stuff.
> Jason, want to chime in with your thoughts?

I would like to hear it too. Almost all (if not all) extended
verbs support providing vendor specific data in a response. Why
should query_device() be different here?

>
> >> Whether it's done through query device/ucontext response, both happen for each
> >> new context call. With this patch, we gather all needed data in one system call
> >> instead of two.
> >
> > Is it important in control path to have one call?
>
> Not a huge difference, better one than two though.

My problem here is duplication of functionality and data.

>
> >>> What is wrong with calling one query_device before allocating any
> >>> ucontext? What are you trying to achieve and what will it give?
> >>
> >> How can you call query device without allocating a context?
> >
> > Forget about my comment above, it was my over-thinking.
> >
> > I had in mind some scheme that first ucontext will cache the all device
> > related data and share it with other ucontexts.
> >
> > Thanks
> >
