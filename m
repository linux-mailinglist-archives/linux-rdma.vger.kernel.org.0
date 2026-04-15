Return-Path: <linux-rdma+bounces-19379-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDM/BeEF4Gn4bgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19379-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 23:40:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B08614083A8
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 23:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FC75301919D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 21:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823EB38F233;
	Wed, 15 Apr 2026 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BcOtAwql"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F8386442
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289218; cv=pass; b=WFb0zWraimUN4x61hc1y/IuJyw25OLGtelvWm7SDapXsx8PZxW6LpRdd16lRQdzYIxKor9PS7zu30FCLxCoOweMxt+BgLly97CgJ7Nyq9NijeiM6QsHoTcJp0GC+K7VJjulwqd1HI8igm+mlR6FgzwCH+ItNR3Pu1A9Wb/Cm36I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289218; c=relaxed/simple;
	bh=8UR0cDfhMut89P6pq2m3AtdE1q+9Y0wHgL4ZA4SRoPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXqXj0To3tmtdA/Oj7mC5I98y0Y5Y5edUuNhmhN8Mp0R/CZ5nenTVQioZbgPYhbX+/nhaw1zgroWikc3w60wJ9FGHv9uDgD5CSVYfw8/Mp716Ku2AYCPOo08SgGzwFfPabmTzLsk43zmILwrxiyOIKARthN3vqdEINDQWKcvbxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BcOtAwql; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b23fcf90b2so68980115ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 14:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776289216; cv=none;
        d=google.com; s=arc-20240605;
        b=YogduzQsbNAjz8wqpPJcryJevXAHNbzEiRn6GaFwhWbTHNROKws5hfVuj6ei7s7vF8
         luvWd0iH9kotZliztgEu3GrQhP8ukjObc7NYfJbcFY8m03z06bcDcC7r/lkE6sGA0aph
         46c7OAf+iNq/d+u56+r5l5MluBr2gW17mBKUFW4aNsInfD1UBFWosJi4sdow6CcDOXFV
         KgGIAOqE7FT0M5miuodjsKgQbYWN+jtWbVHi2k61kfLWoRRF5/AfpH7aR7pqoOUnH96u
         PTGVFoKYEsTHLgML33YDfvrvu07P9xt5ra99cBH6l0xB0gbeCP4SlfILyRN9ZmN3bB0c
         P7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XAztYF0GmlO3kNqglTk5wxwxcVj4RUNUTqhb0zF4bE8=;
        fh=kSa/ts8Rm33LSX53Rtc+kuFS3v3GCsyqpyz9YdUy2Ho=;
        b=hYutMYSJXz5S8eVaC69mjS2wJ+xS0HUc+9OZk/t+Az4TFyGeYyYiRLvR4NpuWdfyzw
         swkZTFKJb1Ec/ezp5eS4mMQqydFmyVTiL1nLU0f/Di0L88VX8rHuPKsHgXfkCDmrEo0q
         CtDefYGoE05W3/8Y+K4XAWGNcY/mJzy+CTLzWFGNRZZjK2bpCo6HNhpD4ZpuCWSAFeTU
         TRJKMdxbE64tr6tnAfBJmHzQHWQyMGAHODxEMP3vNJy5vbOg3/6qsuRlETS/niQMpVRh
         pihyT8huIadhHDA+r3mMIlAExF0z2GJ5J+hkdUrZwePowBocaciFKKHbfisrWC+kYbZ+
         nRsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776289216; x=1776894016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAztYF0GmlO3kNqglTk5wxwxcVj4RUNUTqhb0zF4bE8=;
        b=BcOtAwqlEurfknwp7jdNCxVQeHrdkO5jKP42hmDqgS5W5QQx01RLTeKPzlrw+X2fFt
         6C/3ow8TDL/OMILDXBf5nxTZh+3utD9QRDi5a+eOZie7KaJQ2ERJdc7jCELB5vsNmojf
         50vbRbE1lxvh3eoa9HBxtih2siyloGwx+GXsUFlE/xVSSTA5jHG3kvNlle0fB4RTls4/
         S9tkZlnIw5J02o62E7bwToewDq221Y8c6ZzskLdvPhImUb7Iafg9onU1DIpwvgFFvNGR
         ZztUWosIm/WHs6rWK1nEJOF97zLA3783cW/e1YtDY3Dcq6tZABDB3vk8Uslaxpb+O2gW
         GcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776289216; x=1776894016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XAztYF0GmlO3kNqglTk5wxwxcVj4RUNUTqhb0zF4bE8=;
        b=ol2Rlt8gGpbQu5Yh+cxDFsGPc3Omf+RZw/IQr6lhT4VCPlnhHim+VRJ6xL8iKus2S2
         lFeKBZ0apVXL1jDCsYvAfCc3Ka/vJcRqnaVXmOjS4Vb7MCKqLxp33PlhTeP3yOeFUfOB
         HDSTJDCCOgAR7dsJ9geqix3bNkzWJaDJEg7pNjIuVrwxo91/r4aqLhpyW8yRi+Pktcso
         E2uAQTGxZ6aHZAyA35JkLQ0ws48epwhPRbrLZLJ4h74WyGqRhzyyhFEvruWkmAe3uKtQ
         9OiOORFaZ26d8o04aPBi9R1Qzca4wlwDMka2Em2gbcD7a0FNeyELO+vMGxNDJEW058G3
         rwJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YLnRrY/n6JaHkEr+dovYh4MQv9nMbAZNqwJF4AHbd3rftw04zknhWiZzF7LUHvGigvQTaz7hGG41i@vger.kernel.org
