Return-Path: <linux-rdma+bounces-19528-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDaHCON/62lLNgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19528-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 16:36:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22197460482
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 16:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D33483003822
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 14:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8BC3DD52B;
	Fri, 24 Apr 2026 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GkVxPYqJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CCF3DC4C1
	for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041368; cv=none; b=VRVhkOHlRnoeyPXoJM/1nNTjysK/nOxqQwdNuChIA3YbzJbxHy61wKy+oiK/XvjU//yt+sZ1vQ0nUt89gHZChtMrbCC3uBll8vMz5vm8J4CublgiGwqI9Gg0WmYEG6zNVMJg4qONusngs/ODHok+HlmoMDIFZLZJY1bdhXvVl7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041368; c=relaxed/simple;
	bh=Re59DPAnmFnNzJbvxM1fdICxhhUUbMUQeMYokWbznfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7BYythAf3/S6hgqGM2aktdUeTsatjvjEZ0Knv4S+gitcQFqpOkBLYk9UVtDBIbrtGjp5Iz5pBe9+mS9cKBSBZdsqYfAirEDejoPg5b8Ofqt7c+k84NO7tZLfXUBcSkc9u6pWX0rwBXPVsqjv2hb6pkeH4/nyyZnbVplEyNzAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GkVxPYqJ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8acae26e564so90518676d6.2
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777041366; x=1777646166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqpHsu9O8KQfZPJUE6YxK9zkVCDI7j2Hht6awCscAf8=;
        b=GkVxPYqJJZrDQrQTwHmS1QvV6RRqUgu7h198QFhcR6eyvXs2rcY3NR0Eng9PvZvEE/
         DUlJnvJIQhReHJiPzLpSy0ak5OCqNfom/AFOHG6QWcATt0TXAruWbwzqCR9gDQt8FmTr
         GLruX4eYXsTEvIADxRqd3s109vADjWwKkfhTs0Q57O2l48ZHgGP9jnc2UyT1bm+/n3qT
         vZo4WGwWee2ZEMvN4GOhnOFmtW/R6rQIR55Hqo4ZKXvq/pRxzNSTOFSk6VkorNxyH/8n
         wzPHpYTHs2ME6PuAYA0uCYiotrDb2w2tbCwtvICrBqYcuPeNNSp/EIR8J/1xtL+Gg9t0
         gFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777041366; x=1777646166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqpHsu9O8KQfZPJUE6YxK9zkVCDI7j2Hht6awCscAf8=;
        b=Rks0gSw1/hwiD6M2lgsc7PayWZG4VJEUlLiov2YlEvqzCVH0+WnPkopFIXmDV2lkhv
         +fT1FmE94kX1ZvTTxQYAuhmcicEV27L3iSQQ6CtUz3PlMqL63Qm3g3UJp8FtpEbCkfZb
         adAuTnoRAZeQ6ze9AoTqjZASwB1wmtnCGeMxl1fsGjYc8lpCZq+tBR4Hr7BTH+3++qQh
         x7NfJvPVl5kF4rxIWjfDQXZGBmcLViZloCGmvibZzEYI5pq4aJBblw6ChAs3FFW/tAM8
         q8oS6oC9i1tSk2ti3no8+I0HRt2hRT9jyjKeldomglOYX2Q7G0THfCaqQtMfiXH539S+
         /i9A==
X-Forwarded-Encrypted: i=1; AFNElJ/iU00tA1QiL8/HyF3GhfesNTJQuIHhvfWVw+BRj/jT9moCYZ8WVigDIaxRd/+EU/Mu87WY+arzi+6q@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7mFjKDJMiv67pnK2BUtJjWAIeu6D5K3ryMPijbBSx3bjdSZuH
	QcqV4rRzzTraYWISXp0JQApnlZJ+BgwV3wuEr4ESjzabpVXTAHxLGiGz1ty9QWcA3eI=
X-Gm-Gg: AeBDievH+4brhmheaqXoyrGjQNeMQN5UYejLNpiRTaxk83DQibjNWUyBc6tjKEDYHdy
	velJHDo6uzQbe30Skr7xhKWvkgkHbnytjYi04ll97sWgxTqZpqhCbiqtG+F/Zo8tsKubfEaNq0G
	I0d7Ou9LPBI9WU8y1yAsFfnMv56PeNrJqQfIGaSI5l8K2DSlPBBL8E8/JuR3oEjGdN2Z01Ua3PD
	YWDdcVzPGMQxAtsRX/Vvf3v8ldfDTYEfIIDNARyD0WbSuV20VH8UJgoy+Jil1C3Xt8NpKwDJGfp
	Zj5KP2MnOdDclqeaD2OZTNtt7uEFeJvMYHqUoqoLXXj7OjR9ldPEQZt1c7Ey+zGZql6rfMOUsad
	tlD5kXsYcSwTjZ/lgu/+mpHOtH0oX9iwH1xAp1p3JZHOQDEQUzDdXMTbq4Xe3e2vvBI7usVcAmk
	v7ejNnfuksJJwOPuD32bbOre2wCP6n2r2tVgudXTMmw4dm/He0yBxfKdN7g/JBb3PQcabQnyajP
	ge7D3nTfybX0sCoOAkwhwgOqjY=
