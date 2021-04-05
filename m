Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06CD3541E8
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Apr 2021 13:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhDEL6r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Apr 2021 07:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233778AbhDEL6r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Apr 2021 07:58:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53386613AF;
        Mon,  5 Apr 2021 11:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617623921;
        bh=WOOT88ud4h4nPew4d9BHzn4oO+pbsvrYF8BiFRhDRxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tbqqsp/uqH1H9stRkgNfTw/k1tvr1oY+wlLVfmORnOlZUf+w26YvCUAymWBc5LsDG
         liw6aY7w+gN+YYij9d9CRnTWGChOUYhhO4hqInDW+TdhB6SmXXpBXV1ZnpN6+y6LDs
         JwkUH5X0GIr6B2cwyV7Vhgmgu7+GBBBXMa9rVMm4OBSXrJL0GzOUfNGkwECjyn+P3b
         TwMxUR6VjljA7zmRCBNGqSF9F4L1r/eX4kcKXPj+g1gSb1HvBnxPqazHzWvuva2tvW
         LqR4q8DosTsAvb9pw0yds+T8Ll5oreD/hNXXFBUbjrlgu5P8nuAk880d8PUihSafb6
         kFaGLx2rTtInw==
Date:   Mon, 5 Apr 2021 14:58:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/nldev: Add copy-on-fork attribute to get
 sys command
Message-ID: <YGr7bY9CcQoDXSb2@unreal>
References: <20210405114722.98904-1-galpress@amazon.com>
 <YGr7EajqXvSGyZfy@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGr7EajqXvSGyZfy@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 05, 2021 at 02:57:05PM +0300, Leon Romanovsky wrote:
> On Mon, Apr 05, 2021 at 02:47:21PM +0300, Gal Pressman wrote:
> > The new attribute indicates that the kernel copies DMA pages on fork,
> > hence libibverbs' fork support through madvise and MADV_DONTFORK is not
> > needed.
> > 
> > The introduced attribute is always reported as supported since the
> > kernel has the patch that added the copy-on-fork behavior. This allows
> > the userspace library to identify older vs newer kernel versions.
> > Extra care should be taken when backporting this patch as it relies on
> > the fact that the copy-on-fork patch is merged, hence no check for
> > support is added.
> 
> Please be more specific, add SHA-1 of that patch and wrote the same
> comment near "err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,
> 1);" line.

And rdmatool should be updated too.

Thanks
