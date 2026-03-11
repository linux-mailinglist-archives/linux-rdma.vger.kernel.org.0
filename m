Return-Path: <linux-rdma+bounces-17951-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG9WNSErsWkBrgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17951-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 09:43:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F01425F906
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 09:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C552730F95A4
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 08:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CB33B7761;
	Wed, 11 Mar 2026 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpGe1hbr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24026D4CD;
	Wed, 11 Mar 2026 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217965; cv=none; b=XwRmJOFWyX1isvPJ4pFuFLOgUCUA7dU3cJBoBDQ+RsBGpOkZooVAqtj6Ch2R0hwg5CzAx1i+9RFjXD6KK3Kq4YFZ816iI4RSFOyGOBUBRWIY8CygTUM2/+jRpw2KCb111uL6rgttcZQNjxulHBoOt8MgGAgKflVWwSgf/vSZ2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217965; c=relaxed/simple;
	bh=OFOcMi9IALKzlvmn/o6YfzAE6ZiZanzEDLJ3bnIzhHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fj4YGkfi5zHFsEoFFcxsuyGbTrlhnZEofxHQcoVmbl7iTvyomWv3FARfRq5DpFBSeg+o8UrBXITCxjRvlVqTg+6hFKy+oyJuAmcyhTYe9qo1ignVIdlW0qAo7qxhbwA+tDVjjtJNTZfTCAobV/Fdmxe0yvZyzLqv0jNVM1uEOyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpGe1hbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F09AC4CEF7;
	Wed, 11 Mar 2026 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773217965;
	bh=OFOcMi9IALKzlvmn/o6YfzAE6ZiZanzEDLJ3bnIzhHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpGe1hbrgyNnIxw29629BZMrbmIITMl4cmHH3JTuXgnDLKdKz+dp66JV6pGkSYm1o
	 fd3LCvTR31pFdw/6tiRmjm0X9aPK01PJvFcn4U29vXoW2PLxBztYA5Aj6EreQYU7aL
	 eNqgba/q5jGHEtzfrinmLBXVTb5jMOGCqsW9h0VXf0m5N9CLNhOlTJpVuzN+0kEfcZ
	 Dnx6myUvmry65zVuxdWOE5zV0CEUyMoOYDQqozhuTRLCg6zDcbKQ++oYn4+T1d8Zvu
	 hJFfu56JM8DkKeTLJPwXXN/zizKaWBsAv5sahgkxTGv89VUBDZaXuZGMBvK+/Jl0bT
	 C3ZCvEMpquodQ==
Date: Wed, 11 Mar 2026 10:32:42 +0200
From: Leon Romanovsky <leon@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Use clamp() in _mlx5r_umr_zap_mkey()
Message-ID: <20260311083242.GT12611@unreal>
References: <20260310145727.236094-3-thorsten.blum@linux.dev>
 <20260310212440.0df8180c@pumpkin>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310212440.0df8180c@pumpkin>
X-Rspamd-Queue-Id: 7F01425F906
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17951-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 09:24:40PM +0000, David Laight wrote:
> On Tue, 10 Mar 2026 15:57:28 +0100
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
> > Replace min(max()) with clamp(). No functional change.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  drivers/infiniband/hw/mlx5/umr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
> > index 4e562e0dd9e1..1a6b0ac5c24d 100644
> > --- a/drivers/infiniband/hw/mlx5/umr.c
> > +++ b/drivers/infiniband/hw/mlx5/umr.c
> > @@ -1013,7 +1013,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
> >  		 MLX5_IB_UPD_XLT_ATOMIC;
> >  	max_log_size = get_max_log_entity_size_cap(dev, access_mode);
> >  	max_page_shift = order_base_2(mr->ibmr.length);
> > -	max_page_shift = min(max(max_page_shift, page_shift), max_log_size);
> > +	max_page_shift = clamp(max_page_shift, page_shift, max_log_size);
> 
> Is page_shift absolutely guaranteed to be less than (or equal to)
> max_log_size?

I asked same question here.
https://lore.kernel.org/all/20260310184744.GI12611@unreal/

Thanks

