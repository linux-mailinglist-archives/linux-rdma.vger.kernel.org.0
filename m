Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7C1099C
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 16:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfEAOuU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 10:50:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfEAOuT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 10:50:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6CCC59451;
        Wed,  1 May 2019 14:50:18 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0182F53;
        Wed,  1 May 2019 14:50:17 +0000 (UTC)
Message-ID: <7be4c649c4d826168891b07d52119f64e424379b.camel@redhat.com>
Subject: Re: [PATCH] rdma/i40iw: Add a reference when accepting a connection
 to avoid panic
From:   Doug Ledford <dledford@redhat.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Andrew Boyer <aboyer@tobark.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Parvathi Rajagopal <parvathi.rajagopal@emc.com>
Date:   Wed, 01 May 2019 10:50:15 -0400
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5AA0344@fmsmsx124.amr.corp.intel.com>
References: <20190327134254.1740-1-andrew.boyer@dell.com>
         <9DD61F30A802C4429A01CA4200E302A7A5A88287@fmsmsx124.amr.corp.intel.com>
         <BA22062A-AE8D-43C9-9F54-54214D8BF283@tobark.org>
         <9DD61F30A802C4429A01CA4200E302A7A5AA0344@fmsmsx124.amr.corp.intel.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6tpnLUOFoKrByxpPwXos"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 01 May 2019 14:50:19 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-6tpnLUOFoKrByxpPwXos
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-04-08 at 16:16 +0000, Saleem, Shiraz wrote:
> > Subject: Re: [PATCH] rdma/i40iw: Add a reference when accepting a conne=
ction to
> > avoid panic
> >=20
> >=20
> > > On Mar 29, 2019, at 7:29 PM, Saleem, Shiraz <shiraz.saleem@intel.com>=
 wrote:
