Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC4B377FD4
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 11:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhEJJvh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 05:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhEJJvg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 05:51:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32CE6613DC;
        Mon, 10 May 2021 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620640231;
        bh=GD5CeNZDDk2HnqepEeOE64tTfn4Dz7d0cT+DcE4AKGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MStGnfcoFkBgk2DPOr/3cP2HGX9QFdlP/KnXfz20mMwe74dmIqK3K81HKD1KubDov
         LGIJprZyBpN/Htuv63c/EPqd++eIRhhHX36CwZN9yb7YT3sT270K+NVe6a0enNHqR+
         6KY1sqTwL98F4UPBLiYF7E/laB2r8wzpsnoh5N6oRAeFRETBaqCYbErSDvatfeiqdx
         37KikoEdDm3rTWW0yohujLzdTo7ooOQsZgDMruVY5Kx1E51UO/8O+FtjldLQsfFYmV
         /sltrvmhvwbkm7JvKPy76IYkFPMXy0XWyiupHkMNYrg96YE0kIzdbG0uRKyx7Zl8JA
         7zegAjvufK4Lw==
Date:   Mon, 10 May 2021 12:50:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [V2 rdma-core 0/4] Broadcom's rdma provider lib update
Message-ID: <YJkB5N42Zjjwp4ok@unreal>
References: <20210505171056.514204-1-devesh.sharma@broadcom.com>
 <CANjDDBhyp_YzPE2s6S2HZx20vyrMOEdxhjx4kprtEQWxw+Aoyg@mail.gmail.com>
 <YJjHcUYLhMQGwoD1@unreal>
 <CANjDDBigmYJYocHpN8akxy1QxFgBT1FtVnOObkLz8Ji5-cYVUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBigmYJYocHpN8akxy1QxFgBT1FtVnOObkLz8Ji5-cYVUg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 11:55:24AM +0530, Devesh Sharma wrote:
> On Mon, May 10, 2021 at 11:11 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, May 10, 2021 at 10:33:48AM +0530, Devesh Sharma wrote:
> > > On Wed, May 5, 2021 at 10:41 PM Devesh Sharma
> > > <devesh.sharma@broadcom.com> wrote:
> > > >
> > > > This patch series is a part of bigger feature submission which
> > > > changes the wqe posting logic. The current series adds the
> > > > ground work in the direction to change the wqe posting algorithm.
> > > >
> > > > v1->v2
> > > > - added Fixes tag
> > > > - updated patch description
> > > > - dropped if() check before free.
> > > >
> > > > Devesh Sharma (4):
> > > >   bnxt_re/lib: Check AH handler validity before use
> > > >   bnxt_re/lib: align base sq entry structure to 16B boundary
> > > >   bnxt_re/lib: consolidate hwque and swque in common structure
> > > >   bnxt_re/lib: query device attributes only once and store
> > > >
> > > >  providers/bnxt_re/bnxt_re-abi.h |  24 ++---
> > > >  providers/bnxt_re/db.c          |   6 +-
> > > >  providers/bnxt_re/main.c        |  31 +++---
> > > >  providers/bnxt_re/main.h        |  15 ++-
> > > >  providers/bnxt_re/verbs.c       | 182 +++++++++++++++++---------------
> > > >  5 files changed, 138 insertions(+), 120 deletions(-)
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > > Hello Maintainers, Could you bless the V2 if there are no more
> > > comments/suggestions...
> >
> > I planned to take it after rdma-core release (today/tomorrow).
> >
> > Thanks
> Sure, Thanks.

Applied, thanks

> >
> > >
> > > --
> > > -Regards
> > > Devesh
> >
> >


