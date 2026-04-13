Return-Path: <linux-rdma+bounces-19298-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ATrJOcY3WnoZwkAu9opvQ
	(envelope-from <linux-rdma+bounces-19298-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 18:25:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1519F3EEDD1
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 18:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B8623114A8E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 16:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6B828C2DD;
	Mon, 13 Apr 2026 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEvkAHCU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA2E272E6D;
	Mon, 13 Apr 2026 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096555; cv=none; b=P0LyY/Io89xKJAv+h1AR/vCusgxpmC4ZXbcFGm7EYY6FydEXe/IrMvRmGqoZJerYErQPbgKFAfjHZqSIRghdWIy+ZAKC5fSP8L304Dti/olDaEPhdWwDnbhFKWzUtugI03BaXkSpGMLM2hHnZ/NlqpvhYrbjfyQfYZgHnS2K7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096555; c=relaxed/simple;
	bh=ivJCtvmKkXE+mdYlmr1xPzzNt85+4Pv62hw0me/sBIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7QWdXVua5+S6/Wl7BqhrwaRs34+TI/g5SHpheF2ln1AeSnAVOUqMmeHUcYJcN+PQ9vQtCV55hcP5Vh4Bqn06Nkkx0RkzlHgl5sFlpA/UvlXtuWAQGOKVV5vBB9+uq5vu95zqhVUHYv3Etvma8fzlVgfyRTAo7NdOUAR//gfuKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEvkAHCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1D7C2BCB4;
	Mon, 13 Apr 2026 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776096555;
	bh=ivJCtvmKkXE+mdYlmr1xPzzNt85+4Pv62hw0me/sBIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tEvkAHCUxScpzmU/fjUsAOwn4IjfT4Q8zigg17yVwyGLFbEX5vUjrwijkGox2N6zO
	 G/8J2HWH0WdIgzTmxHDnAMCXVZneeJerIEXy/O2ttBYH3J+ioRjPZH+IMaINxKHCvE
	 zXNwzezk4XNWwB7lKTsfgmFDfKK4IwMoG9wvFSv0Flr67Qmk9OIk4kiQhPkmHAwiC2
	 mFAWUVEjDNRqmIz4HKiJmP/Pu3I7x5CISIIEyTp0jiyHMuguNKBwj/8kkiGjAU4Zsd
	 WEkGOTTrTSKBZqjoOp+BIg9OQTDv+KWPOaSjH/N10qGNp7KpPSwnQ2leaXvx88n7+g
	 rUn+TVhhuSXRQ==
Date: Mon, 13 Apr 2026 19:09:11 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Xi Wang <wangxi11@huawei.com>,
	Weihang Li <liweihang@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
	Shengming Shu <shushengming1@huawei.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] RDMA/hns: fix out-of-bounds write in IRQ array during
 configuration
Message-ID: <20260413160911.GN21470@unreal>
References: <SYBPR01MB7881512F49EA80F0146EEEA1AF5CA@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20260412125005.GB21470@unreal>
 <E9C401AC-6A1E-4E5D-A3D3-C0D2216567B9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E9C401AC-6A1E-4E5D-A3D3-C0D2216567B9@outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19298-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[huawei.com,hisilicon.com,ziepe.ca,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1519F3EEDD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 07:09:49AM +0000, Junrui Luo wrote:
> On Sun, Apr 12, 2026 at 03:50:05PM +0300, Leon Romanovsky wrote:
> > Is this an actual issue, or just another imagined problem?
> 
> This is a defensive hardening assumption rather than an
> observed issue.

Let's drop this patch. The kernel does not follow a defensive  
programming style.

Thanks
> 
> Thanks,
> Junrui Luo

