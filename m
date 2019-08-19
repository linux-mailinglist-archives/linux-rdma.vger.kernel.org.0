Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495D794BDF
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfHSRjn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 13:39:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfHSRjm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 13:39:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E3243082B67;
        Mon, 19 Aug 2019 17:39:42 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFDD190F42;
        Mon, 19 Aug 2019 17:39:40 +0000 (UTC)
Message-ID: <3d51b645485b861ff7b20108c638de37e29b4c0f.camel@redhat.com>
Subject: Re: [PATCH for-next 3/9] RDMA/hns: Completely release qp resources
 when hw err
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Yangyang Li <liyangyang20@huawei.com>,
        Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Mon, 19 Aug 2019 13:39:38 -0400
In-Reply-To: <20190814184737.GB5893@mtr-leonro.mtl.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
         <1565343666-73193-4-git-send-email-oulijun@huawei.com>
         <f49c56933205d90d82ffd3fa55a951843e22cda1.camel@redhat.com>
         <0d325f78-a929-f088-cc29-e2c7af98fd40@huawei.com>
         <f1609a31d9b0d1cdc3b2db38dda1543126755007.camel@redhat.com>
         <20190814184737.GB5893@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-dvxwM7sh6688gTL9Tr9F"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 19 Aug 2019 17:39:42 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-dvxwM7sh6688gTL9Tr9F
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-14 at 21:47 +0300, Leon Romanovsky wrote:
> On Wed, Aug 14, 2019 at 11:05:04AM -0400, Doug Ledford wrote:
> > On Wed, 2019-08-14 at 14:02 +0800, Yangyang Li wrote:
> > > > I don't know your hardware, but this patch sounds
> > > > wrong/dangerous to
> > > > me.
> > > > As long as the resources this card might access are allocated by
> > > > the
> > > > kernel, you can't get random data corruption by the card writing
> > > > to
> > > > memory used elsewhere in the kernel.  So if your card is not
> > > > responding
> > > > to your requests to free the resources, it would seem safer to
> > > > leak
> > > > those resources permanently than to free them and risk the card
> > > > coming
> > > > back to life long enough to corrupt memory reallocated to some
> > > > other
> > > > task.
> > > >=20
> > > > Only if you can guarantee me that there is no way your commands
> > > > to
> > > > the
> > > > card will fail and then the card start working again later would
> > > > I
> > > > consider this patch safe.  And if it's possible for the card to
> > > > hang
> > > > like this, should that be triggering a reset of the device?
> > > >=20
> > >=20
> > > Thanks for your suggestion, I agree with you, it would seem safer
> > > to
> > > leak
> > > those resources permanently than to free them. I will abandon this
> > > change
> > > and consider cleaning up these leaked resources during
> > > uninstallation
> > > or reset.
> >=20
> > Ok, patch dropped from patchworks, thanks.
>=20
> Sorry for being late, but I don't like the idea of having leaked
> memory.
>=20
> All my allocation patches are actually trying to avoid such situation
> by ensuring that no driver does crazy stuff like this. It means that
> once I'll have time to work on QP allocations, I'll ensure that memory
> is freed, so it is better to free such memory now.

You can't free something if the card might still access it.  A leak is
always preferable to data corruption.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-dvxwM7sh6688gTL9Tr9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1a3toACgkQuCajMw5X
L93sVQ//TIdbEZhB/l/vPS5cr5MN5uXswIl58klaW83E66BSwZQXQh70BvlzieyQ
SK/stnFQ8GelM9EB+hwE8z90ZpFoeYGf5eb9Mr51i46D8Fz3yR5yzKbRsoolPVkU
dYhY7T3HBiEc/nzyV0GrHql24pa5TKDZG71TAsaWr7gwOzAppd+O1JM9vxlPaQO5
RFhu6Xh8/Y9zh9IO1F21lOUUnhhL+1qSnJ8W4+Xrc3Q+zpnWi39zKY1qdpYrjHI/
eIKOY3qG4MjJRi43KKH9rUBiLTg3E04tVFwressIDRT5btH/2TGcc5+50XgQrkNq
EHlVGYKey+1dlRUDG9suoZz66HpOeBuQeedCOkmwpXY9NmuhdoxnfLNa9ScYu/Mc
5y6jZ7h/FuPMiccYzNS5fvCbLtGwb8X7M7F53cLshfsZjMwIRSqfrPBj+AppsIz2
YB7uD9O44MiasIaOSrMqqao2rgcxSEgAHTSw9i8HlaWI6OLCWxrA+uA4siEFussz
dyZsoXEz385EnZfVt63xZTzc40eXoZwEMPjlx9bswgoiFxT+RS2kO4rxEDmcOGuC
6z2rOzG6Qx3umBj9qowFFwkUubfWIP6gv2bFabFBCYRY1RmfMOj/WL5rnu+eXkVp
llPX2IjdrKw6f4pCaFXgQVpOT3DAOWpkJNiZTjhTXfrLxK4MxwA=
=R684
-----END PGP SIGNATURE-----

--=-dvxwM7sh6688gTL9Tr9F--

