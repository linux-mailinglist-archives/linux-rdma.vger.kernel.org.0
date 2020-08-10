Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB22C240571
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Aug 2020 13:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgHJLqn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Aug 2020 07:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgHJLqm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Aug 2020 07:46:42 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD5FD206C3;
        Mon, 10 Aug 2020 11:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597060002;
        bh=B0m9ehh8vjTv0qJR4ZfTwEG6b2dJoJdga5KKwZ20q78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wnjdYgSt+AWVafkqHCprY2o7Is5akRoa6N3/UgYgK3T+iPIrr+eKVcxXuEYQNHINw
         3Jk3fNqNZNhdjcsQTxjm+cPqeSTVWIrB9+ezolt6AqRc8jhUC57PDsQ/gPw62C3UxE
         e6yhhJoKXMoFfFraMtME2Wk2Sc+Z7svxbvCtP8DU=
Date:   Mon, 10 Aug 2020 14:46:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>, ranro@mellanox.com
Subject: Re: [PATCH for-rc v2 0/6] Add CM packets missing and harden the
 proxying
Message-ID: <20200810114637.GA20478@unreal>
References: <20200803061941.1139994-1-haakon.bugge@oracle.com>
 <A84B2186-42F4-4164-B80D-27782CEAE925@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A84B2186-42F4-4164-B80D-27782CEAE925@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 10, 2020 at 01:20:43PM +0200, Håkon Bugge wrote:
> A friendly reminder.

We are in merge window.

BTW, the patches are in our regression all that time and everything works
as expected.

Thanks

>
>
> Thxs, Håkon
>
>
> > On 3 Aug 2020, at 08:19, Håkon Bugge <haakon.bugge@oracle.com> wrote:
> >
> > A high number of MAD packet drops are observed in the mlx4 MAD proxy
> > system. These are fixed by separating the parameters for the tunnel
> > vs. wire QPs and by introducing a separate worker-thread for the wire
> > QPs.
> >
> > Support for MRA and REJ with its reason being timeout is also added.
> >
> > Dynamic debug prints adjusted and amended.
> >
> >    v1->v2:
> > 	* Added commit ("Adjust delayed work when a dup is observed")
> > 	* Minor adjustments in some of the commits
> >
> > Håkon Bugge (6):
> >  IB/mlx4: Add and improve logging
> >  IB/mlx4: Add support for MRA
> >  IB/mlx4: Separate tunnel and wire bufs parameters
> >  IB/mlx4: Fix starvation in paravirt mux/demux
> >  IB/mlx4: Add support for REJ due to timeout
> >  IB/mlx4: Adjust delayed work when a dup is observed
> >
> > drivers/infiniband/hw/mlx4/cm.c      | 148 ++++++++++++++++++++++++-
> > drivers/infiniband/hw/mlx4/mad.c     | 158 +++++++++++++++------------
> > drivers/infiniband/hw/mlx4/mlx4_ib.h |   8 +-
> > 3 files changed, 241 insertions(+), 73 deletions(-)
> >
> > --
> > 2.20.1
> >
>
