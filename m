Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE9C29A46D
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Oct 2020 07:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506163AbgJ0GD0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Oct 2020 02:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506151AbgJ0GDZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Oct 2020 02:03:25 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72052207BB;
        Tue, 27 Oct 2020 06:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603778605;
        bh=zM4Qs1pQG+JasfrtI4Cc0+6ajuTrnNNeuLNYuxKLb0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJ6r+QubcjfEsv4zXelFYDAxGe0IiZ2149n3NCTLsVAAZJyN2NoswkbaC21kJJmka
         f+q2+O/vbszIaVQlG0rGbEIAf/Nknrw0qeKJ6Q9xOGwtkm5QSu/BgRrNge2/Cm1bGE
         hJ20Ghs18qAWBqJn7bn9/6RiCwXGZWqJ4rFQZth4=
Date:   Tue, 27 Oct 2020 08:03:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
        "majd@mellanox.com" <majd@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 3/6] RDMA/mlx5: Use
 mlx5_umem_find_best_quantized_pgoff() for WQ
Message-ID: <20201027060320.GE4821@unreal>
References: <20201026132635.1337663-1-leon@kernel.org>
 <20201026132635.1337663-4-leon@kernel.org>
 <94d30486-1909-f044-b59c-ba52e0b1e0e9@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94d30486-1909-f044-b59c-ba52e0b1e0e9@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 26, 2020 at 04:42:12PM +0200, Gal Pressman wrote:
> On 26/10/2020 15:26, Leon Romanovsky wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> >
> > This fixes a subtle bug, the WQ mailbox has only 5 bits to describe the
> > page_offset, while mlx5_ib_get_buf_offset() is hard wired to only work
> > with 6 bit page_offsets.
> >
> > Thus it did not properly reject badly aligned buffers.
> >
> > YISHAI: WTF? Why does this PRM command only have 5 bits? We must force 4k
> > alignment for WQ umems in the userspace?
>
> You forgot to remove those :).

Yeah, sorry, this is what is happening if you are keeping patches in
submission queue for months :(.

Thanks
