Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45D8DF732
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfJUUzz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 16:55:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53057 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728943AbfJUUzz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 16:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571691354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWrTW4dGirEHlCYQhRmguSL5PY0G03s8kJ1n6OjbfEk=;
        b=EOB8gchduY05iAUX+gztgxAQp6dIXcf0BXaEFlHYIrfxo3DyhvKKLGVxqmSRaKEUBG1oXl
        j/DrokkmovWsmhxJAbvqWALEO6eKwG+xjR8Y1ce+CnqDTUeeT5QoqghM4khVFf0qbRAZuH
        A4FKd9UO5mRNjlEenl4SzrtKpgzcZHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-UrM7_W4UPwSVjEfG8SXJQQ-1; Mon, 21 Oct 2019 16:55:53 -0400
X-MC-Unique: UrM7_W4UPwSVjEfG8SXJQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55DF6100550E;
        Mon, 21 Oct 2019 20:55:52 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8FD460856;
        Mon, 21 Oct 2019 20:55:51 +0000 (UTC)
Message-ID: <ffbb94fd1187edc7b0307e739fdaf2c000b7a325.camel@redhat.com>
Subject: Re: [PATCH] ib/srp: Add missing new line after displaying
 fast_io_fail_tmo param
From:   Doug Ledford <dledford@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Donald Dutile <ddutile@redhat.com>, linux-rdma@vger.kernel.org
Date:   Mon, 21 Oct 2019 16:55:49 -0400
In-Reply-To: <d5535489-0130-d159-7e3d-bb34d3bc4282@acm.org>
References: <20191009164937.21989-1-ddutile@redhat.com>
         <d5535489-0130-d159-7e3d-bb34d3bc4282@acm.org>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Ex5SC0YINomtpQL610kb"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-Ex5SC0YINomtpQL610kb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-09 at 14:55 -0700, Bart Van Assche wrote:
> On 10/9/19 9:49 AM, Donald Dutile wrote:
> > Long-time missing new-line in sysfs output.
> > Simply add it.
>=20
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Ex5SC0YINomtpQL610kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2uG1UACgkQuCajMw5X
L93n7Q/+M0SN09nVhv997JZdi+QH5oqj0rvkNWY8YvyEVUnxaUiH7nJNp5Gimn0r
ffQWPv6D678raVHiI+bVhmK+M6WStw0TapRS4r6JlncvhaB0Pa6cu+MMyQBmmXNA
9INoFO4stPRnoRzZrNGToJnNKY76uy8QHHCuVJZsjVD3MYS2yV7VqI1g248cNdwI
+LCo5eJElwZvldamsuQbRqmriJKrOmzd8NXJXMl9xU4mu93KOpIhmbaCiwChRA84
MJmG43LYL7GZiDFevcbbOWBGDyqml986EtM1L6Dv7u4Yeyuu/ppdhKEhewu/am4K
2HxRfWQu/klFXopeb2BhPs09xJnCHCkzRrBXkiSzlDjUjM9pB/OqeEMVsYa4gn6n
oCP6DEHlGMKtrOoFQFJXqs4sYrNp4AML2qvEnCrqTWl1GIR69Rp7/0vsq4RBAull
5pGuQe/61CBsf0Dj3kbLX0N429rI/9O17820mI5xoHpnWe3KJygj5o8QMXtwdo1q
Xi+KrRTZkA6YkSIbOBsBps+vSltzpxiLU7EeY3IANtB0ZzJVLMu3iaXTX0blxvfR
/hygYqDQ06tsGgDtOLgb70VpdSFRfMxIOLC1eFtqNG0JNewMw7QgDxncEB7bqz7G
LbEcNaj60a1aDRBjJjlkrUktA5aRSCVolO8dClN9vKuS6R2Ac+Y=
=jpFF
-----END PGP SIGNATURE-----

--=-Ex5SC0YINomtpQL610kb--

