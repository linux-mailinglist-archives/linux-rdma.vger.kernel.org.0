Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3926822C6D2
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 15:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGXNiU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 09:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgGXNiT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jul 2020 09:38:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1473206C1;
        Fri, 24 Jul 2020 13:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595597899;
        bh=l9Y7q0RbNS8KATMxk+D8owDLxYNwvpw247/i9tJX1KY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0hvsBB8ih/8u5gNo5SfDJgvgcXt/Y9FdQ/c6Zq5txhfm7GKCdFX6ESBIBzzon/Tmu
         iQ5kSV1M+yHFL2Rmps6thAsrtySJPL94q9b5pN8CvdM6/vzkeskbv9T3v0WlyKx1Rs
         LKGsOp7GIndxfzyTaIj2DIImTsn9HZN3OPmFL7ow=
Date:   Fri, 24 Jul 2020 16:38:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] RDMA/mlx5: fix typo in structure name
Message-ID: <20200724133815.GA5479@unreal>
References: <20200724084112.GC31930@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20200724084112.GC31930@amd>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2020 at 10:41:12AM +0200, Pavel Machek wrote:
> This is user API, but likely noone uses it...? Fix it before it
> becomes problem.
>
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
>
>
> diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
> index 8e316ef896b5..2d889df38df6 100644
> --- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
> +++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
> @@ -259,7 +259,7 @@ enum mlx5_ib_create_flow_attrs {
>  	MLX5_IB_ATTR_CREATE_FLOW_FLAGS,
>  };
>
> -enum mlx5_ib_destoy_flow_attrs {
> +enum mlx5_ib_destroy_flow_attrs {
>  	MLX5_IB_ATTR_DESTROY_FLOW_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
>  };
>

It looks that this enum is not in use in rdma-core.

Thanks

>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQT1m3YD37UfMCUQBNwp8NhrnBAZsQUCXxrkRAAKCRAp8NhrnBAZ
sQcXAP0RFVMvqmTE3YS59/dnHrlRqT6pdo1NqYxzlvBYRs7RygD/acgoNgGlcskw
sP+4vHdNis5oxHkscbOp7NC/6q5LdgI=
=gon7
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
