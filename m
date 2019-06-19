Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 222F04C441
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 01:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfFSX70 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 19:59:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfFSX70 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jun 2019 19:59:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1F7383F44;
        Wed, 19 Jun 2019 23:59:25 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 062279F5E;
        Wed, 19 Jun 2019 23:59:24 +0000 (UTC)
Message-ID: <3695301f8ba9f8902c5c0a00171f6ca72f83faf2.camel@redhat.com>
Subject: Re: [PATCH 2/2] RDMA/netlink: Audit policy settings for netlink
 attributes
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 19 Jun 2019 19:59:22 -0400
In-Reply-To: <20190619201158.GK9360@ziepe.ca>
References: <cover.1560957168.git.dledford@redhat.com>
         <5ef05339c1d799133076c24e616860a647e96148.1560957168.git.dledford@redhat.com>
         <20190619192431.GA13262@ziepe.ca>
         <b964f5286ad9d2c3f1fb2f4f0f3206ecf9da2ad7.camel@redhat.com>
         <20190619201158.GK9360@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gsIOHgkaQBm7pdJQh6Cb"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 19 Jun 2019 23:59:25 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-gsIOHgkaQBm7pdJQh6Cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-19 at 17:11 -0300, Jason Gunthorpe wrote:
> On Wed, Jun 19, 2019 at 04:02:30PM -0400, Doug Ledford wrote:
> > On Wed, 2019-06-19 at 16:24 -0300, Jason Gunthorpe wrote:
> > > > +	nla_strlcpy(client_name,
> > > > tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE],
> > > > +		    sizeof(client_name));
> > >=20
> > > This seems really frail, it should at least have a
> > >=20
> > > BUILD_BUG_ON(sizeof(client_name) =3D=3D
> > > nldev_policy[RDMA_NLDEV_ATTR_CHARDEV_TYPE].len));
> > >=20
> > > But I don't think that can compile.
> > >=20
> > > Are we sure we can't have a 0 length and just skip checking in
> > > policy?
> > > It seems like more danger than it is worth.
> >=20
> > nla_strlcpy takes a size parameter as arg3 and guarantees to put no
> > more than arg3 bytes - 1 from the source into the dest and
> > guarantees it's null terminated.  The only difference between
> > nla_strlcpy and normal strncpy is that nla_strlcpy zeros out any
> > excess pad bytes that aren't used in the dest by the copy.  If
> > someone tries to pass in an oversized string, it doesn't matter.  If
> > someone modifes the function to change the size of client_name, our
> > nla_strlcpy() is safe because our dest and our len parameters are
> > always in sync.  I don't see the fragility.
>=20
> Silently truncating the user input string and not returning an error
> is a kernel bug.

That's a matter of expectations.  Looking through all instances of
nla_strlcpy() in the kernel tree, only about 4 of the 25 or so uses
check the return code at all, and only 1 of those returns an error code
to the application.  This mirrors the behavior people see when they try
to do things like rename a netdevice and pass in too long of a name.  As
long as the truncated name isn't taken, it succeeds at the truncated
name.

> I dislike strlcpy and friends for the same reason everyone else does -
> they prevent security failures but create bugs with undetected
> truncated strings.

I think the net stack has a fairly well established behavior in regards
to truncating overly long strings.  Sending an error is just as likely
to break people's assumptions that even an overly long name will succeed
as long as the truncated version of the name isn't taken.

Regardless though, I think it's fair to say the current code as this
patch makes it is not fragile.  It is the opposite.  It just happens to
follow netdev behavior, and that standard offends your better
sensibilities ;-).  The question is whether it is better to buck the
standard and risk confusing people that are actually used to silent
truncation, or fix the perceived kernel bug?  I don't actually feel
strongly about it.  I'm used to the truncation behavior.  If you would
strongly prefer an error on overflow, I'll change the patch up.

> > > >  	if (tb[RDMA_NLDEV_ATTR_DEV_INDEX]) {
> > > >  		index =3D
> > > > nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
> > > > diff --git a/include/uapi/rdma/rdma_netlink.h
> > > > b/include/uapi/rdma/rdma_netlink.h
> > > > index b27c02185dcc..24ff4ffa30dd 100644
> > > > +++ b/include/uapi/rdma/rdma_netlink.h
> > > > @@ -285,6 +285,7 @@ enum rdma_nldev_command {
> > > >  };
> > > > =20
> > > >  enum {
> > > > +	RDMA_NLDEV_ATTR_EMPTY_STRING =3D 1,
> > > >  	RDMA_NLDEV_ATTR_ENTRY_STRLEN =3D 16,
> > >=20
> > > The empty thing is just an internal implementation detail, should
> > > not
> > > leak into uapi
> >=20
> > So was ENTRY_STRLEN.  Once I audited and set all non-input strings
> > to
> > EMPTY_STRING, ENTRY_STRLEN isn't even used any more.  It happens to
> > be
> > the same as IFNAMSIZ and so could be used in its place, but doesn't
> > have
> > to be.
>=20
> Should move both then

Done.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-gsIOHgkaQBm7pdJQh6Cb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0KzFoACgkQuCajMw5X
L92dXxAAipSL0iTj9vm59rf4o1OfRQILcLZ3FIUwSmi/j6CzY2g4nM2gXNt7yoGD
VBrFhgo4sk4801utnQWgQcH6OIl/C9qrQX2JcSMxTOyB9ZbennkEN89q2ehCWvry
dih5+NFk9k59AWwJywh2cNpO+RtwSjzyRU79JSDZOT3VH47pdyZxuiuiEnJ7MyLh
V4XfD4mpoXmlnBr2zkmGujvc/EVubJomTeIPld64aGXZDBrvJuE/I6C7aa+BwGPi
2OGXAUniHMI7afFa7dnICZ7hQvmdh0Jj0ife1GwGMrMy0oQAg0RsD4V7Mh5k9F0x
OaUszou92XnxZ5a1bTrw87MdOqvN3+VHI2hs/60BVEL1w+sKlrkgrPd6VAqh+Pid
G0mdVmuIE1F1GzAXo1CmvwKnGrET3Dw0n43wUElNRPKMag3nMcI8QFZS4Y8PrV3A
OgBm2R3uX11Q/Kxfm4OFtNsdHqc/AEtJUtcGpaPFzlHMpizzpboiTYjd5Lmnjfvg
Q9T4jbQl6sWeAzs5AASmUWvTdpi7BWox+75e2O/0B0sDLu90CdQiTzwJV2DADeob
OVxtHI9ssi+GfA1A8zKce0E0aS5eWxMuH/BcHMDo2zq1m8CWfHczuuMnyCY88b4f
I7Ut10spv6U/t024j2mNR+zkMP4ltXz3s7oCW9RbjpRMbYAWQKQ=
=YaxB
-----END PGP SIGNATURE-----

--=-gsIOHgkaQBm7pdJQh6Cb--

