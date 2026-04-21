Return-Path: <linux-rdma+bounces-19445-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFsTFM/L5mnu0wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19445-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 02:58:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A0343531B
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 02:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C615B30075E4
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 00:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEDF235045;
	Tue, 21 Apr 2026 00:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JkYmabei"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3C21CFE0
	for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2026 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776733104; cv=pass; b=d/qikaxkCRBtA48YIJ18VJAGM6mXXWEQvpDVSZXU3lmPpg4jVPzv0XGSYSItqp7bHJpKSJ1sy2MUZh0DJyYS4rlYN5tHdmh+X1dRV0F7Iq1oMAp371cvjw0nS5xijYv5hEszNfZUnd6fGGV59LkMJJasAveGiFbE2Dfc/O8pbCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776733104; c=relaxed/simple;
	bh=LHJgU5o4zlFKIDCYIg/sT/NOeaqAOnix6HRSAOXirFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gos5gEbvqfOfD5WvCRxl5mDFeSMmZsgbADIUkH20LfT6mtVR8xaz3aKWRcSewdTMKN757BVe/ES7O3h1fbGy3bOBoHZg4JxkbSWgU2CtnFDVlsLEWOOfgoqaHWvwNjgyWhzzt87xJ0YbP25pDph2AKEDSubYf0MttbNOgSlXv7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JkYmabei; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso2209554a91.0
        for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2026 17:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776733102; cv=none;
        d=google.com; s=arc-20240605;
        b=NH4bJS7mqCUgXTUeinvpm3eVExItd587esWza+tDNfFB/y2rUpvHTmJxaUGqn8GaxJ
         yqb/oiIHE+GO9y0wfu44rXH9BKgPUHjvh03hDntYzwwmoqT7MmWqxLL8rSb5ZTDo3uuh
         nGht6vBsFr3cUStl+A1JUk/egQJuIv95oz3AHdcUtMRlibWty5iOUO+JuOu5qQGprXah
         jNFvAuIlskmbeVuCsM46mH5eu32cVSPeN2ygxags5oLLpA3sU+S4ywqwI8zsWc3Abj1O
         jsN6QVQBlVH6rxJ7+/7jUmP0PhTDZHzD+lrh247OiY7qhnNAiV1yQdhOMprHKxRvTaax
         t5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hlwm4FYDSQRfdqm2h1oqg/AzDTMUaQgoUeyswjnB5ZI=;
        fh=TSFsIuklp8fErGtPItdhWI+SQz8uYNL1E7EPbR9gs/c=;
        b=Hiqgvqvm3jARVZDETWLksZoexLuUGhQQTs+bHJRJcre1GwoXC5m5qI+49mzOkV/Cc5
         34L3kFDvW+4pghkqBRimSIKsSCKKr4/gGvVsOhCBOLL5QhlowVG5zqYveiJJedrocTRg
         glqiYA9+Vq9NE+jlE3r7efuSxJ3oO0GCqQ7JaP412dwxBumAPQvAs/qh7KT9crJ6I8bO
         4IobN0bRliyi1/5Dj1JgHT+9BEF1opdkT+xM19Jobq+nfLN/N3WwZkbb3YNfBwwvFCuN
         Ffg0Q0kjnE3VY7s2hhy5Dd9Doy4YWHKXMueUGI7SDAZeNl2cbbWQuKQkN1HrrMrNL4sv
         W2AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776733102; x=1777337902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlwm4FYDSQRfdqm2h1oqg/AzDTMUaQgoUeyswjnB5ZI=;
        b=JkYmabeixhCW3tygHOkl8WHNX/J5tVEwBNxaOTCUx1fhT6a4VRqQ4KTAUyOp3RDzcn
         V8rNaSD14WyBq0UFkks5ao98rXVK3xZTp0vPPBgZXL+myN3j2A+m/YTxtYio3DbwnCqc
         VeQVeVooZ439Cgg6nHODQ1sgd8g/YMq2EUK6EcGw/jahwiVYFs7PCtBItL1d6bBvvr2I
         DVKePZQq+wXAxdNzkOrwyzwx5AM0ZK//yXwoI3hdFCf19AQFfnWSUAyB3TcdIc9mG3xf
         acFtYZZ7W9wyU5pL86gjdQm6SDB/HwvmuAyhoj9z3R9H9j7NVYzJKus5oAOsTWd+Mpyz
         hpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776733102; x=1777337902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hlwm4FYDSQRfdqm2h1oqg/AzDTMUaQgoUeyswjnB5ZI=;
        b=NIv02wB3p7sECd164laP5Z4ZlUCvCF0o7Mrkl8oyn1Y3EXJz4X+DogewR5UHZzpQ4c
         XdchghQYi8tczbEiHjpaKMXWj4XSh94VzxTQZe0A5a3FkDJqLSLnOk5yVJFsKGqmyOML
         uR35sR4ypLbaFb4KSSA2icgX8AT9OM/y3lNgFefzFZIwckAQk0MXmktHOGt8GK9qIxYF
         WGW8gZqUOF8J63K0OX+s5sg0+46yR43pHBFxOOFmiuAe8rWUJTwsu6eCLmjoiiPM9M6o
         TbwKSMW/F48XmpUDBTulsuuNKralr33kVYGLCzGexTY5t3SxJYUFp8wbKs4V3S0M2WCx
         WdxA==
