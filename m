Return-Path: <linux-rdma+bounces-23138-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dAtqGNcCVWptiwAAu9opvQ
	(envelope-from <linux-rdma+bounces-23138-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:23:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA3274CF9C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:23:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eaDdfbdX;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23138-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23138-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51FA0300B1E8
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A43769FB;
	Mon, 13 Jul 2026 15:23:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD195353A79;
	Mon, 13 Jul 2026 15:22:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956180; cv=none; b=ulpP9JTuKo0p2me51YaTCsnXWSCL6wFe04PhiTsMqD/j472P3c9GuZtIjMMYfx7bTrI+R9wc8Fxd42HI3HVp8CTbgjrWV3tc2408rzqZDA2g1bP2oufyJ7PMl/XTBOD39HKW9cyIiTk+uQnv9LYMA4IFzHzoLSW5YzGP3tG/Mac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956180; c=relaxed/simple;
	bh=0YYEYSS/IGj16a1+muAIdyG1NJAaU+H7u5shtlw/7CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/4B6i7xSUa/WZj1BSSgDG5dqgp3zo0gREM/atLSzCmlyw6vdIpXzXE91AIeY97Mvy+wGzjkItnQLSxqhZqXD9wTcPTeacdJfmV8mBfn+9JsFgJeBhUOKaDq4FVPSKLJ1x67SsdcjwwRzjGZitG7lC8G/BM3i4qFVBpUPKJRySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaDdfbdX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597E21F000E9;
	Mon, 13 Jul 2026 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783956179;
	bh=LcD4sVSiqqSJEolFvViBXQG8PPTYn6mUjVJz4B7Yvcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eaDdfbdX0yl1oduOwlwWqfZNS8dYM4c1/nLEUAWeZDarWAEhJvt9OQQQAmyKeOG0q
	 Kmpha++uZDsd8Xp3tDExLPa09iMfozRUAFpbgD5eNoKqMO+Xq/KvT8pKmpBsoQOw7F
	 Kpt7hWVo7scJOHTr/BxBYFEgnQuPR5Efu8ZEa19fPBCSLntUssy2KukquW/mor4lM+
	 9dEh4qrXYIDYIR39eo6OQ9q1e5CyBMqudkjk643onABjrD1V9cEVIX474kRC9uvcA8
	 sEVu8+Qh6xdX1QQcQIWq3EXugQsSFJIm1VQ72hhPKldReNlcm9uk0KiiBvnljkpcSg
	 A6X8EE6+2aQjA==
Date: Mon, 13 Jul 2026 18:22:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, longli@microsoft.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2] RDMA/mana_ib: Adopt robust udata
Message-ID: <20260713152253.GP33197@unreal>
References: <20260713100955.3512145-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713100955.3512145-1-kotaranov@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-23138-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,unreal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFA3274CF9C

On Mon, Jul 13, 2026 at 03:09:55AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Enable the uverbs robust udata interface in mana_ib by setting
> uverbs_robust_udata and converting the driver to the new udata
> handling model.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
> v2: Removed the udata request for alloc ucontext
>  drivers/infiniband/hw/mana/cq.c     | 10 +++++--
>  drivers/infiniband/hw/mana/device.c |  1 +
>  drivers/infiniband/hw/mana/main.c   | 29 +++++++++++++-----
>  drivers/infiniband/hw/mana/mr.c     | 15 +++++++++-
>  drivers/infiniband/hw/mana/qp.c     | 46 ++++++++++++++++++++++-------
>  drivers/infiniband/hw/mana/wq.c     | 16 ++++++++--
>  include/uapi/rdma/mana-abi.h        |  2 +-
>  7 files changed, 94 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
> index f2547989f..a5757847b 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -27,7 +27,8 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  	is_rnic_cq = mana_ib_is_rnic(mdev);
>  
>  	if (udata) {
> -		err = ib_copy_validate_udata_in(udata, ucmd, buf_addr);
> +		err = ib_copy_validate_udata_in_cm(udata, ucmd, buf_addr,
> +						   MANA_IB_CREATE_RNIC_CQ);
>  		if (err)
>  			return err;
>  
> @@ -105,6 +106,11 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>  	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
>  	struct ib_device *ibdev = ibcq->device;
>  	struct mana_ib_dev *mdev;
> +	int err;
> +
> +	err = ib_is_udata_in_empty(udata);

You should use ib_no_udata_io() in destroy/modify/resize flows.

Thanks

