Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F091120BA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2019 01:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLDAq6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Dec 2019 19:46:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41092 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726363AbfLDAq6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Dec 2019 19:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575420416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GceTS82+ABp5UMcB3pFW+QsszdQ5RDgLTM9xkTSQUU8=;
        b=V1nCZKLaTkYxC+SvgiavBXR747v74ET0ar2OB9jkt9WyVTik9S9PfKrK6x3BkEuFle3cm2
        gB4sEMh458rw+RkIAohpfHoAtBER+acV0iZi3M3cgQVaAJvj8IVz32MAi1DxiZ51XxLL+S
        B+eY5xf/N+a5wHQySmAmN0hS+YBpc0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-VJSTEIt0N4C3GbWCDHsgGg-1; Tue, 03 Dec 2019 19:46:52 -0500
X-MC-Unique: VJSTEIt0N4C3GbWCDHsgGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A41351B18BC1;
        Wed,  4 Dec 2019 00:46:51 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-22.rdu2.redhat.com [10.10.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49EDF67E5D;
        Wed,  4 Dec 2019 00:46:50 +0000 (UTC)
Message-ID: <0f8d9087c48e986d08cf85ef8b59bdca25425eaa.camel@redhat.com>
Subject: Re: [PATCH 2/2] rxe: correctly calculate iCRC for unaligned payloads
From:   Doug Ledford <dledford@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Steve Wise <larrystevenwise@gmail.com>,
        linux-rdma@vger.kernel.org, 3100102071@zju.edu.cn, leon@kernel.org
Date:   Tue, 03 Dec 2019 19:46:47 -0500
In-Reply-To: <a0003c88-10f5-c14a-220d-c100fa160163@acm.org>
References: <20191203020319.15036-1-larrystevenwise@gmail.com>
         <20191203020319.15036-2-larrystevenwise@gmail.com>
         <a0003c88-10f5-c14a-220d-c100fa160163@acm.org>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-VSnKJdS6jzSWZDm2nTnO"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-VSnKJdS6jzSWZDm2nTnO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-12-03 at 08:25 -0800, Bart Van Assche wrote:
> On 12/2/19 6:03 PM, Steve Wise wrote:
> > If RoCE PDUs being sent or received contain pad bytes, then the iCRC
> > is miscalculated resulting PDUs being emitted by RXE with an
> > incorrect
> > iCRC, as well as ingress PDUs being dropped due to erroneously
> > detecting
> > a bad iCRC in the PDU.  The fix is to include the pad bytes, if any,
> > in iCRC computations.
>=20
> Should this description mention that this patch breaks compatibility=20
> with SoftRoCE drivers that do not include this fix? Do we need a
> kernel=20
> module parameter that allows to select either the old or the new
> behavior?

No.  The original soft-RoCE driver was supposed to be compatible with
hardware devices.  Because of this bug, it obviously wasn't.  This is a
bug fix, and we do not need to do anything to be compatible with the
broken behavior.  Instead, it just needs noting that the soft-RoCE
implementation in prior kernels has a known wire format bug that impacts
communications with both fixed versions of the driver and real hardware
devices.

> > CC: bvanassche@acm.org,3100102071@zju.edu.cn,leon@kernel.org
>=20
> Should this Cc-line perhaps be converted into three Cc-lines?
>=20
> Otherwise this patch looks fine to me.
>=20
> Thanks,
>=20
> Bart.
>=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-VSnKJdS6jzSWZDm2nTnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl3nAfcACgkQuCajMw5X
L92E4A//S6btyqF/HI95ysw9vFjo2bjEOfPYbKaASTDKcN/pXBYgwukaUMiN8Sjy
TrX8jjN6qSI8yuOLvRQjEIXQpwqKQbK70siBTVnBwMmMes0l+NNDB/uvaz6OQu9o
P0K4/GpXAC1YQM8s5st9bSO7LBIWep/efw+A9DMWKfae1otsvYrcAG04Pu3PPWkS
0vGkS3SxwT/SBkIely7t0MEuNUlA6sUa8lmPHL7aztbJ5aptAMZKQOEg6DWwRGHE
SYUtE/GDXFlg8yEfev7jbMGZzTd1T5lQEgEm/NoQrHCxYG63EvZpzbURecAfcfJL
6N5zvtOt8iCriJZIv0YB+geKw5tj2WNP4M/hb250Rsg6+4amZ9p1p59EBbEOgIgn
Slt2ULEEHoxlm+/10tMfP53OQmWbfBweEqi98HP0OO/vT2Tp0Aaw348fgfiFOI3/
QWBtxHfUUzB+61p46DBZbiVELgL1bdOVJJR752nNEEmpQUycYu0di9AEk42b9EP7
yviAhIfywgQHE5/ebbCpCNkTsjUWuHRgkeHH0TdSSOMIxOWRJrQ/Y5ZdoRE2WVqz
nYIBm64k4WojmpJU0PMjX3CElnC6739bk/LvrnPdi5o9zS/AjTN/Pjv6YrJo6J7D
eFIWHpj6SpanxATJviuiTNouALq0AKTB7igQNfXh2MgzS8Kl78o=
=6DNp
-----END PGP SIGNATURE-----

--=-VSnKJdS6jzSWZDm2nTnO--

