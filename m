Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64174321D6C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 17:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhBVQvQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 11:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhBVQvG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Feb 2021 11:51:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFBE664EF5;
        Mon, 22 Feb 2021 16:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614012625;
        bh=NdPYl+QWm8xo7ev8sCTXYwm6VXHmzh9VDOg2opkQ6i4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pn75JUGxdwgvVJA1khgp3BBoVuUVh4ybT4LVCLZhLEkU7EF6dlo4vXysceu5kOyrQ
         6nZfkFrC+IMXgr3jrHYMk9QYwxAbbp53WKVMDXE2fApUD1E3wi53y4eBe0Wo4vqZuy
         Vth9nBx0m32+u2hY/p3WKY7y8EgHzi3N/uXKWw4jbd+XpvzIcSP2wTzS6MN9L8Ybcv
         Hyj4GqDYTcb+gTN3An1CPPtZPdxtKSzbkwfJZ+HHuBrYCZXWtqQaWXLMyLdtpRerLH
         /6hCY4hgnRv2l7j3W5KHcGmS6YTlHw9zowVgN/E/D99g8iQx0xwbU5+R90G2L5x8aA
         vGZaXpn4gNFcw==
Date:   Mon, 22 Feb 2021 18:50:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Julian Braha <julianbraha@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: infiniband: sw: rxe: fix kconfig dependency on
 CRYPTO
Message-ID: <YDPgzFkF7L6S5xQa@unreal>
References: <21525878.NYvzQUHefP@ubuntu-mate-laptop>
 <YDICM3SwwGZfE+Sg@unreal>
 <CAD=hENeCXGtKrXxLof=DEZjxpKyYBFS80pAX20nnJBuP_s-GBA@mail.gmail.com>
 <YDOq060TvAwLgknl@unreal>
 <20210222155845.GI2643399@ziepe.ca>
 <e1e3bec7-0350-4bdd-50c3-41b21388fc71@infradead.org>
 <20210222164645.GK2643399@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222164645.GK2643399@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 12:46:45PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 22, 2021 at 08:26:10AM -0800, Randy Dunlap wrote:
> > On 2/22/21 7:58 AM, Jason Gunthorpe wrote:
> > > On Mon, Feb 22, 2021 at 03:00:03PM +0200, Leon Romanovsky wrote:
> > >> On Mon, Feb 22, 2021 at 10:39:20AM +0800, Zhu Yanjun wrote:
> > >>> On Sun, Feb 21, 2021 at 2:49 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >>>>
> > >>>> On Fri, Feb 19, 2021 at 06:32:26PM -0500, Julian Braha wrote:
> > >>>>> commit 6e61907779ba99af785f5b2397a84077c289888a
> > >>>>> Author: Julian Braha <julianbraha@gmail.com>
> > >>>>> Date:   Fri Feb 19 18:20:57 2021 -0500
> > >>>>>
> > >>>>>     drivers: infiniband: sw: rxe: fix kconfig dependency on CRYPTO
> > >>>>>
> > >>>>>     When RDMA_RXE is enabled and CRYPTO is disabled,
> > >>>>>     Kbuild gives the following warning:
> > >>>>>
> > >>>>>     WARNING: unmet direct dependencies detected for CRYPTO_CRC32
> > >>>>>       Depends on [n]: CRYPTO [=n]
> > >>>>>       Selected by [y]:
> > >>>>>       - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS [=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && INFINIBAND_VIRT_DMA [=y]
> > >>>>>
> > >>>>>     This is because RDMA_RXE selects CRYPTO_CRC32,
> > >>>>>     without depending on or selecting CRYPTO, despite that config option
> > >>>>>     being subordinate to CRYPTO.
> > >>>>>
> > >>>>>     Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > >>>>
> > >>>> Please use git sent-email to send patches and please fix crypto Kconfig
> > >>>> to enable CRYPTO if CRYPTO_* selected.
> > >>>>
> > >>>> It is a little bit awkward to request all users of CRYPTO_* to request
> > >>>> select CRYPTO too.
> > >>>
> > >>> The same issue and similar patch is in this link:
> > >>>
> > >>> https://patchwork.kernel.org/project/linux-rdma/patch/20200915101559.33292-1-fazilyildiran@gmail.com/#23615747
> > >>
> > >> So what prevents us from fixing CRYPTO Kconfig?
> > >
> > > Yes, I would like to see someone deal with this properly, either every
> > > place doing select CRYPTO_XX needs fixing or something needs to be
> > > done in the crypto layer.
> > >
> > > I have no idea about kconfig to give advice, I've added Arnd since he
> > > always seems to know :)
> >
> > I will Ack the original patch in this thread.
>
> The one from Julian?
>
> > How many Mellanox drivers are you concerned about?
>
> ?? This is about rxe
>
> > You don't have to fix any other drivers that have a similar issue.
>
> Why shouldn't they be fixed too?
>
> There is nearly 1000 places that use a 'select CRYPTO_*' in the
> kernel.
>
> I see only 60 'select CRYPTO' statements.

I don't like the suggestion to ack and not fix either.
All CRYPTO_CRC32C users need CRYPTO and it means that CRYPTO Kconfig
should be fixed.

➜  kernel git:(queue-next) git grep -B 1 "select CRYPTO_CRC32"
drivers/infiniband/sw/rxe/Kconfig-      select NET_UDP_TUNNEL
drivers/infiniband/sw/rxe/Kconfig:      select CRYPTO_CRC32
--
drivers/nvme/host/Kconfig-      select CRYPTO
drivers/nvme/host/Kconfig:      select CRYPTO_CRC32C
--
drivers/scsi/Kconfig-   select CRYPTO_MD5
drivers/scsi/Kconfig:   select CRYPTO_CRC32C
--
drivers/target/iscsi/Kconfig-   select CRYPTO
drivers/target/iscsi/Kconfig:   select CRYPTO_CRC32C
drivers/target/iscsi/Kconfig:   select CRYPTO_CRC32C_INTEL if X86
--
fs/btrfs/Kconfig-       select CRYPTO
fs/btrfs/Kconfig:       select CRYPTO_CRC32C
--
fs/ext4/Kconfig-        select CRYPTO
fs/ext4/Kconfig:        select CRYPTO_CRC32C
--
fs/f2fs/Kconfig-        select CRYPTO
fs/f2fs/Kconfig:        select CRYPTO_CRC32
--
fs/jbd2/Kconfig-        select CRYPTO
fs/jbd2/Kconfig:        select CRYPTO_CRC32C
--
lib/Kconfig-    select CRYPTO
lib/Kconfig:    select CRYPTO_CRC32C


>
> Jason
