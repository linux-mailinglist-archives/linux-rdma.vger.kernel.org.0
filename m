Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457EA3AAD7E
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 09:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFQH1J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 03:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhFQH1I (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Jun 2021 03:27:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 105A26135C;
        Thu, 17 Jun 2021 07:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623914701;
        bh=Sbblh3hwD2BaQ81tKBnnpgdkyDBrz2PvnAvQk8AMWOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3g3Bluo1oqyuRFLWlXlY+tODWOWwaJ7jImdeom9lhnH9mt8qCNBbmiBvr80gJF5v
         QYY543gKEU4+23C8LpRKqnpRrV6+zzEtyB41DjZ8LxEuasAjzMpDU4gcXWPtUpLYsq
         rQ3UBVgY6p2EMQcqkoKb3vfbJlMlzSOQg8+5Kj4sWSd8suQTfaT1esUoCh/X8Qcc8k
         QpYtFi+xef8VbqTGGD9/gkz+PSI0RT+jA61Xs44wu8nj2Rd+vNL46iKFDgvfzKDigJ
         yL9QsmDPZvP23TvSTb2FQ+/jom+oaEWteFYHlPFTrZs1Xn7VSBkm+aF75jd1+B/DMW
         l7ocP0qTSa22A==
Date:   Thu, 17 Jun 2021 10:24:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Jack Morgenstein <jackm@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] IB/mlx4: Avoid field-overflowing memcpy()
Message-ID: <YMr4ypsh7D3q1R5+@unreal>
References: <20210616203744.1248551-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616203744.1248551-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 16, 2021 at 01:37:44PM -0700, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring array fields.
> 
> Use the ether_addr_copy() helper instead, as already done for smac.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/infiniband/hw/mlx4/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
> index 2ae22bf50016..4a2ef7daaded 100644
> --- a/drivers/infiniband/hw/mlx4/qp.c
> +++ b/drivers/infiniband/hw/mlx4/qp.c
> @@ -3144,7 +3144,7 @@ static int build_mlx_header(struct mlx4_ib_qp *qp, const struct ib_ud_wr *wr,
>  		mlx->sched_prio = cpu_to_be16(pcp);
>  
>  		ether_addr_copy(sqp->ud_header.eth.smac_h, ah->av.eth.s_mac);
> -		memcpy(sqp->ud_header.eth.dmac_h, ah->av.eth.mac, 6);
> +		ether_addr_copy(sqp->ud_header.eth.dmac_h, ah->av.eth.mac);
>  		memcpy(&ctrl->srcrb_flags16[0], ah->av.eth.mac, 2);
>  		memcpy(&ctrl->imm, ah->av.eth.mac + 2, 4);

I don't understand the last three lines. We are copying 6 bytes to
ah->av.eth.mac and immediately after that overwriting them.

Jack, 

Do you remember what you wanted to achieve in commit
6ee51a4e866b ("mlx4: Adjust QP1 multiplexing for RoCE/SRIOV")

Thanks

>  
> -- 
> 2.25.1
> 
