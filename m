Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA1014F81
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfEFPMH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:12:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfEFPMH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 11:12:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA72588302;
        Mon,  6 May 2019 15:12:06 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-3.rdu2.redhat.com [10.10.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EDD318945;
        Mon,  6 May 2019 15:12:05 +0000 (UTC)
Message-ID: <580150427022440ab0475cda91d666322ef7e055.camel@redhat.com>
Subject: Re: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
From:   Doug Ledford <dledford@redhat.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "Tejun Heo (tj@kernel.org)" <tj@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Date:   Mon, 06 May 2019 11:11:58 -0400
In-Reply-To: <32E1700B9017364D9B60AED9960492BC70D3737D@fmsmsx120.amr.corp.intel.com>
References: <20190318165205.23550.97894.stgit@scvm10.sc.intel.com>
         <20190318165501.23550.24989.stgit@scvm10.sc.intel.com>
         <20190319192737.GB3773@ziepe.ca>
         <32E1700B9017364D9B60AED9960492BC70CD9227@fmsmsx120.amr.corp.intel.com>
         <20190327152517.GD69236@devbig004.ftw2.facebook.com>
         <20190327171611.GF21008@ziepe.ca>
         <20190327190720.GE69236@devbig004.ftw2.facebook.com>
         <20190327194347.GH21008@ziepe.ca>
         <20190327212502.GF69236@devbig004.ftw2.facebook.com>
         <053009d7de76f8800304f354e3cbde068453257f.camel@redhat.com>
         <32E1700B9017364D9B60AED9960492BC70D3737D@fmsmsx120.amr.corp.intel.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-k2jOauPSrgo/nuoxu8SQ"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 06 May 2019 15:12:06 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-k2jOauPSrgo/nuoxu8SQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-05-06 at 12:31 +0000, Marciniszyn, Mike wrote:
> > Correct me if I'm wrong Tejun, but the key issues are:
> >=20
> > All WQ_MEM_RECLAIM work queues are eligible to be run when the
> > machine
> > is under extreme memory pressure and attempting to reclaim memory.  Tha=
t
> > means that the workqueue:
> >=20
> > 1) MUST not perform any GFP_ATOMIC allocations as this could deadlock
>=20
> The send engine code WILL do a GFP_ATOMIC allocation but the code handles=
 failure as
> will any other resource shortage.

You're right.  I was misremembering the flag's full meaning (I double
checked before writing this).  If you are holding a spinlock (or
anything else that means you can't sleep), you must use GFP_ATOMIC and
you must be prepared for failure.  So, before putting WQ_MEM_RECLAIM on
your workqueue, it should use ATOMIC and be prepared for failure.

> > 2) SHOULD not rely on any GFP_KERNEL allocations as these may fail
>=20
> There are no GFP_KERNEL allocations in the send engine code.

Right.

> > 3) MUST complete without blocking
>=20
> All resource blockages are handled by queuing the current QP being servic=
ed by
> the send engine for and interrupt to wake that QP up via the send engine.

Ok.

> > 4) SHOULD ideally always make some sort of forward progress if at all
> > possible without needing memory allocations to do so
> >=20
>=20
> As noted above.

Right.

> > Mike, does hfi1_do_send() meet these requirements?  If not, we should
> > not be putting WQ_MEM_RECLAIM on it, and instead should find another
> > solution to the current trace issue.
> >=20
>=20
> I'm not sure I understand the 1) above.
>=20
> Tejun, can you elaborate?

My mistake.  It's been a long while since I coded the stuff I did for
memory reclaim pressure and I had my flag usage wrong in my memory.=20
=46rom the description you just gave, the original patch to add
WQ_MEM_RECLAIM is ok.  I probably still need to audit the ipoib usage
though.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-k2jOauPSrgo/nuoxu8SQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzQTr4ACgkQuCajMw5X
L90Yfg/+JItvb6CiBqK0QJ3aaStsPgmPt6T6DXmQbdQO9VjTF/og66t3E3h69vn8
9+XTLWVz4DFegqvUg8aUmymYkbwaZIPAMFGJdJF8NfAPunsN7zNPrU+HmlFRsFLw
jdae45wCONZne1js/A8cv0/yKqNjlVrLH/PuMyw/sLRUjD8ucCwS63N5OCPk2Ftc
GkMuJVUebs5u5bn4Q1g0NKu0tpS8xM/t9VNTgIgDT7qM10wNvFCYWANv+rdjxp42
p7nocsvRl6IS4Ro63B2+r8yjtiWB962fbUbPkkeka0vJwsz8T7B3t8v2HyXqDY7S
0cutoQisGOZ41aEdBwL5tpF7c+Dfi+v48exVjrD2Q/w11vdv5GuenIJryOPSdoix
6CEkEkGcUl0t0uTkB3nN9laAJnPNnLWRAPklc43vDa9ymCy1y2R1RiTWqyt56UXu
UGSGOVk8IgwENLTVOb2k9i2lJG1Sc12qdgEtlGnva8bYEfzS3J1eA1LKKCs6L/+P
s8+UMqoUtr5z50kuuHr9y1oXc/o2sXyjtUYVfhXMbHeplBi2r5o+loxREaKjsJub
RvBvlZY/4X76qSBwqaXZLvaCRwsF+qRmyqLZqM0NOo8aUnR18DNgOwaYviVAWGJk
WPqQw1/6aRMPxzBWl0HDdnPr8k1087sxmcGgbjixChPNfXO7YFY=
=6D4X
-----END PGP SIGNATURE-----

--=-k2jOauPSrgo/nuoxu8SQ--

