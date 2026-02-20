Return-Path: <linux-rdma+bounces-17034-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ50JiFCmGneDwMAu9opvQ
	(envelope-from <linux-rdma+bounces-17034-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 12:14:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 326811672FD
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 12:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12F2830541F4
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 11:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D49342502;
	Fri, 20 Feb 2026 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfPun1Jc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25617341ACA;
	Fri, 20 Feb 2026 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586058; cv=none; b=C+jY7N2XxjVXq5LZJFIkouc9jxaGPBILeNM5bATNqN0+9bb/ptTVbHvzrrwW0+gczcOW73iR/xOM0B5srr3UFyqf6VJ/m5zZAwv0lgaSQWUxsiqku08jswh+nxjG4OfocNp3dSuE1ia0hpKoNpMOvQe00tK+HP5S7LjHqLFTdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586058; c=relaxed/simple;
	bh=OBIwovGiLEgk9sxiCKOM48/c82NKWhf+xBbPy5J21OY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=S+qJiODOy44CeHtLCD+0DkbjbWBFaWQzZb3jYQtT0xapBmSIquY4sRaAO0dfIQyW0WtZMmxK96/wV0sLcFNVv+ySXNzbACG41TRH6Az5sqGsEvGlvmaUXINH6niWKbWSCSbTtQipYCkb/IjisqZ3F72QeO7bGHieiU6LNHpx5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfPun1Jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981C6C116C6;
	Fri, 20 Feb 2026 11:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771586058;
	bh=OBIwovGiLEgk9sxiCKOM48/c82NKWhf+xBbPy5J21OY=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=gfPun1JctNvoNIPU18uGCxIMd5aHiT6dlrmj2bsqLAyavEu8synMj7lWsFKeZXRGe
	 2Ct9Zau5qkp2RGx60hxrlRnWk2pql8eJaaMg7VDRPkmx9vl7oYB9EiQrfHWiWDClNI
	 epLqINoePUTxsjEVMnF3aXbzG0cL+ZDDE21nmHe2GjTf5UuKRo3+afXOpGYryxTUiy
	 3bnMj7tn0ROxyUkCt5R9Q7+7EUQo2EiZ1p8doDxcASopRTcPqmbosOUSng3pwf9F8r
	 9it9JfwQvqkFvY1m8DW6yYf9trdQEriJWze7GP1c65mUJhsz2kL5OiLm+faDY8Pect
	 NCXlJg33ToXqw==
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 12:14:12 +0100
Message-Id: <DGJQUDBN8WQ2.BPQRSNNGMH6X@kernel.org>
To: "Leon Romanovsky" <leon@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH V2] driver core: auxiliary bus: Fix sysfs creation on
 bind
Cc: "Tariq Toukan" <tariqt@nvidia.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Saeed Mahameed" <saeedm@nvidia.com>, "Mark Bloch" <mbloch@nvidia.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, "Gal Pressman"
 <gal@nvidia.com>, "Moshe Shemesh" <moshe@nvidia.com>, "Amir Tzin"
 <amirtz@nvidia.com>
References: <20260219210435.1769394-1-tariqt@nvidia.com>
 <DGJCHYS3SKIQ.1TIHQCMEOCRC@kernel.org> <20260220080413.GB10607@unreal>
In-Reply-To: <20260220080413.GB10607@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17034-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 326811672FD
X-Rspamd-Action: no action

On Fri Feb 20, 2026 at 9:04 AM CET, Leon Romanovsky wrote:
> This init->add->remove->destroy pattern follows standard Linux kernel pra=
ctice.
> I expect all current review tools to flag any missing function call
> among these three.

I'm not saying that the flow is not logical, goes against existing patterns=
,
etc., I'm saying that it is unnecessary to expose a new API to drivers, sin=
ce
this is already handled internally.

I.e. we can easily fix the bug without increasing the API surface exposing =
a new
API to drivers.

> It is not, atomic is not a replacement for locking and this hunk is
> going to be racy as hell:

No, of course not, but it is sufficient to ensure that something runs only =
once.

However, you are still right, since sysfs_create_group() can still fail, we
still need the mutex, because we may need to unwind.

> In the proposed patch, locking is handled by the driver, which understand=
s the
> flow far better than the driver core.

I don't think so, the driver core (or actually the auxiliary bus code) is
perfectly aware of the flow, i.e. create the attribute group once actually
needed by auxiliary_device_sysfs_irq_add(), remove it on driver unbind.

