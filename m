Return-Path: <linux-rdma+bounces-19376-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IiwGnGX32nXWQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19376-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 15:49:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21353404FED
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 15:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80DD13079CD0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7353CAE9E;
	Wed, 15 Apr 2026 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Kz/AXpbu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CFB3A7828
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260830; cv=none; b=YbngrHrhzh+7UnIdyl+2hqEioh+ETxeMXqC3idF84PGAqV+sb7/sfxVHrT9Vr1c6qt0xl9+yv1DG0wMeksjDHhG3DOc+/c9Lc9jtgZkOJSy54r/uMVd7TFrSEcClPqdYfGMwlg/6DSzy7UxDuqdH0Y+lSuSsku71ok7ZN9oiweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260830; c=relaxed/simple;
	bh=DsDZiqoekDSXhnvu8Hw6B7k2oxF+RKGbcd38/Xn6Clw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNRA3vaAHCxf62axiHE2xDR6H9dwNqH9F+7mdd/7gyxoLWpeZOeL1BPxxfhcZtEiltSYjdBdg3vSP5f4mpZCAHWrBrvQUvBIdo3bXug2xeB/zwTmzdr2FcvA/zQE6IODrn3odBWY45o/nJJtPKjG653PN7HPwD5Y79hBFp5Obxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Kz/AXpbu; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8aca0469204so40654436d6.2
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776260827; x=1776865627; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Eik4sapJ1qNNSpJUkcgxvBfIDMdhd6II0vk3D5WLXU=;
        b=Kz/AXpbuMRt4fqDbjlYmADkWkpGtgIdaMI0GlK4U4Exa7onwd8o+QTIO6ljuGMsqnd
         d6hYuLY7tbTUW0dR1TBIv3gN1IyBmJ4iuJ3JgxbMMNWoBYsZpJLHFn1QxTxuJOiSKf7P
         pblbgr+Hjv04vq4kEbUR0kkq8iLVBaK5Kx6F2ebIxmOx7pZKcRQcYN7cJ7NSSUoN/Yh1
         J1ZaXNhS4+KUM+BP7wpAhFA96/DPdj6cp4bmGDR0q1lZGUiL3CDEehn0u+HdSN+COSaV
         Dcl9QmkjRclTy//NasQnKizs6KGAjHgK5gVhAq0xSHr5GfZ7PUSXHKjXpsZI9RzU57GQ
         /K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776260827; x=1776865627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Eik4sapJ1qNNSpJUkcgxvBfIDMdhd6II0vk3D5WLXU=;
        b=sPp2ZIO/gD/5mFm17rox8m2gjndd7LDQfi17A2VHa/SHJSErQWAZEBlfuEaQrx2fDa
         9Odyyq5txIVBngM4ZZlg65KLEoNo8/SxyGZZCTXDuWPefYu6DzXRWwng5W6abzWWyG4L
         Kj2kQtsfs2JK3IxM9iUUyBGrec8AeYEd9MGkPIGCwrCdLXCQboYjOQrnOuoAEn93oosS
         4A3JJCu9YRejs8OVQ2RJlpUIi7+Ab9l/gF5For7JmVYhXAAYTwZg2VMj+dMDYEIi89oa
         e4klO8DcmSxJxLYLNdTSiC6K3GviDJUht/7Nsxfc0umRivH4EWKtf1zYOFGJkyX2DRwg
         Vg8g==
X-Forwarded-Encrypted: i=1; AFNElJ9k0hdzanoeoj1lAZuJG1byz2Rb/NO4zpYThuwlHkfhHLbJjzCe/qUpV2lI+ZFxNCIx3LE4wv9VQr4t@vger.kernel.org
X-Gm-Message-State: AOJu0YziP+PWlIuRdII1uTEw+9hmg81GODZs1woEMUxT3xPou4gzBpCS
	ua/diPxLDDZTU41Wm38RilDtlImnnkK5ey0oY8P1ujpvATixzgVYkdveAz7//cz0uiU=
X-Gm-Gg: AeBDieuCqZBXXjk4Q4QuouIq+a4gAsAy7Jm4W7ctmk1dngXm2jukqw6GqNRkHfYCiil
	3WA6/61SDcDvOhPuyUbGPqzJbgry8ZwZBZ526jwaJK+0A/HA4Xr0rYolBcDsDp0qq4z+bQUte2d
	oQ/esZ3K1NLJm1Tm2NfMfgACTKH+qRXFLOTXX/pO9QJzVkG/hGLH+/lePrRwb5Qo/z79V86b9uk
	j+G7ZMew0y6R3i75eEMMsKnBofwI0eNlnbyIo24loN5874Cd9OxPDunrPcGTeH+M8y64FPiMLGW
	jqy2hWYf8HNx7MuUYMoj7cxpGyukSo27jUwhBLDf90cZQp8EZ5/B7ruEUzcVCfGSCwhETixewQI
	I68W1VJfwknikpYl7Dr1uGNa9m+XE4stoor5WM5ae4pNH3orw+1H+MorKjYjueff01xbpFjtBpd
	9i5VJeb706dyTSRT8MnWWmfWz3sKuBlSuSdbrpbFtMsuT+LAkB5w4Q2AqNuVHxFzHfOEH6HBvMr
	6Fw/Q==
