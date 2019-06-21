Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CA24F0E2
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Jun 2019 00:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfFUWzb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 18:55:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfFUWzb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Jun 2019 18:55:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DBF9630821C0;
        Fri, 21 Jun 2019 22:55:29 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F776604CC;
        Fri, 21 Jun 2019 22:55:29 +0000 (UTC)
Message-ID: <2c11cb3904c0a19e842e411e40c7b1e22df8210c.camel@redhat.com>
Subject: Re: [PATCH v3 00/11] SIW: Software iWarp RDMA (siw) driver
From:   Doug Ledford <dledford@redhat.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Date:   Fri, 21 Jun 2019 18:55:26 -0400
In-Reply-To: <20190620162133.13074-1-bmt@zurich.ibm.com>
References: <20190620162133.13074-1-bmt@zurich.ibm.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hjT6+vxEX2kztg7m3wn1"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 21 Jun 2019 22:55:30 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-hjT6+vxEX2kztg7m3wn1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-20 at 18:21 +0200, Bernard Metzler wrote:
> This patch set contributes the SoftiWarp driver rebased for
> latest rdma-next. SoftiWarp (siw) implements the iWarp RDMA
> protocol over kernel TCP sockets. The driver integrates with
> the linux-rdma framework.
>=20
> A matching userlevel driver is available as PR at
> https://github.com/linux-rdma/rdma-core/pull/536
>=20
> Many thanks for reviewing and testing the driver, especially to Leon,
> Jason, Steve, Doug, Olga, Dennis, Gal. You all helped to significantly
> improve the driver over the last year.
>=20
> Please find below a list of changes and comments, compared to older
> versions of the siw driver.
>=20
> Many thanks!
> Bernard.


This, modulo moving the two defines to a private header, has been pulled
into for-next.  Thanks!

