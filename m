Return-Path: <linux-rdma+bounces-19503-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /lA7DZIa6mlSuQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19503-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 15:11:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 085FA4528A2
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 15:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90EF93044D34
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3BB3EF0CC;
	Thu, 23 Apr 2026 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rc+djx9n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC823ED109;
	Thu, 23 Apr 2026 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949505; cv=none; b=R0+EhzZ8PuL++4lLnjp7QV14D52N3pWlVvQC1UDrj/1YKJlZJe3wMIjp7kldGJeXwPZb0MPZIID9z7AP/ZyK8P2B+a489vqp09mp6OxIKL2fV0q5semChhJ9g1MS0OjZJqvtBc/nzSMVkxnL0ycHDQuLDFNz6tvdhxJNdK7CNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949505; c=relaxed/simple;
	bh=E55xHuO9OgehKjmUEfHBkZfuIuBHCCdniSK9hhyNCMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7lacnkLrjcYdsEWNac99LT0eB+GKdsvjHybuwgkFWbGcn6ojGnsi00KS7SdQG/FJGMUBRW4bA2f5+1uu/405bdIdh2losE6w7eyIuKA02+3l9GcoODzAkB38m+EnOrojwLyGDKvCwTqtRX5bqdg4QCYS1L5IvHYxQPK2oaqFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rc+djx9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FD4C2BCAF;
	Thu, 23 Apr 2026 13:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949505;
	bh=E55xHuO9OgehKjmUEfHBkZfuIuBHCCdniSK9hhyNCMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rc+djx9nbr5IRX86t+nJLDfBrlzvpg2kSMyJohpOCpqsr+QuHTCovBHxYGxwMMcM3
	 FJ8qx4iQWd0LbVCLLbebwcz4dc/F/4FqskIie9hzUK5+3T0BXg8Qla6ab6n9ME35ag
	 YJ8ODjrfFaIV27nuIB7YKmaM/M0Di342exgLj5/Y/lYQJ7zGGfkjp2KAq+IjaUESs5
	 XvrkpyoHH7P+hjn86j7yFqg2RDdbmr89tjCNxA0V/OKH+e1eLUUTFJ35Xed/ybUo9v
	 g1EXz8grM5ze6BlkikNtUYuUFVrdafawot4GgOLOiYaWxAXuhv2RzKUSP7emVZxTQK
	 o2M3Ni3pNU6zQ==
Date: Thu, 23 Apr 2026 16:05:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20260423130501.GD172828@unreal>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19503-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ziepe.ca,huaweicloud.com,kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ziepe.ca:email]
X-Rspamd-Queue-Id: 085FA4528A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 05:40:04PM -0400, Paul Moore wrote:
> On Wed, Apr 15, 2026 at 9:47 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Tue, Apr 14, 2026 at 04:27:58PM -0400, Paul Moore wrote:
> > > On Mon, Apr 13, 2026 at 7:19 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > On Mon, Apr 13, 2026 at 06:36:06PM -0400, Paul Moore wrote:
> > > > > On Mon, Apr 13, 2026 at 12:42 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > > > On Sun, Apr 12, 2026 at 09:38:35PM -0400, Paul Moore wrote:
> 
> ...

<...>

> > > > > so that only the firmware would need to parse the request.  If we
> > > > > wanted to adopt a secmark-esque approach, one could develop a second
> > > > > parsing mechanism that would be responsible for assigning a LSM label
> > > > > to the request, and then pass the firmware request to the LSM, but I
> > > > > do worry a bit about the added complexity associated with keeping the
> > > > > parser sync'd with the driver/fw.
> > > >
> > > > In practice it would be like iptables, the parser would be entirely
> > > > programmed by userspace and there is nothing to keep in sync.
> > >
> > > You've mentioned a few times now that the firmware/request will vary
> > > across not only devices, but firmware revisions too,
> >
> > I never said firmware revisions, part of the requirement is strong ABI
> > compatability in these packets.
> 
> That was my mistake; it was Leon.
> 
> Leon mentioned that different firmware revisions would have different
> parameters for a given opcode, and that one would need to inspect
> those parameters to properly filter the command.  Is that not true, or
> am I misreading or misunderstanding Leon's comments?
> 
> https://lore.kernel.org/all/20260310175759.GD12611@unreal

Right, I said that. The mlx5–FW interface is stable, but that does not
mean it can never change. The contract is that any upstream driver
release must continue to operate correctly with released firmware.

To support this, there are cases where the driver and firmware
negotiate during device initialization to determine whether a given
feature is supported and specific maibox fields are valid.

Thanks