X-Gm-Message-State: AOJu0YyVG5tMTKwZYxcq4ByzipIvJuojcxR0otvB+YATWFMPUoK6R9lw
	mkb63jCkVZSK4hCrha+kF7SU5iT/0NdnVVTZVmwnft+hpn7TlZVUe8OaGKHsu7J6D2t/2SkWs/y
	OjWBhuEZTkPdrpI1Ug/BloASVW/o6xwZc1A7v+BYK
X-Gm-Gg: AeBDies1YuONXV2FmRyxKI5StIJeq9W9EUJ9HJ6BnTNUe7xbTFn7vpqzsUCwBnxmqVF
	8B8bKMFmryOwTPi5R1BmnE7yAJBtT6YWne0oFI20Qp7b49UD1BOplIdMoKqL/dXfUTLLyYj5VKE
	R1haaye7+E1hL8TDJlphA3QGiNhmkREegQANaz4WYBCbWrD9EMgwT4PNYN0uxg65xydjAAyeCHG
	nixEd/Qh6tIN07umdQBIpSRkAM/8gU56sKrIYHZSfVfXXwErIlxBhqc55aw8f+1vHk6rtIqgvXi
	F+Ax5MA=
X-Received: by 2002:a17:902:d507:b0:2b4:5cd0:b6c3 with SMTP id
 d9443c01a7336-2b45cd0bb63mr176613365ad.29.1776289216207; Wed, 15 Apr 2026
 14:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca>
In-Reply-To: <20260415134705.GG2577880@ziepe.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Apr 2026 17:40:04 -0400
X-Gm-Features: AQROBzCNI3m8c-jwsYPK1Y_GRo5FoCh3UrWW71P1zu__g4Bit16U6EWg6GpNPb8
Message-ID: <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-19379-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B08614083A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 9:47=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
> On Tue, Apr 14, 2026 at 04:27:58PM -0400, Paul Moore wrote:
> > On Mon, Apr 13, 2026 at 7:19=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > > On Mon, Apr 13, 2026 at 06:36:06PM -0400, Paul Moore wrote:
> > > > On Mon, Apr 13, 2026 at 12:42=E2=80=AFPM Jason Gunthorpe <jgg@ziepe=
.ca> wrote:
> > > > > On Sun, Apr 12, 2026 at 09:38:35PM -0400, Paul Moore wrote:

...

