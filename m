Return-Path: <linux-rdma+bounces-18023-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJr8LLrAsWkwFAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18023-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:21:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC222693B2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 532D4324766E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 19:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6973019DC;
	Wed, 11 Mar 2026 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzUq9D/x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F82C0285;
	Wed, 11 Mar 2026 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256599; cv=none; b=DKakTyar0JZvwumwcvUCxN6Au+iX7BlJmTGsEiMjDt3SCsryu2uDQI4waSsXy0u+3GZ+2okV2Cnk2hjFn3cSLT+SKM/ekAouniaR21hprV5QKoXLDVFtDh8C34/tQqZVX2InTzqZ/iv28QS0hXgz0pJFCSCWCg0nndfeOnz/tlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256599; c=relaxed/simple;
	bh=viQVK+ttUf0/GAMv0IQvikFFGJ/M/aCjzTR7XLE/Vag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFgFIXkmsRl6JSclZLJQD+F5DD7AtN94OpBcYCLzPnAjTwC7YTNMSREaF7196rq9o1q1sM0K+H+bQ9o1pNSivUxsFs8oOrRUsxL20B7sLDTnXfIK711xPTbPXz3EBeqO+25YpVMBiUuvuaiMB2c5bI5OpE9xeEc4oEELbdoASeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzUq9D/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D793C116C6;
	Wed, 11 Mar 2026 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773256599;
	bh=viQVK+ttUf0/GAMv0IQvikFFGJ/M/aCjzTR7XLE/Vag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzUq9D/xzec9x8Ynd+iPP6ePo7BZinxg/VM6yhohD3LXNt7AMtQ5Uq0xgL7GqVlap
	 sCXv8FGohevbdy5yLbSATzQu+fzrFmcD1XiMuU8gZuSZOP+kVbzMRzjm+M5xoqQUX8
	 L+UFQfFvy0nMsig80r3A4QWNlgZ50yIeYh+ExOm2eiKtQR2x8366reL0BZKR/rUKnt
	 Wfc5ISSjnHFQVdo2hB6QgBiYN+MbD14XZBpBMBP0eGJO0LyE5fvGI+OinqyBZldj8W
	 66vAXOCKw7ZgZ7I23RBmcj4xBaMhcF4F7vqaRD205j5QNQ3JyvBnIoEIEmyl+YR7nH
	 wK++ljV/wBZuQ==
Date: Wed, 11 Mar 2026 21:16:35 +0200
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
Message-ID: <20260311191635.GY12611@unreal>
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com>
 <20260309193743.GZ12611@unreal>
 <CAHC9VhSRt_QEJKJFBDBySNQCiPpcawd5A76xmoRNtppRKGaCog@mail.gmail.com>
 <20260310090733.GA12611@unreal>
 <CAHC9VhTKsOYrs8Wh-O548=2gE7N_gkBy+q05+atcR=D+30uQ=w@mail.gmail.com>
 <20260310193000.GM12611@unreal>
 <CAHC9VhSh8A+yGHT_+BqFGaLNqsZDcaz_cuqf9A+neRQQ3PMY4A@mail.gmail.com>
 <20260311081955.GS12611@unreal>
 <CAHC9VhR0iuzYRpi3vPdKAbsOJ-DoMvWV-c7TXVcAmb3u8J4JwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR0iuzYRpi3vPdKAbsOJ-DoMvWV-c7TXVcAmb3u8J4JwA@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18023-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EC222693B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:06:09PM -0400, Paul Moore wrote:
