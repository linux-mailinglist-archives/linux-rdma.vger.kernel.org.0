Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD51084B44
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 14:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbfHGMNk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 08:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387446AbfHGMNk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 08:13:40 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CE1D21BF2;
        Wed,  7 Aug 2019 12:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565180019;
        bh=UMTWpUND0WCduYIX9IaBA5Cr2IkOsNeVVZuz7zrRtlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLGEhfz6txgseM61MXgKczSPAvxvqk/eGyHU1HFHOAY3xwiTvzv8oRFktY/0+BTLy
         NzZAUkQ7GKNZc5Nw6MXlRJyCrnpk6WGsbi8xXrl3x0xVEzbr3duZOrrZZxInmP1hmw
         K9q9ZKIauBPJ7ol9z3a/3zzGQGNrrHHSYQzybli0=
Date:   Wed, 7 Aug 2019 15:13:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next 2/6] RDMA/umem: Add ODP type indicator within
 ib_umem_odp
Message-ID: <20190807121335.GC32366@mtr-leonro.mtl.com>
References: <20190807103403.8102-1-leon@kernel.org>
 <20190807103403.8102-3-leon@kernel.org>
 <20190807114406.GC1571@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807114406.GC1571@mellanox.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 07, 2019 at 11:44:16AM +0000, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2019 at 01:33:59PM +0300, Leon Romanovsky wrote:
> > From: Erez Alfasi <ereza@mellanox.com>
> >
> > ODP type can be divided into 2 subclasses:
> > Explicit and Implicit ODP.
> >
> > Adding a type enums and an odp type flag within
> > ib_umem_odp will give us an indication whether a
> > given MR is ODP implicit/explicit registered.
> >
> > Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/umem.c    |  1 +
> >  include/rdma/ib_umem_odp.h        | 14 ++++++++++++++
> >  include/uapi/rdma/ib_user_verbs.h |  5 +++++
> >  3 files changed, 20 insertions(+)
>
> No for this patch, I've got a series cleaning up this
> implicit/explicit nonsense, and the result is much cleaner than this.

It doesn't really clean anything, just stores implicit/explicit information.

>
> This series will have to wait.

The information exposed in this series is already available in uverbs,
so whatever cleanup will come, we still need to expose ODP MR type.

This patch is tiny part of whole series, why should we block whole
series and iproute2?

Thanks

>
> Jason
