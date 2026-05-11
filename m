Return-Path: <linux-rdma+bounces-20406-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHNSHoUcAmocoAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20406-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 20:14:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E865142AE
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 20:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DD0C304E663
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14C347B415;
	Mon, 11 May 2026 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF5d2SjZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913447AF6E;
	Mon, 11 May 2026 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523236; cv=none; b=N7CLQmSe7w8yNp8X3i6kUhJ+BALOaf/t9eCqaLHWkCZSeDmu+S6UBB6j70ahi6Zh35c4RiY3WDcEICNKZH7H9JGQhp9O8YO3u5nbav52PR9TYr6jvtrWhGLjmFVwVMxh9MLWOFFZDK/t91yNl+zo69BRPIuudCS49QD6TRsaN/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523236; c=relaxed/simple;
	bh=apKRNyLhmDHY7OfvjfPNGTQkxGTSmJCydOvEIXlMong=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOSDXeRghLxDmHrT7FAbWtWCGacLSqWnblv/x3E7ITR8xG01A0KPF/5rSyo1LQgGk3B1EEZ+wczBj9lal9SDHa6ec+U2aJZH/gx6x09X03gsXoFDZcJuSlCxY1GQbhdGFsmtsq9vnKYiGCTMgXG7bhC+68tDKlfUI0qf2d35X5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF5d2SjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224C0C2BCB0;
	Mon, 11 May 2026 18:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778523235;
	bh=apKRNyLhmDHY7OfvjfPNGTQkxGTSmJCydOvEIXlMong=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AF5d2SjZMdbdrG3Dnnxaeaqm3ajItmaBR/wt3FM+n9tzxK2LQF7UIcTSwiHbv0Osv
	 uX9cXZ/pjb2BETwRyDHOEzDewigXIH84lfeLdBw/RneZ+wDHyBD8MVba91N8sHS7rY
	 IK1xVg70M2NChmbjYaSLdfGfk7F5Hjhg47eZNwATyW3XlTjz1q1OYPcOIWTSv2TLAg
	 8u6kPkkvg/5IRJzu1mfN5GX8tceqAtkSCDZtwYT2Za7vTW2KusuPKDPFfXLQXYmh90
	 gXO3qDO1JdTe1ctHVXgheDk8yxdcGycsXgOPxHes/xS1OGshtkj5Y/l1VGKSjn2Ium
	 ayQ8jtuMCPSPg==
Date: Mon, 11 May 2026 21:13:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "shaikh.kamal" <shaikhkamal2012@gmail.com>
Cc: Roland Dreier <rolandd@cisco.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/ucma: Fix use-after-free in ucma_create_uevent
Message-ID: <20260511181348.GM15586@unreal>
References: <20260503105125.16368-1-shaikhkamal2012@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503105125.16368-1-shaikhkamal2012@gmail.com>
X-Rspamd-Queue-Id: E0E865142AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20406-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,a6ffe86390c8a6afc818];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Action: no action

On Sun, May 03, 2026 at 04:21:25PM +0530, shaikh.kamal wrote:
> ucma_create_uevent() dereferences event->param.ud.private_data
> as a struct ucma_multicast for multicast events. However,
> this pointer may refer to memory that has already been freed,
> leading to a use-after-free.
> 
> Fix this by avoiding dereferencing private_data for multicast
> events and instead using ctx for uid and id, which has a
> well-defined lifetime.
> 
> Tested by running the reproducer under KASAN with slub_debug
> enabled for several hours with no crashes observed.
> 
> Reported-by: syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818
> Fixes: c8f6a362bf3e ("RDMA/cma: Add multicast communication support")
> 
> Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
> ---
>  drivers/infiniband/core/ucma.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index 6e700b974033..8eef10352af7 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -270,10 +270,12 @@ static struct ucma_event *ucma_create_uevent(struct ucma_context *ctx,
>  	switch (event->event) {
>  	case RDMA_CM_EVENT_MULTICAST_JOIN:
>  	case RDMA_CM_EVENT_MULTICAST_ERROR:
> -		uevent->mc = (struct ucma_multicast *)
> -			     event->param.ud.private_data;
> -		uevent->resp.uid = uevent->mc->uid;
> -		uevent->resp.id = uevent->mc->id;
> +		/*
> +		 * event->param.ud.private_data may point to a ucma_multicast
> +		 * that has already been freed, so use ctx instead.
> +		 */
> +		uevent->resp.uid = ctx->uid;
> +		uevent->resp.id = ctx->id;

I believe your analysis is correct, but the implementation is not.  
Are you certain that `ctx->uid == uevent->mc->uid` and `ctx->id == uevent->mc->id`?

Thanks

>  		break;
>  	default:
>  		uevent->resp.uid = ctx->uid;
> -- 
> 2.43.0
> 
> 

