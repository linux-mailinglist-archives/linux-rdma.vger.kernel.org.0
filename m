Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46D1323A25
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Feb 2021 11:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhBXKF0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Feb 2021 05:05:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234636AbhBXKFD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Feb 2021 05:05:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A05964ED3;
        Wed, 24 Feb 2021 10:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614161062;
        bh=Nw0mgdgis9xCN8z4FpRfRyO/GxKvWT8srH/JZMirdj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmsFkDeA6uKkNj+XRC8h6nMYId32B2FEl/B8EpyS1jCmqT0XZ3UV7jyKlBsnJn0sm
         0mrSUZ8/UUx7GYJgMGK0Fa3Gz/yIcc5SeGGaeW4Ai0SdhlhGi7eOWCwO3xBOPlJeOR
         sJL3/wWp/RYHVETdcBu0/v/2WjRfO6q7xC7lbC3xxnKM2VI5oDiy+V4AabTj0vGyWi
         Ipfsxd4cMAeBm38zV9qAtkAxLxWeGuOKyjAu6N0dYvpw7OMX8c05FD1Tv/VAQS1bgP
         CiaJdJDj/kgA2m4aoomFFBsxegRFvVXHV9XqGz9GhkgsscvjMgpBTbB1arO0dvMGLk
         M2kyZ+eqtF7Ow==
Date:   Wed, 24 Feb 2021 12:04:19 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Julian Braha <julianbraha@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: infiniband: sw: rxe: fix kconfig dependency on
 CRYPTO
Message-ID: <YDYko5zdCkssqw3t@unreal>
References: <21525878.NYvzQUHefP@ubuntu-mate-laptop>
 <CAJ-ZY99xZEsS5pCbZ7evi_ohozQBpHcNHDcXxfoeaLzuWRzyzw@mail.gmail.com>
 <CAK8P3a1jRS=QyTxJzSxfEsaAuF5HnOXbv4MOu8b5EZWEhUep=Q@mail.gmail.com>
 <10464303.FBcTZR2von@ubuntu-mate-laptop>
 <CAK8P3a1XW0NTFHiEUoLgeHGpKUfYgM8T8Or7ix3m6Fd-TLEn5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1XW0NTFHiEUoLgeHGpKUfYgM8T8Or7ix3m6Fd-TLEn5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 23, 2021 at 11:05:45PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 23, 2021 at 10:54 PM Julian Braha <julianbraha@gmail.com> wrote:
> > On Tuesday, February 23, 2021 4:26:44 PM EST Arnd Bergmann wrote:
> > > On Tue, Feb 23, 2021 at 9:46 PM Julian Braha <julianbraha@gmail.com> wrote:
> > > >
> > > > I have other similar patches that I intend to submit. What should I do,
> > > > going forward? Should I use "depends on CRYPTO" for cases like these?
> > > > Should I resubmit this patch with that change?
> > >
> > > No, we should not mix the two methods, that just leads to circular dependencies.
> > >
> > > How many more patches do you have that need to get merged?
> > >
> > > If it's only a few, I'd suggest merging them first before we consider a
> > > broader change. If the problem is very common, we may want to
> > > think about alternative approaches first, and then change everything
> > > at once.
> >
> > Sorry, I don't have a specific number, but it's certainly under a dozen patches.
>
> It's probably best to continue pushing those first then.

Arnd,

I'm hearing it over and over for a long time already. People are focused
on micro-solutions instead of one, powerful change, which is not hard to
do.

Thanks

>
>         Arnd
