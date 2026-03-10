Return-Path: <linux-rdma+bounces-17903-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNTZD0NxsGlujQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17903-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 20:30:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB61625705A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 20:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EB3F30612A3
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 19:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680393563C7;
	Tue, 10 Mar 2026 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="malU8zKj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283902E7F25;
	Tue, 10 Mar 2026 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171006; cv=none; b=LboX4ZZfqj0QsnjozGeE27scAGRkf5NqVz2QejzvUc1XqCaJ8LWTuIV5UpEDY4kBqTk8L4UAQVr5g7FczBjduwW56G8ti0pwa139jSHpeNCUHZCtLjXkt6/SN/J9+I0bGQT6sJTYBjguUqPEFVXjaFl+AePF/umqNk0fj1nbkHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171006; c=relaxed/simple;
	bh=1rNJGeotDfkPm9FA4fSdXs8VDn9nF7Ay2FwGOPrTdBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Prt4dk8zQVrbeejoT7++4BRyYhM0DZ87rpakJy9hJ5umMdnEUlABsKS4bD+zkO7/zoUuI6qE2i3rbkWFo24pQa/VIT0uqVm4uPQJ4o9gftruLJYAJob+TNjQYg1PzPrhKAxTW44ZV/pJxLtKILyrHa5lTRDWnDeBaZECSYC1z0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=malU8zKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428C9C19423;
	Tue, 10 Mar 2026 19:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773171005;
	bh=1rNJGeotDfkPm9FA4fSdXs8VDn9nF7Ay2FwGOPrTdBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=malU8zKj6bNvBoVBiQmXuwMqt8VJO4k3BBu5oGctT4fTSW8kt4FMuG1mdKtG43zKB
	 Box6YVJrsOIWnUKOuxV2pvq1XvgIwd1UXhZVrZTH1WtQ9SLEZjBBXUfWbqiJQUXlKa
	 WWJbELCc0u+6Zx9js47hHos3RZ8fZqw04D4fOcaE+r1aFMxOckDhKa0kC1IPvof/oT
	 nZupciFJs5G/qKdiCGERlFp8LSSDf9xa/e9FnHpL73fL/Vl3JEpyaSWF9/QKHXk3Ku
	 ZYdyxRtWYSadcfdvJcs6qXHRsiRe+QLioCt5i55K6Y6Kq39Ytjd2JGeqrtqfn9tJMF
	 xGbgWcNCSKpEA==
Date: Tue, 10 Mar 2026 21:30:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: Re: [PATCH 0/3] Firmware LSM hook
Message-ID: <20260310193000.GM12611@unreal>
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com>
 <20260309193743.GZ12611@unreal>
 <CAHC9VhSRt_QEJKJFBDBySNQCiPpcawd5A76xmoRNtppRKGaCog@mail.gmail.com>
 <20260310090733.GA12611@unreal>
 <CAHC9VhTKsOYrs8Wh-O548=2gE7N_gkBy+q05+atcR=D+30uQ=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTKsOYrs8Wh-O548=2gE7N_gkBy+q05+atcR=D+30uQ=w@mail.gmail.com>
X-Rspamd-Queue-Id: AB61625705A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17903-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 02:24:40PM -0400, Paul Moore wrote:
> On Tue, Mar 10, 2026 at 5:07 AM Leon Romanovsky <leon@kernel.org> wrote:
> > On Mon, Mar 09, 2026 at 07:10:25PM -0400, Paul Moore wrote:
> > > On Mon, Mar 9, 2026 at 3:37 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > On Mon, Mar 09, 2026 at 02:32:39PM -0400, Paul Moore wrote:
> > > > > On Mon, Mar 9, 2026 at 7:15 AM Leon Romanovsky <leon@kernel.org> wrote:
> 
> ...
> 
> > > > > Hi Leon,
> > > > >
> > > > > At the link below, you'll find guidance on submitting new LSM hooks.
> > > > > Please take a look and let me know if you have any questions.
> > > > >
> > > > > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-hooks
> > > >
> > > > I assume that you are referring to this part:
> > >
> > > I'm referring to all of the guidance, but yes, at the very least that
> > > is something that I think we need to see in a future revision of this
> > > patchset.
> > >
> > > >  * New LSM hooks must demonstrate their usefulness by providing a meaningful
> > > >    implementation for at least one in-kernel LSM. The goal is to demonstrate
> > > >    the purpose and expected semantics of the hooks. Out of tree kernel code,
> > > >    and pass through implementations, such as the BPF LSM, are not eligible
> > > >    for LSM hook reference implementations.
> > > >
> > > > The point is that we are not inspecting a kernel call, but the FW mailbox,
> > > > which has very little meaning to the kernel. From the kernel's perspective,
> > > > all relevant checks have already been performed, but the existing capability
> > > > granularity does not allow us to distinguish between FW_CMD1 and FW_CMD2.
> > >
> > > It might help if you could phrase this differently, as I'm not
> > > entirely clear on your argument.  LSMs are not limited to enforcing
> > > access controls on requests the kernel understands (see the SELinux
> > > userspace object manager concept), and the idea of access controls
> > > with greater granularity than capabilities is one of the main reasons
> > > people look to LSMs for access control (SELinux, AppArmor, Smack,
> > > etc.).
> >
> > I should note that my understanding of LSM is limited, so some parts of my
> > answers may be inaccurate.
> >
> > What I am referring to is a different level of granularity — specifically,
> > the internals of the firmware commands. In the proposed approach, BPF
> > programs would make decisions based on data passed through the mailbox.
> > That mailbox format varies across vendors, and may even differ between
> > firmware versions from the same vendor.
> 
> That helps, thank you.
> 
> > > > Here we propose a generic interface that can be applied to all FWCTL
> > > > devices without out-of-tree kernel code at all.
> > >
> > > I expected to see a patch implementing some meaningful support for
> > > access controls using these hooks in one of the existing LSMs, I did
> > > not see that in this patchset.
> >
> > In some cases, the mailbox is forwarded from user space unchanged, but
> > in others the kernel modifies it before submitting it to the FW.
> 
> Without a standard format, opcode definitions, etc. I suspect
> integrating this into an LSM will present a number of challenges.

The opcode is relatively easy to extract from the mailbox and pass to the LSM.
All drivers implement some variant of mlx5ctl_validate_rpc()/devx_is_general_cmd()
to validate the opcode. The problem is that this check alone is not sufficient.

> Instead of performing an LSM access control check before submitting
> the firmware command, it might be easier from an LSM perspective to
> have the firmware call into the kernel/LSM for an access control
> decision before performing a security-relevant action.

Ultimately, the LSM must make a decision for each executed firmware  
command. This will need to be handled one way or another, and will  
likely require parsing the mailbox again.

> This removes the challenge of parsing/interpreting the arbitrary firmware commands,
> but it does add some additional complexity of having to generically
> represent the security relevant actions the firmware might request

The difference here is that the proposed LSM hook is intended to disable
certain functionality provided by the firmware, effectively depending on
the operator’s preferences.

This is not a security‑sensitive operation that requires strict
restriction.

> (this is somewhat similar to how the LSM framework doesn't necessarily
> hook the syscalls, but the actions the syscalls perform).  Yes, one
> does have to trust the firmware in this approach, but given the
> relationship between the firmware and associated hardware, I think
> users are implicitly required to trust their firmware in the vast
> majority of cases.

They trust the firmware and the kernel, but they do not trust the actual  
non‑privileged users of that firmware.

Thanks

> 
> -- 
> paul-moore.com
> 

