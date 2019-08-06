Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94EFE8315F
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 14:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfHFMcz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 08:32:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfHFMcz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Aug 2019 08:32:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A01030613CC;
        Tue,  6 Aug 2019 12:32:54 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-53.rdu2.redhat.com [10.10.112.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FE5B601B7;
        Tue,  6 Aug 2019 12:32:53 +0000 (UTC)
Message-ID: <044973ce7080eb5274befb99aab457897d577c96.camel@redhat.com>
Subject: Re: [PATCH 1/1] Make user mmapped CQ arming flags field 32 bit size
 to remove 64 bit architecture dependency of siw.
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 06 Aug 2019 08:32:50 -0400
In-Reply-To: <20190806121006.GC11627@ziepe.ca>
References: <20190805141708.9004-1-bmt@zurich.ibm.com>
         <20190805141708.9004-2-bmt@zurich.ibm.com>
         <20190806121006.GC11627@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3fHkqJT1PbIu7guEJu3H"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 06 Aug 2019 12:32:54 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-3fHkqJT1PbIu7guEJu3H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-08-06 at 09:10 -0300, Jason Gunthorpe wrote:
> On Mon, Aug 05, 2019 at 04:17:08PM +0200, Bernard Metzler wrote:
> > Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> > ---
>=20
> Don't send patches with empty commit messages. Every patch must have a
> comprehensive commit message from now on.
>=20
> >  drivers/infiniband/sw/siw/Kconfig     |  2 +-
> >  drivers/infiniband/sw/siw/siw.h       |  2 +-
> >  drivers/infiniband/sw/siw/siw_qp.c    | 14 ++++++++++----

He had a decent commit log message, it was just in the cover letter.=20
Bernard, on single patch submissions, skip the cover letter and just
send the patch by itself.  Then the nice explanation you gave in the
cover letter should go in the commit message itself.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-3fHkqJT1PbIu7guEJu3H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1Jc3IACgkQuCajMw5X
L90hIQ/+LBe7URgAxAN6JozqHP/X31oZJlvPGMYTlG4AgDaWjKx8wd67vmMHih/r
Bw1UTpf0yF2tT2Oj7oi5IIIHWbhAzqcc0qVzhZnOyiSvb4vcZsmWpWZoZpRxOlSp
M7+bUB+smQZ5f1zCXXibRj4qlCPqEKQKQEL1KCcuHW4lqwQ5g24F9SopuJemxX/T
PE1RawSzGcTCHnunqUfD13v8SiTFJ1vEa8TDFAtXl+t+DC1dq3argiS7sI6LPOcr
BiCMhffvjHSLxDCg2gZw2EYZgoVgawlF5N9HQOx8PP7hM6rSZu46qVxGCWL3iGcN
VtqgS9VmMWV1FnPfg70hgibzdgEPGXOejZBsg9fjRTk9Xk7tFTPxqDiY8/9ywiR1
8zfE6XrcnjXgAYyYL0e0mSuarqdG6bWaX0qjxD5/qY6fjh3VkkVr0i2MG8OPaJvK
YemIlJzISuhKkAVkjrmTnC4Iwdz+OlKgufUDPC6C7cnQzSuIwYkyoQ/jFPX76eNA
kA2tnXGzmfIQIlvH27JLQbiXLHE6JeDTnIu/EfyPzk9+A5ik3hQqVJLdRWZXEeC1
RRArKfEHb4+hsVJpH00Hod2QCEd9/TsKLxeudMD9yfUcseICKIn8mkCDODQF3dAG
/SYXd6FGeEJTR6BRdAWN+nyfCjOGu3vEhuDABE4VbOB+umBDw2A=
=GoaH
-----END PGP SIGNATURE-----

--=-3fHkqJT1PbIu7guEJu3H--

