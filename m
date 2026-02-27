Return-Path: <linux-rdma+bounces-17321-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMv8LpwOoml9ygQAu9opvQ
	(envelope-from <linux-rdma+bounces-17321-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 22:37:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A691BE363
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 22:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3919830ACECA
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 21:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7CD478E3B;
	Fri, 27 Feb 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brwnEVJF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E23E8C60;
	Fri, 27 Feb 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772228229; cv=none; b=SDoXfGvyuRFatMVY1Vgyu1ksRxIsHgE9vCi3aNBozXd7KYOnacwxKn65iNvkIrOjpy5YtPdrdDByaMsHz1RlR+QhGpfy+DRw55JHU/7bVLMloW+IBjJV+ZP6VKRBeYUi3tmYLfYfaGJmks800YSUsMy7bXTGnSJZz5EeuP3k2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772228229; c=relaxed/simple;
	bh=5tXnhuCv52KCUVGltNH02leOmDs6VgPWcF8wP7DmfYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X35IXgLlso7mp0+/7/SogQ+afbxpQ9xRhqQJwEnaST+cJk8gGsCAeG5VYRPJSMLzDMX3jpdCMfCaTH5Ry87FYKxrSxVvVgNAetqUUZROw2dRprIcsZXZHqKrRbPWOmq304KrKSl6ZJpgCMaItuj0Me2Ocn5pukQkPm7TfGssHgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brwnEVJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F60C19423;
	Fri, 27 Feb 2026 21:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772228229;
	bh=5tXnhuCv52KCUVGltNH02leOmDs6VgPWcF8wP7DmfYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brwnEVJFVllXBTc0ka5thA6S+i5EEMndcr/o6BMfob4vigY2t2NdfmuHLsnt8z9ja
	 oWJW3HFgJ8uHkdFuEnJ6Pd3HxuJ5pXitMdCR4RDXR3uKnZL6ePhRD1v/bSJEL8m5y+
	 JCvM7AwH2wn2FREnGBH4573AWc2I4yb8CbOLfu3cMDGuhbY1rMrwqM5KzDFVlIZqnC
	 B4LYNX5M91tqJOaPTR7fgzRpU8PSXET5nDueXto0aL6sBWZWVZ3+oDgD9kYau91r2y
	 duJzvMjZJc08/XqShFFucHfmJoBCI40D1Rntj7MQCINhKl4bcIm1AcW2QutFvwJEXD
	 BMeEm2JSoq5og==
Date: Fri, 27 Feb 2026 14:37:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH rdma-next 0/6] Add support for TLP emulation
Message-ID: <aaIOgcfCbRIBlpUO@kbusch-mbp>
References: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17321-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60A691BE363
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:19:30PM +0200, Leon Romanovsky wrote:
> This series adds support for Transaction Layer Packet (TLP) emulation
> response gateway regions, enabling userspace device emulation software
> to write TLP responses directly to lower layers without kernel driver
> involvement.
> 
> Currently, the mlx5 driver exposes VirtIO emulation access regions via
> the MLX5_IB_METHOD_VAR_OBJ_ALLOC ioctl. This series extends that
> ioctl to also support allocating TLP response gateway channels for
> PCI device emulation use cases.

Sorry if this is obvious to people in the know, but could you possibly
give a quick high level description of the use case behind this feature?
I'm just curious what emulation needs are enabled by having access to
this packet level. Thanks!

