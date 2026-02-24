Return-Path: <linux-rdma+bounces-17110-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO6xL3B4nWmAQAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17110-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:07:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8821851B6
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16A8F306A311
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21C8376484;
	Tue, 24 Feb 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZYant9w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9474737107D;
	Tue, 24 Feb 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927661; cv=none; b=h01ewZTqCCdki/PnjxPgyYH/AO9Z+R5YKwiNo/H0WVdVQ5gEa9j3flYrukE5Z1VmKBMeY0RdNfhprUp3eTx63PLPVMMMXJloGr6wIDorY6u1AxlxafVMWcsIamfyjITkqhQDMFk4c3yAxCjGWHkc5VkWhhlsxDBvVO0L98jbWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927661; c=relaxed/simple;
	bh=UudKhpnWEeS6spLONpAY/RoCNCqi95XvOx3MdHkj52s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvZDPq2TMNy+BJMNo8ssT7EuKZDz7+J3FmzXOOUdSNqdgE5xtgB84JaXRhRsCY7iLNxwiHObmsSEKYO3Hm/NSs2MuP5/xE1w0kxr1AVRnDrNDqnB2oDSIEXIK0fVNw8cuW3jCkeQciEY3TzoQopHolySxboeQ2SX80EYAHmZzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZYant9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B623DC116D0;
	Tue, 24 Feb 2026 10:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771927661;
	bh=UudKhpnWEeS6spLONpAY/RoCNCqi95XvOx3MdHkj52s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZYant9wfmPbVww0eeF86fU5KsApC0VXiL9qYH0b9QTSKqfnxS4/Yt80PFPLZuj7Z
	 ddmN+pgsVNitMYGryMU4WvZgPLMbA7ysCXeRVWKS/J8pU7tycS/rUFhV+ZinAXFos+
	 Bi3G/dx6bTDy8XouK7OOVq1ZSYx7mQx++Bw2HFgTxsV/UYeRyUAKZKfRFrTtjnGo4Q
	 bdVb33xHcXhiGculnuq0bcP8kggj8Rsj5oQQoVGbGzegZTurkTQmkQZUv86qFBMNmo
	 mVp+201kH8IWnR86y0d6UbRLTW3CZNFeO1A3I6kyA7yDrRRhZmJh6dxzCLiCcMwK0D
	 t0hrIMUnZ9ipg==
Date: Tue, 24 Feb 2026 12:07:37 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: follow rename of dma_buf_move_notify()
Message-ID: <20260224100737.GH10607@unreal>
References: <20260223131148.490904-1-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223131148.490904-1-Simon.Richter@hogyros.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17110-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,cgit.freedesktop.org:url]
X-Rspamd-Queue-Id: 3B8821851B6
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:11:34PM +0900, Simon Richter wrote:
> Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to
> dma_buf_invalidate_mappings()" does precisely what it says, and commit
> 0ac6f4056c4a ("RDMA/uverbs: Add DMABUF object type and operations"), which
> was merged during the same window, started using the old name.
> 
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Fixes: 0ac6f4056c4a ("RDMA/uverbs: Add DMABUF object type and operations")

It was handled by this commit
https://cgit.freedesktop.org/drm/drm-misc/commit/?id=61c0f69a2ff79c8f388a9e973abb4853be467127,
This rename doesn't exist in RDMA tree yet, there is nothing to fix here.

Thanks

