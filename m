Return-Path: <linux-rdma+bounces-17666-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GvceABWiq2lEfAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17666-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 04:57:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798B22A03A
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 04:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C97F73022F7A
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 03:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBCF328260;
	Sat,  7 Mar 2026 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWYjhfxw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97343290AD
	for <linux-rdma@vger.kernel.org>; Sat,  7 Mar 2026 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772855819; cv=pass; b=OkIC/muZgJbjbv1zBp+/Po6+h3HHpLdkCJyP0x75qgZMoBOuqMBcWIhA3Jfo3l4bXI1bnpA/ApGtOIXxwPzdjZoQzPNr2hsV/pkHZqA+4W+3P4SFvRIfH/xTZ1qYTGo0aVICMzFLite/62BBs4HDlcROvieFxcgANASfDEqiIQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772855819; c=relaxed/simple;
	bh=+YqGUeipYWqmWrLE2oeW+THGWpKHPiQu0Eq0PtmykIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCWEtUgmblZLWf1eCbEdclB1Tw/PP636oRQDjvwmHfd0kh0vGg0IlbDr6xMJA+HocRQMhX325yN1+Kr3tjL7LMc1/I1Dzqr9G977faIp/6IBTcA3P/tbG309/0viZUa2FTVplHm6GDHlg2cC9YD9WoDnn9CJQ/b737KAz1ss1f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eWYjhfxw; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89a000f5adeso112058716d6.3
        for <linux-rdma@vger.kernel.org>; Fri, 06 Mar 2026 19:56:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772855816; cv=none;
        d=google.com; s=arc-20240605;
        b=T55X6PjSqW4vs3kwHiJFJMfTocwMu6mtswTPuSofjyODVYip1qqkGtpPOHMV9vr7/W
         ckXhIZNQ8+ojoAwuEMHZNijICw2LyUabEGoZLlCsGTNpn+m0N6i8z18MVv6kEoOwFNtk
         hMhN5Fiz8prnY1oEiYcaZTNmu3wIlVp8zD5W58gBSfd0EdZRqwvgQzr/p0JN8evIJjZj
         07G+rqw+bIAK75EgungLtRd8WxmL8o7yEI5h8HOQsBkhZHjV9tAQ6Vo/790aqm2s4FWg
         dkXqZjabTdIqPYJgTZbTD04wy/1xHAlTykRXw9ogvT/jw4Fxx5kzi5TXGyxtAF9reAB5
         BLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=37+f+iNxTBvZkkOYj5LNOiKZe8rFt1xADvJtvYfXxU8=;
        fh=C7corRCN1GJv0DtLgAV1ubyjZIMgQZE6ZeQmuDQ2jYk=;
        b=lXLsZ2//s98+osLa0p2Yo5AYVJj9aB3VuuFXchM/oI18XFFd+WZ1Loag7dS/r879IC
         tO56qhxtm5p0iYoBACtE4xvFlghWv5Nw3BmMzklB/HjPeyIfK11NbXUIYI7UHX+yYIHS
         ZAvtcPHmq4dGYgpO6w87HsF0Wv+5bIJscAf0KtWKVqXcWD9JHr9fruYkJqxPD93YItFL
         vFjnhV0ImeZksGX+B7CtRxktrLK7ixQZTgd6IrPP0gA9IHdDRwa3onVrv0o/k8jTLv46
         nDg4DTCGC21XsAduDBzPIZr7qWoCxnpFMIMAejrySIDB+lQgHsFB3tMlWFUgXHfQJ5TB
         7p0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772855816; x=1773460616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37+f+iNxTBvZkkOYj5LNOiKZe8rFt1xADvJtvYfXxU8=;
        b=eWYjhfxwjnUo/PJRRf0msriePbFMV32NKdzCcxTwYCOr8FwdV471Pvmh8ErvJdA87g
         FVqRS2JUlDnWxLpi4ssJ7mOfQ8+MzQNsAwlvHGnY52FAHEcjTB4FJlj3T3HzID+vnlP7
         nE6/uK5JdBOr5QLFbKLDI5M6he2pfLmUlXkWoyCwgoRcFM8jpvoIPrPxERbVPhqSRSlK
         jCBnjQm8iIC3lkABhhXlmRZwYAfPO21ce402NR6FGDpG8r2I1+olKm66gebPyKEjtcji
         0QamAg7mJt2EPJJ7mlQiT4rhZYblDAehyWRhwQNFTV8lojfC7UQHUD2+cLiAQGXL5rs9
         arsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772855816; x=1773460616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=37+f+iNxTBvZkkOYj5LNOiKZe8rFt1xADvJtvYfXxU8=;
        b=n4BnJYByHxN/CnwSPvmWocxKVxijlrn775VtlikRINq3jCrt2h3BdauGjasCuZAMNM
         mqOK0o8Fkq38WL8BNbGIazRIpIwUSTzeiEsqWOV0k64My57KYbJY5im7JODjhY+GchL1
         SrLQR4GHxiXI2lSC//ZGHBC+uTRbMZ0ctBMZe7eiVFeaOlX/z0aC4RNX9dFS4pQwsKGo
         FHMjhtciW7hvBaGFJpsoJG2y+la/cBYLAJsYNGB+ZgeRB3Bu+LNO9m5Vi97U/W3vHfdC
         xm8df48tkhfJpCG+/e619KXzsbv9EztnnDnf/S6JW0QwiYE0afchfd6kouyhUkPM0nkC
         3R1g==
