Return-Path: <linux-rdma+bounces-19539-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BCfPCqcV7GkKUQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19539-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 03:15:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C690464676
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 03:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAE76300DDCC
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 01:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C12CA6F;
	Sat, 25 Apr 2026 01:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yrl5jp+/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1A17C203
	for <linux-rdma@vger.kernel.org>; Sat, 25 Apr 2026 01:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079714; cv=pass; b=Y/JgztJPit6s2FOWXbzekrO2FDLzCislYbGtPxD6PsSjtOjsYMYz5FuOFrTaf/Pr1oUl2KhVExuWEjgMwvBiWlOdpiP3hQf9qbowIOKblcOXPIkjBdomsouCpuvW7GqGHHKeTM0LN+CtD48tY9P0r11r+FjLD8qo6D4MAghtBhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079714; c=relaxed/simple;
	bh=lTe61+ZbYHn2PlVrI4qN30kL3kV6gG3b5mTNgspqjVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTkHgdl4aYxDXQWKbk84DkB2x1zVd8oEr6F5mXHeWQAgHos1zuxMeScpZr2lS6CC8LBqcyGKCW/ZqrJNVQc359iPxFfB6QAqLBOcSoXW8/XeNJ3ok0qf3PHQ83vNkmtcrz2vkaJ9xvymWuWATIWW5ozWRAzYaQvo/EjRSzQp+DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yrl5jp+/; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c1a170a50so10827713c88.0
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 18:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777079712; cv=none;
        d=google.com; s=arc-20240605;
        b=Ta0FV54ir7MDo52yuJ525d1/WKL0Yjufn+6zDeKD/n05JxHYinNF2fUMBlmCJgYLGn
         9t/PAlCTNQMM7eMq6GGm6esxPlatKYlx8AMQM6Nxu3W1g8s16RKkJ4sLmRxjUrPqO4SN
         RIvzJlcHyQoQ1ZUYGhiONMgauHzSXj4450iTWZEcsFB8mUCjMFj+bqBh/8iUQ089DpBe
         CDCEsBBxC+v+W2jB9pPAfiWb6GkuXJdaM7DEd/jkOOCzrSQQxefjkpi0h0x/EnINwQRg
         FlfSPgES3TkPKuKMauXByVxB6yzP001uIZpOq4PDsDsMQK0oUxaKpj2Sj2rXaZ2caYj+
         EPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7r36H0GFnJ7+4siXbyHwImHF2YLVRN2QNRYw5R3nOQg=;
        fh=QfhGvM3BjXeBaPYESp75yLMrOIpCm755tXqNxEM7MGU=;
        b=OFLTGyc8YAjwOEFII6Non3ao/UaBKdI8Xj20cYPhMnK3mo/Z1prILANw+VOloOnraY
         u6S8zugG41OX0mCbo29We78x5GqikoxNeVn/odVkO+ijxePP8JGTZ6zXH8G6+imlL1dV
         I+/53AkI382y9DPBFMHYzQLFiRxH0bUbguUSAT7gfEw+ModrzuFdNsPlyT8TXlZsqjcQ
         3bzedyz7hoMeY8zmtnXm8xYGnknzF7zpEeCP/LL/WQdOALyYI/PzLChoCHfJusu/ptFH
         2eVP2ghUupHzxwyENbaTMs18WgEAPiFNCAO9n0vBjS0C9mpxrf8mdILx4Fr8Pmg9CbfW
         K7pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777079712; x=1777684512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r36H0GFnJ7+4siXbyHwImHF2YLVRN2QNRYw5R3nOQg=;
        b=Yrl5jp+/a3dKLkiADqpU0puKBME2t1M3lmXSG5sKp1gfA2PEJ8PYilDFXWnRSqKfwj
         oYVXfeGeNYnlBy/yez2V4Wuo5BL1ADc6zrT3UQZ9YpnxP2ubtY8+dUHUdD3j37TWhh41
         k0Ery9nQ5U0kpOBC0Y7ny1gMDoC+DgtyP1dwjSXkETdcw4QH9pShE4Fw1jTXu7dsec+U
         NeZhlpOtdrTBPujzKqdTQBG1ug56mVOoTvDmnL1fd58FdSWnsggfpeAUqduvHxr/K256
         PA3HtEXF1SHXKY8v6uk45JXaGxztWC2yk7qY2zWJq4tPmodHJmpPMPIOMBWuajCliSuu
         rjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777079712; x=1777684512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7r36H0GFnJ7+4siXbyHwImHF2YLVRN2QNRYw5R3nOQg=;
        b=Nq0BfjQcdQ7z+G4iCttzpqIzPNCkRXoOZpKqWlpa6oX7AfJ1auqq022AxKCfrws06T
         SkGXMEXRRTYHFMMvdm7vvhj26vhrkFCBiLx7G9+9W1haYpaRbdjRSET6MJa5ePBb3RR5
         PMTMo1EFOsVxwEQEcbLr0dosLDD53eE1uzgRGXmXvxmiHZ1/UAdbCPxxmX4rYTYo4uZR
         PoklBo1PiZ/7SywZsQh+i/9/x217pwvPhQDf95AKjFFV0nASyNHpMHzij1opCo6/EIMh
         IQOuI9kn55inpq2Przj7c7JZz6UJjuON4DhPzY9Dz+Gme6xA3OYlZpeKUFBCQAM181GX
         MCNg==
