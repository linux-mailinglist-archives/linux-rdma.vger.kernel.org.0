Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FB33984D5
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhFBJEy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 05:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhFBJEr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 05:04:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 160A5611BF;
        Wed,  2 Jun 2021 09:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622624581;
        bh=W1HS+Fd5lgTIqMdQwJRoo5JfX/u3a8PaEyluE/TZuT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qr9An8cMbX3JEhmRezEGFys8/LMarivFw2Xi/mtgaYikJQQK9fX2YBiDdXy6qxrZb
         i8GrKhB4erFFO6IEAQw+/w7IvD8WuLw5Y0UZJCAfoIb+fih9KxxCQhqAIGLxwBuDtx
         3w/toMaVZhSZ2p4QOvImLgHk9eqHRovxCZtqDOj8NgOClz9uEc3zL4yNU1WpLeLHKR
         4hUQoam05Yw3BhDwdmslRcAtX7Lgl+WAglWMZ4yaZ5+++fqwYBUVNXaHjBSZT/WCZ+
         HiMof72xLVIuJA+UTpqdLvy5e6Wl4AhX1CxyBgUKGAqZ49INSF2p1rTF3qeu26V3XH
         9Mst0gXeIc/gQ==
Date:   Wed, 2 Jun 2021 12:02:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH V2 INTERNAL 0/4] Broadcom's user library update
Message-ID: <YLdJQZDpqD0Niuky@unreal>
References: <20210517133532.774998-1-devesh.sharma@broadcom.com>
 <CANjDDBgR_wP5WHWWRue_Pg8XYujcuoqFs2J-zHD0c2g9+bRfjg@mail.gmail.com>
 <CANjDDBjO4dOXCb5rVe1UOd6foeFp8FLTqJbz8w6c36eTZSZtkg@mail.gmail.com>
 <YKUwKa6fNfBq8b8a@unreal>
 <CANjDDBhNFh4VqPdD09ssUMVZKHgvnRxS8MuttNS1JjeFSk23EQ@mail.gmail.com>
 <CANjDDBiymTXPo2Oj=vfpNUgOXbX8HDjsoiDQs5nh=5QUiMYavQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBiymTXPo2Oj=vfpNUgOXbX8HDjsoiDQs5nh=5QUiMYavQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 26, 2021 at 11:03:09AM +0530, Devesh Sharma wrote:
> On Mon, May 24, 2021 at 6:32 PM Devesh Sharma
> <devesh.sharma@broadcom.com> wrote:
> >
> > On Wed, May 19, 2021 at 9:05 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Wed, May 19, 2021 at 08:45:20PM +0530, Devesh Sharma wrote:
> > > > On Mon, May 17, 2021 at 7:08 PM Devesh Sharma
> > > > <devesh.sharma@broadcom.com> wrote:
> > > > >
> > > > > On Mon, May 17, 2021 at 7:05 PM Devesh Sharma
> > > > > <devesh.sharma@broadcom.com> wrote:
> > > > > >
> > > > > > The main focus of this patch series is to move SQ and RQ
> > > > > > wqe posting indices from 128B fixed stride to 16B aligned stride.
> > > > > > This allows more flexibility in choosing wqe size.
> > > > > >
> > > > > >
> > > > > > Devesh Sharma (4):
> > > > > >   bnxt_re/lib: Read wqe mode from the driver
> > > > > >   bnxt_re/lib: add a function to initialize software queue
> > > > > >   bnxt_re/lib: Use separate indices for shadow queue
> > > > > >   bnxt_re/lib: Move hardware queue to 16B aligned indices
> > > > > >
> > > > > >  kernel-headers/rdma/bnxt_re-abi.h |   5 +-
> > > > > >  providers/bnxt_re/bnxt_re-abi.h   |   5 +
> > > > > >  providers/bnxt_re/db.c            |  10 +-
> > > > > >  providers/bnxt_re/main.c          |   4 +
> > > > > >  providers/bnxt_re/main.h          |  26 ++
> > > > > >  providers/bnxt_re/memory.h        |  37 ++-
> > > > > >  providers/bnxt_re/verbs.c         | 522 ++++++++++++++++++++----------
> > > > > >  7 files changed, 431 insertions(+), 178 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > > > Please ignore the "Internal" keyword in the subject line.
> > > > >
> > > > > --
> > > > > -Regards
> > > > > Devesh
> > > > Hi Leon,
> > > >
> > > > Do you have any comments on this series. For the subject line I can
> > > > resend the series.
> > >
> > > Yes, the change in kernel-headers/rdma/bnxt_re-abi.h should be separate
> > > commit created with kernel-headers/update script.
> > Leon, I need to have my abi changes in the upstream kernel before I
> > change user ABI in rdmacore? The script is popping out some errors.
> Leon Ping!

Leon was on vacation.

Thanks

> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > --
> > > > -Regards
> > > > Devesh
> > >
> > >
> >
> >
> > --
> > -Regards
> > Devesh
> 
> 
> 
> -- 
> -Regards
> Devesh


