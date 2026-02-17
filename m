Return-Path: <linux-rdma+bounces-16962-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHoOBW+3lGlMHQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16962-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 19:46:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A7214F508
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 19:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71A66302E843
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 18:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764A2673A5;
	Tue, 17 Feb 2026 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d+iXRrZ3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA97E372B54
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353964; cv=none; b=pvFlUMK3QK9kpQ2wUPn0qd238qGuIpISbDtVo4+wC8W1X+cjZrmGLU8+pv6HOuKuDeACU5Ah6skIHlpFu0Hz+TXMdLuYfWbh7dorLAMBAsNHK18FTvJxG+DItd5BIgwZJGMUA/bLErzzJ/utmUiOpsQop3VQF7gyggZ9nSio6N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353964; c=relaxed/simple;
	bh=gLOX9axZmvuYlPmEFksafGKlKQwA848/3ambpwp2NKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS+fj5vLhVQRcllfG9WCR5/Yi8X7S6oOtiFH2bSNJkMssBQomlZvqTO3J6KS59TqMntvCRp+SG7hAPJiK/iF70/86GCfWY0ObCLt5X5lcFJhl4qyRcz70gOf++ls0f5ADuQZq8uZunyMaW9UOyS+a/KYWu0AWYNXXxOAu3WXcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d+iXRrZ3; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb40149037so490234885a.2
        for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 10:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1771353961; x=1771958761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fO1oOJOctsZMVce71fgQqJNdo0ApkND023m9f6D9Q84=;
        b=d+iXRrZ3JEm5kNLibjufTIltgSGrwZU6/A0UMfottFh2jhkzLXPkQD7DIO3hcSdQh3
         15o2SXwq1iOsqjQyRzpXSaF1FeKsLlWkgLKgFGN60G12Of1tavjbPLsPEevxFIw608LA
         NzJYZAp4y5QlCZFjFGjxBgPjl8hjl1vZb+fka3hrggLd93/+GWdo6u/zOZiBo474PvEF
         zqlhdMxB/J87nPyRyN3yknvE/f2SgHz39vuDE3XaTI4jyenqF6YJ1bXVso0W5VXuKiwa
         H+FoZGjk9riga8iHaBh2zU25tDKYLZRIrYOsCBg0byLjVb20rNFlzmoMDXdIqDecOuqu
         vfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771353961; x=1771958761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fO1oOJOctsZMVce71fgQqJNdo0ApkND023m9f6D9Q84=;
        b=o/lfgNqy6RX2TvUuhVRt3XCBWgJZTwoMBhpdrb2HfpwKJImrJAjQvE5LjxKhSUmZfi
         CIhbzt29+75M4Du7VgY0D4qEJrz0LNTv6Ckgm2MZd7NDaSB2H379qAVVpYYi12++kyKI
         oXNLdH8vpAy97+MvF+JtrJQhFHjG36/UUkAuhm/Ob61xfQ6KbBWJNMY8RBAXLu0g3N0R
         u9xcC/gr4HM0HqmzdqndBN/oDP+Blg24KlKbzXtlIIU399sF6fcsvrsjc5xzmqo+cFFO
         HJjbL7VUes+rbSPQuhXuvdKynT9uHT+traV65LBpxWV3Qt+5xFqP08Rrru5y9GtJq+Nj
         RsIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW8SBj7w24Gy/khAmjgA6lYHFHxfg8CSsJS8Tu28TXIjXlHcuzE/3nmQ4w/qBl2//Y+EL5BZVbPo+c@vger.kernel.org
X-Gm-Message-State: AOJu0YzwjjynZzLVg76ReuQd03glIqPkyccJSkXJcUDaMrU7fHlGlxmz
	Bs7qTzbwAJJsL4opfqt5f/+eVOE0TkHwWbNK9+724OW0FczMAEl8zOEglYwP38tWNqY=
