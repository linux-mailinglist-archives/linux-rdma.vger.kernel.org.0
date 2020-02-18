Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616FA162B30
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 17:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgBRQ6w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 11:58:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgBRQ6w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Feb 2020 11:58:52 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE22208C4;
        Tue, 18 Feb 2020 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582045131;
        bh=Rkny3PmhsT5aQ5jrN8oXM1aKl8VNJqAcWpOJBypp2Vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zZGqQcileriCYrc/o7hPsQL2fCl7GmjbSmOjO7rTJiKjXck5FToBWkxdRESD1W7R/
         LpkQAq8Ya/K1+E6iUiZVSa+UVlPRuVAsxzTdk06qoIbKsqW+a5N0BTx3Yk3vuEZCuU
         AK0GUlzTJRF+PApNESsj4NXLsE3+v6GGhgR9UanQ=
Date:   Tue, 18 Feb 2020 18:58:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next v2] RDMA/siw: Fix setting active_{speed, width}
 attributes
Message-ID: <20200218165847.GA15239@unreal>
References: <20200218095911.26614-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218095911.26614-1-kamalheib1@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 11:59:11AM +0200, Kamal Heib wrote:
> Make sure to set the active_{speed, width} attributes to avoid reporting
> the same values regardless of the underlying device.
>
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
> V2: Change rc to rv.
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index 73485d0da907..d5390d498c61 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -165,11 +165,12 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
>  		   struct ib_port_attr *attr)
>  {
>  	struct siw_device *sdev = to_siw_dev(base_dev);
> +	int rv;
>
>  	memset(attr, 0, sizeof(*attr));

This line should go too. IB/core clears attr prior to call driver.

Thanks

>
> -	attr->active_speed = 2;
> -	attr->active_width = 2;
> +	rv = ib_get_eth_speed(base_dev, port, &attr->active_speed,
> +			 &attr->active_width);
>  	attr->gid_tbl_len = 1;
>  	attr->max_msg_sz = -1;
>  	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> @@ -192,7 +193,7 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
>  	 * attr->subnet_timeout = 0;
>  	 * attr->init_type_repy = 0;
>  	 */
> -	return 0;
> +	return rv;
>  }
>
>  int siw_get_port_immutable(struct ib_device *base_dev, u8 port,
> --
> 2.21.1
>
