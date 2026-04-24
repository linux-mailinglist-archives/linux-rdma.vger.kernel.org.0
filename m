Return-Path: <linux-rdma+bounces-19534-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP/gBwDr62nhSwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19534-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 00:13:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A73463BEF
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 00:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE588300AC80
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 22:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294323E5EDD;
	Fri, 24 Apr 2026 22:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H5m4vQCZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0A9349B1C
	for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068794; cv=none; b=KO9IxSvRNB2eYKkPZe3TCZ3ynuUIc0/CP0x8gLR8xLtn+q/0Xi2oHfo3EpAvQ8bB97fT8twxOkwnoxgmcabHPwpqsv1Dd+JHiGab91o5MKom8IJ34d0FcmzpBiIjaMPCpLZE/g1BD5MjCytPVjBX0tnuVy4R7iJFXLtOjqKc1kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068794; c=relaxed/simple;
	bh=edkfnYqeyMC0Qt+W6n8ze5hGF7NTNhj3oyNEAcTDdxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlCV6GAuGTprAeaHaec4Ha1iLdOb4lzzFBK+XeOfrj8wXJ5XKXPAUNjThjOUNqsHyAsx2N17mXCs6jS5gv1jHHKBYzoicVLu9veAiyyaWL30/5GbFxYPBd/ArhB3Bww8o2kvXrm+zDbmXYJl7iFvgOd6w14Tu1IzUqO+ld2XhVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H5m4vQCZ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb40149037so858281785a.2
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 15:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777068792; x=1777673592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1Bt8LRPmWuCECk46OUK1KhCrmrzQEbzIWvPlDI3cp4=;
        b=H5m4vQCZE27E+gDtn8BVCf5jLiPS6GNSYRuHd7oK/ryAnR76eU7gh4QWRI3SAXCvku
         xwbAjZ3hIBI5GEUgbOSGuhXCViPpczYPF9VhNc2dh89l7qQROTD8YZ3pfblRmIXAApD+
         LLNyElsdRzbz0O8P7asNE1yJaILYoWrFSeatd7+ExO8xnYjLQgg2muQOyOklYWskuFkU
         cwfy9M7PKhf/GFqDNR2idR9iNUU//TC3BIEIHtpqSrhi/HtxH3xMTkMDNiCC7PJfnIaI
         RfTF+U+c9gQck78mXjxg5cQFxiXkgiK0mPHrBDKGiKFmfg+/2VAfJKkgnb8JLTc01FjS
         F9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777068792; x=1777673592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1Bt8LRPmWuCECk46OUK1KhCrmrzQEbzIWvPlDI3cp4=;
        b=mH2WcAqxCCuAQZ/BnI0k/FDvNQfuZmrBiy3VshQY/K5oOUUskKKqkqxKQ7QoVeG4Hn
         pNpe6PUG1Y7N/3a59iYoxIyX0q2QADnx1YJFrIkJWLy8/hopzc3dv9Z85tFKcQp6QZ/f
         Pux9ToDEhXkjpDA+9QgVXwcyiUNWX6eXXOj9VHI1Lyv0vb1Bb55As+sxFQIHaLQLITBu
         Z46sZUGXz+jDHioJFgP7rvrIknYXaZSbbHNNx/NVzZbQtD2fmIr3mcReohwyJE5XQuv0
         BKKzTrwCJNFPKRTHX+2zdVKRNyM1EEa3aThc/bxqFzGrGWEODmvBJsfk+94/YsOHAK9I
         t+5A==
X-Forwarded-Encrypted: i=1; AFNElJ9+tImIMVxImRSTD4rsYjvrx72cYzorSvJgNhl41VAFdtqyxaAZvg99dm+/ImCi8UKidp5pQBgD7nie@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1CD7Lb8G2+Y8SPqX4SbjD4qJnYM0cb178dfZD7eJS347EHScM
	jiv8HAoIRap3AT2MXylp+Sx+TRUWKx9YGluQdufqWP9K9b/x08G1qAZB1B+6JiYdgFSmaWmM9xi
	XGnqXiVA=
X-Gm-Gg: AeBDieuAJu/1z/tN+o42OfFD8dpnFVc5rb7V2EWZtF3wK2Khls3YD3l9K1X1Dc0J3br
	g2xP89vxRk33ZaqEciJk0rw2+xvsmjX9Ep1jG+y9TCSzchxdEP1YdmIbHAipBGEqmFiGhCP+Mpc
	njbZMDwUI5mHRFjJ/Z7wBJAN84DnMzNn2rIORzdSEmtHCqj1UjSSHRo++UdyYS92fx9iuJJ8f5h
	QETLoAP+3yJKJ0PEVLRg8WqPftIaqra+jN33h2t6Dl024vTeVVxxTCdYLOzeCzgTHaz1m9fZi3M
	vsVf7YSabkA2t5U800QAhtj1mfJtrgCK0roHe0B0G5NfK6eU6HZPrFuos/hzE7a2taFzak0RCcW
	Ok/OdwSgnLStPpMd0CVkgynOVNH3iNujjmVL3ArIoxtauh0UeDXQAtvQQt2permPcHrE0h2AYPJ
	k3tYQ+jBdKVqlxyh7uFYBVlVOnpFv6WZBEx/8a1Icw7mNlQTS7zkTGLNC4L0skTV4N/vHbd5w+v
	QCHoqBcj6HPYiOs
