Return-Path: <linux-rdma+bounces-17719-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDmSIVmbrWna4wEAu9opvQ
	(envelope-from <linux-rdma+bounces-17719-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 16:52:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAB8230F9F
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 16:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BD653013A80
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F335230BF67;
	Sun,  8 Mar 2026 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9O4nBCA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55FF2D739B;
	Sun,  8 Mar 2026 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772985170; cv=none; b=pDRel3/HGaG1ddZorPq79un0eKtAPawmytE1iQ2ytTmr763B91IXXyucxxJrvmgtEU2pNdA6toO0X9f6sHAz7DnbYjfQXjTMdRyAiT21GCqDJI7cwI0atUY+9WFvbujtjvKQFipapYfwaegpNhiNJ9Fn/mjA8Sa48Kh/zx0EyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772985170; c=relaxed/simple;
	bh=HzeZf0iBV2JdWtsPdth3nDVF1rfTM2c+32Za0k/ewIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LR3ZqNQgrQ+9Dpim82wuEoVS6qWvnKpkukn4Gcg6xt1pnPcnCypiRZdqtVIFRQB7dUAlhgre3deKvO2qa88mHDG9sLwHKSWHQg+vIV8tcT1+LwE+6FkL4sNNwhW0+Gv5/yyYThK523YfI5ZvlYMwIdqhgWbDJ+KRT6rOJ+XjXwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9O4nBCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87252C116C6;
	Sun,  8 Mar 2026 15:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772985170;
	bh=HzeZf0iBV2JdWtsPdth3nDVF1rfTM2c+32Za0k/ewIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H9O4nBCAgFpOcasrCuGKdBYp9LugiXTi4dt4sGsHS55HO1s3k6tyFxNGGxn0QX0us
	 9YaGOpA9mo4qXe1d7DM68dggxDD4lsMz3KehXgzgqOYQuaaXcxhDahhSDhAcuyCw1T
	 CH3joo7MS7erQpt0F1u4EGZzum126Zp+X96DpmP24J9xXpi9Fqvgc7xSBB1plWry5A
	 ResEE67OZNIq9WJsbsE9KiDXcKhmGTqOMiJ9JD87X+WHM6AEV9UclhunIyKx54akFe
	 T7tFMbJpnJEQWoSuHdxT/yxDlm+JI1uOznucWfq3LDNhWj80nXakXGvWtKJoi+XD8x
	 bgq6s3n2RKT+g==
Date: Sun, 8 Mar 2026 08:52:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Saeed Mahameed" <saeedm@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
 <shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: Re: [PATCH mlx5-next 8/8] {net/RDMA}/mlx5: Add LAG demux table API
 and vport demux rules
Message-ID: <20260308085248.2427feed@kernel.org>
In-Reply-To: <20260308065559.1837449-9-tariqt@nvidia.com>
References: <20260308065559.1837449-1-tariqt@nvidia.com>
	<20260308065559.1837449-9-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2DAB8230F9F
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
	TAGGED_FROM(0.00)[bounces-17719-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vhca.id:url]
X-Rspamd-Action: no action

On Sun, 8 Mar 2026 08:55:59 +0200 Tariq Toukan wrote:
> +struct mlx5_flow_handle *
> +mlx5_esw_lag_demux_rule_create(struct mlx5_eswitch *esw, u16 vport_num,
> +			       struct mlx5_flow_table *lag_ft)
> +{
> +	struct mlx5_flow_spec *spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
> +	struct mlx5_flow_destination dest = {};
> +	struct mlx5_flow_act flow_act = {};
> +	struct mlx5_flow_handle *ret;
> +	void *misc;
> +
> +	if (!spec)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (!mlx5_eswitch_vport_match_metadata_enabled(esw)) {
> +		kfree(spec);
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
> +	misc = MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
> +			    misc_parameters_2);
> +	MLX5_SET(fte_match_set_misc2, misc, metadata_reg_c_0,
> +		 mlx5_eswitch_get_vport_metadata_mask());
> +	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
> +
> +	misc = MLX5_ADDR_OF(fte_match_param, spec->match_value,
> +			    misc_parameters_2);
> +	MLX5_SET(fte_match_set_misc2, misc, metadata_reg_c_0,
> +		 mlx5_eswitch_get_vport_metadata_for_match(esw, vport_num));
> +
> +	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> +	dest.type = MLX5_FLOW_DESTINATION_TYPE_VHCA_RX;
> +	dest.vhca.id = MLX5_CAP_GEN(esw->dev, vhca_id);
> +
> +	ret = mlx5_add_flow_rules(lag_ft, spec, &flow_act, &dest, 1);
> +	kfree(spec);
> +	return ret;
> +}

drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:1512:12-13: WARNING kvmalloc is used to allocate this memory at line 1502
drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:1532:11-12: WARNING kvmalloc is used to allocate this memory at line 1502
-- 
pw-bot: cr

