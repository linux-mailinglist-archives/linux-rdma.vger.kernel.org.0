Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FF21A0678
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2020 07:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDGFQg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Apr 2020 01:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgDGFQg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Apr 2020 01:16:36 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F26720730;
        Tue,  7 Apr 2020 05:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586236596;
        bh=PP9yPSE8t2IY7iYlwDeMuKlNYVHVBgt72mFtMa0Qhdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MLMD7pM7YjM7CPw+ZJmNWyQYwC9SPctbCS6+0omLTgp0q3YIq+aycLAV3sxS5/0KU
         L0ZTflbCJ6tZH/OfxxiDReeNolLJ8BgokSUDOb9cc5IZpOmWHpXfv7q2t3L7Uj2y6h
         rZb98PURYW14AfI5V0bGU4+DQb4rd+CfHOQXomVs=
Date:   Tue, 7 Apr 2020 08:16:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: Make the event_queue fds return POLLERR
 when disassociated
Message-ID: <20200407051632.GL80989@unreal>
References: <0-v1-ace813388969+48859-uverbs_poll_fix%jgg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-ace813388969+48859-uverbs_poll_fix%jgg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 06, 2020 at 09:44:26PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> If is_closed is set, and the event list is empty, then read() will return
> -EIO without blocking. After setting is_closed in
> ib_uverbs_free_event_queue(), we do trigger a wake_up on the poll_wait,
> but the fops->poll() function does not check it, so poll will continue to
> sleep on an empty list.
>
> Fixes: 14e23bd6d221 ("RDMA/core: Fix locking in ib_uverbs_event_read")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/uverbs_main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 2d4083bf4a0487..8710a3427146e7 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -296,6 +296,8 @@ static __poll_t ib_uverbs_event_poll(struct ib_uverbs_event_queue *ev_queue,
>  	spin_lock_irq(&ev_queue->lock);
>  	if (!list_empty(&ev_queue->event_list))
>  		pollflags = EPOLLIN | EPOLLRDNORM;
> +	else if (ev_queue->is_closed)
> +		pollflags = EPOLLERR;
>  	spin_unlock_irq(&ev_queue->lock);

Don't you need to set EPOLLHUP too? Probably, it won't change anything,
just for the sake of the correctness.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
