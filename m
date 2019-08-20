Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56DBC9672F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 19:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfHTRNn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 13:13:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTRNn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 13:13:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F01F106BB22;
        Tue, 20 Aug 2019 17:13:42 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A39BC10013A1;
        Tue, 20 Aug 2019 17:13:41 +0000 (UTC)
Message-ID: <bffdcce391aa895fead64a63d86e9857f5da9694.camel@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Fix stack-out-of-bounds in
 bnxt_qplib_rcfw_send_message
From:   Doug Ledford <dledford@redhat.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 20 Aug 2019 13:13:39 -0400
In-Reply-To: <CA+sbYW01BgPXyK3mOi_yCNj4=6Z8AuH89-0A_RB5E-AXX+L2cg@mail.gmail.com>
References: <1565869477-19306-1-git-send-email-selvin.xavier@broadcom.com>
         <20190815130740.GE21596@ziepe.ca>
         <CA+sbYW3t2=bCpYjkuNQeT3LSFcL9n9=awHYpSrB6VZBna4dWhg@mail.gmail.com>
         <20190816120023.GA5398@ziepe.ca>
         <CA+sbYW01BgPXyK3mOi_yCNj4=6Z8AuH89-0A_RB5E-AXX+L2cg@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-mTOxRBUYMgaIhTt4oev+"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Tue, 20 Aug 2019 17:13:42 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-mTOxRBUYMgaIhTt4oev+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-19 at 13:42 +0530, Selvin Xavier wrote:
> On Fri, Aug 16, 2019 at 5:30 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Fri, Aug 16, 2019 at 10:22:25AM +0530, Selvin Xavier wrote:
> > > On Thu, Aug 15, 2019 at 6:37 PM Jason Gunthorpe <jgg@ziepe.ca>
> > > wrote:
> > > > On Thu, Aug 15, 2019 at 04:44:37AM -0700, Selvin Xavier wrote:
> > > > > @@ -583,7 +584,7 @@ int bnxt_qplib_create_srq(struct
> > > > > bnxt_qplib_res *res,
> > > > >       req.eventq_id =3D cpu_to_le16(srq->eventq_hw_ring_id);
> > > > >=20
> > > > >       rc =3D bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
> > > > > -                                       (void *)&resp, NULL,
> > > > > 0);
> > > > > +                                       (void *)&resp,
> > > > > sizeof(req), NULL, 0);
> > > >=20
> > > > I really don't like seeing casts to void * in code. Why can't
> > > > you
> > > > properly embed the header in the structs??
> > > Is your objection only in casting to void * or you dont like any
> > > casting here?
> >=20
> > Explicit cast to void to erase the type is a particularly bad habit
> > that I don't like to see.
> >=20
> > You'd be better to make the send_message accept void * and the cast
> > inside to the header.
> >=20
> Ok. Will make this change. But this looks like a for-next item..
> right?
> If so, can you take this patch as is for RC? I will post the change
> mentioned for for-next separately.

This patch is a lot of lines of churn.  What creating an array of sizes
such that you could use the cmd value as an index into the array.  Then
you'd only need to modify a header file to define the array, and the
send function to lookup the length of the command based upon the command
value itself.  Far fewer lines of churn, especially if you are possibly
going to replace this fix in for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-mTOxRBUYMgaIhTt4oev+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1cKkMACgkQuCajMw5X
L90x9A/+J2+u51QY6dHqRPYQng477H2RJ5tz55toyMXFMcULFxcT8/gTTQD8GNoK
bdf25K+61q20CzwiiwHVetIhNaKVACExCVCLK/FlFN4ZJejB0AWi/XqqYxP2Bpmt
xOJ07qwtAB2VK/NcAJVGaoyBKfzFy88rTIbXF6dnPmAsCSwSOCcT5BDOiBDPbtOU
c5G04iL9FhUSpak0k91Z5AtxPONL6IlmkhgiJeFnis0w0dqHNJD0bBBYCDkFl+vK
+9HMKz+/3DBnlDaRp3qszR4xPBy034pqITdvYvYM5RF9WpSD2IjcbjVhgQuWWIQD
OcZpS+e1jbQr/d+xtRqB3dK2WOge15wyAtEbV/K/s0Duj3vFCNqsuXFZ89r3OCL8
WBNZBMRb9SsORyOz9q3qDHJeg4U+7OFLMeTxx2q6pbslOHspySRUcYSy/LjqwlHl
KDKC68H4KBqU3esEk9BuRb37Du85e0X02KJmzk0B/WbcDCMNMbkhWkcZp2Ef3WWs
tvbNF4CiGkA3OwVJWjEZPXUlZ+2rf5xxKChui8jXJ7Qel38xO2eU2p5upnCBl54F
szOAH8JuqO/wwK5gUNK2DWBKk6dV+Py91CkFd+SIhtgOnkj2Vaxt8MNeZzJk1w3Z
fDTaCae8R4bIa2jm5Y3jzGp9XrpbWRMrY4xqOmt5mDv5f/wzrQU=
=ODzS
-----END PGP SIGNATURE-----

--=-mTOxRBUYMgaIhTt4oev+--

