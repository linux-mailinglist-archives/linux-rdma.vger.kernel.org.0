Return-Path: <linux-rdma+bounces-16161-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qErbLKkwemlq3wEAu9opvQ
	(envelope-from <linux-rdma+bounces-16161-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 16:52:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E547A4977
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 16:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EA5330842EF
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A1330F52F;
	Wed, 28 Jan 2026 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M1qPQhhw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AA238159
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615218; cv=none; b=LK0wxdqcxMGufD7t3WOdK5VJLO0SfiIdguLEsTxUg6IMv3YBj9C0615tPhxQxwGCyOb/hMJdXu1PX8JB+mjS/wOvlwtWpCLmrdfqfkL+FfSI35RogpasMwvVJmZXqJ7fLcTEFg7C2dr7gR9tqt5MYkJH5upYOjBvt3HNkY2wWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615218; c=relaxed/simple;
	bh=0+uqeNMfpQTagSFYQOQj2MXdPm7pGT2NiDlMUuaMzxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyZqrbQ/CHFlvhzRZgB5/gxMGWJURMKZaiPzS4zZfgcs9ARvrENpzwScBXeWkBIHYZ8WOfwXmwuQ8rqWfDm9SGThf7r8uby7wWhSDQCXabLKAxVipWErFDfA6o4R+PIcV5d7vWhpacN2fsCOI09xVIA0rfZealvUC6l5n4oItlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M1qPQhhw; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-894723da7dfso108396486d6.1
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 07:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769615215; x=1770220015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YnhDOIVD3P7M++FA62Nre1Z1tYOxRJnLgrDIsJl1LOw=;
        b=M1qPQhhwC9Otix0M8XNepmMaIbRDG81uRl1q56/BCZtLX06oiUnXZ4wIXec/Fpffd7
         H6n/OkVZygfwCbrgk5vNmZlUf8fuPJkQerOBPyVC2rbBWcodwU1YDYa+7txQdhVOD4W6
         G4Qo5rLFY4j1ZcnMf6BfB7g8rUYOHPOmnpnKKdJaRf8rPNhyN1MYxQOHmD7WtjHvF5B6
         zsfzOObLOHp4VlONshEUoDmkNEar1pht5yzdixcmRSKtwZq7FAd0CA7StulzjLbAtTAd
         WghxnAiylOHYJ2ZKS3hWXEZDubItqh3dH/pvDjwKY5HkvRhmVY4c2YA0HevDXMXd9+zQ
         ne2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769615215; x=1770220015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnhDOIVD3P7M++FA62Nre1Z1tYOxRJnLgrDIsJl1LOw=;
        b=O5eQj5OMMoKn+Sb1/klX2I2Kew/cNoGbrkwMh+1O3O6BLRApRD+C/MJQLUoI99lBlP
         9w4JmNjHSSI3u7ud09gq8TfJ4MeIO+ZN0MBljGYr10LHMNvbxT3GekuwizAmp2FXXTrX
         rgr5UnHfvIHEW7h57cDCjh9UlYoKUZ1ehmP1yCtmgUgA8kzKvPJvExuoV0oEZKiWyfgv
         L07GcpZkocetxsWqkVyoTvmGvruW2pBpamlYcq6ZNzeJvZ5i1ocQbV8f4meYsSTQ56g4
         dSYGNzphJMCdwf/D9pKl2kJzbQzXSQATvw4hzhTQATyAKFaKoKI+aYkvOQG/u26y0VUW
         7Jzg==
X-Forwarded-Encrypted: i=1; AJvYcCVSdZI5rOpqx9ZYe20ou8bQCA9uvRN1ZU6z5qAXv57W6x3XFNSKiTvqQx0SycfV84MrEwbkJndW/+2M@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi97lkpPW2UsaRGTTnQdZVigxsrm6AdDdWoGU5legqi96lBjQp
	rfm+NwXanE9OjTXMgRNO8TtlW1ERz2v6bz2XnBNf80YF1Bvgpmi33HvxT6pBGL2HzCw=
X-Gm-Gg: AZuq6aKoTlRrJLJ0s/mgBp73+tZWt4gentK1O7OGHIbbh/wNVZ2KNEO3GGFNPcoSlTR
	JS66ctZ96xMPaTeyj3F1rJ/HsUgl8wbK1t/s54Cvq5/qCzmK2SK28xjqHKS/ZdHZNjwEYpEPAy/
	9SiHaUSjAY7vcPGuPlK+nHnVllPMU3cCD2sFfuz0bhS9Irp27Gn2iSMJCss3mQG6L/B6cU4kcDA
	94ioCpkBLofaG1JTBw7YVQe32LcM8fRjXtlvmBDnr9H9WnR9uBGupuMAZOLsbHoXjd67dBoFGaq
	yryC8AMUMSss8hGCXWk3siJMLiZ2wV4bVKwdVnEW5/d+nGN5ey1y2gG9r7s7i1cmjSmpFY8kMW4
	Rp800/zgEQXlt/LZ0BcTJIyvjgvheaSBpz2rJon6rwQCMTfBk1BHp4HSbCno/aHa1R+36cgdPMK
	o0MRNeLzP+eLUfHUMfo9ti45X4goVugpDFPwRoyCV50GJXoTNVzVSbdPCGVfXeA65Xxmw=
X-Received: by 2002:ac8:570e:0:b0:4ed:b2da:966f with SMTP id d75a77b69052e-5032f899d62mr66355531cf.31.1769615215196;
        Wed, 28 Jan 2026 07:46:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375b640sm19550726d6.39.2026.01.28.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:46:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vl7ks-00000009K1I-0zlE;
	Wed, 28 Jan 2026 11:46:54 -0400
Date: Wed, 28 Jan 2026 11:46:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v9 5/5] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260128154654.GM1641016@ziepe.ca>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16161-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E547A4977
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 04:01:09PM +0530, Sriharsha Basavapatna wrote:
> diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> index 0999a42c678c..f28acde3a274 100644
> --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> @@ -234,6 +234,8 @@ struct bnxt_re_dev {
>  	union ib_gid ugid;
>  	u32 ugid_index;
>  	u8 sniffer_flow_created : 1;
> +	atomic_t dv_cq_count;
> +	atomic_t dv_qp_count;
>  };

