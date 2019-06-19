Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FCD4B065
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 05:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFSDUC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 23:20:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfFSDUC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 23:20:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A79B3087945;
        Wed, 19 Jun 2019 03:20:02 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 646B119C69;
        Wed, 19 Jun 2019 03:20:01 +0000 (UTC)
Message-ID: <af804744ff8bac383888bf9a07c0f260b070533f.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 18 Jun 2019 23:19:58 -0400
In-Reply-To: <a936acff4501cd235735c1784bdbd7d2668fccfa.camel@redhat.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
         <20190614003819.19974-3-jgg@ziepe.ca>
         <20190618121709.GK4690@mtr-leonro.mtl.com> <20190618131019.GE6961@ziepe.ca>
         <97a95f7e5447b0ddf4dee15c536d72bd9fb65780.camel@redhat.com>
         <20190618165338.GO4690@mtr-leonro.mtl.com> <20190618184653.GM6961@ziepe.ca>
         <1ec72297f837bf95fadaf846b7fe39a7b24de23c.camel@redhat.com>
         <a936acff4501cd235735c1784bdbd7d2668fccfa.camel@redhat.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZPvB8OGHU0fesQJ0Bj6Y"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 19 Jun 2019 03:20:02 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-ZPvB8OGHU0fesQJ0Bj6Y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-06-18 at 22:45 -0400, Doug Ledford wrote:
> On Tue, 2019-06-18 at 16:58 -0400, Doug Ledford wrote:
> > On Tue, 2019-06-18 at 15:46 -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 18, 2019 at 07:53:38PM +0300, Leon Romanovsky wrote:
> > > > I have a very strong opinion about it.
> > >=20
> > > Then Doug should add the policies, here are the output values from
> > > the
> > > userspace:
> > >=20
> > >         [RDMA_NLDEV_ATTR_CHARDEV] =3D { .type =3D NLA_U64 },
> > >         [RDMA_NLDEV_ATTR_CHARDEV_ABI] =3D { .type =3D NLA_U64 },
> > >         [RDMA_NLDEV_ATTR_DEV_INDEX] =3D { .type =3D NLA_U32 },
> > >         [RDMA_NLDEV_ATTR_DEV_NODE_TYPE] =3D { .type =3D NLA_U8 },
> > >         [RDMA_NLDEV_ATTR_NODE_GUID] =3D { .type =3D NLA_U64 },
> > >         [RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID] =3D { .type =3D NLA_U32 },
> > >         [RDMA_NLDEV_ATTR_CHARDEV_NAME] =3D { .type =3D NLA_NUL_STRING
> > > },
> > >         [RDMA_NLDEV_ATTR_DEV_NAME] =3D { .type =3D NLA_NUL_STRING },
> > >         [RDMA_NLDEV_ATTR_DEV_PROTOCOL] =3D { .type =3D NLA_NUL_STRING
> > > },
> > >         [RDMA_NLDEV_ATTR_FW_VERSION] =3D { .type =3D NLA_NUL_STRING }=
,
> >=20
> > Most of those were already in the policies.  Only the four that you
> > added to enum rdma_nldev_attr needed added to the policies, and two
> > of
> > them your patch already added.  The only question I had is what the
> > string length should be on ATTR_CHARDEV_NAME?  I throw in the
> > default
> > of
> > .len =3D RDMA_NLDEV_ATTR_ENTRY_STRLEN, but I wasn't sure if that was
> > right
> > for this entry?
>=20
> First of all, let me say that this is a PITA.  I'm thinking we need to
> order all of the attributes in the policy array in alphabetical order
> so
> it's easier to tell what's there and what's missing.
>=20
> Also, I'm starting to not like adding items to the policy array before
> they are actually acceptable as inputs.  Sure, there's the argument
> that
> they won't get missed.  But there's the counter argument that until
> you
> define them as an input in some netlink function that reads them, at
> least for all of the string items, you can't actually set the real
> string length limit.  By adding them to the policy now, you make it a
> guarantee that you'll end up changing the API under userspace later
> when
> they become a legitimate input.  Not sure if that's actually
> wise.  The
> u32 and u64, sure, that's fine.  But the strings, that can cause
> problems later.,
>=20

Maybe the best way to do string items if you add them ahead of time is
to give them an input length of 1.  Theoretically that's just the null
byte.  Then when you add a function to actually read the data, set the
size to something real.

Anyway, pushed to wip/dl-for-next, check it to make sure you're happy
with the final results.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-ZPvB8OGHU0fesQJ0Bj6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0Jqd4ACgkQuCajMw5X
L92DHg/+Nm3wJLI160MLvifWGkzIak9jwmajt8btvN34/XAMgMicjy15bYSGVqB+
gzYelQTkwYyp9zR0R0iV82DoelWczK9trXR3a1+PqgdVzPPAiTDz0MGXvFcQwanm
kf2n/oTpQQgzylKm5i+ytBkij3WtjGQko7WG3L8qL7Uwhsj21mUrgGTUwRvArWJk
9nBtIrf0JPEKJ7fPXOs7nOhS4Wv12BVA83qTvCpyx2/iK3SOqny1muOsLXlMYc+a
YNoQQuIUhIinfjLrC0yNQ28FmNLgs7Ul1EbCfon/SlsN8y0Q5rQBG0Vjpm9f/Lqj
vMgqRWqQexP8+rCMUg+Yz7EE2YRDpOfJ3bV8PrqGuYjyVl8uAyWT11Ei60i6SP/I
I/RseyTkvsWvkjBWNRh+VwBLE1kRxuyuF+pZusX0pvadxskzw42QYcvuo0NSYLzD
iRINr/ft1M2htTk+q3jB+wXvgnG3xY2wd4FT+IpIsybwaQ8AmwegG72A+ocYjihu
8I4iaXHM4CZqorxsopiv5hv/z0x4XvdL/ECPyeHLllg2JoQHzhTGFXw/ODS37FaO
iX4ran5tVNKNNucl7iBliquS0lFO9BUkXaitYEzClqUVx5rLhPZ0jmGvwDuOaJGe
5cKvoDWclIBVMGEk354mQ3C9YTu39wfaNheDlsm0oZ56E0qAsNs=
=Qgpx
-----END PGP SIGNATURE-----

--=-ZPvB8OGHU0fesQJ0Bj6Y--

