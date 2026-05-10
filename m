Return-Path: <linux-rdma+bounces-20318-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJlzKs/WAGovNQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20318-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 21:04:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 381C8505E16
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 21:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBEBD3006B36
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 19:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32C13242B5;
	Sun, 10 May 2026 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlvLsY+3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957EE31F9B4;
	Sun, 10 May 2026 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778439874; cv=none; b=rgnNh+T1zwI/FGWcb0GYbkkmBecM19STbXyeGmyXkrBCPnmm2gfGQotpbvxi42WDAeWekj/DFrpJ0SUVAcU0LaF+i0oLgr87CLbAmC4ckfNY0MRP8QtxsZMUPIho5VlVjJCZOa0UGdTZuXfcrgD0k4HEzfWYnsYsaudYuQ7Wir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778439874; c=relaxed/simple;
	bh=Ahehp0QI9D2BYQLFdFuB77DeVgSwNi1a7QbLB2ukxlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maoWHCWuDoEXwrZrTFaQ21tvsZ3AwYa8aeJL0GPA1f2m4UWtaWgSLYxyN8Zky9hlGbKhVw7+VMb7qcTixgXbojgtsv1ee3VDthyGMopoKobpjfHos1g73QZtZLDW76unarbiI64dHQjVjnQz6AiiybNNuyHyteLqgYULzLI4gHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlvLsY+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BF7C2BCB8;
	Sun, 10 May 2026 19:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778439874;
	bh=Ahehp0QI9D2BYQLFdFuB77DeVgSwNi1a7QbLB2ukxlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlvLsY+3/Uq3eRLE8yMYc3bbYRg+1O5xBNOOIk4eJGUhF7y19CKrsJppjFPVuXgL5
	 8hPWXwZK29J0IgRG64/i7DjmzufN1HC2grrK9R0c57aCOzWZ3SvDUIBYLrEGiKbQEy
	 585z75juuGO3jm+uhSQGdnp5OX+WLv+/DpoCW6LvJF/6gpOwA2FRLj7Cn5CthFzXo0
	 eSODanWU++vWnW5PwQ0UN2MddX+Rtt9o3Z2A2xnNcsNuGq/VCDW7nfHwUhWsFfdUKs
	 2NbLuGVCGu59I65Yp5gfyv01V0ISLGOk/xFpHoAv41aXxCxqol45EB1W1X8AjDsS9+
	 3ky4ZIhL1QsBg==
Date: Sun, 10 May 2026 20:04:28 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Christoph Paasch <cpaasch@openai.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Vlad Dogaru <vdogaru@nvidia.com>, Kees Cook <kees@kernel.org>,
	Alex Vesker <valex@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next 2/3] net/mlx5: HWS, Handle destroying table that
 has a miss table
Message-ID: <20260510190428.GY15617@horms.kernel.org>
References: <20260507173443.320465-1-tariqt@nvidia.com>
 <20260507173443.320465-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507173443.320465-3-tariqt@nvidia.com>
X-Rspamd-Queue-Id: 381C8505E16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20318-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 08:34:42PM +0300, Tariq Toukan wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> If a table has a miss table that was created by
> 'mlx5hws_table_set_default_miss' API function, its miss_tbl
> keeps the table that points to it in a list.
> If such table is deleted, we need to also remove it from the
> miss_tbl list, otherwise the node in miss_tbl list will contain
> garbage.
> 
> Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


