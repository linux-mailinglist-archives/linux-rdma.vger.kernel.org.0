Return-Path: <linux-rdma+bounces-5136-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EE29887A5
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 16:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1619281B7C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCA21C0DED;
	Fri, 27 Sep 2024 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBxWuXFT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE51C0DDC
	for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2024 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449027; cv=none; b=BPex4D7xLZWmmG+QeXTA7DM0QEH+sdLsgXCbZ3HLOVkte0H8cdKlM0N5RpFR/+yMdezHdkSySrXi8YmaqkRc60A7oM7D8QcXnJ7xm1skDL1IVO5rN17ORcg1MjwaFi9jpCZbuVKttIYDGqrxAhRyQ+rhj49Yt6Pj+Ce42XGbwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449027; c=relaxed/simple;
	bh=KpFQjUYNoqorgSZR3P1u7MaHQxHtQSx0hYrOTa71UnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpDmKW4a7t8DwvFwt4IWYLklH3Y4l1MFm3z6jd6O2dL1T7/Iyt8MU8o+pEQf2pagBim0S2+bnKz9Ip8x029KuY0CSCvewuwv2BZZseG7W1b/mDukJQ7PJl4wC08qbRT65K8RUqpvJfRhesE5LiogqjAOgAl2egRP9mjcW3xCce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qBxWuXFT; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f753375394so21537101fa.0
        for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2024 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727449024; x=1728053824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/18GyfMUmFmiPlGch6tCsiK6n05dByaKqzKUBTX5A9A=;
        b=qBxWuXFTyNYy6D2xy5AbSYJNSWBDvFC08SrDvq+vJiLtqZIeKbBFhgHsKdZeWWdzIz
         7NWXpeiSrfacXvRUO3OElk/+G7KzGmNGxbwcrl0De/T1pqkCnmXtqVmeipL7HX8/hy30
         2KmwflU9OTI6OUbMzYo+oG54gVZDDbYECRggNDb2Rb104P5cnV+1QyQp+5EId+RHwrP0
         5QUXO6M/oiYDrRKM5MD1XsTj8/z0MGOFQoJTcp7apDPh6Ds/5rQ7kH09JwadqPNEXzBn
         RjYnYgdFA6h4mfyLXYmpzQ0QlawmrAuQ5rVBf1KBDPAM6VF3b6ioGicUVgFSBPVUhHBJ
         h+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449024; x=1728053824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/18GyfMUmFmiPlGch6tCsiK6n05dByaKqzKUBTX5A9A=;
        b=Cr0qT7f+cB+8192EmuTDhgw2LjMF6Bwlprfxvi21ayeBH8oh0n2noU7+xNysWwBcjO
         190KiHOPkoCGXq3gaTIQ21A32C+Kp9YG/7T2fAtdt8nRvYkZnnEIAY0u8dtdbtdjozQY
         JesPC2vyHgOWaPQeIW8Vj0TRuHd8ZAEo7veYsGlL828wQ01c59QS2sYBk341CLWxli/a
         BSu4n6m+AizBdIfujnQ5q+Qxc44uAUOL6zlOrHV5xGzZtke4XKaMJNKqsQA5uuIuBDLP
         aeEeHj/rmVrh7vRbUNz5TBTKCboS1FHkZJ5H/a2EW6dDcfumVqnVWd3G8QISuLL9zc1G
         AM4g==
X-Forwarded-Encrypted: i=1; AJvYcCWBeCk6nBCiTZJT3D3boVbksDSWwMwGdAJ2eZrlp3ewH0d6bp8EiuOGr5NUtkv/fF1IRVcDhVtkwTuO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc2JYqr537SvFynvrsTTDW2bUBwjx8liVdjDKFYLKLT8dOmM9X
	qcHvVdHp6lvdNitCI7zSqNua9Weni/7qMh3SpJVmaAXErF1VVLuAqJCLUTTFyFi3Z9g+zvl/zxy
	1lgM/Yg8GgXUi0V0TgtB1XeZOjZrS96LkAaBm
X-Google-Smtp-Source: AGHT+IFRKkE0mGNhaH8ET6VLDg6TqeqTkqG/VObziBwEk4Ht7UIK/LQVwwPoMAoSz6jIyTC8gnOtwPvtsKVzIeRIZEg=
X-Received: by 2002:a05:6512:b0b:b0:52c:e11e:d493 with SMTP id
 2adb3069b0e04-5389fc46d3dmr2530689e87.26.1727449023277; Fri, 27 Sep 2024
 07:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1718301630-63692-1-git-send-email-alibuda@linux.alibaba.com> <1718301630-63692-4-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1718301630-63692-4-git-send-email-alibuda@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Sep 2024 16:56:52 +0200
Message-ID: <CANn89i+cKR+hBpXuKxO=dRX448qA3tzEkiOvC4PshWH0OVAD0w@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/3] net/smc: Introduce IPPROTO_SMC
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, 
	wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 8:00=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> From: "D. Wythe" <alibuda@linux.alibaba.com>
