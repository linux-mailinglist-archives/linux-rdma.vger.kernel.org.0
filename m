Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278542E765D
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Dec 2020 06:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgL3FcK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Dec 2020 00:32:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgL3FcJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Dec 2020 00:32:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 773F0207BC;
        Wed, 30 Dec 2020 05:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609306289;
        bh=3RmqZdf92WJL3eksCJ9qchUxtAnBebaRBAqMTBWQRS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGnmWmmrEa5C7wkI3FoGBN5PFWHj4kAs609Mmf4cdr34a4DqW090HZ6XYAYGkGFXk
         g6+ppzKQxuE124LP9K+8ptdOh2m+v8Amdhq2bKbktp/R42h4jueMVSdEk3dJeAqJxe
         C0KqSvBiW2mVlPLR/3iemqO3+cTzdk7c+1uouLUP39fM8XzixFf81REsw/2UahTRlS
         WsVtLp2Whl07q8ZZI/ty/7HcjTQ5nKaefqFZWgleaF/LB1hFj3B9UZaxTIQGf4FC6a
         5l87XEraftzHnTCVXYyJJ/2QFH2RLyosjV8AFr+ryvYhKIwJSI8Bxbm3I/on5gOtLN
         LMzTp2S+IgNrg==
Date:   Wed, 30 Dec 2020 07:31:25 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     trix@redhat.com
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, jgg@ziepe.ca, maxg@mellanox.com,
        galpress@amazon.com, michaelgur@nvidia.com, monis@mellanox.com,
        gustavoars@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/ocrdma: fix use after free in
 ocrdma_dealloc_ucontext_pd()
Message-ID: <20201230053125.GB6438@unreal>
References: <20201230024653.1516495-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230024653.1516495-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 29, 2020 at 06:46:53PM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>
> In ocrdma_dealloc_ucontext_pd() uctx->cntxt_pd is assigned to
> the variable pd and then after uctx->cntxt_pd is freed, the
> variable pd is passed to function _ocrdma_dealloc_pd() which
> dereferences pd directly or through its call to
> ocrdma_mbx_dealloc_pd().
>
> Reorder the free using the variable pd.
>
> Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
