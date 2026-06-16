Return-Path: <linux-rdma+bounces-22276-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L/gaNXRTMWpngwUAu9opvQ
	(envelope-from <linux-rdma+bounces-22276-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 15:45:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 472246900FE
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 15:45:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Ld0iLY9I;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22276-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22276-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CC81324C7F9
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 13:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCA2330678;
	Tue, 16 Jun 2026 13:40:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B07D30C345;
	Tue, 16 Jun 2026 13:40:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617214; cv=none; b=TsE+UryD10JZUjRjX3gwjTk7Uw8u49YO9LPPgej7vp8HbWNvoU+UsWqAi6xYl/QqlLUxIJWPFeDslJsrQD/VZtQ8DcynZs410wMjML/vd3w22u9WWHg4G4XDsdWTLK8m2eyyTx6MU9BuOZacbLvcyvGODUNS36wTsEqg7IqXwwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617214; c=relaxed/simple;
	bh=wA8wW4j3hNvH6XU6Pxe8tuS8j0Q5lz1tEPHcKGyaS3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLL4jerc165UUeLVJkPN4l7Zja2d6+O+Ynv/qy7LqpkE1mbm04BfQtoKKPwcEO6K5qYvhj0RcrArNJK1rEBF1KP/dPzqndNkKs/HzMcjyUdPrNegHOXP2X1Xdoh0h7HhyYcVJW7CzTx62eHnXM4JnOjBBvWQyTC7pGCs81WqiCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ld0iLY9I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAFB1F00A3A;
	Tue, 16 Jun 2026 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781617212;
	bh=9wpiz9obU8g5CgCdynYedfjfq3YjfyVdL+5vnduwH0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ld0iLY9IgD+oJuC/zIviQjB1K5QnZkoSd9Wo7trZTQmtffn20/bsnGnkmdtVNKcG6
	 0oW3ScGlbmzpe606mnT9ueBBWpwtxrxrmWV58buxRxzqhaYZHmdlxrCqIljaF/6Fys
	 nzr7Dp7GlXohyR4yqlVMT/3YjItecEUL0NAwWDww=
Date: Tue, 16 Jun 2026 19:09:06 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
Cc: stable@vger.kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Kamal Heib <kamalh@mellanox.com>, Amir Vadai <amirv@mellanox.com>,
	Moni Shoua <monis@mellanox.com>,
	Yonatan Cohen <yonatanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zhu Yanjun <yanjunz@nvidia.com>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.1 1/3] Revert "RDMA/rxe: Fix the error "trying to
 register non-static key in rxe_cleanup_task""
Message-ID: <2026061651-affected-ream-c0b3@gregkh>
References: <20260605170349.1524-1-vlad102nikolaev@gmail.com>
 <20260605170349.1524-2-vlad102nikolaev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605170349.1524-2-vlad102nikolaev@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vlad102nikolaev@gmail.com,m:stable@vger.kernel.org,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:kamalh@mellanox.com,m:amirv@mellanox.com,m:monis@mellanox.com,m:yonatanc@mellanox.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yanjunz@nvidia.com,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22276-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,ziepe.ca,mellanox.com,kernel.org,nvidia.com,linuxtesting.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 472246900FE

On Fri, Jun 05, 2026 at 08:03:27PM +0300, Vladislav Nikolaev wrote:
> This reverts commit 3236221bb8e4de8e3d0c8385f634064fb26b8e38.
> 
> The reverted commit is an incomplete backport of upstream
> commit b2b1ddc45745. It added guards for req.task and comp.task
> cleanup, but missed resp.task cleanup and left it before the RC timer
> cleanup, unlike the upstream fix. Revert it first so the correct
> backport can be applied cleanly in the following patch.
> 
> Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 709c63e9773c..05e4a270084f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -788,11 +788,8 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>  		del_timer_sync(&qp->rnr_nak_timer);
>  	}
>  
> -	if (qp->req.task.func)
> -		rxe_cleanup_task(&qp->req.task);
> -
> -	if (qp->comp.task.func)
> -		rxe_cleanup_task(&qp->comp.task);
> +	rxe_cleanup_task(&qp->req.task);
> +	rxe_cleanup_task(&qp->comp.task);
>  
>  	/* flush out any receive wr's or pending requests */
>  	if (qp->req.task.func)
> -- 
> 2.43.0
> 

This series does not apply to the latest tree :(

Are you sure it is still needed?

thanks,

greg k-h

