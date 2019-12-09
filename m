Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6379117530
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2019 20:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLITHR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Dec 2019 14:07:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33478 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726354AbfLITHR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Dec 2019 14:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575918435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kw5jm2n65Z3vBV6N4noRKjy7xGgRiwD0j1qA6Co3h9c=;
        b=a3GvwM99Y4edPiZIbP5awdAW15MYBszqjeh8yQsRtfwhZ+LXo06Xf0GcBx98FGmNJQc7/A
        JtFSjhY3TkQP2yWJ4hrHLRIpVgUNM4NjWGyZLrgufvZvkAZGQqn6z4OGCA9VGnIxlJeovp
        YHQhTqaYCxsSJPinh+xqTMM0jmTYQ04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-Qiy2XgCFOFSdQZlExV51tg-1; Mon, 09 Dec 2019 14:07:11 -0500
X-MC-Unique: Qiy2XgCFOFSdQZlExV51tg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D6191005512;
        Mon,  9 Dec 2019 19:07:10 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F39B55C1B2;
        Mon,  9 Dec 2019 19:07:08 +0000 (UTC)
Message-ID: <1aee0f71873a4c9da7f965c12419d81333f3a0b4.camel@redhat.com>
Subject: Re: [PATCH 2/2] rxe: correctly calculate iCRC for unaligned payloads
From:   Doug Ledford <dledford@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Steve Wise <larrystevenwise@gmail.com>,
        linux-rdma@vger.kernel.org, 3100102071@zju.edu.cn, leon@kernel.org
Date:   Mon, 09 Dec 2019 14:07:06 -0500
In-Reply-To: <0f8d9087c48e986d08cf85ef8b59bdca25425eaa.camel@redhat.com>
References: <20191203020319.15036-1-larrystevenwise@gmail.com>
         <20191203020319.15036-2-larrystevenwise@gmail.com>
         <a0003c88-10f5-c14a-220d-c100fa160163@acm.org>
         <0f8d9087c48e986d08cf85ef8b59bdca25425eaa.camel@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YBIBRiuCbjMLNJGh2KBq"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-YBIBRiuCbjMLNJGh2KBq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-12-03 at 19:46 -0500, Doug Ledford wrote:
> On Tue, 2019-12-03 at 08:25 -0800, Bart Van Assche wrote:
> > On 12/2/19 6:03 PM, Steve Wise wrote:
> > > If RoCE PDUs being sent or received contain pad bytes, then the
> > > iCRC
> > > is miscalculated resulting PDUs being emitted by RXE with an
> > > incorrect
> > > iCRC, as well as ingress PDUs being dropped due to erroneously
> > > detecting
> > > a bad iCRC in the PDU.  The fix is to include the pad bytes, if
> > > any,
> > > in iCRC computations.
> >=20
> > Should this description mention that this patch breaks
> > compatibility=20
> > with SoftRoCE drivers that do not include this fix? Do we need a
> > kernel=20
> > module parameter that allows to select either the old or the new
> > behavior?
>=20
> No.  The original soft-RoCE driver was supposed to be compatible with
> hardware devices.  Because of this bug, it obviously wasn't.  This is
> a
> bug fix, and we do not need to do anything to be compatible with the
> broken behavior.  Instead, it just needs noting that the soft-RoCE
> implementation in prior kernels has a known wire format bug that
> impacts
> communications with both fixed versions of the driver and real
> hardware
> devices.

I've taken these two patches into for-rc (with fixups to the commit
message on the second, as well as adding a Fixes: tag on the second).

I stand by what I said about not needing a compatibility flag or module
option for the user to set.  However, that isn't to say that we can't
autodetect old soft-RoCE peers.  If we get a packet that fails CRC and
has pad bytes, then re-run the CRC without the pad bytes and see if it
matches.  If it does, we could A) mark the current QP as being to an old
soft-RoCE device (causing us to send without including the pad bytes in
the CRC) and B) allocate a struct old_soft_roce_peer and save the guid
into that struct and then put that struct on a list that we then search
any time we are creating a new queue pair and if the new queue pair goes
to a guid in the list, then we immediately flag that qp as being to an
old soft roce device and get the right behavior.  It would slow down qp
creation somewhat due to the list search, but probably not enough to
worry about.  No one will be doing a 1,000 node cluster MPI job over
soft-RoCE, so we should never notice the list length causing search
problems.  A patch to do something like that would be welcome.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-YBIBRiuCbjMLNJGh2KBq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl3um1oACgkQuCajMw5X
L92g0xAAnqQegJ44HMMnxocKaXb16S1w7HGC8zXGthohWrD8XJWIx82iXGXfW+WD
yqASVmIoQjPVr5EFs0Bw+VdAPvNcZL2775LXx3p+AsEs7YX096J1GsL0r/gFL4Au
JwyCPWTjXmGBwYASTI0mddcDFehbWUHsMzrTvhYuUgqs21OMxq5ZJNOCmCSpFHML
LEhN5QlUHZY42JzO/lh1lG1fMrKfRqasvbvV4iop7AkP0S/Bhbi/QnkvjjXqPaNR
PJDUrZO4AV2iq4Gs165a9FFmz3IaqQXxUvkqM6QpYKVmR6I5COmaW39jlw8XDBUE
9fcXNIoqS7Ste00w1sDTk6o/iV6NfVNtqXQ2MFQt7JlDxeWiKTcNp9iENAEZYswj
AK9exRvMl0JBy/lhD/156l/mVVjT+Tkd7yq4GYNK4abmaUYuXJD9sODyzvcP+aqr
+GWR4tjPbIj4wMx7d53HCiUptPiTy9GCXz1N0D4R9qnut/IyTAesLt7Qc+hRGcIU
0iuUQf0qLnyYZy10f0spxOHL76hn+RNnUc99y0cHNrAl6KF83muUCqJJ1b8piXkl
4aVEaG0ANJBKUdEbXJpaQtc68gQr2yOdHQ9OdmIhLeE+nilTUF/vcmx9Q5+NFILL
GQu6AxpPs6om8+hXclawTEWnzX3nltlVT+9PD8BJNML3w85ZYLw=
=0iQf
-----END PGP SIGNATURE-----

--=-YBIBRiuCbjMLNJGh2KBq--

