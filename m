Return-Path: <linux-rdma+bounces-19355-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGObLIOj3ml5GwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19355-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 22:28:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D58A3FE5E1
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 22:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E905F30786FB
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 20:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B303242BA;
	Tue, 14 Apr 2026 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AxWq4HDJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CFE31F993
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198492; cv=pass; b=uzDO3jtLZv6Uf2fyPK2VVFmpNH4tyOhhrV1Wlm874nh+YIav9Iwxn9IQTJJ4oFnGAdk30V8fnAdwOzAWn2awTJcH5L/bxfy1tgmOjsEUK0xQsYsY9AnLhGkqaKHUYu6YBtxok8dzh8BbBbNeehXdQXI/uGJNREbQfybeQg3uxRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198492; c=relaxed/simple;
	bh=SZNreY6ilaQZcfu+hbcMb9jeeliOvd2TnQQxoDEAWuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8AInvKPGq0Wp8gGRutjz7JiPwToSIPjys7xwyJFCukcbyohKpJOzBvxZUWYuI1+nKqZ5IqY5vEI+iymwZtj4lAMjCQpVCWspjfRrXw/6skrVI9xo5PvvZT3zfW1wFv4gfexCaFMPqRB+53tOJgOADLQmmFmvuT1G33OJle3BQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AxWq4HDJ; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2ea1b3962so17963845ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 13:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776198490; cv=none;
        d=google.com; s=arc-20240605;
        b=WjY+0tIeL/1FqEubZbPvslDorjFsiukHDlGnF7VRTFoF2/DTuR2DYh2wQk0mAg675w
         hNIZSbcQRyKVyWvMqVFbJoqlqnxreQ1Xfjc/r/ugnnXozDBOs5sSCfClcjGl7CjGarTQ
         sBx2EgnfTvKcX4YbCUbVv48DBD03OzoSKal+MqvIhPthvSc/hxe4wAVjOkNW5p4iQnFa
         xJTLdtPFMEZjpdKGVhbw+qUxvX5r9HomrQnMaAgG9gtV/MpyEA83CWqGxNCykyK+Bi86
         Q/uUpfeykYJ/dTBOPcdvmwc1y9ErHoRyqJUVV2hp4DCML3WsdJZMvhqFZQam8mHzPin9
         NKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4+V4wukdzxX/SIEN/WV7x1rli0RNhXIqb9fJKBWExgk=;
        fh=Q6igYbM3BTRk69pYEfu4ANRoBbvQ/kqzf+q4obMJLEM=;
        b=aKOMhutcAlzNym0T3Mv4IUAniBmZozOhlYZWLi/wew94txlb+VLH8LUTOvV7Uz8Fsr
         HYaFtEaWpUjlNDWuU+JN65vQCssi305iJZxUFy26akmxiaAYgbA2U5nWv6Im0Bb324Jz
         0tGc0CSIJUzTjajk+KfRwYs+yZQZ8fmtO0PG0B71gwAzga1+KnqVLf9+RIpD3M1jvVp4
         wBkPm+VBpJ/TFp2RXQYKdp3ev3pTA5oAORWfbN+4nYH6CpHpFqWzE7k8y6Dsrc5X2N43
         CNUkcZnecxDGUawwZTRHAM00HzvbABZljihAupRVBgepiZ1DEXySUyVglbRRndhV8Exk
         9Cvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776198490; x=1776803290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+V4wukdzxX/SIEN/WV7x1rli0RNhXIqb9fJKBWExgk=;
        b=AxWq4HDJRMYWRZNqKN510OSiQh3m40hpYrIwI+wHHNJ3C7YXKCZw8JSd3V0SOAZUyw
         eJpEL0t+vRKgNARUCvdwmYLx7r6jhVIbeR0fnZgsfNcZ4HBFJ61yF7nE7xnvzipQD1TU
         AVO1hPICbmRqoxcSi1gfmCLa+nE9gk+AL58pH4AGtU6FmA5cSXoBA+RVhZWoueDa3VkH
         ih95DyyKUXB3VIL1bXcz4EI4VLowZ9E+bqM7Blvi+knHFapkeW0BEAgsEgIeVHFKgXBt
         cwy7vUqbOKYZIA+LCmHRO6nBs3PIl0R+hEuqqFhc4fRrYmhTkdEXpywZ1zx3YCFJ+cHf
         K+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776198490; x=1776803290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4+V4wukdzxX/SIEN/WV7x1rli0RNhXIqb9fJKBWExgk=;
        b=mAPFFVqrlGAf7fT+YD8bpr2Vprb+4lXwFJojIDxZnwNDrcZpieNKtD5qx0RtYpfzTa
         x4xx55sYMqg6xW+h+mC2SQZaTQKlS75JR6jrRwmaIczp0jSGpR9XGUgpro5j+nrjiYsG
         B7INEcHEQXSEABp7acs4k2+JywVhx0KCKwMEQF/HjKHb4L4t2r7mMjheNSKyeapwwBwk
         fcSHLMiwC18qiRADiWZKL8MxwC5Syn0Cm0dxeVuY/Sc1+PoMw5/lZZ7zuYVGJORnqGea
         C2OvF5sp4ugXUUsbDGdlykcKwQ+6eProJk+PYlrcBfyzcNUIUQ0UzBkr/jYRGbt8POc1
         ySeg==
