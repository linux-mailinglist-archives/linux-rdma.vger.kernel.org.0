Return-Path: <linux-rdma+bounces-19533-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI0ENsjZ62nfSAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19533-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 22:59:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C477463600
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 22:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D1E230269C1
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 20:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F0B37AA8C;
	Fri, 24 Apr 2026 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AFYxgzKY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A593FB7DC
	for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064385; cv=pass; b=hvix7lpnBONfDFpr2InZDxvZ0ngsrgiHyn5JWt17oyDVKU96+4K9YqBQFOz/PiSdDH+B5/2V2aHzsexnlwtLfZCHKXIVL/DNq8XtKVCDAO0uDwBcVR4EtQlgikacgGHtRbUrp+/AbNDqhp1n1KNOQRCZhpafNIolzey4BBvwcVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064385; c=relaxed/simple;
	bh=UeH21MWoLZK9qwhPVVQmSENxjvt2h6USDonb8uOfEZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIzhTcJ5kYkEr7lm4Ckvjly2iPcMedjbk3P4ycCsJUBhg3gTBb3rVYFULp1fefOkkS6+p2NjXzNJ/xDMS8BbbwO4mFAEKBNDW4+Y2PY/zRdwTJnivDfgVdETy/0HTpOZ9IOKrKEvoGx1oEJw++aPnLlxs0iU7WbIXnraxWFTdbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AFYxgzKY; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a8fba3f769so37780405ad.2
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 13:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777064384; cv=none;
        d=google.com; s=arc-20240605;
        b=VwcGF1yiHCqL3pSLQm5rnmcCAhoVqDX+QrIMAqwS3j7l2CD4EvwoiV1iLGZIs5BjJE
         XseW2nvLQ6DdkK8bZcPPE55r0A2B6+6xujqrKw2YzysjjVLfmM+2kdGNzGtJkXElldsJ
         DxCleLUBae3FUgo6gcEMbIYQJMP6YK0AqqKumQRA0lYFFus9TraU7zAy9teqCEaITVxG
         p/1k23/iib5E0Vqif5JqDhTvMSekXz0hwCkl1SljDhGV0K+oEIRn1zDqKfjr9nki+EOv
         jb9ubklg5Flq+VP6TN6PuTXW3cCk+QLoPS1v3jchq4E3E5fAGUoxYf/7rwTD11644hfZ
         JN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cx20PlWvPq7t/jSP14LCSKX3HGCyhuna9yTPTpknTk0=;
        fh=nj1h/rwdOvqdLxEerGWcRpavvEEeJO2g7GrHl6GZITQ=;
        b=WmaCtP3YnjUpDHK3vG5CMS+5X+NfOuSVGuGY+yt7OIrGmPtnnNRxNz8r2TlbUzndrp
         Yq3k+cbTavwK9m2sjiaDFM/QfOqB88IuzuSOtvmZyMzwh+3GbnjAk9tI+ug24WZVRvfi
         g82uOxU9BmpyYkG5AsKv5Wkq7EkZ7+sHxtOFkJga39/KaC0IYyGdRflSA4gHj5B05jvX
         iSz6J8IURy6dbLMgzMOLzX0tVc5Bpeu+tsMEUMFjEXLlOAEvvGrPp184rI3K3u7q6gW1
         KmXmRxixZp9mJQYD32mIfTuBpgoQ5qgO2tbdRixQiLwwfRTpOglHUlSAafD/tQDFhtpz
         1lag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777064384; x=1777669184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx20PlWvPq7t/jSP14LCSKX3HGCyhuna9yTPTpknTk0=;
        b=AFYxgzKYRbUDqVkO6uhmxHDIhrpxxUfLe9M8Nc9HTLwwXEU8iJLJ47I10OAByCP2pp
         uUMkGmNNpDr6FjxxFMIRfQrLgrK12q1r7gw1bPCg3dM0BgDPbm+Ct3B+ifv1CSd5fcgz
         vXaE6nCxV81WZ0UE/05xEUWmEcatmb+MA0xfj1kIUNNalWC45UW3Oy6bmqpQa7A8C2GH
         EJx2Rxtc86GS5d2V5u1aL8f6S2lQIe5dNBg33IWreA02sX7/2dqZFzKf/YekFFhEDvBs
         iTyoEj+N2pHryD/mVdnL+d8xAbs+ACpsZohmWh6glBzJ40vxQAeD9huI84+0xkQxnIT0
         I1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777064384; x=1777669184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cx20PlWvPq7t/jSP14LCSKX3HGCyhuna9yTPTpknTk0=;
        b=qGQ11U0ZjywyDj0Sranarn/D0pxm9IIfAHbNu7aWZIiC6AsNLDZP/9sFP7tgVWuG0B
         xT+Lu2kBmRj+RhWTcRNufHYryTGhX7lqRX7txb6/G4U6Z1X2aG87O+XNNEuFYggn4Jgo
         Ak6X4Ainqth0x4GEgVdx/4x56UEkiFRRZl7x/O2Eg4ucm5uROqZX70UMuqf6en3fBaRn
         JpXYdcwH9ZAufKP4OwVPDPNHYfJphxKMfMVh7+mySbtOFZHnStwh2u6SDawSDMv903xi
         xGIu70uJ/rrkvZQe8bkpDj75V3t/efxLULoVFvbNmmrGIY7zUMm4M70UGiDkxushhqgF
         dE7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8wlQPcomtTWCE/KZ8WQ0MhHJ+Y41nol02+fQJJptK7i6sPyPDt0iJW8LfkfP1jvaY0LxCcQ8shV5gJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzJucfIJEOeL2CjTm0Zw4cJILZ+AFs4zAXq55SFTV4EUgUzQ/3f
	1qSrbIxC9qSmSbyYYwY5/qfc2Q81aDEKx8i1Jhl9BTraldWUVUYx62q5w2z/BCU/oniOsNvLVv/
	lZzI3Nj8ZKko3ATcQbWvgL45LXZ/f65E9lPbyeDjY
