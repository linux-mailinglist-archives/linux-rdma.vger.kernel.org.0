Return-Path: <linux-rdma+bounces-19353-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEdbNyuR3mmqFwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19353-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 21:10:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CCA3FDE8F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 21:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D08E303C611
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCFA30E0D5;
	Tue, 14 Apr 2026 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ExZHjmi9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C629B22F
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776193804; cv=pass; b=eMgum9+lHMwywspHyL6xVwbHDKKuCTyiJGK6oi/YVcvCUMpoUuBThpMnYG9W3wLlqTqsKElcB7tUFiC8VKFJaaIiQDGe5osj8Z6M20Cl9UVhueZ0BK9eV99JOSA7X5HYOpeBkKKLDcdYI5MsPZ525piUwVwQ2s4s2lQaWS9MUSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776193804; c=relaxed/simple;
	bh=J43mBV0ldP+9tAKtYP6opL+oCOolAXGommPsCXcYceI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NB6G+9wDnGRc0mENn0PLHAdEyPTINJVErZDvZm/l4e9x5Rq33ekvgNZUQLNH/4PDTnhlAhWvKKkRjD2nsvs55YAqhcTGwCIo3ZC+bTIu/YQ0/bfJO5+BFqZkOFkvAC/6aeNSpKRs0CNdnKRc0uGmSzmSQDoZKc7V4M7BpLnKoow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ExZHjmi9; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso5109184a91.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 12:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776193803; cv=none;
        d=google.com; s=arc-20240605;
        b=CVBf+Z+1joUgUZLMZwxfazBKUg86/ztZ0v/5ISvlZ+KTISQPDzU5M4ZqLKNRBKOIg7
         joPeGXQOr6sij9IbrPypaqJLlzuor/vOqqRCzFv9MCZ1cj1v0iL50b/0rKVuZMVef/+t
         KQtIfrKaRqm1s2c4cUlE9Uyc837V3IoBqqw8t5NebsuCPZUscOu/uYXAc9gp2UYYKhk/
         TLlJH7ZyLepy54DMApz3+vlWNHQMP3Oxct3FcRpzZRdQAIV5ohujAO5LMNZDSLwy8np8
         RNn48kuNEEYYCysbvO9Xu2hkTY9fEBj0UqBmTl5qZOWwjCaGbkjqLJFFAqnfq/M0ApvM
         Z0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RMeIDL2hZeivdhvp3qRRH2W8sXvQUhY/bjEclVKtEJU=;
        fh=Uui0aNAWbQkKTLyD0ujPySwnx/QDpLF6YpmOLtHy0S8=;
        b=FS7r1SqhUCyAQ8zq+EZp6eDyrRkD6G/iqHUWWEUq9Cq5CArc67pm3rEcr7YZPOQSPR
         k6gOXffQoWC1ocikxQy9ezHSi7MgWagOzBG+m9yJwR+7KcGJQn/mVmnxbwt5/CDSjOcL
         iNVu3t5c4e7Y18tD/I+3RKj76vzKotN4wPW6sBQUJgwMyEANMTsW6kttAQrn6SPJi1sm
         DRkWHd0XYnrcEN31JvkjdckZUYrnWOHjdoicUALY/N/uXa2b3qboyRiQT0U7T6FEWcQh
         RKBZu9kJ+Lt6swswSF5zcSxQPCqVuWY3AUSksjW26RlBE3CIvqod9lHcL6oDmwk+/icG
         /mbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776193803; x=1776798603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMeIDL2hZeivdhvp3qRRH2W8sXvQUhY/bjEclVKtEJU=;
        b=ExZHjmi9lX9IqrT94HSUjWeI+fXtJcBXvwhEUc/+YY1xv8Rv+ImpKzcGEI0+GsJBIn
         cA9NXcrOzvSiojvwNGbX4DK0jsZuUP2ZcTj2ThU7Oe2DaRgIfdHwYS9MXrJ1ZSCBWAl4
         9PWauySv/so0TigMhbI/ZYT/joSLVF7peyMkEwEyT6bnq0r3KAjl//lsqY8P/l133QdX
         lwu36VEXaz4oK1WI66BvS16iEBKYoqclgb09tDV1+tu1/xOHFS7v1xF+E9HBYKEPjZ7l
         bikZWPv5Hg4OWpUONFrk6gfHgZeYgy6QaTgj3dgNi8EGhI4SDiaadQzqHtHb9yINVb/F
         ZnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776193803; x=1776798603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMeIDL2hZeivdhvp3qRRH2W8sXvQUhY/bjEclVKtEJU=;
        b=bC2yqRdFNgfL5EIWMK5w3koGPsBORULzYk31gNBqA6G/TtHv5TNbfS/iRjq5enMAgq
         BeJQtbVdbAAunfq2tm49qQtPuRgzdY8uPKBDINJSGjgBFqKMpZkKmXq0Z/EMqep5Dju6
         iErRR/frg6K68o+sv5zk7Orkisul0ZqYo5BnvqUDZvbppSogsSev1VToclMQP4Yp8bOb
         pBduGGHy+enc+uh88BAoQpPR5jzsyvk/qDm+pg86IJBrsCkAX2SYnwxTnHOfZ+9ijxQf
         9vqfObGcMl9kb7+AWEO9l0/TJRAKXqsmuIvk/nbEgL+EEdBq2HmvpUMYeWhpj5DEpbmu
         qPPg==
