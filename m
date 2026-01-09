Return-Path: <linux-rdma+bounces-15416-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0417FD0C16A
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 20:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DA5230057F5
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3D32DF155;
	Fri,  9 Jan 2026 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o4zMi1pS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C0E3398A
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767987480; cv=none; b=UFLogIUTpLtrlgrRMoWPMXoBv8hKBquhhX+y/1uTUi6T0MbdHoFsjHAUmV11xdkIf3AOVguSGmBsEenuCFsLYNNtwPqIyuO/ekOQ90J6/4BLtJsvnrkVDTTOsa/s1XBi+/NQa2nFvOuRpidr8eAMY94UenofYE/ANFbfAaH/idA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767987480; c=relaxed/simple;
	bh=RHmHz8fS4az4yqMIxVBr+BG9D55GRIfry2ylvvOEH1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRaSOLp/wtn3NtWEvmGoZyqqipREP8lIeVQjj9spEFDLH6Uu4/iSnXF4fGmKSfdIrg9lwxfzYogfnmDtqDYDeTAQ26HgKyAh0HkzJyovySi135alR+SAaQckjTZURa0H2OgzprFCRsX3iLRP7fmxYA1y5yMfDj+4WIVxdYYM2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=o4zMi1pS; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88ffcb14e11so49587456d6.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jan 2026 11:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767987478; x=1768592278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asEIVILQY87ZgG0bznR82f7SXq/st+iKwtLy6jXwxlY=;
        b=o4zMi1pSXOqxqwowdSOg4xCiV/agtieqNVXRTIk2lyxI8hcumBIgQJuGpl280MpHU4
         ba4jtUq1ekUmWpGteBN6jNTpVXlKhFPy2c8AbNd/dT3Qu5SwSydK6HwnpwPHmhoCysK9
         TD0ZiQOa+ztNBXg4Xtu789TNkgGYaalPh+ST+WXbi7yEfHWVpIlZ8rCSUWjOQfEf6fBY
         4PJZ/TcvakaYKgMoy9eYahhqnujIMoQ0ULdsb0zPX++LsX7ARjRUiNkvGGiJcnc/iFmi
         meQ7F+S/tNrMW/BTzqHCMWsYtFAH6dAEDbi4ZgZffUfLv6Z7b3EHQ1z11RTbVFG8OmC8
         5Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767987478; x=1768592278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asEIVILQY87ZgG0bznR82f7SXq/st+iKwtLy6jXwxlY=;
        b=PQUvIzNGFeuzOsU+jr1uKQF1UQHU8YGeimUIFcgm9Sn4QK1gVtJx7kAlfJCTBpap5X
         RuPmi/nEOg+G6ANML7O3uZaM5iLWcBHITctiBSoWDkSZ0rWVIwQ1KX5XNx9xTKEtYyB7
         eQsfsnxXZSfRPe1q3UPpg3Z5fbQGnE/wlbDUoS0yfYMkorsPGKZo9clDMffjtyObpnR5
         UfbZLS2XHmp+b/GqzMwgNCOO/5ATzG19zYzdbuGzEcK3TwK0evOpHG9UYJGugn6Vu8y8
         chgb/8ebjcPijFYKhXZ7Z05h/MoBLiLETDxzjq7+cUZlM2mSUlhXn1ZQGNCwLBUPm/bq
         y4ew==
X-Forwarded-Encrypted: i=1; AJvYcCVY1xMQeZzCSugXKebDt1pYiGGMkcOGsn5nSFur/dzS0vFzYe6t9Z+wZFBUGu8LwMyRspp6vXfGi41J@vger.kernel.org
X-Gm-Message-State: AOJu0YxYa7Plnu9ZhkGQQHQXSj4+Gv9PiYdpb8ncfFvO3HqjGgvaNOgT
	S3CLXLsNZn/H0nAobrvcoueYHKnBuP73UpeEnJNZpUceX/59UchEt6no6pGDeTofZZA6iTIuctQ
	N8Snt
