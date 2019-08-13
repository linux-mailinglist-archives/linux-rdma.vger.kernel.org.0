Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5E8BE92
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2019 18:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfHMQ33 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Aug 2019 12:29:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfHMQ33 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Aug 2019 12:29:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 705E6315C027;
        Tue, 13 Aug 2019 16:29:29 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FA24379D;
        Tue, 13 Aug 2019 16:29:28 +0000 (UTC)
Message-ID: <39f3d4581c685e55dd099c637e5facb8b1f58a40.camel@redhat.com>
Subject: Re: [PATCH rdma-next v1] RDMA/mlx5: Annotate lock dependency in
 bind/unbind slave port
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Date:   Tue, 13 Aug 2019 12:29:26 -0400
In-Reply-To: <20190813102814.22350-1-leon@kernel.org>
References: <20190813102814.22350-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KBX2CGkE4RbUYagS/siY"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 13 Aug 2019 16:29:29 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-KBX2CGkE4RbUYagS/siY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-08-13 at 13:28 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> NULL-ing notifier_call is performed under protection
> of mlx5_ib_multiport_mutex lock. Such protection is
> not easily spotted and better to be guarded by lockdep
> annotation.
>=20
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-KBX2CGkE4RbUYagS/siY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1S5WYACgkQuCajMw5X
L92uFQ//bIMe6vQZ06XhtA7X0g1l5TP9ZNe9JxzPaGt514iUcxM19Odq4JZCEbLm
Ri5s0sfgR2B0sdMJaI54iMq/krmWXRt6ZdenFTziwpCtx9MQcDbty27CP1eZtLTH
StgS6YhxJN/cGOhtwLLAyfcxBUpYw33UE2qmJQDfcRRmpYAM29dFn0943qc31u+3
zmhEIXWV+ZKrsKDcv+qQXwweU2KjBZQk1hYBrJfc5ZUTwmAbb0rbTBbTlgzqhfGD
5PjlWQIqHMP+BEgqTudvRYiOZg4xUd+IrZQTBjbSkSEDboF8rS9lYbKiLWTHi2yO
vWwpACtbv3/3DZ9md9lSomJLEPFQmDQxGdPwhe+EBWqK8YO/28zK1jUb/2Awn6/G
1H/0vxqKG65yG6+2pUYLYMu3U9MDWjoFW3mIOvWQTp3CK9o8RT1Z0BS+lBRVc8Y2
da2G33z++T7IV02W77yvqiPMt7P9AmupcSPyph8xgCnHG7yYDTp81UBEEPjCNWjj
xvO6vhAWrkNKuJGjxdmes9/gvuhCrwuiggzrZ++PXz86KQfDLeOzPqGPvs5V8Cpc
oEKopvods0fofsybHDk01DsooJDy4KQN+sZg5ejPaMwCHfACKhZ6ETjZOrgBu4O7
ht68xFlWoX8XYVAnB1s+W/TZri7/tTIBuU3Y/fV2TKLF2DrLDVA=
=y9MQ
-----END PGP SIGNATURE-----

--=-KBX2CGkE4RbUYagS/siY--

