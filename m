Return-Path: <linux-rdma+bounces-17883-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAPeJqM+sGmohQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17883-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 16:54:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE8825409E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 16:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A24B31DC5F2
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8877D3B0AD0;
	Tue, 10 Mar 2026 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE5zqna0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27133A7855;
	Tue, 10 Mar 2026 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157686; cv=none; b=ubI2ftC7yIOql4eJUSYHFaAadtTvZE9ZesTnIVI9tkm2GPtmLqGJ3P/x20oNImMlUKUgp1YYzZHDsO78zkusozKEm6FnZ9qQ0Pi7CuVe2e0ytVX+qz0JAG915Qd4xP6Y43q09j/I2qv7fyQ5iKBXaS1Vj1nTWZ6vLaoFTidkNes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157686; c=relaxed/simple;
	bh=Mdu07JbdQJBAS6Pv8AkQlWnH5S0xlv6Rm3oiXUNCQ/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ux69uWa9O8bC9EqTTjQGPHLx/1Dgbrk7PFGJamVhuE1R4H3jr5xkJ57B4a/5N95FVuh0FA7fdAPQxeZ4g0aeUuUtfuuc7Cl24YN0KjAYR8ELctwaJlMR9CjcXv9tuKJhI6cngaX1xSDu6hErX/Mn9VXany5lAIsql65qmpzHdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE5zqna0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F414AC19423;
	Tue, 10 Mar 2026 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773157686;
	bh=Mdu07JbdQJBAS6Pv8AkQlWnH5S0xlv6Rm3oiXUNCQ/w=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=VE5zqna0P5eCb1UcJvIiQ5Irnn/Qb/gIpHQO1xKXBtak+uLLGd5lXHstyERA67aDB
	 suz7y8GeERd1qvUdWkBnDcXMLVe58ykD1dbluFg8Gm1UhwJHHO6V4XtVHUHvGcCfPr
	 ZYDY48k7LzC99Bu+qJjI/W2wPrwKEBycm5BgdXcDyn6sqVJioofVtQfNmJi/WZfnAu
	 U7KPXdjEGcwBCInIdaUGHyPN6anRMGzTXCUbqc2hqeVLLf7EC1OcQPa9YcqvvYGGSZ
	 DsuqdPNozvGEbxdcL4ocW4qdNZf6ldm2IzIlVjVR87mivUDygCTUbBb4KRDpphLCHa
	 y4qkyCod4FnkA==
Message-ID: <1f12a15e-152f-4b64-961c-6542d343ec8d@kernel.org>
Date: Tue, 10 Mar 2026 09:48:05 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] RDMA/rxe: Support RDMA link creation and
 destruction per net namespace
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, shuah@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260310020519.101415-1-yanjun.zhu@linux.dev>
 <20260310020519.101415-4-yanjun.zhu@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260310020519.101415-4-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EEE8825409E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17883-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

On 3/9/26 8:05 PM, Zhu Yanjun wrote:
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
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


