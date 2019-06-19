Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15CA04BAF6
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfFSOPk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 10:15:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfFSOPj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jun 2019 10:15:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2ADA73086226;
        Wed, 19 Jun 2019 14:15:39 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51F826014C;
        Wed, 19 Jun 2019 14:15:37 +0000 (UTC)
Message-ID: <62b71d826d25c0aa80aacb2c38cfb5ccfec958c4.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:15:34 -0400
In-Reply-To: <20190619060744.GE11611@mtr-leonro.mtl.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
         <20190614003819.19974-3-jgg@ziepe.ca>
         <20190618121709.GK4690@mtr-leonro.mtl.com> <20190618131019.GE6961@ziepe.ca>
         <97a95f7e5447b0ddf4dee15c536d72bd9fb65780.camel@redhat.com>
         <20190618165338.GO4690@mtr-leonro.mtl.com> <20190618184653.GM6961@ziepe.ca>
         <1ec72297f837bf95fadaf846b7fe39a7b24de23c.camel@redhat.com>
         <a936acff4501cd235735c1784bdbd7d2668fccfa.camel@redhat.com>
         <af804744ff8bac383888bf9a07c0f260b070533f.camel@redhat.com>
         <20190619060744.GE11611@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-kV5YxPxZguCMHHmtTQwY"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 19 Jun 2019 14:15:39 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-kV5YxPxZguCMHHmtTQwY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-19 at 09:07 +0300, Leon Romanovsky wrote:
> On Tue, Jun 18, 2019 at 11:19:58PM -0400, Doug Ledford wrote:
> > On Tue, 2019-06-18 at 22:45 -0400, Doug Ledford wrote:
> > > On Tue, 2019-06-18 at 16:58 -0400, Doug Ledford wrote:
> > > > On Tue, 2019-06-18 at 15:46 -0300, Jason Gunthorpe wrote:
> > > > > On Tue, Jun 18, 2019 at 07:53:38PM +0300, Leon Romanovsky
> > > > > wrote:
> > > > > > I have a very strong opinion about it.
> > > > >=20
> > > > > Then Doug should add the policies, here are the output values
> > > > > from
> > > > > the
> > > > > userspace:
> > > > >=20
> > > > >         [RDMA_NLDEV_ATTR_CHARDEV] =3D { .type =3D NLA_U64 },
> > > > >         [RDMA_NLDEV_ATTR_CHARDEV_ABI] =3D { .type =3D NLA_U64 },
> > > > >         [RDMA_NLDEV_ATTR_DEV_INDEX] =3D { .type =3D NLA_U32 },
> > > > >         [RDMA_NLDEV_ATTR_DEV_NODE_TYPE] =3D { .type =3D NLA_U8 },
> > > > >         [RDMA_NLDEV_ATTR_NODE_GUID] =3D { .type =3D NLA_U64 },
> > > > >         [RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID] =3D { .type =3D NLA_U3=
2
> > > > > },
> > > > >         [RDMA_NLDEV_ATTR_CHARDEV_NAME] =3D { .type =3D
> > > > > NLA_NUL_STRING
> > > > > },
> > > > >         [RDMA_NLDEV_ATTR_DEV_NAME] =3D { .type =3D NLA_NUL_STRING
> > > > > },
> > > > >         [RDMA_NLDEV_ATTR_DEV_PROTOCOL] =3D { .type =3D
> > > > > NLA_NUL_STRING
> > > > > },
> > > > >         [RDMA_NLDEV_ATTR_FW_VERSION] =3D { .type =3D
> > > > > NLA_NUL_STRING },
> > > >=20
> > > > Most of those were already in the policies.  Only the four that
> > > > you
> > > > added to enum rdma_nldev_attr needed added to the policies, and
> > > > two
> > > > of
> > > > them your patch already added.  The only question I had is what
> > > > the
> > > > string length should be on ATTR_CHARDEV_NAME?  I throw in the
> > > > default
> > > > of
> > > > .len =3D RDMA_NLDEV_ATTR_ENTRY_STRLEN, but I wasn't sure if that
> > > > was
> > > > right
> > > > for this entry?
> > >=20
> > > First of all, let me say that this is a PITA.  I'm thinking we
> > > need to
> > > order all of the attributes in the policy array in alphabetical
> > > order
> > > so
> > > it's easier to tell what's there and what's missing.
> > >=20
> > > Also, I'm starting to not like adding items to the policy array
> > > before
> > > they are actually acceptable as inputs.  Sure, there's the
> > > argument
> > > that
> > > they won't get missed.  But there's the counter argument that
> > > until
> > > you
> > > define them as an input in some netlink function that reads them,
> > > at
> > > least for all of the string items, you can't actually set the real
> > > string length limit.  By adding them to the policy now, you make
> > > it a
> > > guarantee that you'll end up changing the API under userspace
> > > later
> > > when
> > > they become a legitimate input.  Not sure if that's actually
> > > wise.  The
> > > u32 and u64, sure, that's fine.  But the strings, that can cause
> > > problems later.,
> > >=20
> >=20
> > Maybe the best way to do string items if you add them ahead of time
> > is
> > to give them an input length of 1.  Theoretically that's just the
> > null
> > byte.  Then when you add a function to actually read the data, set
> > the
> > size to something real.
>=20
> Like you said, it won't be needed till new input code is used, so from
> API perspective, it doesn't matter what size will be. I liked your
> idea
> to put it to be "1". It goes hand by hand to avoid possible addition
> of input handlers without update of update nla_policy.

