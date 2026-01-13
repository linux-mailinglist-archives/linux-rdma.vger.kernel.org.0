Return-Path: <linux-rdma+bounces-15531-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A11DD1AA7B
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 18:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 525653095A9C
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 17:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB91FC110;
	Tue, 13 Jan 2026 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PZyEnsuv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A061DC985
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325570; cv=none; b=pgWI8WkMBCjDVsxOlrFPkcaKuwO2T3bARZEqcIzOWHXZ5Nun9dW+shaBbVhqn2XZmuav5YtlfopQpGlwlknV9suIsSvWDFOUYII/VcZs5zVCCuM7Ok1lHVuALJE5iFKZsxCsdyuFhJjRvNAylz+nLPn2OYEPqCIP8+6XsbzxBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325570; c=relaxed/simple;
	bh=cfnIE6Zm07wFIJpyboTjeNFkHSS3z51ujgRZXValdo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAhr5oz1JG+23BYM0gbWk1jL+7D5a46BfegqSnAeNEAO8PrTHvEHu/yGX7K+Dkr9vlRHtGD/pvkHXMvWsHt8o1HfYGZ/RjPq7ScygYohNAzwhi4PpHRv748DFca78i80c/A3szjdy8OzUxkCj+nK9eYPGY/3SFWsEO8Vi191qQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PZyEnsuv; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ffc0ddefc4so91880281cf.3
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768325568; x=1768930368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jb1LBnmtXWBY0l0f3EMO1CF4I66UY+SqBtcivWhKkyA=;
        b=PZyEnsuvHc7p6YO7+UDDSTcG9i7oiubq+DVkb9xVOacPNdKbvyf+iwuPXl53Vm9U3W
         f1GcFCpNs4G3Ln8sf2rQZafXAA7iCqrVhI4Yh/0vntL+oOCXJ6IZ9OEb+zjxaL1KAnK0
         aO1ts33wkC5u7dtRuDn+Job3r0QPvcRXfOEHOooVmKCLYU9MtOCmvS5DTBB5vQhK8a9A
         7RWKUHt1LisBH3EbrkB9xkXrA8W/zTMDbBE6kz/gwdPoOrJBpN360Xt359GaJcbh85kw
         OkGw1waYVWTsLva91lOcIljtf8RLFHCvoBE5fO/apYMBeFPZ+WVsgFTNXp467hWlZJ3L
         ALXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325568; x=1768930368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jb1LBnmtXWBY0l0f3EMO1CF4I66UY+SqBtcivWhKkyA=;
        b=SdFmiSIuvCw29ZCmDjK+DbZbNNr2DV/x4J9B36IRhrKS7Du2hKn/n4+Y3tT7YGTvss
         NewxCOhW07l6f44sBskJ+j0mGk9I1YSIz9YTvr+eLzMzjqypJlKjfw0US/I4U00AwdO5
         x3OfnSlVr0YM0UoQSr8KMTxKkwi7S0kqdZBWdlt45ibygFWsmwEhSdDmxDprIZhTXaKI
         I2+nRUi5QOXzqyVKGr/IhNEi1orCGDoMQhrvoCJKa7qeS0LXEyvoPk6z9LMz1jPguRyE
         pY8nX9jgRxEQZ4+OmimkIanrnujbNcpk+8GKSsRAzpGjm5kZXIPiqQRF4WVnwu/wPqWb
         H+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8Pimz/+LT8MdIW1Y5NcX1IlT1nlW6QZAbhf/+I89pbt4/O3gNVieUGEZiTY1ilm1ESjMXLkdq4d3G@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPCd8uDMVa6j29+PkLigA9M7JOw/OaVmWSRg3phe9Z1UArKrh
	ihvKYOd49QCCfsztLZhYbE1tUP9aq8xI8U02z/RoSf5NwfztLNP4+e+AGnTVFsSPQxE=
