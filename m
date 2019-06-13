Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1747344D5A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 22:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfFMUZY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 16:25:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfFMUZX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 16:25:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4E9D37F43;
        Thu, 13 Jun 2019 20:25:22 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B476600C1;
        Thu, 13 Jun 2019 20:25:21 +0000 (UTC)
Message-ID: <6e586118ad154204ad2e2cf2c1391b916cb4ee54.camel@redhat.com>
Subject: Re: [PATCH v2] RDMA/cma: Make CM response timeout and # CM retries
 configurable
From:   Doug Ledford <dledford@redhat.com>
To:     =?ISO-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Jun 2019 16:25:15 -0400
In-Reply-To: <67B4F337-4C3A-4193-B1EF-42FD4765CBB7@oracle.com>
References: <20190226075722.1692315-1-haakon.bugge@oracle.com>
         <174ccd37a9ffa05d0c7c03fe80ff7170a9270824.camel@redhat.com>
         <67B4F337-4C3A-4193-B1EF-42FD4765CBB7@oracle.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+O8VTt/oRz42SjEM1nOO"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Jun 2019 20:25:23 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-+O8VTt/oRz42SjEM1nOO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-13 at 18:58 +0200, H=C3=A5kon Bugge wrote:
> > On 13 Jun 2019, at 16:25, Doug Ledford <dledford@redhat.com> wrote:
> >=20
> > On Tue, 2019-02-26 at 08:57 +0100, H=C3=A5kon Bugge wrote:
> > > During certain workloads, the default CM response timeout is too
> > > short, leading to excessive retries. Hence, make it configurable
> > > through sysctl. While at it, also make number of CM retries
> > > configurable.
> > >=20
> > > The defaults are not changed.
> > >=20
> > > Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> > > ---
> > > v1 -> v2:
> > >   * Added unregister_net_sysctl_table() in cma_cleanup()
> > > ---
> > > drivers/infiniband/core/cma.c | 52
> > > ++++++++++++++++++++++++++++++---
> > > --
> > > 1 file changed, 45 insertions(+), 7 deletions(-)
> >=20
> > This has been sitting on patchworks since forever.  Presumably
> > because
> > Jason and I neither one felt like we really wanted it, but also
> > couldn't justify flat refusing it.
>=20
> I thought the agreement was to use NL and iproute2. But I haven't had
> the capacity.

To be fair, the email thread was gone from my linux-rdma folder.  So, I
just had to review the entry in patchworks, and there was no captured
discussion there.  So, if the agreement was made, it must have been
face to face some time and if I was involed, I had certainly forgotten
by now.  But I still needed to clean up patchworks, hence my email ;-).

> >  Well, I've made up my mind, so
> > unless Jason wants to argue the other side, I'm rejecting this
> > patch.=20
> > Here's why.  The whole concept of a timeout is to help recovery in
> > a
> > situation that overloads one end of the connection.  There is a
> > relationship between the max queue backlog on the one host and the
> > timeout on the other host. =20
>=20
> If you refer to the backlog parameter in rdma_listen(), I cannot see
> it being used at all for IB.

No, not exactly.  I was more referring to heavy load causing an
overflow in the mad packet receive processing.  We have
IB_MAD_QP_RECV_SIZE set to 512 by default, but it can be changed at
module load time of the ib_core module and that represents the maximum
number of backlogged mad packets we can have waiting to be processed
before we just drop them on the floor.  There can be other places to
drop them too, but this is the one I was referring to.

> For CX-3, which is paravirtualized wrt. MAD packets, it is the proxy
> UD receive queue length for the PF driver that can be construed as a
> backlog. Remember that any MAD packet being sent from a VF or the PF
> itself, is sent to a proxy UD QP in the PF. Those packets are then
> multiplexed out on the real QP0/1. Incoming MAD packets are
> demultiplexed and sent once more to the proxy QP in the VF.
>=20
> > Generally, in order for a request to get
> > dropped and us to need to retransmit, the queue must already have a
> > full backlog.  So, how long does it take a heavily loaded system to
> > process a full backlog?  That, plus a fuzz for a margin of error,
> > should be our timeout.  We shouldn't be asking users to configure
> > it.
>=20
> Customer configures #VMs and different workload may lead to way
> different number of CM connections. The proxying of MAD packet
> through the PF driver has a finite packet rate. With 64 VMs, 10.000
> QPs on each, all going down due to a switch failing or similar, you
> have 640.000 DREQs to be sent, and with the finite packet rate of MA
> packets through the PF, this takes more than the current CM timeout.
> And then you re-transmit and increase the burden of the PF proxying.
>=20
> So, we can change the default to cope with this. But, a MAD packet is
> unreliable, we may have transient loss. In this case, we want a short
> timeout.
>=20
> > However, if users change the default backlog queue on their
> > systems,
> > *then* it would make sense to have the users also change the
> > timeout
> > here, but I think guidance would be helpful.
> >=20
> > So, to revive this patch, what I'd like to see is some attempt to
> > actually quantify a reasonable timeout for the default backlog
> > depth,
> > then the patch should actually change the default to that
> > reasonable
> > timeout, and then put in the ability to adjust the timeout with
> > some
> > sort of doc guidance on how to calculate a reasonable timeout based
> > on
> > configured backlog depth.
>=20
> I can agree to this :-)
>=20
>=20
> Thxs, H=C3=A5kon
>=20
> > --=20
> > Doug Ledford <dledford@redhat.com>
> >    GPG KeyID: B826A3330E572FDD
> >    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
> > 2FDD

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-+O8VTt/oRz42SjEM1nOO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0CsSsACgkQuCajMw5X
L93Qnw//XiMtlCbAK0cVmGzfaTsPIhjBTzMbZp1TJB7HxlKPGgxvIkHXmZhDdqXG
Gtm9ttKv7bmHAf0All8L9F/ZStpG4vAE3OrG0xY6c6Ru+5O9bSLIs6gMrUcj5aFH
uKRYaIS75kvPsWD4hITaWws+mIxW/0mkn90Jz4b+aNzMfu9CrDXhASzcZtJj6UGQ
IzHabjAzxSqqLuXwPPYyams8dBceOj8e3rmgD+k1DHV9NTlPT3wKB7oJjfvLJHRh
2OPKBuf3u3d36s/P6dOCh6Tqg+EYrlZIP+mAR0dKXiV9xUwwQmqYINmLTMdpKny9
j8VM8QUPWm01g60BLAB4BZszlBOW1Oi1FwN90JjfDxMB1TBlLANkX0TOz3KaCtLS
BfUEeXzfufsN7plPHko+wHmrkmLdcwc5/9RYTJt0e+8okw8mW2VllINuHixow5Iz
l74f+aKDsnqBqjwNgXSf+f1E35KYzz58/MJfOSeRZojGCYMXjWD61NlbN8+KsCvY
Gp06TuAwzSUijm1NxfyQ7pDf+jZq6P+10k5I0nNCD7XiKIopbqpN5voFvZwRtPXo
8ilP89CQ7jIKtlVcXXVS7gE3AmdzobyDPh6EAZpXXXn0OqqLCPOpMiinhD8ZFJlM
IQdJgNUeG1PZi2ZE6y18wzghvL9RbP7Pi/1/8OgbxnAdThz3xKU=
=clAS
-----END PGP SIGNATURE-----

--=-+O8VTt/oRz42SjEM1nOO--