Ok, I cleaned up the policy array by sorting it so you can find things
when you need to add new stuff.  New policy additions should preserve
the sorting.  Then I audited all of the string inputs, fixed their
definitions in the policy, and removed the (now) unnecessary checks for
string input overflow.  Their already in my wip branch, but I'll send
them to the list too.

> > Anyway, pushed to wip/dl-for-next, check it to make sure you're
> > happy
> > with the final results.
>=20
> It looks good, thanks.
>=20
> > --
> > Doug Ledford <dledford@redhat.com>
> >     GPG KeyID: B826A3330E572FDD
> >     Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
>=20
>=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-kV5YxPxZguCMHHmtTQwY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0KQ4YACgkQuCajMw5X
L925dQ//Y/DBk6hHwA7GMeE6E6CFRCppPCGRHALXlUrIv6k76mxePFfNY5DdHafo
LRp5khOTRnSvQ/lax630Jb5779NQBLjCKVrIkXNbXwllu1Yra1Yi4C3eIZqP+/R/
P+2b7WwVXAw96hb6dUeAoNHguJv3X2sa0u4fV3GllmAUFa93exJsN8sM44Qjp4mf
JYyQ7Q5WI51jD7dyDZcqkpJNEUvOWDfCq02Yrqps6DddcrOT5vps3riRs2Gf7AFY
YeKjxDeHKSuU3tEUZoyuAQijNj4MGvnHGruAHpGwjjwmleH+5r8yPB8jALt9QivG
VqHjmPEuP8k0fM6KRanyH8dLUh3l8Xm+ve+8AyNl3MkESCjDBp7nwhJMrsoDh+DX
tUYcBD0GbTfHPCH0k/zZwojHRNExoMks3CKa1+1OqpimIekVgCdi4ytk3yG/liL3
ewuZA0vlPgM71U7s1BeMGHCr07IwoPLD7UcZ3OV2eSHR5Q/THoLkm2Vdv0WJXbDj
PUH5yJ+WP1Xn0bsngDZ9zu73vKnXszMLfcH8Z5Yio9URT+PXVxIjKJGy5r8RlgGo
PhfPBKZO6AUTNbv0xI23swQxriUVkzHYvvpGjb79GJ505IBU3hDkiPvzRPNkhU5F
aV1XG/+727WlocHEMEsjp1B1m3OBgLY3zS7gkbXhb9f1XPYc3NM=
=SmvH
-----END PGP SIGNATURE-----

--=-kV5YxPxZguCMHHmtTQwY--

