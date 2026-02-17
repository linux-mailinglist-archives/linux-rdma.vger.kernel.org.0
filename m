Return-Path: <linux-rdma+bounces-16953-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH45L69qlGmqDgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16953-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 14:18:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F0714C808
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 14:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B086300F11B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A7E35FF62;
	Tue, 17 Feb 2026 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qs633JOr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E80356A13;
	Tue, 17 Feb 2026 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334309; cv=none; b=K/ReckEgqMkfn4TGh8IbaA3sCwocT3l69t5kiJ8/1pvTCqQsDdRCBo2VeoUVom6SjcMDs0ETO+YbPI2t4vHroli6QDFYCiIdpi/o3vCy5sRHb+bMJgxfit4GF7saaE9Yzop8nH3uEdfg8VP25UBZvEhivUOtGrHBC/4F1mqkcPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334309; c=relaxed/simple;
	bh=3DeHYvvhqg+AUSPY8xqMDBqmLhO2PgQZBfdqynuYxeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo1OFyICOQCtjrM8rmKw9mLj//RGId+OqBeGAV3KkKVZ7X2nmtRyzPyf92x427mCiHmvjne9oAbcLfNbTVV7I7coALeaMkzM9hsxWf4MeMDAFQ2dC46kjvaFlZ0HTg3Sa+JMTSpmPARxgWi+FP7GO49LwLg2q3Kml+TbBWhlr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qs633JOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104FCC4CEF7;
	Tue, 17 Feb 2026 13:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771334309;
	bh=3DeHYvvhqg+AUSPY8xqMDBqmLhO2PgQZBfdqynuYxeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qs633JOr9lAk6uV/DSdPEwUM6tgD8lcB0kwrYdegMJh0Tmg2A1E36pvfdNov+HsZe
	 elJqVQCA5DvR8aYztF6Bx1C2s0nzLK5dRnenH5dloGUrtBi9puJdGYwsDVUHJjppMr
	 rbUGmjruKdKX/yRL4YsyAK9o8KpceSb5jT6abnzkaycb8D3h70qpwrcHi20pP/nBzO
	 wTDozAJzYlJeC2by8wWC8vg+V/5jt5xPzGXx2r+ccVyFcE6UbobfkvRxVv3pZ9ijxQ
	 jdFFem5SDyksWPVY88AGOGQXDFflG42TGd+kLjXNhqgibpQx6ZXlx5OpDbHx4JdsKK
	 EYj8aWUBlr8rw==
Date: Tue, 17 Feb 2026 15:18:25 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Usman Ansari <usman.ansari@broadcom.com>,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: select CONFIG_DMA_SHARED_BUFFER
Message-ID: <20260217131825.GL12989@unreal>
References: <20260216121213.2088910-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216121213.2088910-1-arnd@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16953-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,arndb.de:email]
X-Rspamd-Queue-Id: 61F0714C808
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 01:12:00PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The addition of dmabuf support in uverbs means that it is no
> longer possible to build infiniband support if that is disabled:
> 
> arm-linux-gnueabi-ld: drivers/infiniband/core/ib_core_uverbs.o: in function `rdma_user_mmap_entry_remove.part.0':
> ib_core_uverbs.c:(.text+0x508): undefined reference to `dma_buf_move_notify'
> (dma_buf_move_notify): Unknown destination type (ARM/Thumb) in drivers/infiniband/core/ib_core_uverbs.o
> ib_core_uverbs.c:(.text+0x518): undefined reference to `dma_resv_wait_timeout'
> (dma_resv_wait_timeout): Unknown destination type (ARM/Thumb) in drivers/infiniband/core/ib_core_uverbs.o
> 
> Select this from Kconfig, as we do for the other users.
> 
> Fixes: 0ac6f4056c4a ("RDMA/uverbs: Add DMABUF object type and operations")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

It looks reasonable to me. dma-buf is becoming a first‑class citizen in the
RDMA world.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

