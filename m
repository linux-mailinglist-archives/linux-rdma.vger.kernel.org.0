Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E924EAFC
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfFUOqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 10:46:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfFUOqy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Jun 2019 10:46:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCBDE85546;
        Fri, 21 Jun 2019 14:46:48 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39BBA60142;
        Fri, 21 Jun 2019 14:46:46 +0000 (UTC)
Message-ID: <bed26bed510e6c38309ebe26fde6834cb687a100.camel@redhat.com>
Subject: Re: [PATCH V3 for-next] RDMA/hns: reset function when removing
 module
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Lijun Ou <oulijun@huawei.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Fri, 21 Jun 2019 10:46:43 -0400
In-Reply-To: <20190621125750.GJ19891@ziepe.ca>
References: <1560524163-94676-1-git-send-email-oulijun@huawei.com>
         <d4ba310e1cb50abd3810032fc468797edd917c08.camel@redhat.com>
         <20190620193457.GG19891@ziepe.ca>
         <9862d4db3e930bc12c059f8b04e1eb24c493519b.camel@redhat.com>
         <20190620200533.GH19891@ziepe.ca>
         <54fedcfc1ffc92a5446c2f720c7dd57776333ef1.camel@redhat.com>
         <20190621125750.GJ19891@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fiIF1tqUSqwJOm+vJBns"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 21 Jun 2019 14:46:53 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-fiIF1tqUSqwJOm+vJBns
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-06-21 at 09:57 -0300, Jason Gunthorpe wrote:
> On Thu, Jun 20, 2019 at 04:30:03PM -0400, Doug Ledford wrote:
> > On Thu, 2019-06-20 at 17:05 -0300, Jason Gunthorpe wrote:
> > > On Thu, Jun 20, 2019 at 03:48:23PM -0400, Doug Ledford wrote:
> > >=20
> > > > It's an msleep() waiting for a hardware command to
> > > > complete.  Waiting
> > > > synchronously for a command that has the purpose of stopping the
> > > > card's
> > > > operation does not sound like an incorrect locking or
> > > > concurrency
> > > > model
> > > > to me.  It sounds sane, albeit annoying.
> > >=20
> > > If it was the only sleep loop you might have a point, but it
> > > isn't,
> > > every other patch series lately seems to be adding more sleep
> > > loops. This sleep loop is already wrapping another sleep loop
> > > under
> > > __hns_roce_cmq_send() - which, for some reason, doesn't have an
> > > interrupt driven completion path.
> > >=20
> > > Nor is there any explanation why we need a sleep loop on top of a
> > > sleep loop, or why the command is allowed to fail or why retrying
> > > the
> > > failed command is even a good idea, or why it can't be properly
> > > interrupt driven!
> > >=20
> > > I'm frankly sick of it, maybe you should review HNS patches for a
> > > while..
> >=20
> > Are you sure this hasn't changed over time and you didn't realize
> > it?=20
> > I'm not seeing all the sleeps you are talking about.=20
>=20
> It is because I wasn't applying those patches :)

Ok, well, I promise if they send a patch that adds an msleep in the
middle of the send routine, I'll reject that.  But this one is on the
module remove path (or so the subject says).  I'm not really concerned
about it here.

> > In fact, if I grep for "sleep" in hw/hns/ I only find 9 instances: 5
> > in hns_roce_hw_v1 and 4 in hns_roce_hw_v2, so really only 5 at most
>=20
> Most of our drivers have 0 sleep loops (excluding the hfi/qib
> uglyness), so 9 is aleady absurd for a 2010 era driver.

Yeah, but they get away from that with a workqueue/waitq type setup.=20
That's fine for a running module, but is a bit messy when doing a module
unload where you have to protect against deleting the workqueue/waitq
until after you are done using it, so again, I'm fine with a sleep here
instead.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-fiIF1tqUSqwJOm+vJBns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0M7dMACgkQuCajMw5X
L924ohAAnvkVwlvgpHooDQFnbj36aNwxoJ/mQ45LHE9xnpvkdDbgCmi9F56aT3rC
VQw9qv4Z3U4aigkCgz7Zj23mdtaFoxSI8XG6CTZMCsOs3bYHMoUTrbqzaqWTTHr6
CPYLbs3KC7tPHxOCkXb69v9aLq7Ozvs60etoMKx6yaQMAfX3XO9oBmo6R+ogvTIz
HjMzdWWuEuk2pBLS6XJy/ZFODsI54yjuLmRgd6M6oViCgl+Qswn6SSXjwsrG10AY
HEbXc01h7oaKN/jH0vuKJBB5+WG256BA/UfxG2/ruRbERwdzcV/qKwuGZgUkbH/W
U7+b4YgGHo3AnBQeYbEIzNxtvob1FEMye8W6u/Sp8cr2/5qu8pqnGR7hKPQGwYk5
9tunZgLjkxFtIfWGTat0G2wVqHesl+aeuqTtXeaLrEz1+R5/ttAkpHvxDVI75lgG
rH6lESQZ8DiMaYm/4V2bQvsePbuXqadCGatfvKpf4IBQ0UcJpWZNFuj9DfpA+L+S
PxXX4TyRkRNXFxYIyMFaK7HyeOlhaNmd/m7sdiehp9LZzSXMnLOU+Ge64UHyC80V
QOHfDNIO703B3LWbKeHtq1Z+O5mu3DFvKAiG2myPI7ND4A5GcaO2dRF75Xk6ozkG
TXhcgdzr/ZSy8UpH7sc3O86MCewjIfWTzQ88Thku++ebqkB3fY0=
=dR3b
-----END PGP SIGNATURE-----

--=-fiIF1tqUSqwJOm+vJBns--

