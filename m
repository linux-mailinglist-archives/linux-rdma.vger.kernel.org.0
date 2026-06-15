Return-Path: <linux-rdma+bounces-22234-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K9IgJKXyL2o3JgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22234-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 14:40:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E596864B8
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 14:40:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gzlLG8Ha;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22234-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22234-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE533080A43
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8323F484A;
	Mon, 15 Jun 2026 12:31:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE13F4834;
	Mon, 15 Jun 2026 12:30:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526666; cv=none; b=LhTW1LsH5AYE91qU8G5zOzn+tqq2uIk3nCHf8y8vUAiB5I7BNKeyVVEg707FZliQcGKYtAB4GFTqktUdWWsJZBccNK4hpK3Qu9ap2GP9WypHDqK6AmM1TIQPjwbk4PT+n2ZwHkZBzgJhGmMm8SAssn0tswXOllBdX46bJfil5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526666; c=relaxed/simple;
	bh=n6rVU8hZkAoVBUdjEyEiZj3byk7yaw6Ywu1ouXmXVIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpm3uBUtD2lykmcycMEvaot1DaaCJ2n7rA00Oe30zwptrhe0N/dPhSv72FeOXfM/J9faSo8eivNE3mX8B/ZmlXz4TmA29WBPa+JTOSkvSIlbJ7oeQdRjAdEHUAkUdoPurCAqqrYpmcPuwJf3jloxKsEp05txb9EFYX0ASTcatmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzlLG8Ha; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A001A1F0157E;
	Mon, 15 Jun 2026 12:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781526655;
	bh=bjUsrlAJzA2g2sG67p8ulOzileDSPaUvPy5l18Mliyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gzlLG8HabWMs4R8b2QuZkBDTDfN0eShe3CG5Bd4GqnDvqTseKV08S6lXIS0PWGUPw
	 Wz55HtTI1EQjOmkLcl3He9hOMhTrK1UFowD/laDWymB+DK759obCLWNJdo6iWZrcp2
	 6qsOImUqAdrdx4t7oiTty8hJwYJsLq2D9A0Fnn6VuOtnxv24JjF5oXvkttFdN3etcI
	 sugLR54CzIOjrqQXWigBP5G92qKouteZo2OXUIVusclHjRVfMR9FW8PA1wN0wbbbr/
	 2sXdtNHZptlAL7tlD5ra/2HZ3/4nPVa8FfDiobLZB21wGy7lUarc5j82wGOQnghLA5
	 JO/fNOg05FsbA==
Date: Mon, 15 Jun 2026 13:30:50 +0100
From: Simon Horman <horms@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Free steering tag data on release
Message-ID: <20260615123050.GJ712698@horms.kernel.org>
References: <20260613153725.1874-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613153725.1874-1-lirongqing@baidu.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22234-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:lirongqing@baidu.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,horms.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9E596864B8

On Sat, Jun 13, 2026 at 11:37:25PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> mlx5_st_alloc_index() allocates an mlx5_st_idx_data object for
> each new steering tag table index and stores it in the xarray.
> When the last user releases the index, mlx5_st_dealloc_index()
> removes the entry from the xarray but did not free the backing
> object, leaking memory.
> 
> Free idx_data after erasing the xarray entry once the refcount
> reaches zero.
> 
> Fixes: 888a7776f4fb0 ("net/mlx5: Add support for device steering tag")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


