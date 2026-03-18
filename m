Return-Path: <linux-rdma+bounces-18339-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO9+D4DEumkNbwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18339-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:28:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DB32BE2D9
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A03DA300D17A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C83E3DEAD0;
	Wed, 18 Mar 2026 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxSrfrc4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041823B19CE;
	Wed, 18 Mar 2026 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847676; cv=none; b=I1UfbIR5LuecNwoO9+zZ7icgDsbd4OG6W6AWwaSmQveJuRMJLqoLPtEZ1X+JnYKhIuBzQKxK9KySuAei34lRkdxWhW2zH91eKbC/oOQvtXbcFKr+iQ0Qxi7clNeBBWfUv68mrhkhci2ttkXisJQG9fpZYFTvKwxvbB9yGciCjRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847676; c=relaxed/simple;
	bh=xYwT38Ow/A3np5f840+TVPKUu5ff7b4db3s9FCASpD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffeFnYBAE2z8FVv8/ddjUeDNeLtc9UpQDWd2mabrbdr1wAEgfK5jwdwu78AeU+0URbUepmU0VXmddS/Pqy8rRnRhxuzzOBeA66Tqr8xDetHiutoI5m5BmBm96ckOsMd2RB/v2/BFQmAkk6Tqq2wanKCbDVRCIsWPX7LuG/b+EN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxSrfrc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A78FC19421;
	Wed, 18 Mar 2026 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773847675;
	bh=xYwT38Ow/A3np5f840+TVPKUu5ff7b4db3s9FCASpD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxSrfrc4lL0AbgBzcupyRzdGjYOR+gn+toV/zxwxCpFsEAy/lbFGLfGOBpPWHkSDs
	 tuQokcNAh+JIephWchqus7hSaWm5YXfvH0wAvNhTRmMA+8WS+AnZlW+OGsUPpHML1a
	 /yBewVCbw/Bkr9+75peBls2XRefr3igpIV/QvXZoF6CRu5lLykCPRtkIR/7n8DWJAZ
	 FS+6+cKW7BBX8fiqJRALeDGJrLw1NMqXABkv/VVRmb0ZyOU44LmFHhujeCjxbd5yGe
	 CimMbpLOSoFKnYgMLAvHjTdK7p/92bnKOjRN1gTKTbiybB4MnxZ4OWB38mGBwqxZXv
	 RuTGVTKRcuG+g==
Date: Wed, 18 Mar 2026 15:27:49 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>
Subject: Re: [PATCH net-next 0/2] net/mlx5: Support PTM on ARM architecture
Message-ID: <20260318152749.GE1753385@horms.kernel.org>
References: <20260316133607.8738-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316133607.8738-1-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18339-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4DB32BE2D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 03:36:05PM +0200, Tariq Toukan wrote:
> Hi,
> 
> This series by Carolina refactors mlx5 crosststamp initialization and
> enables cross-timestamp support on ARM.
> 
> Regards,
> Tariq
> 
> Carolina Jubran (2):
>   net/mlx5: Move crosststamp setup into helper function
>   net/mlx5: Support cross-timestamping on ARM architectures

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>


