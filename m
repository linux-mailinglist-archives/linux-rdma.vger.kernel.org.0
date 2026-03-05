Return-Path: <linux-rdma+bounces-17520-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL6TC0xfqWlc6QAAu9opvQ
	(envelope-from <linux-rdma+bounces-17520-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 11:47:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AADC20FF05
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 11:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FF4B304F48E
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 10:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654E8382360;
	Thu,  5 Mar 2026 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+A/J+aI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27474375F6D;
	Thu,  5 Mar 2026 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707464; cv=none; b=UtEbIF/F1mJNT+CM0Z8UFSDaXyAlyyh6rt97dHcorE7O8wFtMgcQBoc9SUUoiPg6agxRqHaQkZGNeLSxi32ZFQFkXLKZGhM1MgYLV5+HqhsaDD9oc9ZRnP1cBy8sxkx06b3+9QDkp+YyioK1LNm1DU9ALK4LTpqfdS/e8byRVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707464; c=relaxed/simple;
	bh=9Edvck3LxiBvAXzvxFRHIOn3vCHYrELA6m6QYdblTzA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qUGPeRgJrnTHbPhlB0UqYpk7tMRiNsrzfhaK6c3vhAUJCjozxJaVdl22T2wSvEE954piTEm8OIQTMttFPrrJmkG4zAWjnBi8CnBFOes/tdCbvCpMjB4AxTKHjDy2+4Vlk7oXgSOVx6XR2b7mW44hXbWfzKXDaeWJuSp0RhyhLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+A/J+aI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966D0C116C6;
	Thu,  5 Mar 2026 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707464;
	bh=9Edvck3LxiBvAXzvxFRHIOn3vCHYrELA6m6QYdblTzA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I+A/J+aIrdrEYqniBB6Tb8c15G9pVcV0AIhe9vRhE1fEoUlVTZbNUv6SO3JTBtc7n
	 4Gj7dv9lh7V5nL1dQQdICRFvUAUlxUea84CEZSbzh2f/OdOwiEMeS62+JCGmmy6tZu
	 /P7lAoK0NwM8J6ZQCPTZsk28l5ll+l92/qlOvyB78k9o8pZZjDmnblB6lvNEDDNSrO
	 qx1vj6NMa3i5OcbDHyO8B2go5EWgisja5Hc1wo4rS104v0uGwI2g+nLcNZ8G+NcDta
	 MO5kLuDSwI3mC9mD188ac2tMfy/5UoLe/4eXBMW56Y0QRHjdclchddujIAhc305tLB
	 z+g/TnS1tzRrw==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maher Sanalla <msanalla@nvidia.com>
In-Reply-To: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
References: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
Subject: Re: (subset) [PATCH rdma-next 0/6] Add support for TLP emulation
Message-Id: <177270746103.1221304.5163870005960445007.b4-ty@kernel.org>
Date: Thu, 05 Mar 2026 05:44:21 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: 9AADC20FF05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17520-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Wed, 25 Feb 2026 16:19:30 +0200, Leon Romanovsky wrote:
> This series adds support for Transaction Layer Packet (TLP) emulation
> response gateway regions, enabling userspace device emulation software
> to write TLP responses directly to lower layers without kernel driver
> involvement.
> 
> Currently, the mlx5 driver exposes VirtIO emulation access regions via
> the MLX5_IB_METHOD_VAR_OBJ_ALLOC ioctl. This series extends that
> ioctl to also support allocating TLP response gateway channels for
> PCI device emulation use cases.
> 
> [...]

Applied, thanks!

[3/6] RDMA/mlx5: Refactor VAR table to use region abstraction
      (no commit info)
[4/6] RDMA/mlx5: Add TLP VAR region support and infrastructure
      (no commit info)
[5/6] RDMA/mlx5: Add support for TLP VAR allocation
      (no commit info)
[6/6] RDMA/mlx5: Add VAR object query method for cross-process sharing
      (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


