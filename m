Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7D724FAF7
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 12:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHXKDM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 06:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgHXKDL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 06:03:11 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 727AC2071E;
        Mon, 24 Aug 2020 10:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598263390;
        bh=/qLLd39h/EgE3uu+zDV2bL9jlQlsNDtavwQ/G3YM5Ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clVZy12dt/FKS17oucTGEOgehgG6urBzb9Jo8PIeB7ICwZg2eamCJjk9EuvgeKxeu
         F5ezw11TaRIE5Zh1Ffject567/El/gQeYPs1kctna7MD9p42s4wgL+HUzc2ZOXoFFr
         dRDe5G1Ex9OXJYGHT54F/GBFkKxV+dCBenZbuFWA=
Date:   Mon, 24 Aug 2020 13:03:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v3 01/17] rdma_rxe: Added SPDX headers to rxe source files
Message-ID: <20200824100306.GK571722@unreal>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-2-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820224638.3212-2-rpearson@hpe.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 05:46:22PM -0500, Bob Pearson wrote:
> Added SPDX header to all tracked .c and .h files.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c             | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe.h             | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_av.c          | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_comp.c        | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_cq.c          | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_hdr.h         | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_hw_counters.c | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_hw_counters.h | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_icrc.c        | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_loc.h         | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_mcast.c       | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_mmap.c        | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_mr.c          | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_net.c         | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_net.h         | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_opcode.c      | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_opcode.h      | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_param.h       | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_pool.c        | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_pool.h        | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_qp.c          | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_queue.c       | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_queue.h       | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_recv.c        | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_req.c         | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_resp.c        | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_srq.c         | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_sysfs.c       | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_task.c        | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_task.h        | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_verbs.c       | 31 ++-------------------
>  drivers/infiniband/sw/rxe/rxe_verbs.h       | 31 ++-------------------
>  32 files changed, 96 insertions(+), 896 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 907203afbd99..6c2100c71874 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -1,34 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>  /*
> + * linux/drivers/infiniband/sw/rxe/rxe.c

This line is not needed.

Thanks
