Return-Path: <linux-rdma+bounces-17278-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OE6KvL7oGlXogQAu9opvQ
	(envelope-from <linux-rdma+bounces-17278-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 03:05:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D13691B1CF6
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 03:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DBB130093B2
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031DA2D2483;
	Fri, 27 Feb 2026 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgUl0Qej"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810326ED2A
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157933; cv=none; b=GXITYuxfEawP3YoZ7I7NzNtq6Cjo+yhR1CC9xonK1tetK2n7s+WI5f3d8K98c09mJyr0NruMNX4QjxutJWNhm5YzhsBQo4CQRU2+VejBlyy56y91jH1xJuBVGftkhKyB7fh2YUjhit13u+veOIK5JrYwYpB05LhDA/e1JwIfECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157933; c=relaxed/simple;
	bh=moNV7Ab9pajnMC5omM/0ELQKCQZiltYx6EIWnZkSRCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDzne7ZIevG/gWK4UrGtZ0gGrxHXitePKbBRX1F9Eel3h94AFDwbwm/kRgaVhF++f5BjWg6ht1pD+EVXJEKZ0480z7Q+Qddth/0Ki7ZCswA5UWont/vXt3yN09oy1E9TStrAMoBQnmb7LTIZDO6LWF6QoxazqyZvfn3ZYLld/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgUl0Qej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FC9C116C6;
	Fri, 27 Feb 2026 02:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157933;
	bh=moNV7Ab9pajnMC5omM/0ELQKCQZiltYx6EIWnZkSRCY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tgUl0Qej/URbYPmXwf2+X0NuXUc21wDiUz8cAHNc9pLSxz64s88vVs2wBmOSVB4uV
	 p4ZjLgLIvJLbH1JuaVdtxGlxLpuYStop5xzmuAzGuYH6EWkhSFSOzcyqCOsDmeyH3L
	 oacNZF4rIb+pqs9bkZ+1MwBXdpC0TIIWhI7tix/rgr0NiUTIAfto3Mlnk35H6vd+u7
	 ulI73MSyhWUnyh5tnUpP6AuoTd8eMbyfWPXmXHhfFBm+P/5DCWafmVzzzEOcJe4z47
	 5dM5TL6LCrW1buEvAHUylyKrLu6rgIq5aKiKHir9LtQFSwLANEynvl9r21EYRcxJzU
	 XKDIbu6prcbSg==
Message-ID: <c0887a43-f5ea-4e7b-8fb5-7322b76396a3@kernel.org>
Date: Thu, 26 Feb 2026 19:05:32 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/rxe: Add network namespace support
Content-Language: en-US
To: "yanjun.zhu" <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20260225172622.7589-1-dsahern@kernel.org>
 <e87e7871-d35e-4b91-a00f-1491ac5b6dab@linux.dev>
 <18ecbd06-baac-43ee-a455-6b34c716fdfe@kernel.org>
 <88b82e8b-40da-46cf-bb41-2c346bd28c70@linux.dev>
 <20260226064755.GA12611@unreal>
 <cfad2c5c-23a9-4034-ad71-2c1ea21ff597@linux.dev>
 <8ed32ed9-3931-4b2b-8f44-0023aa998b5c@kernel.org>
 <8098445a-c778-4b11-be88-6243aba98268@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <8098445a-c778-4b11-be88-6243aba98268@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17278-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D13691B1CF6
X-Rspamd-Action: no action

On 2/26/26 5:06 PM, yanjun.zhu wrote:
> 
> The patch link is: https://github.com/zhuyj/linux/tree/6.19-net-namespace

please send the patches; I cannot give comments to a github tree.

Scanning the patches, I think you have over complicated what needs to be
done.

1. socket lookups are not free. If the rxe module is going to own the
socket, let it own the socket. See my patch with the net_generic way of
retrieving the socket per namespace. <several patches later> Oh, you
also bring in net_generic, so why make this so complicated?

2. current code creates the socket for init_net at module load time. My
patch changes it to first rxe link create and then leaves it enabled
until the namespace is deleted. Why? Well, any solution trying to track
how many devices are in the namespace is overly complicated.  If an rxe
is created once what are the odds it will be created again? This is a
very specific type of workload. Besides, it makes the code very simple.
I bet this is why my patch fails any test cases you have.