> > > > We've already talked about the first issue, parsing the request, an=
d
> > > > my suggestion was to make the LSM hook call from within the firmwar=
e
> > > > (the firmware must have some way to call into the kernel/driver cod=
e,
> > > > no?)
> > >
> > > No, that's not workable on so many levels. It is sort of anaologous t=
o
> > > asking the NIC to call the LSM to apply the secmark while sending the
> > > packet.
> >
> > From the LSM's perspective it really doesn't matter who calls the LSM
> > hook as long as the caller can be trusted to handle the access control
> > verdict properly.
>
> The NIC doesn't know anything more than the kernel to call the LSM
> hook. It can't magically generate the label the admin wants to use any
> better than the kernel can.

The NIC presumably knows how to parse the firmware request and extract
whatever security relevant info is needed to pass to the kernel so the
driver can make an access control request.

> Just like you could never get everyone to agree on a fixed set of
> labels for network packets we could never get agreemnt on a fixed set
> of labels for command packets either.

I don't follow you here ... I'm guessing you are talking about secmark
labels?  The secmark concept was created not due to any disagreements
on packet labels, but rather the challenges and impacts associated
with packet matching directly in the SELinux code.  Secmark was seen
as a more elegant approach to packet matching than the older
"compat_net" SELinux code it replaced.  Even with secmark on SELinux,
the packet labels need to be defined in the SELinux policy, the
netfilter code simply assigns these labels to packets using the
netfilter config.

> > > > so that only the firmware would need to parse the request.  If we
> > > > wanted to adopt a secmark-esque approach, one could develop a secon=
d
> > > > parsing mechanism that would be responsible for assigning a LSM lab=
el
> > > > to the request, and then pass the firmware request to the LSM, but =
I
> > > > do worry a bit about the added complexity associated with keeping t=
he
> > > > parser sync'd with the driver/fw.
> > >
> > > In practice it would be like iptables, the parser would be entirely
> > > programmed by userspace and there is nothing to keep in sync.
> >
> > You've mentioned a few times now that the firmware/request will vary
> > across not only devices, but firmware revisions too,
>
> I never said firmware revisions, part of the requirement is strong ABI
> compatability in these packets.

That was my mistake; it was Leon.

Leon mentioned that different firmware revisions would have different
parameters for a given opcode, and that one would need to inspect
those parameters to properly filter the command.  Is that not true, or
am I misreading or misunderstanding Leon's comments?

https://lore.kernel.org/all/20260310175759.GD12611@unreal

> > this implies there will need to be some effort to keep whatever
> > parser you develop (BPF, userspace config, etc.) in sync with the
> > parser built into the firmware.  Or am I misunderstanding something?
>
> I would not use the word "sync". It is very similar to deep packet
> inspection, if you want to look inside, say, RPC messages carried
> within HTTP then you have to keep up to date. How onerous that is
> depends on what the admin's labeling goals are.

I'm not sure what to say here, that sounds like a synchronization task
to me, but if you have another term you prefer I'm happy to use that
instead.

> > > > However, even if we solve the parsing problem, I worry we have
> > > > another, closely related issue, of having to categorize all of the
> > > > past, present, and future firmware requests into a set of LSM speci=
fic
> > > > actions.
> > >
> > > Why? secmark doesn't have this issue? The classifer would return the
> > > same kind of information as secmark, some user provided label that is
> > > delivered to the LSM policy side.
> >
> > I think there is a misunderstanding in either how secmark works or how
> > the LSMs use secmark labels when enforcing their security policy.
> >
> > The secmark label is set on a packet to represent the network
> > properties of a packet.  While the rules governing how a packet's
> > secmark is set and the semantic meaning of that secmark label is going
> > to be LSM and solution specific,
>
> "network properties" are a bit vauge ...

That is one of the main reasons we moved from the old "compat_net"
solution to secmark so that we could leverage all of netfilter's
packet matching capabilities.  Once again, if the issue is simply a
matter of phrasing, please let me know what terminology you would
prefer.

