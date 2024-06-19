Return-Path: <linux-rdma+bounces-3297-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6707A90E664
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 10:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7222829C9
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 08:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C477D07E;
	Wed, 19 Jun 2024 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxXoaHrt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567C22139B1
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787457; cv=none; b=BKESWcJDASiG89K4AyT3rs2xv/ukgQzVaQ9cedrrJtKOcTUPEvvYxSbFjMquvDw+GAzLL+8kFxgOMa29FK9y5O9aXpL4Sf/8wfxumt35vrMkRAAgqjd9qTRS5RCHJlbFLwPnlSxr1eOOXfn9if1AqghK0oTE3441BgCXgFbIDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787457; c=relaxed/simple;
	bh=PIG6Kka9k+EKA09IA04D41rfhMH0zRx/yR1QAJNU5bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lukLi56Twh34yebwdUCGOkk/vBrq/OflNhhA8fof0tbqwEsgzACX23zmIKO+EYTYmUf8+iEJ/LDTlzKfi2QYaag6OBlvQiYyhZI6QPMPdg80WbWBtSP0hozd1J/3PqiufRkRwHKZ+LTA7JY893mT3HSva1w13V6KANIkDssCwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxXoaHrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66916C2BBFC;
	Wed, 19 Jun 2024 08:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718787456;
	bh=PIG6Kka9k+EKA09IA04D41rfhMH0zRx/yR1QAJNU5bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxXoaHrtVuzxHNBEJMYL6MsPXfy/WwnbYM8F1W+jZlsTwANNUUYuGFODlntgbZnh5
	 v9SY6fd8UZPjY2S8FAHCFUJaQNQ/hUozrmL9McBOFe4/0elkX3rB+UPucuzwZ4VAF6
	 VB92h4NfDxP/evmqO6LL0Uxh85BEAIaS7fCKgnsqLrkusLM9DaudUp8leUxapeNtiV
	 fdd03X8FowZwpN87cRCtuUw0oBZNNR3Mog3nmj2+9OGBOLuWog7OE6l3mrDYRAGsaJ
	 ihmcsfWhCVVruhA77wnlWsR/keUAGzyLmzB0QgSYJxdfXVj5uyYisncf2MAO+Mqjn4
	 8wYsLQyXN4wmw==
Date: Wed, 19 Jun 2024 11:57:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA: Pass entire uverbs attr bundle to
 create cq function
Message-ID: <20240619085732.GK4025@unreal>
References: <cover.1718554263.git.leon@kernel.org>
 <7d0deae3798c9314ea41f4eb7a211d1b8b05a7fd.1718554263.git.leon@kernel.org>
 <20240617134409.GK19897@nvidia.com>
 <20240617154947.GA4025@unreal>
 <20240617201003.GM19897@nvidia.com>
 <20240618050557.GC4025@unreal>
 <20240618130854.GB2494510@nvidia.com>
 <20240618160559.GH4025@unreal>
 <20240618161345.GD2494510@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618161345.GD2494510@nvidia.com>

On Tue, Jun 18, 2024 at 01:13:45PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2024 at 07:05:59PM +0300, Leon Romanovsky wrote:
> > On Tue, Jun 18, 2024 at 10:08:54AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 18, 2024 at 08:05:57AM +0300, Leon Romanovsky wrote:
> > > > On Mon, Jun 17, 2024 at 05:10:03PM -0300, Jason Gunthorpe wrote:
> > > > > On Mon, Jun 17, 2024 at 06:49:47PM +0300, Leon Romanovsky wrote:
> > > > > > On Mon, Jun 17, 2024 at 10:44:09AM -0300, Jason Gunthorpe wrote:
> > > > > > > On Sun, Jun 16, 2024 at 07:15:57PM +0300, Leon Romanovsky wrote:
> > > > > > > 
> > > > > > > > @@ -63,6 +63,7 @@ enum uverbs_default_objects {
> > > > > > > >  enum {
> > > > > > > >  	UVERBS_ATTR_UHW_IN = UVERBS_UDATA_DRIVER_DATA_FLAG,
> > > > > > > >  	UVERBS_ATTR_UHW_OUT,
> > > > > > > > +	UVERBS_ATTR_UHW_DRIVER_DATA,
> > > > > > > 
> > > > > > > The start of the driver's attributes is not a "UHW", the UHW is only
> > > > > > > the old structs.
> > > > > > 
> > > > > > I asked from Akiva to keep existing naming convention UVERBS_ATTR_UHW_XXX
> > > > > > to emphasize the namespace and the position of this attribute as
> > > > > > relevant for existing UHW calls.
> > > > > 
> > > > > Well, calling it DRIVER_DATA and UHW is very confusing when it is
> > > > > really the start of the indexing for drivers that use UHW.
> > > > > 
> > > > > A better name is needed
> > > > 
> > > > UVERBS_ATTR_UHW_PRIVATE ????
> > > 
> > > I think it need to have the word "start" in it, because it is the
> > > start of numbers, not an actual number itself.
> > 
> > UVERBS_ATTR_UHW_DRIVER_DATA_START ????
> > What do you suggest instead?
> 
> How about:

ok, let's take this variant.

Thanks

> 
> diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
> index dafc7ebe545b8d..e9322f66cd2dec 100644
> --- a/include/uapi/rdma/ib_user_ioctl_cmds.h
> +++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
> @@ -37,9 +37,6 @@
>  #define UVERBS_ID_NS_MASK 0xF000
>  #define UVERBS_ID_NS_SHIFT 12
>  
> -#define UVERBS_UDATA_DRIVER_DATA_NS    1
> -#define UVERBS_UDATA_DRIVER_DATA_FLAG  (1UL << UVERBS_ID_NS_SHIFT)
> -
>  enum uverbs_default_objects {
>         UVERBS_OBJECT_DEVICE, /* No instances of DEVICE are allowed */
>         UVERBS_OBJECT_PD,
> @@ -61,8 +58,10 @@ enum uverbs_default_objects {
>  };
>  
>  enum {
> -       UVERBS_ATTR_UHW_IN = UVERBS_UDATA_DRIVER_DATA_FLAG,
> +       UVERBS_ID_DRIVER_NS = 1U << UVERBS_ID_NS_SHIFT,
> +       UVERBS_ATTR_UHW_IN = UVERBS_ID_DRIVER_NS,
>         UVERBS_ATTR_UHW_OUT,
> +       UVERBS_ID_DRIVER_NS_WITH_UHW,
>  };
>  
>  enum uverbs_methods_device {
> 
> And recommend replacing the open coded UVERBS_ID_DRIVER_NS all over
> the place.
> 
> > > It is also not PRIVATE at all, this is just in the device specific
> > > space number space, not the core space.
> > 
> > Private in the sense of driver specific, like net_priv().
> 
> It is not a private, it is a namespace, that is the naming that was
> used here.
> 
> Jason

