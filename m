Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3BD3217DA
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 14:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhBVNBj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 08:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231506AbhBVNAw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Feb 2021 08:00:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7892164E41;
        Mon, 22 Feb 2021 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613998807;
        bh=nDRWYHNsa+cFWunPd5wmVkyRdJdv5f0ZF3Zd9b2ZiAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Znn+NKOUvzUMhpEVyufbit3bf6FGwxqJbKPBTGxAL6nl9a7mpVItNCIGRttnPSTUW
         4fttNwWwU2aBoMz3TpOtU8q3ZdKnVQ0tkiL0tm5URp6I6DDsty32S8mPJ4LsS7rUtX
         eK2su4okB/j8z+Eiwwo6jX8cKUG4FX6O9SuoC/OYCl52PUdMICSavE9JU7Dn+1dvnA
         PakEe4vv9wE3CqnzEhjYT3/IBC0jI2kIPncncmS5uzNzKQ0kWjKz/bEJbkobLm0EEJ
         +XfkYlHQ98/lxiVa/QO0XLQ9yKIaorjIUIB/lBg09DTu/Pv4ZRLdBlGut6zgWcC3J/
         A9ycPRRqzeQvQ==
Date:   Mon, 22 Feb 2021 15:00:03 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Julian Braha <julianbraha@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: infiniband: sw: rxe: fix kconfig dependency on
 CRYPTO
Message-ID: <YDOq060TvAwLgknl@unreal>
References: <21525878.NYvzQUHefP@ubuntu-mate-laptop>
 <YDICM3SwwGZfE+Sg@unreal>
 <CAD=hENeCXGtKrXxLof=DEZjxpKyYBFS80pAX20nnJBuP_s-GBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENeCXGtKrXxLof=DEZjxpKyYBFS80pAX20nnJBuP_s-GBA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 10:39:20AM +0800, Zhu Yanjun wrote:
> On Sun, Feb 21, 2021 at 2:49 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Feb 19, 2021 at 06:32:26PM -0500, Julian Braha wrote:
> > > commit 6e61907779ba99af785f5b2397a84077c289888a
> > > Author: Julian Braha <julianbraha@gmail.com>
> > > Date:   Fri Feb 19 18:20:57 2021 -0500
> > >
> > >     drivers: infiniband: sw: rxe: fix kconfig dependency on CRYPTO
> > >
> > >     When RDMA_RXE is enabled and CRYPTO is disabled,
> > >     Kbuild gives the following warning:
> > >
> > >     WARNING: unmet direct dependencies detected for CRYPTO_CRC32
> > >       Depends on [n]: CRYPTO [=n]
> > >       Selected by [y]:
> > >       - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS [=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && INFINIBAND_VIRT_DMA [=y]
> > >
> > >     This is because RDMA_RXE selects CRYPTO_CRC32,
> > >     without depending on or selecting CRYPTO, despite that config option
> > >     being subordinate to CRYPTO.
> > >
> > >     Signed-off-by: Julian Braha <julianbraha@gmail.com>
> >
> > Please use git sent-email to send patches and please fix crypto Kconfig
> > to enable CRYPTO if CRYPTO_* selected.
> >
> > It is a little bit awkward to request all users of CRYPTO_* to request
> > select CRYPTO too.
>
> The same issue and similar patch is in this link:
>
> https://patchwork.kernel.org/project/linux-rdma/patch/20200915101559.33292-1-fazilyildiran@gmail.com/#23615747

So what prevents us from fixing CRYPTO Kconfig?

Thanks

>
> Zhu Yanjun
>
> >
> > Thanks
> >
> > >
> > > diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
> > > index 452149066792..06b8dc5093f7 100644
> > > --- a/drivers/infiniband/sw/rxe/Kconfig
> > > +++ b/drivers/infiniband/sw/rxe/Kconfig
> > > @@ -4,6 +4,7 @@ config RDMA_RXE
> > >         depends on INET && PCI && INFINIBAND
> > >         depends on INFINIBAND_VIRT_DMA
> > >         select NET_UDP_TUNNEL
> > > +      select CRYPTO
> > >         select CRYPTO_CRC32
> > >         help
> > >         This driver implements the InfiniBand RDMA transport over
> > >
> > >
> > >
