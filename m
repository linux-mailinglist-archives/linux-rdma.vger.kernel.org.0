Return-Path: <linux-rdma+bounces-17259-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPUxIHzWoGl0nQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17259-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 00:25:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F6F1B0E18
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 00:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8637F3016B98
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B38431B122;
	Thu, 26 Feb 2026 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eGEm9YrP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9D8287E
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772148344; cv=pass; b=coPudrDjTX9mHH5d+IdekhZEUEBheWvZblyLEdIg1H1o/y77KZd6A9ITS0eGMeXvocGwyPbQm+h/BmSTMJpkNkvqk3bGTAtvou4oUWpLGapGxYB751D2RANG3r5dtdDVmTS9XFpNO5z9HjAckVKhOaqNV3+PCfJ0NS13UkA8Dr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772148344; c=relaxed/simple;
	bh=fKEN7m274g2FOvgWDmD5sdNxcW6bHpUV80grnqbWDQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLXqW6muTcsTQRxPqZbSgs+dPG7Ah+exAsx4pZ1qrGpOlIVF7D6O6QaGcofeZ1NiPRth683FnCgOI++VykzC4H9+8LVIOYG8FthAQRJ5rstVwPjSovtK4X267R2nwWHwPe0FYkBZctZApa09Gz09sdnZhFsuOlGZr2em1S7smjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eGEm9YrP; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7947cf097c1so14810017b3.2
        for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 15:25:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772148342; cv=none;
        d=google.com; s=arc-20240605;
        b=cFmPTlC/USFfCg1rDhfWeDDShOpZgTHrspD8WeeZwamMG5/ZEgXXILmmvEqQRUWpRA
         XSQW4XE9oinKcKL7jv91GRBdxrsIyL5ikEdsIC33EB1KNHmw691GdcX3Rrub7ieKIxXk
         iv91MeqowcLPeJbWZPcaJQbs0V1W4KFuDiT+eC/I+6Jep84mleseRGP5bYuhnQQxuVEV
         5RwsxbW6TrwpxDEo/4AqOll97qAKq5/zfDDhfLQfoFM7VxWIxX/3DLWstdFdNLqnSZrL
         sIpZgmfAXJtahd2Bj/xJ6lEvRFC3fW0+sJfwSf9h72ccqFgnOIeRmKISXE6wJF3PNqbj
         rb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RA9ZhPtteEti8GBIEl7r2i+X0yhHEMSgTXlmvWuYNUM=;
        fh=hJ6arDlaYC+Osj6zLvFTJ5zVlS4RYvD7TxtESMIPAAI=;
        b=bE5hg7j2JLVCyANjOL7vfC7LOA/HHNx3Z8+JnXQPYdM2WnyXQpEvFrUeJKptcpVUg2
         KVpkX8A7lLW8YCLWbFJybOUjPqpuzW3kFO+4moZbuCdvlcih7qw+rvdYNWHoGLKyl7dF
         +D4IbFItcWayCPul0V8u2Sj0x0wAWb1gfpggCEFDFrPeU260HSYzZb3loBRduAjy5I97
         yjIGg11ERaq1TRIBKln6w6H5Ftap4ru/3mv9Y6zUF28xEx88gW5Ls6758/iRRxnN5DfW
         Plh3a7XCcwHRmcJ47CwXtIrE/PTILO8Ww3mMMQQOYzgww3Hcw8YU0w77PkCmbtysSfmi
         SYzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772148342; x=1772753142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA9ZhPtteEti8GBIEl7r2i+X0yhHEMSgTXlmvWuYNUM=;
        b=eGEm9YrPBH9UT4gKVrl8GfB7soAVA24EhWRqFQg1ow68GFbn2OlEBY5+KOHucUWCFj
         cQU4teBNyVmFMOT+8H7ks0D7d633c340hjFp4+VllwfWBNlAKvru1vW7iOFa9F5M6L4W
         /AG4jtWaWnCeT0cU/qiFfuRezO8z3MOaL/MnBKi8u4bsmDKqTqTZgrlfIdNWU2OBN0dF
         iuEB+1efiA8MHJDKxhxRJfpBFYxrjNVBP2oKjsxljnvETCehl4RbD381mVBZVnrdUpXw
         lM5+FQAkcSO1qylSco/t4OAEHGFxKNzd+OxNYkIeJ389Sg6Wo3sN6R3SPltJc9cRxazu
         CflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772148342; x=1772753142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RA9ZhPtteEti8GBIEl7r2i+X0yhHEMSgTXlmvWuYNUM=;
        b=BEYEW2OElc3EJLgKNWw2eA7VpsgrNuNQLHtdUikI3snzdW6hROiaAj8yVH3AbhWpx5
         5PXLdyeAjimCWHYOQOQNG2ACemHQ7jpJGc8B40GyiFM2g+Ddbt4+3hMCk/zuZSfzCORm
         TQx8uRD8UM/RBR81WjbVCCWlmFkIwUoxQxtWcUDUiTEORE2dCoUSGDTiPsVMn9hTLhW2
         CbUkbPqzAdbpfZW74CHfgIviJnMZkNQmacmfet1YyxDFKcpGvHeUBrymYG1sE9IiYs+u
         wmwekObDDu5Uy5mvhDYs3jSc7Sib7G9t53p5bUqPoSApMw9ZXk4g6iYy0SMUnDLU9mZC
         QlrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxf/HDG9Ipn4ocNGIgB08IGi1gJiKQt7RoqnzqXoNT4YvYv0vPCJc3MpO9wpc2jtVKVJoXmUcNQBp0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkjxpphj50f6mTvGc3kLRiC+7rBcXbPciWHTusEvfEr24v0ymh
	XWVa2Y27ROvVwyRBhvEOs/ij++HlV+kD/OYPN8RM3cAQ0q/ib4Wjv2J4nRKMmZObGlSqHd0Ut7s
	8ohdohcOFZW9dEuKPc1OZak51iYdrgPSLrwPTWWpS
