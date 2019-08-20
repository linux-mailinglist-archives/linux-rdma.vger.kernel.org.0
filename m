Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5468A96788
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfHTR00 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 13:26:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfHTR00 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 13:26:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F30FEC06511B;
        Tue, 20 Aug 2019 17:26:25 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE24427CC9;
        Tue, 20 Aug 2019 17:26:24 +0000 (UTC)
Message-ID: <ba80583ebdd6ee011760cf7f2fa8ae24fca4fbe3.camel@redhat.com>
Subject: Re: [PATCH] infiniband: hfi1: fix a memory leak bug
From:   Doug Ledford <dledford@redhat.com>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 20 Aug 2019 13:26:22 -0400
In-Reply-To: <1566156571-4335-1-git-send-email-wenwen@cs.uga.edu>
References: <1566156571-4335-1-git-send-email-wenwen@cs.uga.edu>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-US3lxzWUFg9EQZXej5pr"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 20 Aug 2019 17:26:26 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-US3lxzWUFg9EQZXej5pr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-08-18 at 14:29 -0500, Wenwen Wang wrote:
> In fault_opcodes_read(), 'data' is not deallocated if
> debugfs_file_get()
> fails, leading to a memory leak. To fix this bug, introduce the
> 'free_data'
> label to free 'data' before returning the error.
>=20
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Applied to for-rc, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-US3lxzWUFg9EQZXej5pr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1cLT4ACgkQuCajMw5X
L93WxRAAvPPKCRDj4NrNcEmeeAbwDIxjSGnnXwWLlscQmTgj3YCPiihDIg+qJrTA
uCyw1Vy4S2iKeM/sSEx21arRo/W5cWy1wZjNKwHUqpO2DBtcc4zqT6Q0l0Fpyavp
g6fuRhb5HGOeRH9Nx5zRvZyrw/ZX2BdHn8zu1f+4GC4FfYUin3JSlVItAFuxMbZe
li2O+RjY7zX34d9GyASnlbTIkJANQnQ5zhsecjXMZ1g/KYQBTqmybRTzoI+rOuWG
78/YV3maR5P+jfL5aCTKyOeFE6/AGFUTsZprK7pfVDW82a0vzL2d11yK6qrRZOYJ
RzdI5sezWTN468j05KYRNn5P6G1tm9z+app7xkaElifcXxG70LCm3fm2OjKRjxTe
zhIN2GYXhmj51sVBcXsQLtGI27Yw2b7n8wNTpTBC4WTbJQaaLZy0FiH01t818Sms
c9sewrTTttWCj2QdV5Zxo+4Ev34SzCNfQUpdueV/P3na2SbEo5D5DYCEXohI4yiq
8mDX2j+b5IPugUOROgVqj5tNrAJRXwrc+7xVBdNtxe/G9xdRAd19x0IhoG8HxwP4
5BlPzLjFL7YDDNAZaPYx1/xWPjy5Y8MhgZe6LQ/Q9md2NB4JvdmxJ6QhQoV5Ptr6
m68afXxZANqWKcXTlJSQFXy0anNE27+i5lyFr0ISAy+6x3H/htE=
=A3kK
-----END PGP SIGNATURE-----

--=-US3lxzWUFg9EQZXej5pr--

