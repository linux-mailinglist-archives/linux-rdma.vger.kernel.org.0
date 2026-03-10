Return-Path: <linux-rdma+bounces-17901-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAkELLZqsGmNjAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17901-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 20:02:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D5256CB2
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 20:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C5FB305D499
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 19:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1638D3CA4B9;
	Tue, 10 Mar 2026 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnrqwmFF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE93C8727;
	Tue, 10 Mar 2026 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169303; cv=none; b=lbLtxjlwwtLs7khMnPQkzbqohgtg4UFuS4YPC1NmHIX03B8uLgjENhnp5rV8/py+iUaRAn1g5GxdZEXYGw0pOljm9qwAAuL7wl1fZCfuv97GdbUj5gx6uFIiTlLjEV3QsKMG4IEOqovK4ixdHr8N78CLsUm6mIYlAXublkWb8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169303; c=relaxed/simple;
	bh=ihzR0EfXuDfyZL7nE22W9lb62r6Y6+GR2FtvUDNNL/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+2mYGpiqZ39iB4iqRxAztmYm07lFtlNZ31X1Y31EsYcClm9vy8UutWZG4IAzwxJJDC9l/Gzu4dtL2k46u1yNxSIBsYjoMbbpv3kWzvm98gQr2We3cU32GHNCudIyJ8wB4n1JelwPU7MjRDY5W0Z2ez+GRyUQ4DHY7LgoONrQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnrqwmFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A47FC2BC87;
	Tue, 10 Mar 2026 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773169303;
	bh=ihzR0EfXuDfyZL7nE22W9lb62r6Y6+GR2FtvUDNNL/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tnrqwmFFST15C80fvpsNWGfxIbxzaDk/Z7rvn6b+temFLR8TrgqktsiOiluqCNqvr
	 ICiHwB1nb2cOe2EJ8rB8+tgtpJjsn+mhQOoQEdK4ZmsI9JT/CEu0Ha8QTMv4cRm5CY
	 ahdJMoETlPGW62OAVPQ7uQERI7QhOS5FfHgJ5ongNPIZuLJYdrEBefAnm2MmWf4fE4
	 PZOsvxMuS7wFA9rU0pWaQT4deQuPgJiH9l84WmKO9VN6UBzo5U2YLyvF9UvA47N4UF
	 rlAen6HrqG1rPqrUEwJujCl254eLFSOTA6I9U0sJnMv881jhdVtWiczct8L308ay+0
	 HDO0lD7YfppYA==
Date: Tue, 10 Mar 2026 21:01:40 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: jgg@ziepe.ca, zyjzyj2000@gmail.com, shuah@kernel.org,
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH v5 1/4] RDMA/nldev: Add dellink function pointer
Message-ID: <20260310190140.GL12611@unreal>
References: <20260310020519.101415-1-yanjun.zhu@linux.dev>
 <20260310020519.101415-2-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310020519.101415-2-yanjun.zhu@linux.dev>
X-Rspamd-Queue-Id: 8E2D5256CB2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17901-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 03:05:15AM +0100, Zhu Yanjun wrote:
> The newlink function pointer is added. And the sock listening on port 4791
> is added in the newlink function. So the dellink function is needed to
> remove the sock.

It is an RXE‑specific description, but you are adding code to the general
nldev path. Please clarify that this behavior applies only to RXE, and
include examples showing when and how it is invoked. In particular, explain
how the socket is cleaned up if delink is not called.

Thanks.

