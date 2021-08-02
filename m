Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8233DDDCB
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 18:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhHBQgK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 12:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhHBQgK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 12:36:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D01761029;
        Mon,  2 Aug 2021 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627922160;
        bh=jH10d1NY8ybX3b76wQNdz4Y+qT0osXyymVh2QtvmmJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPKU5/H6qHDa7SSJjAhjoT29pdJuuWvH2YH1Q8tVPoAANyY+CovW+lNwSSRnDpS87
         eYSH9JDxKhXY2BP0jvNDHJGJ7rVMSwu2KIOXGlt9mVvL3lM2EQAz/8b7V4MJVw9a5p
         0TKborM52kx6UAorc+nqJjKntWMKwLYcIMwSFFmWtuD27YaD//phVPy8ofN5HRnm4T
         /+MOyxj57HylkOcosSbbdvaJA8vqRqCZj5V0xqFJLZ2x4iflPxs1n7kGGUcvDha0qN
         MvDVFKWm2+ZU6m4z9m5pW5/tsYc44VE7dV0flDDp7Mbj+nqbht5B6re5YuPWfK9s1J
         MbnbILSqqDw8A==
Date:   Mon, 2 Aug 2021 19:35:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH for-next 09/10] RDMA/rtrs: Add support to disable an IB
 port on the storage side
Message-ID: <YQge6yQTILQsQECO@unreal>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
 <20210730131832.118865-10-jinpu.wang@ionos.com>
 <YQee8091rXaXU4vL@unreal>
 <CAJpMwyj6SjO+yNsA9uMDZP1Cu2gUfXHAeRGgaGf46xbxDBrk5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyj6SjO+yNsA9uMDZP1Cu2gUfXHAeRGgaGf46xbxDBrk5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 02, 2021 at 04:31:01PM +0200, Haris Iqbal wrote:
> On Mon, Aug 2, 2021 at 9:30 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Jul 30, 2021 at 03:18:31PM +0200, Jack Wang wrote:
> > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > >
> > > This commit adds support to reject connection on a specific IB port which
> > > can be specified in the added sysfs entry for the rtrs-server module.
> > >
> > > Example,
> > >
> > > $ echo "mlx4_0 1" > /sys/class/rtrs-server/ctl/disable_port
> > >
> > > When a connection request is received on the above IB port, rtrs_srv
> > > rejects the connection and notifies the client to disable reconnection
> > > attempts. A manual reconnect has to be triggerred in such a case.
> > >
> > > A manual reconnect can be triggered by doing the following,
> > >
> > > echo 1 > /sys/class/rtrs-client/blya/paths/<select-path>/reconnect

<...>

> >
> > And maybe Jason thinks differently, but I don't feel comfortable with
> > such new sysfs file at all.

This part is much more important and should be cleared before resending.

> >
> > Thanks
