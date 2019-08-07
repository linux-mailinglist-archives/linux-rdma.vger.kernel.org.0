Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C51853CF
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 21:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbfHGTlm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 15:41:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388369AbfHGTll (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 15:41:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25DBB3C91A;
        Wed,  7 Aug 2019 19:41:41 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-53.rdu2.redhat.com [10.10.112.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03633608A5;
        Wed,  7 Aug 2019 19:41:39 +0000 (UTC)
Message-ID: <10554323fcc1cb2f710b720688a3542af10767f2.camel@redhat.com>
Subject: Re: [PATCH V3 for-next 02/13] RDMA/hns: Optimize hns_roce_modify_qp
 function
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Wed, 07 Aug 2019 15:41:37 -0400
In-Reply-To: <1564821919-100676-3-git-send-email-oulijun@huawei.com>
References: <1564821919-100676-1-git-send-email-oulijun@huawei.com>
         <1564821919-100676-3-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-p9j3bx6MLkTDDTdez2Zx"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 07 Aug 2019 19:41:41 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-p9j3bx6MLkTDDTdez2Zx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-08-03 at 16:45 +0800, Lijun Ou wrote:
> +static int hns_roce_check_qp_attr(struct ib_qp *ibqp, struct
> ib_qp_attr *attr,
> +                                 int attr_mask)
> +{
> +       struct hns_roce_dev *hr_dev =3D to_hr_dev(ibqp->device);
> +       struct hns_roce_qp *hr_qp =3D to_hr_qp(ibqp);
> +       int ret =3D 0;
> +       int p;
> =20
>         if ((attr_mask & IB_QP_PORT) &&
>             (attr->port_num =3D=3D 0 || attr->port_num > hr_dev-
> >caps.num_ports)) {
> -               dev_err(dev, "attr port_num invalid.attr-
> >port_num=3D%d\n",
> +               ibdev_err(&hr_dev->ib_dev,
> +                       "attr port_num invalid.attr->port_num=3D%d\n",
>                         attr->port_num);
> -               goto out;
> +               return -EINVAL;
>         }
> =20
>         if (attr_mask & IB_QP_PKEY_INDEX) {
>                 p =3D attr_mask & IB_QP_PORT ? (attr->port_num - 1) :
> hr_qp->port;
>                 if (attr->pkey_index >=3D hr_dev-
> >caps.pkey_table_len[p]) {
> -                       dev_err(dev, "attr pkey_index invalid.attr-
> >pkey_index=3D%d\n",
> +                       ibdev_err(&hr_dev->ib_dev,
> +                               "attr pkey_index invalid.attr-
> >pkey_index=3D%d\n",
>                                 attr->pkey_index);
> -                       goto out;
> +                       return -EINVAL;
>                 }
>         }
> =20
>         if (attr_mask & IB_QP_PATH_MTU) {
> -               p =3D attr_mask & IB_QP_PORT ? (attr->port_num - 1) :
> hr_qp->port;
> -               active_mtu =3D iboe_get_mtu(hr_dev->iboe.netdevs[p]-
> >mtu);
> -
> -               if ((hr_dev->caps.max_mtu =3D=3D IB_MTU_4096 &&
> -                   attr->path_mtu > IB_MTU_4096) ||
> -                   (hr_dev->caps.max_mtu =3D=3D IB_MTU_2048 &&
> -                   attr->path_mtu > IB_MTU_2048) ||
> -                   attr->path_mtu < IB_MTU_256 ||
> -                   attr->path_mtu > active_mtu) {
> -                       dev_err(dev, "attr path_mtu(%d)invalid while
> modify qp",
> -                               attr->path_mtu);
> -                       goto out;
> -               }
> +               ret =3D check_mtu_validate(hr_dev, hr_qp, attr,
> attr_mask);
> +               if (ret)
> +                       return ret;
>         }

If you make this the last test in the function, you can completely
eliminate the use of the ret variable and instead do:

if (attr_mask & IB_QP_PATH_MTU) {
   ...
   return check_mtu_validate(hr_dev, hr_qp, attr, attr_mask);
}

return 0;

> =20
>         if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
>             attr->max_rd_atomic > hr_dev->caps.max_qp_init_rdma) {
> -               dev_err(dev, "attr max_rd_atomic invalid.attr-
> >max_rd_atomic=3D%d\n",
> +               ibdev_err(&hr_dev->ib_dev,
> +                       "attr max_rd_atomic invalid.attr-
> >max_rd_atomic=3D%d\n",
>                         attr->max_rd_atomic);
> -               goto out;
> +               return -EINVAL;
>         }
> =20
>         if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC &&
>             attr->max_dest_rd_atomic > hr_dev->caps.max_qp_dest_rdma)
> {
> -               dev_err(dev, "attr max_dest_rd_atomic invalid.attr-
> >max_dest_rd_atomic=3D%d\n",
> +               ibdev_err(&hr_dev->ib_dev,
> +                       "attr max_dest_rd_atomic invalid.attr-
> >max_dest_rd_atomic=3D%d\n",
>                         attr->max_dest_rd_atomic);
> +               return -EINVAL;
> +       }
> +
> +       return ret;
> +}

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-p9j3bx6MLkTDDTdez2Zx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1LKXEACgkQuCajMw5X
L93KahAAhuj7Z4lLCYQsnmcFsELRi5Htx0Wpg+YxxecM4LMUcI8WJIksFt15LQeN
G6s1M7ml52exmsCBa+d68PZJqFKQsFlzIWA6Zmj10OObb+8Hi8o0THZhJavdLeNV
8AS2MpEuHPpUvcYSeVDxa9/swonmuJOJkwHYYnd27CQ4DuHwfatMH+ZW3X6WmcoN
RoKedwgRlW5bLH97Hjyo/vfoPtw5Wz0FEoJv/JdCHd1Zv7dbn/qe1V1rMyW7mn0h
rQejHZv1YrPrV3NwaXXGq6tutCq0X1Dg61mU2Gfu5iGH4HvVPoWvthuxw9B6qyyu
ronHtKE2W5qfZwf6GWXX+oK/JZIaumkoT92DosRyo3WfyZNpAHoqyYI+yGdD5aZK
XPNTXHXe5mQ/lstNOFxCWMFNLwswNg5Nf1N5sl7nabpHSO1mTtK3juWtpx6MZWf5
QycGOK5ZdEdkq17MzPuyOPODBA2Y7bBAupQUwIGDDzJO2tIqX+L/cwUgHoprkKD0
T3KRzhf2p8dpxdLyxINFHw9XgP++CTEsVSGg3oaQDgwGPKtzZedK/XRGu8raCcom
w0ZeQH2mzHSfcPNvtie2sd45h//h2cLY4x1I34wi9RXVroN+N9T+BYk4c8EEUqPN
UzFAQ6cx+bWVbTsfF5lZRb4ghNNWnmtLO+zshZKL1HprTeUb5jE=
=gb//
-----END PGP SIGNATURE-----

--=-p9j3bx6MLkTDDTdez2Zx--

