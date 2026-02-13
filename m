Return-Path: <linux-rdma+bounces-16810-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFAGJnj7jmljGwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16810-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 11:22:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E511135022
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 11:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73841300BBBE
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 10:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD7734D4FD;
	Fri, 13 Feb 2026 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg2f1MX2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5895335543;
	Fri, 13 Feb 2026 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770978165; cv=none; b=bQu+4uPw8y9uxbPMZP+2XpMFO5GhD3Qk1LliKseoY5LRw/B6ErLz8j/hRXc1N19foWXvGoCHwW5mWmu0l5HN7uAzHIoVO14GKaxf3K3/R25YYvqX4LbYAewqlDmNOeuSBid0j/J3PadPuD+EbtOsArubh5S3+Kx6FlNdfmmoeAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770978165; c=relaxed/simple;
	bh=9UGh2ajZ04vzYkXM+OtM3fOW6ITnku1TUR5DhZCwOVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgxLOde2qq3KFcQw/+0jei3V7AYYN+VUn1DmL/OTA/hjiYzkV6g97H0J59Szs551jcZ8wm+I2ncxTFZisY7HoBKGkZfDYzD7uKOPejIHOZqwHEP1ebOtGR7Dj9joNcR9fOSo+gnJ7CvTOfgd+xTdeAP8k6W8uTCKRyBlIilKsMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg2f1MX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00815C116C6;
	Fri, 13 Feb 2026 10:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770978165;
	bh=9UGh2ajZ04vzYkXM+OtM3fOW6ITnku1TUR5DhZCwOVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fg2f1MX2H+LxmASOMKP4rRxF67uvIwPXfMnpXnCQrJ4w9c1pJsXiwwkVMlR7B8NVa
	 WkQjrzz1LUQ/szfMerq4dza5Xvf4jJG5m7z9Te0THirMU1qoVCFH01eLK2upbq82Dj
	 kbq59jkDz5Qkpo7yqBYXs3BG/xZSsXx2ugTrh9qk8uaFLT0zWhZaDOQo+YZHRb/c7Q
	 ERKM7i320qVKuYkF0uQYxgoNQTNm2Zx5QdW7WdIKtGfP7kZHBI10RMqCFfrGUQFyuC
	 Uzu/h4q91AlC4KBiNE4WeGDL6oXU6aSk4FpggARB5kBXrvP9CUcMw/1XRY0Zx1X5UC
	 uqGXrMhOwGFCw==
Date: Fri, 13 Feb 2026 12:22:40 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 04/10] RDMA: Add ib_is_udata_in_empty()
Message-ID: <20260213102240.GK12887@unreal>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <4-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16810-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 3E511135022
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 09:45:38PM -0400, Jason Gunthorpe wrote:
> If the driver doesn't yet support any request driver data it should check
> that it is all zeroed. This is a common pattern, add a helper to do this.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  include/rdma/ib_verbs.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index c0dd82a77e7a13..973d9ec6875e63 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -3119,6 +3119,20 @@ static inline bool ib_is_udata_cleared(struct ib_udata *udata,
>  	return ib_is_buffer_cleared(udata->inbuf + offset, len);
>  }
>  
> +/**
> + * ib_is_udata_in_empty - Check if the udata is empty
> + * @udata: The system calls ib_udata struct
> + *
> + * This should be used if the driver does not currently define a driver data
> + * struct.
> + */
> +static inline bool ib_is_udata_in_empty(struct ib_udata *udata)
> +{
> +	if (udata && udata->inlen != 0)
> +		return ib_is_buffer_cleared(udata->inbuf, udata->inlen);

The number of existing callers of ib_is_buffer_cleared() and very
similar ib_is_udata_cleared() check caused me to think that udata->inlen
!= 0 needs to be checked in ib_is_buffer_cleared().

For example, we don't have this != 0 check in uverbs_request_finish().

Thanks

> +	return true;
> +}
> +
>  static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
>  					     size_t kernel_size,
>  					     size_t minimum_size)
> -- 
> 2.43.0
> 

