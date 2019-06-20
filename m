Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE874C51D
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 03:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfFTBvz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 21:51:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfFTBvz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jun 2019 21:51:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E50B0C057F3E;
        Thu, 20 Jun 2019 01:51:54 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 518C95D719;
        Thu, 20 Jun 2019 01:51:54 +0000 (UTC)
Message-ID: <e19673d2233a8e38f3e74eb6760232df1a304f3a.camel@redhat.com>
Subject: Re: [PATCH 2/2] RDMA/netlink: Audit policy settings for netlink
 attributes
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 19 Jun 2019 21:51:51 -0400
In-Reply-To: <20190620001759.GC14968@ziepe.ca>
References: <cover.1560957168.git.dledford@redhat.com>
         <5ef05339c1d799133076c24e616860a647e96148.1560957168.git.dledford@redhat.com>
         <20190619192431.GA13262@ziepe.ca>
         <b964f5286ad9d2c3f1fb2f4f0f3206ecf9da2ad7.camel@redhat.com>
         <20190619201158.GK9360@ziepe.ca>
         <3695301f8ba9f8902c5c0a00171f6ca72f83faf2.camel@redhat.com>
         <20190620001759.GC14968@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LHVrDwVhynYS79tGPwWS"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 20 Jun 2019 01:51:55 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-LHVrDwVhynYS79tGPwWS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-19 at 21:17 -0300, Jason Gunthorpe wrote:
> On Wed, Jun 19, 2019 at 07:59:22PM -0400, Doug Ledford wrote:
> > On Wed, 2019-06-19 at 17:11 -0300, Jason Gunthorpe wrote:
> > > On Wed, Jun 19, 2019 at 04:02:30PM -0400, Doug Ledford wrote:
> > > > On Wed, 2019-06-19 at 16:24 -0300, Jason Gunthorpe wrote:
> > > > > > +	nla_strlcpy(client_name,
> > > > > > tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE],
> > > > > > +		    sizeof(client_name));
> > > > >=20
> > > > > This seems really frail, it should at least have a
> > > > >=20
> > > > > BUILD_BUG_ON(sizeof(client_name) =3D=3D
> > > > > nldev_policy[RDMA_NLDEV_ATTR_CHARDEV_TYPE].len));
> > > > >=20
> > > > > But I don't think that can compile.
> > > > >=20
> > > > > Are we sure we can't have a 0 length and just skip checking in
> > > > > policy?
> > > > > It seems like more danger than it is worth.
> > > >=20
> > > > nla_strlcpy takes a size parameter as arg3 and guarantees to put
> > > > no
> > > > more than arg3 bytes - 1 from the source into the dest and
> > > > guarantees it's null terminated.  The only difference between
> > > > nla_strlcpy and normal strncpy is that nla_strlcpy zeros out any
> > > > excess pad bytes that aren't used in the dest by the copy.  If
> > > > someone tries to pass in an oversized string, it doesn't
> > > > matter.  If
> > > > someone modifes the function to change the size of client_name,
> > > > our
> > > > nla_strlcpy() is safe because our dest and our len parameters
> > > > are
> > > > always in sync.  I don't see the fragility.
> > >=20
> > > Silently truncating the user input string and not returning an
> > > error
> > > is a kernel bug.
> >=20
> > That's a matter of expectations.  Looking through all instances of
> > nla_strlcpy() in the kernel tree, only about 4 of the 25 or so uses
> > check the return code at all
>=20
> Sadly the kernel is full of bugs :(
>=20
> Silent string truncation is a well known bug class, I guess Dan
> Carpenter just hasn't quite got to sending reports on these cases
> yet..
>=20
> > and only 1 of those returns an error code to the application.  This
> > mirrors the behavior people see when they try to do things like
> > rename a netdevice and pass in too long of a name.  As long as the
> > truncated name isn't taken, it succeeds at the truncated name.
>=20
> Returning ENOENT, or worse, the entirely wrong result instead of
> EINVAL, for a too long string is a straight up bug.
>=20
> The probability of any user hitting this is very low, but it is not
> some well thought out behavior...
>=20
> > > I dislike strlcpy and friends for the same reason everyone else
> > > does -
> > > they prevent security failures but create bugs with undetected
> > > truncated strings.
> >=20
> > I think the net stack has a fairly well established behavior in
> > regards
> > to truncating overly long strings. =20
>=20
> I think it is just bugs. :(
>=20
> > truncation, or fix the perceived kernel bug?  I don't actually feel
> > strongly about it.  I'm used to the truncation behavior.  If you
> > would
> > strongly prefer an error on overflow, I'll change the patch up.
>=20
> The client_name is a stack variable of a completely arbitrary size
> that
> is larger than all existing client_name statics in today's
> kernel. Tomorrow it may get bigger, or smaller. Its length absolutely
> does not form part of the uAPI contract, and truncation of the user
> provided string should always return EINVAL never any other result.

Ok.  I'll push out everything but this patch, and rework this patch
tomorrow.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-LHVrDwVhynYS79tGPwWS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0K5rcACgkQuCajMw5X
L92+wg/+MhWDWRoKxs8Nt7YSVtFLaX8cU8/kkfdxKrH6UBXCMe4G1R99/5to/Qw9
bWR0wWV0tCDcCoWEGDEG9CU1fUAtgLwh2eBlsH+qV26SKnCwZlfv1PapPYWUZJ2z
unHBCjG382ADJYsTskzItMuvKMlFC+cBdz7YZvh/W3f18idCmQWNEWUkBVQ52iSG
XFIsp9asiAraONbrJaDBf5MxasxgIYRK0LG7zwccoNhAnZ1ULF9OxWuUkldzOnqq
EPmyQm0HzfA0OI753SNBLEXzcjRANS3lPCP/p+0VkS3zYO3uzTA6diXzJpPLrtiC
8FKEt1RqWxetw1gEOn4k5ZSwdXwmVI620MdpxPRJt/9P8prWsVXVpYoEnYdmN985
orkXq1YMxXOc6FYcE03Zezbmzby7ugCifD0aTctm0vY3IF8olP/avn8Ebd6BYzod
6hDdZRlNIQtWXtrBANz5STpFUm8He9Ms/DYC/SF9Hz8YrS6paNj2gnem8TtI6Tas
bGZQSR++5cMHQx6jLB/Jr8FSX6hlc2TuBm1Z6ONI7uT4QdYOxbkRiaPVZW0WZmqW
fd7vvYi3UTUJh1ENelcqZyOOCE3BSlJ2DqPcnWVWTmkam7CkD7wrtt/PCvn8cHPt
7ddu27A4LgYR0UJIZAzRU/x7LIDyzKcDyCZ5zQevzBIvlb8ZvRw=
=wsyA
-----END PGP SIGNATURE-----

--=-LHVrDwVhynYS79tGPwWS--

