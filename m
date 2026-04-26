Return-Path: <linux-rdma+bounces-19556-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI+fIYrr7WlwowAAu9opvQ
	(envelope-from <linux-rdma+bounces-19556-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 12:40:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7054E46968D
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 12:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAF6E3003986
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570DA35837C;
	Sun, 26 Apr 2026 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2nDwSOX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC81A073F;
	Sun, 26 Apr 2026 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777200005; cv=none; b=thNwi4hfi49/yuVC0ttU/KfZAfoDxChlp/ajDfLqiSuqZS8JJbTOOr+qjJcTlDi/mVP8sfwgth5R7oJLc2f5E/S7j0ky44MiCwyqFxAF5J1xsxHD6hBWW79x5WLg8N88+BzfkvIttNs9zYmfI7MchaMV/BBFVGw4+RcmVpKMYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777200005; c=relaxed/simple;
	bh=NobXfV/IHDZN4TMelBCg0nlIZMOXOjqrGKs387mb+bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAsNZeKGOjRFSUtw43er4Lcx93GdOiJ8qu9o3dLsXWN1l4BI3mJsAEfjRfmVCI3ne28oUf3JWjFG4vcnzf1BzU8zDhSXPYsTqqjE2+mEZDmzRgCpqi42YZlZdGy9fcyaJ8PMeof+P6niOg/YGoARKbIULwKcB1fe3nH7LTlA65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2nDwSOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C580C2BCAF;
	Sun, 26 Apr 2026 10:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777200004;
	bh=NobXfV/IHDZN4TMelBCg0nlIZMOXOjqrGKs387mb+bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2nDwSOXzyL/bNaYNnDRQKVbObHeaqUovKVtVLy7J5BDV5+FgUnA9cwsKVKeHNg3l
	 mj4KUk8JS7MxJ6IR/m9dGs/Sssf5aLMnNp8qPipZKuge389Rj8jQVM13Pr8Zy2r+lX
	 Hh3FChr2td5Ul8LNLiYSKvuFWWGeax4VSSlqz92BYXfKVHAo9PTEUKNLre5uuEQbrZ
	 9Zk+y61MDzWYfrUnoxhV7f3i1+i3KhDye3BdW9jSHj6Xzbunl/BsI3Tx3OvpnF0EqM
	 cS/73O39ObONnU7su4w1ookjO+ZYUANNZIIO6V9BE9NV8GXNaNYqSemwb0FUWcLPfR
	 zVzLaKSJPcvdA==
Date: Sun, 26 Apr 2026 13:39:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Paul Moore <paul@paul-moore.com>,
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
Message-ID: <20260426103957.GH172828@unreal>
References: <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca>
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
 <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca>
 <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
 <20260423140950.GE172828@unreal>
 <20260424141921.GA3611611@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424141921.GA3611611@ziepe.ca>
X-Rspamd-Queue-Id: 7054E46968D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19556-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[paul-moore.com,huaweicloud.com,kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 11:19:21AM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 23, 2026 at 05:09:50PM +0300, Leon Romanovsky wrote:
> 
> > > > Leon mentioned that different firmware revisions would have different
> > > > parameters for a given opcode, and that one would need to inspect
> > > > those parameters to properly filter the command.  Is that not true, or
> > > > am I misreading or misunderstanding Leon's comments?
> > > 
> > > They are ABI stable, so there will be rules about future changes that
> > > old software can follow to ignore or reject future things it doesn't
> > > understand.
> > 
> > It is wishful thinking and applicable only to mlx5 devices. No one
> > promises that other devices follow same ABI rules.
> 
> Well, I will definately kick them out of fwctl if they don't.

It is easy to say but harder to follow. The kernel includes many devices that
exist only in specific hyperscale environments, where the update cycle is
tightly controlled. They easily can break FW backward compatibility.

Thanks

> 
> Jason

