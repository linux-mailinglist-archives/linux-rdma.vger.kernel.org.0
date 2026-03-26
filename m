Return-Path: <linux-rdma+bounces-18699-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPKWHnP/xGkz5gQAu9opvQ
	(envelope-from <linux-rdma+bounces-18699-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 10:42:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B9F3327E1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 10:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6CA03122063
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A1734B425;
	Thu, 26 Mar 2026 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="fdMqbocP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9427346E68;
	Thu, 26 Mar 2026 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517588; cv=none; b=Zo7uzO5ltOX3LHcjTEXEgGjyOtUNIxQS7ndeWQkjgXSGY8c4LBHRycThD8DI0o4bJ8K5v5r6hXb+k5oXG3KeMpfWnrpR5HuHHi7Befcg2nK+5qdvTaCM8sueyrFdFLR0cToEJ/e1ujlmFDZ2ElcV7o3i+ZIlbQfzMP3oZWnRIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517588; c=relaxed/simple;
	bh=lr+fL1xZKdJvJ+cIO01kA3TTYfyVOiqIfSGhQyVjGKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSjC3ZisnrBbxT2ArjQbBMi9T+I+eKTxtnQiRIenv6fu1guK/zMvpzcIYHgYNBDYTg9EKl0JD3DtesiNjLumCcmI2Id5ch7E04nME6NL6Q+D902Xvoau7lYtTF9JcJNVA50x4abKcaj36b8Scl8e3HGG9ieWJTuPoWC7bejsyLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fdMqbocP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=Z0WUXCv4keO15fOq2l2m6s3jGy09mN43/z1icMRS0wY=; b=fdMqbocPxjGNnT5Ya5fGprjYIh
	Hat0N0TO/7vRh3HaWvtE3QMCwmYzBJy8kcaPkVz44Fg4Vmb4JN4O6SP8YgN2YPU+YxwbymKEiJlJk
	KDNcZpg+GubLqZSUb11th+uLQM2c5aFg3vftBlC3MCLbQ8wL6wnRnvLnJNDDR+SngKaF/zuy1LXs0
	+3yMAD6VbfEsSokXz7Wu7jzPAkQQe51VFyeNCzMarAu/NnknLIkpuGGxDg4TLK1lADrobVDjxZ5dL
	oBZVVBNsMqAFBSIbxV9nlirP+JUnn7t0vJQFj2xzg8Nhs7C7iBlcOIqT+JI3RMl7vcgKqG5pHGMF7
	7sWWC3LQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w5h5J-009kkg-25; Thu, 26 Mar 2026 09:33:01 +0000
Date: Thu, 26 Mar 2026 02:32:54 -0700
From: Breno Leitao <leitao@debian.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Naveen Mamindlapalli <naveenm@marvell.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Danielle Ratson <danieller@nvidia.com>, Hariprasad Kelam <hkelam@marvell.com>, 
	Ido Schimmel <idosch@nvidia.com>, Kory Maincent <kory.maincent@bootlin.com>, 
	Leon Romanovsky <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2 09/12] selftests: drv-net: Add MAC loopback
 netdevsim test
Message-ID: <acT8O5vHc7gl6hzG@gmail.com>
References: <20260325145022.2607545-1-bjorn@kernel.org>
 <20260325145022.2607545-10-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325145022.2607545-10-bjorn@kernel.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18699-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,marvell.com,redhat.com,nvidia.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38B9F3327E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 03:50:16PM +0100, Björn Töpel wrote:

> +def _dfs_write_u32(cfg, path, val):
> +    with open(os.path.join(_nsim_dfs_path(cfg), path), "w",
> +              encoding="utf-8") as f:
> +        f.write(str(val))

This function doesn't seem to be called, right?

> +def main() -> None:
> +    """Run netdevsim loopback tests."""
> +    with NetDrvEnv(__file__) as cfg:
> +        cfg.ethnl = EthtoolFamily()

Given some functions above assume this is nsim, should you call
cfg.require_nsim() ?

Reviewed-by: Breno Leitao <leitao@debian.org>

