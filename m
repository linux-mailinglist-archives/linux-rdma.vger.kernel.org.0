Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3CA97DFA5
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 18:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfHAQAS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 12:00:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbfHAQAS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 12:00:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DEF86404F;
        Thu,  1 Aug 2019 16:00:17 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF2DA60623;
        Thu,  1 Aug 2019 16:00:15 +0000 (UTC)
Message-ID: <c3d95377af494b5d519a26f5c7dd8426ed93612f.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] IB/mad: Fix use-after-free in ib mad completion
 handling
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jack Morgenstein <jackm@dev.mellanox.co.il>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>
Date:   Thu, 01 Aug 2019 12:00:13 -0400
In-Reply-To: <20190801121449.24973-1-leon@kernel.org>
References: <20190801121449.24973-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+z1pMIKdAvYiqfxRqCc0"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 01 Aug 2019 16:00:17 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-+z1pMIKdAvYiqfxRqCc0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 15:14 +0300, Leon Romanovsky wrote:
> From: Jack Morgenstein <jackm@dev.mellanox.co.il>
>=20
> We encountered a use-after-free bug when unloading the driver:
>=20
> [ 3562.116059] BUG: KASAN: use-after-free in
> ib_mad_post_receive_mads+0xddc/0xed0 [ib_core]
> [ 3562.117233] Read of size 4 at addr ffff8882ca5aa868 by task
> kworker/u13:2/23862
> [ 3562.118385]
> [ 3562.119519] CPU: 2 PID: 23862 Comm: kworker/u13:2 Tainted:
> G           OE     5.1.0-for-upstream-dbg-2019-05-19_16-44-30-13 #1
> [ 3562.121806] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Ubuntu-1.8.2-1ubuntu2 04/01/2014
> [ 3562.123075] Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
> [ 3562.124383] Call Trace:
> [ 3562.125640]  dump_stack+0x9a/0xeb
> [ 3562.126911]  print_address_description+0xe3/0x2e0
> [ 3562.128223]  ? ib_mad_post_receive_mads+0xddc/0xed0 [ib_core]
> [ 3562.129545]  __kasan_report+0x15c/0x1df
> [ 3562.130866]  ? ib_mad_post_receive_mads+0xddc/0xed0 [ib_core]
> [ 3562.132174]  kasan_report+0xe/0x20
> [ 3562.133514]  ib_mad_post_receive_mads+0xddc/0xed0 [ib_core]
> [ 3562.134835]  ? find_mad_agent+0xa00/0xa00 [ib_core]
> [ 3562.136158]  ? qlist_free_all+0x51/0xb0
> [ 3562.137498]  ? mlx4_ib_sqp_comp_worker+0x1970/0x1970 [mlx4_ib]
> [ 3562.138833]  ? quarantine_reduce+0x1fa/0x270
> [ 3562.140171]  ? kasan_unpoison_shadow+0x30/0x40
> [ 3562.141522]  ib_mad_recv_done+0xdf6/0x3000 [ib_core]
> [ 3562.142880]  ? _raw_spin_unlock_irqrestore+0x46/0x70
> [ 3562.144277]  ? ib_mad_send_done+0x1810/0x1810 [ib_core]
> [ 3562.145649]  ? mlx4_ib_destroy_cq+0x2a0/0x2a0 [mlx4_ib]
> [ 3562.147008]  ? _raw_spin_unlock_irqrestore+0x46/0x70
> [ 3562.148380]  ? debug_object_deactivate+0x2b9/0x4a0
> [ 3562.149814]  __ib_process_cq+0xe2/0x1d0 [ib_core]
> [ 3562.151195]  ib_cq_poll_work+0x45/0xf0 [ib_core]
> [ 3562.152577]  process_one_work+0x90c/0x1860
> [ 3562.153959]  ? pwq_dec_nr_in_flight+0x320/0x320
> [ 3562.155320]  worker_thread+0x87/0xbb0
> [ 3562.156687]  ? __kthread_parkme+0xb6/0x180
> [ 3562.158058]  ? process_one_work+0x1860/0x1860
> [ 3562.159429]  kthread+0x320/0x3e0
> [ 3562.161391]  ? kthread_park+0x120/0x120
> [ 3562.162744]  ret_from_fork+0x24/0x30
> ...
> [ 3562.187615] Freed by task 31682:
> [ 3562.188602]  save_stack+0x19/0x80
> [ 3562.189586]  __kasan_slab_free+0x11d/0x160
> [ 3562.190571]  kfree+0xf5/0x2f0
> [ 3562.191552]  ib_mad_port_close+0x200/0x380 [ib_core]
> [ 3562.192538]  ib_mad_remove_device+0xf0/0x230 [ib_core]
> [ 3562.193538]  remove_client_context+0xa6/0xe0 [ib_core]
> [ 3562.194514]  disable_device+0x14e/0x260 [ib_core]
> [ 3562.195488]  __ib_unregister_device+0x79/0x150 [ib_core]
> [ 3562.196462]  ib_unregister_device+0x21/0x30 [ib_core]
> [ 3562.197439]  mlx4_ib_remove+0x162/0x690 [mlx4_ib]
> [ 3562.198408]  mlx4_remove_device+0x204/0x2c0 [mlx4_core]
> [ 3562.199381]  mlx4_unregister_interface+0x49/0x1d0 [mlx4_core]
> [ 3562.200356]  mlx4_ib_cleanup+0xc/0x1d [mlx4_ib]
> [ 3562.201329]  __x64_sys_delete_module+0x2d2/0x400
> [ 3562.202288]  do_syscall_64+0x95/0x470
> [ 3562.203277]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>=20
> The problem was that the MAD PD was deallocated before the MAD CQ.
> There was completion work pending for the CQ when the PD got
> deallocated.
> When the mad completion handling reached procedure
> ib_mad_post_receive_mads(), we got a use-after-free bug in the
> following
> line of code in that procedure:
>    sg_list.lkey =3D qp_info->port_priv->pd->local_dma_lkey;
> (the pd pointer in the above line is no longer valid, because the
> pd has been deallocated).
>=20
> We fix this by allocating the PD before the CQ in procedure
> ib_mad_port_open(), and deallocating the PD after freeing the CQ
> in procedure ib_mad_port_close().
>=20
> Since the CQ completion work queue is flushed during ib_free_cq(),
> no completions will be pending for that CQ when the PD is later
> deallocated.
>=20
> Note that freeing the CQ before deallocating the PD is the practice
> in the ULPs.
>=20
> Fixes: 4be90bc60df4 ("IB/mad: Remove ib_get_dma_mr calls")
> Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-+z1pMIKdAvYiqfxRqCc0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1DDI0ACgkQuCajMw5X
L93LvA/8D1yvkMGxzGF9X9TmRrX6C1dFRNp8CkzTUt1FU/358hMxaXqfYZ7RNbgs
7/B6pMriha/yS5ZWQolGkRH4oV7/baEoA1NiFJmSJHDEJaP06Fc59s+lqSz27OCZ
BmiZx9IpJIVC+kmaC0yWunobrhlTqnNZ+X2r74ZtKLWoquU6R3dNKPFfI03tOnNN
feeV4qCm8IP4q63a/mqqwbI7UrmHTD0RUoobh9D3laixcR8SLjyn1BWRsDyZ/0s7
DEjJdDeJpwh4k6kQzptfusasEFcpo3j+yEI6uVjrQrtgQnedtHoc9yTiTtsDhZ9g
GE03eA8iW/D5DpibNKhYU01Hij85N7lQ9mgUFY/x6H0NHvUxBbBF1xgZGWV8x8/l
5KGE+nc6Vizw0aEMGMmL+/HyXBP6XS4uwMje8tZolUMBPcKRO3T6QTFm4DP5z2vC
txv3CYgQ+vh0HvpYO5huQE4u6s5fR2OjlwmVYWG3qtCs69Mu/XpmjpaqzUF04zt0
yvJZEZNkVlN2bMLzKVjy8x2JXWV8xpuMcUnTaeXZI+qcSDBfqm00t7dBkpKutsOC
x0Bt2OKbeGROD+kLsiJRClIWylywVQg/Sy3ENMojdRUGroGnQUc22VRoLFWrRPnx
8LurH+IT7sqLzVwCNSCnlQsLp2n9CdAi5oz7gNe7qzFXKSMyd8w=
=DAOC
-----END PGP SIGNATURE-----

--=-+z1pMIKdAvYiqfxRqCc0--

