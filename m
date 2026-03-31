Return-Path: <linux-rdma+bounces-18849-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBLtGAzTy2mILwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18849-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:58:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB6036A94B
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A75C7302223D
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 13:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63073F660F;
	Tue, 31 Mar 2026 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCvdbi5J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3F63DD501;
	Tue, 31 Mar 2026 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965316; cv=none; b=FdBpyRdAgVjxAFDy61yubV1H8dIjljEi4mBuCKy8vJwTcx51gYGDUu2WSkBqCHalstm+dmEyPnzYjTU4jKrm9UfPrDlzvMU4MNA/i+ZHLOID+XnOA5Jb2wjszvJuHuRY5UxDXGwGUUOAwmjwrrh8FTIRjm4sgtkfdcw6hahH2ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965316; c=relaxed/simple;
	bh=uaXnpQXrBn79y7cjpfquFyxdXUjfsq6cz5WtK1NVeX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj4KkSqUmDyrzBH1WMPkhPJuuiClXcbxI4b2pzrdpRcLZ0k3pZuKN+AhyWJIXX7MCP7T5GKzT7YLoOh5KMv3vlTRC9lEqA6LuNl/C52tKmcBv73ilqoeAgkEkSF+PAF/SSNHfyuRsKrpnv2fJ8rzXcKqSXeTas4b3jwNRd8LyPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCvdbi5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E50BC19423;
	Tue, 31 Mar 2026 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774965316;
	bh=uaXnpQXrBn79y7cjpfquFyxdXUjfsq6cz5WtK1NVeX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCvdbi5JEDYCr3wmDu7t9rgpUQ/i/fpbBHzcOAbcxNvxdpU9pW6j9G4Fe7buM5TR2
	 CrQl8gP0VZjHHifa95kK8+b2yHi/c3Qrl4lXRwO5nhkp3I7Mg+4gbUqILikGHjEAgb
	 pTvPA9pDVD6SxeN04IZ8VYiPvLgED/fFj7R7siXMZMMhjnbbL7C02tQwT6WI7n5ydj
	 1ROJkPTdoSD17+HFOuLYlkeYiMljLzJRikjRsZSOipCS2EsGKGGriUDUBuJuQjS3Pd
	 rSE3BgurRUfGR3dmz7TuSeoWnBnH8CEEQxdAJNooc9oZWmrjq5EZTBtMPFVST+o+5P
	 lcIswmzGpahbw==
Date: Tue, 31 Mar 2026 16:55:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v3 1/1] RDMA/mana_ib: memory windows
Message-ID: <20260331135512.GG814676@unreal>
References: <20260331090851.2276205-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331090851.2276205-1-kotaranov@linux.microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18849-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BB6036A94B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 02:08:51AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Implement .alloc_mw() and .dealloc_mw() for mana device.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Long Li <longli@microsoft.com>
> ---
> v3: Use v2 request
> v2: fixed comments. Cleaned up the use of mana_gd_send_request()
>  drivers/infiniband/hw/mana/device.c  |  3 ++
>  drivers/infiniband/hw/mana/mana_ib.h |  8 +++++
>  drivers/infiniband/hw/mana/mr.c      | 54 +++++++++++++++++++++++++++-
>  include/net/mana/gdma.h              |  5 +++
>  4 files changed, 69 insertions(+), 1 deletion(-)

How did you test this patch? How can applications know that alloc_mw is
supported now if you didn't set IB_DEVICE_MEM_WINDOW and props->max_mw?

Thanks

