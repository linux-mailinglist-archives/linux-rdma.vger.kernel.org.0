Return-Path: <linux-rdma+bounces-21377-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBK/LjEVF2px3wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21377-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 18:00:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF2B5E75A3
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 18:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB6D23076B1D
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194A37BE99;
	Wed, 27 May 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LU8i9pAB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CC837B41C
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897035; cv=none; b=LngN2B2NsQIXaE8yzV/4fWlKntoCzGi2501Sqf70krtvI9N+mAeMRsrxiLHHoWdm7qDYvj9eIVUKwieKZwdH3clnyPERokoDYkhwZUX+mfCzoWhwfHlnF7grymufFfAKbEcSJ/8QbTfOrxom1KA9RzovHOY+ze2YSgDI53uFQXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897035; c=relaxed/simple;
	bh=MKktkVFFRwWv3Cl6LemxCXmbDQXtUar98N/gjvcClx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1F2BdgjN2LN1ZVII8pEzUPKeP5Iwqo32ACOW8Vzrrv8aoaHb1KLJFfcIKY3+ojypAUIuEDh/F0RypY3Phq13DvKf7EvWHgWeYYzZLIImaL7wUr2pSftk0bx3Of9Ba7KBXFTwIlYCRqXiyTkmlG2W9oyqGe2y1pGHl/VNXiihWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LU8i9pAB; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso181132426d6.1
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 08:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779897032; x=1780501832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiWhKHGsWED41dTj/kfDsoTq45/iJo8R/r5XOSyJNoc=;
        b=LU8i9pABsYvyFqy4HYuXgVUcZplBdDLhMcbfnSHNNwE9TyVTMqtPXPOw9mEr/iWmnL
         GYfc1S+eE8DnLLEu/TIKLuJdfp/X17klOiiK6i81vH7R5InMV3k7bmCnSwdMeeZgGiL4
         SX/bB1eyDbMNGKYwfhNnnc+QpYQBFhfNTtfcnGo0N44Ojv9quAQN+XlOqp92zTkz+AED
         Jaq/ni11a931ELOPHsXGI5gd8obskTtpMZV8Yvq/Kc+T1s04zBxUGYNTMTTEQc63lw3X
         SAPf93yrT+dx/0EnpmpitgTcOyCNU8x9339u8jf2DJIh4wJ4UyX0/uGPbSZ4BkldWfev
         okSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897032; x=1780501832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiWhKHGsWED41dTj/kfDsoTq45/iJo8R/r5XOSyJNoc=;
        b=rZowxaK6KmY+v7Af4oUAv6QI2IYeTEHenrBdd1EInT1D3H1bTVKbmyyqE4KlJQupoz
         7hR51UMHcGHyjx5IXid3qxFKT3ASLpnI+NQCR8LkXKquO//72q9E4cPk4hxMih7dyOPz
         T2yAKV2iLQj4CwHnO/2+2YT+yositrBXp+uszDWBRzijit5WEiIHs76D5iQAYvq7R/83
         l87GMzlLNp1saf9q6V8hMM+o8hzo1A+6Cr0sizgnUUrrVGRuSY8WUmPiznq/qqT6OF/5
         fJy7vUMX0JGkSw7hXgwomLk5iKVxbfQrvTfj0PZtyPip0cxHIYQKY2POdnvsnwNuBqMv
         1pSg==
X-Gm-Message-State: AOJu0YzxKcJDK5jjfPHfKalP3b7MzwwieGG4hYUj7A8pferDh1bO9+MI
	tABRMVacEUKCZ+56JYh13RqfwLSKFKFTI3kGPxQozszZpTJh52aQtgb7Me/W4jPp2QU=
