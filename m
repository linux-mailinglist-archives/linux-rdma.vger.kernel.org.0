Return-Path: <linux-rdma+bounces-20665-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOWOHTB3BWoaXgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20665-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:18:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E3A53EC92
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8E3C301D941
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 07:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0073B8950;
	Thu, 14 May 2026 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu1RRe7N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120421D798E;
	Thu, 14 May 2026 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778743083; cv=none; b=Y9b3LASshVZbCLv5kNaALKbJK3wny6YkxTvqTl+bqza4yuEpzHMrohk1U5tRWTI9i0POMy43Elyptsk0nF4FQtl/ouI0hOCQZn73RUNO+sEG1VWQNE21b7gO1zKNDUP8mD1b+VKJGC4caFFd8MEZMJqhZEksXSZ3ehuy8pv+Z4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778743083; c=relaxed/simple;
	bh=qMU/UTjNWbT0vre1acHeAmz/XhdXkB5cvBxnQTCixU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6B/MIEAZvSygJnZ6tGQHBFyFMJ7Dz0BEhTzK7lobbKg9Z9XBKoSrjll4MHQB3Pxk9LziRKQSieWd1ATDNNH7DGeTZ2hpcmeEyXtHfzDs/RiGM9msGX7SA6HAfjygJoUkD3WMFmt6aBGE6/ipVJD7OJ7AVJNDzNhbob5LFTuvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu1RRe7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4554EC2BCB7;
	Thu, 14 May 2026 07:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778743082;
	bh=qMU/UTjNWbT0vre1acHeAmz/XhdXkB5cvBxnQTCixU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hu1RRe7NeOQJbGDX8neVsglQTeyQoGpUHp4bLeS2fsOTz80CDq+ivqUqiKS8W6dCv
	 zY5/koMKndKBmszaLDOL2WupimHbuGFgvaQ+//X94XSNOgMbOUbr7dE7rOtWsTUd8b
	 G+bpg5DTShIYUqEcKNRgqMYn2NWMhkazzEuiFK0I4lkCQ2TzkBVNok9HQw+lANiKXV
	 rl0c4uMlLFUJoAp8plp+juc+xFzFrqft8HAv0sJVh3s9xwh6JsRFzka6BoVR/RetCH
	 Cg+xsYGC/QfcgkYBcIHbwuweaJeYBnpNPN+RB9PZwd/3jWfDcWhvc7dd/53l29PwWV
	 BpFOlkXzLVR0g==
Date: Thu, 14 May 2026 10:17:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Vaishali Thakkar <vaishali.thakkar@ionos.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/rtrs: Fix use-after-free in path files cleanup
Message-ID: <20260514071758.GN15586@unreal>
References: <20260511130804.773204-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511130804.773204-1-lgs201920130244@gmail.com>
X-Rspamd-Queue-Id: E1E3A53EC92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20665-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ionos.com:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 09:08:04PM +0800, Guangshuo Li wrote:
> Once kobject_put() is called on srv_path->kobj, the release callback may be
> triggered and srv_path may be freed. Therefore, srv_path must not be used
> after kobject_put(&srv_path->kobj).
> 
> Both rtrs_srv_create_path_files() and rtrs_srv_destroy_path_files()
> currently call rtrs_srv_destroy_once_sysfs_root_folders(srv_path) after
> kobject_put(&srv_path->kobj). Although the call site only passes srv_path
> as an argument, rtrs_srv_destroy_once_sysfs_root_folders() dereferences it
> internally to access srv_path->srv. If kobject_put() has already freed
> srv_path, this results in a use-after-free.
> 
> Move rtrs_srv_destroy_once_sysfs_root_folders() before kobject_put(), so
> srv_path remains valid while the helper accesses it.

This still doesn't answer my question: how can you access memory referenced
by the srv_path pointer after it has been freed?

  1612         rtrs_srv_destroy_path_files(srv_path); <--- you released memory pointed by srv_path here
  1613
  1614         /* Notify upper layer if we are the last path */
  1615         rtrs_srv_path_down(srv_path);          <--- you are accessing memory which was already released.
  1616

Thanks

> 
> This issue was found by a static analysis tool I am developing.
> 
> Fixes: ae4c81644e91 ("RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_path")
> Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - Clarify that the use-after-free happens inside
>     rtrs_srv_destroy_once_sysfs_root_folders(), which dereferences srv_path
>     after kobject_put() may have freed it.
>   - No code changes.
> 
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> index 51727c7d710c..c9ba9d2d0eb3 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> @@ -295,8 +295,8 @@ int rtrs_srv_create_path_files(struct rtrs_srv_path *srv_path)
>  put_kobj:
>  	kobject_del(&srv_path->kobj);
>  destroy_root:
> -	kobject_put(&srv_path->kobj);
>  	rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
> +	kobject_put(&srv_path->kobj);
>  
>  	return err;
>  }
> @@ -312,8 +312,8 @@ void rtrs_srv_destroy_path_files(struct rtrs_srv_path *srv_path)
>  
>  	if (srv_path->kobj.state_in_sysfs) {
>  		sysfs_remove_group(&srv_path->kobj, &rtrs_srv_path_attr_group);
> -		kobject_put(&srv_path->kobj);
>  		rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
> +		kobject_put(&srv_path->kobj);
>  	}
>  
>  }
> -- 
> 2.43.0
> 

