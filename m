Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D45E110956
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 16:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfEAOof (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 10:44:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbfEAOoe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 10:44:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AB04C05001C;
        Wed,  1 May 2019 14:44:34 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 634B1795BA;
        Wed,  1 May 2019 14:44:33 +0000 (UTC)
Message-ID: <053009d7de76f8800304f354e3cbde068453257f.camel@redhat.com>
Subject: Re: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
From:   Doug Ledford <dledford@redhat.com>
To:     "Tejun Heo (tj@kernel.org)" <tj@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Date:   Wed, 01 May 2019 10:44:31 -0400
In-Reply-To: <20190327212502.GF69236@devbig004.ftw2.facebook.com>
References: <20190318165205.23550.97894.stgit@scvm10.sc.intel.com>
         <20190318165501.23550.24989.stgit@scvm10.sc.intel.com>
         <20190319192737.GB3773@ziepe.ca>
         <32E1700B9017364D9B60AED9960492BC70CD9227@fmsmsx120.amr.corp.intel.com>
         <20190327152517.GD69236@devbig004.ftw2.facebook.com>
         <20190327171611.GF21008@ziepe.ca>
         <20190327190720.GE69236@devbig004.ftw2.facebook.com>
         <20190327194347.GH21008@ziepe.ca>
         <20190327212502.GF69236@devbig004.ftw2.facebook.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-W3B0OcwnC1UvGodrBicI"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 01 May 2019 14:44:34 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-W3B0OcwnC1UvGodrBicI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-03-27 at 14:25 -0700, Tejun Heo (tj@kernel.org) wrote:
> Hello,
>=20
> On Wed, Mar 27, 2019 at 04:43:47PM -0300, Jason Gunthorpe wrote:
> > Well, at least I'm not super familiar with the block layer and
> > wouldn't know about this..=20
>=20
> Yeah, conceptually it's not complex.  Filesytem and IOs are needed to
> reclaim memory because we need to write back dirty pagecache and swap
> pages before reuse them for other purposes.  Recursing on oneself
> obviously won't be great, so filesystems need to use GFP_NOFS and
> block layer below that needs to use GFP_NOIO.
>=20
> It's kinda unfortunate that network devices end up being pushed into
> this dependency chain but we do put them in memory reclaim path w/ nfs
> and block-over-network things, so it is what it is, I suppose.

The discussion is helpful, but we still need to decide on the patch:

Correct me if I'm wrong Tejun, but the key issues are:

All WQ_MEM_RECLAIM work queues are eligible to be run when the machine
is under extreme memory pressure and attempting to reclaim memory.  That
means that the workqueue:

1) MUST not perform any GFP_ATOMIC allocations as this could deadlock
2) SHOULD not rely on any GFP_KERNEL allocations as these may fail
3) MUST complete without blocking
4) SHOULD ideally always make some sort of forward progress if at all
possible without needing memory allocations to do so

Mike, does hfi1_do_send() meet these requirements?  If not, we should
not be putting WQ_MEM_RECLAIM on it, and instead should find another
solution to the current trace issue.

> > But your explanation is helpful. I will be watching for WQ_MEM_RECLAIM
> > users that are allocating memory in their work functions.
> >=20
> > Would it be possible to have a lockdep-like debugging under kmalloc
> > similar to check_flush_dependency() that complains if a WQ_MEM_RECLAIM
> > work is doing inappropriate allocations?
> >=20
> > That would help discourage using it in WQ's it shouldn't be used on.
>=20
> Yeah, I was wondering whether that'd trigger warning.  I don't think
> it does now.  I fully agree it'd be great to have.
>=20
> Thanks.
>=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-W3B0OcwnC1UvGodrBicI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzJsM8ACgkQuCajMw5X
L91m0A//Z50j2AFTmJd54kjHGrDj42aLi/YJqJ6neeOuu/2EGLJmMckSGFPGEraA
+ST1ccRZfb1s3nwvxPvkEWEtT7ZjvgKPPkN3tIr96bbPv2Jix/Q04tN84wRneo3X
KaalU/3khapzycs4wfarJ4xXlaXsbuRmSwFUWuv8yhDlyIFuIZfwoaErKLu05pDX
x5syrWLBzKkTEbtSNXqmpnCfIBCsx/iRMWgqfka+ZdGvh5MHp8Fzj6HsNCMRJkhF
7r/PDq80i81W7OjZK3i2NuQ4Hmrd799w6PoDVfDyRYMeCtZqmVFWY69NxVkwrENV
l+WCLSOyAt3s6aqtLJiEqbc6gdq5KZ5AFdZrEhgj4CpD1zRuL0Z5eJr8Munw1SsD
4HI38Pto4urCRv1q5AcftCvMgJO6NZTlMXqwmfH9LnfgSrYQOoVWaZSqzi2dLEaA
Klw/RU4QbiK3K9lNz/K8PXtlqhVu3EtXULscQDwDskMzyD27gFnJbfP4GIUm4Nw3
Byfv9Jk2a6t55Fkm3Yu1O5VOi4VojnAbqIgog0zznC1RFSSGFlL7qJv+Cu9rhwn1
nmdFz1zJ2uTO8XQ+3kMendtVUKMbUAT8Ch5inFwb3w0XSlqqUDpCPCGarGCBR/Jy
NsZiFslb4Ka0bn1YRJAtfbCJdNYI/9owEJqG1159lorMZQ5MyQw=
=zNbg
-----END PGP SIGNATURE-----

--=-W3B0OcwnC1UvGodrBicI--

