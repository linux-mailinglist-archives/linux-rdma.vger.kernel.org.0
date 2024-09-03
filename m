Return-Path: <linux-rdma+bounces-4710-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F56A9694D0
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 09:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE891B238D3
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 07:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0806F205E36;
	Tue,  3 Sep 2024 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHqTO2oQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5831205E2E;
	Tue,  3 Sep 2024 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347367; cv=none; b=HxPoQcH4i88UFZsm+f8Kb88AI0rBpU8xv+IvZNf5mwy8Al9GU/rt6TIqjor1RyxhYTKRpgnpsc3Oui9WCKpsCxyHCtFiZ9gjZghLiTqlf6mP3jH9emSRkcR5K/yfPWNwl+0Umns58es1tFs+MBrsKvfCFdxlt4YyLlKdETfLYzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347367; c=relaxed/simple;
	bh=tSPlMThcmo9qk8daO81Bk+y+EZzFXzCueiSUkdZ9oVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwTyb8lZP1DHOBlPZBs4EAkAlWa2g04xCzSVRdG3rZU1Qi7yoTkmXY0SOWSRqQ+yVfUi7aoXl9wIQ+Ck1EtGhPigQ+TtS7SzafbNglwd3xqai3usMolVgc8JF52i4cCsvuaTl7ZLzcAv2ej5ClAi+cb33U9TwCrSOtkaAfZkt2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHqTO2oQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED9EC4CEC5;
	Tue,  3 Sep 2024 07:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725347367;
	bh=tSPlMThcmo9qk8daO81Bk+y+EZzFXzCueiSUkdZ9oVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHqTO2oQ7rfINp765eS9cUvrJte/XHsmh2amucqRRR6Q3bb9pYw8GDYd5pN0ADgXk
	 e8isDMLd1noD0i2nUxqcKI9ov9hoFij53Vb74GRtwB/ZXyU6haCV83V5dm61UZh/zr
	 3p+P5DRRbYJBwuN7jR8eOe6j1Z1AvzDdMWZCxFAtrGwRvQWdE3n5UsrrnDJWXD9zDr
	 97IgdKQzqK9SQ8dUiPaN27eq+MXtwzvEMJOz4yGQFb7vuCVx0Wh15zgP9ht6ei0pnV
	 OJGYWxF85V1hCLl8puVnwxFcRTMouTih8KG7QJN/tu+Xi204XmXvAiKuXWpfOSPjw8
	 WunoTmoilvRdA==
Date: Tue, 3 Sep 2024 10:09:22 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 for-next 1/2] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Message-ID: <20240903070922.GI4026@unreal>
References: <20240828064605.887519-1-huangjunxian6@hisilicon.com>
 <20240828064605.887519-2-huangjunxian6@hisilicon.com>
 <20240902065726.GA4026@unreal>
 <e999d699-b764-5a58-c1ec-6f53e0e8521d@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e999d699-b764-5a58-c1ec-6f53e0e8521d@hisilicon.com>

On Mon, Sep 02, 2024 at 09:32:10PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/9/2 14:57, Leon Romanovsky wrote:
> > On Wed, Aug 28, 2024 at 02:46:04PM +0800, Junxian Huang wrote:
> >> From: Chengchang Tang <tangchengchang@huawei.com>
> >>
> >> Provide a new api rdma_user_mmap_disassociate() for drivers to
> >> disassociate mmap pages for a device.
> >>
> >> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> >> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >> ---
> >>  drivers/infiniband/core/uverbs.h      |  3 ++
> >>  drivers/infiniband/core/uverbs_main.c | 45 +++++++++++++++++++++++++--
> >>  include/rdma/ib_verbs.h               |  8 +++++
> >>  3 files changed, 54 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
> >> index 821d93c8f712..0999d27cb1c9 100644
> >> --- a/drivers/infiniband/core/uverbs.h
> >> +++ b/drivers/infiniband/core/uverbs.h
> >> @@ -160,6 +160,9 @@ struct ib_uverbs_file {
> >>  	struct page *disassociate_page;
> >>  
> >>  	struct xarray		idr;
> >> +
> >> +	struct mutex disassociation_lock;
> >> +	atomic_t disassociated;
> >>  };
> >>  
> >>  struct ib_uverbs_event {
> >> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> >> index bc099287de9a..589f27c09a2e 100644
> >> --- a/drivers/infiniband/core/uverbs_main.c
> >> +++ b/drivers/infiniband/core/uverbs_main.c
> >> @@ -76,6 +76,7 @@ static dev_t dynamic_uverbs_dev;
> >>  static DEFINE_IDA(uverbs_ida);
> >>  static int ib_uverbs_add_one(struct ib_device *device);
> >>  static void ib_uverbs_remove_one(struct ib_device *device, void *client_data);
> >> +static struct ib_client uverbs_client;
> >>  
> >>  static char *uverbs_devnode(const struct device *dev, umode_t *mode)
> >>  {
> >> @@ -217,6 +218,7 @@ void ib_uverbs_release_file(struct kref *ref)
> >>  
> >>  	if (file->disassociate_page)
> >>  		__free_pages(file->disassociate_page, 0);
> >> +	mutex_destroy(&file->disassociation_lock);
> >>  	mutex_destroy(&file->umap_lock);
> >>  	mutex_destroy(&file->ucontext_lock);
> >>  	kfree(file);
> >> @@ -700,6 +702,12 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
> >>  		ret = PTR_ERR(ucontext);
> >>  		goto out;
> >>  	}
> >> +
> >> +	if (atomic_read(&file->disassociated)) {
> > 
> > I don't see any of the newly introduced locks here. If it is
> > intentional, it needs to be documented.
> > 
> 
> <...>
> 
> >> +		ret = -EPERM;
> >> +		goto out;
> >> +	}
> >> +
> >>  	vma->vm_ops = &rdma_umap_ops;
> >>  	ret = ucontext->device->ops.mmap(ucontext, vma);
> >>  out:
> >> @@ -726,7 +734,7 @@ static void rdma_umap_open(struct vm_area_struct *vma)
> >>  	/*
> >>  	 * Disassociation already completed, the VMA should already be zapped.
> >>  	 */
> >> -	if (!ufile->ucontext)
> >> +	if (!ufile->ucontext || atomic_read(&ufile->disassociated))
> >>  		goto out_unlock;
> >>  
> >>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> >> @@ -822,6 +830,8 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
> >>  	struct rdma_umap_priv *priv, *next_priv;
> >>  
> >>  	lockdep_assert_held(&ufile->hw_destroy_rwsem);
> >> +	mutex_lock(&ufile->disassociation_lock);
> >> +	atomic_set(&ufile->disassociated, 1);
> > 
> > Why do you use atomic_t and not regular bool?
> > 
> 
> The original thought was that ib_uverbs_mmap() reads ufile->disassociated while
> uverbs_user_mmap_disassociate() writes it, and there might be a racing. We tried
> to use atomic_t to avoid racing without adding locks.

atomic_t is never a replacement for locks. It is a way to provide
coherent view of the data between CPUs and makes sure that write/read is
not interrupted.

Thanks

