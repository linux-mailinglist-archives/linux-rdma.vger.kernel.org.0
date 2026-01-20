Return-Path: <linux-rdma+bounces-15780-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D70Ib3ob2lhUQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15780-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 21:42:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 283884B7E2
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 21:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75C3292E9D2
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 18:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2DB44CAC3;
	Tue, 20 Jan 2026 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Qf3mD8Yx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84E36656D
	for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932927; cv=none; b=BEi4m2Q8u50gOzP9NBNqZthS5y41keURafKT8aeABSTBI6LfpFN/pJKoaXuGadM5eWAShgvd9G0S1dpr9E2zohAaxYsnZ9xeTmEKGbWqfc5iBmkCPkuCJKPfL/bjmLaIbRKPB1SXNrxNWFZMmHi+Z4WmPMVNxMq5YsuH38fJsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932927; c=relaxed/simple;
	bh=P7+NPENiCb9v28BZGi63qLThR+z5AOm6e7zj6+AnwGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgHeZujPyqJvWkY58W7NHd3i9tRBNaoLKHufhsmU3q6OrUnsMGz+FQ0mcYI+ZEoEONJC/KU3Iw1ovlmGJqLK3oqKVWatzHuj/6g7psE4khTgx2MI8eP37r9lD6DcpzR7UNhIVzL+tj+mTHHWsejViiU07Cw96NPHfq5x/JeHGwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Qf3mD8Yx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ffbea7fdf1so46756251cf.1
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 10:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768932922; x=1769537722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+h0EX6bJ4UpFAOqOLmeekiIIdrOYR0BoNDz6Hm/Icw=;
        b=Qf3mD8YxOwKMTiG29U6iQQXI2ObmVH9wgHx0GBbfjzqKpT2nf0x3iEzQ4f0yyjNftw
         /WgfkZIIP/ephlI6Yqq8i4lgMuXjflnlXT+IUnKLPE0hKyRC2CrEoDNzR6p8AvOuyIIW
         jTaPOMxobi9kA4h/PBRjkGMxuhpbU6DdLTHvbBLtyWweAi0xdMQjMWaXWmTF5E3Ac7BE
         AQr76Odj/l15XIF5xtglisnivdQn5hI2xtQogUmb56FviICrm5VDVNwcE4K4gMxbaqYp
         QTc1pawAnB6uPlNS15JMRCwB9z/lV0mJziI4XxfwxwOaQ8d+mVrz1c9EUnR3EkiylN+N
         u16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932922; x=1769537722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+h0EX6bJ4UpFAOqOLmeekiIIdrOYR0BoNDz6Hm/Icw=;
        b=AjNJejp5a90FScTHUIB2DdD4067idbO6OV37E2cGhEKTvCrJvJBjPcApo3is/eQCDo
         jFNgotTZcnQVCtv3xa50KrUNgE4CWrvoFNL9rCLVDeZPSPKKqropF37Q4TZB3Blrsju3
         tB7Ah8l31qgth1jKYPdL4oMi7IrEp5/9HYi4slvpJRW8hMBKosVQ7TwUskjUH5axSuxK
         ZlnNoiXkXI0enSbASbZ86k94dwHvFpOkcVLu4eYLBSqnrpnAGdURzJcmX+758T0HU6kg
         Ksa7v1bo3YsK1/+aRcnjw6eqBG5ZmV6G+Kr38Sdg87xJ8Vl/hVEwzifi+6ZVjV0QISgE
         vONg==
X-Forwarded-Encrypted: i=1; AJvYcCVTZRFKR6ew3miePOa9mChdAU8Ev/gBv5KZwTcrzGNJNCUfJ2SOEIzufQdmbDov+102H3JH2IDcr3HQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/eR8ZdmuxvO+KXVWx7SinlMiBwd120KW36ce1E1mbP2J1MC0
	MaBOUV70LNe9cptQAVUAmWU9FkkladixUmA0aVk3w3CKQVASOopdQz9O8c3JDjyu5yY=
X-Gm-Gg: AY/fxX4RFumJ9/V0MXEIoZACZZzRt60SVO/PMVsq5atKkD0Ni98EbsOrLoEgB34aESI
	eLWrSPX3Y2cZr3KT15rR2xkXC2rbxcoghO0rdR6UBtZrI8GuuI4EPxQKgwL4xXvtZhL///KMNdp
	DKVMnJNDqcWjpacmXiEYba8Rx/k7THSuet3jehYe2gOh3I6NvO7iJ+zCKmjTUiGiCFsrGSEqAqP
	WWxFTFGaLD6+XsukkYpqAz89c6jxPw1V4E1EJfe+zIg0NmWQYBcY/TydTEMHTxk8A455kGX685A
	CnyFP4HUhkqzxyJt+T1QcGONUSsJn5lyXgrmUXoa15qG1V0pViygvjHUpg4VDqqUOMwIvpVbNpf
	rFvM+OKEN8QcaDbeG/eBBAccDwcpKPa9rHD6shGgD/pss89Kl+LStfKXl2KFhefZP90Kw5UOcLu
	C7mkK7fhdk4paLS9iM17mdNwiYZetsicTjj9/2aqrVYxc9Kd/WO3jJ
