Return-Path: <linux-rdma+bounces-22071-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IxO4I+AkKWrDRQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22071-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 10:48:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B4F667632
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 10:48:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bAZP0lVR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22071-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22071-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E667F301425F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 08:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296CF38A29A;
	Wed, 10 Jun 2026 08:48:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A31DED5C;
	Wed, 10 Jun 2026 08:48:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081307; cv=none; b=CVdhbpCMQffvM8DrphAj3RxC7rn2mAhnc4bY305+Vjm4iVC/eR9+qRzH2OtqZIrbpViHanFlEs6Dtuxi6WdNcSqaRzOHTVIR0L50Y5lqNtN0EyrHs1Vpvb1NUvXzobFe3MZV9R6120ZZcsiNmCSyf8tcUUnVfFZSPtcx5hHJfBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081307; c=relaxed/simple;
	bh=93UC6CvoV4AAmtXgj04tbMk8Wo9cdo9nu2xiJvuCJZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNK+zd2nBPxawOALkqEjTEQlF4LFU0lzc0XmljkFO3Elx1GQtHqW1Xn/cwg1OqkC9UKhRzzCZWrTbDnybAnHml2NBzj1QhT0wUgzG/mHCYMq3Xw39oGjkldxIeMQfYmgjK9Spw29lassAXZLuv/i68hQB41Q5I3qqr39Ly3IU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAZP0lVR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E549C1F00898;
	Wed, 10 Jun 2026 08:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781081305;
	bh=ZL4KJh11hOaBm0PTtLndpRqJiskwi2RiG8rfJeFxW34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bAZP0lVR1jkHUb9UejjrPFrykKuOq3aWD8QiIFs+3DSh/VZarndLzuL41hlgDOU9C
	 98cDQHMmewjdz2zcbjkq6jRVcu4JbcpvFsfRQtLFWT+RHX6JBou0HIOSNljgsajHQ2
	 /ltVNg25M0h37texJTkmWYIf9/sx0STpEbxmSSnN/Iewzq+B2Slp7ntXGQoRc2yjG3
	 tToyEodzGgOdi92GsdAKL3J9xFQURGKlZOVE50gMlA9XNru1ihrq7oSSmR7+AlUvVj
	 dErE3uSzIdgRYb2FUB5FLlD47hdwK2eQjq+AvE6dY8P9ogSlpUYcHNCjQfjgNDJ+M/
	 PFuAlRJrV/Zmw==
Date: Wed, 10 Jun 2026 11:48:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/cgroup: fix resource leak in
 DRIVER_FAILURE cleanup path
Message-ID: <20260610084821.GG327369@unreal>
References: <20260518031541.1552942-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518031541.1552942-1-cuitao@kylinos.cn>
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
	TAGGED_FROM(0.00)[bounces-22071-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cuitao@kylinos.cn,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20B4F667632

On Mon, May 18, 2026 at 11:15:41AM +0800, Tao Cui wrote:
> When a driver fails to destroy an RDMA object during ufile cleanup,
> the kernel retries and eventually falls back to the
> RDMA_REMOVE_DRIVER_FAILURE path. This path sets obj->object = NULL
> before calling uverbs_destroy_uobject(), which skips the destroy_hw
> callback. Since ib_rdmacg_uncharge() lives inside destroy_hw_idr_uobject(),
> the HCA_OBJECT cgroup charge is never released.
> 
> Add an explicit ib_rdmacg_uncharge() call in the DRIVER_FAILURE path
> to prevent the resource counter leak.

It is not the correct approach. A cgroup controls how many resources a  
task may consume, and a "failure to release" indicates that the resource  
usage is still being accounted to that task.

Thanks

> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  drivers/infiniband/core/rdma_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index 5018ec837056..347ec8f6976b 100644
> --- a/drivers/infiniband/core/rdma_core.c
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -917,8 +917,11 @@ static int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
>  		 * racing with a lookup_get.
>  		 */
>  		WARN_ON(uverbs_try_lock_object(obj, UVERBS_LOOKUP_WRITE));
> -		if (reason == RDMA_REMOVE_DRIVER_FAILURE)
> +		if (reason == RDMA_REMOVE_DRIVER_FAILURE) {
>  			obj->object = NULL;
> +			ib_rdmacg_uncharge(&obj->cg_obj, ib_dev,
> +					   RDMACG_RESOURCE_HCA_OBJECT);
> +		}
>  		if (!uverbs_destroy_uobject(obj, reason, &attrs))
>  			ret = 0;
>  		else
> -- 
> 2.43.0
> 

