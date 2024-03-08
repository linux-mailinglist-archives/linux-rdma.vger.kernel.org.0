Return-Path: <linux-rdma+bounces-1337-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DED8768A0
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 17:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6F5284BE0
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0144A7484;
	Fri,  8 Mar 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzVfYdjN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE638833
	for <linux-rdma@vger.kernel.org>; Fri,  8 Mar 2024 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915756; cv=none; b=F4wcYTbSUpaHsNGu6BYAbkl+LFPQbBfI9POOgDulHF1Rij/a9J3YBFTflTdFcEyEZS6IIRYVIAw29b5x7M4sY3GiFnqU40JeVpUbxlOCf+nr4/ls1/X8xc66Qk5fDd17M1GHDovHKhy92PTv5WTFOAlLF6KTreygfS1DwOMj9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915756; c=relaxed/simple;
	bh=uPrbF5Ox+vu7iho9eTuH6+EGw3QQLXcCKp9k7gJ6hkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCELrJT+WSL1k6vzrj6Iv7qTJ1eRfKUTJFEqxy3aea1gKWeIzcxPepITfxT7953HsK8txx32D050X3XrUxV5AC4fpu47nAw3irqQTxViuNZCLW7P78HLDhz85gAeuT7nuLIC3iO8XoCkPdfc4A6wzDH5lXNIIM/hQsgsPaCY/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzVfYdjN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412d84ffbfaso81805e9.0
        for <linux-rdma@vger.kernel.org>; Fri, 08 Mar 2024 08:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709915753; x=1710520553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOrfDN6DUS3z6W9USMXm9TDcYeYmwzsYtsqCm4dDnZg=;
        b=dzVfYdjNq3Dh6DyWMHWYU8s1lO61YavkdrhiDCqYDbGVL0Mmj/HvXnidi52vHJa480
         3GOHpE2zlnqlMPk3R+2fAWYPPUOLnhInjWO2lnsRUU44OLzvf/vE6y5T7a0jdt56fgJV
         Wm0ZCTFvlIZjjC+m6haNDLtPExXMLZIvehpCr32lJpL5Bnbd0Auw/zK/OLk/P/eXNWC6
         bGM5+Dbe+h3Nh4ttNX95b2GGIJIjH1CPcjO2lnDrIQo2yr2Gw/5y4tkDZzSzTTxWe/M1
         mm1oDmSZZ8AcnCbvVUFY8WrfF1E/xfEBjBFeLj8n5j/+QT5qvOdOm9KtbmuECJnoRu6U
         fUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915753; x=1710520553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOrfDN6DUS3z6W9USMXm9TDcYeYmwzsYtsqCm4dDnZg=;
        b=XTn5DFHzg7nLOH1RArCsli8tZDFZCCLYShcH02QOSFEFg0iD7AnZYHYB1JBD6MDOqu
         0+N0zqa0mp1Ap2rLK2gjZL5L4V6/konQXkTLtzOK1kQqjXAHBw/4bn8tRU5e3QiRsH7R
         qvwgGQSm8BzGsKchNn0mIg5Az8hj8/W1Asjcpxv693wSDHG05KYRuhIcSTWIFtcbuJYt
         wX9wn6/PEemsiB1T3rClC72UA1Li8MNPdgxUtaOFFmdOL/lETatSD2aNPBQXLyAq0uCr
         rs2OsJs04q7gWiZlmVYBlpTQvWaf3YxGOEtwmiSRnFJZhKiLR8F1a8Tx4Mhv8fgo0Zki
         D/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeXESCL+5hlcbJGAVtyf3onWRRoqMiKs2Ah8Kxy12W7ODlHlgPpJ9iw/VtbqKZK/IZy8OmWVbD6WynwSaE83CpEncFfWjm4gFwOQ==
X-Gm-Message-State: AOJu0YwIy216iZCaZHzi2yfxgZUyc3tnS2Qfi5OVspmUmP89EMXLAxHb
	4/EpR81SBUOea9xwL61+eqnKKfrn0KiypoQNzFT5wGl+sc++p6TfN8sg6DuippDqOxQTAxbmaXq
	3kT0xdyezs8e0VwgY2LpadA+dk6NOEMRB5Ybw
X-Google-Smtp-Source: AGHT+IHdakyT4e0JlZTyQbtpCNBcXQ7oNKHV5piu7RFZMfMFIO/kn47LAhQvRuuSursHH0bszERdJesVIKZzJSg6K4g=
X-Received: by 2002:a05:600c:5104:b0:412:e492:7e5 with SMTP id
 o4-20020a05600c510400b00412e49207e5mr420406wms.1.1709915752445; Fri, 08 Mar
 2024 08:35:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307232151.55963-1-kuniyu@amazon.com> <20240307232151.55963-2-kuniyu@amazon.com>
