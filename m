Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608594969C
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 03:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfFRBTx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 21:19:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfFRBTx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jun 2019 21:19:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E35BE308FE8D;
        Tue, 18 Jun 2019 01:19:52 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DB712C16A;
        Tue, 18 Jun 2019 01:19:52 +0000 (UTC)
Message-ID: <4e80e6631acb78b1cb615dc322f87cc11f48f385.camel@redhat.com>
Subject: Re: [PATCH for-rc 0/7] IB/hfi1: Fix a stuck qp problem
From:   Doug Ledford <dledford@redhat.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 17 Jun 2019 21:19:49 -0400
In-Reply-To: <20190614163146.44927.95985.stgit@awfm-01.aw.intel.com>
References: <20190614163146.44927.95985.stgit@awfm-01.aw.intel.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5Znhzmh/TlAWaPWNk7AL"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 18 Jun 2019 01:19:52 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-5Znhzmh/TlAWaPWNk7AL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-06-14 at 12:32 -0400, Dennis Dalessandro wrote:
> This series fixes a problem we encountered with a QP getting stuck.
> It is a bit
> bigger than we probably want for RC so I'm fine applying this to for-
> next
> instead especially this late in the game for 5.2.
> ---
>=20
> Mike Marciniszyn (7):
>       IB/hfi1: Avoid hardlockup with flushlist_lock
>       IB/hfi1: Silence txreq allocation warnings
>       IB/hfi1: Create inline to get extended headers
>       IB/hfi1: Use aborts to trigger RC throttling
>       IB/hfi1: Wakeup QPs orphaned on wait list after flush
>       IB/hfi1: Handle wakeup of orphaned QPs for pio
>       IB/hfi1: Handle port down properly in pio
>=20

Hi Denny,

These all look reasonably sane.  Their big for a late rc, but they fix
scale issues, not your typical one line typo bug, and those often are
bigger fixes.  I'm comfortable arguing for these.  So, assuming my
build test that's underway completes, applied to for-rc.  Thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-5Znhzmh/TlAWaPWNk7AL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0IPDUACgkQuCajMw5X
L93KiA//V/t9LgcA9t+kQYvLykt+kj//cFOCeu1IrVCD0ps8adTH00Nj5uFWQUlz
mcdRLfS1kvWNk1v53gWTiDbY9EUR55iQxHDhnu8jU0FvCYlHaXJq3jjqrz47Sy4l
Gqtl3aamRMHo8AFaV7s+swX+95K24ltsRRqa3pkbHOzSw85Roma13CUWl4z2QeJl
heKADddn9k1aVABMgFa6DzvqRJu9/ZGfBLGUjXgxHDCAbXO5eczF3QWRWYdPyFh1
gqpG4bytV7FJuF0ZKZNtRGJvfvCXMfnVfE7E8UFQ4KBsRj4XzRS0XClIMrYMI02c
iO1huBtdjjOaeM83rRLCIn4xKWrhsz5/rEBY6H4lVp4NqwNR8+b+BSNPN9plzwPP
Nun6/J5qvO6hzi1MOy84MP04zG0LZITW0nv3VOQ4tRR7H7FPCfrDnJBIIp0BsCPn
SIHxGQy8iOzKQvhkGfoq260JrlSOd834l9TlpLe1100/lh8KNcJcQf3crqV0jZUF
qIfEqYQHqYfKzeBkVISHTpge7zNDDKhhHjd68T3Vc3ZUWmYTJumwiKRKDkuyvzZB
0fwIOSoeIPqmeuSKMGaGgeTtm7OiMl1bQkLw4VXmnBI8WMeJ4jzNPVzCkirdyNzr
Gi2xrOKHvC4/BHMKc9sGHEgl7SL/QgdwxzQlSs129nSJ2R22TbI=
=Hxe1
-----END PGP SIGNATURE-----

--=-5Znhzmh/TlAWaPWNk7AL--

