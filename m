Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E714089E4
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 13:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbhIMLMS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 07:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239218AbhIMLMS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 07:12:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27B3860FE6;
        Mon, 13 Sep 2021 11:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631531462;
        bh=imV1HdFIM3pWMGHcbCzgqQqzQy79AxR5aFL/ExL4tEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/KGibOz3nPy6r4cvtm2PXB7OLjYg8CN2IE40G2XaeZfknjt8cY0STBPghvSjyvsw
         mkWujswNCdI0hyw7SxjXPiiEf1h3UiHOV0BbZIbXUXhZoLOIon53xtVD+E7arjJRc1
         lBb4hMOZ3lrFZQdXWRtFcvH9x6KukBZpdswJB/KNc+e3m1AlA6tVNmaDHjjA3nFhZ+
         F0LOTGzwVrDeyye/dKHOcjmBObXrNmhxOJjWxhvpTR4hsNxlpkW/1OVrMIJp6RaMiU
         14LQarEIZvKsU9vDSf7C1LqM/bP2+PYc63JknQUMTfgDDWVzSxVX3VM+520F9FrHTN
         Jvm1n0fNkEFfQ==
Date:   Mon, 13 Sep 2021 14:10:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 09/12] RDMA/bnxt_re: Use GFP_KERNEL in non
 atomic context
Message-ID: <YT8xwteMlzaUuEkb@unreal>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
 <1631470526-22228-10-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631470526-22228-10-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 12, 2021 at 11:15:23AM -0700, Selvin Xavier wrote:
> Use GFP_KERNEL instead of GFP_ATOMIC while allocating
> control path structures which will be only called from
> non atomic context
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> index 947e8c5..3de8547 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> @@ -848,13 +848,13 @@ struct bnxt_qplib_rcfw_sbuf *bnxt_qplib_rcfw_alloc_sbuf(
>  {
>  	struct bnxt_qplib_rcfw_sbuf *sbuf;
>  
> -	sbuf = kzalloc(sizeof(*sbuf), GFP_ATOMIC);
> +	sbuf = kzalloc(sizeof(*sbuf), GFP_KERNEL);
>  	if (!sbuf)
>  		return NULL;

I think that you can do same change in bnxt_re_netdev_event() too.

>  
>  	sbuf->size = size;
>  	sbuf->sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf->size,
> -				      &sbuf->dma_addr, GFP_ATOMIC);
> +				      &sbuf->dma_addr, GFP_KERNEL);
>  	if (!sbuf->sb)
>  		goto bail;
>  
> -- 
> 2.5.5
> 
