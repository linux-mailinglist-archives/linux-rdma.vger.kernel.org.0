Return-Path: <linux-rdma+bounces-15413-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E337D0BFAF
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 19:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAEDB30A2E62
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ED8274659;
	Fri,  9 Jan 2026 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xadeknin"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BD96FC3
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984945; cv=none; b=LtcvEqJsdoaSKYgx9iP8ZKD5DXAqIjZAJP22SPydrUvpJzlojwZvMPYCjTGZ5gnGjOzJbFE8DOvJvN7z2TG6IzrI2lj+pVdBpZd4tLJ2yNgKSQ/iyO8smagr6PYbaUMe+l9pcO5vYFVoAO+c3r8BT6b94PTCclsCD0YUL+kpItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984945; c=relaxed/simple;
	bh=uIRD2SAGkC3vHH0SoFYDJGs6ZdftL+0iOFOnFj+eixI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1Y9790iBHE1EP36d1WJxo06aXHEuhlQwh57FCdRUKcKyl7/52YgeKCIoZbSK3E5d5aN3dKD7TsAzeAeruGjVVK5q0Zx1hk8Z8FWHvLRvjOkUaxW8xj+IRebBNdyC4MUo/E6nRb5MyF7kDaQNKOuYvPVqEq+FOpOksmlGAATtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xadeknin; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b25dd7ab33so346442285a.1
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jan 2026 10:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767984943; x=1768589743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Jfwvn0Y+YooJ+FLqtp40HMKjCMxznXzLMctLCymL0Q=;
        b=Xadeknin3S++zbkFh+XdNp7Fo35+PsXw7H7flOwpwv+Be7xCqL/JLGHp+4dtcGz14x
         T16QahvX887jX1PG3IqOuVLlx30iAqLrQDiAU+yItuSZToYjpSPpdz90FAX1wN4FRR39
         B/5ckKtHzM+tXgzp1JujJopYqXAdURZXVo1jkq3hgJ9SounTeHMuci67rt7McbhZ3qPM
         qxF3DBdR/U+ImP1kVA/Q78D4OLtkGcH1HaCeqBtHFgCB9IDVBlKvNO+t//6m6hreuv+x
         TL9NoRc8tej/oP7va/P08QxWM6oLqlnS0jtRomS3ZHIyFsrmMYL7nQZdsrjzPoW+RPr2
         V6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767984943; x=1768589743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Jfwvn0Y+YooJ+FLqtp40HMKjCMxznXzLMctLCymL0Q=;
        b=pgyG+xxocPhS8P1CSuXPo+iuhpywz9o48JpQ+85zG/aMIwEFjBV4vPyDZ8ID50E0aA
         h7tklHnpkvP/liDByIYne7YvHo8KbYCiKJ0N0RP5GsvAi3Se8RedrvRd2cv+XdsjqxhS
         vpqJUeqDnIml7cb25XzsO76+cyPr4YPd7e/Wn6V6tnIB2EyEJaj0E/ASJte2gZI51iWs
         GYKTkeILIbPDt3g8VjAWsOI6WNIY7RpZIH4KNX/0DH9hSts+Vjz/2XQZEFH1eaFngMug
         HZJ9rCWfFwvYXnCTSa27zfkUAKd8d5qr9oqBCjRRsbJ5kE1xnG1kMjAusJv8esf/0pd1
         QEOw==
X-Forwarded-Encrypted: i=1; AJvYcCX+qEiJyhJC4Mgnjgp+kcucwOdpLKAiFwVITTJhDoosSKGExCzKLp5OuKZp31h+889vJ5Cw32ggMQvN@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwIrc5eYIp9NmeSnWKrTgTwEzn0gkTd6nklnd0nECbo42aUfj
	VdktiE3fEG3p3c9x3jR7Xruy+DWz/G86fly/xjJWyeASe54Nf8yxC5pXdGH6Zms70+E=
X-Gm-Gg: AY/fxX67W/zryB8NZIrVFQxd8pHOM5intlijfAwgIAJWE4RMSrJTUDTwf5BPaSlMC99
	JWr2QRAUqHszm03ty5VqRKckA8J2Q1xlxN2LQbrMmOqZawnA8VQ5HPTKz/YfxU2V2XGzIG4+dPB
	yEj92RbnvnIlFOjYhARb88hdzZJyZ0h3LFBO905CCgrb2smaiyBIu6BZyZsrBwoLYCy9uIkNB4r
	laPVW8rNpHZVGF2yC8BGuO+djRGJl61L60UC1PtBQY0LBotx2aVRnLbxc2CGzvU5VJX6x0aHvak
	PEfzRJz5XI7NxAkLPfi77KIARLyzWk+Yu+BRizg+HGM3GU2rZjDB8ca0QLsPys7mYWgQR1+9GFz
	saFcmYC0SZSLCcNoQcf/BOr9G6jC7ympoUBu7JweB9V/Qt3AuVrvigTKGm+DdYgCYDWoBVMaEXX
	gAepxTHsU049jE9mTc8prOpMvIcJhGMAR043cNiEM3w+CQaxVF8jV7T5n4bWwRCEeT8wc=