X-Received: by 2002:a05:6214:449e:b0:8ac:7f70:4441 with SMTP id 6a1803df08f44-8ac862b51ccmr345394526d6.48.1776260827109;
        Wed, 15 Apr 2026 06:47:07 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6ceb891csm11733136d6.48.2026.04.15.06.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:47:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wD0a9-00000000FYO-1ssS;
	Wed, 15 Apr 2026 10:47:05 -0300
Date: Wed, 15 Apr 2026 10:47:05 -0300
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
Message-ID: <20260415134705.GG2577880@ziepe.ca>
References: <20260409121230.GA720371@unreal>
 <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal>
 <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal>
 <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca>
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
 <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19376-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:email,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: 21353404FED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 04:27:58PM -0400, Paul Moore wrote:
> On Mon, Apr 13, 2026 at 7:19 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Mon, Apr 13, 2026 at 06:36:06PM -0400, Paul Moore wrote:
> > > On Mon, Apr 13, 2026 at 12:42 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > On Sun, Apr 12, 2026 at 09:38:35PM -0400, Paul Moore wrote:
> > > > > > We are not limited to LSM solution, the goal is to intercept commands
> > > > > > which are submitted to the FW and "security" bucket sounded right to us.
> > > > >
> > > > > Yes, it does sound "security relevant", but without a well defined
> > > > > interface/format it is going to be difficult to write a generic LSM to
> > > > > have any level of granularity beyond a basic "load firmware"
> > > > > permission.
> > > >
> > > > I think to step back a bit, what this is trying to achieve is very
> > > > similar to the iptables fwmark/secmark scheme.
> > >
> > > Points for thinking outside the box a bit, but from what I've seen
> > > thus far, it differs from secmark in a few important areas.  The
> > > secmark concept relies on the admin to configure the network stack to
> > > apply secmark labels to network traffic as it flows through the
> > > system, the LSM then applies security policy to these packets based on
> > > their label.  The firmware LSM hooks, at least as I currently
> > > understand them, rely on the LSM hook callback to parse the firmware
> > > op/request and apply a security policy to the request.
> >
> > That was what was proposed because the idea was to combine the
> > parse/clasification/decision steps into one eBPF program, but I think
> > it can be split up too.
> >
> > > We've already talked about the first issue, parsing the request, and
> > > my suggestion was to make the LSM hook call from within the firmware
> > > (the firmware must have some way to call into the kernel/driver code,
> > > no?)
> >
> > No, that's not workable on so many levels. It is sort of anaologous to
> > asking the NIC to call the LSM to apply the secmark while sending the
> > packet.
> 
> From the LSM's perspective it really doesn't matter who calls the LSM
> hook as long as the caller can be trusted to handle the access control
> verdict properly.

The NIC doesn't know anything more than the kernel to call the LSM
hook. It can't magically generate the label the admin wants to use any
better than the kernel can.

Just like you could never get everyone to agree on a fixed set of
labels for network packets we could never get agreemnt on a fixed set
of labels for command packets either.

> > > so that only the firmware would need to parse the request.  If we
> > > wanted to adopt a secmark-esque approach, one could develop a second
> > > parsing mechanism that would be responsible for assigning a LSM label
> > > to the request, and then pass the firmware request to the LSM, but I
> > > do worry a bit about the added complexity associated with keeping the
> > > parser sync'd with the driver/fw.
> >
> > In practice it would be like iptables, the parser would be entirely
> > programmed by userspace and there is nothing to keep in sync.
> 
> You've mentioned a few times now that the firmware/request will vary
> across not only devices, but firmware revisions too, 

I never said firmware revisions, part of the requirement is strong ABI
compatability in these packets. 

> this implies there will need to be some effort to keep whatever
> parser you develop (BPF, userspace config, etc.) in sync with the
> parser built into the firmware.  Or am I misunderstanding something?

I would not use the word "sync". It is very similar to deep packet
inspection, if you want to look inside, say, RPC messages carried
within HTTP then you have to keep up to date. How onerous that is
depends on what the admin's labeling goals are.

