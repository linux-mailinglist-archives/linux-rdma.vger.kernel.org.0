Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3AC109EA
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 17:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEAPVR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 11:21:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfEAPVR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 11:21:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0EC08666E;
        Wed,  1 May 2019 15:21:16 +0000 (UTC)
Received: from [172.31.1.7] (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 843EF62AF8;
        Wed,  1 May 2019 15:21:15 +0000 (UTC)
From:   Doug Ledford <dledford@redhat.com>
Message-Id: <4A4820DA-474E-437F-B3D3-56EAA31ED58D@redhat.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0D3CF026-EA97-4DBE-AA86-5A5A44F91A99";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Date:   Wed, 1 May 2019 11:21:08 -0400
In-Reply-To: <20190327170213.GD22899@mtr-leonro.mtl.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
References: <20190318165205.23550.97894.stgit@scvm10.sc.intel.com>
 <20190318165501.23550.24989.stgit@scvm10.sc.intel.com>
 <20190319192737.GB3773@ziepe.ca>
 <32E1700B9017364D9B60AED9960492BC70CD9227@fmsmsx120.amr.corp.intel.com>
 <20190327152517.GD69236@devbig004.ftw2.facebook.com>
 <20190327170213.GD22899@mtr-leonro.mtl.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 01 May 2019 15:21:17 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--Apple-Mail=_0D3CF026-EA97-4DBE-AA86-5A5A44F91A99
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Mar 27, 2019, at 1:02 PM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Wed, Mar 27, 2019 at 08:25:17AM -0700, Tejun Heo (tj@kernel.org) =
wrote:
>> Hello,
>>=20
>> On Tue, Mar 26, 2019 at 08:55:09PM +0000, Marciniszyn, Mike wrote:
>>> The latter is the ipoib wq that conflicts with our =
non-WQ_MEM_RECLAIM.  This seems excessive and pretty gratuitous.
>>>=20
>>> Tejun, what does "mem reclaim" really mean and when should it be =
used?
>>=20
>> That it may be depended during memory reclaim.
>>=20
>>> I was assuming that since we are freeing QP kernel memory held by =
user mode programs that could be oom killed, we need the flag.
>>=20
>> If it can't block memory reclaim, it doesn't need the flag.  Just in
>> case, if a workqueue is used to issue block IOs, it is depended upon
>> for memory reclaim as writeback and swap-outs are critical parts of
>> memory reclaim.
>=20
> It looks like WQ_MEM_RECLAIM is needed for IPoIB, because if NFS runs
> over IPoIB, it will do those types of IOs.

Because of what IPoIB does, you=E2=80=99re right that it=E2=80=99s =
needed.  However, it might be necessary to audit the wq usage in IPoIB =
to make sure it=E2=80=99s actually eligible for the flag and that it =
hasn=E2=80=99t been set when the code doesn=E2=80=99t meet the =
requirements of the flag.

> Thanks
>=20
>>=20
>> Thanks.
>>=20
>> --
>> tejun

--
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 =
2FDD








--Apple-Mail=_0D3CF026-EA97-4DBE-AA86-5A5A44F91A99
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzJuWQACgkQuCajMw5X
L92rVxAAh+axOou9YbGIU/aLBFHJq2VvlH3689GLxVrCz3aFgelywPJA1G+LJ2f/
yy+f2EXAdAuB650ruGfIjM+grffNi6UkZOhZuC/QVK6np+5udvzcr4QxOSeYAmg4
j7n0m2XTbQ0eHpAF2zDyfEQGLUibOEpt7Kp4Dvoeth4umh4yqKedZD8T7lnfF3Er
eG9ji6PMm4huq+h+4AhCV1SdgndbEOYe2x6TLI0TYo7mAAc7rXNFD/LJgHPe+Tau
xGry60NLIqg6CUhRUtv2ZWDpCcqo16VYyPAXTbbhDGD/nXKYBY9vnOE6FnqibLMC
aJ9aYJKX/UDuvN1yUJKCyduHAES0i5NTOPzL4PzRvfH6xBBIK/jc1PPQNVRVxhqS
UzWbtS+mRTud5ICd+f3R5L3rxU4aqt89aK8gQc3XJkfCLZn5w/AxfkvESThlP1HT
7FTh54RHGvXRYVNJ40n0DTPWtLkBr2X6GXxC2xlfLRUU6LvLcG/S4h+043YFD/pn
QfgX3YCuLvP+7RQN7reapG9ChQf0s52NcNm+Bt1kkieTZhwJinfmWKK3ktvrG1fv
DqjKOaJ06iJrz8oO8pw70wa0kugVP9CjPF0/0QTFAZGlQ5q+pb8Bf+iJWSh25uZc
37ySdmJiM+bBUmV/ONfTUY38GRoWSB/qRBSVXHGzUpl2tYLa1IA=
=LH4U
-----END PGP SIGNATURE-----

--Apple-Mail=_0D3CF026-EA97-4DBE-AA86-5A5A44F91A99--