X-Gm-Gg: AY/fxX5rIjDyGBzmfiQzedBLyr2Pz3lKVlTyaifedqAS7cOmdjP7E8TvHRiDCXbwmWe
	vTAiQBBh7ZXldfjwDCWSrJgV+3Eb7RdwDh0rvEq4wBWbEQk/mghVME5odnNKJjfhepAVRgX5sUK
	TNmV9eY1fQTKJPIcFLDQ8Z7xYB119djhKHm3ObVRsedqzdc/zkJx9Ihjk3DAqTmxysoec/hOuy8
	ePGr1MEOJhfRa6Ti5oVtMPpBVNMZAMdkCGHzvXOyLUwJzg/qkWLkVLPWAhTfSolARZwbU2ooui8
	I+KsisF/aooZox1omNbIhSH+iEjuK2urIU4V3VYeodMBlMQJsjBv7cwlaWPryA431qRNRrJmBRD
	hAJQDHQPx2Bl2sSNT9AEhR0XgZEU0SzRd6VSnmJy7FyNqmz0wyBetkf6zqDq9EibylXrn2P0eOE
	QeSJKQYHLCbolJSI/KaS9uXXUTDyDIR/KQoQeI9/onDUc112kE00l/S/8pl/dG1KCr0rI=
X-Google-Smtp-Source: AGHT+IHJI91yYcVQBV2K1MDV942aSq8tmXfMMhmMI1T7q1uEe8czYqSx+BvZr7J5FUZTfapiYL8MtA==
X-Received: by 2002:a05:622a:149:b0:4ee:4128:beb7 with SMTP id d75a77b69052e-4ffb49ea31bmr297171771cf.69.1768325567960;
        Tue, 13 Jan 2026 09:32:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5013bd680a1sm15002711cf.16.2026.01.13.09.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:32:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfiG7-00000003w9W-04bl;
	Tue, 13 Jan 2026 13:32:47 -0400
Date: Tue, 13 Jan 2026 13:32:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260113173247.GT745888@ziepe.ca>
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>

On Tue, Jan 13, 2026 at 10:39:56PM +0530, Sriharsha Basavapatna wrote:
> +int bnxt_re_dv_create_qp(struct bnxt_re_dev *rdev, struct ib_udata *udata,
> +			 struct ib_qp_init_attr *init_attr,
> +			 struct bnxt_re_qp *re_qp, struct bnxt_re_qp_req *req)
> +{
> +	struct bnxt_re_alloc_dbr_obj *dbr_obj = NULL;
> +	struct bnxt_re_cq *send_cq = NULL;
> +	struct bnxt_re_cq *recv_cq = NULL;
> +	struct bnxt_re_qp_resp resp = {};
> +	struct bnxt_re_ucontext *uctx;
> +	int ret;
> +
> +	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
> +	if (init_attr->send_cq) {
> +		send_cq = container_of(init_attr->send_cq, struct bnxt_re_cq, ib_cq);
> +		re_qp->scq = send_cq;
> +	}
> +
> +	if (init_attr->recv_cq) {
> +		recv_cq = container_of(init_attr->recv_cq, struct bnxt_re_cq, ib_cq);
> +		re_qp->rcq = recv_cq;
> +	}
> +
> +	re_qp->rdev = rdev;
> +	rcu_read_lock();
> +	if (req->dpi != uctx->dpi.dpi) {
> +		dbr_obj = bnxt_re_search_for_dpi(rdev, req->dpi);
> +		if (!dbr_obj) {
> +			rcu_read_unlock();
> +			return -EINVAL;
> +		}
> +	}
> +	ret = bnxt_re_dv_init_qp_attr(re_qp, uctx, init_attr, req, dbr_obj);
> +	rcu_read_unlock();

So now if dbr is racily freed the QP just keeps using it? That doesn't
make alot of sense.

I think the reason you having problems with your locking here is
because this is the wrong way to pass a handle to another uverbs
object.

Pass in the uverbs object ID and use the uverbs object lookup to
acquire *and lock it*. Then refcount the uobject properly for the qp
lifecycle so the underlying DBR record cannot be destroyed. Get rid of
the hash table.

Jason

