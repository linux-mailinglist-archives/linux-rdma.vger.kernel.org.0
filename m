Return-Path: <linux-rdma+bounces-19194-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDVdAnIU2Gm9XAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19194-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 23:04:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 888663CFBB8
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 23:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06A0F3013490
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 21:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171D0370D5E;
	Thu,  9 Apr 2026 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="V7X4gGD7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FC3446CC
	for <linux-rdma@vger.kernel.org>; Thu,  9 Apr 2026 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768677; cv=pass; b=SaywoxgoOQUCUwF+55gHsUesZ5mLK2pu7zdAmvgtxyrnzLimZMh0iPRN3YnmVco+CvbqmM0rf5HrvwZoMs4ZIoIbRlGI3FRZ+dAfoLcvmjhsfZHXETijvtFm7h50V4u/vHak9Hqe4U90ou4jBNLLbnuKwZMucFluKgciXDfASes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768677; c=relaxed/simple;
	bh=LSYLWSUH9Mj6i04sciDGLrl/1HBwlgwaKnT9iX/4E+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSiBHNXCD0RVvj56SkagNVYBuY6/l/coPGDAEmxLtMKLhSsCrgzokT4tTvwP2TnzIlkvXqU9Q1RIzIp4q3qmOk6nT22JtFPN3uezWchRHbWZsUtGlCI9bIPWNzlxDkN4wjxGp+X4CceLNvp3ZgV3x668w0h7oxa5pRfipYT4Dbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=V7X4gGD7; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35c1d101355so634248a91.1
        for <linux-rdma@vger.kernel.org>; Thu, 09 Apr 2026 14:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775768676; cv=none;
        d=google.com; s=arc-20240605;
        b=F7jrykdYrAg5S7y+9ose1scJii0eRAsD6du16Q9iTeQpma+k4i4gWIJrZ+MIobwvB1
         gqFDM+mteJRR6eJoI3Sfum+BgcVPPmoPjWwY88aV5IhkU5CLt2MYMTeEuip5H1U8u2kI
         p9Tn1qr/cUdOvi8l6hBXUhF5t4hd+tPSv0XZDvLwvFRuNSVjK4nduRuggcP4Gdt0v842
         kn4Y9Lqrp9HFbCATnGTgojMYcX3SV8xNtX8F2Vzg1Ko5bOeAp09hTR5zZ4XtyVWu6lCY
         /ojob1s/RR4WK8OJG0bdDrO9wFFZNcbKzpbOr5yIsbyVXRtXq1H5a6J3KNmTb3HKN4Ef
         KXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lhvOaKGuS0RvMrnclskhUETxNWQ62+P6zx5TM7DZbx4=;
        fh=/PSqCikWKJrzezXELWetAJGqLx4nSyd9pbs4jNVq5fQ=;
        b=eyzAl2IPlyByfrPnWTds454t0bECY4yH+MUw6SQkddiIDny12f6hlLFqcugKrD8DFm
         P1V81uDvjiFy48F3w6p4bHFzDCaOb5LezZiXkLUZyXEF5uJ4925yqW4eOIoVffzwJTgL
         wilJdb0J3zigYc/taoYbdEWK3mDiTbhEcs3nyazcr1X5Tu5+IjqAa/3sLsvmmXRiV9nS
         yzuuECsWyVf2cvfEBzbFZotDsJARXiSutsc8lcLQb4i9CjUjYwpcWCGMbtPpzz3P5Vxk
         mDTYH5ei/gYPwFL0zyZSZTGauXF9LXAusNR4J2TIz0qCRW+S/gD+lN/vegZx8i3GGEEH
         y0Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775768676; x=1776373476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhvOaKGuS0RvMrnclskhUETxNWQ62+P6zx5TM7DZbx4=;
        b=V7X4gGD7whTgHgmCFzcNTUdyXfi7fLJB1XdLPs/rgZtnG23DKukhxcra1k+9HK+kiH
         ri7KgWMKq39l6VaF2i6tNb100zITQlGLSeYtzjvUcHI5SYn1cK/E8QfmhdQ7EfnFJ+lB
         vX9DC8x2yd8slQJq1bjwpxS4guKDRfIvpKdvqUDqDicmcBnkdRdYrCrwHxJ+cuQpdGxE
         8yzFhMsdhSxDDvrkdFlP3BbKYpnYEYcw7rpw0h+3YH418tjaG+j1zUKXptBR/dhx7WLn
         v+fpfCIndfDqxfRjeXWN5r3I9jqcGRkdZ+AffFaaPc4cuUAUjsvETOf7nueGb1mbaJ00
         YxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775768676; x=1776373476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhvOaKGuS0RvMrnclskhUETxNWQ62+P6zx5TM7DZbx4=;
        b=OK7VKyNDuQ+JjGoWH+7ISGnW8yjgUV54kxrLjVWWsA1dHjxUH2FJVIKaRLpjgnA+AP
         3mA6m/XH6UYoYxxiMQaLlUOr5k8c2Gm8k/hvQdcPv6j0nmE/Y3HHyC49G10yA8GP6Jjd
         dII/F+1/aDs/l/PIakyMPIqfV5Tam4dkYp+vxNFIiCxdhZd2aQpDQYFNMHSaE6FEueky
         d8qKrpIuAfVKGLyhKO5JG+602YIHgahLJ3jMyjU/vr+ZLTMNurZkbXy2LtNpvG4QDPEC
         TwYmOPyGyNswYa8x8rSzEZjrr0a3g42Dg/bZxYUL1JSWrvONRMIkzhn1FpbySgOwvNtd
         h7mg==