X-Google-Smtp-Source: AGHT+IGSJpDWhso+1BpCgrD9khCE6me+jV7S4uU0Q8jxP3Zld/IpT7ibMdMGaHx5vOhxoLIbaedmeg==
X-Received: by 2002:a05:620a:2a09:b0:8b2:e5cd:fa42 with SMTP id af79cd13be357-8c3891b060cmr1459603085a.0.1767984943161;
        Fri, 09 Jan 2026 10:55:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b8573sm851954585a.12.2026.01.09.10.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 10:55:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1veHeA-000000037bn-134W;
	Fri, 09 Jan 2026 14:55:42 -0400
Date: Fri, 9 Jan 2026 14:55:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v6 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR
 verbs
Message-ID: <20260109185542.GM545276@ziepe.ca>
References: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
 <20251224042602.56255-4-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224042602.56255-4-sriharsha.basavapatna@broadcom.com>

On Wed, Dec 24, 2025 at 09:56:01AM +0530, Sriharsha Basavapatna wrote:
> +static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(struct uverbs_attr_bundle *attrs)
> +{
> +	struct bnxt_re_dv_db_region dbr = {};
> +	struct bnxt_re_alloc_dbr_obj *obj;
> +	struct bnxt_re_ucontext *uctx;
> +	struct ib_ucontext *ib_uctx;
> +	struct bnxt_qplib_dpi *dpi;
> +	struct bnxt_re_dev *rdev;
> +	struct ib_uobject *uobj;
> +	u64 mmap_offset;
> +	int ret;
> +
> +	ib_uctx = ib_uverbs_get_ucontext(attrs);
> +	if (IS_ERR(ib_uctx))
> +		return PTR_ERR(ib_uctx);
> +
> +	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
> +	rdev = uctx->rdev;
> +	uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_DV_ALLOC_DBR_HANDLE);
> +
> +	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
> +	if (!obj)
> +		return -ENOMEM;
> +
> +	dpi = &obj->dpi;
> +	ret = bnxt_qplib_alloc_uc_dpi(&rdev->qplib_res, dpi);
> +	if (ret)
> +		goto free_mem;
> +
> +	obj->entry = bnxt_re_mmap_entry_insert(uctx, 0, BNXT_RE_MMAP_UC_DB,
> +					       &mmap_offset);
> +	if (!obj->entry) {
> +		ret = -ENOMEM;
> +		goto free_dpi;
> +	}
> +
> +	obj->rdev = rdev;
> +	dbr.umdbr = dpi->umdbr;
> +	dbr.dpi = dpi->dpi;
> +
> +	ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_ALLOC_DBR_ATTR,
> +					    &dbr, sizeof(dbr));
> +	if (ret)
> +		goto free_entry;
> +
> +	ret = uverbs_copy_to(attrs, BNXT_RE_DV_ALLOC_DBR_OFFSET,
> +			     &mmap_offset, sizeof(mmap_offset));
> +	if (ret)
> +		goto free_entry;
> +
> +	uobj->object = obj;
> +	uverbs_finalize_uobj_create(attrs, BNXT_RE_DV_ALLOC_DBR_HANDLE);
> +	hash_add(rdev->dpi_hash, &obj->hash_entry, dpi->dpi);

This is out of order, hash_del is done inside bnxt_re_dv_dbr_cleanup()
so it should be before finalize, but it isn't a bug.

It should probably be written like this:

	uobj->object = obj;
	hash_add(rdev->dpi_hash, &obj->hash_entry, dpi->dpi);
	uverbs_finalize_uobj_create(attrs, BNXT_RE_DV_ALLOC_DBR_HANDLE);

	ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_ALLOC_DBR_ATTR,
					    &dbr, sizeof(dbr));
	if (ret)
		return ret;

	ret = uverbs_copy_to(attrs, BNXT_RE_DV_ALLOC_DBR_OFFSET,
			     &mmap_offset, sizeof(mmap_offset));
	if (ret)
		return ret;
	return 0;

Jason


