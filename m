Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EF6A44C0
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Aug 2019 16:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfHaOdS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 31 Aug 2019 10:33:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfHaOdS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 31 Aug 2019 10:33:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E57E3083363;
        Sat, 31 Aug 2019 14:33:17 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 489145C207;
        Sat, 31 Aug 2019 14:33:16 +0000 (UTC)
Message-ID: <63286035eb752429fdb651750acf74765caecfe5.camel@redhat.com>
Subject: Re: qedr memory leak report
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Date:   Sat, 31 Aug 2019 10:33:13 -0400
In-Reply-To: <20190831073048.GH12611@unreal>
References: <93085620-9DAA-47A3-ACE1-932F261674AC@oracle.com>
         <13F323F2-D618-46C3-BE1B-106FD2BEE7F4@oracle.com>
         <20190831073048.GH12611@unreal>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xxfO9c/BHcrprOjEez8n"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sat, 31 Aug 2019 14:33:17 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-xxfO9c/BHcrprOjEez8n
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-08-31 at 10:30 +0300, Leon Romanovsky wrote:
> Doug,
>=20
> I think that it can be counted as good example why allowing memory
> leaks
> in drivers (HNS) is not so great idea.

Crashing the machine is worse.

> Thanks
>=20
> On Fri, Aug 30, 2019 at 02:27:49PM -0400, Chuck Lever wrote:
> > > On Aug 30, 2019, at 2:03 PM, Chuck Lever <chuck.lever@oracle.com>
> > > wrote:
> > >=20
> > > Hi Michal-
> > >=20
> > > In the middle of some other testing, I got this kmemleak report
> > > while testing with FastLinq cards in iWARP mode:
> > >=20
> > > unreferenced object 0xffff888458923340 (size 32):
> > >  comm "mount.nfs", pid 2294, jiffies 4298338848 (age 1144.337s)
> > >  hex dump (first 32 bytes):
> > >    20 1d 69 63 88 88 ff ff 20 1d 69 63 88 88 ff ff   .ic....
> > > .ic....
> > >    00 60 7a 69 84 88 ff ff 00 60 82 f9 00 00 00
> > > 00  .`zi.....`......
> > >  backtrace:
> > >    [<000000000df5bfed>] __kmalloc+0x128/0x176
> > >    [<0000000020724641>] qedr_alloc_pbl_tbl.constprop.44+0x3c/0x121
> > > [qedr]
> > >    [<00000000a361c591>] init_mr_info.constprop.41+0xaf/0x21f
> > > [qedr]
> > >    [<00000000e8049714>] qedr_alloc_mr+0x95/0x2c1 [qedr]
> > >    [<000000000e6102bc>] ib_alloc_mr_user+0x31/0x96 [ib_core]
> > >    [<00000000d254a9fb>] frwr_init_mr+0x23/0x121 [rpcrdma]
> > >    [<00000000a0364e35>] rpcrdma_mrs_create+0x45/0xea [rpcrdma]
> > >    [<00000000fd6bf282>] rpcrdma_buffer_create+0x9e/0x1c9 [rpcrdma]
> > >    [<00000000be3a1eba>] xprt_setup_rdma+0x109/0x279 [rpcrdma]
> > >    [<00000000b736b88f>] xprt_create_transport+0x39/0x19a [sunrpc]
> > >    [<000000001024e4dc>] rpc_create+0x118/0x1ab [sunrpc]
> > >    [<00000000cca43a49>] nfs_create_rpc_client+0xf8/0x15f [nfs]
> > >    [<00000000073c962c>] nfs_init_client+0x1a/0x3b [nfs]
> > >    [<00000000b03964c4>] nfs_init_server+0xc1/0x212 [nfs]
> > >    [<000000001c71f609>] nfs_create_server+0x74/0x1a4 [nfs]
> > >    [<000000004dc919a1>] nfs3_create_server+0xb/0x25 [nfsv3]
> > >=20
> > > It's repeated many times.
> > >=20
> > > The workload was an unremarkable software build and regression
> > > test
> > > suite on an NFSv3 mount with RDMA.
> >=20
> > Also seeing one of these per NFS mount:
> >=20
> > unreferenced object 0xffff888869f39b40 (size 64):
> >   comm "kworker/u28:0", pid 17569, jiffies 4299267916 (age
> > 1592.907s)
> >   hex dump (first 32 bytes):
> >     00 80 53 6d 88 88 ff ff 00 00 00 00 00 00 00
> > 00  ..Sm............
> >     00 48 e2 66 84 88 ff ff 00 00 00 00 00 00 00
> > 00  .H.f............
> >   backtrace:
> >     [<0000000063e652dd>] kmem_cache_alloc_trace+0xed/0x133
> >     [<0000000083b1e912>] qedr_iw_connect+0xf9/0x3c8 [qedr]
> >     [<00000000553be951>] iw_cm_connect+0xd0/0x157 [iw_cm]
> >     [<00000000b086730c>] rdma_connect+0x54e/0x5b0 [rdma_cm]
> >     [<00000000d8af3cf2>] rpcrdma_ep_connect+0x22b/0x360 [rpcrdma]
> >     [<000000006a413c8d>] xprt_rdma_connect_worker+0x24/0x88
> > [rpcrdma]
> >     [<000000001c5b049a>] process_one_work+0x196/0x2c6
> >     [<000000007e3403ba>] worker_thread+0x1ad/0x261
> >     [<000000001daaa973>] kthread+0xf4/0xf9
> >     [<0000000014987b31>] ret_from_fork+0x24/0x30
> >=20
> > Looks like this one is not being freed:
> >=20
> > 514         ep =3D kzalloc(sizeof(*ep), GFP_KERNEL);
> > 515         if (!ep)
> > 516                 return -ENOMEM;
> >=20
> >=20
> > --
> > Chuck Lever
> >=20
> >=20
> >=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-xxfO9c/BHcrprOjEez8n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1qhSkACgkQuCajMw5X
L91nOQ/8D7DsWrRwLkYCyPvMmbfdTPB9xhdgk89sIxJRdwx+tK/RHAP9+BNfv5fx
CMU05uoUuptOSnWUikz3WRiE2Ba1ewJn9NnqtZACXRai4Vokf/y2dMRJniFHE0Zz
h2vVk9EeCo2ByHHzDZaXHbzq7JQcIhUyitTApvXofnmcdQUF0tKM4erjpTjiomxv
B2lnGkyFJFMb8nDex+iszDGl2m3Ta5Ilz9CpBO9iKq+Lps5ELVRzQMOM22DojrLg
XJWDac0kxgcVDy6MqqF5G5HHhNCmN5z2F9S9rgWl5uLiT0PWHTPhbaYdxOBOkDCw
QnUU5g+xDnIwfABLubcQb5/oTTAiUSiAVtOxjHdsOOrEF7c4lRC69F5o60WYzuC/
bH4FNaJsBDwbNOA/gkkJvzBV/FrBcNHgm9HTEEU7qu86+6VGVZNgadp0+buwX/6X
3A2FJJc8YD8rSvFD9kQuc5UUlnq87j2y/ESufLOA1kfgLGnHOWIhhhsy5shnmYPU
p8xRHKh4y0OzRZs9mxDVBrBC7d+nj42XWV4UtPYKMXLe+mOJ6fL6fw+MTU2wMMVB
50D4WzZFOszkBM6AG09AriZTrEG1JhR7ohXXVLdQSU54l2HiHtR/ZJ5qwpFIPGXw
aTREmrfOcb7+mwsYP21pIc6BipgQDGw6ZcdybDsmYbu2phTOLKI=
=VgwZ
-----END PGP SIGNATURE-----

--=-xxfO9c/BHcrprOjEez8n--

