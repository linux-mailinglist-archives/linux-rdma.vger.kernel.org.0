Return-Path: <linux-rdma+bounces-19378-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGpeFDf932ntbAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19378-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 23:03:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C136407DCD
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 23:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF5CC304DCAC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 21:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240C8386435;
	Wed, 15 Apr 2026 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XsRY/SFM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8D31E832
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287024; cv=pass; b=j/QKILG4dSUSIxC4yMn5IkigUlmpUpUTJpuL45Fty56ZRnpDrWqe1N7bctdxrQxnC+Iu14itoe1cA+tlwbquVzsFlXJnAhvgzSJZj58lNiAqTrjS40pUJpGRyr8Xh7+75zPIdvI/TvP1ou2I0fNLdcdGt2TwtWsKa9fivPvMKMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287024; c=relaxed/simple;
	bh=GaaNZcjpodnsAzv4m2iPX05Zq7otswTnvY9FgzS0EHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdgBZNUJ3E628rqEb8wBc5X9oRG+0/6NaGFxHNvu+QvPGnrB7LHSBiV0QcmChshnqe5oVvYPdNT9IVqy3eQQIEwJKuKxJ1n8ocwewUiKBBGBBwKlcYySNXa1y9MAVjCMnNbNDpzSHCsSqyLZwXnxM6ePp3t0yyorKj4ggU9Evno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XsRY/SFM; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad21f437eeso16725ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 14:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776287023; cv=none;
        d=google.com; s=arc-20240605;
        b=E/CcXpD4gLZaq6O1jSxzgIkA5pMxBu300o3gcBYBuVcjxLoK8+agP9FXFsvCR17op8
         RhPqosNSh6RTalXxvknA1a7Lg2wPGj/TPoeM2UL0CA7wIElZnS2Id6i7abysGupRS97+
         VGX8v+qlZz9roeXfippm0l/ULpSKkc24s3FNkCeuRRdqxbAUZLdjpIC7jxBPjJt6V6mg
         vE4+qfyDzFfYrZEp6qruFPCFrIH0sEbwoVikji0IKb1Fq4Aoz55ZMPzMCwCdJ2BpQdnU
         Cifn0RbmisqD0Wzl+lXqvOw9Do3Q/hzNDVfM3ytfM7z0NQiPgddBoI/KeHHX6gU0fLBo
         G2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+83jR3u+OMYuyXETY5Yv8xOj3xNbNwA4cnwnv5DT6dU=;
        fh=e9Jh0mPapbD+zuQw4Swb1HdI7MmjMDlLd9DFIB5qRzA=;
        b=KAQjGmSI5ji8bcHD9Fj+59MNweMl9Zepnz//ZXhp4+4hIaH4vz7M9Kziyd/NVlnD0l
         si3yRovojfMlbOsvtG9Y7PdVWZWFWiXmNxNQqypZsPaMzs+7F6etLYVSCUw58RARc8V1
         Gf+vUecwBKFVtVD2DucpJVbzwdNfIuZE7p2tDMAGeG6PcHCuZmmR/95cVgrt+m9z4E53
         mM3JlP1tJzAcR0NfWZd0w4CKv8zJd5ZMM2Eb/aPmeUp2QqiRQWgkh6ecdQM/WMFVkJ//
         PkAEqSHcQ2oQC23uy4mTtj7ikpzinMQh4VYQtLxUNfYJu2uhLAG0qVZH4SWKFCes7Vju
         Ij5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776287023; x=1776891823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+83jR3u+OMYuyXETY5Yv8xOj3xNbNwA4cnwnv5DT6dU=;
        b=XsRY/SFMGYJCRXoivRO3oa5bLJ71GiHRIJmHzS5CrF5VUjJdd+hV8k6h8Hc8acy5UA
         yzCv2maRQmr3UoQgWe2BwKVdIFSSWgXAb058iwgFF5JGOAuxjg1etk+/4PjX0jNPtUfU
         F196m2hDsOIS+hHWcXKTv65cuesfDho6jb7u0fZwDdvNVDz96meOZVK0rjbpVwrZzRTv
         T/LRK7lfQK/1zur7SEA8te1lqaqQp1WcYuRZzZQSO6vMSPwTZTOQtXueZqAS1KEiib8l
         St6JQ9G58yL/vXw8hfuKPmmqe3FCUg92QZH0BSvagOrhGJLUUSTgse7gFR8UZkuZe3mB
         snIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776287023; x=1776891823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+83jR3u+OMYuyXETY5Yv8xOj3xNbNwA4cnwnv5DT6dU=;
        b=dTVl+Ub1m16kwg4DeP7qd4oGDPmrGwQpzsytq9AX033I3oB7tEbUgiWb5q5Ay7hGs1
         GeXUxzuf1MuYCFqzDJwHMWP7n8xFlQZAgDDAvtz8TTgPFq5dW1WHldadUf8pcAAtBNJn
         qIZjlmIgUhSmeylM9B+JYQxRfQUTBGxLVlrEy+dnmqD7ptUMTGGcHOMZjNVoILCesWQd
         cwGODhBImTYDeN/GGcnTxH+sMF/u70sKIoBYoX/zf6vDIKPeAIVa7TYS6nE96XP8qHbz
         DQaEWNPgnF+jN++VTdlgDTHRlrR+eVbIzqDk5wc48w1XxnGcGEf1IEFgp5UssFvxdPS1
         YgTA==
