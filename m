Return-Path: <linux-rdma+bounces-18187-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAwACBsuuGnhZgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18187-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 17:21:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F9529D40A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 17:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9920B307AFFD
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CA5332EBC;
	Mon, 16 Mar 2026 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK5YDJ6+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FB5332913;
	Mon, 16 Mar 2026 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677675; cv=none; b=EXapxVwk2kZLKkWvH1OEGa2+LNoLVd9evcna/RRCs0R5AO9OCQbMqqot5VxjXm4QmQgZrIAFvT2dknxi9C5Ut3cM0XnS9dRQE1EedHNHyipI+31Mj5L2umTDisw70b2P1UI3XQqiacP9M2fiFCoMfbMjVJYJ3OUiZ3x2xKNj9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677675; c=relaxed/simple;
	bh=is5HxqVpX5arWjtIEaX2O4WWt03cRdaxTzMEe4aXiNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qniGTIgvDG+fawECKx4TxKdXt4BZRj0gtFuGbKsXUZtSsTDgUhQR5jj6D+r+3A1VDYdM9P9eaWYXyLk0s+VaHLsebEMFmw6OQ8/GVTqb6cajhhDarRRa1C0jBADEhUeEH7a8NlV3pqUMChi+xeThzjBnaGFzJj3xwbgl8HB7zXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK5YDJ6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A625AC19421;
	Mon, 16 Mar 2026 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773677675;
	bh=is5HxqVpX5arWjtIEaX2O4WWt03cRdaxTzMEe4aXiNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TK5YDJ6+3+CPnZ7926lAv3MzsLL0H1h56sIm7ZvW+Bi8en4qldMscy3Wgw9WLeDLv
	 uXDkuY6Y4jgBHKP7LRRApF7mYi+mdFQKANRTvzSZ/e+zhJWhtePRT7Ii6X0qVU9EsQ
	 07c22wx04BT8e2eKxQb7nyQT73gujRfD6hGqnF+ygoh+mAx5g4wbRNcOtlh6wa9xq7
	 9/XOYIiqmIP3d+iLJ/RbJtY+qwx/Pk9lLcAIUhBP/SK6JcKiFNt9pk1+94we7HhRKR
	 8MzgZvqDslQygadWCNVftzeBeZsWLUKzCRhqh8oXHv92Emy9fF7PooRHjemN7/Ciax
	 t9x4t8E/5wt3w==
Date: Mon, 16 Mar 2026 18:14:30 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: memory windows
Message-ID: <20260316161430.GF61385@unreal>
References: <20260306105758.508579-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306105758.508579-1-kotaranov@linux.microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18187-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 81F9529D40A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 06, 2026 at 02:57:58AM -0800, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Implement .alloc_mw() and .dealloc_mw() for mana device.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
> As I see that Jason's rdma_uapi is not in the next yet. I will make a patch
> adding his helpers (e.g., ib_is_udata_in_empty() for mw) with all other
> api calls.
>  drivers/infiniband/hw/mana/device.c  |  3 ++
>  drivers/infiniband/hw/mana/mana_ib.h |  8 ++++
>  drivers/infiniband/hw/mana/mr.c      | 57 +++++++++++++++++++++++++++-
>  include/net/mana/gdma.h              |  5 +++
>  4 files changed, 72 insertions(+), 1 deletion(-)

<...>

> +	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> +	if (err || resp.hdr.status) {
> +		if (!err)
> +			err = -EPROTO;
> +
> +		return err;
> +	}

We already had this discussion about this specific pattern.
https://lore.kernel.org/linux-rdma/20260127141929.GV13967@unreal/

Please fix it first.

Thanks