X-Gm-Gg: AZuq6aIdSsum19UI48FEbfNdAwNJzMDIkptUa9hVVRERO9Z6fc1oTnl7hymTb8eMGhd
	+HtNnLV5fDMhmnJPQWerkdzDlcbP9ns/3YO4kB657rSIGk0pO7X0tdG2VQ5i2C56HpRSeLYKhB4
	X7Bu+230KeBbGfTbtlopoiEAFiA7rvtsc6XHpqkCVc52g9+cbUZPOsu7Ix9uhk+LgeUH23v0gk3
	6nuC3uaZxGsiR/ZK1bNGensFYK4K/upOp4kMZLsMDXJdAM1Z4r8yhIciZb1gHAAy6EJd/MvMYO8
	/GNrt4ZbjEJpwsj1vPKcD4IGYM2MVGBm60TPNG3lybnGznEtzRl0dai+no9o3LrapjspL9ePIR4
	LLpG/bM1yOw92trdkcy+qoqLXikQWTARcfds9z2TsKQqs4wXCDnsiaVov710PuCVF332oZq3yHz
	TweNiqvkrGsSoqdKBetgcegDbb9LclVUVMGSPaXkkHVUzrch6snntC47LKeT3wAhEvcEZyGfOEy
	FYhDgc=
X-Received: by 2002:a05:620a:4011:b0:8c6:adfc:48f4 with SMTP id af79cd13be357-8cb423bc6d9mr2010954685a.37.1771353961109;
        Tue, 17 Feb 2026 10:46:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c7e71sm1743302685a.30.2026.02.17.10.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:46:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vsQ59-00000005A2u-2ZSA;
	Tue, 17 Feb 2026 14:45:59 -0400
Date: Tue, 17 Feb 2026 14:45:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com,
	leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC] RDMA/irdma: Add support for revocable dmabuf import
Message-ID: <20260217184559.GP750753@ziepe.ca>
References: <20260217182116.1726438-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217182116.1726438-1-jmoroni@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16962-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 81A7214F508
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 06:21:15PM +0000, Jacob Moroni wrote:
> +static void irdma_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
> +	struct irdma_mr *iwmr = umem_dmabuf->private;
> +	int err;
> +
> +	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
> +
> +	if (!iwmr)
> +		return;
> +
> +	/* Invalidate the region in hardware, but do not release the key yet.
> +	 * This will either invalidate the region or issue a reset. Either way,
> +	 * the HW will no longer touch the region after. If successful, the
> +	 * region is marked as invalidated so that the real dereg MR later ends
> +	 * up skipping the HW request.
> +	 */
> +	err = irdma_hwdereg_mr(&iwmr->ibmr);

Er this command issues:

cqp_info->cqp_cmd = IRDMA_OP_DEALLOC_STAG;

Really need to explain this better, I forget how iwarp works - but you
can't release the rkey/stag in a way that something else can get it
reallocated.

Generally the way to do this is with the IBA defined reregister MR
verb and change some property of it to do revoke, eg change the PD or
make it 0 length or something like that.

> @@ -3599,7 +3639,7 @@ static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
>  	struct irdma_device *iwdev = to_iwdev(pd->device);
>  	struct ib_umem_dmabuf *umem_dmabuf;
>  	struct irdma_mr *iwmr;
> -	int err;
> +	int err = -1;
>  
>  	if (dmah)
>  		return ERR_PTR(-EOPNOTSUPP);
> @@ -3607,31 +3647,43 @@ static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
>  	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
>  		return ERR_PTR(-EINVAL);
>  
> -	umem_dmabuf = ib_umem_dmabuf_get_pinned(pd->device, start, len, fd, access);
> +	umem_dmabuf = ib_umem_dmabuf_get(pd->device, start, len, fd, access,
> +					 &irdma_dmabuf_attach_ops);
>  	if (IS_ERR(umem_dmabuf)) {
>  		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%pe]\n",
>  			  umem_dmabuf);
>  		return ERR_CAST(umem_dmabuf);
>  	}
>  
> +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> +
> +	err = ib_umem_dmabuf_map_pages(umem_dmabuf);
> +	if (err)
> +		goto err_map;
> +
>  	iwmr = irdma_alloc_iwmr(&umem_dmabuf->umem, pd, virt, IRDMA_MEMREG_TYPE_MEM);
>  	if (IS_ERR(iwmr)) {
>  		err = PTR_ERR(iwmr);
> -		goto err_release;
> +		goto err_alloc;
>  	}

You also need to be careful of races here because it could have been
revoked already. Also notice if this ahppens private is NULL and it
will crash.

Finally, we don't actually support revocable mappings at the core code
level. We either have fully pinned or fully movable, so this is not
right to just change to ib_umem_dmabuf_get(), that assumes the HW is
fault capable.

Probably what you want to do is add a revoke callback to the pinned
importer?

Jason