X-Forwarded-Encrypted: i=1; AFNElJ9BqZtgKXpvINGpfSZ0/y9OBLlUxFsJpwWQNSLP9XXE44C0IswG+VQFuckjVu5NMG4jX14Z6BMVd2SO@vger.kernel.org
X-Gm-Message-State: AOJu0YwZwZgOW+Ov/uibKKtothXkcAOcpQGnYCLFMt59QG0bDVyTzqZh
	8naaQw3DOxvIXd/NIyT52aHIyBUs2Z9UOUYg7MV4EJZ/VxSex59qDTdtKOPY+LXKPLIFsKNLrjx
	Crc8fUI+8ZLOgZkWOo+DsemrOvmDCZvC0GWsEQX/t
X-Gm-Gg: AeBDieuDeQTR3GqtFDmJaLViFxhahU8he4zMa/Sz6I/4N3k/hnxBaHNw2xdp0Lfman7
	jvGuqAlOXAQK8pvk1wW/9tJIAPMtwsYHF+O1vt/f6KkrEac0WUcIJnbN6EwphcWDX2SzDhtKz5M
	QzjlDOWC9wPj3wJoURgOF2MT/0gp/DQEwf7tN+cLE5P5w28/GhVTuPDg/Ou5qnGhvMnHJEXMtje
	a2vJMXPsRAZ96NxSixUJ2+sZSaHKi3KL0AXH0+ZNiaWDJSzUD8G13qdWqYMgwmhDS+RrdLs1FSA
	xORxkJ0u0o1TpPIm7kr1eSL/Qu3i
X-Received: by 2002:a17:90b:4c8c:b0:35f:be09:1a2b with SMTP id
 98e67ed59e1d1-361404104d3mr15707115a91.10.1776733101940; Mon, 20 Apr 2026
 17:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca> <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
In-Reply-To: <20260417191749.GK2577880@ziepe.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Apr 2026 20:58:09 -0400
X-Gm-Features: AQROBzD3bPay_GfERLBaTKyLHFewS9zTfkn7kJbzuJjwn1OBJ7EB6NLWqF-EJvc
Message-ID: <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19445-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7A0343531B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 3:17=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
> On Wed, Apr 15, 2026 at 05:40:04PM -0400, Paul Moore wrote:
> > > The NIC doesn't know anything more than the kernel to call the LSM
> > > hook. It can't magically generate the label the admin wants to use an=
y
> > > better than the kernel can.
> >
> > The NIC presumably knows how to parse the firmware request and extract
> > whatever security relevant info is needed to pass to the kernel so the
> > driver can make an access control request.
>
> Not in practice, we'd have to agree on how to describe the "security rele=
vant
> info" and that won't happen..

