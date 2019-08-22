Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEC699F11
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 20:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfHVSlt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 14:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731002AbfHVSlt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 14:41:49 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A822173E;
        Thu, 22 Aug 2019 18:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566499308;
        bh=rLEnkzxz5mKcFfl/3d7DBVAepwV1ekdOI1K02hy4+ZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wecqi2FrI5X3U429u/H2DxXHYXULLsVAZziNEswh40OV5hDm/6HXgOyhVTv6hqx9i
         D72XVk7HMyLPktO1V0AwzQ42mjB873TZBsomwUHeHxqAZY6bA7RSme1yO5YmSGJF8u
         SJkF4Z5LULZ+Zicc1XFKwZqF8EsClHCvEilQ/vo8=
Date:   Thu, 22 Aug 2019 21:41:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, geert@linux-m68k.org,
        dledford@redhat.com
Subject: Re: [PATCH v3] RDMA/siw: Fix 64/32bit pointer inconsistency
Message-ID: <20190822184147.GO29433@mtr-leonro.mtl.com>
References: <20190822173738.26817-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822173738.26817-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 22, 2019 at 07:37:38PM +0200, Bernard Metzler wrote:
> Fixes improper casting between addresses and unsigned types.
> Changes siw_pbl_get_buffer() function to return appropriate
> dma_addr_t, and not u64.
>
> Also fixes debug prints. Now any potentially kernel private
> pointers are printed formatted as '%pK', to allow keeping that
> information secret.
>
> Fixes: d941bfe500be ("RDMA/siw: Change CQ flags from 64->32 bits")
> Fixes: b0fff7317bb4 ("rdma/siw: completion queue methods")
> Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
> Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
> Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
> Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
> Fixes: a531975279f3 ("rdma/siw: main include file")
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
> Reported-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw.h       |  8 +--
>  drivers/infiniband/sw/siw/siw_cm.c    | 74 ++++++++++++---------------
>  drivers/infiniband/sw/siw/siw_cq.c    |  5 +-
>  drivers/infiniband/sw/siw/siw_mem.c   | 14 ++---
>  drivers/infiniband/sw/siw/siw_mem.h   |  2 +-
>  drivers/infiniband/sw/siw/siw_qp.c    |  2 +-
>  drivers/infiniband/sw/siw/siw_qp_rx.c | 26 +++++-----
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 43 ++++++++--------
>  drivers/infiniband/sw/siw/siw_verbs.c | 40 +++++++--------
>  9 files changed, 106 insertions(+), 108 deletions(-)
>
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index 77b1aabf6ff3..dba4535494ab 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -138,9 +138,9 @@ struct siw_umem {
>  };
>
>  struct siw_pble {
> -	u64 addr; /* Address of assigned user buffer */
> -	u64 size; /* Size of this entry */
> -	u64 pbl_off; /* Total offset from start of PBL */
> +	dma_addr_t addr; /* Address of assigned buffer */
> +	unsigned int size; /* Size of this entry */
> +	unsigned long pbl_off; /* Total offset from start of PBL */
>  };
>
>  struct siw_pbl {
> @@ -734,7 +734,7 @@ static inline void siw_crc_skb(struct siw_rx_stream *srx, unsigned int len)
>  		  "MEM[0x%08x] %s: " fmt, mem->stag, __func__, ##__VA_ARGS__)
>
>  #define siw_dbg_cep(cep, fmt, ...)                                             \
> -	ibdev_dbg(&cep->sdev->base_dev, "CEP[0x%p] %s: " fmt,                  \
> +	ibdev_dbg(&cep->sdev->base_dev, "CEP[0x%pK] %s: " fmt,                  \
>  		  cep, __func__, ##__VA_ARGS__)
>
>  void siw_cq_flush(struct siw_cq *cq);
> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
> index 9ce8a1b925d2..ae7ea3ad7224 100644
> --- a/drivers/infiniband/sw/siw/siw_cm.c
> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> @@ -355,8 +355,8 @@ static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
>  		getname_local(cep->sock, &event.local_addr);
>  		getname_peer(cep->sock, &event.remote_addr);
>  	}
> -	siw_dbg_cep(cep, "[QP %u]: id 0x%p, reason=%d, status=%d\n",
> -		    cep->qp ? qp_id(cep->qp) : -1, id, reason, status);
> +	siw_dbg_cep(cep, "[QP %u]: reason=%d, status=%d\n",
> +		    cep->qp ? qp_id(cep->qp) : -1, reason, status);
                                             ^^^^
There is a chance that such construction (attempt to print -1 with %u)
will generate some sort of warning.

Thanks