X-Received: by 2002:a05:6214:5d82:b0:89f:9bc2:20d1 with SMTP id 6a1803df08f44-8b0280c8cf0mr475388426d6.7.1777041365807;
        Fri, 24 Apr 2026 07:36:05 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b031f65a27sm180664046d6.16.2026.04.24.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:36:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGHdT-00000002nbb-2MlG;
	Fri, 24 Apr 2026 11:36:03 -0300
Date: Fri, 24 Apr 2026 11:36:03 -0300
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
Message-ID: <20260424143603.GB3611611@ziepe.ca>
References: <20260412090006.GA21470@unreal>
 <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca>
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
 <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca>
 <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
 <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
X-Rspamd-Queue-Id: 22197460482
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19528-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Mon, Apr 20, 2026 at 08:58:09PM -0400, Paul Moore wrote:
> > > > > The access control point itself represents the requested
> > > > > operation.  This is possible because the number of networking
> > > > > operations on a given packet is well defined and fairly limited; at a
> > > > > high level the packet is either being sent from the node, received by
> > > > > the node, or is passing through the node.
> > > >
> > > > I think we have the same split, fwctl send/recive analog is also very
> > > > limited.
> > >
> > > Sure, but I thought the goal was to enforce access controls on the
> > > firmware requests based on the opcodes/parameters contained within the
> > > firmware request blob/mailbox?
> >
> > Yes, that's the goal. It is the same as iptables being able to
> > identify that a send system call has a packet that is http or dns.
> 
> I think we still have a disconnect here.  A packet being a DNS or HTTP
> packet is different from an opcode.  The opcode in the iptables isn't
> "DNS" or "HTTP" it is "INPUT", "OUTPUT", or "FORWARD".

I understand that

> Most LSMs will want to know who is initiating the firmware request
> (the subject), the requested operation/opcode (the action/verb), and
> the target of the request (the object, which in this case is likely
> the kernel or the device).

How is
  system_u:object_r:httpd_packet_t:s0

A kernel or device? It is a label for packet contents. I also want a
label for packet contents.

> As I understand things, the action/verb is going to be the opcode
> within the firmware request.  If you believe I'm wrong about this
> please help me understand why.

You could make that choice, I'm arguing we should not, and it should
be in the object side.

> > - op_X_t is the result of the classifier inspecting the RPC
> >   packet. Admin tells the classifier to return op_X_t similar to
> >   how --selctx does for iptables.
> 
> I've tried to explain how this doesn't match with secmark, but I'm
> evidently doing a poor job.  

Yeah, I don't get it at all, sorry. I fell you are making some very
nuanced distinction with HTTP being an object but the HTTP-equivilant
in fwctl is not an object, I can't follow it at all.

By that logic:

   iptables -p 80 --string "GET"

Is an action, and it should get a unique action in the tuple.

> If you want to continue with the secmark comparisons it might be
> helpful to spend some time configuring secmark on a SELinux system,
> and writing policy for it, to see how it works.

I think I have a pretty good idea, you haven't said anything that
contradicts what I expect..

> certain action on an object.  My concern with your example is that the
> object isn't what is actually being acted upon, it's the requested
> action.

Object is a label for the packet contents.

> The fwctl ioctl/API allows a user to act on a device, with the
> actual action being specified by the fwctl payload.  From what I can
> see, the classifier's output is the action, not the object.

You can take that view, it is certainly one valid way to look at it.

But it is completely impractical.

I am arguing for the secmark like view where the content of the packet
decides the object label.

> > The same way secmark cannot pre-identify all the XXX_packet_t's.
> 
> Once again, I think there is a disconnect or misunderstanding, on a
> SELinux system using secmark all of the packet types, e.g.
> "XXX_packet_t's", *are* pre-defined in the SELinux policy.

"Pre-defined" in a text files in user space controlled by the admin.

Admin can "pre-define" their fwctl ones too, what is the issue?

AFAICT the only debate here is you want to make fwctl's packet content
an action while allowing iptable's packet content to be an object.

Jason

