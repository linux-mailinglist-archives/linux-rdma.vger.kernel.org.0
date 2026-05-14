Return-Path: <linux-rdma+bounces-20732-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCVPM0cgBmpDewIAu9opvQ
	(envelope-from <linux-rdma+bounces-20732-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 21:19:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB9A5463B7
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 21:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7A4D3016ED3
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 19:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4FE3A7198;
	Thu, 14 May 2026 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6DIbQEG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C115639B94D;
	Thu, 14 May 2026 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786365; cv=none; b=AziavpTrKDX460Rh/YQzO83yqscJoh42SFD4efA/kMgAu48DJiL+c0c7FivHZR4m0jjPsmJBgocaCy4UpXjqmKWYm6dIUDOldNVlo5CrI6ZzPbZYm/UuZjq4gOobl1u/bGrrsVuM95yrobyO+lzB9Ql9nKaHctfOKhDiocJmW84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786365; c=relaxed/simple;
	bh=03wBdPzVqhOiMAr5bStesrdEHrdTtvRd2tO6+WrphDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfiE+Cqx0J6Y1gCFp1Wc4QRTeVn3pNCXjScBlryH8emFypuTmmEhKw658bPPWtjRV8Xw2MGF0nCfBq0UZUsNQmC5NghcjYUmS52BmdbV+xwkyFZoQJZq37YXLX4tsgvxzQqCQMPWTjN40pSAr5S+VLhHh1s5KRS4ld3ADLsCutw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6DIbQEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4734C2BCB7;
	Thu, 14 May 2026 19:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778786365;
	bh=03wBdPzVqhOiMAr5bStesrdEHrdTtvRd2tO6+WrphDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o6DIbQEGtF6ZTF7hG9nxXBGNMwLv+EzCYILY1Y1A5FCZ7FT0MNLXRjEkry8DluctH
	 WbZCvUaguhRy/Ov5mLAC77UrnNcrn66gHBmeaGUrsgfTPN/fzKaq81pgSF3zfDuyzM
	 Z0+cj/XP9QZvR7VUnxe7CdebcSa3KbqLOLLuwsB6n5DXGhRlqeB5STWlpeydMr2ySh
	 BuP2wXZfXBoVVdsK+kWdTZOGHYyExLN5f3J4DYJL6sdAI1dtdZlyTROSX3r68Vxu3k
	 odpRqQU7VJBnNG/jkogp5xj9QtPJ+zKB1q4LpjvTy105jpsggVeVtz4oxq/A0Snen0
	 8fxfnczmuSp/A==
Date: Thu, 14 May 2026 20:19:20 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Akiva Goldberger <agoldberger@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 1/8] net/mlx5: Use helper to parse host PF info
Message-ID: <20260514191920.GA15811@horms.kernel.org>
References: <20260510053448.326823-1-tariqt@nvidia.com>
 <20260510053448.326823-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510053448.326823-2-tariqt@nvidia.com>
X-Rspamd-Queue-Id: 5FB9A5463B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20732-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 08:34:41AM +0300, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Add a helper mlx5_esw_get_host_pf_info() to retrieve host PF data from
> the query_esw_functions command output, so callers no longer need to
> parse the layout to obtain the required information.
> 
> Convert all callers of mlx5_esw_query_functions() to use the new helper,
> preparing for upcoming support of the new op_mod that returns data in
> the network_function_params layout.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


