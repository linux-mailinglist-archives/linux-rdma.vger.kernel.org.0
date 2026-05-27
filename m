Return-Path: <linux-rdma+bounces-21396-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJb8NagsF2rd7wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21396-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:40:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 369705E862A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 010ED303AFBE
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D893DFC92;
	Wed, 27 May 2026 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Iy0irSCj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C312F585
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903635; cv=none; b=t/sl/LAKo7vn/PePn04OKv70RXryIAxI54Jsf6esa74w8LwtLcWmYu4cItUI3xhgl+YA8WnA2pWK36humpXjwy29y6rTb1xq/yvV0r1N4Ig7GTwMEvROAoI/vqkAKtSLqksihqbJcacWSo+EjPR94JW0AzQBp0Hjp9hzqRvbg4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903635; c=relaxed/simple;
	bh=EYZBtGLYBsDMKWxI1Hn3I+3zNtIMx6Z+JvaXyEc4hIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ptba1zeFFC2i8sFeONoGE4tcZ6HqcYvnn9IJOQ6pC0+qiQt4PNdJeKbBrE5AUqvnPOS/+y6AwJOrV7jE6++zBFpcuwCyFuaMREjVqRelxnHt6qiXGvsf7Tl9ubprWqyOrI1p//LXIR47hJdeW4saRE5+gGzShR+NQuxzIrnBCu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Iy0irSCj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50faeb8317bso108337011cf.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779903633; x=1780508433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqFeTv3zQ1eZrp+0fYGu1eja5BsXVK78baJ0ZjzzUg8=;
        b=Iy0irSCjju4O70dPU8yx2/Qk1JTSBT70eMdxa0zxywEIHCsjoXWlra+VPbkKrnqw6K
         U+G+oc5RDZsI2ETB2IoYKxtrpRMjCzgoAaVPCUgjiT2QaWs72/dEUfxqh5peeVZFEHib
         iN90NV2ktYXoDeAD63vfouCf/pUgsKz/FQeeBqc+am7K5XIXNa4BNlb+1h6/JyLx5AYL
         FeFLBBJR80TGnxQLZEshKXrjZ2NM0Kay5CcOJrWWf4SanuXQa86W7EvlCO5oKwh5ZSYM
         perYHZ227Y8d92tyNle9TpiO/T3XO0xqnCvvSdJMPaIbL+9d3WHGu9G5Tj6vPGC0aa/P
         75Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779903633; x=1780508433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqFeTv3zQ1eZrp+0fYGu1eja5BsXVK78baJ0ZjzzUg8=;
        b=nNeCdT3xouaXBv9sFBYAAbgDrcHVBnYloYz1TAOss2cFc1UExbQ+lj94cfTlkrWtCu
         vL646eYnQBkpNWj515HIyozbaPVU+7G76Nb3r/pQqB+7yF3VkcoiQReaccNWq4PpKazb
         r/7tCgW44+zNwWoX9GQCq5bU1bDUS83aqU0Gul0+u+g1Bwk+kxAMb/Xr+JnfAgzhmm3K
         oDGhlBNLxE/5rPFiM6Z0/8uTeipwOmxaDqei6mcZXQPMwRvVe3xnETURyhRz0i7Q7P3a
         0mngVXVPXpnHsQoID8VTMUd7Z/b6ujPsBq2EwQgax6yK59m7BcvB7fZugStN4PZJHV23
         CkVA==
X-Gm-Message-State: AOJu0YzQrp+bQ74lIC4HBmCNp0YSLrcdr45zTBpYnogZct42A8M7bwUS
	3Of5L6QM5gScbl+CQWp7PJuk+ydmIw/KzBiQXnQgs/uzhJ20l/rVQsiaKjCfG1Rrvj4=
X-Gm-Gg: Acq92OG8DzmfFxDfLILRs/RleuMN0AMpID0wq45dQ2jKcefEc1QyvhaZAgYbpJ8iahi
	dV+nHHvIYRepRXEI9xNiJEjdTe0mUgiBF/ImVtui2mJ8BE+9ov+A3DndNycU2s+43Ca1gFNkH9e
	hoW6A4kWp72WAXH8aqlQVtKsKm6YvzQBNuJuIZaxvEk8cUz+q0P4vIacYKVqfarWeIMUhJcZ8p0
	Gp91KIn4VdoS8Cy12YliEwaq9oDicDvPRnmKqU5cQHyDC/SDrbt+lURZfYfVek46+W8fjHSzDoV
	y2nE/KhEhVqmtK8P5UixE1i1NHLYTw0p3Q1II+euyojCMxjLCW+IDA5Y7YtTmZH8I4k5Stl8mKg
	1dOUoXkCsgS8XuzhY73Zjn7JgRBjAR2n5NR1tGY+JRTbvUL0pPdZp41YyodFPhymEsKzFfJaS6w
	lb+j17aulCqlVneaGJuO8F1u7vkJR/iidi5OzxrjX8qaDprWxcu1d4rZnoW8isja5c2CUgWfQNn
	Wb/vw==
X-Received: by 2002:a05:622a:5c08:b0:516:e833:64f2 with SMTP id d75a77b69052e-516e83367b9mr265338291cf.12.1779903632537;
        Wed, 27 May 2026 10:40:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8132f780sm174837726d6.49.2026.05.27.10.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:40:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSIF5-0000000FLny-2Kcj;
	Wed, 27 May 2026 14:40:31 -0300
Date: Wed, 27 May 2026 14:40:31 -0300
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
Message-ID: <20260527174031.GB3528738@ziepe.ca>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21396-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 369705E862A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 04:41:40PM +0200, Jiri Pirko wrote:
> @@ -862,6 +884,9 @@ int uverbs_get_flags32(u32 *to, const struct uverbs_attr_bundle *attrs_bundle,
>  		       size_t idx, u64 allowed_bits);
>  int uverbs_copy_to(const struct uverbs_attr_bundle *attrs_bundle, size_t idx,
>  		   const void *from, size_t size);
> +int uverbs_attr_get_buffer_desc(const struct uverbs_attr_bundle *attrs,
> +				u16 attr_id,
> +				struct ib_uverbs_buffer_desc *desc);
>  __malloc void *_uverbs_alloc(struct uverbs_attr_bundle *bundle, size_t size,
>  			     gfp_t flags);
>  
> @@ -920,6 +945,12 @@ static inline int uverbs_copy_to(const struct uverbs_attr_bundle *attrs_bundle,
>  {
>  	return -EINVAL;
>  }
> +static inline int
> +uverbs_attr_get_buffer_desc(struct uverbs_attr_bundle *attrs, u16 attr_id,
> +			    struct ib_uverbs_buffer_desc *desc)
> +{
> +	return -EINVAL;
> +}

This mismatches needs a const:

../drivers/infiniband/hw/mlx5/doorbell.c: In function \u2018mlx5_ib_db_map_user\u2019:
../drivers/infiniband/hw/mlx5/doorbell.c:141:51: warning: passing argument 1 of \u2018uverbs_attr_get_buffer_desc\u2019 discards \u2018const\u2019 qualifier from pointer target type [-Wdiscarded-qualifiers]
  141 |                 err = uverbs_attr_get_buffer_desc(attrs, attr_id, &desc);

Jason

