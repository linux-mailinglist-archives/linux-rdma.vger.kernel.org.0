Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FDE377613
	for <lists+linux-rdma@lfdr.de>; Sun,  9 May 2021 11:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhEIJl1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 May 2021 05:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhEIJl1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 May 2021 05:41:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D64F61421;
        Sun,  9 May 2021 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620553224;
        bh=LHjhKg+Bl2xpAY5vzNiT9BE9j0VusASjGP1iaIU9g9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABluCzLOJEL397Rll7rd9mpgQq8bTxmeenZJiQ7+gDnUyF+1CbxXpGYuiBKBHGmPm
         U//v3coR8RaHiCpIckZOqluceqp6hb6hQa6uxymNj9Q58AQ76UROvI2xuqBUekTdLl
         /SDyTJzQbbSABBkMmVisZZeGue2H35E7ArMEEEhhTOVrJm5dIDjleEVoye2THTUvVV
         PgvJhHauBQpk6Ytmpk2JPIcl/kQS318pjw9MKtZhQFusoQykI2V94rxLfOcqEq/Jdy
         7FcSfRrpJ7U5M3c0/eydnNJFb+G9PbkMXS3IoPG/4K+yQrPnizI8adv/FbOlswmAzU
         HNRU/z+fkJzdw==
Date:   Sun, 9 May 2021 12:40:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     yishaih@nvidia.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: Remove unnessesary check in
 mlx4_ib_modify_wq()
Message-ID: <YJeuBYslGHMB84la@unreal>
References: <1620382961-69701-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620382961-69701-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 07, 2021 at 06:22:41PM +0800, Jiapeng Chong wrote:
> cur_state and new_state are enums and when GCC considers
> them as unsigned, the conditions are never met.
> 
> Clean up the following smatch warning:
> 
> drivers/infiniband/hw/mlx4/qp.c:4258 mlx4_ib_modify_wq() warn: unsigned
> 'cur_state' is never less than zero.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/mlx4/qp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
> index 92ddbcc..162aa59 100644
> --- a/drivers/infiniband/hw/mlx4/qp.c
> +++ b/drivers/infiniband/hw/mlx4/qp.c
> @@ -4255,8 +4255,7 @@ int mlx4_ib_modify_wq(struct ib_wq *ibwq, struct ib_wq_attr *wq_attr,
>  						     ibwq->state;
>  	new_state = wq_attr_mask & IB_WQ_STATE ? wq_attr->wq_state : cur_state;
>  
> -	if (cur_state  < IB_WQS_RESET || cur_state  > IB_WQS_ERR ||
> -	    new_state < IB_WQS_RESET || new_state > IB_WQS_ERR)
> +	if (cur_state > IB_WQS_ERR || new_state > IB_WQS_ERR)
>  		return -EINVAL;

Actually the more robust change will be to move this change to the ib_uverbs_ex_modify_wq().

Thanks

>  
>  	if ((new_state == IB_WQS_RDY) && (cur_state == IB_WQS_ERR))
> -- 
> 1.8.3.1
> 
