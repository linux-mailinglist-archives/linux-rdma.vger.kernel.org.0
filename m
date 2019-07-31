Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7B07C7A3
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 17:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfGaPx1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 11:53:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfGaPx1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 11:53:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A41B63007C58;
        Wed, 31 Jul 2019 15:53:26 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0F845D9C9;
        Wed, 31 Jul 2019 15:53:25 +0000 (UTC)
Message-ID: <0a43aaa2bc1883f57ae1421b03cc3d5d23c2e425.camel@redhat.com>
Subject: Re: [PATCH v6 20/57] infiniband: Remove dev_err() usage after
 platform_get_irq()
From:   Doug Ledford <dledford@redhat.com>
To:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 31 Jul 2019 11:53:23 -0400
In-Reply-To: <20190730181557.90391-21-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
         <20190730181557.90391-21-swboyd@chromium.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3uGQjmrAoGQofD5SJvvd"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 31 Jul 2019 15:53:26 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-3uGQjmrAoGQofD5SJvvd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-07-30 at 11:15 -0700, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now
> that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
>=20
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
>=20
> ret =3D
> (
> platform_get_irq(E, ...)
> platform_get_irq_byname(E, ...)
> );
>=20
> if ( \( ret < 0 \| ret <=3D 0 \) )
> {
> (
> -if (ret !=3D -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
>=20
> While we're here, remove braces on if statements that only have one
> statement (manually).
>=20
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-rdma@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>=20
> Please apply directly to subsystem trees
>=20

Thanks for being clear about where you wanted these applied.  This patch
applied to rdma for-next, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-3uGQjmrAoGQofD5SJvvd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1BuXMACgkQuCajMw5X
L91QTBAAiui1A475ITd01T4j1gUB9/Sd6MwQ0xiBHbRxH8/WUDBBv/aLmriNCEbR
Ty0LZ9tMPoySa6KgwjCwjXAcNPLiFqQSjS3FTaafesBdlvyQ78MKbEdnEtCJoX+0
+JjyTu3XxMD5uJzE4LE6m0T7dIJJJWUdisJhcqFa0hxHFtGQ9sUat1ap0MWJYwIr
1XDaNDH/ovGB0DfcTaa8pI1AZesabdhwYCB5tWj90ZWJmr8E+aUxTu1pTFHbP6Yj
hyDCQpFSrNw7ZOUDFvdghB+HtywDNWpJPV7mZ4kq5cyAdoMdHmPR1zYUFOzUEH+d
Rx0OixPW8LYQ25Hep74mhDAkxJBcEX/B0nqhvRJHLzppWiDAKT+KqznrBuczCysA
MXUMGFvLseEi1+lO5JasVvNemYf4E6iXXcyo+CSJvToEyXruOaunonP7nlqPRrgL
KhNNhpCV71p0rSLemlur46V9sDvHQc5csfGYxi4TEr++nddiWTHH5eIkKbR6MUYJ
JPJCdVyJwqnV4im6TIVnU2is/x7qMex+0ufGAPn+XtRUOxqRSHXTAh5UkHanELA0
UpgUKT+ipnI7S+JMYjWleclqg/ZvWWRvDVNsetP/VWxlWRpfcmUsAqa1DvlSINZG
IB/o7oJ3gGVLJLilhiW4yJVDoh9RlNvgJpv1mHDVbc3jzcUQWSo=
=n9Yh
-----END PGP SIGNATURE-----

--=-3uGQjmrAoGQofD5SJvvd--