> > >=20
> > > > Subject: [PATCH] rdma/i40iw: Add a reference when accepting a
> > > > connection to avoid panic
> > > >=20
> > > > When a CONNECT_REQUEST is received on the listening side, a new
> > > > cm_node is created. A pointer to the cm_node is put into an iw_cm
> > > > event message, which is put on a workqueue and then sent to i40iw_a=
ccept().
> > > >=20
> > > > The driver needs to add a reference to go with the iw_cm event so
> > > > that the cm_node cannot be destroyed before the workqueue item is p=
rocessed.
> > > >=20
> > > > Note that i40iw_accept() already releases a reference in two error
> > > > paths; these appear to be incorrect since there was no associated r=
eference
> > taken.
> > > > Backtrace:
> > > > [436732.936866] general protection fault: 0000 [#1] SMP NOPTI
> > > > [436732.937891] Modules linked in: ...
> > > > [436732.966395] CPU: 0 PID: 14062 Comm: CMIB Tainted: P           O=
E   4.14.19-
> > > > coreos-r9999.1533000047-442 #1
> > > > [436732.970042] task: ffff8bd589113c80 task.stack: ffff99c047710000
> > > > [436732.971123] RIP: 0010:i40iw_accept+0x2d0/0x4c0 [i40iw] [436732.=
972065]
> > RSP:
> > > > 0018:ffff99c047713b28 EFLAGS: 00010046 [436732.973022] RAX:
> > > > 0000000000000296 RBX: ffff8bcf356a1800 RCX: ffff8bcf356a34c0
> > > > [436732.974314]
> > > > RDX: dead000000000200 RSI: ffff8bd53818b1c0 RDI: dead000000000100
> > > > [436732.975607] RBP: ffff99c047713c68 R08: 0000000000000000 R09:
> > > > ffff8bd53818dc40 [436732.976902] R10: ffff99c047713a08 R11:
> > > > 0000000000000004
> > > > R12: ffff8bd538188018 [436732.978192] R13: ffff8bd53818b220 R14:
> > > > ffff8bd648826800 R15: ffff8bcf356a3400 [436732.979480] FS:
> > > > 00007fc6ceba2700(0000) GS:ffff8bd674400000(0000)
> > > > knlGS:0000000000000000 [436732.980937] CS:  0010 DS: 0000 ES: 0000
> > > > CR0: 0000000080050033 [436732.981983] CR2: 00007faa0ea26270 CR3:
> > 00000016fa6ce003 CR4:
> > > > 00000000003606f0 [436732.983312] DR0: 0000000000000000 DR1:
> > > > 0000000000000000 DR2: 0000000000000000 [436732.984602] DR3:
> > > > 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > [436732.985893] Call Trace:
> > > > [436732.986368]  iw_cm_accept+0x8d/0x550 [iw_cm] [436732.987159]
> > > > rdma_accept+0x1e8/0x260 [rdma_cm] [436732.987982]  0xffffffffc0ad11=
41
> > > > [436732.988574]  0xffffffffc0ad14cd [436732.989168]
> > > > __vfs_write+0x33/0x150 [436732.989824]  ?
> > > > __inode_security_revalidate+0x4a/0x70
> > > > [436732.990734]  ? selinux_file_permission+0xdd/0x130
> > > > [436732.991600]  ? security_file_permission+0x36/0xb0
> > > > [436732.992466]  vfs_write+0xb3/0x1a0 [436732.993088]
> > > > SyS_write+0x52/0xc0 [436732.993698]  do_syscall_64+0x66/0x1d0
> > > > [436732.994384]
> > > > entry_SYSCALL_64_after_hwframe+0x21/0x86
> > > > [436732.995311] RIP: 0033:0x7fc79f7676ad [436732.995981] RSP:
> > > > 002b:00007fc76d371040 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> > > > [436732.997355] RAX: ffffffffffffffda RBX: 0000000028c80950 RCX:
> > > > 00007fc79f7676ad [436732.998646] RDX: 0000000000000128 RSI:
> > > > 00007fc76d371050 RDI: 000000000000005c [436732.999934] RBP:
> > > > 00007fc76d371050 R08: 0000000000000000 R09: 0000000028cc2400
> > > > [436733.001221] R10: 0000000000000009 R11: 0000000000000293 R12:
> > > > 00007fc76d3711d0 [436733.002508] R13: 0000000028c80950 R14:
> > > > 0000000028cc0950 R15: 000000002796b010 [436733.003798] Code: ...
> > > > [436733.007166] RIP: i40iw_accept+0x2d0/0x4c0 [i40iw] RSP:
> > > > ffff99c047713b28
> > > >=20
> > > > Fixes: f27b4746f378e ("i40iw: add connection management code"
> > > > Signed-off-by: Andrew Boyer <andrew.boyer@dell.com>
> > > > ---
> > > > drivers/infiniband/hw/i40iw/i40iw_cm.c | 19 +++++++++++++++----
> > > > 1 file changed, 15 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c
> > > > b/drivers/infiniband/hw/i40iw/i40iw_cm.c
> > > > index 206cfb0016f8..28e92a68c178 100644
> > > > --- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
> > > > +++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
> > > > @@ -272,6 +272,9 @@ static int i40iw_send_cm_event(struct
> > > > i40iw_cm_node *cm_node,
> > > > 		event.private_data =3D (void *)cm_node->pdata_buf;
> > > > 		event.private_data_len =3D (u8)cm_node->pdata.size;
> > > > 		event.ird =3D cm_node->ird_size;
> > > > +
> > > > +		/* Take a reference to go with the iw_cm event */
> > > > +		atomic_inc(&cm_node->ref_count);
> > > > 		break;
> > >=20
> > > Maybe I am missing something here, but i40iw_cm_post_event() should
> > > have bumped the cm_node ref count so it is not deleted till event
> > > worker completes. So, I am not entirely convinced this is the right r=
oot cause and
> > fix.
> > > It would be useful if we could get the call trace on
> > > i40iw_rem_ref_cm_node() when cm_node goes away. I can assist providin=
g a
> > debug patch.
> > > Shiraz
> >=20
> > There are two distinct events put onto two different workqueues. Event =
A is of type
> > struct i40iw_cm_event. Event B is of type struct iw_cm_event.
> >=20
> > i40iw_cm_post_event() bumps the refcount and then posts event A.
> > Event A gets sent to i40iw_cm_event_handler().
> > i40iw_cm_event_handler() calls i40iw_send_cm_event().
> > i40iw_send_cm_event() posts event B.
> > Then i40iw_cm_event_handler() drops the refcount associated with event =
A.
> >=20
> > Event B gets sent to cm_id->event_handler() which I believe is cm_event=
_handler()
> > in iwcm.c.
> >=20
> > There is nothing to prevent the refcount associated with event A from g=
etting
> > dropped before cm_event_handler() is able to process event B.
> >=20
> Sure. But, there is a refcnt for the cm_node when its created that I woul=
d have expected to exist in i40iw_accept().
> Where did that get dropped? Something like this that shows the sequence o=
f callers dropping the refcnt on the cm_node
> leading up to the problem would be good.
>=20
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/=
hw/i40iw/i40iw_cm.c
> index 8233f5a..9d01d9d 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
> @@ -2288,6 +2288,7 @@ static void i40iw_rem_ref_cm_node(struct i40iw_cm_n=
ode *cm_node)
>         struct i40iw_cm_info nfo;
>         unsigned long flags;
> =20
> +       pr_info("%s: cm_node %px ref_cnt %d caller: %pS \n", __func__, cm=
_node, atomic_read(&cm_node->ref_count),__builtin_return_address(0));
>         spin_lock_irqsave(&cm_node->cm_core->ht_lock, flags);
>         if (atomic_dec_return(&cm_node->ref_count)) {
>                 spin_unlock_irqrestore(&cm_node->cm_core->ht_lock, flags)=
;
> @@ -3664,6 +3665,7 @@ int i40iw_accept(struct iw_cm_id *cm_id, struct iw_=
cm_conn_param *conn_param)
>         dev =3D &iwdev->sc_dev;
>         cm_core =3D &iwdev->cm_core;
>         cm_node =3D (struct i40iw_cm_node *)cm_id->provider_data;
> +       pr_info("%s: cm_node %px\n", __func__, cm_node);
> =20
>         if (((struct sockaddr_in *)&cm_id->local_addr)->sin_family =3D=3D=
 AF_INET) {
>                 cm_node->ipv4 =3D true;
>=20

This patch is now over a month old with no resolution.  Can we get a
final answer on this please?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-6tpnLUOFoKrByxpPwXos
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzJsicACgkQuCajMw5X
L90y7Q//dcSdb3A2qZ3X9h9IKTK8V0hSO0PGojTRE6WcLqVwyHR4w5EfV4n1timK
EXvGjwg49+3K3qP4zyx/s2HC/JWywzN9fW9lKwe4iTtRAWruZ82TXLzWVqo0TFhZ
OhLZtRsbITXZrKWvVhBW6t70ZSnPUm0rElAKiaG2LXsWY1HN3BcqeSVce6Y4M0LP
Xj5q8EGtTeSaCUcBcvsKEWZlz6p0cd3RCwE+tvdxyNRbVqRPvT9G6cZv+frdk74R
uoqVp8Q60847ttpytf6OWmq50TRN3KM7tsKrUjV9Q+2y1LnZa963mAJSQhxk5cMW
fPDaqFMbjEqltqNw3tHxxye7UX6qy2KA/mwZ4Mh9IIC06DHDA8jzJsGUirHPeVts
gF6ndgJncXguG+yoFJkMr8PWv93lzW7ltGRWbqbRqry1IwlJyVFYIH5Dy1Nb2Bf1
ht7cRBcvdNUlTrR6OP6zyYcjb3u7SwfaDDd5SJg2U7XwvCVDkhtZ0U0LE7Vv9G5h
5uMDhRwBpKa/+AM2QHT/6nQYVTZX5e+W2fBboC8YF7mmMuTC1XJLgTLzj3BlAHzd
YNq3/Pm9GD81711DYIDjbg9PCYS7fyQKU0YkuBdKdUtzsGf0qnDpbaROw22NS2fD
3NbiyXKxab3M71mkUKqu4oBfNWAGvpvpFItbWsHNBi/2UEw1qJc=
=upFh
-----END PGP SIGNATURE-----

--=-6tpnLUOFoKrByxpPwXos--

