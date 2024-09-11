Return-Path: <linux-rdma+bounces-4877-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F6974F8C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 12:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8BC288203
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B9C185940;
	Wed, 11 Sep 2024 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKEkj0C/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B883418592A;
	Wed, 11 Sep 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050023; cv=none; b=fLebmbOhcmdKQaHW9gACd4TXZaDqWX+quacv0uHr5xadDjj1mcu0TljE1S0NMdlFegMCkMSTT3fDbhSt31BJZ9v//OhmC8z/RfrlVqif9fQcKv3wVnC6FhShJnvBdyVYMwPoMbuQKgLqEv1Cf+y3NW7Pr52bI8DbEUWv/jEtvE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050023; c=relaxed/simple;
	bh=44mLgS0KPbMic/uDwAJWMxwTITSGBXKzlDUFRNsJ+OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5GWjqfvzKuP2uxAf26NuxzU6eVmo8JLicjk4Qn806om506KmbRjU/vyhoxpkBUPslI/BUxBpqD4L2Vo/DBGonxo2/lPE9n6Ns2PT2SXY4LmHMMXsQIyv62veNoQ1IBr54AruHjJgMCWrrTS+mAySapxgQxTPlIimUZY5VTVNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKEkj0C/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0AFC4CEC5;
	Wed, 11 Sep 2024 10:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726050023;
	bh=44mLgS0KPbMic/uDwAJWMxwTITSGBXKzlDUFRNsJ+OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKEkj0C/r0iPebMEtq2M1DSca8oCj/+s/zhDLxXjyVrFQ7ReFxCvgT/jciHLtEUev
	 vWxd7KmE5tNa8P+2eI+8lDPUH2pK1eAYMseCO9DRvYb+jyX1bZUBqLnW2LJT43FhLB
	 zxfQdbCYG9aVnDvzWk8BnUdK2VTIHl78NsHhP0LhKic+vCOetZ3l0zELUxyw21Gq4Z
	 sQANNgeBABvQaZG70Rs8iP6cEaNrv2r+6v518lp+MQISUfNcViOxIgMfwK5VHl3YiK
	 KbDT4w4h9FCq+VPpYDnvbcybCP6zbeRHAlHmsvtDDNOCFrCme1TEp5xn0zpT/t0uCr
	 z3X5QKmVfo0pA==
Date: Wed, 11 Sep 2024 13:20:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 for-next 1/2] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Message-ID: <20240911102018.GF4026@unreal>
References: <20240905131155.1441478-1-huangjunxian6@hisilicon.com>
 <20240905131155.1441478-2-huangjunxian6@hisilicon.com>
 <ZtxDF7EMY13tYny2@ziepe.ca>
 <d76dd514-aceb-b7cb-705a-298fc905fae3@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d76dd514-aceb-b7cb-705a-298fc905fae3@hisilicon.com>

On Mon, Sep 09, 2024 at 04:41:00PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/9/7 20:12, Jason Gunthorpe wrote:
> > On Thu, Sep 05, 2024 at 09:11:54PM +0800, Junxian Huang wrote:
> > 
> >> @@ -698,11 +700,20 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
> >>  	ucontext = ib_uverbs_get_ucontext_file(file);
> >>  	if (IS_ERR(ucontext)) {
> >>  		ret = PTR_ERR(ucontext);
> >> -		goto out;
> >> +		goto out_srcu;
> >>  	}
> >> +
> >> +	mutex_lock(&file->disassociation_lock);
> >> +	if (file->disassociated) {
> >> +		ret = -EPERM;
> >> +		goto out_mutex;
> >> +	}
> > 
> > What sets disassociated back to false once the driver reset is
> > completed?
> > 
> > I think you should probably drop this and instead add a lock and test
> > inside the driver within its mmap op. While reset is ongoing fail all
> > new mmaps.
> > 
> 
> disassociated won't be set back to false. This is to stop new mmaps on
> this ucontext even after reset is completed, because during hns reset,
> all resources will be destroyed, and the ucontexts will become unavailable.

ucontext is SW object and not HW object, why will it become unavailable?

Thanks

