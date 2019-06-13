Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B86443D0
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFMQce (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 12:32:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392008AbfFMQcd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 12:32:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5ABF2C04BE32;
        Thu, 13 Jun 2019 16:32:28 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC65B5C5F3;
        Thu, 13 Jun 2019 16:32:26 +0000 (UTC)
Message-ID: <08deb91f7516b4c8911211499a00a58392d65a8b.camel@redhat.com>
Subject: Re: [PATCH v2] RDMA/cma: Make CM response timeout and # CM retries
 configurable
From:   Doug Ledford <dledford@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        =?ISO-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Jun 2019 12:32:24 -0400
In-Reply-To: <2c114313-01fe-6d4d-5134-592d1a7b829b@acm.org>
References: <20190226075722.1692315-1-haakon.bugge@oracle.com>
         <174ccd37a9ffa05d0c7c03fe80ff7170a9270824.camel@redhat.com>
         <2c114313-01fe-6d4d-5134-592d1a7b829b@acm.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-0AQ/OTcN7UdTwkCoV3sM"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 13 Jun 2019 16:32:33 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-0AQ/OTcN7UdTwkCoV3sM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-13 at 08:28 -0700, Bart Van Assche wrote:
> On 6/13/19 7:25 AM, Doug Ledford wrote:
> > So, to revive this patch, what I'd like to see is some attempt to
> > actually quantify a reasonable timeout for the default backlog
> > depth,
> > then the patch should actually change the default to that
> > reasonable
> > timeout, and then put in the ability to adjust the timeout with
> > some
> > sort of doc guidance on how to calculate a reasonable timeout based
> > on
> > configured backlog depth.
>=20
> How about following the approach of the SRP initiator driver? It
> derives=20
> the CM timeout from the subnet manager timeout. The assumption
> behind=20
> this is that in large networks the subnet manager timeout has to be
> set=20
> higher than its default to make communication work. See also=20
> srp_get_subnet_timeout().

Theoretically, the subnet manager needs a longer timeout in a bigger
network because it's handling more data as a single point of lookup for
the entire subnet.  Individual machines, on the other hand, have the
same backlog size (by default) regardless of the size of the network,
and there is no guarantee that if the admin increased the subnet
manager timeout, that they also increased the backlog queue depth size.
So, while I like things that auto-tune like you are suggesting, the
problem is that the one item does not directly correlate with the
other.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-0AQ/OTcN7UdTwkCoV3sM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0CepgACgkQuCajMw5X
L93+Mw/6A61mDk+ikAXS6vmFqzcWR0dtVmtxKeNB1/IKvTOJ4JZJxnaYaVIrCjzE
dn3S3UH0Y3ulfyq90Rl3o9opmes7P0vuL+yvxV8Z75EfSObyrFddWfa3JubQ1j6+
Qn5OygYPCpW6hL1xV8VjT9f4od+BKUglDkkD9SHIWPaZWVEwLzM1b3EDSLxLFX4u
kk71uM2PEgxjc3ZSUOSGJrmWEQsM3G/nTshnDD47DJl9PcYx1CUQq6z4aouVQsD0
IlBm6xnWjlfO5qNlCJDXEtKmZgKvI/r1r8+xdz8IicTtmDNaXxxoJX4kP5KNbo4l
W0a9FogbmLhkpigzG0EqOkFUlJkvS/rPvancckDaNMX8YWh3uYrt1v+BKecgw0Rp
tzGLkDJSoqsmsxZc2as0fUz4CmxA5cPypi+wPQ7LFc2JyfVpdYCGsoiwIwVP7r29
R0dmZNfnVp78QEEcKHmRMVjaRNVzbEYiE2+4Y8MZ7IgB3YBqNgQqByhbha++wFry
BXZlf8isVQdeZlYl1QFczlOENrPrYLcz8tPt4eFxheWy8mmLgBboX5otxI0nn4jQ
jR7qBUtefDDwmDyOw1++jVg1TI9yTxtfD7W4avzg7Z7R7WlsipO3X91VZjWSFDXu
qfE+tzXZx2jCudHaU5e4n0Hp8pE+f+GLERIhPcTAjr6RIuJl78k=
=6Yw4
-----END PGP SIGNATURE-----

--=-0AQ/OTcN7UdTwkCoV3sM--

