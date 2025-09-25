Return-Path: <linux-rdma+bounces-13651-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23464BA009C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 16:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32E14A1D69
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0313C2D9795;
	Thu, 25 Sep 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oIgb/qKt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9B2D9EF6
	for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810762; cv=none; b=up6Dui+leON7xqJfTCSgHzs1s7JIZBMg7OmUEpmymABm8r1hjWSaLF/eF+OUAfGtyrkWDktbt9FTcTeJRlE5sUlpISs9geAIMf97QU0m4v1aM8sg8AN7KcIRqWMeb3+68VCLPZqukfg7MrR5M/p/meQctLoKREn4CxqYsEA5LO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810762; c=relaxed/simple;
	bh=t2XhKDcOt+laEXJKI0ZnYMcUTY3NrTdNzuZY0B9gwa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqCIL5pWocvX/OpXQDEW5LB2UEgtvbWrYiTgE6VhvofN7ULtE8j6OU/7YVAEb6J5UdjD/YqkKwZGNcLd2yfDjnmYnUyL/IZJAAgp6Y5kYMAEm8JNMcIcfssyBKlZeTLUJ4gEEtWwDVdG5vOuMmEMVRWP3wZQ4iUhlUmgmvI0UUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oIgb/qKt; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-743ba48eb71so22615947b3.1
        for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758810760; x=1759415560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3t/i7G6sNLKCulldNQHYLFlpc4dAP8McL+RwiXOYYM=;
        b=oIgb/qKtzNG20IudvQHkMdpg78J7mR5whHJN11kqRfTI7Rwxbdh4teDfCJIzTDthYV
         LqFWXDHfq7mV7JGPezZkmiaiNBnFlrhi1XQJ0Vgh4cBepdTR5MLworBtXkWPtxiIpeLg
         fCluQPVHGI8m+bj2omQif9xnbn3D5MWkcy3bKuqN2ZT0/Vwv6tSDsM5xElNVwlpJsfE2
         oCwu+LwD7FaRaW3/sxTxvE+J9yLPuxMxArjHfJlFeys4AzuEKno1LMhOKHFvhkqegOQd
         Fhr2fNUcDG/pHRd2vvKzGxK0piUCf34UKHBekgbc4zjNGwQx7JSHDugFim2ZDaizPG03
         CO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810760; x=1759415560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3t/i7G6sNLKCulldNQHYLFlpc4dAP8McL+RwiXOYYM=;
        b=E6PWnQxSxcQMbK4AQL8a8KJEumVWXOdH/AFXRVqV4llOW9JagIL7SGXbI36JxwDXQg
         /bEa/9lQWkvC8r+7Ky02s+bL3jZRjyaHY0lRVp7ROjDlcH6yn55hOw4hUto5lRlRgpN+
         C/yX2V776vl658JM6VMEygr4q0/M//8PYWEjGJK02eAo4Q6GQ1v2OBkCbXxZDu89N9HK
         HXMMiAUUYadDFveFFfW+UBUBRpNLveYmFLyQmgddkjUhHJgbcX+LrPaDryJYW/ZOv7FY
         RxkmlkgXmQ0sYsil4ON3O5ENv1Jsab74eZCKr4b2Q0kPVRoOUUeeaifpeQLVAlf8aM/Y
         VPLA==
X-Forwarded-Encrypted: i=1; AJvYcCVaDCCytlf6jtUmH4BhNt0/B8zxK3Vsg4tY8jDhrfC3S/CVgzRY90PmTqXaWiqlp0L3RyWedie0LXCG@vger.kernel.org
X-Gm-Message-State: AOJu0YzLE5sJrDbB/+mY+EH/07/SwSjhf/qJT66aofJoAyQIPJ6ycZRk
	jN1yxEf+DlXtWKB/kdrrFlAt90b72AQQ9HPt26LUkZfwwkCqvPrZFDGs3b3P/uRFwsHFbSM3N1G
	adpLGVQnsnnjMVJO1KoSjBooTCpQoUuwu6369NGC/
X-Gm-Gg: ASbGncum3F8hI1CyyMCSl2vwFD/374VNsoEajMqK+C4lp4+VUQZUeBflZUv9eHR1+6s
	2tMXCnspcgQVOoVoyVcpZVyevTZDrpcc/nJedFBcc+qsZvxd7hr0//RfdZ7u8aclj/g/rKm81AS
	r8O8Mt1nss+HZwfd2BXibbqSEolLHkDEivHjo7ajf4v5Rhpj7HVv6koQTuC9XQR/8pntaTzbRvN
	exdFmSP1HUeAg==
