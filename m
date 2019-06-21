Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B854EF83
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 21:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFUTei (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 15:34:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfFUTeh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Jun 2019 15:34:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35FA2BDD1;
        Fri, 21 Jun 2019 19:34:32 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B3E25C21E;
        Fri, 21 Jun 2019 19:34:30 +0000 (UTC)
Message-ID: <9864929b96df09102ec801b2e70806cdf266e107.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] RDMA/netlink: Audit policy settings for netlink
 attributes
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org
Date:   Fri, 21 Jun 2019 15:34:28 -0400
In-Reply-To: <20190621182028.GA22934@ziepe.ca>
References: <b77fa93a0a34dc0ae40bdbac83ea419a0d8879ff.1561048044.git.dledford@redhat.com>
         <20190621182028.GA22934@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-2Jap0XLtB2wgDdt0qta9"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 21 Jun 2019 19:34:37 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-2Jap0XLtB2wgDdt0qta9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-06-21 at 15:20 -0300, Jason Gunthorpe wrote:
> On Thu, Jun 20, 2019 at 12:30:17PM -0400, Doug Ledford wrote:
> > For all string attributes for which we don't currently accept the
> > element as input, we only use it as output, set the string length to
> > RDMA_NLDEV_ATTR_EMPTY_STRING which is defined as 1.  That way we
> > will
> > only accept a null string for that element.  This will prevent
> > someone
> > from writing a new input routine that uses the element without also
> > updating the policy to have a valid value.
> >=20
> > Also while there, make sure the existing entries that are valid have
> > the
> > correct policy, if not, correct the policy.  Remove unnecessary
> > checks
> > for nla_strlcpy() overflow once the policy has been set correctly.
>=20
> The above commit message paragraph is out of date now.
>=20
> Otherwise looks OK to me, it would be nice if we could avoid sizing
> the string in the policy, but OK otherwise.
>=20
> FWIW this is probably how other netlink users in net are making their
> use of strings OK. The policy will reliably trigger the EINVAL if the
> policy length and the buffer length are identical.

If that's the case, then we can go back to the original patch and drop
all the checking of string copy overruns because I set all of the policy
elements on anything that was a valid input to the input size.

> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
>=20
> Jason

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-2Jap0XLtB2wgDdt0qta9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0NMUQACgkQuCajMw5X
L90hkg/+Js7ewjZZDxK4mNTc1dLW91VKcm5rCnNPSKzHezwEtChoDh01sqvsXFdx
shdC3buNhqyd+/p0iGWJU+5/TV0d/DwebVMInQ3GON2m50w//9NSTA/qesXUBLNp
nF7GSwn1wXiSZCk99qwyMg68jxBXqzwQY2cXRfA3tCKgQhpJK0C8nMQqYI+j59km
iNQueS5ezGyNn8NZQxaJC+i/+obHDPsOdovzd2F+8+3AU2ogyniu3ISwcPqqpunf
yL+g+N6hYV0oTLvVaweXeKIgxwXMyXVJSI8RzqSXv1RqMFVDMTghKru6ctiNjdh6
hb0nNlwyZhJBQMot5Es4FlanX2sexuRJp2xqsg8T00tYyN6kY/lFddL56bKjwuD9
/58WlXUsergl+au2usfIdmsrYnMTki2EayFOWdP+UZS+HGWEEbeInG8nRvoHltv5
c6rpRmOYpIPNTDZBRTAryWZePr3DbrP8ZB6MPZEcOwMdLQ4mIasBHmWBydlXg3I6
9pAbU20vyS5sGMoknVaqgKXjdlglQJ4sc7XIxzysGe0rLui8YSDPwV40u9sUhM9G
o5/BhYpcMq8UA5eIcsHYql2bYTTYTsXB1zvTpHsGQbLos9bbkoSSzOpUAKhxtl8i
S1qVuTnJMVt6RuLJeMNvJRrxH5COvrlQMSqUzqE2MZb5BJfewjk=
=f2yw
-----END PGP SIGNATURE-----

--=-2Jap0XLtB2wgDdt0qta9--

