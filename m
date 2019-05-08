Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D90A17D70
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 17:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfEHPlx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 11:41:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEHPlx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 11:41:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB6B4306C9E0;
        Wed,  8 May 2019 15:41:52 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-3.rdu2.redhat.com [10.10.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D68315DA2E;
        Wed,  8 May 2019 15:41:51 +0000 (UTC)
Message-ID: <222d71d2fce5be8461d7fc35c221e832c9c1a162.camel@redhat.com>
Subject: Re: [PATCH v8 02/12] SIW main include file
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Date:   Wed, 08 May 2019 11:41:37 -0400
In-Reply-To: <20190508142229.GD6938@mtr-leonro.mtl.com>
References: <20190508130834.GA32282@ziepe.ca>
         <20190507170943.GI6201@ziepe.ca> <20190505170956.GH6938@mtr-leonro.mtl.com>
         <20190428110721.GI6705@mtr-leonro.mtl.com>
         <20190426131852.30142-1-bmt@zurich.ibm.com>
         <20190426131852.30142-3-bmt@zurich.ibm.com>
         <OF713CDB64.D1B09740-ON002583F1.0050F874-002583F1.005CE977@notes.na.collabserv.com>
         <OF11D27C39.8647DC53-ON002583F3.005609DE-002583F3.0057694C@notes.na.collabserv.com>
         <OFE6341395.7491F9CF-ON002583F4.002BAA7E-002583F4.002CAD7E@notes.na.collabserv.com>
         <OF21EE5DBF.E508AFF5-ON002583F4.004B49A6-002583F4.004D764A@notes.na.collabserv.com>
         <20190508142229.GD6938@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wHIKqbm+nr5p6Y7+dvbw"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 08 May 2019 15:41:53 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-wHIKqbm+nr5p6Y7+dvbw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-05-08 at 17:22 +0300, Leon Romanovsky wrote:
> > It is a recommendation to choose a hard to predict memory
> > key (to make it hard for an attacker to guess it). From
> > RFC 5040, sec 8.1.1:
> >=20
> >    An RNIC MUST choose the value of STags in a way difficult to
> >    predict.  It is RECOMMENDED to sparsely populate them over the
> >    full available range.
>=20
> Nice, security by obscurity, this recommendation is nonsense in real life=
,
> protection should be done by separating PDs and not by hiding stags.

That rather misses the point.  The point isn't whether your PDs are
separate, but whether a malicious third party can easily guess your next
generated ID so it can be used in an attack.  This is security by
obscurity, it's security by non-guessability, and it's been shown to be
necessary multiple times over in network stacks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-wHIKqbm+nr5p6Y7+dvbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzS+LEACgkQuCajMw5X
L92nzw/6AqtcQHKG4UmkQQG9Q4uVdxSuIDUoyRrk3UMptUOOjTDRkLG4QrMqV0D0
EtBc7qIN7TjBePMJfKCLAhpGQSrsVWsQzpSab6GYwwSjX4lwWJ3Crh2kv+85pwfA
jiZ4DchwJJghuNwf1ZSPQOvdAZAoWFZDTbOhhlAyBYw+LiNwxIq09Np0WVOxztiE
6FBwgS2lQYygx8U3QTQxIxcrASiYb0bTPdU4SKrPlPtguCmtCxVrk1iYTCOBdInG
BmAp8B49FcyM82drJVwgE8hZ6Bk2RYCx3xI9GvhP38GUlK1VXuzRR/QIso7BmV2T
hKePqi+mseuph6wQ2L/xXOO3G2pFIwdgCeKfhq6KLI+rRr+qSODKU5LmBLUg6Eto
dDiMC4x39CnhMJ1TE4L0N7todeH/pODhLtmDIk3WG+AKq7Uz/5uOMda4d9WYNPSp
D7ziD3A0jbr/Ab3H8f+94kjKywuoUItkqUsJDemtyuCVgBAUbtJWIbyk36IvDOaU
Gm9p9cQZCPgcu3OK83qEDa1S9X6QJr8HeoXwdTZxyyeXr24REDJ9uCF4GA2JF+9l
kxpxETSnU44X/zsCE61H4KhzO1/oOtZ1ByY5vtZkj3TdD0OVz9hSTehOKBVkbRkp
lHXgN+6YNu/YvhrCfCJ1QXJhw93QwYhyrbfBHuDjOuhNdZAlxMU=
=AHv2
-----END PGP SIGNATURE-----

--=-wHIKqbm+nr5p6Y7+dvbw--

