Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2658BA5E
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2019 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfHMNdz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Aug 2019 09:33:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbfHMNdy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Aug 2019 09:33:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 725D8307D90E;
        Tue, 13 Aug 2019 13:33:54 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C1F8194B6;
        Tue, 13 Aug 2019 13:33:53 +0000 (UTC)
Message-ID: <107ef16030f6b7ffe70ba46cb22920ec21c707db.camel@redhat.com>
Subject: Re: [PATCH V4 for-next 14/14] RDMA/hns: Use the new APIs for
 printing log
From:   Doug Ledford <dledford@redhat.com>
To:     oulijun <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Tue, 13 Aug 2019 09:33:50 -0400
In-Reply-To: <e741a9b0-a716-3cb0-4635-1e71a431fb33@huawei.com>
References: <1565276034-97329-1-git-send-email-oulijun@huawei.com>
         <1565276034-97329-15-git-send-email-oulijun@huawei.com>
         <e89dd9d3c6b38f826252c00d1f7becb96cac7bad.camel@redhat.com>
         <0466fce2-1cde-73d5-fc98-25930dd9957b@huawei.com>
         <e741a9b0-a716-3cb0-4635-1e71a431fb33@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-mtDr19CcDodUmfPd+d+1"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 13 Aug 2019 13:33:54 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-mtDr19CcDodUmfPd+d+1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-08-13 at 17:31 +0800, oulijun wrote:
> =E5=9C=A8 2019/8/13 17:13, oulijun =E5=86=99=E9=81=93:
> > =E5=9C=A8 2019/8/12 22:48, Doug Ledford =E5=86=99=E9=81=93:
> > > On Thu, 2019-08-08 at 22:53 +0800, Lijun Ou wrote:
> > > > -               dev_err(&hr_dev->dev, "Destroy qp 0x%06lx
> > > > failed(%d)\n",
> > > > -                       hr_qp->qpn, ret);
> > > > +               ibdev_err(&hr_dev->ib_dev, "Destroy qp 0x%06lx
> > > > failed(%d)\n",
> > > > +                         hr_qp->qpn, ret);
> > > And then fixed it up here too.
> > >=20
> > Thanks. I will be more careless in the next time.
> >=20
> >=20
> >=20
> > .
> >=20
> Sorry, I will be more careful in the next time.

I have to admit, I did get a chuckle out of the previous email, thanks
for that ;-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-mtDr19CcDodUmfPd+d+1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1SvD4ACgkQuCajMw5X
L920yRAAmF47i7kr6DfBvg+mj7wpR6bBq94bEk5v3D04M/EhnXebt33nrStP77MO
BShkgBzeV5PDLlZ37yWxEousTUPsXQZED9VlDDuUmzmJJqVh/V9hii3+Qf7EequU
3g7MiG16B0uOsf5gRuthVISswgSdHhha010gxBsLIpp5oiigIRvO0Z4FeplLFLPp
ym9JFIWnxt2AlcUAlUjrPtCdSOq2b1gBTTcn9/vd2kj7dNLxx0XPkwIh0x5Q+Lsh
oP2nqk/9me+WY2OQBMb4JM+Jf8MWpWN1lSoeXf1TRMNN4wYqAMSN5tJgnx/0YT0E
kInUK4YB8n46sAgnRL1mlVNAP/Y8Nu3zXqwdz2CTwOt0V6nff7Jud8M+2rN8RldM
3SxECIugGM+rck8AaxZHwb1eyHXHUCNiqw6xktv1gj7JjjsOEvtC+J5U9/voygA5
4U/pzvO1PCAc+jygVQZCqkP68uD0Y9kUFiSz9uI73du2KvrmqoI7PgzsThR6L+Zo
nK68xGtn4siKEeqFB2dkY9YzDxIPtca470S0K+DgVzuA2DTXj6fa6QeIMmOLTVTQ
EE5AxbRZ4+9/ZVGncnAS1HaxOmvSY9uoO8grRZXLh7dqHvhZfWC+vHZXS+9zbh7p
cHSvI7F1Xgk7YJtmQ7Qq7eWExycoDztGzjWPhCpUVBTXtCVUNUU=
=Ymud
-----END PGP SIGNATURE-----

--=-mtDr19CcDodUmfPd+d+1--

