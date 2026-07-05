Return-Path: <linux-rdma+bounces-22781-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w8mhB7dlSmqpCQEAu9opvQ
	(envelope-from <linux-rdma+bounces-22781-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:09:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6063F70A407
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:09:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KN2QpTZB;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22781-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22781-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 905E8300CE6E
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D223815CA;
	Sun,  5 Jul 2026 14:09:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65C3644A4
	for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2026 14:09:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260587; cv=none; b=mdt9vp2t6jl7wLh7P1M0Uhx1jS6aPgaTYEizL5uABtiEtzYd5pCE6oHtyYpZL4GOCvMFRYMzSZFHj88DHJOuXz1MYc63PXqior+dnGGanoG3JcOofJjLaBS1EoIQWfs8DjUGzhEUgDgnjajDmxaXQwg6j2SOEfXl+ZkbauJ1rsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260587; c=relaxed/simple;
	bh=9QnA86PjVwx/XfFrgmjKp12l68zJrBcvSGQzTC36iko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWOv7Kd4feJjedPYcw1qzfmkARdy3b32e5slJCtfEEkGIwf17zwWD1KdTrvHftVtTz5+gxJXxRdIg9iN0mwrwCowtI39Ex5ftmER1DlhpC2bR+/rOMyAm1InBgw1/x1Ld1LzT6PsGntZynhV3oqPF/BEv4GvlIV0b9q/tRMpQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN2QpTZB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FC21F000E9;
	Sun,  5 Jul 2026 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260586;
	bh=XpUz0K5izmcajqlrTfe9PZlBq7+dYA5eh9xrwlruDsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KN2QpTZBdDj3g7CjCkqUm4Za/kpP4hHwDsSH/JTl4cpNSKzrdtS2CMwT0eWX83I4C
	 C5bR7J8/8UoUltGMIGOp5Dhe3D+Qx4Oc8CumkNI2NpljRQccRcM6REq0muYaoYFlh7
	 0ef78S3BkTNgjN1FrdlIi+gzXEIlV1qCrtlkJWEgcoU8AH4ldDXSZmBnsE5hTrVwrM
	 NMKuUnjPNb32n9ffWc5uUviG6E2uz/BhY/ya7BlPWBifyUlJd3cf4YGjhF4C0crQMA
	 VYJry28ch8In3hqnaVfkvUsFkGpL5ohu1hto7LA7VpoXJ45rIioBz5cYjbv3Ag94uJ
	 YWmM2dGYNIPxA==
Date: Sun, 5 Jul 2026 17:09:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Check for null udata during reg_user_mr
Message-ID: <20260705140940.GG15188@unreal>
References: <20260630154720.1647530-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630154720.1647530-1-jmoroni@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22781-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,unreal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6063F70A407

On Tue, Jun 30, 2026 at 03:47:19PM +0000, Jacob Moroni wrote:
> The irdma driver requires udata for reg_user_mr. Previously,
> it was assuming that it was always non-null, but it can actually
> be null if the user intentionally triggers the UVERBS_METHOD_REG_MR
> ioctl.
> 
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index cb54c7c8fcd..3bcac68a612 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -3519,6 +3519,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  	if (dmah)
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> +	if (!udata)
> +		return ERR_PTR(-EINVAL);

Is this check specific to iRDMA?

Thanks

> +
>  	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
>  		return ERR_PTR(-EINVAL);
>  
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 

