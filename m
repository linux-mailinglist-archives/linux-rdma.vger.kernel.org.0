Return-Path: <linux-rdma+bounces-23255-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kbF4H8c/V2pjIAEAu9opvQ
	(envelope-from <linux-rdma+bounces-23255-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:07:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDE975BB77
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:07:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Upx8oRBZ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23255-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23255-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB246303C7CE
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2397359A90;
	Wed, 15 Jul 2026 08:07:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2583CA4B6;
	Wed, 15 Jul 2026 08:07:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102829; cv=none; b=jWKjm/hTpuUCRmrPbF4xB7uYr1p10OaIxtpQtqglxIwDvtuJAgsP8/MdWSkefM9oqH/zc59hI9aweK8KtrAqQjY3erPdLpwbD6PvM32g7Qug44a/RR9+NJ59DDfOD1ywhoaN/cnu3d4wLKviyzpE/1aulpIxYY01/tdSWqQqh1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102829; c=relaxed/simple;
	bh=63BF7yDg5mV6YVNbqpmCdUzgHzei3DzBvrrKN6kQjT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFv468TTvsHY2dvtkrLRFHrHtAlcP7Aj5n14B4Kkv2lzqiwPqSJTgxYK042g6/1SP2sEmjxTqoaUytZb2vRIAFXzBCpJqDco8ZTsmM9Ev49+hGGiBc7b1ZaL1jdmg+z4B0N/1KLTEFcKqZP26BxjzCZBXX7SQsDiFRxlyD1SEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Upx8oRBZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7261F000E9;
	Wed, 15 Jul 2026 08:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784102828;
	bh=SoXbmTx4Ab43BxiYyhpe9D5zp0kkuyc+3ahF3zv0vqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Upx8oRBZc1gXetV5nCUT4f/L9Jho9KLJnAeLmwj8IF6lGros6aqgHQpsgacMz9bFe
	 YTGaV8v6e558qtnuqBbfsdIdzmZQUO75Xq6gueS/Ppsjnp7UxfCgguCKzz7+cRxXhw
	 267Hc4uIHuedZg+KBjQhLig8bhrPjjyf4IRAePMJ1NXTqlSNcWfua4+zZoLjZyBLFa
	 NE1R6Rq3bifHO+/G6EAqj27qvh8kVJsIu27nyCNd+LrRhBEmVGGH72kvjv5UmdKKXv
	 pieFv+7+0c5XwTlMx+iRizuF0b9+Vr37Ap7jxoPmsekXERkynk50QD2IQ5N4mvLFN+
	 TrS/ALstVE4sQ==
Date: Wed, 15 Jul 2026 11:07:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, longli@microsoft.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v3] RDMA/mana_ib: Adopt robust udata
Message-ID: <20260715080701.GC21348@unreal>
References: <20260714123113.3792099-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714123113.3792099-1-kotaranov@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kotaranov@linux.microsoft.com,m:kotaranov@microsoft.com,m:longli@microsoft.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23255-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCDE975BB77

On Tue, Jul 14, 2026 at 05:31:13AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Enable the uverbs robust udata interface in mana_ib by setting
> uverbs_robust_udata and converting the driver to the new udata
> handling model.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
> v3: use ib_no_udata_io
> v2: Removed the udata request for alloc ucontext
>  drivers/infiniband/hw/mana/cq.c     |  8 +++++-
>  drivers/infiniband/hw/mana/device.c |  1 +
>  drivers/infiniband/hw/mana/main.c   | 29 ++++++++++++++++------
>  drivers/infiniband/hw/mana/mr.c     | 13 ++++++++++
>  drivers/infiniband/hw/mana/qp.c     | 38 +++++++++++++++++++++++------
>  drivers/infiniband/hw/mana/wq.c     | 12 +++++++++
>  include/uapi/rdma/mana-abi.h        |  2 +-
>  7 files changed, 86 insertions(+), 17 deletions(-)

<...>

> diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
> index a75bf32b8..8336bf51b 100644
> --- a/include/uapi/rdma/mana-abi.h
> +++ b/include/uapi/rdma/mana-abi.h
> @@ -25,7 +25,7 @@ enum mana_ib_create_cq_flags {
>  
>  struct mana_ib_create_cq {
>  	__aligned_u64 buf_addr;
> -	__u16	flags;
> +	__u16	comp_mask;

This change is unrelated to the patch.

Thanks

>  	__u16	reserved0;
>  	__u32	reserved1;
>  };
> -- 
> 2.43.0
> 