X-Forwarded-Encrypted: i=1; AFNElJ/8R+rKxnf2W0Cn7nyQNyd28C0LvPWQeXn4nTg1aWit6KMiC/7v+TJ0gVIKY9Fe5DZWeEm81ngO6jo8@vger.kernel.org
X-Gm-Message-State: AOJu0YxXoz9Z5OK4DaQkYjrUWe7M4nrcgjwN0p8uYAcd9wU+j8Rx7vPE
	BUAY4k1YwG94Jw9oPCrp3HIKTSNZxz8CuQKXLnSP+bjNl4UMPHH6cmCMXzMre86M6HBoGgep+0x
	1Cic+Yw0CLicycq1CRXz5JtUmmrjvJfYSBeL5kctD
X-Gm-Gg: AeBDiesF3tbcvahwgZT9Go24i6r/SE7zBU9QZyLo+9693eOO1Akk1WIO7hVK5XT6M6i
	tlNXBRjpunctOCAtRoCxnd5K8XBwBLdr3A0OaxnMm8ytMv/jJ3G9isnguXOb31AOECQ/H9KAGvX
	G3+qd/F3rf7Vkz/Ksjn4Tssjb1MB+mcWT/RpQhONHDEE/FtjEiO6+CR3lG4l0/KhZZKY08CtgcZ
	WS7TMo//dO/ND9uYxYySU2TjQ8rePKJqWDcLdfhYAN7wwlN76VcOXr+GH5WhKTk0fXaOZT0Wt74
	Pajg1Y4=
X-Received: by 2002:a17:902:9a8e:b0:2b0:ac1e:9720 with SMTP id
 d9443c01a7336-2b2d5a459b2mr142509675ad.23.1776198489857; Tue, 14 Apr 2026
 13:28:09 -0700 (PDT)
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
 <20260413231920.GS3694781@ziepe.ca>
In-Reply-To: <20260413231920.GS3694781@ziepe.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Apr 2026 16:27:58 -0400
X-Gm-Features: AQROBzDV1U7-Lr_78p5lvbSYJBsit-JnR3MD284PiQF66a4KQgj72Qdddd-aJXA
Message-ID: <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19355-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:dkim,paul-moore.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,ziepe.ca:email]
X-Rspamd-Queue-Id: 5D58A3FE5E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 7:19=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
> On Mon, Apr 13, 2026 at 06:36:06PM -0400, Paul Moore wrote:
> > On Mon, Apr 13, 2026 at 12:42=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > > On Sun, Apr 12, 2026 at 09:38:35PM -0400, Paul Moore wrote:
> > > > > We are not limited to LSM solution, the goal is to intercept comm=
ands
> > > > > which are submitted to the FW and "security" bucket sounded right=
 to us.
> > > >
> > > > Yes, it does sound "security relevant", but without a well defined
> > > > interface/format it is going to be difficult to write a generic LSM=
 to
