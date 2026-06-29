Return-Path: <linux-rdma+bounces-22771-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CDxND4tjSmrkCAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22771-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:00:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8994F70A30C
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:00:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Gg3gPeZn;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22771-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22771-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB8E7300D44C
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E7937DE9D;
	Sun,  5 Jul 2026 14:00:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E2437883E;
	Sun,  5 Jul 2026 14:00:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260038; cv=none; b=ggZUlrAj/McqlvK9KTGyEPEUgN2r6ijVLncMPQOlzRETMDuczaJTZ+FnYfsQ/bGwVA56aEvYac1dk+EiG1G1uyaAOQ7YJDz5TnEAzPP5xR8LIeqPCfbq2vdhOESqbkGityOnggxX+1EuvpZ0Rh+a1Ve6DSEHNVyEeFrOjcjNoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260038; c=relaxed/simple;
	bh=png50S20ShN43oQFZ0KFX6+JBP2QoOZjdSEZIbE7nGc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=boGTKIul6O6bwG0oMuGOWmq0vGnqZd8EEAlBdtqyaAnrCAWN7bX4XTz0ZvOCmT1xldpcilDzuOyuXP5rNFxrB3S2/nfk2T8l9vjoEUxH31bVSnFmlJMQEuR2RVUQBMORlhJq3MZML6juOzoTbLTEp/7nZvaUXaTFhE++40rw0s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg3gPeZn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262AB1F000E9;
	Sun,  5 Jul 2026 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260036;
	bh=5uxf4qWbZxrE+bclyeo+X4WWa+BNtCzdTw3O82BRkVg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Gg3gPeZnv+nztE73c3L1kKLTkcDrfYYajG6/oBuEmNSbAA675tFKtLbraQxpXioYL
	 DDrq4KywljsnuF8lvsR6ptsUlvT683TOVPDlYuWQqRfZl6leGMszYEXRYgusGVS+RT
	 MFn4jWKS+wd+Rdww+MNy2VCCCgzqrJUVR8a/uejK7Vbi6VzL/i3SX669H0nHTkAgIN
	 SLwmJMT+1gDytydeE1z0MnbANUTzPOhj6RR9hEkox3edHHF7OfdFCCW7eft0MJQsEU
	 b6zjdv0lxWq7SCtcckyji1vl8w/Vo4T6aobJ4w4RU/QavZcxliKwHcxRj9Xt+7Sk86
	 sDgP7dJFHpmgw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Michael Bommarito <michael.bommarito@gmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Vlad Dumitrescu <vdumitrescu@nvidia.com>, 
 Or Har-Toov <ohartoov@nvidia.com>, Bob Pearson <rpearsonhpe@gmail.com>, 
 Sean Hefty <shefty@nvidia.com>, Kees Cook <kees@kernel.org>
In-Reply-To: <3170ff3bc389a930bb1641f2caa394a0b2241579.1780774907.git.michael.bommarito@gmail.com>
References: <3170ff3bc389a930bb1641f2caa394a0b2241579.1780774907.git.michael.bommarito@gmail.com>
Subject: Re: [PATCH v3] IB/mad: drop unmatched RMPP responses before
 reassembly
Message-Id: <178273508232.133362.14163993593921420714.b4-ty@kernel.org>
Date: Mon, 29 Jun 2026 08:11:22 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DATE_IN_PAST(1.00)[145];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22771-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:michael.bommarito@gmail.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:vdumitrescu@nvidia.com,m:ohartoov@nvidia.com,m:rpearsonhpe@gmail.com,m:shefty@nvidia.com,m:kees@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8994F70A30C


On Sat, 06 Jun 2026 16:01:55 -0400, Michael Bommarito wrote:
> Kernel-handled RMPP receive processing starts reassembly for active
> DATA responses before the response is matched to an outstanding send.
> The normal match happens later, after ib_process_rmpp_recv_wc() has
> either assembled a complete message or consumed the segment.
> 
> That ordering lets an unsolicited response that routes to a kernel
> RMPP agent by the high TID bits allocate or extend RMPP receive state
> before the full TID and source address are checked against a real
> request. A reordered burst can therefore reach the receive-side
> insertion path even though the response would not match any send.
> 
> [...]

Applied, thanks!

[1/1] IB/mad: drop unmatched RMPP responses before reassembly
      https://git.kernel.org/rdma/rdma/c/d2e52d610b9b09

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


