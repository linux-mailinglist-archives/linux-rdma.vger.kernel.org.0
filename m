Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3AA2EA9BF
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jan 2021 12:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbhAELWf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jan 2021 06:22:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbhAELWf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Jan 2021 06:22:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD4E1229C5;
        Tue,  5 Jan 2021 11:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609845714;
        bh=J2rQFW5UeCBZWO7kUs+dzLqKTH6ljbBLpV9kH7nBePs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lM9lmzenwBx5/9sOt2fh8fkiOI9c7F0BFRSfhkpOr0F+RcZOlQKz6qa+uo3Dn5yvD
         Po0YW60h5tJh81Rf9DEEMDAYBouQfQFnsd0+WSE1ppAObGPFpSjJuqaFpYPguILbi+
         +dbM2pXxZmdyPse/MhNQ/l8bfKF5NnpbnG4Umtg1XfBfTy6/LAm9lI9V4gOBR0ciAW
         ZkKzhET6EoTOjhlsEFZktZCSMbYJ5HMsAGiILyV2NCHqPgapotD/6BhRCfE5S07E6g
         ya9sB+MwYRwC1MkfbgTCSzDgzZw/9i65Bb25voPf65FyJ/SVv0yAN+J3R6X4+dEybn
         +pWS3Q9dhxK+A==
Date:   Tue, 5 Jan 2021 13:21:50 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Leonid Feschuk <lfesch@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 1/2] RDMA/efa: Move host info set to first
 ucontext allocation
Message-ID: <20210105112150.GR31158@unreal>
References: <20210105104326.67895-1-galpress@amazon.com>
 <20210105104326.67895-2-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105104326.67895-2-galpress@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 05, 2021 at 12:43:25PM +0200, Gal Pressman wrote:
> Downstream patch will require the userspace version which is passed as
> part of ucontext allocation. Move the host info set there and make sure
> it's only called once (on the first allocation).
>
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Leonid Feschuk <lfesch@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa.h       | 7 +++++++
>  drivers/infiniband/hw/efa/efa_main.c  | 4 +---
>  drivers/infiniband/hw/efa/efa_verbs.c | 3 +++
>  3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
> index e5d9712e98c4..9c9cd5867489 100644
> --- a/drivers/infiniband/hw/efa/efa.h
> +++ b/drivers/infiniband/hw/efa/efa.h
> @@ -45,6 +45,11 @@ struct efa_stats {
>  	atomic64_t keep_alive_rcvd;
>  };
>
> +enum {
> +	EFA_FLAGS_HOST_INFO_SET_BIT,
> +	EFA_FLAGS_NUM,
> +};
> +
>  struct efa_dev {
>  	struct ib_device ibdev;
>  	struct efa_com_dev edev;
> @@ -62,6 +67,7 @@ struct efa_dev {
>  	struct efa_irq admin_irq;
>
>  	struct efa_stats stats;
> +	DECLARE_BITMAP(flags, EFA_FLAGS_NUM);
>  };

Why do you need such over-engineering?
What is wrong with old school "u8 flag"?

Thanks