X-Gm-Gg: AY/fxX70nzxtvywW0JlUfNXafGssZD2IylAQUn8aQK4jLmw1fIyIedQ6B4OnZFH+d7F
	G2AyYoxi1LQqzlC+8HN+mXTCoDZTWLIt3ReOUSGW+nqmkDH2wnDYt5LqXkSn1kJYhscAbp8V5iV
	08FzQ7h+xJL59pRLFIIOcjLDRscLaKNzZew9PY37PpPuOmFl5kwUTQRhgixdQTB5udcer2ZcdZX
	QgTKET7dON48o1RjtGJoUaISioJkfrM182Of80Zp7uFb6qMUyOvrkhKz7cYjFt1nzEZtmZfm6zH
	lml6mcxKBGk1oxYTyR88lxbj4LjYpru7ux5P6pIH7wiiywR8a6W3LHXKlGnbXym8xlkH8sbdqDL
	8MTb/q/Qm24DgiiF2XeMY+EMYu87sdUIZkGSEOic1f41pYWqiV3HCZE2MkagFY1sxqj5aedUjts
	c7HwkVJ+7tzYDX4ZP6NvoJZHBKz8oGAYkoN94SJA9kQqR4ypxlI6Jjk5QYdg9my6AodRw=
X-Google-Smtp-Source: AGHT+IF8yNPVlkd4sqod/EUFxVBMkkMwrVPRk2FVvmibO6o0+GW7Kkgws24zrcf1sfBVFNYsCXVj0A==
X-Received: by 2002:a05:6214:5bc8:b0:880:5867:45b4 with SMTP id 6a1803df08f44-8908417514fmr163552876d6.13.1767987477723;
        Fri, 09 Jan 2026 11:37:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770cc73dsm83512906d6.7.2026.01.09.11.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 11:37:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1veIJ2-000000037wJ-3NuK;
	Fri, 09 Jan 2026 15:37:56 -0400
Date: Fri, 9 Jan 2026 15:37:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v6 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260109193756.GP545276@ziepe.ca>
References: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
 <20251224042602.56255-5-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224042602.56255-5-sriharsha.basavapatna@broadcom.com>

On Wed, Dec 24, 2025 at 09:56:02AM +0530, Sriharsha Basavapatna wrote:
> +static int bnxt_re_dv_create_qplib_cq(struct bnxt_re_dev *rdev,
> +				      struct bnxt_re_ucontext *re_uctx,
> +				      struct bnxt_re_cq *cq,
> +				      struct bnxt_re_cq_req *req)
> +{
> +	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
> +	struct bnxt_qplib_cq *qplcq;
> +	struct ib_umem *umem;
> +	u32 cqe = req->ncqe;
> +	u32 max_active_cqs;
> +	int rc = -EINVAL;
> +
> +	if (atomic_read(&rdev->stats.res.cq_count) >= dev_attr->max_cq) {
> +		ibdev_dbg(&rdev->ibdev, "Create CQ failed - max exceeded(CQs)");
> +		return rc;
> +	}

This is a racy way to use atomics, this should be an
atomic_inc_return, then check the return code, doing a dec on all
error paths.

> +static void bnxt_re_dv_init_ib_cq(struct bnxt_re_dev *rdev,
> +				  struct bnxt_re_cq *re_cq)
> +{
> +	struct ib_cq *ib_cq;
> +
> +	ib_cq = &re_cq->ib_cq;
> +	ib_cq->device = &rdev->ibdev;


> +	ib_cq->uobject = NULL;
> +	ib_cq->comp_handler  = NULL;
> +	ib_cq->event_handler = NULL;
> +	atomic_set(&ib_cq->usecnt, 0);
> +}

All these should already be 0 since this was freshly zallocated, no?

> +int bnxt_re_dv_create_cq(struct bnxt_re_dev *rdev, struct ib_udata *udata,
> +			 struct bnxt_re_cq *re_cq, struct bnxt_re_cq_req *req)
> +{
> +	struct bnxt_re_ucontext *re_uctx =
> +		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
> +	struct bnxt_re_cq_resp resp = {};
> +	int ret;
> +
> +	ret = bnxt_re_dv_create_qplib_cq(rdev, re_uctx, re_cq, req);
> +	if (ret)
> +		return ret;
> +
> +	ret = bnxt_re_dv_create_cq_resp(rdev, re_cq, &resp);
> +	if (ret)
> +		goto fail_resp;
> +
> +	ret = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
> +	if (ret)
> +		goto fail_resp;
> +
> +	bnxt_re_dv_init_ib_cq(rdev, re_cq);
> +	re_cq->is_dv_cq = true;
> +	atomic_inc(&rdev->dv_cq_count);
> +	return 0;
> +
> +fail_resp:
> +	bnxt_qplib_destroy_cq(&rdev->qplib_res, &re_cq->qplib_cq);
> +	bnxt_re_put_nq(rdev, re_cq->qplib_cq.nq);
> +	ib_umem_release(re_cq->umem);

This seems really weird error unwinding, I expect to see functions
with error unwinds that match the calls within the function.

So why doesn't bnxt_qplib_destroy_cq() do the umem release and
req_put_nq?

Jason

