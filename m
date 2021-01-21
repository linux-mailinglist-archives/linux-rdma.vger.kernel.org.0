Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A81E2FEFDF
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 17:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbhAUQMT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 11:12:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731699AbhAUQMO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Jan 2021 11:12:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9E7223A1E;
        Thu, 21 Jan 2021 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611245488;
        bh=jjLGdKR5GLsw6DX3wBDygjk1QWEO1wvll3YXwKcdWeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dojJHgRGEGA/q8skPyr7SHwCCGZx5pucvYfGEmE6d99u/tV8MaoEVrZ72ZqGqq5JL
         FCfVOzodQN2IHAGUIQYto5BGHrCKFRD9m+bSnoHdf6b9iAps+8GAL+HcTtDcqiBX9k
         Q05DuxWdEEOhM7gTJJCaXfZ+p/6u5hRc9Z3KvPZmGsdifOFUN/f9RvJMvNYkF7kWar
         sQObibWRgpQRp2brpOwfmkxPQ7jz6GF6gHHqTydyO5NQAogPE9QLVCqzcKxSoBtvKy
         08XWX5bAg7XNqYi8HjqR9S+0+RURH1bIgMM0AdR660BjxKbF2isTd2Ly5mn1xLW+KG
         vdIN1JQDw9GTA==
Date:   Thu, 21 Jan 2021 18:11:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Lameter <cl@linux.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] Fix sendonly join going away after Reregister event
Message-ID: <20210121161124.GD320304@unreal>
References: <alpine.DEB.2.22.394.2101211318530.120233@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2101211318530.120233@www.lameter.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 21, 2021 at 01:24:43PM +0000, Christoph Lameter wrote:
> From: Christoph Lameter <cl@linux.com>
> Subject: [PATCH] Fix sendonly join going away after Reregister event
>
> When a server receives a REREG event then the SM information in
> the kernel is marked as invalid and a request is sent to the SM to update
> the information.
>
> However, receiving a REREG also occurs in user space applications that
> are now trying to rejoin the multicast groups.
>
> If the SM information is invalid then ib_sa_sendonly_fullmem_support()
> returns false. That is wrong because it just means that we do not know
> yet if the potentially new SM supports sendonly joins. It does not mean
> that the SM does not support Sendonly joins.
>
> This patch simply attempts to waits until the SM information is updated
> and the determination can be made.
>
> The code has not been testet but compiles fine.
> I am not sure if it is good to do an msleep here.
>
> Signed-off-by: Christoph Lameter <cl@linux.com>
>
> Index: linux/drivers/infiniband/core/sa_query.c
> ===================================================================
> --- linux.orig/drivers/infiniband/core/sa_query.c	2020-12-17 14:51:15.301206041 +0000
> +++ linux/drivers/infiniband/core/sa_query.c	2021-01-21 12:52:53.577943481 +0000
> @@ -1963,11 +1963,19 @@ bool ib_sa_sendonly_fullmem_support(stru
>  	if (!sa_dev)
>  		return ret;
>
> +redo:
>  	port  = &sa_dev->port[port_num - sa_dev->start_port];
>
> +	while (!port->classport_info.valid)
> +		msleep(100);
> +
>  	spin_lock_irqsave(&port->classport_lock, flags);
> -	if ((port->classport_info.valid) &&
> -	    (port->classport_info.data.type == RDMA_CLASS_PORT_INFO_IB))
> +	if (!port->classport_info.valid) {
> +		/* Need to wait until the SM data is available */
> +		spin_unlock_irqrestore(&port->classport_lock, flags);
> +		goto redo;

We have all potential to loop forever here, if valid doesn't change.

> +	}
> +	if ((port->classport_info.data.type == RDMA_CLASS_PORT_INFO_IB))
>  		ret = ib_get_cpi_capmask2(&port->classport_info.data.ib)
>  			& IB_SA_CAP_MASK2_SENDONLY_FULL_MEM_SUPPORT;
>  	spin_unlock_irqrestore(&port->classport_lock, flags);
