Return-Path: <linux-rdma+bounces-23268-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fDTtGgtQV2pWJAEAu9opvQ
	(envelope-from <linux-rdma+bounces-23268-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:16:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B85B375C58E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:16:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hfdVkabU;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23268-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23268-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6C9830A7729
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7587E3EEAC4;
	Wed, 15 Jul 2026 09:09:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9163EDE59;
	Wed, 15 Jul 2026 09:09:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106557; cv=none; b=quToe7SGYQkTrYtlgMwRUAdG+XpX8EFNdr0uMjBR5ibz296VV+ulrA58gZi11awb0TDa0MvRBHBTSaK5TcZkjWkMO4RY6bW6NJif4TIgRn0RsSNOdfexeZpu71o9t3W8qzt82swtKR1Ck89vu8HdgbRY4/H9VPgaQRLX9F5rkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106557; c=relaxed/simple;
	bh=tXdEG0goKvMbutz17XGU9zr5ono3VT8dFex3LL/vpeE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rfYWs7i1yy+CUORAeonXA5W6D57XqWDvC6js+A9RtwVmzdvrkeuIeIrDu9y5yOLSjrq+QmEjULLCFzDyMbxv1vTj/ktPx+45YacgHHEh6xLJSVvVyJa/ysNaqwLcg+Xr/HTtoCvoVSu7+K9cuHdzHxD4o7j9tdtwRG/EKceNJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfdVkabU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2052D1F000E9;
	Wed, 15 Jul 2026 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784106555;
	bh=JwtsMn8Nx8xb2AMLd+1RR24PiUtzA9F3LkIVqXg656o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hfdVkabUjfbbTJWe1jj/FQ46uq2zpsU6YyD2ZXNZj+IOlALDcauds68jBzBMNGCpM
	 HFhGiIuo7tlMKn08wqUMSUF3VQmczw1DEbY/quFl05NfUxWbBkQrAocs1cA+SjSeZn
	 DxLcKZm5To6Sy+7/2ExVHQfzI9RECXvbWiquO2KGjGasY4AHZMgpLyd2MtYWqVJFD0
	 s9/WIM5RfBsM990EaVP92GcYJlINzV1FpsdGe88BQ4uMC8fZ3EiTmK5AkCSzF6N19R
	 yIAsWf4cVCfKJm9V1NiHXxxl1MO4CPZ9cAmKPBlK7/PjYby2GpT4AbBNAgrEVhZpOm
	 jEn6BND/ukpnw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-rdma@vger.kernel.org
In-Reply-To: <3ca4ace543a02ccfdcce1ba568895c994aad7abb.1784018825.git.christophe.jaillet@wanadoo.fr>
References: <3ca4ace543a02ccfdcce1ba568895c994aad7abb.1784018825.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] RDMA/umem: Constify struct dma_buf_attach_ops
Message-Id: <178410655282.143159.8817691751117151919.b4-ty@kernel.org>
Date: Wed, 15 Jul 2026 05:09:12 -0400
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
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:christophe.jaillet@wanadoo.fr,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,wanadoo.fr];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23268-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B85B375C58E


On Tue, 14 Jul 2026 10:47:32 +0200, Christophe JAILLET wrote:
> 'struct dma_buf_attach_ops' are not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   10300	   1216	      0	  11516	   2cfc	drivers/infiniband/core/umem_dmabuf.o
> 
> [...]

Applied, thanks!

[1/1] RDMA/umem: Constify struct dma_buf_attach_ops
      https://git.kernel.org/rdma/rdma/c/e952e079d22620

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


