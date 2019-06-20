Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13BA94DB3B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 22:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfFTUaN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 16:30:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfFTUaN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 16:30:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D88B37E42C;
        Thu, 20 Jun 2019 20:30:07 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1951219C77;
        Thu, 20 Jun 2019 20:30:05 +0000 (UTC)
Message-ID: <54fedcfc1ffc92a5446c2f720c7dd57776333ef1.camel@redhat.com>
Subject: Re: [PATCH V3 for-next] RDMA/hns: reset function when removing
 module
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Lijun Ou <oulijun@huawei.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Thu, 20 Jun 2019 16:30:03 -0400
In-Reply-To: <20190620200533.GH19891@ziepe.ca>
References: <1560524163-94676-1-git-send-email-oulijun@huawei.com>
         <d4ba310e1cb50abd3810032fc468797edd917c08.camel@redhat.com>
         <20190620193457.GG19891@ziepe.ca>
         <9862d4db3e930bc12c059f8b04e1eb24c493519b.camel@redhat.com>
         <20190620200533.GH19891@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xjgCBBdOUQ9sDjQqOr7k"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 20 Jun 2019 20:30:13 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-xjgCBBdOUQ9sDjQqOr7k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-20 at 17:05 -0300, Jason Gunthorpe wrote:
> On Thu, Jun 20, 2019 at 03:48:23PM -0400, Doug Ledford wrote:
>=20
> > It's an msleep() waiting for a hardware command to
> > complete.  Waiting
> > synchronously for a command that has the purpose of stopping the
> > card's
> > operation does not sound like an incorrect locking or concurrency
> > model
> > to me.  It sounds sane, albeit annoying.
>=20
> If it was the only sleep loop you might have a point, but it isn't,
> every other patch series lately seems to be adding more sleep
> loops. This sleep loop is already wrapping another sleep loop under
> __hns_roce_cmq_send() - which, for some reason, doesn't have an
> interrupt driven completion path.
>=20
> Nor is there any explanation why we need a sleep loop on top of a
> sleep loop, or why the command is allowed to fail or why retrying the
> failed command is even a good idea, or why it can't be properly
> interrupt driven!
>=20
> I'm frankly sick of it, maybe you should review HNS patches for a
> while..

Are you sure this hasn't changed over time and you didn't realize it?=20
I'm not seeing all the sleeps you are talking about. In fact, if I grep
for "sleep" in hw/hns/ I only find 9 instances: 5 in hns_roce_hw_v1 and
4 in hns_roce_hw_v2, so really only 5 at most as those two files are
just duplicates of each other for the different hardware.  And even
then, when I checked on all the sleeps in hw_v2, they were all in init
or reset code paths, certainly none in send.  And I didn't find any
include file wrappers that use sleeps.  I get how over use of sleeps can
be a big issue, I guess I'm just having a hard time finding where it's
being abused as badly as you say.  Of course, I may just not be looking
in the right place...

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-xjgCBBdOUQ9sDjQqOr7k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0L7MsACgkQuCajMw5X
L93dHhAAuXP4KLTnKetSl6qWxkaVuR2uyTZOL1CLAvJb22n0NoDUs7V0wXnBKrh5
hFCT47xbhqOWOR4m1uA2d5t0KusnzJfxn2uCxhDv4JFr9HbK+VtCGLLJmnattHfz
Ow6OzLitHEzcXZVYmegtq1jVmgMrpa6C9NtoToOHO/mnF6/zSv9Z2/Y+x5EE4+7M
Mvrj+7LM35o8T2DUyFH4jJTG8gqgAePTCfjcoGx5lD2YfY6H/vo0Z/Ij6dbSHKFq
W/tQvuCdlpV9Sq0ViM3MJs1NQX8yso0xuVco1QNngDuoTy6gvKHPxlTBwxh2kiYC
0/CahQ7uVz8pdA8S9PTQpqbQCRjcvdP1LI5txI0U60nL2OjHktdd9oDIw25IIfNy
zvcyqUKXyDSXQBYhrzOdFK9JmAy9lmZj5jVSnH+3yswMo/sLhmV+c7zknBSdMVHa
g6mRmLzHkoW5WB92yjzJML9iIIVm2fnDTBI5KVWPRakPw+tFICYAcQAekOkONW0W
PuLuXwEpzqkmQNurkez6uqzHBIOtmWq0w11+crRUoUYXIa8ZQWSYPfvs4PTzaHx1
MyIuLQeCnrm8Kb6vK0zsAcnElqT0SPNR+vP8HUdYSQR20f9X9LbxOv0XhDYnegTK
nOfyravokdM9T9frd/aV9Toy4En+y9GA0+JKTN9f2IpOVT8ry+o=
=FJih
-----END PGP SIGNATURE-----

--=-xjgCBBdOUQ9sDjQqOr7k--

