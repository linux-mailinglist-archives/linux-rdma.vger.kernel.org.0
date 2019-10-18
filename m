Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDC0DD098
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfJRUtr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 16:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbfJRUtr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 16:49:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A92A73071D9C;
        Fri, 18 Oct 2019 20:49:46 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A22A0600C4;
        Fri, 18 Oct 2019 20:49:45 +0000 (UTC)
Message-ID: <93a0c381172f05a0256af82f702faa2d4068a24a.camel@redhat.com>
Subject: Re: [PATCH for-next] iw_cxgb3: remove iw_cxgb3 module from kernel.
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Adit Ranadive <aditr@vmware.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>
Date:   Fri, 18 Oct 2019 16:49:43 -0400
In-Reply-To: <20191018204747.GB6087@ziepe.ca>
References: <20190930074252.20133-1-bharat@chelsio.com>
         <20191004181154.GA20868@ziepe.ca>
         <D4D8B4CD-CDA7-4587-BA10-E41A2DE89978@vmware.com>
         <20191018204747.GB6087@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WqrDnNMpzmVFWUmMflly"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 18 Oct 2019 20:49:46 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-WqrDnNMpzmVFWUmMflly
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-10-18 at 17:47 -0300, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2019 at 06:41:16AM +0000, Adit Ranadive wrote:
> > On 10/4/19, 11:12 AM, "Jason Gunthorpe" <jgg@ziepe.ca> wrote:
> > > On Mon, Sep 30, 2019 at 01:12:52PM +0530, Potnuri Bharat Teja
> > > wrote:
> > > > remove iw_cxgb3 module from kernel as the corresponding HW
> > > > Chelsio T3 has
> > > > reached EOL.
> > > >=20
> > > > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > >=20
> > > Applied to for-next
> > >=20
> > > Please also send a PR to delete cxgb3 from rdma-core
> > >=20
> >=20
> > Is Chelsio going to send a PR for the deletion? It looks like
> > otherwise
> > rdma-core is broken for other providers when running with the for-
> > next branch.
> >=20
> > Also, it looks like the kernel-headers/update script in rdma-core
> > needs to be
> > updated to remove a header if required from the
> > rdma_kernel_provider_abi
> > section. Or is that expected to be manual?
>=20
> Manual is probably fine, this doesn't happen often
>=20
> And the bug introduced in this patch is just a bug that should be
> fixed in the kernel now

I pushed that fix out already.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-WqrDnNMpzmVFWUmMflly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2qJWcACgkQuCajMw5X
L90uEQ//RX/WdOM9IuS1xBzb1+/YpJKL4kLRBTUCeqWiJHSUPmemmcUQ317lp8cK
JpYjt9fIRpOg0vIaQIEsq+Vjzjt5At3gJqFYnrQSDQiQFcmnLrmL/SjQCkbsPJwJ
Dp+HceqvR7ZEGS6H3WtcP3z3A4nbMBHXIXYyWKJphB6udlQvrbgjvV5EyRf50IoC
09tKxKii2oASoiFvj/MgQ5vysKfE6jMMZ1lj8RM0JhH7FHVIG46tJD+5WIsU9p4d
UZXdUsUDUDopwzRh7A0y5SUk65rgDEXhKL0KE3AtnwaGcxd7B4PocUcDbu6qXVWE
dFpIAGnhp86k3ztrUb7o7DsVcS7r6sI0WdBZQEWQF2TEGcpFTQZaf15rshBSIpuL
vfLdtpWw0kn6xpNeDG/ezmXfs5lC7yeHdfj02cCVwnnf2yegDi9ToDvF9I98qZWT
Ds40eO37JRTKN/bem6m6jmwQ6fuMt8OjCg4O087ZWMUWPd2VMs1QFswMu/G/Rmpr
kNedjh7wxcy0rVonGHSsQCmKDXCn8QxOvlhI8KzwvgOH+5BIjx5DT1sqR0BXw+dC
3FG+8pk0IBDMANBXTQroUTRHL4q+xgk78znO1dJbvnWisIULXE80b54l0L6kDJGQ
iq053CdT1TC6nPuNxgizWxn+bbYtulIEtUOanFfGjssRVwFhylc=
=vSs6
-----END PGP SIGNATURE-----

--=-WqrDnNMpzmVFWUmMflly--