X-Forwarded-Encrypted: i=1; AFNElJ+yrOWOBkxTHDtAlIya0CNmgI8Tm4r9ig17p2A6MZJ5NkzSGqLbwPZZeI5uAnleAn/txNjQ9T9CC4xh@vger.kernel.org
X-Gm-Message-State: AOJu0YwYJvgAoAUG+EtUOLoWKbeu4NE5wQ6tliQ3tC+pPKvBrM0J/1lu
	m082TpIHsjPnXvy2avAhLkdroDLYDPj8I+sF88Gz2xonT8tCj7YCbtkgoJMc09k9R/W0TBldhfE
	xmdEHK8E27dOTrsllt9+ta5oxl4ur/e0T+r7uZEri
X-Gm-Gg: AeBDieuwKaRbyQI+PSiqJ8tkvsXLJuOQyCPmzMkDS2mOROhKxyvexti+352ZwNq3Jgd
	Zd7XaX0AWqnvjZRNR7lQmkJHqLS9scSdMtCUlydU8GLxTh3rY+SklKJuwbkvRjkcUERvPxIkBVH
	bwZdDO+HLeIsFV8enKYo8P0sLvnYaux7c299F2N+Mp98eqe+UMaAi5NgsXqeeTy+dGafp42K5Vx
	mOfqqA/z0rzB9+WpURlcmCarJSI7KH7oE/HU6NCjzNq9AQYYMBADWlrVxjD2QqXU1QAw2xFponr
	H+dWM5M=
X-Received: by 2002:a17:903:2484:b0:2b4:5d0c:7a85 with SMTP id
 d9443c01a7336-2b5eaa22380mr5127465ad.3.1776287022908; Wed, 15 Apr 2026
 14:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <4cf6b20b-f53b-4b5e-ba03-c7ac01bec0c2@schaufler-ca.com>
 <CAHC9VhTm9MG-NzdwxtqJA6LZeTEsmUjyy8da2=8KOVxgDtEqWQ@mail.gmail.com>
 <53a532e8-5981-49b4-896e-0bf5021ff78b@schaufler-ca.com> <CAHC9VhRoaECt03Rs-ZyoGhW2_qZkA_1weTYYjiXc41Yf5U8A_g@mail.gmail.com>
 <a5fe292b-77c8-4190-8989-1d32cadb5689@schaufler-ca.com>
In-Reply-To: <a5fe292b-77c8-4190-8989-1d32cadb5689@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Apr 2026 17:03:30 -0400
X-Gm-Features: AQROBzBz2q68BZW8dTm1i7JCyf7T-jJ8N457zfM2449jgU9ei1obevOWDfD4MWI
Message-ID: <CAHC9VhS1sVMGHpO-5Zn0K0w6suTB-i_SwvouDpEmT8sXffsRfg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19378-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,schaufler-ca.com:email]
X-Rspamd-Queue-Id: 9C136407DCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 6:42=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 4/14/2026 1:44 PM, Paul Moore wrote:
> > On Tue, Apr 14, 2026 at 4:10=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 4/14/2026 12:09 PM, Paul Moore wrote:
> >>> On Tue, Apr 14, 2026 at 1:05=E2=80=AFPM Casey Schaufler <casey@schauf=
ler-ca.com> wrote:

...

> CMW MLS and SELinux MLS can be mapped. They have the same components.

Yes, one of the fields in a full SELinux label can be an MLS field,
but that doesn't mean there isn't translation needed.  The important
point is that security label translation, mapping, etc. is necessary,
possible, and has been proven to work across a variety of systems.

> >> SELinux transmits the MLS component of the security context. Smack pas=
ses
> >> the text of its context.
> > Arguably the NetLabel/CIPSO interoperability challenge between SELinux
> > and Smack is due more to differences in how Smack encodes its security
> > labels into MLS attributes than from any inherent interop limitation.
>
> Yes. That is correct. The big issue I see is that SELinux does not repres=
ent
> the entire context in the CIPSO header. Thus, you're up against many SELi=
nux
> contexts having the same wire representation, where Smack will have a uni=
que
> on wire for each context ...

That isn't always true is it?  From my understanding of the "cipso2"
interface an admin could easily map multiple Smack labels to a single
CIPSO label.

It's important to remember that if you wanted to utilize CIPSO to
communicate between SELinux and Smack, the label translation is not
between SELinux and Smack but rather between SELinux and CIPSO as well
as between Smack and CIPSO.

> >>> Use of the NetLabel translation cache, e.g. netlbl_cache_add(), would
> >>> require some additional work to convert over to a lsm_prop instead of
> >>> a u32/secid, but if you look at the caching code that should be
> >>> trivial.  It might be as simple as adding a lsm_prop to the
> >>> netlbl_lsm_secattr::attr struct since the cache stores a full secattr
> >>> and not just a u32/secid.
> >> Indeed. But with no viable users it seems like a lower priority task.
> > You need to be very careful about those "viable users" claims ...
>
> Today there are no users.

That you are aware of at the moment.  You are also well aware of my
feelings on this issue and ultimately I'm the one who has to sign off
on that stuff.

> There are other problems (e.g. mount options) that have yet to be address=
ed.

The existence of one problem does not mean another does not exist.

--=20
paul-moore.com