> > secmark labels represent the properties of a packet and not the
> > operation, e.g.  send/receive/forward/etc., being requested at a
> > given access control point.
>
> Yes, still aligned.
>
> > The access control point itself represents the requested
> > operation.  This is possible because the number of networking
> > operations on a given packet is well defined and fairly limited; at a
> > high level the packet is either being sent from the node, received by
> > the node, or is passing through the node.
>
> I think we have the same split, fwctl send/recive analog is also very
> limited.

Sure, but I thought the goal was to enforce access controls on the
firmware requests based on the opcodes/parameters contained within the
firmware request blob/mailbox?  Or are you happy with a single
send/receive level of granularity?

> > As I understand the firmware controls being proposed here, encoded
> > within the firmware request blob is the operation being requested.
>
> I am not proposing that kind of interpretation, I want to stay in the
> secmark model.
>
> When the packet blob is sent into the kernel at the uAPI boundary
> (send_msg, send, write, FWCTL_CMD_RPC, etc) that is your access
> control point.
>
> Deep inspection on the packet blob determines the secmark.

... and this would be done by your BPF classifier, yes?

> LSM takes the secmark and determines if the access control point
> accept/rejects.

At this point I think it would be helpful to write out the
subject-access-object triple for an example operation and explain how
an LSM could obtain each component of the access request.

> > While we've discussed possible solutions on how to parse the request
> > blob to determine the operation, we haven't really discussed how to
> > represent the requested operation to the LSMs.
>
> I don't understand this? The secmark example I pulled up is this:
>
> iptables -t mangle -A INPUT -p tcp --dport 80 -j SECMARK --selctx system_=
u:object_r:httpd_packet_t:s0
>
> The "represent the requested operation" is the string
> "system_u:object_r:httpd_packet_t:s0", which is entirely admin
> defined, right?

No it isn't.  The string you've identified is the packet's secmark
label, one of two packet object labels in SELinux (we'll ignore the
other for our discussion).  Ignoring the managment controls, the
"requested operation" in SELinux is going to be either send, receive,
forward_in, or forward_out.  If we look at some example
subject-op-object triples for a secmark packets, entering or leaving
the system you might see the following:

 httpd_t RECV httpd_packet_t
 browser_t SEND httpd_packet_t

> > I'm assuming there isn't a well defined set of operations, and like
> > the request format itself, the set of valid operations will vary
> > from device and firmware revision.  I hope you can understand both
> > how this differs from secmark and that it is a challenge that really
> > hasn't been addressed in the proposals we've discussed.
>
> I still don't see the difference from iptables. IPSEC, SIP, DNS, HTTP,
> etc are all protocols with the same lack of any commonality.
>
> > At a very high level the access control decision for firmware/device
> > requests depends on whether the LSM wants to allow process A to do B
> > to device C.  The identity/credentials associated with process A are
> > easy to understand, we have plenty of examples both inside and outside
> > of the LSM on how to do that.  The device identity/attributes
> > associated with device C can be a bit trickier, but once again we have
> > plenty of examples to draw from, and we can even fall back to a
> > generic "kernel" id/attribute if the LSM chooses not to distinguish
> > entities below the userspace/kernel boundary.
>
> I think I would feed that into the classifier as well. Like iptables
> can have a netdev argument to only match against specific devices, we
> can have the same logical thing.
>
> > I think the hardest issue with the firmware request hooks is going
> > to be determining what operation is being requested, the "B",
> > portion of access request tuple.  If we can create a well defined
> > set of operations and leave it to the parser to characterize the
> > operation we've potentially got a solution, but if the operation is
> > truly going to be arbitrary then we have a real problem.  How do you
> > craft a meaningful access control policy when you don't understand
> > what is being requested?
>
> Same as for networking. Admin understands, admin defines, kernel is
> just a programmable classifier.

Are you able to define all of the firmware request operations at this
point in time?  That is my largest concern at this point, and perhaps
the answer is a simple "yes", but I haven't seen it yet.

--=20
paul-moore.com

