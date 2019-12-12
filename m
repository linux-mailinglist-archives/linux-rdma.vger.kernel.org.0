Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A57511D908
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 23:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfLLWGo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 17:06:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53823 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730779AbfLLWGo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Dec 2019 17:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576188402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O1h6InmNDXxK4eSQU7BGNjAS6CC7RxlUPwcIjM2O2ig=;
        b=Vj9XOZ8iUoUm9RMM3vpOSWiM13fRlwuCtwAaBuYXjFjZROF8p8pLRz8j4Dp1OZ4a9YCBRY
        1fWg62Ec8gmPVRUOhKSm9J9g4zIBsgv7tNmDmQnoSzY7MdEs5Z3K/8MMec1eTss1OyxPAF
        XmGEYpkQXWhen1MiffwAsJ2n7hmcmQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-1cuBz17tPw29KspTqU71PA-1; Thu, 12 Dec 2019 17:06:36 -0500
X-MC-Unique: 1cuBz17tPw29KspTqU71PA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EB1B800D41;
        Thu, 12 Dec 2019 22:06:35 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E8016609A;
        Thu, 12 Dec 2019 22:06:34 +0000 (UTC)
Message-ID: <55d97fa9d8efd296ecc308a67e043db3714cfcf3.camel@redhat.com>
Subject: Re: [PATCH 2/2] rxe: correctly calculate iCRC for unaligned payloads
From:   Doug Ledford <dledford@redhat.com>
To:     Tom Talpey <tom@talpey.com>, Leon Romanovsky <leon@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Steve Wise <larrystevenwise@gmail.com>,
        linux-rdma@vger.kernel.org, 3100102071@zju.edu.cn
Date:   Thu, 12 Dec 2019 17:06:32 -0500
In-Reply-To: <5f98ecdc-44d1-e185-19e9-7710c2c7c991@talpey.com>
References: <20191203020319.15036-1-larrystevenwise@gmail.com>
         <20191203020319.15036-2-larrystevenwise@gmail.com>
         <a0003c88-10f5-c14a-220d-c100fa160163@acm.org>
         <0f8d9087c48e986d08cf85ef8b59bdca25425eaa.camel@redhat.com>
         <1aee0f71873a4c9da7f965c12419d81333f3a0b4.camel@redhat.com>
         <20191210065410.GK67461@unreal>
         <c20696208c239bd11621ad3101735255738bcc97.camel@redhat.com>
         <5f98ecdc-44d1-e185-19e9-7710c2c7c991@talpey.com>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-SM7OdyQ9BoAct7SfnIiC"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-SM7OdyQ9BoAct7SfnIiC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-11 at 09:42 -0500, Tom Talpey wrote:
> On 12/10/2019 11:24 PM, Doug Ledford wrote:
> > On Tue, 2019-12-10 at 08:54 +0200, Leon Romanovsky wrote:
> > > On Mon, Dec 09, 2019 at 02:07:06PM -0500, Doug Ledford wrote:
> > > >=20
> > > Do you find this implementation needed? I see RXE as a development
> > > platform and in my view it is unlikely that someone will run RXE
> > > in
> > > production with mixture of different kernel versions, which
> > > requires
> > > such compatibility fallback.
> >=20
> > It's not a requirement, that's why I took the patches as they
> > were.  It
> > would just be a "nice to have".
>=20
> The counterargument to this is that it only extends the protocol bug
> into the future, and for one single RoCE implementation.

It just allows buggy implementations to talk to newer soft-RoCE
(although not to hardware).

>  No hardware
> implementation will do this, as it violates the protocol.

Right.

>  And, it
> potentially opens a silent data corruption, by accepting packets which
> don't actually pass the checksum.

This, I highly doubt.  For packets without padding, it would be the
same.  For packets with padding, it would only allow packets where the
data bytes had a correct CRC, so it's not like it just allows anything
to come through.  And it would only allow it if the flag was set, it's
not like we would allow two different CRCs on every packet with padding,
it's either on or off, and the check still covers all data bytes.  I
find it highly unlikely that this would introduce any sort of data
consistency problems for the specific case of old soft-RoCE talking to
new soft-RoCE.

> Personally, I'd say it "nice to avoid", i.e. don't apply such a patch.

No one has submitted a patch, so we seem to be good regardless ;-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-SM7OdyQ9BoAct7SfnIiC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl3yuegACgkQuCajMw5X
L927GA//SrL+IwyKuTPB6XXB3gc/d3IU/fRArkCyj9BVMIR+ugvHDp6Mqoq24sy7
pH4xNcjYlrMUJiOOd4XF+7K9My7CqiNbEq6UFyVK83dofP8cfNNcwFuJa+rfZkRf
XUCCTWZwQvOSmkDjmbuvL7nqkZSQx0wnlv9Gch/DoCiReM20nEGoN0HOdMC1ySpa
ioZ1kgAldZcrLd6OnLDq8HfKUzkpPmynG834mN7HUzCNp9swur99TKQMITYOQsdN
VV9s8EUjD/YHo0G4bSdwaE3vsQa5fIr+T6D9V5yfGeA1uZtCXZ4ecS1OGCx2meLI
Pdow51aSqH0pHv/Y5l/2GugL6sER6iIz7tRtQRx2xrqhf1Ry7/Jh9L9E+fZuTwMy
uWMK/NQBF8+vv7lEK3ekbI0b/JnNInTkqE6swLhR23uliiL9z6nSBA2ONlDmmpwH
3g7NDRW5KwIB784/1jplncZSAzvq0qRiwDHFEQWVnbzdtWE8ipvA0TJz63cM9Tkb
P29TxBrL/pWYeus65BowIAbVwjEVNVusRWXbJtjP+OR5/zeQbOmtper3j/O3WU95
tphbzvGddv3iW+OmWKU4USOIQWuz0fqRD+9EJlRdA0TOSxVq8mBzwXfI732TVlPm
luZO0hTx1l2w9Uf3Hf3iD9P3MhIjArobEp6uUTtFQm0qldmpt6M=
=Rh4C
-----END PGP SIGNATURE-----

--=-SM7OdyQ9BoAct7SfnIiC--

