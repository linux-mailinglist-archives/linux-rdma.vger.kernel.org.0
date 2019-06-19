Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38064B03A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 04:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfFSCpc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 22:45:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfFSCpb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 22:45:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 015D9308302F;
        Wed, 19 Jun 2019 02:45:26 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31F167DFFE;
        Wed, 19 Jun 2019 02:45:20 +0000 (UTC)
Message-ID: <a936acff4501cd235735c1784bdbd7d2668fccfa.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 18 Jun 2019 22:45:18 -0400
In-Reply-To: <1ec72297f837bf95fadaf846b7fe39a7b24de23c.camel@redhat.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
         <20190614003819.19974-3-jgg@ziepe.ca>
         <20190618121709.GK4690@mtr-leonro.mtl.com> <20190618131019.GE6961@ziepe.ca>
         <97a95f7e5447b0ddf4dee15c536d72bd9fb65780.camel@redhat.com>
         <20190618165338.GO4690@mtr-leonro.mtl.com> <20190618184653.GM6961@ziepe.ca>
         <1ec72297f837bf95fadaf846b7fe39a7b24de23c.camel@redhat.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JrxlsnCek57/J0hyqOe+"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 19 Jun 2019 02:45:31 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-JrxlsnCek57/J0hyqOe+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-06-18 at 16:58 -0400, Doug Ledford wrote:
> On Tue, 2019-06-18 at 15:46 -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 18, 2019 at 07:53:38PM +0300, Leon Romanovsky wrote:
> > > I have a very strong opinion about it.
> >=20
> > Then Doug should add the policies, here are the output values from
> > the
> > userspace:
> >=20
> >         [RDMA_NLDEV_ATTR_CHARDEV] =3D { .type =3D NLA_U64 },
> >         [RDMA_NLDEV_ATTR_CHARDEV_ABI] =3D { .type =3D NLA_U64 },
> >         [RDMA_NLDEV_ATTR_DEV_INDEX] =3D { .type =3D NLA_U32 },
> >         [RDMA_NLDEV_ATTR_DEV_NODE_TYPE] =3D { .type =3D NLA_U8 },
> >         [RDMA_NLDEV_ATTR_NODE_GUID] =3D { .type =3D NLA_U64 },
> >         [RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID] =3D { .type =3D NLA_U32 },
> >         [RDMA_NLDEV_ATTR_CHARDEV_NAME] =3D { .type =3D NLA_NUL_STRING }=
,
> >         [RDMA_NLDEV_ATTR_DEV_NAME] =3D { .type =3D NLA_NUL_STRING },
> >         [RDMA_NLDEV_ATTR_DEV_PROTOCOL] =3D { .type =3D NLA_NUL_STRING }=
,
> >         [RDMA_NLDEV_ATTR_FW_VERSION] =3D { .type =3D NLA_NUL_STRING },
>=20
> Most of those were already in the policies.  Only the four that you
> added to enum rdma_nldev_attr needed added to the policies, and two of
> them your patch already added.  The only question I had is what the
> string length should be on ATTR_CHARDEV_NAME?  I throw in the default
> of
> .len =3D RDMA_NLDEV_ATTR_ENTRY_STRLEN, but I wasn't sure if that was
> right
> for this entry?

First of all, let me say that this is a PITA.  I'm thinking we need to
order all of the attributes in the policy array in alphabetical order so
it's easier to tell what's there and what's missing.

Also, I'm starting to not like adding items to the policy array before
they are actually acceptable as inputs.  Sure, there's the argument that
they won't get missed.  But there's the counter argument that until you
define them as an input in some netlink function that reads them, at
least for all of the string items, you can't actually set the real
string length limit.  By adding them to the policy now, you make it a
guarantee that you'll end up changing the API under userspace later when
they become a legitimate input.  Not sure if that's actually wise.  The
u32 and u64, sure, that's fine.  But the strings, that can cause
problems later.,

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-JrxlsnCek57/J0hyqOe+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0Job4ACgkQuCajMw5X
L9317hAAvbVKKrSf/fG95xX+jaRCdsvLweyZRSYuWxuzJ0lQdH3KFmp1d7saxpa4
lBRQLiq7jk5oPcuOi+7cr5uiyph84trhwh4Yj9SfbNm19/08YR8mfz1lKhh5Iimg
Cqf8dZYc463VJz6HCAPYD7b0EZS0TkGj3wZ80Ba58PKoA+bfukgew1WNkkMlXL1I
ONTjijSWwSqM2kOlQe9Ufq0Fy6UJhEUqBwZB5Rb4SfNhdWRI38QaIK7b2NiKs9D7
zmbhub24s4rmphibQMl7MivB4j2ovQsKuu2hHFEZg+cm3aPhZBPNqQoVI2alEXUW
mgu0t2kYw2dgf/MJaJ2nQrc8gz17+Jb3i8uMfYiKJef+VAazhFke6jXbDxsE4bf2
a3IUA4n4BLzopwcmeCXyNa2BWptP3hf4AMUilxIeljcuxmRt37JLa3Ji0BfffJ71
wfR4oiMvov0IJfRd2QFrKO22OKysbSb3U+DrIwBNlceYM3VUCX7aM6x62t/icrVO
PVKcb4IzQX5EfM2tOALCZq6Oe0H8kIdLNkTFTNeSwqS6LAKZgZRpOVpV/PiQwOVW
GVbWtNHMp6EPG13NEeqLzAQJJmHGNp5sekOpJD8AmcJpxh/0UVC5QtB13YmhZgOk
ujZlf2/9zojIhTPcyc6s4SQBZsLXeUWs6i7pJC3YiThVRL2QwLA=
=KIDo
-----END PGP SIGNATURE-----

--=-JrxlsnCek57/J0hyqOe+--

