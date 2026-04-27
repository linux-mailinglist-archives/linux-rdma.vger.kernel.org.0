Return-Path: <linux-rdma+bounces-19602-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMxhO8G172mFEAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19602-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 21:15:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B14F47926C
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 21:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 866AF30A1E52
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 19:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2073EF0DC;
	Mon, 27 Apr 2026 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAwze+ZM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859093E3D96;
	Mon, 27 Apr 2026 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316986; cv=none; b=Y5d26dzit+L7dc2YMUOy3QhkNvr8EjUXXrYd6itmCm7HW88alyoyqm7yxeZm+OX0F8IHL7S4RtJGRzteNKwJlxjZBi4KvzEzU2DwSCY8zVn7tZCg/r5jT9enluHu+ZUh5O+DA+Z5vnpnFcWOCWUVWYUWrSmMhDSpa8ov/ZnRsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316986; c=relaxed/simple;
	bh=GuYS9/hGtuZHiXcvekyT34pWb9SYDnOOkCWMLXLGHTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLGVp8KTcGW54MvP4ZflXyuFJ6XpiCqiQZNctIZixvvVJGR7Mx0oH1jf3ejR09w4oAliLepljMNUqYvuKIv4htgczRjH2oe1JQ4BtABGi/t7sorYj8MlOW9NjlV+rZU35jgVK/Ek2gfR247tZcY3fRCL2WbtryvODruQCVXKMYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAwze+ZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D57C19425;
	Mon, 27 Apr 2026 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777316986;
	bh=GuYS9/hGtuZHiXcvekyT34pWb9SYDnOOkCWMLXLGHTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAwze+ZMMcoOyFQlsJS/GytKxSTe7le7s0F/ZA2SrC1cKMiNf+qxqRa5HzKQmW6UN
	 ufEjPc4lK+WmwF6l6Zey5obs9qNgRb/YQl1xofDcyVWGdkNVwO/BiUh1LZg/HNw8mb
	 vY3F4DWaUqWxHe7o17v/Iihk479UFuHBHAr1n4sozEWcO27Y5H6vS5/QasNyLp6vUw
	 SUJrUeqALqdZml0Cd9wt70zEVneckpA+raAYCs22W7oLmBCTninvubV3mwqNDqMqGI
	 V/K+9JZjUpOSWJwjgC0gmbDVP6RZWGA5N0Ew938dfPABVn2x0EHgDeW3V614oQyl1r
	 w3z5II298HHxw==
Date: Mon, 27 Apr 2026 22:09:41 +0300
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
Message-ID: <20260427190941.GN440345@unreal>
References: <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
 <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca>
 <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
 <20260423140950.GE172828@unreal>
 <20260424141921.GA3611611@ziepe.ca>
 <20260426103957.GH172828@unreal>
 <20260426134224.GC3501894@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426134224.GC3501894@ziepe.ca>
X-Rspamd-Queue-Id: 5B14F47926C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19602-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[paul-moore.com,huaweicloud.com,kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, Apr 26, 2026 at 10:42:24AM -0300, Jason Gunthorpe wrote:
> On Sun, Apr 26, 2026 at 01:39:57PM +0300, Leon Romanovsky wrote:
> > On Fri, Apr 24, 2026 at 11:19:21AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Apr 23, 2026 at 05:09:50PM +0300, Leon Romanovsky wrote:
> > > 
> > > > > > Leon mentioned that different firmware revisions would have different
> > > > > > parameters for a given opcode, and that one would need to inspect
> > > > > > those parameters to properly filter the command.  Is that not true, or
> > > > > > am I misreading or misunderstanding Leon's comments?
> > > > > 
> > > > > They are ABI stable, so there will be rules about future changes that
> > > > > old software can follow to ignore or reject future things it doesn't
> > > > > understand.
> > > > 
> > > > It is wishful thinking and applicable only to mlx5 devices. No one
> > > > promises that other devices follow same ABI rules.
> > > 
> > > Well, I will definately kick them out of fwctl if they don't.
> > 
> > It is easy to say but harder to follow. The kernel includes many devices that
> > exist only in specific hyperscale environments, where the update cycle is
> > tightly controlled. They easily can break FW backward compatibility.
> 
> Well Linus's rule applies here, if it doesn't bother anyone it didn't
> break..

Great, that means they can load any BPF program they want and access whatever
firmware fields they choose. Your earlier claim about 'not breaking FW
compatibility' is only partially correct.

Thanks

> 
> Jason
> 

