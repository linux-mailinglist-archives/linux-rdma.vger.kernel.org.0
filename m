Return-Path: <linux-rdma+bounces-19859-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P+WBYMv9mmdSwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19859-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 19:08:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED214B2F4E
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 19:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0FE4300F9F2
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A0B382F10;
	Sat,  2 May 2026 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz1l8ErP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496E0299AAB;
	Sat,  2 May 2026 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777741690; cv=none; b=nYu8ObIs9FZMX5RQT7EQVQIP6Xlb9kCcWNmWLqbnSwy8lsndRRxyWEaYR9JHXTeZq1H0fHaoidDYXaEpeiwEnan6HF2RpA0MWALBMDhAgYCL0Q2D0ma/vRnGnuGynfjJ0ipBveUQlJN/35BM10Rylu1KVhOO3JDlDPX73zoOWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777741690; c=relaxed/simple;
	bh=30Uahu0v/XehWUtxu9l0X2lqpXU+V5dHVU5p7Ysft0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV1DGEYaak5vTy8ybMrFGnRnT0k/0uQXouBl+tzO8gVu6kfzd8uETNEzXpldnmeKR1RwNhUiqZ0oD7DncBxz5Gs1NPArw7/tXeHeeyT7LlOP1Znq6eAMXcmJICuGt68P/UbpT43g9kOYgtiQU91tdp++6JRmO04Kj0aXsa4I434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz1l8ErP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83176C19425;
	Sat,  2 May 2026 17:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777741689;
	bh=30Uahu0v/XehWUtxu9l0X2lqpXU+V5dHVU5p7Ysft0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sz1l8ErPMSmuGu5loMwMeOHJJoP6PmNqPQEEDsbePAJyAKGYVdDFxggRkgSIO3wbN
	 mli1wfSei6iPbPT2uItrmqj1BH8TsgUMa+cWkKiccABu1tCJ5CkHosnPd32seXAkfp
	 ou9Os54dP2xL/HZj8MMkT9eLrdrD1FDe8l/SIzut01aUyHI8SHRbaafO4TmBrqZhNU
	 bX4eWLrt78am3eiKB/W/ffXIlJ/WjdmRI4UfJQdK4d08E2hLhqzCjjF9qs0OFQAj4+
	 /oiy/XBt4dsMGYEuu1K7xJWHxp81h+xVmhQfdQpvKtD22tFfimRV+s+cz77T9B2WuR
	 vKWY6zIFLUPHQ==
Date: Sat, 2 May 2026 18:08:04 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>, Kees Cook <kees@kernel.org>,
	Dragos Tatulea <dtatulea@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5: Add vhca_id_type support to IPsec
 alias creation
Message-ID: <20260502170804.GN15617@horms.kernel.org>
References: <20260430061958.225245-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430061958.225245-1-tariqt@nvidia.com>
X-Rspamd-Queue-Id: 5ED214B2F4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19859-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 09:19:58AM +0300, Tariq Toukan wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> When creating an alias FT for MPV IPsec, if alias creation with
> sw_vhca_id is supported use it instead of using the hw_vhca_id.
> 
> This in turn allows IPsec to work properly after live migration,
> in case a VF was live migrated and his hw_vhca_id changed due to
> migration which can happen if you migrate to a VF with a different index
> than yours, IPsec would fail to start post migration, this patch
> resolves the issue by using sw_vhca_id instead which doesn't change post
> migration.
> 
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