X-Gm-Gg: ATEYQzzDi3bL0qO9M+K44JnYeGn6AyoFQtKwN/4jP2lagt1RMoSDD9qTDDIFtYZXFwv
	oJt3IJITY2NYoaXn2fQfhN4HibMZYz08DA+aLn2ZQI8inCmsvwpqr0PYEbTWWd6CWza7ZNP8hVv
	Z7q6Jj5lc7IHHKKG3qrEjLUvet1isiPOgnpdYkOsv93QC0kjiOR2a+Hkfi28BwdgBlcnINswn8F
	XSpBULsfMjiuYOpkYUyhA2p+89U2l3XVoTPJolLsSMCO1uf/Pus+7WKEJ8NuwNSt4eGBS1m7fzw
	h0Q9bl5DLeI2cZ59Fhj0SGY6DdYSI0h5Lb5/C8MF
X-Received: by 2002:a05:690c:d83:b0:796:3977:9f28 with SMTP id
 00721157ae682-798855da97bmr10368887b3.51.1772148341487; Thu, 26 Feb 2026
 15:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226213454.85586-1-achender@kernel.org>
In-Reply-To: <20260226213454.85586-1-achender@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Feb 2026 00:25:29 +0100
X-Gm-Features: AaiRm503t44yYtqzVG2hHOZcr0Eczfg-LoG2ToaT51Z1g1hmiCtsxqgH8nuFLs4
Message-ID: <CANn89iLGtL+Mka4dww-y+vZpqggMhsNzp5XJbo3RB6RG7=Tgbw@mail.gmail.com>
Subject: Re: [PATCH net-next] net/rds: Fix circular locking dependency in rds_tcp_tune
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, pabeni@redhat.com, 
	rds-devel@oss.oracle.com, kuba@kernel.org, horms@kernel.org, 
	linux-rdma@vger.kernel.org, allison.henderson@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17259-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 21F6F1B0E18
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:34=E2=80=AFPM Allison Henderson <achender@kernel=
.org> wrote:
>
> syzbot reported a circular locking dependency in rds_tcp_tune() where
> sk_net_refcnt_upgrade() is called while holding the socket lock:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> ------------------------------------------------------
> kworker/u10:8/15040 is trying to acquire lock:
> ffffffff8e9aaf80 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_noprof+0x4=
b/0x6f0
>
> but task is already holding lock:
> ffff88805a3c1ce0 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: rds_tcp_tune+0xd7/=
0x930
>
> The issue occurs because sk_net_refcnt_upgrade() performs memory allocati=
on
> (via get_net_track() -> ref_tracker_alloc()) while the socket lock is hel=
d,
> creating a circular dependency with fs_reclaim.
>
> Fix this by moving sk_net_refcnt_upgrade() outside the socket lock critic=
al
> section. Since the fresh socket is not yet exposed to other threads, no
> locks are needed at this time.
>
> Reported-by: syzbot+2e2cf5331207053b8106@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2e2cf5331207053b8106
> Fixes: 5c70eb5c593d ("net: better track kernel sockets lifetime")

Are you sure this is the right Fixes: tag ?

Before this patch we had a GFP_KERNEL allocation already ?

This might instead come from

commit 3a58f13a881ed351198ffab4cf9953cf19d2ab3a
    net: rds: acquire refcount on TCP sockets

> Signed-off-by: Allison Henderson <achender@kernel.org>
> ---
>  net/rds/tcp.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index 04f310255692..da22b3dfdbf0 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -490,18 +490,24 @@ bool rds_tcp_tune(struct socket *sock)
>         struct rds_tcp_net *rtn;
>
>         tcp_sock_set_nodelay(sock->sk);
> -       lock_sock(sk);
>         /* TCP timer functions might access net namespace even after
>          * a process which created this net namespace terminated.
>          */
>         if (!sk->sk_net_refcnt) {
> -               if (!maybe_get_net(net)) {
> -                       release_sock(sk);
> +               if (!maybe_get_net(net))
>                         return false;
> -               }
> +               /*
> +                * We call sk_net_refcnt_upgrade before the lock_sock sin=
ce it is
> +                * not yet shared, no lock is needed at this time.  Furth=
er,
> +                * because sk_net_refcnt_upgrade does a GFP_KERNEL alloca=
tion,
> +                * this can trigger an fs_reclaim in other systems which =
creates
> +                * a circular lock dependancy.  Avoid this by upgrading t=
he
> +                * refcnt before the locking the socket.
> +                */
>                 sk_net_refcnt_upgrade(sk);
>                 put_net(net);
>         }
> +       lock_sock(sk);
>         rtn =3D net_generic(net, rds_tcp_netid);
>         if (rtn->sndbuf_size > 0) {
>                 sk->sk_sndbuf =3D rtn->sndbuf_size;
> --
> 2.43.0
>

