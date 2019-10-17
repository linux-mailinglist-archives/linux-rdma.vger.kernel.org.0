Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E364DDB7C4
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2019 21:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389681AbfJQTmx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Oct 2019 15:42:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfJQTmx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Oct 2019 15:42:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 582A0307D97F;
        Thu, 17 Oct 2019 19:42:53 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 401785D70D;
        Thu, 17 Oct 2019 19:42:52 +0000 (UTC)
Message-ID: <463be65989ed267198998a4d3bb64365b372b66d.camel@redhat.com>
Subject: Re: [PATCH rdma-next v1 1/2] RDMA/uapi: Fix and re-organize the
 usage of rdma_driver_id
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Yishai Hadas <yishaih@mellanox.com>
Date:   Thu, 17 Oct 2019 15:42:48 -0400
In-Reply-To: <20191015075419.18185-2-leon@kernel.org>
References: <20191015075419.18185-1-leon@kernel.org>
         <20191015075419.18185-2-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-umIk38S8KuA/RqTN4B92"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 17 Oct 2019 19:42:53 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-umIk38S8KuA/RqTN4B92
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-15 at 10:54 +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
>=20
> Fix 'enum rdma_driver_id' to preserve other driver values before that
> RDMA_DRIVER_CXGB3 was deleted. As this value is UAPI we can't affect
> other values as of a deletion of one driver id.
>=20
> Fixes: 30e0f6cf5acb ("RDMA/iw_cxgb3: Remove the iw_cxgb3 module from
> kernel")
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-umIk38S8KuA/RqTN4B92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2oxDgACgkQuCajMw5X
L919lhAAhQ5uxiGUiRhHEQNwja8kFvsc02IeXboVfIyG3kiarxtXSDy8dgVujJcV
BgK+fVon7IRfvp24xnf3lUhNU3f34EGtFTd3J1z+fgYOFCeFgANd6Vu8T8KmZ+Bu
kvi41M5q6YayFcNTOAcGHtX1Z9PCr/xdHfRsRGgr3EKbIjUa/FHp9+Ux4rIQx9nL
bHFpXehthvSLHV6uVg/NXS4xbOMrNkJsIIqJprZCrcrRbX/PqSj0Id3J7u5wVmZ5
vEcR4W66EAe8X6xso85wapGEcWv3hcuCyJ9yTLWXDr5hoJSYdaYVYetJ4l+f32XK
iY3PQ72ENmYgb1zXuPnpRryyaonz1QElP2X3dXOKHPkMEtgzxvP6py8Sv75TyKkR
5YG1aHoa8/qq/9Gk3DjcWRCKdTaRCh+bHIJBouNJLqrpfMQqXXEtWmoSVVdSEaOx
DkeMtuUCNIdXg3YoUfyGCO3CZlcWjr8ByYRrrV5GP4tZJ5dMpcU2p0DxujcS1Drp
lKHUdZSqp50IWBe8C4A8cjMSHWzgdCTF+oEawS+o2HVv2aS6m/WVxRrTKKYWggrE
MCuu5v6ZoJqBrxDdDitJnysiKaVjuoyXt6zJLMLh5fWnNTb2J9cMNqiikhrGjLD/
LGmFYE37HbzaAvojET1Ot7PXfRXgPzdZUylOXCndyjo2h///ZaA=
=u0p8
-----END PGP SIGNATURE-----

--=-umIk38S8KuA/RqTN4B92--

