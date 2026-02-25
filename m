Return-Path: <linux-rdma+bounces-17184-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HfaEJdEn2m5ZgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17184-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 19:51:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9838019C70B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 19:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 302C43034B04
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 18:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869F83D6688;
	Wed, 25 Feb 2026 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2VUQhMy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F8313E17
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045429; cv=none; b=A/pFuSUv8ML7lnkFhRzGaeh+D5FovlfffCK65r8L1fKNKyOOis7W6v+AlEEdwUAZwAoRIoO8/ojFJ319e3W04tUkCfsm8h+Kff6HRFTPvX+5xayQ+wZX8wNkffx+ZGKj+cMx1R7MBaQt0BsdSJq+Q89KoprQ1AZE8883tbcknMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045429; c=relaxed/simple;
	bh=Bc7QDZIxQQ3Q17TLO6F3tRbLkrGwoQY/sssRSkkuVWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6Dd+i4cl8sSSB4xlRRBMXOXd1W1q+3D6VhdU8HXapZQgEBHZKPE5FcA+drq8L81SLJi5Uf7lJXZEWWIcA9WU+9gDbnCesBIESqDbhMhz2IHC+A2ufUyPSt5KezX/AK18sH5Flv5U9HsDr3qBlMm12pRLYAEMdaVU3UO3WcYyvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2VUQhMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC245C116D0;
	Wed, 25 Feb 2026 18:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772045428;
	bh=Bc7QDZIxQQ3Q17TLO6F3tRbLkrGwoQY/sssRSkkuVWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f2VUQhMy2iMfKAuklpO69WCTuYQcL9SrC+0SCOXtZnMEg0dSm05SpnaynmTm/hntY
	 tdYGHC7ke3islo3dbEimGXnwxPXtK9S+8/BXul4Cwqb7Pi40S0laaVaftvoi+umCf+
	 UD2kQJwo1lU9yxYsC6OSgnzEwbHUnEhzq6bEFg8YP5bYrQk36+wmYclZSXwITghCau
	 4IMLRX12+znlGUZGKG7qZOyXbtKtCbPDGetpo+Htd8bUDSILIE0QB4X/jwLXHmgmmT
	 AAp06gGJ9Jj1CbsYenc3JGoHm0jpqDEgMTJ79Dzj+KWu733nJo6ecuL+8WqBrw2LzG
	 KFs5fkU4u6DgQ==
Message-ID: <18ecbd06-baac-43ee-a455-6b34c716fdfe@kernel.org>
Date: Wed, 25 Feb 2026 11:50:27 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/rxe: Add network namespace support
Content-Language: en-US
To: "yanjun.zhu" <yanjun.zhu@linux.dev>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org
Cc: linux-rdma@vger.kernel.org
References: <20260225172622.7589-1-dsahern@kernel.org>
 <e87e7871-d35e-4b91-a00f-1491ac5b6dab@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <e87e7871-d35e-4b91-a00f-1491ac5b6dab@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,ziepe.ca,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17184-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9838019C70B
X-Rspamd-Action: no action

On 2/25/26 11:14 AM, yanjun.zhu wrote:
> On 2/25/26 9:26 AM, David Ahern wrote:
>> Allow rxe to work across network namespaces by making the sockets
>> per namespace using net_generic. Defer socket initialization until
>> a device is created in the namespace.
> 
> https://github.com/zhuyj/linux/tree/upstream/6.14-net-namespace
> 
> Do you make tests with the above link?

no. I had no knowledge of that branch until this moment. It is almost 12
months old, so not sure the relevance if it is not being actively fixed
on top of tree.

> 
> Compared with the net namespace in the above link, what is the
> difference between this commit and the above link?
> 

no idea. This patch was in our tree at enfabrica dating back to 2021.
Someone started looking into automated tests with rxe, so I pulled it
from the tree, rebased to 7.0 and sent it out.


