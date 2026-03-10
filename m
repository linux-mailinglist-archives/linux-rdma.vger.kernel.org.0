Return-Path: <linux-rdma+bounces-17899-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ExXH7JpsGmNjAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17899-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 19:57:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF7E256BE6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 19:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C18863087E0D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1103BD65D;
	Tue, 10 Mar 2026 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhNqkqHB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79334346776;
	Tue, 10 Mar 2026 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169068; cv=none; b=llkI7a2izb32PIbBa5va0/FUSIA4scbF96Oxi0y2qGfGoOIsrZq6+wa8W6LRqboUB23VmdETCHK6c5sFjUwnZTabWYYCUEeHIHpOVNMU+v7E9Mx4IVJNX2LTug8tZx/bbGyZqBjtTuAo/AIHQ2UbCJKB9sNLl2zkfBTXdTMHmr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169068; c=relaxed/simple;
	bh=QKDa00Qt22eYvkpAbCeFEb1rDnsZqgCwq5V7QS1bUqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+l9K0qG4QnERwJz30BamnWSIk6eU7X4Ye76E8HiuOIHBLT6FvwXT5hxbDzl0hHrQLugO/P6U8WXAfFASpa+cuGOVcUdyafZMdDm4f5yD6Dq2L4rHHrj6HeiT0iC4Wh78ynVoqgzsQSAwkEfKXoWw13Oc0aOqOHCFc3+FCQbOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhNqkqHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD5BC19423;
	Tue, 10 Mar 2026 18:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773169068;
	bh=QKDa00Qt22eYvkpAbCeFEb1rDnsZqgCwq5V7QS1bUqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhNqkqHBwcv342b5nb2h2w0XOpLsKYAG9XYIg0KRItiv/ZLPL5yBrY2jsMqcp/mWD
	 5Rv04WIAPiRPeCFIS2kGvf2CiH6Ku8XtxN9RCFTcMXvuMWheNGFsY40JvqOKO72MaB
	 xKCPeEk0cUaCtclp3xXe29gjGwvo5/yybPq5MOdr/jHvTc376/+obaFqs+xdbnzZ69
	 HLGXm0/hqWD6/0iY66cJ3YChTJu/pqUxLAN7XuhQw90gZZVNGs4rvI4v8c9i6dqlBB
	 +L0UITZl4EChyZjN3klsN6UIvJmc0p4aJCOwtvYFVG7uAEQWWOn/XUWeDkjAcd72A4
	 YTzZ4upWyeQug==
Date: Tue, 10 Mar 2026 20:57:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: jgg@ziepe.ca, zyjzyj2000@gmail.com, shuah@kernel.org,
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH v5 3/4] RDMA/rxe: Support RDMA link creation and
 destruction per net namespace
Message-ID: <20260310185744.GK12611@unreal>
References: <20260310020519.101415-1-yanjun.zhu@linux.dev>
 <20260310020519.101415-4-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310020519.101415-4-yanjun.zhu@linux.dev>
X-Rspamd-Queue-Id: EEF7E256BE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17899-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 03:05:17AM +0100, Zhu Yanjun wrote:
> After introducing dellink handling and per-net namespace management
> for IPv4 and IPv6 sockets, extend rxe to create and destroy RDMA links
> within each network namespace.
> 
> With this change, RDMA links can be instantiated both in init_net and
> in other network namespaces. The lifecycle of the RDMA link is now tied
> to the corresponding namespace and is properly cleaned up when the
> namespace or link is removed.
> 
> This ensures rxe behaves correctly in multi-namespace environments and
> keeps socket and RDMA link resources consistent across namespace
> creation and teardown.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe.c     |  38 +++++++-
>  drivers/infiniband/sw/rxe/rxe_net.c | 145 +++++++++++++++++++++-------
>  drivers/infiniband/sw/rxe/rxe_net.h |   9 +-
>  3 files changed, 146 insertions(+), 46 deletions(-)

<...>

> +#define SK_REF_FOR_TUNNEL	2

<...>

> +#undef SK_REF_FOR_TUNNEL

We typically place defines at the beginning of a file and avoid undefining
them. The undef directive is mainly used when a macro is defined inside a
function.

Thanks