> > > > have any level of granularity beyond a basic "load firmware"
> > > > permission.
> > >
> > > I think to step back a bit, what this is trying to achieve is very
> > > similar to the iptables fwmark/secmark scheme.
> >
> > Points for thinking outside the box a bit, but from what I've seen
> > thus far, it differs from secmark in a few important areas.  The
> > secmark concept relies on the admin to configure the network stack to
> > apply secmark labels to network traffic as it flows through the
> > system, the LSM then applies security policy to these packets based on
> > their label.  The firmware LSM hooks, at least as I currently
> > understand them, rely on the LSM hook callback to parse the firmware
> > op/request and apply a security policy to the request.
>
> That was what was proposed because the idea was to combine the
> parse/clasification/decision steps into one eBPF program, but I think
> it can be split up too.
>
> > We've already talked about the first issue, parsing the request, and
> > my suggestion was to make the LSM hook call from within the firmware
> > (the firmware must have some way to call into the kernel/driver code,
> > no?)
>
> No, that's not workable on so many levels. It is sort of anaologous to
> asking the NIC to call the LSM to apply the secmark while sending the
> packet.

From the LSM's perspective it really doesn't matter who calls the LSM
hook as long as the caller can be trusted to handle the access control
verdict properly.

> The proper flow has the kernel evaluate the packet/command *before* it
> delivers it to HW, not after.

From what I can see that's an artificial constraint since we've
already chosen to trust the device.  After all, if we don't trust the
device, why are we talking to it?

> > so that only the firmware would need to parse the request.  If we
> > wanted to adopt a secmark-esque approach, one could develop a second
> > parsing mechanism that would be responsible for assigning a LSM label
> > to the request, and then pass the firmware request to the LSM, but I
> > do worry a bit about the added complexity associated with keeping the
> > parser sync'd with the driver/fw.
>
> In practice it would be like iptables, the parser would be entirely
> programmed by userspace and there is nothing to keep in sync.

You've mentioned a few times now that the firmware/request will vary
across not only devices, but firmware revisions too, this implies
there will need to be some effort to keep whatever parser you develop
(BPF, userspace config, etc.) in sync with the parser built into the
firmware.  Or am I misunderstanding something?

> > However, even if we solve the parsing problem, I worry we have
> > another, closely related issue, of having to categorize all of the
> > past, present, and future firmware requests into a set of LSM specific
> > actions.
>
> Why? secmark doesn't have this issue? The classifer would return the
> same kind of information as secmark, some user provided label that is
> delivered to the LSM policy side.

I think there is a misunderstanding in either how secmark works or how
the LSMs use secmark labels when enforcing their security policy.

The secmark label is set on a packet to represent the network
properties of a packet.  While the rules governing how a packet's
secmark is set and the semantic meaning of that secmark label is going
to be LSM and solution specific, secmark labels represent the
properties of a packet and not the operation, e.g.
send/receive/forward/etc., being requested at a given access control
point.  The access control point itself represents the requested
operation.  This is possible because the number of networking
operations on a given packet is well defined and fairly limited; at a
high level the packet is either being sent from the node, received by
the node, or is passing through the node.

As I understand the firmware controls being proposed here, encoded
within the firmware request blob is the operation being requested.
While we've discussed possible solutions on how to parse the request
blob to determine the operation, we haven't really discussed how to
represent the requested operation to the LSMs.  I'm assuming there
isn't a well defined set of operations, and like the request format
itself, the set of valid operations will vary from device and firmware
revision.  I hope you can understand both how this differs from
secmark and that it is a challenge that really hasn't been addressed
in the proposals we've discussed.

At a very high level the access control decision for firmware/device
requests depends on whether the LSM wants to allow process A to do B
to device C.  The identity/credentials associated with process A are
easy to understand, we have plenty of examples both inside and outside
of the LSM on how to do that.  The device identity/attributes
associated with device C can be a bit trickier, but once again we have
plenty of examples to draw from, and we can even fall back to a
generic "kernel" id/attribute if the LSM chooses not to distinguish
entities below the userspace/kernel boundary.  I think the hardest
issue with the firmware request hooks is going to be determining what
operation is being requested, the "B", portion of access request
tuple.  If we can create a well defined set of operations and leave it
to the parser to characterize the operation we've potentially got a
solution, but if the operation is truly going to be arbitrary then we
have a real problem.  How do you craft a meaningful access control
policy when you don't understand what is being requested?

--=20
paul-moore.com

