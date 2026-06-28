Return-Path: <linux-rdma+bounces-22546-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i+sOAGpYQWqDnwkAu9opvQ
	(envelope-from <linux-rdma+bounces-22546-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 19:22:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 895AD6D487B
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 19:22:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cr0X8ppC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22546-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22546-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88D6C301050C
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBE72F5A13;
	Sun, 28 Jun 2026 17:22:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB0175A6C;
	Sun, 28 Jun 2026 17:22:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782667340; cv=none; b=j8lYYoa021aNWPcCba681QQy6vACHpg9RGUDb7To3RjXkJ0ctCIe0cKk11OQYHm8u5Kn9nuLnHmo00I1T36tHkDFcSClVz4i+Pwv92W0dQBEtbjAH2sblycCJ8ZkS+gw28y/ZO+LOwiFYIYXM/SDjWv6hghU0AVH4g02hxXazlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782667340; c=relaxed/simple;
	bh=wKlPAafFqFummURaBmMXBeD44pSJYZ07Qs2NOWGYKwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtXZH4IMxNsg1sgQzCXDCxNSUUN2DemxUvOKUAQKwv43vEYXjh02XN+fnm8sXJ+ZNAgJIg9gIqjgKLgOp5oZQ7XvirVn8HM75JG0fUwPEnRh2JqFSd6Osq3ccuabc5ptYMl49PYyU72EH15mMEDl+EJrOCC8AVhNazVjSbMsIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr0X8ppC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF911F000E9;
	Sun, 28 Jun 2026 17:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782667339;
	bh=X3LfRdMyXIWUfkeMbzMyrJa/f52GFOdYugzYTIgol+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cr0X8ppC+FnMQSEdWSWCFAYoPjoiiTL1sfxed+hcPeERSHDfOJewwLw1fmTAfv4wG
	 Lei+sYzQXl198vYiMa8aEd0lSlR6R16sZ5E+6oND+zqdNrttMTzgeOgDaq9OnqPj+Y
	 J2VmTQtBH00WjOEQ+TuL0ercrrv8OhH0z2uatJcKkvLcmDJ204Fr6AJGofegKtWDQ0
	 NUz+8PGGqMc83PlBoziuHXibVn5ee/VaAdFc3v+b+Y29c/q0nvUaLNEjXWHdiKkeDT
	 hOz2Jjclsc//5WS0vDAUceNNRUekZzSrCvuRPn4Jm5lomdlSrohUtUlcJHvr2/pLKE
	 S6aqR897z0mjA==
Message-ID: <4d98d9a3-07e1-4333-b040-c72e5f561a63@kernel.org>
Date: Sun, 28 Jun 2026 11:22:18 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3] rdma: display resource limits in
 curr/max format
Content-Language: en-US
To: Tao Cui <cui.tao@linux.dev>, leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
References: <20260615005315.169582-1-cui.tao@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260615005315.169582-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22546-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 895AD6D487B

On 6/14/26 6:53 PM, Tao Cui wrote:
> diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
> index 4356ec4a..e5b8b065 100644
> --- a/rdma/include/uapi/rdma/rdma_netlink.h
> +++ b/rdma/include/uapi/rdma/rdma_netlink.h
> @@ -604,6 +604,11 @@ enum rdma_nldev_attr {
>  	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
>  	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,	/* u64 */
>  
> +	/*
> +	 * Resource summary entry maximum value.
> +	 */
> +	RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX,		/* u64 */

I do not see this uapi in Linus' tree. What is the status of the kernel
commit? Put a reference to the kernel patches in the commit message.