X-Gm-Gg: AeBDiesWk5VbPUMx28TNLycb6KChYZG4ZqJ22tzxgHlnLdc95BMMz1/E3wXynsPNP4A
	ORzU+hRNSc7ln/lR1zBfOGvBrDkRyseJXUNIEIV5jSdrQVxBbCghyjW+r+7GHBzr8gpprzlURW+
	6zuCur6uH66b+aQctS6vGoPFr39GiirtKR3KXcKhtpduX+NqYnby4hOVtQJxqbnLC4ASoR8BUSL
	44PNCJKrUCxT7C3CyrlmDCN1WcDYVmHL3j1clEJv/FSjtxaG8N6agxmvB5bYyWmVVsOnjkPQMbL
	+6WVI0TaJvaa6M9Keg==
X-Received: by 2002:a17:903:3d43:b0:2b0:5d60:7f3f with SMTP id
 d9443c01a7336-2b5f9ee90bdmr253173065ad.16.1777064383845; Fri, 24 Apr 2026
 13:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca> <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca> <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
 <20260424143603.GB3611611@ziepe.ca>
In-Reply-To: <20260424143603.GB3611611@ziepe.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 24 Apr 2026 16:59:30 -0400
X-Gm-Features: AQROBzBvtUdT2Z9qKk4YO4TpY44cZkRRfodVGSuPlBOevRtYkwWicMOMpHeLYC0
Message-ID: <CAHC9VhR++21SD+v4Bb16SQmYHgJYZ0ytQ+BecGPNK+fEOe4G7g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9C477463600
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19533-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]

On Fri, Apr 24, 2026 at 10:36=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
> On Mon, Apr 20, 2026 at 08:58:09PM -0400, Paul Moore wrote:
> > > > > > The access control point itself represents the requested
> > > > > > operation.  This is possible because the number of networking
> > > > > > operations on a given packet is well defined and fairly limited=
; at a
> > > > > > high level the packet is either being sent from the node, recei=
ved by
> > > > > > the node, or is passing through the node.
> > > > >
> > > > > I think we have the same split, fwctl send/recive analog is also =
very
> > > > > limited.
> > > >
> > > > Sure, but I thought the goal was to enforce access controls on the
> > > > firmware requests based on the opcodes/parameters contained within =
the
> > > > firmware request blob/mailbox?
> > >
> > > Yes, that's the goal. It is the same as iptables being able to
> > > identify that a send system call has a packet that is http or dns.
> >
> > I think we still have a disconnect here.  A packet being a DNS or HTTP
> > packet is different from an opcode.  The opcode in the iptables isn't
> > "DNS" or "HTTP" it is "INPUT", "OUTPUT", or "FORWARD".
>
> I understand that
>
> > Most LSMs will want to know who is initiating the firmware request
> > (the subject), the requested operation/opcode (the action/verb), and
> > the target of the request (the object, which in this case is likely
> > the kernel or the device).
>
> How is
>   system_u:object_r:httpd_packet_t:s0
>
> A kernel or device?