Why? Nothing reads these? If they are stats then put them in your
stats struct and return them to userspace. I'd drop it and come later
with a user visible stat.

This patch is really big now, can you at least split it to cq/qp?

> @@ -459,11 +463,454 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR,
>  DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_DEFAULT_DBR,
>  			      &UVERBS_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR));
>  
> +static int bnxt_re_dv_create_cq_resp(struct bnxt_re_dev *rdev,
> +				     struct bnxt_re_cq *cq,
> +				     struct bnxt_re_cq_resp *resp)
> +{
> +	struct bnxt_qplib_cq *qplcq = &cq->qplib_cq;
> +
> +	resp->cqid = qplcq->id;
> +	resp->tail = qplcq->hwq.cons;
> +	resp->phase = qplcq->period;
> +	resp->comp_mask = BNXT_RE_CQ_DV_SUPPORT;
> +	return 0;
> +}
> +
> +static int bnxt_re_dv_setup_umem(struct bnxt_re_dev *rdev,
> +				 struct ib_umem *umem,
> +				 struct bnxt_qplib_sg_info *sginfo,
> +				 struct ib_umem **umem_ptr)
> +{
> +	unsigned long page_size;
> +
> +	if (!umem)
> +		return -EINVAL;
> +
> +	page_size = ib_umem_find_best_pgsz(umem, SZ_4K, 0);
> +	if (!page_size)
> +		return -EINVAL;
> +
> +	if (umem_ptr)
> +		*umem_ptr = umem;

Why?? Just have the caller store to the right variable.

> @@ -3324,12 +3418,11 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  	cq->qplib_cq.sg_info.pgsize = PAGE_SIZE;
>  	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
>  	if (udata) {
> -		struct bnxt_re_cq_req req;
> -		if (ib_copy_from_udata(&req, udata, sizeof(req))) {
> -			rc = -EFAULT;
> +		if (umem) {
> +			/* Standard CQ (non-DV): use req.cq_va */
> +			rc = -EINVAL;
>  			goto fail;
>  		}

I think this should support the umem interface here, it is trivial
right, just skip the below if the umem is passed:

>  		cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
>  				       entries * sizeof(struct cq_base),
>  				       IB_ACCESS_LOCAL_WRITE);

Jason

