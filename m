Return-Path: <linux-rdma+bounces-19352-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEWWFkd73mkHEwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19352-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 19:37:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BFF3FD25B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 19:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15E42306CD14
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0653F0746;
	Tue, 14 Apr 2026 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d99lLNat"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB983EDAB9;
	Tue, 14 Apr 2026 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188057; cv=none; b=jDegAtmp/LJulswY6PnNhKBDl38VHpNdRcG28v9CnvV/6L3Wr0fHuprDQCLb3OgxurVPQPbLF+pEpz5gtWmcmK25tERtb+LDg6L2Er0LxJ/QrOX0el0oaCanWS6u60eAbliNcaZf/pF/jTzcP5DT1wFEeTnVJd288rz2WZzoICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188057; c=relaxed/simple;
	bh=bIYKUg6KM4B2jwA0U61DhG5RQJNqCIi7oMSl3PzaDqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFpiBDfLsCb3rBUnF907grRlYT2b9pLznXQ6DOM1uGzOTniUoru0ZsRr4f+h3R9TusWStaBgjtKPUNyB4pLAUb6btm+GIeeHXoCZfDUwqgSxJvlO10EKJE4vr/LFkWUjVCDlV5TnfvRdFvtJedIGOHlUdoee4pV3e3SCbqHtes4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d99lLNat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408C2C19425;
	Tue, 14 Apr 2026 17:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776188056;
	bh=bIYKUg6KM4B2jwA0U61DhG5RQJNqCIi7oMSl3PzaDqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d99lLNat3zpmep1gV8Utf8/s8GvEKvRmD1JIrFdWoUlLy+SRr72tOv+ONZzBcdwo2
	 r3Y0+CBIA+/SOEpyQpdl7GLlSx7LuWs5ZrQP+QQ8VKMTuH6vXmN1GrqawyyBSsqgli
	 /iKWZbo+UQuapoELb+8sOji5Ed9TICOV+vYgyZTcEOrHXMPfTSyYZzIMbcTRsog6r0
	 GRE1DrcqxyTnIUJp4SvqHFMGm7urtEDKS3rkC9h2uAJ5jdSvH2sB7m9sHQVUODrgyo
	 QQqvlg8HhNaHUC93ntQl2YvEzHhBhBUr4DncCpFiGi8lKA3FrU19LKznpoZKvxwIAq
	 wQqZxnWE/Xt7A==
Date: Tue, 14 Apr 2026 11:34:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <ad56liSM4zI2SWWp@kbusch-mbp>
References: <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal>
 <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal>
 <acvNsvS5ShlQlrox@kbusch-mbp>
 <20260331140309.GH814676@unreal>
 <acvWplw67b3Gwlkc@kbusch-mbp>
 <20260331190220.GI814676@unreal>
 <acwkAo2k41xaxdTS@kbusch-mbp>
 <20260409120415.GF86584@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409120415.GF86584@unreal>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19352-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04BFF3FD25B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 03:04:15PM +0300, Leon Romanovsky wrote:
> Something like that, on top of this proposal:

...
  
> +struct vfio_region_dma_tph {
> +	u16 tag;
> +	u8 ph;
> +};
> +
>  struct vfio_region_dma_range {
> -	__u64 offset;
> -	__u64 length;
> +	union {
> +		__u64 offset;
> +		struct vfio_region_dma_tph tph;
> +	};
> +	union {
> +		__u64 length;
> +		__u64 reserved;
> +	};
> +};
> +
> +enum {
> +	VFIO_DMABUF_FLAG_TPH = 1 << 0,
>  };

Okay, so you have the hints as a separate action from the dmabuf
creation. I was trying to set it up in one shot, but this proposal may
be fine. We'll try this idea out internally.

