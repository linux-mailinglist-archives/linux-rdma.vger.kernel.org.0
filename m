Return-Path: <linux-rdma+bounces-19300-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ4TNHsk3WkzaQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19300-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 19:14:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B93F3F10BE
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 19:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F42130659F2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF14630FC1E;
	Mon, 13 Apr 2026 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E2wavPRL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508141A680C
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098543; cv=none; b=RQZRXdqwvu6C2aA0HvwQhqHYMrphuqLSoo26VklOeF5Ee2S2rKa48u7QnFENeTJNuZYX/ArB3jP17a3kwpJ0NC6qXw6E8eQbW9uqgXHKdVF51FBWcKL9YdMn7Yj7CiIDbWT0B6AqV+Wbsjbnsj2RhLCS40EcujK3YS9TYvqtVIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098543; c=relaxed/simple;
	bh=G+WYrb1BBVDoPFmFwGScCNyDrJlyYOjXSYKOQwe+8ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK2ADZrahT2Jf5IuyU/MN55wMKd1FXnM5Dn5gpXcSiJvsysqYEtw4jujOs+dQsNyzU/mWzJbch0QwlmZMcT5y/Jur2hleV5T2G2pJ7u+IxdIMXsTn2h/RKTL34KfZyLpNFncvYO7DNofOjYZ+McUrqTjK7nA8dbUxNQfbJoM5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E2wavPRL; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d8e11b948so46029011cf.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776098541; x=1776703341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jUiNyilK1I2myoXjgAEGP+spYezLcxgAYqqWit3D6Xk=;
        b=E2wavPRL5AmyZgB0g/U0hP95w+LHR0CODATHBR29H0d0H1ZgOljvH8X8HvEY3mXt5a
         YlnadNIjO+fQDkEchqiV9cHty+PdpSlVJ0f4C9c9V84ivaVyIHJVhYYiHOq6kNaLYdCy
         RS6GxQgi6h43fT46Qsn7sAG84AXG/H7JJnfCpu1q5aml+RfpX8WXFWxo1JtI9p6txnZa
         PdoMOOEpmP/FwRH5QMlO4oHklEDiJJ+80RerI/KkkD87VkTNCjDn28FG8unDsu3pExSz
         eHYOVnR1ITXBzK/9kIafEqDD5d9qV0i6BSWJek3gMW5q99EoszY3lceECT/YF1kRVaZz
         9cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776098541; x=1776703341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUiNyilK1I2myoXjgAEGP+spYezLcxgAYqqWit3D6Xk=;
        b=aOzIraQuihxNEe4qTtr7ILIHgrObewnMPAnVOaKPw1YSGwHqzZXBm5QzIjwgZhxYXo
         Gka+kMp/aMGnIGp46OljCkuRfe2R8ylgEuazhfQvdrAri8Wk1YbXxTtcVPO86/xWq0CD
         nZgL2VLK+rXj8/tNn2SCurw4NfTlVrX46lM/GVrgQnxYLKV8HSTHxc0TCSu+fHI3sKia
         Cw3APvy5jCoiJPoky2KfDgnWnQeP81m1uXsJmipmSosFWVPpqf0mXsyXVCaIEOpAJEEO
         MPoRqMfRHmULZ76rpk9THnnJi4D1H4XeV0Bn/YpTt2Ntmfm9iPMY+DzqoBLkivXb9uVt
         KY3g==
X-Forwarded-Encrypted: i=1; AFNElJ+a4k7zOtqfLcsVS6nrb0lKAalfTM6x+kyeJF3wJ50c2Jd9XSYKa5klj922PfVC8tHYSzDrYFwk9F/s@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JgzvoZkgcjxYJSxAp234YwXUkWxHIfLJipaB+NnAoMruhkk1
	JB2TQC4roFDUBxRIkqKnvuR7+zijAF5LCNL0O2b3GLhb8y07SKBcnjKHiKI1Arqb2DU=
X-Gm-Gg: AeBDiev23AEzhQRRm8Py0bZTtxU9xSIyHjt7CyIdLMX5sVVrKMl703W9/kxejsLp7N3
	XDL4j2XEYWTe7q7MM7csM97+vuLwBOAP4Z4iF8AqJoH63Lym5jknJjlGKhIRF8wj6QcO8J0vc2s
	lKa70uCdg8dDeir9Eazj5QqtvAj786AG/qm7TkUhtc5bh2QgudchnpNWWXvMIp4NJ46vHeUpIrT
	l48WgMUIupbtamd4MujyGR7NtHZSN/Gqeo8vTYjWDM7zygsnfDtWwXW1ThcHvSqCLnV7bh49UdW
	B9Ax6ykMKiBEyFyF8Yw4Gx/58uM69ZTwDCLAA941tw3kW5LvYqPqhsOuJkRkP1dI1YozSzQUJug
	VKodfgWGllRARCMXVeQmVpb2hCZ51N8mS4xKBcIHeUUlvYA3JMFYrdv7Jf3SccyiEGp8msNgvm4
	dWDu14ecg4+zWHwsqkhSGMJ8Pdn6GdsyXiTvM6T5HPzz943hNoDJuJzSRLismCjQdXWaKxmDuiw
	HNVlA==
X-Received: by 2002:ac8:5ac8:0:b0:509:120d:4311 with SMTP id d75a77b69052e-50dd5c02761mr211953761cf.60.1776098541243;
        Mon, 13 Apr 2026 09:42:21 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50de6bc04e0sm60997991cf.19.2026.04.13.09.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:42:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCKMe-00000005Zr4-10vb;
	Mon, 13 Apr 2026 13:42:20 -0300
Date: Mon, 13 Apr 2026 13:42:20 -0300
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
Message-ID: <20260413164220.GP3694781@ziepe.ca>
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal>
 <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal>
 <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal>
 <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19300-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B93F3F10BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 09:38:35PM -0400, Paul Moore wrote:
> > We are not limited to LSM solution, the goal is to intercept commands
> > which are submitted to the FW and "security" bucket sounded right to us.
> 
> Yes, it does sound "security relevant", but without a well defined
> interface/format it is going to be difficult to write a generic LSM to
> have any level of granularity beyond a basic "load firmware"
> permission.

I think to step back a bit, what this is trying to achieve is very
similar to the iptables fwmark/secmark scheme.

secmark allows the user to specify programmable rules via iptables
which results in each packet being tagged with a SELinux context and
then the userspace policy can consume that and make security decision
based on that.

Google is showing me examples of this to permit only certain processes
to use certain network addresses.

So this is exactly the same high level idea. The transport of the
packet is different (firwmare cmd vs network) but otherwise it is all
the same basic problem. We need a user programmable classifier like
iptables. Once classified we want this to work with more than SELinux
only, we have a particular interest in the eBPF LSM. In any case the
userspace should be able to specify the security policy that applies
to the kernel classified data.

Following the fwmark example, if there was some programmable in-kernel
function to convert the cmd into a SELinux label would we be able to
enable SELinux following the SECMARK design?

Would there be an objection if that in-kernel function was using a
system-wide eBPF uploaded with some fwctl uAPI?

Finally, would there be an objection to enabling the same function in
eBPF by feeding it the entire command and have it classify and make a
security decision in a single eBPF program? Is there some other way to
enable eBPF? I see eBPF doesn't interwork with SECMARK today so there
isn't a ready example?

Jason

