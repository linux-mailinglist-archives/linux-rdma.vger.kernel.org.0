Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32179979F
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 17:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbfHVPCs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 11:02:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733051AbfHVPCr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 11:02:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85EBCC056808;
        Thu, 22 Aug 2019 15:02:47 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 99E518097;
        Thu, 22 Aug 2019 15:02:46 +0000 (UTC)
Message-ID: <ccd7df7a3062c7db10480b411ee7bdcdbbb95cea.camel@redhat.com>
Subject: Re: [PATCH] siw: Fix potential NULL pointer in siw_connect().
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Date:   Thu, 22 Aug 2019 11:02:43 -0400
In-Reply-To: <20190822120211.GA8339@ziepe.ca>
References: <20190819140257.19319-1-bmt@zurich.ibm.com>
         <30814d3ca3b06c83b31f9255f140fdf2115e83e5.camel@redhat.com>
         <20190821125645.GE3964@kadam>
         <adc716f5d2105a3cc7978873cd0f14503ae323d8.camel@redhat.com>
         <20190821141225.GB8653@ziepe.ca> <20190822071023.GF3964@kadam>
         <20190822120211.GA8339@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hgNP9wgD4Gzhf+ZSJ3/W"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 22 Aug 2019 15:02:47 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-hgNP9wgD4Gzhf+ZSJ3/W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-22 at 09:02 -0300, Jason Gunthorpe wrote:
> On Thu, Aug 22, 2019 at 10:10:23AM +0300, Dan Carpenter wrote:
>=20
> > > People using 'git log --oneline' should have terminals wider than
> > > 80
> > > :)
> > >=20
> > > The bigger question is if the first character after the subject
> > > tag
> > > should be uppper case or lower case <hum>
> >=20
> > I feel like more and more people are moving to upper case.  There
> > are
> > some people who insist on upper case and no one who insists on lower
> > case so it's easier to just make everything upper case.
>=20
> I've noticed Andrew lower cases everything going through his
> tree. I've always used upper case for no prarticular reason

I prefer uppercase for the subsystem, and lowercase for the component.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-hgNP9wgD4Gzhf+ZSJ3/W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1erpMACgkQuCajMw5X
L93OaxAAv7iIia/uFURUZTuBnSxtTgfsySX16UVb4FtVZySOvPIKvFzJ6joZrk33
14eGNYvKJF8wOUf/Ty8727SNsRYdIKOteuyZ3KdogNdSoSQChuWPDobsqKBorhoq
vtrGCsJm9uPTbWWHDIm1KtfMVko27gVmYmnd50LePzrPB6wvPo6Kvc6TxkReg7Xi
kq+GDxINW3YSsclBrw0apjePurAJgk7xtGBl11PEaXUcYGQIVApd3lJ3kM5jXG4z
KCeuFYYTJEj784MFypC9fClwQfc6A+yD2H0RPCD/gR4VaCDdmMUhksSrpub9p5oM
HxGPzdXwzkyEvhsRdgcJlmK2vQd9yqIzU/d+9p7TQVb5TFfCUX7CN0gjdcwXLAog
E5Vcr9p6D6CCmArJQjzi5tnQyi/7XqfppXoSGRh9qBI+iqdsvcrGaPN7qZW0PbuW
RrNWYgKRTarBy2JGtPupCjp/xQJEpKJ5NAbdvJxxae7BgCJggaCHTGXXfB1bRqsw
6ZnNNGSYMgfablwAyqDbIoDiX/VnQzTRO1T4wLQNheTYtubAXT4OuRsDo795TRgy
DYhzyx0p1o485izBjognr1PYpH/GQa51QH5vHmDlszWy5HxWvRA5EZRZF2w2mURF
7UimwJn/At3fiiQUJmS8e/Fe2G5gLakWgN8XgxRQ0gFAtxdzTM0=
=k2fB
-----END PGP SIGNATURE-----

--=-hgNP9wgD4Gzhf+ZSJ3/W--