>=20
> CHANGES:
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> v3 (this version)
> -----------------
>=20
> - Rebased to rdma-next
>=20
> - Removed unneccessary initialization of enums in siw-abi.h
>=20
> - Added comment on sizing of all work queues to power of two.
>=20
>=20
> v2
> -----------------
>=20
> - Changed recieve path CRC calculation to compute CRC32c not
>   on target buffer after placement, but on original skbuf.
>   This change severely hurts performance, if CRC is switched
>   on, since skb must now be walked twice. It is planned to
>   work on an extension to skb_copy_bits() to fold in CRC
>   computation.
>=20
> - Moved debugging to using ibdev_dbg().
>=20
> - Dropped detailed packet debug printing.
>=20
> - Removed siw_debug.[ch] files.
>=20
> - Removed resource tracking, code now relies on restrack of
>   RDMA midlayer. Only object counting to enforce reported
>   device limits is left in place.
>=20
> - Removed all nested switch-case statements.
>=20
> - Cleaned up header file #include's
>=20
> - Moved CQ create/destroy to new semantics,
>   where midlayer creates/destroys containing object.
>=20
> - Set siw's ABI version to 1 (was 0 before)
>=20
> - Removed all enum initialization where not needed.
>=20
> - Fixed MAINTANERS entry for siw driver
>=20
> - This version stays with the current siw specific
>   management of user memory (siw_umem_get() vs.
>   ib_umem_get(), etc.). This, since the current ib_umem
>   implementation is less efficient for user page lookup
>   on the fast path, where effciency is important for a
>   SW RDMA driver.=20
>   It is planned to contribute enhancements to the ib_umem
>   framework, wich makes it suitable for SW drivers as well.
>=20
>=20
> v1 (first version after v9 of siw RFC)
> --------------------------------------
>=20
> - Rebased to 5.2-rc1
>=20
> - All IDR code got removed.
>=20
> - Both MR and QP deallocation verbs now synchronously
>   free the resources referenced by the RDMA mid-layer.
>=20
> - IPv6 support was added.
>=20
> - For compatibility with Chelsio iWarp hardware, the RX
>   path was slightly reworked. It now allows packet intersection
>   between tagged and untagged RDMAP operations. While not
>   a defined behavior as of IETF RFC 5040/5041, some RDMA hardware
>   may intersect an ongoing outbound (large) tagged message, such
>   as an multisegment RDMA Read Response with sending an untagged
>   message, such as an RDMA Send frame. This behavior was only
>   detected in an NVMeF setup, where siw was used at target side,
>   and RDMA hardware at client side (during file write). siw now
>   implements two input paths for tagged and untagged messages each,
>   and allows the intersected placement of both messages.
>=20
> - The siw kernel abi file got renamed from siw_user.h to siw-abi.h.
>=20
> Bernard Metzler (11):
>   iWarp wire packet format
>   SIW main include file
>   SIW network and RDMA core interface
>   SIW connection management
>   SIW application interface
>   SIW application buffer management
>   SIW queue pair methods
>   SIW transmit path
>   SIW receive path
>   SIW completion queue methods
>   SIW addition to kernel build environment
>=20
>  MAINTAINERS                              |    7 +
>  drivers/infiniband/Kconfig               |    1 +
>  drivers/infiniband/sw/Makefile           |    1 +
>  drivers/infiniband/sw/siw/Kconfig        |   17 +
>  drivers/infiniband/sw/siw/Makefile       |   11 +
>  drivers/infiniband/sw/siw/iwarp.h        |  380 ++++
>  drivers/infiniband/sw/siw/siw.h          |  745 ++++++++
>  drivers/infiniband/sw/siw/siw_cm.c       | 2072
> ++++++++++++++++++++++
>  drivers/infiniband/sw/siw/siw_cm.h       |  133 ++
>  drivers/infiniband/sw/siw/siw_cq.c       |  101 ++
>  drivers/infiniband/sw/siw/siw_main.c     |  687 +++++++
>  drivers/infiniband/sw/siw/siw_mem.c      |  460 +++++
>  drivers/infiniband/sw/siw/siw_mem.h      |   74 +
>  drivers/infiniband/sw/siw/siw_qp.c       | 1322 ++++++++++++++
>  drivers/infiniband/sw/siw/siw_qp_rx.c    | 1455 +++++++++++++++
>  drivers/infiniband/sw/siw/siw_qp_tx.c    | 1268 +++++++++++++
>  drivers/infiniband/sw/siw/siw_verbs.c    | 1760 ++++++++++++++++++
>  drivers/infiniband/sw/siw/siw_verbs.h    |   91 +
>  include/uapi/rdma/rdma_user_ioctl_cmds.h |    1 +
>  include/uapi/rdma/siw-abi.h              |  185 ++
>  20 files changed, 10771 insertions(+)
>  create mode 100644 drivers/infiniband/sw/siw/Kconfig
>  create mode 100644 drivers/infiniband/sw/siw/Makefile
>  create mode 100644 drivers/infiniband/sw/siw/iwarp.h
>  create mode 100644 drivers/infiniband/sw/siw/siw.h
>  create mode 100644 drivers/infiniband/sw/siw/siw_cm.c
>  create mode 100644 drivers/infiniband/sw/siw/siw_cm.h
>  create mode 100644 drivers/infiniband/sw/siw/siw_cq.c
>  create mode 100644 drivers/infiniband/sw/siw/siw_main.c
>  create mode 100644 drivers/infiniband/sw/siw/siw_mem.c
>  create mode 100644 drivers/infiniband/sw/siw/siw_mem.h
>  create mode 100644 drivers/infiniband/sw/siw/siw_qp.c
>  create mode 100644 drivers/infiniband/sw/siw/siw_qp_rx.c
>  create mode 100644 drivers/infiniband/sw/siw/siw_qp_tx.c
>  create mode 100644 drivers/infiniband/sw/siw/siw_verbs.c
>  create mode 100644 drivers/infiniband/sw/siw/siw_verbs.h
>  create mode 100644 include/uapi/rdma/siw-abi.h
>=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-hjT6+vxEX2kztg7m3wn1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0NYF4ACgkQuCajMw5X
L92D1RAAi2DlBp/GFiFjCXVduldlAMRq8Ozc7dzLhHqhtvz+pNOaguthzsUQakyC
m74LaxDKBnmkreYqjM3J7W31qaojogGrUhKBoTZvAmqNFggUpHirM0GJ1AUu7OpI
9guYDqhEsaXmvS7n55i0eZ5CyQ3ue2+kYJPje9ISdgV7vKw8lJ9tJ5fZf4JNljrd
4H9ihPVOkSN/P9VRQW6sYnc/QmegFDbzQ1YAUvAMxLVaSsKfuzQU+PTPXg5vRMNq
4yCvvZoAcV9icJ6P2DV1wsbyg7E+zJMvAredXXoh7DiRFXzANv/eHL/3L6yxDvGh
n4zv2nHNfyMTCLUWlILDZqmWHE1tM96FsSW5DLmGczysbLSaTn6GNWayxKfLHxvj
34w93MYnIlP4x7Zze0kAAgPEyEOKB49dRAZ73M4heA2tUbHvIxQy75spOPRlw8y3
jglGkRMWoSR2zLC1yFYxmFO+NY69RWLeIX4pdip8+9zlI2UPXv3CviQJnOJ7GC0H
rtMXMb5dFu+1ws2mJVbEo6OP9Z4g3rbmRd139ffm0ozsmraiN8oa7fKPU32fxRNG
V/zeVng6hpm5/KZF4M3VXLJ69FcOJJOQHU2eZdtm3i6xAHFxR5vIzbmHadUeD/kt
1M7yOdDSsKlYTc4S0uV8kYJ69YwNRSMu0vBzz12bNcqujl8v1tw=
=R23S
-----END PGP SIGNATURE-----

--=-hjT6+vxEX2kztg7m3wn1--

