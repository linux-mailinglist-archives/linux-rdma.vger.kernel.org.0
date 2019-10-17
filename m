Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0524BDB857
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2019 22:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394628AbfJQUeq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Oct 2019 16:34:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13041 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392669AbfJQUeq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Oct 2019 16:34:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E21E59465;
        Thu, 17 Oct 2019 20:34:46 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1FE760A97;
        Thu, 17 Oct 2019 20:34:44 +0000 (UTC)
Message-ID: <fa266ca5e309a69f6d0762d88a8d1c13f93847b0.camel@redhat.com>
Subject: Re: [PATCH for-rc 2/2] IB/hfi1: Use a common pad buffer for 9B and
 16B packets
From:   Doug Ledford <dledford@redhat.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Thu, 17 Oct 2019 16:34:42 -0400
In-Reply-To: <20191004204934.26838.13099.stgit@awfm-01.aw.intel.com>
References: <20191004203739.26542.57060.stgit@awfm-01.aw.intel.com>
         <20191004204934.26838.13099.stgit@awfm-01.aw.intel.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MsyWYZmzYNdbXYv92b0p"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 17 Oct 2019 20:34:46 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-MsyWYZmzYNdbXYv92b0p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-10-04 at 16:49 -0400, Dennis Dalessandro wrote:
> From: Mike Marciniszyn <mike.marciniszyn@intel.com>
>=20
> There is no reason for a different pad buffer for the two
> packet types.
>=20
> Expand the current buffer allocation to allow for both
> packet types.
>=20
> Fixes: f8195f3b14a0 ("IB/hfi1: Eliminate allocation while atomic")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Kaike Wan <kaike.wan@intel.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-MsyWYZmzYNdbXYv92b0p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2o0GIACgkQuCajMw5X
L92ZYg//fIwl33/UyRfej7nKR9kYog18C0kbyfyzdDvIaBWCp93pUQEIi9J9TsiF
5LtCncwccAixCnKjzf/dfnF7XVwiKAErlDKhXnZI4jlrzviZ7s2DfE/CZ0OFq41Z
t488zZZR21N9CbCoR2/w3wzALe6miglneKxv2o/WTgH1UWZfvd61zy4ory9yw7nh
zCQyzifK4yKpIK78l/gwdKLADXrdbFWmlXlMkm72QM2PzBfEPsJL5DiXkCXuMHx9
BbjKj6y3U4z4b33iAx/54nYEc4YXCfK011Ohkx10vKIXJIKpyNRfpRtw40DaWolI
qnyVhgIyKHGopleyPmHQwEfzqotLZQfEeOS80nxG+nRatroAMQqb/0lWhvaJiRyw
ckVOjTo/m+tsH16Vr4m3NEPTzCETE0lrb3aErO8zhRXXSlcDjxJSBucn2Xx6pRqy
y4PKJvVvizcNDfl3pOI+79ZLudsOuYPJEGvsdAY0IyU2q/0VFjqtrWaSU2DdDP9b
8o05pA4qliCEJq2PWgWRYIsFuyXyPS2PeeQ0rPEkRTU9Qcg8+2Jks/XEullLxmyk
XmVSyieobJbe4UXd6GEGfRF14ejPsaZT88vO80/usuAL9cZyOucgezkQCJw6cXeO
BbExU0AsYhEqmUjWtzSpssQBDOZtpv65Zbalp4rHNGNHYe218sw=
=msZ4
-----END PGP SIGNATURE-----

--=-MsyWYZmzYNdbXYv92b0p--

