Return-Path: <linux-rdma+bounces-16809-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB0oE8v4jmnbGAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16809-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 11:11:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C5A134E8E
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 11:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BF65300BC56
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 10:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA9D350288;
	Fri, 13 Feb 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERGyDKTU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6132548B;
	Fri, 13 Feb 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977458; cv=none; b=F/0Qd5ywb5eH4H+IBP4rFDZMQKVoX5sFS7esie+PNdVjuZqJot/nysqz0SpjRF3pvgw2wAXh50CXF6n6ufu8tE2Da4M298bWT/Ky6CJPFY0FHl8HQOicYCHhaVucXwQ39Jkrd7zLgXh7zyoZaYlYS6cFeBA1nZ6XgL643pCrk5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977458; c=relaxed/simple;
	bh=05ziA3jFCmsLsBin1JqX80Gggt8ooeVNYdy1t/iCrTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSNAyewppNkWbdnKlYCuQwjYPQnbUmV4FOBWESISTenPym5uVEn1dJTdByp/nKJXi8yALDDK1WHx2vCvUM1AlslzlFyNjvjpdd4tcM2oDRVoBaWfm+rEROsqvnfrCIuOSW1Qng8t9OeUIf9bSKVbpBM69uKBhX+jNuytYYFBtdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERGyDKTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB813C116C6;
	Fri, 13 Feb 2026 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770977458;
	bh=05ziA3jFCmsLsBin1JqX80Gggt8ooeVNYdy1t/iCrTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERGyDKTUnAd4DTdeLzwXJ2M6fd09yy0xjEHlSyqjyy9AGw1o/DYXuOczBbgNJ6TC8
	 031P39cjtP6UoMTVParjv9DcZbz/hC9UtQttEsthqs9CF5dfdM8Elg/tnJEC7+9tB1
	 6b3ozXIRlUHHQC1bHtjnUgX6epNzJy5aCgKaIBxQ8qjJvRv61UJwFsw/d734c8bv63
	 bAw2oTNIYuuH9LRlP4ETFkylSiAli3rMJ+Y6bkOI7iAUKatXh4STWN6AfBBthf+bqo
	 PWHVVWNr7Uoy2oNxckRe7zmfq7VRCcZwlyXi5Rd6l3p/ptNK2yaiSoimliJpW2uWYU
	 E7SqnTytgQqEw==
Date: Fri, 13 Feb 2026 12:10:53 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 03/10] RDMA: Add ib_respond_udata()
Message-ID: <20260213101053.GJ12887@unreal>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <3-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16809-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: F3C5A134E8E
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 09:45:37PM -0400, Jason Gunthorpe wrote:
> Wrap the common copy_to_user() pattern used in drivers and enhance it
> to zero pad as well.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  include/rdma/ib_verbs.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index bb61cab2ef9a06..c0dd82a77e7a13 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -3177,6 +3177,38 @@ static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
>  		ret;                                                          \
>  	})
>  
> +static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
> +				   size_t len)
> +{
> +	size_t copy_len;
> +
> +	copy_len = min(len, udata->outlen);

Don't you need to check that udata->outlen is larger than zero?

Thanks

> +	if (copy_to_user(udata->outbuf, src, copy_len))
> +		return -EFAULT;
> +	if (copy_len < udata->outlen) {
> +		if (clear_user(udata->outbuf + copy_len,
> +			       udata->outlen - copy_len))
> +			return -EFAULT;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * ib_respond_udata - Copy a driver data response to userspace
> + * @_udata: The system calls ib_udata struct
> + * @_rep: Kernel buffer containing the response driver data on the stack
> + *
> + * Copy driver data response structures back to userspace in a way that
> + * is forwards and backwards compatible. Longer kernel structs are truncated,
> + * userspace has made some kind of error if it needed the truncated information.
> + * Shorter structs are zero padded.
> + */
> +#define ib_respond_udata(_udata, _rep)                                   \
> +	({                                                               \
> +		static_assert(__same_type(*(typeof(&(_rep)))0, (_rep))); \
> +		_ib_respond_udata(_udata, &(_rep), sizeof(_rep));        \
> +	})
> +
>  /**
>   * ib_modify_qp_is_ok - Check that the supplied attribute mask
>   * contains all required attributes and no attributes not allowed for
> -- 
> 2.43.0
> 
> 

