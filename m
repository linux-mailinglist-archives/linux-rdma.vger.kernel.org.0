Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B296F48D74
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2019 21:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfFQTGN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 15:06:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfFQTGN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jun 2019 15:06:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 991556EBA2;
        Mon, 17 Jun 2019 19:06:12 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D1DF7DF66;
        Mon, 17 Jun 2019 19:06:11 +0000 (UTC)
Message-ID: <b8a3714af85a4a798bd205bd152a2098b4124820.camel@redhat.com>
Subject: Re: [PATCH trivial] IB/hfi1: Spelling s/statisfied/satisfied/
From:   Doug Ledford <dledford@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Jun 2019 15:06:08 -0400
In-Reply-To: <20190617140138.734-1-geert+renesas@glider.be>
References: <20190617140138.734-1-geert+renesas@glider.be>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-uV6aTJ3m0eystd3cMwoh"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 17 Jun 2019 19:06:13 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-uV6aTJ3m0eystd3cMwoh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-06-17 at 16:01 +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/infiniband/hw/hfi1/tid_rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c
> b/drivers/infiniband/hw/hfi1/tid_rdma.c
> index 6fb93032fbefcb7e..24f30ff6b5fbc868 100644
> --- a/drivers/infiniband/hw/hfi1/tid_rdma.c
> +++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
> @@ -477,7 +477,7 @@ static struct rvt_qp *first_qp(struct
> hfi1_ctxtdata *rcd,
>   * Must hold the qp s_lock and the exp_lock.
>   *
>   * Return:
> - * false if either of the conditions below are statisfied:
> + * false if either of the conditions below are satisfied:
>   * 1. The list is empty or
>   * 2. The indicated qp is at the head of the list and the
>   *    HFI1_S_WAIT_TID_SPACE bit is set in qp->s_flags.

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-uV6aTJ3m0eystd3cMwoh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0H5KAACgkQuCajMw5X
L93CIw/+IhiUDg8ipstsI788cxfhZ0Fzg3YRv/bOAkc5Mpyle0jyr2UVJiuUwlC6
X2imbQx3GIDS0Q+widP4HmB2USrYen9B7waoQ8Y0HBiw01xG1479+1thRG2ujiDd
iJTUtRE7JhkLVQ3+GQSbdxXtgdnkqHH0/52w/EX5jtEXwaDZUaEMfb5gkgze/89F
pniweNJU+I1y0sRqoSrK8CrcQ++fGAHQbYHrOqeccujB0PsC2v8kHoA2LsLWJxkm
lX1oyaIK+KbSoue3q6meH9iSmW4KSB4vnCYDeitMqSzr0+vSvGESXKrDvwaV4PDr
6dZsq5vnJGQ1LpzePZ/ky/xCXdBFvh0YgUiSC3O0VD42rVhC3UlCjqJhSotAgaac
PXG6AAB/upnVeiLtAi6FdQab0Gc/og+p1pH7+1Z6S2h9ZKTFBs20PKuTZZBj2cLm
j7Zoa4KF1VOH3sP01ysCB488QMbY1oXW5QslWPTCbDJg6bppHEFSrQTxNUtxMEKD
ttHUPati9V7QQkNBPDbUFr1NjqLhAdLx9WGHgyII1DpV5EBObNfh6OyjqC/MOKG+
69pf+LuhoxyhoFQzYFtPTEtzp4808qfxW76fmDYtun9gypyrZVxl+jpoAPSYSIzj
ZEzaMHBsY2ybwDrPbFI+P/AoNmfbIfveZuwtC3aVWrP0ZDp8VXo=
=QIBC
-----END PGP SIGNATURE-----

--=-uV6aTJ3m0eystd3cMwoh--

