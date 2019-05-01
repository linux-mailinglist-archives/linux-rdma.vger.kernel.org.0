Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BA310B4E
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 18:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEAQ2z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 12:28:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfEAQ2z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 12:28:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6C9B2D7E6;
        Wed,  1 May 2019 16:28:54 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B53F4B6;
        Wed,  1 May 2019 16:28:52 +0000 (UTC)
Message-ID: <cc59704be472e2576510ca3dcaeafdd6c547eacb.camel@redhat.com>
Subject: Re: [PATCH for-next v6 00/12] RDMA/efa: Elastic Fabric Adapter
 (EFA) driver
From:   Doug Ledford <dledford@redhat.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Date:   Wed, 01 May 2019 12:28:45 -0400
In-Reply-To: <1556707704-11192-1-git-send-email-galpress@amazon.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-i3k1uQ9ZwbLNV35aW7y1"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 01 May 2019 16:28:55 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-i3k1uQ9ZwbLNV35aW7y1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-05-01 at 13:48 +0300, Gal Pressman wrote:
> Hello all,
> The following v6 patchset introduces the Amazon Elastic Fabric Adapter (E=
FA)
> driver.
>=20
> EFA is a networking adapter designed to support user space network
> communication, initially offered in the Amazon EC2 environment. First rel=
ease
> of EFA supports datagram send/receive operations and does not support
> connection-oriented or read/write operations.
>=20
> EFA supports Unreliable Datagrams (UD) as well as a new unordered, Scalab=
le
> Reliable Datagram protocol (SRD). SRD provides support for reliable datag=
rams
> and more complete error handling than typical RD, but, unlike RD, it does=
 not
> support ordering nor segmentation.
>=20
> EFA reliable datagram transport provides reliable out-of-order delivery,
> transparently utilizing multiple network paths to reduce network tail
> latency. Its interface is similar to UD, in particular it supports
> message size up to MTU, with error handling extended to support reliable
> communication. More information regarding SRD can be found at [1].
>=20
> Kernel verbs and in-kernel services are initially not supported but are p=
lanned
> for future releases.
>=20
> EFA enabled EC2 instances have two different devices allocated, one for E=
NA
> (netdev) and one for EFA, the two are separate pci devices with no in-ker=
nel
> communication between them.
>=20
> This patchset also introduces RDMA subsystem ibdev_* print helpers which =
should
> be used by the other new drivers that are currently under review (irdma, =
siw)
> and over time by all drivers in the subsystem.
> The print format is similar to the netdev_* helpers.
>=20
> PR for rdma-core provider was sent:
> https://github.com/linux-rdma/rdma-core/pull/475
>=20
> Thanks to everyone who took the time to review our last submissions (Jaso=
n, Doug,
> Sean, Dennis, Leon, Christoph, Parav, Sagi, Steve, Shiraz), it is very
> appreciated.

This looks to me like all of the requirements we discussed at the OFA
workshop for inclusion (must have UD in addition to SRD, must have a
pull request for the user space portion, must have processed prior
review comments) have been met.  I did a cursory review of this patchset
and have no specific objections that I'm willing to hold things up for.=20
I'll give this a few days for other people to comment, but I'm basically
ready to take it.

I will, however, take patch 1/12 sooner and feed it to for-next so other
drivers can start modifying their prints to use the new helper.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-i3k1uQ9ZwbLNV35aW7y1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzJyT0ACgkQuCajMw5X
L92RGQ/8DeVao7onS1oSuP6eJpM5zGXnvLTexJeKc5T8glENQYoidcqydaK1es8a
E2yZqNW5FCHvHPOsUMnz57YrBn4mLydkEGQO+9VM4/d/cPYAmfDDb03w2Fud+qDu
N58u4OLrwYkAWWjqg/vgT8TcqmouuMmhBnQHLRnmvHLJj1EVOQVsO8/BsjH7lHms
6vKbsJfvifAFeLkANXsrKZrJB6eQEe0k7PhjKccURYM1pBj2Lh/YVpPmRO5z1Kj+
xKJEFDewwH3CFX8lpzfUcdVPH1CbTdK6GZBdIQ8j5rVKbJvrYKbqZNqMrvtJ3H33
Wh9rNvvX84RRE7hDOpdKZaPyzgGAj+K5Dx/8PwoOv2cTlqNgANPBou+ewZyr1t+E
ETV0EbLgfZbl7f7xEzZI90+y6m8zq7TxG56qwgYOpVwWXaU/wjq6U/OCZ4dmTjri
xB14aVIoflDZ9jfzguqcSu24zpTgdODbheHF7cmvZUMbC+YCZoVlcihHvQaHRn0i
hMsU8DQbgq6fO+PR8M8jh4jjN5JiuCT9z4ieLrJZp2P1+9tqiCvVl9EJ9n8wZ90j
7dKC+9UcfAyHHqoPX9cP1eWRCJ6PzvQVH/kz1s149j/hsP9pVjITcBnjkB76D6lB
IRyYTm0Dtf4FvUatQrl/hOY45+zEt4ll5EJ9h41LrzJkLGpThR8=
=eHsK
-----END PGP SIGNATURE-----

--=-i3k1uQ9ZwbLNV35aW7y1--