> On Wed, Mar 11, 2026 at 4:20 AM Leon Romanovsky <leon@kernel.org> wrote:
> > On Tue, Mar 10, 2026 at 05:40:02PM -0400, Paul Moore wrote:
> > > On Tue, Mar 10, 2026 at 3:30 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > On Tue, Mar 10, 2026 at 02:24:40PM -0400, Paul Moore wrote:
> > > > > On Tue, Mar 10, 2026 at 5:07 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > > On Mon, Mar 09, 2026 at 07:10:25PM -0400, Paul Moore wrote:
> > > > > > > On Mon, Mar 9, 2026 at 3:37 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > > > > On Mon, Mar 09, 2026 at 02:32:39PM -0400, Paul Moore wrote:
> > > > > > > > > On Mon, Mar 9, 2026 at 7:15 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > ...
> > > > >
> > > > > > > > > Hi Leon,
> > > > > > > > >
> > > > > > > > > At the link below, you'll find guidance on submitting new LSM hooks.
> > > > > > > > > Please take a look and let me know if you have any questions.
> > > > > > > > >
> > > > > > > > > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-hooks
> > > > > > > >
> > > > > > > > I assume that you are referring to this part:
> > > > > > >
> > > > > > > I'm referring to all of the guidance, but yes, at the very least that
> > > > > > > is something that I think we need to see in a future revision of this
> > > > > > > patchset.
> > > > > > >
> > > > > > > >  * New LSM hooks must demonstrate their usefulness by providing a meaningful
> > > > > > > >    implementation for at least one in-kernel LSM. The goal is to demonstrate
> > > > > > > >    the purpose and expected semantics of the hooks. Out of tree kernel code,
> > > > > > > >    and pass through implementations, such as the BPF LSM, are not eligible
> > > > > > > >    for LSM hook reference implementations.
> > > > > > > >
> > > > > > > > The point is that we are not inspecting a kernel call, but the FW mailbox,
> > > > > > > > which has very little meaning to the kernel. From the kernel's perspective,
> > > > > > > > all relevant checks have already been performed, but the existing capability
> > > > > > > > granularity does not allow us to distinguish between FW_CMD1 and FW_CMD2.
> > > > > > >
> > > > > > > It might help if you could phrase this differently, as I'm not
> > > > > > > entirely clear on your argument.  LSMs are not limited to enforcing
> > > > > > > access controls on requests the kernel understands (see the SELinux
> > > > > > > userspace object manager concept), and the idea of access controls
> > > > > > > with greater granularity than capabilities is one of the main reasons
> > > > > > > people look to LSMs for access control (SELinux, AppArmor, Smack,
> > > > > > > etc.).
> > > > > >
> > > > > > I should note that my understanding of LSM is limited, so some parts of my
> > > > > > answers may be inaccurate.
> > > > > >
> > > > > > What I am referring to is a different level of granularity — specifically,
> > > > > > the internals of the firmware commands. In the proposed approach, BPF
> > > > > > programs would make decisions based on data passed through the mailbox.
> > > > > > That mailbox format varies across vendors, and may even differ between
> > > > > > firmware versions from the same vendor.
> > > > >
> > > > > That helps, thank you.
> > > > >
> > > > > > > > Here we propose a generic interface that can be applied to all FWCTL
> > > > > > > > devices without out-of-tree kernel code at all.
> > > > > > >
> > > > > > > I expected to see a patch implementing some meaningful support for
> > > > > > > access controls using these hooks in one of the existing LSMs, I did
> > > > > > > not see that in this patchset.
> > > > > >
> > > > > > In some cases, the mailbox is forwarded from user space unchanged, but
> > > > > > in others the kernel modifies it before submitting it to the FW.
> > > > >
> > > > > Without a standard format, opcode definitions, etc. I suspect
> > > > > integrating this into an LSM will present a number of challenges.
> > > >
> > > > The opcode is relatively easy to extract from the mailbox and pass to the LSM.
> > > > All drivers implement some variant of mlx5ctl_validate_rpc()/devx_is_general_cmd()
> > > > to validate the opcode. The problem is that this check alone is not sufficient.
> > > >
> > > > > Instead of performing an LSM access control check before submitting
> > > > > the firmware command, it might be easier from an LSM perspective to
> > > > > have the firmware call into the kernel/LSM for an access control
> > > > > decision before performing a security-relevant action.
> > > >
> > > > Ultimately, the LSM must make a decision for each executed firmware
> > > > command. This will need to be handled one way or another, and will
> > > > likely require parsing the mailbox again.
> > >
> > > As it's unlikely that parsing the mailbox is something that a LSM will
> > > want to handle,
> >
> > I believe this approach offers the cleanest and most natural way to support
> > all mailbox‑based devices.
> >
> > > my suggestion was to leverage the existing mailbox parsing in the firmware
> > > and require the firmware to call into the LSM when authorization is needed.
> > >
> > > > > This removes the challenge of parsing/interpreting the arbitrary firmware commands,
> > > > > but it does add some additional complexity of having to generically
> > > > > represent the security relevant actions the firmware might request
> > > >
> > > > The difference here is that the proposed LSM hook is intended to disable
> > > > certain functionality provided by the firmware, effectively depending on
> > > > the operator’s preferences.
> > >
> > > My suggestion would also allow a LSM hook to disable certain firmware
> > > functionality; however, the firmware itself would need to call the LSM
> > > to check if the functionality is authorized.
> >
> > This suggestion adds an extra call from the FW to the LSM for every command, even
> > for systems which don't have LSM at all.
> 
> If latency is a concern, I imagine we could create an LSM hook to
> report whether any LSMs provided firmware access controls.  The
> firmware could then use that hook, potentially caching the result, to
> limit its calls into the LSM.
> 
> > The FW must pass the already parsed data
> > back to the LSM; otherwise, the LSM   has no basis to decide whether to accept or
> > reject the request.
> >
> > For example, consider the MLX5_CMD_OP_QUERY_DCT command handled in
> > mlx5ctl_validate_rpc(). DCT in RDMA refers to Dynamically Connected
> > Transport, a Mellanox-specific extension that effectively introduces a new
> > QP‑type family on top of the standard RC/UC/UD transports. This type does not
> > exist for other vendors, each of whom provides its own vendor‑specific
> > extensions. All parameters here are tightly coupled to those specific
> > commands.
> >
> > It is unrealistic to expect different firmware implementations to supply
> > their data in a common format that would allow the LSM to make a generic
> > decision.
> 
> That's unfortunate as that would be the easiest path forward.
> Regardless, you are welcome to work on whatever implementation you
> think makes sense for any of the in-tree LSMs, with that in place we
> can take another look at the firmware command hooks.
> 
> Good luck.

I'll take advantage of the upcoming weekend and look into what can be done
here.

Thanks

> 
> -- 
> paul-moore.com

