Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA23111A35E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 05:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLKEYa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Dec 2019 23:24:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40310 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726718AbfLKEYa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Dec 2019 23:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576038269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TK38JnGxZMaz8frisHHO+Z0eZRL+92+DHWRZoGUewsg=;
        b=ceD3uctA2jX46eVeeRJBzEtjXP88UNWAbNbco54pmolLXHI2/gpMDIDsI4nKY/CqWo6pEx
        r5PQKp1TKokYli+ru8Zi/AUp/taL/DgcvGk+LFQMX6QiSkGPsL+JOVif8ndTs3f7uZsqQG
        RDyue8xGGNiWmnRrwQ0rIEeEU8dBg9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-l24wJ9vFPd2RSp0dYsNuvQ-1; Tue, 10 Dec 2019 23:24:26 -0500
X-MC-Unique: l24wJ9vFPd2RSp0dYsNuvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD91E800EC0;
        Wed, 11 Dec 2019 04:24:24 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB4725EE1A;
        Wed, 11 Dec 2019 04:24:23 +0000 (UTC)
Message-ID: <c20696208c239bd11621ad3101735255738bcc97.camel@redhat.com>
Subject: Re: [PATCH 2/2] rxe: correctly calculate iCRC for unaligned payloads
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Steve Wise <larrystevenwise@gmail.com>,
        linux-rdma@vger.kernel.org, 3100102071@zju.edu.cn
Date:   Tue, 10 Dec 2019 23:24:21 -0500
In-Reply-To: <20191210065410.GK67461@unreal>
References: <20191203020319.15036-1-larrystevenwise@gmail.com>
         <20191203020319.15036-2-larrystevenwise@gmail.com>
         <a0003c88-10f5-c14a-220d-c100fa160163@acm.org>
         <0f8d9087c48e986d08cf85ef8b59bdca25425eaa.camel@redhat.com>
         <1aee0f71873a4c9da7f965c12419d81333f3a0b4.camel@redhat.com>
         <20191210065410.GK67461@unreal>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wgQDn3NDwUaUn33QzQLS"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-wgQDn3NDwUaUn33QzQLS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-12-10 at 08:54 +0200, Leon Romanovsky wrote:
> On Mon, Dec 09, 2019 at 02:07:06PM -0500, Doug Ledford wrote:
> >=20
> > I've taken these two patches into for-rc (with fixups to the commit
> > message on the second, as well as adding a Fixes: tag on the
> > second).
> >=20
> > I stand by what I said about not needing a compatibility flag or
> > module
> > option for the user to set.  However, that isn't to say that we
> > can't
> > autodetect old soft-RoCE peers.  If we get a packet that fails CRC
> > and
> > has pad bytes, then re-run the CRC without the pad bytes and see if
> > it
> > matches.  If it does, we could A) mark the current QP as being to an
> > old
> > soft-RoCE device (causing us to send without including the pad bytes
> > in
> > the CRC) and B) allocate a struct old_soft_roce_peer and save the
> > guid
> > into that struct and then put that struct on a list that we then
> > search
> > any time we are creating a new queue pair and if the new queue pair
> > goes
> > to a guid in the list, then we immediately flag that qp as being to
> > an
> > old soft roce device and get the right behavior.  It would slow down
> > qp
> > creation somewhat due to the list search, but probably not enough to
> > worry about.  No one will be doing a 1,000 node cluster MPI job over
> > soft-RoCE, so we should never notice the list length causing search
> > problems.  A patch to do something like that would be welcome.
>=20
> Do you find this implementation needed? I see RXE as a development
> platform and in my view it is unlikely that someone will run RXE in
> production with mixture of different kernel versions, which requires
> such compatibility fallback.

It's not a requirement, that's why I took the patches as they were.  It
would just be a "nice to have".

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-wgQDn3NDwUaUn33QzQLS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl3wb3UACgkQuCajMw5X
L91n+g/+PZDfjW8bJBURqu1nAkxP+mHOZjJCYU4GWZJr25OxlJiUrPPU6vRFiB2q
f0QBqTXhnRscY86KvUBSeT8VsgJzOVhXq8Cg0disjaiciACFoaAJJ1SYwv+M+2IV
AQGjNQhhyT9GJSrUL819QyHjNWzMWAN0LtRT8vFlg4LCWA+BUo/wggz6aw6bTXe5
LqqcU1XPcH5HdiwwYPpB2lgJfdoAklPzlWl+7on2JSMYh24rnRGRAVaBouxCFu41
/hfiP91pPAuUl7ZR8BEsn6RMEzOOBhz95bQjwdmbZsyVO7nYr7JVVL6TKboixG4m
lqudo6tFMJp9dZTv36qA/pXG7ui+rE9dXgmhK3xmdsNU38uW68Mwhk4LMqyRtulM
32GT4KjQss9VUkTzhI2i6uFpAv/JQ/cBbfJTK7m08MITrRdATybC1OZJfu0gCQsM
D7KAbj6JHwIknKD6lQZ6RGUIH4Hs3kter40fWKCsyIknKIra6nPZwoRPBZ18nev+
6I91YVn98KB8thKZKmA9s6a0E7yrK7ln7cHXdfAlK2HWtFFPe+B/rxIxH5IJ7QGf
61OKoFG1FS017VRTgy2nlN7j3lF/AgyFqIE8NgGm2DG/kJeN60XP5jPs+EDuiTjU
pNI97S5IelJQkRIWbP5HTvMbtJw+qDSbh3UAWSjtBJt1lC+w8JM=
=VQOm
-----END PGP SIGNATURE-----

--=-wgQDn3NDwUaUn33QzQLS--