X-Gm-Message-State: AOJu0YzUOvJGkLTn/hPkB8pL+VjsEohSaVNSJ85hdgyaMQPrzWLAWPwH
	p7OSHyTB9hJTNPoW4iqaE9orwJURrccrKqtkxdRUZSf/3teoRG6/D87VV4V3k0cJDExZrFKJIUb
	YKpP5K12G0Wr2J4YHyny7gyaMzv38WB4H7qW9dBSx
X-Gm-Gg: AeBDies85TkiHT/Ng35+oHamB6QQPKPuGorDaCW5WbpRYtVil/1N53iVrQ1r7MRsAiz
	XWVUG+AZu76Z4z48ojGNZtWXhkzoPsImqy+Z7MEkSr4DjVZOHkOpxedmyRlmXQRt7+HBP2Sks3e
	PG0k6WBCTOUnneJdWbYrMlOrU5InQOVtUN9bahs5oIpx0WM75B7AXFFRQpCuqfmF38zQzsCLdah
	qjvsQRgkGDjxl89cVD0mo5+XbmrKz/qw6Z8fAVOTdnn8Xj+i8zqqLXl3+FyftLn0kS+XVFXchyx
	yKFODsmkNEqKh46py2GpJij+V/HXwEOGsBDGoFi8OjXZ1MzRTDNXBHOVlYTvJia5rJopuR+mheo
	x3xPhegzyp9z8f+eFxt5DdkHndLlkjeUhE8fO1VgstlKJbmlZOrEQZhhuerJq1QxQLDDwbo01Xg
	==
X-Received: by 2002:a05:7022:6b8d:b0:12a:6a64:81d9 with SMTP id
 a92af1059eb24-12c73f723aamr17990214c88.13.1777079711571; Fri, 24 Apr 2026
 18:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69ea344f.a00a0220.17a17.0040.GAE@google.com> <20260425011228.363364-1-arjan@linux.intel.com>
In-Reply-To: <20260425011228.363364-1-arjan@linux.intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 24 Apr 2026 18:14:58 -0700
X-Gm-Features: AQROBzDf_odRFEVmahEw2wf6Cs0OKGs7p7bYafFnCU0ZIKo6as4qB3fXM9tOuzc
Message-ID: <CAAVpQUArvDSrcTCNDeFaJ2jRYE=BJUbM7uzHYs5ZCrfBvRB1OQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] general protection fault in kernel_sock_shutdown (4)
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6C690464676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19539-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ziepe.ca,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fenrus.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	SUBJECT_HAS_QUESTION(0.00)[]

