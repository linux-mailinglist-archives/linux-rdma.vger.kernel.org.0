Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC343806
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbfFMPCn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:02:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732506AbfFMOZh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 10:25:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BEE8308624B;
        Thu, 13 Jun 2019 14:25:29 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C03B1001B0F;
        Thu, 13 Jun 2019 14:25:25 +0000 (UTC)
Message-ID: <174ccd37a9ffa05d0c7c03fe80ff7170a9270824.camel@redhat.com>
Subject: Re: [PATCH v2] RDMA/cma: Make CM response timeout and # CM retries
 configurable
From:   Doug Ledford <dledford@redhat.com>
To:     =?ISO-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Jun 2019 10:25:23 -0400
In-Reply-To: <20190226075722.1692315-1-haakon.bugge@oracle.com>
References: <20190226075722.1692315-1-haakon.bugge@oracle.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ADbkA2BUesfdQDqwIlIL"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 13 Jun 2019 14:25:37 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-ADbkA2BUesfdQDqwIlIL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-02-26 at 08:57 +0100, H=C3=A5kon Bugge wrote:
> During certain workloads, the default CM response timeout is too
> short, leading to excessive retries. Hence, make it configurable
> through sysctl. While at it, also make number of CM retries
> configurable.
>=20
> The defaults are not changed.
>=20
> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> ---
> v1 -> v2:
>    * Added unregister_net_sysctl_table() in cma_cleanup()
> ---
>  drivers/infiniband/core/cma.c | 52 ++++++++++++++++++++++++++++++---
> --
>  1 file changed, 45 insertions(+), 7 deletions(-)

This has been sitting on patchworks since forever.  Presumably because
Jason and I neither one felt like we really wanted it, but also
couldn't justify flat refusing it.  Well, I've made up my mind, so
unless Jason wants to argue the other side, I'm rejecting this patch.=20
Here's why.  The whole concept of a timeout is to help recovery in a
situation that overloads one end of the connection.  There is a
relationship between the max queue backlog on the one host and the
timeout on the other host.  Generally, in order for a request to get
dropped and us to need to retransmit, the queue must already have a
full backlog.  So, how long does it take a heavily loaded system to
process a full backlog?  That, plus a fuzz for a margin of error,
should be our timeout.  We shouldn't be asking users to configure it.

However, if users change the default backlog queue on their systems,
*then* it would make sense to have the users also change the timeout
here, but I think guidance would be helpful.

So, to revive this patch, what I'd like to see is some attempt to
actually quantify a reasonable timeout for the default backlog depth,
then the patch should actually change the default to that reasonable
timeout, and then put in the ability to adjust the timeout with some
sort of doc guidance on how to calculate a reasonable timeout based on
configured backlog depth.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-ADbkA2BUesfdQDqwIlIL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0CXNMACgkQuCajMw5X
L91KahAAkTk1tWxyrUqGuqR1JxRNYpkvoBGlCeat39+UBPeVsDo4lyHbKG9GxtDp
gvjay636xZcSKUDh4RohTMfsQp+ckUc2nBsuB2ULpTykrpVbIHj4RxsbjXXoTuDr
Dj709f6KgYeeQKHGEMv0VlmTjIGTkFeK4CsIByA4B+G17sEq3vwLiCX2KhvZQ+zU
9Kgs/iJqY0qO53nVEodK18HzubvFCXamq0tBa8Bpm8smX6CvOFy66AamLpO+DTdv
srJhldcGmgQHNm8qTd5emAvgAJr5NEMu2idxmjA5CBui4wyjGmbt3JTrB4L6SErw
og8bPvlNziT0+u/VFnH0Q7kLfqEctrfRAj8/6zZnTwp6Cm9b9B86J2dd4xor95xI
E6IdvpwJrvqV8s8cNB14ueRs0p199xNBIfRgn9+ofr8a0vzlfwMyvp/lxc3pKftg
8VpVe2vjow2RIPkTC5AQOhSa7ZrxcsfccWGFwx//GNFTY4jciKL89IDH/N5PSNu8
A9TlASC4uRAdsCPPJjyKp8UrCv8iSiMtpyTCf1CrMkMoZuToO3IwbsfRFBqcIr2q
NmS1UX09WPYGQ8vwnP4+RLJbZ1fWViPZbqLmqWQe96QQnJNnS6WJI0jMjKwU0ZN3
KPj/N2F5pESsz4eVuPZFWIlChA3iobMyWXF0VDXe8XSOsPkJCng=
=ov9e
-----END PGP SIGNATURE-----

--=-ADbkA2BUesfdQDqwIlIL--

