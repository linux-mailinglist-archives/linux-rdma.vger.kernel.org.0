Return-Path: <linux-rdma+bounces-19418-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP6jNRmI4mk97AAAu9opvQ
	(envelope-from <linux-rdma+bounces-19418-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 21:20:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D741E31C
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 21:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4D8F304707C
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 19:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7F83C9EF4;
	Fri, 17 Apr 2026 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Sx8fcCLW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EACF319851
	for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2026 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453476; cv=none; b=DmMtCdbcVP9Z36FSCuNIX4lADvNcN/th+sGviKIxJIgYARYT7wU9+pda5TFO6FhpDItJ/1jCqRF6y9giMbv70GzNwv+ra+Ut4KCI6gNMjP4qPe1QpPZ+zkYBJTfx2PK1pkLfRmkgfzSD2sS0aHVhXU7eyCB2IUGcL1YUXyxhr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453476; c=relaxed/simple;
	bh=de+cgeiRloRqiMe4wUivFxwt1KqtqUuvg8OBq9NZKi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZUt2Cljj4z3WMGycqZ3GbdgF7dnxVaS4MoLk30a0IqjMZszvqdh9r7r5IBqvLARbRh70cQLI6rlETxEEvOtv84XMA0TAytgxlYWk6AvtqVv/geRHYhEsL2QzpmUSywTYBcyCpMLPVKyApiivzE02R9ggbJWrXfphsAT7y5SNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Sx8fcCLW; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8aca2726f61so12530036d6.0
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2026 12:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776453471; x=1777058271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4EAYiUx134wz4kkjk1jnBH2zllAceLFfLUvioLTQuWg=;
        b=Sx8fcCLWseq3/lgxypDZO6saM5K9gzfIKNypH3NUSGbT5dqx7sAGtNZe4sRWAbtSKo
         kYlLDdv/LSV9Lz4MqvSZUrFT/0zy6GOc9/LN5By5UfPTbS/hQIZ5X9Hy/1Bu9tVkAh1S
         3mcpURKlwyMKqI2sF0iBTmG4qejHM4Wm525Mio/t0pj2Wgfd+SXl9IJQLHY3/hdZZhJP
         6B1OI7GtaiSQ+hWTESH7hcWeaHbPmNt5kp2p22y6VagKOfmpcI2BS+3CeRAPJ/kDnH/l
         PIFct8tdk/bNU9F5+Kzs/tDxkUIlecnXOJUDLpVGSW3EPUOrEFsDmEl0ZVdeGVWVGxYB
         ZAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776453471; x=1777058271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EAYiUx134wz4kkjk1jnBH2zllAceLFfLUvioLTQuWg=;
        b=qLJr8Z//N2Rnf5BWAK6iD8lxu61hCtu+A0sOclOwnfb4h4/B4EWRMIJHrO0xAfLbu8
         ck/O+VTp5ySuwIWcnNIaJt84x6n84iB/WPCXvviPZk9R4OZ1fd2EtCFQ3tQmJ14kro5f
         +E6iz1Pmv3U6AX1PkrXIl949732DPptrT6Ds2ucSCVmJYREBD+XY4Iq8wedDFiKrd7S/
         0qM++89SA1ZvopRDpiShLqe5qpNE4MJLyEX+8IZpPkdVJO3ZjWGqzkMggpRZ4AY66lKn
         2yGu4vBrU/wunRz2XV+7b48kMb5b3Ylwv3I5OH/VcmFFxn0ICn+zXn0XEnD/mTViOBgl
         Dxag==
X-Forwarded-Encrypted: i=1; AFNElJ+q2Yan3NrEslJv7oQqaqt+JgQKKYcGRHubxqZGqvtEpl6GVwPMCHdXVKyc6ym6xZ2GYvpDDpNtwiH+@vger.kernel.org
X-Gm-Message-State: AOJu0YzGaXCtbZPkPKMe+QnN/+K5+5Ae4yUyBXh3ncbPpNo36u6ewxH/
	kpXyWa2M+IZigd+buMHW9rIOYAknUH75qe3CAzAXEvFlAmXX+j51JwBoYhvNdmLBIP8=
X-Gm-Gg: AeBDievvFvhydMaThritZ/ffZrBmzzRXTGN976JyJxLZWNuxEZzq6U0vYk2TPfy6cp/
	Rx5KpFgL+j8Jj9i2YJILeGN9xEc9+h2HcDcM4FLLkIufW/jzBHGWMrlTsJUEJr+U2ECjPQ6NlMv
	l7oLQ9k0CIKsU6Ydz1iUu7JlP683S3vlbLy489e3EPsJ3Vp75PT6X1MN00pyClzFGBQL/BQL6jc
	hTcBWk5DOuQH+ZRexlGPvwBf1sIvQkX79tDGCzGde0fiBKvRDocMEtJa9SQEDCdn1Ak/GYfNoNf
	F8yt52KCwssasIqQ7V1eU1uCYC37PLwixd8keVtbtvnpCgfial4FY3AmGwAaS+CYVkWG3cY1xsc
	Eamgjo7cuLeGZggphaDYh6jnABmnTarfgRXnqPR9QHCqa4hnCWKtJOuyU+RT5DYAqWLx2otR/op
	7yum+MX0dzJtalIXWBoaif7+hT/hXha1mBp0i4gsd+7YnO3mDBGW7GrroojZ+P05SzkSHp7drmC
	slnxGS4m85eFPqc
X-Received: by 2002:a05:6214:2a46:b0:8b0:2d20:ff79 with SMTP id 6a1803df08f44-8b02d2100femr46126906d6.27.1776453470830;
        Fri, 17 Apr 2026 12:17:50 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae86947sm26222946d6.37.2026.04.17.12.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:17:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wDohJ-0000000DV61-2ye0;
	Fri, 17 Apr 2026 16:17:49 -0300
Date: Fri, 17 Apr 2026 16:17:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Paul Moore <paul@paul-moore.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
Message-ID: <20260417191749.GK2577880@ziepe.ca>
References: <20260409124553.GB720371@unreal>
 <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal>
 <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca>
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
 <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca>
 <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19418-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: 841D741E31C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 05:40:04PM -0400, Paul Moore wrote:
> > The NIC doesn't know anything more than the kernel to call the LSM
> > hook. It can't magically generate the label the admin wants to use any
> > better than the kernel can.
> 
> The NIC presumably knows how to parse the firmware request and extract
> whatever security relevant info is needed to pass to the kernel so the
> driver can make an access control request.

Not in practice, we'd have to agree on how to describe the "security relevant
info" and that won't happen..

> Leon mentioned that different firmware revisions would have different
> parameters for a given opcode, and that one would need to inspect
> those parameters to properly filter the command.  Is that not true, or
> am I misreading or misunderstanding Leon's comments?

They are ABI stable, so there will be rules about future changes that
old software can follow to ignore or reject future things it doesn't
understand.

> > > The access control point itself represents the requested
> > > operation.  This is possible because the number of networking
> > > operations on a given packet is well defined and fairly limited; at a
> > > high level the packet is either being sent from the node, received by
> > > the node, or is passing through the node.
> >
> > I think we have the same split, fwctl send/recive analog is also very
> > limited.
> 
> Sure, but I thought the goal was to enforce access controls on the
> firmware requests based on the opcodes/parameters contained within the
> firmware request blob/mailbox?  

Yes, that's the goal. It is the same as iptables being able to
identify that a send system call has a packet that is http or dns. I'd
like to have a fwctl RPC ioctl system call identify if the RPC packet
is A or B.

> > Deep inspection on the packet blob determines the secmark.
> 
> ... and this would be done by your BPF classifier, yes?

BPF would be one option. We could probably also meaningfully do a
fixed set of matching functions (ie pkt_data[X] == A then MATCH) more
like iptables does if that is somehow relevant to LSM.
 
> > LSM takes the secmark and determines if the access control point
> > accept/rejects.
> 
> At this point I think it would be helpful to write out the
> subject-access-object triple for an example operation and explain how
> an LSM could obtain each component of the access request.

I think I am talking about this:

app_1 FWCTL_RPC op_unpriv_t
app_2 FWCTL_RPC op_priv_t

- app_x broadly comes from the process executing the ioctl

- FWCTL_RPC identifies the IOCTL userspace called to send the RPC
  packet

- op_X_t is the result of the classifier inspecting the RPC
  packet. Admin tells the classifier to return op_X_t similar to
  how --selctx does for iptables.

For sketch purposes I've used the words priv/unpriv as something an
admin might want to setup. As I said above the actual buckets and
mapping would have to decided by the local admin.

> > Same as for networking. Admin understands, admin defines, kernel is
> > just a programmable classifier.
> 
> Are you able to define all of the firmware request operations at this
> point in time?  That is my largest concern at this point, and perhaps
> the answer is a simple "yes", but I haven't seen it yet.

We can identify all the IOCTL points where the RPC packet will be
delivered to the kernel (send/recv/etc)

We cannot pre-identify all the mlx_XXX_op_t's an admin might want to
use.

The same way secmark cannot pre-identify all the XXX_packet_t's.

Jason