On Fri, Apr 24, 2026 at 6:11=E2=80=AFPM Arjan van de Ven <arjan@linux.intel=
.com> wrote:
>
>
> Unfortunately the AI had a burp and did not write out the proper URL
> for analysis data; it should have been
>
> http://oops.fenrus.org/reports/lkml/69ea344f.a00a0220.17a17.0040.GAE_goog=
le.com/report.html
>
> and in addition, it made a candidate patch (below)
>
>
>
>
>
>
>
>
>
>
>
> From: Arjan van de Ven <arjan@linux.intel.com>
> Subject: [PATCH] RDMA/rxe: fix double-release race on UDP tunnel socket t=
eardown
>
> This patch is based on a BUG as reported at
> https://lore.kernel.org/r/69ea344f.a00a0220.17a17.0040.GAE@google.com.
>
> The Soft RoCE (RXE) driver stores per-network-namespace UDP tunnel
> sockets for IPv4 and IPv6 encapsulation. Two independent code paths
> tear these sockets down: rxe_ns_exit(), called when a network
> namespace is destroyed, and rxe_net_del(), called when an RDMA link
> is deleted via netlink. Both paths read the per-namespace socket
> pointer and call udp_tunnel_sock_release() on it.
>
> A time-of-check/time-of-use (TOCTOU) race exists in rxe_net_del().
> It reads the socket pointer via rxe_ns_pernet_sk4(), then passes it
> to rxe_sock_put() for release. If rxe_ns_exit() runs concurrently
> between the read and the release, it clears the pointer and calls
> udp_tunnel_sock_release() first, causing sock_release() to set
> sock->ops =3D NULL. When rxe_net_del() then calls
> udp_tunnel_sock_release() on the same socket, kernel_sock_shutdown()
> dereferences the now-NULL sock->ops, triggering a KASAN null-ptr-deref
> at offset 0x68 (the shutdown function pointer in struct proto_ops).
>
> A minimal alternative would guard against NULL sock->ops inside
> udp_tunnel_sock_release() before calling kernel_sock_shutdown(). That
> treats the symptom rather than the root cause and leaves the
> double-release of socket state intact.
>
> Add rxe_ns_pernet_take_sk4() and rxe_ns_pernet_take_sk6() which use
> xchg() to atomically swap the per-namespace socket pointer to NULL
> and return the old value. Replace the non-atomic reads in
> rxe_net_del() with these take variants, and release the socket
> directly via udp_tunnel_sock_release() without going through
> rxe_sock_put().
>
> Whichever teardown path executes take first claims ownership of the
> socket; the second caller gets NULL and skips the release, closing
> the double-release window.
>
> Link: https://lore.kernel.org/r/69ea344f.a00a0220.17a17.0040.GAE@google.c=
om
> Oops-Analysis: http://oops.fenrus.org/reports/lkml/69ea344f.a00a0220.17a1=
7.0040.GAE_google.com/report.html
> Fixes: 13f2a53c2a71 ("RDMA/rxe: Add net namespace support for IPv4/IPv6 s=
ockets")
> Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destructio=
n per net namespace")
> Assisted-by: GitHub Copilot patcher:claude linux-kernel-oops-x86.
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c |    8 ++++----
>  drivers/infiniband/sw/rxe/rxe_ns.c  |   14 ++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_ns.h  |    7 +++++++
>  3 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/=
rxe/rxe_net.c
> index 50a2cb5405e22..4f604636cb7b4 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -655,13 +655,13 @@ void rxe_net_del(struct ib_device *dev)
>
>         net =3D dev_net(ndev);
>
> -       sk =3D rxe_ns_pernet_sk4(net);
> +       sk =3D rxe_ns_pernet_take_sk4(net);
>         if (sk)
> -               rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
> +               udp_tunnel_sock_release(sk->sk_socket);

This leaks sk->sk_refcnt, no AI slop please.

I'm working on the right fix.

Thanks.

