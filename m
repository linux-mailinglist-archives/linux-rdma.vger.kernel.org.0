Return-Path: <linux-rdma+bounces-16579-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPu3EK+ThGk43gMAu9opvQ
	(envelope-from <linux-rdma+bounces-16579-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 13:57:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C10AF2DEA
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 13:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA603030117
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5D3D5221;
	Thu,  5 Feb 2026 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQCpLh6g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43813AA2F;
	Thu,  5 Feb 2026 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296096; cv=none; b=ukD8ySUxZTOtp63dcKGo+YT75s9PkqmTW5KtHDqrTwGdW4/Q2/uugd5ZXsK4bDxYUJtj/JjNknzxZTCCx1BAlT+0TksQp3zkqyuic5fox9Ms79e3Rpq7RpRwcQL2dys8NqElCTwA71toyyumrELcBn7kLBQ2ka4hvOxblmGzR0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296096; c=relaxed/simple;
	bh=rd7IcAxI7KXXPqJTRS37PUB7IUPkaSG1cqSOfe+KXUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsdmN6ai5IKKZjyZLfU+xBfD+K/n4QH4txyp0YichMpmV+8lYHDsEx+m+nDd/DebtRi7i2cOCZXN22KMHy/1dqk7GJgYo/sgoHvpF4D6iy8u9BNpmi8Qe7WuJwB/46YudLzsaXd3DEAlXseGL9FVR3lYriD3Zl9K0k0wmhCGJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQCpLh6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFEAC4CEF7;
	Thu,  5 Feb 2026 12:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770296095;
	bh=rd7IcAxI7KXXPqJTRS37PUB7IUPkaSG1cqSOfe+KXUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQCpLh6gd+PBKTfgShfaD6r24q4QHW21CwfekwoWm3SWRaFV47nio3OctX7I1bYa/
	 QWZjWf/Ml/xfDmaIw4Mlqft4eIopKkQRwQ0bdWAT5jsmwH7ykh/NLS0KZK4OUJEcsU
	 OKklMe+mL+PyOMLOpE0I2wTtl/9hDUqYx+phuXii5eXDltlhUDw4a8oqQXQ2cUHMif
	 0V9zoW2f8Ja+nJZKCNHl63K3UKggMDQpWR3j9zEPUjnn5/dUxPorCweEOGwuGTlod7
	 dSfy+tO5YUg184/uDRiryjUzVIAhSPh+TN2Z+zdXAlDHnJWalnJ/LCiXJQ9SH+0MIp
	 2EUe5ISYGabjw==
Date: Thu, 5 Feb 2026 14:54:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Yael Chemla <ychemla@nvidia.com>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Shahar Shitrit <shshitrit@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5: Fix 1600G link mode enum naming
Message-ID: <20260205125451.GE12824@unreal>
References: <20260204194324.1723534-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204194324.1723534-1-tariqt@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-16579-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 9C10AF2DEA
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 09:43:24PM +0200, Tariq Toukan wrote:
> From: Yael Chemla <ychemla@nvidia.com>
> 
> Rename TAUI/TBASE to GAUI/GBASE in 1600G link mode identifier and its
> usage in ethtool and link-info tables.
> 
> Reported-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Yael Chemla <ychemla@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c                    | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/port.c       | 2 +-
>  include/linux/mlx5/port.h                            | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