X-Received: by 2002:a05:622a:1447:b0:501:3ccd:cb3e with SMTP id d75a77b69052e-502a1f7105fmr227831511cf.66.1768932921973;
        Tue, 20 Jan 2026 10:15:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d6e670sm99756901cf.1.2026.01.20.10.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:15:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viGG8-00000005aY4-3tNU;
	Tue, 20 Jan 2026 14:15:20 -0400
Date: Tue, 20 Jan 2026 14:15:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/uverbs: Add DMABUF object type and
 operations
Message-ID: <20260120181520.GS961572@ziepe.ca>
References: <20260108-dmabuf-export-v1-0-6d47d46580d3@nvidia.com>
 <20260108-dmabuf-export-v1-1-6d47d46580d3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-dmabuf-export-v1-1-6d47d46580d3@nvidia.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15780-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 283884B7E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Jan 08, 2026 at 01:11:14PM +0200, Edward Srouji wrote:
>  void rdma_user_mmap_entry_remove(struct rdma_user_mmap_entry *entry)
>  {
> +	struct ib_uverbs_dmabuf_file *uverbs_dmabuf, *tmp;
> +
>  	if (!entry)
>  		return;
>  
> +	mutex_lock(&entry->dmabufs_lock);
>  	xa_lock(&entry->ucontext->mmap_xa);
>  	entry->driver_removed = true;
>  	xa_unlock(&entry->ucontext->mmap_xa);
> +	list_for_each_entry_safe(uverbs_dmabuf, tmp, &entry->dmabufs, dmabufs_elm) {
> +		dma_resv_lock(uverbs_dmabuf->dmabuf->resv, NULL);
> +		list_del(&uverbs_dmabuf->dmabufs_elm);
> +		uverbs_dmabuf->revoked = true;
> +		dma_buf_move_notify(uverbs_dmabuf->dmabuf);
> +		dma_resv_unlock(uverbs_dmabuf->dmabuf->resv);

This will need the same wait that Christian pointed out for VFIO..


> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index 18918f463361..3e0a8b9cd288 100644
> --- a/drivers/infiniband/core/rdma_core.c
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -465,7 +465,7 @@ alloc_begin_fd_uobject(const struct uverbs_api_object *obj,
>  
>  	fd_type =
>  		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
> -	if (WARN_ON(fd_type->fops->release != &uverbs_uobject_fd_release &&
> +	if (WARN_ON(fd_type->fops && fd_type->fops->release != &uverbs_uobject_fd_release &&
>  		    fd_type->fops->release != &uverbs_async_event_release)) {
>  		ret = ERR_PTR(-EINVAL);
>  		goto err_fd;
> @@ -477,14 +477,16 @@ alloc_begin_fd_uobject(const struct uverbs_api_object *obj,
>  		goto err_fd;
>  	}
>  
> -	/* Note that uverbs_uobject_fd_release() is called during abort */
> -	filp = anon_inode_getfile(fd_type->name, fd_type->fops, NULL,
> -				  fd_type->flags);
> -	if (IS_ERR(filp)) {
> -		ret = ERR_CAST(filp);
> -		goto err_getfile;
> +	if (fd_type->fops) {
> +		/* Note that uverbs_uobject_fd_release() is called during abort */
> +		filp = anon_inode_getfile(fd_type->name, fd_type->fops, NULL,
> +					  fd_type->flags);
> +		if (IS_ERR(filp)) {
> +			ret = ERR_CAST(filp);
> +			goto err_getfile;
> +		}
> +		uobj->object = filp;
>  	}
> -	uobj->object = filp;
>  
>  	uobj->id = new_fd;
>  	return uobj;
> @@ -561,7 +563,9 @@ static void alloc_abort_fd_uobject(struct ib_uobject *uobj)
>  {
>  	struct file *filp = uobj->object;
>  
> -	fput(filp);
> +	if (filp)
> +		fput(filp);
> +
>  	put_unused_fd(uobj->id);

This stuff changing hw the uobjects work should probably be in its own
patch with its own explanation about creating a uobject that wrappers
an externally allocated file descriptor vs this automatic internal
allocation.

> index 797e2fcc8072..66287e8e7ad7 100644
> --- a/drivers/infiniband/core/uverbs.h
> +++ b/drivers/infiniband/core/uverbs.h
> @@ -133,6 +133,16 @@ struct ib_uverbs_completion_event_file {
>  	struct ib_uverbs_event_queue		ev_queue;
>  };
>  
> +struct ib_uverbs_dmabuf_file {
> +	struct ib_uobject uobj;
> +	struct dma_buf *dmabuf;
> +	struct list_head dmabufs_elm;
> +	struct rdma_user_mmap_entry *mmap_entry;
> +	struct dma_buf_phys_vec phys_vec;

Oh, are we going to have weird merge conflicts with this Leon?

> +static int uverbs_dmabuf_attach(struct dma_buf *dmabuf,
> +				struct dma_buf_attachment *attachment)
> +{
> +	struct ib_uverbs_dmabuf_file *priv = dmabuf->priv;
> +
> +	if (!attachment->peer2peer)
> +		return -EOPNOTSUPP;
> +
> +	if (priv->revoked)
> +		return -ENODEV;

This should only be checked in map

This should also eventually call the new revoke testing function Leon
is adding

Jason