In-Reply-To: <20240307232151.55963-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 17:35:37 +0100
Message-ID: <CANn89iLvFuuihCtt9PME2uS1WJATnf5fKjDToa1WzVnRzHnPfg@mail.gmail.com>
Subject: Re: [PATCH v4 net 1/2] tcp: Fix use-after-free in inet_twsk_purge().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 12:22=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
> inet_twsk_purge()") added changes in inet_twsk_purge() to purge
> reqsk in per-netns ehash during netns dismantle.
>
> inet_csk_reqsk_queue_drop_and_put() will remove reqsk from per-netns
> ehash, but the iteration uses sk_nulls_for_each_rcu(), which is not
> safe.  After removing reqsk, we need to restart iteration.
>
> Also, we need to use refcount_inc_not_zero() to check if reqsk is
> freed by its timer.
>
> Fixes: 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in inet_twsk_=
purge()")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/inet_timewait_sock.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index 5befa4de5b24..c81f83893fc7 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -278,18 +278,32 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo=
, int family)
>  restart:
>                 sk_nulls_for_each_rcu(sk, node, &head->chain) {
>                         if (sk->sk_state !=3D TCP_TIME_WAIT) {
> +                               struct request_sock *req;
> +
> +                               if (likely(sk->sk_state !=3D TCP_NEW_SYN_=
RECV))
> +                                       continue;
> +
>                                 /* A kernel listener socket might not hol=
d refcnt for net,
>                                  * so reqsk_timer_handler() could be fire=
d after net is
>                                  * freed.  Userspace listener and reqsk n=
ever exist here.
>                                  */
> -                               if (unlikely(sk->sk_state =3D=3D TCP_NEW_=
SYN_RECV &&
> -                                            hashinfo->pernet)) {
> -                                       struct request_sock *req =3D inet=
_reqsk(sk);
>
> -                                       inet_csk_reqsk_queue_drop_and_put=
(req->rsk_listener, req);
> +                               if (sk->sk_family !=3D family ||
> +                                   refcount_read(&sock_net(sk)->ns.count=
))
> +                                       continue;
> +
> +                               req =3D inet_reqsk(sk);
> +                               if (unlikely(!refcount_inc_not_zero(&req-=
>rsk_refcnt)))
> +                                       continue;
> +
> +                               if (unlikely(sk->sk_family !=3D family ||
> +                                            refcount_read(&sock_net(sk)-=
>ns.count))) {
> +                                       reqsk_put(req);
> +                                       continue;
>                                 }
>
> -                               continue;
> +                               inet_csk_reqsk_queue_drop_and_put(req->rs=
k_listener, req);

> +                               goto restart;
>                         }
>
>                         tw =3D inet_twsk(sk);
> --
> 2.30.2
>

Unfortunately  inet_csk_reqsk_queue_drop_and_put() also needs the
local_bh_disable() part.
Presumably this code never met LOCKDEP :/

What about factoring the code like this ?
(Untested patch, only compiled)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 5befa4de5b2416281ad2795713a70d0fd847b0b2..21a9b267fc8b843f8320767fb70=
5de32f2c7b7b0
100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -265,10 +265,9 @@ EXPORT_SYMBOL_GPL(__inet_twsk_schedule);

 void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 {
-       struct inet_timewait_sock *tw;
-       struct sock *sk;
        struct hlist_nulls_node *node;
        unsigned int slot;
+       struct sock *sk;

        for (slot =3D 0; slot <=3D hashinfo->ehash_mask; slot++) {
                struct inet_ehash_bucket *head =3D &hashinfo->ehash[slot];
@@ -277,38 +276,35 @@ void inet_twsk_purge(struct inet_hashinfo
*hashinfo, int family)
                rcu_read_lock();
 restart:
                sk_nulls_for_each_rcu(sk, node, &head->chain) {
-                       if (sk->sk_state !=3D TCP_TIME_WAIT) {
-                               /* A kernel listener socket might not
hold refcnt for net,
-                                * so reqsk_timer_handler() could be
fired after net is
-                                * freed.  Userspace listener and
reqsk never exist here.
-                                */
-                               if (unlikely(sk->sk_state =3D=3D TCP_NEW_SY=
N_RECV &&
-                                            hashinfo->pernet)) {
-                                       struct request_sock *req =3D
inet_reqsk(sk);
-
-
inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
-                               }
+                       int state =3D inet_sk_state_load(sk);

+                       if ((1 << state) & ~(TCPF_TIME_WAIT |
+                                            TCPF_NEW_SYN_RECV))
                                continue;
-                       }

-                       tw =3D inet_twsk(sk);
-                       if ((tw->tw_family !=3D family) ||
-                               refcount_read(&twsk_net(tw)->ns.count))
+                       if ((sk->sk_family !=3D family) ||
+                               refcount_read(&sock_net(sk)->ns.count))
                                continue;

-                       if (unlikely(!refcount_inc_not_zero(&tw->tw_refcnt)=
))
+                       if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)=
))
                                continue;

-                       if (unlikely((tw->tw_family !=3D family) ||
-                                    refcount_read(&twsk_net(tw)->ns.count)=
)) {
-                               inet_twsk_put(tw);
+                       if (unlikely((sk->sk_family !=3D family) ||
+                                    refcount_read(&sock_net(sk)->ns.count)=
)) {
+                               sock_gen_put(sk);
                                goto restart;
                        }

                        rcu_read_unlock();
                        local_bh_disable();
-                       inet_twsk_deschedule_put(tw);
+                       if (state =3D=3D TCP_TIME_WAIT) {
+                               inet_twsk_deschedule_put(inet_twsk(sk));
+                       } else {
+                               struct request_sock *req =3D inet_reqsk(sk)=
;
+
+
inet_csk_reqsk_queue_drop_and_put(req->rsk_listener,
+                                                                 req);
+                       }
                        local_bh_enable();
                        goto restart_rcu;
                }

