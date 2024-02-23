Return-Path: <linux-rdma+bounces-1117-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21626861B32
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Feb 2024 19:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2C21F28712
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Feb 2024 18:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5C4141987;
	Fri, 23 Feb 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3f1YmZhl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3317D13F012
	for <linux-rdma@vger.kernel.org>; Fri, 23 Feb 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711784; cv=none; b=LIST/wSuMLzUHJY0XEAPi+WpXX1OnRpd6d8ddv29LN0xQv5nqBI7e1t57cihhFQDOJ9YH+YCATu1R0JblP7PtOy8Fr0wgLz4LyuMWjlqtBNRRyQIDEhoZLsXQ+WBneH4cWVEDXEjlYebVymuy1jpgCqzEc85SOvMOeYgZYiFqfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711784; c=relaxed/simple;
	bh=YerWNo1IvQT57CgOP1IhhejAzZdIcMAqyhFnZkjrJMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZBab60kWHWsqhsld6xxRDwO5GJ56hmEdw2LiWIBkF9w6rOizBh+n/MQrkpaSx09it6cUE/ObFhN+porqfaT7bOGefrR06z9+B4ywVwD9JFQyKvUB7HUMwNP2ttncxFFErfvlLpOiytiLm6CgBla+dAJylfeK+i+rRJG/PI4iWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3f1YmZhl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso293a12.1
        for <linux-rdma@vger.kernel.org>; Fri, 23 Feb 2024 10:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708711781; x=1709316581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzX4jxRTXKDG983WNUYBE978wFUHRMiTk7mCqZuSDfY=;
        b=3f1YmZhlY/d8r8AzzLqfmhTWh2dUgLL2NcNjIQ0LaCvzYfXMQ/BD5Fbdv7dqOZDlXl
         6YrIXTLXyPFoHDVu9TX1dSe5N5c1ujuhiYvd7sn4ZHS5yh0Sh56WyPnhB3N8P8zuzC2T
         r2vAIrbvQ5GzNcb1Hg/1po8VC+9h+Smv/mbG2f4/cibPnaxaxnEX99PrTi2mh12QphZw
         vhFvQl18lkGxPAw6yUbjq3LnUUvkS3/qbhnOv0MFmrrBZjfJ0YSPMRtQ/2B8jFS2a4hg
         krAVSk5FCqyhcerC8G1SEMWqMoPiaaQr3titJz84OqlC6mIdi0WGdka0jUJ93ddtdZHI
         cnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708711781; x=1709316581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzX4jxRTXKDG983WNUYBE978wFUHRMiTk7mCqZuSDfY=;
        b=HOwvDSdPpfotEPIgZpSbmoRJsD0cgEOmVM9WdjWTc/lyTnWFbqGBPQySQJPLKC8LnQ
         XlmOcHI13MzzzWZl+r5HS3eCXp1QnLahvaD06aXaLeTC12CEjoWqHrYMjl3jh+vlsJtb
         dBTu0wat8SlOQTaajCi+qIsWQFyEEJ/uY/ZKtc+XhY3h5wxjnt/WqEqQwnCt353mSVTT
         59FHrvSe2t4N0i43m0yNqRa9WldrdvEflas7dvM/WeFxD4OqWr/utQdlsN3MakNAxh9i
         Y99VxwxoaSUxLIL9t03Isr94CpQBAaa9KHWaUXgUlSMgiR0/f1t7VuGro2OOxjCL48sV
         0mVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8YAo1SGIJIRpR65aDhDcq7JTJtqSe323It6bBpgVJPgChoVRGa55rJ+YYwSXklYolXUY6xdgHzWOczUYh1SGrCSrLipYSgRbPOA==
X-Gm-Message-State: AOJu0Yx8NnaZ1D2ygQR1zFpOO1A4ZaYor5ytJpnXfShk0XjTvw+zs1E0
	ux82Sqm3JX731KoNnVz073dqQHD8YOJPMAZGxFwLA8gJ5qT8wVZrCQVu5Q6dAkiqoqQRyGKOB8O
	G07reteUmlw8ybNDmcdODTz+LIMaqXVkKlC71
X-Google-Smtp-Source: AGHT+IG1Wv1Ld5IAjxats+kxHJ5Mcmy/+6OrplzEMMMr5lmasOrVRaGfhzjJAbwxEbVxjHcQ7uIrCzhWNFCyCe5hqcA=
X-Received: by 2002:a50:c319:0:b0:563:adf3:f5f4 with SMTP id
 a25-20020a50c319000000b00563adf3f5f4mr14501edb.1.1708711781318; Fri, 23 Feb
 2024 10:09:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223172448.94084-1-kuniyu@amazon.com> <20240223172448.94084-3-kuniyu@amazon.com>
In-Reply-To: <20240223172448.94084-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Feb 2024 19:09:27 +0100
Message-ID: <CANn89iKD9i-UKABN2XVczfYsrSKC81VUVQH+eJxYGgdz42ExTQ@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>, 
	Sowmini Varadhan <sowmini.varadhan@oracle.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 6:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller reported a warning of netns tracker [0] followed by KASAN
> splat [1] and another ref tracker warning [1].
>
> syzkaller could not find a repro, but in the log, the only suspicious
> sequence was as follows:
>
>   18:26:22 executing program 1:
>   r0 =3D socket$inet6_mptcp(0xa, 0x1, 0x106)
>   ...
>   connect$inet6(r0, &(0x7f0000000080)=3D{0xa, 0x4001, 0x0, @loopback}, 0x=
1c) (async)
>
> The notable thing here is 0x4001 in connect(), which is RDS_TCP_PORT.
>
> So, the scenario would be:
>
>   1. unshare(CLONE_NEWNET) creates a per netns tcp listener in
>       rds_tcp_listen_init().
>   2. syz-executor connect()s to it and creates a reqsk.
>   3. syz-executor exit()s immediately.
>   4. netns is dismantled.  [0]
>   5. reqsk timer is fired, and UAF happens while freeing reqsk.  [1]
>   6. listener is freed after RCU grace period.  [2]
>
> Basically, reqsk assumes that the listener guarantees netns safety
> until all reqsk timers are expired by holding the listener's refcount.
> However, this was not the case for kernel sockets.
>
> Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
> inet_twsk_purge()") fixed this issue only for per-netns ehash, but
> the issue still exists for the global ehash.
>
> We can apply the same fix, but this issue is specific to RDS.
>
> Instead of iterating potentially large ehash and purging reqsk during
> netns dismantle, let's hold netns refcount for the kernel TCP listener.
>
>
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP listen endpoints,=
 one per netns.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/rds/tcp_listen.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> index 05008ce5c421..4f7863932df7 100644
> --- a/net/rds/tcp_listen.c
> +++ b/net/rds/tcp_listen.c
> @@ -282,6 +282,11 @@ struct socket *rds_tcp_listen_init(struct net *net, =
bool isv6)
>                 goto out;
>         }
>
> +       __netns_tracker_free(net, &sock->sk->ns_tracker, false);
> +       sock->sk->sk_net_refcnt =3D 1;
> +       get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> +       sock_inuse_add(net, 1);
> +

Why using sock_create_kern() then later 'convert' this kernel socket
to a user one ?

Would using __sock_create() avoid this ?