X-Google-Smtp-Source: AGHT+IGPVZb8260WIN2V5Is62i24gV4aTIwROuDhQPAORW+WvMp6xmIWUJzg3WDP3IAyIAjWSew/LKrgoflQZygG3no=
X-Received: by 2002:a05:6902:1003:b0:ea5:b757:9641 with SMTP id
 3f1490d57ef6-eb3853fca26mr1716135276.1.1758810759200; Thu, 25 Sep 2025
 07:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922121818.654011-1-wangliang74@huawei.com>
In-Reply-To: <20250922121818.654011-1-wangliang74@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Sep 2025 07:32:27 -0700
X-Gm-Features: AS18NWC0x8CFQRjOZVU80gw3PZ5hWaNCl3XvXGEiSPqo83w7a1Av7fuCtK5U9es
Message-ID: <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix general protection fault in __smc_diag_dump
To: Wang Liang <wangliang74@huawei.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 4:57=E2=80=AFAM Wang Liang <wangliang74@huawei.com>=
 wrote:
>
> The syzbot report a crash:
>
>   Oops: general protection fault, probably for non-canonical address 0xfb=
d5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
>   KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead=
0000001f]
>   CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREEMP=
T(full)
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 08/18/2025
>   RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
>   RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c:8=
9
>   Call Trace:
>    <TASK>
>    smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
>    smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
>    netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
>    __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
>    netlink_dump_start include/linux/netlink.h:341 [inline]
>    smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
>    __sock_diag_cmd net/core/sock_diag.c:249 [inline]
>    sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
>    netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
>    netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>    netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
>    netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
>    sock_sendmsg_nosec net/socket.c:714 [inline]
>    __sock_sendmsg net/socket.c:729 [inline]
>    ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
>    ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
>    __sys_sendmsg+0x16d/0x220 net/socket.c:2700
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
> The process like this:
>
>                (CPU1)              |             (CPU2)
>   ---------------------------------|-------------------------------
>   inet_create()                    |
>     // init clcsock to NULL        |
>     sk =3D sk_alloc()                |
>                                    |
>     // unexpectedly change clcsock |
>     inet_init_csk_locks()          |
>                                    |
>     // add sk to hash table        |
>     smc_inet_init_sock()           |
>       smc_sk_init()                |
>         smc_hash_sk()              |
>                                    | // traverse the hash table
>                                    | smc_diag_dump_proto
>                                    |   __smc_diag_dump()
>                                    |     // visit wrong clcsock
>                                    |     smc_diag_msg_common_fill()
>     // alloc clcsock               |
>     smc_create_clcsk               |
>       sock_create_kern             |
>
> With CONFIG_DEBUG_LOCK_ALLOC=3Dy, the smc->clcsock is unexpectedly change=
d
> in inet_init_csk_locks(), because the struct smc_sock does not have struc=
t
> inet_connection_sock as the first member.
>
> Previous commit 60ada4fe644e ("smc: Fix various oops due to inet_sock typ=
e
> confusion.") add inet_sock as the first member of smc_sock. For protocol
> with INET_PROTOSW_ICSK, use inet_connection_sock instead of inet_sock is
> more appropriate.
>
> Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Df775be4458668f7d220e
> Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/smc/smc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 2c9084963739..1b20f0c927d3 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -285,7 +285,7 @@ struct smc_connection {
>  struct smc_sock {                              /* smc sock container */
>         union {
>                 struct sock             sk;
> -               struct inet_sock        icsk_inet;
> +               struct inet_connection_sock     inet_conn;
>         };
>         struct socket           *clcsock;       /* internal tcp socket */
>         void                    (*clcsk_state_change)(struct sock *sk);
> --
> 2.34.1
>

Kuniyuki, can you please review, I think you had a related fix recently.

Thanks.

commit 60ada4fe644edaa6c2da97364184b0425e8aeaf5
Author: Kuniyuki Iwashima <kuniyu@google.com>
Date:   Fri Jul 11 06:07:52 2025 +0000

    smc: Fix various oops due to inet_sock type confusion.

