Return-Path: <linux-rdma+bounces-17180-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M4rJQsMn2neYgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17180-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:49:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D80E198F81
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 270A6305BF57
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8604D3D4105;
	Wed, 25 Feb 2026 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjAH1Ynu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B613D34A4;
	Wed, 25 Feb 2026 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030923; cv=none; b=IpSkL0goLs5MsfwQ+se2RH8q/LlkL/PySAq4yX0hEKRDqLtn0WUzu/0D2X/Z/hdjDeW1gEakyYZC1Do22CF3dyeijpb11WODVu8gh96xlkdMDUDRo+cLni9n48UvrnQd0RozlCbagNWW3pFNHQ2Yp3DObM3ZI7v/y17N0OeNjIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030923; c=relaxed/simple;
	bh=a48AnDXr2g5J8/duPgNtsMAvR0EueaiZVi6qlr1yaao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqL/GxNXMb/U1Y6O9RTTnsX7XrfDgRznWqId1M8k1jpmQkMdjkLs9zDYQOSY/EaZSWLI94MMoEnKdbOnBU4TIp+XjOQ6XFvKU+4C8P2OsDWMjm0tVzYKblYmrSFGE7P+l5y5scifAQfF71BKDPC0rmx9c65++tV7FU3GjcEC9bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjAH1Ynu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499B7C2BCB1;
	Wed, 25 Feb 2026 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772030922;
	bh=a48AnDXr2g5J8/duPgNtsMAvR0EueaiZVi6qlr1yaao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NjAH1YnufeImsvdf1D8D2EjhwD32nPYuLZvJFyWUSv6Co+KnHRH1sfWnggLN3E+nr
	 YMR+hftNy2SDN32Jqpxaj7I9zV/+Ho/R6DwljtMp1tuNNtj5wQlRq6UjoAuB4M5gxE
	 h4f7rvB5lNjQPMhiMGzap3v7cIr+NeR4eAxrl4jN9kaCzfSaubfL7IAppSk/+y6JdR
	 ylE9jTvou4P/5yQfjWEYvf0dBJoSYcXwhUPI53vsIUEG7pgVEvOsgip+ZpELUkZoWL
	 rxVisgDL4+v3jV6eSAZnnQK6+CLVVs52y5CBlRrjqtOCq0SpSxvC1OaZn9ZG6Abl5I
	 JCDBliQrhGEhQ==
Date: Wed, 25 Feb 2026 16:48:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH rdma-next 0/6] Add support for TLP emulation
Message-ID: <20260225144839.GG9541@unreal>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17180-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D80E198F81
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
> 
> Thanks
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Maher Sanalla (6):
>       net/mlx5: Add TLP emulation device capabilities
>       net/mlx5: Expose TLP emulation capabilities
>       RDMA/mlx5: Refactor VAR table to use region abstraction
>       RDMA/mlx5: Add TLP VAR region support and infrastructure
>       RDMA/mlx5: Add support for TLP VAR allocation

>       RDMA/mlx5: Add VAR object query method for cross-process sharing

There is no need in this last patch. There is a way to implement it
purely in userspace.

Thanks

