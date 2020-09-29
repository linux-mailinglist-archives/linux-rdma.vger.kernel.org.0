Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384C827C27E
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgI2Kfz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 06:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgI2Kfy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 06:35:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8CF02075F;
        Tue, 29 Sep 2020 10:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601375754;
        bh=u4myyC2FCs6IeunqeNEz8KzBIYzR3949I//QihYj6Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t39Ob8b965lJzHVgrp91VQv3HZgivaKc4BiOwFS1n7y4qtVKlA5fTteqGxoeTICnf
         Il/sc9legvzzDNaoFyM1N/o9c8LxHhttwZTH3LiYcwywKN3ietVy4UMKvywhl39kiY
         xuRac5zW6X8o8oRZdBZfTi1KqrUZBq3flLJ1IXGA=
Date:   Tue, 29 Sep 2020 13:35:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blk-next 1/2] blk-mq-rdma: Delete not-used multi-queue
 RDMA map queue code
Message-ID: <20200929103549.GE3094@unreal>
References: <20200929091358.421086-1-leon@kernel.org>
 <20200929091358.421086-2-leon@kernel.org>
 <20200929102046.GA14445@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929102046.GA14445@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 12:20:46PM +0200, Christoph Hellwig wrote:
> On Tue, Sep 29, 2020 at 12:13:57PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > The RDMA vector affinity code is not backed up by any driver and always
> > returns NULL to every ib_get_vector_affinity() call.
> >
> > This means that blk_mq_rdma_map_queues() always takes fallback path.
> >
> > Fixes: 9afc97c29b03 ("mlx5: remove support for ib_get_vector_affinity")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>
> So you guys totally broken the nvme queue assignment without even
> telling anyone?  Great job!

Who is "you guys" and it wasn't silent either? I'm sure that Sagi knows the craft.
https://lore.kernel.org/linux-rdma/20181224221606.GA25780@ziepe.ca/

commit 759ace7832802eaefbca821b2b43a44ab896b449
Author: Sagi Grimberg <sagi@grimberg.me>
Date:   Thu Nov 1 13:08:07 2018 -0700

    i40iw: remove support for ib_get_vector_affinity

....

commit 9afc97c29b032af9a4112c2f4a02d5313b4dc71f
Author: Sagi Grimberg <sagi@grimberg.me>
Date:   Thu Nov 1 09:13:12 2018 -0700

    mlx5: remove support for ib_get_vector_affinity

Thanks
