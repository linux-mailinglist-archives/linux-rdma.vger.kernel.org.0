Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24085DCEA5
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 20:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634580AbfJRSr2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 14:47:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634575AbfJRSr0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 14:47:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90866307BAA7;
        Fri, 18 Oct 2019 18:47:26 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E574860BFB;
        Fri, 18 Oct 2019 18:47:24 +0000 (UTC)
Message-ID: <8f73a95b6ce854275b93d4aa665cd59ae1a30d41.camel@redhat.com>
Subject: Re: [PATCH v1,for-rc] RDMA/iwcm: move iw_rem_ref() calls out of
 spinlock
From:   Doug Ledford <dledford@redhat.com>
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>, jgg@ziepe.ca,
        bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com, sagi@grimberg.me, larrystevenwise@gmail.com
Date:   Fri, 18 Oct 2019 14:47:22 -0400
In-Reply-To: <20191007102627.12568-1-krishna2@chelsio.com>
References: <20191007102627.12568-1-krishna2@chelsio.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DQzQFRacbhwI0zQC3dYh"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 18 Oct 2019 18:47:26 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-DQzQFRacbhwI0zQC3dYh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-07 at 15:56 +0530, Krishnamraju Eraparaju wrote:
> kref release routines usually perform memory release operations,
> hence, they should not be called with spinlocks held.
> one such case is: SIW kref release routine siw_free_qp(), which
> can sleep via vfree() while freeing queue memory.
>=20
> Hence, all iw_rem_ref() calls in IWCM are moved out of spinlocks.
>=20
> Fixes: 922a8e9fb2e0 ("RDMA: iWARP Connection Manager.")
> Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-DQzQFRacbhwI0zQC3dYh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2qCLoACgkQuCajMw5X
L90RpxAAgPbSprFO++KeeatF3hZ1ZctTZ+MPIFdfd6ZqyJJK/Gezw66oBdzukht+
gfMtvpXJSwoHcmTTHI90IMqH4RohPFIfycHW30Z26Gxn3NoBgh4usd/+enp7WCJk
rIF0EXzTfLMyvfhqVJU02BfvKSJrs4WDD900ejwC9scroZ3TN5CoR+xh89H9rri9
WljEX0MQMmkNqKYOZYujoNNTyqoAtY/9MxJzmVfbdiwWgzK7vRvAcMXj0Hy5EjG5
5gV35Jca/uGctQ/TVLYCh1C7phBoRneT3eQwOTFuymxWNO5caPFbluipS5Awgjkr
839qaRZlTQO3myknp7SaB+bStN8sXTd88rS0xRtt/mQ6JmN4qf4JRx4evNwwLm1Z
4IoZ4sC/BAMlehjAHXwiS3X8sw7yXWKqxMHC1B5HU5tdT/vX5wReZV5kHd22H9rH
rr8QaadWmCEvR2lwTwk1xmP1eKMlNlDYoMwN9I9xNnOCCrPH4xZTzOfda03gffnX
ElO7lzSsg+XA/411sWjGR6590yEH10saR5gZ1jEnDsVWCexeJ2nsYhKj+3xSDm3a
/UlzMlWjlEaUvNiPAfEdjV7YK7RAFX3Cv53PJ9zpv72OCDF9AHQz3DLkR2WYK/OE
xPBRItThDo607uOJQzDNSKmNWjnZoDxD+2PNbMMiD315pxYt1gE=
=8ghy
-----END PGP SIGNATURE-----

--=-DQzQFRacbhwI0zQC3dYh--