It's not.  It's one of two labels on a packet.  I've cautioned you
about leaning too heavily on the secmark comparison as it falls apart
in a number of places, this is one of those places.

> It is a label for packet contents. I also want a label for packet content=
s.

According to your explanations, my understanding is that you want a
fwctl RPC operation.  That is not the same as the secmark label
assigned by an iptables/nftables rule.

> > As I understand things, the action/verb is going to be the opcode
> > within the firmware request.  If you believe I'm wrong about this
> > please help me understand why.
>
> You could make that choice, I'm arguing we should not, and it should
> be in the object side.

Okay, you believe I'm wrong, that's fine, but you need to provide a
(better) explanation for why I'm wrong and your approach is The Right
Way.  Present your case, but please do it without referencing secmark
as that comparison is horribly broken at this point in the discussion.

> > > - op_X_t is the result of the classifier inspecting the RPC
> > >   packet. Admin tells the classifier to return op_X_t similar to
> > >   how --selctx does for iptables.
> >
> > I've tried to explain how this doesn't match with secmark, but I'm
> > evidently doing a poor job.
>
> Yeah, I don't get it at all, sorry. I fell you are making some very
> nuanced distinction with HTTP being an object but the HTTP-equivilant
> in fwctl is not an object, I can't follow it at all.
>
> By that logic:
>
>    iptables -p 80 --string "GET"
>
> Is an action, and it should get a unique action in the tuple.

Let's both do ourselves a favor and drop the secmark comparisons; I
think it is only hurting things at this point.  If we stick with the
secmark analogy I worry we are going to keep repeating the same things
to each other without making any forward progress.

> > If you want to continue with the secmark comparisons it might be
> > helpful to spend some time configuring secmark on a SELinux system,
> > and writing policy for it, to see how it works.
>
> I think I have a pretty good idea, you haven't said anything that
> contradicts what I expect..

Frankly, several comments, including in your last reply, indicate you
don't really grasp secmark, subject/verb/object, SELinux, or some
combination thereof ... and that's okay, you don't really need to
understand those details.  Let's move past the failed secmark analogy
and return to the fwctl hooks, that's the ultimate goal.

> > certain action on an object.  My concern with your example is that the
> > object isn't what is actually being acted upon, it's the requested
> > action.
>
> Object is a label for the packet contents.
>
> > The fwctl ioctl/API allows a user to act on a device, with the
> > actual action being specified by the fwctl payload.  From what I can
> > see, the classifier's output is the action, not the object.
>
> You can take that view, it is certainly one valid way to look at it.
>
> But it is completely impractical.

Elaborate on that, because from what I can tell that is the valid way
to look at it from a subject/verb/object perspective.

> > > The same way secmark cannot pre-identify all the XXX_packet_t's.
> >
> > Once again, I think there is a disconnect or misunderstanding, on a
> > SELinux system using secmark all of the packet types, e.g.
> > "XXX_packet_t's", *are* pre-defined in the SELinux policy.
>
> "Pre-defined" in a text files in user space controlled by the admin.

That's not correct.  It's kinda like saying the NIC driver sources are
simply "text files in user space controlled by the admin".  The
SELinux secmark labels are defined in the SELinux policy sources which
must be compiled and loaded into the kernel before they are valid on a
running system.  Policy must be written not only to define the secmark
labels, but also to define the access control rules which govern how
those packets are handled by the system.  The iptables/nftables
command lines simply assign a secmark label to a packet; that's
important, but only a small part of the total equation.

--=20
paul-moore.com

