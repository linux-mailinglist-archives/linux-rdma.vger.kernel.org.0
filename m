Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3BB623051
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 11:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbfETJ1r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 05:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731436AbfETJ1r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 05:27:47 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE1D620675;
        Mon, 20 May 2019 09:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558344466;
        bh=zuXK1OQKVBWNuAmS6OGK6m6wC5Y0IRxMxbCKfDHhQMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dwKp/Pjw9/i4dzwWbwY6E4TaJEK3TomEWvRCQFI/VSYuSdUpy3FUXaZaZenN+QKee
         Q+429E1r0oNLrx5tgswbXkNA8Q0N1yC9SK7hqKkyv1uS2CBlxtAMs7VhY5+U30Ih8p
         fhBXZlGARGl1UqdtwRxsPMzx8EeGVDXKtBFaWat4=
Date:   Mon, 20 May 2019 12:27:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     ariel.elior@marvell.com, sagiv.ozeri@marvell.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma] RDMA/qedr: Fix incorrect device rate.
Message-ID: <20190520092743.GC4573@mtr-leonro.mtl.com>
References: <20190520091812.3311-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520091812.3311-1-michal.kalderon@marvell.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 12:18:12PM +0300, Michal Kalderon wrote:
> From: Sagiv Ozeri <sagiv.ozeri@marvell.com>
>
> Use the correct enum value introduced in
> commit 12113a35ada6 ("IB/core: Add HDR speed enum")
> Prior to this change a 50Gbps port would show 40Gbps.
>
> This patch also cleaned up the redundant redefiniton of ib speeds
> for qedr.
>
> Fixes: 12113a35ada6 ("IB/core: Add HDR speed enum")
>

No extra space please.

> Signed-off-by: Sagiv Ozeri <sagiv.ozeri@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index e52d8761d681..f940da2eb61e 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -159,54 +159,47 @@ int qedr_query_device(struct ib_device *ibdev,
>  	return 0;
>  }
>
> -#define QEDR_SPEED_SDR		(1)
> -#define QEDR_SPEED_DDR		(2)
> -#define QEDR_SPEED_QDR		(4)
> -#define QEDR_SPEED_FDR10	(8)
> -#define QEDR_SPEED_FDR		(16)
> -#define QEDR_SPEED_EDR		(32)
> -
>  static inline void get_link_speed_and_width(int speed, u8 *ib_speed,
>  					    u8 *ib_width)
>  {
>  	switch (speed) {
>  	case 1000:
> -		*ib_speed = QEDR_SPEED_SDR;
> +		*ib_speed = IB_SPEED_SDR;
>  		*ib_width = IB_WIDTH_1X;
>  		break;
>  	case 10000:
> -		*ib_speed = QEDR_SPEED_QDR;
> +		*ib_speed = IB_SPEED_QDR;
>  		*ib_width = IB_WIDTH_1X;
>  		break;
>
>  	case 20000:
> -		*ib_speed = QEDR_SPEED_DDR;
> +		*ib_speed = IB_SPEED_DDR;
>  		*ib_width = IB_WIDTH_4X;
>  		break;
>
>  	case 25000:
> -		*ib_speed = QEDR_SPEED_EDR;
> +		*ib_speed = IB_SPEED_EDR;
>  		*ib_width = IB_WIDTH_1X;
>  		break;
>
>  	case 40000:
> -		*ib_speed = QEDR_SPEED_QDR;
> +		*ib_speed = IB_SPEED_QDR;
>  		*ib_width = IB_WIDTH_4X;
>  		break;
>
>  	case 50000:
> -		*ib_speed = QEDR_SPEED_QDR;
> -		*ib_width = IB_WIDTH_4X;
> +		*ib_speed = IB_SPEED_HDR;
> +		*ib_width = IB_WIDTH_1X;
>  		break;
>
>  	case 100000:
> -		*ib_speed = QEDR_SPEED_EDR;
> +		*ib_speed = IB_SPEED_EDR;
>  		*ib_width = IB_WIDTH_4X;
>  		break;
>
>  	default:
>  		/* Unsupported */
> -		*ib_speed = QEDR_SPEED_SDR;
> +		*ib_speed = IB_SPEED_SDR;
>  		*ib_width = IB_WIDTH_1X;
>  	}
>  }
> --
> 2.14.5
>
