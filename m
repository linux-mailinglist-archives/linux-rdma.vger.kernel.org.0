Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742FE3AE686
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 11:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFUJ4T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 05:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFUJ4T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 05:56:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADDCB61151;
        Mon, 21 Jun 2021 09:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624269245;
        bh=OEnUs+FFUyXCYJZ2pT/TAX52GYZOj+VoDurkZafNsV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFcoVsKWNtOb+oigaAlYEca7mB+TQ/FcXIxF6aY5UcZ+XQDKExmIlgllqM5PvncVd
         YIg59DVQVFOsRuCsSF76VIb/RTIFTbMjH0RK9cUDqRT9mKXzfd+jFhmynnDgPbDPpT
         d2Wf4xkylIvreQtWKGqJksJ9TdVY62Saf5PZlPWDSri0jw8nwExtJ+vbzVpiUew8Ya
         rRoBy2QLH8jSECNe+IKf8JfIpt5CGxbBTFigB4kefREy6Hz9A7XZBb0ZHA31CAAaw0
         QhsYr9pnr90fVSHdIkiVlrSEp7Tc/VT60iPGthfJzJL8diQRaG9/47mgZ6SCXnqSMm
         Uye6EgmAlL2Gw==
Date:   Mon, 21 Jun 2021 12:54:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Hans Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Message-ID: <YNBhuZNjGvUsJHUy@unreal>
References: <1623934765-31435-1-git-send-email-haakon.bugge@oracle.com>
 <YNA7ZnKIKC217pCw@unreal>
 <C8E39F1F-14D5-4DBE-ABE0-2EFC20353D83@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C8E39F1F-14D5-4DBE-ABE0-2EFC20353D83@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 08:20:47AM +0000, Haakon Bugge wrote:
> 
> 
> > On 21 Jun 2021, at 09:10, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Thu, Jun 17, 2021 at 02:59:25PM +0200, Håkon Bugge wrote:
> >> The struct rdma_id_private contains three bit-fields, tos_set,
> >> timeout_set, and min_rnr_timer_set. These are set by accessor
> >> functions without any synchronization. If two or all accessor
> >> functions are invoked in close proximity in time, there will be
> >> Read-Modify-Write from several contexts to the same variable, and the
> >> result will be intermittent.
> >> 
> >> Replace with a flag variable and an inline function for set with
> >> appropriate memory barriers and the use of test_bit().
> >> 
> >> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> >> Signed-off-by: Hans Westgaard Ry<hans.westgaard.ry@oracle.com>
> >> 
> >> ---
> >> 	v1 -> v2:
> >> 	   * Removed define wizardry and replaced with a set function
> >>             with memory barriers. Suggested by Leon.
> >> 	   * Removed zero-initialization of flags, due to kzalloc(),
> >>             as suggested by Leon
> >> 	   * Review comments from Stefan implicitly adapted due to
> >>             first bullet above
> >> 	   * Moved defines and inline function from header file to
> >>             cma.c, as suggested by the undersigned
> >> 	   * Renamed enum to cm_id_priv_flag_bits as suggested by the
> >>             undersigned
> >> ---
> >> drivers/infiniband/core/cma.c      | 38 +++++++++++++++++++++++++-------------
> >> drivers/infiniband/core/cma_priv.h |  4 +---
> >> 2 files changed, 26 insertions(+), 16 deletions(-)
> > 
> > This patch generates checkpatch warnings.
> > 
> > ➜  kernel git:(rdma-next) git checkpatch
> > WARNING: line length of 86 exceeds 80 columns
> > #69: FILE: drivers/infiniband/core/cma.c:1149:
> > +	if ((*qp_attr_mask & IB_QP_TIMEOUT) && test_bit(TIMEOUT_SET, &id_priv->flags))
> > 
> > WARNING: line length of 98 exceeds 80 columns
> > #73: FILE: drivers/infiniband/core/cma.c:1152:
> > +	if ((*qp_attr_mask & IB_QP_MIN_RNR_TIMER) && test_bit(MIN_RNR_TIMER_SET, &id_priv->flags))
> > 
> > WARNING: line length of 86 exceeds 80 columns
> > #127: FILE: drivers/infiniband/core/cma.c:3048:
> > +	u8 tos = test_bit(TOS_SET, &id_priv->flags) ? id_priv->tos : default_roce_tos;
> > 
> > WARNING: line length of 84 exceeds 80 columns
> > #136: FILE: drivers/infiniband/core/cma.c:3096:
> > +	route->path_rec->packet_life_time = test_bit(TIMEOUT_SET, &id_priv->flags) ?
> > 
> > 0001-RDMA-cma-Replace-RMW-with-atomic-bit-ops.patch total: 0 errors, 4 warnings, 118 lines checked
> 
> You're running an old checkpatch. Since commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning"), the default line-length is 100. As Linus states in:
> 
> https://lkml.org/lkml/2009/12/17/229
> 
> "... But 80 characters is causing too many idiotic changes."

I'm aware of that thread, but RDMA subsystem continues to use 80 symbols limit.

Thanks
