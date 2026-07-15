Return-Path: <linux-rdma+bounces-23265-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2n1TD4BNV2qpIwEAu9opvQ
	(envelope-from <linux-rdma+bounces-23265-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:06:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7F775C388
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:06:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NA6iqLfi;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23265-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23265-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3C41300102D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B13EB11D;
	Wed, 15 Jul 2026 09:06:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228C3E7BA4;
	Wed, 15 Jul 2026 09:06:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106365; cv=none; b=u2KBteluQEOs8d5ZJPgWIe8QGeBqlk875R4/PvpnXO87VMT96gP0ZuYt0XLyFIyeGuzO3kq2iMO60suZFqsvx+2jZpEfbBgSzSAsp129qqJlJm+e7nR06yLqdwwaCscQ9zVuaH1RbOJykBxch3x/8rpSS/lbgAu+mIfIUYz/T8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106365; c=relaxed/simple;
	bh=3BI5Z4OqUuRtYp7BClG+SHiYvpqE3H+/n/Rx4Jg1ivQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUGRb3Ts7p4witJqCmrZ4XeaZTUbFXwhnZBUvD0HMIjbCeSGZysdz0AmXF9036QQkc0hL36zHmpqnRUOg7N3RNMp50UFtzCUr+NJsnNefVB3GVPf7ZQWnB9EJIlo5KXobWhKYEoybpgh8UzxVYSsPt/tRhd0JmrnWNI2CdUPaT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA6iqLfi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62031F000E9;
	Wed, 15 Jul 2026 09:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784106362;
	bh=Y88tzC1/LJ6aLdthsFjO8w+Vf1/wl511Iaf+O9aceZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NA6iqLfiTDjHV10czvzfbX+T/3yibb2uvqjCZh4lOIrlyViE77SGOlCfLAn4b6mxy
	 7XHfZcBucN6pAWXdVAkV8pa+aWpo0vkNIuV+kpZ+XKgELT1PWy5mhQWjI9GWlSiS0J
	 bB5KZfOtuEVuckco1Mu4wmPUxhTQMm4sojvzMbQwlrJbuXqG4mnCoKiIKSOCoWkb1m
	 rmeDEdcI5JI993RtjdFhs2NyKrW532YbDrBVWTYqL5YjjfAFIeyIVbS33Hxhrdiyt9
	 PY5P6QFqvcjy9sS7yekx0j2B4atzmHuX3v8kacZaY9SYTK3yyjWUkUVj+yXunJnvrD
	 L/1W0wvS8BuKQ==
Date: Wed, 15 Jul 2026 12:05:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: kensanya@163.com
Cc: bvanassche@acm.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	TanZheng <tanzheng@kylinos.cn>
Subject: Re: [PATCH] RDMA/srpt: Fix srpt_alloc_rw_ctxs() unwind counters
Message-ID: <20260715090557.GE21348@unreal>
References: <20260715023016.56767-1-kensanya@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715023016.56767-1-kensanya@163.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kensanya@163.com,m:bvanassche@acm.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tanzheng@kylinos.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	TAGGED_FROM(0.00)[bounces-23265-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,unreal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F7F775C388

On Wed, Jul 15, 2026 at 10:30:16AM +0800, kensanya@163.com wrote:
> From: TanZheng <tanzheng@kylinos.cn>
> 
> When srpt_alloc_rw_ctxs() fails partway through a multi-buffer indirect
> descriptor, the unwind path destroys RDMA contexts but leaves stale
> n_rw_ctx and n_rdma values (and a dangling rw_ctxs pointer). Later
> sq_wr_avail accounting in srpt_queue_response() or srpt_write_pending()
> can then subtract the wrong number of send queue credits.
> 
> Reset the counters and rw_ctxs pointer before returning an error.
> 
> Fixes: b99f8e4d7bcd ("IB/srpt: convert to the generic RDMA READ/WRITE API")
> Signed-off-by: TanZheng <tanzheng@kylinos.cn>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index f66cfd70c263..4644429fae14 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -1016,6 +1016,9 @@ static int srpt_alloc_rw_ctxs(struct srpt_send_ioctx *ioctx,
>  	}
>  	if (ioctx->rw_ctxs != &ioctx->s_rw_ctx)
>  		kfree(ioctx->rw_ctxs);
> +	ioctx->rw_ctxs = &ioctx->s_rw_ctx;

This line seems questionable to me.
You probably need to write:
if (ioctx->rw_ctxs != &ioctx->s_rw_ctx) {
  kfree(ioctx->rw_ctxs);
  ioctx->rw_ctxs = NULL;
}

> +	ioctx->n_rw_ctx = 0;
> +	ioctx->n_rdma = 0;

These lines seem correct to me.

>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 

