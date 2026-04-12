Return-Path: <linux-rdma+bounces-19249-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id U421LCJf22lXBAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19249-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 11:00:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E4F3E3332
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 11:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FE6C3004614
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 09:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC1313E21;
	Sun, 12 Apr 2026 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp8RS9Py"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B930BBAE;
	Sun, 12 Apr 2026 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775984412; cv=none; b=Bwww+7JDoWNpHAFC2//YA9B6Y7ANoSaM64hyFedrV1C3Cvxwz6vD7zEi3rCoixkuJSfJaxvPOX+7sL8fDCRHWhIb1n+mYP459uwiJj2IdZXLO4mNaeZml5jyzE9EwU/6d8nckv6MFw6rRpE1Q6vmPZxlBOvqEIzBipOYxXz7R3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775984412; c=relaxed/simple;
	bh=XLSXOqKfHWfTPS6C6Vq2UT2HUb3l8dn3SksR7uKAF1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICGLxQm+6CxD1uTOrCow4rBaGpOMxagPDEN3Gh/R8F6Vhi4+4MJAlOfTc9FeOQ+2+Qb2nAmUoH4nEYntIee/n+7kB9o5IYoatygZ6s0504nxsuVyVml7Wyr9gkmO+kc33kj1baTarB8f5xG65cpIcpsxfliNTPlwbxAs64OVTDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp8RS9Py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8EAC19424;
	Sun, 12 Apr 2026 09:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775984412;
	bh=XLSXOqKfHWfTPS6C6Vq2UT2HUb3l8dn3SksR7uKAF1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jp8RS9PyXTYJFvkzzLsKbqdk9YThojx4/3xYFhM36XYBeKqzD1VS87sgR3Ep4G+wj
	 nIDIotasekxgRR2+0LR1ZnRFKfv6A7hEbes2g4J5SoihEugtVrNR7XvlNzaLHEZS2r
	 cHZihj147Ov2kMt/c0JJRi/9bPg/TdDk4SdHu+WdXL0qjA0ahVxxKxP7Kc3PwKLHmk
	 b2Opz8lmLzC4ig2Rs95Ar//4WLPrxMnbu3drosCYDokJ6cVPTWVa/Z4SoW7kMZaHjC
	 UkqezaVoZsCnLgyhyOrwMVesW6JK6+EAfZsldb0dCG8a1n/N7VSqtXivIBgWjVJo2f
	 1WwiEbGVseE+Q==
Date: Sun, 12 Apr 2026 12:00:06 +0300
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
Message-ID: <20260412090006.GA21470@unreal>
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal>
 <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal>
 <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-19249-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,paul-moore.com:url,msgid.link:url]
X-Rspamd-Queue-Id: 00E4F3E3332
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 05:04:24PM -0400, Paul Moore wrote:
> On Thu, Apr 9, 2026 at 8:45 AM Leon Romanovsky <leon@kernel.org> wrote:
> > On Thu, Apr 09, 2026 at 02:27:43PM +0200, Roberto Sassu wrote:
> > > On Thu, 2026-04-09 at 15:12 +0300, Leon Romanovsky wrote:
> > > > On Tue, Mar 31, 2026 at 08:56:32AM +0300, Leon Romanovsky wrote:
> > > > > From Chiara:
> > > > >
> > > > > This patch set introduces a new BPF LSM hook to validate firmware commands
> > > > > triggered by userspace before they are submitted to the device. The hook
> > > > > runs after the command buffer is constructed, right before it is sent
> > > > > to firmware.
> > > >
> > > > <...>
> > > >
> > > > > ---
> > > > > Chiara Meiohas (4):
> > > > >       bpf: add firmware command validation hook
> > > > >       selftests/bpf: add test cases for fw_validate_cmd hook
> > > > >       RDMA/mlx5: Externally validate FW commands supplied in DEVX interface
> > > > >       fwctl/mlx5: Externally validate FW commands supplied in fwctl
> > > >
> > > > Hi,
> > > >
> > > > Can we get Ack from BPF/LSM side?
> > >
> > > + Paul, linux-security-module ML
> > >
> > > Hi
> > >
> > > probably you also want to get an Ack from the LSM maintainer (added in
> > > CC with the list). Most likely, he will also ask you to create the
> > > security_*() functions counterparts of the BPF hooks.
> >
> > We implemented this approach in v1:
> > https://patch.msgid.link/20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com
> > and were advised to pursue a different direction.
> 
> I'm assuming you are referring to my comments? If so, that isn't exactly what I said,
> I mentioned at least one other option besides
> going directly to BPF.  Ultimately, it is your choice to decide how
> you want to proceed, but to claim I advised you to avoid a LSM based
> solution isn't strictly correct.

Yes, this matches how we understood your comments:  
https://lore.kernel.org/all/20260311081955.GS12611@unreal/

In the end, the goal is to build something practical and avoid adding
unnecessary complexity that brings no real benefit to users.

> 
> Regardless, looking at your v2 patchset, it looks like you've taken an
> unusual approach of using some of the LSM mechanisms, e.g. LSM_HOOK(),
> but not actually exposing a LSM hook with proper callbacks.
> Unfortunately, that's not something we want to support.  If you want
> to pursue an LSM based solution, complete with a security_XXX() hook,
> use of LSM_HOOK() macros, etc. then that's fine, I'm happy to work
> with you on that.

The issue is that the sentence below was the reason we did not merge v1 with v2:
https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-hooks
"pass through implementations, such as the BPF LSM, are not eligible for
LSM hook reference implementations."


> However, if you've decided that your preferred
> option is to create a BPF hook you should avoid using things like
> LSM_HOOK() and locating your hook/code in bpf_lsm.c.

We are not limited to LSM solution, the goal is to intercept commands
which are submitted to the FW and "security" bucket sounded right to us.

> 
> The good news is that there are plenty of other examples of BPF
> plugable code that you could use as an example, one such thing is the
> update_socket_protocol() BPF hook that was originally proposed as a
> LSM hook, but moved to a dedicated BPF hook as we generally want to
> avoid changing non-LSM kernel objects within the scope of the LSMs.
> While your proposed case is slightly different, I think the basic idea
> and mechanism should still be useful.
> 
> https://lore.kernel.org/all/cover.1692147782.git.geliang.tang@suse.com

Thanks

> 
> -- 
> paul-moore.com
> 

