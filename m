Return-Path: <linux-rdma+bounces-18246-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CwzCog1uWmcvAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18246-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 12:05:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FE12A8740
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 12:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A1FC3010725
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4831B3A6B91;
	Tue, 17 Mar 2026 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvGiKRON"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5383587A2
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745473; cv=none; b=Y8jxOt5I0WzrnA04GP4gwamhXn7ZUmBrvLhN863x2LdCYJTSNOKnnWq1ZyQvZiRmQ8QpyQ+D+Hd/AXEEx98sq4UujlFdGJTy5mLWyoZXG2NvkPDk5mpkyYDLuj+zFNE0KY/V4RFxR6MA5W/LBn6AT5klLbphRrXFIla7y5T5vDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745473; c=relaxed/simple;
	bh=P0tLbS2Ykxw7VPCP1RVLuN4ErZPx4T42O91htQzqL3I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=myTP4CN2TREjZ6fnVLSK93TKz2SEvUlMA+fVOdWGbGAwSRKRom/GyDKHwhzw5J8bbetGilruFAf5qwbmD16YGtUVPzF8yzYV5pCxpIKBE8c0PRWWKCvyO60KtEFSjsu1M4QkDt6BEjHRsr4BejzmkpShvwakcBAxfgeEKY4wZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvGiKRON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF48C4CEF7;
	Tue, 17 Mar 2026 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773745472;
	bh=P0tLbS2Ykxw7VPCP1RVLuN4ErZPx4T42O91htQzqL3I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nvGiKRON6trn6+oY2K6ZZW3m/pRQ+vKOzmmZ81iTJT39tHYx7DTJDR2TlRz45RDuo
	 BEhdZqYlBPZc45WMEmrUq9SRGevSr7uTyTQ0KDNtSaclTY7CP3BGzeW9qkR0OCh7n+
	 Y72xBTiAI9fRD6GWrjCcecLoB5YBy0oITpMNCgBCpnajI3Z8HFCHNdmbC0uqrqmqtn
	 Gu+Tqc8nBY92n3qkkksGm79CS7t8YRZmlQmTjjLi+5lYUBuK/Eslst6/iZ6Xfu5VO/
	 p4++2aFUdsFXGcdopFFbuiWHCTF1yIAPBd+OKulosP/GaZRvBHe6m/CXnThaCr0GI9
	 O00xEM1PlNoOQ==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Michael Margolin <mrgolin@amazon.com>
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev
In-Reply-To: <20260316180846.30273-1-mrgolin@amazon.com>
References: <20260316180846.30273-1-mrgolin@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Rename alloc_ucontext comp_mask to
 supported_caps
Message-Id: <177374546974.343333.6909684988845488330.b4-ty@kernel.org>
Date: Tue, 17 Mar 2026 07:04:29 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18246-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26FE12A8740
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 16 Mar 2026 18:08:46 +0000, Michael Margolin wrote:
> Following discussion [1], rename the comp_mask field in
> efa_ibv_alloc_ucontext_cmd to supported_caps to reflect its actual
> usage as a capabilities handshake mechanism rather than a standard
> comp_mask. Rename related constants and align function and macro names.
> 
> [1] https://lore.kernel.org/linux-rdma/20260312120858.GH1448102@nvidia.com/
> 
> [...]

Applied, thanks!

[1/1] RDMA/efa: Rename alloc_ucontext comp_mask to supported_caps
      https://git.kernel.org/rdma/rdma/c/5122be2a19aa0f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


