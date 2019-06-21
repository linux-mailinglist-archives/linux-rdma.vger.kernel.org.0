Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9514DED4
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 03:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfFUBye (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 21:54:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFUBye (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 21:54:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBFEB31628F6;
        Fri, 21 Jun 2019 01:54:33 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19FFE60605;
        Fri, 21 Jun 2019 01:54:32 +0000 (UTC)
Message-ID: <8649cd04f9a73013416d8382274ad344f7a8b300.camel@redhat.com>
Subject: Re: [PATCH] RDMA/odp: Do not leak dma maps when working with huge
 pages
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Date:   Thu, 20 Jun 2019 21:54:30 -0400
In-Reply-To: <20190614004644.20767-1-jgg@ziepe.ca>
References: <20190614004644.20767-1-jgg@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-w7KkQlce4gxHbefmCpAa"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 21 Jun 2019 01:54:33 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-w7KkQlce4gxHbefmCpAa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-13 at 21:46 -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> The ib_dma_unmap_page() must match the length of the
> ib_dma_map_page(),
> which is based on odp_shift. Otherwise iommu resources under this API
> will not be properly freed.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-w7KkQlce4gxHbefmCpAa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0MONYACgkQuCajMw5X
L91GzA/9FZ+0cdS3BGg0GgIgEvScrAFHuTcO47UYlSVreEEVAMPMyAXObE4r3Yzt
RqjH88ZpM04oub/2YJDxo6gT4zji1xlauyIzAfU4D05iARAf0LWnsLSeeRUDpDTI
dFZyOYoqDwc8y1tK2OzuRxWptO63HFtkvS1pl7vr+YxgDQQmSP/AfJagu8aFi/pM
nEpWKaN/3idCOJWB0d3tl5EMeV13eGaeSpGwKQXiha2nxr0aC1yNSheK+11Mkl6Q
QgHQt5IoVBFhvXowtlGXRwE0vjIfXtyRJ/XaMizSyJ0GS5EO1xZ/9LFhn8IIRe+7
VNj3DMH/s5V+Ejgidi6saa1jXuOSZtmJUp48+lU1aTQtNhiQ/QvWLywaKT8H1x4m
VOy68OcnblhzX/9gIzSIosYjmj14J6qIs1KsG5v33eJNESJeAhEQvZyHn6Ydo0vY
Q9bEDFgeMe6ayTRGas7liiXNNohT60EFS/90lLrOmdl2lWL1pb+Iv6xVv5Hl2wIG
U4uRexE6I5UxDtV9yFZnAnuEikStWJeMs3U1gAWkLP8h4HAUBntCmV2q77XKXvtp
IW/HgDlIZHyn35XB6yJjMFzmSiDNXTMf7hMwYxFnc9fAoJTRfePmOgjSj7Dsb9xo
J9b2yoKoWB3PKnb0GUhZ4XNi1GeI9LH/PmTvUYY3ciLSjOy/m6E=
=20nE
-----END PGP SIGNATURE-----

--=-w7KkQlce4gxHbefmCpAa--

