Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8745B8A219
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfHLPRE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 11:17:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfHLPRE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 11:17:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09BAD7E424;
        Mon, 12 Aug 2019 15:17:04 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3848D29348;
        Mon, 12 Aug 2019 15:17:03 +0000 (UTC)
Message-ID: <a4e4215dab3715e0181fa6c97b583f3feb3d582d.camel@redhat.com>
Subject: Re: [PATCH v2] Make user mmapped CQ arming flags field 32-bit size
 to remove 64-bit architecture dependency of siw.
From:   Doug Ledford <dledford@redhat.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca
Date:   Mon, 12 Aug 2019 11:17:00 -0400
In-Reply-To: <20190809151816.13018-1-bmt@zurich.ibm.com>
References: <20190809151816.13018-1-bmt@zurich.ibm.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XJOouuCINNof23o6vPAZ"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 12 Aug 2019 15:17:04 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-XJOouuCINNof23o6vPAZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-09 at 17:18 +0200, Bernard Metzler wrote:
> This patch changes the driver/user shared (mmapped) CQ notification
> flags field from unsigned 64-bits size to unsigned 32-bits size. This
> enables building siw on 32-bit architectures.
>=20
> This patch changes the siw-abi. On previously supported 64-bits
> little-endian architectures, the old siw user library remains
> usable, since the used 2 lowest bits of the new 32-bits field reside
> at the same memory location as those of the old 64-bits field.
> On 64-bits big-endian systems, the changes would break compatibility.
> Given the very short time of availability of siw with the current ABI,
> we do not expect current usage of siw on 64-bit big-endian systems.
>=20
> An according patch to change the siw user library fitting the new ABI
> will be provided to rdma-core.

I changed the commit message somewhat.  The siw driver was just taken
into the upstream kernel this merge window, so there is no need to be
apologetic about abi breakage, there are *no* released kernels with a
prior abi.  We are only guaranteeing abi compatibility for the official
siw as taken into the upstream kernel and into rdma-core, and those will
be kept in sync starting with their first official release, which has
not yet happened.  Until this rc cycle is complete, we can fix up
anything that needs fixed up, so if there are any other abi issues you
think you would like to address, well, chop! chop! ;-)

With that said, thanks, applied to for-rc.

> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/Kconfig     |  2 +-
>  drivers/infiniband/sw/siw/siw.h       |  2 +-
>  drivers/infiniband/sw/siw/siw_qp.c    | 14 ++++++++++----
>  drivers/infiniband/sw/siw/siw_verbs.c | 16 +++++++++++-----
>  include/uapi/rdma/siw-abi.h           |  3 ++-
>  5 files changed, 25 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/siw/Kconfig
> b/drivers/infiniband/sw/siw/Kconfig
> index dace276aea14..b622fc62f2cd 100644
> --- a/drivers/infiniband/sw/siw/Kconfig
> +++ b/drivers/infiniband/sw/siw/Kconfig
> @@ -1,6 +1,6 @@
>  config RDMA_SIW
>  	tristate "Software RDMA over TCP/IP (iWARP) driver"
> -	depends on INET && INFINIBAND && LIBCRC32C && 64BIT
> +	depends on INET && INFINIBAND && LIBCRC32C
>  	select DMA_VIRT_OPS
>  	help
>  	This driver implements the iWARP RDMA transport over
> diff --git a/drivers/infiniband/sw/siw/siw.h
> b/drivers/infiniband/sw/siw/siw.h
> index 03fd7b2f595f..77b1aabf6ff3 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -214,7 +214,7 @@ struct siw_wqe {
>  struct siw_cq {
>  	struct ib_cq base_cq;
>  	spinlock_t lock;
> -	u64 *notify;
> +	struct siw_cq_ctrl *notify;
>  	struct siw_cqe *queue;
>  	u32 cq_put;
>  	u32 cq_get;
> diff --git a/drivers/infiniband/sw/siw/siw_qp.c
> b/drivers/infiniband/sw/siw/siw_qp.c
> index e27bd5b35b96..0990307c5d2c 100644
> --- a/drivers/infiniband/sw/siw/siw_qp.c
> +++ b/drivers/infiniband/sw/siw/siw_qp.c
> @@ -1013,18 +1013,24 @@ int siw_activate_tx(struct siw_qp *qp)
>   */
>  static bool siw_cq_notify_now(struct siw_cq *cq, u32 flags)
>  {
> -	u64 cq_notify;
> +	u32 cq_notify;
> =20
>  	if (!cq->base_cq.comp_handler)
>  		return false;
> =20
> -	cq_notify =3D READ_ONCE(*cq->notify);
> +	/* Read application shared notification state */
> +	cq_notify =3D READ_ONCE(cq->notify->flags);
> =20
>  	if ((cq_notify & SIW_NOTIFY_NEXT_COMPLETION) ||
>  	    ((cq_notify & SIW_NOTIFY_SOLICITED) &&
>  	     (flags & SIW_WQE_SOLICITED))) {
> -		/* dis-arm CQ */
> -		smp_store_mb(*cq->notify, SIW_NOTIFY_NOT);
> +		/*
> +		 * CQ notification is one-shot: Since the
> +		 * current CQE causes user notification,
> +		 * the CQ gets dis-aremd and must be re-aremd
> +		 * by the user for a new notification.
> +		 */
> +		WRITE_ONCE(cq->notify->flags, SIW_NOTIFY_NOT);
> =20
>  		return true;
>  	}
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
> b/drivers/infiniband/sw/siw/siw_verbs.c
> index 32dc79d0e898..e7f3a2379d9d 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -1049,7 +1049,7 @@ int siw_create_cq(struct ib_cq *base_cq, const
> struct ib_cq_init_attr *attr,
> =20
>  	spin_lock_init(&cq->lock);
> =20
> -	cq->notify =3D &((struct siw_cq_ctrl *)&cq->queue[size])->notify;
> +	cq->notify =3D (struct siw_cq_ctrl *)&cq->queue[size];
> =20
>  	if (udata) {
>  		struct siw_uresp_create_cq uresp =3D {};
> @@ -1141,11 +1141,17 @@ int siw_req_notify_cq(struct ib_cq *base_cq,
> enum ib_cq_notify_flags flags)
>  	siw_dbg_cq(cq, "flags: 0x%02x\n", flags);
> =20
>  	if ((flags & IB_CQ_SOLICITED_MASK) =3D=3D IB_CQ_SOLICITED)
> -		/* CQ event for next solicited completion */
> -		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
> +		/*
> +		 * Enable CQ event for next solicited completion.
> +		 * and make it visible to all associated producers.
> +		 */
> +		smp_store_mb(cq->notify->flags, SIW_NOTIFY_SOLICITED);
>  	else
> -		/* CQ event for any signalled completion */
> -		smp_store_mb(*cq->notify, SIW_NOTIFY_ALL);
> +		/*
> +		 * Enable CQ event for any signalled completion.
> +		 * and make it visible to all associated producers.
> +		 */
> +		smp_store_mb(cq->notify->flags, SIW_NOTIFY_ALL);
> =20
>  	if (flags & IB_CQ_REPORT_MISSED_EVENTS)
>  		return cq->cq_put - cq->cq_get;
> diff --git a/include/uapi/rdma/siw-abi.h b/include/uapi/rdma/siw-abi.h
> index 7de68f1dc707..af735f55b291 100644
> --- a/include/uapi/rdma/siw-abi.h
> +++ b/include/uapi/rdma/siw-abi.h
> @@ -180,6 +180,7 @@ struct siw_cqe {
>   * to control CQ arming.
>   */
>  struct siw_cq_ctrl {
> -	__aligned_u64 notify;
> +	__u32 flags;
> +	__u32 pad;
>  };
>  #endif

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-XJOouuCINNof23o6vPAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1RguwACgkQuCajMw5X
L90xRQ//bgAmJU6coqylJJNGgmztws2HmUVRxqHQHWkMohUyZq+tQqQzu98rSAQx
m3bdB6UQbrnm9HYMVMw1ywoEOWSueusE+FF0Qkii/d38k2AjnW58qosyK85pxM0J
NWlNj/elei9AnSRi9a91aUq9avy4UUzueBIt891WcfjETgRigJgDYr4lnUbAK7lk
DZH5bXPdinZc7geFm/BN3uTjOW3tjiA3w617idauxTG5VSiGMg/meRyyjAy2jcEi
v2voZC57lCI0LQQFHBJ+mNHxUOMTIYL007wJZWxizI5UG4/nseASlAwU8xKjEFo5
zrmGW+c0o2kmVkqFkwdRg3fmLNJZtagU0jVK0oHUJHahGv1o6mLUM8TRfZ8lYmPv
vNDKsZe0EeXOnrWcxQH5nejB0Hh6zB5uhb3F9ubb0YAoh+rMKHPq5SobHD0S2N4/
J9W9V+dz9A++wocx5kZJKZPAbBGo+z8WRb04zCNzzSZhYjB0R4jBwGkAcg6hUELh
bmjUBCYrfiNjx926dZBFQn4AvjEz9qVNiR3bZSy1dbLCGowcEcxFnhpYeQrke57n
HAdW41vyuhraA2LPrd6MaIdhrGCfhw5vKPrsiCSEzBx9j+PP4igWsgG+rjoKM3Xv
5fzlC/Gj2rI3K6ye8W1pEbPmZB8XcOM9lPvI0SUZb2I0HFiu6/k=
=Ym1a
-----END PGP SIGNATURE-----

--=-XJOouuCINNof23o6vPAZ--

