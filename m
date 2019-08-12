Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C051E8A24B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 17:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfHLP3T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 11:29:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbfHLP3T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 11:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B29ED3084051;
        Mon, 12 Aug 2019 15:29:18 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0066600C4;
        Mon, 12 Aug 2019 15:29:17 +0000 (UTC)
Message-ID: <f49c56933205d90d82ffd3fa55a951843e22cda1.camel@redhat.com>
Subject: Re: [PATCH for-next 3/9] RDMA/hns: Completely release qp resources
 when hw err
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Mon, 12 Aug 2019 11:29:14 -0400
In-Reply-To: <1565343666-73193-4-git-send-email-oulijun@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
         <1565343666-73193-4-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-X7rF25/ciT8K40eU+Aof"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 12 Aug 2019 15:29:18 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-X7rF25/ciT8K40eU+Aof
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-09 at 17:41 +0800, Lijun Ou wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
>=20
> Even if no response from hardware, make sure that qp related
> resources are completely released.
>=20
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 7a14f0b..0409851 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -4562,16 +4562,14 @@ static int
> hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
>  {
>  	struct hns_roce_cq *send_cq, *recv_cq;
>  	struct ib_device *ibdev =3D &hr_dev->ib_dev;
> -	int ret;
> +	int ret =3D 0;
> =20
>  	if (hr_qp->ibqp.qp_type =3D=3D IB_QPT_RC && hr_qp->state !=3D
> IB_QPS_RESET) {
>  		/* Modify qp to reset before destroying qp */
>  		ret =3D hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
>  					    hr_qp->state, IB_QPS_RESET);
> -		if (ret) {
> +		if (ret)
>  			ibdev_err(ibdev, "modify QP to Reset
> failed.\n");
> -			return ret;
> -		}
>  	}
> =20
>  	send_cq =3D to_hr_cq(hr_qp->ibqp.send_cq);
> @@ -4627,7 +4625,7 @@ static int hns_roce_v2_destroy_qp_common(struct
> hns_roce_dev *hr_dev,
>  		kfree(hr_qp->rq_inl_buf.wqe_list);
>  	}
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata
> *udata)
> @@ -4637,11 +4635,9 @@ static int hns_roce_v2_destroy_qp(struct ib_qp
> *ibqp, struct ib_udata *udata)
>  	int ret;
> =20
>  	ret =3D hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
> -	if (ret) {
> +	if (ret)
>  		ibdev_err(&hr_dev->ib_dev, "Destroy qp 0x%06lx
> failed(%d)\n",
>  			  hr_qp->qpn, ret);
> -		return ret;
> -	}
> =20
>  	if (hr_qp->ibqp.qp_type =3D=3D IB_QPT_GSI)
>  		kfree(hr_to_hr_sqp(hr_qp));

I don't know your hardware, but this patch sounds wrong/dangerous to me.
As long as the resources this card might access are allocated by the
kernel, you can't get random data corruption by the card writing to
memory used elsewhere in the kernel.  So if your card is not responding
to your requests to free the resources, it would seem safer to leak
those resources permanently than to free them and risk the card coming
back to life long enough to corrupt memory reallocated to some other
task.

Only if you can guarantee me that there is no way your commands to the
card will fail and then the card start working again later would I
consider this patch safe.  And if it's possible for the card to hang
like this, should that be triggering a reset of the device?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-X7rF25/ciT8K40eU+Aof
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1RhcoACgkQuCajMw5X
L91yixAAoEumDFstIaqf6YTkfSSLXxL9MW5hH1OVdUnSuY1X/y7Nk+1ENjAzXdjb
Sh6rCRH7J+9KK7wTev1/1/0Bg6zJbJafpg7dV7ghwKmanMBLXWLheq1L5Cl3tckj
TF3V/6MH1sh7ogNWHUjqqwDnpUAcmGAX60j/FIhJIhb9dX9w/N1e5f8QLpyAh28C
ZI1DbDrosqTGVTtaXQYBi70k+68La0bWHpT0UMGgPCSkpVQUSL6ilofHvznsXq2h
EPDtoaVq/5IP4HZs95IXh+pEhqQd+DW2F2d4gJfZ+TdjZtjkF7ijElpmBfq7chYu
isl99vtQwvV0il7bY2LKC+klso/KwluJQjrmfKgK4ds8N0CE479nQfNQjEq+c5sI
1+SPfOZC02ALQnVFdXqt8TDptaX4CoCGlcZnE6UQKJZly47ThTIg0Yy8oL/6m61V
V/mGeMDXL0H+Ex2N+6LkhYIPGNOFIy2dcCOZ/He0/pfSM1jPRv1iVapup6m6Alvp
4NHHdRoqylv8JeqmBARjSE1oTh/qqLGJMNrddFsoBu3jAXd4xyjpwJF+XWW/g6xB
Hjh64MHt1sql/+AgNHwSfQ0BT0IvPDv8VF14gkAQwG7fQG9BehAf+2x8STd9AIlq
Cn99wfW854SjtRq6fbUTtY60/49u3s0Hgd0GRyyCD4eICVH6HKA=
=AJ50
-----END PGP SIGNATURE-----

--=-X7rF25/ciT8K40eU+Aof--