X-Forwarded-Encrypted: i=1; AJvYcCVzjIE058M4yTMYG0diL6Xg9/Ey2JSxmwem3Qu8YMmy0sJuvqkyGNmwFrhtR/DNNQ3POchyPzG8yRBQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGgtPmaV9+hmzRl3JpC+bC81IjukhRSwJozIo42HesRtdkLRx
	D3PKlrxV5ByvDI1ypngo4gcfwTQeUjzsRJZnuJoDkqFnWBdq1U+9ot76axO5xuAgF4VuALcM925
	gR1EXEEUqf0xDDCIcyXZDpy9TzM/Wg9p9ac1GKcY2
X-Gm-Gg: AeBDies8Wpdwo59d9lGOrwttw9UcMTZJxz/z/lvMkT+3xg+eYaOydMJSTrEdS7XwUBw
	txIW5JpnxLj5RZr+1aZj0X0QaeuTnUOzud5YWHuZSt88h69lDmj2C7yIPnVIqbMZ6KRLcRYFE+y
	P7IMwMlQQgaqINOeg4/6BEh6cd61zE1MsGNiWRdGIOwxwjQxuA3x/1kkxJdy3nFydjMsCL+dDW7
	mkXsEmtp0/BZh4yYO3ooN79Ytk4vYMD7McC9n+1zQ6BuG07iIuNAJrErcO6szl2uwhUrSB1mQyD
	bDBTnwc=
X-Received: by 2002:a17:90b:35d0:b0:35c:cba:344f with SMTP id
 98e67ed59e1d1-35e42814b32mr506029a91.13.1775768675871; Thu, 09 Apr 2026
 14:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal>
In-Reply-To: <20260409124553.GB720371@unreal>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 Apr 2026 17:04:24 -0400
X-Gm-Features: AQROBzCv7hqSB6tSKvErzJZhlb90rNuzAgZmLqxEJrioN65F1TGjEcz2AUzp16g
Message-ID: <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Leon Romanovsky <leon@kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Saeed Mahameed <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19194-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[huaweicloud.com,kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,ziepe.ca,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:dkim,paul-moore.com:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 888663CFBB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 8:45=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
> On Thu, Apr 09, 2026 at 02:27:43PM +0200, Roberto Sassu wrote:
> > On Thu, 2026-04-09 at 15:12 +0300, Leon Romanovsky wrote:
> > > On Tue, Mar 31, 2026 at 08:56:32AM +0300, Leon Romanovsky wrote:
> > > > From Chiara:
> > > >
> > > > This patch set introduces a new BPF LSM hook to validate firmware c=
ommands
> > > > triggered by userspace before they are submitted to the device. The=
 hook
> > > > runs after the command buffer is constructed, right before it is se=
nt
> > > > to firmware.
> > >
> > > <...>
> > >
> > > > ---
> > > > Chiara Meiohas (4):
> > > >       bpf: add firmware command validation hook
> > > >       selftests/bpf: add test cases for fw_validate_cmd hook
> > > >       RDMA/mlx5: Externally validate FW commands supplied in DEVX i=
nterface
> > > >       fwctl/mlx5: Externally validate FW commands supplied in fwctl
> > >
> > > Hi,
> > >
> > > Can we get Ack from BPF/LSM side?
> >
> > + Paul, linux-security-module ML
> >
> > Hi
> >
> > probably you also want to get an Ack from the LSM maintainer (added in
> > CC with the list). Most likely, he will also ask you to create the
> > security_*() functions counterparts of the BPF hooks.
>
> We implemented this approach in v1:
> https://patch.msgid.link/20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.co=
m
> and were advised to pursue a different direction.

I'm assuming you are referring to my comments?  If so, that isn't
exactly what I said, I mentioned at least one other option besides
going directly to BPF.  Ultimately, it is your choice to decide how
you want to proceed, but to claim I advised you to avoid a LSM based
solution isn't strictly correct.

Regardless, looking at your v2 patchset, it looks like you've taken an
unusual approach of using some of the LSM mechanisms, e.g. LSM_HOOK(),
but not actually exposing a LSM hook with proper callbacks.
Unfortunately, that's not something we want to support.  If you want
to pursue an LSM based solution, complete with a security_XXX() hook,
use of LSM_HOOK() macros, etc. then that's fine, I'm happy to work
with you on that.  However, if you've decided that your preferred
option is to create a BPF hook you should avoid using things like
LSM_HOOK() and locating your hook/code in bpf_lsm.c.

The good news is that there are plenty of other examples of BPF
plugable code that you could use as an example, one such thing is the
update_socket_protocol() BPF hook that was originally proposed as a
LSM hook, but moved to a dedicated BPF hook as we generally want to
avoid changing non-LSM kernel objects within the scope of the LSMs.
While your proposed case is slightly different, I think the basic idea
and mechanism should still be useful.

https://lore.kernel.org/all/cover.1692147782.git.geliang.tang@suse.com

--=20
paul-moore.com