> > > However, even if we solve the parsing problem, I worry we have
> > > another, closely related issue, of having to categorize all of the
> > > past, present, and future firmware requests into a set of LSM specific
> > > actions.
> >
> > Why? secmark doesn't have this issue? The classifer would return the
> > same kind of information as secmark, some user provided label that is
> > delivered to the LSM policy side.
> 
> I think there is a misunderstanding in either how secmark works or how
> the LSMs use secmark labels when enforcing their security policy.
> 
> The secmark label is set on a packet to represent the network
> properties of a packet.  While the rules governing how a packet's
> secmark is set and the semantic meaning of that secmark label is going
> to be LSM and solution specific,

"network properties" are a bit vauge. I can use iptables to inspect
the packet quite completely. It has protocol modules that can do very
detailed inspection. I can use general things like -m string to apply
a secmark to packets containing specific data for example.

From my perspective iptables runs a complicated scheme to evaluate the
full content of the packet and on match applies a secmark.

You can already create a hacky labeling scheme that would tell the
difference between HTTP PUT and HTT GET sessions for example.

At this point it is not just "network properties" but you are
inspecting a RPC and evaluating what operation a remote CPU will
perform.

Even just simple port inspection in most cases is often classifiying
RPCs on the network "Any HTTP RPC" "Any DNS RPC", etc.

> secmark labels represent the properties of a packet and not the
> operation, e.g.  send/receive/forward/etc., being requested at a
> given access control point.

Yes, still aligned.

> The access control point itself represents the requested
> operation.  This is possible because the number of networking
> operations on a given packet is well defined and fairly limited; at a
> high level the packet is either being sent from the node, received by
> the node, or is passing through the node.

I think we have the same split, fwctl send/recive analog is also very
limited.

> As I understand the firmware controls being proposed here, encoded
> within the firmware request blob is the operation being requested.

I am not proposing that kind of interpretation, I want to stay in the
secmark model.

When the packet blob is sent into the kernel at the uAPI boundary
(send_msg, send, write, FWCTL_CMD_RPC, etc) that is your access
control point.

Deep inspection on the packet blob determines the secmark.

LSM takes the secmark and determines if the access control point
accept/rejects.

In both cases deep inspection will allow the admin to create labels
detailed to the RPC that is described in the packet. Eg
labels like "HTTP GET", "HTTP PUT", "FWCTL CREATE OBJ X", etc.

In both cases these are packets containing RPC messages some remote
CPU will excute.

> While we've discussed possible solutions on how to parse the request
> blob to determine the operation, we haven't really discussed how to
> represent the requested operation to the LSMs.  

I don't understand this? The secmark example I pulled up is this:

iptables -t mangle -A INPUT -p tcp --dport 80 -j SECMARK --selctx system_u:object_r:httpd_packet_t:s0

The "represent the requested operation" is the string 
"system_u:object_r:httpd_packet_t:s0", which is entirely admin
defined, right?

The analog here is some

'fwctl iptables' -match 'byte[10]=0x20' -selctx system_u:object_r:fwctl_mlx5_create_pd_t:s0

Again, all admin defined?

> I'm assuming there isn't a well defined set of operations, and like
> the request format itself, the set of valid operations will vary
> from device and firmware revision.  I hope you can understand both
> how this differs from secmark and that it is a challenge that really
> hasn't been addressed in the proposals we've discussed.

I still don't see the difference from iptables. IPSEC, SIP, DNS, HTTP,
etc are all protocols with the same lack of any commonality.

> At a very high level the access control decision for firmware/device
> requests depends on whether the LSM wants to allow process A to do B
> to device C.  The identity/credentials associated with process A are
> easy to understand, we have plenty of examples both inside and outside
> of the LSM on how to do that.  The device identity/attributes
> associated with device C can be a bit trickier, but once again we have
> plenty of examples to draw from, and we can even fall back to a
> generic "kernel" id/attribute if the LSM chooses not to distinguish
> entities below the userspace/kernel boundary. 

I think I would feed that into the classifier as well. Like iptables
can have a netdev argument to only match against specific devices, we
can have the same logical thing.

> I think the hardest issue with the firmware request hooks is going
> to be determining what operation is being requested, the "B",
> portion of access request tuple.  If we can create a well defined
> set of operations and leave it to the parser to characterize the
> operation we've potentially got a solution, but if the operation is
> truly going to be arbitrary then we have a real problem.  How do you
> craft a meaningful access control policy when you don't understand
> what is being requested?

Same as for networking. Admin understands, admin defines, kernel is
just a programmable classifier.

Jason

