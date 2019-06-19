Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C394C201
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 22:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfFSUCj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 16:02:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfFSUCj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jun 2019 16:02:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DE2C22386D;
        Wed, 19 Jun 2019 20:02:34 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A78216013D;
        Wed, 19 Jun 2019 20:02:33 +0000 (UTC)
Message-ID: <b964f5286ad9d2c3f1fb2f4f0f3206ecf9da2ad7.camel@redhat.com>
Subject: Re: [PATCH 2/2] RDMA/netlink: Audit policy settings for netlink
 attributes
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 19 Jun 2019 16:02:30 -0400
In-Reply-To: <20190619192431.GA13262@ziepe.ca>
References: <cover.1560957168.git.dledford@redhat.com>
         <5ef05339c1d799133076c24e616860a647e96148.1560957168.git.dledford@redhat.com>
         <20190619192431.GA13262@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+N7qhVXbTu2TH1nsl9c/"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 19 Jun 2019 20:02:38 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-+N7qhVXbTu2TH1nsl9c/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-19 at 16:24 -0300, Jason Gunthorpe wrote:
>=20
> > +	nla_strlcpy(client_name, tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE],
> > +		    sizeof(client_name));
>=20
> This seems really frail, it should at least have a
>=20
> BUILD_BUG_ON(sizeof(client_name) =3D=3D
> nldev_policy[RDMA_NLDEV_ATTR_CHARDEV_TYPE].len));
>=20
> But I don't think that can compile.
>=20
> Are we sure we can't have a 0 length and just skip checking in policy?
> It seems like more danger than it is worth.

nla_strlcpy takes a size parameter as arg3 and guarantees to put no more
than arg3 bytes - 1 from the source into the dest and guarantees it's
null terminated.  The only difference between nla_strlcpy and normal
strncpy is that nla_strlcpy zeros out any excess pad bytes that aren't
used in the dest by the copy.  If someone tries to pass in an oversized
string, it doesn't matter.  If someone modifes the function to change
the size of client_name, our nla_strlcpy() is safe because our dest and
our len parameters are always in sync.  I don't see the fragility.

> >  	if (tb[RDMA_NLDEV_ATTR_DEV_INDEX]) {
> >  		index =3D nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
> > diff --git a/include/uapi/rdma/rdma_netlink.h
> > b/include/uapi/rdma/rdma_netlink.h
> > index b27c02185dcc..24ff4ffa30dd 100644
> > +++ b/include/uapi/rdma/rdma_netlink.h
> > @@ -285,6 +285,7 @@ enum rdma_nldev_command {
> >  };
> > =20
> >  enum {
> > +	RDMA_NLDEV_ATTR_EMPTY_STRING =3D 1,
> >  	RDMA_NLDEV_ATTR_ENTRY_STRLEN =3D 16,
>=20
> The empty thing is just an internal implementation detail, should not
> leak into uapi

So was ENTRY_STRLEN.  Once I audited and set all non-input strings to
EMPTY_STRING, ENTRY_STRLEN isn't even used any more.  It happens to be
the same as IFNAMSIZ and so could be used in its place, but doesn't have
to be.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-+N7qhVXbTu2TH1nsl9c/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0KlNYACgkQuCajMw5X
L91d0Q/8DJp1IXsxTj+eVdzOjF3XkzbM/+eiRSZJgeCZVn3OF2U6nXdlxXD0KqbC
BdOAJOBrY5KV++3XFZz+BHLWxn/jJwn/WDMi1ncZNlQqqsanslRfiwfz++KpZOEn
WjXyTUhApQ/DV5a8nMVFFtmfBkFEBdFKhvjda78WMksu0Qw87hYD0219YBG8rqjf
Qg6SPUDcR53Wpl1mMEwyj9No/HjbXhIhfDpJER5JhcqJS3wRjJlrHmg84+e2Dx6E
pl6sNFytTx2PD61IHJGcyaSBx+kvajIJQmCYPBHwcCitNvQZZ21lo+dmeFF5TqCZ
M8TYtttf65YOCSdgDzUbuSgBrWu6PiVngmab0nuBpolqjsAoRBRBGZSAH6500HeD
ULQ00UghVfvayNIU2R15LVfSEPMF+g3UUJXRor1mESu2w/xpVEw3obXdk5XTwXSt
TyEdN9PnNHhvi6Gmj2/u+XSO3y8CMHNWjc2bQCHKF/XDuLJhQfEl1rYq5pSe/BHw
JiH2EiBd1FoBhVcGP1zlOTV/MJL+XMqBiaqBxoPWsGFodi0spB5/08FWmW4G1spb
BvCFIGooTLUzMFSXwSrZTELLFn94hOdr2MF97+ing5paRf8Bkyd1MXQLoGNOUNIM
L33ylWvuOLeMnVLX4J5aw8IrbVPtpVAG6FCVwJvExsEQhWEK1j0=
=6oHU
-----END PGP SIGNATURE-----

--=-+N7qhVXbTu2TH1nsl9c/--