>
> This patch allows to create smc socket via AF_INET,
> similar to the following code,
>
> /* create v4 smc sock */
> v4 =3D socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>
> /* create v6 smc sock */
> v6 =3D socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>
> There are several reasons why we believe it is appropriate here:
>
> 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
> address. There is no AF_SMC address at all.
>
> 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
> the infrastructure of AF_INET(6) path, such as common ebpf hooks.
> Otherwise, smc have to implement it again in AF_SMC path.
>
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Tested-by: Wenjia Zhang <wenjia@linux.ibm.com>
> ---
>  include/uapi/linux/in.h |   2 +
>  net/smc/Makefile        |   2 +-
>  net/smc/af_smc.c        |  16 ++++-
>  net/smc/smc_inet.c      | 159 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  net/smc/smc_inet.h      |  22 +++++++
>  5 files changed, 198 insertions(+), 3 deletions(-)
>  create mode 100644 net/smc/smc_inet.c
>  create mode 100644 net/smc/smc_inet.h
>
> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
> index e682ab6..d358add 100644
> --- a/include/uapi/linux/in.h
> +++ b/include/uapi/linux/in.h
> @@ -81,6 +81,8 @@ enum {
>  #define IPPROTO_ETHERNET       IPPROTO_ETHERNET
>    IPPROTO_RAW =3D 255,           /* Raw IP packets                      =
 */
>  #define IPPROTO_RAW            IPPROTO_RAW
> +  IPPROTO_SMC =3D 256,           /* Shared Memory Communications        =
 */
> +#define IPPROTO_SMC            IPPROTO_SMC
>    IPPROTO_MPTCP =3D 262,         /* Multipath TCP connection            =
 */
>  #define IPPROTO_MPTCP          IPPROTO_MPTCP
>    IPPROTO_MAX
> diff --git a/net/smc/Makefile b/net/smc/Makefile
> index 2c510d54..60f1c87 100644
> --- a/net/smc/Makefile
> +++ b/net/smc/Makefile
> @@ -4,6 +4,6 @@ obj-$(CONFIG_SMC)       +=3D smc.o
>  obj-$(CONFIG_SMC_DIAG) +=3D smc_diag.o
>  smc-y :=3D af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o sm=
c_llc.o
>  smc-y +=3D smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink=
.o smc_stats.o
> -smc-y +=3D smc_tracepoint.o
> +smc-y +=3D smc_tracepoint.o smc_inet.o
>  smc-$(CONFIG_SYSCTL) +=3D smc_sysctl.o
>  smc-$(CONFIG_SMC_LO) +=3D smc_loopback.o
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 8e3ce76..435f38b 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -54,6 +54,7 @@
>  #include "smc_tracepoint.h"
>  #include "smc_sysctl.h"
>  #include "smc_loopback.h"
> +#include "smc_inet.h"
>
>  static DEFINE_MUTEX(smc_server_lgr_pending);   /* serialize link group
>                                                  * creation on server
> @@ -3593,10 +3594,15 @@ static int __init smc_init(void)
>                 pr_err("%s: tcp_ulp_register fails with %d\n", __func__, =
rc);
>                 goto out_lo;
>         }
> -
> +       rc =3D smc_inet_init();
> +       if (rc) {
> +               pr_err("%s: smc_inet_init fails with %d\n", __func__, rc)=
;
> +               goto out_ulp;
> +       }
>         static_branch_enable(&tcp_have_smc);
>         return 0;
> -
> +out_ulp:
> +       tcp_unregister_ulp(&smc_ulp_ops);
>  out_lo:
>         smc_loopback_exit();
>  out_ib:
> @@ -3633,6 +3639,7 @@ static int __init smc_init(void)
>  static void __exit smc_exit(void)
>  {
>         static_branch_disable(&tcp_have_smc);
> +       smc_inet_exit();
>         tcp_unregister_ulp(&smc_ulp_ops);
>         sock_unregister(PF_SMC);
>         smc_core_exit();
> @@ -3660,4 +3667,9 @@ static void __exit smc_exit(void)
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS_NETPROTO(PF_SMC);
>  MODULE_ALIAS_TCP_ULP("smc");
> +/* 256 for IPPROTO_SMC and 1 for SOCK_STREAM */
> +MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 256, 1);
> +#if IS_ENABLED(CONFIG_IPV6)
> +MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 256, 1);
> +#endif /* CONFIG_IPV6 */
>  MODULE_ALIAS_GENL_FAMILY(SMC_GENL_FAMILY_NAME);
> diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
> new file mode 100644
> index 00000000..bece346
> --- /dev/null
> +++ b/net/smc/smc_inet.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Shared Memory Communications over RDMA (SMC-R) and RoCE
> + *
> + *  Definitions for the IPPROTO_SMC (socket related)
> + *
> + *  Copyright IBM Corp. 2016, 2018
> + *  Copyright (c) 2024, Alibaba Inc.
> + *
> + *  Author: D. Wythe <alibuda@linux.alibaba.com>
> + */
> +
> +#include <net/protocol.h>
> +#include <net/sock.h>
> +
> +#include "smc_inet.h"
> +#include "smc.h"
> +
> +static int smc_inet_init_sock(struct sock *sk);
> +
> +static struct proto smc_inet_prot =3D {
> +       .name           =3D "INET_SMC",
> +       .owner          =3D THIS_MODULE,
> +       .init           =3D smc_inet_init_sock,
> +       .hash           =3D smc_hash_sk,
> +       .unhash         =3D smc_unhash_sk,
> +       .release_cb     =3D smc_release_cb,
> +       .obj_size       =3D sizeof(struct smc_sock),
> +       .h.smc_hash     =3D &smc_v4_hashinfo,
> +       .slab_flags     =3D SLAB_TYPESAFE_BY_RCU,
> +};
> +
> +static const struct proto_ops smc_inet_stream_ops =3D {
> +       .family         =3D PF_INET,
> +       .owner          =3D THIS_MODULE,
> +       .release        =3D smc_release,
> +       .bind           =3D smc_bind,
> +       .connect        =3D smc_connect,
> +       .socketpair     =3D sock_no_socketpair,
> +       .accept         =3D smc_accept,
> +       .getname        =3D smc_getname,
> +       .poll           =3D smc_poll,
> +       .ioctl          =3D smc_ioctl,
> +       .listen         =3D smc_listen,
> +       .shutdown       =3D smc_shutdown,
> +       .setsockopt     =3D smc_setsockopt,
> +       .getsockopt     =3D smc_getsockopt,
> +       .sendmsg        =3D smc_sendmsg,
> +       .recvmsg        =3D smc_recvmsg,
> +       .mmap           =3D sock_no_mmap,
> +       .splice_read    =3D smc_splice_read,
> +};
> +
> +static struct inet_protosw smc_inet_protosw =3D {
> +       .type           =3D SOCK_STREAM,
> +       .protocol       =3D IPPROTO_SMC,
> +       .prot           =3D &smc_inet_prot,
> +       .ops            =3D &smc_inet_stream_ops,
> +       .flags          =3D INET_PROTOSW_ICSK,

When this flag is set, icsk->icsk_sync_mss must be set.

Unable to handle kernel NULL pointer dereference at virtual address
0000000000000000
Mem abort info:
ESR =3D 0x0000000086000005
EC =3D 0x21: IABT (current EL), IL =3D 32 bits
SET =3D 0, FnV =3D 0
EA =3D 0, S1PTW =3D 0
FSC =3D 0x05: level 1 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000001195d1000
[0000000000000000] pgd=3D0800000109c46003, p4d=3D0800000109c46003,
pud=3D0000000000000000
Internal error: Oops: 0000000086000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 8037 Comm: syz.3.265 Not tainted
6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 08/06/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : 0x0
lr : cipso_v4_sock_setattr+0x2a8/0x3c0 net/ipv4/cipso_ipv4.c:1910
sp : ffff80009b887a90
x29: ffff80009b887aa0 x28: ffff80008db94050 x27: 0000000000000000
x26: 1fffe0001aa6f5b3 x25: dfff800000000000 x24: ffff0000db75da00
x23: 0000000000000000 x22: ffff0000d8b78518 x21: 0000000000000000
x20: ffff0000d537ad80 x19: ffff0000d8b78000 x18: 1fffe000366d79ee
x17: ffff8000800614a8 x16: ffff800080569b84 x15: 0000000000000001
x14: 000000008b336894 x13: 00000000cd96feaa x12: 0000000000000003
x11: 0000000000040000 x10: 00000000000020a3 x9 : 1fffe0001b16f0f1
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 0000000000000000 x0 : ffff0000d8b78000
Call trace:
0x0
netlbl_sock_setattr+0x2e4/0x338 net/netlabel/netlabel_kapi.c:1000
smack_netlbl_add+0xa4/0x154 security/smack/smack_lsm.c:2593
smack_socket_post_create+0xa8/0x14c security/smack/smack_lsm.c:2973
security_socket_post_create+0x94/0xd4 security/security.c:4425
__sock_create+0x4c8/0x884 net/socket.c:1587
sock_create net/socket.c:1622 [inline]
__sys_socket_create net/socket.c:1659 [inline]
__sys_socket+0x134/0x340 net/socket.c:1706
__do_sys_socket net/socket.c:1720 [inline]
__se_sys_socket net/socket.c:1718 [inline]
__arm64_sys_socket+0x7c/0x94 net/socket.c:1718
__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: ???????? ???????? ???????? ???????? (????????)
---[ end trace 0000000000000000 ]---