X-Received: by 2002:ac8:7d15:0:b0:50f:b13e:b740 with SMTP id d75a77b69052e-50fb13eb934mr273244551cf.9.1777068792308;
        Fri, 24 Apr 2026 15:13:12 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fc42c7fabsm78174021cf.9.2026.04.24.15.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 15:13:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGOlq-00000004lHz-0nuV;
	Fri, 24 Apr 2026 19:13:10 -0300
Date: Fri, 24 Apr 2026 19:13:10 -0300
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
Message-ID: <20260424221310.GA804026@ziepe.ca>
References: <20260413164220.GP3694781@ziepe.ca>
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
 <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca>
 <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
 <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
 <20260424143603.GB3611611@ziepe.ca>
 <CAHC9VhR++21SD+v4Bb16SQmYHgJYZ0ytQ+BecGPNK+fEOe4G7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhR++21SD+v4Bb16SQmYHgJYZ0ytQ+BecGPNK+fEOe4G7g@mail.gmail.com>
X-Rspamd-Queue-Id: A8A73463BEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19534-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Fri, Apr 24, 2026 at 04:59:30PM -0400, Paul Moore wrote:
> >
> > > Most LSMs will want to know who is initiating the firmware request
> > > (the subject), the requested operation/opcode (the action/verb), and
> > > the target of the request (the object, which in this case is likely
> > > the kernel or the device).
> >
> > How is
> >   system_u:object_r:httpd_packet_t:s0
> >
> > A kernel or device?
> 
> It's not.  It's one of two labels on a packet.  I've cautioned you
> about leaning too heavily on the secmark comparison as it falls apart
> in a number of places, this is one of those places.

But I want to label a packet too, you keep going back to it not being
the same thing and I keep repeating that all I want to do is put
labels on FWCTL packets :(

> > It is a label for packet contents. I also want a label for packet contents.
> 
> According to your explanations, my understanding is that you want a
> fwctl RPC operation.  That is not the same as the secmark label
> assigned by an iptables/nftables rule.

I view fwctl as an opaque packet based messaging subsystem. It
communicates a packet to a remote CPU and returns a response packet
back to the userspace.

Trying to have the kernel assign fixed meaning to the content of the
packets inside the kernel is contrary to the entire design of fwctl.

It is like demanding the netstack parse HTTP packets as a precondition
to using LSM. It makes no sense.

Any LSM integration requires a labeling system that is not hard wired
into the built kernel. I don't much care what it is, so long as the
classification and label space are defined by userspace.

You say it is not like secmark, fine, but I see a perfect mirror in
secmark...

> > You can take that view, it is certainly one valid way to look at it.
> >
> > But it is completely impractical.
> 
> Elaborate on that, because from what I can tell that is the valid way
> to look at it from a subject/verb/object perspective.

We cannot have the kernel predefine verb labels.

I'm completely fine with using verb if it can be dynamic and userspace
can tell the kernel what the verbs labels are.

This is the only reason I pointed at secmark, it shows a system that
has both a user controller classifier and dynamic labels that are not
fixed into the built kernel. ie it is flexible.

> > > > The same way secmark cannot pre-identify all the XXX_packet_t's.
> > >
> > > Once again, I think there is a disconnect or misunderstanding, on a
> > > SELinux system using secmark all of the packet types, e.g.
> > > "XXX_packet_t's", *are* pre-defined in the SELinux policy.
> >
> > "Pre-defined" in a text files in user space controlled by the admin.
>
> That's not correct.  It's kinda like saying the NIC driver sources are
> simply "text files in user space controlled by the admin".  

That's very pedantic. I mean to the point I wonder if we are even
speaking the same language.

I said the labels are defined by userspace, you said no, and then
explained that they are defined by userspace going through a bunch of
steps:

> The SELinux secmark labels are defined in the SELinux policy sources
> which must be compiled and loaded into the kernel before they are
> valid on a running system. Policy must be written not only to define
> the secmark labels, but also to define the access control rules
> which govern how those packets are handled by the system.  The
> iptables/nftables command lines simply assign a secmark label to a
> packet; that's important, but only a small part of the total
> equation.

I understand all of this, I am totally fine with it. A package will
install, a distribution will provide, or admin will write these
things, and do all the steps to load them into the kernel. I don't see
any issue with that.

Hardwiring things into the built kernel is a problem that must be
avoided because end users only run the kernel provided by the
distribution. "recompiling the driver" is not an option that is
available.

Jason

