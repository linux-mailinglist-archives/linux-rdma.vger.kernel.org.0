Return-Path: <linux-rdma+bounces-20221-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH4FF+Ck/Wl0ggAAu9opvQ
	(envelope-from <linux-rdma+bounces-20221-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 10:54:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B04AC4F3EE7
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 10:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 664673037DCA
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64768378D95;
	Fri,  8 May 2026 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txiMh5cH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142330DEBA;
	Fri,  8 May 2026 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230400; cv=none; b=blE+x3sFWGrDogZQB/FSAFcC7pQEjPDzAKUHgl0NNvInwzx/qiflaTC1dpWVQBNZYjjBdz6//RK5HeHBaQFKoLVYC4AnrN84Yq4HMd+ansfo/q3fOThPRtGz/iQJYeFMK+lLwvwImmrd1nTZBcC8m6Wvs7Z29kr7BTWvvi6XN0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230400; c=relaxed/simple;
	bh=0Oc+nQErYflak7AM+05y0HqXVo7pIUyXWjUVlj9tC+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brSat/fEdgClyd3bcU1nglxyqMf8I7RYHGrtSL2CcyRMOkXiEStDO5b0Z6M/SxOpY2uHOtGTgQTsBv6kFX2Qvvwa4MQjU6a9O61i2Hmq06i4dwMbSQq0Ncj/XlVTFV58ZY2H0FLf3Pl4LfzEHSWk8LGlS/++NBcyFi8D/X2CgOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txiMh5cH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D707CC2BCB0;
	Fri,  8 May 2026 08:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778230399;
	bh=0Oc+nQErYflak7AM+05y0HqXVo7pIUyXWjUVlj9tC+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txiMh5cHWkzob08XqHJFpZGd6NpjHWMfELATGg5SAo0eZzhi3lFiVzgBi09ZFWbAO
	 MIiQg8QzRLcJB0KSu7dGa1sDXL3Qia6pMxP4+29xiRFcxZqbk3m47uEoC9RMxq9q7n
	 Q5ItaEL4AZ8GBbnjn5i6rwVefHZslhBFg/2Fi7HdtM2Ea34OkXhS1qUTKsWFM5xg1s
	 X2r7/U/zIp5nWET+vqdLVQbxv0hP8+Lh9UjkZgEXHT0UId9EzWHdC8P1hSgEHVUZM3
	 yzKD0zXvVWET04xmUWsoU3smXTsscuZVzYUZFVUC7c6b3utRZBdoNZZxgqqlyhEaDD
	 saOfNUQq5jiIQ==
Date: Fri, 8 May 2026 09:53:15 +0100
From: Simon Horman <horms@kernel.org>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net/mlx5: Fix HWS action unwind NULL dereference
Message-ID: <20260508085315.GK15617@horms.kernel.org>
References: <20260504220725.46686-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504220725.46686-1-prathameshdeshpande7@gmail.com>
X-Rspamd-Queue-Id: B04AC4F3EE7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20221-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 11:06:46PM +0100, Prathamesh Deshpande wrote:
> mlx5_fs_fte_get_hws_actions() stores some destination actions in
> fs_actions[] before checking whether action creation succeeded.
> 
> If creating a table-number or range destination action fails, or if
> fetching a sampler destination action fails, dest_action is NULL but
> num_fs_actions has already been incremented. The shared error path then
> calls mlx5_fs_destroy_fs_action(), which dereferences fs_action->action
> to get the HWS action type, causing a NULL pointer dereference while
> unwinding the original failure.
> 
> Track whether the current destination action needs fs_actions[] cleanup,
> but append it only after dest_action has been validated.
> 
> Fixes: 2ec6786ad0a6b ("net/mlx5: fs, add HWS fte API functions")
> Fixes: 32e658c84b6d ("net/mlx5: fs, add support for dest flow sampler HWS action")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


