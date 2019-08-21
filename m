Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7C298380
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 20:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfHUSrG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 14:47:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbfHUSrG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 14:47:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1462158569;
        Wed, 21 Aug 2019 18:47:06 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 404A160126;
        Wed, 21 Aug 2019 18:47:05 +0000 (UTC)
Message-ID: <0ce34055454c68cf9089e9e742b04397419a6309.camel@redhat.com>
Subject: Re: CX314A WCE error: WR_FLUSH_ERR
From:   Doug Ledford <dledford@redhat.com>
To:     "Liu, Changcheng" <changcheng.liu@intel.com>,
        Tom Talpey <tom@talpey.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 21 Aug 2019 14:47:02 -0400
In-Reply-To: <20190821153844.GA4545@jerryopenix>
References: <20190821120912.GA1672@jerryopenix>
         <6aed3f75-2445-eb6f-0bd8-7c79ea4a0967@talpey.com>
         <20190821153844.GA4545@jerryopenix>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-vuIwJ44XM8U33rnYtB5w"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 21 Aug 2019 18:47:06 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-vuIwJ44XM8U33rnYtB5w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-21 at 23:38 +0800, Liu, Changcheng wrote:
> On 09:36 Wed 21 Aug, Tom Talpey wrote:
> > On 8/21/2019 8:09 AM, Liu, Changcheng wrote:
> > > Hi all,
> > >     In one system, it always frequently hit "IBV_WC_WR_FLUSH_ERR"
> > > in the WCE(work completion element) polled from completion queue
> > > bound with RQ(Receive Queue).
> > >     Does anyone has some idea to debug "IBV_WC_WR_FLUSH_ERR"
> > > problem?
> > >=20
> > >     With CX314A/40Gb NIC, I hit this error when using RC transport
> > > type with only Send Operation(IBV_WR_SEND) WR(work request) on
> > > SQ(Send Queue).
> > >     Every WR only has one SGE(scatter/gather element) and all the
> > > SGE on RQ has the same size. The SGE size in SQ WR is not greater
> > > than the SGE size in RQ WR.
> > >=20
> > >    There=E2=80=99s one explanation about IBV_WC_WR_FLUSH_ERR on page =
114
> > > in the "RDMA Aware Networks Programming User Manual"=20
> > > http://www.mellanox.com/related-docs/prod_software/RDMA_Aware_Program=
ming_user_manual.pdf
> > >    But I still didn't understand it well. How to trigger this
> > > error with a short demo program?
> > >    "
> > >      IBV_WC_WR_FLUSH_ERR
> > >      This event is generated when an invalid remote error is
> > > thrown when the responder detects an
> > >      invalid request. It may be that the operation is not
> > > supported by the request queue or there is
> > >      insufficient buffer space to receive the request.
> > >    "
> >=20
> > The most common reason for a flushed work request is loss of
> > the connection to the remote peer. This can be caused by any
> > number of conditions.
> Good diretion. I'll debug it in this way first.
> > The second-most common is a programming error in the upper
> > layer protocol. A shortage of posted receives on either peer,
> > a protection error on some buffer, etc.
> Do you mean the protection key such as l_key/r_key isn't set well?
> What's kind of protection error could trigger IBV_WC_WR_FLUSH_ERR?

FLUSH_ERR is the error used whenever a queue pair goes into an error
state and there are still WQEs posted to the queue pair.  All
outstanding WQEs are returned with the state IBV_WC_WR_FLUSH_ERR.  This
is how you make sure you don't loose WQEs when the QP hits an error
state.  So, literally *anything* that can cause a QP to go into an ERROR
state will result in all WQEs currently posted to the QP being sent back
with this FLUSH_ERR.  FLUSH_ERR literally just means that the card is
flushing out the QP's work queue because now that the QP is in an error
state it can't process the WQEs and, presumably, the application needs
to know which ones completed and which ones didn't so it knows what to
requeue once the QP is no longer in an error state.

As Tom has already pointed out, all of these things will throw the queue
pair into an error state and cause all posted WQEs to be flushed with
the FLUSH_ERR condition:

1) Loss of queue pair connection
2) Any memory permission violation (attempt to write to read only
memory, attempt to RDMA read/write to an invalid rkey, etc)
3) Receipt of any post_send message without a waiting post_recv buffer
to accept the message
4) Receipt of a post_send message that is too large to fit in the first
available post_recv buffer

A common cause of this sort of thing is when you don't do proper flow
control on the queue pair and the sending side floods the receiving side
and runs it out of posted recv WQEs.  Although, in your case, you did
say this was happening on the receive queue, so that implies this is
happening on the receiving side, so if that is what's happenining here,
the process would have to be something like:

sender starts sending data (maybe without any flow control)
	receiver starts receiving data and refilling buffers
	...
	receiver runs totally dry of buffers and gets an incoming recv
	causing qp to go into error state

	receiver then posts refill buffers to the RQ after the QP
	went into error state but before acknowledging the error state
	and shutting down the recv processing thread

	all recv buffers posted as WQEs are flushed back to the process
	with FLUSH_ERR because they were posted to a QP in ERROR state

> > If you're looking to actually trigger this error for testing,
> > well, try one of the above. If you're trying to figure out
> > why it's happening, that can take some digging, but not in
> > the RDMA stack, typically.
> Many thanks.
>=20
> --Changcheng
> > Tom.
> >=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-vuIwJ44XM8U33rnYtB5w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1dkaYACgkQuCajMw5X
L92eQA//cJjWy9tKcuJsWxJozc1FsCkf6pOmQPhnoLgA6M9jHTj/2XDW4dcN/FXf
5THfGW6FJD2QbBe5XtcOkvH0CDPVfOBB4OYN9Lo6D7fRCkKekcHbbCvPH7FDQWSR
0ViOhCaaS/gZFj0uq+Tmvzzsjs+5nAFwJyBMbEVOVVCqVoTV67Bt58vmxij2jwUp
rq2eW40pT3ZLisoyQu8lOd/JAUCiICbOQrLn6tztUencAiZm44R/RPe9t7vXzq9w
2OA/6AkXt9pVplJMpAmYS0yfs8UxW+o/TdTComxbOySaVdNG6TxUZg6iETk+OZuQ
gPMltTt0KU1E/Se1a8KWm0anvYcCLw9JgIcyRAQFrNbhci8GP1s5FHGRxk0aYWeg
3yq3896cy2XePSYyH9qHdvSLw1p+KOuYA5HIcukyErJ/Ss0DSiUfLyFGwl5Hd/Mx
vy2Wp6M/wL90wAY3ea+58cVkwZs3dSVVfjlPflB21qp3PG17zkKMh9zjAargXUtv
JUBvi90zC/huZMgoQcK/qvECF/E1G5g7oyacFNMO9VIvAO5wQVOctaTvdoHmHQoY
VVxfGpFb2vnmVCxsNE/ScpOsSfydJp4F8wCAZHSXjCckpNDlvZJ/gXbSTveK7NEV
o7JiJWPXIJ0jsQ20Xcr1/GNEstWTkBv821fBPFrpl83w37vD9K4=
=oh8x
-----END PGP SIGNATURE-----

--=-vuIwJ44XM8U33rnYtB5w--

