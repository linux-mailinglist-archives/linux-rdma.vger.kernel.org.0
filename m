Return-Path: <linux-rdma+bounces-16737-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBHnJBCCi2m+UwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16737-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 20:08:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE1D11E821
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 20:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 287673005332
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 19:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD3301717;
	Tue, 10 Feb 2026 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oiSBHrQN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B12F25E2
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750474; cv=none; b=WLiyuyVHtSLFsvJAiQHAFigcSrjFWxxWcxHjqwgY7QJleit0kw3uJfqOZcOz+utl24EyTGVoFTs2iavr+y7tKFx7s1oyc0xlDQd/ojOmTTX6FbG1/02vv+3FdZr1vMHiZq5jqU7oZHmXKwycAEYY0g3t6El744j6idLgUhwQ5PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750474; c=relaxed/simple;
	bh=MDViR/HZSl5zSkFDfi4h/To9TIWDFQmbzg+uU82Qk0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncnihy1pS0WqugwraGGnWL/UQB3+6ZTNP2f1ZUis8lZiopsHujCQtZyAi1/YTRO1jnopPPFZX2kLQF40+5MfT0PVE0LwL8KkyZeQYmNiwu3Fy6RlOqzyLoxcuaXgCMvGgHbJ5mGRnSBrbKp+s8AvFd8HrqycVoQ8npwinooEmzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oiSBHrQN; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb1c4679ebso176873685a.0
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 11:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770750472; x=1771355272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S3nz05TfWVaHu8QaucgGIJES7rsZcIfH8q2MA1zKWFg=;
        b=oiSBHrQNdoD3Y8lD7Usru92DL2cf2iXo1dGWbpdznXAnP3mszqEvPCRQqJIngVo+WZ
         bDNpkaGvl94fhuYSodceTGK692oG26FxfKoWsu9Gmaw4I45YEMm/BLnJfRMERWKgNhHF
         su0p9tBwZVG1QUhln4Z2Y7tEp30Hq1uZlnPymydQFaFGb1S8cZTFoO+G5v4Zgd/iJkxW
         I0djiEPzQeAYlayAku3cGWiM+35cEUYnrHgYUbzCeaOXPj0BCBZUwRCm9FVtjhd6dbbH
         /9A4W3yKpMC3RwPQNHqr0C0sVrTcyrK7csryeWLpSLtZKo3G81jIId+mMEa0zAQr7DQe
         6CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770750472; x=1771355272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3nz05TfWVaHu8QaucgGIJES7rsZcIfH8q2MA1zKWFg=;
        b=PIFjU/ED2sfCkfiLLUAM2pHxr6NSFg3vYALn5/EnqqHEe5w9IrgtHy37DuyzKfybG7
         jO/FoIsd39J82vmxTNvcadHzqqHzpgQ8tkqkFaYZfzaLOJBDlKTDmBcN49JUcBS4coTq
         65q+HKxVsKr1joaS6VBQcnysNzO6RXHdxbph3KEyCHclFJlAUTgi1s8F3Jfqv/bEMYKA
         05mAbyz07xKVKKC898ZQGLlMulEdDBYUdy3v53YbVmRbahDLSDF/BW7+sRY4pXtTKXkg
         pQltzca1WZpmys37Hs+rN12AKhIDRxF+aKtQ4PNqoGd5WP2KOYvqTgs8CA6l50pUyug8
         EIhw==
X-Forwarded-Encrypted: i=1; AJvYcCUS31clJ4YplF5SGBEzzUIamgunIgfdH3kqUjgOiBSMhX/v0EAygvV/RRY3LVOnmgW062Zfqx1LzZMT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hMeIdugHqKw8uji8WaprqVh7nH8HC3+wVUjCCnbPnrtijBJm
	hefGzaHCGmJzMoNGfc5JbnNnFDjfIfTFJsKcJkb5YJQWFtrD7ggOIQxna7u6l2tdUa7GsdHTPGc
	MVScM
X-Gm-Gg: AZuq6aLpYikZ/WglEGeaNMnNzaoB+yfBYdAjD3SVggG4OBz6XYYHAVgLL6p3RzM18K9
	dZFcYjO9mc/EfTcSfzbkaviCE5eTgjw+bbkKwaTJK5xe+uhYEuqzWNd9AWl6HKIhYqfvBCwEzi2
	H5ZJVrfGYNn9axUAEwyJ7Fjepm4rvnv0aZYAz3inN7JQrNDoDmpwKt4T/9A+fMJI3OYEsZvHiDv
	qF9X9IN8uFuKzPMY3DvO7ExrmLsa/VnuT7yBR3GQX1UmPbkoscNsmHjTapMSCd4gahrxkvqFWQI
	x0CPco/dKpB4xwyJ2veOyPC/MwHpDwpLB3u7Qy62axM2SlMhnnk1WkGEKGg2T5UQbtJUbsJUzh6
	MzgybMSMnV2+fv1FJqiQ2pUgjhIRWtqCXutUsrGBzhG0kypuqcHCpayDZAhhzH+ED4DTxA+UwWr
	jwwmUOeVVwHm9PIEBizoF5x7pBGxDlTktFVJfE65SHR9nCWufBHfmX2brgl/w2LgP9SJSNamcaY
	xg+K6rbc6dl50WMkw==
X-Received: by 2002:a05:620a:4114:b0:8ca:d5cb:6842 with SMTP id af79cd13be357-8cb1f6ebe26mr431758185a.44.1770750471859;
        Tue, 10 Feb 2026 11:07:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf77f6ee8sm1089285485a.8.2026.02.10.11.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 11:07:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vpt5S-00000005CVz-2zgB;
	Tue, 10 Feb 2026 15:07:50 -0400
Date: Tue, 10 Feb 2026 15:07:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v11 4/6] RDMA/bnxt_re: Refactor
 bnxt_re_create_cq()
Message-ID: <20260210190750.GD750753@ziepe.ca>
References: <20260210165939.41625-1-sriharsha.basavapatna@broadcom.com>
 <20260210165939.41625-5-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210165939.41625-5-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16737-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 9CE1D11E821
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:29:37PM +0530, Sriharsha Basavapatna wrote:
> +static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
> +				struct ib_umem *umem,
> +				struct bnxt_qplib_sg_info *sginfo)
> +{
> +	unsigned long page_size;
> +
> +	if (!umem)
> +		return -EINVAL;
> +
> +	page_size = ib_umem_find_best_pgsz(umem, SZ_4K, 0);
> +	if (!page_size || page_size != SZ_4K)
> +		return -EINVAL;
> +
> +	sginfo->umem = umem;
> +	sginfo->npages = ib_umem_num_dma_blocks(umem, page_size);

This ends up doing ib_umem_num_dma_blocks() twice:

bnxt_qplib_alloc_init_hwq()
 bnxt_qplib_create_cq()
  bnxt_re_create_cq()

And then again for a third time:

static int __alloc_pbl(struct bnxt_qplib_res *res,
		       struct bnxt_qplib_pbl *pbl,
		       struct bnxt_qplib_sg_info *sginfo)

	if (sginfo->umem)
		pages = ib_umem_num_dma_blocks(sginfo->umem, sginfo->pgsize);
	else
		pages = sginfo->npages;

etc. :\

It looks to me like npages is only expected to be used in kernel mode
where there is no umem.

So maybe don't add another num_dma_blocks here and make a note to go
and clean up this code properly as a followup? Properly means the
function that allocates the memory for the sginfo fills it in
completely instead of sprinkling it all over.

Jason

