Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBD5399E21
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 11:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFCJxE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 05:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFCJxD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Jun 2021 05:53:03 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EBBC06174A
        for <linux-rdma@vger.kernel.org>; Thu,  3 Jun 2021 02:51:19 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1622713877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEKekvRZ0gEcIM4ZPqgTuhKau84picTbD6ksI9abu64=;
        b=j6Ens4XE9kHq/v1Oh1lPrB5+8jvSdd6s6fz5b+RxotQ822Rbxx/HNTnDMVcgtqn7Cng4mM
        jopa/pX+HsLBXwr4WT1Hiy0Rtprcf8kNcXBgFkziy+zK0ttirsH9Oa+v7CqAJM16g3x58A
        36o1yw/fwRXBZcxVehHk6mv+ZQ5pF1c=
Date:   Thu, 03 Jun 2021 09:51:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <50b8e6889371090f47322437a54153ab@linux.dev>
Subject: Re: [PATCH for-rc v1] RDMA/rxe: Fix failure during driver load
To:     "Kamal Heib" <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
In-Reply-To: <20210603090112.36341-1-kamalheib1@gmail.com>
References: <20210603090112.36341-1-kamalheib1@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yanjun.zhu@linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

June 3, 2021 5:01 PM, "Kamal Heib" <kamalheib1@gmail.com> wrote:=0A=0A> T=
o avoid the following failure when trying to load the rdma_rxe module=0A>=
 while IPv6 is disabled, add a check for EAFNOSUPPORT to ignore the=0A> f=
ailure, also delete the needless debug print from rxe_setup_udp_tunnel().=
=0A> =0A> $ modprobe rdma_rxe=0A> modprobe: ERROR: could not insert 'rdma=
_rxe': Operation not permitted=0A> =0A> Fixes: dfdd6158ca2c ("IB/rxe: Fix=
 kernel panic in udp_setup_tunnel")=0A> Signed-off-by: Kamal Heib <kamalh=
eib1@gmail.com>=0A> ---=0A> drivers/infiniband/sw/rxe/rxe_net.c | 10 ++++=
+++---=0A> 1 file changed, 7 insertions(+), 3 deletions(-)=0A> =0A> diff =
--git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/r=
xe_net.c=0A> index 01662727dca0..6cb4446a0bdb 100644=0A> --- a/drivers/in=
finiband/sw/rxe/rxe_net.c=0A> +++ b/drivers/infiniband/sw/rxe/rxe_net.c=
=0A> @@ -207,10 +207,8 @@ static struct socket *rxe_setup_udp_tunnel(stru=
ct net *net, __be16 port,=0A> =0A> /* Create UDP socket */=0A> err =3D ud=
p_sock_create(net, &udp_cfg, &sock);=0A> - if (err < 0) {=0A> - pr_err("f=
ailed to create udp socket. err =3D %d\n", err);=0A> + if (err < 0)=0A> r=
eturn ERR_PTR(err);=0A> - }=0A> =0A> tnl_cfg.encap_type =3D 1;=0A> tnl_cf=
g.encap_rcv =3D rxe_udp_encap_recv;=0A> @@ -619,6 +617,12 @@ static int r=
xe_net_ipv6_init(void)=0A> =0A> recv_sockets.sk6 =3D rxe_setup_udp_tunnel=
(&init_net,=0A> htons(ROCE_V2_UDP_DPORT), true);=0A> + if (PTR_ERR(recv_s=
ockets.sk6) =3D=3D -EAFNOSUPPORT) {=0A> + recv_sockets.sk6 =3D NULL;=0A> =
+ pr_warn("IPv6 is not supported can not create UDP socket\n");=0A=0AThis=
 warning doesn't read smoothly.=0A=0AZhu Yanjun=0A=0A> + return 0;=0A> + =
}=0A> +=0A> if (IS_ERR(recv_sockets.sk6)) {=0A> recv_sockets.sk6 =3D NULL=
;=0A> pr_err("Failed to create IPv6 UDP tunnel\n");=0A> -- =0A> 2.26.3
