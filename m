Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0942922DC
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfHSL42 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfHSL42 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 07:56:28 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE12A2085A;
        Mon, 19 Aug 2019 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566215787;
        bh=NXxRgWsLB6Z8bxfZp+XAAmb3N7hJ6+RLVZk0B7dP0L0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUfGquRNpepHtZHGBhZvfqZGaXBrbdUaBhK/xO7DWYKE6YDB6tGYLKK8MrdF85S9N
         n9b26O7v9+ELwVhdQMeGBjxDsJ8Qj6lBQZQbybmgVW7ut/ef8Lc9ANTlIZ9MNXhUb0
         MFlCR3C973mSa3WcV33j2cf7gvROKZ9cSbFpa2IQ=
Date:   Mon, 19 Aug 2019 14:56:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:MELLANOX MLX4 IB driver" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx4: Fix memory leaks
Message-ID: <20190819115623.GD4459@mtr-leonro.mtl.com>
References: <1566159781-4642-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566159781-4642-1-git-send-email-wenwen@cs.uga.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 18, 2019 at 03:23:01PM -0500, Wenwen Wang wrote:
> In mlx4_ib_alloc_pv_bufs(), 'tun_qp->tx_ring' is allocated through
> kcalloc(). However, it is not always deallocated in the following execution
> if an error occurs, leading to memory leaks. To fix this issue, free
> 'tun_qp->tx_ring' whenever an error occurs.
>
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  drivers/infiniband/hw/mlx4/mad.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>
