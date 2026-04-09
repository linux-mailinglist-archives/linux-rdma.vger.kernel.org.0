Return-Path: <linux-rdma+bounces-19162-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIx+HjOg12kUQQgAu9opvQ
	(envelope-from <linux-rdma+bounces-19162-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:48:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C94D23CA9B3
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 984AA302A6BA
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714CE3CE496;
	Thu,  9 Apr 2026 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIvAptah"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322BB386566;
	Thu,  9 Apr 2026 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738758; cv=none; b=W8FlGbkmUh+manCRaDEb64J0Sje8RNKygItsanA2mwoKxDETUg2qF1xxVQfYKxRDg+Wl9wQtRsS1lKX8LGZRod1iIL23aiUJZEVr3uyFBmRiN0rCiOHNwXrBqhZmjdx3WETfGtvvb/JBdSaFYJ3wmWSD7XG/FaZaPN6H3wh4reE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738758; c=relaxed/simple;
	bh=F3YWEWo+ZWw7HTP+EW83s9mQm7lmQNVuen/JBUuUnKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdYVDNhmoLZB9gWKN77ecj8IHp76uE9idqgi2GtcbgYk/RSuyJ/525Kj2W+XCYt/LBkw+VYNhH0fL8kpB5TYEyjW0O5VytFewMbdHgknIXDHJWoneJWpajDAo2VyvsAYref/1t1hYPHooKpXKCQNjD0h5lmFdqIIQGyhqyBUgpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIvAptah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D466C4CEF7;
	Thu,  9 Apr 2026 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775738757;
	bh=F3YWEWo+ZWw7HTP+EW83s9mQm7lmQNVuen/JBUuUnKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIvAptahXSFmNzHFMElZa6wcgXee9e/ruyoLqF6Pn1zw/4Vj6v3Ty2OoXzK6dY+n6
	 2giIpM4yXIXlAMd3pnD52DFd75PZ7MU0CKqrYewo8qXGe+vMyZBBFR3XIKkJtWRJbu
	 8mmahAZCkXnwJF4kNrYpVnQ+qu6wfhmeV3eBK1YBYTHoQfr0H/wcI4D4LjSB5iGBTb
	 TpE0L/EzixG7I1N3dGOaXH2J6grSzeact+g1IrL2wJ22ecjIbkSatnNTFXrjYZ8+c4
	 Uro7UxW4GX6d5qMe9Pfi1cmKR+SsInIFZ3Srx/4wKQQpKLSlqNwwEcArq7k82hhZ3a
	 TBEwjf+JPqOGA==
Date: Thu, 9 Apr 2026 15:45:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: KP Singh <kpsingh@kernel.org>,
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
	Maher Sanalla <msanalla@nvidia.com>, paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
Message-ID: <20260409124553.GB720371@unreal>
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal>
 <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19162-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,ziepe.ca,nvidia.com,intel.com,huawei.com,vger.kernel.org,paul-moore.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,nvidia.com:email]
X-Rspamd-Queue-Id: C94D23CA9B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 02:27:43PM +0200, Roberto Sassu wrote:
> On Thu, 2026-04-09 at 15:12 +0300, Leon Romanovsky wrote:
> > On Tue, Mar 31, 2026 at 08:56:32AM +0300, Leon Romanovsky wrote:
> > > From Chiara:
> > > 
> > > This patch set introduces a new BPF LSM hook to validate firmware commands
> > > triggered by userspace before they are submitted to the device. The hook
> > > runs after the command buffer is constructed, right before it is sent
> > > to firmware.
> > 
> > <...>
> > 
> > > ---
> > > Chiara Meiohas (4):
> > >       bpf: add firmware command validation hook
> > >       selftests/bpf: add test cases for fw_validate_cmd hook
> > >       RDMA/mlx5: Externally validate FW commands supplied in DEVX interface
> > >       fwctl/mlx5: Externally validate FW commands supplied in fwctl
> > 
> > Hi,
> > 
> > Can we get Ack from BPF/LSM side?
> 
> + Paul, linux-security-module ML
> 
> Hi
> 
> probably you also want to get an Ack from the LSM maintainer (added in
> CC with the list). Most likely, he will also ask you to create the
> security_*() functions counterparts of the BPF hooks.

We implemented this approach in v1:
https://patch.msgid.link/20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com
and were advised to pursue a different direction.

Thanks

> 
> Roberto
> 
> > Thanks
> > 
> > > 
> > >  drivers/fwctl/mlx5/main.c                        | 12 +++++-
> > >  drivers/infiniband/hw/mlx5/devx.c                | 49 ++++++++++++++++++------
> > >  include/linux/bpf_lsm.h                          | 41 ++++++++++++++++++++
> > >  kernel/bpf/bpf_lsm.c                             | 11 ++++++
> > >  tools/testing/selftests/bpf/progs/verifier_lsm.c | 23 +++++++++++
> > >  5 files changed, 122 insertions(+), 14 deletions(-)
> > > ---
> > > base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> > > change-id: 20260309-fw-lsm-hook-7c094f909ffc
> > > 
> > > Best regards,
> > > --  
> > > Leon Romanovsky <leonro@nvidia.com>
> > > 
> 
> 

