Return-Path: <linux-rdma+bounces-17113-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFfVNfZ/nWk/QQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17113-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:39:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0CE1857FF
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69FE03050657
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CE82BD5B4;
	Tue, 24 Feb 2026 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLVIxSpb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7368136B042
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929584; cv=none; b=UM0OcnuWLlpOPF8MU14APkgyKXEgVMAa9xgJRo+kFWzCtXYE8CjeV3K1MyRjCggWBY0t/ktKvFsbBX4deXMYRXiol+eQrfafbdpAJ1w4FYcrAV46fH8q36t7ygAjTmhcVSrlDDp3rxVoAnM6RtTI3ODgLf8b3fOX4iioxqPrZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929584; c=relaxed/simple;
	bh=jzDoFB49aLaVRA1mq3b326d6d3BPvQTTzO9U6GkN518=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rWSQKxzDWaPxrMooglAOcu0V+G97I79cD4nkeQxRXUE+Lc2YrVymAE2+w2mKBpkwtL5yeYR2hemLizvLEYTXUiAY9teG++9vOMVJfNUyLFLz9jO5XgVszaqmDm17OCkgb/vTkPP2gLMgCRqPMrYygQNAsOtgSbYcwsLHKuzV7Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLVIxSpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26ECC116D0;
	Tue, 24 Feb 2026 10:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771929584;
	bh=jzDoFB49aLaVRA1mq3b326d6d3BPvQTTzO9U6GkN518=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vLVIxSpb8dQVVCt6oxJab7crpu6Aatw0q5tpLZVuK9eduMyW94tFmp7k8LDM9LvLf
	 4pg9xRO8KLDA1SIHeDXGrV30aKY/SBrzF455rI540Y1k6J2gOvkUe+eGGMwmbhVsev
	 nqMKlNwU1e85Fbj7eRtpa3rjZFdjUd4M/krJbV5EfzEYAiA+mrrdV/IvkYXNns305c
	 4KwnHih6dEsW2z5wAu1uMZptpjPZgk7/egg4wMuqFpS9/W1AMZDZ7X+Y4xS4OOlzM2
	 xWn57xXNkRj3iQr0OO0y0n9kgu4kDrXKIBxhlpgnZ8fhF/5VARygpBE396TwXxmmj3
	 vh1AT60njZ5Kg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <20260224003106.3172916-1-rdunlap@infradead.org>
References: <20260224003106.3172916-1-rdunlap@infradead.org>
Subject: Re: [PATCH] IB/cache: avoid kernel-doc warnings
Message-Id: <177192958105.751672.18109344018378101079.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 05:39:41 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17113-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E0CE1857FF
X-Rspamd-Action: no action


On Mon, 23 Feb 2026 16:31:06 -0800, Randy Dunlap wrote:
> Use the correct function parameters names to eliminate kernel-doc
> warnings:
> 
> Warning: include/rdma/ib_cache.h:47 function parameter 'device_handle'
>  not described in 'ib_get_cached_pkey'
> Warning: include/rdma/ib_cache.h:89 function parameter 'port_active'
>  not described in 'ib_get_cached_port_state'
> 
> [...]

Applied, thanks!

[1/1] IB/cache: avoid kernel-doc warnings
      https://git.kernel.org/rdma/rdma/c/2ecd012774bc23

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


