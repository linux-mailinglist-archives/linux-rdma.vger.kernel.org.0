Return-Path: <linux-rdma+bounces-17465-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPTnI5IMqGn2nQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17465-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 11:42:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2544C1FE7F4
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 11:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE2253013A70
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF6366819;
	Wed,  4 Mar 2026 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mre/lklA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE12317169
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620927; cv=none; b=uroruvPfAfheQBI6JuzurCfHxOsuu6OxIP2RaGc9o9bA2Iemq3wDnCF92Ju0RVF+HblEsfpXHpozbNnKw2Zgd7QhJGSgJBWLvOLY47DEQLwHnmSqt62mYnOru2IFqgSt9TLDk7GWfDg61BXzkOcZv5wf5r/PgYz3fa1lqyB2ZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620927; c=relaxed/simple;
	bh=z1b1ln1XDDblYpAyS0wMjnrKkLubqTbSoxgsTWx/Pv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llm/raGR/U9FDV9NF5WEiO44XukqUdBBwYCn1f25JtOig6G+BJ/wuEVWfLa4WK77AlKludn1f6BKleK1qfMOer39XXEhDza/iVJgpnYcUrXuv2vaj1oFPh/TpetcY9XmDwmCxJgGCloh2jWA/GbYrwh1DNF70tot7v2sIW+HW3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mre/lklA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E40EC19423;
	Wed,  4 Mar 2026 10:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772620927;
	bh=z1b1ln1XDDblYpAyS0wMjnrKkLubqTbSoxgsTWx/Pv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mre/lklASG3m6OVjacEqvvb9GLls645GzruzKbmOmu2wLlGxZlsDZ/THrcVV13tsF
	 Dq2fpkCnDMno9xwGOb2q/q/UA2Up4xLySGgOBN4utnnZ1oC2Epwfgcmx/N/iY96ThK
	 PIw6yN4sH9XoYJX/p1U0Bnuv2Fz3jLmD/sIUphZpY6347P6kPKYgoZK5PToe3JJaUR
	 RB0xFTmm3SqIUNkvqpQnRmun/kfuevN+IVVmCbF+FvpCIBES95EaaSdhgVVAfLcsy3
	 f6P9qdujK++nhm8TEh+sBtZwaCkZE5EMRjYIk5pn4dk3+W+eeGHblZuacsD4DXcTz0
	 Cxt8YtM/FsjLg==
Date: Wed, 4 Mar 2026 12:42:03 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Cheng Xu <chengyou@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next] RDMA/core: Fix missing MODULE_IMPORT_NS in
 ib_uverbs module
Message-ID: <20260304104203.GY12611@unreal>
References: <20260303031913.74708-1-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303031913.74708-1-chengyou@linux.alibaba.com>
X-Rspamd-Queue-Id: 2544C1FE7F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17465-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alibaba.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:19:10AM +0800, Cheng Xu wrote:
> Compiling failed with the following messages:
> 
> <...>
>   CC [M]  drivers/infiniband/core/uverbs_std_types_dmabuf.o
>   LD [M]  drivers/infiniband/core/ib_uverbs.o
>   MODPOST Module.symvers
> ERROR: modpost: module ib_uverbs uses symbol dma_buf_move_notify from namespace DMA_BUF, but does not import it.
> ERROR: modpost: module ib_uverbs uses symbol dma_buf_phys_vec_to_sgt from namespace DMA_BUF, but does not import it.
> ERROR: modpost: module ib_uverbs uses symbol dma_buf_export from namespace DMA_BUF, but does not import it.
> ERROR: modpost: module ib_uverbs uses symbol dma_buf_free_sgt from namespace DMA_BUF, but does not import it.
> ERROR: modpost: module ib_uverbs uses symbol dma_buf_put from namespace DMA_BUF, but does not import it.
> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> make[1]: *** [/opt/linux/Makefile:2051: modpost] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> Add the missing MODULE_IMPORT_NS to fix it.
> 
> Fixes: 0ac6f4056c4a ("RDMA/uverbs: Add DMABUF object type and operations")
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/core/uverbs_std_types_dmabuf.c | 2 ++
>  1 file changed, 2 insertions(+)

The same patch was already applied to Linus's master.
7c2889af8233 ("RDMA/uverbs: Import DMA-BUF module in uverbs_std_types_dmabuf file")
https://patch.msgid.link/20260225-fix-uverbs-compilation-v1-1-acf7b3d0f9fa@nvidia.com

Thanks

