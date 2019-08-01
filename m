Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1427DFE3
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 18:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbfHAQPD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 12:15:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731704AbfHAQPC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 12:15:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58730A23DB;
        Thu,  1 Aug 2019 16:15:02 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 212076012A;
        Thu,  1 Aug 2019 16:15:00 +0000 (UTC)
Message-ID: <46095f6fd184092280401dc530f8a80478b5a1b0.camel@redhat.com>
Subject: Re: [PATCH] IB/hfi1: Fix Spectre v1 vulnerability
From:   Doug Ledford <dledford@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Ira Weiny <ira.weiny@intel.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 01 Aug 2019 12:14:58 -0400
In-Reply-To: <20190731175428.GA16736@embeddedor>
References: <20190731175428.GA16736@embeddedor>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-K/NeFDo836XcRrv7GODw"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 01 Aug 2019 16:15:02 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-K/NeFDo836XcRrv7GODw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 12:54 -0500, Gustavo A. R. Silva wrote:
> sl is controlled by user-space, hence leading to a potential
> exploitation of the Spectre variant 1 vulnerability.
>=20
> Fix this by sanitizing sl before using it to index ibp->sl_to_sc.
>=20
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
>=20
> [1]=20
> https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-K/NeFDo836XcRrv7GODw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1DEAIACgkQuCajMw5X
L93qDxAAheHnKgMq9WrxSODBtUqgFbkqgE1Ifu/SVsLX18TaPe0xJYTK5Prv1/h2
6PC3Fj2/Bkp4Lj9FSNyAKL1uG/AkLF+Yd7mBmpjtNa621Ot/20tNLvcHIz0Z+VvS
hBTBLlZh1cQDJqoZI3qrJonP2+yR7yexWEPSwVc0+pzunUChAAvVQHw8dqFeiRlL
kOIG+wC6nJJsRO3KNqcoRx76ncvoZ8fWr/z4frzD5v+Qua39ZwWdaGO9UknNaUg3
CsjuYhSB6H7ccutSdLmzEvITCcWfE8dQTTMju40swmbYK+p66SbB/gjrkVGITeq3
vWH1R7n/hKjKP1UmOo5EdhTkLRxlVwqT2tyTcZfQJcU/gj1+CMLyRbKOnyhzoCLM
z4aqv38Y0R3qlCjfsW5KgU5QAVEOEEOKfJszujhXGH7SsMHUgQrYgmKXUsxsdYeu
awGYUsMOiKOUHdhPQGMibo3cItwenjbRfscmnmO588lpJQP7sBujNB4nlbMPVudf
44duPmqW5EzTP1QOJ0TsXUeJ2TZl59S6kt3+oskzuIRBoOSahZUhXABs85Bo8Wlt
Dh2eaTwAxYUWfc33bDekXk5KkmPbNTwEMSr3jGBGVJfDHHNgPGDUg8vAMnmgp+l7
ykEdIkN6Vaibrt8oQUAajD7U29Cly5lYclPkGkVlcWKt03PfBjE=
=9rCJ
-----END PGP SIGNATURE-----

--=-K/NeFDo836XcRrv7GODw--

