Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3682B3512
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 14:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgKONgv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 08:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgKONgu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 08:36:50 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B12B92071E;
        Sun, 15 Nov 2020 13:36:49 +0000 (UTC)
Date:   Sun, 15 Nov 2020 15:36:46 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/counter: Combine allocation and bind logic
Message-ID: <20201115133646.GF47002@unreal>
References: <20201115093405.129689-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115093405.129689-1-leon@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 15, 2020 at 11:34:05AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
> RDMA counters are allocated and bounded to QP immediately after that.
> Only after this two step process they are really usable. By combining
> the logic, we are ensuring that once counter is returned to the caller,
> it will have everything set.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/counters.c | 130 +++++++++++++----------------
>  1 file changed, 58 insertions(+), 72 deletions(-)

Sorry, for resending it, you wrote here [1] that you took it, but I
don't see it in the tree.
[1] https://lore.kernel.org/linux-rdma/20201112185951.GA981682@nvidia.com/

Thanks
