Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1689F35420E
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Apr 2021 14:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbhDEMkH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Apr 2021 08:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235289AbhDEMkH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Apr 2021 08:40:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50024613A3;
        Mon,  5 Apr 2021 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617626401;
        bh=EnYc02ojerZa0n6Tf2F3o1fHFoGaCmzd1tnTjO9i5Y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VFBfCZLPjVa9HU9psssGoSfKq2tPp1iuQVskIbIlGBQhYnTiucMc8CKZGCv5CIuWB
         2NQgXWX7P+eDi4V0MWFPJCs6dDXBodc66h8CohHYcMp4KqG2XZKf7RHqEm+iNViy3Y
         1tyGOu8eSzlmdkgqDx3lSytTknONEGF75w3z8vxmEyBqIURu0yGQD63D91qVJxi/hw
         U9Hh2KEpZSBR98MFm2OSl/6s/8xzhzkyhc+/JGsb65YpoY/wLI6VjkeTNUjXYe9GOj
         fI7GWTKG4l20T8YcZ1A3Qq055AUpTibNUOUdD8CWhKAeQ0+6iWkZUZMpCZHbGNt/4b
         xZpMwtA1Us4+Q==
Date:   Mon, 5 Apr 2021 15:39:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/nldev: Add copy-on-fork attribute to get
 sys command
Message-ID: <YGsFHWU8Hqd5LADT@unreal>
References: <20210405114722.98904-1-galpress@amazon.com>
 <YGr7EajqXvSGyZfy@unreal>
 <d8ec4f81-25a6-7243-12c4-af4f5b64a27f@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8ec4f81-25a6-7243-12c4-af4f5b64a27f@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 05, 2021 at 03:15:18PM +0300, Gal Pressman wrote:
> On 05/04/2021 14:57, Leon Romanovsky wrote:
> > On Mon, Apr 05, 2021 at 02:47:21PM +0300, Gal Pressman wrote:
> >> The new attribute indicates that the kernel copies DMA pages on fork,
> >> hence libibverbs' fork support through madvise and MADV_DONTFORK is not
> >> needed.
> >>
> >> The introduced attribute is always reported as supported since the
> >> kernel has the patch that added the copy-on-fork behavior. This allows
> >> the userspace library to identify older vs newer kernel versions.
> >> Extra care should be taken when backporting this patch as it relies on
> >> the fact that the copy-on-fork patch is merged, hence no check for
> >> support is added.
> > 
> > Please be more specific, add SHA-1 of that patch and wrote the same
> > comment near "err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,
> > 1);" line.
> > 
> > Thanks
> 
> Should I put the original commit here? There were quite a lot of bug fixes and
> followups that are required.

IMHO, the last commit SHA will be enough, the one that has working
functionality from your POV.

Thanks

> 
> >>
> >> Copy-on-fork attribute is read-only, trying to change it through the set
> >> sys command will result in an error.
> >>
> >> Signed-off-by: Gal Pressman <galpress@amazon.com>
> >> ---
> >> PR was sent:
> >> https://github.com/linux-rdma/rdma-core/pull/975
> >> ---
> >>  drivers/infiniband/core/nldev.c  | 19 ++++++++++++++-----
> >>  include/uapi/rdma/rdma_netlink.h |  2 ++
> >>  2 files changed, 16 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> >> index b8dc002a2478..87c68301c25b 100644
> >> --- a/drivers/infiniband/core/nldev.c
> >> +++ b/drivers/infiniband/core/nldev.c
> >> @@ -146,6 +146,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
> >>       [RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID]      = { .type = NLA_U32 },
> >>       [RDMA_NLDEV_NET_NS_FD]                  = { .type = NLA_U32 },
> >>       [RDMA_NLDEV_SYS_ATTR_NETNS_MODE]        = { .type = NLA_U8 },
> >> +     [RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]      = { .type = NLA_U8 },
> >>  };
> >>
> >>  static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
> >> @@ -1693,12 +1694,19 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
> >>
> >>       err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_NETNS_MODE,
> >>                        (u8)ib_devices_shared_netns);
> >> -     if (err) {
> >> -             nlmsg_free(msg);
> >> -             return err;
> >> -     }
> >> +     if (err)
> >> +             goto err_nlmsg_free;
> >> +
> >> +     err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK, 1);
> >> +     if (err)
> >> +             goto err_nlmsg_free;
> > 
> > Is it important to have an ability to fail here? Can we simply ignore
> > failure?
> 
> Should be fine.
> 
> Thanks
