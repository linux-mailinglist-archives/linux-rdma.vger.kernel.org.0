Return-Path: <linux-rdma+bounces-19069-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id edgdN45b1GlrtQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19069-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 03:19:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C20CF3A8A60
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 03:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 180B1300ACB8
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 01:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEAA1F1534;
	Tue,  7 Apr 2026 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQsTiFiX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3AA1AAE17;
	Tue,  7 Apr 2026 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524747; cv=none; b=dDgqJGdHfENMIrb5MrPRAMR6koYhONdzgHrbVmLhWuXUJFwG6AxvfQzU+rRNgU52JQdnckw0FG/B4gjlaDkA1Sj9eLMAAx2YJzoXyBnOZQahcp48GKylIt8PV2iV2pgzrIrO8YXxlqCahS+himBA3P0IhONbtK7dqdM7faBCwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524747; c=relaxed/simple;
	bh=7pRZlUGhH6jAxJA84NlqKbWQd/to3feeYUT3bgBqYHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLzPjz1ZflHNPiv2d6hpVP/NImCDDRuV3p8J92OHwMxfAPnpyGoBxhogjHQEKesKlROALiNbJsQPNQWKvWG8VZmTLXd8hh3Tl4naqO4HwJmbDyaXiS4hDyY6Pe3I6yWDdSBYJzYzs7g1TbxYchWF2ILjgCFCELkV3uEv2e1rGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQsTiFiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B666C4CEF7;
	Tue,  7 Apr 2026 01:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775524747;
	bh=7pRZlUGhH6jAxJA84NlqKbWQd/to3feeYUT3bgBqYHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQsTiFiXa2J6iXfmK1k5HuTsGc1VOzZo5QD1GSFzjCdOAGdI7jTOfjHSbNGgjJFKb
	 4GztNM4ai2ie9fwAVbqkSCvpCWajq8rIFWMDIrWHqRRPoPGJL5o9ValaRhx/CSDvb1
	 N+HhG/noO9V3BQYV7d9tyRB/ZZQQT3f6vcpZcnqkZ7ObAI642bV5T7qodAK3z/9rl3
	 J9TpT+12gNLuSD9WbOdeHr0diLZIp9KwW8mqrbyY2juSHN76zQ5TSXHYztHGy9CZoE
	 6Bnos9GTTSmGYufe1p+hA6WGeVTgw0xhPvw3r0HnVUl2/gCCYLMdSLiT+n44W2MGjV
	 aY/8Z2sseKk0A==
From: Jakub Kicinski <kuba@kernel.org>
To: achender@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	rds-devel@oss.oracle.com,
	edumazet@google.com,
	linux-rdma@vger.kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] net/rds: Optimize rds_ib_laddr_check
Date: Mon,  6 Apr 2026 18:19:00 -0700
Message-ID: <20260407011900.3596320-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405041613.309958-2-achender@kernel.org>
References: <20260405041613.309958-2-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19069-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C20CF3A8A60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/rds: Optimize rds_ib_laddr_check

This patch optimizes rds_ib_laddr_check() to avoid excessive
rdma_bind_addr() calls by checking if an address has been used before.
It renames the original function to rds_ib_laddr_check_cm() and
introduces a new wrapper that first checks rds_ib_get_device() before
falling back to the CM-based check.

> diff --git a/net/rds/ib.c b/net/rds/ib.c
> index ac6affa33ce7..73e01984ee9a 100644
> --- a/net/rds/ib.c
> +++ b/net/rds/ib.c
> @@ -401,8 +401,8 @@ static void rds6_ib_ic_info(struct socket *sock, unsigned int len,
>   * allowed to influence which paths have priority.  We could call userspace
>   * asserting this policy "routing".
>   */
> -static int rds_ib_laddr_check(struct net *net, const struct in6_addr *addr,
> -			      __u32 scope_id)
> +static int rds_ib_laddr_check_cm(struct net *net, const struct in6_addr *addr,
> +				 __u32 scope_id)
>  {
>  	int ret;
>  	struct rdma_cm_id *cm_id;

[ ... ]

> @@ -487,6 +487,20 @@ static int rds_ib_laddr_check(struct net *net, const struct in6_addr *addr,
>  	return ret;
>  }
>
> +static int rds_ib_laddr_check(struct net *net, const struct in6_addr *addr,
> +			      __u32 scope_id)
> +{
> +	struct rds_ib_device *rds_ibdev = rds_ib_get_device(addr->s6_addr32[3]);
> +
> +	if (rds_ibdev) {
> +		rds_ib_dev_put(rds_ibdev);
> +
> +		return 0;
> +	}
> +
> +	return rds_ib_laddr_check_cm(net, addr, scope_id);
> +}
> +

Can this code handle pure IPv6 addresses correctly? The function extracts
addr->s6_addr32[3] and passes it to rds_ib_get_device(), which looks up
devices by IPv4 address.

For IPv4-mapped IPv6 addresses, addr->s6_addr32[3] contains the IPv4
address. But for pure IPv6 addresses (when CONFIG_IPV6 is enabled),
addr->s6_addr32[3] contains the last 32 bits of the IPv6 address, which
could accidentally match a stored IPv4 address.

When this collision occurs, the function returns 0 (success) without
calling rds_ib_laddr_check_cm(), which performs the full validation
including rdma_bind_addr() and IPv6 link-local scope_id checks. This
means a pure IPv6 address could be incorrectly accepted as valid for IB
transport.

Should this be guarded with an ipv6_addr_v4mapped(addr) check? For
example:

    if (ipv6_addr_v4mapped(addr)) {
        rds_ibdev = rds_ib_get_device(addr->s6_addr32[3]);
        ...
    }

The existing callers of rds_ib_get_device (rds_ib_get_mr,
rds_ib_update_ipaddr) operate in post-connection contexts where the
address type is already validated, but rds_ib_laddr_check is the
validation gate called during bind/transport-selection for any address
type.

>  static void rds_ib_unregister_client(void)
>  {
>  	ib_unregister_client(&rds_ib_client);

[ ... ]
-- 
pw-bot: cr

