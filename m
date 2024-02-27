Return-Path: <linux-rdma+bounces-1154-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F57868FAA
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 13:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675AE1F276E4
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB3B1386D3;
	Tue, 27 Feb 2024 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="caCQpkxQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917F13A24E
	for <linux-rdma@vger.kernel.org>; Tue, 27 Feb 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035582; cv=none; b=hJKLVQ6+SfD4fKBdHMVCSxm57xN2IRFcMUCW0kP5ZngVuarupk79wsl/x8SPz5tejnG9ptu3eROnBtP0VjjUm8m5S4XD0XVPzS0gOTqPvXAtkQPVZTVr0WOLFY+BfEyyrWocIAMJBYAmb43k4XrCcM+/blystwEpqjbr+hNByF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035582; c=relaxed/simple;
	bh=fHI1d6xBEkYiAA/ZAX2kHnxTAnTB85e+e5bYpERBO0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRyIzTOpvWaHaxBFdtJPTSLuchBpCVoOC8rUFjxKnsnPZlVbPK1Y48KQ5W/utvZsT2+V1bsvYCTtr0LGxunduPBtL2KMolVhfwsnf80pcEJArpbQEmY7+Z2Oh8XVfzhLWHtf+METthDTaZVE0D7B62XlJ0j7CWheO9dlXKN/kgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=caCQpkxQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso10383a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 27 Feb 2024 04:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709035579; x=1709640379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mng29kRLwMiV7HMfeAIuZCWaSGikFSk8b3VmpAQhE4g=;
        b=caCQpkxQrF7K4rcLb+H3U5AkmeHe9tT9nNVgZ+2L/lhCrFRLEDgB95QljSX8fDJTWb
         zSmBzPXu1t9vY8tiukeDI5kZ9Lzd0lORBaRJd/Xcr2ZU4gA2aROtHOfNtLP9FxM+55DY
         D6bDPKzZbWwoFvMrI5URmfSe40e8mxKp6e67zll+PbLmeJj17PfSX+3bBaUW3+3XW37O
         f5s6CW5qyaTugNXEU1a6CBQnejo8rfDjJIqfN7TnEctC7Jdbq1FfIblrfirm6jrceFNi
         8CCbz+/We86/SUQi6uy/hsyXEJSNTnAot+iogtNw8Z/eaR/n3Ufkp+VVOAtJmBmpQ1/A
         vBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709035579; x=1709640379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mng29kRLwMiV7HMfeAIuZCWaSGikFSk8b3VmpAQhE4g=;
        b=Bwu8NP3WpWRP+4X3UaIjE0z+X2lvjarYyySPZZrCWRcDgk3xLdIlmzLRI3QN5Piv+Q
         ZYMq5yQhV/SAJmAOmniNzce+r1Y5uYLfh8tSRlzXEja3b4P2Kdfz/tgNW5Jk1k/FSh6K
         THtkHk69hLG9QpiGPSH/DR/ec9cscc7ZNnhjSOK4ge0I6baNtGx6hUA3gpIMg/Bw38e7
         dJd+avgoODVpFWE+kLGFG9aU5UnqXFPlnRRXprodTQHyJuo13wjX69Wi+VShdPPDGY7K
         w3fNhbWOy7WHMwK7mloZf1K2hxilGxhu/xYT6WuVSudkqLYTrFtejUVU1EWDqcWO6/lE
         BTpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfevVL2Zf0Pe+yABbAERVyVdhAmxt7Vc92cApQyVyaq5uFuzY6UmCPWxUktE6I5ZWuO9r+TglsYE0Ug2vRRMitbyY9a6QhRLOQUA==
X-Gm-Message-State: AOJu0YyVc9cg07siq5o3bbPW1KQdzwdHaE+R3m2YvoIGhoJKFlNjfTPw
	C1czucOucPuHFPodIVN8jPueG4B7vd2pIpmE1o8TauaUxnguKPLfByw8EARLfzwhoTJJSHwyQcC
	RwU3sUXIgu0gV/5I6JBw2db4+RLaZAvXwm+7Q
X-Google-Smtp-Source: AGHT+IE5EcpHCbJ1Yg8IJ94Wwtxjam+g/DMGz8KiexN4BekXdHWEn5VGWYgoIxKj/607A0rXf+xzt2FRv+kLIlx3QG8=
X-Received: by 2002:a50:cd19:0:b0:565:4f70:6ed with SMTP id
 z25-20020a50cd19000000b005654f7006edmr172276edi.6.1709035578750; Tue, 27 Feb
 2024 04:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227011041.97375-1-kuniyu@amazon.com> <20240227011041.97375-5-kuniyu@amazon.com>
In-Reply-To: <20240227011041.97375-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Feb 2024 13:06:07 +0100
Message-ID: <CANn89iJErUHpaAqs=qzuD_WxqtBC1rqSh3n9sJ_zJKwHyPORmg@mail.gmail.com>
Subject: Re: [PATCH v2 net 4/5] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 2:12=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
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
> Instead of iterating ehash and purging reqsk during netns dismantle,
> let's hold netns refcount for the kernel listener.
>
>

> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP listen endpoints,=
 one per netns.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/rds/tcp_listen.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> index 05008ce5c421..2d40e523322c 100644
> --- a/net/rds/tcp_listen.c
> +++ b/net/rds/tcp_listen.c
> @@ -274,8 +274,8 @@ struct socket *rds_tcp_listen_init(struct net *net, b=
ool isv6)
>         int addr_len;
>         int ret;
>
> -       ret =3D sock_create_kern(net, isv6 ? PF_INET6 : PF_INET, SOCK_STR=
EAM,
> -                              IPPROTO_TCP, &sock);
> +       ret =3D __sock_create(net, isv6 ? PF_INET6 : PF_INET, SOCK_STREAM=
,
> +                           IPPROTO_TCP, &sock, SOCKET_KERN_NET_REF);
>         if (ret < 0) {
>                 rdsdebug("could not create %s listener socket: %d\n",
>                          isv6 ? "IPv6" : "IPv4", ret);

If RDS module keeps a listener alive, not attached to a user process,
netns dismantle will never occur.

I think we have to cleanup SYN_RECV sockets in inet_twsk_purge()

Yes, it removes one optimization you did.

Perhaps add a counter of all kernel sockets that were ever attached to
a netns in order to decide to apply the optimization.
(keeping a precise count of SYN_RECV would be too expensive)