X-Forwarded-Encrypted: i=1; AJvYcCU+vwf4oa4aDyGEu+O+1kHq05DhRaXUyIPGp62Al5WkhBGId5kMFORPjvMBg/rFT4NZup3wjVSa1No2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81l6dly55WHXYkuN+1S2WEehlSzvSxuSbW+uy9N0xpv3HXZHT
	KS9ZXtVEFHQ3Xe2qEBA8Ntk2RyHqgPl3gpat+XaRmAs2EB+esvV9hII493LCQZYq9LPaecMOwfA
	dJJ2ipARD64yV0jB7C37Epi59sSE6YstzC2D3KCdC
X-Gm-Gg: ATEYQzxrS6CE/jcpeMY7rTiknPBevop+9LchZ2hhjlSSPAMhQYENAAd+yv5Xm0TdoPl
	02KAfS/Rgpd1HseBumX4gWhD4qSAHOgZh8NM4Sq9ZxIyVgy9Htyx+yzUQto8A5/3NRGrhBtG3tp
	N7Dt1oionGbdmElHgZ50BTl1sejwjpdnXMR8FooxJ+Q4/48gVlK6B3Wvdv+8K37c0FuFuUmKKA/
	RhchHx7eySwEcxO8AdvfA8Fkf8KkIp7X0M/7a/DoCC5y2ciSU3crPeSuNZw061P/MnqsE8+uJXq
	EYnODxbZ
X-Received: by 2002:a05:6214:c6d:b0:899:f6a0:7a6e with SMTP id
 6a1803df08f44-89a30a1751dmr64828556d6.9.1772855816216; Fri, 06 Mar 2026
 19:56:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307032158.372165-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260307032158.372165-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 7 Mar 2026 04:56:45 +0100
X-Gm-Features: AaiRm51ElVeY3JClqi6sIJpTbU0I15M_lz5ZJaTnV56OEn-A2dcPlGYd14B54AI
Message-ID: <CANn89iJ0V6un1un7zjG-J9d4EJQOjTO37s3EQUKTodwPWsXhFQ@mail.gmail.com>
Subject: Re: [PATCH net v1] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, 
	syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1798B22A03A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17666-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email,linux.dev:email,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 4:22=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> Syzkaller reported a panic in smc_tcp_syn_recv_sock() [1].
>
> smc_tcp_syn_recv_sock() is called in the TCP receive path
> (softirq) via icsk_af_ops->syn_recv_sock on the clcsock (TCP
> listening socket). It reads sk_user_data to get the smc_sock
> pointer. However, when the SMC listen socket is being closed
> concurrently, smc_close_active() sets clcsock->sk_user_data
> to NULL under sk_callback_lock, and then the smc_sock itself
> can be freed via sock_put() in smc_release().
>
> This leads to two issues:
>
> 1) NULL pointer dereference: sk_user_data is NULL when
>    accessed.
> 2) Use-after-free: sk_user_data is read as non-NULL, but the
>    smc_sock is freed before its fields (e.g., queued_smc_hs,
>    ori_af_ops) are accessed.
>
> The race window looks like this:
>
>   CPU A (softirq)              CPU B (process ctx)
>
>   tcp_v4_rcv()
>     TCP_NEW_SYN_RECV:
>     sk =3D req->rsk_listener
>     sock_hold(sk)
>     /* No lock on listener */
>                                smc_close_active():
>                                  write_lock_bh(cb_lock)
>                                  sk_user_data =3D NULL
>                                  write_unlock_bh(cb_lock)
>                                  ...
>                                  smc_clcsock_release()
>                                  sock_put(smc->sk) x2
>                                    -> smc_sock freed!
>     tcp_check_req()
>       smc_tcp_syn_recv_sock():
>         smc =3D user_data(sk)
>           -> NULL or dangling
>         smc->queued_smc_hs
>           -> crash!
>
> Note that the clcsock and smc_sock are two independent objects
> with separate refcounts. TCP stack holds a reference on the
> clcsock, which keeps it alive, but this does NOT prevent the
> smc_sock from being freed.
>
> Fix this by taking sk_callback_lock to read sk_user_data and
> then sock_hold(&smc->sk) under the lock to pin the smc_sock.
> The lock is released immediately after sock_hold(), rather
> than being held for the entire function, to avoid holding it
> across ori_af_ops->syn_recv_sock() which creates child
> sockets and could risk deadlocks with nested lock ordering.
> sock_put(&smc->sk) is called on all exit paths after the
> hold.
>
> [1] https://syzkaller.appspot.com/bug?extid=3D827ae2bfb3a3529333e9
>
> Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@goo=
gle.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/smc/af_smc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index d0119afcc6a1..21218b9b0f9a 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -131,7 +131,14 @@ static struct sock *smc_tcp_syn_recv_sock(const stru=
ct sock *sk,
>         struct smc_sock *smc;
>         struct sock *child;
>
> +       read_lock_bh(&((struct sock *)sk)->sk_callback_lock);

This will not survive a SYN flood attack.

Please use RCU instead.

>         smc =3D smc_clcsock_user_data(sk);
> +       if (!smc) {
> +               read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
> +               return NULL;
> +       }
> +       sock_hold(&smc->sk);

If you must take a refcount, use

if (!refcount_inc_not_zero(&smc->sk->sk_refcnt)) {
  rcu_read_unlock();
   return NULL;
}


> +       read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
>
>         if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_=
hs) >
>                                 sk->sk_max_ack_backlog)
> @@ -153,11 +160,13 @@ static struct sock *smc_tcp_syn_recv_sock(const str=
uct sock *sk,
>                 if (inet_csk(child)->icsk_af_ops =3D=3D inet_csk(sk)->ics=
k_af_ops)
>                         inet_csk(child)->icsk_af_ops =3D smc->ori_af_ops;
>         }
> +       sock_put(&smc->sk);
>         return child;
>
>  drop:
>         dst_release(dst);
>         tcp_listendrop(sk);
> +       sock_put(&smc->sk);
>         return NULL;
>  }
>
> --
> 2.43.0
>