X-Forwarded-Encrypted: i=1; AFNElJ9jddwAGkjijOy2+wXSdwhiftGMX35qpfpLZeKx8VGJKNm3IO1M8zje+HCOY7TtEnVOw3h2ox9/5iql@vger.kernel.org
X-Gm-Message-State: AOJu0YwVcHHTeblttHdnAj1sanyTh7p0dQfWz4TK6HI2bR8WjxR+i0T8
	4XimXpsxvy5Rl+k+sY8rscbKRNg2EJL9jV4jkE3tb15EpQm6rDb2sy+4KjSEdPt5NdbHjgQhhSq
	zg1xR5kI0XAfdeKIwfiCnI3OH/yRioITZX9rj/qFH
X-Gm-Gg: AeBDietiNRFADkFObIR0/4FKuhr0GynNRyGa/ixzBESth/A3blHC5aXSNzhmZnv3R6F
	ZZn10cOYI7RYtJLtvR2geTPjp1aijbDSmpNLLyBgGLFkFTXaeQGGAhdbKo+HqRpKt5xqId8zxIV
	PUzNEwRfMBknrzqbR0gFkG7/Qr+YDvv7265oTTm1O67HjGsDNCDRvx3KBvOWlPI3ubyrzbljIid
	aHktmurTxY6j2wCYfHnSEbIrK7lLzKqzJpcjJEDXdd6Gmz6iXe5J+NhbD07tS+oZjrghyKaRDo4
	wlQH3co=
X-Received: by 2002:a05:6300:615:20b0:3a0:cd5:82b7 with SMTP id
 adf61e73a8af0-3a00cd5a76bmr10180913637.55.1776193802297; Tue, 14 Apr 2026
 12:10:02 -0700 (PDT)
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
In-Reply-To: <4cf6b20b-f53b-4b5e-ba03-c7ac01bec0c2@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Apr 2026 15:09:49 -0400
X-Gm-Features: AQROBzAOdBY4w7LZBBBsHqiX9-ECTPgm0KJFmDB-WN8NELm_4E3dGLmVNUhIl-4
Message-ID: <CAHC9VhTm9MG-NzdwxtqJA6LZeTEsmUjyy8da2=8KOVxgDtEqWQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19353-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:dkim,paul-moore.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 09CCA3FDE8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 1:05=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Netlabel has a similar issue to secmarks with its use of secids, and
> currently supports only a single CIPSO tag in the IP header, making
> multiple concurrent LSM support impossible.

That's not correct.

We've talked about this multiple times Casey.  The short version is
that while NetLabel doesn't support multiple simultaneous LSMs at the
moment (mostly due to an issue with outbound traffic), this is not due
to some inherent limitation, it is due to the fact that it wasn't
needed when NetLabel was created, and no one has done the (relatively
minor) work to add support since then.

For those of you who are interested in a more detailed explanation,
here ya go ...

NetLabel passes security attributes between itself and various LSMs
through the netlbl_lsm_secattr struct.  The netlbl_lsm_secattr struct
is an abstraction not only for the underlying labeling protocols, e.g.
CIPSO and CALIPSO, but also for the LSMs.  Multiple LSMs call into
NetLabel for the same inbound packet using netlbl_skbuff_getattr() and
then translate the attributes into their own label representation.

Outbound traffic is a bit more complicated as it involves changing the
state of either a sock, via netlbl_sock_setattr(), or a packet, via
netlbl_skbuff_setattr(), but in both cases we are once again dealing
with netlbl_lsm_secattr struct, not a LSM specific label.  Since the
underlying labeling protocol is configured within the NetLabel
subsystem and outside the individual LSMs, there is no worry about
different LSMs requesting different protocol configurations (that is a
separate system/network management issue). The only concern is that
the on-the-wire representation is the same for each LSM that is using
NetLabel based labeling.  While some additional work would be
required, it shouldn't be that hard to add NetLabel/protocol code to
ensure the protocol specific labels are the same, and reject/drop the
packet if not.

Use of the NetLabel translation cache, e.g. netlbl_cache_add(), would
require some additional work to convert over to a lsm_prop instead of
a u32/secid, but if you look at the caching code that should be
trivial.  It might be as simple as adding a lsm_prop to the
netlbl_lsm_secattr::attr struct since the cache stores a full secattr
and not just a u32/secid.

--=20
paul-moore.com

