Return-Path: <linux-rdma+bounces-15796-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKHvFTKQcGkaYgAAu9opvQ
	(envelope-from <linux-rdma+bounces-15796-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 09:37:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0190D53AC1
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 09:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A4FE462CD2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 08:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6248E46AF3D;
	Wed, 21 Jan 2026 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUHFr7TG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6351E2858;
	Wed, 21 Jan 2026 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984373; cv=none; b=MCPreRGvSXn3xnCjxZfEchxuzqfPPJIK7BU3IFUTKKX6YHW/rXfWztObJ4NdimAX4YYWrNI33b/I1m6EimoK19NpmmolEqLQZpW4UMTuJ0USBHzYeQnAzSKP+cAizNHYcwGMsk6Sj42t+P+xHB/+TMu9+KT2uyT09YnCzgv0DcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984373; c=relaxed/simple;
	bh=/zT/QjwvPkSB24GeDesBZudUrJ0yllxGlSmObH/gtTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOEUXAQsNPk2De5a+2Hvy9jfk0IBWSZAiOhMLEm1EkzDWIRN63oiIrvZKa6Ia6LiB6xJ0dt2Ao92c1NE7JLfGmX7q/0C2DpQGoGRwvEp8I5DpFT4uQRmldgb/76nmXmaVomGRF1QGEMgplaAa+jkRi/xtGQdElqaC/iMxWBouDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUHFr7TG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238F6C16AAE;
	Wed, 21 Jan 2026 08:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768984372;
	bh=/zT/QjwvPkSB24GeDesBZudUrJ0yllxGlSmObH/gtTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUHFr7TGAeMAUTrV0mOIsyb1G5GAbPUJMTSRMrIneHR5ny44/ztcAZeCfxtAjn8vK
	 eyVgpdPBG9WzQmI6zBlbzTANLSgeSECemT+UHlbu6DtJxxM0Pf2u6NeIEBPuxrHZWP
	 om7xQF/CZkIrrSO7THkC0CAy07v9tFe7vrckwWj2uhTpWU+6ten5aVcD0aZoENXBfQ
	 QQojJJtaFv5CQAkLFtqZoawL/YWS/LYmOrMjgRM+PquvF5n73IF+VT8HFzY55/b80k
	 i6wzEZbfXg+yzDpwEpFU+4x7qStuCs2V7k1+ghigK5/fEhcku8m16Gx0ingiM2IPE4
	 nRdh5CgWDr1dA==
Date: Wed, 21 Jan 2026 10:32:46 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Edward Srouji <edwards@nvidia.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/uverbs: Add DMABUF object type and
 operations
Message-ID: <20260121083246.GV13201@unreal>
References: <20260108-dmabuf-export-v1-0-6d47d46580d3@nvidia.com>
 <20260108-dmabuf-export-v1-1-6d47d46580d3@nvidia.com>
 <20260120181520.GS961572@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120181520.GS961572@ziepe.ca>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-15796-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0190D53AC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 02:15:20PM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 08, 2026 at 01:11:14PM +0200, Edward Srouji wrote:
> >  void rdma_user_mmap_entry_remove(struct rdma_user_mmap_entry *entry)
> >  {
> > +	struct ib_uverbs_dmabuf_file *uverbs_dmabuf, *tmp;
> > +
> >  	if (!entry)
> >  		return;
> >  
> > +	mutex_lock(&entry->dmabufs_lock);
> >  	xa_lock(&entry->ucontext->mmap_xa);
> >  	entry->driver_removed = true;
> >  	xa_unlock(&entry->ucontext->mmap_xa);
> > +	list_for_each_entry_safe(uverbs_dmabuf, tmp, &entry->dmabufs, dmabufs_elm) {
> > +		dma_resv_lock(uverbs_dmabuf->dmabuf->resv, NULL);
> > +		list_del(&uverbs_dmabuf->dmabufs_elm);
> > +		uverbs_dmabuf->revoked = true;
> > +		dma_buf_move_notify(uverbs_dmabuf->dmabuf);
> > +		dma_resv_unlock(uverbs_dmabuf->dmabuf->resv);
> 
> This will need the same wait that Christian pointed out for VFIO..

Yes, something like this is missing
https://lore.kernel.org/all/20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com/

<...>

> > +struct ib_uverbs_dmabuf_file {
> > +	struct ib_uobject uobj;
> > +	struct dma_buf *dmabuf;
> > +	struct list_head dmabufs_elm;
> > +	struct rdma_user_mmap_entry *mmap_entry;
> > +	struct dma_buf_phys_vec phys_vec;
> 
> Oh, are we going to have weird merge conflicts with this Leon?

No, Alex created a shared branch with the rename already applied for me.  
I had planned to merge it into the RDMA tree before taking this series, and  
then update dma_buf_phys_vec to phys_vec locally.

> 
> > +static int uverbs_dmabuf_attach(struct dma_buf *dmabuf,
> > +				struct dma_buf_attachment *attachment)
> > +{
> > +	struct ib_uverbs_dmabuf_file *priv = dmabuf->priv;
> > +
> > +	if (!attachment->peer2peer)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (priv->revoked)
> > +		return -ENODEV;
> 
> This should only be checked in map

I disagree with word "only", the more accurate word is "too". There is
no need to allow new importer attach if this exporter is marked as
revoked.

> 
> This should also eventually call the new revoke testing function Leon
> is adding

We will add it once my series will be accepted.

Thanks

> 
> Jason

