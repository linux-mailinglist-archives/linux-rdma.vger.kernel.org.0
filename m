Return-Path: <linux-rdma+bounces-19295-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMyqLG8T3WkOZQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19295-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 18:01:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F383EE41B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 18:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DA2930BED12
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1700B3DFC7D;
	Mon, 13 Apr 2026 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia0sDvZ4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E1E125A9;
	Mon, 13 Apr 2026 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095616; cv=none; b=dix1E8+no/Yv00CqE+12xxhLy1Tc1LMm5q1dPd7v84eHhircEjMyUxdwhW+EzRiSFPx1hrGjNqQiKAkim3+TbF2Iw6aQDKMt5m7i5jsXJQ/bOcP5HGYe6i0J3Xqf7Eo3/FjbkE+3sZUF3Fr3Pv8sVNbKKeoxpYqRspcssPR6ZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095616; c=relaxed/simple;
	bh=9M6tnLgIr+sMqBYY17RTZRwcr2YkcNi64g6q6UG2hdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4QeJ3Fse7ZUlZRvHFYiAwiWiR1QZ4Ao3tyZC+Hd81uZ54QiiLIFxjpn4XgFR3UfkgBq4E+tbBA4IAC6+eRIoi5AxlwJ7mFfmthYaFDSne6AqLUvFpPxy4c3zhYNbCgR8d7EDbyjJf1UDFBfoYaG9Skx/IqugIE4rGlM2885FAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia0sDvZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00D0C2BCAF;
	Mon, 13 Apr 2026 15:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776095616;
	bh=9M6tnLgIr+sMqBYY17RTZRwcr2YkcNi64g6q6UG2hdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ia0sDvZ4lmIa/fXnarKKku6xXJW3V+56XzaeZOpO6F3X8Ow8pD6wXa3N/3VWNOAaj
	 ybUrRO4+LWB/5UiKpAQ4KCdCijHpeH92xtAcIsSXadz4Mjdwsy6+q6BRwZwIRZuukC
	 rOlAtExAFewHXIQ9FAu0e5DUTneN75JJM7i5S3d00aZi3kXvvwQSnxf9KvBEmlcmTd
	 JIWQwF74SQOLwTJArhFb2WflOc5KaoUtx84BBU2DXw4Z8AmFmuiOPXOMlpp13767Th
	 4qOLCEHoEV9tnM0NFO2zR/uV3LdtOOzTFqT322eQxO1KOeIgxzYadv6TGqsVCZvUwF
	 OMb79RWzbXHAQ==
Date: Mon, 13 Apr 2026 18:53:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
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
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
Message-ID: <20260413155332.GL21470@unreal>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19295-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huaweicloud.com,kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,ziepe.ca,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:url]
X-Rspamd-Queue-Id: 11F383EE41B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 09:38:35PM -0400, Paul Moore wrote:
> On Sun, Apr 12, 2026 at 5:00 AM Leon Romanovsky <leon@kernel.org> wrote:
> > On Thu, Apr 09, 2026 at 05:04:24PM -0400, Paul Moore wrote:
> > > On Thu, Apr 9, 2026 at 8:45 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > On Thu, Apr 09, 2026 at 02:27:43PM +0200, Roberto Sassu wrote:
> > > > > On Thu, 2026-04-09 at 15:12 +0300, Leon Romanovsky wrote:
> > > > > > On Tue, Mar 31, 2026 at 08:56:32AM +0300, Leon Romanovsky wrote:
> 
> ...
> 
> > > > We implemented this approach in v1:
> > > > https://patch.msgid.link/20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com
> > > > and were advised to pursue a different direction.
> > >
> > > I'm assuming you are referring to my comments? If so, that isn't exactly what I said,
> > > I mentioned at least one other option besides
> > > going directly to BPF.  Ultimately, it is your choice to decide how
> > > you want to proceed, but to claim I advised you to avoid a LSM based
> > > solution isn't strictly correct.
> >
> > Yes, this matches how we understood your comments:
> > https://lore.kernel.org/all/20260311081955.GS12611@unreal/
> >
> > In the end, the goal is to build something practical and avoid adding
> > unnecessary complexity that brings no real benefit to users.
> >
> > > Regardless, looking at your v2 patchset, it looks like you've taken an
> > > unusual approach of using some of the LSM mechanisms, e.g. LSM_HOOK(),
> > > but not actually exposing a LSM hook with proper callbacks.
> > > Unfortunately, that's not something we want to support.  If you want
> > > to pursue an LSM based solution, complete with a security_XXX() hook,
> > > use of LSM_HOOK() macros, etc. then that's fine, I'm happy to work
> > > with you on that.
> >
> > The issue is that the sentence below was the reason we did not merge v1 with v2:
> > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-hooks
> > "pass through implementations, such as the BPF LSM, are not eligible for
> > LSM hook reference implementations."
> 
> I can expand on that in a minute, but I'd like to return to your use
> of the LSM_HOOK() macro and locating the hook within the BPF LSM as
> that is the most concerning issue from my perspective.  One should
> only use the LSM_HOOK() macro and locate code within bpf_lsm.c if that
> code is part of the BPF LSM, utilizing an LSM hook.  Since this
> patchset doesn't use an LSM hook or any part of the LSM framework, the
> implementation choices seem odd and are not something we want to
> support.  As mentioned in my prior reply, you could do something very
> similar though the use of a normal BPF hook similar to what was done
> with the update_socket_protocol() BPF hook.
> 
> There are multiple reasons why out-of-tree and pass through LSMs are
> not considered eligible for reference implementations of LSM hooks.  I
> think is most relevant to this patchset is that an out-of-tree hook
> implementation doesn't necessarily require a stable interface, and
> without a stable interface it is impossible to make a generic API at
> the LSM framework layer.  As you mentioned previously, each vendor and
> each firmware version brings the possibility of a new
> format/interface, and while that may not be a problem for out-of-tree
> code which is left to the user/admin to manage, it makes upstream
> development difficult.  I did mention at least one approach that might
> be a possibility to enable upstream, in-tree support of this, but you
> seem to prefer a BPF approach that doesn't require a well defined
> format.
> 
> > > However, if you've decided that your preferred
> > > option is to create a BPF hook you should avoid using things like
> > > LSM_HOOK() and locating your hook/code in bpf_lsm.c.
> >
> > We are not limited to LSM solution, the goal is to intercept commands
> > which are submitted to the FW and "security" bucket sounded right to us.
> 
> Yes, it does sound "security relevant", but without a well defined
> interface/format it is going to be difficult to write a generic LSM to
> have any level of granularity beyond a basic "load firmware"
> permission.
> 
> > > The good news is that there are plenty of other examples of BPF
> > > plugable code that you could use as an example, one such thing is the
> > > update_socket_protocol() BPF hook that was originally proposed as a
> > > LSM hook, but moved to a dedicated BPF hook as we generally want to
> > > avoid changing non-LSM kernel objects within the scope of the LSMs.
> > > While your proposed case is slightly different, I think the basic idea
> > > and mechanism should still be useful.
> > >
> > > https://lore.kernel.org/all/cover.1692147782.git.geliang.tang@suse.com
> >
> > Thanks
> 
> Good luck on whatever you choose, and while I'm guessing it is
> unlikely, if you do decide to pursue a LSM based solution please let
> us know and we can work with you to try and find ways to make it work.

Thanks a lot. We should know which direction we'll take in a week or two,
once Chiara wraps up her internal commitments and returns to this series.

I appreciate your help.

Thanks

> 
> -- 
> paul-moore.com
> 