X-Gm-Gg: Acq92OF4G1VRF1dakwzAY9Pn8lsPQQHirXbXGUaJ2mgMZUZoDrNsxlYmH8AhQDyeGj2
	bNfAWZy5zwZl7LZ1DuPfnx7sCrJtdC3UdPcrXauIleCXgyhyP77Ofw1tEBgxPRjbB7bDzGvkvGG
	AWan3qn9bHxQvL3kOUr/GPFT/947rjbATMdprd5PvSMQ7uWq6U7/iXw+vCt6g5pB+YWCdz3PAUG
	+cc+952lmkPOBCshYMyBj83X3CVIzRPKuXNaqwlPGoFRXYjWdn4pHKTiTdtEsrZmpR1duGg+I+0
	2YZIYsTKwDDlgv0zZv77oTDPn5sdd0MzQHxEq/7t0ioi0XLwV4SKvrQcJ5Q/19zd4X4blSfIPe9
	U3kWHnqqrhO8slQXzMTvDOMgiOP13FqQr6IrmRAiEyDYkUSeIRTeaXYP9lkpWmKJv6inpzr4GPM
	7AGM+gYVNf9jI0efxjKnEPh6E9D+N/LLbT6l0CCfO4pMF/wr1hydSpFU/Uz0wDiZYTFlHRwcwBp
	ogR8ij53ILyjrM7
X-Received: by 2002:a05:6214:4e86:b0:89c:cb57:6227 with SMTP id 6a1803df08f44-8cc6e3728edmr238399906d6.12.1779897032394;
        Wed, 27 May 2026 08:50:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcd3f4sm171607146d6.5.2026.05.27.08.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:50:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSGWd-0000000Eo0q-0oIO;
	Wed, 27 May 2026 12:50:31 -0300
Date: Wed, 27 May 2026 12:50:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com, jmoroni@google.com
Subject: Re: [PATCH rdma-next v7 03/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260527155031.GA3528738@ziepe.ca>
References: <20260526144152.1422310-1-jiri@resnulli.us>
 <20260526144152.1422310-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526144152.1422310-4-jiri@resnulli.us>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21377-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0FF2B5E75A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 04:41:40PM +0200, Jiri Pirko wrote:

> diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
> index 6a78288e27a1..457c49d44467 100644
> --- a/drivers/infiniband/core/uverbs_ioctl.c
> +++ b/drivers/infiniband/core/uverbs_ioctl.c
> @@ -597,6 +597,31 @@ void uverbs_fill_udata(struct uverbs_attr_bundle *bundle,
>  	}
>  }
>  
> +/**
> + * uverbs_attr_get_buffer_desc - Read a buffer descriptor from a uverbs attr.
> + * @attrs:   uverbs attribute bundle.
> + * @attr_id: id of an UVERBS_ATTR_UMEM-typed attribute.
> + * @desc:    descriptor to fill.
> + *
> + * Return: 0 on success, -ENOENT if @attr_id is not set, -EINVAL on a
> + * malformed descriptor.
> + */
> +int uverbs_attr_get_buffer_desc(const struct uverbs_attr_bundle *attrs,
> +				u16 attr_id,
> +				struct ib_uverbs_buffer_desc *desc)
> +{
> +	int ret;
> +
> +	ret = uverbs_copy_from(desc, attrs, attr_id);
> +	if (ret)
> +		return ret;
> +	if (desc->flags & ~IB_UVERBS_BUFFER_DESC_FLAGS_KNOWN_MASK)
> +		return -EINVAL;
> +	desc->optional_flags &= IB_UVERBS_BUFFER_DESC_OPTIONAL_FLAGS_KNOWN_MASK;
> +	return 0;
> +}
> +EXPORT_SYMBOL(uverbs_attr_get_buffer_desc);

This function has to go into ib_core_uverbs.c if umem is going to call
it:

ld: drivers/infiniband/core/umem.o: in function `ib_umem_get_attr':
umem.c:(.text+0x783): undefined reference to `uverbs_attr_get_buffer_desc'
ld: drivers/infiniband/core/umem.o: in function `ib_umem_get_attr_or_va':
umem.c:(.text+0x82d): undefined reference to `uverbs_attr_get_buffer_desc'
make[3]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1

Jason

