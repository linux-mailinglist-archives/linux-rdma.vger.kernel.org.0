Return-Path: <linux-rdma+bounces-5812-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB559BEF2C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 14:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024BA1F2415F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A82D1F9ABD;
	Wed,  6 Nov 2024 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYMjKNIV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5A1DE4CA;
	Wed,  6 Nov 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900212; cv=none; b=ZqsxpNgXYEFQ7k//fDvBS2rqcDmB2/UCpTVuCwCcye2eP03zLKI/YjfyNdOHFHNd3liKpuMVUPkCdCGVyKIXmkLVLmWgAilsk3t/9RYji26MK0zmvE+B6wFa/XvGSPKCiU8A0bHmHtGwBFJFH3z43MPaj3gic7p4qjqsyNpQhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900212; c=relaxed/simple;
	bh=LNXfloYp9NxsfFEtf3y74Qg0Z197tnIsIXZDZW9Ablk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hvn1ZDZzy8aVuOP4bRSY58cmvlut28iXiX11JaAJgTiBETjpSUDWN3SNOxq7EB9ZhKMcYaYH6TUsE4uTSm4ZpnvgUIyoS16gYxZ4gVwCBWCjfnfnHk8iVXOODr0sTPqAF9OQuIM1fDqAceMx6ZEekKDuA97BB5H5vhCPUWXWpzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYMjKNIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C65C4CED3;
	Wed,  6 Nov 2024 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730900211;
	bh=LNXfloYp9NxsfFEtf3y74Qg0Z197tnIsIXZDZW9Ablk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYMjKNIVQaq4ELhbqWiYPYj1cytI2t7mj1eVLEmSVCEMeKxOIkH/EnPDdXVzTwhqp
	 cA7LpX4dKR5KGQ8W7D3ATdtFEaw76M2NVSqP+44q/83EvFm2OicmTQI3f7W49LsnT4
	 lXSwdzS+8K1IoA2LM4TAF+DQZAjKu1cSbp7bocBsj9bIJhDjrIG60X7ms/ISMHo1N/
	 oS1M0OzCdhQDwICdmjHzENIsFSZ/2f/GlLwPW9CdEFn53ppvI2FgcZD8ZE8dq+nA5g
	 OGNzZ3OBgdQzjMGG7bO99CuspLIXfwSBbKxUMin8Dsqc5QJQs8dgdENXOIFg76WDyi
	 ATAuV8KJtmnkg==
Date: Wed, 6 Nov 2024 15:36:46 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, tangchengchang@huawei.com
Subject: Re: [PATCH for-next 0/2] Small optimization for ib_map_mr_sg() and
 ib_map_mr_sg_pi()
Message-ID: <20241106133646.GE5006@unreal>
References: <20241105120841.860068-1-huangjunxian6@hisilicon.com>
 <20241106120819.GA5006@unreal>
 <b7dd1cc5-849d-781e-ad08-c5b554900150@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7dd1cc5-849d-781e-ad08-c5b554900150@hisilicon.com>

On Wed, Nov 06, 2024 at 09:12:47PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/11/6 20:08, Leon Romanovsky wrote:
> > On Tue, Nov 05, 2024 at 08:08:39PM +0800, Junxian Huang wrote:
> >> ib_map_mr_sg() and ib_map_mr_sg_pi() allow ULPs to specify NULL as
> >> the sg_offset/data_sg_offset/meta_sg_offset arguments. Drivers who
> >> need to derefernce these arguments have to add NULL pointer checks
> >> to avoid crashing the kernel.
> >>
> >> This can be optimized by adding dummy sg_offset pointer to these
> >> two APIs. When the sg_offset arguments are NULL, pass the pointer
> >> of dummy to drivers. Drivers can always get a valid pointer, so no
> >> need to add NULL pointer checks.
> >>
> >> Junxian Huang (2):
> >>   RDMA/core: Add dummy sg_offset pointer for ib_map_mr_sg() and
> >>     ib_map_mr_sg_pi()
> >>   RDMA: Delete NULL pointer checks for sg_offset in .map_mr_sg ops
> >>
> >>  drivers/infiniband/core/verbs.c         | 12 +++++++++---
> >>  drivers/infiniband/hw/mlx5/mr.c         | 18 ++++++------------
> >>  drivers/infiniband/sw/rdmavt/trace_mr.h |  2 +-
> >>  3 files changed, 16 insertions(+), 16 deletions(-)
> > 
> > So what does this change give us?
> > We have same functionality, same number of lines, same everything ...
> > 
> 
> Actually this is inspired by an hns bug. When ib_map_mr_sg() passes a NULL
> sg_offset pointer to hns_roce_map_mr_sg(), we dereference this pointer
> without a NULL check.
> 
> Of course we can fix it by adding NULL check in hns, but I think this
> patch may be a better solution since the sg_offset is guaranteed to be
> a valid pointer. This could benefit future drivers who also want to
> dereference sg_offset, they won't need to care about NULL checks.

Let's fix hns please. We are moving away from SG in RDMA.

> 
> Junxian
> 
> > Thanks
> > 
> >>
> >> --
> >> 2.33.0
> >>
> >>