I think you're going to find that you need to describe the security
relevant info regardless of how you implement things, but we can leave
that discussion for below.

> > Leon mentioned that different firmware revisions would have different
> > parameters for a given opcode, and that one would need to inspect
> > those parameters to properly filter the command.  Is that not true, or
> > am I misreading or misunderstanding Leon's comments?
>
> They are ABI stable, so there will be rules about future changes that
> old software can follow to ignore or reject future things it doesn't
> understand.

Good, "ABI stable" means there is some hope :)  Based on the various
discussions I'm guessing both the ABI and any assigned numbers
are/will-be vendor specific?

> > > > The access control point itself represents the requested
> > > > operation.  This is possible because the number of networking
> > > > operations on a given packet is well defined and fairly limited; at=
 a
> > > > high level the packet is either being sent from the node, received =
by
> > > > the node, or is passing through the node.
> > >
> > > I think we have the same split, fwctl send/recive analog is also very
> > > limited.
> >
> > Sure, but I thought the goal was to enforce access controls on the
> > firmware requests based on the opcodes/parameters contained within the
> > firmware request blob/mailbox?
>
> Yes, that's the goal. It is the same as iptables being able to
> identify that a send system call has a packet that is http or dns.

I think we still have a disconnect here.  A packet being a DNS or HTTP
packet is different from an opcode.  The opcode in the iptables isn't
"DNS" or "HTTP" it is "INPUT", "OUTPUT", or "FORWARD".

Most LSMs will want to know who is initiating the firmware request
(the subject), the requested operation/opcode (the action/verb), and
the target of the request (the object, which in this case is likely
the kernel or the device).

For most LSMs, I expect the subject to be the process making the fwctl call=
.

Similarly, the object will likely be either the kernel or the device itself=
.

As I understand things, the action/verb is going to be the opcode
within the firmware request.  If you believe I'm wrong about this
please help me understand why.

> > > LSM takes the secmark and determines if the access control point
> > > accept/rejects.
> >
> > At this point I think it would be helpful to write out the
> > subject-access-object triple for an example operation and explain how
> > an LSM could obtain each component of the access request.
>
> I think I am talking about this:
>
> app_1 FWCTL_RPC op_unpriv_t
> app_2 FWCTL_RPC op_priv_t
>
> - app_x broadly comes from the process executing the ioctl

Yep.  Were on the same page here.

> - FWCTL_RPC identifies the IOCTL userspace called to send the RPC
>   packet

Maybe.  That is an option.

> - op_X_t is the result of the classifier inspecting the RPC
>   packet. Admin tells the classifier to return op_X_t similar to
>   how --selctx does for iptables.

I've tried to explain how this doesn't match with secmark, but I'm
evidently doing a poor job.  If you want to continue with the secmark
comparisons it might be helpful to spend some time configuring secmark
on a SELinux system, and writing policy for it, to see how it works.

Beyond that, I think you will find that most LSMs - although not all -
define their security policy via an abstract subject-action-object.
The policy either allows or rejects a subject's ability to perform a
certain action on an object.  My concern with your example is that the
object isn't what is actually being acted upon, it's the requested
action.  The fwctl ioctl/API allows a user to act on a device, with
the actual action being specified by the fwctl payload.  From what I
can see, the classifier's output is the action, not the object.

> > > Same as for networking. Admin understands, admin defines, kernel is
> > > just a programmable classifier.
> >
> > Are you able to define all of the firmware request operations at this
> > point in time?  That is my largest concern at this point, and perhaps
> > the answer is a simple "yes", but I haven't seen it yet.
>
> We can identify all the IOCTL points where the RPC packet will be
> delivered to the kernel (send/recv/etc)
>
> We cannot pre-identify all the mlx_XXX_op_t's an admin might want to
> use.
>
> The same way secmark cannot pre-identify all the XXX_packet_t's.

Once again, I think there is a disconnect or misunderstanding, on a
SELinux system using secmark all of the packet types, e.g.
"XXX_packet_t's", *are* pre-defined in the SELinux policy.

--=20
paul-moore.com

